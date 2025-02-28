Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51158C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FEC481100;
	Fri, 28 Feb 2025 12:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sBmxzHPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7598110C; Fri, 28 Feb 2025 12:42:09 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEF280FF0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e0505275b7so3109202a12.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740742926; x=1741347726; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIl3H4txFIQK/LgYUVrwX2EGFIhI25ORiBQ+u9ybucg=;
 b=sBmxzHPQNW8dQAyDehURKpSGx1mf/RcL98KFobp1XKCWia1BIcGGqxdawJbosQJJja
 yqDEvM8oSLvlb/HOG8ucFzqOneovCYlHeRbP8UpPY1Favb3Z9i145FttDaC/AxlOPL2r
 Gz/YgwQIhMqR3gPIfwkM+wiAP3dGHD2xOO5wGH5bk/U7IlVW7cdKzfcZNhLHnRglvTQ5
 MLVNcPuSRKb2x6KHetmBfCV1rQwjuymb1CKT9oTTQ9Fn/0ynAPZotwtYPGLxrr1+88rA
 4xm4H39miWLw85YibYY5kuyQXswAWMdQb3Jom1dc4e0Cq5czStuiUCdBEgqFDnS3BozS
 dAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740742926; x=1741347726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIl3H4txFIQK/LgYUVrwX2EGFIhI25ORiBQ+u9ybucg=;
 b=IJ0y9lazNoZvnEfzp5k4RS7vZX6gGdV2T2/V83HW3o5ffPusW075UpgkU8AsX379Di
 f1FtugCZwA2Q3FDRO/cfv8lBbhQdEwoYkfANj+row17Uqa0Q4YmpLt2PKsARFdIrz9RG
 pwZrJtbqzggJEEVKNuWnzicaF3ewTNy6gSkzSPSjo2HhpozrN6Q0Gs1YYM37kyIYrfad
 rfwFtSbL8lpijCVdKUxIpnwnjw0GFu1oaD6DCUcjRvdGmumD7OmfhwpXljgwhMzy3EMQ
 woUHMdWAv6WxHClDAuReqp9DzhcCcN0z2YbljwPgC+BnMtgdg2wTNqv6UFDEHTVyfBUg
 MDVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCMe2SJ9PXBsdsL9uejMydm3Rpa7ydZ/+vR0refTdBpsBGdCQU4cacsEexc6245fa3OgJFt7s=@lists.denx.de
X-Gm-Message-State: AOJu0YxS36kFA9Et2pFCrQgmHYiRGfDrKE6wQKGStObv0AIERVW4Llhv
 meIliuIfPqNO6eyRwpOh9ffyd71mvPH10H5CtPi9XAZrgdZVbuBf68JP3EIoRug=
X-Gm-Gg: ASbGnctTJHZlEYMlXxeyD7hxG1hQuamad7MpQu6X05O5Qrs8CNeBNT8DpUilTTrNcgN
 BGJtFja77aV0bdsrLLFbpb5S3xofFv7yZDbfMiCYoyBvzlaDjzZULCRyXorz9+jP5uZyttA6mub
 c/FiiHtR89rfXAb9sBrnXH+//tybXdqwZqX5Jd+cRLeHF2qFl5H7AHGJGZu7Ev3IPgDnZVpwuQU
 7lV2lwEK3NkwBs0gtBbIelZev48KakFy5ndquZDS+X+FxBdz9/QfNtdU+kr2+ArURLxP0fK5KnQ
 s1VhsPt01fBaj+WgybvYzh5YALTKIGmRlNcVMkwcL1zcuCm9UfIeBKJgCMKLM9K6LXizhVQ+3Ns
 Q5jFLpQ==
X-Google-Smtp-Source: AGHT+IGeCNEQb3XaJJbVa+ECm3nRwXT53LY1u1YdCg8NbEcAdwM1MXrFSNyoI5FOjTm03FbxEHVw/Q==
X-Received: by 2002:a05:6402:2813:b0:5dc:c9ce:b01b with SMTP id
 4fb4d7f45d1cf-5e4d6ae8b21mr2264991a12.8.1740742925818; 
 Fri, 28 Feb 2025 03:42:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3bb5abfsm2355026a12.35.2025.02.28.03.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 03:42:05 -0800 (PST)
Message-ID: <b4aa14d8-cfb9-48f3-a215-b96812465495@linaro.org>
Date: Fri, 28 Feb 2025 12:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <20250227180623.GI2640854@bill-the-cat>
 <4a1222e8-ef18-4753-9870-b40ddf35145e@linaro.org>
 <CAC_iWjJJe2f7a6ckjL0XDGmJA6PqtOTeqTkjFLNOGkVM535a8w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJJe2f7a6ckjL0XDGmJA6PqtOTeqTkjFLNOGkVM535a8w@mail.gmail.com>
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

Hi Ilias,

On 2/28/25 08:40, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Thu, 27 Feb 2025 at 20:31, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 2/27/25 19:06, Tom Rini wrote:
>>> On Thu, Feb 27, 2025 at 05:09:00PM +0100, Jerome Forissier wrote:
>>>
>>>> This series adds support for HTTP server authentication using root (CA)
>>>> certificates.
>>>>
>>>> As a first step, the wget command is extended to support a sub-command:
>>>> cacert <addr> <size>. The memory region shall contain the CA
>>>> certificates. With this, it is possible to load the certificates from
>>>> storage or get them from the network for example, which is convenient
>>>> for testing at least. The Kconfig symbol for this feature is
>>>> WGET_CACERT=y.
>>>>
>>>> Then new Kconfig symbols are added to support providing the certificates
>>>> at build time, as a DER or PEM encoded X509 collection:
>>>> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
>>>> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
>>>> command as well as for the builtin way).
> 
> [...]
> 
> I don't know if we can do it in this patchset, but in the future, we
> could store the sha256 and the CA certificate path in a U-Boot elf
> section.
> Since we will soon have .rodata section with proper memory
> permissions, we could automatically download the cert in mem and make
> sure it's valid.

That's a good idea and I think we have (almost) enough to do that
already via scripting:

=> wget https://curl.se/ca/cacert.pem
WARNING: no CA certificates, HTTPS connections not authenticated
##
233263 bytes transferred in 96 ms (2.3 MiB/s)
Bytes transferred = 233263 (38f2f hex)
=> hash sha256 $fileaddr $filesize cacert_sha256
sha256 for 40200000 ... 40238f2e ==> 50a6277ec69113f00c5fd45f09e8b97a4b3e32daa35d3a95ab30137a55386cef
=> if test "$cacert_sha256" = 50a6277ec69113f00c5fd45f09e8b97a4b3e32daa35d3a95ab30137a55386cef; then wget cacert $fileaddr $filesize; fi
=> wget cacert required

The last step is currently missing but trivial to implement. It tells
wget that it must not do HTTPS without CA certificates. So if the hash
doesn't match the cacert will remain unset and wget will error out on
https://. I can add it in v2.

I still think it may be a good idea to be able to embed the
certificates themselves, because for some reason the CA server might
not be always available or we may want to avoid an extra download.
Perhaps gzip support would be nice, too?

Cheers,
-- 
Jerome
