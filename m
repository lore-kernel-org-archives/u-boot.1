Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A54C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 09:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E009040ADC;
	Tue, 22 Sep 2026 09:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSm7ruu23nG0; Tue, 22 Sep 2026 09:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1A98A40A57
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790068529;
	b=k8fjvqvTBtrSAq2JBOXaYf6GJaGtfIVKTQDRRSsoro4aGWvCtxNThhUG9pbnqUrztuJ2
	 cGX9Zi0GeOkOa58kSM3qVi3w9fV6C5weMeFgSpqu8HSMy/UJ0I0gN3cdrUdJt7xuioVL7
	 jXsOzVD6x8Q1iunymP5Utclb+j+1gezggJ5Z1mT6lI9Un9LViQrcF4kB2TwLBfiyYCaBG
	 47XMCtMUAPj71i5TysIsm+p1tPzanEor6BwtcGIPlHl8LMyu9Xx0FuzxAYt7au4o/449Q
	 y7X/q3WNEkFS8UYTudWf7JYzu/TNX9EQNu5VZXyTxTcELbJzHSQQtro/449OCK4Xc6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790068529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FQy+7qMiUe6DydGIjmc4F8m7HdU0uuisNaPeJmfBUGU=;
	b=nImcah7j7yiig6cfUh8nQ5Spt6Ohy7jrZsueO+Yg5a+b6hfYUqFlnAUeC4/6AHlQ+mkF
	 zZnKVNiekjHPPztL0NyTlNjd4Zxc9kEjlIiWrbzgwh0KPnxQdjgAYU/8dSzosnIWZJzML
	 dM6ifyQStjW4qzHoatjNp6ZTaJHG0iH+d7hjnwf0/7miHF6oJco1oGbW2ezuEqtAuXzLm
	 fWDceqoijbGDAhulfViiMIeWTJByKBzBs8dgJqEczdcGIvA3yiEPEUhIK5rqkD5OdOs4T
	 FHWJUp2I7F98+RUCQ9SmUflsnzIAg5RX+Rc22M07KOqSBb0ZBP/9DchHmsD01SlUmCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790068529;
	bh=FQy+7qMiUe6DydGIjmc4F8m7HdU0uuisNaPeJmfBUGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xXJp02sGte5VD3oBwttQlOKlFZEs+YfXf2SsF6+9DljYzGfSEFqLt9xsK7cwlwviP
	 fMc7UqFhFoJFxtApcZL0kDKlbYgYjYvh4+nW7wBm3Mq4qJ8Hqeh+qcogrCpyV+Ojsl
	 WQQIIHvD1WstH1Vm9XQNRKLVK6SmVShrd5IpK/PedCq1DOgtajxQULUvbKtnZi11Gu
	 IufVt4xdMkgQpbMlae1VJyNldNPJtKhR5AUH//lk33ejYuH0s8s4yDIf21DFgrAM+w
	 dnS0JpmyUZFhG9PhgXa6JuJw9BlsHB9bRm21Bb4UHnklXrBdpzWBlWFzdMspkYhhY1
	 t6CMEPcFd1yWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A98A40A57;
	Tue, 22 Sep 2026 09:15:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D61F12C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2330180DBC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IZu4hPZvUTP for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 09:15:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3609F80DB4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790068524;
 b=F1Sd46OM2uXNLS6PNPlxDtuwU6arsTxXTrSE/j9Nf3REuc8y7XWqVY1KIHVmajBqYu3A
 MwWAYA9uDfUjykNzBm5w8UlU39Fd0IHiKqbQ0jg+X7F10VCzoSEm75xn/+zPCB3MMk6k1
 r9su0z1an+O4liiIazy8Ie5H09nLK1PQ1nBzCznCJnVKvv5DYoIvAYhuYOPNmPjcEfffW
 VfnstD/u9kyAAEoDvl2xG9j/iFZV4Z334d8DmRMRgB0QL4AsstK2AykzjcVnZSg6PF9QB
 JRBQm2MU/4LC116IBaJbBvSdFXAx/aylK8WjwNcE5H9k6sQYzDUrNT0DRpTzpoQT5GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790068524;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=FQy+7qMiUe6DydGIjmc4F8m7HdU0uuisNaPeJmfBUGU=;
 b=gxBiwAR8/7D89Z4tZ7ebgf2JrJIA8UvBciRERp640IJQQ0pn4Hcq+/InC+eAnhkbNqcQ
 OiOtOVt/EKyk9YbkmrN/OEHyN9S42uLpGzM4UgQFPoIYQlE3FkIicoH7dphruAbmxiuAg
 VnpnmAPRR7iG+5yVVLs9WHnyKHPE+7H5qcYGsywbzZGGww3hh5AiU7Nce8DkUK9ZmdPDW
 Vzl1hKoXmPWqxwChcFzHvRGfpN+QQD4C/SUbxfQ3XhhcXZEk8hrkPhFmiK/7oyHdKWxtc
 D2WeY3VNl87uaBpH3i71hJ27+E5SjB159OU0I+A9DKKq4zx9e1HcTnQHZP7TXwZ+g/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=brXL1HeZ; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=brXL1HeZ
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3609F80DB4
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E50241595;
 Tue, 22 Sep 2026 02:15:18 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90B933F528;
 Tue, 22 Sep 2026 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790068522; bh=VOBqCBE6yU6HjqaYgCO7giQv/11PWC2L1PtYZU+WFLY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=brXL1HeZ3FSO4DeUDnsH8Jb3Gap67dchYMcGZ4+ymKs/7pmIqA+yvqsoYKw9sL7wq
 TbJCfgdiVB0hfE7+caXIaHCfUUBEdR/zuxp8Y17GAnyCvfGcVw+hKLNdLT6lShXyUg
 /Q3PcBxmlwhoAB5RsaARkGYmpmCSTdXrZEU+WFfo=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 22 Sep 2026 11:15:16 +0200
Subject: [PATCH v2 1/2] efi_loader: fix string table reallocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-ptr-v2-1-58817a31c67f@arm.com>
References: <20260922-ptr-v2-0-58817a31c67f@arm.com>
In-Reply-To: <20260922-ptr-v2-0-58817a31c67f@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3703;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=VOBqCBE6yU6HjqaYgCO7giQv/11PWC2L1PtYZU+WFLY=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqskcmOObIdUpZLcpk/apYK1JoJ/Wgb9WYs0J6P
 Z0rY87qsCGJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarJHJgAKCRDLSfhWdqMG
 lMxRCAChdOD3FC80TTyGPO9/4eThrTQZPaNIxCKUxh4Q5FXYBuHErinBZOeK5Bq8pnv/TrNZ2gJ
 PtXzMKjok4OdtA9K7FHG1DkraYOz2z5CreGAx5af1QeZP/2K4B7UiILbZLFjrlW/IN1EibXwAYT
 xsf3SYskeZJmbGevk8rka+KVjy0i3dnzYBO4hl/iOtmtSGbz8cjDbiNJJx31VEUl32+RxNO5VGO
 gcVQvLyWLPtXDIFwnq4Ao4+5Zrjnr1V9J/xepSuRBTGsq+eNZjM+N23+/VMBOMVn7/pwjF4LVxW
 fGrGAgAYhh+WD+gWOc56F48Lm6iAC6dYAJXYYmHThubSfzIE
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

-- 
2.53.0

