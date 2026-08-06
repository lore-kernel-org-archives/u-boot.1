Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77117C5AC7C
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 392954074A;
	Thu,  6 Aug 2026 16:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbp0PojodvJT; Thu,  6 Aug 2026 16:15:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91BEE40753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032936;
	bh=FWqw1aIgcf2sGTEHO1CvJ85WAI6Vu6KptiyQKJe1doE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gna+PjMHvdac0sCPZgiut6AP0CeaTOGPm0yyq8qFZrn+NtqbDMfMHVfHY21ObMx34
	 W2cMpbNtS4qjJzUof7BP0fPb6AbgVibX4so5w7p72evje/2fCbHFw4xyFCBEvG73bi
	 UD1PL1VUUdCc59qXrF/V91r2kJFh6DeyZgn0j93Vh3I/sSOObUtsEJKC99x3A679Dl
	 7kz+OXVliA1SgfHVjT6AGQiqt1ggPQtG3BqrXBlVx7F3A/w7c3bqpkXDIW2YJeNp8l
	 opcN6oEWI64mTxugKGKMIEkYY95WfVoBSY6JgGKa8IJOYLuh5ovpBIOEAnE84YMwzE
	 ewQt3/208lvfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91BEE40753;
	Thu,  6 Aug 2026 16:15:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CA642B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A94660808
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B805I4ScxT9P for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:15:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0AAF360806
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AAF360806
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AAF360806
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb63dbd229so843849a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032931; x=1786637731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FWqw1aIgcf2sGTEHO1CvJ85WAI6Vu6KptiyQKJe1doE=;
 b=BVf0OU2QWCL2DCwgMV1A8dDpEwUErdxKJVANUNdBzq1iBZAqShJq3kJRBPfYDeAnA6
 r8yYgzPeaxKKaUlniGLW73jWc/3XUpI+8UffPW/L5XCwvL6WrftwWcYZ6jV3UJRJ/Qf4
 ysgrEe1tMD+Tqr5QJQB1yK6OeCCC1UT4Kj+fEA0jQBT26F48ZWMbaJzbRrJcxwYWUjVE
 YJE+/aZgbQ4OPbbD6X+KYnQzdE0hMeiyNmuUsRP6XGpvjDGEZfi5eDuAaKDo5cmo9V+v
 eG79P1lxJMawBJ2sSfetuqjmGqGDJgMHzxfpcK+w818auClLAL2My114oqQmBBrhNdHW
 EjyQ==
X-Gm-Message-State: AOJu0YxFmHa4EuD54eLBN+pJ2fZMA0aPrFxfSz0pyL0oGf2+tHSivzui
 S4X85zD5lwV5xNZ3ecvD+Keu3PW2xSgqYcN6IMIScdWPMUuu373YgEXodiRsm0SAjOEfC1UcT67
 uhQzhhLo=
X-Gm-Gg: AR+sD100poFit4aCMaEWiDCwrKSYZU8iZ+9mu8MAVzausXfUiZTv/+PJXNLVjClGJFH
 UqSmPFKlgqsD55x3olnPbIIhskGQBjSvyO02EzHAy3u1Y6def9kMw1VyqDWsMf4I2Is5/H06cJK
 JzP7Gh05dOzeR5/QshS3hYj3vurPnhbIPxmbnTpAWF6Zg0oHg4pWHMaG36fs4TvgWbBgFbdgZeF
 0nLwsHan1VomEdu0NjBC+vFUgU/NXy3JKCbJQGo9okADuBfH5FOeVNQUvToC6I88vuSy7sqHlz9
 kBDBq6MXYUIro36Vj7N7mZx+6ne3D1qEqJX4COtJecSpE/ICDgI9BFmyv+efTE2R2mnMPr7+FDZ
 ad8vRLajpyMxgOj9HUkaMR0sropPKY1hfjWGQ0nu2NHxQZetDXMLEvdczYWoWiYpW4poCCXtYL9
 6Z1/Y746EP6VA0QNeCQffd5CGo3saElC2r6yvikcE4WqC/wfNqzPjZxfof2S2CAOPSGg==
X-Received: by 2002:a05:6830:6810:b0:7e9:e5df:5ee2 with SMTP id
 46e09a7af769-7f3443c1813mr1515568a34.6.1786032930809; 
 Thu, 06 Aug 2026 09:15:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:beb1:8dd1:72b8:350d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df568d7csm4563367a34.18.2026.08.06.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:15:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Aug 2026 11:15:01 -0500
Subject: [PATCH 3/3] net: dwc_eth_qos: add mt8366 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mtk-net-mt8366-support-v1-3-5eb259ff69dd@baylibre.com>
References: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
In-Reply-To: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=673; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=l+HKuKprS0R+u4SlJ0EM5u2FuUEbM699JvzHE+iGnbE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdLMXK3F1jF8xPDIuzdb2V+BIe+J4t5Ijn8R9G
 94DKTwdIWeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanSzFxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgIEH/3cfg7eTiafW6FQE4zSuHlCmE+cuOe+f6sYVBQJ
 /fwcObVkVwbmrriw+k6EOqUca9cYCYUpigTxNzeQsZIWNqzLzXIZUAHS9drrDTlcC58w5ISjcPB
 /uifHt0/pA+iDq1GwqFpOZtzQNDyLCMTVptUKl2V22fg0RxNqO3Cu5XeD3Z/z22BsjqaFPHXz27
 Kctw6zL5wf3u/wc53ZTPxC4EyU0ifnl615R90tXZkc68KtgPekkuZIFur7djURaaELLJSDXW2PY
 yy+37gSm2KJMKo4p+HTDFNwGRsWwULkjAEYSfc3yYgX7+glwd9xTih4HCGX7zUvQih9kQ0a+4+1
 Yuss=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786032931; x=1786637731;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWqw1aIgcf2sGTEHO1CvJ85WAI6Vu6KptiyQKJe1doE=;
 b=I6jigdHrcw7M13ycerNw6a28QItmWEpxbEif9iEzVEzLNAKbsDhAtji2wIoe1bN6Y9
 TDE41+9CO72foxANZZe857ws/nkCv3W7Z7kOhfXqP7W01LS1Yr4nITQL1h1bAsPy+Jgs
 A81HRLSqbVJIxIpdzgChEGYezHMNoHDUCEzsDZ/bNZBUZmm1Fh/h0UR4n083ZGWc9glY
 Aw00AKwoNK2QJBmnCB/Cf+/PWdcaoIBtpoDiQkx5EJ0PjlVhjkDyGQqAudRO2INpKd2Q
 woKfFwSUqQ132xts9XkW6Ursc3OttuOprthSXk7uXh0KQNdxltw2vYIddlMY3PYbM5Sy
 MgvQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=I6jigdHr
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

Add a compatible string match for MT8366 targets.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/dwc_eth_qos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index e7cf68d011c..bf590421324 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1664,6 +1664,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "mediatek,mt8189-gmac",
 		.data = (ulong)&eqos_mtk_config
 	},
+	{
+		.compatible = "mediatek,mt8366-gmac",
+		.data = (ulong)&eqos_mtk_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_SUNXI)
 	{

-- 
2.43.0

