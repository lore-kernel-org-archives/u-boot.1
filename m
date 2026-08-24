Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D199FC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 23:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108FE60680;
	Mon, 24 Aug 2026 23:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0B4ybfFsRrj; Mon, 24 Aug 2026 23:09:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787612949;
	bh=5hdcyyZUF34BG5Bn4PMAAT9WqLVTBCgX5Tc6sC31g2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qT1CNrPMnEq87TAQaU3crLZzix5d2dECLfpHXM0Pf3jW95zoQ/HcJ9j8yeMa3r7f6
	 tzBTd97EnM9GSThI1yZT3BRJgLftCzT31ozYoslAVLHbB+AQeCNapZqplDX/GgwUaI
	 jZ6WJCynkNqTBR5oTT0nu1UjG8KlxbVcLa+gOSnRy/IY6QrB8oOZx0CcJ0zMgP5Av6
	 9eiSHgZOHBj25yyFdhHE+iHVKvh0Eg3N3Z3en+B1mXf3VQB7y1l3/ysC844Q0kHOFZ
	 d8ugdWkYXlvan7x7f1J/MK7hNt8u0umSTrzkzT9CzzXq2AlnZLLv0oPWyFZYXm1+vU
	 sQHOZ7zzkvfzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7BD160667;
	Mon, 24 Aug 2026 23:09:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1057C279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E230580B40
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7vEAbZ_3vlh for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 23:09:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LB6DD5Mz
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2E8E80B3C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:09:05 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso294407a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787612945; x=1788217745;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hdcyyZUF34BG5Bn4PMAAT9WqLVTBCgX5Tc6sC31g2c=;
 b=LB6DD5Mzvp5yaBhrqAn7GjClqTgjIJS+o7aClHs16PkpZPmXlYgKm4+tXtVsKBOTmP
 xwON0UaIX+8zv2ZpnCjlM1pae0NQGts2Oz3FXHDH+y/4VNyNSypkYWhuZmHSEdsS9ILd
 I2s93o77/uXimSZyzsVV+hCONdOQOvrp/qJ3oalF57DsNRFS5vN1iU8+ZSTGeatTEqS5
 /SK/op30Txb7MAoMbv3P408wN1UIInDjvemuNIWicjG3OHLQK6HRucNkYckd6llURpQ7
 OoBv7d14Ryzd8KqHwmENK/JySKGhsE2uJzv8ja8Dl+VKdY7a1h+nqf/EHENJ4RI/wRSP
 AxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787612945; x=1788217745;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5hdcyyZUF34BG5Bn4PMAAT9WqLVTBCgX5Tc6sC31g2c=;
 b=IWV8+NdFmknwrgmRs5EQarD+mIpHuOSVM05j8Od0nsY3UN3JbVCO5hwzsvA9nOKPoF
 COMF86Wb+PPA/HHVVEcN3h81gT+qboBl2zwIETwy+FXtCDwxYQzl7x/pEWl61N3qS1Nt
 UrbOQiC2Rl+DVhnonq7i2zev0M3bFN8AHEnU/o8YRqVg93cUROpGkQG2EX5/F+LntbMu
 BvrNpjq65UG2M4gHzUg1Y9P0SMImR/Irmbtu3ip1oxl5MDhGkpG4NQjjgRFTDmSRw8eA
 TZ68LJMZ8s7mBWDKp+P8MoF/9bUDFUiU7IbzrqeUbnXMsmmc8O3gX1S2xczbxfu4V10m
 TgYQ==
X-Gm-Message-State: AFuF++kZ9Im+vDU0C2UhGETqGLoubqr2mDdR3A16e0h09mWeyjm1CHhj
 1A8GkaF/38R30xJwS2urYcrFsUzk9BvXVCuwALn763AsHfLavvL7hzW1qfwZXme2vTSdDaqHXpX
 AsTweWpM=
X-Gm-Gg: AR+sD11M+Odgl1mtciV43F8whv1sN6Ieu462tcg8fXifnDbNWnJKekP2gbKde6JfUVC
 s5zzXf2VjS3kM800O8G3kn3g0/+yjcyS+w8uNUq2eVu+qMLd3SiWFGfbdhOH5E1DECBDSTpVMuC
 tOpxa90GaIKJ2TEl3NN8JvTxqEk5NhcHKpEBB2sePBOIV9NygEa2KA+DH4wfHKnsWwH1vJac3pj
 GqFn3GuiT51m1G4IYSBa2qJEVPMduOlzQ/2GVUH113380Ip0uoxSzCu46Y/INQOdzR1IE11P88t
 fbOzy60hpJ8667IYEFlDRQo+w0/RyBFn1qcgIQsMmbhnrfn/4kJH0tNUGqPuGtMkyChEkTI488A
 VlzPnfdVf4IexQ1aNcrYbARf7zN6eh5j5lyLgg9ZLfPOFY/P0WaIfMdUrVRnHylhQkpuaYZKL90
 zDpY16cs/JplIRKnr/a94QMd8AyY47pfyJghst/dhQ2rgNdpKTgAeQH6Wr9FuV6toRJQ==
X-Received: by 2002:a05:6830:2e15:b0:7e9:d34a:f436 with SMTP id
 46e09a7af769-7f4aeea3548mr1473425a34.17.1787612944937; 
 Mon, 24 Aug 2026 16:09:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fae8df0sm5535597a34.5.2026.08.24.16.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 16:09:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
References: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
Subject: Re: [PATCH 0/3] net: mediatek: add mt8366 support
Message-Id: <178761293351.2485046.12519137317406616221.b4-ty@b4>
Date: Mon, 24 Aug 2026 18:08:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=m2jXe6jBowiKz8nqRgFVklAJ8Py+NVgpXdTE58Bd9Fk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjM8HBfOoM4nF8ilNAh+U3v8NcyryywqMTxCYj
 6rC76OAJTiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozPBxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ANG8H/jP4CGhXVXaujn0mMgGEFaOkuNzXuyGyeQCHPn+
 lxIhfnvxVonvFp+QidSDP8AgPyTsacQ5AAwxpcUmaXfknM6Ub3Ga8aOILIFQbUU1BM96/a5BgvD
 fgMki3xIuQ6k1l2R4m+2bRjQhVbrUjo6RsJ5DFlQMwW2YxRYZPzJ1BjfJ1FhiXQJ0JDz2ZaA0OV
 hSsldlgkyl2PVNLz87dIFmTXkYjREzosYIksqu+IfrvckaGtfRMEIe6L2uXx+rO27ct3esZlIAH
 Z2+ITsM5nr45BvN08Ju+reQiggAbb5e6e2mUUO+TyvEXZfpUYDtqwHxCS2Yt0nxEDYdSBOQA7h0
 JEPk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 06 Aug 2026 11:14:58 -0500, David Lechner wrote:
> net: mediatek: add mt8366 support
> 
> In order to support MT8366 (Genio 360 EVK), we need to add a new
> compatible string match since there are a few registers at a different
> offset on this target.
> 
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/3] net: dwc_eth_qos_mtk: support platform-specific PERI_ETH_BASE
      commit: 04845af8b08ea651359a4ff3137d59f3f2384794
[2/3] net: dwc_eth_qos_mtk: add mt8366 support
      commit: 66e793bc93738d32e9dd20bab37f5020724a4940
[3/3] net: dwc_eth_qos: add mt8366 support
      commit: 34b86a6741e7cd7ec83c9926bd8a81ddb3206079

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

