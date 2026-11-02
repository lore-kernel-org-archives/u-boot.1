Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61B606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DrjJO6ZT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dV2toQRJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01E2E605A9;
	Mon,  2 Nov 2026 20:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhhRkzGb8k6S; Mon,  2 Nov 2026 20:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0172B605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793650631;
	b=C60j4gPMVSHoPD10mrotjIY0Y0TPctVKKMdaoH42s4YPg/IHtO9GGP6HqAqaNzjBgO/S
	 OBfPPRMudq/2j+kTI8yLwvLUOrfivd8JYasZkPRvHJkYcrGYfO2ZzkxzfIMj0X+MOKba7
	 SqXkd6onIYeWezy4J4vUl3aJB/NVQuEeAhDGHFZ8aXox6li9Euk7+srxGH6JGcpjL4fk8
	 FwOPC19I0Bu9EaATW1cepOLh6IN2eL/d6zbcgoHcbfrz+A5EHbuUIsLC1v3jLZ5xs2jwN
	 D/DHxDZUQESuq4ThJ6l/AESr+u61MuJmNn4bVs8ooYYabjpxX5G3zDdQlIdtbj9jEkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793650631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y3FO33bTOaS3bUe2pBlhKlxZoB3w1RA7flksbMaq4TY=;
	b=T6QAth13C2OYzAyGdF4xlLdWeuFTtwHoKryL2ai8eOrJU/jgGCoc/PhtujsuU1v51ITf
	 1wt/D6xcpJjD6kyv9bZsX2O72tHOtpNMtHhxpYAuEI9m9tuco4rAsAInCX6xb9Qxrwieo
	 pvS2GUR9Yl/k5sXkSBx8lcF+GYRdkLk2VLq3Uk0+DyyLAd3E00COSH9KPSN79z/94DFF6
	 sDycE8hs8KYjptsyVgEZTzdFQxw3XgENZArz7l/fJkQZhKXMxGZDhdGA5C49/hcHHxz7H
	 nK9Zg++d1ZU6dHwN3wZOG7klDOqDUK8hCsk6cvK/uP4T4A/mry1QCELR9BaPsMkBQhg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793650631;
	bh=y3FO33bTOaS3bUe2pBlhKlxZoB3w1RA7flksbMaq4TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DrjJO6ZTzl8ABbZn7QMfmenxShQF5W6qLtsBrxG7LD1/Sjwe5iDkNaf+EnqKwZlXI
	 rkidiUskyRhQdxGuJ1sb4HzRT47YVM/aq8vIl8Iappo3VL2NlytMspTW92Wv9n+g0J
	 YkDxyVmDlI+Qm5tkgWRuc3jZZywHmwHmkbh1YascxbCpLIHg0aMJta8ZsLrnGENQEz
	 wWZfnixUtpSh5Gb0xi9nYOlahqW6feavpyg6+6lqkHg3ujL3bl+fVkxDk1nO8/9Fhq
	 Y5+K72SsQqOpmsyp2X3ejX+n3A2NugP0uvepvrOpsCBiV2QUv5jxORAK5dXBfc7Xuk
	 tRDxJBGXaLl4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0172B605EB;
	Mon,  2 Nov 2026 20:17:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 76AC44BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67E8E40218
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0pVxSQRawNCt for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 20:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EDD23401B9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793650628;
 b=q5+TQ8mimh4TeJfH7vFdB33LQPZ0bCnJpjaIw1RdeasOFn6Jx+aN/bOVYmkxm7RR21kl
 zdNoKuYY3a18RmbmAqvbbG62lIano4RduccZA+E7/xQ8EOrRZJOh+hJ3Pz6xazSyIHCtz
 QV9tXaDq1xK/E+d4JmCVL9dWftmmN1ODI6mTpgxFjdwstncokwby6Fq7LR3N7nguAY7Ap
 +b7BwmhZNydcx2nNgkHV0GODn7xg2/T4/zrUajJEsU+mwucdIWY6Na/F/LTJs4wn8c6D5
 rtP02br6XMzDYsU6gdOJun7aNRbtyavjmLNxn9c9hnn9sJ1g9JPawemVR3kNe3SgbCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793650628;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=y3FO33bTOaS3bUe2pBlhKlxZoB3w1RA7flksbMaq4TY=;
 b=Qya60s+Dp1n+M4wFr9amSKIyU5RFqpJvh2/0b0XVxbTRtX54Tqg8YmRP/5cP1hmLGTRL
 T/KbiDdWzTgCY873XRnLCrRbbjnx6Y70QNndX0NqbU7iS7OE1MiWH0xuAmqqLvj0Hofba
 IbSeXOifCCL1hgUcnuksWG0RT3rIP4xvxsgOc4DUhlPEeu68wYrXaRWf4azA6ISQp19CK
 iPhM/Foh+iuxYSAXrZi/iv60DBigRqMP09EFgHpSARqYFzT4WG66OxpIjLRb2+GqOKLKS
 sgbPUXXgwPuO/Q3Wxwg1wLyYftDLDMiygWOGILGtD5I/bESVhOpXdmUxJtJQca2KA/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dV2toQRJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dV2toQRJ
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDD23401B9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:17:07 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5ba36cc21cdso4971763e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793650625; x=1794255425;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3FO33bTOaS3bUe2pBlhKlxZoB3w1RA7flksbMaq4TY=;
 b=dV2toQRJ1VRP2OlkvzTngI1Iz6J0ygAuWfGMZUvqVPkpu8Vgad42lM8An8E9caj6cF
 d9M4X/p0D19gWOob9Dv6UseSoe3tQJX9QiykyozgzQYUHZ+MGCtv+mve9MMUvq5iPdnT
 9ky09ViVeInQJQxDp6uJh5ODAtRAZxwx+DbCCtBwHpq0K0aDezEVinOQ480eRlEtuOmU
 5LQytPyoJCI83JbXMspWfYIiETSRliWc1gLNcvyTna3uQMHpw3aHf89MMez3hxfR5mrf
 bbeg2YNQmcHL6cMUY7PsWUwbqbKFHSWZeUNbrLCtQBFLq+qGTMLk8hmeLx1Kv5vLDOYx
 3JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650625; x=1794255425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y3FO33bTOaS3bUe2pBlhKlxZoB3w1RA7flksbMaq4TY=;
 b=f+NTD/dGojmBg9edtouZ0h2paJ0wOI9K+h3O57OF90JJz2X9cLhsyF+nl6riHIwVPy
 1HoE5b1gcrgWX51dRhMU60vvhjlFEHTpkSdKUU9OWc+L9HCtTauPtJ4Dj8zUyNrIqIy5
 jjyrQo9U9zqOSXkpsjPFI22B8V7nBqFAuu02FV9rkFiORJVmBnO2CC3xXCtW1YRdPWgG
 xtlTFS1KU3dZWymIT4fO13wp6n4WvyaiSF+/QzfSBjUl6cSwkmBGagGaATrsvHftJgMF
 Q4MURxSk+dG9hTNmxA+p9RPV3lm5nOmqzubpWd0xBti6w9TNejx/DYS64mAbyNfHvZRh
 bvSw==
X-Gm-Message-State: APuU4Z/qt2sx0vJjbZ7h8uZ69Dq+Kxd2r7RceR+ya1Std38r5QpzLWG/
 P0BetYjrSuL9ZOgME8l/T22gc7QFjS95EnL1FQ57UOXdTEvrfxdnkemc
X-Gm-Gg: AYBFou1YWROumQxEI9tOEBEcqsCOuWtA6RXSaav3gG7HiuRDLw6YNNpqMxbqaY4Hm7u
 XN80MvAZKtECUBI/TWJHYXHZJP6PTyn0WinPOCbpUTcP/J1rD/lcNXfLpJZ+WAAo8tA5cr5Zgif
 0zyLQP7ZraY0VUU1oFAKTPheDlWFoRsiwVEVyTOerHn2FOMMJINOxWLUSnJqTBtbNCorrr97Ykt
 OS1lXW0Xv1BeW3M3T6Bnvdcu5TFX6+Q2GlW+OtPJjcf4W2coXttD8hme8FvHvqP/qI+JoSsuXGF
 D0hQgyya3IEtGGWu5Edci6M0JO1r3LfnZ8juFObaxNdTTZzkTDdrPNfnRbe2S0IzwKLeYD9tddq
 nCBLU6+a+o+XtAhRHEdHGel/KyWuNrUn/FZZ9LDQlCLf15UHVr4yufxH0fCRjvtNySxetu7pgD5
 WiDCDqxOngd/0vJzdg9YwiHAJ/xT3TxIvxpI3/qH+nK/j22SDFI5GZ5odoePEbXaHH2p3rleIxS
 ifgzRfvJedcbwEPcII1ycBIizFz53r9BLSeNlSQ+qBLn527pDgnPCxT19ocnsnv+bKXYvvUVDrf
 8i1alnzaJrpDKLuy9MrCNUw6nfeiBlwoSE3HafKSG72RFhto8IcPOjJnf2ZC+6XxiuUHamWnod1
 VoA==
X-Received: by 2002:a05:6512:31c7:b0:5bf:aff9:86c6 with SMTP id
 2adb3069b0e04-5bfd951d67amr3594575e87.4.1793650624775; 
 Mon, 02 Nov 2026 12:17:04 -0800 (PST)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfee2f683csm182347e87.56.2026.11.02.12.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:17:04 -0800 (PST)
From: "Maxin B. John" <maxin.john@gmail.com>
To: sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Subject: [PATCH v3] cmd: binop: validate inputs and fix heap overrun
Date: Mon,  2 Nov 2026 22:17:03 +0200
Message-ID: <20261102201703.2235449-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028183154.823513-1-maxin.john@gmail.com>
References: <20261028183154.823513-1-maxin.john@gmail.com>
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

The binop command trusted its arguments. It never checked the
parsed count, the hex strings, or the return of hextoul(). A hex
string longer than count would overrun the heap buffer and corrupt
memory. Bad input was accepted silently and the command still
returned success.

Require the count to be a non-zero decimal number. Reject hex strings
that have an odd number of digits, contain non-hex characters or are
longer than count bytes, reporting the offending env var value where
there is one. Check every allocation. Return a failure code when
something goes wrong.

When printing to the console, a count that is a multiple of 16 left a
blank line after the data, since the last byte of a full line and the
end of the output each printed a newline. End the output on the last
byte instead.

Make the file-local helpers static while changing their signatures.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
Changes in v3:
- Don't print a blank line after the data when count is a multiple
  of 16

Changes in v2:
- Say what count is now accepted in the commit message
- Make the env/mem helpers static
- Print a separate error, showing the value, when an env var holds an
  invalid or too-long hex string

Related patches:
- binop test support: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637972.html
- binop documentation: https://lists.u-boot-project.org/pipermail/u-boot/2026-October/638262.html
---
 cmd/binop.c | 96 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/cmd/binop.c b/cmd/binop.c
index 10d91b5dbf2e..189df03035bb 100644
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
@@ -124,26 +156,26 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc == 5) {
 		for (i = 0; i < len; i++) {
 			printf("%02x ", result[i]);
-			if (i % 16 == 15)
+			if (i % 16 == 15 || i == len - 1)
 				puts("\n");
 		}
-		puts("\n");
 
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

