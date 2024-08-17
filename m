Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A957C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 13:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF44886F3;
	Sat, 17 Aug 2024 15:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NO+NOaWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4350288A4C; Sat, 17 Aug 2024 14:03:46 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1A988580
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 14:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=crausaz.romain@gmail.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso9850415ab.2
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723896223; x=1724501023; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3MlfGhnpMsuVBULK5rt4S+ACRmZLrbgOwtlUAhoJUOE=;
 b=NO+NOaWX9nXYaPCMCE6QUBhNj6CB/JACYn9D3zaD/T7hKSNJHbk7hcbjsAZOTmPipX
 1uRjvF7D88RdIlMtRk8ut0YCtzS65ENe3iftYDeEJ2+xcOxGOqy1h3CETQOXFo1ZD6xJ
 BzTmdFIAcdSJ63Wgdmv6r0Ww7kNzRA2TGv3qjZwTZL/rToAe1RMb+xAnNkfZjTkk8/ql
 2WCDAr777pzlZ0qGhoQuvhrpBh400Eyf6MfdV2FzC2aYPmEQEHzagT7IpXynGlEtXbCt
 UZ/wOaASlDo+BvIWCnhrSJoD4AJAT/uu6lf6pwbsQNgZcmlvCYgEr7FdMo7+BLfRPJrt
 BCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723896223; x=1724501023;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3MlfGhnpMsuVBULK5rt4S+ACRmZLrbgOwtlUAhoJUOE=;
 b=Z137XCvK8dvQbuQyk73UO2PvYiMLbBXlUjTIMrzuGTv/mE3VgUc5fXfIAr3eD5xNkO
 Agj61ebIaPTihMhJV9CFGopBOkgALCIMHIob2kZupPf5QvFCi//V+00U/Bj5rFwg3rwl
 6zSN9o16xDXhSz/lFyuwCGDqPh0SDw+sHQTGYS6hZrkibENFgEygyy+8GeE3HpL3kdn0
 S3lWhsrXpa95ALxn3ltMqk94uXcRDBeeYWSce153bUFf8v4ySclJylELurDgSrq3ayR6
 7yQO0llZQS0Khv1T8V6884c6z59in/zwtZmW2J+zx3wzwUe4XtUjy26xHoA4X3uVmBZr
 eZPQ==
X-Gm-Message-State: AOJu0YzikNyRT9dkrTiyKKg3flUXpZVaairwW/aF7nGHZhO1uvj1Wzbx
 8UPIM7ILmed50PtXQNe42cYi5Yy51jX5zQOvcsocNMGTYaHdpkMtQozmibmbuzODBNTAuFddBlS
 oAcpZE/60/IS/ti+BbGcqWpNKMnG4e8qJGzw=
X-Google-Smtp-Source: AGHT+IGEfNZkjJ6WbxDfV8HIBL/a+Frm9ElB2Oduzz7iogB9W86jyaSjww9nVrQE1G54sotNx2BY2Mp1W2K2L21H5FI=
X-Received: by 2002:a05:6e02:2184:b0:382:834f:2b9e with SMTP id
 e9e14a558f8ab-39d26cee5bemr61280525ab.11.1723896222597; Sat, 17 Aug 2024
 05:03:42 -0700 (PDT)
MIME-Version: 1.0
From: Romain Crausaz <crausaz.romain@gmail.com>
Date: Sat, 17 Aug 2024 14:03:31 +0200
Message-ID: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
Subject: RPI CM4 - I2C BUS and Device Tree
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 17 Aug 2024 15:01:10 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all,



I am currently facing an issue with U-Boot and a raspberry pi CM4. Here is
the setup:



1. Yocto Scarthgap

2. U-Boot 2024.01

3. rpi_arm64_defconfig



I am trying to access the i2c bus from U-Boot. I have been trying to modify
the device tree which is referenced as
=E2=80=9CCONFIG_DEFAULT_DEVICE_TREE=3D"bcm2711-rpi-4-b=E2=80=9D=E2=80=9D in=
 the defconfig without
success. I can remove everything, set all nodes to disabled and I see no
change in U-Boot (I am using dm commands to check the status of the
peripherals).



It seems that with the rpi, U-Boot will only configure itself against the
device tree passed by the bootloader of RPI. Could someone confirm this ?



Is there a way to configure / modify U-Boot to use its own devicetree and
simply pass the device tree generated by the rpi bootloader to the kernel ?



Because the second issue is that the i2c driver defined in the device tree
passed to u-boot is not available in u-boot.



Thanks for your help



Best regards

Romain
