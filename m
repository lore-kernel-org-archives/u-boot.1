Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44371CA9ED8
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1373D6061D;
	Mon, 12 Oct 2026 05:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJY0k2wlzvki; Mon, 12 Oct 2026 05:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0C3B60702
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783420;
	b=jSByjmjRdTWrHIaYsP22DP0hmM9iDsJxu6/QmfIGqhPPIy4vTmZs2GiBjSacPaXHDxjl
	 9vGXERho2mwB9DGNH1WFm8GfijLdtFo7b4h4h7ADE0GjNejJl6PDPHsDfYkTYJ2toYmGi
	 PeFj2sdXMJjUrEpcyeOul+UNyR7uoFYCPh7Et2VEspDD8jnCRY2T/1IVW+5CLit1s+rXw
	 oVzrjvDP2sqHdqnxhkBaOhCd06enR7ePfwVJP654YX20BvxCR2hDNZ2xl8dnabpk/sqhE
	 cL8pmAJFeDJH3dnQjB1/7D7dvGXxtLF01rD8kV8bnwJLsZ9OHpHHT+znWsZH8PYlScQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b/D/4tT3weB0SOdYETZNTpuwhEKrilbxJj7HnSK7O6Y=;
	b=IiQEZcliNz/BJa+RbB8Ypwlhe1rvFq2DidX7lrVP68uDana4nWIHOME86fLakSqA2vxU
	 IsehEpI2nf9YZ4Ar/X19fCo9WE6qiYgmwCgohnKCQUvvUxh6By/UVT5APGY7A3NPsWqGu
	 E60ralq2GfQSsztMh9z9Ua27Q7Wqva7ze/DP4KQf/RuK7aox1pKPpeEMyzZ6GLgKtKvIn
	 u21yBeHSOgelONakT92w0scKOeVJDi52elhIaQiTTZenj3I7a/SgSmjP+C0CjmSNO5i/G
	 bpFfWE/XdR6ciIX1IXKFExD4stqbBkJVlfspqUxjljQDUYEzJ0Eb55s1fzp7YrCIgxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783420;
	bh=b/D/4tT3weB0SOdYETZNTpuwhEKrilbxJj7HnSK7O6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CZSmauymqRiMpEDJa71nnuwgmBv50XYmKx9cAY1jFY8/ln7QKwe4418QJZl1CzteH
	 NrdoLZtIE71HQoqF5CvIbm/hKhZ1/HoHFzFWMgKAXVPvYiOdl/9Am9thJzfw5RIs4I
	 c49Sq406ewdcwm40StGX+Cgk9ax+C15vgmsHuxjuV/FJiECpoXTApK3JClAPMEFLde
	 10ajaLJ10GLfbutMuEXevAkMtw2zeQj1JkW23UuLaWOlR+aHAg2zGlJ5oXaRprhe+s
	 kG1FyvAIKb7r9EAqEYaqFTTEFhaNcH6q9S2BVdo705rUzH7mN3OS8mF5aiKRsuDvP7
	 ZFv0Mi62KoIiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0C3B60702;
	Mon, 12 Oct 2026 05:36:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8733175
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64F59400FC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFx1wHt9U6K1 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 01:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8841C400E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770243;
 b=IeYej5Q3f0PqolgcODqiEY3HHP9pLaI7z71mlIFbVnUIZMToDMEg4+qIrWxhB+lXwLRO
 Wuai31Vwk+ebL/1rdUmSk/37UNrIkulNTmSNKjzKvLmKdY6tuN3Udw8GKGnNaiH2PeV/m
 Xttc2YytKouKiGDC4znZUW0+D024+0Y2rP7VVk73CB+qGbhoFbimLfLHwlHYXNhsly4PX
 iRcW1lVNUauwYugIGH4+p0Us2vYLT+a8oTiOi0bgrp9HL6q/NiikLrt0EYCA+6fcrm1v2
 k3gkDB409F4FlUcd51QjezB2jr+tYXgGNSX7I1U88AKMs7js2nnsTS+bbMk0TynaSpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770243;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=b/D/4tT3weB0SOdYETZNTpuwhEKrilbxJj7HnSK7O6Y=;
 b=VGkyxwdkDNviI3nb7hLo0V1ZH7hF9XYBcTN69U4tGNAFwGjNVgmaTQnkpFCWsQl+BQct
 oFow6re93ETbrlUEu61+O0lswkG8eytwds3/1xfeulP+ELyISjmVIx+frbJ4gJmlcZcX4
 NjzSJqJQiZXP7d+YqbYXLv5w3Fr1JPHdsvvobb8SzlXLctGHUzUmJVnwWY73jvzB+Dpi0
 y/Adrh7/Z1Wfv+gpMKKFEPqpfjc4mnxlJPI+VxqNwkKtQHjtmZd6Y1Ymgmz4JRuShsXYj
 AlnlX4xDixrPBH+TJy3sr/gUp7gx3Brev+9/6GaJkmk/sCScsC894ZuhVyTMcmo6h6Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Mhzlj8oH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a33; helo=mail-vk1-xa33.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Mhzlj8oH
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8841C400E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:23 +0000 (UTC)
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5e3e525cf4bso1241068e0c.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791770242; x=1792375042;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/D/4tT3weB0SOdYETZNTpuwhEKrilbxJj7HnSK7O6Y=;
 b=Mhzlj8oHSZMgItneAFtLneFebnkyUS8yVyzBXc1qaIVX2uSyPCOr+35g8EsPEaAKdy
 UwVVkDDk6aUPhJUcrKlyMlrRGN5vFGwQi+0aF38f5nVJuo2wxQ9iD4+dRN0Y9UVKDBda
 dMxWyEVO7N3mZxbufFT/ArHDqzQ1ZJ328isIQHFH+h7gCXlUkA0APhAS7H3/kpSl4ApT
 2/xK/njkiyHI6+NOxOPvUOdao5UVTGagBCZw1U81Z4AUjgg6sQNNwYGS4c+97pFFTcmK
 MigesfYkqj/+aJeyeQ/HyPOtn4wWLoqB4As2lWioPKM6yTHVROGTefX5z+mVeTzU12c+
 yVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770242; x=1792375042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/D/4tT3weB0SOdYETZNTpuwhEKrilbxJj7HnSK7O6Y=;
 b=zbyJlB7yLdou7pzZb4WC9W2O8K69xdUTK0S7usPlf5VN0m0JWmCZ1H3N1rB078vIox
 pIs7kTxQqqVKQ0fNU5Ji4WMbO1AzMTbfh2TPeFJlbWyqd2hy8anC4hXcGBJBlU/Onjpn
 VEXaPThPb4FdvXy4I6eKUD1fAQxEjOeFdLSVOgrDzaLpRl4ul3cQzgOr1v7eDhiz1M4v
 cnuSJKVj9HFOgau8zLK3gX2W5r+7CgVzhd7pSQEvuVQo7VZquBV4AKW4FVImrykYHTzb
 EqXMAuHtrLWx5w4nMINDvuSZcUPghX79Ez8mz+Ib6g68gIF5ou3IE2+ZxZR4wIZyVqA+
 Aasg==
X-Gm-Message-State: AFq9FYLGGUna/pjkim765+PgfWAaRysaBKKqemgF3k5Zfh8l5ULua/0R
 GpyZ+uyXf63A8kNrUbOqpHpc+Bj+tXvH+ENasxjydVIZJ+xFny9EM+9uvTdKIyitF47bRw==
X-Gm-Gg: AYBFou0nFGR90UArhKzm9bMIlHmDYG51GQYUfKDc2nLQe+kMpMsg53E/en2wM9rDqZ+
 CPWjp8UEZDniGvRrLTRZF3zqfC8ZaBQ5tVSx6oqZlXomI0Sc8WYdQt4oO42ZT8gmS3tiFKU1gw2
 VvAp99WemEkXZ+smcgO+dytDq888zr6ex8s2lb4RFVU8oSdPKUpJCxqEzB+KjbWb2ngymqtiPTZ
 67HKcY+zX5M1lbB0YNX66ppn99nOSALTqTLNMfBbVVQI7TFE76lQ83YvYStzuaPCZaifkZZKtrQ
 YOCKqbg30YgZycPbZzkEhSV+YNVJxbJletqC0HslNHsu8sPQyN3XeFhOXLoSSOmf90d4XnT+tLd
 SMVPk0t2u+sl/RlqhD9PKaiotmzbUfD24fwTRiWR5VGSFIPp7/uHgi8SMoTh+RxA3BlQ3nPvuhO
 L8LFvTIGHPf2QLm00kNHwbYQmbua2tu2myqxDdQ9U3olNNM6+ZAZCclthlGkOvgLe/XBhFRjDie
 Rw2kNyZiCnKdoX9rvkmVGSioSEDYNPjlS+/SfjkwLQsbTzJXH5thY2hkyglRIt0PhapIXntbw==
X-Received: by 2002:a05:6122:e449:b0:5c9:8b3b:deb5 with SMTP id
 71dfb90a1353d-5e91efca242mr2730202e0c.0.1791770242066; 
 Sun, 11 Oct 2026 18:57:22 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e93683455csm3457882e0c.13.2026.10.11.18.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 18:57:20 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH 1/2] spl: atf: Check the return of the entry/load lookup
Date: Sun, 11 Oct 2026 19:55:41 -0600
Message-ID: <20261012015542.1156811-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012015542.1156811-1-sebasjosue84@gmail.com>
References: <20261012015542.1156811-1-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 05:36:56 +0000
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

spl_fit_images_get_entry() reads the entry point of a /fit-images node
with fit_image_get_entry(), falling back to fit_image_get_load(). Both
report failure through their return value and leave the caller's ulong
untouched: fit_image_get_address() returns -1 before it reaches the
*load assignment, both when the property is absent and when the value
does not fit in a target ulong.

The result was stored in ret but never tested, so a node carrying
neither an entry nor a load property made the function return an
uninitialised stack value, after first reading it in the debug() call.
spl_invoke_atf() hands that value to bl31_entry() as the BL33 entry
point, overwriting the CONFIG_TEXT_BASE default the caller set up for
exactly this case.

Before commit caa7fc2c5775 ("spl: Use standard FIT entries") the lookup
used fdt_getprop_u32(), which returns the value itself and yields
FDT_ERROR on failure, so the variable was always assigned. Switching to
the fit_image_get_*() accessors moved the failure signal into the
return value, where it was left unchecked.

Return the entry through an out parameter and report failure, so both
call sites keep the default they initialised.

Fixes: caa7fc2c5775 ("spl: Use standard FIT entries")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 common/spl/spl_atf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index cb0604ce03..c058774eba 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -252,17 +252,21 @@ static int spl_fit_images_find(void *blob, int os)
 	return found;
 }
 
-ulong spl_fit_images_get_entry(void *blob, int node)
+int spl_fit_images_get_entry(void *blob, int node, ulong *entry)
 {
-	ulong  val;
 	int ret;
 
-	ret = fit_image_get_entry(blob, node, &val);
+	ret = fit_image_get_entry(blob, node, entry);
 	if (ret)
-		ret = fit_image_get_load(blob, node, &val);
+		ret = fit_image_get_load(blob, node, entry);
+	if (ret) {
+		debug("%s: no entry or load address\n", __func__);
+		return ret;
+	}
 
-	debug("%s: entry point 0x%lx\n", __func__, val);
-	return val;
+	debug("%s: entry point 0x%lx\n", __func__, *entry);
+
+	return 0;
 }
 
 void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
@@ -280,7 +284,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 	 */
 	node = spl_fit_images_find(blob, IH_OS_TEE);
 	if (node >= 0)
-		bl32_entry = spl_fit_images_get_entry(blob, node);
+		spl_fit_images_get_entry(blob, node, &bl32_entry);
 
 	/*
 	 * Find the U-Boot binary (in /fit-images) load addreess or
@@ -291,7 +295,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 
 	node = spl_fit_images_find(blob, IH_OS_U_BOOT);
 	if (node >= 0)
-		bl33_entry = spl_fit_images_get_entry(blob, node);
+		spl_fit_images_get_entry(blob, node, &bl33_entry);
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
-- 
2.43.0
