Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA362CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C70C5606FA;
	Mon, 12 Oct 2026 19:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1x5gJiyGg6X; Mon, 12 Oct 2026 19:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95E8A60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832264;
	b=UzOo/IuDDCi0Kmr2LaK8H2ufU0iRlBpUMwwZBJOaMBYo2i69sA9zoCsb3DIINFOAymfN
	 NcGqcVHgRmnqAObcVzHsuLheZZlHgah+eRLDYUjqgIBZRbuJHVpM5xA4Vhy2tVUjogMjA
	 4bt0dIc/vDUcs+X9LKy1wd88pQmK8j+7wUU5jsiDLS9h66KU+j2vApAEvymwZ4P/+2c+f
	 Cib+DsNDPSaOUeOL3jitMTeRHcgblGRMps28cb9awZ09N7w620WkCK53sD4VYohgPj539
	 r6Ywcv6zW2gGeHUP67br5awdNcbgGsJH3vt9VVh2707hk4+sSWDcy5k12NkO1zZ1IAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rMz7JWhaUqt54GIA+R+SjUas2J0wm84IJiZuzKCM7sE=;
	b=r8MXHc615Mjnt8zHRiM/wQqgQr5cX16q7u6nYO/ocMqwl3qlY/ufqOLey81Z0m65qnTl
	 FtKdF165lbQrEGdruXQ512yJAs+gRL0qhrxwr2yoHLWG3pNLqs4Qqg5vLeQtGSXh9rzC7
	 3SbAcJL3lZFAKTAm2WvJ+goAnPQrrwZSpa9L+Sekz6VwujGgUN1lcbp2hpK5kNqT+Nwlm
	 Dh0HvrCya44eBMZEFrszSibfyINbQix8Y8IAkiGs4PhMb5yx6ejTqoPKnLZrKEigFB7QX
	 JKp31pGZ69ridAaFWR4OpUFqdn8wrlzOBfUHjjmbfOGeEqw6WM3/4x4veckOt3xU8uw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832264;
	bh=rMz7JWhaUqt54GIA+R+SjUas2J0wm84IJiZuzKCM7sE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oNX7/kFEiQ7nPDl+tkD23aNxBk8BEUOyL+9pCr15j2XQMugzcFj7XmENQTWzp/ECO
	 6rfajDQHZG2q6+Zzuq1U7BnqvdfRkgO0bdIl+KOzav5SPVW7sIddsh8KrlqzLEZkTu
	 /QbwzzaaZvB2Kr+OOWyllwYggTfH0/GOZ9iWZ/QP5DiIbMiOmDdILsf5mvZd0vms60
	 BQQ0WCqIYCvyutYY5VNtwxW+KtcN/4OeCz6JR+MPQzOoCC9FE46ee9NExCGBEOWdzD
	 0Wva8jd0WtsCag+2x/+8DIpdyGA+Bx7Tsy11LXOikSOf3TicieAwGZ1uPDCxCNpkVy
	 SjirT6aw7vwAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95E8A60600;
	Mon, 12 Oct 2026 19:11:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9579C2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BE20400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pa8xgIIq-d9E for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 043EE4005C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.121
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832261;
 b=cwqn7XXnvei4g0PNm+9Hq/ORVA7uB2NOFuTGIUUG5gYUToO5RiXML58mSbEQvF854Jqu
 CFOLdgJgNw4phNwuTZqjX3To20QIgeoYgfwJqcn+n+eijGqCEcsZ7RHQVDY1lIn9NEDlo
 D7b78V3OQDqZWMf45ZOXkuJSGeKq1DSzwwLVgIVnDIqw2vkORFTK5EZbjLqJhrilAscX2
 rDG6jG5J7me22n+BobxM9gs9UH6pS4NDMePxpA94WAiVC6bXnL2VuWunHYJfp4XEd8fuW
 GocK4QRXJg0iCM3cEbM0L634CzYqMqk6zV8io+17VVTLXWim0c26FnHkO+hVBYCvhDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832261;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=rMz7JWhaUqt54GIA+R+SjUas2J0wm84IJiZuzKCM7sE=;
 b=RuH2h/mTMLRIru17WZ1XUI7+akUD01bZYNhz24fVFOQTTkRv0RNw9oyYO2UQCukuTBW5
 4Y31KtzbSiZzOJRuQhS4lESZrdhGgn2G55iNIyqhwRzoYrjC6sxKMv5/882jRZMmlzDZo
 jOJv2w3IIqto7nw1cFNeXcH04FZEPK58q9YogdJKULIsrpOqCATGmePOZpPKg+UoYz4K7
 rjj7O7MXRm9tajZdA0DMVepLcIQ1Hbn0NOfpGMljO+KAGSMfGmp2JZs6AodpNWXzB0KIJ
 ay8S9mA0ESRMQ0oQ3sZpjlmwJkwrcmoUk4s0BLc7X1yAmwF6LNtpy5VfZP7rj9recfA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=p1g8f33Q; 
 arc=none smtp.remote-ip=185.125.188.121
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=p1g8f33Q
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 043EE4005C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:11:00 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8488E3F68A; 
 Mon, 12 Oct 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791832257;
 bh=rMz7JWhaUqt54GIA+R+SjUas2J0wm84IJiZuzKCM7sE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=p1g8f33QAV5HifTYXNsbCbPUOE2qEIKCYEPU1k6KIjYUdWaaVQlU+RChbo2Nx1ZsK
 rZRlui7EmoeDumtbhxmTGzjIUqkawyzzLp8TE4BHtG9IcVg15yTV42PrKauw72ycqE
 fBipPAkCzD7fwd6HDCzHHlsj4mzqAhCTA8YZlLJUNbcrQvaBvZxkUThrWNyrO5YAj1
 f5wJg2bEkvgfgjXcwTJjpPIysoYS+DeybEGB4rBsg6VFwV4J1sBSLfapDDgrsUZxEl
 hb8ZbapufT0JPpyGIeTFWsrClrI/on2CRCd5rS4+LuCH2zjpdSiIfRZSrJUBBGK0V+
 p02/tpTMvqaWxDYfBz++Zuhp/+D4bATSsyc3ogaUxDWtvDOoR8JJ/8FAAERTrrroIH
 EN1+8HvDTXafnbg+hQZLTW1TNM2DxK7an+QJnEkSfjs0L4/C33ldAuK2ggeqzL6ZyR
 /ubu4q3PwQj2SXUi+HkLoNquhlSoGv+OF9peD3ea4yvGzw68WKk48nOoTeOd/MDDf2
 L/OOdFZ6cxSXCOUZEi5rfWk9LiWmeaAlOjmKX1IeAoKrZ4eHeu0CRKlNEpBaVEiuKE
 DAWm1ocdGFjQBE5KvamKfHWF7MQtYo29hlCgFc0vMIn5j/kwRHtnAbx4936fHf7FIH
 /Fn/8F5Us3spHbOy0orRwiFM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: fix HII GetString()
Date: Mon, 12 Oct 2026 21:10:53 +0200
Message-ID: <20261012191053.16783-1-heinrich.schuchardt@canonical.com>
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
v2:
	string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
---
 lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 90dff91e5d4..dc02d7d2ba6 100644
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
+	    !string id ||
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

