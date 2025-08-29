Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F994CA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 10:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53A483542;
	Fri, 29 Aug 2025 12:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=munisense.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=munisense.com header.i=@munisense.com header.b="CMRpUDE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7517183559; Fri, 29 Aug 2025 12:10:42 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9603834AD
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 12:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=munisense.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gijs.peskens@munisense.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afeceee8bb1so279854166b.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=munisense.com; s=c12e0d22-ac12-44f1-aa93-b49ab5265a0e; t=1756462239;
 x=1757067039; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/nepWcxDdBafd8+J9hhnKfc87wQ6nUzFBbbiZGyQ80s=;
 b=CMRpUDE54XilXBytZFfuQ822NgXMZLE3iyj3BNqJl0SYolHZnUQ8OMAG0oqrj7NEu5
 xcMwWKQB7C/sZGSsvYGDkBhZDqBbmUUkqYd9nyQk1JXLFMhK7Vf/yeL1jz24b/uv7sB+
 RCKev15HqAyiEPS8QzxBGqUE6MaG48AJ0nn59QVMMQN50VXpHXbSNdQfI/HL6TtxJMaV
 BNUpsqiEXOSLuf+IhrC3NIgk/YUJR2kOlTXCAl3znTKZrfATAVCb0MY23STa7Ll+jC6x
 QYu7a6yHtwUjJdLHqO3F2NKKGx/Y9te/RzzNJ+/+EQT18m2qK9fVWgv2QV0PwT4UcWBf
 NLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756462239; x=1757067039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/nepWcxDdBafd8+J9hhnKfc87wQ6nUzFBbbiZGyQ80s=;
 b=S9IbOz82EOHJo+ERulzn2BfBc8PXD3KH/c11MFI3Oo0oLU6qrhdWXq9O3hntYooXzN
 MhGq3nE1mR+mHMA114e2oRIVVkze+XV0K1Fn5kaxVzYdz5tt+4Gj5zjIHSAOujFFo36R
 esuZ0w0J9jIh0IMY67Y3yLsUJi3m3c5T1HZfxi6eew/Yy2O/z6TdSc4WGyaPs2iL0AG4
 Icv/XMzP0UHN9qbMjtUph0D1k/3Hy8ebX4PAIeFLobSy2G3xF4UQ26FRXSOQ444B4ekb
 7zpjIv+2uAHnepq1FXetf2wufuTPB+B0bO/j9DbnfjGHNvqlrvdaiga4eMfmLYVw4jZ9
 h7BQ==
X-Gm-Message-State: AOJu0Ywv6Td9uFiXR3xqhGnxxT1vNOUXJkh7WaCpUHN847IzkAoHV/Yy
 H4Za1tBTJTwx8D4CN0gci/LtXQdORX+mSf7We9uvblOA+Fr1ieCnInrlkkOwyVt8uPzf5nAgzbc
 rNjb4
X-Gm-Gg: ASbGnct8S430S59ivk9Q0+QEnyfEC1SpUudif9g9o0xe+O4Z8pJVrO6DnsZl/IPBB69
 UHqTBhBH7nizhO3LPkETor2U7G7OzLY2pb3VJlIV6eYV+ByA85Qp2v3FTIHlnU46pkr7pgHyzjL
 PCU73VmU86uPr8A9qY/4QZP9a0VnHGNJShHAd0Xy8o4snZ0iagEJEwJx1q+iKufxlOPFdvtXf3j
 liGQHyYV427UjUuIrVlSkSWUAMJwYbjoD6oOVLJuG+UdQqg+3Tn3HWcIP/zSDBLtbz5DoNqXock
 QvSjTVl9OmCxmaTSj+As6z8byOyEuATfy9AeK7O3CrQ49rEqZ9910fpFetedtfe33xZKSsuxy3C
 1aRe9XLx1supDRgynPG9y/VvTl48yWFWZCTOaJxRSOiINxAWjw93cVy68TVrPYJjwoBPo05Yzus
 BFBkSla6Smb0kt/A==
X-Google-Smtp-Source: AGHT+IGDcPINwnmQEGKo1yB5uZp+EgwHNke5oGyj9a+LnjryqMX+/kIjPAHVrBephQ1aApPHZpfLoQ==
X-Received: by 2002:a17:907:7e92:b0:af9:3c4d:e978 with SMTP id
 a640c23a62f3a-afec348acb4mr832592566b.41.1756462238646; 
 Fri, 29 Aug 2025 03:10:38 -0700 (PDT)
Received: from ?IPV6:2a00:1708:3ba6:500:d381:4e9e:1d81:a316?
 ([2a00:1708:3ba6:500:d381:4e9e:1d81:a316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afefca0f238sm171836566b.43.2025.08.29.03.10.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 03:10:38 -0700 (PDT)
Message-ID: <1b82498b-73e0-4793-a320-b49828273fc7@munisense.com>
Date: Fri, 29 Aug 2025 12:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: u-boot@lists.denx.de
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CALeDE9M1gvJ1Z=vNr345V35QjgfGU_Q2Wki5dMF-zAqY-ko=BQ@mail.gmail.com>
 <f5074534-b565-460d-9943-6493174db3f9@epam.com>
Content-Language: en-US
From: Gijs Peskens <gijs.peskens@munisense.com>
In-Reply-To: <f5074534-b565-460d-9943-6493174db3f9@epam.com>
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

On 20-02-2025 09:54, Oleksii Moisieiev wrote:
> Hi Peter,
>
> On 19/02/2025 21:37, Peter Robinson wrote:
>> Hi Oleksii,
>>
>> I've started to look at this.
>>
>> On Wed, 5 Feb 2025 at 10:15, Oleksii Moisieiev
>> <Oleksii_Moisieiev@epam.com> wrote:
>>
>>      This patch series provides generic support for Raspberry PI 5 in
>>      U-Boot with additional hardware drivers.
>>      The following features were implemented:
>>      1) add generic board config for Raspberry PI5 including device-tree
>>      files;
>>
>>
>> We already have basic support for the RPi5 since Jan last year, you
>> can see the patches [1]. This serious should build on that rather than
>> add new duplicated bits. It supports basic serial and mSD support.
> Thanks mentioning. I will do full rebase after upstreaming of the
> dt-bindings to the Linux Kernel.
>
> Oleksii
Thanks Oleksii!

With RP1 (seemingly) coming for 6.17 does this mean we can start testing 
a V2 in the near(ish) future?

Gijs Peskens

