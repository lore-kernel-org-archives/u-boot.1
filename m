Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D2FCA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 215CB60815;
	Tue,  6 Oct 2026 21:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkFwGTrLVVa7; Tue,  6 Oct 2026 21:48:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5C89960871
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323302;
	b=rLqhd/ZYeKtoPOxPsB48mr/3F1iTaL4b3gEMNigXmCFPanSkMkbruS7CZn4Z1hwfue4S
	 3IQJjDifrPW17P594GAbiJuCfgTfHGzMxdiQAp6Tglsvciuf46bAju15uMgn5LFfUIK3Y
	 agnDfxabsQefDqfDBO8FGP0Hxb3N1JFa5NuswTfgRHawWSSz+a5p6/DlX3StAv4PgQNnl
	 SeW8E0DUQ2AJ9k754rpruH0Z0RbEkVYXf+i3Qh4khNVUVRa5ObEeW08zgYs1jj4tv56lQ
	 fp0O1rilfRopdIsmC+NoyoXM+UrNe4brd4gLvti3mVklPJqIlPQfI4DPaS/Si8+etaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xpqz51ZkPeHPHAPjNIw84/IsMs00sTLk1LxxyUSsPWw=;
	b=S7jUDcLh5OoUCxtCujPXcq49Wj5rF9IdCN//YixlXjA00h5nGVzanNgxlpFAxF+KdROU
	 CKD/NmMuAFtrrc+irn87qxYurSlU05JrFTsVHcVL+Hd5vX0j9YDHdrvpEadiOevSTL3UL
	 ykrAYI3FG8fIWfT2sNThSiThs9YPOwvOKC0YgB1TkIfia9q1uKkj2j8dRLdtn85HeTFjs
	 eETxB+i0FAymJ+mci/g0GDmY5FEDV7kd0sLqlw/SyYa8RbViTceTmtOpo7/5G2Rb6NRF5
	 qfYQRop9jl1CvFJ5HPSLWQVGRPrI+cLNDzqfQ3YIo/AVHGq3QHsLPSkTK8QG6N65VyA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MxKBzt9H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323302;
	bh=Xpqz51ZkPeHPHAPjNIw84/IsMs00sTLk1LxxyUSsPWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3sD34SXRRLD6jSE2Xr34Fxrb8RX9wC7s69Z/XKOJWs6/x2Fc+dLsvXZGggGxoV1g
	 eGdaWqUE2RfzTuRwarVwiikVh4X2cIiPl7PsC8H328nacS0539XTQAgRaa/gzfErjy
	 LvGb3Q4GIwXBmGhx6K2PJW8w4S4S1JzI8R0WrUr9f8LQ2IB1gXGEWKNIKdCExvTpoK
	 CgVniXBNbgONoW6RUlaNMnYKSndSgxAUjBgKn0zbz2p6WiUJcg6I9VKOrhk9Divy5u
	 fnYbzuGBbvWLnvkFSGh/eGSVgjGxoaEySkQ39+/wu0nYk2SrvEo9+YwIvDERl9PxAl
	 dL+6TOIwLSIlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C89960871;
	Tue,  6 Oct 2026 21:48:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1832432F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09817607ED
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JbishXrfXig for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C65AD607CC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322645;
 b=Vd2kd4eXjISnLvQDOT4eiqkeDxLOXhXU/7PjTNh2CddmSl3gJh8ZiDK7/2x0a7uVO6P1
 MH51aztuIhH4KF0dv8JjlI8tj+OsZnT0jWHmHIE43/b9aSurDMSWg5LbqyFnu2xmERiWA
 x0EvbRMSPyiuq7B6Bj9BZx5u1ogji+gU/JmLZ5QfBxG69UQsMF8lwpC5Wfdyh8Yec5xsq
 RKRUZyHmJH73MijW8DShp6DRLxE9hG/wwKjQdZmV9i2PN1kcyJRJBh92fOiIMlhZrd/K1
 cs5zlG/mXlStSAaC8qkWYMckopckJyKS+unL4A+u6OJIecOFJATI5FPphWIhTQ+onOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Xpqz51ZkPeHPHAPjNIw84/IsMs00sTLk1LxxyUSsPWw=;
 b=isnKaY4NtQs5l9/Yu8f+hvJFn+3gKnBod2cFOmCpTV9SHI9HQBplrjCqIRLSxE4cukrF
 niQr5rXqmPTFXN/VhrtpESqUbFcLslCemEM5FQJ5HrV/hjS1EFQit/9qg6Ujp+j3E4yti
 akdQ/4RRv4SeoTeIOi6mSInQaSZn5PaoNcXcY5Br6H4b9MQgMsjg+CC50QAWjcrAEFen6
 J1lSsh97WKcwRuBscuGWY4MOKwQL2wp8+yCoe9RK/H5tVh4wbnx8drHw6ClHtCckQBRmY
 OlQg4PRmTYVPMcKLP8lkmBSl9TQCUWTXooPVfKZzzzGEIVoviDrdzcjMAocrDHZpVNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MxKBzt9H; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MxKBzt9H
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C65AD607CC
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:24 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4e85dac114fso623215b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322643; x=1791927443;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xpqz51ZkPeHPHAPjNIw84/IsMs00sTLk1LxxyUSsPWw=;
 b=MxKBzt9H7vn/tQjC5EKFC6RbycnbD5EuzSXBq8eVmtFp/1FRAp/Lv17aqW+Y5AOZSc
 opTDoMjuFWqO36UfPA3GWa0bIXsB5Hm5+ojT/Snb42Vq5YbIcXaF7A6sJ+ZN5sz6AkgY
 TEbwOPhRsrWfYQ/BRp3hl8FFO5r3Nn1xO7NyVCUMSkpsIRPmQdC75Eu4ay/7ml+3Vlli
 FRDJq9UrhW4RA8kmAmP0rflRPXQu2swIDtbtN/IQ617BbEjfgKGN/P8CzzPXmRV0hQQg
 S2hy2YhnavDVVGgLtOW8BV9k15JZ4EHBs3ApVHOt7z0jDLnsuYPxHjTQpxERSvZJ6gO1
 WSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322643; x=1791927443;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xpqz51ZkPeHPHAPjNIw84/IsMs00sTLk1LxxyUSsPWw=;
 b=NRi/lf4ozJAr3Ws4cWjYtit0ffq1e6+shDDOOlt75MK1HrZlHAhFHq2gY5QMhvFM+Y
 GbhEJz4jhF+leWsxo9LQFNbpgJ8dIVJPUruDSo+gOYT82mpb/+Z7nwfrSLg38tDBlt+P
 O5ykwDx/dQQ3xbf4pFz8erWmx624eDsx6SC0hzAtwcHOjJuAqdq2B6Q9cQaqVUJ2dpsG
 suNY8GglbVsM0hjQsiwI3UGPahZzhpQSXpQlObNebtfMP00o/qbOUEKQCYcrAHACIKiT
 s+6Izpn+pCMGlBF58Yspzb6WVPpfz5P1mkDJvBP9q57uSwIAa3jC+KfQAfZfV9JUeNZD
 W4iA==
X-Gm-Message-State: AFuF++nPcBKPfF9d9+wzn39pyTRjGUL9G4kXH+fLLuuYHipAi95cvUEC
 ihNhHTltx8BzpeRRV6JrVHFDPgEPa/1XIUZdv2MZ6jV0YysrzETMYu4vuK10EoVF+YCjIh3K98p
 2TDuu
X-Gm-Gg: AYBFou392R9czGzMerg6HOCcATr30zWJbzT3XA/BqrlxyCXvOTCQFjUJqwiIrLkDKRl
 gmVFw7mxiywPXnmqbSt42MBPzSAPZf6bjVtKD7rUGdODoCv9xEmmN37MOJTED7uZo1pcvey0uI2
 HOMYd5bwrKQO83mco8abf3N0aQJjRVSrVPO45C4xOwlMGSdLdRjUVlXwkqMhCrXN5Cm5emZyBPX
 0KREO45gTnwWFG1COdV4crXCi0qyAlWVwi79EFxq+5UyzYl+1oWKGe8qepgx/i5NwexlVcCZsVo
 DwmTRX2ua3qn5nVTZY5pcxMLl8OWTG189s3Cuff9nQohL6nvTlxq5fm7HVVyHSHUp7u6YwLlYAV
 YH+rySYT7pVPmTyZ9i33rx0oIW5PKak7qfsioY/e0r7pHQt+sZF0am3fQeDw8GLp17joP1NAk30
 FIuQYfUcG2R9E5RPG41IUf3xuzFN60h0Ob3NXUT08jUh1djg3A7IlC0BGxB38KfRjNrVLWsbhD/
 Q==
X-Received: by 2002:a05:6808:198b:b0:4f7:d324:bc3a with SMTP id
 5614622812f47-4fc45d579f2mr719095b6e.18.1791322643338; 
 Tue, 06 Oct 2026 14:37:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:13 -0500
Subject: [PATCH 1/8] video: mediatek: mtk_disp_mutex: describe the DSI
 pipeline with data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-1-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3983; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YT/8i+HDGas9OaJsN+/w+4TK4EhHZH5BrQZIAX06Jig=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWnW928t7D+WYP6s/DXWUMnXLIqHFGskj7do3
 ZUojA5zXd+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVp1hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ac+4H/1sCIIdFZdvHVDETrhaIA5k+CBGgjcaRaeLIcHo
 MxQ+pr0Ok+ek9BBsUGsC0k+MBoiygFoo9MSbUnkTgXc+pnPb6lhQXytVpH6svV3umNSYQgfX4GV
 vXHuNJb3OXgWsKB9XlNGkAj0vbNpAX/Pf+qzG+vd/JCuPAc1t0udBf4uEsoiNnjEyaSXNzfZ+q7
 TkDej5Txy7SsDprEJa2JhwrPIKr0bdbpEPfbyCv6/cxfBojHUAyagFT90uxD9W63pls33uWZdJ/
 iYsAo+WKB7K7YK/ml06wrMoO3mL4OIm8p4GVJCjzCRf2Jl3c/81aio871v20OVZFGrHgihP6bC7
 fQ00=
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

Replace the per-SoC functions that set up the mutex of the OVL -> DSI
pipeline with per-SoC data: the MOD0 bits of the pipeline components and
the start and end-of-frame selectors of the DSI, written by a single
function.

The functions differed only in those values, so adding a SoC now only
takes data, as in the Linux mtk-mutex driver.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 52 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
index af8e7032a01..1d987ad06f8 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.c
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -76,11 +76,13 @@
 
 /**
  * struct mtk_disp_mutex_data - per-SoC mutex data
- * @ovl_dsi_enable: set up the mutex of the OVL -> DSI pipeline
+ * @dsi_mod: MOD0 bits of the components of the OVL -> DSI pipeline
+ * @dsi_sof: start and end-of-frame selectors of the DSI
  * @no_clk: the mutex has no clock of its own
  */
 struct mtk_disp_mutex_data {
-	void (*ovl_dsi_enable)(struct udevice *dev);
+	u32 dsi_mod;
+	u32 dsi_sof;
 	bool no_clk;
 };
 
@@ -111,39 +113,23 @@ void mt8188_mutex_config_hdmi(struct udevice *dev)
 	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), MUTEX_EN);
 }
 
-static void mt8365_mutex_ovl_dsi_enable(struct udevice *dev)
-{
-	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_OVL0) |
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_RDMA0) |
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_COLOR0) |
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_CCORR) |
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_AAL) |
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_GAMMA) |
-			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_DITHER));
-	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
-			    MT8365_MUTEX_EOF_DSI0 | MT8365_MUTEX_SOF_DSI0);
-	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
-}
-
-static void mt8366_mutex_ovl_dsi_enable(struct udevice *dev)
-{
-	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
-			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_OVL0) |
-			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_RDMA0) |
-			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_DSI0));
-	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
-			    MT8366_MUTEX_EOF_DSI0 | MT8366_MUTEX_SOF_DSI0);
-	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
-}
-
 static const struct mtk_disp_mutex_data mt8365_mutex_data = {
-	.ovl_dsi_enable = mt8365_mutex_ovl_dsi_enable,
+	.dsi_mod = MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_OVL0) |
+		   MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_RDMA0) |
+		   MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_COLOR0) |
+		   MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_CCORR) |
+		   MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_AAL) |
+		   MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_GAMMA) |
+		   MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_DITHER),
+	.dsi_sof = MT8365_MUTEX_EOF_DSI0 | MT8365_MUTEX_SOF_DSI0,
 	.no_clk = true,
 };
 
 static const struct mtk_disp_mutex_data mt8366_mutex_data = {
-	.ovl_dsi_enable = mt8366_mutex_ovl_dsi_enable,
+	.dsi_mod = MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_OVL0) |
+		   MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_RDMA0) |
+		   MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_DSI0),
+	.dsi_sof = MT8366_MUTEX_EOF_DSI0 | MT8366_MUTEX_SOF_DSI0,
 };
 
 int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
@@ -155,7 +141,11 @@ int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
 		return -EOPNOTSUPP;
 	}
 
-	mutex->data->ovl_dsi_enable(dev);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
+			    mutex->data->dsi_mod);
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
+			    mutex->data->dsi_sof);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
 
 	return 0;
 }

-- 
2.53.0

