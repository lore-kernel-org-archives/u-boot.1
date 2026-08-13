Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64B5C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32F2160A4C;
	Thu, 13 Aug 2026 15:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYsFBdYuIvrd; Thu, 13 Aug 2026 15:56:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C4A160AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636615;
	bh=gTf/8ICPP7Z+SGVrx9GoL6SjBtOiUyWf+WTOLGtglvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YsgRPo+x85jVzjwBp2W5l62DtcYwZshBv211Si1VrS2ShsZ2ZYqWZuWnSl0Vf74+T
	 1WLE4zU1Zkiq9syXzjpsSnvjfHfLruJgIyVWDJKGvbcDbf4i28csemzfX89VIVswqN
	 wiHgCaHJpx6kXFgrjl19gdK+IxCiTBOJsBAktoNvDEK8If8sqVgKae+8fJelhH642t
	 ZBV0SOufseie2Tdsd3Pj2SLPgsp56xpJ99m55akmCT+3Bd7AlqqwQhCk9kJmQTk7Pu
	 7h45Xa4nmtudWvA3a3QmEnnUmbvLbbHqP93WkMaMSL8wrR9yvOgpwoAgKFsC1NzjIY
	 xLCAttpz7TFPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C4A160AF6;
	Thu, 13 Aug 2026 15:56:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE5C8EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B03A281247
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qvG45lRXP1hC for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:56:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B3AB580E30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3AB580E30
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3AB580E30
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:52 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7ee4399c423so79062a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636611; x=1787241411;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gTf/8ICPP7Z+SGVrx9GoL6SjBtOiUyWf+WTOLGtglvs=;
 b=LFHWN7G+/B82mUMbvGxJB+A0l2jIjqWHwVZd8FSw9KjyM/okmNB51f87lumrsP776D
 2qZWl5ha0XBNR+SidR0I5b1b5VfoT44ItVuKBdTBOimdEcBdjHJefYK2IgVyz+K3aQx1
 MPUlDpjOs9SP/MFZDdNKkwf8fGmpV02b8Ue1CBvoAXNP/MUW88KpGzWM55Wn5TyiFE7M
 Ps9E6ctZoOaeJi6NrWk4hZuX+xbo155IC5uvd5F0kt5uOBO135pgh+2MRdrc8O5SfX6N
 rMBYqHMzhpVzG9j+rT05mp0d3/+PproaCd2DoOD1ksfO1vKS4NVSEn5IL/vmjk0P1kp6
 PRvQ==
X-Gm-Message-State: AOJu0YzuLLyy1s9e/GLWdIXQDtfKbEXiQnRqiCrh9wdl/6eMr2TZVZPA
 wiciunQ395l+rg5QOts2x/jjelfhPZOg71ewz1xbe986ooLPEsVsk6xW7j3Zv+N4Wc8=
X-Gm-Gg: AR+sD124vItAY7+wKmtI+OFW7xI426vdVxSoFPusM6+DJWDz0HCKhwoB5k2dcprlril
 08TVYk1yBLokQookbATau1lssn9+3rK2YBpU6efbg04fk0iSYXWGYS+BK+0KBzC1lL2vdNYT7GU
 hGkUaEw+s9bJv7908xOL2bF9unD9F09/aSWI5VrhOI3UKaLpEw9VkZo91+dK7Ke9CcewHsz5MSL
 xAZYPWnkWDXd+GKoYCAvt/mUyHnHJ/QSIhbOVD38+HAm3Sz70Ej/hW3uIflBwy1PXAXwCQRYRZS
 DPIMjtPalOwHCkXIlgLJxJCaWxyj0NO4aafvYKIJiwD6xNk7pcg7M9ES7jdASzZWio5DN1e/0I7
 JHEsQFQ923oEFcx28Mo+gdsfQiDpgUz2+A7hZb7j50Psuty1a1mnDUXrI4iB2xMSGz9xiODAXc2
 w+zRL2ILWY0DDKKp2eniWH7Re5VAoxNAtMm9XBIJpng7DxQasMoNMKrpSqEo5TO95h
X-Received: by 2002:a05:6830:2992:b0:7e6:e385:4c1e with SMTP id
 46e09a7af769-7f3ca59e06fmr6655416a34.4.1786636611112; 
 Thu, 13 Aug 2026 08:56:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3c9ca7b0bsm2391452a34.15.2026.08.13.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260728-mt8188-add-hdmi-phy-driver-v2-1-8b2893b151ba@baylibre.com>
References: <20260728-mt8188-add-hdmi-phy-driver-v2-1-8b2893b151ba@baylibre.com>
Subject: Re: [PATCH v2] phy: phy-mtk-hdmi: add new driver
Message-Id: <178663609577.2270888.11074723889068596355.b4-ty@b4>
Date: Thu, 13 Aug 2026 10:48:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=514; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=v56Grm4Z+LxALeUxwqpXBlIqaoTZDtVc19cvZBYpB/U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfek66mOUgxK973EsYju9VI7HNDfyPxCsK7xXj
 RNu3vtIqySJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3pOhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtZcH/iAH2Mx4cq8e4twHmonxcuCUmXVGmBke19euUnK
 FeCWrO2o5uxNX9HU9/3pnfBeFhGEsYsc/Cv1x01qA81taoer0V/ZpZi/QJgo8tNR/J6ieSjgj6g
 BqVh8+XWs1kjQ+kdFjz5ZyvdrPDCLu8+8qPJFw34erM4SyHfobAkTTWqtj+EyuqR+NnAelyXFUv
 6ZxvdhrksDl7dpRIij3P0hg1sAkgI1sxkIZr5tb7ImK9EcCQ8530N4iFmtLoY577TG6UE3xELpe
 ROC+THamjAprnqXusLIBBwIDo85pjtLoxZ4wvESAXF+0BjKMlgtwddufold34vikU6MXO3uTxBP
 Razs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786636611; x=1787241411;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTf/8ICPP7Z+SGVrx9GoL6SjBtOiUyWf+WTOLGtglvs=;
 b=ovXlygV/Sa3+4cX886FqbcEe855n25/X8QzkEtGMFo+JE1zGmxUQHhQglYK3EJMKsy
 fyxRQNc+KRRFJo80vrmlM8rBSeUC7GuxVNJYTxnYg5/1xd5ivyFUOxv9JhtlpDq8KWTp
 ykbwqKP6hOSegvJv9V2c4sgCGG20y53PB8GuwCCl71PPI8Wv4WD88Ui0JoVUmvdtPS6J
 AlvMi5rhCAGh+wnL5SVz7JDqDdqtpVNdX/Cta4NzaX53ZtcJpHlrnyduC2EXeuqF8+8E
 RakdPfS/rDs+DG6VQ3H//7GKVlNJuSpTrUFGM6DnvzsarmQbwtY2JsbFoz8qXe1DWsp4
 9W6A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ovXlygV/
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

On Tue, 28 Jul 2026 17:01:56 +0200, Julien Stephan wrote:
> phy: phy-mtk-hdmi: add new driver

I made a few small tweaks while applying.
* Use div64_u64() instead of div_u64() since both args are u64.
* Add a return value check for mtk_hdmi_pll_drv_setting().
* Make da_hdmitx21_ref_ck u32 instead of u64.

Applied to mediatek-for-next, thanks!

[1/1] phy: phy-mtk-hdmi: add new driver
      commit: 7e98fc167a2f3a3b94387ed9b19d5e59b4d5b643

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

