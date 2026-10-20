Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9B606A328
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bdUHlT5P;
	dkim=temperror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=auuzpFit
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76F30810EC;
	Tue, 20 Oct 2026 10:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLxL1SOzK9Ju; Tue, 20 Oct 2026 10:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F2DBA810CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491382;
	b=EizkU6MSna7jqtIflDcWGAE9URkQ7gCCEKl7iTKKMSCYxUm9lBDdtPWq8+TGY2rkFIVL
	 R8Su9bZHT9RCwGxjr+SNhL+TOxnUCFhPom85kTEzXgwqTFqtz65bGT/HwKPw/uwJMsLG1
	 x/gkVbm4Pz1q/jBVQS+9pRb/q9r7VXFtKPw5FPZQ5UvRLKrHaQVEd+PrnauF0ItzIZ15O
	 y1K0+RHx+Swp2uKvePUYdaH4a3nE0WW6FY9RaQjCJOzoKMTJ9dHu51emWnB0Ei9W3rC2O
	 xFoK4B74owtiF92HdubCMSu9OnUCAt/smRCx4IWC4zBeBvL30jnd7IfusMXgrSHQuTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xncaR0Piutzl2mjoSGRFJkTTxSfCEjytWSpT23sQ/UM=;
	b=qdAayaur5bV4xd6GdRZxTQvYwhHGlbshfatdNHS2ekU/FKM8ykfWVepumiEshU4LG6Cv
	 opMLYyYB9EPTbXtu5X1bhtpKxcZ8DETvl5aIfgv+Ob4i2XuSZF9WPoKW+eUkLKUbE3dXw
	 QGKu/1H9HCpk0ai7cpgZ3MttNpikfALWOnNcsmKnXAjXJj4UamWkhYdxVT5h2QFg3BhTJ
	 0eoNZfBqrY9x59gioSDZNlzvPdlU6zgbwXNWRH1OSAKwQuMUm4BaS2gj6wlOJgTMo5scY
	 bDurtw/xD6ZaeIHrPG0YeBICyCUDRUJzfIelxGoV6rosHq1NtHsT/4iQYHRaYiHDRzw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491382;
	bh=xncaR0Piutzl2mjoSGRFJkTTxSfCEjytWSpT23sQ/UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bdUHlT5PU24KDMZAU/uYomLhQdpTxmYZZCqdQqHWrAiDpfVH+mPvHeBVbzS2wF14r
	 ihHKz/tfjzc+Gjxf3MAV/NAVqc1Lavlnqp3bXzkNFUw2UPS9zZw8RzBlX3zCRXRpUJ
	 Bua1lrY1X2MdoXLmN+2/NyPvhYQ4gqTZSw4NdRmnz2TyFQMw/tIbr0ASmjGGSVHFxg
	 eg5dsQgq0xplFYgc1OnxhKaMKsyOCCcrzDjyPImk88LXhMwg22wKZIvIp3SeWO2ES1
	 G7NZVfr/tDslreYN7IKWegepqgSJHO6Luv4xfsbUK+6KqyoWjhAZ/6YtYUMNY04/6S
	 K02SZ/06sj1zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2DBA810CE;
	Tue, 20 Oct 2026 10:16:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB4231E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C171D400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9D5wI5tCbGz0 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B56E440328
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491375;
 b=LPA3f49khX/YY7Xf0ze9c27L0W0UsK5fZDOPOsIk8tmci8L07U7nZHXjA98rzH+/CG7G
 udGWx+1tcepDVNaFSkk8Xr8z1g1UaQ2wof/iOpAvTdlBfSgAApQuRLXOGqJiCbc5HBEa9
 R9VAD8o2RIt8k94+mZAydSLTopY8AKHW6nsgoLzL79youykTt/0EliFjtSavon4dIcXAB
 QedMRBg+VamwHiXR++iDGMYBWkEhpNZB7W29XylLLr5WyywwJ1u01s2S9cpMm+N7SSSr+
 rCcNA34IQH7of2tYvXAfD3b/a0FjPTZKiQteE8P6mO5hePzn6HQs32Q+OCnH57uTMjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=xncaR0Piutzl2mjoSGRFJkTTxSfCEjytWSpT23sQ/UM=;
 b=PGsYL3sYqo5aSYlBpzegEKL12zWF5C+Sa8bVC6HbUiO9rBEr61DVB9viwXh7AZsNQLdK
 Agp6SeNj5mfIt7v0bGaCPPL3Uc5nTXLNUYKlc7CSsegUcpzeYzxrYqvGpa2JgTRDqWBAf
 Gc4yax1LYeR6EduXL4ocrkT2DPLtuvtpDZw5XUipKfnlUwvZrXU4xRoVwJ5X/n8dybaX2
 J2lLoDeMvuiCNl7Sk1uajQLkuTyugl4PEaqgiHs2j3KSI665OTw0sfvBJIOlnAKCKWx7X
 GiP3Ra4b2uoV9NzcnnQ9XRA85DYVJ8alZled6a08ZcRQYLZiLqACpwhnb8w26E3d61w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=auuzpFit; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=auuzpFit
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B56E440328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:13 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1e2957d7eso21010165e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491371; x=1793096171;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xncaR0Piutzl2mjoSGRFJkTTxSfCEjytWSpT23sQ/UM=;
 b=auuzpFit80bgRdB4TPWvYq0mcls//UOGMMrdv3RnUryQZNDxtJ5teCctJY9bjnK9f2
 /3655IkhWQeHkwtfz0Lsw1zQHl6Yol0N4eyJXR0LBJsO0K2Epvyr+isbDaVq/cvlGgjJ
 1L6RnEA1KVIJGvy/56rMx57tXJcsxsCGeduZg19ogBzd8EvMWXMlvNYB60Yix0iQRxkI
 tRaaxpuYGitRjtPWhFOxXz5bKkxy/ErDEYUSNcrtl2tMigXXAOBJxmG1M6jqAsWjRDnN
 dG3pskIh9HI14wCEEPyZ43VXxVAIDnEWjD4zYJ+yADW+etHMuU3SCcTzcbLb5uEnwH11
 Wnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491371; x=1793096171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xncaR0Piutzl2mjoSGRFJkTTxSfCEjytWSpT23sQ/UM=;
 b=1z+97jNYm7BeByVwDIyVfwvwoEL8vFvJWS1kjegz8yc6mOUEjQuz4lPXZhcBzG/zLW
 HYkRAOqbejv/2uMBTCiqnJ6LhldjFtxYJFS9pG/XHFbcx76LyeesakSM5gkGNlD+FtWD
 cc7Xj5s+6X/4S8MKlASM/R/KPhxZTtxR62cv0t4EATBcEnfxyr89aeMqsEjo5HFlouGu
 qi/4NseiL/M6fPvp3NYOCki0DMxfPQ8o/3eY4i8Y5uBuzcslGHWFXn+MvNvMFb6T9WrS
 +Tjgdg7F12CwIY/nqxlZ4tmid6z4d6yx/PdnT7ho7ME4hs+M1Yg9I49UHQhp/c22mVwz
 tsAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwexL02VPrSwwa4emxWSZRK8l/lLeYOjlFntaqF34uaUqS8aCgi6Y3lIdafgivikYN08JN1v+Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLvH9KWstSS3/pueAc0gq2YR2eSE+Bb8Xb6AVitkDhmgyWAAt5G
 kNlh9dVq36MHkwkM+fzUymnvCVKvcu3oIUwYODjjeXrN6nmQs4Dk6UKF
X-Gm-Gg: AYBFou28Yh1Tv8C5PLFggvEpbVQW4HssVaJ82CFNdR2SiXYw65G3+zv40ReeripEYb/
 t1kBXHmW5LgoxzaDKp/GHHHaCpsveE/+H5CKBOqvGrOCLQDLAdwMoeVBpwq0EgL7V3cv++joE/v
 jEysobp5qsnr0KP+RRQRTwymojYfz0UG3fmoxgBHZwLs1gRcS5MeQUbqOJdJ32xHMluK6AREL1u
 0g7xvMEOf3NIh4w6d90aBE+me8bb63q8TZyjUxQ+KXWp+Sn7H0W0bEBf8dG1UmyriafxqIgOLip
 qtXo7nPSaq8x88AXxDhcc48A623IRYGsSUW3D7M91adGCZxKlVRz6ynS3dZw5HIN6Hc6Z/M7ZKH
 m8ZLgwcI3ktrvrq11hUvsshfr3Yw0lAuB80q26KdL8GtLj7jc1wunOYGT4b5nnRjIKiNDD6nd7+
 LHXZuBOttG6Jc/rPKO8cHViL7eDnk7pfR3A82IWQCHxEmUqne+rmSjkWFUrStKVTP3jTMogmxPP
 9/P
X-Received: by 2002:a05:600c:4e8a:b0:49f:ffd0:4039 with SMTP id
 5b1f17b1804b1-4a1d763ca4amr206481455e9.32.1792491371176; 
 Tue, 20 Oct 2026 03:16:11 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:10 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 1/9] fdtdec: match an alias to its stem only when the
 number follows it
Date: Tue, 20 Oct 2026 12:16:00 +0200
Message-ID: <20261020101608.2818265-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020101608.2818265-1-mehmet.fide@gmail.com>
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

