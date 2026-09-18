Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B77C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 08:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7484B81241;
	Fri, 18 Sep 2026 08:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmpzOQhT7VIO; Fri, 18 Sep 2026 08:51:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7E16281237
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789721511;
	b=gD1xhCwNPW0NbWEh2CPHqUmA4Z+L7jhcYAAX1zMzVKZfr4sxNZaZLwUsOJVUVHFl2Xhq
	 RPr08bbO0ZdQ2ezFPlXNLEKlKF7LkYBEQvsj9eYs0xyQ2tq6HtzOzenCLRm3GLGqhOZE7
	 yKcx+TQp/Dov5AubpmMY9ilZ2IJ0+HM/sd4X3hWVUSsj84lHhcD08iGBSUoOvkQhBZsqi
	 ff5caxKLRkhRQaO7RphgxrpxKno+tqDF1kVmZcc8UG9r7izlBFtfMRpqr7AqbhIBBvKw2
	 vnyVWerCxcyER8/YQBoTx6zorT3w41rVVedxPH9wzr14SsFAxloBCb31f6Iuc2Cu4mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789721511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uj1Ibbg/dbNgGRuF+qoVRmCDi8hMFwxSNCplRAceZNY=;
	b=DmH/p0vT1naTcTUU8hzVyzHQakZDaNmm34G7VBs+NuuNJcojO0DsvRFEK+YZaIpNMo7k
	 mt4NSi1jt+9IUAHAo8Qjxpl0+AJxnvfGgD6TNB2jhDiPIVf5qqCWIevdm24TbklB5E56Y
	 uLaMYurin6nTILg4qxmi3U+m7KWKLioaewy+8OW7JqrSaMC2UgSZnEQ2eX9jOYJV9EQGE
	 OJoNqzSpDoCPaL/uoTmf3QJhCx0YVbnBg7uu9lZYtWTcZQcMWA8nhzg8DXzt5QC2QloJ/
	 TMbcYHgFIvP6UJYMGDFwayMoE8nklhZMy70X9KFGp9/oYn0uEz/iPD8sXsVz5fgQ04A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fat+XQpr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789721511;
	bh=uj1Ibbg/dbNgGRuF+qoVRmCDi8hMFwxSNCplRAceZNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjzIBOGH0bse+9gfr76WVvj0JNcrj9mSLW8EHyCeXpyL+V18RuJDy4DVSfI0RaLmv
	 nDrFjgIUPrwTiC9fq7Pw33aN/J4zGwe9AKdOrqeJKszqI+nj3chUHaLEGyBRFm8Z+A
	 hz99jM1zI1EpEWv+WI0NDmpfqUhiFrFxpNfhlYXFLinv6vSTCb12ZOxyHRZ8qBa67G
	 oSCcf4o9OJESZqwOt1zh5yq2ShIJ13aCZ7b5haw7lgsH4EP2KtQk/GxVOYEXgBtTnC
	 TqgjKDRiOjtmQGm4kgzfO/uIwhsyRa+J2lSlwRsbsxVqaNGD7DxklUAG05QR8HdmUJ
	 U4KAurzcw8dhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E16281237;
	Fri, 18 Sep 2026 08:51:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC98362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30AF88084F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2h8crZJy9io7 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 08:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2315A81238
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789721509;
 b=L+4Kq1bf+WY9n0LcOzvgXCS8AqJCbS5fyDRkJvZ1akHVvYGHWUyyDho5Y0XkWVV5aJCR
 mSggn9R9EUQurW0t6CZoOWilUbd/RYH/jHJzXdmB6HHMi3DKUZTYK+m1V5ht+lQXzSyrL
 wPxIjXCzwIQIf+/sUg3LJO3FlKOuQrDQJKsY8stfkedgC5oSMdB27Szc+EbZrE/i1luNX
 t+NWDh3CVnjrBseBKuiTySs+DrQSoQx7LH+hK4+kQauXD0cvP4ZfLnBqMy+/K70EHqVJS
 yAX2BMa8JtatViwASoPbsroJw70fpXpDpJpRVLhlQodLrorrG+4723AN7urM16NNYGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789721509;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=uj1Ibbg/dbNgGRuF+qoVRmCDi8hMFwxSNCplRAceZNY=;
 b=OK3fHKj5Yu66n05oJ398yRsDgBjW5IYZnx1Xr/1SL3dLaQZOoGBTMTu5LwOfcUv64B4/
 uW+KKEHYkyHUOMzv4rfacWO9itetFeSlskKz9wr68Zpbfg8kCAX+/TpukIN0P2a4aCZCL
 4It4GVo5agYGj/EUtyCVqXq0ovb/EP5oOUKYa/b+E8H44SElzIZKh7MA9w/GzJCyaNzjx
 ikECURBkOI/n/JZHPLJsfuJeG9vsMfjCVJazmIqPavM/WNvV5ehR8seKZ7izJVB3cP1ua
 dRsI7YIDKnjIieYUeTWayfR39pYUtWRGx864MWLsqjHO0AzXtBxKci8dAilnfPXEdmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=fat+XQpr; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=fat+XQpr
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2315A81238
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:51:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0071168F;
 Fri, 18 Sep 2026 01:51:42 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35D183F86F;
 Fri, 18 Sep 2026 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789721506; bh=dM4h7rS9GG4oh7lxspKFMze3d3uUPjPzBMEWMrPREzM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fat+XQprBv9+xI0cLBZgiVLG+U9GaCMXpWJpZutDQRNe4ycpcMuIwO0nTnzEfn2DU
 VZm4H3WAp2oUMea79bfd1pnkKarUWGlV4hqu7hn4vwjIxBMB0wT8W2hYv5GlPG89a1
 zbgFPOiAX6yZMw736IS/6XV6DCaBL07AMXvD4BIo=
Date: Fri, 18 Sep 2026 10:51:42 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH] efi_loader: fix string table reallocations
Message-ID: <aqz7nmtoJPGdjwdC@debian>
References: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
 <BC138B74-47B8-4DC2-9EB9-5FE389909AB5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC138B74-47B8-4DC2-9EB9-5FE389909AB5@gmx.de>
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

On Thu, Sep 17, 2026 at 06:23:11PM +0200, Heinrich Schuchardt wrote:
> Am 17. September 2026 11:45:31 MESZ schrieb "Vincent Stehlé" <vincent.stehle@arm.com>:
> >The new_string() and set_string() HII string protocol functions keep
> >using old pointers after calling realloc(), which may have moved.
> >
> >The set_string() function also assumes that reallocation only grew the
> >array by one element when computing the start of the memory to clear,
> >and forgets to update nstrings to the new table size after reallocation.
> >
> >Repair and factorize the reallocation code in a new grow_string_table()
> >function to fix those issues.
> 
> 
> Should we add a test in U-Boot and possibly in SCT?

Hi Heinrich,

Thanks for having a look.

I think the existing "HII database protocols" self-test is sufficient, thanks to
the change.

With this test, before the patch, the code coverage is fairly good in
new_string() but is poor in set_string().

After the patch, the code coverage of grow_string_table() is fairly good as
expected, and the poor code coverage of set_string() is "gone".

Best regards,
Vincent.

> 
> Best regards
> 
> Heinrich
> 
> >
> >Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> >Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >Cc: Tom Rini <trini@konsulko.com>
> >---
> >This can be tested on the sandbox with the following command:
> >
> >  ./u-boot -T -c 'setenv efi_selftest HII database protocols; bootefi selftest'
> >
> >While the unit test does cause reallocation with new_string(), it does not
> >with set_string().
> >
> >Further testing can be done by forcing stbl->strings = NULL, just after
> >calling realloc(stbl->strings, ...).
> >---
> > lib/efi_loader/efi_hii.c | 64 +++++++++++++++++++++++++++---------------------
> > 1 file changed, 36 insertions(+), 28 deletions(-)
> >
> >diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> >index 7bf51ad43d1..90dff91e5d4 100644
> >--- a/lib/efi_loader/efi_hii.c
> >+++ b/lib/efi_loader/efi_hii.c
> >@@ -822,6 +822,37 @@ static bool language_match(char *language, char *languages)
> > 	return false;
> > }
> > 
> >+/**
> >+ * grow_string_table() - Grow a string table if necessary.
> >+ * @stbl: String table to grow.
> >+ * @n:    Minimum table size desired.
> >+ *
> >+ * Make sure a string table can contain at least n elements.
> >+ * If the table is too small, reallocate the memory and clear the new elements.
> >+ *
> >+ * Return: false in case of reallocation error, true otherwise.
> >+ * In case of error, the original string table is left untouched.
> >+ * In case of success, stbl->strings and stbl->nstrings may have been updated.
> >+ */
> >+static bool grow_string_table(struct efi_string_table *stbl, u32 n)
> >+{
> >+	void *buf;
> >+	u32 old_n = stbl->nstrings;
> >+
> >+	if (old_n >= n)
> >+		return true;
> >+
> >+	buf = realloc(stbl->strings, sizeof(stbl->strings[0]) * n);
> >+	if (!buf)
> >+		return false;
> >+
> >+	stbl->strings = buf;
> >+	stbl->nstrings = n;
> >+	memset(&stbl->strings[old_n], 0, sizeof(stbl->strings[0]) * (n - old_n));
> >+
> >+	return true;
> >+}
> >+
> > static efi_status_t EFIAPI
> > new_string(const struct efi_hii_string_protocol *this,
> > 	   efi_hii_handle_t package_list,
> >@@ -847,23 +878,12 @@ new_string(const struct efi_hii_string_protocol *this,
> > 	list_for_each_entry(stbl, &hii->string_tables, link) {
> > 		if (language_match((char *)language, stbl->language)) {
> > 			efi_string_id_t new_id;
> >-			void *buf;
> > 			efi_string_t str;
> > 
> > 			new_id = ++hii->max_string_id;
> >-			if (stbl->nstrings < new_id) {
> >-				buf = realloc(stbl->strings,
> >-					      sizeof(stbl->strings[0])
> >-						* new_id);
> >-				if (!buf)
> >-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> >-
> >-				memset(&stbl->strings[stbl->nstrings], 0,
> >-				       (new_id - stbl->nstrings)
> >-					 * sizeof(stbl->strings[0]));
> >-				stbl->strings = buf;
> >-				stbl->nstrings = new_id;
> >-			}
> >+
> >+			if (!grow_string_table(stbl, new_id))
> >+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> > 
> > 			str = u16_strdup(string);
> > 			if (!str)
> >@@ -957,20 +977,8 @@ set_string(const struct efi_hii_string_protocol *this,
> > 			if (hii->max_string_id < string_id)
> > 				return EFI_EXIT(EFI_NOT_FOUND);
> > 
> >-			if (stbl->nstrings < string_id) {
> >-				void *buf;
> >-
> >-				buf = realloc(stbl->strings,
> >-					      string_id
> >-						* sizeof(stbl->strings[0]));
> >-				if (!buf)
> >-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> >-
> >-				memset(&stbl->strings[string_id - 1], 0,
> >-				       (string_id - stbl->nstrings)
> >-					 * sizeof(stbl->strings[0]));
> >-				stbl->strings = buf;
> >-			}
> >+			if (!grow_string_table(stbl, string_id))
> >+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> > 
> > 			str = u16_strdup(string);
> > 			if (!str)
> >
> >---
> >base-commit: 2c7eaee7b3422ce7c84e892abfe16e1afce42e83
> >change-id: 20260916-ptr-670be74dcbd3
> >
> >Best regards,
> >--  
> >Vincent.
> >
> 

-- 
Vincent.
