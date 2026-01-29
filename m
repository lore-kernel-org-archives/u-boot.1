Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD574D3F09D
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6996884067;
	Thu, 29 Jan 2026 17:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y92BHFrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7158406D; Thu, 29 Jan 2026 17:57:56 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD2C83F32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f251C35ldz9vGq;
 Thu, 29 Jan 2026 17:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769705871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OtiiUA9aqHnjakSjGS/rfn9TmMy7uzUbWORA1/0Pq0=;
 b=Y92BHFrSNYjGuELFdLYKSuxKpixLzxI5buWTIsgQruWdtPEUZxkfuF3/QlTRIiIeW9BP2h
 MLe//PMOdwAqd4zMeLAg6TVu7ws54LOx3BCFR4TcEA3sKFD67VSItkoft6c+CItn5fIx/u
 bZJ1m0sXCp7Q3/lxykO/TIgLq5ZoEhr07/m0X59nsP0iXmWDOe2BUBmIxvWU3oR0LuuwdV
 zlljk/3s/DXITD87VWhxV3wI58BxofqUSC7a6ky/iakgtVnWSw3BtOusTsQFPUn0LxPoM5
 Ji1Nz6LaoWwPweYIgsMKfz0cXuRkA8AiWsPOXHfduVXwAABLzHLP0JKk41rohw==
Message-ID: <a2760c72-787d-4bb8-a6e4-8a6b118967f1@mailbox.org>
Date: Thu, 29 Jan 2026 17:57:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <87wm10mm0g.fsf@kernel.org>
 <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
 <20260129165341.GC2044980@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260129165341.GC2044980@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5744a05a05fda00bca3
X-MBO-RS-META: gx9eydxserypixnzokjiw3wiow4c79co
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

On 1/29/26 5:53 PM, Tom Rini wrote:
> On Thu, Jan 29, 2026 at 05:33:45PM +0100, Marek Vasut wrote:
>> On 1/29/26 5:17 PM, Mattijs Korpershoek wrote:
>>
>> Hi,
>>
>>> +++ b/lib/gunzip.c
>>> @@ -8,6 +8,7 @@
>>>    #include <command.h>
>>>    #include <console.h>
>>>    #include <div64.h>
>>> +#include <env.h>
>>>    #include <gzip.h>
>>>    #include <image.h>
>>>    #include <malloc.h>
>>
>> This is part of
>>
>> gunzip: Implement chunked decompression
>>
>> so clearly I should move that part here already.
>>
>>> Maybe this should be included conditionally depending on the command
>>> being enabled or not?
>> Why conditionally ?
> 
> A good general question I had is, what's the overall size impact of
> these features?
A more general question is, can we do without this patch. I think yes, 
but I didn't find a way to make the test pass without inhibiting this 
odd self-rewriting progress line. Is there a way to ignore output until 
specific line shows up or something along those lines ?
