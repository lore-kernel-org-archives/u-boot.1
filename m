Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30533606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G4OsAq0F;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mL3/691S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09A478121A;
	Thu, 22 Oct 2026 07:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HcL1RS3k6BtV; Thu, 22 Oct 2026 07:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1784281215
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652963;
	b=C0EgXkSg61ccQwF+4+a1uQsVdONjSzEuh98J8+jUVmJHU92y+NZm2nNcgdDm5PBfL5r3
	 8KSaOXMadGWlYkJXRjHhewycZnQ+qgIBEuz0qNU1D7ppoEY5aMDqkboUDh6mSvZ+1PICY
	 dGI/gRVpGL72eYAnjqbgCf1N9jUoBGJgk+7I3iXvsLVWnynuGarPDyg/G/dGFYM42aL2g
	 rzPYtDB9aoDgkgn4HWF+Tm2b2b2Ri0r4w5Wl1c+BuSrXb8fIhCbIniBmaVkIzDkgKdvdP
	 UNr4velxQQ9m06AuzglgvnrQdS9+Ln2UeBK9BlwexlDHrxd4hBAu4x23h9XwphmvCgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652963;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RfBdzGqF6oquUau5Yvj341a2hzVm1WZZUFltYL37mNE=;
	b=pKlpRb6dCi37VMjGH/X25i+sAPjshXr6g/se/ffyR9+/ZXPPZy44m8AlSP7dKWWiZ4+n
	 x6W3M2TGvn6fAmfgVByo7Shg6u2jaj0+UYIEWzOI8EoPJkKi56aAjE+em8uTIvi0BqEgr
	 /txKW8zLPkWP0xf6u+4E6InbQKFYLNQrzAGRwclLV0q+jxNEtp9E+02jPmWR4zHHuYWjD
	 NqiGTfpc29sTRFkMopDwpklpmnH+f0OCQxkeD6iLDn4OyJ2uG6ba/8cYg9rfUeTFAof2c
	 XjxqevT0hjzBZumjcVj4DYBynzMmAZBXR/8SO9+bkAMKLIZOuzoJBvZG/4SqXYbq9TQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652963;
	bh=RfBdzGqF6oquUau5Yvj341a2hzVm1WZZUFltYL37mNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G4OsAq0FWX4vtegptfsJ5txbb4jFhbVve243IheQPE2L8jX3O8ed8i79R7BV6txGy
	 8iVzqg+RbD5rbMzqMLjMX9MezEaLQt64SQPg30zD3K7hzKEPq/6QD4c57lCflmOWKb
	 Iw479MoYPbuSYxJqNo6HXN8+55U83TCD6g0EX7YMqjd7y8tjCuq1db9UJCTu0+EFa/
	 PTumG8alCYn4h+VLWe1zgHt2Rf0BVwucXqLfZvlmj5/F4ewAA7gr5EMVvd5bjMAMRg
	 twU06UtF+Dl8eVne4sdYFfOLMwF51A+SuODMx6aEP4M2zoxNgxCD3FWd6Ts9HssmlK
	 isvsyJ2iaCAxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1784281215;
	Thu, 22 Oct 2026 07:09:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B2981AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51A424017B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAd14f9vfFSm for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42AD440042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652951;
 b=g4TDPkmxRPgHZx0Ylmf1VoWqAVLVCFSF6QZ69XPD/5bZaj1DD4bHFCVIYd51B08RcA04
 s25CEp2QV4DH9WJO6ZuL7dU5k/Ydy72Q999qpGcUHNGH43CIMqAKYKHB4Dj4psieZZEJG
 vJfCH06NKxz5dYdky4K/KyP+BuUPISl8Ecn60ZXodpeCTgoysdGzxDeXVU/orOLz3RYhR
 8eiTkqy7Jr2xkMqn2jLKgftcAJdwRYQ+j/8UUvyPeE1OAQXdQyvikMK8ImzIfijnmm12H
 BbwF8A6bsZP6mZB5Uj+6VTiyFQkQ1Zm+4RudrOa93OPxd7xB2qJNMJrxBb6UyA2JDhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=RfBdzGqF6oquUau5Yvj341a2hzVm1WZZUFltYL37mNE=;
 b=QANtwVDTO2KPKxVWprjr7vkv5kE63A3JWFVYbSViSlbnJVjXCAupB/B8ofYGFWEC1HNV
 frbPqKyoslkzIZtjxJK30TT4ObqoCwkPNG783YoJa+SIiZA0qXXpyZHyofECVIJDdzUbg
 6etqJV4+mErEHQB7j4fKxSysFQxPSUrdqgMKmhsLTPb6lVzWdDXEITIx6xlU/Pp0KA0jH
 bpcW91B9tTRl1/y0wGU+t7QzY+xZVHeY8FBzlv6q+cqepk2xDyndwqiTbrat6865/FsP8
 poI94yNrM4PfuYXmpT4vBiS0EV/isUYMkNfa92I75oXm47JMkAtNKG71VWN9g7vOgfA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="mL3/691S"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mL3/691S
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42AD440042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso1155908f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652949; x=1793257749;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RfBdzGqF6oquUau5Yvj341a2hzVm1WZZUFltYL37mNE=;
 b=mL3/691SNEF4kLBAJfXDYPG0X6YeXD1+ayvtQtjjZ0sv5roDdxr/adeeL6qIFq6k4t
 ew0EZMAhCCIQw5rQL0raBkE2nGsJOnXarQ/7FVHGAL3jneJmjPCQdqyJcTQsl2BB/QK0
 OGhd+iC/fBbujXNo1UJEjPYO7MqHn1bFQhjOE3F++vOTQ3ubJviH8f+7PdESupZSHwhg
 qlXeQf0OR7uBg/HXHCrNxUxcgDE7G7SaJDu/TD+Th8lfztENulEYgP21MTg1txG46OJY
 YLbGXvo9JcJ3C7BdAhzIpQ3ayt0uou9CmyODkhyPTyHhGcb7tYjCukmkUMtCDDbW6vTu
 6dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652949; x=1793257749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RfBdzGqF6oquUau5Yvj341a2hzVm1WZZUFltYL37mNE=;
 b=yn/Zr3u7tBJQpUOPfthlkrT5ZosO99fufo9lYtne1LiDqXYN773ZJK4mQQDmQZunXz
 mU4tsTf268yL94Ypw4/lAxa0HgwnmpE3+DvzCcBNH2Fh2SIvmg/HTHCrZJxbfRyU34gn
 k1cu7pWNWohV5+6m7wZXlqFr/lzOXYPMCywNx4OpWX4il3JPqfl8DOSOKXM+cIz4u0Ol
 8Y2Kc8bqGyT516R4qkDABAgPZFJpkwiRkielX2yzyiAlo92lB4H9q0zhQePyBzwvf7rQ
 hCtVEgtvSgfN9FV+XDJXh5mNy8kipguF+TaHplIDs8yiTYzY9u/tZR0eorh3X+O7VD30
 oO8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJzTgNVM7XmEKxPRr75Qn4kUeltuj6LVIMOiylST1lHnfywH0yNbMYfhRitJ+RD2VUy5hfPQM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIHHjA9NdQWZA/TpIBnufggIyPSGAnCtV3X3LkBgQw3ShdB0Z98
 mkYDu+0vVxmcEs75GFyWqEp1gDj14VjJJ9ffFl6uKVICQMWDWOwqpCiS
X-Gm-Gg: AYBFou0HzzGD8KGVAuB7ZQNkn/Q0W2IyCC9rw0U9oe27OqM7lLcMH9v7FMq/QTk4fLd
 tviHzXXKMKZd5mVP7l+rlw+ewI1mAXBNjZyUkvQTnzSHlg+NYUEeZTLwuHeZHZyh6NWi2VukYWr
 wZ2febHIF+YxxRK/N6tJR4ET7f1OBFrXICqO+p/aJBmdtHJTlz2eSOvXX/K16ZjVSVY8B42NaKV
 K6sVki0ZHF9+lJPOuOgrzR2f6qEkmpZ2sbhDswUBCEQeLE61T4XepyaZixX+MZ9+bytMTulQ+Uu
 KCyHJ2L1eJddZrAl6hAWbK81rpnid6hp74uohnNfQ7vxhXDNIV3lWYOkb2LNcKCK9XhgOEEGdNi
 lGI3CWmqIbbXVchMxWrCl/SP2VEf1CxQxGzBpDc4EY0JGrAetpYxoTCuwfCaipJq+XRdQB+Fe6T
 yFvnR/53qlrOsA6KGqz6/2JojnrDPhccYDwdFrNXffPVIjQJG0TV/ExP0DrSseNA4UcIgW9dLEo
 zrb9awZNjnTRjrpVEQAMkIdGu32TDp3fIcfJ7uwZSCUA7y+goph8eXUsK50Yg==
X-Received: by 2002:adf:e00f:0:20b0:488:8232:d16e with SMTP id
 ffacd0b85a97d-48e264a9823mr5852087f8f.45.1792652948916; 
 Thu, 22 Oct 2026 00:09:08 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:08 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 07/10] usb: ehci-vf: request the ID detect gpio through the
 device
Date: Thu, 22 Oct 2026 09:08:57 +0200
Message-ID: <20261022070900.616265-8-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The ID detect gpio of an OTG port is requested through the flat node,
the result is never checked and the gpio is never freed: a bad gpio
description or a failing read silently leaves the port in device mode,
and every probe after a "usb stop" fails to request the pin again and
reads it only because the failed request left the descriptor pointing
at it.

Request it through the device in the probe and fail the probe on any
error but a missing property, which keeps the port in device mode as
before. Free it in a remove hook and on the failing probe paths, so
that the probe after a "usb stop" can request it again.

The flat tree access was the last user of the global data pointer:
drop it.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v8:
    - Reviewed-by from Marek
    
    Changes in v7:
    - new patch, split out of the previous one on Marek's review
    - gpio_request_by_name() and dm_gpio_get_value() are checked; only a
      missing property is tolerated
    - the gpio is requested in the probe and freed in a new remove hook and
      on the failing probe paths, so the probe after a "usb stop" can
      request it again

 drivers/usb/host/ehci-vf.c | 61 +++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 90840cea92d..52ec83fc485 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <usb.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
@@ -37,8 +36,6 @@
 #define UCMD_RUN_STOP		(1 << 0) /* controller run/stop */
 #define UCMD_RESET			(1 << 1) /* controller reset */
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const unsigned phy_bases[] = {
 	USB_PHY0_BASE_ADDR,
 	USB_PHY1_BASE_ADDR,
@@ -162,7 +159,6 @@ struct ehci_vf_priv_data {
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	int node = dev_of_offset(dev);
 	fdt_addr_t phy_addr;
 	ofnode phy_node;
 	int i;
@@ -207,18 +203,6 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	if (priv->dr_mode == USB_DR_MODE_OTG) {
-		gpio_request_by_name_nodev(offset_to_ofnode(node),
-					   "fsl,cdet-gpio", 0, &priv->cdet_gpio,
-					   GPIOD_IS_IN);
-		if (dm_gpio_is_valid(&priv->cdet_gpio)) {
-			if (dm_gpio_get_value(&priv->cdet_gpio))
-				priv->init_type = USB_INIT_DEVICE;
-			else
-				priv->init_type = USB_INIT_HOST;
-		}
-	}
-
 	return 0;
 }
 
@@ -258,12 +242,27 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	if (priv->dr_mode == USB_DR_MODE_OTG) {
+		ret = gpio_request_by_name(dev, "fsl,cdet-gpio", 0,
+					   &priv->cdet_gpio, GPIOD_IS_IN);
+		if (ret && ret != -ENOENT)
+			return ret;
+		if (!ret) {
+			ret = dm_gpio_get_value(&priv->cdet_gpio);
+			if (ret < 0)
+				goto err_gpio;
+			priv->init_type = ret ? USB_INIT_DEVICE : USB_INIT_HOST;
+		}
+	}
+
 	ret = ehci_vf_common_init(ehci, priv->portnr);
 	if (ret)
-		return ret;
+		goto err_gpio;
 
-	if (priv->init_type != plat->init_type)
-		return -ENODEV;
+	if (priv->init_type != plat->init_type) {
+		ret = -ENODEV;
+		goto err_gpio;
+	}
 
 	if (priv->init_type == USB_INIT_HOST) {
 		setbits_le32(&ehci->usbmode, CM_HOST);
@@ -277,7 +276,17 @@ static int ehci_usb_probe(struct udevice *dev)
 	hcor = (struct ehci_hcor *)((uint32_t)hccr +
 				HC_LENGTH(ehci_readl(&hccr->cr_capbase)));
 
-	return ehci_register(dev, hccr, hcor, &vf_ehci_ops, 0, priv->init_type);
+	ret = ehci_register(dev, hccr, hcor, &vf_ehci_ops, 0, priv->init_type);
+	if (ret)
+		goto err_gpio;
+
+	return 0;
+
+err_gpio:
+	if (dm_gpio_is_valid(&priv->cdet_gpio))
+		dm_gpio_free(dev, &priv->cdet_gpio);
+
+	return ret;
 }
 
 static const struct udevice_id vf_usb_ids[] = {
@@ -285,12 +294,22 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
+static int ehci_usb_remove(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+
+	if (dm_gpio_is_valid(&priv->cdet_gpio))
+		dm_gpio_free(dev, &priv->cdet_gpio);
+
+	return ehci_deregister(dev);
+}
+
 U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
 	.probe = ehci_usb_probe,
-	.remove = ehci_deregister,
+	.remove = ehci_usb_remove,
 	.ops = &ehci_usb_ops,
 	.of_to_plat = vf_usb_of_to_plat,
 	.plat_auto	= sizeof(struct usb_plat),
-- 
2.55.0

