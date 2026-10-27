Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B27606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jviDQel4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+pshuCa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A16B80F5D;
	Tue, 27 Oct 2026 16:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4De9z2S_MZ1V; Tue, 27 Oct 2026 16:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7E4380EF1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116911;
	b=fokWz4cQg021iXapSPYlRWznEsHgz7zJQ6eF5ZjfaB64bqe2I851AsiSsIvdo2RDoRCr
	 z0D+gDEtdsQLknALQsmwksJ+pbnjJv8FWFpKLG2DF2TIe/CmPKMyD3LzpLHo+lTHD4jzV
	 lrCso+hQwXMtXfQ0v/sWgnY1vRHubUBjgnFEqjfHGr5UIHrHckP2NZvIe1VvGpoYBO2b/
	 TSoSACWEGTJN7MeBdDMeHv/aZ5BuJ0aoE1girMa4P760N7wBlWlRMxZSiOJlgiW0GavT/
	 3iGBENjhw2JA9O1YX2v3UywSeqoAodH6f5Ip+DvSID4EE98HeU9MJXGhTUGaxXQiPWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116911;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9kINL7arTs4IbNo4rV2p4l31rIh8GCS2d9evYNZ0LUI=;
	b=dWVqzYOlvl1a6kxxCxnRY9H1Ipm5nZ3y4PZJpbk9mOZFvrB59KQAMA6MobrOjqRZhcwP
	 MLfKbgfb6JBZrwenxCHGYzT7CRpPmc70qutuyuDxsSbuZcoPx4k58RiGPVy3BShXMh6sZ
	 3GED72C/7x1Wgl8X08mvXB9AtVyyImcqxdlfC82eNjqxDSXkcsqmsqjdHW87f3b2pLDWd
	 yfsHV14uH+r0rE8FXB+tovBxCFXLI38HaQblOe8vBVDad1NtKMd4BkQeH842eDP8Fc9CQ
	 R9RDWk+QwqNP9BpOQ8VqEzYeqctsm/9mo1bbWedyn8bBFHIprU6xaTNEWByKA1zsnpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+pshuCa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116911;
	bh=9kINL7arTs4IbNo4rV2p4l31rIh8GCS2d9evYNZ0LUI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jviDQel4H31DxPrKktSg5rowbAX7yzAsHgaaTH6K+ee2jzaLwvsyDaN9HmPzr/eKE
	 X0RCQB4AmEVPLwlOJ2MM+wcRWwfovmyQ6wakWcxgoBUaFXskYfDTq7kbnQBKF4h48m
	 iSEq3zXBhDEOkGkNODDk/gA6Pn2tCebxXnq0LkxFz+FCqJZMxEAc8wS/zaOYoNDsaM
	 Ps7vxUA7FUbI11/qNNgmN/SQYhPsJv3ZbzU8/el+7YX2SC70BnpKZWHZOGlaMC3Y0W
	 rjwtSuSN5+j2951v8HNUJG+O6tJz08LbczRypUn3yjoymf7l4Mmgp9OW+eJc3hKcif
	 19YkqMrjcoOKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7E4380EF1;
	Tue, 27 Oct 2026 16:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 626DC279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E68180FA6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qWnjetKyu70 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 15:13:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DD668114E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793113954;
 b=nktcZ4dzNDtomL2OAfJWDJJ7LWmO9BiS0cUC77bHa0iUjmRZtjle73RDNR9dMDDNg3v/
 OWLmepHxvGEVij/eUpVKQHdHCfSv4mWVjWzXu0bKW8W0dcdjj5+JdPNGJrQfp9s0oca3Y
 MeEHU5OZOZFj+l5dOKPu4jlU/b2xXVLh4vN1TeUWPl3i4ZYhhVs8peaDUyLK/nlNg/f2V
 Ck+KG+8R2YIEwU2kloYsGxsYtX/PAs4NhUAkXhjzCYd1/PdLH+LcxJzUgmjhInqpT/Po6
 +NLKMnofPa5AFcd5Q9rkVzxTXwNrU/cwte3k70qest7UEOJfruaAfHLKfFfQtafiffw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793113954;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9kINL7arTs4IbNo4rV2p4l31rIh8GCS2d9evYNZ0LUI=;
 b=VPcAjQYG14BSik1xtAv2KVcJCeQ5HDl27pN5L7RHeD7A74e7CExKPUng8b/61lI3hKCz
 ckJhYbtFUeOgBKrqDLeEs2Sf9Pi5m3VBkdI1JIjzlmNM7VxGN0wOCo00viKOBNKN/5jxd
 xsZjqynpxSeXq0zVkKojntvVpmV6WujPOhxrS0SFeYuKQ469xSvcUaJgch+9JnNv6ulCM
 3XZqdL5wA7NWiiUx4FajQGBASGpwjb6KjUUIDjx+x3x6fDYHQ3c37/Uxd7Zcg/dROiAJ9
 sNilrdZcBJk2QlRxUvQQh2eA3BXESZsCYz5Q3Mf9y6YoenJD8ECTxMgiCiapcy1sDYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=c+pshuCa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=c+pshuCa
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DD668114E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:12:33 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5be3ed646a5so40485e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793113951; x=1793718751;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9kINL7arTs4IbNo4rV2p4l31rIh8GCS2d9evYNZ0LUI=;
 b=c+pshuCa4Im6MPhAP+7bREbugkEqBTcojELbzB/acBVSY+mhQ/s5iNSSbFz2UKLV8M
 HzP8tH/0nzjotXsFOAUykyBoT8+yeCJKNETIKK3DabmjzMAK36+DwbA2fizJkptwdxXb
 wt70MUhvo/JqII7FJshN3WwLmZCQr3wXIgMqo0YSyguTcuYeyL93GeWn6zjiiAwxcSpf
 iSKZPwrn8cdOvs9+zHaOm2rwSUgJwgjEfkG8wh/j9hgTR0gmlJUDs7Y1jfwiKFUBQnaP
 wco7AWyQm14K5wA2blZ3u2lIsAyvmzYiyVXop/wKr5zuRLH1owV0rsFUYKdiJRYjlmeM
 Va1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113951; x=1793718751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9kINL7arTs4IbNo4rV2p4l31rIh8GCS2d9evYNZ0LUI=;
 b=dC0lFLEJF+N9Lvo3Rbp4VAX8/DLU7G+R+PL0KWVka7vkmuwOrxPUdFu0RuyZtPnV/2
 HJRlEd6D0SIaSspfiIdA3KALym/6FXglgs4Sy7f37n2RjO+q0SHGW7yX5Q/4WIhMxV/W
 QUuj+WkH8m4ZReJbobuOio0FASKz3zpZSulZrJxFT46iA03aI5OZNDMt1n4b74V6RJWU
 0cd/UUXabGeKOb8WPfyVQPFsbsWvzCi3dqQjXjakECN+rLJ6peVnf6Yk7BwQ6ZRYFiJD
 rhbT5N4Ya24e6BV+kBxdFUlNDy52wMi0kNwbt5W3l2TPstB2dvJb+ygx2TrRsoyFcfbS
 847Q==
X-Gm-Message-State: AFq9FYLCL8B39iWtqKP4GA/FwHRRjbQpE/ABKYDLnSVdhQnHRd/9ot8y
 HAGJxOaeXrBf4rNYAFJlDStmGLd9+E7k+piYMli7zJsziTuYb0xeSgi+8WrErA==
X-Gm-Gg: AYBFou09W1YpQFmtIk8voxF8nYqwUyi++IErVMXgN9lzieZHUMrdbJ2Z/JeSw94yGC6
 JOF1302DW2ywF3qa/+O0SPc9uwxfz/tt+6nsjk8TgSf9DbGCPz+V7p91Mf5p9TZTOfYQ96hnpoQ
 RMJhP4QxXgbDXT7cH7Eb0kI/eL8hdff9WUHaJ0dkMOi/kR+38GGS/7B84h4bwnVduOT9aFEhIUo
 h+uamddwqamIPPbmAiBec3YONC4jhirN1k1zF9tnKVm49HNNg5cFAwpLHj/TKoPUjs2vUaIKPNp
 MG+p70p291LzXxk+Gr8exEYRPxqBN3D93Ywqfn+NHOroWnFB4yWSBHUW7OQtmjp2xVDiG19oPbD
 cM6T4TLyt5oBsF/UokmaWxWoEHIUu0YDldpJDR+9KSBJVS7HFYpQ2hqYWs/G+Qu42WJKU8XIAOk
 YOjQvCB7uYvFAFouyVBoj2ezgWfyFrgFDLsx3ICXrBkMD4igwOVXuJVF7yx/YIMVoTQbGVYpJSJ
 K8QXPMb6xw5uX5JF6hTBQaxYd3Z7JeSY42mkZxbT0Xr6eh6j8sWT+rPwlDBjNoRoPdq8fIYRln+
 TPan1T+KRvVACy38/rr0rj6nGFXd
X-Received: by 2002:a05:6512:3e26:b0:5bf:a12f:e117 with SMTP id
 2adb3069b0e04-5bfb71dae8dmr3881046e87.27.1793113950954; 
 Tue, 27 Oct 2026 08:12:30 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfca563654sm58865e87.15.2026.10.27.08.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:12:30 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com
Subject: [PATCH] cmd: binop: validate inputs and fix heap overflow
Date: Tue, 27 Oct 2026 17:12:29 +0200
Message-ID: <20261027151229.642110-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 16:01:48 +0000
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

Fix the count check. Reject hex strings that are malformed or too long.
Check every allocation and return a failure code when something goes
wrong.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
 cmd/binop.c | 87 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 30 deletions(-)

diff --git a/cmd/binop.c b/cmd/binop.c
index 10d91b5dbf2e..ba109fc6b4f3 100644
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
+int write_to_env_var(char *varname, u8 *result, ulong len)
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
@@ -28,40 +31,70 @@ void write_to_env_var(char *varname, u8 *result, ulong len)
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
+int read_from_env_var(char *varname, u8 *result, ulong len)
 {
 	char *str_value;
+	size_t slen;
 
 	str_value = env_get(varname);
-	if (str_value)
-		hex2bin(result, str_value, strlen(str_value) / 2);
-	else
-		hex2bin(result, varname, strlen(varname) / 2);
+	if (!str_value)
+		str_value = varname;
+
+	/* Shorter hex strings leave the (zeroed) tail of result untouched */
+	slen = strlen(str_value);
+	if ((slen & 1) || slen / 2 > len || hex2bin(result, str_value, slen / 2)) {
+		printf("Error: '%s' is not an env var or hex string of up to %lu bytes\n",
+		       varname, len);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
-void read_from_mem(ulong addr, u8 *result, ulong len)
+int read_from_mem(char *varname, u8 *result, ulong len)
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
+int write_to_mem(char *varname, u8 *result, ulong len)
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
@@ -70,7 +103,7 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
 	ulong len;
 	u8 *result, *src1, *src2;
 	char *oparg, *lenarg, *src1arg, *src2arg, *destarg;
-	int i, op;
+	int i, op, ret = CMD_RET_FAILURE;
 
 	if (argc < 5)
 		return CMD_RET_USAGE;
@@ -89,22 +122,15 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -129,21 +155,22 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
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

