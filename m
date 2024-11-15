Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3313D6DDF0
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 10:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9B98933E;
	Fri, 15 Nov 2024 11:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qbcm44E0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5218934C; Fri, 15 Nov 2024 11:54:03 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D0689234
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso91459f8f.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 02:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731668040; x=1732272840; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F/XanCrWw4YHX5KXFiSLb3oKfqpeAYMwPUniucIiVBE=;
 b=qbcm44E0S9Q58kX+57ihf91m6Cnt5EI8UYufpagfRu7mhQCR2AbD0s0fofDCmV/TdC
 DjFqyZkqQD9iQX2S99U1X6QvuYS2ZngvfuCjzX/Cqc1+zx2z6AIbTA9uD2EgabLtfkXu
 trXNSNqcNiVZZ7R8KUCCwpLdvIMkshV/zqcQ9tkJnTHltQ+SHmJ5J7h6Z6yqDTi62vD2
 +d2vofhco0H7Y6R5g7jVpBwtFVDE7sUiACTvCHtk5W2VvTAcCN4HILpwSXdrA7n66QUx
 G30/Jmy3k3S9Fy5ruAWYq9Kd+z244BYiPiTI0sGb/gEZ4vac60ZdoMUV9TjI4PoDqsL3
 CX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731668040; x=1732272840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/XanCrWw4YHX5KXFiSLb3oKfqpeAYMwPUniucIiVBE=;
 b=j460U8nOb5NuqXuyJzfoHSxwkibtfQo9/kMTPL6QNDOsg6ed4Deo700i2S+u+8DbOW
 7h2q5BV1ET1/o1xr63HoP/P8I9YElELsTjv/ju4HTsQHN9YaYfp/EkvIXTu/gVBcFneQ
 yGc4r35TgkIWO3ESxwcknK+skyLhuNovOIJ6uzEJhZz3k9iceVUIZmpAYuoqMkeJhjg5
 bvMVdEHfCtDhAP4pxQWOFtCmoUploZE6vsXoTaE059mTPNGa757XwauWt3UZkMkibyv7
 /Dx4y948mF7/cNJpL6RTES2DF7/sHK+S3MrtyRnZvI+4ZzRn7J4EBr3mhiYRaRKBZqo9
 rb1w==
X-Gm-Message-State: AOJu0YwZ2F2RdrBSdFZbYteEOuBApReCaY3ds+lnwGSDkoVksBfm2rcq
 NHcyPWOP/2R8DCQbFU+G6g/op2eCbWxfos9BTgVwCPNZQvf9aWQwm3ulhysQy2Q=
X-Google-Smtp-Source: AGHT+IEKSODcN62KFDANg6gRdblDJ+TW9909ah3tlTf6QyuPKakjnz++iUrBDsDeHDJvy+114Jr0Ag==
X-Received: by 2002:a05:6000:178a:b0:381:f443:21cc with SMTP id
 ffacd0b85a97d-382255f3b48mr1486650f8f.0.1731668040070; 
 Fri, 15 Nov 2024 02:54:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c548:e170:2aa3:31?
 ([2a01:e0a:3cb:7bb0:c548:e170:2aa3:31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3199sm4034852f8f.22.2024.11.15.02.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 02:53:59 -0800 (PST)
Message-ID: <45113171-b97b-4ef1-9758-86a6d5adfd18@linaro.org>
Date: Fri, 15 Nov 2024 11:53:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Yasuharu Shibata <yasuharu.shibata@gmail.com>
References: <20241105120653.99438-1-jerome.forissier@linaro.org>
 <20241115001400.GO3600562@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241115001400.GO3600562@bill-the-cat>
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



On 11/15/24 01:14, Tom Rini wrote:
> On Tue, Nov 05, 2024 at 01:06:53PM +0100, Jerome Forissier wrote:
> 
>> Since net_test_wget() is testing a command and is in test/cmd it
>> should be in the 'cmd' test suite, not 'lib'.
>>
>> Reported-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>  test/cmd/wget.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> This leads to a sequencing error in tests:
> ------------------------------------ Captured stdout call -------------------------------------
> => ut dm dm_test_eth_act
> Test: dm_test_eth_act: eth.c
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10004000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10004000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> 
> Error: eth@10002000 No valid MAC address found.
> test/dm/eth.c:284, dm_test_eth_act(): -ENODEV == net_loop(PING): Expected 0xffffffed (-19), got 0xffffffea (-22)
> Test: dm_test_eth_act: eth.c (flat tree)
> test/dm/eth.c:273, dm_test_eth_act(): addr = NULL: Expected non-null, got NULL
> Test 'dm_test_eth_act' failed 2 times
> Failures: 2
> =>
> 
> Where it's fine when run by itself, but fails in CI/etc when running all
> unit tests.

How annoying ;) Any idea how to reproduce locally?

Thanks,
-- 
Jerome
