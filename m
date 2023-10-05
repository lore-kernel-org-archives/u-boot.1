Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94E3E92716
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 19:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0448686D11;
	Thu,  5 Oct 2023 21:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Cn1vtP+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E05C86D28; Thu,  5 Oct 2023 21:13:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F00C85095
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 21:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S1h6V2BYPz9sST;
 Thu,  5 Oct 2023 21:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696533202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/vxx3Jfb9wzzvNy+B7nuMKQUn0XEfPgvEZDMkO0u3E=;
 b=Cn1vtP+9L5QLyOV+FsxBtoV4shSKsxQhMy5j3vicXgoy9/de0AatnoqVF/zOFPzwYB6E3C
 Z4pNafGxwysJ+aQqy9oZ0oKVg2+yLBQ+h0KzlQ8AEajRvC26pWuVwoyhrZq9M5PX8YP7li
 aR+SB2xxTr2i8tgKTv/jfs+KFiBLNadzLYsjqhw+/Q3jmMmKdMPhJiJNlqslIdM7U9xgRI
 VZsLH5xt4UXxCEGmkun4gWXzdMnDiYNHem1aemoh0vb8+QQY4ZKjQP6nSvZ5dWX6IgEAFn
 M1bEzRTtmDw2XU/elo8opwMcC9JjrCARb7W9Jp5MGW4PNBUV/zxWHdTqcU9vag==
Message-ID: <d3734870-add1-4b34-910c-4adbeb864ac9@mailbox.org>
Date: Thu, 5 Oct 2023 21:13:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
 <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
 <5d5f0da0-c0f1-670d-d43a-dd2618f226db@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <5d5f0da0-c0f1-670d-d43a-dd2618f226db@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 737ed6690859f34004e
X-MBO-RS-META: imx58hh1c8dqqu1n7euur1m89yfutgfw
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

On 10/5/23 18:18, Paul Barker wrote:
> On 04/10/2023 13:26, Marek Vasut wrote:
>> On 10/4/23 10:48, Paul Barker wrote:
>>> On 03/10/2023 14:23, Marek Vasut wrote:
>>>> On 9/20/23 14:42, Paul Barker wrote:
>>>>> +	if (IS_ENABLED(CONFIG_RZG2L)) {
>>>>> +		struct reset_ctl rst;
>>>>> +		int ret;
>>>>> +
>>>>> +		ret = reset_get_by_index(dev, 0, &rst);
>>>>> +		if (ret < 0) {
>>>>> +			dev_err(dev, "failed to get reset line\n");
>>>>> +			return ret;
>>>>> +		}
>>>>> +
>>>>> +		ret = reset_deassert(&rst);
>>>>> +		if (ret < 0) {
>>>>> +			dev_err(dev, "failed to de-assert reset line\n");
>>>>> +			return ret;
>>>>> +		}
>>>>> +	}
>>>>
>>>> devm_reset_control_get_optional() or something should do here too , right ?
>>>>
>>>> Note that R-Car does have SCIF reset too, so this can be generic code.
>>>
>>> For R-Car systems the current behaviour is working and well tested, we
>>> concluded that we shouldn't change it so this reset de-assert was made
>>> RZ/G2L specific.
>>
>> I can test on R-Car just fine, no worries.
>>
>> SH R2Dplus is even tested in CI nightly.
>>
>>> For RZ/G2L, de-asserting the reset is not optional.
>>
>> Let's avoid special-cases like that.
> 
> Looking at this again, I don't see how we can avoid a special case here,
> de-asserting the reset is required for the RZ/G2L. It may be optional on
> other SoCs (I don't know), but it's definitely not optional here, so I
> don't think we should be using the devm_reset_control_get_optional()
> function.

I'd say let's just unconditionally assume reset is needed for all 
platforms. That should work, right ?
