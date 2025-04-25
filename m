Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CC7C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C45A81E14;
	Fri, 25 Apr 2025 13:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745582284;
	bh=k+0NMNrA79CVivUnIJ/dKX/gehsElEQtMKAIjTfN7lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aa1FKfO+UwdSkKTPMNXuJ3VNn81x+3WdlpYBP4to3hgIJfVV+oRV0z7d1h4Z8vcRw
	 F//YgZWTxmIujlY2F8yMVrZe1ZQEycE/q1Z8QtvJBx2SvvbPyJEJynjXzunXd92iul
	 0JeXa3KzBA05n/WpbjnCwDlyDiWsLus07aD5tJ81sfLvxA2tnbeAdW9sKBLw6lIYz6
	 0OYYGf5Qd7XPnp0nZ3iAwkayeUpMh9B+AZJhjxSvmr6DdP0DnDXpQ6H9XpOLnAY9mD
	 bowhdPoIuIcBWKH1242MTAMoFb4ySpvODplSbw0DhX1mwCf/4bnOynRV6D0PB3//xR
	 uifFFdWiymEtw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8508205A; Fri, 25 Apr 2025 13:58:03 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4158181E0F
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Szy4BnNS"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 21315102A8CB3; 
 Fri, 25 Apr 2025 13:57:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745582280;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=k+0NMNrA79CVivUnIJ/dKX/gehsElEQtMKAIjTfN7lw=;
 b=Szy4BnNSb8biOLVYBr6NTJ904FWLdIhVEClLfxOxDTvHBhysPYlEdFHUpGOsCXhAJEKBew
 8QOpatshD9A09hGkkpOjLsW8mPlYARlcQceMXYHgQ/KXSDyCSTdAIyuy2RyRC7EL2tn9sz
 F7Qf3xk5ResOi1a/L7+t14wb3OQq/1FzhEJeVC5GPKNfdM0YwxyIMM+lPBHd9c13nmE2D0
 ofwDIVcXYRgqpazKJQWV7Kh9EMBRZKRMZ10TTjQcZZ3z/6dAAiX8wctvYf5i0HtnDe2LTa
 HXKp1cnQYhwyG1SGgHTMqjzz25Dv108Mnl4/FaoMLMOg0HdWE4nIEcKto1pMyA==
Message-ID: <94aebc95-b7cc-5b99-8257-8a42f65ff59e@denx.de>
Date: Fri, 25 Apr 2025 13:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 3/3] siemens: capricorn: add ahab command and enable
 watchdog
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250416090419.54781-1-hs@denx.de>
 <20250416090419.54781-4-hs@denx.de>
 <CAOMZO5Bo-W6M3Ax52QK8PzFYOb0=Vq2EmSd9SqN-sQZQ1b0QUA@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5Bo-W6M3Ax52QK8PzFYOb0=Vq2EmSd9SqN-sQZQ1b0QUA@mail.gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 25.04.25 13:47, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Wed, Apr 16, 2025 at 6:05 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> From: Walter Schweizer <walter.schweizer@siemens.com>
>>
>> Handle watchdog in U-Boot to fix CI.
> 
> This commit log must be improved.

Indeed!

> The watchdog's purpose inside the imx8qxp is not to make CI happy :-)

:-P

> 
>> @@ -16,6 +16,7 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_SYS_MMC_ENV_PART=2
>>
>>   CONFIG_DM_GPIO=y
>> +CONFIG_AHAB_BOOT=y
> 
> What do you think about this option? It seems unrelated to watchdog.

Yep, as in subject the patch enables AHAB and WATCHDOG...

I will improve the commit message.

Thanks for the review!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
