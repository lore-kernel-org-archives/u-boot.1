Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F07606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YcxixvOv;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cSvC41De
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F389811E6;
	Fri, 23 Oct 2026 11:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VDQAlzeHgJ0; Fri, 23 Oct 2026 11:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 49668811DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754169;
	b=cYOeKGbrkA/73NlW4XtIeMH6rvXbbdcn4hs9XC3/g4hEoiH96f1ceIii+JmwK+LnXsOs
	 82Bs8DWdOF71K/Ni07cZYybiuJuvPxt6BZW/7gY9zAcF7erhytyVBQKiO7XViQ1W1R2ZQ
	 3a50la6PHkI2f04shJ/H+TGjM3ro0mCJuZVUTW3LMTW01OHZNVitgSXggw2nx4NlpH/98
	 81AgcmBpVC59gZprhp1O1wZVic6+c3sB5SdYTlxG22lJURqiwgBvfj70A+7dPQ1Vr7xEX
	 lxgHTe08tqVE4tmdBNeQMh8hATgtW+rDwd6/9Jp3CtH/tXC+aU5B57cILHwBolSRe8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W7JLNA/oklsSvxbmuU9dW2Mo55/zjXtg3CQyFJ0A4GY=;
	b=FIeIx0VaWqfQRs7IGj2s72ewez/othiVu+eQXUH4Z1rBvCINiSKXL7rC5y5eiLwhs2P1
	 m4fQfNMPRp2ES0iGLD8E7QVrBpjGIXHt3Q7rJJXjAKusvebX9SpbyTrAgsoJSF8w6CrJL
	 YLYlrbhcJ8a20V/MynZuWbLg3b2KxDySuGMJpRpJHk+G1lQGzhIx8ogSr9LSeNtCSevcx
	 UHGTeFuZpqc/z82ZVioT+YHcgPHD56Au76FW9IeoteDo5xQRSHhZj4keq61UcFFLptIa4
	 52rxI/312+vK3GSfZKKme6CIekHZUd0Sc2Z+JiDR2Hv7KTqTG4Yix7qItSQJ5kgGkaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cSvC41De;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754169;
	bh=W7JLNA/oklsSvxbmuU9dW2Mo55/zjXtg3CQyFJ0A4GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YcxixvOvHxMcXYi8bei2iPT539ZAwMOXZdH1BW4Aa5aKJegl25tym3goCbGFvxjq0
	 X00bmnczAd1nKE+mGRrfBsd/I03+tfnoDXBDROVj087zb3ZwPhdsG1lgXdiJs+tU5a
	 znWQzZn7eCJ8Uadi9lk0E6iPINlcSM52nV9UWfM7KJ4sUejOQNxvcINXLgtswXSI96
	 M6G5mlwNw7VtiuoWrE7KUcW84LBl/EBye1gIoc83cmpkP/QriiUA2A6lxnQ+WtLhCe
	 MiGG1tTQmVBVp5HprlsI+Xsl+elnAbnEcu/Zwrnq/iqPxsvnFEDMgKbskCEfyNPqWX
	 ilvJavNuXMJtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49668811DD;
	Fri, 23 Oct 2026 11:16:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B459BB02
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3175811E6
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNHDMJMaoU4f for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E896811AB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754166;
 b=TgDnGRDQ1AeK2Zo6yLsYmh5JhXoIIejMuOL5mvKTW9ereF86zCegQlct8KORWtnrABJJ
 YovtLqMFYKouR9id9Xzw9ka97hVjg8pkCMgE5bB+qzfwLPKOb0L4isOQ4oJtQ4+VS62Yp
 DBqSgdWbxdy4GoHReI9zco4ffQqm2ZGmCviwCicLxXV5FXlvsKA+J9u6Sc000YgxIfec5
 DkFPGksrVHhxdOjywXpm7kP/AEVfiLEekcn/CEFavB3imnCUVsvjAj1b/1UEicggw0lr4
 FkbZCHGZjXBw57XcHjXKJNAchwDNK4tcg3dspYTFdhdRfdLwXt/IUxa8EIkab+tlsLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754166;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=W7JLNA/oklsSvxbmuU9dW2Mo55/zjXtg3CQyFJ0A4GY=;
 b=k444uoX07OtyH6ic4JBUnbXOXONgN5VbFs41bvtJs9JIxIKefEuoUzHAT6hH4POTsyqK
 hdrguWxV9JXq1HlE3bR8v4TNKhW85aHTRuEJ6WZuSVsBL4SXMgBkxqyOmRlwRCWRgzaWn
 gkFPJza3MJJGeOSQ2WygvKIL3D4IOyQLNz7Mz04RgrlZnleK4YYL/rsMDa0nCqIpYJQWl
 15LgKQFE93JmG9P8gWcveLuBDl1tYDTAUo5p7gUhxts9KFZbCUShv0+QxoAiHsWNZi+EY
 LiTwqcJiT8VBKY5FpMKYRuFN656+gxwx6OCOI9ub7n8lkvv5sypDch7y6045aeFoHJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cSvC41De; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cSvC41De
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E896811AB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:05 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so613258f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754163; x=1793358963;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W7JLNA/oklsSvxbmuU9dW2Mo55/zjXtg3CQyFJ0A4GY=;
 b=cSvC41DeY1R9uPT0WJFmnKPVoo8enwnTMU18U5R+TbweOdbujJnTD/9DlQRG9nLSwg
 qTUCxGbz13vgXi3y20N7mp783T/505vgTGNROeRtxPLhAfT8c9+oUyizRKFhjIDg23l2
 ZdBi7NusNtTaQEUlaqhiceOd2B/e3o/FxepZ4+G72bTX+n/ljeNkPBILw+LB7Ps2McV9
 RtR+bBWMijSEIcGntVMVvHpBTGD4GNKCDG+AxLXirn5paS4sKmX5ze1xdeEItom9fwsV
 gQr7WPrzcdPCytxVxHVedN7ovkRpOLTSoWDglg439LHIBCu+zEF5e/Bv2WZbwMbeV1CA
 O7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754163; x=1793358963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W7JLNA/oklsSvxbmuU9dW2Mo55/zjXtg3CQyFJ0A4GY=;
 b=kqcFj3T+M4aEz4uGB8LgsQYnaXrpzw5npWZAPWXpL9v4tAj1C4D7wpWkFj32yDldds
 q6QGHKCpMNQxPNObN7ym7ZnrLCt48AS/OZOTwMCT+GL5rPfUCbC35VlbISlJRXHIRM7D
 PzKQK/AN6AAZ+MYDwJlnBf3/3VtWyxkkcvRYV2QuVNNLEOVM7A0PFEt1oW6CCqOdnIz7
 WvUDMi935wrRCW8K9uNdQuSBGpppMUXwClSrP7Nj9iDMI5a6PQac0CGtHhkpugiB2tW7
 N4XW+crGy5iFsbSokuEpwhYxarJmbORVm4+C9suT7pA7BCwObYCHuvYVtBWu/nfjVssE
 kyVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIV+Z5AAi4MW0vjCbcRy3DDEB7Q5rNFVdEvOn6o3mve1KtiOY0mTJG5LnhTk2jrjQKfqTWIWU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI1CqBNtM+89aw9HjqrA+3KzcgP9UNk/zoR5wvBNo7UXUyiT6Dz
 eOcE5BLYSjmTfDgQp/QvI/OG0vXJeR9uCeTijyLL4XzlWzTBk3L2osDy
X-Gm-Gg: AYBFou3sBdFQk6d25PT7YK1w98g6LDxhMDgtYOCXA8NRjZfEae+8Rdmb4IptMPB0yI9
 qqS5y8AI9jgCUfYF8iG/1KyPfobKYfMW2QxuDXfYfgTaLuM5mY4iksKoA4kEQO4EIIJXjEbXNKv
 C9MPCm1RIV1iLz8Er4+JYm+7ffVt66eiUVQBwLk9zr7xWoJc9xMmOyWCBZHYhJqvk7Ln43b9w83
 PR4JjaCXYuLnW4ORUSyDLezjd+X/VZzucUuE7qNp6zARnTf/SjKymoUEKKV05IXYoCyP0jUGTaO
 R/EJXjkwdQo6dZ3ImOICEIX9V5eE61uJmeP3KFqyJspbG8DO6ffKHstclsPUAhF1OYAG0KcL5+G
 3ySKy+c/ixNfSONccKHIpbCUyM2oB5MMJbEsOY9H8SpK8sQAiYMjUpNO0uRQS7IV3o/g+l7rP2x
 niNakhs1ZKE7QdXde+/PEqafBfD3XsDyizUYD7Xc0fNDOU02NfqvfBAbE8wbceuqY5uN+qcjEpt
 bj1JiCQOid9VAt0oPv4qtydWgTq8PCTI+SiZyEPqZVi7Qr84DYmy2vlirTBRUiBDovd0vOnrru5
 MfMHa0Y=
X-Received: by 2002:a05:6000:299c:10b0:48e:d88:55f4 with SMTP id
 ffacd0b85a97d-48e3854f102mr2256316f8f.2.1792754162883; 
 Fri, 23 Oct 2026 04:16:02 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:02 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 1/9] fdtdec: match an alias to its stem only when the
 number follows it
Date: Fri, 23 Oct 2026 13:15:51 +0200
Message-ID: <20261023111559.4081795-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

fdtdec_get_alias_seq() and fdtdec_get_alias_highest_id() compare the
alias name with the stem by strncmp() over the length of the stem, so
every alias that starts with the stem counts. On a Colibri VF50 the
aliases usbphy0 and usbphy1 matched the "usb" stem, the two USB
controllers were given the sequence numbers 2 and 3, and ehci-vf
indexed its two-entry tables with them. The live tree disagrees: there
of_alias_scan() splits an alias into the stem and the number and
of_alias_get_id() compares the stem exactly.

Match an alias only when the stem is followed by its number, as the
live tree does. A test covers both lookups with the sandbox aliases,
where "test" is a prefix of testbus3 and of the testfdt aliases.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - none, rebased on main
    
    Changes in v8:
    - none, rebased on main
    
    Changes in v7:
    - Reviewed-by from Simon
    - rebased on main
    
    Changes in v6:
    - none
    
    Changes in v5:
    - new patch, from the review of the alias lookup in v4: the live and the
      flat implementation disagreed on a stem that is a prefix of an alias
    - the test calls fdtdec directly, which checkpatch warns about; the two
      lookups under test have no livetree form

 lib/fdtdec.c     | 43 ++++++++++++++++++++++++++++++-------------
 test/dm/fdtdec.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d25535bf36c..5fe7e85a943 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -508,10 +508,29 @@ int fdtdec_add_aliases_for_id(const void *blob, const char *name,
 	return num_found;
 }
 
+/**
+ * alias_seq_of() - get the number an alias gives a stem
+ *
+ * @name: Alias name, e.g. "serial2"
+ * @base: Stem to match, e.g. "serial"
+ * Return: the number that follows the stem, -1 if @name is not @base
+ * followed by a number (usbphy0 is not a "usb" alias)
+ */
+static int alias_seq_of(const char *name, const char *base)
+{
+	int base_len = strlen(base);
+	const char *num = name + base_len;
+
+	if (strncmp(name, base, base_len) || !*num ||
+	    strspn(num, "0123456789") != strlen(num))
+		return -1;
+
+	return dectoul(num, NULL);
+}
+
 int fdtdec_get_alias_seq(const void *blob, const char *base, int offset,
 			 int *seqp)
 {
-	int base_len = strlen(base);
 	const char *find_name;
 	int find_namelen;
 	int prop_offset;
@@ -531,8 +550,11 @@ int fdtdec_get_alias_seq(const void *blob, const char *base, int offset,
 
 		prop = fdt_getprop_by_offset(blob, prop_offset, &name, &len);
 		debug("   - %s, %s\n", name, prop);
-		if (len < find_namelen || *prop != '/' || prop[len - 1] ||
-		    strncmp(name, base, base_len))
+		if (len < find_namelen || *prop != '/' || prop[len - 1])
+			continue;
+
+		val = alias_seq_of(name, base);
+		if (val < 0)
 			continue;
 
 		slash = strrchr(prop, '/');
@@ -549,12 +571,9 @@ int fdtdec_get_alias_seq(const void *blob, const char *base, int offset,
 				continue;
 		}
 
-		val = trailing_strtol(name);
-		if (val != -1) {
-			*seqp = val;
-			debug("Found seq %d\n", *seqp);
-			return 0;
-		}
+		*seqp = val;
+		debug("Found seq %d\n", *seqp);
+		return 0;
 	}
 
 	debug("Not found\n");
@@ -563,7 +582,6 @@ int fdtdec_get_alias_seq(const void *blob, const char *base, int offset,
 
 int fdtdec_get_alias_highest_id(const void *blob, const char *base)
 {
-	int base_len = strlen(base);
 	int prop_offset;
 	int aliases;
 	int max = -1;
@@ -580,11 +598,10 @@ int fdtdec_get_alias_highest_id(const void *blob, const char *base)
 
 		prop = fdt_getprop_by_offset(blob, prop_offset, &name, &len);
 		debug("   - %s, %s\n", name, prop);
-		if (*prop != '/' || prop[len - 1] ||
-		    strncmp(name, base, base_len))
+		if (*prop != '/' || prop[len - 1])
 			continue;
 
-		val = trailing_strtol(name);
+		val = alias_seq_of(name, base);
 		if (val > max) {
 			debug("Found seq %d\n", val);
 			max = val;
diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index 495f57234a4..075f7e5471f 100644
--- a/test/dm/fdtdec.c
+++ b/test/dm/fdtdec.c
@@ -8,6 +8,7 @@
 #include <dm/of_extra.h>
 #include <dm/test.h>
 #include <fdt_support.h>
+#include <fdtdec.h>
 #include <mapmem.h>
 #include <smbios.h>
 #include <test/ut.h>
@@ -188,3 +189,37 @@ static int dm_test_fdt_chosen_smbios(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fdt_chosen_smbios, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* test fdtdec_get_alias_seq() and fdtdec_get_alias_highest_id() */
+static int dm_test_fdtdec_alias_seq(struct unit_test_state *uts)
+{
+	const void *blob = gd->fdt_blob;
+	int seq;
+
+	ut_assertok(fdtdec_get_alias_seq(blob, "testfdt",
+					 fdt_path_offset(blob,
+							 "/some-bus/c-test@1"),
+					 &seq));
+	ut_asserteq(12, seq);
+	ut_assertok(fdtdec_get_alias_seq(blob, "testbus",
+					 fdt_path_offset(blob, "/some-bus"),
+					 &seq));
+	ut_asserteq(3, seq);
+
+	/* the stem must be followed by the number: testbus3 is no "test" */
+	ut_asserteq(-ENOENT,
+		    fdtdec_get_alias_seq(blob, "test",
+					 fdt_path_offset(blob, "/some-bus"),
+					 &seq));
+	ut_asserteq(-ENOENT,
+		    fdtdec_get_alias_seq(blob, "spi",
+					 fdt_path_offset(blob, "/i2c@0"),
+					 &seq));
+
+	ut_asserteq(12, fdtdec_get_alias_highest_id(blob, "testfdt"));
+	ut_asserteq(3, fdtdec_get_alias_highest_id(blob, "testbus"));
+	ut_asserteq(-1, fdtdec_get_alias_highest_id(blob, "test"));
+
+	return 0;
+}
+DM_TEST(dm_test_fdtdec_alias_seq, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.55.0

