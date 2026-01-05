Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C0CC79F89
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD8E83DA6;
	Mon,  5 Jan 2026 14:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QnIlNgGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B71983AB7; Mon,  5 Jan 2026 10:37:04 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E1C83CF5
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so103355715e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767605821; x=1768210621;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ur4Gq9Wm+WmVj6sReima2osbuGtkaUudTX7070yJeHI=;
 b=QnIlNgGUtjxkDon8K36ngZvQY8I71ifljWojLF/KeU2jrrXG7yEUvOFpCtmXopTV2k
 zNSA2kU4ZD1EVAxmarLhD+4pjM8/YAu2lyy/xJDIveA//otQKejAQ+cTLZHl9dWxZead
 r2gmTfbLxDLPRGD+nTnFp9slkO1glIETR0Z+WVz5dw/xWcqYYH2aau1P873uN53pNq5x
 cxqGcTHIXpZxDcTCttacYntsu8qTLjHGoz7YpLqLK01z2vxCXmnc+oflUgbdIVZiHCWo
 H7JTyMDrxLPisDDP9flip1rpDTCHmy9p0LfOGFwM9P/Bo+ip4Ts4eV+MxU774k37LT6K
 C54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767605821; x=1768210621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ur4Gq9Wm+WmVj6sReima2osbuGtkaUudTX7070yJeHI=;
 b=iqTqYOjPwzc/VHrFQppkxGRNYBfJE5KVRdiySuj0l4vschhx+9RlnBaIVdGUEFjlm0
 qmBCshIIlO2e2b4b0XU01PZEP2nc+FOOfnrmw8MzsJiizMAuZRBVEhuocedzWOWcRejP
 3+AKj6GglY1LA7gIAc9aiXt2HpENFeIH0iXo39Rd2t6jnWsmHkaiTNeHSkgE5Z1eZn7C
 Fo5AEacAbRoeueIruBmkuxFTsph95BM+VSIBvSa79CBjYmmGDYDYEf8HORODeaSfIgC6
 3EvvUXwwsGjaqTaMlC1B/Cww7WQr+Bhp2Fgy7K6pS05XO+xtRTAKx2a6fPemnYNaa6Lq
 en1A==
X-Gm-Message-State: AOJu0Yy/6YwqmM2mLRX4Vpi495f6J++0hhEcdD9pPCGq9cp6lyPxUvIr
 0kdCiwQCgTcwXnnnaSnTlH2Y5xG6+8TA75maRSmQ1KggD34bHTgWZWyzgroS8GidNDMrwERCouC
 J7/Bl
X-Gm-Gg: AY/fxX59z45p/uGOHrNg+Ro/9Xivwqytfmgf+5CJI2jRvSaqRHad7wKtKPHzruvK7on
 nvznV5pGmFGkXz5cmd8GiqK7rKEaBye8BbYDZO6K8jImXv0PDrqptZc1pxN3Mr+XpqYShxir/JQ
 tpPJV58eHhrlF+MGS5LsiBtBLItjkw+yqMZHu6x5EI5KZB2OfefvLkwRPpbuhvgzHZSh+Mfop8+
 K6GSqv46266ilfTaL/4h4k2Ae1F6MpTEYd4frYrbNUpm7aWICPaej7ZWek9Fu7ZDhNQLoOp1V+R
 5soup4H3vtzpxkObqqeLP38xyof3LODmCW/4qh/xr8tmsYc2TaotYw2F2BESl76uoufWRVp8ydd
 p5Ugk7xuFMZHUSOato//f6FtHxXiX3gJYLgOEbqf0sMW2r4VnMDSFQq2ZM96GTjzkx+zIbpuorX
 I1aOPiZNbRokpLWoq5/gc=
X-Google-Smtp-Source: AGHT+IFD8XtI12OW+cHViHmDa+Cei9oO9GS8WuB2LvI4ooCqZM1/k2T6YkeljsoPXFhpW9da3q9sGA==
X-Received: by 2002:a05:600c:c091:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-47d195a98d5mr485741365e9.35.1767605821298; 
 Mon, 05 Jan 2026 01:37:01 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d452be4sm143380885e9.10.2026.01.05.01.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 01:37:00 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 10:36:26 +0100
Subject: [PATCH v4 1/4] panel: Add missing comment for the timing argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am33-evm-lcd-v2026-01-v4-1-7617591b8159@baylibre.com>
References: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
In-Reply-To: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=msp@baylibre.com;
 h=from:subject:message-id; bh=fMGXotjnQKFx59fxFUunjfwuMjXv9G/L6C1+9yXXNOE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszoNrWvl+ueiGYu9JdqDIs4OjVlhnjY/X2TOg82Lbqov
 mjlha9OHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCROCGGf+YTvspVJHV12Vse
 bmf5ErhdKLV2+v87npPnhobqMz9NPsrIsC3ut2aFEbvakZmdC5uvLoqTi5tipdDzeenfwkhDhWe
 vWAE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

For completeness add it.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 include/panel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/panel.h b/include/panel.h
index ab417bc91ed1d23aadc64e861bb721418199fb0f..e2764d72c57dcc4ae11d5f1553f1bfcd98996138 100644
--- a/include/panel.h
+++ b/include/panel.h
@@ -29,7 +29,7 @@ struct panel_ops {
 	 * get_timings() - Get display timings from panel.
 	 *
 	 * @dev:	Panel device containing the display timings
-	 * @tim:	Place to put timings
+	 * @timing:	Pointer to the timing for storing
 	 * @return 0 if OK, -ve on error
 	 */
 	int (*get_display_timing)(struct udevice *dev,
@@ -60,6 +60,7 @@ int panel_set_backlight(struct udevice *dev, int percent);
  * panel_get_display_timing() - Get display timings from panel.
  *
  * @dev:	Panel device containing the display timings
+ * @timing:	Pointer to the timing for storing
  * Return: 0 if OK, -ve on error
  */
 int panel_get_display_timing(struct udevice *dev,

-- 
2.51.0

