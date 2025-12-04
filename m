Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1600AD1F9DC
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49DD8407E;
	Thu,  4 Dec 2025 13:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g7tzaAzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52F583F5D; Thu,  4 Dec 2025 09:31:56 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA43583C51
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 09:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-644fcafdce9so1045854a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764837104; x=1765441904;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ur4Gq9Wm+WmVj6sReima2osbuGtkaUudTX7070yJeHI=;
 b=g7tzaAzKcf/O0NNz+14sySot8psb5tGN+L+0IFjuVWFZ187HkQ75dPXZ6UTdr+JO4S
 HcX0N67bhFdmsZ9+UtbpghPKDyN6Yse1zX7MC1pkp7YUL/L8RNc5NpSmyfNYReAPvLbz
 XyGGEr2IyQA1kMjgpX2i8KDWdvhrQjfoPWjtrwyopVof2OIIIyTkFbB58VUy69GupYzr
 LJdSZSD9TLbc7p3zLwKsnBfGFoaq7Fv+vK6bciGWeLnFzlxw2WZKglW4FYZ0LZ+D995k
 gvXVFotX7fKuNkW8giY+7piII6hDO0D/A/McZY7orgQlkrC0DcKu/HpMjQq/ACLTECiE
 6dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837104; x=1765441904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ur4Gq9Wm+WmVj6sReima2osbuGtkaUudTX7070yJeHI=;
 b=FjOY3++i5pkBEZPa8jQGSJXsPrMy4NpP0ozaERupmMR4GWojKwnzobxCsMsOtVom9G
 OB7IlWL3pMXqGZX4TBYdGDp1nyvPyklLAwjVGjaebXZ9eKrgVS/RW2SEEUE9DYHQHzJx
 SQyI1YuAdcuVV20Xs+F2mVqqeYD9ozTsYPi/VwaZ5Hrk3vvDF/vQLsVmMy+/GDLvblBD
 V0Xr3b1o4xwCbEvXJyqwYEcpOsfgMwJjujeTWxGWWTb5iEpb4AI6ZphOhm11wZbRy5+6
 k3XXuvWauFkdsrpt6HgoM2EA3G0YCuV7QfLH9xLu8njoLsHsUNHhZVtFIiXbsE3lfwCA
 LsrQ==
X-Gm-Message-State: AOJu0YxuuiCAclQY6chuGv8cW9EGxBsF5JxnPFk/vlwk+xHGP4uhN77N
 WitK7RIElALw6LdAc5/IQG5cmNh2RomZQXu5abaSReef0ZNkqvnV2InP5mKJjOzZJzQ=
X-Gm-Gg: ASbGncs+l+wbO8RsojgZS0eea6Y6OhAOhPCfaOhNP6w9jZII4MK+LvOWPIJ1yL/OEfI
 Xb4uKtW1DIjOWvRRej2hdR+/K059g+KK0eom/mvqHT1klZFguX0fvyFKtcQPczJQ+aXERTLMwTx
 IgiRBJjiul+stFwB0uo1j4AN20wsJ3OKnBZjOnfNSkjDyeFsGQ+yGtsysAQtjog9doIwNsSU8C2
 jwzCPnkaezViYsr3n264LvNAxJFyCWnpyCVvy0T5QOx9e/90VsiqEaG3dYzAgEFhVS9oJfr+fD1
 kjq+H41HIpN0tZNq0qYharEs0nMlIH8lhyD39GDZlfd7yEl5EHEvlnP8n4LEZSsC3ra8bBASHRg
 JysA+f9tcQqLuuDEmok//4M/nOv0noNw0FbOi+kvigmhqB+pCGybJFfXlw4erqUbaW0D/iAThiN
 6XXbGgJRY=
X-Google-Smtp-Source: AGHT+IFZiwCms5oHHc6aRgr6ChRKd+7CvwXmq1QPlxd/fxTxlLAn4PdZFTinzM/3O2dJhujqmV65MA==
X-Received: by 2002:a05:6402:280d:b0:647:70bb:d20c with SMTP id
 4fb4d7f45d1cf-647abd97109mr1807139a12.12.1764837104275; 
 Thu, 04 Dec 2025 00:31:44 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b412dec1sm642510a12.30.2025.12.04.00.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 00:31:43 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 09:31:14 +0100
Subject: [PATCH v3 1/4] panel: Add missing comment for the timing argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-lcd-v2026-01-v3-1-ca74853bd5f0@baylibre.com>
References: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxDt1sZs998FdowTYspQ/x27yG7VJ7MhRYiZ/OW7H8wN
 3u+QpBIRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEwkfgcjw5M5Jg8+OcbX/20X
 ZFZIj1qS1ZkhsvO0Ze6qRXEz8p632jL89/BlcRCZ4sf96KnqJEYRR7/YaRxXBL15PzafquA06yr
 hAwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

