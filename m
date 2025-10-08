Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5CCCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69008393F;
	Wed,  8 Oct 2025 11:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M9991atU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BD98398C; Wed,  8 Oct 2025 11:20:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1E2838AE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so4989985e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759915213; x=1760520013; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vN1o7M0V3X9V65f6DoeWXXLnr7JosKEyin6DriQGBtM=;
 b=M9991atU9NMN+Hz5tPPzlpKS0fP7D9/dEP782RjF5xv8cGkCzUK1wTr6jJu1xRP7Xl
 7FkgInnxiCQj7BW4Cx+76ZpOdlGNfc1yMk20JKHITTT0ZE0Ll9p9fxQPr09QmRIHsOJn
 +/RDCehhvxi6J/W3rChXtm4UepBhnXCmuFsLbOeDWADf4i1K4KnUhyqa9EONCg2Envwx
 lQ2/cRFfkN1owJYLdJrxdeyftdpDllxAxIpTn5/UoWLCaBWPn+bM1YoHc0WnY71JGu7L
 FgHr1r7Sdv+mgH4qJiTjJ/eZUCUqKvo0wSnEJg19mbr4o3EYqpcRfad5et79zsKyK6Qs
 M9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759915213; x=1760520013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vN1o7M0V3X9V65f6DoeWXXLnr7JosKEyin6DriQGBtM=;
 b=uCmbf0zjhRW7+BpCTPPwb2PriBqArFJ/71F8MuDpwozxV/KGw8bpHvY3L0tOuH7hbx
 rjoHmQESfDsTh9/WXt0mLnO/T4IBgmQXXwt6tlClHgCfZcy5AiW2Yiczefe/wMG90kVw
 ilIrupqcIAbRp/q7m5y0z0SW/cKRlFTpEbWRMSy6lm2ZMP4I0+hconP/gzF8wvUKukja
 ahPkyE3m8Lvsi2wyn/wstxsdKeRtz4my/0KWSQ+dMRkdcRj2M0mCPTuSigc4R6Rg6GZs
 RKYQILbKxYR9PMUUf9fbDkGIRHVAdScLffvJUpSr75s75XCDTRJFjr/RGAafLej61wzu
 2m4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSXY8/gREhEQ4XFTmgwp4FzGcyGOYzJx0x6J+ZwPOYXbQOJECAVcBGdZDcFZjKxXcbzN8hgcE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+i9INb/Rtp2X7KRuSkMmHW+e9UBHHbw5ZRGmCFneQWJ34NutZ
 l/+ZNCWDgkwPgQJpWCya1ZJstCWKpQnc1bRYTOfs7HeKs20WVmbnHlAmt3yxLznBX8c=
X-Gm-Gg: ASbGnct2a8Ib+Ay3baR8ikC327LoD3u3pAEMbAKN3/7Hjs+8jd9DkfPOAP2XwUkUm81
 4pP1fP8Exay7cXD8Iwyc94/qkY1IXNo36fkFO+qrHtn0mZLtcByzF1zGJQq3WOGmBsKZySCpauQ
 x0AIEoGqfA25GXU9tZkjslLgsODNJpRfNIEO1W4NOBVJAFOAnod0ykrSLUTH3fJin4M0exI2gGR
 zN386g8AREqzQcYqTFYOIWm2DvU5cjAaWH2GevYu3qq7krgxqMec2OE2JeKsrWT/s4S9iPCPQiV
 tXp8YRG8qrM7fmjmtvRLloBO9EtJto+oKHxivShb7qFCUnJXJB7B8LH/3TA2k4+a00e5vFkNrK7
 U553T4WLENqcIVXW/gIlX7pb57KpBTnFQXyagaTvw7zE67nQd4z/U2zF9a5a9icEArn4H1HV1kA
 ==
X-Google-Smtp-Source: AGHT+IGeKXQ1OXACpckP4NHQO85gu+smvu2KClZJdy7W74y1wXdf79M39r1oLsM5KWuAvpkfyw0IqQ==
X-Received: by 2002:a05:6000:2504:b0:3eb:f3de:1a87 with SMTP id
 ffacd0b85a97d-4266e8e4483mr1584858f8f.56.1759915213048; 
 Wed, 08 Oct 2025 02:20:13 -0700 (PDT)
Received: from [192.168.7.93] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm29147055f8f.26.2025.10.08.02.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 02:20:12 -0700 (PDT)
Message-ID: <f6fb56e3-f1ab-432a-8d08-89bdd63bd8df@linaro.org>
Date: Wed, 8 Oct 2025 11:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bootstd: make it possible to use tftp for netboot with
 standardboot
To: Tom Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
 <20251007234906.GA577000@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251007234906.GA577000@bill-the-cat>
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

Hi Tom & all,

On 10/8/25 01:49, Tom Rini wrote:
> On Wed, Sep 24, 2025 at 09:41:41AM +0200, Benjamin Hahn wrote:
> 
>> Add the option to load the bootscript with the tftp command (static IP)
>> instead of the dhcp command (dynamic IP). For this a new function
>> tftpb_run similar to dhcp_run, is needed. The selection of which command
>> to use can be done with the ip_dyn environment variable, which can be
>> set to yes or no. The ip_dyn variable was chosen as it is already in use
>> on the imx platforms.
>> Also edit the bootstd doc.
>>
>> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> 
> OK, so this fails to build on qemu_arm64_lwip (and a few other lwip
> targets) because tftpb_run was defined just for the legacy stack and not
> lwIP too. But, and this is a question for Jerome too, why isn't dhcp_run
> already in the common network file and instead written again in
> net/lwip/dhcp.c?

No particular reason. This must have been an oversight when I introduced
lwIP.

> And for both of you, can we perhaps have a common
> function or functions? The lwIP one does handle tftp it looks like.
> Thanks!

Yeah. IMO, dhcp_run() should be common, but I'm not sure the NET_LWIP one
is correct TBH. The comment "Assume DHCP was already performed" is
suspicious and I'd rather use the NET one. That is, move dhcp_run() from
cmd/net.c into net/net-common.c, discard dhcp_run() from net/lwip/dhcp.c,
and see if that works as expected.

Thanks,
-- 
Jerome
