Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9697BC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD6860856;
	Thu, 17 Sep 2026 09:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdrPT9ZH5_0j; Thu, 17 Sep 2026 09:45:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B180D60840
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789638356;
	b=j+lTnHWnjhyPB1QZTRDJ+TkAQFcWebtSnotYHr9lWzOi06lg/alBYhcadhmMJFcsDHx5
	 Fhnr4HAPxZ266nX1NyOL/eMm55cI/BSsJyYsDkA+gj4aHzj55pbKkUU65BYdbwKme9bTO
	 Kz8ae4MnflAPPnSDpru5GCInAOr6/c+z/+4o8XfbM7UivFbwP1eKb+/Bqyr5Xr3kbYk0H
	 UMLV7vFheoxAo6LIJqnnJQ5p8uAi2R0wlH/aHWUN6CJtwaVn9d0W39HBg9aEf13TIACIX
	 QFenhZGdcXJJhJwjm+bFG7DCd4CaNsY8Wmkjgt4M0GchKscGL1uKkjK35FN77MDv8vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789638356;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XUv22fZJEO3Bg5Evvu2h8B/LIgEjotTFjKMRRsdrWuI=;
	b=TNwZz0cNem3OydrX7CzWdsYC/q/jMjZ7otGIcnydwl8d/Iw4Nf+2eP3O27SfTuSn249/
	 N/Mzp1tHMEQizLi2CKSBoHk22EdzA17J/BMMvGw+QtbwE4Kuin/a5gymoXv4NX32+mjWm
	 1wV2Rs9AlhC2urHoQFCOFHCZmFe3/ziGcilvh/YxnnnXwEOn1S4U+5BL0EY+Ol4h9719N
	 gUeJNBOgYUddGQ4kQKGX8gaC37u0TNwmzuFsZC19eFx9EWVVaLB9IHU1P9eWv7o8LHh6m
	 vBbYV3Da8yWF0+RPSkyUbRK23nmSaUVu7v2Xk0NNh7W/ipZqkakNdueG3BNhksNkQsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789638356;
	bh=XUv22fZJEO3Bg5Evvu2h8B/LIgEjotTFjKMRRsdrWuI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DZ2BhdCCu6aYzg2iv4KxFj2wpMt76jobT5pGG2AKbvbmYytPBPpFW1QIVQSZUYMPM
	 rCYcHdYU0nkXQaiARXNsq9nr05UXZJqGJm7U0D11sXYpnLErmINYcRmLMQa+A5iWXj
	 ZMmnx5xKFQ/xTQ58U/y87gmKWaOepki992asLs4oy1LHrg0bUvAH2AZooPm/dZlLR/
	 luB4CV9TA8fdYCOlH115RDVvyNshelPGOfXqrCqLhqEvQrdcvRaqZjVrf+gR8sMufC
	 YsvqtdnP+4oHvCS719+Wl4DRL5kKDdAwPUVpVjZjW6/snqi4sRLft3OaZj3VoEWyJh
	 FLrM+vme4ijVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B180D60840;
	Thu, 17 Sep 2026 09:45:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68FBB13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B0A380EF1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_EXP8yRgdJR for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1832080E97
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789638354;
 b=OPFkb8/kY0EnLFkUYPNvxeJYOVwvc9IZx/SPxZkjV6qOo5V9Ay3Vn9Z8veS9HxqAeUje
 9fyYK+iuXph2DLhvJBtGIHPhHZHjbP5SURKAnbD6Bh7tFIcZhu3X9hW/G6rG6tkUi+3YQ
 zoA/YyTZ4McgTvVTujmP4MkT5+qc2+uABBjiyAlP9oIyHhEg/H58HXX5uVT9tsBydhEfb
 2z+8TYl2f1i8K0bzlkdAjen2EAgRpAv6tYGT9ep+4demY/0A0P1tkXSCyHsZ6LWPqB+9y
 GAGZFM0eqrmITZmXsh6qWWIeycmrLyn5kUAQNHKSI9TQE8wI86bnUv9gD4MC1abY3WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789638354;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=XUv22fZJEO3Bg5Evvu2h8B/LIgEjotTFjKMRRsdrWuI=;
 b=LINQXplodr67YhsZyxw5b+LYAmAKYiM1kwbRhvS5EkovR4++Nj/+S6nlfGy7CzryruCD
 G3tsbkqfiKI34t1Kmdh3ZBF6p2wykNTM5yLNgdkGoBm2bJtH6tOLdcW4KW/wkEPiEHJjI
 HN2O4/C+Q61umiqDaI2u6iN/UJL6HBc09pWgpkZe7y2i8kc1q+a4boUt3aVvKxPXvcGdn
 bfLvFBtNlEQEXLPiqKvvK7PLC2AwfiYvDb3g7sq2pAth/Rh7/iEgoJzFZl4LZDXWVfUZF
 ZA3zhyZ9ITxdG1WOBhfhet3jc2rm+oUQ6b29rdxe+0MXdwxvJJJDNVMQxLZmcOrC/9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=sFNhuvtX; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=sFNhuvtX
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1832080E97
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:45:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 123D61476;
 Thu, 17 Sep 2026 02:45:49 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3440D3F7B4;
 Thu, 17 Sep 2026 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789638352; bh=THPhjRzwXuJbAVHVhE6L25IFDodfKsLWuWJ+FFOXGq4=;
 h=From:Date:Subject:To:Cc:From;
 b=sFNhuvtXbBgH2+eWTFPvk5tMBsG//B8ZQAIcppF128rYewJO4lVR+ghxefqsqrksg
 WV7yNYaO+wrJSg6Ua5XCAVHpEaxpw1XtLw/bQ+woj5ghKST4HirrX+awwgRR2UQlVJ
 by3qyiaJmJctbXlSkE5F4nor0m2bCtIB2ZluSl3I=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Thu, 17 Sep 2026 11:45:31 +0200
Subject: [PATCH] efi_loader: fix string table reallocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Mz3YKSIl0zc4OkVHOTlOSkFGMloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0Ad4D8H2cAAAA=
X-Change-ID: 20260916-ptr-670be74dcbd3
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4183;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=THPhjRzwXuJbAVHVhE6L25IFDodfKsLWuWJ+FFOXGq4=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqq7bOLIadiG8K41Zt+XLozaPjY3w2/Qc5VXm2y
 pje5HQjzxKJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaqu2zgAKCRDLSfhWdqMG
 lORHB/4p3aS9UvpQ/E6D8Isr0p5MHX3tKQeaD4qLRYVuH1RnszUN6NBaeVSPKTKRyLCby0nkx97
 4AVz5iB0jkvalRM/PCotGDKkhZIBrbKmSPQzuuagnQOBJMXNSctStzwpY/woiqqi78Og63Yo5pE
 vJL7IN7FbWkjXEHKQY8z2weV2n0jyFHBeP/JzjRqajsNkXKTWgmkgu5tVW+Sce0lYUfrG4gwNh6
 suC+YIehirlnWStLNKId+fgYkC66n4sgtWG+u5Wc86zjOPgD1CWR1Xi14+/ct2gAH8zkVHJsyEG
 WSVoY1dyOnJxgtsqstrXWTNmudHSOUeEWgZS+AjSKkFdGc3T
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The new_string() and set_string() HII string protocol functions keep
using old pointers after calling realloc(), which may have moved.

The set_string() function also assumes that reallocation only grew the
array by one element when computing the start of the memory to clear,
and forgets to update nstrings to the new table size after reallocation.

Repair and factorize the reallocation code in a new grow_string_table()
function to fix those issues.

Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
This can be tested on the sandbox with the following command:

  ./u-boot -T -c 'setenv efi_selftest HII database protocols; bootefi selftest'

While the unit test does cause reallocation with new_string(), it does not
with set_string().

Further testing can be done by forcing stbl->strings = NULL, just after
calling realloc(stbl->strings, ...).
---
 lib/efi_loader/efi_hii.c | 64 +++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 7bf51ad43d1..90dff91e5d4 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -822,6 +822,37 @@ static bool language_match(char *language, char *languages)
 	return false;
 }
 
+/**
+ * grow_string_table() - Grow a string table if necessary.
+ * @stbl: String table to grow.
+ * @n:    Minimum table size desired.
+ *
+ * Make sure a string table can contain at least n elements.
+ * If the table is too small, reallocate the memory and clear the new elements.
+ *
+ * Return: false in case of reallocation error, true otherwise.
+ * In case of error, the original string table is left untouched.
+ * In case of success, stbl->strings and stbl->nstrings may have been updated.
+ */
+static bool grow_string_table(struct efi_string_table *stbl, u32 n)
+{
+	void *buf;
+	u32 old_n = stbl->nstrings;
+
+	if (old_n >= n)
+		return true;
+
+	buf = realloc(stbl->strings, sizeof(stbl->strings[0]) * n);
+	if (!buf)
+		return false;
+
+	stbl->strings = buf;
+	stbl->nstrings = n;
+	memset(&stbl->strings[old_n], 0, sizeof(stbl->strings[0]) * (n - old_n));
+
+	return true;
+}
+
 static efi_status_t EFIAPI
 new_string(const struct efi_hii_string_protocol *this,
 	   efi_hii_handle_t package_list,
@@ -847,23 +878,12 @@ new_string(const struct efi_hii_string_protocol *this,
 	list_for_each_entry(stbl, &hii->string_tables, link) {
 		if (language_match((char *)language, stbl->language)) {
 			efi_string_id_t new_id;
-			void *buf;
 			efi_string_t str;
 
 			new_id = ++hii->max_string_id;
-			if (stbl->nstrings < new_id) {
-				buf = realloc(stbl->strings,
-					      sizeof(stbl->strings[0])
-						* new_id);
-				if (!buf)
-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
-
-				memset(&stbl->strings[stbl->nstrings], 0,
-				       (new_id - stbl->nstrings)
-					 * sizeof(stbl->strings[0]));
-				stbl->strings = buf;
-				stbl->nstrings = new_id;
-			}
+
+			if (!grow_string_table(stbl, new_id))
+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
 
 			str = u16_strdup(string);
 			if (!str)
@@ -957,20 +977,8 @@ set_string(const struct efi_hii_string_protocol *this,
 			if (hii->max_string_id < string_id)
 				return EFI_EXIT(EFI_NOT_FOUND);
 
-			if (stbl->nstrings < string_id) {
-				void *buf;
-
-				buf = realloc(stbl->strings,
-					      string_id
-						* sizeof(stbl->strings[0]));
-				if (!buf)
-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
-
-				memset(&stbl->strings[string_id - 1], 0,
-				       (string_id - stbl->nstrings)
-					 * sizeof(stbl->strings[0]));
-				stbl->strings = buf;
-			}
+			if (!grow_string_table(stbl, string_id))
+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
 
 			str = u16_strdup(string);
 			if (!str)

---
base-commit: 2c7eaee7b3422ce7c84e892abfe16e1afce42e83
change-id: 20260916-ptr-670be74dcbd3

Best regards,
--  
Vincent.

