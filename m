Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2919CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 13:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5945B83EF9;
	Mon, 18 May 2026 15:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BlDh8sXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F8D83AA9; Mon, 18 May 2026 15:40:08 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A5D383FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DE2C210DE2E; Mon, 18 May 2026 15:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779111605;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sgtuZf7IeGgVnXfgpmFdHEl3q/6pUzyaISLHkQhE6QU=;
 b=BlDh8sXtBTTLqZih1Aqn8y9Ie656u99njlUFFCi9ako6sWh+EKKAr5aVnqgbRHxN/LXkvG
 n9KlHi+TZ93tVihKt5oienSHiqxuIx8SL4KuEZIu0JJSjlOvHps7LwlIrd5jhYAY0fmy69
 bY+fYwwk/NtLQAhN4ZBgLCvvW7xqIFjQH7ve0p1p4/IJJg5xA+LwqxAs9kKR+o77JqrtqM
 urmI3GtR4ic09UBI6gLzYVgIWuCKqHUbxPX3F8EK+lvmVNqipTZiQGU1WrPQYdV0TxkyHY
 P4Fyc/+jWXr2eYBeuwmSiMvZcT1AoLRd0Bl1uQANOHIP6oX3h+fXuSiC4EyJnA==
Message-ID: <e47bd1ee-7bd6-62bd-f337-573c6e74493d@nabladev.com>
Date: Mon, 18 May 2026 15:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: remove dead code
Content-Language: en-US
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de,
 Kyungmin Park <kmpark@infradead.org>
References: <20260512055008.9357-1-peter@pcc.me.uk>
 <96868c0e-277e-ff6b-8cab-985ec0b91dcb@nabladev.com>
 <CAPQLkRjnCS0mHDn+mn22dMwQKGmDDQgDG9PGpN4u5YH+JA3kYg@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAPQLkRjnCS0mHDn+mn22dMwQKGmDDQgDG9PGpN4u5YH+JA3kYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Peter,

On 14.05.26 05:08, Peter Collingbourne wrote:
> Hi Heiko,
> 
> On Wed, May 13, 2026 at 7:50 PM Heiko Schocher <hs@nabladev.com> wrote:
>>
>> Hello Peter,
>>
>> On 12.05.26 07:50, Peter Collingbourne wrote:
>>> This code is dead because it appears after an infinite loop; remove it.
>>>
>>> Fixes: 4c4477c77008 ("fs: ubifs: fix bugs involving symlinks in ubifs_findfile")
>>
>> Wrong commit ID? I find in current HEAD:
>> """
>> commit d5888d509cc43942ec98d993f2d129f5c8ddc432
>> Author: Peter Collingbourne <peter@pcc.me.uk>
>> Date:   Tue May 5 03:38:16 2026 -0700
>>
>>       fs: ubifs: fix bugs involving symlinks in ubifs_findfile
>> """
> 
> Yeah, I see the same. Looks like I accidentally used my original
> commit ID instead of the one that was pushed.
> 
>>> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
>>> ---
>>>    fs/ubifs/ubifs.c | 3 ---
>>>    1 file changed, 3 deletions(-)

Applied to u-boot-ubi.git

Thanks!

bye,
Heiko

>>>
>>> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
>>> index aafbd01a028..3f2e2037745 100644
>>> --- a/fs/ubifs/ubifs.c
>>> +++ b/fs/ubifs/ubifs.c
>>> @@ -608,9 +608,6 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>>                root_inum = inum;
>>>                name = next;
>>>        }
>>> -
>>> -     kfree(buf);
>>> -     return 0;
>>
>> May we need to stay with "return 0;" at the end of the function, as
>> some source code checking tool will claim if there is none?
> 
> I'd probably remove it unless some tool complains. If there's code at
> the end it can mislead readers into thinking it's reachable, which is
> how I ended up adding the kfree() there in the first place.
> 
>> Beside of the nitpick:
>>
>> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>>
>> If you find time to send a v2 with updated commit ID I would be happy,
>> else I can fix it when picking up the patch, if okay for you.
> 
> Feel free to fix it up, thanks.
> 
> Peter
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
