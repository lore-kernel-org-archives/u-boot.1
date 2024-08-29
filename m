Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF798C87FC3
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 16:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2689988CA1;
	Thu, 29 Aug 2024 18:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQQrDQ6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BDB88CCF; Thu, 29 Aug 2024 18:40:09 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB9A88440
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so7734795e9.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724949607; x=1725554407; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rIsvoc5gOZoFhTOiAYtKt+ShOaQCtxEK1xqE98i4EZ8=;
 b=cQQrDQ6PAU+IUYoGAO32Lql1YXU1q68aRbpX/+ELIbUKshPAGed5lVyubAROAzPuHV
 HOU5p0ONSjUjvdccqcdnDDaQPzG6JNaC81RfBKZUwMedIjPxQUSl2noJ3D/YtXHjWSAb
 6bzjIn888R5ayldpz0RLq75BexBAhobSye9CJ2OtgCO6ZMofCyJoFvGolrmeiu0W8f4h
 dkMnXIqdkcDg+CO0b8l2e7hSU9j1Rs5hP0mYXRnjejfuQ02X/LdreogSkW2BpeucJToR
 dFc8pomIfaOuPzYeptvw8a5JPn9EVMNhSkRaXqVGmN7N8K6z+SB0PC9pkD6TXl1p2/My
 z9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724949607; x=1725554407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIsvoc5gOZoFhTOiAYtKt+ShOaQCtxEK1xqE98i4EZ8=;
 b=tA+vKNHQaGwti0jB310Ppfnhn0UNgOsTRv75oDkhl1oR+G2TwVI0V0O1F7E4s8vh7I
 sVRkhT+8SaPiIMDCUs9hRBBpbWjTxBMZFCoknOOGAXIguuRiwCugVEOVB3aC9d0jTJUQ
 A/tQGcQ9saLJlwKzTcUNFwqkh/ysKLpIUV4gANtVQkr3m4WOColp6DFmX4ndqTw3kRCx
 1hHMZ+/WJSxTdllGcH2f6TdWdEQq2sBhxe2b9YaTfhqigHt4Mig4c/Hy6ps3ejd0e9gk
 VTRvag9Iz6gVcpOC8vwCbAzuOR8o1YBZjtqgN5zR13j0o0NcGVZ//Kwe1vfMb138YT8A
 Otdg==
X-Gm-Message-State: AOJu0YwNZNfzilcZIL09czCgSVhkihnOFIYRQggVzH6m3EswdBWlr7yE
 jHPFc/nqk15E8xSIvCGyU7T1dcxjN04Mpw4SOpdbZSClTXyKQJEjO4PlFa9T5Fc=
X-Google-Smtp-Source: AGHT+IGt+xDRYp2k6waEQ2d9IoW+Eew1/7KoIOu5+W213lzSwpjLink1AHumTktkkE1xCoR+sbBeag==
X-Received: by 2002:a05:600c:470f:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42bb01aa115mr28358695e9.6.1724949606983; 
 Thu, 29 Aug 2024 09:40:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:dda4:b3aa:27ae:d28a?
 ([2a01:e0a:3cb:7bb0:dda4:b3aa:27ae:d28a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef7ea08sm1820393f8f.68.2024.08.29.09.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 09:40:06 -0700 (PDT)
Message-ID: <1c7c2e70-aa24-46b3-ac3b-47c6dc9fde3c@linaro.org>
Date: Thu, 29 Aug 2024 18:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] net: fm: call dtsec_init_phy() only when it is
 defined
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <679e20bfd9ac3de6560e202f82452563b01fca7a.1724846454.git.jerome.forissier@linaro.org>
 <CAFLszTh87_wd-+XLe1EeXziMiu9p_rT-qfAgHg4PxGwhsAKUtQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTh87_wd-+XLe1EeXziMiu9p_rT-qfAgHg4PxGwhsAKUtQ@mail.gmail.com>
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



On 8/29/24 16:04, Simon Glass wrote:
> Hi Jerome,
> 
> On Wed, 28 Aug 2024 at 06:11, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> dtsec_init_phy() is defined only with MII so add the proper conditional
>> in the caller code.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  drivers/net/fm/eth.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
>> index 19f3f0fef0..e4ec769693 100644
>> --- a/drivers/net/fm/eth.c
>> +++ b/drivers/net/fm/eth.c
>> @@ -701,8 +701,10 @@ static int init_phy(struct fm_eth *fm_eth)
>>                 supported |= SUPPORTED_2500baseX_Full;
>>  #endif
>>
>> +#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
>>         if (fm_eth->type == FM_ETH_1G_E)
>>                 dtsec_init_phy(fm_eth);
>> +#endif
> 
> We really want to avoid #ifdefs in the code as they create different
> build paths. Can you use if (IS_ENABLED) ?

Sure.

> Also BITBANGMII seems liike
> it needs a CONFIG_ prefix.

I agree. I have copied the line verbatim from line 29 because the condition
needs to be the same. And I suspect there is another issue with the operator
precedence. Do we want "MII || (CMD_MII && !BITBANGMII)" or
do we rather want "(MII || CMD_MII) && !BITBANGMII"? I guess the latter.

So how about:

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef0..22025b6a27 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -26,7 +26,8 @@
 
 #include "fm.h"
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
+#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
+     !defined(CONFIG_BITBANGMII))
 
 #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
 			 TBIANA_FULL_DUPLEX)
@@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
-	if (fm_eth->type == FM_ETH_1G_E)
-		dtsec_init_phy(fm_eth);
+	if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
+	    !IS_ENABLED(CONFIG_BITBANGMII)) {
+		if (fm_eth->type == FM_ETH_1G_E)
+			dtsec_init_phy(fm_eth);
+	}
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO


???

Thanks,
-- 
Jerome
