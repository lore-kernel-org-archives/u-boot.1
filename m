Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D050DE674B2
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 13:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F148E83B99;
	Mon, 22 Dec 2025 14:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aEEmhba8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CABB83DEB; Mon, 22 Dec 2025 13:32:55 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9E083B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 13:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alperyasinak1@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so3619301b3a.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766406771; x=1767011571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5DKiIWy34uvkajwuQVyxKAwcPxmxD2R3EQ+DVuKXp4U=;
 b=aEEmhba8DMamNuA15+yBQma9BT8ughLxVpMgDEQDYPQekvf3VeO9SAZBmeo4YV6FdB
 daB8j5/b/BrBSsJDjosviWX3uev61slPZKYD8eZ5mX6HV2iFvRp2iizZLyeeusDZm8tr
 VQ3xTpqLhpc1eeZHzGboHizd2jlnmNuVjc1ck/ERwXeyBWDqmTNBG5mDbc2nExh8bJEe
 B6gjdABuVMSUW7YhO5LXvbcqCq4baEe6bM0//LZoCdPiMEfzx4nP1FccTXL+Z82MyRV0
 GCijCB7fgfgSeO8XSxTZFcH1BHEL6Q5g/7hQmxd3/lsd+t2rlpZmsqvXP/IvZ8gVPcQt
 S+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766406771; x=1767011571;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5DKiIWy34uvkajwuQVyxKAwcPxmxD2R3EQ+DVuKXp4U=;
 b=oayN3yPi9GYzazOFbUGcD5jYVPh5F1fh9+tMc80hBH7NPmLbaYeovcIynhn0FeL1xx
 cyONklmpfjn+wY6AiAGVz1aW7VbzChSmBYznWPajusivTFbI/OxWlVB6uDo7kNh8UwGW
 h33YJklfjist0+trmEAUd4ABBZqftFbr9dZaw3uiQG5DSO5MNo4ybxNIvokvi9qVYp4m
 9j6yY/3wfECXwKbIhfzrUPrY2Ar2t69hZg9Xv++bKnECC64rHoKc37JOwSDd70RgGa1o
 B14ibJVfytF2/JCiiQDTG1H2so9QNkCoQmp+69AqqXOUZug5geCg79FFSdm0NA3rNN0A
 ksig==
X-Gm-Message-State: AOJu0YxcMfIyADSlSVO6zzznrxJhsRGaxDU/n3cYeEAVaahPOTQXUzvd
 C3oXvwXAdv1UOgwsb45n8hb7XJiZyNPqwxP4CLYcmNbiKuS936aigo85VDQ6uyPtznTbo/SLSQb
 EU4DhthM/riJl2WzDV6m5E9CisjVBQMq1WrEO
X-Gm-Gg: AY/fxX5XnexUSWuAyyDnc3AidHUIECepoah+JJxh5XPLxX+PHws5V6YNsUpwOUEpimY
 2YG002dR0ZSDSrt4AAXNxm6l7J5TFLSFLA4L2N2Pb3VzxZbd3fM7cbZVgMzaIm0X0+GM56fY8mh
 5og1DXNpmvNhIGnzAzvbGcdBFXvxynPIGKa7sFweZ7XfwujL0wY2XRlCq2vYHeb1wB7HPi5Mdnd
 yIeojWjzoGC7YR/6M8cH2zfoimaDmZ25hDpJyxvskIN+iDY0QOGGd74KuEkhhVB+UlWpA==
X-Google-Smtp-Source: AGHT+IFu0p8m5hmJSRQJfFtqtJeG2FWyT1QSEyqmo3oHbz2489U2pbFUKjsT6cLldRngHPY2dBCEXBSakmOXcR70CP8=
X-Received: by 2002:a05:7022:6294:b0:119:e569:f26d with SMTP id
 a92af1059eb24-121722b509emr12929632c88.22.1766406771322; Mon, 22 Dec 2025
 04:32:51 -0800 (PST)
MIME-Version: 1.0
From: Alper Ak <alperyasinak1@gmail.com>
Date: Mon, 22 Dec 2025 15:32:40 +0300
X-Gm-Features: AQt7F2qV32sZ_8v4_Cah3fp2nmIAGpuAvOrN5ktNTobEVdrpNCQWwQbvJxTnQbg
Message-ID: <CAGpma=6KqYJ_TB+qNZJjc0anTb5WmRW6ikjG-SjbVfBsOk5pZA@mail.gmail.com>
Subject: [QUESTION] SpacemiT K1: Incorrect RAM detection with unpopulated CS1
To: u-boot@lists.denx.de
Cc: me@per1cycle.org, ycliang@andestech.com, michael.opdenacker@rootcommit.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 22 Dec 2025 14:54:57 +0100
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

Hi,

I'm working on Orange Pi RV2 board which uses the SpacemiT K1 SoC. I'm
currently using the bananapi-f3_defconfig as a base since there is no
mainline support for Orange Pi RV2 yet.

The Problem is U-Boot reports 4GB RAM on my 2GB board. I think the CS1
register shows enabled with valid density even when no physical RAM is
populated. This causes U-Boot to report double the actual RAM. Also,
If I don't set "mem=2G" in the kernel command line, it causes a kernel
panic.

I'm sharing U-Boot, bdinfo and DDR register dump output:

U-Boot 2026.01-rc4 (Dec 10 2025 - 15:28:43 +0000)

DRAM:  4 GiB
Core:  21 devices, 9 uclasses, devicetree: separate
Loading Environment from nowhere... OK
In:    serial@d4017000
Out:   serial@d4017000
Err:   serial@d4017000
Net:   No ethernet found.
Hit any key to stop autoboot: 0

=> bdinfo
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000000000000
-> size     = 0x0000000080000000
DRAM bank   = 0x0000000000000001
-> start    = 0x0000000100000000
-> size     = 0x0000000080000000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 115200 bps
relocaddr   = 0x000000007ff81000
reloc off   = 0x000000007fd81000
Build       = 64-bit
current eth = unknown
eth-1addr   = (not set)
IP addr     = <NULL>
fdt_blob    = 0x000000007ef5ed20
lmb_dump_all:
 memory.count = 0x2
 memory[0] [0x0-0x7fffffff], 0x80000000 bytes, flags: none
 memory[1] [0x100000000-0x17fffffff], 0x80000000 bytes, flags: none
 reserved.count = 0x4
 reserved[0] [0x0-0x7ffff], 0x80000 bytes, flags: no-map
 reserved[1] [0x7df5b000-0x7df5dfff], 0x3000 bytes, flags: no-notify,
no-overwrite
 reserved[2] [0x7df5ed10-0x7fffffff], 0x20a12f0 bytes, flags: no-overwrite
 reserved[3] [0x100000000-0x17fffffff], 0x80000000 bytes, flags: no-overwrite
devicetree  = separate
serial addr = 0x00000000d4017000
 width      = 0x0000000000000004
 shift      = 0x0000000000000002
 offset     = 0x0000000000000000
 clock      = 0x0000000000e2b328
boot hart   = 0x0000000000000000
firmware fdt= 0x0000000000279b18

=> md.l 0xC0000200 1
c0000200: 000f0001                             ....
=> md.l 0xC0000208 1
c0000208: 800f0001                             ....


I think this seems to be board independent and appears to originate
from the code at "arch/riscv/cpu/k1/dram.c".

I'm curious to hear your thoughts on the matter. I'm not very
experienced with U-Boot, so I would appreciate any guidance.

Thanks in advance.
