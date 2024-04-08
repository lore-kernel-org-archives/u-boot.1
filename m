Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9022FC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9625988124;
	Mon,  8 Apr 2024 20:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=extrowerk.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=permerror (0-bit key) header.d=extrowerk.com header.i=@extrowerk.com header.b="PCMejmvJ";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9zClKZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7711387F8D; Mon,  8 Apr 2024 09:40:56 +0200 (CEST)
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com
 [103.168.172.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0C487BE0
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 09:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=extrowerk.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zmizsei@extrowerk.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailflow.nyi.internal (Postfix) with ESMTP id 5FB4120035C
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 03:40:52 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
 by compute2.internal (MEProxy); Mon, 08 Apr 2024 03:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=extrowerk.com;
 h=cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1712562052; x=1712569252; bh=nVhU9dYkxl2U5a4zl7lYhBKpRTYDVCjT
 lhnQDPgTnp4=; b=PCMejmvJ9qGg1G05FZNyxq+HopBH0Srl0U+VxADbxW+9HBxz
 h9bu5iO3vAxT/m0MOFZ8X6vYEChVfiuN9atJGdpIg00AxJRKJ61VXqAb3weT10Uw
 Odk9VupUzpisyk/4fFxPt9PSw/dBKXixab4+JS8DjD9vJ26HFyOxE2JHJfp3RY6V
 Zbo7VYlx9rF1oeMTO16RonM4k9ZSFwP328wUHBVwXXeCGbp9E6ntg5qVOPweTu3L
 3MTWtLeCnZDpNxIRMVBy30G7iHXzSQZouLeTSmpopl7qFdy0o2st55ZTSM5CL/Nm
 AaGm/6EgXyRLhd2hdQjK6SYRF6Y5HWa7/ew+jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1712562052; x=1712569252; bh=nVhU9dYkxl2U5a4zl7lYhBKpRTYDVCjTlhn
 QDPgTnp4=; b=h9zClKZUkN7sVKTLMjqoiV/zN7NBCJP8BulmSD2eM10/eVJhqFB
 sZ8tUeBDeSy+Xntg3apxVj0+Jbbc11VVub9fJrkD9FR/nzYe+CaPlFZgiBK0Ov2h
 ShVb2ueUlWYdwHAw0pbGISphK3gXSszN8RA8xH9c6+IegDTBHEpv3hrFa+DvbYu9
 GXe5u0Mg2J0UKLz20BoOZ9Gt2XdFBnO1TFKsZVALDLJgFlp1i+94z/vefBP1GueF
 LlhhaWA27lMjOKVWNvl/AnQ23kd9xhqUmpmNUTskwRIgN0T6usc3hLLtNy8JdpHy
 km6IFleMeteEypoEKaBhJj+49YIc+jTV3Lg==
X-ME-Sender: <xms:hJ8TZnSNq1LdXv6Pg5XA_N-ufuLa0k3nxkS3s8SPwB60nlT11r9utw>
 <xme:hJ8TZoyOB5vL1ZjUtzv-0zW0ApekxMDCwSqkij151ryiVuZsntTJlqhVGG2CT7W-d
 V1i6k0yrDuxrhkeeuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
 dtreerjeenucfhrhhomhepofhiiihsvghiucgkohhlthojnhcuoeiimhhiiihsvghisegv
 gihtrhhofigvrhhkrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeegfffgfffhieevhe
 ejgffgveeufeejiedvffdvudegudeiudelteejudffkeenucffohhmrghinhepghhithhh
 uhgsrdgtohhmpdhgvghnihgrthgvtghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepiihmihiishgvihesvgigthhrohifvghrkhdr
 tghomh
X-ME-Proxy: <xmx:hJ8TZs3RuZQWORSKg-RHFn-HlHirbCUbBIbjny6PmylH1kqgz81qlA>
 <xmx:hJ8TZnDue7lYWOayOY_wSM0XDV7D7xF-cOfF6DDkmrZob2EMXQF2HQ>
 <xmx:hJ8TZgjqgH3Qo8wwpgp1OA7ZL0DAzAComiGchgiyKAKhvD-JhXP0tg>
 <xmx:hJ8TZrpxbXJW3JfOtWzpID3BQFZZMpdhpaJCDfRjZYtbamDWCRLNfA>
 <xmx:hJ8TZueGgqtvQk8r0OqRB4RJe9mzqaKnl9VgDRjRExRzHL2volff8pML>
Feedback-ID: i46594767:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 12E5D2D4007D; Mon,  8 Apr 2024 03:40:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
MIME-Version: 1.0
Message-Id: <cf475658-6c25-474b-934b-15da1363a39f@app.fastmail.com>
Date: Mon, 08 Apr 2024 09:40:31 +0200
From: =?UTF-8?Q?Mizsei_Zolt=C3=A1n?= <zmizsei@extrowerk.com>
To: u-boot@lists.denx.de
Subject: Can't get U-Boot working on Geniatech XPI-3566-ZERO
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 08 Apr 2024 20:35:45 +0200
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

I'm trying to get a mainline U-Boot running on the Geniatech XPI-3566-ZERO RK3566 based SBC [1], but all my attempts have failed so far.

The SBC doesn't have any SD-Card slot, please keep this in mind!

I can build U-Boot, but when I write the resulting binary to the eMMC using rkdeveloptool, the boot stops and I see no output on the UART pins using 1500000 baud transfer rate.

My steps were the following:

- git clone https://github.com/u-boot/u-boot
- cd u-boot
- CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make rk3568_defconfig
- ROCKCHIP_TPL='rkbin/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin'  BL31='rkbin/bin/rk35/rk3568_bl31_v1.44.elf' CROSS_COMPILE=aarch64-linux-gnu- make
- rkdeveloptool db MiniLoaderAll.bin
- rkdeveloptool wl 64 u-boot-rockchip.bin

After that I can no longer communicate with the board via UART and it no longer boots.

I've built uboot countless times, I've followed all sorts of guides, I've tried modifying FDT and transplanting the DTS from the official SDK, I have tried vanilla defconfigs and tried to modify them aswell, I think I've tried everything, but no matter what I do I just can't get it working.
The vendored U-Boot works ok, but I plant to run OpenBSD, for which an upstream U-Boot would be better situated (according to the OBSD mailing list).

Please give me some hints because I'm running out of ideas. I've spent countless hours trying to get this to work but haven't succeeded.

Thank You very much!

Best Regards,

--Z--

[1] https://www.geniatech.com/product/xpi-3566-zero/
