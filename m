Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CFACA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7284D80987;
	Sun, 11 Oct 2026 17:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iCq-KERuzGVA; Sun, 11 Oct 2026 17:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F16780C76
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739392;
	b=WEN/KUSHmmvWbPzNxPlTyErLkxB9jDRdWFR7q+yviwk6Ro1TxCPKBwz2Cx4tKYloU+yi
	 F21/0R9cycxbHIm4tpweFz0FMoYfyRIssOAB8C5xtKJPVJrT9ro2bZXsHt4/8ejRXG+FG
	 w7nHtUFTIxH5Hok6yxYvYwo5jubFfHB7QEaUvrHM0/1IKAdWv5qvhaDevwrs6UBNyGhjc
	 Is8Q7mqJ8jdb/LoO3ys+NXAulV4xpiGamFQc6ObCCQYLDEBrRR7MZ9hNfwl40kFvNLidF
	 4HZko95VPY31b2Phpg1/CkZx7zLJ9zkF4zatNQSu2hdEYDzjeYzSEr02AjKcXqUyyAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u50CNTJUjv0iT14I9NB3iCZ8oFOlwDD8+8AAoAf9P4k=;
	b=mMfQxccId93xZHR8FhvyUm7FfzKDKbaSt+zhSE6LI4951bCyPKmNXbPlmggAtpDAi0/c
	 XYxmL00Uq2fepTWi8BOkCN5boVRNqwSBL8CC0txUdWO+8GYYD6onTalUWDCNPTfHG5eim
	 wbng0/7wVjUioA8gB3K/WY2hdzSg6kxZjPB1hIR3awiDVgW6HShYBDZP0QSzhIIgzD3uz
	 45N038itXzB9/8OYNNSvUDyRXBUA83iVAe4mRRP+b1Rmk+d76obpIFXeYMTdlOQu4yp6c
	 +dA+/Z/hqTKvFyORFJl4VtWDyInL4XYcGrXiEwb4o5lm0qnAoCUPzGyG/kDSnEvVc3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739392;
	bh=u50CNTJUjv0iT14I9NB3iCZ8oFOlwDD8+8AAoAf9P4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyNXkEDt1FAvw0TJDaFlY9bImgpzgBPIUzC9vaw3he5tppP+1c5LxlZ25haWCuSbn
	 e8SdN2waslWMlgvmcicb741Y5VETKhn8/1/QMmgFZ0ifdfRSmL5fwQvBLn6VyBun9n
	 2aS/oGkSV/UzdzTRUKTIHIsZpvxoI92BywS6yHlnc+bsyWa+qbW+HVJseI24mNQWEP
	 KsWRmknnMj2SuxPHj7sizMq9IUoGICiAHRhPpc20p8esV8+CeMtq09isxVQrjxrLke
	 4DcSWGvsOJtO6e20e78Ygr3pAbysBelzhr1oxf8vT+LLq690XHmL/NVFsrzUcUTRRB
	 DeHnLPrkT+dOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F16780C76;
	Sun, 11 Oct 2026 17:23:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E72075
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FD81605CF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzBrRSpC7Wop for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E176605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791732192;
 b=a5T6fepjx7IqhLM/ZTwKAYNjZpXvXhTjUYVSB8iZgsJTW/8zYgykOgKdcETrThggKKQc
 8UneXl6w7rI8BJj7qT7iM4Cqs2fXqUWfVHMMI6LtjuTQ7ZC8+9H01NMBk6NScfbzfV+OZ
 8NymSeURYA/7tCYDzfgwi1i+HzhwwV4pwlikn8xOLb6OcUKsea75Q6+Qf5Rq4DO+QOElv
 6QypcJAfC+/eEOl0iV9+VtL6GbqXk+x4MLJM9L3cJcaGj14b8ERTAGJQ2Y771ZysRCSql
 6Ikng+uBHyeO89Kv7DM2xWS2FwacirNYj444rsWdUUYkD/eYafY2/Zst3iue1GOaL5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732192;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=u50CNTJUjv0iT14I9NB3iCZ8oFOlwDD8+8AAoAf9P4k=;
 b=m0jcn7ArykbT9MuXK38L0X3A9txO0vkF5S0IJPtMQ11OPixfLkW/TKrfe1xiGL5AELWM
 IyfjFkDB9LXm/iXbIPdCfcUcFZwkgB4vUnIIC3B1wXcKl2FTHoitaDlPI4omowiNkUK5O
 os7KgEDM2wyxo1UcltPCX7Mzc/mOaSSOd2AUfs33+8TH0E9DSgJNGPpJl3GaGe7jxhLLv
 jXnpb09cUB6F5H4Umo4/Jquv2limSIADryDrtxpQ+K0GsMk3eO+tyzLDyqSZj5LsAtVxH
 HkVHyavyP+1gO7M82cBnnadnipLPfi5UHhoaEXozKw4YXWTZwOb8Q3XT45pD8JIafeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=D4upGGWh; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=D4upGGWh
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E176605E4
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:11 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D8BF03F1DA
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791732189;
 bh=u50CNTJUjv0iT14I9NB3iCZ8oFOlwDD8+8AAoAf9P4k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=D4upGGWhccycR5xzRut3Bwzhqmonl/JzmpLtIx+FW9cfqv+H54ObNF9/WxAJRFpLH
 0CPlGGLvgyMwwUhx5triHoqtmlrJUEkZCfdhViY3ALIXs3/s8nywO+StO6IaeFyMQy
 YJstOymGtnuBbDz25nar1dOythXqau0o6FBCdLJdyOrRUVisCfQ+7EcSBG53Sfhtad
 kUfPQTqZOp9EE0ucY7ptvfc8zRKnq+A6BGUA1veUkcp5XZVUP7AsIPd0iAGf2hmI5f
 C23J6sZDs4wXaKsRzzSFeYVwmwCmf9CzYayy/AOdEawk1TMCPR+zQ1mcQz5SjivpEK
 eiGi4qyonjgY5L2LpTp5wDszu7kRgJwIPy6d2f/fN8ByTNX7PvodP2zmRdG41+R17O
 ozTzi1VPFjaL125g6W6HEBN9dwJQIFX0JLj+IW49ciL2EbEy/7bSc/rx1STtDKbH+4
 ZKhidJzZy2Fx0IdlUalZ4XNralVxXrfaIruLWv3alzDi3fOYp0vnuUfRdMX7qlSRbL
 jIb4KVD9IoXhRN6GIG+xraKbhteabkimjZwPb7j9fxyrAJTxHkQJ5umBYHxvfvnRbm
 yVddxkxn8lTpHLqGYC3JFSE1GK8H8CAbiSv7dnkh0cwiSjLeZhIa+v/kXVGvn0AXyO
 j0OcnA4Z3517Lw9pvNwC4dms=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so14694875ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732188; x=1792336988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u50CNTJUjv0iT14I9NB3iCZ8oFOlwDD8+8AAoAf9P4k=;
 b=hIRWqrcN/RK6zzcWGQvOrl6EybjPTHTxrTt7XO886DN1yOKFkqS3D6wkzRkuiM4pxM
 GiM6csogGnYLcOawWlmZ8yHaRdaQT3jFAyAJ3fDzKCCy32+5+qlF9Ge9F/UCau2CFOkW
 RM6lHOVOos/OZAzw3j8Nmcyzn1S37ju53Emp5mmFOwbskQgHExvjsSRl74bKCm4sbfHn
 tGg1UB7BIlERIjWiqWs6WOaoe2VRRUSfWB0APdQ1RxAkGFCmPu6gntpBFgoJqdglnTob
 HONdekHNfp4Rx2PLv5uv66R24wpjLNkoUPMrrGzdiMwppIT6RWDzsTd2kCa/KBXsmv/l
 62eQ==
X-Gm-Message-State: AFq9FYLu3PN2/cggBzjjTmcLA1gCGlrkmj2KpUrsXu2xPNY2BPoaGBH5
 /QdFG2oQ1yyc83COHHRbkbC+wSzWEkuVUBdqs09vLPYXtXOVU6HiT1tdDN4arP6x40VQUSMwf64
 8J3/U75Uk0lDyWcm0rY1lfOYbcIF5uMaxdHY+f2lYUrkSF107fkB78pxCITr3JVDGKZN4Eyzd7E
 JF84UeIjJvE3IRCLK06Q==
X-Gm-Gg: AYBFou3WqAvbGi4BGx89szQZsO5WDxPUm/x+2+p5GkJlEhRszwnoxR7fxmY2NX/iGEs
 wg9wrrWjc25LR/gifuACXA5pyWoH2OQgI5qVEzwhceHswSxrsvXBQ+1OsmfIB7zgbx20JTE+gaN
 CT3yGmLOGMSx3FDu46gRKr5Zfyw8OtNgjKs+Aejh8pAh7nWRHYePn8PFevMeKXuHRQge9FO2hfk
 DiSDRSR5GFjTZaEHg/N+bjAcHRFPFC9K1IQLr2P3S24nTuO8qnuU/XdWpDz7XJleBTJmirnjXXT
 XT089c+iCtMfhE4wbxjdxD0GQX1vniP8e/rWGpisnolChlb57Thij6kt7Pz8W+n0fYvpiQlyCJf
 PT39/d6fJO4l7mElKqRbWehKZVcXSaguSwYVUQDrztyraTcTYJZEgUIyAoVB7k5w4n8cbsg==
X-Received: by 2002:a17:903:288:b0:2e5:d301:2ce9 with SMTP id
 d9443c01a7336-2e842ce7fcbmr59456745ad.47.1791732188226; 
 Sun, 11 Oct 2026 08:23:08 -0700 (PDT)
X-Received: by 2002:a17:903:288:b0:2e5:d301:2ce9 with SMTP id
 d9443c01a7336-2e842ce7fcbmr59456625ad.47.1791732187879; 
 Sun, 11 Oct 2026 08:23:07 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b5fd2sm33300445ad.50.2026.10.11.08.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:23:06 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v1 4/5] tools: mkimage: bound external data reads in
 fit_import_data()
Date: Sun, 11 Oct 2026 15:21:16 +0000
Message-ID: <20261011152235.8842-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011152235.8842-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
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

fit_import_data() reads each image's external data from the mapped FIT
file at the offset and size the FIT itself declares, without checking
that the region lies inside the file. A data-offset or data-position
pointing past the end of the file, or a size reaching beyond it, makes
mkimage read outside the mapping, crashing on re-process or silently
importing unrelated memory as image data. An authored .its that
declares external data properties hits the same path, since dtc
produces no payload beyond the device tree.

Read the properties through fit_image_get_data_position(),
fit_image_get_data_offset() and fit_image_get_data_size(), which return
u32 since commit c4d81d062790 ("image-fit: Use unsigned types for
external data properties"), so a value of 0xffffffff is no longer
mistaken for a missing property. They fail for a property that is not
exactly one cell, and the import then skips the image as if the
property were missing, as it already did for a shorter one. Compute the
file offset in 64 bits and require the whole region to lie within the
mapped file before importing it, with an error naming the image and the
offending values. An empty region reads nothing, so it is not checked:
mkimage -E -p places one past the end of the file when every image is
empty, and such a FIT must still re-process.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index b648e3e2514..f0f30e06bd9 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -1033,9 +1033,9 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	     node >= 0;
 	     node = fdt_next_subnode(fdt, node)) {
 		const char *ext_data_prop = NULL;
-		void *data = NULL;
-		int buf_ptr;
-		int len;
+		uint64_t offset = 0;
+		u32 val;
+		u32 len;
 
 		/*
 		 * A source file must not combine image-data with external
@@ -1059,22 +1059,39 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		 * FIT_DATA_OFFSET_PROP and FIT_DATA_POSITION_PROP are never both present,
 		 *  but if they are, prefer FIT_DATA_OFFSET_PROP as it was there first
 		 */
-		buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_POSITION_PROP, -1);
-		if (buf_ptr != -1) {
+		if (!fit_image_get_data_position(fdt, node, &val)) {
 			ext_data_prop = FIT_DATA_POSITION_PROP;
-			data = old_fdt + buf_ptr;
+			offset = val;
 		}
-		buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_OFFSET_PROP, -1);
-		if (buf_ptr != -1) {
+		if (!fit_image_get_data_offset(fdt, node, &val)) {
 			ext_data_prop = FIT_DATA_OFFSET_PROP;
-			data = old_fdt + data_base + buf_ptr;
+			offset = data_base + (uint64_t)val;
 		}
-		len = fdtdec_get_int(fdt, node, FIT_DATA_SIZE_PROP, -1);
-		if (!data || len == -1)
+		if (!ext_data_prop || fit_image_get_data_size(fdt, node, &len))
 			continue;
+
+		/*
+		 * The offset and size come from the FIT itself, so make
+		 * sure the region lies within the mapped file before
+		 * reading it. An empty region reads nothing and may lie
+		 * past the end, as mkimage -E -p places it there when every
+		 * image is empty.
+		 */
+		if (len && (offset > (uint64_t)sbuf.st_size ||
+			    len > sbuf.st_size - offset)) {
+			fprintf(stderr,
+				"Error: image '%s': external data at file offset 0x%llx size 0x%x is outside the FIT file (size 0x%llx)\n",
+				fdt_get_name(fdt, node, NULL),
+				(unsigned long long)offset, len,
+				(unsigned long long)sbuf.st_size);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
 		debug("Importing data size %x\n", len);
 
-		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, data, len);
+		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, old_fdt + offset,
+				  len);
 		if (ret) {
 			debug("%s: Failed to write property: %s\n", __func__,
 			      fdt_strerror(ret));
-- 
2.43.0

