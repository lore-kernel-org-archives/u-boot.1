Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB5606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GWzt+Vo7;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=1DfWLuaT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F37154089C;
	Wed, 21 Oct 2026 16:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVaC8BqYWyHr; Wed, 21 Oct 2026 16:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C6E140655
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598712;
	b=m6+07q3HTs1DMqhECa8RNcgBRZMXM0O5eevV8KInpAOhF1Prp2mfifJteAmOWiOlqSzk
	 V4fge+tsTfBrX+f3H3U9phf06lBw+PrCp1ueyJh2YhHuhZAUL6hb9u/QZUmX4fMUsaiPa
	 pjbNUgPSgg/Kjzzl4vG+Z++4wEz1wYgNci5a1KtnoA6Ope9RUzmFw60sMQLZab4/u8dLK
	 iUb/X7QQHm6b5Zp3oX5p9lZOO0YCK1qK94oj7ug2l29trSKWvYiNiWYWl6jCbNuaTxZ+f
	 YeUE/vT491j4bpt/oPjmLAEl20PDalbE/w4myod/Mky6euHj/mSqL0PqJgwxwddNNIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X43B1zpUZcgJJZMTyy4LNrpw3FqA3XIgqsLC4tjaaYM=;
	b=p3ESN3MgvDXqzS3vYZaPZ4Il0nahBI1yCGANOEgPW2DEXh3B+N5jxzuUXT+B1KAVLUtQ
	 OooLwHyOyAFIzIwjM4aJbqwkG1UlXQoMB3l5+soHUqunF+X3oIcUMIySuZwS+71JRkl5K
	 U2HBeB2qVo88o4+OJY28U/IMNzqpgrjnxN7OWIkUJUOhSweUocKb6GS4InyIQepPu4vzQ
	 6fW8MnXhPhtZxFK6cLNCGYDSI4dYNNGDBXqQOZC+U1V/TIQAzkrE2tqrrXs+8S0k0f+ZQ
	 E7BtUbs5gASajAhDwMgH8K2UcnyyUDi8RaMcb1o3Q1typVnoliqYr4EEWTWFPyQwYgg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598712;
	bh=X43B1zpUZcgJJZMTyy4LNrpw3FqA3XIgqsLC4tjaaYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GWzt+Vo7qNW9SCvTWfCjNh85fRxJ/uLh+poPAXV/EF6MW2/J+yIzbBqBbYRa3odzC
	 SITm90pg+frFG1ckXBg1qLT3lhw3exNeDd17E3y3yVpcqh47djQev6w85VOpuRWIi/
	 qkMjKIhYE3H8+qChDyouWd4wP++cKIQDUL3O+PyULEbxbOVVU/R1KPvG/pmadrnhh4
	 boz8+sIh3IaXMWDScPxJd6vmKrrUr1Qx6GsOxihccSxQVBuJequUu+EmnauC3JwLhE
	 Q3ycqVBQer1g9JLojK4w4XC3yrWCjB14xu97KiUPxVtjrS5LhV7kktAq9owI9QWQ2L
	 Bm9RVk9nkDhLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C6E140655;
	Wed, 21 Oct 2026 16:05:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EB8395C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67B5281103
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOkFk1wWoi3O for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 022CD80F88
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598710;
 b=DAuNSY9THxwSKJ/B73+iLrf6srCJtsuSS8484JwnVZLUSmYYo3Yn/q52LczfokQmrz64
 JF1hxL6XwQ+S/UZo6BdEMDhI67dvyEuNhyydXRHSA/bEV+obWu66SYhA501TFaH4yMPgU
 pYzMvMWm/ulIU5l2tl8Y3FOb2ITPSTfPDu4h9ETvhLiP0z5L/rw3EJzmpuRBfndY6UhAN
 UVfbwK0uYdwrMfNqFc7fia9E6Dz+wETT7hHJtdGNKXZekxh96JJap2SiIv8FG/7MVj0rf
 I77YwrFpRkkp9gd+i3N0xn0xRlv6L0gP5LGKfnI4bjrLaLwzr6g/Bl2KOW8Fh2e0Qew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=X43B1zpUZcgJJZMTyy4LNrpw3FqA3XIgqsLC4tjaaYM=;
 b=lUJjf7zCc64+OiWzFnqSJHmaK2KgyxgnrZ2u4WUDD+pJQ7ZTLICR5ClqFuwdQ9RSx/xo
 U0lbZNkhkEhgSYCHCyDoxVlengLEVR4q9tuhO5a07zmMMFQXKTkRoCBF5Q3K3tgNhsQ+4
 yQ6F+7FkO6MmbUkvdAkecM3LiV7MtSAW4lygXk/am4CLopN+Oqit8sbC9gebL6/1QG9Me
 Kxk5Tex76HXT0YLKaFAUhzMp04SABfYDkb3dPTw/fG7OqeXMEWRwH7eHqMQCU8SeorM0T
 fyCj7fwxTiJ+EHX4AQdd//k6s2rrHxIuMVhehtM38ua9dowc7eZTTVppAAU9MDaOJpQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=1DfWLuaT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=1DfWLuaT
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 022CD80F88
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:08 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso7738555e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792598706; x=1793203506;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X43B1zpUZcgJJZMTyy4LNrpw3FqA3XIgqsLC4tjaaYM=;
 b=1DfWLuaT8LKRXBLeLed6kJI848Re5a3Twl1k3rivdDqc86EfQ3ou41iJYD595QZGpp
 T/WVOiCve81wtTGABOaV1b052BbP9AUnjzZtYWyHWQ0qeAITihekRo0tDcmSbFtfelTM
 sAxQTb14+/SFT2AN7LacjFgAhHYNRpfAMj78lV/dqVQ2Cu/D16GpPG+UHfDiaMZSHIY9
 dPIGBKQ+KwqTpppkiQVk/oA20+woiIdCIBJ4bJVUlJgWhxpwxmAMx/u1tJARj3jOyJYu
 edMerfTXMY5EJ9xtxcaJgH29+K1lgWvwWHkldQnoppPQ1MN7tY94PH8+VPYPKcToeRFn
 1Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598706; x=1793203506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X43B1zpUZcgJJZMTyy4LNrpw3FqA3XIgqsLC4tjaaYM=;
 b=lQ4HlPyB/hQyfs1Bj7iBHMQrzM8e7P6hRruWv7+iYDAoc5A15jZQF/IALCiSVTklAO
 emlEX3yrBKtLiYRrzBdy39k9Cuf027QifpfA6NMXntzrazwNfjUGL3P+BvPutroBklJB
 OmpIeaK2pQNBHq94eTCw5dPOF3GfEsFboh7SdIb01Ymq0JRbPEDuQZdveVK9/o09JmBM
 P8l4yk5NmPskC3RKUBuYbLD9uTqGaIhzHb3+CuWSP/ku+4PwjGlovN0B0o4tkAG4wd3o
 xJLYqrSN6rCSvB5udEKM1BSPWuw4eB7jeTs1o8TLIuagSXBiY6aJZoqktbljUEgmbk3q
 1qDA==
X-Gm-Message-State: AFq9FYK0gbiqQvBIED+A/G4EqV5p5cK15ERY3dEAC8ikbe407TfulYeS
 UQC01D6On7lsS3xGI+BaXPVsu6wPO3zatV6EX7McO9IRFv/R5rPTwUXMy5bqd2AA5Nw=
X-Gm-Gg: AYBFou1qRUlQA8jxIrHD13zr7FHSeO0jSuE/XwXiHrimkqm8SQxt5GREXAgQNyXNKRM
 1RE3bThl8mpNH2/A17BeNtVzUlQWuiAtqr7kPPyP2fDnWYU/+GQNi+40WxhIM310tMq6tvwxelT
 EfQdQprwbb7NicKr+GL9c1zs+q9MQQO3hvgN10w5ZD4awXNwo2KpTRIHhvFuCbzgb53Q8Vh17qi
 XI6GUhPRKD7wAFOa0fCWZTiVGaMTKjvRqB21PUPjxd6juRz9mQkJHc4ZUUAykPaZOpUPLfJfL1F
 ng3/uCbbCQ65nZG2Jw5TzEF9d7Fr5L55o9WZq1pn43ey0RkqCfOrz4NKOxQtpXu0XF+57K62YHh
 ebUqPOLVQITlJ9W+MzgfwhYFmYVTaaYRuHiqqDmVY8XxR09boDW3QHeqNbXtZTNwkkr+74bbsEy
 6uJdfUhq9ZRK/pXLmnntzzdQ8+0QMbNpB5Wd7AzUAZfZMWXR79Hxjod7kTIX1Xe2/Pqwc3/pxci
 MrZqRa/msLYzWxBQJaJdChLZYYDSd4URYgeYbzBq8qgTiqx9GwQ6gkgKRwybKJ/r5sXBGV1uOQM
 OzufN/2P4PGTKZ7uP5/K9nJWuSH2PlLukTfO
X-Received: by 2002:a05:600c:46d3:b0:4a1:97c6:d2e8 with SMTP id
 5b1f17b1804b1-4a1fdd234a6mr55520985e9.32.1792598706295; 
 Wed, 21 Oct 2026 09:05:06 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd629bbsm54075975e9.5.2026.10.21.09.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 20:04:46 +0400
Subject: [PATCH v3 1/4] ufs: report the active boot logical unit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-ufs-spl-boot-wlu-v3-1-064e73cd2209@flipper.net>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Alexey Charkov <alchark@flipper.net>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5537; i=alchark@flipper.net;
 h=from:subject:message-id; bh=CQ9OtpguHT0W2dmSLsGj95UHOxvmdYi+aDYWXXo84z4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdeLRyh+sZtu973jTNTm/l5tnQOGX208NHi6JWpptcn
 HbdMeOdSsdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTLWjK8Feo5t+SfSkzPy0+cvLqOpG2hivBn7bz6AZee6xWIn7oeZw6I0Nv+co
 Qi84tTx9cmuoVXyvy+6JLekhCYYZjg9PlUBXjOjYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A UFS device boots from whichever logical unit carries the bBootLunID
that bBootLunEn selects, and presents it through the boot well known
logical unit. Resolve the same mapping on the host, so that a loader can
follow an A/B switch while reading an ordinary logical unit with
geometry of its own.

Walk only the units the device can have, as bMaxNumberLU says, so that a
miss costs a handful of queries rather than one per possible LUN. Pass
over disabled units, which cannot be booted from even if they carry a
matching bBootLunID, and units whose descriptor cannot be read, as
another unit may still be the boot LU.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/ufs/ufs-uclass.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h        | 39 +++++++++++++++++++++++++++++++++
 include/ufs.h            | 17 +++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 2ca4fb2a0209..969bcece5e42 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2296,6 +2296,62 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	return 0;
 }
 
+/*
+ * A query the device rejects fails with its positive query response code
+ * rather than an errno, which a caller expecting either a LUN or a -ve errno
+ * would take for a LUN.
+ */
+static int ufs_query_errno(int err)
+{
+	return err > 0 ? -EIO : err;
+}
+
+int ufs_get_boot_lun(struct udevice *scsi_dev)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	int err, i, num_lun, ret = -ENOENT;
+	u8 max_num_lun = 0, unit[2] = {};
+	u32 boot_lun_en;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				      QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0,
+				      &boot_lun_en);
+	if (err)
+		return ufs_query_errno(err);
+
+	/* Booting is turned off, so no unit is the boot LU */
+	if (boot_lun_en == UFS_BOOT_LUN_DISABLED)
+		return -ENOENT;
+
+	err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0,
+				     GEOMETRY_DESC_PARAM_MAX_NUM_LUN,
+				     &max_num_lun, 1);
+	if (err)
+		return ufs_query_errno(err);
+
+	num_lun = max_num_lun == UFS_MAX_NUM_LUN_32 ? 32 : 8;
+
+	for (i = 0; i < num_lun; i++) {
+		/* bLUEnable and bBootLunID are adjacent, so read both at once */
+		err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, i,
+					     UNIT_DESC_PARAM_LU_ENABLE,
+					     unit, sizeof(unit));
+		if (err) {
+			/* Another unit may still be the boot LU */
+			ret = ufs_query_errno(err);
+			continue;
+		}
+
+		if (unit[0] && unit[1] == boot_lun_en)
+			return i;
+	}
+
+	dev_err(hba->dev, "No enabled logical unit is boot LU %u\n",
+		boot_lun_en);
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
 {
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 9f55735602b1..6ee83042a645 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -399,6 +399,45 @@ enum device_desc_param {
 	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
 };
 
+/* Unit descriptor parameters offsets in bytes */
+enum unit_desc_param {
+	UNIT_DESC_PARAM_LEN			= 0x0,
+	UNIT_DESC_PARAM_TYPE			= 0x1,
+	UNIT_DESC_PARAM_UNIT_INDEX		= 0x2,
+	UNIT_DESC_PARAM_LU_ENABLE		= 0x3,
+	UNIT_DESC_PARAM_BOOT_LUN_ID		= 0x4,
+	UNIT_DESC_PARAM_LU_WR_PROTECT		= 0x5,
+	UNIT_DESC_PARAM_LU_Q_DEPTH		= 0x6,
+	UNIT_DESC_PARAM_PSA_SENSITIVE		= 0x7,
+	UNIT_DESC_PARAM_MEM_TYPE		= 0x8,
+	UNIT_DESC_PARAM_DATA_RELIABILITY	= 0x9,
+	UNIT_DESC_PARAM_LOGICAL_BLK_SIZE	= 0xA,
+	UNIT_DESC_PARAM_LOGICAL_BLK_COUNT	= 0xB,
+	UNIT_DESC_PARAM_ERASE_BLK_SIZE		= 0x13,
+	UNIT_DESC_PARAM_PROVISIONING_TYPE	= 0x17,
+	UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
+	UNIT_DESC_PARAM_CTX_CAPABILITIES	= 0x20,
+	UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1	= 0x22,
+};
+
+/* Geometry descriptor parameters offsets in bytes */
+enum geometry_desc_param {
+	GEOMETRY_DESC_PARAM_MAX_NUM_LUN		= 0xC,
+};
+
+/* Value of bMaxNumberLU in the geometry descriptor */
+enum ufs_max_num_lun {
+	UFS_MAX_NUM_LUN_8			= 0x0,
+	UFS_MAX_NUM_LUN_32			= 0x1,
+};
+
+/* Value of bBootLunEn, and of bBootLunID in the unit descriptor */
+enum ufs_boot_lun_id {
+	UFS_BOOT_LUN_DISABLED			= 0x0,
+	UFS_BOOT_LUN_A				= 0x1,
+	UFS_BOOT_LUN_B				= 0x2,
+};
+
 struct ufs_hba;
 
 enum {
diff --git a/include/ufs.h b/include/ufs.h
index a8b7d370f782..1c307569cdc5 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,6 +20,23 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+/**
+ * ufs_get_boot_lun() - find the logical unit the device boots from
+ *
+ * The bBootLunEn attribute selects boot LU A or boot LU B, and the device
+ * presents whichever logical unit carries that bBootLunID through its boot
+ * well known logical unit. Resolve the same mapping, so that the caller can
+ * read the active boot LU as an ordinary logical unit.
+ *
+ * @scsi_dev: SCSI device of the UFS host controller
+ *
+ * Return: LUN of the active boot LU, -ENOENT if booting is disabled or no
+ * enabled logical unit carries the selected bBootLunID, -EIO if the device
+ * rejects a query, other -ve on error. A failed read of one unit descriptor
+ * does not stop the search, but is returned if no unit matches.
+ */
+int ufs_get_boot_lun(struct udevice *scsi_dev);
+
 #define UFS_RPMB_CID_SIZE	16
 #define UFS_RPMB_NUM_REGIONS	4
 

-- 
2.55.0

