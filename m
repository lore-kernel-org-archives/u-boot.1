Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96B606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VOWJ58eF;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=cHXiIvtl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3229381266;
	Thu, 22 Oct 2026 23:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChFEyO4MXeb9; Thu, 22 Oct 2026 23:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8C2181248
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713374;
	b=atFCT/+/L1a4reMts8NLSeA19+KMBC5oQMG3yQ/6E8PK42340/ZovsSGze3ehQt5I4kf
	 BMe70rzWYd4pBEh35e0NhixvhD4i4dVY9QK6vG21T8PnFiQ2xOixjzM/urdaLDeOWquUj
	 tVlSSpkZMy6C4LYFY79CL/5RNquHiaczovkCoroK4F58iu/FJMtgiOaTG5LqXSBNYxq79
	 tYRW02RXgpThX1IKGTgmdBOkg5zvE68Tmr+JRVtdSJtPU7ch0DkRn4Y0P9w+iUgKKOI0l
	 3GJ1CMi3rYUDKTS60o0F8zvDlnAGZHoUF0uEFn0mSiuqIu8GcyM1AOWhVkD2RpEdsGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792713374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HM0Cu21xs00DvkCrHMIgyBU6yWyMafD1/yzsjFEqTjE=;
	b=YtwwLb7NPjchZpLNMZ/dZ2WEaN9BTu45xtwK2xi861zteGmRMBAJC1jYDiUVna9toqGY
	 03gA3RsX47ej4xLd92IKa0jfjwUg33+99X38TV9WNzvw6Wb3FcKkZy8o+sD2+t+BXBv3J
	 xpyx6AwMV/PS9ZYMM40wAM5gAJXdGdRBDyC7QDpaVga2zi0FweZnqlAynnmD9xdROyvD3
	 xwkmViFRgVBSPX+zOUR76Ijq5Qs653GJoOupYqMaQLve0nbvLwiqpdntoIY0J0L93g6Lx
	 daJs0QnulGfthqidlogi0X1OIiQ2GgpGvp4PeovkBpZP0jK4GcEst6WR2sdesNQ9qBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792713373;
	bh=HM0Cu21xs00DvkCrHMIgyBU6yWyMafD1/yzsjFEqTjE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VOWJ58eFqQH4Mm8RrFpkE4s7+S0k2dZV79nQ0uh460jzZBRkO1oCUJ5ZZ3iOB/2L3
	 8xTTJbR2H9eZKXc4mnFlzFnWGeFkjir9CmJ/wK/1IRnAXgCAAWcX/woh1BLp4Vbe6I
	 1gftEc5a4ZqK+cm+vgmjAeAnOVYQ0tFYPrdmFvrVNxMdHejujg7vIdUhd38SVXMX41
	 W6koTSags7imtgk3SrJPFq8xPG+c5GN3L+cOG3e6KuRVxV4sYzWOrhqHXIpuLa0m11
	 +ebNFnqq8KQjeUW20+YAO/KpV6gl9vVbBeiETcr9zoro9D9BcQQV7Mxj91Np7Myu6d
	 TtRoKIph/A5gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8C2181248;
	Thu, 22 Oct 2026 23:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E81B49D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 046AA40111
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3Rn0lXU3I0W for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A164D400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792713371;
 b=i34iYia+lRt81p9FJcIYwK/qJLd41tI12V3A9IpXIpu8JBLfw/NsoNDpCoWSSbKtjFVW
 +D0NtNtRpKOzRKnayyEeym+Z8X/N1nrEMoE8jf8XwpQoLPF7K1+l/XJ00GV3rc51/S0kD
 hqIAzLtoAz5/ggLu2S3dKhQHrE2PXBP7HxSQvW72GRSeDFlNLlz6MgZbgCk7hxuvU4x0W
 pPCzbw4qXtjAxVLh44HEdpMvVHmptZBeA8Uh2cx/yYQrcqKd9s+PSmHQlBG0zLaCc+xYJ
 F5+SUjCKCLUdMLCo8U3GtDeOYmucmn1S6fXzmISLOWd6cfokFVU/66kihsvlBgrcfbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713371;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=HM0Cu21xs00DvkCrHMIgyBU6yWyMafD1/yzsjFEqTjE=;
 b=c8JlEgcHBEFyzyuEqiXsnwBs5f/CimsknOsdMWQrvBFrC52AfrsEJtjr0goG9mAs0+Po
 qh4IR1lpppscnVt3WaXu+vn1sm7VQ0H+S7N3Kpi6omQ+b5ENtdlFO7COAVpLcKZIseTPh
 ch4tiPcv8j/w+7DDtpHgcrwXpNSZlsRNbK8royPVTIyn4x0ogft3zbqpDjl7TqPnTaO4F
 qCsiMuNhcwSsBi/CucoqgaDdeowK7KCZ24gO/9yzYnlaFzJey00KYUTzSWWM33OF7MXuC
 /GfYLUAHM3avaUvon0G+qLLtI5bqZnxV76DCboSAsUqzX6RQifYyviLvb2SNnm0cKlQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=cHXiIvtl; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=cHXiIvtl
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A164D400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:56:09 +0000 (UTC)
Received: from LT03 (host-209-35-187-178.broadbandcancun.mx [209.35.187.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A49523FA38; 
 Thu, 22 Oct 2026 23:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792713366;
 bh=HM0Cu21xs00DvkCrHMIgyBU6yWyMafD1/yzsjFEqTjE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cHXiIvtlJse5tu7IuCy41bjY8ArUM6GUXs6DI5vFKz4ijn7UJHGX3vJvE5DZKGGaP
 hjxHdq8eEXfQJoycBZVJAO9/QILs3WskY5oymYR6bnofxVBvX3QzrlTQl9VzaCGd29
 gjZlWMryFMP3E12ek1cCCjXxE3ARC3rQ9FVOTKLc0cf5gH74HnCKmOCz1SNb6Yjjhr
 2QPxfXl03I8kYRYvDfBdjttNBQfthvmscM+AynB2cVidnlI8pFEGEAeVxYUwVio3nV
 XBLRALTs21se+SEus/GB9+1AGN4jt0oI5Ck3pmmzpiaeQxbvCw/phZ6W0A4acB7xcm
 CQ+8p9VUzn3C85jSgPg1JVnDKUDyqy+WR1L5JoEzk1lAgOuDKZls2uqs1NQmFW0I2u
 q6Wx2rsHdYwERZMzztSRTUxBXrmV+b/sHqxqIsydwJfjjCtYp8ict4HbnoNeKfG7q/
 OQUJCRJc6vguDMfk73Ei6JPgteV6qxYjVAI6LSw3XAiwMF/MbA5m4cmrwLRO3J1Lje
 IVNMTR1fYCyOk4a4D+82Z08ANqBnZG7iudO2s7a+QGKYasYE5t9jl9xLH6FKECyF/l
 G0lQ59L6/l8e87Y9skaw36ZLF8xbA8VGA8iA7F9x+dx082b8E6ZQv5fLZlwDmgkez1
 rfiXDEdwVQTh7rZU49LD73xI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix HII GetString()
Date: Fri, 23 Oct 2026 01:56:02 +0200
Message-ID: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Add missing parameter checks required by the UEFI spec.
* Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
  language.
* Handle querying the string size with *string_size == 0 and string = NULL.

Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	Update commit message to indicate that parameter checks are added.
	Correct a misspelled variable.
v2:
	string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
---
 lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 90dff91e5d4..47325f7d8aa 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
 {
 	struct efi_hii_packagelist *hii = package_list;
 	struct efi_string_table *stbl;
+	efi_status_t ret;
 
 	EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
 		  package_list, string_id, string, string_size,
 		  string_font_info);
 
-	if (!package_list || !efi_hii_packagelist_exists(package_list))
-		return EFI_EXIT(EFI_NOT_FOUND);
+	if (!language || !string_size || (*string_size && !string)) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	if (!package_list ||
+	    !efi_hii_packagelist_exists(package_list) ||
+	    !string_id ||
+	    string_id > hii->max_string_id) {
+		ret = EFI_NOT_FOUND;
+		goto out;
+	}
 
+	ret = EFI_INVALID_LANGUAGE;
 	list_for_each_entry(stbl, &hii->string_tables, link) {
 		if (language_match((char *)language, stbl->language)) {
 			efi_string_t str;
 			size_t len;
 
 			if (stbl->nstrings < string_id)
-				return EFI_EXIT(EFI_NOT_FOUND);
+				goto out;
 
 			str = stbl->strings[string_id - 1].string;
 			if (str) {
 				len = u16_strsize(str);
 				if (*string_size < len) {
 					*string_size = len;
-
-					return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
+					ret = EFI_BUFFER_TOO_SMALL;
+					goto out;
 				}
-				memcpy(string, str, len);
 				*string_size = len;
+				if (string)
+					memcpy(string, str, len);
+				ret = EFI_SUCCESS;
+				goto out;
 			} else {
-				return EFI_EXIT(EFI_NOT_FOUND);
+				goto out;
 			}
-
-			return EFI_EXIT(EFI_SUCCESS);
 		}
 	}
 
-	return EFI_EXIT(EFI_NOT_FOUND);
+out:
+	return EFI_EXIT(ret);
 }
 
 static efi_status_t EFIAPI
-- 
2.53.0

