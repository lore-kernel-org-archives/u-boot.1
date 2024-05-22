Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA0C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A92188472;
	Wed, 22 May 2024 12:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="UTy/O8GH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B33748848F; Wed, 22 May 2024 12:06:44 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CA488435
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso4534523a12.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716372402; x=1716977202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AA2/ffCstJ7713b4mxGvq2iamj5N8XSa4i3TBCtjVBY=;
 b=UTy/O8GHYGxMDY7f1BGUIfUfeb4dRsFvfBrhX4jwR9lafRc6SwuhxttE9QYSYs0XXu
 aYUl0oaEcMksnLZV9ulWXDuy5isx0CM4HCyBcU9Eskb0KGT7ZXc2Ck0zRaSuLiBTTQA6
 r0PUie3BrPzRueQSipe1B4nhmp+drhZ1jHwbGExX27iaBeAXXBGYmqqd1s+QTvW8MbLf
 sZT8tmuJJDfKV3O/9xVC/mmdFqMU7HjtroYZjYB6EeJ5A0DdoHQORcpfIKaL2jskKedM
 ZVYaWxDElQTAsQyIKrS+EII3ZDmlWJcymcW/9xFHftCkb/v87ZigUmaZCsEHm03QmZQ8
 MMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372402; x=1716977202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AA2/ffCstJ7713b4mxGvq2iamj5N8XSa4i3TBCtjVBY=;
 b=Xz1/QzeDvayKzUJU6xUul81wzyNPRjEKAVqDIHpgwquthzgUmwFvssyeIMGJGBLGlT
 SOpRqLPGYY7AnDBEwWvzFxdsxrinbJONoBZO/QCE4nYrVtQ+ni1vu/CJIH2RoLnuANx9
 mzSuS3/Pp9HM/dcG/S95WZLdTSQTnFMxIBYIblVeOip7u25aTvs8djmaHJ3C0vAYfh+A
 JRW9gjYFzVhCffLTEWI/0I+RUaHJgQ+jkL5y18yZ9EtxQzXGAWgQ5TwErZNMK52f1bWx
 QqGpd3wDjZGcgQ1TgFWJO66O+8zl0AWD9fM3Rul0F4SiA/CdW+CRZGuFOFiNvo/6Lx9b
 O+MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4fzuK0DrlsC509zGeCxY16BcXmcbt/uFk6cwoYp2xPiFrFILI+W9d4LShw0EmDA3UBXjgGQ1fJhHi8C3htha/INa8bQ==
X-Gm-Message-State: AOJu0Yz/nYeoNMjiCdC5K452IrZdfhg5I/K3Mr685vNVYv7LErc/01D7
 qXIn8LJiiYIGQPUtFnYlGdC48nG6I0RQeY3lqIjflb2Lw8kT3ITP4WETpb1lh88=
X-Google-Smtp-Source: AGHT+IEsPUq/y8aBrwGRGXJrMBmOSRO8MHMR0Mto8k1VVGjuRJb2TInohjXoFEEfFrZYoSytf9E9BQ==
X-Received: by 2002:a50:d790:0:b0:574:eb43:3862 with SMTP id
 4fb4d7f45d1cf-57832a01cd1mr980178a12.5.1716372402041; 
 Wed, 22 May 2024 03:06:42 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-65.dynamic.amis.hr. [188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfc2fsm18146146a12.39.2024.05.22.03.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:06:41 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] net: phy: add PSGMII (Penta SGMII) mode
Date: Wed, 22 May 2024 12:06:15 +0200
Message-ID: <20240522100638.224484-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PSGMII interface is similar to QSGMII. The main difference
is that the PSGMII interface combines five SGMII lines into a
single link while in QSGMII only four lines are combined.

Similarly to the QSGMII, this interface mode might also needs
special handling within the MAC driver.

It is commonly used by Qualcomm with their QCA807x PHY series and
modern WiSoC-s.

Add definitions for the PHY layer to allow to express this type
of connection between the MAC and PHY.

This is basically a direct port from Linux which already supports this
mode.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/phy_interface.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/phy_interface.h b/include/phy_interface.h
index 31be3228c7..04826bc65d 100644
--- a/include/phy_interface.h
+++ b/include/phy_interface.h
@@ -31,6 +31,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_XGMII,
 	PHY_INTERFACE_MODE_XLGMII,
 	PHY_INTERFACE_MODE_MOCA,
+	PHY_INTERFACE_MODE_PSGMII,
 	PHY_INTERFACE_MODE_QSGMII,
 	PHY_INTERFACE_MODE_TRGMII,
 	PHY_INTERFACE_MODE_100BASEX,
@@ -79,6 +80,7 @@ static const char * const phy_interface_strings[] = {
 	[PHY_INTERFACE_MODE_XGMII]		= "xgmii",
 	[PHY_INTERFACE_MODE_XLGMII]		= "xlgmii",
 	[PHY_INTERFACE_MODE_MOCA]		= "moca",
+	[PHY_INTERFACE_MODE_PSGMII]		= "psgmii",
 	[PHY_INTERFACE_MODE_QSGMII]		= "qsgmii",
 	[PHY_INTERFACE_MODE_TRGMII]		= "trgmii",
 	[PHY_INTERFACE_MODE_1000BASEX]		= "1000base-x",
-- 
2.45.1

