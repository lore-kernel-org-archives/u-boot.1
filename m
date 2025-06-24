Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7E1C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 23:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B6C82977;
	Wed, 25 Jun 2025 01:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qy4DBd/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6ACE82C84; Wed, 25 Jun 2025 01:05:11 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949EA803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 01:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 116573F546
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750806309;
 bh=a67Hf3HZu3HO076mtm8CeGuGxTSgbqPO2PAZLW4YfBY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qy4DBd/E1G2n2GjkoU785KKCj+ZySYQoql7hWLXfgPFM9bDqwejrab2T2lI/CaAT+
 uRYEgpVcV/Eqn6iwNmimERaNtmTOs2Vz9DpWtq/nETqb/fs0FDQ5jqVYADBWLGSoXM
 SAMYMb+rUGnUiKRobDyvOR4wNrDezm7cduphLqF2oJf669Fq0hx42hCJViKTdyCJEo
 pA4S+UqbkLaRrasvpfVSY1fTnDM/JReYhOwDOq+VbzQmaG3rNn07VFCziAe/HVi+61
 zA1MluC+5fjhsd4XNvLW656TNlk1i/YlIGgFCjHbYvQ8KP7kOdwdA90v9UHTH1k5m/
 yrrWpmHw3HUuA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so162639f8f.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 16:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750806308; x=1751411108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a67Hf3HZu3HO076mtm8CeGuGxTSgbqPO2PAZLW4YfBY=;
 b=fzMkjOaKhxKjiEatY1GjnbYE8zUsOtahspYgn+JIh5IvKN1FJASl72a+bjj41Poo/a
 5yfBp4tIkf3xCUDPxSiuTOp+7gQb5+v8vSlOXukIxECkpwzsafEl61QTYf5pVZ+4tShJ
 dXYGxXbdo2CsuxtFSLXALeEfDxG+BZwmqKBb+v4nYhoRTTR/JYTuodv/qUe3SHG0Cy21
 9fsOyMsmPKiPGl4JJfjJvi4TvpdKEF1kcWjVR5Jlqd5W9h2ZcrZZMrYx1MqXKT1Kb4sD
 H9E/2sS5Jrf21cpge0Bm6wCFcykAzzPuibBuud1pgv+7MPyrIVraebNB0yiettv0tYBo
 C/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5SK5rXVG7127E+9ZcsyXFrx1jLWpmi10q29r9Cy18H0vZfbG9VgPon7VfOZn5pPhIQ/vf/8s=@lists.denx.de
X-Gm-Message-State: AOJu0YxdfCdGaDmTOlDU7bfJ1UzlEEMXBDg/vn1Blb5vQM0rY7dM6sLD
 cMJarIgNPzhQcpGxRHjYeb83fZX0YhEE5wzGSOnFRetd1KaRSPYz7CZlZaeWxdadxFqMEff4xhE
 6NsCV6Blny1WViCT3Y0t/LA6cZ9ltkgI1ik6hSCVWMNbB6P99zUAVrYLk6UuskfwUpVg2HWk=
X-Gm-Gg: ASbGncs7U/UTBmTUWd9AJGa4rw6dBPk15DO8yejzqNMSN2ro6L1RAwFGt4jQ1a9SOVU
 qFrbbyJw5NzM25ZsL1NLxFOEj8/LzQyEjFMbrKPl2fH3k1OSNArPn0phgpTFiCg/GeuCT2zrbKM
 tYL8Mv1UAJ6uRKwpwU5YyialoxCOxYPqFMCjdOMl/pjMThchqnnjGu4semMS6vf0DLXrKQdVFBN
 q00D+V/7LN1guZNB3W+O8vOXc6nDaFCB5DZ9BVpxRDCGkldKyEQae0nn2W87tiUsgK3TeEn24Cx
 3h+jz3C5qoXw1w4SBrt4X4s8W6VRDOVtSpgyrSVDID+bzH9joVM1DFqo3EpF44rREjtp18rWYmd
 pA5+RcJ+ni9Irr+AlRqo=
X-Received: by 2002:a5d:5f92:0:b0:3a5:25e2:6129 with SMTP id
 ffacd0b85a97d-3a6e7206741mr4677558f8f.21.1750806308470; 
 Tue, 24 Jun 2025 16:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIJIfnjMNKWT69EtTdY/4FFn1kU5URUm5xEhBPZGHKJwTsV82sHmkgmQaWT53cbt9kbadBIg==
X-Received: by 2002:a5d:5f92:0:b0:3a5:25e2:6129 with SMTP id
 ffacd0b85a97d-3a6e7206741mr4677539f8f.21.1750806308051; 
 Tue, 24 Jun 2025 16:05:08 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8050e1fsm2968146f8f.8.2025.06.24.16.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 16:05:07 -0700 (PDT)
Message-ID: <33d0319b-2069-4e4b-819f-870329b58346@canonical.com>
Date: Wed, 25 Jun 2025 01:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
 <c9fafbc7-e813-4ed6-ba27-527407b8d32c@iopsys.eu>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <c9fafbc7-e813-4ed6-ba27-527407b8d32c@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 24.06.25 23:02, Mikhail Kshevetskiy wrote:
> 
> On 24.06.2025 18:34, Heinrich Schuchardt wrote:
>> [You don't often get email from heinrich.schuchardt@canonical.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> A malformed FIT image could have an image name property that is not NUL
>> terminated. Reject such images.
>>
>> Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   common/spl/spl_fit.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index e250c11ebbd..25f3c822a49 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>>                                    const char **outname)
>>   {
>>          struct udevice *sysinfo;
>> -       const char *name, *str;
>> +       const char *name, *str, *end;
>>          __maybe_unused int node;
>>          int len, i;
>>          bool found = true;
>> @@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>>                  debug("cannot find property '%s': %d\n", type, len);
>>                  return -EINVAL;
>>          }
>> +       /* A string property should be NUL terminated */
>> +       end = name + len - 1;
>> +       if (!len || *end) {
>> +               debug("malformed property '%s'\n", type);
>> +               return -EINVAL;
>> +       }
>>
>>          str = name;
>>          for (i = 0; i < index; i++) {
>>                  str = strchr(str, '\0') + 1;
> The line above has a clear bug. str will never be NULL, so  the check on
> the next line is ineffective or just broken.

Yes, strchr() searching for NUL will never be NULL. But when sending 
your follow up mail 3 minutes later you claim the opposite.

>> -               if (!str || (str - name >= len)) {

Please, notice that this line is being replaced by the patch.

Best regards

Heinrich

>> +               if (str > end) {
>>                          found = false;
>>                          break;
>>                  }
>> --
>> 2.48.1
>>

