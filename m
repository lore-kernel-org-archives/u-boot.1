Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53206CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD35984971;
	Fri, 12 Jun 2026 14:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kUEG4zQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628EA839A8; Fri, 12 Jun 2026 10:45:00 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3CA8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E991C1A38E5;
 Fri, 12 Jun 2026 08:44:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BDD3C60012;
 Fri, 12 Jun 2026 08:44:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44A4C106C85EF; 
 Fri, 12 Jun 2026 10:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781253896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=e3ed8Md9XruTBYElPCbJKqX3tD9WZ31JkskIcsmFGas=;
 b=kUEG4zQMQkrZcScTpv4JJYKxo7RrkfKJBjDBXqrQTboYYO4m15Of9SzHJd+XWCZLDCBQf/
 IpsMdYhd4fggRzoCvJJ6ubIjJnMec16k40Yp7VXGr32kwelEDgcfJsW6WPZEK+aIwQV7/r
 9KlydniaaUbJ7kbMANNKZAxMnARDVQ8eadoErpsYeHf/Md7mUdWjA0vXIU8XEKZ3ehaT3z
 YExKyiAtYlSS/61+vUo6Z3QUtgBRK0vD48cJeFqhKB2wJKcR1osiP5iX4jwpT1gat6pnBM
 mcAGAYvs0QPlAFgD7UneRWNRGqU784q9TREbvZqbbKhAMuSgO4DJLnKOP62wPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Kumar, Love" <love.kumar@amd.com>, Bastien Curutchet
 <bastien.curutchet@bootlin.com>
Cc: Michal Simek <michal.simek@amd.com>,  u-boot@lists.denx.de,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Andrea Scian <andrea.scian@dave.eu>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/5] mtd: rawnand: zynq: Fixes and software ECC support
In-Reply-To: <d8771451-d817-4e5e-913a-f5ffb0a28879@amd.com> (Love Kumar's
 message of "Fri, 12 Jun 2026 10:45:06 +0530")
References: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
 <d3ff1c38-1348-4916-821e-bf2825d94960@amd.com>
 <d8771451-d817-4e5e-913a-f5ffb0a28879@amd.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 12 Jun 2026 10:44:54 +0200
Message-ID: <87cxxwgnax.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

Hi Love,

> We are seeing issue with zynq-zc770-xm011 board with NAND write.
>
> Below is the log snippet:
>
> """
> U-Boot 2026.07-rc4-00024-gbc44b6a0aeb0 (Jun 10 2026 - 20:00:05 +0530)
>=20=20
> CPU:   Zynq 7z020
> Silicon: v3.1
> Model: Xilinx ZC770 XM011 board
> DRAM:  ECC disabled 1 GiB
> Core:  20 devices, 15 uclasses, devicetree: board
> Flash: 0 Bytes
> NAND:  128 MiB
> MMC:
> Loading Environment from nowhere... OK
> In:    serial@e0001000
> Out:   serial@e0001000
> Err:   serial@e0001000
> Net:   No ethernet found.
> U-Boot 2026.07-rc4-00024-gbc44b6a0aeb0 (Jun 10 2026 - 20:00:05
> +0530)CPU: Zynq 7z020Silicon: v3.1Model: Xilinx ZC770 XM011 boardDRAM:
> ECC disabled 1 GiBCore: 20 devices, 15 uclasses, devicetree: boardFlash:
> 0 BytesNAND: 128 MiBMMC: Loading Environment from nowhere... OKIn:
> serial@e0001000Out: serial@e0001000Err: serial@e0001000Net: No ethernet
> found.
> Hit any key to stop autoboot: 2
> Hit any key to stop autoboot: 0
> Zynq> nand info
> nand info
>=20=20
> Device 0: nand0, sector size 128 KiB
>   Page size         2048 b
>   OOB size            64 b
>   Erase size      131072 b
>   ecc strength         0 bits
>   ecc step size     2048 b
>   subpagesize       2048 b
>   options       0x00000000
> Device 0: nand0, sector size 128 KiB Page size 2048 b OOB size 64 b
> Erase size 131072 b ecc strength 0 bits ecc step size 2048 b subpagesize
> 2048 b options 0x00000000 bbt options 0x00028000
> Zynq> nand erase.spread 0 0x2000000
> NAND erase.spread: device 0 offset 0x0, size 0x2000000
> Erasing at 0x1fa0000 --  99% complete.
> Erasing at 0x1fe0000 -- 100% complete.
> OK
> Zynq> nand write 0x80000 0 0x2000000
>=20=20
> NAND write: device 0 offset 0x0, size 0x2000000
> NAND write to offset 0 failed -5
> """
>
> Please have a look.

We reproduced it too. I mostly focused on the read part initially but
write support matters too and my colleague Bastien in copy is working on
it.

Thanks,
Miqu=C3=A8l
