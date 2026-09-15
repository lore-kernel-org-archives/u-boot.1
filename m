Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720A4C88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60C9F80AFB;
	Tue, 15 Sep 2026 15:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88AXPXiC3cQx; Tue, 15 Sep 2026 15:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2056380AFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789484413;
	b=RbFTrCN4JoWbN1mbYV4PtF2syw0iV9oLPUa7LQi+htRq0O6TW+aMVK+Rmeun2DLvSKZw
	 HN3UFxrLGf6vRcR+1RRf+GLOEQwFx5QmMhQKST9HH6lmE4wRBIJv0Z7SeunsCiZCM6FiO
	 geKUKu5oF5/VTStJRN+DVjpev3NNfk67Sm+pR9or/vwS1wPzVN2zBLMBum3Wve6CV9gbI
	 VCun1T3gy08dbbdyp9Hl+9S3tVCEgCMwzLvadkCz91srOkHYK8T2whOdZmZhMGZ0v1PM5
	 KF2gx/N4bS2CwE4rAVtwErMVF1QQte7F2GKu2EZsK18/b4KY2ojNCjLhHCVHua55Y/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789484413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ksL/eeZLJhMvL26ZM+HM/YTDu2tw7no0VtOngqk9vVA=;
	b=j8K9P4FKRLWpPLo4WfcQMIdaLYAduoH73Lg/LRze/X79yPQddC86ZQsPcLGuayOPJKEx
	 ta3rQQJvtBwOCxAdXxjACuUmNPWSTS/6z1KYb/GRA9BWfGfKKHMsmf5PW0dZDCwvy6HYB
	 T+PfkdS30cfVfr2i4N1cSlwXoql85Hh6QfnHWBjf0B18TyVTIhcmFRm7be/xqi7KECj8N
	 NksOEObajbCE4jcLTVx58h3vReNeQ4B6IvlNTGs7SqLsbX+VccXpvtuM6Mqt35pJOWWOw
	 QsvWPXpvPtJRLl6gmGruZEQIJ3eHXRTdVb51WlIzjYHbTPJqMaKBwf0hf4xkUdQmNjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789484413;
	bh=ksL/eeZLJhMvL26ZM+HM/YTDu2tw7no0VtOngqk9vVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFPRM/nN28JO3QWPMlufxqDBRz6j6DpL7BZ39DlNu0sWTtcpFuEbORgtxISoP5F5d
	 Bv3HHPuKMt6VrTduE/zz3TbzRX5/xmXaliOg2Dc7OtXjZRcK7rTdp5Rr42+lXremrk
	 ihF2Y0FbVyRT3ZIXEM+H2vHbhOptPo2mWAIYmfAJ45VtDKpy90wiRwbd+a79rA6YWS
	 p7wVN8Yu21qQ9au2dzHSs5DM1S3XIjFmJJsFYhi2+ND5srvxSib4RZPwF++aj87Rsh
	 YQWDbtNwvlvZ8sYsSA5AAgoLemYAYiZijnL473ZSJYJN1Flm0/Ht8HRbR/GD4iRrNW
	 mkx1jjBH1NQBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2056380AFE;
	Tue, 15 Sep 2026 15:00:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFC9FDCF
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1D53400D8
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrPkBdyehOF6 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 25E1B400C2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789484408;
 b=k7YFgO2HzkImLVSILa3VSRWS/udHM1bmgJLTk2q91UvUhZlWUXBYqVxzpd78oPkqJyrU
 2kFBqLQTYV7egD9yggdfq1w71tMp9ZjqY9EZ2zS8CpM4zwjFq2VR50AdPEhaj0CkwvjvI
 a5vfLFHZfygJb91Pu9hA8wSMuT0Sq6x3STHt+I4pws2F1RQRfbsl5N5rEJJ53UC8sKecG
 Pi3Ajoa4ByQfqXRlqnwSsWGRmZ+B/QOG9/MyO9XF9eMthJxh8OUZII2niE8f7DQnQMvta
 /IOwZM1EwxbAwenevFUiM7jsiUpLWTaT4vZV8C/vz9eTcKytdk3IHeXsbH7SX0F99zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789484408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ksL/eeZLJhMvL26ZM+HM/YTDu2tw7no0VtOngqk9vVA=;
 b=hx4Tr/eRfrTmCbpEqmLxRY462zonDFtlf9TI23bzTSp5zeT5ToR/+dr8hJlh24UEgtlv
 ocn30CibbqtGn4Bmx2kv9+BAvxgavuU8NpXkqG3FVXoeCKB3z/TbMSur1ipjmcHmp8Jkc
 5dywmaNuc2kp8+aKSU38+wmbR/SsBfO25QySuZzNSboy0rWFlPp+aOl4eptn6tZMUMRuc
 lShakzOCkydXnGpogLyVKmFCC+m1ghUS8qiaeedNayMBn+7GCCI4CYgf85CtxFrf1xgBj
 GKaC61iRqAQ0IDmFJZMNQjuHcNJpHg5RxlHWsBiLKRJjyxUyNgY+F6b5pSaD87Agw3Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ju2Xk0XY; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ju2Xk0XY
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25E1B400C2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:00:06 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso3367105e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789484404; x=1790089204;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ksL/eeZLJhMvL26ZM+HM/YTDu2tw7no0VtOngqk9vVA=;
 b=Ju2Xk0XY5InVfpSi/SiJOBN5uz2CY+LnFAjV6idFHmCy2Fsz9W1STGiJxoPHzvfVMg
 WUBboSihA6bSPWftAey9dp9qx8oFHTl6fd31n7opNJejclpMCM9gQm0qN3luiGbRUbq3
 zHAbJ1PUXboFc34ElN8+z0womPqJvwHkGAIbCXnjXMP3w1NzkzQ+CkBAdaHQPlNnv7Sw
 /Y/ZW0yamqW6L/JhhXGSOzEfz/rFftKAX85ilRG9YUiyzAZ4RvL6FcPEpKGaDhNMrSZd
 1jbK6+SPA9QAo2cHnArYEm9LKTFHpMRmBPPL3Oq4H5nThyIvaSNsK+wDFAe5LiGMH4+Y
 d49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484404; x=1790089204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksL/eeZLJhMvL26ZM+HM/YTDu2tw7no0VtOngqk9vVA=;
 b=ih1HGdeg8lhQnDWuEuPFdanvVdmhqwXeqqw91IAq5CjrWKmeyfvHH1joHU2gJaiZO2
 W3fXDar84U5EPpVSzUFxWuTeQzE9xTxX/Wn22DEvsFh5rO8dB8/R2jzRJKyzafKJaCxT
 fepfrbzzjB0oT7oEbLisP3nLFBOPKeNuYiEj4Xm66OT6GqcLrFAH3tCpkLxpJxmZZ+Ua
 nEtNi13BdWi6az0C0ofyPt4lJOsoVzAzVELLxCV6Jyhv156Ad5ZvKYobfzvW/Mkvv8L+
 9X6q1qWN7eEIe7s15TJ8anelFRQQ6VpPTA6Jwa882gt0ezpIaVeEASoMUpYiZtLyfURd
 qgqw==
X-Gm-Message-State: AFuF++n12TIilvAtRX5nHvrGiCQVGKCtdcZLF3fwSNFs1ktQ4ukxRENK
 tW+gUWxF8xMfGz99RFwmXiwS7e4wUMPre1nmvACF3Q/MwFppJzfolezq5Fcpjw6TL1A=
X-Gm-Gg: AYBFou36z1Ys4WfqpC/6sgAoAm5zfc/Sfk8jjOWFt1fwj8mI5n8wFaHM2pUtceSdoda
 5LAyNACOr8Dhp4zCtLVrN5+TLlidiYJtFJDbkcJb88S5okPa6fkPHkNBMjAkzfsBjd6rO3ds28f
 j006Myih4/nh0BM5DK8p+2b77L68ia2DKtZjU66hmXgFULj/u80Ut9QCMozJu6u9ONHvDsznrBN
 Tp1YUUDCpVPMIWMYJr+8covaRpehV7BiqhHaw0G9lvGcADTL2Kp0Kp1fp20tzgiWlV57NYVVNIa
 ga0WKaXdiusvjVKEhaUJ9JCD/JSnipt32Kag8IELWQc1s9NbYW07zvJlgkUFmCpVpi3+AzWI0sk
 IRo3JAxN7FQGIuPUUPGyZcrovCkgFib+Ac79G6ihEtG8bzIK3MsVLdv5mDyK3n6GEceyQUUtBaP
 fW0mS9z4yadRYVyee0m4ypOwbw1k9q/Md2J5mXu/cFARXsSAkAEjJtIK8Co7ukEWknPHxncyMC/
 ftzQNBfvZ8QTqNlANuxZYjgAWw3fIOY3ZOCYktAfrmXBin5dqvbx8Ui25k7qVwh9fOuaew70tMb
 e89PoSRiJIBqyom/Vsm/MqbEo2yev8V76wE9xlwztyHm9eFobTSQjU0=
X-Received: by 2002:a05:600c:871b:b0:49c:edd8:ba35 with SMTP id
 5b1f17b1804b1-49e821fef6cmr19303225e9.6.1789484404385; 
 Tue, 15 Sep 2026 08:00:04 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83aeb654sm1538675e9.8.2026.09.15.08.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:00:03 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 15 Sep 2026 17:00:31 +0200
Subject: [PATCH 2/3] phy: mediatek: move MediaTek PHY drivers to their own
 subdirectory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-2-83707ed5242a@baylibre.com>
References: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
In-Reply-To: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

drivers/phy/ hosts a growing number of MediaTek PHY drivers (T-PHY,
XS-PHY, UFS, HDMI). Other vendors already keep their PHY drivers in a
per-vendor subdirectory, so follow the same layout and move the MediaTek
ARM SoC drivers to drivers/phy/mediatek/, together with their Kconfig
symbols and Makefile rules.

The MIPS SoC drivers, mt7620-usb-phy.c and mt76x8-usb-phy.c, are left
where they are: MIPS MediaTek support is kept separate from the ARM one
elsewhere in the tree (drivers/clk/mtmips/, drivers/pinctrl/mtmips/),
and Linux does the same, keeping its drivers/phy/mediatek/ for the ARM
SoCs only.

No functional change: the files are moved verbatim and the Kconfig
symbols keep their names, so existing defconfigs are unaffected.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/Kconfig                              | 46 +-----------------------
 drivers/phy/Makefile                             |  5 +--
 drivers/phy/mediatek/Kconfig                     | 46 ++++++++++++++++++++++++
 drivers/phy/mediatek/Makefile                    |  6 ++++
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.c |  0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.h |  0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.c        |  0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.h        |  0
 drivers/phy/{ => mediatek}/phy-mtk-io.h          |  0
 drivers/phy/{ => mediatek}/phy-mtk-tphy.c        |  0
 drivers/phy/{ => mediatek}/phy-mtk-ufs.c         |  0
 drivers/phy/{ => mediatek}/phy-mtk-xsphy.c       |  0
 12 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 97133304cb6..112c5aee786 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -278,51 +278,6 @@ config PHY_EXYNOS_USBDRD
 	help
 	  Enable USB DRD PHY support for Exynos SoC series.
 
-config PHY_MTK_HDMI
-	bool "MediaTek HDMI-PHY Driver"
-	depends on PHY
-	depends on ARCH_MEDIATEK
-	depends on ARM64
-	depends on CLK
-	help
-	  Support for the HDMI TX PHY found on MediaTek SoCs such as the
-	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
-	  clock PLL to the HDMI TX controller.
-
-config PHY_MTK_TPHY
-	bool "MediaTek T-PHY Driver"
-	depends on PHY
-	depends on ARCH_MEDIATEK || SOC_MT7621
-	select REGMAP
-	select SYSCON
-	help
-	  MediaTek T-PHY driver supports usb2.0, usb3.0 ports, PCIe and
-	  SATA, and meanwhile supports two version T-PHY which have
-	  different banks layout, the T-PHY with shared banks between
-	  multi-ports is first version, otherwise is second veriosn,
-	  so you can easily distinguish them by banks layout.
-
-config PHY_MTK_UFS
-	bool "MediaTek UFS M-PHY driver"
-	depends on ARCH_MEDIATEK
-	depends on PHY
-	help
-	  Support for UFS M-PHY on MediaTek chipsets.
-	  Enable this to provide vendor-specific probing,
-	  initialization, power on and power off flow of
-	  specified M-PHYs.
-
-config PHY_MTK_XSPHY
-	bool "MediaTek XS-PHY Driver"
-	depends on PHY
-	depends on ARCH_MEDIATEK
-	select REGMAP
-	select SYSCON
-	help
-	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
-	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
-	  multiple USB2.0, USB3.1 GEN2 ports.
-
 config PHY_NPCM_USB
 	bool "Nuvoton NPCM USB PHY support"
 	depends on PHY
@@ -364,6 +319,7 @@ config PHY_XILINX_ZYNQMP
 	  that is part of ZynqMP SoC.
 
 source "drivers/phy/cadence/Kconfig"
+source "drivers/phy/mediatek/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 02f8b495ea0..ed0279e47f2 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -6,6 +6,7 @@
 obj-y += allwinner/
 obj-y += cadence/
 obj-y += marvell/
+obj-y += mediatek/
 obj-y += qcom/
 obj-y += renesas/
 obj-y += rockchip/
@@ -42,10 +43,6 @@ obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
 obj-$(CONFIG_PHY_AXIADO_EMMC) += phy-axiado-emmc.o
 obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
-obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
-obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
-obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
-obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
 obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
new file mode 100644
index 00000000000..29a46ea9350
--- /dev/null
+++ b/drivers/phy/mediatek/Kconfig
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config PHY_MTK_HDMI
+	bool "MediaTek HDMI-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	depends on ARM64
+	depends on CLK
+	help
+	  Support for the HDMI TX PHY found on MediaTek SoCs such as the
+	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
+	  clock PLL to the HDMI TX controller.
+
+config PHY_MTK_TPHY
+	bool "MediaTek T-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK || SOC_MT7621
+	select REGMAP
+	select SYSCON
+	help
+	  MediaTek T-PHY driver supports usb2.0, usb3.0 ports, PCIe and
+	  SATA, and meanwhile supports two version T-PHY which have
+	  different banks layout, the T-PHY with shared banks between
+	  multi-ports is first version, otherwise is second veriosn,
+	  so you can easily distinguish them by banks layout.
+
+config PHY_MTK_UFS
+	bool "MediaTek UFS M-PHY driver"
+	depends on ARCH_MEDIATEK
+	depends on PHY
+	help
+	  Support for UFS M-PHY on MediaTek chipsets.
+	  Enable this to provide vendor-specific probing,
+	  initialization, power on and power off flow of
+	  specified M-PHYs.
+
+config PHY_MTK_XSPHY
+	bool "MediaTek XS-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	select REGMAP
+	select SYSCON
+	help
+	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
+	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
+	  multiple USB2.0, USB3.1 GEN2 ports.
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
new file mode 100644
index 00000000000..00ab10a238e
--- /dev/null
+++ b/drivers/phy/mediatek/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
+obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
+obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
+obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
diff --git a/drivers/phy/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi-mt8195.c
rename to drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
diff --git a/drivers/phy/phy-mtk-hdmi-mt8195.h b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi-mt8195.h
rename to drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
diff --git a/drivers/phy/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi.c
rename to drivers/phy/mediatek/phy-mtk-hdmi.c
diff --git a/drivers/phy/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi.h
rename to drivers/phy/mediatek/phy-mtk-hdmi.h
diff --git a/drivers/phy/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
similarity index 100%
rename from drivers/phy/phy-mtk-io.h
rename to drivers/phy/mediatek/phy-mtk-io.h
diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
similarity index 100%
rename from drivers/phy/phy-mtk-tphy.c
rename to drivers/phy/mediatek/phy-mtk-tphy.c
diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
similarity index 100%
rename from drivers/phy/phy-mtk-ufs.c
rename to drivers/phy/mediatek/phy-mtk-ufs.c
diff --git a/drivers/phy/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
similarity index 100%
rename from drivers/phy/phy-mtk-xsphy.c
rename to drivers/phy/mediatek/phy-mtk-xsphy.c

-- 
2.55.0

