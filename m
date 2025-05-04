Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD364C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 17:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA2D82982;
	Sun,  4 May 2025 19:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="juz3AXjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C8B82A0A; Sun,  4 May 2025 17:12:19 +0200 (CEST)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A067829EF
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 17:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746371533; x=1746630733;
 bh=cyXpxlSYWeOaf5o8bb1FmFb/ZEG9Y4LXHDbbBE10acU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=juz3AXjHdXONWwHmNHgqk2cB796mEJY9kKv9HkYplxAtv9M4dAe9rxi5q351vaXwq
 psOOcQrEyqX7u52cgX1H+y9Y8EVni+bJNiSQQz8eVGcpBJGQkjb/WC73AQUy0Iutb3
 IKbkR+KFXt+b8SljmSyjcsIdAJnZ2phyRx/SRsqf82XGkBnrOlY69xmJSApWUDId/z
 wogW3fzg2We+YGGvKV5DO0wNg6WiB0KOFsLTgPCyJVYUvKGHrhL8yG0al+ZF8f9sVW
 aTikE4Uo1+GLEBtP1hTAkjPpakX37xAfJs3Auty4QMZ555CUeEkGWVTN5+b36rH1vb
 8LXM0fNFfduPQ==
Date: Sun, 04 May 2025 15:12:07 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Subject: ARM - Linking issue with binutils 2.44 (dangerous relocation:
 unsupported relocation)
Message-ID: <640da044-55d0-4491-afea-3e9d9dc0179e@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: a20935019ca5e91e84b8591fbd33ce498f37a485
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 04 May 2025 19:36:57 +0200
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

Hello U-Boot list members!

There exist an issue with the newly GNU binutils version 2.44 when
trying to build U-Boot at link time.

Error output:
$ make stm32h743-eval_defconfig
$ make
[...]
   LD      u-boot
arm-none-eabi-ld.bfd: warning: -z norelro ignored
arm-none-eabi-ld.bfd: arch/arm/cpu/armv7m/start.o(c_runtime_cpu_setup):=20
Unknown destination type (ARM/Thumb) in arch/arm/lib/crt0.o
arch/arm/lib/crt0.o: in function `_main':
/home/jk/Projects/U-Boot/src/arch/arm/lib/crt0.S:170:(.text+0x44):=20
dangerous relocation: unsupported relocation
make[1]: *** [/home/jk/Projects/U-Boot/src/Makefile:1824: u-boot] Error 1
make[1]: Leaving directory '/home/jk/Projects/U-Boot/build'
make: *** [Makefile:177: sub-make] Error 2
$

I have tried to fixed it with success. Simply added the assembler
directive ".type c_runtime_cpu_setup, %function" after
".globl c_runtime_cpu_setup". under the path:

arch/arm/cpu/armv7m/start.S

The binutils patch with cause this building error is explained
at least in the following commit in the binutils git repo:
31ed3a9d691493486f6e32357d89a55229dbdc0a

Extract from the log:

"This patch emits an error instead, and warns in some other
cases, to encourage users to add the missing  '.type foo,%function'=20
directive."

But I don't know if this only exist on ARMv7-M.

Kind regards,

Johannes

