Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D13606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kOjQp1hL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jil91Bit
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3533D80C6A;
	Thu, 22 Oct 2026 07:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fClsyYOG0SZ1; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CA7780C8E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652950;
	b=k+7GDqL4Y6MNVT/MKAkpu/24844KoCggaHuQ62sEVr3305foPv8BFZqTjTB9ChcadNos
	 opTcx6Ly/OJxetEQEmQ+tzlO/JuUiuWb0etbFRX7Gn+iKjNQazltoIB7EOI8WafM3wxDS
	 FO6n+YfauYryd7z18ZQgY1EprroQwnCHejIt/3O0EUcLpR0pXjPSrC7goNcx37XyC+4VH
	 H6PRF8CQ9Bz9wbkq3kuxUdRgGGYgjaXZpCxk5sFUvjkwrDh49qabZ7MrwjASRoloTxdOL
	 wR5x8+IgJ3Qx/kh/GGJ7JA/1obKS+BbXCh5/cikYCPFvMrhWHj5GwrEkLk1XwxvidIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/CqUFK3PcKSMN6ZpFD4M1IAHe0JJ6TSlK8qLZpaXZAM=;
	b=JcB2ybyvOYb6QQ/vOwc0zhgmEUBpsBmycVdnNmLcBZMWdhYJUj1EPhLEizbATaK6uNkA
	 4Hr76+KvEBZW0/d0yjsg33HWgqpKWjEXGb48HgaFfVEGEHwdP3G5yxVwH8ZABrGhbE+oR
	 RON8fTUZJe43asYP7KyKPcSw/7DSyP3UAyozc5OgrvuWW7T3bYEWKLxhjawI1YQXzQHB/
	 UbTNNrIYbqrZ06ie+Dw6aQbJbSTWF5PUhMtQvf8Yxoek69R4gRfmC+AkTxqApUsC5RoAY
	 7korpzMKkSo4f4ck5Y5S5XU2NCeAMi3xxKnOmlaRqf2gtEkGNG4hTV5E3bMyIdBiuPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652950;
	bh=/CqUFK3PcKSMN6ZpFD4M1IAHe0JJ6TSlK8qLZpaXZAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kOjQp1hLja0KWZxVnhFJIlPSy6MVhnHbchFwhDwxnNLkUcFwh/TDILCNTqwDimOVA
	 ZISsjybneZ3/5pOQqYkUT7xg35I375Jw8qOq8Ny7dIyqf/6GrQluXxbmesFc6+lEaT
	 SkVBzGlQ0W8pYrnZIu/hjdTLon9+nJprgnPXbw6LhwUb/H5LAc7rMFFufvPQIxdDKy
	 bqeLKPNXUMuW0PN/0fU0wwQR0dMitp6tVhRc9sLvDabN6rsKXUC2T8B/+Vzxqt09Mz
	 1JD6Oq29Jgmw1vRwVPSY8QjFGj2M7PMxXzkRk5zo3Tc7wUSdysszGbju9uECAWkKwB
	 rq0UXm5hGt5fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CA7780C8E;
	Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 182411AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1CF14070A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJ7i52ZlRZts for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D49B8406E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652946;
 b=qk7KXcSlraiPMu51B+b8Mb3mCT8NLlVsr3j4GKpj4MZ3oR4ynGULiiM8Z/pcMC9wBlE0
 LctcpHMjYKizRaKCX1hjGLoFK4DxG4lWTb+tF4cvSebs/euLy76Co7zNmBt3HiH7g8PEv
 NwWOGewVOhSKR/sEHO31r7+3sdTbZ08ZRN1DGZFBlVIBrl+GYSukTfiDSyKn8xVbz7fCP
 ZD8Wkt0rvZ9xoHa1Xn3xZFHZdwQC9IfsXuo2btepjQV0fNa0zsksOMP8Z/x3t86Qw8Tnk
 HMfasU+ccntDgHG5kKQfEiHbYJP/Ba97pIwGC3iE2tie63omiylTwE5vgThlTNZhgFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=/CqUFK3PcKSMN6ZpFD4M1IAHe0JJ6TSlK8qLZpaXZAM=;
 b=kQVIrs/CcXL0+JoE6ZRIQStZcDBUoPOhjeQ17LtZrttvISpfLNENt5ravrsijXgLLoYS
 fHPnJoP7fnqy0a99gLserSz0iTs3jIsMSgKtuAU0j3zqdit71mCe0B00yejWi7eOFkpBo
 NWIfv4k0BE5QxBgqBd+VDS7e+7qdKooMmHks3Wzfm3GlX5GFjoqP7NFWJurN8pIoJ0ded
 Pz+Gqc6uywOeVuf/eRkFbMnU3JfzRH8Dhykh45YyGLag4ge0/SeUrpN278zV4tVaDl0gz
 wmSQS6ISXvvXTQd8QhNu4jEVIwza9nUJgNzeLgOiEUaHuTT+1xHqbHMAFCoLgGDtTHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jil91Bit; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jil91Bit
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D49B8406E6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:05 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1115270f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652943; x=1793257743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CqUFK3PcKSMN6ZpFD4M1IAHe0JJ6TSlK8qLZpaXZAM=;
 b=jil91BitiFaizOdXhvMlYkLGftizjSlEFcbTxWe0igHdlMX0AlrBeIuU9OMVaRDZD4
 92Zj5WMF92UI/qIT2PULJWVvnufez/UyE+BeodfuIHbnthUL7igdlCtGL7OVemJcXiHn
 iyRbETIZH5SJVubyLFwVO1xjPs9hqkPss1jWe8O7dFrkic6AVBrMFhQEhLGYPdc5hRK1
 42IwMlpk5nQSB98x1TJyrBAKuhgcpUMTOBvOaeqBYHUjaJzeRx9SSmiQKrJb9uez1UtM
 sUG1VAn4ipt07ynWRx/5h98HKKpbG/MzkpO1/Ex97TTAGsJDwTSU9IDD+mozeRbjH7hC
 BItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652943; x=1793257743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/CqUFK3PcKSMN6ZpFD4M1IAHe0JJ6TSlK8qLZpaXZAM=;
 b=1CeZyqJYu1tjD3fK33LvCGZLZns6nwMR1+EtZ38QmOfOKSVzud418La2xfa9xGRlmx
 nIgkvdDPhsDewQLqR+ZEHbR3CbhG5RMaxaduT2Sx96JlO9GqQvORRF7pj5gzyXUl4u5u
 PIJ5DDhUsHWWp/+GiR1ywHEcGRCSR5KiT8c5ny0Dg5DaZVbMrSKK8oy+f+lYybTZDazg
 JP4BtqNyL00J7TdZtI7R4RMW8o8nLAwQay9QBt0n5/WnqZH4uUS8rXVyIBPW1oWQ2kEn
 B7C94SnsPs+vQzv2IIBMiKwUo4UlZrJ1PrbFM25pTlXPdNDbQk4Malp/5vFBHOeGwN8C
 zFwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwc7KX5kYcQiOKQYZGI65W2to9IOyrXFXJ/paeFhlH5felxq19NiLt5iYhjaBBfWHK2G71kk6k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJQysadujjyRTSZ6LUe5bx35fZp34ErNgIX+nAWsTYHONw8wgtd
 JtuMUP4cLGQhTOuY+zOjQ3LERALgfM7krpUx9nlmczcCFoKYoPdyZfE3
X-Gm-Gg: AYBFou38uGxPWf1Qy2QpwQlXQKnUuvJ8/r2np2OQy2un4DD+VDID1HoEPZ3Gt8Ex07W
 ay6Bvw44/m5K8peW8srqEBSoKOZb/JyXMNuhh+M1TJyPZj0ssBKW10my92YbYGTyuFZVwLK/n3N
 JfNc/mzoPuXuLhEahOhg/iQgZiYGWj9BOUUBkuLdszXIAPnSzHcJ5ar1yg4IWlsjwFBnxixOUBv
 pK8kmEd8xhDk74Ix9sBtIDudNjrw2GcTYO2M73mZL3SGxFw6oEanKA69EtSWqYV6t26j+jkSHd+
 AP8H7k2TQqGUKQh82vb6BybhM0o9zuPPn0oEWMRhbIbtg0+SIGdVcldAgfC2GIJCbma4D2d2iH8
 nbR4bOkFDBHO8XAL4m8XdzxQcLgizKXZwjIal5XxYi30wZvLPo7uDbp7ifFA/Y6bO+5HLgOgPG2
 jCKw09Xx3T8SBywNqlLbSN1asnUJPQZSFtn231cUnj4ldmLu3GGMkEo51TmjRsVMNzIZIIvP32O
 Txv0HF0j6uhR8JilygMYy7dxBaL6xUy1OKA3XPKwWC1+z6dXI/VzIMPRTCppw==
X-Received: by 2002:a05:6000:4918:b0:48a:fe3b:64b7 with SMTP id
 ffacd0b85a97d-48e264e7f0fmr9017856f8f.53.1792652943080; 
 Thu, 22 Oct 2026 00:09:03 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:02 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 01/10] fdtdec: match an alias to its stem only when the
 number follows it
Date: Thu, 22 Oct 2026 09:08:51 +0200
Message-ID: <20261022070900.616265-2-mehmet.fide@gmail.com>
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

