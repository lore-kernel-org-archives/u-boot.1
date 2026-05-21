Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD892CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 16:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579E5846A4;
	Thu, 21 May 2026 18:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PFRVXYgM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kQqUVf9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5065A846E7; Thu, 21 May 2026 18:17:12 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3116783FF5
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gLtpY6M77z9vgd;
 Thu, 21 May 2026 18:17:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779380229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAQq3yA8IWx9pW+5GYanWZ2ZXfX1Ul4mjuRxWIPs1wo=;
 b=PFRVXYgMRyBzrsuFzWHtyxhtkdmn07jtELIv3FZUChgPxS8+8TRm34/XiUmHpMKGgYKjT9
 KZp/6jEMt8ZRirvoZ7MPjUOogQQGcSw9sOTziYXtKHU5Htnf/HJ7FdbBYDzi5fYwsyOQHN
 tnRML9cRDMfCcMZiyNyhCljBue8+gWP5b1cupY/PHYkfkrlhLoA6/tTdwzCTPZaMnIQFl4
 PpvHUXTHvo2OiZNCg9HYlv60SNujjqBcd327ArjwdwGSQ6D/mLB6eFE7XcBygWrcOoR68m
 UZTdOxu1IJISBuPQ1hCXCijkN/1Wq+Aluty/Fb80uhmxk8CFz3h0IsA5Mx9LoQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kQqUVf9H;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <57eda5e0-e82d-43a0-af31-bf2db62eae56@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779380228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAQq3yA8IWx9pW+5GYanWZ2ZXfX1Ul4mjuRxWIPs1wo=;
 b=kQqUVf9HibLGwgRDe7yIujzVrRfOdf/XaTgkTBsEnvXM0VA2flRT9fXHoOb3Hifu7q9aA7
 4eNm9ufqSU7IqOKmmXFUmQYeqB15r5Wy/wyeDTMLJSHtLNwNp+MqYzQLdQhbjCrsfOzxNu
 GdaDyLylx0pgoEygVGxPdI1JSwWaWlvF91BSermFFRnk6R/qE+kLu8llOMiGMxp510hJ2N
 MUmT/pM37UNOqSAWsoEgjfWczirkIsVPWv9O5rPneEIqHNptjHdv+I5QQ9IH2HjDvF0ma1
 Fj9bqXI8CSE+2qaIjj9MFJaxmO2ztdYVVAs+7HcigUjboEGxrUlWKVFjmr4D4g==
Date: Thu, 21 May 2026 18:17:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] tools: mkimage: fix get_basename crash on paths
 with dotted directories
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <cf2f988c-e12e-4dd3-b80e-b58f846a8d71@mailbox.org>
 <b1206a04-9800-4323-bf4a-cb8a14f15f8c@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b1206a04-9800-4323-bf4a-cb8a14f15f8c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q3wx54u6hwoopb4rgyr6c7q7wnjcfrrn
X-MBO-RS-ID: b4735fafb4b923fad9f
X-Rspamd-Queue-Id: 4gLtpY6M77z9vgd
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

On 5/21/26 6:12 PM, Quentin Schulz wrote:

Hello Quentin,

>>> +    p = strrchr(start, '.');
>>> +    end = p ? p : start + strlen(start);
>>>       len = end - start;
>>>       if (len >= size)
>>>           len = size - 1;
>>
>> Why not call basename(3) directly in here ? Why reimplement it ?
> 
> """
> Warning: there are two different functions basename() - see below.
> 
> [...]
> 
> Notes
> 
> There are two different versions of basename() - the POSIX version 
> described above, and the GNU version, which one gets after
> 
>      #define _GNU_SOURCE         /* See feature_test_macros(7) */
>      #include <string.h>
> 
> The GNU version never modifies its argument, and returns the empty 
> string when path has a trailing slash, and in particular also when it is 
> "/". There is no GNU version of dirname().
> 
> With glibc, one gets the POSIX version of basename() when <libgen.h> is 
> included, and the GNU version otherwise.
> 
> Bugs
> 
> In the glibc implementation of the POSIX versions of these functions 
> they modify their argument, and segfault when called with a static 
> string like "/usr/". Before glibc 2.2.1, the glibc version of dirname() 
> did not correctly handle pathnames with trailing '/' characters, and 
> generated a segfault if given a NULL argument.
> """
> 
> Not very reassuring, tbh.

Writing our own variant with its own set of bugs is worse than using a 
common implementation which has the bugs removed over time due to effort 
of the various users.

If basename(3) is not an option, is there another common alternative ?
