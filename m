Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE37CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 18:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC838838DD;
	Mon, 27 Oct 2025 19:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lD/zQZX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B9B8352B; Mon, 27 Oct 2025 17:01:36 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6F882A9E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hannes.grabmann@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso1155067966b.2
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761580894; x=1762185694; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5e9g/Fp3WakSXKjnwcoX497qZX3EkTLxi8V/ovZBKeY=;
 b=lD/zQZX9JpaOiL5rnSpUT26YA8JCWOmObg4lL0eE0wCsniRglJf0YvS64lINhCKb9v
 nxTa9gw51BCryIyclcJryP+L2BtxRumII0Y3OBOTIGiL7k2rJb2HI7ipjSWD7riCVTEF
 QzcDd4guGBgfVtdZuDxZhBkrIoisV9WJRQyIMerlhsxHNBrH9d7D3ioWgPNcUwkIx7QI
 MRnQdLjLQaJCW4x40X+hMAMfEIjhBUc/NkYQa4OX5aVQLbYiXLW5NKY5zkZePmfR4VzO
 G20yeRhNunJM/2RiNC7f354dZ+u1aig2zpxyxL0jQaSCdAXmBAE1sR8jYEf0iBuHAmLZ
 6Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761580894; x=1762185694;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5e9g/Fp3WakSXKjnwcoX497qZX3EkTLxi8V/ovZBKeY=;
 b=VgF3Zy69x1uKLkrJXv53RlhojoLrtf4ScVnhHwy/NjhQoe7RnKsDYdShC93vwbGIv/
 rPWsQdB56LFywp62PZJcj30qaLEqs95XFl5EqP71OoCmfsTvr2ak2YopA0EHOmUIVQqQ
 FY8lKZ/cNZjp3KiaZFT7dG+xXPu17pHp+fyFjxALm/OgKezDqd2gRF9i7OMn3E5QGcd7
 dIX7r8aSmBYWr2Bqyokm2OsfYnZPvihAvoDTG7RSqaz2TOuJ0TY6QeRqRvJSFlg/rrfb
 jkGxtfY6z39qb6rnOLZGcyBZ2L2HSeB8E+u1yIQzf0ToWncENBnMtAPK7rDV8IwXuRB9
 x7Zw==
X-Gm-Message-State: AOJu0YylFQ7JXI5r9I6TrfAseX5w8cdM+9c+/tZ9I6attdkK7FhEJadU
 7XaAeGyIhCIh5KDvaOU+AloxbNPdOTjxb5AfZHemxw4XxRMcm0uXjrWaOu/yWFkNLyJY8PI32Aq
 CIu67yug3TDGHKEkWrp6WwmwoSJlhDiWFaaLx
X-Gm-Gg: ASbGnctN7CSzQgU6QwOUaSLOPvDye65ecfT4MiUietAbm7zGsiFM4+DHmB7yRxJ0MIN
 20ZUALsSzUfdZQiW9rN/yY9p0VSA8KG5hKoqk/iQrquXtimrhsYpKsice0+cazYp9YN4U0dyksL
 7rhDAWPkbbskpJe3uu23VPdaysJDLMPu1Uq0oS0K5g4cBsXTL+LC7Qo6EIGS3jZDpJAeAKxTyLz
 +7PJdvJ05aco078wVx1QpJP4fJ29K+kfMtFohuDWDmMkPTJ8w28xnlFhmUOTMQdYq7kZUlN
X-Google-Smtp-Source: AGHT+IEFyCIQ5W5hdoO3OCUIMrr6bxejw9rRQZf2CGEZ13oTfF/QbKjMOAqcxUuZJVl8eOYfP37tyIew7JS21IuGlnk=
X-Received: by 2002:a17:906:c101:b0:b3f:9b9c:d499 with SMTP id
 a640c23a62f3a-b6dba59b314mr36268866b.51.1761580893564; Mon, 27 Oct 2025
 09:01:33 -0700 (PDT)
MIME-Version: 1.0
From: Hannes <hannes.grabmann@gmail.com>
Date: Mon, 27 Oct 2025 17:01:22 +0100
X-Gm-Features: AWmQ_bl0KLLflBC2942H5tY9emTdjkyu4swhu9tciHPCoQSHWl8TXR0xnNJ6ymA
Message-ID: <CALFKKaYMzd-t0=CbFHqhZbYekVyHDuer-yEyao5b9VkPZ_S4rA@mail.gmail.com>
Subject: DE10 Nano - Booting from FPGA
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 27 Oct 2025 19:29:35 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,



I am currently working on a small project for the DE10 Nano Board and setup
Pinmux for the Ethernet PHY signals. As I need the preloader to configure
the Pinmux in the HPS, I have tried to set this up based on the current
u-boot-socfpga branch. For this purpose i followed different guides on
rocketboards.org and the "AN 709: HPS SoC Boot Guide" on how to build a
bootloader and configure HPS from FPGA using EPCS64 flash memory. I could
configure SPL_TEXT_BASE=0xC0000000 and "Support booting from SPI Flash" in
menuconfig, build and create .hex file from u-boot-spl to initalize the
on-chip RAM. Problem is that the preloader does not seem to be executed.
Upon further investigation i noticed that the spl data address is not at
0XFFFF0000 as suggested by several older guides:

arm-none-eabi-readelf -S spl/u-boot-spl
There are 19 section headers, starting at offset 0x1482f4:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk
Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0
0  0
  [ 1] .text             PROGBITS        c0000000 001000 00b5d4 00  AX  0
0 64
  [ 2] .rodata           PROGBITS        c000b5d4 00c5d4 00232b 00   A  0
0  4
  [ 3] .data             PROGBITS        c000d900 00e900 000098 00  WA  0
0  4
  [ 4] __u_boot_list     PROGBITS        c000d998 00e998 000840 00  WA  0
0  4
  [ 5] .bss              PROGBITS        c000e1d8 00f1d8 000010 00   W  0
0  4
  [ 6] .ARM.attributes   ARM_ATTRIBUTES  00000000 00f1e8 000029 00      0
0  1
  [ 7] .comment          PROGBITS        00000000 00f211 000026 01  MS  0
0  1
  [ 8] .debug_line       PROGBITS        00000000 00f237 0292fa 00      0
0  1
  [ 9] .debug_info       PROGBITS        00000000 038531 08eab7 00      0
0  1
  [10] .debug_abbrev     PROGBITS        00000000 0c6fe8 0134ca 00      0
0  1
  [11] .debug_aranges    PROGBITS        00000000 0da4b8 002948 00      0
0  8
  [12] .debug_str        PROGBITS        00000000 0dce00 010da7 01  MS  0
0  1
  [13] .debug_loc        PROGBITS        00000000 0edba7 042307 00      0
0  1
  [14] .debug_ranges     PROGBITS        00000000 12feb0 006ca0 00      0
0  8
  [15] .debug_frame      PROGBITS        00000000 136b50 007324 00      0
0  4
  [16] .symtab           SYMTAB          00000000 13de74 006a70 10     17
1244  4
  [17] .strtab           STRTAB          00000000 1448e4 00394d 00      0
0  1
  [18] .shstrtab         STRTAB          00000000 148231 0000c1 00      0
0  1


I also couldn't find that value in the menuconfig, nor could I find any
up-to-date guidelines for booting HPS preloader from FPGA. Can you tell me
if this approach is still viable and how to implement it correctly?

Best regards,

Hannes Grabmann
