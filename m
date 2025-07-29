Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17463C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3575382C87;
	Tue, 29 Jul 2025 13:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tgkWyGGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4CC82CFA; Tue, 29 Jul 2025 13:18:44 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D33182BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b783ea5014so1533775f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753787921; x=1754392721; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66PSssizo4dOeBKQjOMt4jZ7O7j3BG0qJWLDUjX8C8M=;
 b=tgkWyGGeT4HXI6hnur8Zj4/UOdownmKvHLXtAItn8ZIzPauts63uSwHwr0PIfINhO/
 sERdX+7nCpQKqi7D5qnwsalTj56aCTt6yR6c5WcYVfi3uVZ9FSGIGPRUjPj3WohtXdW5
 VWiWONZbYOJoXGZOYVjHDkF+eb50bZlIyXJOrYc8h42QCaZc8W1ptQB1nbSOtmRqhg08
 kdMxoCjIeUShJeaJd0MopRjO4Q4V3lSJVYcUeUcAHNNwYWeNoTT/R6qqwcVAMsQTg598
 DJEpP3XmWzGDlGCFBeVcjSERePTMss0kRbww52nsdU35BiFAIh8F/D2mgqWpurVw4oJh
 PPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753787921; x=1754392721;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=66PSssizo4dOeBKQjOMt4jZ7O7j3BG0qJWLDUjX8C8M=;
 b=GdetoBZGaCXvS+RYkkV+V5PcvPUThRC9wSLRXAVfy7Z+F5rd7NSmn3UnqgPvJTNIpY
 OBNLoHBYw00Kzsb3YzDyhwUEHRcAKFhtZD7KCtRMmrxMltg4XNvsCCWM3hcFVzw5HlOk
 9MNJCSAHx3HTlxHvD0zDiMYUixwxr8hdtaxnIUFpRuEB1JVC9z3G9RSabTOPyAeUPNHo
 n7aEofy28AUoQ4u7gsRm52AVzZUVzyhE3RoLvgzRXTkLLuwsYMAqLCPsVVbT0z3JoRHW
 wXp3ddavndxxWz/uoUi2ckDctgPyZHCUk6cG4JDhgIzi+r763FWDols/UKKdejTiWyCY
 6bmQ==
X-Gm-Message-State: AOJu0YxiF+xodJL5yrO7O7IHZr4FJ3zhOEPbe91Q8wfFQeLAHNuOVnx7
 Dvnow3skRa1qMtrPXoF2cMbVE0fBHjNA/PO9E+yGigqncm84ZrX7FugWQA0tdPBtX3E=
X-Gm-Gg: ASbGncs2jlEoUrk3+hjuxxK8hsXl+AfQJqCB67rmccmHxgP09juWIdTXaLP8iddiNdR
 kl74TPJRaCm1syQSKVuTo8+LRb0iRmlZFYPGsQgbIGrubRXsdPv7r12BqotseIJPIwRHsfcV4tv
 1AMuSvKCl1RocyR5Rm/bVQqHZ3baFgtWNM5Tt41r24NbmUTKy9efBWZu7QBIjMQgh1ywD0nTVmw
 pAr3vR1yQPVxhBHn7oDCZRl56ify51rlwqSykGLDV3hzQ1rgfW5vNHTN0hnQ/GBPKJLseS4i/M2
 I1SOX7+fUJK4WH7CcsnSXRQKwDbhwSBLpZc8DoqetTBb9D4K6MonSnr+Jm2+Hh/N28ScdDThowJ
 ifXeY/HDw9IfSdbn9tQbXL7I/KXAAzUx2/hOZG0NEj0omS2YQ/sKcyvUxpjHMr78Fi1DhWi2Qg2
 K7vg==
X-Google-Smtp-Source: AGHT+IGGXxa2s8dXz60EpIHRRSZ+QZDwdyKIh/XyTTSFg3owK8951X5P1BIDOJhtSVtMJs/JpM5xqw==
X-Received: by 2002:a05:6000:3111:b0:3a4:f6ba:51da with SMTP id
 ffacd0b85a97d-3b7765eda40mr9894663f8f.15.1753787920706; 
 Tue, 29 Jul 2025 04:18:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067?
 ([2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f31fsm186198585e9.10.2025.07.29.04.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 04:18:40 -0700 (PDT)
Message-ID: <876b019c-4505-43cd-9247-3a63991e664c@linaro.org>
Date: Tue, 29 Jul 2025 12:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch error report in drivers/misc/imx_ele/fuse.c
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

Smatch reports the following error.

drivers/misc/imx_ele/fuse.c:218 fuse_sense() error: buffer overflow 
'data' 4 <= 7

Looking at the code I can see that at line 198, word is checked to be 
less than 8. Later at line 203 data is declared as a 4 element array. 
Then at line 218 word is used to index into data which means a possible 
out of bounds access if word >=4.

There seems little point in increasing the array size of data as 
ele_read_common_fuse will only ever read into the first 4 elements of 
the array.

So I am not sure what the correct fix is here. Is there any guarantee 
that word will be < 4 in the case of word_index == 1? Or should this be 
an additional check?

Thanks,
Andrew
