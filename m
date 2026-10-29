Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E41606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sylm1EAO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BLJixg8A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B9B40759;
	Thu, 29 Oct 2026 13:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDBxMqTDeBvr; Thu, 29 Oct 2026 13:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 07FDA40797
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281669;
	b=m909428waNrKUBf9NaG/BJySvwYRkDeUZJW6BU9kmxXIp35EqAR3s5Myb4/rwkh6lhDx
	 l/G3KEcFvkk1EFq4JWPMICURSEez5peADL/jecewMG5fiXJJ9zWEfipZpHPeEj0y60pDD
	 dHDev9g5rmqyGzXRr3IKjHIz4JXt9gZqLOqncldldRa+KKXWCga9I6Gqi1OLEQv9OHcae
	 GlZyjEMwE6uqBM+y9ew+iUZFMP3vqvMJ98eGuqB24TyOXCDN/ZEwMeRSB24Fa9Q8DNhYo
	 uBn8R1x47tty5gVkRIMkKL0W8mPc7BkxPmnednJZ16278m/vG88RWUZGaFJ2lLgJBlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XikUASoqOHVBfRQrS/MruQzTjRODwAXIHu0PP0YAsT8=;
	b=KROF0lDawTr26UP6SqZxDIYRYPJHEn40UQXaqzLKhiytEQd2AnY1D/qZqFKq/B0Q77QV
	 VuCS5NMGzrNlVT83AuEgcxK2tMIw3CEGre6IPdYYz5dbN0RaxMkJZTFyuODJxOl0f5PEt
	 FIfj/54E5YmqSz3vGiht0v5UN+wVeE006+uBUeR20QbHTCqwn4GU0gcCHQlokGj7zPIls
	 ukiOfyn5XhiJ7Ili/wClNn1cKFrmvbZFNYl3KYzWYd9W2Ub4KzFKgC7t1tnENhnPdFHwK
	 7v4ubjQWyZbaK2xjqdDj9vSlzKR+2Zt0VtV4BBxcwkgQ+cAmmk20ChgB1MDnQ9Xey5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281669;
	bh=XikUASoqOHVBfRQrS/MruQzTjRODwAXIHu0PP0YAsT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sylm1EAOxKUDHJpi1V4rp0DHRYZB4AzfpJbY1bcwpT+qfURkvdG8cDIYbxWs+G22y
	 m3vpHECCR/mzFB7z7mmCg6nU7XaxdYHKX1IMU1psiM/2fyPd6RQWcVSo+ICqQoSukp
	 S2C6G9v/+rYyEN7d9P+Hzl9TDpSA5qHJUb+wBu4D9xWzPhhLyaTKCzq2KjaHqW4n5u
	 LoIF2DCF3dHC+oI3/umPoi+5/JsEa9FOX3tdO83Sh9hxhHFNbFieqvIRlu8hvStqg2
	 GjdcJyUeGupy0PThjVZYnDkZV7dT4BLPfcCoVXwmkcVR6nF4g7cyEOw6cgnTGuWzxm
	 B8ET4l/ZRDltQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07FDA40797;
	Thu, 29 Oct 2026 13:47:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB59DDD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D976D40318
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vghpoooHmgbS for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 276A840024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281666;
 b=cCntAsoEdfQvurxRXz4c86UsjoGx8x3h5ROr3GPkEu/V869XBJpRKIrVs6ht/nHvssEW
 746loIPwdQts3vc2XuaPNPhMudbz7viINE3XRkT4PzYTMnUpfBv2FhPNRlVRA6JBi/1uL
 GVajEYIBUxOET0X/3b2xg8kl4Bo0Xk/SCkNJ5+MGKv0+BG14miysgdrijkX8F5n8yA/3y
 3x7Cuo5mVbX5dvvajee7/QTsIrEA+3bkVWaf2hVYcZN4iH//zlWoU/km6IlUzmQB8NeaY
 M9sY/AjYKxrSXfKQLCqA18dl12HMtqA0H/fhTPxjL+j/+KJnrm2H1on4feevGLcOMzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281666;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XikUASoqOHVBfRQrS/MruQzTjRODwAXIHu0PP0YAsT8=;
 b=FOdmTyfL8Ir42wfdplIh+vN8Gg+nW7UDPhCUvTSpoKUVbgMXPx7GBvWeW6MNYs+SYX1y
 5uihSl7h0TsUJwGOCjUppxM6cB/SFHGUtCAY+yA/WdFE+d7bdHONTwf5f1UYMZU0GLnNn
 LTbVq4Pw38L9SdbrdOR+dYntYslZDq8ZnWSVOdwCcDBRV+0uANw4b+UcjpY107XVCJaNj
 nHJjHOgROC/mxujcu/oVb+WaLT6e5p+LYFI87gMafkgNbr/LO7/MnIYBEJm6DOYa+BhMg
 LRvMm+/XZdGvDKjC7a1KGYFbmY8+yOdvppssrKXJtbTrjnqRQbiZR6q6n3dAl061MOA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BLJixg8A; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BLJixg8A
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 276A840024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:45 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3282db206d3so1211902eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281665; x=1793886465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XikUASoqOHVBfRQrS/MruQzTjRODwAXIHu0PP0YAsT8=;
 b=BLJixg8AK0b0zASkhsXw+MurToOVmcEameR8EomRY59hnqtYbXRvV6gEQLj9UMDndh
 cevJ/UjSyE4x6TXy4nLsXGIjM6J6mtmZUnqnkuAq2GG2jXgdgBZZGzLM9Q5zY5tnXPPs
 1n+2xRjGApn6ekPIm6BMO9U+ODqhDTSGLbNrr7I2nD0Jju5DULaIxhTcvaa834FjdOim
 +0loMkvw34NGcDh9MQX04KfP7W1keW7+Tfn6T3gf+ZYWbU2ikSIgtEq0oPwE1pKCxkSB
 BOoYTofH7NonZjSxpJ2ACK6VCmLzT1CgtoFmnMLKaRFrpkJNVmNP2LcpStoyNPD3emYx
 qhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281665; x=1793886465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XikUASoqOHVBfRQrS/MruQzTjRODwAXIHu0PP0YAsT8=;
 b=bEL8d/qM9HTYs9IWLeqTdSbEw6SO49KLfl0H/vaPrWDsCTQtsBuRrPkzJodIbGnQTa
 SLs3qy+iQ7xh8RWV7NPTrR+FFn4mHLb/tO0RcR5htg0MltGfj9WgH3N/1AT/yN4MMRfO
 jZuU50bMNyYBKxlZlaCpOY3n7wV0edqnPIkKzQkKuiRm22AhtEDvDaIwTzgof+uaNM2F
 +Uc6p5+x5mUfiDoc7kAJFzGz+tE7nzCxC7XwvQufDJoMffhAS/jCau2HOMq9KX5k1hnj
 FREuMtA5cS8o2wm7q+mMqEfUgYPfKNho8ybW+SAtRNmxY3ke4qbzRzxlCRcLogj1lAB0
 B7RQ==
X-Gm-Message-State: AFq9FYLMBsKsplWJDqcG6T95TvDh2NevisOwof7Qjd3ozZO/RriQRhBj
 y5zcKKuVVurISt9ob/l67cdMhZXxYxcEiGOXPE97vF5+8tPMxDOGXJGztHP2Lg==
X-Gm-Gg: AYBFou2bqoPtDGYwP4BGNC9uhO1vl/MvaYoohLJocuf7NF/wF0xm0HUgp9aXZoPvW7i
 x0ublxQgGikaGUx9E7v3OiaSflW6gHm4/DqpEQ+65+wa1ODoE3q24uDGJygHlSpQjFZ7zRYrsw4
 3pPJfWhHxSPpZgc0kzGPh/N9XJnCCZg5ml7mF6MuLwjliSNXO4SsBHpGKzgnu8YYsGtFpDdY2vd
 H121c1a1l/ypppn6knnZKagF+3PdLuqvAz78GDMzTgA4FiI3h2v16PEzgKaYjSG3Nw35KOXga11
 egvzQr1TlN6EmqmDaMZDbhaIPJipGQynBqWIctc/B5kY8LxLufxupgvinvfXrgtHSGDaxdXYey5
 n5qjicGp108pXe2WPH9917X8jIIT4ZWqlFZo+8fzgNs14QvBVZNxvY5NCmAne4L/sgblxkF3yQA
 VQMIOMxm/vURDANfD87CQmsxAC3DAUl5M+7QuR7hQKlAnl8xj6LJ89qBuLnyKABPIiqCik/i06o
 aVCGaBB8Oc/c+xa2uM2ug0piMHZCr7rD4Fa8nSX0qnunYJgWanYpHNZTQQzXMJ/Z7079fJo5GlD
 st7NbG7dj8nZEozWfl3A3F+QD4ndSQ==
X-Received: by 2002:a05:7301:df49:b0:36a:1e0c:e28d with SMTP id
 5a478bee46e88-36a202bdba8mr8115659eec.4.1793281664472; 
 Thu, 29 Oct 2026 06:47:44 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:43 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v1 3/6] mmc: spacemit_sdhci: Handle missing pinctrl states
Date: Thu, 29 Oct 2026 19:16:52 +0530
Message-ID: <20261029134705.3767-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029134705.3767-1-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check for available pinctrl states before selecting them in the
SpacemiT SDHCI driver.

Skip pinctrl selection when the device does not define a default
state, allowing eMMC configurations without pinctrl properties
to work without spurious pinctrl errors.

Select the UHS pinctrl state only when it is defined, and log
errors when pinctrl state selection fails.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 836201ce83c..668555b94e1 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -355,10 +355,27 @@ static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
 	return mmc->cfg->b_max;
 }
 
+static bool spacemit_sdhci_has_pinctrl_state(struct udevice *dev,
+					     const char *state_name)
+{
+	char propname[20];
+	int state;
+
+	state = dev_read_stringlist_search(dev, "pinctrl-names",
+					   state_name);
+	if (state < 0)
+		return false;
+
+	snprintf(propname, sizeof(propname), "pinctrl-%d", state);
+
+	return !!dev_read_prop(dev, propname, NULL);
+}
+
 static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
 	u32 reg;
+	int ret;
 
 	spacemit_sdhci_set_voltage(host);
 
@@ -383,16 +400,26 @@ static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
 	sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
 
 	/* Set pinctrl state based on selected timing mode */
-	if (IS_ENABLED(CONFIG_PINCTRL)) {
+	if (IS_ENABLED(CONFIG_PINCTRL) &&
+	    spacemit_sdhci_has_pinctrl_state(mmc->dev, "default")) {
 		switch (mmc->selected_mode) {
 		case UHS_SDR12:
 		case UHS_SDR25:
 		case UHS_SDR50:
 		case UHS_SDR104:
-			pinctrl_select_state(mmc->dev, "uhs");
+			if (spacemit_sdhci_has_pinctrl_state(mmc->dev, "uhs")) {
+				ret = pinctrl_select_state(mmc->dev, "uhs");
+				if (ret)
+					log_err("SDHCI %s: uhs pinctrl selection failed: %d\n",
+						mmc->dev->name, ret);
+			}
 			break;
+
 		default:
-			pinctrl_select_state(mmc->dev, "default");
+			ret = pinctrl_select_state(mmc->dev, "default");
+			if (ret)
+				log_err("SDHCI %s: default pinctrl selection failed: %d\n",
+					mmc->dev->name, ret);
 			break;
 		}
 	}
-- 
2.56.0

