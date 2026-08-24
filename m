Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B26C61DB6
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C39A280D4F;
	Mon, 24 Aug 2026 19:53:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abWNm0sdDGnI; Mon, 24 Aug 2026 19:53:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787601190;
	bh=vWKJ/cpynkpelQz77szOFrVSjYCgqutDIEelvS//yS0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRLsPSwZ5IsjsSpB3zhfYnj91kG4a2PbcELb7JrubRPMG64xDI27IoJaBhDai4UFM
	 XXML+fWCbPGO6MzqBGoWQ4CLn4PVd0GMRTwEGywe6ghtzZdznNP2W5vlPG+4sMFbYN
	 CdgNvxYQoazw7wiRYKyzNXPGZZnQ9Vz0GQCpHo0KSzgeDEIQmCaYyzBUM+0E0TclU+
	 bBvUrkDQQtkmv8IjBHDPdRy7LRev15027pzESctOTTX+MfTOrwdIJ0qFQ559e+t/vp
	 wnq5gL6+6pKA6U3/bEOz11wnXd2/n7lzhkcjNF4XUH3hMAfhwfo2Wusgldz2lxVsgW
	 sLvJgOkF5mtMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D990480D2C;
	Mon, 24 Aug 2026 19:53:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C8D0279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E63080BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sED2-pcR8rn for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:53:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=MRANwr0c
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 546D980D43
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:53:05 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ec1e9d3359so3750731a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787601185; x=1788205985;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vWKJ/cpynkpelQz77szOFrVSjYCgqutDIEelvS//yS0=;
 b=MRANwr0cQw/ZGVuz5EC/gE5LA/uBysQMRUINLzGTtZUwm5c4D8DaLp1Kvqkvqyq/Zn
 qSFrgNqhrHl1yBb3us3fxHHjJLGutFfMiN1J2DyvD2ONZwx50InJb4+MwR277UBoGD1I
 fHeDBcbrZMu0D3/Dx+EnvhWVltKKO0++vBQp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601185; x=1788205985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vWKJ/cpynkpelQz77szOFrVSjYCgqutDIEelvS//yS0=;
 b=mQMAH+h+HghWa//Zdnyy60MU1mRaS137nTSmyKis4kvVEATNx0IOqo4fQQFQKUuwSS
 3F/DIVPY+JeYFb6rXbiCsAYFOex2KcPHE8+xxMdd6ecaygGlday+3dLNzqAx9+s0N1ZE
 SgfE9vkkcOK+mSt+E6HvX2E9kuD5okOCwXkipqglNB63+uFfQgkDFAY2e/5SrsnqbesX
 GY43DjP5TJTKbzPVrQTecFl6YyvC0URWmT0ZRkg03hYu+bxZbJGJP7BTh7kffz8M5P8w
 4pPJmBuS7rMotPFizTDBGlbcEztM3bJtMBrZtwAGuztAr/ORtFWP82QNz5ZJbrnSskvB
 +oIQ==
X-Gm-Message-State: AFuF++le1VtaKqB7IkxR6qFelm1HPc9WaenRLqlCFj149BW6pwKQPtSD
 /EOJ0SUkdsfnPRl30/h0iRCbjJO1ChQnHhh3/zbdc17Z81lvp1opfw/xzqVUteWOCplWQkqZXYG
 JI0bQPJM1/HP8
X-Gm-Gg: AR+sD13/fnzhJemH8qXVa+gsWRYD1kkh/ZYyTIDvFdgY7tWoXw282Gky9tNpgNS/9px
 kcfv3FFNp7lH886NWvvP5RrsI+9MVtm9e+2e0FTtLTdxzCHSoUkoLwyAic6VjtfrTVR4EwJgjFr
 2ggJ58PlEWyQOH/SZhKOBeQfpPjGcUakL/afAimiWdFdoe/tCTo/w4/JeETq9ay3qz8QOhB3t6l
 cCsFCWf3mfyno78MxfSd3W9rwN3T9fa2D0guLoPDQ0IH5uwpFevZcu9AMnvXCWx4qNCwaqzfcFA
 tEOOHknr0SfDxsVSu1PblzDLM8nSThSjKagl585D9O/JG2u+2NEe+txxQoOvoJoC3DfBVkf0Ig7
 PHuUgzzu6o4xvI0v6jii2E+tfQtB1hWHd1wX3n536sTOy5oqTYZ82XXULPaUAZHnrQUAAQbGAHB
 POYq4KyBp+ApMd8l3SBRm8R27XN5OvaFmNCSr93Gu82zK1br4Gw6KBG7Dfe4xRfDtUDGZr9ENYh
 lcpf2+j5/ZbOqPXp3MmBJyCmzWeXqG8VXJtF+15aO+gE5c8ctRBoAAxBf+OfvcU7yfL/r/xLko6
 kIRYmaxXtr4BiY7YRv8U0A7Qg7c3RfEWdg==
X-Received: by 2002:a05:6830:3c0c:b0:7e6:fa37:9797 with SMTP id
 46e09a7af769-7f4613656demr33661266a34.6.1787601184841; 
 Mon, 24 Aug 2026 12:53:04 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc8623esm4975162a34.22.2026.08.24.12.53.04
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:53:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/5] dts: Make DEFAULT_DEVICE_TREE depend on !OF_OMIT_DTB
Date: Mon, 24 Aug 2026 13:48:46 -0600
Message-ID: <20260824195224.556419-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824195224.556419-2-trini@konsulko.com>
References: <20260824195224.556419-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When we have configured the board to not omit a DTB as part of the
build, we should not have to say that we still need to build a default
DTB for the board.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 dts/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index d56d94679f5d..b7a2d12a73b5 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -224,7 +224,7 @@ config OF_OMIT_DTB
 
 config DEFAULT_DEVICE_TREE
 	string "Default Device Tree for DT control"
-	depends on OF_CONTROL
+	depends on OF_CONTROL && !OF_OMIT_DTB
 	default "sandbox" if SANDBOX
 	help
 	  This option specifies the default Device Tree used for DT control.
-- 
2.43.0

