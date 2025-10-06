Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D26CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 12:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5B3835B3;
	Mon,  6 Oct 2025 14:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CsTV6bUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D118365E; Mon,  6 Oct 2025 13:59:10 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6385802C1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 13:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so4373565b3a.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759751947; x=1760356747; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ep9j7kF0pDFSGsReWQnkCCUBuGSgMxb9NziIwoWCUOQ=;
 b=CsTV6bUvL3l5LlNEU9lrg8AMMHE1j3RkrlHxfIQnWNxh9bq4WH/VpGqUEj/XefCV+T
 HLOZO+jJRDIhnWIHgV25i80thcxWZgXnDGz8FY/wVOwByTdvVtJS3i8TM96ROTSmA9sI
 unwlt7g0hxcI/M7rV2HzCXVZOnKSV4ZIe+9xYIeuQ2+1UJ/EB+fNQdv5W05/y7Q7AS14
 ytIyJ/yD/u/iCi0cGYAf/vTopFe1jUHnJ9rxCu0T6TZuDvlQSj57UwcgeDW4uC4LabEp
 rd1wCbBJgLm3T6UB0wj+hgomhWf4cCDWtObiE+rzbFW52dAuw807p2eoX/FMDrtzO0eL
 huZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759751947; x=1760356747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ep9j7kF0pDFSGsReWQnkCCUBuGSgMxb9NziIwoWCUOQ=;
 b=ehQctu1P2zZtkNXH6/6WpCcngipJdN69EeK3rgDpf3/2d21UQ2IIjA+XL0ALWnoZQh
 OhO8LXN33qlsfaqto3/nRb8rhoM/Ekdd+ucOVwpyui/DUyd96cEfpD20K8Zl/k5O+j1H
 J20sl2OjyIFSZSVseui1gokOfsUNxbyUp+5keOs0dbOhIK7EJ1h0tNgdYY48Mo8WGwoX
 y8+QdKYyrxwkg2x0KGsjai+x6zcOegykOyNkRH/J9YAVVDxinM7gg7TxriKJduXTLv4F
 Pskm27HRMuDLzI31lyeakfiXNIFdmxRi67whyOs5blaQ4s1kLOjKP4sj12yuie14OlXL
 1GAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfoMHhL5P4RgnLq7eM+LVALmTM/idfyBHRyKzsLlW535N/4zED1IWjN4dapl4ZUeO+txp9FOQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyau4RF97Xh0Ul5eu6Rgw5z2DLcsBaFy9TCDnnh8wxrWGad0CXp
 NyX3hyhoIJP6caUA4iG2TUr2vJZCPfcG2XCbNINxol6JV0XwggAEaoUR
X-Gm-Gg: ASbGncsviADx0C0mg79QP33Yy9CZapXym/8cwcqgGyCoQFDnUwHqvsKAGjFLu//o72k
 dMrqslU9d7byDd6uNZG4QtsNydmiIk2J2xu7cG7AqAtqyxZb0ExF6zHSJkugP+oLGZjyeFEqesT
 qjiOGYN11jBblzsFNv7k67CPgJM4L5XNz31cQy+lAmoTDIxTeeVCH+9T/BWUiwxw1nBXMNRPC2a
 6qno3uJ2upsI7HrBskiMRiIy+UI4JxlKvqEBu5IAHl7b02akTlB7ag7O8SLoWjU3I2qvGmsMMop
 9XIQpbqq++tm71GGFOXUfQu86YW9BETJJIhC+5v5xwGz82g3035RKNbxgViaZN448xwZzZszSI7
 P+0W1TS8k7htgUy5pqmzDXnbffv4jEqYKlmNrcH45Ct6TBIB16bs3387bXz4NqfS6VVSq3/IJr5
 lBl5xDyQp/bDBvmFT24a6lrI+EnQ4Lc6HQ9nDkEcWI9w==
X-Google-Smtp-Source: AGHT+IH8myyff6+PhYY17k5HZvDFFf/qL6KDg7R7FG8QYnH+3fey+yk9/0oT+1S1j5eWKxSxvdH1/A==
X-Received: by 2002:a17:902:e787:b0:27a:6c30:49c with SMTP id
 d9443c01a7336-28e9a5663ffmr146235875ad.27.1759751946971; 
 Mon, 06 Oct 2025 04:59:06 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d12bc5asm130014565ad.55.2025.10.06.04.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 04:59:06 -0700 (PDT)
Message-ID: <251a26cf-fef4-4d20-a278-881ca31ddb97@gmail.com>
Date: Mon, 6 Oct 2025 19:59:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v1, 1/1] net: phy: add paged PHY register accessors
To: Marek Vasut <marek.vasut@mailbox.org>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006044405.30376-1-lucienzx159@gmail.com>
 <4fa8531c-e6c2-4a3a-b284-86c5bdd94530@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <4fa8531c-e6c2-4a3a-b284-86c5bdd94530@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Oct 2025 14:52:24 +0200
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

Hi Marek

Marek Vasut 於 2025/10/6 下午 04:18 寫道:
> On 10/6/25 6:44 AM, Lucien.Jheng wrote:
>> Synchronize paged PHY helpers with Linux v4.16.
>
> Why such an old version , current LTS is 6.12 ?
>
I just meant to say that this patch was initially included in this 
commit. I'll adjust the wording here.

For the next version, I will write the commit message: "Synchronize 
paged PHY helpers with Linux v6.16."

>> linux commit
>> COMMIT 78ffc4acceff48522b92d8fbf8f4a0ffe78838b2
>> TITLE: net-phy-add-paged-phy-register-accessors.patch
>
> Please use the standard abbreviated format with 12+ letters SHA and 
> commit subject -- example: e37de002fac3 ("Prepare v2025.07")
>
OK, got it.
> [...]
