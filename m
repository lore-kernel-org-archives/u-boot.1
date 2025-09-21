Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEDCAC5A7
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 08:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E441C830CA;
	Sun, 21 Sep 2025 10:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="b46Duvs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B51830CA; Sun, 21 Sep 2025 10:57:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35ABF82B07
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 10:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1758445061; x=1759049861; i=frank-w@public-files.de;
 bh=9zLQIffeu+BqvxGwKyk1ezjgJhs4kFmJlcKG8GJvCNo=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=b46Duvs43LIEWTpYEzQoC6JDbn8aBRqJ3R8zrGLR6B9gfkJQoZeRz0vsYjMfd0sS
 GDGZzQXfdfO0AnLrk2E/eKtXHBT2QERuofjTu0ZJvYojxpSYkrvO80UkCnzwMr513
 78DcghqRPyGs0AI26rxc6bdr3iEJrU2RH/bTkAoVvm3QWSnIcOxUIGN0R8iCngNnm
 1tCVk59PZNM1a/I3oORyT1Dd5ACsAnEhEYqUhEeDBoBqpnh5r5U96gLx0tH/s70Om
 KgSw8tgllWgYgMtYxvKiR2TrZz3Bb2FuwiCc9p+KcmOYxijr9nmKuR87EyHAF9Co2
 ziTXzn+6knRCaJClYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.144.255] ([217.61.144.255]) by
 trinity-msg-rest-gmx-gmx-live-cb7cf587c-sv4zv (via HTTP); Sun, 21 Sep 2025
 08:57:41 +0000
MIME-Version: 1.0
Message-ID: <trinity-c6602654-0e16-4733-ade7-c41d7ed4cb03-1758445061028@trinity-msg-rest-gmx-gmx-live-cb7cf587c-sv4zv>
From: Frank Wunderlich <frank-w@public-files.de>
To: devel@easynet.dev, u-boot@lists.denx.de
Cc: devel@easynet.dev
Subject: Aw: [PATCH] Fix Linux reboot on MT7988 using EFI and PSCI
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 08:57:41 +0000
In-Reply-To: <20250920154248.789281-1-devel@easynet.dev>
References: <20250920154248.789281-1-devel@easynet.dev>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:axlWKfi4v55mT5SmVziHmz1e5Lsob1ghIuH/y2QfOZIUQPWgh2Zr/H/v/AGDeGXMN7JGR
 4XInSOP4Mv2Ak77KT2TTuatpwGetIQRhCl5WH8ISu6kSMh2LNfaVU8QCGvC0ddG3jTpNhTYnf4hF
 B053Vm9jrIn+FAXvTAQe2Xr3QF71WaeQJCVMltm0cIXi5Z8ES+sQ8SKKVfEvwkkzc+9X1zYNkTnW
 DIsZEiitavoJuyMfylM4HiMHCKRNEi/6MjTLx1Gp2b963lIilerO4tkb0lWN4esGqKaa1SrXNmVA
 PGna7nK8bv4AIFxd0WNk+jLKjrU86qJlAiemeOYhtU+aegO1DR9s/vF+HX/OjtXY2M=
UI-OutboundReport: notjunk:1;M01:P0:4kcZxWKTnxU=;1Cyroy8IFWFVoB/Y6WP68U+f+v+
 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
 dWMw==
Content-Transfer-Encoding: quoted-printable
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

Hi

thanks for your patch.

some notes below.

> Gesendet: Samstag, 20. September 2025 um 17:42
> Von: EasyNetDev <devel@easynet.dev>
> An: u-boot@lists.denx.de
> CC: EasyNetDev <devel@easynet.dev>
> Betreff: [PATCH] Fix Linux reboot on MT7988 using EFI and PSCI
>
> Signed-off-by: EasyNetDev <devel@easynet.dev>

this needs to be below commit description with your real name.

> I'm proposing adding PSCI in DTS for MT7988 SoC which solves the problem
> when U-Boot is compiled with CONFIG_PSCI_RESET=3Dy.
> If this code in DTS is missing and the system is using U-Boot EFI -> GRU=
B EFI -> Linux Kernel,
> then the Linux kernel is not able to reboot the board on systemctl reboo=
t.
>=20
> This simple code fixes this issue.

please write description in a way that you describe the issue itself and h=
ow to fix  without personal points.

e.g.

When booting with U-Boot EFI -> GRUB EFI -> Linux Kernel reboot is not pos=
sible with "systemctl reboot".

Fix this by adding psci node in uboot devicetree.

Patch itself looks good :)

regards Frank
