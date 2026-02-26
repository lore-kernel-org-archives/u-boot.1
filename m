Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88C1FD8FC3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55FC783D1A;
	Thu, 26 Feb 2026 16:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EjlDnvVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8ED183D8A; Thu, 26 Feb 2026 16:21:48 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B5983AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 16:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 716053FCE5
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772119306;
 bh=AHoksELKI073CgOMhKe/6sLySdTAvrNzw0zd8bVoi1Y=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=EjlDnvVizcIEIMns5ayN9WG6krBsth5B5vWlK/vQsyq1hP63H4MfNVf2+Covs/0Lu
 t1urtWDN4xYS1xQhRKMlXYF9pHQC1EYPjdzBRDZ4Oles4mFl1OHzPrZ/iFpWRwYMq7
 t8ejiQ18JkSw4ddSC6rFBYqjZXXg5RwTF95LDSknQuhuTLfAD5OJLiglpbFwT/Ujez
 oxbaK1jpk/ADGk9WnQ1DjrmfpW8iRqem5R09VcEG2Y9R87kZzAD1xeb35yyb6KtZxQ
 4EQfPHw0XZpiT2J5OwTxq9hbCEyz5kaMH/ZpeoIV4SbUli+/PpgivSjEA77uYRKfCf
 QzcIUWxGDcIr+yvXs0ebGH9VycUFEnEcv0bsRbVTsdVoddKm67Lnsszd0tgyrN8sWf
 /5hDE2WjzT9V7asgJOtAAFyX4iLdGyXf+Da7ZxHtWpJ+MpjjxpIjWcD2WgfKPrW++w
 vIUTBB6p4he7HgfOVFHna06olrL/OsAlQgVgoBf4+2nlj9vXn7JxZMCd/UvT9MNV3r
 0EaZdyujtmP/sCPc40/CUMDy/TZdLkiOFUVqtK/LsU+47xtrtK/i+B6/8Pdxu/A72y
 j+x2WhilZJ1fI2WNzCUUq8tYKKMesiQoZMpT3cnYFNP6A50b0IoPodqNGsjWdK5O37
 +7V6YV1KnZNY8Caf4HRZFW5Q=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4368060a5e5so1071110f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 07:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772119306; x=1772724106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AHoksELKI073CgOMhKe/6sLySdTAvrNzw0zd8bVoi1Y=;
 b=jQM32wUzb2WK3xVS2SYN88e59UruGtWrX/B9FbC1Q+oW34JowFltJM8usKrDNS2ZNU
 3llnREh92ysDnaCp/jZ7W7LBlXNsBYnNzZQ7IeTmbbEFOc+BDHBuB2zCMjkgZfeOzSRM
 zwXehzp8UnjjkU0/XP+SVmYM4g9BiSolBaI5QbBW6Tln1UxV/TGXHKnWMcMCwKVJ+TI7
 BUtO1J+woHNO5Eca3IJwEvEtJ4azzjmFSYSpaQ5hIh6m7rU2EMa2EgS/z7pJmJKZX7k0
 JxQvTs1GbS8lXlBzQHq1tmOwcXm8RSzRGV9ihic+unup8H4N4FuZJ1+Sfmg1o/g9PVV+
 D1Og==
X-Gm-Message-State: AOJu0Yyx4oGbo3I19K98UR2pKzrmpsTX5sAHxXaE/4o01qpPrTZagje0
 KAymTJ1Zla/l6wUCH5ZlhK6xnGQjF8/u0e/kr3SE0dhWjG610siIOXDOL/eUjqNSBJdJrrMeLXR
 z+auMhDC/tzFbjba99eqx0KXzCTtNCx6LppvmZ+k1zlK5yUw0GpGfo0KIEIlywBYVR3/UM2qIIK
 6SkWo=
X-Gm-Gg: ATEYQzxmta9HWHtePR4iKx5AKX2v6VdF5EecU+hIBJG1kUCpc6JJuVYfG3BNnSOUYKs
 X02k5fxNsE8BIzdXevOSTJowb7x6RVchrbz+G3hWrWMSlK5UPJy2O4c81uwJA4ZoeSW0j/88WJD
 ldckHTniTCJQbBSABiBLXiadMxTjRfaDAdvgEiG1dozov1aQaacw/hVQJHNp0tdHIT6esT27GUC
 dapPQKdEbYZnco1zjN2GVio/pOxq3u1uNDoz62tEOghQn1V3l/65J0kzn8axip7+e350BV/WhpA
 Mjl3m1azBcRG7k70ah9b1Fw62L9jWTFnFXUmFw0mJXePHu9nF9Y8iEzP7dJX/oxQjIuJsoXJ7N+
 2hxDh5Pl5jNbLCySPiggq3QpZQnLN3Vnqcs+Bbg2l8pFZ+0PhrHUXG0qp0SAB2SxESb1uNJpmAk
 SRACQ85WFgx0Ejy/ZFD3QTmXh13F8WNApT/PQhTCFxvq6ImsSo52M=
X-Received: by 2002:a05:6000:438a:b0:436:1989:a1ba with SMTP id
 ffacd0b85a97d-43994294f6dmr9103982f8f.10.1772119305859; 
 Thu, 26 Feb 2026 07:21:45 -0800 (PST)
X-Received: by 2002:a05:6000:438a:b0:436:1989:a1ba with SMTP id
 ffacd0b85a97d-43994294f6dmr9103902f8f.10.1772119305280; 
 Thu, 26 Feb 2026 07:21:45 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70e8e8sm222607f8f.10.2026.02.26.07.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 07:21:44 -0800 (PST)
Message-ID: <fed4cdb6-f0bc-4b57-801d-0b5e05eeb77c@canonical.com>
Date: Thu, 26 Feb 2026 16:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: add checkkconfigsymbols.py
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
 <1279492c-5e93-4a89-8cfc-2d5e9c0e3ade@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <1279492c-5e93-4a89-8cfc-2d5e9c0e3ade@cherry.de>
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

On 2/26/26 16:14, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 2/25/26 2:10 PM, Heinrich Schuchardt wrote:
>> Add checkkconfigsymbols.py from Linux 7.0-rc1 (unchanged since v6.2).
>> This tool allows to identify the usage of symbols that are not defined
>> in Kconfig.
>>
> 
> I'm wondering if a good next step wouldn't be to require users to run it 
> as well as checkpatch before submitting patches?
> 
> We can take our time to fix the current codebase but making sure none 
> gets introduced is necessary otherwise we'll be chasing a clean codebase 
> forever. And I think this could also catch sneaky merge order issues, 
> e.g. someone adds support for a new board before/while the symbol is 
> removed/renamed.
> 
> We should be able to enforce both checkpatch and checkkconfigsymbols.py 
> to be run with b4 prep --check (and b4 am/shazam --check), see https:// 
> b4.docs.kernel.org/en/latest/config.html#term-b4.prep-perpatch-check-cmd 
> and https://b4.docs.kernel.org/en/latest/config.html#term-b4.am- 
> perpatch-check-cmd
> 
> However, I don't think this script is ready to be used with b4. As far 
> as I understood it, b4 sends the patch to the tool's stdin, so we'd need 
> to add support for such a thing.
> 
>> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Imported the script from v7.0-rc1, same as the one in this patch, thus:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

In the current state the script is helpful to find problems. But it 
shows far too many false positives to be added to CI or to used in git 
automation.

Best regards

Heinrich
