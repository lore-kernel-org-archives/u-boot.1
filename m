Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64F7CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80D5C607F6;
	Tue, 29 Sep 2026 20:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3TPvwJDJd8B; Tue, 29 Sep 2026 20:32:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5AFB6607E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713970;
	b=Qgjv8PCN4hlaxbSWuj62dcM2Jz0bnXiSUdvuIFOG0Kr+p9Sla3WihDBamhXdFAcZnfkU
	 l8UrQn3+RBSxlit/XMwL6xROe5hZnvPU1ohh1n8TOGMKzWVN+hsgUFPytmytBx9CblkVW
	 O3Qs6NDL0qnsBWFpcXNv5cg4PQHPrvSvt9BsbXJRjYbhrbKal1l7qford+k/Ex1hntEEe
	 i1Ng0tT1Ju/oizb4lUkt2/Z7Ug9SQaN60MzS0uHR8PoupHlUgHTL38oXRrNBHQZVNUYkY
	 fTbypjZm+X9pnWbzZBMnbzx2pe+sOyjWbE22cRUyidCuYPzp5GPZJEmkohqhmK8BVOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
	b=elhP2k0yxhXaiqCCpR88Ekrj0ms2AFV7C5+i+tr+qObEWuH56xcCY2xWIuM36aciUkO2
	 TxuCgAWmtr3HjcBICz3E6LqGH3KCPRMDD5SqEOYtn9pyM7vahXBlbfZ6JAANP1sOelb5t
	 Zw94Zmz2a+yIfhzU8alph0PKVIredjepd5bP1dwyd2Jg8GaEZ8W5z37FJGopBzQuIJMy1
	 RfAInX1CIGWBtMrCG6MtLpXpF7DiK/0wnIFxKo0geWEUuYhVsSb+pSAosdL8kzDfe9N7N
	 RkdtGkTW8XUodI4/bL21eMN7NaHygw2ryVsuIoMSqVNiS/icxBRz5LT9JMuNKA21dxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713970;
	bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jxMNYUGXTR4f7REMxr0lppQjEaqzQS2mv472UawqyYiUzU8+05I7E6Q2Eqe1sL+3r
	 usM6vxAopApK3K1atG0DitDK1hTJcd89Vzm0EZXXMs7ByZ80QLKDZUfH+sICvouXQg
	 X+inBFfX5Ox1Uj9fMAEAm8lFV77Wd2Mfi59wjsCncFqCa4ZDszkQqu+DrDfXHIOya5
	 5wbKMkzzC1ZXelmFKis3TFtIZkwjY1qCII3/MlO5ZFXm+18Z3iKBULJnq4XIvRsOub
	 dFfjvfg/8Ueb9DIibtaVDeeEzBmpONRezYerDygLELBkoTHgsQZpF/fK3vn1Vb75C7
	 nogbdykirTEAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AFB6607E5;
	Tue, 29 Sep 2026 20:32:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B671314C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C2AC400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkD_AVrvPZn2 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 58AD6400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705245;
 b=NrVFAHDGGM0nM/Sky94IIRPvEyKsA4QXJ/ZWiy1xV+bPJOVwM8CHRyHaCLb5kTeJohDl
 iVjdepJztSv3hpeglHk5S4wsmDlPktEx7S3r13jCcB5lVoX1JGZxD5bvkcnBP1owS3+FB
 P8UETFtj7pheoY/limZm8n6HCAqMAPLkpmsJ/+Dg9vD45BXpY2DESIwi+BUmjzrr9vrld
 x3sHuVns18FS/kg0rJ9Bq/eIo/+os1ByzR3z7vg2wMd0QAIEXKq8JBlmrNR0/UPBUB6e0
 GPG49sZAQQ+JVeXj58c0VVTgMR6OeUuclMtYJWWUn1Lfdzfh/etW/8NzFMf5F+E7V+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705245;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
 b=MWov25mSpAOeoe/usKHHKjdQHgc+dxkdFmqkIEJZHNgwsG5f29+Q5Ej5JAd1+WnXNHPM
 SyFsNVE/lT2rtjHgGsmAnjXTUupK4MYrMT/Vt6OpXaaVyDUXdak+i6QgB6GoGHQDqlk7w
 CKj6K8GcUJ1u12qv7RSxil6WobH/PcdhAcZ2EilGv5535ZyQJ7piLurwqIPQd5ZTzMFN3
 FmLsFhrs6bg8A3HR7eZiDfevXqIcJqdKBCTOAmWYEO6eda9NwhqVFLxeZMBlQpGaxU9sC
 VucvCY7ggCNCfpJnYxqluy0dnUebP9sQ7Sw3LKfnahpC8LW1+NWsGfOo2N7ojc6KK1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=VDonxCVj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::2a; helo=mail-qk2-x2a.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=VDonxCVj
Received: from mail-qk2-x2a.google.com (mail-qk2-x2a.google.com
 [IPv6:2607:f8b0:4864:34::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58AD6400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:24 +0000 (UTC)
Received: by mail-qk2-x2a.google.com with SMTP id
 af79cd13be357-93c7519e76bso178601985a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705244; x=1791310044;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
 b=VDonxCVjCYdz4Z2mbM3IcXSGR6OBLSEbutw0IfA9urhc12Fju7NlOUlv8lZbHMR9cx
 0wVQKLgXT6ghVfxp8Ig6+nmSL6aqk3fMWAu4g8n+2BbiQ9doy6uRyOdA4gLBwJL47pIA
 RDbbScuoh/iY/gOtGkhToPgzt5fx27jxaJC3sm4XEaa05PqV8G5VAiDWApP7msycWmxo
 Py/lFeUXal2Eb8+cltYamDrOEnhn5/TOnOpNM8rlYOrqHSKJtgTspGIjAZ5G+/N4fmyE
 p34fqIyYUuSMVC0izhbUz+oB1NCtVcftb6JhOQ0xpuJFgjhw0gYwKVkkZQraUoMpG//v
 R6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705244; x=1791310044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
 b=QCnMrH0998qN2H5sH6pRA8hDGIaHALujOsz5ErML4nmKmkWVFQPLx18mrd5PwSFzxt
 97P6qEhtXDNT7zA3fZ7UmZvzfyCNHQ1kkCH6Ir43XN1Xbae8U5IcS23+ZVDDYaQOgmeH
 k5Crluhy5fwyDJOaDfpa9RjBCrZctpD/HZWwUDKl6LDKrn3cO5fhEHTm0/rTZ9im+Xwc
 8L6Cz+MZphrV/NoKp6van5+IPhIngWDws7djJ71uE9LdqMu6U6lEFFp871SVVU4ahzsR
 2PW0lVZ/U37J231nQIUFioPHOJWtKdDWpDta2NTaD8tEOqOE4yKMGcFw92Zv0ctIoRWk
 W3Jw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQprjrQY/i6ucLR/YohqG5izGN5xhp0EEndaxZhJO6Yp20OVkb1wAuYGu4/z0v52scD9mzomU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kfai5DrW/lcc5IYV0AGijCEVMHyt++TfEgZRc3CquyNhjd1VGB
 GiuwvTdB372ROip+awvypBFvCrERRzy13lf1OL5k9BR6FhECF3KYRu5a1fJKXXKzKyg2YyUNodl
 UDKmMeOxqZGMxg8b2wNbPZMmQnN1ABhw7V3AnnxFbP/lQmCN7uxDlZIv36hq0XSg=
X-Gm-Gg: AYBFou1Ok41s6pzqLawSD/QHw1OJoW6R+gOCzcEaWBENFn/E9wnTV6p8IxYtRZtoI+a
 hEquD4+9EI9JbzOikrsX0xxhD9UtCQVQn1/DwNhOCVwBLrX4fyTfXS0LCFnlfq2inwDHYLQGvkw
 wZO+ErQLFOpGUPLETioW8BBULJYG/ReGfq/fnD2r9qxSJhDOaJT6Ir38T1m0/lGJzkIKi9G4tvv
 fZ174lyfwLJFr1fBMg6E9r+KBCRjpe2yZ+uh9K7OSbPg4DjENZ2aKB/EWfzRFgAwYeD8PnOYO00
 MpESr9/zx+brch5C7FWVQF3X+/AuxRY8LFxM701GCKf7PF/URDhzWaCqVmvwqkEPQxb7hbBw27Y
 AOj5bpQIBCn9C/KhkVfBpJ9Rpbon4e7W+I10+ZMOslXXz0EYHMeL67LlOvv5XH15c9eGepct7+Q
 jQSuayuRKZsA8iU7qAdNB5bBGFI6ER5A38TGgQ/oRysfEieT9v2USqkKVOcApQ9ibe5g==
X-Received: by 2002:a05:620a:370d:b0:93c:17db:d91f with SMTP id
 af79cd13be357-93c9fb59e46mr57265385a.39.1790705243208; 
 Tue, 29 Sep 2026 11:07:23 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:22 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Nick Xie <nick@khadas.com>
Subject: [PATCH v2 0/9] arm64: meson: Add s4 support
Date: Tue, 29 Sep 2026 14:06:22 -0400
Message-ID: <20260929180721.3440839-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series (along with several patches submitted separately) adds basic
support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
patches on it is at [1].

I developed this for a custom board, but I believe a better candidate
for a defconfig is the publically-available Khadas VIM1S [2]. Khadas
has kindly sent me a VIM1S so I was able to add some more features and
fix a few bugs.

Creating a bootable image currently requires modifying AMLogic's
FIP [3]. Unfortunately, that software has a proprietary license and I
have already reviewed it in order to make the necessary modifications.
Therefore, I am wary about submitting patches to [4] (or binman). If
anyone would like to do so, I can try writing up a specification for you
to implement so we can avoid any copyright issues.

Linux boots but can't read either the eMMC or SD card (mmc0/mmc1):

[    1.537445] Run /init as init process
[    1.573054] mmc1: new SDHC card at address 0001
[    1.573722] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    1.578302]  mmcblk1: p1 p2
[    1.594234] mmc0: new HS200 MMC card at address 0001
[    1.595881] mmcblk0: mmc0:0001 AJTD4R 14.6 GiB
[    1.598333] mmcblk0boot0: mmc0:0001 AJTD4R 4.00 MiB
[    1.600596] mmcblk0boot1: mmc0:0001 AJTD4R 4.00 MiB
[    1.602689] mmcblk0rpmb: mmc0:0001 AJTD4R 4.00 MiB, chardev (239:0)
Starting systemd-udevd version 255.21^
[    1.681013] mmc2: new UHS-I speed SDR104 SDIO card at address 0001
[    1.758610] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    1.884396] mmc1: card 0001 removed
[    1.902656] hub 1-1:1.0: USB hub found
[    1.902829] hub 1-1:1.0: 4 ports detected
Waiting for /dev/mmcblk0p2 to show up...
[    2.083595] mmc1: new SDHC card at address 0001
[    2.084253] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    2.086749]  mmcblk1: p1 p2
[    3.102764] mmc1: card 0001 removed
[    3.247600] mmc1: new SDHC card at address 0001
[    3.248274] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    3.250416]  mmcblk1: p1 p2
[    4.254738] mmc1: card 0001 removed
[    4.399589] mmc1: new SDHC card at address 0001
[    4.400230] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    4.402721]  mmcblk1: p1 p2
[    5.406737] mmc1: card 0001 removed
[    6.604775] mmc1: new SDHC card at address 0001
[    6.605518] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    6.607752]  mmcblk1: p1 p2
[    6.774076] mmc1: tried to HW reset card, got error -95
[    6.774133] mmcblk1: recovery failed!
[    6.774594] I/O error, dev mmcblk1, sector 61066752 op 0x0:(READ) flags 0x80700 phys_seg 5 prio class 2
[    6.780963] I/O error, dev mmcblk1, sector 61067016 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 2
[    6.781018] mmc1: card 0001 removed
[    6.927580] mmc1: new SDHC card at address 0001
[    6.928252] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    6.930422]  mmcblk1: p1 p2
[    7.934738] mmc1: card 0001 removed
[    8.003206] meson-gx-mmc fe08a000.mmc: card claims to support voltages below defined range
[    8.003576] meson-gx-mmc fe08a000.mmc: no support for card's volts
[    8.004334] mmc1: error -22 whilst initialising SDIO card
[    8.032146] mmc1: error -95 whilst initialising SD card
[    9.163594] mmc1: new SDHC card at address 0001
[    9.164282] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    9.166825]  mmcblk1: p1 p2
[    9.334084] mmc1: tried to HW reset card, got error -95
[    9.334140] mmcblk1: recovery failed!
[    9.334605] I/O error, dev mmcblk1, sector 61067016 op 0x0:(READ) flags 0x80700 phys_seg 14 prio class 2
[    9.340984] I/O error, dev mmcblk1, sector 61067208 op 0x0:(READ) flags 0x80700 phys_seg 5 prio class 2
[    9.341040] mmc1: card 0001 removed
[    9.491572] mmc1: new SDHC card at address 0001
[    9.492239] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    9.494407]  mmcblk1: p1 p2
[   10.526746] mmc1: card 0001 removed

Not sure what's going on. Maybe the drive strength needs to be adjusted?

[1] https://github.com/brivolabs/u-boot/tree/meson_s4
[2] https://www.khadas.com/vim1s
[3] https://github.com/khadas/u-boot-fip-yocto
[4] https://github.com/LibreELEC/amlogic-boot-fip

Changes in v2:
- Add S4 to meson board info
- Add DEBUG_UART defaults
- Extend initial padding to 4096 to match what Amlogic does
- Add ADC clocks
- Use our own board instead of reusing q200
- Enable more peripherals (buttons, LEDs, etc.)
- Use defaults where possible (commands, distro boot, etc.)
- Set mac address the same way Khadas does
- Set config/stdout-path so we can find the serial

Sean Anderson (9):
  arm64: meson: Add s4 SoC support
  clk: meson: a1: Eliminate separate id parameter
  clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
  clk: meson: Use soc-specific naming for common functions
  clk: meson: Export a1 functions to common file
  clk: meson: Support fractional fixed-factor clocks
  clk: meson: Support power-of-two dividers
  clk: meson: Add s4 clock driver
  meson: Add Khadas VIM1S support

 .../meson-s4-s905y4-khadas-vim1s-u-boot.dtsi  |   5 +
 arch/arm/include/asm/arch-meson/boot0.h       |  12 +
 arch/arm/mach-meson/Kconfig                   |   7 +
 arch/arm/mach-meson/Makefile                  |   1 +
 arch/arm/mach-meson/board-info.c              |   2 +
 arch/arm/mach-meson/board-s4.c                |  50 ++
 board/amlogic/vim1s/MAINTAINERS               |   7 +
 board/amlogic/vim1s/Makefile                  |   1 +
 board/amlogic/vim1s/vim1s.c                   |  26 +
 configs/khadas-vim1s_defconfig                |  66 ++
 drivers/clk/meson/Kconfig                     |   8 +
 drivers/clk/meson/Makefile                    |   2 +
 drivers/clk/meson/a1.c                        | 495 +--------------
 drivers/clk/meson/axg-ao.c                    |  12 +-
 drivers/clk/meson/axg.c                       |  16 +-
 drivers/clk/meson/clk_meson.c                 | 376 +++++++++++
 drivers/clk/meson/clk_meson.h                 | 149 +++++
 drivers/clk/meson/g12a-ao.c                   |  12 +-
 drivers/clk/meson/g12a.c                      |  24 +-
 drivers/clk/meson/gxbb.c                      |  24 +-
 drivers/clk/meson/s4.c                        | 601 ++++++++++++++++++
 drivers/serial/Kconfig                        |   2 +
 22 files changed, 1358 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c
 create mode 100644 board/amlogic/vim1s/MAINTAINERS
 create mode 100644 board/amlogic/vim1s/Makefile
 create mode 100644 board/amlogic/vim1s/vim1s.c
 create mode 100644 configs/khadas-vim1s_defconfig
 create mode 100644 drivers/clk/meson/clk_meson.c
 create mode 100644 drivers/clk/meson/s4.c

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: s4_clk

-- 
2.53.0

