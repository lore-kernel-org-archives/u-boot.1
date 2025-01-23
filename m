Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9207EC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 06:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF5880243;
	Thu, 23 Jan 2025 07:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737613642;
	bh=VHTuvXw7KF+5IpDQGqscLAqN2qmsDXHLRW0ADXLte+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sm8zf0QTa8bgEfslPEnVjLCq5UPZV5wupMNw5vOgzj8qBzFUSpHMzghYTQE/q7JX6
	 7UbvD602PoD2WmZvw4v2gx9dsAtOkb9vhNtbsqHo0WfYGIB55JWGGfwqOjlT5dzDkV
	 /7WqF4xcxQFziAwIFbCeUedf15usKLxwDUVkKmxeb9+CNsd9n6Qhu0/ijG0GcX2G8D
	 hcNHVcZju3U/Ln0hUEVQZQ3NL6S0jMm97Oaj9gMTrTsSvUBAmoxp7JNnt42PbEzXmr
	 tqdFFgBydiNhIeIn+eAYDKlNOStY6TwWrPv7lfTX9Qv71iGWLiK4b89Kq9IR8/BWNt
	 QQXP08YxcQYpg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7870E80275; Thu, 23 Jan 2025 07:27:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645F980214
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fuc5R5Rm"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 584B8104811D5; Thu, 23 Jan 2025 07:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737613637; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHTuvXw7KF+5IpDQGqscLAqN2qmsDXHLRW0ADXLte+c=;
 b=fuc5R5Rml2yI5lcCcXgAIzfzwSozujFXffMu4ilBskXXSscVenoRwM+UomuN1CK1cAmew5
 jyZLCC2J+GCFS62s0kAAXocllb3j1p95Wvf+l/MMb+tsTDsa5ReiqjdE/YKGtzSbJrgi8x
 0VHSxyhoyGbG7rCJ/tcEtqiOr1MYfKGVIWE5eglZh9Fc7dqUISEhJkUCmDIdMvlNWVm8H9
 Ct8RrfytdtoDuOdAcY4GDcYNzb1lKdILwpCbG4cBxklvrmdyC/qcGv7AgClWCOF0vP9+2x
 SVgHk15hCyUznGArnL+UV1reorZv1ZwCSdLhsSSLw3Sxhio1ZYUF/3X2qX6VUA==
Message-ID: <a24d4059-dc95-cf61-82ea-c0f207bac16a@denx.de>
Date: Thu, 23 Jan 2025 07:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] led: add function naming option from linux
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250122121201.55597-1-hs@denx.de>
 <20250122141455.GK3476@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250122141455.GK3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 22.01.25 15:14, Tom Rini wrote:
> On Wed, Jan 22, 2025 at 01:12:01PM +0100, Heiko Schocher wrote:
> 
>> in linux we have the option to create the name of a led
>> optionally through the following properties:
>>
>> - function
>> - color
>> - function-enumerator
>>
>> This patch adds support for parsing this properties if there
>> is no label property.
>>
>> To be as close as possible to linux import the following files
>> from it:
>>
>> include/dt-bindings/leds/common.h
>> include/linux/uapi/linux/uleds.h
> 
> I think you missed my message on v1 saying we need to just use
> dts/upstream/ for these.

hups... Indeed ... sorry!

Look ASAP into it...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
