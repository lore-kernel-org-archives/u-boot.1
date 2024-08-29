Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA91C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 16:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30308855C;
	Thu, 29 Aug 2024 18:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h9cXICfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED8688B23; Thu, 29 Aug 2024 18:21:36 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2195387F3B
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-371936541caso540071f8f.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724948493; x=1725553293; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=grOKaU0YwfxkPbb2xHlOiI4aMtC7Hr1zkkQXngpxKUY=;
 b=h9cXICfFMe7HWZicGSVtAYIMH1tIJXm0LWd1T3UpvyYfsKsjh3r97+D2oKduytPoUv
 7gpA1w7Ncx2HWBAw1As/gqXlI2Y+X9fcauYtm15fZbeRorMnMa1wIkX91uGeD5j3scsY
 jPTEfVx189WFGimFrnvcxKUMqoOD9Vykqeen/s572bp+FJdd7Lv2ga1FexiryBVVGbr/
 PTOh7m7hZxm+W4QMLp+Hn8DMeiV2x5DVX5JhBi50cPejzaMsbxqfa1qoaz2D5ysyDX3/
 57RLoekOBCWsNcXBTcqwcs8lyMn4XOXRxw0Nr99bWp5FeJ/Ew0OrSbnpi7g4OcDIgunr
 94tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724948493; x=1725553293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=grOKaU0YwfxkPbb2xHlOiI4aMtC7Hr1zkkQXngpxKUY=;
 b=Uumh4U+AkFHYylDKDPs4GgTZg7yjGGOgfUOsYOGwAk/BA9447Sd+V0F0smnMD/hXC7
 m09JtchOWKMjfiN8RRy/GIF9Dym8NokV3DA8OuQxs1Wd7Ur6muS8HBRBAahByAlC3IN3
 2uQML8lQtXdQ1aF6ry2xkZYL/NmfNviaQKtSUxPW9kcl3sN5aiSiNNoA6fXzatwZehUN
 nOLngCkONuvNdcDTyXZFGDdIE+0L37LtOPB0un/eAWHaei8CvxCH0H1Rov9SBFia5USt
 sosmN40kvRCWmo12PCyE0qaAOCvozrqaYJ06qBOwWGdmefNg+ikcep6Ie7rQrFP+b9j3
 auBg==
X-Gm-Message-State: AOJu0Yz25SKPTvGdW3EbK7gqhMekvAtfpynrobAQfCHNQFLL/tLq3mHv
 VYApv0eIyqfcrKzNc1dNLKVxcRRl6Z/lyJX7kkyfV7NivxABTIU4SPdEV/i08vs=
X-Google-Smtp-Source: AGHT+IHiLWjskJndSNZR9PRxSzkTQpHixtd2nb7gKCQqfbioVWim8RoA1rzXnkVRdqczNkEU1EJcZw==
X-Received: by 2002:a05:6000:e12:b0:371:913d:e50b with SMTP id
 ffacd0b85a97d-3749b55260cmr2268191f8f.31.1724948493366; 
 Thu, 29 Aug 2024 09:21:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:dda4:b3aa:27ae:d28a?
 ([2a01:e0a:3cb:7bb0:dda4:b3aa:27ae:d28a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df7c5bsm21620945e9.23.2024.08.29.09.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 09:21:32 -0700 (PDT)
Message-ID: <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
Date: Thu, 29 Aug 2024 18:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
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



On 8/29/24 16:05, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
>> NET_LWIP so default to NET in this case.
> 
> Sandbox needs to support NET_LWIP.

I agree in principle, but AFAICT it is not a trivial task. Does it have to
be done in this series or can it be dealt with later?

I would need to look into this more closely to give details, but if I
remember correctly the sandbox tests expect a precise sequence of network
packets. For example when doing a TFTP tests, it expects an ARP packet to
go out first, but when lwIP is used the ARP might not go out because the IP
may already be in the cache. So the sandbox is definitely not a black box
in that respect which makes things a bit more difficult.

Thanks,
-- 
Jerome
