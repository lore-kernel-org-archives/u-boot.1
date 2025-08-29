Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDFBCA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAC083642;
	Fri, 29 Aug 2025 16:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sima.ai header.i=@sima.ai header.b="aZMQaPfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 490FA83321; Fri, 29 Aug 2025 06:07:14 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382AE83321
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikunj.kela@sima.ai
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2489b6b6cbdso2149305ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sima.ai; s=google; t=1756440429; x=1757045229; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ACxECWBzdL8D1vCQWS/PL1/BC3RBKh++b5kT78aiSXI=;
 b=aZMQaPfk1g91ehStD6t3yzSytyjWR5IerJFWuumBTPd0CkFJlK1jPK1uISw5bzpbJ/
 Yq32o78MnJyi3jK1OJXN1jMrnhxEZFzaIy2VDw2woM6FI7sISQQKK+sA/TdRrBtq4Zp5
 Qb3RIk+gKjt0da/s04UqkufYp4H0FA24G7HCO6WZtLv3AlmyP2tk/ybP10b/DkXKTp0q
 stod2q7n6+65prjAL3u3nDXSU2EkRNbm4beNStZreulIKF0sbZ+9l9lUeEZD1HHuK4HA
 d+HIIx6x6WeTmbJH85Et28LecB6zNFU+RMy3K4yxKbyZvrhtMDEL7lmVi9UaNYGPK/XG
 uaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756440429; x=1757045229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ACxECWBzdL8D1vCQWS/PL1/BC3RBKh++b5kT78aiSXI=;
 b=fBdFjIXHQwRe16ak5S7gbsTxA876JrZ2df7pjZRG5gxWPA7jfzUVQnfNSCJQLX8cig
 cPDzMbpEX0skilfd6fkBdNsSAfPDT9RErlCztQX1AXQoNDHG2mM7hE5EvQkgbb3QEuS+
 0NvFGoUu6anIsI1ksF58tEk7hQfVuPU/W/gHXZdKkmzxXMhSU6FedRZJN/jFJaB3RrHa
 ON0CygN9DZOYEdvev6JFAb3Tpm1a7GYYPUhm6zIUoQ9Z9dg2Whnh16ZGPj/AXxZNqiqK
 c7mwjZUqDvPWveuI3yh8sV4esMYOmeLn+OnwHwPKfo4/v+VxWO3rxo8Ua2fzxRz94Rmu
 jMfw==
X-Gm-Message-State: AOJu0Yxlg0/Ac1IYNvk1UfwoIT2HmSO1Bs9Ejnx3VpKNPNIgtFbB7W/V
 /dxfS5uIocDa75aQPRFX+g3D39DMDhxFmI4tioCdrDuV8OrNtJo4jIPUhY2zOXN47Ps=
X-Gm-Gg: ASbGncsXXvyywtf/q9hfhkRcfxgeQZI4LJLlH78HLcbndjiscFkNZF22+Cpnn7rcz83
 lEEUL4sQ0Ne2FCTXe0QookO9SYEKr3OJ2OKtmumWjiokCbktnObZZRbICupZSbA96Af3axYYJm3
 M1lf/6u+zuUOvml7qJnW3F1oYKMvExRh9ignxG+OdM4gbYcZUqmh2b74iTqHAcQFjT+m2fEGdTK
 y8PLU1s96NjVYjrDOAn/0KZutxteYbQPl/8x4vosr4ZYzOI9DtHETJWSuKMjhUYElIaNfHzAyw+
 pamj+EyXnKum1pLm3m5UAvWiABmGz6jnY/YZRsGKQVv3VA3nRUk62T17h3XhErHUnfAFE3mza2+
 tPsI7OYYaOn2oApVccm3y7gkxp+efzj6L5ey/UCm41su42vE0Tg==
X-Google-Smtp-Source: AGHT+IGEjfXRwZSI6bc7GdjzQv9fXtGZrmww0F7nBmMQLEubxGk79FkzqZYEyU4cvO9EQBKlfL3xPg==
X-Received: by 2002:a17:902:ea0d:b0:248:ff48:8779 with SMTP id
 d9443c01a7336-248ff488908mr19120875ad.2.1756440429491; 
 Thu, 28 Aug 2025 21:07:09 -0700 (PDT)
Received: from [172.16.1.86] ([45.62.187.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da470dsm10603195ad.89.2025.08.28.21.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 21:07:09 -0700 (PDT)
Message-ID: <188017bd-5b9a-40a0-b510-f419336e8ed7@sima.ai>
Date: Thu, 28 Aug 2025 21:07:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: xgmac: Augment mdio read/write with cl-45 format
 support
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250828225532.1147284-1-nikunj.kela@sima.ai>
 <SA3PR03MB7187E64199FE9C74B131D52EB43AA@SA3PR03MB7187.namprd03.prod.outlook.com>
Content-Language: en-US
From: Nikunj Kela <nikunj.kela@sima.ai>
In-Reply-To: <SA3PR03MB7187E64199FE9C74B131D52EB43AA@SA3PR03MB7187.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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


On 8/28/25 7:45 PM, Ng, Boon Khai wrote:
>> +
>> +	val |=	mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
>>   		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
>>
> Replace the tab to space after |=

Thanks. Will fix in v3. checkpatch.pl didn't seem to have any problem 
with it.

