Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C73E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EBB89409;
	Mon,  9 Dec 2024 16:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="keJ6AbOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7D3896DE; Mon,  9 Dec 2024 16:34:10 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F07789409
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso1270111f8f.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733758448; x=1734363248; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sPKH7wLl/SpyCSI9mqpu6YjcY/yCWnb5+yK7HxAJM54=;
 b=keJ6AbOROTc3grmcuNUQTIadQWLzZZ8lM+IKI7spe0UrWQ9KAFDUF0VnB5wlirfguj
 amgJons1Jt5fgDsUVb+CzgVQsJN5GwbJF3n7uvE4ORtYIfNd3AjapQkaOXn+Sx6ck3s3
 4bSGMtsrFU74WzvD8kpkuW5ZAwpbT5kbSdtLYQ68zAOSAKO1C0nua7SV2r+Pl55Jwezd
 gOE1iQqS2i1OjQsM7A0a8Sp4HxuUaBrxAhwUPdJL+a/OTaOFhTi4leVtw1psOcLI9gbA
 JQUvFBy0PostcVkpC7YgNJfe8zIXj2QD0J+7h1Avuq+V+baW4zBDFzn+BUJRCGL0NH2B
 CCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733758448; x=1734363248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sPKH7wLl/SpyCSI9mqpu6YjcY/yCWnb5+yK7HxAJM54=;
 b=tUuCecD8ebGa5+2XgwQhB/zQcYI/P2UgLnj58eLLVdbOVtnHklBfx16BdMYwalYe7o
 A2lTiWNP+bF6m2662VTpBuI84dH+1sTExXP3KlI+HTgVV9gZSnVR1faX1hniTzoOBsYJ
 h0JJNGw5Jkfb9n7Q7ipBy1OPw9psRQTns846AYxvQV9autxTZm6SpfGigRnfW96Up8Fb
 M75a47IiuHdkPddYbesgt2uXDYxngJrvw5gxBSP1hVS7hTkSULA4OUf5P604nyz9yNoZ
 VgFL177IDNivtisNyI0cJxMsDCoXrBBji4lQtf2zwupwmnDfD5YWz8ynzLd8gY54imU/
 NrfA==
X-Gm-Message-State: AOJu0Yyiw1BOjMH+AzFa+JJ8aHn8xok8OwV/Tsypwxpda2EZMD7c+/Ry
 HhB5Fh0dbwxPoEVY+697I/Y6Yppqlwy5FEkFnYH2renvslczLauQGub1XHelSwQ=
X-Gm-Gg: ASbGnctCmZEjikqRxsvKJljztfzotoZc9vNsrbOXkuMUe0E7SeyaIBksTwhuQiF04PX
 6dwSsDMIFfvNMet4TmAVA5tK+DNn3JIT3WH8c/FUOXWay59FWbMhiiVP0MfGAJnOOZNFJnwqHN9
 dblkAboW2tMitvVzLcbEikt6iwW+qfLf3w4mZjpoOj/+zuJ+TEVjj49A0q1CFDFK384wK+7dL8Q
 1Xj01/4K7yC1u/0pTa+nFHFNBqYTkr7gnq4fguhoY1t8b8QTHAyiNy/4nL+DMJ/xwArLaFOKIQf
 Tx1z8YsmFEWzlyD8PHsOf27Gz6Rlxw==
X-Google-Smtp-Source: AGHT+IFItd7Xnq4/mPtxE1mfc8ZekXWLCUAQ+pHGVgj1qM+b5MudkV+vRLkrUN3TMVVf9YHQB2bWUw==
X-Received: by 2002:a5d:6d82:0:b0:385:df73:2f24 with SMTP id
 ffacd0b85a97d-386453fe925mr712319f8f.39.1733758447921; 
 Mon, 09 Dec 2024 07:34:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6246:ccc2:7b44:1143?
 ([2a01:e0a:3cb:7bb0:6246:ccc2:7b44:1143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59cc26sm13206628f8f.38.2024.12.09.07.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 07:34:07 -0800 (PST)
Message-ID: <3326fa5a-0258-4870-972e-f764c957fb0b@linaro.org>
Date: Mon, 9 Dec 2024 16:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace: add support for "trace clear"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20241206102917.1095207-1-jerome.forissier@linaro.org>
 <20241206170716.GU2457179@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241206170716.GU2457179@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 12/6/24 18:07, Tom Rini wrote:
> On Fri, Dec 06, 2024 at 11:29:16AM +0100, Jerome Forissier wrote:
> 
>> Implement a "trace clear" command to delete the currently accumulated
>> trace data. This comes handy when someone needs to trace a particular
>> command. For example:
>>
>>   => trace clear; dhcp; trace pause
>>   => trace stats
>>   => trace calls 0x02100000 0x10000000
>>   => tftpput $profbase $profoffset 192.168.0.16:trace.bin
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  cmd/trace.c     | 13 ++++++++++++-
>>  include/trace.h |  2 ++
>>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
>>  3 files changed, 47 insertions(+), 15 deletions(-)
> 
> We have trace tests already, can they easily be expanded to cover this?
> 

Sure, please check [1].

[1] https://lists.denx.de/pipermail/u-boot/2024-December/574457.html

Thanks,
-- 
Jerome
