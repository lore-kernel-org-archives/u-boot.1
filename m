Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF3C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 576CC60835;
	Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZ3TlW4abSUj; Thu,  6 Aug 2026 13:05:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 830A76080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021521;
	bh=kPW2DUxdpLm77sM+lotN4NGuanbhMa2JVuZlwPlfDK8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oulrlOBeiMnPFuZ90+ezdWnOYknKVke2q5CPKcdjrpvtAtyK+RdDxkw7fKTKCb0yx
	 yp2PKd8TOQOeSia6GkCqOW+0djtaqSb48pImkHsWOdY899VGue6Y316M3/tmeJv96F
	 ugzrUZbocBbcEmXQv+nETDnVQ4amHBD0acoH8q9TFm8bNC2ruA2RHTx9NZWxcIqEYn
	 wDEt/uKOsZ05rxAzVyIUSYjPPQWphzSnyapmG9Jp2UmANARRmUXnGG2QBCZ4MFYutw
	 smppXPTllbD55NYPi0nEqYEQYYDsDR/hNjhX9Mh/vEGjT6AkohY8ChObUHmTTYQG7w
	 tLDvYWzb2PL5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 830A76080C;
	Thu,  6 Aug 2026 13:05:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BEC6F218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4F0040278
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttvnxZHHdf9g for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:48:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF5A840159
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF5A840159
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF5A840159
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:48:19 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-472326ca506so1455678f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020498; x=1786625298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPW2DUxdpLm77sM+lotN4NGuanbhMa2JVuZlwPlfDK8=;
 b=hDgJ3XiIrjUzKQau6CjVIvidRYdxAX0cJC5HiokubLZ9+7VeMulUZTA6A8UPTbe4Sh
 +Ich5ml/0DKzSXvWKHj3Lk/CH7U2WBLp/hIAuwVXrAEaTmFl8DR1bUuf03FeNwYDLQyw
 f9lQVruXPCCIS9lae7odaFdA6mBSzJFfJCQhv2hzMhJkRyEgvpiQMuHfZQ0esAZvTvsr
 JJzgAoiP5R1zayWaKhyFQUwDURQDIQ+sKfXvtzeHtE7IsC7KmKAQDF/WPv5pGAvt2DhS
 DSGUkqX4BONL8cOkq/fIScw+ErJZjmCk+fixjhoFAtXQeYz0FCDV4H9TfKfFqLbNUBxx
 jIlg==
X-Gm-Message-State: AOJu0Ywc3Fv4faKeo5mMjcx7NnkVlN2/PrK5Com2mI0H57RQa6YuTEQm
 ejQhAK9HiIkn7hFp0y5uxaJ11l6FGaEbKTq2QLLmD4t2xLBnDB3MxBYwXchD0g==
X-Gm-Gg: AR+sD10b+BEzdlGztDa3QHNSbfD/iR2AC09Bb8Lf/yD/uh+7cwIr+N6udbIrcWlqhRS
 ZMYKYEUPRf77w9y/TwDDm1bM9LoRLcFLm7cRc2hbj3euFHG8LDlzN129PuqxHVG2GjLFWxbkd7i
 abw0cACivxBeSuBiMoMpCWTQ5uPjmUL50qkghmURU86eBdUeh4aemENpzlh7XYj+4Wgv6efGC5o
 6dujCt62j4Wkfh017+aMgRkL2e5S7o1y6kvr4yl2NP4Ji3oqjCh9EZLwTBc3hmod7DJFcGbnIyi
 rzN66rwEYvHBRSSj/mtKOKXGatFuugyes9pLKkBClWSI+i1/vFOKAC/jRnWzvrlDb7CRW888CZD
 eNQwChRGwgxXXsBYDrGQ+3yvQ0lzXwGww2f0g8feZ4wDpmy4GkAuKGV34LLHxslMYAqOmmfhqQA
 pdixn0KIhigq0Hyd9zgRcX7oXCQ7S5SNAtm+HwkgiSxxQ2y7Gd25Bb9NkHpiIFTqN51iY=
X-Received: by 2002:a5d:5f48:0:b0:47f:9404:5185 with SMTP id
 ffacd0b85a97d-47fec63136fmr22485577f8f.24.1786020497698; 
 Thu, 06 Aug 2026 05:48:17 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b25c01sm5663727f8f.29.2026.08.06.05.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:48:17 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Franz Schnyder <franz.schnyder@toradex.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: colibri_vf: CONFIG_TEXT_BASE and the Toradex eBoot flashing path
Date: Thu,  6 Aug 2026 14:48:16 +0200
Message-ID: <20260806124816.262259-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786020498; x=1786625298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPW2DUxdpLm77sM+lotN4NGuanbhMa2JVuZlwPlfDK8=;
 b=iHG/w9PHn6hSL8QcEFCOdeKi0txxZ0yQWiyP2HZd/tlIuxvwUMSZaYPHF2ghb7p8zI
 aURkt3PTZjdxYQl7XtvbHBftQ7rZPY5StXHgsBbEYRjyEL+Wqe5Tg0006m59EPyKs1R9
 IaNCN4lJcEXBA8MczAxJINKzReYS4urm+IEQL2oXXMTBUqll9OiBgZMCho8lOl/R9T/+
 gz4i/+onb743vSpIBUimMyfpnCNDXgn9YhAwkecQMEZqRbRkRSKNrw2HDu3oEccr/444
 /zF0agGSSZtGS9Q5krviiH5uh6WTOVnwfOkO3sxRefICS4RVcgxGr2lCRm82myeY+io7
 XiEQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iHG/w9PH
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Hi,

a report rather than a patch, because I am not sure which way you want it
solved.

Colibri VF50/VF61 modules that still carry the Toradex WinCE bootloader
(here: "Toradex Bootloader 1.7 for Vybrid Built May 1 2020") are flashed in
production by handing U-Boot to that loader:

	> flashloader colibri_vf/u-boot-nand.imx
	Bootloader image size: 455448 bytes.
	Loading done.
	Flashing bootloader.
	Writing 223 sector(s) of bootloader code from sector 64.
	Flashing completed.
	> reboot

With colibri_vf_defconfig as it is today, CONFIG_TEXT_BASE=0x3f401000, the
module then prints nothing at all: no banner, no character, on a console
that works before and after. Building the very same tree with
CONFIG_TEXT_BASE=0x3f408000, the value the Toradex 2015.04 fork used, the
image boots normally and the rest of the flashing flow (NAND partitions,
Linux) completes.

The difference is only where the image lands in OCRAM:

	0x3f401000: IVT entry 0x3f401000, image start 0x3f4004e8, len 0x6d000
	0x3f408000: IVT entry 0x3f408000, image start 0x3f4074e8, len 0x6d000

Our reading is that the loader is still resident when it copies the image
in, so an image linked at the start of OCRAM overwrites the code doing the
copy, while 0x3f408000 leaves the low 32 KB alone; we have not proved where
exactly the loader keeps itself, so treat that as a guess. What is measured
is the boot/no-boot difference above, on the same module, same card, same
command, one build apart.

Booting the same 0x3f408000 image from NAND through the boot ROM works too,
so the older base is not specific to the eBoot path.

Is the eBoot path still considered supported for these modules, in which
case colibri_vf_defconfig would want to go back to 0x3f408000, or is it
obsolete in favour of recovery mode, in which case it may be worth a note in
doc/board/toradex? I am happy to send either patch.

Thanks,
Mehmet
