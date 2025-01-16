Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650F7C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D6B8075F;
	Thu, 16 Jan 2025 02:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hDJpzjxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2675780717; Thu, 16 Jan 2025 02:28:34 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA0280214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844ef6275c5so16706139f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990910; x=1737595710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EMemPRfsx7NU7ZrdxI6nN/KybFc6Y0Ujnjb/qeSlxc=;
 b=hDJpzjxkYDMKfNLysG8AeQhD9pOTPbmPicI7KM3Mbo4HdjYMN2mNnVWK2eMD8ZoKxK
 BpCH9ktHlDPFs3sf/V1xIQkceZ75lhmcgQ9wcjPs9ckfQi9VYmJi8Qt4NALjIeU/BI3x
 1nJJmNxYsFK52w5g5TyyrvtrvjGHLBVHuWkTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990910; x=1737595710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EMemPRfsx7NU7ZrdxI6nN/KybFc6Y0Ujnjb/qeSlxc=;
 b=O6nx8sqgFydMTSI7Y/Rx25sWro46urf5VCRyGyKTQjTBpFX+oDQ/nmBhwoC8tntkur
 wtT5/Kq9xxpHk8jw8nZhlIbJ6Cw/ws99QmlLXhyUzDz25TZYO713COsMayapSuaKTdHI
 kRgdcTOBjGT7pIiW0TECDIxg/J74IzBhqZQDODaJRL9EeuZi98t+hsaX7nShF1PFHQed
 iw2eisotIvqNcIH7hFbFzTJBMjcYD3KbgAj32KsR2R/G3pEbGnYYZUjRfu2HFXXtOisW
 +LOnO2hoL1zIZxvzjo4IxUsJmi+Jz6wRqjy4eJfImkcv1O5GVwXHxlQ5XK++dRs1o1a3
 L2fA==
X-Gm-Message-State: AOJu0YxU6cacp1lKdb5hSgNhatkKkuc6iihS6w3MtVwaCt6d9r4KMKbK
 A06XOt46Mm8QLZkZwuGuQ+4Ai3aAYTfUv31QuhoR1qBwS05D4hkwusCb9VtX36ZL8J2xRXtbwhY
 =
X-Gm-Gg: ASbGnctbdMSP52IVK1i6wjnR8jQ8uCyw0DbGsoHGZukfkG0q+7E2fOfZIxTDI1JCyhx
 3gebIs9p464Oa+OeScApHvQH5C3qSXI4ww8TYnBtdVE9M4jn9b4PP5ozxQiv85fTjpaoA+975Xx
 djNIxMLN/+P3kUZMeXicridnJFPODfk+pn55Rzj0eG9lOLH7oU0FoflT+yUwB5kHR1C5VN9eE21
 Xa6/W8s7aZsaHfvpTDrS4rzooY09edEgx62Z0xlMduLsSyHs/tr+Qv9gPE69N+o+wT2buhfQDda
 wlGGn1RgBVCqiH7jTA==
X-Google-Smtp-Source: AGHT+IHm2Lgjl28NwQKYBYcXQn3xMbIcj412RviFEU47VHg85Kd+0nN7j7COCigyF1sXr+ssbu4dRA==
X-Received: by 2002:a05:6e02:12ef:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3ce3a9a50b3mr234175885ab.1.1736990909726; 
 Wed, 15 Jan 2025 17:28:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 19/22] spl: Plumb in the relocating loader
Date: Wed, 15 Jan 2025 18:27:20 -0700
Message-Id: <20250116012723.2820301-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is fairly easy to use. The SPL loader sets up some fields in the
spl_image_info struct and calls spl_reloc_prepare(). When SPL is ready
to do the jump it must call spl_reloc_jump() instead of jump_to_image().

Add this logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 12 ++++++++++++
 include/spl.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 09e6dc26f5e..7cfbab06419 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -826,6 +826,18 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	spl_board_prepare_for_boot();
+
+	if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
+		int ret;
+
+		ret = spl_reloc_jump(&spl_image, jump_to_image);
+		if (ret) {
+			if (xpl_phase() == PHASE_VPL)
+				printf("jump failed %d\n", ret);
+			hang();
+		}
+	}
+
 	jump_to_image(&spl_image);
 }
 
diff --git a/include/spl.h b/include/spl.h
index 9cfba98db55..7155e9c67aa 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -414,6 +414,7 @@ static inline void spl_load_init(struct spl_load_info *load,
 	load->read = h_read;
 	load->priv = priv;
 	spl_set_bl_len(load, bl_len);
+	xpl_set_phase(load, IH_PHASE_NONE);
 }
 
 /*
-- 
2.34.1

