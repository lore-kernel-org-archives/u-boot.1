Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E07C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6AB560743;
	Wed, 19 Aug 2026 13:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbGM8bXI40yv; Wed, 19 Aug 2026 13:42:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146930;
	bh=oPrjG2jfLSpgX07gMsYGdcIXUZntabfyeBipEwBP8UY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v/iqLyPizPNEVli6DWLLjQ5nFq/8f6VzGhFS/W23MFHW7LHRH/F2m8HIduGdvP38o
	 yACJqRAQChPOIX6ShlUeBjWMz1QqjRAyXQxxtekHX0DzZj4oPMTY2eDPadk0qUm4Cz
	 YwsXnO9Emcv1oehz8Ibbt3DM20ifuOrHIhgYzSCSwW1vYqMLjWbSi8T3XVSEKOv2uO
	 rwsy6T+fU6rO/X1yiz7GgcmGzyKHYVxaa//JZi/91jlpae7wgqHrTp7JQRYUcGiSmL
	 gFm0wWUt1oxyRm3JCGo029gPzJ/STlLjZrZ7xmO/R0BsS4ewQpzqsNp46FiRLP6z+g
	 kLMwLgYrDEsEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29D1C60719;
	Wed, 19 Aug 2026 13:42:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D82C1460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72D3C6069C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3hUnfCrOwMF for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 13:39:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FbEsQ+Bt
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 852A76069B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:04 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso378992f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787146742; x=1787751542;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oPrjG2jfLSpgX07gMsYGdcIXUZntabfyeBipEwBP8UY=;
 b=FbEsQ+BtJ5mkkqay+ijP11fz0Q1Z5067aq1E48TCxiZ9WZDWgTCn+mJmAbhJHndZ3l
 kD9K0yXtPHMxKFut9HrTSk5s8N6ZzODSQ8VMPj2gABr4YLTBL6R3T9CuiLWzZt7tMjUU
 nfJR72C/2P6p55tjIsbJ6JYTuQRz1HYTKYan8N0FuMD7RwyrXjag9E5fE9m9xMG+90KU
 IIb7ZTMhshteJdKxymTk71ZMjnpC/gzzfDydgrZDEoHH/YtKqxhY2bGUsXmYHfZxiZjK
 9WUZXSt9aXr3IEdrWyWDfDy2b8L9pcZ4HMK1sFoO6cTtjw09BY94K4XsrhEOqLFrzGvl
 OVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787146742; x=1787751542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oPrjG2jfLSpgX07gMsYGdcIXUZntabfyeBipEwBP8UY=;
 b=g41/pANS/OO2xXEpOQGEQFn7Wpfdj0P0+kyA8mGx76S2fvg2i2P8e67bfbw7kvHXUf
 s67HCuXXcgoEUG6UQAUHyodzb74Rdx7lgxcfLDeXFKLFN2QqvezzgPLN7Ru6jWeg4MR/
 3GSsbFGJKUBP0N6YOxeZAvqdHKmxNX/jKI1jKfW95zxa37Px+HFE6VI4FdomUtuy7TEm
 icfVHlg4blCkELzOaVb3SeG/bFxpma7bdlox4rIkxT183hsyi46l4FOmgXrIDKgmUdE4
 mgIrRtNo0zU/BrEXrksHB3Y2ybLbdsy6B1Vk/fxc+Z/b21Qd4Yum2BSf6BLwfdHjCs9D
 yhKA==
X-Gm-Message-State: AFuF++lEZRrrIZYzDDbiq/NxS3YibAJdRUDdnMc2U9iP5/pqG2wjIlQj
 h6CswZ1h94L/5HB9XsHDvNmI5IKeIUIuToWQs2p+lXgUnh4rvFLtGvmn
X-Gm-Gg: AR+sD102nVa6E9VZeaSATXQrQU93TwVspnrhnr5EyHlhXh5DNgKEzwsHE9a+c50rYHx
 eWyCCMJzMTE6mhthCrigOKA1r5MJVyJOB79SUN+eKIub5W9X/2/Ge/qw/k27Ia72k1yz/TWWnrA
 5ZQEVa3TIPVuGgsdjjnnrlkZGqfZA8tfKqdpq2HtHO0E8DZe+hO5T9QAzf0wuVlURNrNf61ml6M
 CiA85lRAVFBCcA5qhLsY1Qjp4Jqb1ok7+M/LEQ6MjpONSSkpMQbhOKmo8gTvO9x6xrdCd3q+rEf
 VKAJQ2gh8R0l+RMwBecdVgthfv5jbiScskYzRbfj3DlZNl6XvrH58b24EOVo+nEeQ0QdpD7WHp6
 9qLRgnxm1hro2iqDEX7od7j7jjB+w6aTj364PkRRIARLhhikNnmWC2+byNDA/FL9U83pxpNKVSH
 iQ8+EZ2OUrJrDa0jn/1AmMKxNcwAKipOKoYsOcpnpFsB7fXAwBVGH8D04di45QOiLGHwIeNQuc3
 rIV1Cn3hk9S2xaRKWohgDN6SkQiXcwAAmSo+dzjQvSAykHnxQ==
X-Received: by 2002:a05:6000:22c2:b0:482:a2d5:5b5e with SMTP id
 ffacd0b85a97d-482b1e86851mr8506281f8f.4.1787146742416; 
 Wed, 19 Aug 2026 06:39:02 -0700 (PDT)
Received: from eichest-laptop
 (90.251.200.213.static.wline.lns.sme.cust.swisscom.ch. [213.200.251.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441753sm6463070f8f.5.2026.08.19.06.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:39:01 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com,
 ernest.vanhoecke@toradex.com, alice.guo@nxp.com, peng.fan@nxp.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/2] Cleanup i.MX95 based Toradex boards
Date: Wed, 19 Aug 2026 15:38:35 +0200
Message-ID: <20260819133900.167046-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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

This series removes two leftovers from the Toradex i.MX95 board support.

The first patch drops CONFIG_SPI from the aquila-imx95, verdin-imx95 and
toradex-smarc-imx95 defconfigs. It has been set since the initial board
support, but none of the boards selects an SPI controller or slave
driver, so SPI is not usable in U-Boot on them anyway.

The second patch removes the WDOG_BASE_ADDR definition from
verdin-imx95.h. The ULP watchdog driver takes its base address from the
devicetree now, and the macro it expanded to no longer exists, so the
definition is dangling.

Neither patch changes behaviour, they only drop unused configuration.
All three boards were build tested.

Stefan Eichenberger (2):
  configs: {aquila, verdin, toradex-smarc}-imx95: remove CONFIG_SPI
  imx: verdin-imx95: remove unused WDOG_BASE_ADDR

 configs/aquila-imx95_defconfig        | 1 -
 configs/toradex-smarc-imx95_defconfig | 1 -
 configs/verdin-imx95_defconfig        | 1 -
 include/configs/verdin-imx95.h        | 2 --
 4 files changed, 5 deletions(-)

-- 
2.55.0

