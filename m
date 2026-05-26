Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E55CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A287784843;
	Tue, 26 May 2026 15:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FjWf3y79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1676D8484F; Tue, 26 May 2026 15:17:15 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D18847B0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE6B944065;
 Tue, 26 May 2026 13:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A211F00A3A;
 Tue, 26 May 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779801430;
 bh=zIvzEYDNIBlrKKOGGE3gpnefkRt4nE78W54RJUtTtQU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FjWf3y79Dw5Pse9Cu30PGZww0U7gT6GWP8or4r+7x/iHlb+AmENJD5/hA4aqBKBty
 CcpHz9BuqMKOBqM3XvBw6YFq9399sAsBFyVqmaxImmDFUyO1ny7OZnWmpFkjhdMPbq
 rKY+4mSg5We95de7cLgTKSqwSKO+fCU1uAc9X8HMlvLl3yx5Wi4EhF+21U4/qOk3QL
 mp16jk7FStWj3PIcub1kSDVF/911ztc73QmT42j8Y/sPTGAAwjYp7aB24suVvtR4Fd
 ifcvWeM3S9om/YYsce5UZc0sUZ5vkOHmTrdl1skmA0XZTIaa1s5uIAuGJ7fXgN4w5e
 d2iFLLX2MFPbg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Josh Law <josh2@disroot.org>
Cc: u-boot@lists.denx.de, mkorpershoek@kernel.org, igor.opaniuk@gmail.com
Subject: Re: [PATCH 1/1] libavb: fix avb_replace() OOM handling
In-Reply-To: <20260522183537.GA1858239@bill-the-cat>
References: <20260521163248.15866-1-josh2@disroot.org>
 <20260521163248.15866-2-josh2@disroot.org>
 <20260522183537.GA1858239@bill-the-cat>
Date: Tue, 26 May 2026 15:17:08 +0200
Message-ID: <87se7efgyz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Josh,

On Fri, May 22, 2026 at 12:35, Tom Rini <trini@konsulko.com> wrote:

> On Thu, May 21, 2026 at 04:32:48PM +0000, Josh Law wrote:
>> avb_replace() promises NULL on OOM. Once it had built the first
>> replacement, a later allocation failure returned that partial buffer.
>> Callers treat any result as success, so AVB could keep booting with
>> truncated bootargs.
>> 
>> Free the partial result and return NULL. The existing callers can then
>> take their OOM path.
>> 
>> Signed-off-by: Josh Law <josh2@disroot.org>
>> ---
>>  lib/libavb/avb_util.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git a/lib/libavb/avb_util.c b/lib/libavb/avb_util.c
>> index 8719ede15a7..9e2e6ea3495 100644
>> --- a/lib/libavb/avb_util.c
>> +++ b/lib/libavb/avb_util.c
>> @@ -272,7 +272,7 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
>>        num_new = num_before + replace_len + 1;
>>        ret = avb_malloc(num_new);
>>        if (ret == NULL) {
>> -        goto out;
>> +        goto fail;
>>        }
>>        avb_memcpy(ret, str, num_before);
>>        avb_memcpy(ret + num_before, replace, replace_len);
>> @@ -283,7 +283,7 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
>>        num_new = ret_len + num_before + replace_len + 1;
>>        new_str = avb_malloc(num_new);
>>        if (new_str == NULL) {
>> -        goto out;
>> +        goto fail;
>>        }
>>        avb_memcpy(new_str, ret, ret_len);
>>        avb_memcpy(new_str + ret_len, str, num_before);
>> @@ -308,7 +308,7 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
>>      size_t num_new = ret_len + num_remaining + 1;
>>      char* new_str = avb_malloc(num_new);
>>      if (new_str == NULL) {
>> -      goto out;
>> +      goto fail;
>>      }
>>      avb_memcpy(new_str, ret, ret_len);
>>      avb_memcpy(new_str + ret_len, str_after_last_replace, num_remaining);
>> @@ -320,6 +320,10 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
>>  
>>  out:
>>    return ret;
>> +
>> +fail:
>> +  avb_free(ret);
>> +  return NULL;
>>  }
>>  
>>  /* We only support a limited amount of strings in avb_strdupv(). */
>
> Thanks for the explanation and patch. This seems fine but I'll defer to
> Mattijs as it's his area.

This patch seems to posted a second time here:
https://lore.kernel.org/all/20260521165122.17475-1-josh2@disroot.org/

Can you explain why it has been send twice, please?

>
> -- 
> Tom
