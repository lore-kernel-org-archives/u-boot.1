Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1820606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H4YxCy3L;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKm2BwTF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD72240A3D;
	Wed, 28 Oct 2026 21:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUfWgomQU_mA; Wed, 28 Oct 2026 21:40:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE2BB40A2C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793223601;
	b=awrpWtL6CN4dTBdQew8BEtKHhpBStX7tLcpe5mmwVSEtbPz6VetZS5sWwzucD17WyBeE
	 AwFxxyjlgZru/8EyufJQvCJ+REIB6zOjLwyuNT6ikIbC/ftNznG+KMaxQw+4DVYlvWBwd
	 NsuvTfDy2DLEW8OWC3kvJg9oBekCLc9P6/6TZM8sYO1ufKiobw8sZsVVAIk6suZ+Mvf50
	 ZotkAsZRojvgKEC7WHSp4A04KVnnIKwGMhGBVOGbk+FOYKtERFVuD2TCFblXec4zEtlhR
	 6uH1p8dkzaoiLbqXnbu7l6XC/LJQGmVCE5mpJmTPYO9+xQr/vh/iwDLLF1T5VJAMIvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793223601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q9bkPp7TXQ3e8j5H8y0JWzVAVupNOts+nj0dKcoRTWA=;
	b=PfpE/Fi8LQCb5/Z8Imm8vOSI4A2VoWym+ZFn5UutO+ljbX+OuYcjPKy1gpQGECBaOotl
	 07nFd8wOK2jubqjctYTt+1YfM3NIY5z/pEzk/4Oe2EbCaLlgCDg0tTDcRVKWLpdJ2M30K
	 bkX+gJOHJt7RWT+2ne2yt0HBaWzknUWcdYCH84zHIIXhDZvz7JIQXY2wUgyOQwTs8i4VJ
	 eykzQP6STUmX5RoSEqFja1/4JrNfSg3eJQ7b0IOiIWAXOLCeEu6lqP8hB4rzBpJrCmF08
	 EWdSYzGqlSGlvzeuiTXm1i1N2qPPrW41RfC4ADXT1xCgZ5ygwhLkUXaOTfd3aA85ILg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793223601;
	bh=Q9bkPp7TXQ3e8j5H8y0JWzVAVupNOts+nj0dKcoRTWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H4YxCy3LPD+/HCyvxZ9bmAXlz0SW2XeX60Mm9zDh6M4WkCerfaetpEmkU3cIglL5s
	 59kXIs6Qi3uUoR5LRsqbkNL+gwZA8OK5CRgtlyBplt3MovyVQgmVBmnw4aXYtg7cEV
	 Ett0611+/AwdC2E/DKdaBur+BY+DSH70/QPKrtkar/WjPb5i4aKgKbV9NQfZ6QCwGH
	 mr/wrrTuPO6J1OUGypWTlckwrONRpV2v/NlYoGf3VOm5Hko8lQPbjTKZhnnpRKxxwL
	 Y8GriIQYfeG5ERMeId25MXMSJH8FjSkAhbzHKBfwr16KVsmS2UVR4GzCH2N48un1ez
	 tOSCj5dqEMsTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE2BB40A2C;
	Wed, 28 Oct 2026 21:40:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CBAD6362
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD42440725
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYtfLDGkasZr for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9D531407E4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::233"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793212319;
 b=T4FVhEPIqVG7NCHyRMHg0One6UAPhSTu2lpdp+sO1u/yIsJtFvmYsaYyd5V9aJwO5jdA
 siGwIO5tO1b0vq1yFEdBMrPnqM/dxmIZTiHsh4f3J5r/Hvu12iA81rGf7hP6x1pVwkgcr
 hqYximlqJTDy+s1zsRslOoXoG1ZIF3+UFFHJFwVaAH4aJR4ZaqdoizS86kjYrcAu5dKUg
 IAmfGQdmhucxOodIM6G8/Gdk7jOx9J/+BRMr26AWwEjwprKiCBwDifqzVldmUHqsW5acs
 dQ2+JYQLdy6Ex6GjQ1avSg1y5mwFxxNieJbvZdavj6b0xBthIdWpLPF/mO9xgyZCSSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212319;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Q9bkPp7TXQ3e8j5H8y0JWzVAVupNOts+nj0dKcoRTWA=;
 b=HyxrYAZF82H95XTdEpivXL5rye9Cci62oeRrBJ3zMcoDdyqSLrpfmuev2kGPK6sGidny
 BfS6O0m/6wpy8c/xZrW/X++eX4C+S7FhpEh9vhWRnaOk/R2CGX09f2fMv1Dau/Fg5AcjH
 t7pNSDlzVWpNKM7ZbETRuRDRyMiJFnTWFPClVrorB2K0LFSg8x8EX4Juq7SieigtvFvnO
 NArqzMIxsC6KRw4j/j9IpdTLRy7Sqctr3nF6FqQnRfr2+RLoFVKPv54P0W2JRH9sM7Z4f
 Qpv3YUe0Sn9ZDPKC9airGo9BXR6dcJUELgFlur6fw7oJ+FUjbwWQk4HdQKRRgn2lfJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=AKm2BwTF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=AKm2BwTF
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D531407E4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:31:58 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3a75f960be4so10410771fa.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793212316; x=1793817116;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9bkPp7TXQ3e8j5H8y0JWzVAVupNOts+nj0dKcoRTWA=;
 b=AKm2BwTFWKn6vvzj4tLqzN/4yLg5OpfnLfc5qE3KiiNAUSpC0jaIq+rec+hAl4dujT
 SDZKzN+XT4pc/oe4MG3tJFm94iOpjESJIkdGY5VhDoloLg0R1qTiACVKTAkCjq/zfrvS
 G7vsAR82By0dpMDR1jPFle0lxcS00JknTTV9vdWApuiGwiD38jaNYknf++vqFrgAeyhi
 +VN/Qa79jKtijFqkgapVXAGLqsilhD50bxKz4Y/DmAbDnMqRsRhut99YmNUQmCef0ZQ4
 1NrZBL5/E4IGJeUiOiygQjSCMXvi5KIOMEzbbrHAR1032y9kmLvkcjQPG9Nec3R2m2vT
 C9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212316; x=1793817116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q9bkPp7TXQ3e8j5H8y0JWzVAVupNOts+nj0dKcoRTWA=;
 b=qzbndKc4/IHWZ1K6TjrVL7q2gJk5YxT11oMwCLTTErXXLsDb8N4Ff30tU0VwU0znEE
 turHXMmHcan92UWw/8BNomWqCgagDJ/S1Ako85X+mS4u49he2besisYoSvE33FtTJ5nO
 myV7PRULIQb5QDg+T3uv9n0Pgfz5tqMj6VO9y/hZH5WbE3UA5XiwnAENTsjjJ5dD7BN0
 cBbo1AQdcbk9FX9JSz1p9uEdu3uEIelbebdLhCRRu7sQshvQuFBC1JLvdHhDfx5EhlIi
 gEoKsdA4gujXlw38+sxaRfiz9dsOtfYvhpLUkbglSTyorxhOgf7hnwcS0IxERQDZwZ5t
 DkMA==
X-Gm-Message-State: AFq9FYIQdY1liRgWAKnltFFhtoS9gtLZK6jRpuFuNMrX4NzbMljNU8wQ
 7xkkDQBaSp+WCVA0xk03f4+PLAzP96HXNuVLSWJ2dzMgFX2ckHtBqqXv
X-Gm-Gg: AYBFou2m/QlIunE98CCcqeuCzLy6Uf06KUexGagY7Ee/6CxcMLudEkgYEmAHZYAGp7h
 w7OeJQwMPCwA6by7gidrnf16Io6jDo8ijJaPXJHQzNMV3f2gDekBBfaqlufKy3pDJJO8/HZUEU3
 XANB3DUQ6Cx+1Z7767urU+Rx9+Rufe+81L/cBrfzTju8DHAGoiwZukdO9QCWzn7eiq8h/Rbns29
 1nLaWxSYj9wBKLpdpOKJ5Y/VuKaD/XCOSpGiC0WGDa/+AJtLZjjnASR+2+U6zzmS1AKb1UYMDS5
 pIFhH2lq7e2+JSI2U2klt5UldyujxD8ZRwfqr8ByN2VKABa6CBpo1RRrZFqEvNagmnALS3p28dc
 s3pENVT6UfIv6aPFvmLxX7N+phAS/iljTKgQ7I2ogG2sGH/ZUVDFPNH6mtefqLSvXwNQZ7izij2
 qauH0fzu3x/HPj/PG1YQts/QXFbiTZiYweiT8cUFDUTJCsj5t2r7c1/FFZJUcWa44b8TBi07Ivt
 25yWa27mRuakXKPwLq75pp2qDoAtu2J4JjanbKiD4oYvXH2EVh5xzJhmg7mu8wRSp8OcmHN0XBe
 Emnt55KpEs9XVmhhXTRyXwq7MpNXXW46hBCdS1O8fEh2UoV23PD47ATu3wTZqWypXR0RSvuAS/N
 G0g==
X-Received: by 2002:a05:651c:2101:b0:3ab:ac4c:186d with SMTP id
 38308e7fff4ca-3ac9cf5fbe8mr6760901fa.13.1793212315674; 
 Wed, 28 Oct 2026 11:31:55 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a11442sm33252271fa.28.2026.10.28.11.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:31:55 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Subject: [PATCH v2] cmd: binop: validate inputs and fix heap overrun
Date: Wed, 28 Oct 2026 20:31:54 +0200
Message-ID: <20261028183154.823513-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFLszTgxvQ9z8R=nr8COaFvHKS+cwEnmHjjG7ihhVBxfiBtunA@mail.gmail.com>
References: <CAFLszTgxvQ9z8R=nr8COaFvHKS+cwEnmHjjG7ihhVBxfiBtunA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 21:39:59 +0000
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

The binop command never checked the parsed count, hex strings or the
return value of hextoul(). A hex string longer than the count would
overrun the heap buffer and corrupt memory. Bad input was accepted
silently and the command still returned success.

Require the count to be a non-zero decimal number. Reject hex strings
that have an odd number of digits, contain non-hex characters or are
longer than count bytes, reporting the offending env var value where
there is one. Check every allocation. Return a failure code when
something goes wrong.

Make the file-local helpers static while changing their signatures.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
Changes in v2:
  - Explain what count is now accepted in the commit message
  - Make the env/mem helpers static
  - Print a separate error, showing the value, when an env var holds an
    invalid or too-long hex string
---
 cmd/binop.c | 93 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 30 deletions(-)

diff --git a/cmd/binop.c b/cmd/binop.c
index 10d91b5dbf2e..ee1ad671f3c6 100644
--- a/cmd/binop.c
+++ b/cmd/binop.c
@@ -2,6 +2,7 @@
 
 #include <command.h>
 #include <env.h>
+#include <errno.h>
 #include <hexdump.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -14,13 +15,15 @@ enum {
 	OP_ID_OR,
 };
 
-void write_to_env_var(char *varname, u8 *result, ulong len)
+static int write_to_env_var(char *varname, u8 *result, ulong len)
 {
 	char *str_output;
 	char *str_ptr;
-	int i;
+	int i, ret;
 
 	str_output = malloc(len * 2 + 1);
+	if (!str_output)
+		return -ENOMEM;
 	str_ptr = str_output;
 
 	for (i = 0; i < len; i++) {
@@ -28,40 +31,76 @@ void write_to_env_var(char *varname, u8 *result, ulong len)
 		str_ptr += 2;
 	}
 	*str_ptr = '\0';
-	env_set(varname, str_output);
-
+	ret = env_set(varname, str_output);
 	free(str_output);
+
+	return ret;
 }
 
-void read_from_env_var(char *varname, u8 *result)
+static int read_from_env_var(char *varname, u8 *result, ulong len)
 {
 	char *str_value;
+	size_t slen;
+	bool is_env;
 
 	str_value = env_get(varname);
-	if (str_value)
-		hex2bin(result, str_value, strlen(str_value) / 2);
-	else
-		hex2bin(result, varname, strlen(varname) / 2);
+	is_env = !!str_value;
+	if (!is_env)
+		str_value = varname;
+
+	/* Shorter hex strings leave the (zeroed) tail of result untouched */
+	slen = strlen(str_value);
+	if ((slen & 1) || slen / 2 > len || hex2bin(result, str_value, slen / 2)) {
+		if (is_env)
+			printf("Error: env var '%s' value '%s' is not a hex string of up to %lu bytes\n",
+			       varname, str_value, len);
+		else
+			printf("Error: '%s' is not an env var or hex string of up to %lu bytes\n",
+			       varname, len);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
-void read_from_mem(ulong addr, u8 *result, ulong len)
+static int read_from_mem(char *varname, u8 *result, ulong len)
 {
+	ulong addr;
 	u8 *src;
 
+	if (strict_strtoul(varname, 16, &addr)) {
+		printf("Error: invalid address '%s'\n", varname);
+		return -EINVAL;
+	}
 	src = map_sysmem(addr, len);
 	memcpy(result, src, len);
 	unmap_sysmem(src);
+
+	return 0;
 }
 
-void write_to_mem(char *varname, u8 *result, ulong len)
+static int write_to_mem(char *varname, u8 *result, ulong len)
 {
 	ulong addr;
 	u8 *buf;
 
-	addr = hextoul(varname, NULL);
+	if (strict_strtoul(varname, 16, &addr)) {
+		printf("Error: invalid address '%s'\n", varname);
+		return -EINVAL;
+	}
 	buf = map_sysmem(addr, len);
 	memcpy(buf, result, len);
 	unmap_sysmem(buf);
+
+	return 0;
+}
+
+static int read_src(char *arg, u8 *result, ulong len)
+{
+	if (*arg == '*')
+		return read_from_mem(arg + 1, result, len); /* Skip asterisk */
+
+	return read_from_env_var(arg, result, len);
 }
 
 static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -70,7 +109,7 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
 	ulong len;
 	u8 *result, *src1, *src2;
 	char *oparg, *lenarg, *src1arg, *src2arg, *destarg;
-	int i, op;
+	int i, op, ret = CMD_RET_FAILURE;
 
 	if (argc < 5)
 		return CMD_RET_USAGE;
@@ -89,22 +128,15 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
 	else
 		return CMD_RET_USAGE;
 
-	len = dectoul(lenarg, NULL);
-
-	src1 = malloc(len);
-	src2 = malloc(len);
-
-	if (*src1arg == '*')
-		read_from_mem(hextoul(src1arg + 1, NULL), src1, len);
-	else
-		read_from_env_var(src1arg, src1);
-
-	if (*src2arg == '*')
-		read_from_mem(hextoul(src2arg + 1, NULL), src2, len);
-	else
-		read_from_env_var(src2arg, src2);
+	if (strict_strtoul(lenarg, 10, &len) || !len)
+		return CMD_RET_USAGE;
 
+	src1 = calloc(1, len);
+	src2 = calloc(1, len);
 	result = malloc(len);
+	if (!src1 || !src2 || !result ||
+	    read_src(src1arg, src1, len) || read_src(src2arg, src2, len))
+		goto exit;
 
 	switch (op) {
 	case OP_ID_XOR:
@@ -129,21 +161,22 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 		puts("\n");
 
+		ret = CMD_RET_SUCCESS;
 		goto exit;
 	}
 
 	destarg = argv[5];
 
 	if (*destarg == '*')
-		write_to_mem(destarg + 1, result, len); /* Skip asterisk */
+		ret = write_to_mem(destarg + 1, result, len); /* Skip asterisk */
 	else
-		write_to_env_var(destarg, result, len);
+		ret = write_to_env_var(destarg, result, len);
 exit:
 	free(result);
 	free(src2);
 	free(src1);
 
-	return 0;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
 U_BOOT_CMD(
-- 
2.47.3

