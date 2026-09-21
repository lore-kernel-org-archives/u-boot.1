Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F53BC982DE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 09:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D692606AA;
	Mon, 21 Sep 2026 09:25:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJ8hFbOUDnGT; Mon, 21 Sep 2026 09:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5EEC260628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789982747;
	b=i++/LA6+SlK/fmRO0MIiepS2mZ/vorarXLuMWZmuCMG537xq61j+82emPoSc8cQ483j7
	 A+UK3GVXgqrWTZNIZtgFXWcRoXZLEZd4BnrSmgvFleStvDotPgn4AbZ7WdZZh14pFStGx
	 HXPEBpeVWsPijgfTwiBD60cxcQ3vftjH1m7Tr/ex7dih9MO4UVUJJ3387NiTMa6BQYmbS
	 Sn3NKkZOtLXlAaW00W/+b6QCNUA2E/UEsQ4qVm1myHlMLbkRKv5uwN3zMdrAnhsfJvPEo
	 qcnhKV0ar/EyTlgN+PgQOoZqn6gE/O2LBi81q7aQQwM3UtNQNaMzGLBzVM6EKrumf3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789982747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=phPFd2sNi/6MzG7FWNuFyR4pGHkPc0l0LSqQT1QcD5c=;
	b=UNxDNQ4NDr37WqysPzh4Em5WMgk+j3pRWqimLBIAdTvi/wSoeioRadWbFR0YcjxorUY7
	 /zHni7z83Q2KSLgA6uAg5SDTuhS2sN2hQA4rtYCqgvNGTrrKwN7ipt9TAohljcP9Ho2sn
	 /r8FHH+il/S1XnP/sADtZKi5brAhzqHk9327pj/v/JfQyztbB7Q6DyDDOzI66UzvLfht1
	 5VIFS01wQOYb5f1oFHUBT96IfV/1kzyVNCTI4yQJI2F428ExBKpZ2ecpDklzX+5FMcQ2Y
	 6gEVm9JSBn0+CmaahIteu0OS/JXoZsSmjYjpB6gURdUmeUQRe7Cx5yDZ5ZfzvutPRaA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789982747;
	bh=phPFd2sNi/6MzG7FWNuFyR4pGHkPc0l0LSqQT1QcD5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aAz+lU8g0X9PjaDnME73c4uEMliUleIQTPaL5Xc+LV7bnQFbrLyc6CnO4Nsmurfmk
	 TIIsKepitVrPlPIXDU/1VWmRtATPj4aN9IgE1y3GYm6cI2PR6PM5yqkYCeLELKySjN
	 32c3fhNV7bgQ9ZojcPDtY6FtzIbqEkomn5AIF/eXas/j20zMpmhVo6ltmFNktZ8LPj
	 ORDySSAX5EW8tkJ+dYpUjsWA8+m3EirB19FApCB5CT7Zap2H0kbHyLsqai9Nqic8iB
	 ybugJK6ZT3tUKZxOJPUWX6Xu4Z9OaH+OfUnc84pz0lrEjFASdkguleUVDQsWo6Kh/s
	 s8E3Iu4MgqKdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EEC260628;
	Mon, 21 Sep 2026 09:25:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B046C12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95E3880CE8
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uHj9yTkGnKdB for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 09:25:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C510280CA7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789982744;
 b=B8CsmRFNjTHp0Y3g++baKg/3vaWe+jCgn3RSBKWDinuynZ7E5VzMP8Q4oW1w9nF0g/xA
 VQE79bCHq3phOLmB5U9mPMw2DZGHaaWPumkxzyjAPTHI+BvncytEZL2ztET7S+K73DoRC
 H8caiquxhpjIpyyfjzXwAdSyYIkdGJLakizkyT+afXf0cqMEsT4mSjizN0EWnBN625Ii2
 EMXGK80kHnF86O1jt+aiaPARlG3I0kbU2UyeDFpzxMWDogwCxnoqMce9YaO5fv/dRF1DN
 GEq8aaXyRz3Em+10qXj4RvHzGAWkfB43TV8fXD34rQdhJTwAUSb74tmPpEhUDgVEu3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789982744;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=phPFd2sNi/6MzG7FWNuFyR4pGHkPc0l0LSqQT1QcD5c=;
 b=iLftOosn42RrbtYQSFr3lk+eDkqDLjPDv53e9OQJw2bpsHIn+HkNQVvVo7E97Ob2orNI
 uzmRLXReOKm7k8WE+J0nomEc0Y49NPy0RLzMj/vKTpccjR4kTv5/I8HDZpynCPTR7PSt3
 qTigNuPtJ6BlLHH0T+lwGf4wGsnOAxSrPnq/yWfRWSeFeU0P/sNr1ofwYGAVurazmBFWW
 1Q4SbxQ5NfFRoVawtvy2KtWR9H7/buivxliMw+ucAWFsA502/BRhMTdjUXcduhiXYy3oW
 1VNhhfhGsV3iU77OO7bH+y2zoki4JdxwiEBB3eIVl9Zepu8Mlwhezpek8gwNuteUMsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=UKvoW32t; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=UKvoW32t
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C510280CA7
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:25:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96E761476;
 Mon, 21 Sep 2026 02:25:36 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82323F86F;
 Mon, 21 Sep 2026 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789982740; bh=Xwv1GHgZUnQ4yNpTuVxaYu663f9hWJBtFepDHNBPL+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UKvoW32tn0FnZ616PNPhFEndWDlgsGsmaOTZ9iGbvBm0n4yqKIef0KLo9W9eq9O1h
 eYjNzvUU4C7BXox3cu2tptnI2Xc8Lcu4hP5GLlva98Z2LOf9nv9zF9tCkARFtskL2B
 +54tO0aVL+jgvvaiFJ1dKzolb6pUX1Y2fUa90Ysc=
Date: Mon, 21 Sep 2026 11:25:35 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH] efi_loader: fix string table reallocations
Message-ID: <arD4D-UUNXzMdOXq@debian>
References: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
 <BC138B74-47B8-4DC2-9EB9-5FE389909AB5@gmx.de>
 <aqz7nmtoJPGdjwdC@debian>
 <FA1BF842-7E1D-4CF3-B744-681CEEE150AD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FA1BF842-7E1D-4CF3-B744-681CEEE150AD@gmx.de>
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

On Fri, Sep 18, 2026 at 06:22:23PM +0200, Heinrich Schuchardt wrote:
> Am 18. September 2026 10:51:42 MESZ schrieb "Vincent Stehlé" <vincent.stehle@arm.com>:
> >On Thu, Sep 17, 2026 at 06:23:11PM +0200, Heinrich Schuchardt wrote:
> >> Am 17. September 2026 11:45:31 MESZ schrieb "Vincent Stehlé" <vincent.stehle@arm.com>:
> >> >The new_string() and set_string() HII string protocol functions keep
> >> >using old pointers after calling realloc(), which may have moved.
> >> >
> >> >The set_string() function also assumes that reallocation only grew the
> >> >array by one element when computing the start of the memory to clear,
> >> >and forgets to update nstrings to the new table size after reallocation.
> >> >
> >> >Repair and factorize the reallocation code in a new grow_string_table()
> >> >function to fix those issues.
> >> 
> >> 
> >> Should we add a test in U-Boot and possibly in SCT?
> >
> >Hi Heinrich,
> >
> >Thanks for having a look.
> >
> >I think the existing "HII database protocols" self-test is sufficient, thanks to
> >the change.
> >
> >With this test, before the patch, the code coverage is fairly good in
> >new_string() but is poor in set_string().
> >
> >After the patch, the code coverage of grow_string_table() is fairly good as
> >expected, and the poor code coverage of set_string() is "gone".
> >
> >Best regards,
> >Vincent.
> 
> If the test did not fail before your code was added, there must be some test case missing.

Hi Heinrich,

Yes, we are indeed missing a test, which would exercise set_string() in
a way that would reallocate the string table, and I did not find an easy
way to obtain that with the existing HII packages data that we have
currently (packagelist1 & 2).

Arguably, now that the factorized function is well covered with
new_string(), we might not even have to do an additional testing effort,
but if you insist I could try to add some more packages data and a
specific unit test.
Just let me know if you prefer that.

Best regards,
Vincent.

> 
> Best regards
> 
> Heinrich
> 
> 
> >
> >> 
> >> Best regards
> >> 
> >> Heinrich
> >> 
> >> >
> >> >Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> >> >Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> >> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> >Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> >Cc: Tom Rini <trini@konsulko.com>
> >> >---
> >> >This can be tested on the sandbox with the following command:
> >> >
> >> >  ./u-boot -T -c 'setenv efi_selftest HII database protocols; bootefi selftest'
> >> >
> >> >While the unit test does cause reallocation with new_string(), it does not
> >> >with set_string().
> >> >
> >> >Further testing can be done by forcing stbl->strings = NULL, just after
> >> >calling realloc(stbl->strings, ...).
> >> >---
> >> > lib/efi_loader/efi_hii.c | 64 +++++++++++++++++++++++++++---------------------
> >> > 1 file changed, 36 insertions(+), 28 deletions(-)
> >> >
> >> >diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> >> >index 7bf51ad43d1..90dff91e5d4 100644
> >> >--- a/lib/efi_loader/efi_hii.c
> >> >+++ b/lib/efi_loader/efi_hii.c
> >> >@@ -822,6 +822,37 @@ static bool language_match(char *language, char *languages)
> >> > 	return false;
> >> > }
> >> > 
> >> >+/**
> >> >+ * grow_string_table() - Grow a string table if necessary.
> >> >+ * @stbl: String table to grow.
> >> >+ * @n:    Minimum table size desired.
> >> >+ *
> >> >+ * Make sure a string table can contain at least n elements.
> >> >+ * If the table is too small, reallocate the memory and clear the new elements.
> >> >+ *
> >> >+ * Return: false in case of reallocation error, true otherwise.
> >> >+ * In case of error, the original string table is left untouched.
> >> >+ * In case of success, stbl->strings and stbl->nstrings may have been updated.
> >> >+ */
> >> >+static bool grow_string_table(struct efi_string_table *stbl, u32 n)
> >> >+{
> >> >+	void *buf;
> >> >+	u32 old_n = stbl->nstrings;
> >> >+
> >> >+	if (old_n >= n)
> >> >+		return true;
> >> >+
> >> >+	buf = realloc(stbl->strings, sizeof(stbl->strings[0]) * n);
> >> >+	if (!buf)
> >> >+		return false;
> >> >+
> >> >+	stbl->strings = buf;
> >> >+	stbl->nstrings = n;
> >> >+	memset(&stbl->strings[old_n], 0, sizeof(stbl->strings[0]) * (n - old_n));
> >> >+
> >> >+	return true;
> >> >+}
> >> >+
> >> > static efi_status_t EFIAPI
> >> > new_string(const struct efi_hii_string_protocol *this,
> >> > 	   efi_hii_handle_t package_list,
> >> >@@ -847,23 +878,12 @@ new_string(const struct efi_hii_string_protocol *this,
> >> > 	list_for_each_entry(stbl, &hii->string_tables, link) {
> >> > 		if (language_match((char *)language, stbl->language)) {
> >> > 			efi_string_id_t new_id;
> >> >-			void *buf;
> >> > 			efi_string_t str;
> >> > 
> >> > 			new_id = ++hii->max_string_id;
> >> >-			if (stbl->nstrings < new_id) {
> >> >-				buf = realloc(stbl->strings,
> >> >-					      sizeof(stbl->strings[0])
> >> >-						* new_id);
> >> >-				if (!buf)
> >> >-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> >> >-
> >> >-				memset(&stbl->strings[stbl->nstrings], 0,
> >> >-				       (new_id - stbl->nstrings)
> >> >-					 * sizeof(stbl->strings[0]));
> >> >-				stbl->strings = buf;
> >> >-				stbl->nstrings = new_id;
> >> >-			}
> >> >+
> >> >+			if (!grow_string_table(stbl, new_id))
> >> >+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> >> > 
> >> > 			str = u16_strdup(string);
> >> > 			if (!str)
> >> >@@ -957,20 +977,8 @@ set_string(const struct efi_hii_string_protocol *this,
> >> > 			if (hii->max_string_id < string_id)
> >> > 				return EFI_EXIT(EFI_NOT_FOUND);
> >> > 
> >> >-			if (stbl->nstrings < string_id) {
> >> >-				void *buf;
> >> >-
> >> >-				buf = realloc(stbl->strings,
> >> >-					      string_id
> >> >-						* sizeof(stbl->strings[0]));
> >> >-				if (!buf)
> >> >-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> >> >-
> >> >-				memset(&stbl->strings[string_id - 1], 0,
> >> >-				       (string_id - stbl->nstrings)
> >> >-					 * sizeof(stbl->strings[0]));
> >> >-				stbl->strings = buf;
> >> >-			}
> >> >+			if (!grow_string_table(stbl, string_id))
> >> >+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> >> > 
> >> > 			str = u16_strdup(string);
> >> > 			if (!str)
> >> >
> >> >---
> >> >base-commit: 2c7eaee7b3422ce7c84e892abfe16e1afce42e83
> >> >change-id: 20260916-ptr-670be74dcbd3
> >> >
> >> >Best regards,
> >> >--  
> >> >Vincent.
> >> >
> >> 
> >
> 

-- 
Vincent.
