Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49AAFC617E
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 10:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AADF83B49;
	Sat,  3 Jan 2026 11:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="cVn2COxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A017483B4E; Sat,  3 Jan 2026 11:55:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E60E83B48
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 11:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1767437709; x=1768042509; i=frank-w@public-files.de;
 bh=q3aDVAyV+vLa4RBiZTeput2gN+r4deYjVejJItsk3eQ=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=cVn2COxCvuMmRTu5zf8PpmJ8nZUbBZRGaW55syROJ/9KMAl7i/jIwliM54Fkk+mj
 EPNrsYXqjFzbqOsuq1E4LDOfIQeCJGg2ko7UQJ3eIQ0ct5Rs9u4TOQr4BkbxXurcf
 Xy5+JTVEMaUiRa+iJdZoJZ+WjJmtcM6JBy2I31MBpYiSxhxvSoR1Qvsaz3DrxmUnl
 X6MpCfJ5YPjF4xFpbf5vrX2EJdgGAaSBBDYRNOMPpkyvSwEiJCVvnRsCs1ZhF1MOs
 d3/npaXEKLtkKVF4deviFZfD3AsMawyR29R2jbHZ7KhskIUyvkCfdZOjZ7Ihs25ds
 BVzWWvp0IYj2v7NcVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.77.161] ([80.245.77.161]) by
 trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb (via HTTP); Sat, 3 Jan 2026
 10:55:09 +0000
MIME-Version: 1.0
Message-ID: <trinity-3f748198-84ca-4da1-a48d-3f6e1c1818af-1767437709081@trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb>
From: Frank Wunderlich <frank-w@public-files.de>
To: u-boot@lists.denx.de
Subject: u-boot.dtsi also possible for dtso?
Content-Type: text/plain; charset=UTF-8
Date: Sat, 3 Jan 2026 10:55:09 +0000
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:QngpjkKlwemrTB19Yg+hi74GSBKTynrrR0OpWgl88XnWS9sAX4XudTyQq1yKDv5X3PoXS
 HqRtfjl9u5BVO2NcJW6Eoco5xiYDha9YX5GOG4U7UbqgcgthUyaM/fxJRL/uDGPBuvh69So7OU8K
 sAecuDIO1uyGOJ4hogTgZwWY/YJvElHOWaSidtWT5YmiYnrrycXTRrxC56nCs2Nt2qC1jN9/b40B
 gVvCUJhXpgGf7uHRAeCfJaGjfDRG5N9R/LdwX9/7ZduEg+wytpAhPa0DdDg2hw01LIzVPyIxkXyb
 B1+Nd9Tnlf1BSeX+e4On4/ZukvP4mt5Mzc1v6XuYs+NbBg1mKVCyE791h4ilVX8AMA=
UI-OutboundReport: notjunk:1;M01:P0:vJv+6A4CCq8=;v13jJZQ9WYWBKsw5dmTV4G6AYCp
 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
 G6qKuNYzbfX6uRXN3C5D65HoHdk/
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

i make new attempt to change mediatek boards to OF_UPSTREAM because i found out, that dtbo merging is now possible.

but i faced a problem:

e.g. BPI-R3 has 2 SPI-devices (nand,nor) on same spi switchable via hw. i need both in dts to probe the right
device for linux and to allow install from sdmmc to both of these devices based on hw switch.

currently in uboot the nor is device 0 (unit-address and reg) and nand is 1. this does not work in linux, so i need a
way to overwrite the dtso from linux with the new values in uboot.

for dts there is a way using -u-boot.dtsi files...do they also work for dtso? where do they need to be placed?

regards Frank
