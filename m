Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D5CC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E0DE81167;
	Fri,  4 Sep 2026 07:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1z9Tzh6Fblh; Fri,  4 Sep 2026 07:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9542680F6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788506011;
	b=pDvtA1MkKQ2uFE8N5PjOWbikBDQoUKGGh9D1H80eOMZ2Up1k1lqr6k9iRVI96W4kFzeU
	 SkEp/K9GUCpicZZHIhLX2/4p0ZuDnyqOU1WoDwMwwYkYtZHaTpJCr/7YMq+uRpSyj2j3J
	 21tpH5PclFY9CCVJxoK17qgwRBSYajRsIrLPxhBt1/IRG/G5KV0s8CdrlIHQYmB4WmCWa
	 svtmZh7DbxmFlK4i7KD8fHPKEBhutS4xXqrCT1TxmYPG2q7HlQc1hXRtBJ5z9fUxnpe+E
	 8iUR7l9yk/r/PVPi67CxqgYnUBPpHJ9j+aPDTMJJrHQG8/3XehT1iZKwZY0m+K7hNfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788506011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lIAKJEagodA8mwf9U8mZlH4zY6v2bEuCI4Dbtj9f5nw=;
	b=Y30APbRnpoPpPWwLqaZNlJQ8OC0iQsLUbFvyzmwAzv+2TCM4RGK55wuMxfe0aQtSCUkW
	 P9yAJEktS5uMMm6WRRbVu41q8P7fls9oc6HhOhieklxrwSx5BM6Z1Z1abubXNpwAZ011F
	 k0R5qEXQLoMQteZe2FtpsOu1XJyrwc67rbuvRzfH76elZRcdszz6QYEnLUzVUog5hGeDR
	 aHHagcZRH0baelQ6lOy6SAMaZQ5cxcCNeY5qz/dm+id3fiuJ8zOAR1yyxHe/EAS/HONDk
	 6Xu0aJrlkmhh0dorZPgCn5P38er1XBcxlBa+Dx7yPhrByFWcr1ty/U34osczl+ElOAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788506011;
	bh=lIAKJEagodA8mwf9U8mZlH4zY6v2bEuCI4Dbtj9f5nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBEhYuzwhcIhb2bEXScR9c8l7Wme2DM7Z3WoNhenFYcMdkWNcKRMV+X/RB45uI66C
	 n9G+hDT3VtNwRb2OrVcamYy6uW3nk6H0A+2c61g6Vg1pY7tm2YCew1ESxTDJO3asD6
	 KuzOgjgzTf5uP+qE1yOYbdqoQOuyapDiGltwMtqBWIlreToewqdWRmmBu+Cn6N/sk1
	 1xoHb8Kt+scaYVooNbv4qp1PrX0366b9icO2GhgbxUyiNdqyC8z+DxTNLvATo01nfM
	 dKOPGQ2hn/u3PPsSrsqEFVdzj1yhDsc5P+KLnEmgQrQhnJlSJd98PgFNTv7RSuSMoU
	 +pjYNbUQZKt6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9542680F6A;
	Fri,  4 Sep 2026 07:13:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 97F6434E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84DC740BA9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZyBA2nxFuFZl for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9D4940B82
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788506008;
 b=StZtLpD4SNWGgetHZjOuOvD04Jo7/pDMnCf9XB9x5Kna7pgiWMREp42TpyP8U26yJHMO
 AM5vtu+aI+jOqKLFCFZp+Lpht9VI/YHJMlH17dEAXx55xXWO5bFL/2contAl5aVVWmRod
 w/LFDfkq7tM1Bi57RYMm+jhIr+pcs7YiTIw/9Vzo8fkr6u7kPb8fjWiMMhTyFcDxj7AKk
 7utMNnH6TTj+LYHCusCTotX31LFHs99/MK+B1Ub3IZDrjs+anCkMVcplLv0L73xGTKxxJ
 I2GrvaLNmD3+UdNvwk94Pi5ioIDHQTOunEKL8fyoIkdjxJxd513XmQXl602+gw6tXfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788506008;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=lIAKJEagodA8mwf9U8mZlH4zY6v2bEuCI4Dbtj9f5nw=;
 b=AUgut0B+Ohly+OOmo6g9ePLYmG4utPf5LWUMXVwgBVRpNT92OPEStNrRrdwOq0YMdJiW
 bId+Mgte58mHQaH57+L9nbwvpAwL9HLVEPdf7TulV+OeF0J5hAFG7RZJEeHIRNlMZSDhx
 eGsWFWenBzgwhFR1lN2R5E5qUwPEIwUdWo3e5lSujRsxj0nGJ4Srx1ynbJnqnXcEt/bmO
 Qsthqw+rePGzouCuhufforg8bXjQYyMs0Kd5FybD8Wr9gPIGAalUNKZTNehn5Svkb1rSc
 KPG4XrHdAqdbgUmgGEnHCzJQLb5ZpaH2fYhpyTZmk8HaX1dz3TNCalbwhaoLyczP+rA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=mCAQtDhJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=mCAQtDhJ
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9D4940B82
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:27 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so437492f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788506005; x=1789110805;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lIAKJEagodA8mwf9U8mZlH4zY6v2bEuCI4Dbtj9f5nw=;
 b=mCAQtDhJoH9Xvxrx9WnRXGd/khcy8R7vY2X2UpGrJm7i5x7HrbJlz3OUp538JAR54M
 5MBDUN3ciFekqcSRRYWhkLEpP9jsYLeatGIBnAOMGQB2zKirVmbm4V6+FDnSmATByHZ7
 aelnhZsjYFPuttLAMhFbO+JkQqtGV8HX9OfsEl+ULh/eksk2V39wC9jE6do0CxanI08z
 H1T5HKW7iQh7EWpIvuxnozfWdfH75YFfDZBdBxcFTys1DaHGkoy7FJ530Gw4M+99PMDO
 fybqToK7j5qLFcQWtQGuRDStEOQJ/1N7zXdWDg5SHxUlAGdYkKtKpqQAPoasj4FKpSy2
 /7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506005; x=1789110805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lIAKJEagodA8mwf9U8mZlH4zY6v2bEuCI4Dbtj9f5nw=;
 b=NzFDFb2+UPjZF5S9UYF+oWQrH7UYABkxtLf/2VGiChB3h+xly4D2Oi2f9jMRw6MrtR
 S1UdPYrCeb//Dnnb3BJOK/FOGXrQxuih4QYPBFeShTpgdU1/8PKiD9Yv894anc3uzWxe
 5WTDt1eZuy8BO4kXsSnsP86/SI3tyZCcJzusg3DJaMmKoZckjZeERcYaUT7FD4ctDFcF
 Gm6Ra622rvudU0tx4+9clonBqZva0YODlVsb2DLPywSeIaPIZQ2GEjgA3hKDEJ9b5dLr
 uE85HYGsuQWZ4XL+l+GpT1VY/xY//FKh5/2i7CoW4C0bOrUgi0BhQfDKLevGzZnfQ46w
 4vnQ==
X-Gm-Message-State: AFuF++kPQgPOaSibnMCJvV6NqpIhkhlK3eP3wFdDu8yvZNDCaBIf7F1J
 icupp0p/qthtiL2O6CnGKBfnRa/yNL83kyEIL3bin4x108yGycsEqg5LVOJ1XdFTEgc=
X-Gm-Gg: AYBFou3Tolo88h9HHY3Be7NGZn6b+IvsOWWDcBzWdJ/vb8KUpVNHzf/fJww9TCZHxOH
 g3sOB+lGoZGzBrfGXB8AAIER6pdDP+WyGp3IvoJ2T95PFtuWW4X8h3kdnoC/HxdhTOzdhqWmueY
 6mgf2SSC5nI0qM59a64LM7ZFWzgFpHGXsNUE3umPyBKlzBvU9MvyhdZOEZzss0ycYXvjBQGjZpI
 bRikjw7nfqJqtFb4ZCDzu38Cf9dZrbG5qARY2MVIXnxGll8J1VAvpUf8vwbcVItUBzPZZI8KhY1
 QHF93g+y/0gkc4HcJSRrDF6hbcERLsb6tfxfIe2yR5AfH15r/hM5lGreyybiMHQNLiuE8D6oWQ1
 mJirlMoxaj7T6UpFclfGWMu/Dbbpj7S+5e4umR8sgW2/lIkQfMBhnnH+QlACMgIFjFdAUJsngZH
 TMSCTvknxpU71P3st4uU2yH+Ntfa7IZzEfDrF+JeiwgRCD2aBn//h3Gd1ulUiYeq9p/hmWY1maV
 xN6zQJatI+UFRqutUhb71bSmBJf3xXqabwrnlesvJMeG9cC+Ws=
X-Received: by 2002:a05:6000:25e7:b0:485:8c16:a35c with SMTP id
 ffacd0b85a97d-4858c16a667mr1164969f8f.52.1788506005366; 
 Fri, 04 Sep 2026 00:13:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:45 +0400
Subject: [PATCH 10/10] spl: ufs: allow loading U-Boot from the boot logical
 unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-10-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=alchark@flipper.net;
 h=from:subject:message-id; bh=iF7oZLORccDc537mwo7HBpM7bGNr1bjiJ7w4Z13eF1E=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi+acatlnYTkgd3OcRc/TDz/2+7wyy2nVnZF6Nr8k
 /GvmuOn1jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUv4xj+MXksDDu9GXLzR6+DslJLqce7DY31Vlbf+L0elm+o69qN4Uw/GZ///q
 F/4uorJ6mfmthr4i69ZtPJitsM3Z0cjp5cI71ZS4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Naming a fixed SCSI device number cannot express "use the currently
activated boot LU". Offer the boot W-LU as an alternative source, so
that flipping bBootLunEn between boot LU A and boot LU B moves U-Boot
along with it and the SPL needs no reconfiguration.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/Kconfig   | 30 +++++++++++++++++++++++++++++-
 common/spl/spl_ufs.c | 18 ++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index d1e3c365ac9a..093bf55e6017 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1634,9 +1634,37 @@ config SPL_UFS_SUPPORT
 	  use of UFS devices such as hard drives and flash drivers for
 	  loading U-Boot.
 
+choice
+	prompt "Source of the U-Boot image on UFS"
+	depends on SPL_UFS_SUPPORT
+	default SPL_UFS_RAW_U_BOOT_USE_DEVNUM
+	help
+	  Pick how the SPL decides which UFS logical unit holds U-Boot. Either
+	  name a logical unit outright, or let the device point at one of its
+	  boot logical units through the boot well known logical unit.
+
+config SPL_UFS_RAW_U_BOOT_USE_DEVNUM
+	bool "A fixed SCSI device number"
+	help
+	  Load U-Boot from the logical unit that shows up at a known SCSI device
+	  number once the SPL has scanned the bus.
+
+config SPL_UFS_RAW_U_BOOT_USE_BOOT_WLUN
+	bool "The UFS boot well known logical unit"
+	help
+	  Load U-Boot through the boot W-LU, which the device maps onto whichever
+	  logical unit bBootLunEn currently selects (boot LU A or boot LU B). This
+	  follows an A/B switch made by the device itself, so the SPL does not have
+	  to know which of the two is active.
+
+	  Booting has to be enabled on the device (bBootLunEn is not 0), otherwise
+	  the boot W-LU does not answer and the SPL will not find it.
+
+endchoice
+
 config SPL_UFS_RAW_U_BOOT_DEVNUM
 	int "SCSI device number of the UFS device to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS_RAW_U_BOOT_USE_DEVNUM
 	default 0
 	help
 	  UFS devices are usually configured with multiple LUNs, which present
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f3..393736c7dc7c 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -8,6 +8,7 @@
 #include <scsi.h>
 #include <errno.h>
 #include <image.h>
+#include <ufs.h>
 #include <linux/compiler.h>
 #include <log.h>
 
@@ -24,16 +25,25 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
-	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
+	int devnum = config_opt_enabled(CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM,
+					CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM, -1);
 	struct spl_load_info load;
 	struct blk_desc *bd;
 	int err;
 
 	/* try to recognize storage devices immediately */
 	scsi_scan(false);
-	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
-	if (!bd)
-		return -ENODEV;
+	if (CONFIG_IS_ENABLED(UFS_RAW_U_BOOT_USE_BOOT_WLUN)) {
+		/* A UFS controller only ever has a single target */
+		if (scsi_get_blk_by_lun(0, UFS_UPIU_BOOT_WLUN, &bd)) {
+			puts("spl_ufs_load_image: UFS boot LU not found\n");
+			return -ENODEV;
+		}
+	} else {
+		bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
+		if (!bd)
+			return -ENODEV;
+	}
 
 	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
 	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);

-- 
2.54.0

