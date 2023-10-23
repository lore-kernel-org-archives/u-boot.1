Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8C4CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1EA87733;
	Mon, 23 Oct 2023 15:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XB3b5glT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FF187738; Mon, 23 Oct 2023 15:51:46 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C1986F86
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D0943FA6A
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698069102;
 bh=Mn6mKz+JUTAOO+h5VpdYED609ECVHnWRy4I9G5bLkq4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XB3b5glT0v2jAQRluD3AMl61p1ioJ21Q7OJP4Q9+gb5s1UD+VmlJ43xYF4kl3pCUb
 aovmAp+QAmdyf0KQIm5Yar6fZ8A2JuI22spLnqiv8p+Hv984+LwPfsy2XXB6/bJQTx
 GFiwaCBaqNUmeFaFXlGOvcxNTcnIJLVjAM2zrj9EArZqi1ap/PdXeoEHUPDAcneyt1
 VtLMY+BLM/FiDDnJySq/8bjT+Ue5LPklS8D4D8CxO5tJXeIsVAbtxpSHhg5hxG9EEQ
 5Ej58L3E8A5/K+zJAdYu1swuDg0wjkkilCEOQySuUwqjstv52DPQrSRoK6/YHrDIBw
 Tzq0Zl9XYruHQ==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso29673021fa.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698069101; x=1698673901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mn6mKz+JUTAOO+h5VpdYED609ECVHnWRy4I9G5bLkq4=;
 b=mKkrJc/n2adKECnfZEDy71VZcXq7zjAstjPxASwtSkQVQVXA9yWXIeCdVIVShEotTD
 BLby8JrEZASd71I5nvgejONtvokxN6prJ/m2wLlB9bXjzvNDZ3ajVfM9agsesgT0YC1n
 h5TGA4BNYwPZ50Im+msb9EK3wI2MAK0WRCCrwGTryE4bdnz3ZJ4mAQM9VwZJM2VBJ39L
 iS/AwWoNGiUEZ4DxKgqO89l6ZUXCe8BfuwVfIQvPQlpNbK8dZ6TqnyRz6Xc8R2qzhFIp
 pd/yTnwz9+Ok0cCSyei3blYHDHQdUxprVOjIr66U/KODOkXM7U2Ul92yKE0WxDftH1/3
 E5cw==
X-Gm-Message-State: AOJu0YypxutBnZFc1yUjXSDGCDtO9esfnbpm83J/ZpVFu7NIxmw753mO
 fKNzwWsJkb33MxiL4MQ9GxW0C/pE1tRKMf+bMrVjmKFkWaZGKSVCRGmtQfGZv8SG9bk8f93SPSK
 +q/hZpnP2qN6nJVB7f0n2uFYNlEE5zb4=
X-Received: by 2002:a05:651c:50f:b0:2c5:6df:8b24 with SMTP id
 o15-20020a05651c050f00b002c506df8b24mr7349010ljp.41.1698069101584; 
 Mon, 23 Oct 2023 06:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwFyA4YX8l33Gr4ExmSTnNTmhn5Ekqst2bi1KE8wT9Tjj/OuxcNBNscAt/32h742ijNaEQkw==
X-Received: by 2002:a05:651c:50f:b0:2c5:6df:8b24 with SMTP id
 o15-20020a05651c050f00b002c506df8b24mr7348978ljp.41.1698069100764; 
 Mon, 23 Oct 2023 06:51:40 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b00326dd5486dcsm7835853wrm.107.2023.10.23.06.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 06:51:40 -0700 (PDT)
Message-ID: <303af8d9-3dd6-4c74-94fd-b2300f7fdbac@canonical.com>
Date: Mon, 23 Oct 2023 15:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
 <20231023134310.GJ496310@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231023134310.GJ496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23.10.23 15:43, Tom Rini wrote:
> On Sun, Oct 22, 2023 at 07:47:07PM +0200, Heinrich Schuchardt wrote:
> 
>> SPDX headers should use GPL-2.0-or-later and not GPL-2.0+.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> So, first, iirc GPL-2.0+ is deprecated, but still valid, yes? We should
> use the current form of all tags moving forward as I do remember there's
> a reason for the switch to "-or-later" from "+". But second, the linux
> kernel is still full of "GPL-2.0+" including dts files that this patch
> changes, and so will get lost again on re-sync.
> 

I cannot find GPL-2.0+ in https://spdx.org/licenses/ anymore. It was 
marked deprecated in 2017.

Best regards

Heinrich
