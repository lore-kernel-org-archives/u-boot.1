Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C250CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE31E40949;
	Fri,  9 Oct 2026 16:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qugt7rg6dF_T; Fri,  9 Oct 2026 16:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B7CA40962
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562567;
	b=Ngz51KaQgwGWlcRVitFB6RbTGW7lBh55zOlDxgfBgRRISmvddNIWeK7N7JcmFozjiBkk
	 e7+O7j6MElugfGwTnqyvCEU6tm5iYj3F+zFQlBRJkRgLPYgudflRSiDMtT/CiDcod+4gm
	 cAtZbtNgEiOzI3vuIp8CV9qDra/IQ8OeOfNbEg57UPC+KDrB3tn/SQrxpyyTjyqqpGQbX
	 3FSeOkm1j2N55YLarwkgVNbRS4UGglASN6dSq+9ACysQPGw/9mojHDFnHfT85tMeCZD0m
	 7c6dZ0a6zBOxwUeDLuAwMaFDoXSyAaxoNkZrhXAJ584bR6nGaIrU8lSfv03pIdm4dUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iYnA9cd+BNVL3uo5oAvJecHbToSn1H/LBv2imjSxkLc=;
	b=CZVSTqgMOOc9U5f3FDcGi8JN3tUdGtIOeQ84NKPwZhxMqJnCd0oEhoRxPCBqWSW1ybhV
	 x5n0iR4z5bmms1FNZNn1XS1dQ21BSFTeODcHQJa7AxMV6BquM44lFVx9LfaP05TErcRhD
	 oo/9xJTv0NAf6l/cMm0B5aNAYrmxmVdj/xQjJidfG+9nCYwUS6NLkcDsdXAW9nCjWNEHy
	 Uakg4K2eqyOIQFbwrWLHwJSCfZB21N4i2XGl/TNAj9c0PFzQJR6myyL/UBam0/6TPzx/I
	 +oSSEEfFaO7eB4yIM9sW8Fgex3G0zJCIXuBCwv6OCuoD2bJ/QM8oGNMdGh7B2UcPeXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562567;
	bh=iYnA9cd+BNVL3uo5oAvJecHbToSn1H/LBv2imjSxkLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rb74BX4xkhTxppf5+4UZFucQr3/gQhl70GsL+ubdCXhxU1UNc2a8Q0mbCcJF+Qm05
	 8hqCBR4TjFlo2RuWZsvm2UVan6zr30vl+hyP+sd+8U6+UcQmR23MIulNuU4F5Jbcve
	 Y6tml+Lf7JxodDj3hhifVtJ9wtfLot9+DXkEiQEOJfpuD2FBOQDbuZWHBzp6/8oWyn
	 a3C2bDJwWmRunHM0K7iyw00AJQcbG+QEv6VFFdzX1WVJooxhEf3C8CTDbGkdD4VLTS
	 +N0T7w6i+hZAsNnOCasnLqnrezpM3M9Sjpk2W8DIbk9IAEXWkY0yeCAd9i9rzrc6zv
	 yGma1gMfBKknA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B7CA40962;
	Fri,  9 Oct 2026 16:16:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C184F75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3E1A40102
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BaE9x4D78zq8 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 51CC940050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562562;
 b=WTMzZW87kxCdDsj+G5Uo9yGrnMHCgJEmPVjmZArbV6f2owAzkMi3LUAOx6qTj0K2eAzH
 xW1FGR/CsFZgKVMJVSpJoLWhSBRIcI0owkS1KJuGSVGKotxLQ5p8Nv2KiJW3gSXyfUhr7
 N2GSB1OImmPJ1VWd4bX2HA6y5oUDFUOCRfGypbfmkkZZ2KCp67pGjlKnEjsWbC0Qqn53u
 rvEvUhXZzL4xrZQwUvEPDctPaHWFyx6sf3o+yV+8LPJQS/81sak0dLi3e8YLnFXqYUSlD
 Bj2VzmEaMa4n7kfGhN0e5ZsKXGsjx7dMR0169+s9wBTsaSp11Y3foG8I1FNAA7c/kBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562562;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=iYnA9cd+BNVL3uo5oAvJecHbToSn1H/LBv2imjSxkLc=;
 b=j7/OWAbB/nU+ujiiFpkPLOQ6Y90GPvEk4YiKEBwitbj61zeJ7ySK3bo7Jkfc3qgz7Bf8
 uZ+Yf8xiku6Yw3RFTovn/nUcZxSeafdGb1rOQK9XE+OLUGbAMWREOwGcgf3JdlLTokN39
 Nx+BIfWff6wYjxqOZ7dAxez1gDZ21MzfvMq34FBhTGM2d4zaOtpN8n0BQYR4ULnQDAcet
 NC8pNKx1aeWsSc33ffvT9ITmfZ1QwCVc5kZJ09wUzhyJGojQjA2rsZnrufkew00qIru/P
 4DLoc3w7gYxsxhlVA1INNcUHrL7mBmSC6ULGhNNl4zpWBAkL9QCwBUrP7cN96UqqIbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DAQqEqkB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DAQqEqkB
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51CC940050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4f699fe49b3so2607483b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562561; x=1792167361;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iYnA9cd+BNVL3uo5oAvJecHbToSn1H/LBv2imjSxkLc=;
 b=DAQqEqkBIKgO9q+1qLY8cNkiVcuGgtxFxkaM9ZYg4jx4HgQ8rGFb/hlfwRchg/0Hgi
 CXxW0uw1EEOCaClJse3w4nsVb3G1yd+wMb6UiyPYFODS4pDK2R7wACNGgZ35hNVbppqC
 KGwxfRQOI7dHTDwG3fiKJv8VXAQSraHzwvO77Yw00EFh9YIWcLac1bgNH4HU/FKQmm5J
 szQFRnvG4RExZ4Q1PX4wsToPnYekRMBBMLH46+WFq5UY95SAaMPl5etYp4wpzM3fPQ4J
 n3W+82XWbey51809f14vGMCI2RcGVcUdrqTPrJ1QQlwm+hnf9ESJ4KYFf7qJzj6aImgl
 Xf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562561; x=1792167361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iYnA9cd+BNVL3uo5oAvJecHbToSn1H/LBv2imjSxkLc=;
 b=dxoFsz8qLrZYV49A8Qvv6vNf109Go2qr5FCz0KrSThja0blUlgXGTm/VGnDi5QfeSB
 tSREpDvSS+eMYfQuLSqDWELfECUi4/i/B2tqZ4u/R29qeo4WyZQ8SrN6XVuMTzyex7kp
 KPZ/N8wTKle1+PU4XNgmpBlSOV6Uh4aEz94edimdFSEmNh1SaK6K0+Itaf3HCg5Jh3s3
 INBUVJrzAuZFQawo7SsSaxpLRCMhRpBWzOZ/3ywRoQZJI0qQy6gupWH1jqlRhOS7MuYA
 a08Ox3il2WjPLt3ycc7CMI1WSKDwkF3zQWN6+0TpOUX+5jQLB14loNJwZHZUop1XymFK
 hdQQ==
X-Gm-Message-State: AFuF++kLYITrcUSF1w4DxcJJked1nJKEc0aId/pLqc/VAzn0aI94Gi7D
 B7euyZfD45OCsEnzSFgSMPClA44JaDex1cU8F0vlnYolZIgsFdUvrWKCoirOLSOi4LurT7Dq77E
 ynWiC
X-Gm-Gg: AYBFou0Y+6MYnIH9zs5z9m8ny/1mgc9oVqPyYKoRXhavkKfLPGDNzONLHimgqlsAsSK
 giBOIPlk8+iqHXGbceRo66Th6jtUkgIsckqlhbloe8oKbwoGafiVstwjhMNjVcAivOlUDRmCTcT
 /EYSKwDZQwcz2ccjg2eWgLUHGXfbFRfZW7blvPNmKd1V8ULGx+zqqeSp8viugDZHaVylzY9BvSy
 4p8P6J82Q5J1knOX2A1wVYQg+X0zkPDeqVXEnBltKnyPXyPnX1OibAqxtnSee1ld7jN0B7sXw7U
 pqno/CNbe0EE0FpVdVf7k+MzyLIcSnL4KL7x8NWIB7Fh2e1OUhNSAIkwmqPjF/LJ5rWITVJ+wPF
 3YoCLyj54bcxSMp+TRCM1CBvwKhbUwuyRYbFRW6C5SSZO+QOFvtmi0gn+991utRmTB14+PNls7b
 wO2d2J3uKFuDOcSUK6b7/dwrqN1FM64PLJ3+TShcLpPDb/U4JjswKdKJLcVE8ntT8gCuM9cgH6K
 EVvL+/6CWzHGA==
X-Received: by 2002:a05:6808:c1f3:b0:4a3:3108:866a with SMTP id
 5614622812f47-50c4e1a6e4dmr2158070b6e.17.1791562560825; 
 Fri, 09 Oct 2026 09:16:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:10 -0500
Subject: [PATCH 07/13] video: mediatek: add a DVO driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-7-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18001;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=jkUIdw1KHa+7Lx9Yy+M0o4vFiLnrb1Zr4KiWJWr3FZY=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRMAltym2AwOeX6EenWG7FjAbEufLuxzy7TrF
 YVkpHQ4WCWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskTABYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyXsH/0VUOd79pToZ+MnP7kd3/9JLflFHcMktDmoMM5J
 IDQEVNbMGeg3EWyFGsNNhJjjGPion/rGaSq6tkvN1JxGqnbo3qLvrUgPFtKkiqXNZUvZHmd5uv/
 LK3uPFbg8Tibba/j73EYpoqeJ4Sw76Ve0HrEtwc81A6d2fwMg1P0XIybQqWYIPNPmgttNJ6r4Hv
 jh6YjBB0DL37eZmBMPTOEFyw5999b1E1gQkhQHceBFk+CSnzpS73K8D7Pm0i5xsJsEO883UvOz6
 bfPMsxTzpB+2uZHr99v3HZtcjzGg9gzUwi5xlm5i/Xpditq7eGlgBLY+P1gPhT7ac5ijyUH8bHu
 hyaY=
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

Add a MISC uclass driver for the DVO, the display controller's output
stage on MT8189, which replaces the DPI/DP_INTF block used by earlier
SoCs. It takes the pixel stream from the vdosys0 data path and drives
the attached transmitter with video timing. The driver exports the
configure and enable entry points the driver of that transmitter needs.
The block moves four pixels per iteration, so both the horizontal
timings and the pixel clock are divided by that before they are
programmed.

The register programming and the display buffer watermark calculation
are based on the DVO support in the in-flight Linux series "drm/mediatek:
Add support for MediaTek Digital Video Output (DVO)". Linux programs a
fixed per-mode table and then overwrites it with the calculation, so
only the calculation is kept here. Its fill rate is taken from the
engine clock, which paces the data path writing into the buffer, where
Linux uses the pixel clock. Only the SODI pair is programmed; the other
watermarks are left at their reset values.

The driver has no Kconfig prompt of its own: it is useless without a
transmitter behind it, so the driver of that transmitter selects it.

It is the device that holds the display power domain for the whole
vdosys0 front end, so it is marked DM_FLAG_OS_PREPARE to have DM power
that domain off before the OS starts, as the DSI driver does for the
DSI path.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/video/mediatek/Kconfig   |   6 +
 drivers/video/mediatek/Makefile  |   2 +
 drivers/video/mediatek/mtk_dvo.c | 417 +++++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_dvo.h |  33 ++++
 4 files changed, 458 insertions(+)

diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
index 346d02e9c02..88cf3d11b2e 100644
--- a/drivers/video/mediatek/Kconfig
+++ b/drivers/video/mediatek/Kconfig
@@ -34,6 +34,12 @@ config VIDEO_MEDIATEK_DSI
 	  pipeline (overlay, RDMA and, on the SoCs having one, the colour
 	  pipeline) to scan out the U-Boot framebuffer to a DSI panel.
 
+# DVO output stage, the eDP path's replacement for the DPI/DP_INTF block
+config VIDEO_MEDIATEK_DVO
+	bool
+	select MISC
+	select VIDEO_MEDIATEK_DISP_COMP
+
 config VIDEO_MEDIATEK_HDMI
 	bool "Video HDMI Support for MediaTek SoCs"
 	depends on VIDEO && ARCH_MEDIATEK
diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
index 9de9a9c78f1..ee3d7eed618 100644
--- a/drivers/video/mediatek/Makefile
+++ b/drivers/video/mediatek/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_VIDEO_MEDIATEK_DISP_PIPELINE) += mtk_ddp.o \
 
 obj-$(CONFIG_VIDEO_MEDIATEK_DPI) += mtk_dpi.o
 
+obj-$(CONFIG_VIDEO_MEDIATEK_DVO) += mtk_dvo.o
+
 obj-$(CONFIG_VIDEO_MEDIATEK_DSI) += mtk_disp_aal.o \
 				    mtk_disp_ccorr.o \
 				    mtk_disp_color.o \
diff --git a/drivers/video/mediatek/mtk_dvo.c b/drivers/video/mediatek/mtk_dvo.c
new file mode 100644
index 00000000000..5ec683af15b
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dvo.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek MT8189 Digital Video Output (DVO) support
+ *
+ * DVO is the display controller's output stage on MT8189, replacing the
+ * DPI/DP_INTF block used by earlier SoCs. It takes the pixel stream from
+ * the display data path and drives the eDP transmitter with video timing.
+ *
+ * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ * Copyright (c) 2026 BayLibre, SAS.
+ *                    David Lechner <dlechner@baylibre.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/stddef.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_dvo.h"
+
+#define DVO_EN				0x00
+#define EN					BIT(0)
+
+#define DVO_RET				0x04
+#define SWRST					BIT(0)
+
+#define DVO_OUTPUT_SET			0x18
+#define OUT_NP_SEL				GENMASK(1, 0)
+#define CH_SWAP					GENMASK(7, 5)
+#define SWAP_RGB				0
+#define HS_INV					BIT(20)
+#define VS_INV					BIT(21)
+
+#define DVO_SRC_SIZE			0x20
+#define SRC_HSIZE				GENMASK(15, 0)
+#define SRC_VSIZE				GENMASK(31, 16)
+
+#define DVO_PIC_SIZE			0x24
+#define PIC_HSIZE				GENMASK(15, 0)
+#define PIC_VSIZE				GENMASK(31, 16)
+
+#define DVO_TGEN_H0			0x50
+#define HFP					GENMASK(15, 0)
+#define HSYNC					GENMASK(31, 16)
+
+#define DVO_TGEN_H1			0x54
+#define HSYNC2ACT				GENMASK(15, 0)
+#define HACT					GENMASK(31, 16)
+
+#define DVO_TGEN_V0			0x58
+#define VFP					GENMASK(15, 0)
+#define VSYNC					GENMASK(31, 16)
+
+#define DVO_TGEN_V1			0x5c
+#define VSYNC2ACT				GENMASK(15, 0)
+#define VACT					GENMASK(31, 16)
+
+#define DVO_TGEN_V_LAST_TRAILING_BLANK	0x6c
+#define V_LAST_TRAILING_BLANK			GENMASK(15, 0)
+
+#define DVO_TGEN_OUTPUT_DELAY_LINE	0x7c
+#define EXT_TG_DLY_LINE				GENMASK(15, 0)
+
+#define DVO_TGEN_INFOQ_LATENCY		0x80
+#define INFOQ_START_LATENCY			GENMASK(15, 0)
+#define INFOQ_END_LATENCY			GENMASK(31, 16)
+
+#define DVO_SHADOW_CTRL			0x190
+#define FORCE_COMMIT				BIT(0)
+#define BYPASS_SHADOW				BIT(1)
+
+#define DVO_BUF_CON0			0x220
+#define DISP_BUF_EN				BIT(0)
+#define FIFO_UNDERFLOW_DONE_BLOCK		BIT(4)
+
+#define DVO_BUF_SODI_HIGH		0x230
+#define DVO_BUF_SODI_LOW		0x234
+#define DVO_DISP_BUF				GENMASK(31, 0)
+
+/* Output one iteration of four pixels; OUT_NP_SEL encodes 1T1P/1T2P/1T4P. */
+#define MTK_DVO_PIXELS_PER_ITER		4
+#define MTK_DVO_OUT_PIXITER_1T4P	2
+
+/* The display data path feeds DVO two pixels per iteration. */
+#define MTK_DVO_INPUT_MODE		2
+#define MTK_DVO_OUTPUT_MODE		4
+
+/* 1 unit = 2 group data = 2 * 1T4P = 8 pixels */
+#define MTK_DISP_BUF_SRAM_UNIT_SIZE	8
+#define MTK_DISP_LINE_BUF_DVO_US	40
+#define MTK_DVO_EDP_MAX_CLK		297
+/* Fallback when the engine clock cannot be read, in MHz */
+#define MTK_DVO_DEFAULT_MMSYS_MHZ	273
+#define MTK_DVO_MAX_HACTIVE		3840
+#define MTK_DVO_LINE_BUFFER_SIZE	(MTK_DVO_MAX_HACTIVE / MTK_DISP_BUF_SRAM_UNIT_SIZE)
+#define MTK_DVO_BITS_PER_CYCLE		(8 * 32 * 1000000)
+
+/* SODI watermark thresholds, in microseconds of buffered data */
+#define TWAKE_UP			5
+#define ULTRA_LOW_US			23
+
+struct mtk_dvo_priv {
+	/*
+	 * Must stay first: mtk_disp_comp_*() are handed this device and cast
+	 * dev_get_priv() straight to struct mtk_disp_comp_priv, and the eDP
+	 * driver calls them on the DVO across the driver boundary.
+	 */
+	struct mtk_disp_comp_priv comp;
+	struct clk *engine_clk;
+	struct clk *pixel_clk;
+	struct clk *pll_clk;
+};
+
+/*
+ * Keep the PLL in the range it is happy at by running it at a multiple of
+ * the pixel rate for the slower modes. Thresholds are in kHz.
+ */
+static u32 mtk_dvo_calculate_factor(u32 clock_khz)
+{
+	if (clock_khz < 70000)
+		return 4;
+	if (clock_khz < 200000)
+		return 2;
+
+	return 1;
+}
+
+static void mtk_dvo_sw_reset(struct udevice *dev, bool reset)
+{
+	mtk_disp_comp_update(dev, DVO_RET, reset ? SWRST : 0, SWRST);
+}
+
+void mtk_dvo_hw_enable(struct udevice *dev)
+{
+	mtk_disp_comp_update(dev, DVO_EN, EN, EN);
+}
+
+/*
+ * Program the display buffer watermarks from the rate the buffer fills at
+ * (the display data path writing into it) against the rate DVO drains it at
+ * (the pixel stream leaving for the eDP transmitter), so that the memory
+ * subsystem is asked to step up before the FIFO can run dry.
+ */
+static void mtk_dvo_sodi_setting(struct udevice *dev,
+				 const struct display_timing *timing)
+{
+	const u64 sodi_total = (u64)MTK_DVO_BITS_PER_CYCLE *
+			       MTK_DISP_BUF_SRAM_UNIT_SIZE * 32;
+	struct mtk_dvo_priv *priv = dev_get_priv(dev);
+	u64 sodi_high, sodi_low, sodi_high_rem, sodi_low_rem, tmp;
+	u64 dvo_fifo_size, fifo_size, total_bit;
+	u64 consume_rate, consume_rate_rem;
+	u64 fill_rate, fill_rate_rem;
+	u64 data_rate;
+	u32 mmsys_clk;
+	ulong rate;
+
+	/*
+	 * The fill rate below is how fast the display data path writes into
+	 * the DVO FIFO, so it is paced by the engine clock rather than by the
+	 * pixel rate the FIFO is drained at.
+	 */
+	rate = clk_get_rate(priv->engine_clk);
+	if (IS_ERR_VALUE(rate) || !rate) {
+		dev_warn(dev, "no engine clock rate, assuming %u MHz\n",
+			 MTK_DVO_DEFAULT_MMSYS_MHZ);
+		mmsys_clk = MTK_DVO_DEFAULT_MMSYS_MHZ;
+	} else {
+		mmsys_clk = rate / 1000000;
+	}
+
+	fill_rate = div64_u64_rem((u64)mmsys_clk * MTK_DVO_INPUT_MODE * 30,
+				  32ULL * MTK_DISP_BUF_SRAM_UNIT_SIZE,
+				  &fill_rate_rem);
+
+	data_rate = div64_u64((u64)timing->hactive.typ * timing->vactive.typ *
+			      timing->pixelclock.typ,
+			      (u64)(timing->hactive.typ + timing->hfront_porch.typ +
+				    timing->hsync_len.typ + timing->hback_porch.typ) *
+			      (timing->vactive.typ + timing->vfront_porch.typ +
+			       timing->vsync_len.typ + timing->vback_porch.typ));
+
+	consume_rate = div64_u64_rem(data_rate * 30 * 5 / 4,
+				     MTK_DVO_BITS_PER_CYCLE, &consume_rate_rem);
+
+	total_bit = (u64)MTK_DVO_EDP_MAX_CLK * MTK_DVO_OUTPUT_MODE * 30 *
+		    MTK_DISP_LINE_BUF_DVO_US;
+	fifo_size = total_bit / (MTK_DISP_BUF_SRAM_UNIT_SIZE * 30);
+
+	/* DVO supports MSO mode, so calculate with three line buffers */
+	dvo_fifo_size = fifo_size + 3 * MTK_DVO_LINE_BUFFER_SIZE;
+
+	sodi_high_rem = fill_rate_rem * MTK_DVO_BITS_PER_CYCLE;
+	tmp = consume_rate_rem * (32 * MTK_DISP_BUF_SRAM_UNIT_SIZE);
+
+	if (sodi_high_rem < tmp) {
+		fill_rate -= 1;
+		sodi_high_rem += sodi_total;
+	}
+	sodi_high_rem -= tmp;
+	sodi_high_rem *= 32 * 6;
+	sodi_high_rem = div64_u64(sodi_high_rem, sodi_total);
+
+	sodi_high = (dvo_fifo_size * 30 * 5 - 32 * 6 * (fill_rate - consume_rate) -
+		     sodi_high_rem + (5 * 32 - 1)) / (5 * 32);
+
+	sodi_low_rem = DIV_ROUND_UP_ULL(consume_rate_rem * (ULTRA_LOW_US + TWAKE_UP),
+					MTK_DVO_BITS_PER_CYCLE);
+	sodi_low = consume_rate * (ULTRA_LOW_US + TWAKE_UP) + sodi_low_rem;
+
+	mtk_disp_comp_update(dev, DVO_BUF_SODI_HIGH, sodi_high, DVO_DISP_BUF);
+	mtk_disp_comp_update(dev, DVO_BUF_SODI_LOW, sodi_low, DVO_DISP_BUF);
+}
+
+int mtk_dvo_config(struct udevice *dev, const struct display_timing *timing)
+{
+	struct mtk_dvo_priv *priv = dev_get_priv(dev);
+	u32 hsync_len, hfront_porch, hback_porch, hactive;
+	u32 vsync_len = timing->vsync_len.typ;
+	u32 vback_porch = timing->vback_porch.typ;
+	u32 vactive = timing->vactive.typ;
+	u32 dvo_clk;
+	u32 factor;
+	ulong rate;
+	u32 pol = 0;
+
+	/*
+	 * The watermark maths divides by the frame's totals and the PLL
+	 * request scales the pixel clock, so a degenerate mode has to be
+	 * rejected here rather than producing a silent divide by zero.
+	 */
+	if (!timing->pixelclock.typ || !timing->hactive.typ ||
+	    !timing->vactive.typ) {
+		dev_err(dev, "invalid timing\n");
+		return -EINVAL;
+	}
+
+	if (timing->flags & DISPLAY_FLAGS_INTERLACED) {
+		dev_err(dev, "interlaced modes are not supported\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Retune this output's own PLL first: the EDP_SEL mux downstream only
+	 * selects between its inputs, so the rate has to exist before we can
+	 * ask for it.
+	 */
+	factor = mtk_dvo_calculate_factor(timing->pixelclock.typ / 1000);
+
+	rate = clk_set_rate(priv->pll_clk, (ulong)timing->pixelclock.typ * factor);
+	if (IS_ERR_VALUE(rate)) {
+		dev_err(dev, "failed to set pll: %ld\n", (long)rate);
+		return (int)rate;
+	}
+
+	/* clocked once per iteration, see the horizontal timings below */
+	rate = clk_get_rate(priv->pll_clk);
+	if (IS_ERR_VALUE(rate) || !rate) {
+		dev_err(dev, "cannot read back the pll rate: %ld\n", (long)rate);
+		return IS_ERR_VALUE(rate) ? (int)rate : -EINVAL;
+	}
+
+	dvo_clk = rate / factor / MTK_DVO_PIXELS_PER_ITER;
+
+	rate = clk_set_rate(priv->pixel_clk, dvo_clk);
+	if (IS_ERR_VALUE(rate)) {
+		dev_err(dev, "failed to set pixel clock: %ld\n", (long)rate);
+		return (int)rate;
+	}
+
+	/*
+	 * DVO moves MTK_DVO_PIXELS_PER_ITER pixels per iteration, so the
+	 * horizontal timings are counted in iterations rather than pixels.
+	 */
+	hsync_len = timing->hsync_len.typ / MTK_DVO_PIXELS_PER_ITER;
+	hfront_porch = timing->hfront_porch.typ / MTK_DVO_PIXELS_PER_ITER;
+	hback_porch = timing->hback_porch.typ / MTK_DVO_PIXELS_PER_ITER;
+	hactive = DIV_ROUND_UP(timing->hactive.typ, MTK_DVO_PIXELS_PER_ITER);
+
+	/* the HS/VS invert bits are set for an active-high sync */
+	if (timing->flags & DISPLAY_FLAGS_HSYNC_HIGH)
+		pol |= HS_INV;
+	if (timing->flags & DISPLAY_FLAGS_VSYNC_HIGH)
+		pol |= VS_INV;
+
+	mtk_dvo_sw_reset(dev, true);
+
+	mtk_disp_comp_update(dev, DVO_OUTPUT_SET, pol, HS_INV | VS_INV);
+
+	mtk_disp_comp_update(dev, DVO_TGEN_H0,
+			     FIELD_PREP(HSYNC, hsync_len) |
+			     FIELD_PREP(HFP, hfront_porch), HSYNC | HFP);
+	mtk_disp_comp_update(dev, DVO_TGEN_H1,
+			     FIELD_PREP(HSYNC2ACT, hback_porch + hsync_len),
+			     HSYNC2ACT);
+
+	mtk_disp_comp_update(dev, DVO_TGEN_V0,
+			     FIELD_PREP(VSYNC, vsync_len) |
+			     FIELD_PREP(VFP, timing->vfront_porch.typ),
+			     VSYNC | VFP);
+	mtk_disp_comp_update(dev, DVO_TGEN_V1,
+			     FIELD_PREP(VSYNC2ACT, vback_porch + vsync_len),
+			     VSYNC2ACT);
+
+	mtk_disp_comp_update(dev, DVO_SRC_SIZE,
+			     FIELD_PREP(SRC_HSIZE, timing->hactive.typ) |
+			     FIELD_PREP(SRC_VSIZE, vactive),
+			     SRC_HSIZE | SRC_VSIZE);
+	mtk_disp_comp_update(dev, DVO_PIC_SIZE,
+			     FIELD_PREP(PIC_HSIZE, timing->hactive.typ) |
+			     FIELD_PREP(PIC_VSIZE, vactive),
+			     PIC_HSIZE | PIC_VSIZE);
+	mtk_disp_comp_update(dev, DVO_TGEN_H1, FIELD_PREP(HACT, hactive), HACT);
+	mtk_disp_comp_update(dev, DVO_TGEN_V1, FIELD_PREP(VACT, vactive), VACT);
+
+	/* RGB output, so no channel swap */
+	mtk_disp_comp_update(dev, DVO_OUTPUT_SET,
+			     FIELD_PREP(CH_SWAP, SWAP_RGB), CH_SWAP);
+
+	/* start the info queue as soon as each frame does */
+	mtk_disp_comp_update(dev, DVO_TGEN_INFOQ_LATENCY, 0,
+			     INFOQ_START_LATENCY | INFOQ_END_LATENCY);
+
+	mtk_disp_comp_update(dev, DVO_BUF_CON0,
+			     DISP_BUF_EN | FIFO_UNDERFLOW_DONE_BLOCK,
+			     DISP_BUF_EN | FIFO_UNDERFLOW_DONE_BLOCK);
+
+	mtk_disp_comp_update(dev, DVO_TGEN_V_LAST_TRAILING_BLANK,
+			     FIELD_PREP(V_LAST_TRAILING_BLANK, 0x20),
+			     V_LAST_TRAILING_BLANK);
+	mtk_disp_comp_update(dev, DVO_TGEN_OUTPUT_DELAY_LINE,
+			     FIELD_PREP(EXT_TG_DLY_LINE, 0x20),
+			     EXT_TG_DLY_LINE);
+
+	mtk_dvo_sodi_setting(dev, timing);
+
+	/*
+	 * More than one pixel per iteration needs the shadow registers, so
+	 * that a whole set of timings is latched at once.
+	 */
+	mtk_disp_comp_update(dev, DVO_SHADOW_CTRL, FORCE_COMMIT,
+			     FORCE_COMMIT | BYPASS_SHADOW);
+	mtk_disp_comp_update(dev, DVO_OUTPUT_SET,
+			     FIELD_PREP(OUT_NP_SEL, MTK_DVO_OUT_PIXITER_1T4P),
+			     OUT_NP_SEL);
+
+	mtk_dvo_sw_reset(dev, false);
+
+	return 0;
+}
+
+static int mtk_dvo_probe(struct udevice *dev)
+{
+	struct mtk_dvo_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->engine_clk = devm_clk_get(dev, "engine");
+	if (IS_ERR(priv->engine_clk)) {
+		dev_err(dev, "cannot get the engine clock: %ld\n",
+			PTR_ERR(priv->engine_clk));
+		return PTR_ERR(priv->engine_clk);
+	}
+
+	priv->pixel_clk = devm_clk_get(dev, "pixel");
+	if (IS_ERR(priv->pixel_clk)) {
+		dev_err(dev, "cannot get the pixel clock: %ld\n",
+			PTR_ERR(priv->pixel_clk));
+		return PTR_ERR(priv->pixel_clk);
+	}
+
+	priv->pll_clk = devm_clk_get(dev, "pll");
+	if (IS_ERR(priv->pll_clk)) {
+		dev_err(dev, "cannot get the PLL clock: %ld\n",
+			PTR_ERR(priv->pll_clk));
+		return PTR_ERR(priv->pll_clk);
+	}
+
+	return 0;
+}
+
+static_assert(offsetof(struct mtk_dvo_priv, comp) == 0,
+	      "mtk_disp_comp_priv has to stay the first member");
+
+static const struct udevice_id mtk_dvo_ids[] = {
+	{ .compatible = "mediatek,mt8189-edp-dvo" },
+	{ }
+};
+
+/*
+ * DM_FLAG_OS_PREPARE has DM remove this device before the OS starts, which
+ * powers the display domain off and resets the whole vdosys0 front end.
+ * Handing OVL, RDMA, the mutex and an SMI larb that is still bypassing the
+ * IOMMU to the kernel leaves it unable to bring the display up, and it does
+ * not reset a block it finds already running.
+ */
+U_BOOT_DRIVER(mtk_dvo) = {
+	.name = "mtk_dvo",
+	.id = UCLASS_MISC,
+	.of_match = mtk_dvo_ids,
+	.probe = mtk_dvo_probe,
+	.priv_auto = sizeof(struct mtk_dvo_priv),
+	.flags = DM_FLAG_OS_PREPARE,
+};
diff --git a/drivers/video/mediatek/mtk_dvo.h b/drivers/video/mediatek/mtk_dvo.h
new file mode 100644
index 00000000000..f4197d037aa
--- /dev/null
+++ b/drivers/video/mediatek/mtk_dvo.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek MT8189 Digital Video Output (DVO) support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: David Lechner <dlechner@baylibre.com>
+ */
+
+#ifndef _MTK_DVO_H
+#define _MTK_DVO_H
+
+struct display_timing;
+struct udevice;
+
+/**
+ * mtk_dvo_config() - program the DVO for a display mode
+ * @dev: DVO device
+ * @timing: display timing to output
+ *
+ * Retune the pixel clock for the mode, then program the timing generator
+ * and the display buffer watermarks. The output is left disabled.
+ *
+ * Return: 0 on success, a negative error code otherwise
+ */
+int mtk_dvo_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_dvo_hw_enable() - start the DVO output
+ * @dev: DVO device
+ */
+void mtk_dvo_hw_enable(struct udevice *dev);
+
+#endif /* _MTK_DVO_H */

-- 
2.53.0

