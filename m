Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D6AC52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D1588B07;
	Thu,  8 Aug 2024 18:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2bE/yJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF9788B07; Thu,  8 Aug 2024 18:41:11 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A4088481
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so1379839a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723135264; x=1723740064; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gPDLdhg+C4di9GA756LmTYp+6hHcmMCvfxvGTOr5u04=;
 b=n2bE/yJ9JcMt5zXCMB33+e6FFS+zTGBrk3eXc+qeFEBAoU5v1pEXKget02y7UT2/D2
 D4iDrdIGr2+9ddZWZq4eRi3JbQ46VMquVrzQFgu8YBj2o49YOBNVAAqpusmc2K85E+Pw
 XBZ+VioRnZfGiERA+1G/fZ5OZ37Dv44NhBNmqVqQv428Hqtugv6J5npZUFIcc/0FAgf5
 v4vewKe2jyuwv7q7yUgQS9bmcYXRvqqysVIaImnBRMLyH+jQ+aEcJE8mrh7sN2GlLej4
 gqgL7dGTf3ssk2H/6adIyUDo72go3HsOfIFyynFChjXgktuIEfWAJvcJ74fg5B38K/ew
 TbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723135264; x=1723740064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPDLdhg+C4di9GA756LmTYp+6hHcmMCvfxvGTOr5u04=;
 b=wNMe63SuvfTp+RAEiXdpl+eB7CcmWERTwddN/9r84VaiPdaXgPDro5bRmKFwEqBh7A
 gYKsKgP8NI2p6Bnf75vV65M14k/NhpnKTYsb/x0LPaIoXoA3FmgnF8c26Qu2dgBM51C5
 xgtD3VY1W7aCDOF32wjfTgwVTKhFesgWdHVunA0o3Iom3CnCwcwrm8FE4fz+RKxdqAz2
 c1Gz2jDcZJ8BonZwHZm++RIEHogt3Apyjivy3zviZ6ecIRoJWAtfi3/YfixzyFfc6sBc
 jxz8gsFPsmGLH9kBk4li4hQrb5cJYTYp7K7AFYFZyfjjdgd5VWKmEfJqnTzCC0FwXbd0
 4QgA==
X-Gm-Message-State: AOJu0Yw2dQ2Q+n4VrwIMFaRPYHz3id/VuhybT7+Eha5wkhtOQ0tGrSgM
 ICxvTsX3UjfOw9E/u+XoY6YIbVWgVK4jT8Wdz+VzGUew3JxROp42Wxwe/cT1BWU=
X-Google-Smtp-Source: AGHT+IHs7z6UM5er0Xw08VMLFF3b845KrfFWyMm3iDmsm8b0WOFQyzD6rqOKRPSPPxl2zznHDfJWFA==
X-Received: by 2002:a17:907:7f8c:b0:a7a:b0a0:ebdb with SMTP id
 a640c23a62f3a-a8090c81d36mr189634166b.22.1723135263825; 
 Thu, 08 Aug 2024 09:41:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830?
 ([2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4545dsm759150666b.124.2024.08.08.09.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 09:41:03 -0700 (PDT)
Message-ID: <2a23d370-82a0-446e-8ab5-00fa9005fdbf@linaro.org>
Date: Thu, 8 Aug 2024 18:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/23] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <20240807204400.GJ1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240807204400.GJ1626301@bill-the-cat>
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



On 8/7/24 22:44, Tom Rini wrote:
> On Wed, Aug 07, 2024 at 07:11:44PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. and
>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>> so. With that it becomes possible to fetch and launch a distro installer
>> such as Debian etc. using a secure, authenticated connection directly
>> from the U-Boot shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
>>
>> Prior to applying this series, the lwIP stack needs to be added as a
>> Git subtree with the following command:
>>
>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> 
> For v9, I think it would be good to do a CI run with NET_LWIP default
> and seeing what fails from that too. There's a few problems still
> leading to a lot of failures, in that case. Thanks.

I pushed my branch to GitHub [1] and there's a failure in the
tools_only_macOS job [2]. Any idea what is going on? I tried twice and
it failed twice :-/
Om my Linux machine, "make tools-only_config tools-only" works
fine.

[1] https://github.com/u-boot/u-boot/pull/635
[2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9105&view=results

Thanks,
-- 
Jerome
