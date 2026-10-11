Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EB2CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 07:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1969810AE;
	Sun, 11 Oct 2026 07:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5hbId29A_fq; Sun, 11 Oct 2026 07:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F071A810AA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791704111;
	b=a2jVTs2QW03jIwiM4IL/zjk+HiyOaDoaFfU5ir0MBWZOG0bm0/DjJsj7aj7RFkNRtXAf
	 BPCo0CxEfyuXpQwcBN4yMPO5vReMvvAsRgG3tU6clB50Uho9GItffSD/mPlIeoWxq2F2Z
	 S8ZGUx09BYXmb981+yiSpHFNJ32jpELQ3W5VLi2CUTp7EF6Z9O3YcK7bsSY7FTAOZ22SI
	 FNSTwnNvCHGo8Npwu9cJHIlPSnqGUOToBB+OjBO+qPx5RiEzkGG4WW9ALdASBnBWQH7jq
	 vXF42hpp0Opa6WUSJHkkXrrNcBCU7XnFqa7OnI2woZNHPM5zSaGbhPTy0e9XXd1uUlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791704111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vS0vXH3hcPZqc+e70GtweHUob0qecKM/i502u2TVoGs=;
	b=QLPSLheF0ZjoxiMmAp4Uy6MalQjshQCevTIgrYfuYzWf6YkOQChQucAHWr4D6MzWJhwV
	 taCNAxHD9dctyGQwoADiEPMdz1T43p1jlvA1Pbw4PMRxASOQQlv+cTLSve5lOJ4vs0eID
	 y8Ii25UcuvViWixOOq2CwKmuyX1/7mDlkTEr/fu6DgMKZ4jfEQFPutIS3k/bvCEGctZHh
	 CSlN4Wgel3AyFrEWZfL4p8WiA3p12FBGE5hFDW2GDzPC6osPQDD16+BzIC2iMWO15xWxB
	 KpaJbsKvEeAYmMdzrX/lUqBVmX6KmPAAj9LKhS6cnYe9p9e90z9yU0LOzm4Kg0nkdEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791704111;
	bh=vS0vXH3hcPZqc+e70GtweHUob0qecKM/i502u2TVoGs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EZSA+yk5WPK4rJHeg+e++MKTzPPSDLLTh0ESOpPsTAgw+X8IBAjDYnZSVamig1UXN
	 1s6opCRSRNs5O1xoLOEdbGIaOMnZL/S8uu/bM7arqh4tEBvrkXFaFrug+aNpQIavmq
	 rlBmvlHHIEXcHy/PJJDTAfPu0R9IlkRB3tatgasudqCiEWTgyLPJsUDjwniG6EdAB7
	 e18xt2ZFZfCwvKwdRh1JpKsfBN64biqC0fz3OXS8TmG+S14lq6EmBLWyfyffD14761
	 H3l24oEBWq0sYXvq8VCbuZG2w0G9gUxgJkxB1NbQZ8QtlpE4efZ/SvPo4oMvkLssKD
	 /1SRR8hMfscQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F071A810AA;
	Sun, 11 Oct 2026 07:35:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B270C9DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9822360644
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0YYf-pVAQ0Wc for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 07:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CED160634
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791704108;
 b=cRgQurM0ClGRnczHxwfIdhkQctB3HN9XqgWcYVCZM8Gz8G1tflYnYSEgLoFN11uSrPyS
 y6ZKOqAf76VgDO1dDgjTiyxaWK6MPwdPTWQhfkgIIYzL3LJ1M1hhjK3d1OaSL69uJUl23
 XvdrLFb9eFLfK4giG9DG1Eq0OgdZMXd4j2MZvoJ+w+WrKMjOZbcEzpnJmqh3tNv7hSSzR
 2dcsCkOkLDRTDpNmElWxcfQ7rFJPGsCYErHQJ4KYcKTSAW3LjX/N9B0QKARPcVRA4eg/I
 /oePIb3F58g2+h8mdap/U4tZlLuf/ChjoovxGhcJiNdMh665HqcS0MnCQ92jgcveA2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791704108;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=vS0vXH3hcPZqc+e70GtweHUob0qecKM/i502u2TVoGs=;
 b=mPDhlWRLMBSMu9BrWhYT4YETKZBFdNr1bsZenT9tN+NUjgCSGVxm1ft2fyZA0tHRU18f
 M8A0HK+SgTxYZ1usfxiNotfShYl3AwX2pwSuXO3XMNC615fqxili7SVdvpUKdTbMIzxss
 cBLLhnTiBgS4INNuZonxKE8B1Ruu1VlPqDenOWyRaQIKTe+z+ao+/rw934rXpCVfFg3ch
 EDyrGtQvbRwh2UCyDclnNJBfhrGevaodAaZTKQJDoPL2y7wgq1x7ipB3iyc/1dV5A+kBG
 4oH/R3IOpwyJP6/42kIRthqF7jI1lpMuEHP3NL2q7A5IjzlOnDeVRdZK7Fefes66H1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=YqLEU3ie; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=YqLEU3ie
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CED160634
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:35:06 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 131BF3FA39; 
 Sun, 11 Oct 2026 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791704103;
 bh=vS0vXH3hcPZqc+e70GtweHUob0qecKM/i502u2TVoGs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YqLEU3ieNow/z2Gm8rKiwcAmd/+y+bCxGaZfSQ8XmEx14MdFe+7Q4Hq/LAPzKiCuZ
 lxAnkY6Lv68rj5vNl+8E8aZhlaacazEaj78CiF43GKkYWXQRgQrxCn5SWhGh0qScXV
 +hhX9yz2EqxeJZOwyKku5mwRTs4tY/JrR5eC6p9rlaTU35Hpy3zWlv5FW3rq3ou3wZ
 WVJHwhQ90JTLiRyjfbvCl/MmDPrEyZcgvR8jAh1JEKa8FkXazNMhrPTLkF3JlAvipR
 YllZ90Yan+ERNIIf5tcKamahL9fyFB+HMIAmVtfkK1b/bwsNqnTtPOQ1c0EfFmxUHl
 XzTAbBvx72VBh7TrTNXIJyJSbKsmtuwrm02SUODB1xXq3XubEtxqOYnO5y3WhzJFOL
 YJUGoQgu3NBaV+T4ATnL6fWwfKsVjZEjJl0CfEcNG5GurxTg3B0XhpTM0uv4meQycc
 2dvj0xTYkdipfQ7+/J8vAa3pX51vEJP4mzj/VOQfcYTBGnWtu7iWzOEbsDNtvm1/1e
 fnhhJcDKbntwvVeqe7C8VV6rFuvR/87XiFu+sWlQFlPhVhsjjBb2oVADZ+jzaqv9fi
 pIcXpomCjy/PSmur86CSbiG779m+iZlJi8LRvVNe15DDP3jbniBTZgMbaq9ECYQLRA
 b+crV4kE9P2gUyzSWL6ULqUU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix HII GetString()
Date: Sun, 11 Oct 2026 09:34:45 +0200
Message-ID: <20261011073445.48921-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

* Add missing conformance tests.
* Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
  language.
* Handle querying the string size with *string_size == 0 and string = NULL.

Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_hii.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 90dff91e5d4..6fe25d4cc7a 100644
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
+
+	if (!package_list ||
+	    !efi_hii_packagelist_exists(package_list) ||
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

