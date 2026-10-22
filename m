Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0019606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZcL9uVhf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jUgGCODP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21D408124D;
	Thu, 22 Oct 2026 18:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mNwD0l7t_MbX; Thu, 22 Oct 2026 18:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E9D981217
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792694417;
	b=qUGrm5Cbdr24SVhfyLv9+YfWWgFdDCb4W8Iq9EH/KLF4r4NFq+ZeUyjjjxHSQEITpe1G
	 ZpLlYwbEKZK44TWIpDxe09tLDVe95IQCIR8uvpfMapHVIVdJ//s5J4jDsLKdtDp8XE0XE
	 4S2hIyyZlLUgg7BSoA1yM1M0+I1zx88uKBHDDCnjgbYdi8V1PGIrnu9tZydkoF1TlsFww
	 v1nZX55mja27m9cBY/f/l/jTOqzqX04BmA+W7pPoNloEmKqxAX3RY0V8uNp9Jv8ZdUSDq
	 LtAYY/bUh6DL/J69XGK1M9W7X+jMnPDec46USLDfQLBWhOoo/bXfOdJeF6iF/RrKzrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792694417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gJ+QtWYb/3xoQqUhhl9OhQDlcv1qF3l9T14JBOUGm5Y=;
	b=k2OzNYITIHfUiGQ84x+6UzyZQw9nvIIFfu9MZBxTPI8Zpvi4hAEBDH01/ZxBiUvuqjQP
	 w2EyfOgkGe18uETs1plwfbek8bs9mLHqoM0cK5owogvPgExyZcA1/kTACsM0hzKyxXT//
	 kTBFaVAeZkLkOpz2Ucb4ZfnmfJLaKVLOIGODYD7vkXx0me5Lui+0LyzWR1YTTA4hsyxNt
	 y+/J/iCEsiQZpoRshugJEtJXm1m8/eI9i8LA0in0mVcofRVTBC8wvSX67hzcpAyAuu4ui
	 h1DYj5lqNqpUeY3Bd06v3PqKdM4kdQtvSePgxB/BbtUeKKAhazq/XGIGjLUTm5mXI6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jUgGCODP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792694417;
	bh=gJ+QtWYb/3xoQqUhhl9OhQDlcv1qF3l9T14JBOUGm5Y=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZcL9uVhfKXhzH+FqIAFJGm/0zowokVYbJQt5PTiUTSp7sf6cblI4E3DqUJJdYByga
	 fjfYPIWilg1VJ2BOTjJV79rkD7QsGNS3tRsIa4goPHBFI7031yd0jLWksyqxjAS51g
	 +g5f4HxwlLc7QtGqSCgzTfC3IDhD/kK33HEUyErUY3dxDiCqHCwWtjRb6u2Wh/9lHS
	 oB86GGsYFWr+K4piz77nc0Qbb016/jeAJR2X7c73FY3dHicb1JFLAO9YzRIB7cX7xz
	 ffGWp2HaFYtcETGjXaQcVTC7wyPI9yCBX27vw6DU2jR0Dfxl1VozJQgWnX1F8EDenb
	 Em5Y3OrZRc7Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E9D981217;
	Thu, 22 Oct 2026 18:40:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD5D8356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 664C0810F5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:39:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPcUSWqqYA3A for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:39:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EEDD810F4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792694385;
 b=WAHX1nlemCNQOVmjOQqS2ZU8ntZngsFPTG8D1dFEOmMcXSv6l9hndWlBkqz2piK9lj0m
 m8lMrADgq2AmJCKLVDYeqk9TJ1dAZNgXt/bcF0oPhtLdkUIJMru17QSsrdk2ppDzXYLNC
 HeK/BHFqSfaQVK/THu8gN5yJWj4cCQmRjwY2DjeIFERdPJPMMh/l6NU0aeL3jiOB7jAak
 i7GEkrcV706cNZK1TRfxvTFXCYxy9SeDjPX6+cQ0071KObf78eFkCBXsc8UWMegkiLw+u
 AA3pc14G9gOo3+Xnpt6nmxq7buT/AxyCRUDNH+CPRL4NN9iT0WWNRtzMoxtXfpn2nfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792694385;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=gJ+QtWYb/3xoQqUhhl9OhQDlcv1qF3l9T14JBOUGm5Y=;
 b=ObOclBWfudU2FyFdB4nGdHFew39GK9Foj0TWjgi7z9WfE1B8E9m9MeuA0bX485D4LdT8
 XKi0jAmZ6ry/VFd3CAjLdDmT+WWBTC3GqMIchCjDH02JpQbYEVEOLBRQuXSsuqjenBcOg
 0bxxicu2edO4COR/6RUHaNaZ/q0tq7WkiFxbYJr7yIeKVBIsc9YuhpmngCbR6a1ZjKbIK
 qbrl4NJcfCDkeRl267yeH8hlnLZcVRWkh05sxJ2qifzjZZZMeuPrNrdlbIaLMWi3lVptV
 dUjs5mPk/5pZ7HZRot26c2qoollmJL3IuuYkshM6ZIcUcyYZzUfDBvJlkrLkS48CJAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jUgGCODP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=anon87111@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jUgGCODP
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EEDD810F4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:39:44 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so88723f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792694383; x=1793299183;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJ+QtWYb/3xoQqUhhl9OhQDlcv1qF3l9T14JBOUGm5Y=;
 b=jUgGCODPeNR/ZhJGOMAAiZ9oCRu5peStvvpdiVrqUvY9hew2i027OXqmgTrcRoavFV
 uOCH3+c/t9weiao+jWtKWIs1v7OU7RXbm6lW7UYaaAazqVlmFunpn7N05kMgv13yeL/i
 +9y2WwRDFeJPkrf9rxSaKSnle001S7ooFkQ9ZLHKKgY5Bj/nX2Xjb8vVNP05emCWCPpn
 SZLKdx3ZNX3C8GkIUZXDvW2I93gy1AS5DT1rjzekRNQWcWfgcLb586mF9T8TgjahMl6h
 Y6W/MajecEEpboweROt6xWnLq9rtKU24wB7AKlLiFGYCcMU6GHUcwUGx1SBn0Yh2LNdf
 uxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694383; x=1793299183;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJ+QtWYb/3xoQqUhhl9OhQDlcv1qF3l9T14JBOUGm5Y=;
 b=NhFowZGt0iEbuomD9b1sRBoSgba1WPqjmU8rqIp2SsuepWd5KEdqnr9ENJe8vPw4uB
 qWDyl7p3jCDJmVUPsb35ATXG/WFM9q8sV/t+liZZqA19YvfeY909tG/FkHDt0k5GQDo7
 1mUF3/0R+fa0YHm8lChdJPcNVNoGORXdvvuQyFzfxsNCbuKWgw2WSW45ZQ+V16keS3p/
 d7geuWlKy2so9BHIMf+eg4OR8oLFR5Mn6Ib96osPqFZF4gOKd+TEnfTnc2sqr260AYWq
 Lcaye5Dlz3505RsTKy+8TTOcM22jsjj4nsAWUoQSvH4+H8Nka0SaFuRgQPs9AOAtas8I
 jDXg==
X-Gm-Message-State: AFq9FYIGAS6iwv1OeM5ExXNUpdJWSRbAH2DbHKtekIH5whqs9BNSne2h
 yvKbDAF/t25Lj4WWL/k+7f3RXfR9GPCBPiJKVDHuyymAupxRx1HH9qoVFpV9EfwJ
X-Gm-Gg: AYBFou0yQb1xeRpJCcHZq4tD2gqkwnLVujjbao9YGUW3bs15+ir9ZPBUxY62Ic+3XQ2
 s+SpaLTdcOpXA5oDD2/zpT3kDRGeGoVKI9ja7w1C8VJP+JK3rb5neLi5ssls5KbrcbctZFL99Uv
 bdma1gbLhQH3BIBZB/NDiE5+J8Bfz0x27563IeEBJf3qGWz/r5VRJy07EzBx5+5/diw66uUiJDJ
 8B1YVspyzOWxvw7FqcfB2ym10IPuyL+1CChmbVXmMWYjkNNGWfZJFZ6PwSQPV88NT78FcOwrbnV
 pypghCOrArE9tqFE0x0uvMRQHYnIUCbqpp/pTN4QN/EgxikEznEZK1q86V1yUvz3Qu+Tx7N/pu9
 kIMf2NbBHhxM2UV+BOmO92vs6ccvqF60cm4awZGZ4kAfwwdsu2fg0F8xF+LXBYGFUbFeERPyWzz
 5u5ueTZFiB50CNfNgOu9kNta41hITGAqk+7mEvtplrOUsxoCP43zrjAu2cdNedPrj+UV6zJ7a/4
 A+hAyESbj+ekUz6gWc6tAhcOkMaVChQFifxkzXi9DxotFH8FRVHABJzQrpjHvA9/2SHg84xLpw6
 k67Ymep8O/a5sEOO0hyaACI6b18=
X-Received: by 2002:a05:6000:2386:b0:48c:490a:336b with SMTP id
 ffacd0b85a97d-48e2642399cmr13776131f8f.5.1792694383045; 
 Thu, 22 Oct 2026 11:39:43 -0700 (PDT)
Received: from ?IPV6:2001:7e8:c647:4001:7656:3cff:fedb:3af7?
 ([2001:7e8:c647:4001:7656:3cff:fedb:3af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e379cf6aesm118457f8f.18.2026.10.22.11.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 11:39:42 -0700 (PDT)
Message-ID: <c752b277-c4af-4ab5-b882-092c89df3f09@gmail.com>
Date: Thu, 22 Oct 2026 20:39:41 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: anon87111 <anon87111@gmail.com>
Subject: [PATCH v3 2/3] image-fit-sig: honour required-mode on the image gate
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com, me@ziyao.cc
References: <20261022180000.1792693930-0-anon87111@gmail.com>
Content-Language: en-US
In-Reply-To: <20261022180000.1792693930-0-anon87111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 18:40:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fit_config_verify_required_keys() reads the required-mode property from
the /signature node and accepts either all or any of the required keys.
fit_image_verify_required_sigs() has no such policy: every key marked
required = "image" must verify.

Mirror the configuration gate so both behave the same way. The default
stays "all", so this changes nothing unless required-mode is set to
"any".

no_sigsp keeps its meaning. It reports that the image carried no verified
signature at all, which is a separate question from the policy outcome,
so it is still driven by the success count and not by the number of keys
marked required.

Update the documentation, which scoped required-mode to signed
configurations.

Signed-off-by: anon87111 <anon87111@gmail.com>
---
 boot/image-fit-sig.c        | 32 ++++++++++++++++++++++++++++----
 doc/usage/fit/signature.rst | 13 +++++++------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index d6c61e1045..4b50e45965 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -190,6 +190,9 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 				   const void *key_blob, int *no_sigsp)
 {
 	int verify_count = 0;
+	int reqd_sigs = 0;
+	bool reqd_policy_all = true;
+	const char *reqd_mode;
 	int noffset;
 	int key_node;
 
@@ -207,6 +210,14 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 		return 0;
 	}
 
+	/* Get required-mode policy property from DTB */
+	reqd_mode = fdt_getprop(key_blob, key_node, "required-mode", NULL);
+	if (reqd_mode && !strcmp(reqd_mode, "any"))
+		reqd_policy_all = false;
+
+	debug("%s: required-mode policy set to '%s'\n", __func__,
+	      reqd_policy_all ? "all" : "any");
+
 	fdt_for_each_subnode(noffset, key_blob, key_node) {
 		const char *required;
 		int ret;
@@ -215,14 +226,27 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 				       NULL);
 		if (!required || strcmp(required, "image"))
 			continue;
+
+		reqd_sigs++;
+
 		ret = fit_image_verify_sig(fit, image_noffset, data, size,
 					   key_blob, noffset);
 		if (ret) {
-			printf("Failed to verify required signature '%s'\n",
-			       fit_get_name(key_blob, noffset, NULL));
-			return ret;
+			if (reqd_policy_all) {
+				printf("Failed to verify required signature '%s'\n",
+				       fit_get_name(key_blob, noffset, NULL));
+				return ret;
+			}
+		} else {
+			verify_count++;
+			if (!reqd_policy_all)
+				break;
 		}
-		verify_count++;
+	}
+
+	if (reqd_sigs && !verify_count) {
+		printf("Failed to verify 'any' of the required signature(s)\n");
+		return -EPERM;
 	}
 
 	if (verify_count)
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index e5d6ce85c7..c8856772bc 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -404,14 +404,15 @@ that might be used by the target needs to be signed with 'required' keys.
 
 This happens automatically as part of a bootm command when FITs are used.
 
-For Signed Configurations, the default verification behavior can be changed by
-the following optional property in /signature node in U-Boot's control FDT.
+The default verification behavior can be changed by the following optional
+property in the /signature node in U-Boot's control FDT. It applies to both
+the configuration gate and the image gate.
 
 required-mode
-    Valid values are "any" to allow verified boot to succeed if
-    the selected configuration is signed by any of the 'required' keys, and "all"
-    to allow verified boot to succeed if the selected configuration is signed by
-    all of the 'required' keys.
+    Valid values are "any" to allow verified boot to succeed if the selected
+    configuration or image is signed by any of the 'required' keys, and "all"
+    to allow verified boot to succeed only if it is signed by all of the
+    'required' keys. The default is "all".
 
 This property can be added to a binary device tree using fdtput as shown in
 below examples::
-- 
2.53.0
