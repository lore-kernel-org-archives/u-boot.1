Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF25C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 09:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7A6803DF;
	Fri,  4 Jul 2025 11:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lVwmi99x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF485806D8; Fri,  4 Jul 2025 11:53:58 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB56801BE
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 11:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso385008f8f.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751622836; x=1752227636; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urGSUjM0fVbPWxWgu25zcjtyBVubKvToPx2n0ySO50c=;
 b=lVwmi99xtAlalD1cr+GKof1Zi3eRFBhuxAmRjyfBsD1M9dDZBJHCULpYBiu917JtoW
 bFtYzQLi27x+BvqT5VLdlhRM94dVn4xKlwLI0j7AFBkU/RfmxaVPO7Up6vef0nBMwinQ
 7FAcLDgtKjZEyu+MHm6GjYLpEnMIsv143ZeTrWiBKGZoZqnswVANLpwabiLnnknxls+Y
 2udINKpwOeZ+T8Cx+/mEXmdlCieJhM2YrSLigUgC3RJKMtQmyzWpMCkhJgHAPQ6l3xGD
 sDmaTCMD1L88B4iRiSCb/GCKesLrX8bKIIJ/K+KApK1rH+3k5xtb/ex5pEhpKipqkoCQ
 yIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751622836; x=1752227636;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=urGSUjM0fVbPWxWgu25zcjtyBVubKvToPx2n0ySO50c=;
 b=Q0IBhiHZWCyuPOLEbNmbg3Te3422ZH7KgOX/glzf4gX+t0D341QUKp/Fk37go++7V7
 Mv/gu39X9djadryQW5vnElr4+jZI2sMqIWvivRfPU8evUmEPhMprF69zBGfexQ5p6/xF
 I62Sr8Gzf5yRdOWCAPpPBvUpPwKWnfwXrNHH4RCjlMj8qE3WX5lr5ofk/NbJ4I40KYQu
 WyYoFfHp+3RzoojdUtVWlFt4MR1YKWi+w+yiQ0VByIr6stTXt1dJpxOcvwBIFnKDgxfs
 MN4B8jr9ZA1AygYjlzLmGBDdbkqKKWKMp5AiJB5LoY9tIku9JOd7VYyiIoTomMKOXFV8
 8A3w==
X-Gm-Message-State: AOJu0Yy3OORcsl2ES2Sg5yhByvuwAKjtrUtzEBWpy192KzlEUF8ES0AB
 ZjruvhfhiPCRAc/gkkusi4EsQRpXs0ne2k6Rkt6mMg/MOTFen2JqLYZtb5rHx/iSNUJ36jK+6D+
 XgF9O
X-Gm-Gg: ASbGncusk+eZuDsZ8I5BgTVO9JM/EvMUd+OmkpqdN9Gn9HAC2TL46mOgwFyUUkb9a41
 PPE+HJp3QGX197ChuC+B7W1FPI5/OxIyfM94sc6u59lzhKSg9+L61mHCAFnFIs4mvp3vVomMMKx
 rhWOLb3atJwgImW0c9cAEp4bIzjSSj2wFCS99w+rUdr/ZVM1IQon3IkCjPOK+pEGOUUq6RaHvtW
 bZ1iIPSubZ4cDDiTkeV5iKVLMteHApvC21P0WP9WOaxBvPGI4DVE2pNRIr0JfFueBk85WQE4nZe
 5LpfgH1ZK+KdLqaKpBTQ0A5W++fwz34adLdeO0tnNGgJVkAi1r3VNYcayJNxml/C1FRfzwlB4vw
 4mEVx3jxS1dKgNRMDYOuggvZPj2pRISs+jQ5LuuU=
X-Google-Smtp-Source: AGHT+IFN0jX8QBPgw/+JjZxwqqOYbYrJkJkp2gbg5lCGwFF71oaROIGZVZ218ZTXdbq3u3iJEtpdVg==
X-Received: by 2002:a05:6000:3106:b0:3a5:2cf3:d6af with SMTP id
 ffacd0b85a97d-3b4964f7b11mr1514803f8f.45.1751622836074; 
 Fri, 04 Jul 2025 02:53:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:2854:bc73:8076:c06f?
 ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bc5asm2044469f8f.20.2025.07.04.02.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 02:53:55 -0700 (PDT)
Message-ID: <3df65973-626b-4894-84bd-5a03a19032c2@linaro.org>
Date: Fri, 4 Jul 2025 10:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: PCI config read functions
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

Hi Tom,

Smatch reports that the callers of the functions 
(dm_)pci_config_read(8|16|32) from drivers/pci/pci-uclass.c do not check 
the return value for an error before using the variable that should have 
been assigned with the value read. However in the error path that 
variable is not assigned to and so the code can use an uninitialised 
variable in that case.
eg line 1396 in drivers/pci/pci-uclass.c addr may not have been assigned 
to in the error case.

This also seems to be the case with callers from other files as well.

Would a patch that adds a default assignment before returning an error 
to the affected functions be accepted?

Thanks,
Andrew
