Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A93C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBEF84CCF;
	Thu,  2 Jul 2026 11:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="RKiddJnC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="djKBJb03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C6B384CE1; Thu,  2 Jul 2026 11:24:53 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0346284CCF
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 11:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id AEBB21D0011E;
 Thu,  2 Jul 2026 05:24:49 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
 by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 05:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1782984289;
 x=1783070689; bh=FOTbzIE93laxy9c7gb5nraa/cJXYnRhGkZt0pLF+Y9o=; b=
 RKiddJnC3+LEvDtMJ2a8NtNd/J0dvbxPAaX3+2O3ypEOudkpncgIhpGymCJZqS6H
 KLLWdk1OVtGLyEyHk/JNPJ7QhXQmrO9RqfZpG+oAZMLDD3l4SviLG4FIYXPeFhKC
 Er7rnVEeYT2yVl9TK13msyjt6TFN9JKbOlb1X35AskAKkblF7v4ErVc4/ye/cInX
 e3uxUEHQ/5DFKUFO6XCLh8oaUES0xEL8ek7R65D3/92ntM4pFvd2rhF06+QhVZt/
 oG360Od/ey4CXXMK3dIKjN99m4rCcY34hydZtr0E9HIVhIPZ71IIwvH0CAl47GQ1
 qzdjRgZqyxPNnEwjFAwSOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782984289; x=
 1783070689; bh=FOTbzIE93laxy9c7gb5nraa/cJXYnRhGkZt0pLF+Y9o=; b=d
 jKBJb03j9fIs4VrhVAjbXwemmX3D89UAn2Vyi+zaS3zuy0MmBrYVnEqwzHR4tbP9
 NKHtx0n6MKH8541BI98o55E79jJGqSALW0c7u1wglWreShemIx55kzRDsb92DaN3
 /6eIz4Iw8+BCdVl9REURbzaXDsuq4wyu5iMrkV+BcujRNk3tF8fkHmKxuDXhmalk
 /++9bREb99TbHkVni5j6YyxD7amMtIeLx9N8Y7vXRFoelcV1MPjHrXGTswULwBnH
 OaSU6ofEFIi3/yPAIVjX8j7tfEBRIWnvaqUIAW8mYcKOoY4BPgu27Hf/hbQ3UZKR
 wTgEGDm2N+n2zhad1G2Rg==
X-ME-Sender: <xms:YS5Gap3Me5WkwRfGkPWMbFdAfjpYNepmXtbAw8nsRbC-lSHH4LLy7A>
 <xme:YS5Gaq4A1oER_idv9EYJxGZ6xy-4ou-GiX_CRo5CYeVXec7X2iwF55Ghvi6xUOxoh
 Jz2xyHahzqT4jYj-Rjdr1PlYmUiI-jdDFsqrju0PVP2HoN4pTUwUPY>
X-ME-Proxy-Cause: dmFkZTG4UxpVeSMx2NHG5o97sCqTH3ghb7Hx2UMsd/OGEQASw1PhC+iO16IBkN4ZSlDHi4
 YvJSHQ/blZEVRg19n18FYbnSyrZe3Iy0gT2imnNSv8bgzeAMABUVo3Bi942Ii9Ygz9wM3F
 pevGZNw3DhEQzUnckiPEMXFuUmWqGdQKp0s1PzUnS2pHpqTxewuJxWEnTSro0bfr8o0r2t
 pHtHrkh+/5Hxn6PmZzp9R4bul4696t0lrO3Xt6v+ZIqSr6siM6JcMgdLREZsXzWE7+j/h7
 Q6i7IYVx3yBQ9Yym8tEtL0jMYKJppUWXrYdHVcP91wq5Vu/y/gdyzPWzizFZtwe1zj9dI0
 1jKKy8G3oQVFzEZvlgZRmaCE/RojfocvGkOXbGSL15PFBxLq4d7Unu3An7tqUHtxfVu5vU
 7fkUHzdYwtYVNuhYw/o8VH2Ys59mZ72d9vPcjZiwfEyJoWfiMT/Bj4OHMRAzfF9dgSmwQa
 EbxYBPmnFpVQTgwgFmKrFdumHcNx+ZjJSMEFG2YZFmFbSa834crHtNuKK9F3UaQbsri5/Z
 ru6EcKvJEM2F85ouRISjXHqP7pV1O/iGI09NmoJAnk/h0lNUorOhnBIh96aNyuyact8PWD
 QLqAaAbHdU2aSLc3taIUo5MSan3Wp0cR5zxdenRBm1oBdPqiixL2gV3C8qPw
X-ME-Proxy: <xmx:YS5GajahLTAu-v8qIlIWMqV5GQaIiOHl4Dd3hhA5phs1H2kl7o-iWA>
 <xmx:YS5Gaj5SrXksGoD60bPH24g_mCq0jk_K-1jL8DcZ2OhUtK8b79I5KQ>
 <xmx:YS5GamB17VCknlDyH5aZW5073bDSDmi-cm5PvzqNHWZbsLlE461Oyg>
 <xmx:YS5GapeTC0XagAYuMDVwfNv-HnAXJY_QaK6DxZP756WCZpHQsArHkw>
 <xmx:YS5GatfjBN2xRBWyCgRAWFheXZqNs24cKgK9-8rf3rvktyFivGdgh9W4>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 2DAE818E0071; Thu,  2 Jul 2026 05:24:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AvGwZkVkcVgZ
Date: Thu, 02 Jul 2026 10:24:28 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Tom Rini" <trini@konsulko.com>, "Yao Zi" <me@ziyao.cc>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Message-Id: <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
In-Reply-To: <20260701174940.GP749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc> <20260701174940.GP749385@bill-the-cat>
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Wed, 1 Jul 2026, at 6:49 PM, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 11:17:59AM +0000, Yao Zi wrote:
>
>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> 
>> Add some common library routines for the architecture.
>> 
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Signed-off-by: Yao Zi <me@ziyao.cc>
> [snip]
>> +#define CACHE_MAX_LEVEL		3
>> +#define CACHE_MAX_INDEX		6
>> +#define CACHE_OP		GENMASK(4, 3)
>> +#define  CACHE_INDEX_INVWB	0x1
>> +#define  CACHE_HIT_INVWB	0x2
>> +#define CACHE_INDEX		GENMASK(2, 0)
>
> I was expecting checkpatch.pl to catch the double space here, but it
> didn't. It did warn about a few other things in macros, which should be
> checked out at least. And that comment applies for the whole series,
> along with a manual check for other spacing issues, thanks!

Those style issues are mostly copied over Linux kernel counterparts, should
we leave them as is to ease kernel rebasing effort, or fix them for consistency
with rest of the U-Boot?

Thanks

>
> -- 
> Tom
>
> Attachments:
> * signature.asc

-- 
- Jiaxun
