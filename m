Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AD7D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB30D88DD0;
	Fri, 18 Oct 2024 18:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dYsTSJRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4276888DF3; Fri, 18 Oct 2024 18:31:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D3688DA0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9e6c=RP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729269059;
 bh=h2ym/7YixAF8UpqAXW5Pcx5XGTYkHCWL3BNyDgYexmQ=;
 b=dYsTSJRTXq/i/Gx7aS1FHbyAomLakCgE7IsuRguWaE7i/ggcVC4DwSq7n+MZU2pCjHxI1CUwN
 BGLWFKKKdQ3nl5cVO3KBPTwHaolBdIS1BhlxuJ9XAnqEwc4MdT3rirCUjbu+5cQCWPpM5uTFmEd
 TB4bftgoYLt+3TQ+AhQIJaNHiFjRQk6Nrv27PgxV+AluWhVV8EDU6Q8FqRni/qHtiUwsFT/fPyv
 LfLpzwKCX0PlL2k9c0kfSH9EnmmYBFyhCAjPja7vJcarXxHp1mzbFer6fP453bye2LqGxCvbf73
 r3/hMryFh+KU/Pu9WnqlgOYBvSZm0hq5E2dOI4nLyTng==
Message-ID: <c3fa880f-989d-4283-b0ed-5719562dc154@kwiboo.se>
Date: Fri, 18 Oct 2024 18:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86: coreboot: Add timestamps from coreboot to
 bootstage
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240828201355.1111764-2-sjg@chromium.org>
 <20240828201355.1111764-1-sjg@chromium.org>
 <CAFLszTjk+LtGFUBb-Xgn_QX-W-QP+yCJ+E1C=V04VGcpi0mVng@mail.gmail.com>
 <f6cfcdee-e7a2-4564-a1f3-473fb47cb3cb@kwiboo.se>
 <CAFLszTi9U=QFqekG93SoQmDrCE=vH3=N3BvZ8sQ8_yFBkv62RQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTi9U=QFqekG93SoQmDrCE=vH3=N3BvZ8sQ8_yFBkv62RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67128d42c2bf7088b2829ceb
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

Hi Simon,

On 2024-10-18 16:59, Simon Glass wrote:
> Hi Jonas,
> 
> On Fri, 18 Oct 2024 at 01:44, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Simon,
>>
>> On 2024-10-18 01:12, Simon Glass wrote:
>>> Receiving timestamps from coreboot was unceremoniously dropped some time
>>> ago. Add it back.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Fixes: 8ad01ce36f7 ("x86: Remove x86 specific GD flags as they are...")
>>> ---
>>>
>>>  arch/x86/cpu/coreboot/coreboot.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> Applied to u-boot-dm, thanks!
>>
>> I was under the impression that you would rework this to prepend the
>> coreboot bootstage records instead of adding the preceding coreboot
>> records in the middle of existing U-Boot records.
>>
>> Or did I misinterpret your response [1] to my "bootstage: Do not sort
>> records" patch [2] and you instead wanted me to do this?
> 
> I decided to worry about this later. There is a coreboot update as
> well in this lot of patches. Once that is applied I have some more
> pending patches and I will take a look at this.
> 
> I sort-of agree that sorting shouldn't be necessary...it's just that
> with the boot sequence getting so complicated these days, I'm not
> sure. But let's go with unsorted and worry about it later when we have
> other cases (i.e. other than a prior stage) to worry about.

Does that mean you will merge my patch [2] to remove the sorting? It is
currently marked as 'Changes Requested', yet there is no request to
change anything. Only a request to insert the coreboot records in
correct order, something that is more related to this patch in my mind.

Regards,
Jonas

> 
> Regards,
> Simon
> 
> 
> 
>>
>> [1] https://lore.kernel.org/u-boot/CAFLszTjz9dX2UzUHgbmsr2no4seK07oo2PC++hS2t7CP7z8khA@mail.gmail.com/
>> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240803124149.2916030-3-jonas@kwiboo.se/

