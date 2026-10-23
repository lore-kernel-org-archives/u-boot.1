Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2606606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rG0ezqTK;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bdh+WMZF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96F09408B3;
	Fri, 23 Oct 2026 12:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sLpWWGjAq_XI; Fri, 23 Oct 2026 12:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B64E5408CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792759816;
	b=kCI7VioiniU743Uoihk1uQqCvMnPqC0Ee2QSAtcJlBUzgJXv+uSV5e7D6r03rhy/YD43
	 Vcu/jYepHW13D8fKlacc1zqbfiNS2pPBVCSWocCFat3JmMEKtfq0ebY+Ja6B6rcrLmQ6Q
	 k5Blyd0nrgZNyYF10Y0UndW5b2zJJMXwjOcATZj2XYN7fVuADQPmJ26FwHTNpyvjCVjqh
	 zoEJFAz5LaI/a7NE1jfxdyjM8CH3mNzMFeDM29LWFQ8FCDUwJKICik+rBuPHzRUB1b9Rp
	 JQ1PySvNdCX91MCh8bzzTVom++Va2GlpEBoEV5+552Tnqouixmy8mHtYbRtRiUS0pWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792759816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MbWsl+gfbYStwRdn2BNUCrCSpWzn85RwaBOZkfAgi0k=;
	b=ahZPJb51N1FKSkZsoBdqNcgT92AH+Nc3ky1TtYvV1iAq8WvrHYpFj6Tk5OF/0B4J4Ib2
	 TFLi0LPocgRBCLuVOaDzvdHdBlaMM+6+gjBNOlcw26rWJIfawKDBxgr246IAcNbtOs+FB
	 7xKfeOYEko1hg2Kq4K6PUdyvX7GRrxKp+rLwiWOdnC2rC8nS1+DBwjwXlfqcQ63ZemzFC
	 prlg7SaIG9ChL3RxjkeEFH02FVtBtSXI68r2ket/KObkdTOIHtQv/b81yvpeAuunyREuN
	 K+IzcEPCGogICW0QqhT4IfMzHEDhug2pda8BFHKNhCxrOiAVboNKmUT1wwWV31RYP8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792759816;
	bh=MbWsl+gfbYStwRdn2BNUCrCSpWzn85RwaBOZkfAgi0k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rG0ezqTKBFiCrZ8gBu/mGb02R6fFy+knS1VWQEK3iqElrwP+6gZcb0nicLea3kHOG
	 xjk5kpgh/bXAd6dZ0uAjf3HO4YXU+OaioXGY19ka6CE8mW8qknXZEv9CMNhIGVmpik
	 xTyLd/VUEAt4DsW+VbpdMpqM8I6Vdej3PQBEnUXshLQn9Gzb4YWLoUEhvrW8YwzWtQ
	 fEB/oHsQRZkEVaNfUMaFhhQK9MShmOZojjF8ZX4hgFNmgQ7Vpvuxac8k66YhaeABv1
	 vrbyZG4Fpr0H2WfBPdc+cNuKTI4qvgB/B/A919418jBKHlixAGYDfvDfPlbNh2kwKc
	 xBuJ8I972j3Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B64E5408CD;
	Fri, 23 Oct 2026 12:50:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 63BD8235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55753606D6
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bkcik4KyYBy for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 12:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B94060639
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.121
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792759814;
 b=d4SDajkwgS5pEUqNYs1Um8csVH3Uvpuqr8JKvbwDLUqHuxS+COdDW153Bo5jHOiJsiWr
 TsMDXW7Z746ev2DWus0Gx0efobspg6kLrzstCVIR1/tDEMAEOv6UYeEmd3DxmmIFMUzTn
 B47Uej3qbSBvey0OK9x5DyE1G0WQhwis6C+qKf2rC44BEZdh8vsyAyTDGS5SO2sMpqpCn
 kUP+lskL72zNLV9DSSfZ+K0viogG1Wvtct9jGanrlWZg3Hryzmk4ErTUEas66tI3mS38c
 aCNCXwBKmgIsx7mcPzVd6j3QLs617jpCjeE5oPQOGjgZjDY7AViRlbwctp7bRN/f8XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792759814;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=MbWsl+gfbYStwRdn2BNUCrCSpWzn85RwaBOZkfAgi0k=;
 b=e7PyoLXrdafrRcUMDnF2ctpvqP7V4fo6KxwRLPgzwEvUNwP3GKhUzmhKbfkdsM5KVjVt
 +m5dyPthDNDy8dMl6G2HhoRZQUNNnrCzH9TCnuzxNvFQcn/Bpwtq/GgEQnNxTb++kXst4
 KPlgWJGuN8XsMno06OBcFlRPwVTWQZfnPgAm/0Tc3CH13aLtgIj7JVkkBx40eUqfTclGD
 XV4Dvfbc3WxeeYLzDdJ0i07Gi/93dKfmhmVwcaH0bjxIRuWtEkZE/2gNY2Ipe077MjIdO
 LJgV7CramhEFdxeMDYRcvLb8yZKl7R3RBNzHJURzD39ASkG5S4L80oQDQVzRQavVaNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=bdh+WMZF; 
 arc=none smtp.remote-ip=185.125.188.121
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=bdh+WMZF
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B94060639
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:50:12 +0000 (UTC)
Received: from LT03 (unknown [209.178.136.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 582153F0FC; 
 Fri, 23 Oct 2026 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792759810;
 bh=MbWsl+gfbYStwRdn2BNUCrCSpWzn85RwaBOZkfAgi0k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bdh+WMZFvcocUCwBDgPgZrpT3Bdmp5UYjBuTmrfXGup6oteCq8vOcRDXrOuzSoS5d
 5KMsyhqllZtVJJ2V1W/4t/PYjUbepR5q55l6n23DT/fJO2dpWxNoXe5cITnfxzHQZa
 2GKCIqxvaGhsGomWXMS/7RhosuvwtlQ0y/tPhU1GPSAqvrzzumEeRzkMGjJdjynjVg
 9oFdTb+pEl/Ymk3tqp9pUPeOWMPzxRt2uGhTA3hrZtoLC2BMLdQlQdMESAIlEUjxDU
 1MSFwjmXk8F8QljdsDUyArfz94AYlgQuaCqvqhvVxKixYIWVxaYZdarwQS5MlHzLbv
 ngsJpT9C+tMF7RM/cY65lt+gr9vBViJkBrgdLIhacEb8rbx/m3E5TAjwPT1Yf0HYZd
 oKdVUvP50/ABPSKmlC+rv1LQNgZqWjTi3kBoX/fNngv17i8pU2vrWWlhWQSXqLwoCh
 vUxLt8yUDl5A+UB+CiDcGK/f+c6uAym4kbTtM6Vbw/TcgPNKpK80K/rn4xHETZ6JGN
 Ni/t86IyYVjRliPMUGv6JCUCPz/hJ0TFZlRC6sKq5h6H+7V1neesaOdeiMgnhmDjam
 GWe1poVk1cJFfNgeJ1CNPzd3n0YV31M+lvgN0rLn2l7kxNO/YSbivSQK0L7DzFoXXk
 0TyekU00inycp72uhLssD5KA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix HII GetString()
Date: Fri, 23 Oct 2026 14:50:03 +0200
Message-ID: <20261023125003.310076-1-heinrich.schuchardt@canonical.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Add missing parameter checks required by the UEFI spec.
* Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
  language.
* Handle querying the string size with *string_size == 0 and string = NULL.

Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v4:
	Remove superfluous check if string is NULL.
v3:
	Update commit message to indicate that parameter checks are added.
	Correct a misspelled variable.
v2:
	string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
---
 lib/efi_loader/efi_hii.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 90dff91e5d4..fce26d50d8e 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -910,41 +910,54 @@ get_string(const struct efi_hii_string_protocol *this,
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
 
+	if (!package_list ||
+	    !efi_hii_packagelist_exists(package_list) ||
+	    !string_id ||
+	    string_id > hii->max_string_id) {
+		ret = EFI_NOT_FOUND;
+		goto out;
+	}
+
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
+				memcpy(string, str, len);
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

