Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAF606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tbwnMwfM;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jOKJYL1G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4789440AE7;
	Sat, 24 Oct 2026 00:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44omeHvMt34z; Sat, 24 Oct 2026 00:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA1C040B07
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800626;
	b=XlqLEr49FEL8CbRRJ3kaXp/XZJ/d9e9VE0F3VlWRVnAxSKfY1/GlLG6ZsM7XHVYW/sbj
	 96n47xiMdJhmW+FBxr45HhhJMfPPlUN3XTaQ0/6kAwciA695ewTTMERbme1iqQrADffup
	 okYJVqqCf0d4GIX4eTEDPyf9+p1KPlS0um3EPD/3JOH7g8xaW92ngbqeYfItG3+DD5u9P
	 j0Z7lo/GaJNjjcHMemLY4jXrx1yVwPuiEIRsExNMQOmHthJ7gMLkclZ+Bg96Ox64usmAJ
	 C6W5buzL5RRzA9R376Sz/80sHnIV/2/5gjS8dT2gjqx29cA9y8D6VXR3FTeMyTuCRmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ANdBrrrNMjwXmUJRgsUbnzzfOk01MNyhkeSnL6neUGU=;
	b=EfU582KAQjMin9H1al/bxbIxnw0xSd/7cloLH+o+e9yFdANinEJxpIgKt+exN/3cyCd1
	 934tAPvwpVyzTPgptkfjfoqBBaUdX0wOofuyTBJw5cYUaquFn84Rknrq6ukBtOSTuDxWW
	 jZ359QwHsB3C5EvvrFE9Ms4xK67/1wtiKSnqg38VI8gQaJDCzLW1lGMBBgTo+JDwP9/6+
	 P6mVxLOcdpBHs/RLR26QrHXGaL6H/7ci5vn1dEhbyUx04fUSIsVIaef1tv6jPY5IQc0zd
	 tNI0Zz2+OYU69n6WMzDFPbaSjF5qX72pB/NjXc9bmsFA2vNk/NwqRcb74WzrWqZmSjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800626;
	bh=ANdBrrrNMjwXmUJRgsUbnzzfOk01MNyhkeSnL6neUGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbwnMwfMNe5f6cwnCKakMSxHnCwoMpyjFiEZNXBtElOrvnANCO6EW9W7cTOVw0Tns
	 tN8F9mxV1ooIJuWIiyQs19/So01Q81R2cRXjdYS1ZKRudDGZzqhMAIMdEc4AOAlTwR
	 VuRQusdXK4/exlwMhOD33RAzQFUiQ4IgX1h1IUH7y0nkCowGRnzqhDY5tul4GQ8E0V
	 21iTeB63tPmprNdTxLzWz4VQQwj4fuiT+qhD/a4M+jcMpah0UcFgybh1QUrVR1NMsM
	 kF5/1fggGcbvo9zdPvmUIntAMr+6K2tjRAl5eAjcXGvrC2bAa0KrU7u7E9EbGp1u2J
	 itX4BcrZJfO6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA1C040B07;
	Sat, 24 Oct 2026 00:10:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5E95356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B31974016D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKRLfw2UlYGL for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CB1304009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800621;
 b=UbbMBm8gRbGYyMFaEOxGARMXg8WrhFq1G0EDXPDs0V8llrxL4MdSLyUPgGtm8XbhwZcR
 l4KHL0Jdv0IG6fIRPFhokMWeEgIZynK7ezLKNUAnEHpdnvLFD2PZrMyJBgLA927zINRCs
 HtvlVW+eNykQl3AML/Ova3Nl1GL10ouKiMCwNIVUov7d8fGNLOSMttgnkU6tIH8k94OKf
 YxHqrWN7ccUogQRwuERLZW9t2ZrEaNHZjiJzTK6PuPqlDKaDZAxKjqdW/f6oLj64/uf03
 966qzvd/IaazSWU7HIP2GyO4N4WVpA8b08/ykK4b8vlkEneD43+5XNLXOk0/rlWE/ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800621;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ANdBrrrNMjwXmUJRgsUbnzzfOk01MNyhkeSnL6neUGU=;
 b=lCTPw++VpYoZSXJgHleMawlFjmxgTNXFmUTwqg3kODLboBmDdvQTsfNxlCVlp+DL+Dju
 HYFo36kudrq/fjJZpsqWgUlKB0tCU8tduWWvG4PNHunQ+sG5Bj3Op5Xi/9LIgsHyXsUKP
 FWnXmXbhkxwD56gws4bVAUVivgvWZWATrZL/jNRXYCN40yuy+I+vFj+NjMaI8ou7+yt8e
 mx5sIWVN685IYoUQ5y79kIctIfW5tTZSNUaN5tuQPIL+qJyMey69CZRLa6U6RE0q1zAKV
 fNq+NGWZ+FV1CQ3EhdO9n3NypaClHZULa9oorV+RuuYQU2R9PnlpL/S5EEtAcxxBmUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jOKJYL1G; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jOKJYL1G
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB1304009E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:20 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-53aa0802881so703977b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800619; x=1793405419;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANdBrrrNMjwXmUJRgsUbnzzfOk01MNyhkeSnL6neUGU=;
 b=jOKJYL1G6jYNihVyGzl4SoHy50Zme5Ib7EV5B2qMZ7gQQLaahM9G5qR7JUEaJ46iWN
 jePcHObQJiwq/smTqHOviWo/bcQoTgyly/n4dH3qtyG/Bym4HeH3k9IxXiORIBXeH1OF
 L9hnCEOVAkOZiX4Y1Lj9B1tea/+Y963CqhGcps6fKdoykyutiX1Mkht93ndWSEBxKaaB
 6zizYa9KcQ0HpgnnPHshWi67XJpIm78zGBH2uwvq9PXMshjpqBUaxKqXpSMQwfqY54PZ
 SFlx51hhn+XbbZ3kt/KBxaV4rVKKgdm06RfLggko5OmA8AGRtD0j0RT+PooOyvNva9P/
 ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800619; x=1793405419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ANdBrrrNMjwXmUJRgsUbnzzfOk01MNyhkeSnL6neUGU=;
 b=D7RwIR/qRkeq/kjxq1c/BSHMr06TeL9JWDLBTo21bi6wtU8bQ4cjkbrVy33fEoF3DI
 XEt9t2REm862yFgN4UPDQVPnxwmQfw0L0E0Ppqf1gDc1zZO/6/PoqqzB+iDPoOpRl6/9
 AECzGxwp0ig/unLDore2ad9+CnHkwkwHGC3+DsT3Mhq1VlX1Lm/kN1LBolD3YibObvPd
 YGRMhqkXKuNqetjFw66BzKP+51eNn1eyp4f+0THZbKjs37h17vMEl2DKtyyFZhOkUcsE
 AaLhGrbGNMY9LMKbTqAB01rCsYG9GYRTzZzu8oCzFAsCogUrdzC3c9mHXF11uFZ67SEt
 8/Jw==
X-Gm-Message-State: AFq9FYJKcGXPfjEfTyD1VC4nX6es+n1uyUvwGep2+FgjPjJTw51Xcaws
 JDzEKwTn6oLdNe8N/9fCk87fqFOhTPLiTEvVlC227SBWNHRUaOeMt9suv3ZlXOYxVCA=
X-Gm-Gg: AYBFou3OmrrkmQF2zEnzIibKnP9f+YeDedBSwNrrophY1DfTITK4vIUXOAK6uI9neF2
 IMysegbjv4j3gUAFhtNlRQSWmv2aSP1XsUwmiT0YMBjtdIIwnvzQd2xAoujrOUbo4pWVu95RORJ
 y9TAIOAkJ4+cAQC1xAjsslmd2DFirhF2afbyhbf3aZ2q+WI6cMRKzWH1oKQEI7wVNO+liP2bNl8
 yPk05zlf2+HDTidTT4tOeHOcey9HmLrUo0wyZcyHyluF5TPpQ4h3h4/f13HR2UOaQDYTqtiQtv3
 x9pW/Hc+WDVIigF/Zj/fIuYYa+oCtt/WoP2v/g7Kiu/mJNGN4UuKDJwDxeNlgrwQnMsEdItG5vY
 fnAy9fYkbQATIii/TH7eif0IB96FbkSA5iHTiqdzbdModz0FRSRRiG9dMAP4t2ndUaebaO2t/CJ
 NZl78ZK9l/hkFaFajDp6Har8x7gP2Lhxl3nlfZKfA+AJ8P8lH9Z4QSlyfWrfXu/WRqzVCB/R+9u
 Tvflgx4J35EFLxhtZyDjWZzisf0iONz0rtAjsCYTUSatCja4wjWizlA2NOU
X-Received: by 2002:a05:6808:13c3:b0:4e6:cc78:edc1 with SMTP id
 5614622812f47-55c002d71cdmr602345b6e.42.1792800619448; 
 Fri, 23 Oct 2026 17:10:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:11 -0500
Subject: [PATCH 5/7] configs: mt8189: enable eMMC FIT boot from SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-5-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nemFhVjuH33FTU26DorbsEE8hMJ+2UUWzpq5dnNMPaw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/dJV3c0Joqt4gFAB3ahjYZq/IL4No06x6Jj6
 SAWtVo15xiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3SRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aam0H/2qQ4BXUU8tbS6fjaFrRh+WFxDCRCI2KOWLI1Dv
 5ftg8h/xTqtHGcIZEmq73ZdvKJXh+l7COpYMFJ8TU2/HITFL4eTy0B9KlIEZfq1iKRZ1bQSaZ3o
 JgtD0h+9oMVqgIthdwoYovvg2BnpIjbpmgxjtK1iwGwS8wly0P3bNEcgdraR0pllnE9CIJlMFYU
 2aQkUw0HYZJN0fV0/QxPtCP78K4VfO7CsB4qivejw7uqT0IyRH1XnjenEozHX9fVW38Km3oHFTY
 p/3264Lm+Nv3e1NrGvb+NO7gd1JY8YqY3p8+p4YbDwDrKK/FtQolLUXq9JdypKKfyXvKxxkDsBd
 tKDY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable SPL on the Genio 520 and 720 EVKs, entered by an external DDR
loader, to load BL31, OP-TEE and U-Boot from a FIT in eMMC partition 1.
Pass the transfer list from the DDR loader on to U-Boot proper in
registers, through BL31, and allocate the SPL bloblist when the DDR
loader does not pass one.

Reserve 256 KiB for SPL: the MT8189 BootROM loads at most about 930 KiB
from eMMC, and the DDR loader needs more than 600 KiB of it. Place the
BSS right after the SPL region with the stack above it, and the heap
away from the firmware that SPL loads and the memory reserved for it.

The DDR loader describes the DRAM in a transfer list, like TF-A BL2
does. U-Boot proper applies the devicetree overlay in it, as when it is
started by TF-A BL2.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 0dc3c2873f9..f25e1ffc5d6 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -63,3 +63,39 @@ CONFIG_VIDEO_MEDIATEK_DSI=y
 CONFIG_VIDEO_MEDIATEK_EDP=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
+CONFIG_SPL=y
+# Fixed destination and copy window of the external DDR loader. The
+# BootROM loads at most about 930 KiB from eMMC, so the DDR-loader region
+# and SPL together must stay below that.
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+# Place the BSS right after the SPL region.
+CONFIG_SPL_BSS_START_ADDR=0x40040000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+# Leave 448 KiB above the BSS limit for the stack, global data and early heap.
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+# Keep the heap separate from the loaded firmware and its reserved memory.
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_SERIAL=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_EFI_PARTITION=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_BLOBLIST_ALLOC=y
+CONFIG_SPL_ATF_BL33_BLOBLIST=y

-- 
2.53.0

