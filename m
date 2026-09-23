Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD7DC9830E
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 17:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22566605E3;
	Wed, 23 Sep 2026 17:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AaH6lE-mF2ns; Wed, 23 Sep 2026 17:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5066960880
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790183029;
	b=m/XOrAkiDZKsev5tcSTBSaZ8DHldXgDoDHASc8j77g/2PDoy/vOT3Q2615wEh3+DsdoG
	 bvge48uJg340hhjYnKqN6c+zlgouNNYwl0eCAUQlJFMb0znKa0ITnx35POpTLzSybjwxD
	 CgQMpnEDcsj64ED7H7vgKuNezDFB27GuBNLSyjlOQbIBgKD0gakVuafyzTqA3+tikJYiz
	 Nw9PjSyiqMx+jRSqSWvfUv3T1ziwTrtetUpq/R0APLxEy2ZM7DCdzJz+L7PIs/MN1WEah
	 +n7LwTqs7cTANpYHUWJGFmC2n6mixD/i87P+bbOo15HH/jozlx4CF7Vt9TunhSBu1Wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790183029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OXcoO2+jRerT1yKpMJlp///7Is7paCSAE+adxesGuro=;
	b=cwmQJnXakGGEy3m2Bmj7lf4U5TuMlwpNxLKnp0zskINqmP/X21qwHOhC60dC2QNDSknb
	 QedevYrhZMiVvq6tKZOb1CDYTL+IwQ/0t1EVO272VnLSaF9fwrKE0HLb6UmhQ1zb7C5pZ
	 5+Gxkv8fmH3vBBbjpmnvawmKLO6FxmXJ5Dacuw702zArub+T+EPGSdXZ74qjNZM48S91j
	 l9R6GKg9PhMnRPcflRfy//HwrR/7o3Xj14x22/0kDta6q2VghYwEv0DMqS85ZDUuU8FKP
	 2+9S3uh32pVR6wVx51hxHQK+mfKW6zd5obqa3PnEdMxr1FQttFHOYMRNDXwGImll3Mw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790183029;
	bh=OXcoO2+jRerT1yKpMJlp///7Is7paCSAE+adxesGuro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hd5cWCRSRYCkPyFUbSyHvmpP855wu33CSIUH35PSEO/LBINUJKnzCymUsubdvqygA
	 j/BfsR4EYPlTjy+Cz6HylXPLXSZypqwLhrYyft9Ufr1Of/LGBOp2UQxvEIro/AwBxN
	 n9WCl6UTdixnrKmCcnpuMqcwSZpTTwDcR8SNFm1VmQiB6RwpREgQKEasGw87TDHl71
	 qoiDPD2t/0vK9LCk7WWYOq+q2xCiCPW2dmtFshmAZ8/NWV4/j9ejvx7XyL1f9owecH
	 hIIMpZxd/KDeaHyZxjC459S59bj65RYRYAe5FvSXXKCgsOVf/RLkXW9gvAtgN8nBG3
	 yYOmLso9+aRgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5066960880;
	Wed, 23 Sep 2026 17:03:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A8BF498
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3114A40348
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:47:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijIk-UyS-UYE for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:47:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 72CF340282
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178422;
 b=pfyzlu/I/2GMpQTPvhTkXX3nKXm4osaOchnjWCyK/hElRFuZy5X0uiKh/6zmP4BnXxTL
 mx2ZNgJqAMQcvNWL1QJAHxDa1Yy/eR8yrE5LLV2lCwDofAvhYn9jOEQ/eiBZgwDK6+OpD
 X4zNm1QJnultPz7ePXGPNBS6GbsGHJQPOkeE/hFr/m8wisFcLj3weJwDBs03d8TCKGqmh
 5p2mdfvnbx7O0dc70rmLzVy3r4yrZDdcQK6jyG6JdF7opmbdru0d2JN8XfjHpIjUfnfiH
 2zwzIh+FC6n/ibQyKsMznRIlFyeJiuo6H0TO29H+LCAberYbzzdKn9/JsyGU0gPMdRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178422;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=OXcoO2+jRerT1yKpMJlp///7Is7paCSAE+adxesGuro=;
 b=d4NqvTbj4XRoeo85e0on1EmDJQHUTnEQXgiZp3BAViB1awubdK88QFqAdSYgFiEEUnYo
 u1tdDLO5c5A+7zUg247PLSNJahyai8EVAwAh6mrgQHoy7MPiO8aIeJHfuGe5OSWxNBu3C
 Cv8GiWxutPJN4ngaZfnBbmx9ZqXl/p5vlid97lEfNjhVNTxlxY2Bw98omf7ksqR70lFNb
 yN/sj/AxzB1uNHMbEubIPDXuIMSck0y6lNKRAiheo2xu624C3B1e7l3SSOr1J8CMj4ueE
 F7KY8dZb0lpcTKDYlcKrMgr7GAzDGiv7KaQpO5Oxj0u5a4p2dh7/OzbChOagynW1vow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=BcvcoCVq; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=BcvcoCVq
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72CF340282
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:47:01 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB9AA3F57F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790178419;
 bh=OXcoO2+jRerT1yKpMJlp///7Is7paCSAE+adxesGuro=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BcvcoCVq+Al4quHzxvC+FDY+XgNCiLbhKFHfZ3ZlhG995ubL2DsQ6awDQ1UfWZuKK
 SbrRH7XnyJwC6rVkzXHnQZvN1TN9zhyVHvttFI4Zye6uI7sZO7n00fftBamAijOa+q
 vh5c5l5I8juWuaR9PiNG5X4AfDyZh0gBD5qg3zAc7tiYRV9iO3UryxZAMKevTz7r5d
 iTRT4xCHdrjQpQ2dBB1UQ2gKPI/xPHpPQIPeidGQdKZ6M5SYrr0KW6y3bXo7D+pq9j
 UTH9BvFaEP39DEtH6SQkXHsb/hLzexsuCqmYDwqpwCc05vfjqe88V/MvBOn0IRuRI9
 nHZDhP1jTowMCMn5SSpywInJ/YRItoJcgetpa2QPf8moqi5MZgbO7/oT3zUZSFlzws
 G526cmDYsxX4MLblwZ48T3U0wl1D/cQcSScTwZD66GaOO1epleAe+GFuJzridwkTm6
 i5B4OW6YgQ+6d+in5eMDGTFUbD47jEYosOu7yxdfoOw9MNA5pGVK2Y1cgmMYbjQ92S
 wvy83fzd1mX8j0ls6DS76yNS9BIadbVfHhcN1HnWa1QZBoRI2j1HK3Q5WWe5A3scrO
 StHtSAp+iXB/2DVSKhh1Ag/Yz+ShC2Hz70p1xutadYOKWEwYr0okowWYDpMVHE1n9d
 T1i1Au/mLcRXMf62opqnV+Ew=
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-486a057f5b9so1416567fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178418; x=1790783218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OXcoO2+jRerT1yKpMJlp///7Is7paCSAE+adxesGuro=;
 b=qgQBV/kTHqqMr2g+xFJjUGy219s4NNdjNERZVxPHFPdJEoZISZMfj9pn/cI4u5JLob
 Ezp0s/ex74v2hF+9UKfaWJmmYyY0w6tySscRg4ACAGmLwxNOtUJF+YVqXFkaLeMqNQgV
 vzoWMTeW1OT+BveXizkjSUZiDsnE6xBYCWsKijuA246W6aeaXgiTP8kFubTcLoL0Ne0U
 tXSqOruw1XKq1VvbW5rQ6eEijgBhHmVyFzklJqcWszjgz82Df6QqIQZ7Ygaz5b9INar2
 vfy5kIUJU7aA+JeM4MKpgcAfEXxM0N/uzEYa/iq0S0tn1cVJ/tamNQWZycn4lAd24IZI
 jw/A==
X-Gm-Message-State: AFuF++nWGbf046MYPyyEeBoJOQKql8HUYTVKPeKKDn+dlYHHY1iHK9u6
 E5ibJHoB4qSLg/Dmf1pIV37ewYawi+iLgO/62QAkCwNMolaDTGPFvuDp2A58QjNd07axMUaOgPd
 00yu0X/ZRsecE3T+xkaM0hkFdJIahlxmiBzNhyp6z1qnGKQeXElxzGcCnyXS8YWo0n+VksRpPoG
 LZyvFitTpCM4Je851yiA==
X-Gm-Gg: AYBFou215AplwUBxm7p1/kCgp84AfSAbdq8pzF9bGRll4DEZrxVaUTzQa3IGKvVNf1F
 Wmqb3bfAUKPJhJFOmn25L3YLr1Y9DLexf/fW6vae75xgkweCx52BCa+Ur/feOPbtLQsiOfSUp3X
 grE05kHvluG+iW5WdUZZA3rWYahqH1t4YM2uL7NooPLzVkBiWsO/VzVymDIQKvKY9g/bUM8OQNW
 f+hVwCF4jB5aiM1YfQ6zrBCuMO9i4mdBsR3EAymCpHGXqE1GRS4bMF4mH14/62/5XRKwcZbn5pv
 w8/5BIoYkS7jqvrhYPQvJVpTyisbPFuHjYuEWDACHK/GipCrHtJ0KO8bHW2FC0u+Ak48Xdd7VjM
 g/BabidH0cgpXj+2oBwrddoLbuL77yZpIIkThk2LXdrqmImJm1O5ZEb9UkH23nweX8y4=
X-Received: by 2002:a05:6870:c992:b0:485:d1ab:793b with SMTP id
 586e51a60fabf-4908ba50d24mr2532259fac.28.1790178418518; 
 Wed, 23 Sep 2026 08:46:58 -0700 (PDT)
X-Received: by 2002:a05:6870:c992:b0:485:d1ab:793b with SMTP id
 586e51a60fabf-4908ba50d24mr2532238fac.28.1790178418125; 
 Wed, 23 Sep 2026 08:46:58 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4908e665df5sm2103963fac.10.2026.09.23.08.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:46:57 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
Subject: [PATCH v1 3/3] spl: fit: use constants for FIT property names
Date: Wed, 23 Sep 2026 15:45:13 +0000
Message-ID: <20260923154610.339153-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923154610.339153-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:03:42 +0000
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

spl_fit.c mostly uses the property name constants from include/image.h,
including FIT_LOADABLE_PROP in spl_load_fit_image(), but still spells
out a few names as literals:

- "loadables" in spl_fit_record_loadable() and spl_load_simple_fit();
  use FIT_LOADABLE_PROP.
- "fpga" in spl_fit_load_fpga(); use FIT_FPGA_PROP.
- "compatible" of the FPGA image node in spl_fit_upload_fpga(); use
  FIT_COMPAT_PROP, as boot_get_fpga() does in U-Boot proper.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 common/spl/spl_fit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1a0066c92a0..64e5f95546f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -608,11 +608,11 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 	const char *name;
 	int node;
 
-	ret = spl_fit_get_image_name(ctx, "loadables", index, &name);
+	ret = spl_fit_get_image_name(ctx, FIT_LOADABLE_PROP, index, &name);
 	if (ret < 0)
 		return ret;
 
-	node = spl_fit_get_image_node(ctx, "loadables", index);
+	node = spl_fit_get_image_node(ctx, FIT_LOADABLE_PROP, index);
 
 	ret = fdt_record_loadable(blob, index, name, image->load_addr,
 			image->size, image->entry_point,
@@ -735,7 +735,7 @@ static int spl_fit_upload_fpga(struct spl_fit_info *ctx, int node,
 	debug("FPGA bitstream at: %x, size: %x\n",
 	      (u32)fpga_image->load_addr, fpga_image->size);
 
-	compatible = fdt_getprop(ctx->fit, node, "compatible", NULL);
+	compatible = fdt_getprop(ctx->fit, node, FIT_COMPAT_PROP, NULL);
 	if (!compatible) {
 		warn_deprecated("'fpga' image without 'compatible' property");
 	} else {
@@ -767,7 +767,7 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 		.load_addr = 0,
 	};
 
-	node = spl_fit_get_image_node(ctx, "fpga", 0);
+	node = spl_fit_get_image_node(ctx, FIT_FPGA_PROP, 0);
 	if (node < 0)
 		return node;
 
@@ -928,7 +928,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 	if (node < 0) {
 		debug("could not find firmware image, trying loadables...\n");
-		node = spl_fit_get_image_node(&ctx, "loadables", 0);
+		node = spl_fit_get_image_node(&ctx, FIT_LOADABLE_PROP, 0);
 		/*
 		 * If we pick the U-Boot image from "loadables", start at
 		 * the second image when later loading additional images.
@@ -971,7 +971,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	for (; ; index++) {
 		uint8_t os_type = IH_OS_INVALID;
 
-		node = spl_fit_get_image_node(&ctx, "loadables", index);
+		node = spl_fit_get_image_node(&ctx, FIT_LOADABLE_PROP, index);
 		if (node < 0)
 			break;
 
-- 
2.43.0

