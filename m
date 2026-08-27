Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AD0C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 323F3607A8;
	Thu, 27 Aug 2026 14:24:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T6iCd39sdpp9; Thu, 27 Aug 2026 14:24:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787840666;
	bh=zYlcCnF5+nqJXW6+Ev/3CBU7Gyj7/aEcJRms4AxcSLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=laSrGOkoazAs60mTfB2+YxRwVifx1fa1aw2dJM4yLZwQm6DOkFO1HAz8pTv7lv2Qn
	 E6P+PU8EcOEM25VkVC3gZVsN/kyplfGP2HUkTbQZjScH9dgVLLdZ5cHDmByx/nCteB
	 77kj2x30QiOWGuI4SDg8WLrj3Z6vKYwPPKoglu/Ym3R8Q1zaFgSZeBvUGFwhfGiNza
	 oRDFABeJuS9KwyVAtoWTNW67YbolyKmRRvZfjtOVF/dR12SW7Q/24u1+EzJMmajJeV
	 LQ34od+9NBwA/Mh2jOFidEsOL2Xk3VkDZBf2kfe/5djLIOibxfPbvU11ksyiNVHGOr
	 D97BdBH5M4htA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69CA76079F;
	Thu, 27 Aug 2026 14:24:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64AB3355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4ACF76079F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApVpIBWtX5YQ for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:24:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hgev/oIX
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31E0B607A0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:24:20 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so20422545e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787840659; x=1788445459;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYlcCnF5+nqJXW6+Ev/3CBU7Gyj7/aEcJRms4AxcSLU=;
 b=hgev/oIX+r83PAvn9b09TYHalPf6yn3hSI/vbOTWSwn6ugOSBg0tx1seD5+mfyLa84
 WnKPKulwK3NZxjummdwPjJBl9XrZrhgLzVibNziLD0c1OhwPVQLtGvc5l5qanqONij/T
 DJdodlukIiucqNhQNkkl9jr1Ph/hU3le5/Fn4Mm/mal3tD1YAgjZiHWU/TAz8ky6+/jh
 wqvt/IaMYoET58OIGU7oFIt2+klXV0A7n9H839s9AhsUfTnBz7TrX57RgdIdaN6pxb8i
 RHCm4KupO+CaPZ0yuYr2JOT+i04Od18QVGHkZO7MU9pvULKvabGaqsg99sNA/+L/Znbg
 EDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840659; x=1788445459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zYlcCnF5+nqJXW6+Ev/3CBU7Gyj7/aEcJRms4AxcSLU=;
 b=q/26P87uX5ms+1nMs1m++E/VnRGvwvwOkiET4VNy+xuTPpEdY++eop/kUvdozUUdZC
 7lrZh8ATyEXxxvtaLkA6hgm1BZst9ObbLHFKs0I1Fl2Gp+AtmZfCt+J+NH/BfPhNpuZX
 C/SpWu0ustXs6SoX9ozxNpPDyLsqBjfo2KlPU2Z9+u3bBdCjwC7zXOnloCDKtQUaRI1K
 UnEM+KOuha4UdHgxCffUzN7R4qdswdrRZxU2fUUbuDDMnDtB5CpjHNbdLgxnIq8T1THO
 Snzkh9yFEKEY8ZMd9MflNT0ApgZxQtXmwtmGDYm7xsPd7a30kbJ84gwObJkCEqlwb4PW
 Pf/A==
X-Gm-Message-State: AFuF++kFsZ9+w1IU88/RkiPxyFUMTHLM2fWyR1Qn8oUbKfVjoiKA+BCK
 etxIMNl4NANTvBrhNGs6myMHIKUQ/k3hlfqToi9uYgbRWo+zRqc5KO/LL6XirheCU8M=
X-Gm-Gg: AR+sD11LXbsDBNM54mW9yaFu/+4ZiADhEGWm7/BpFA9Er+vEGB+Tn4PGTroqABWlik+
 2u6wpgrwVmbXfki+F8FHKeQBW79SHidS3qE/Z3nf0MyFTjPQu7/oMASbf4Cr1LMdAz00q4zxs78
 HQZRCXD9s0rb2XKdJlYfvTevIVcimJd9FJtWp82jnCdThSaUSD+3TmFEo+H7uE3fucrssHxkM3i
 9igwHwTPWhGEIQHLirAO/L6IYNGFQyt5KJVkJcBqlFHAz1wmJkwz5maI7M0DOgjKCRhB6fZ8lrz
 4XkNEV6GRTc2EmUUZDiKUZGRtC2oSVCFyF4HU7eTF6oohjdEdJ+tizrWu6SPC//aLFFwgVrzOrJ
 QS8V3Gsws+OSDNb1WKVeOpJVBJYCd41cDiSbk0pUI8Rrk5E720HHGd8rNRRjavz7OwjynYbhn5a
 x7FxHMPnIBBi+V1B58QOD61Ru6Y12N9GD79m132q2f5uG6wLia6i9Qo6V2dA==
X-Received: by 2002:a05:600c:19c6:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-499dc7252fcmr178652515e9.9.1787840658814; 
 Thu, 27 Aug 2026 07:24:18 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm66935835e9.4.2026.08.27.07.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:24:18 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 16:23:27 +0200
Subject: [PATCH 1/3] bus: ti-sysc: Tolerate disabled CLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-1-e2c43cecc71e@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=msp@baylibre.com;
 h=from:subject:message-id; bh=apbJgCwp9lClCw4Q+23FIWtfhUJo5lNlNaktxGfqXYA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJHtVmn6QdviYvzIl28tkt+PBSyXUfTt45UQen9MTpr
 rhzwG15RwkLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzEfTrDR8aFd8NqLs2ovNtj
 90RJ/s5sySlFzzUZvvL2KVl8mHAtmJGhM407VI3X/8rLgsyEP0sn8b0XnLjxXuLmH9qRXi6yqlv
 5AQ==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

When ti-sysc is probed in a limited SPL environment with disabled CLK
relying on the ROM setup for clocks, it should still be able to probe
successfully. Allow -ENOSYS as error during clk_get and clk_release.

The other calls to the clock framework in this driver will return 0 when
CLK is disabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/bus/ti-sysc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5f9f0a0d0b7b..d0395893519c 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -55,7 +55,7 @@ static int ti_sysc_get_one_clock(struct udevice *dev, enum ti_sysc_clocks index)
 
 	err = clk_get_by_name(dev, name, &priv->clocks[index]);
 	if (err) {
-		if (err == -ENODATA)
+		if (err == -ENODATA || err == -ENOSYS)
 			return 0;
 
 		dev_err(dev, "failed to get %s clock\n", name);
@@ -71,10 +71,12 @@ static int ti_sysc_put_clocks(struct udevice *dev)
 	int err;
 
 	err = clk_release_all(priv->clocks, priv->clocks_count);
-	if (err)
+	if (err && err != -ENOSYS) {
 		dev_err(dev, "failed to release all clocks\n");
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static int ti_sysc_get_clocks(struct udevice *dev)

-- 
2.55.0

