Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87253CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 08:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FB98483F;
	Wed,  6 May 2026 10:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fVgOzJsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A9C846F4; Wed,  6 May 2026 10:16:01 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161BD846F4
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 10:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso519475e9.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778055357; x=1778660157; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmLaG4x+55AhXrMp9EhEFgpDjUykPyEdExoAX3OHqUk=;
 b=fVgOzJsIxGKSQNqRorxz7OcZ8/0lNFqWpYXHPUMsehmt+ItyR40Jft6THDcPsRQhYA
 3xHXomQgamjOSANZwt/clu7YyVGfh5SvHOwjAM+DPKyB21D14QxAI22SKPzjwS19oz61
 BHeqjxD6r0ViNo1nYaD6RUo3Ga179AuQKK7LxtIbnUHjivnUd54hlO3qicRSWoCa8VUe
 KcKhuR9UiSCeS09LFgbRrkWkxrMEwIYhvftko97mSUSgRLkp+qZora46qwdFK37ADNaG
 YYknrWVygwW7v1mYq2/5kDesE+ZII3XyxQqwiXYiUsGuEQTbQwgnjQArvpFPQ2hLdoGd
 q6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778055357; x=1778660157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmLaG4x+55AhXrMp9EhEFgpDjUykPyEdExoAX3OHqUk=;
 b=VychhwGt5PUyyukDq/6TEOmeFOt+kYWxynJNBSVl7dVa2stVhIstmZkgB4bDlHkrxe
 bTagehlkQF/BZcdT4j5+41oZmTuhLcITbtXaGtQ3skWymR0+2ApgfkGz7x9q7IcU+i0L
 aXyBIOUhRDNjFEyGkUDtrHr55AShS6vw+JexnUgOfH7G9fqmnDG7psjG6969pmj3iFX9
 dy37dDcMuwzWMmnvsooSY3VjGIej7kjdxi3ZRH9eVXSvKTF6iMea3MgvtrWHBqlL3Y5H
 b1rnbOXm9jQ55dnPj8+oJcPdfpAhmABiVF//C1vsZjVPgKQaOkWnR+O9UbiY3wXY9sAh
 PTmQ==
X-Gm-Message-State: AOJu0YwjIELE0gpnXj3FA3J0UbdVA9+oiz3L+4I+9TraVXVC4Eq8r7TR
 d4RvmvaCx3wmENsSSRk1gcYuEWs8JXHnZPWxlK/HExEPeLpjrCsHv1I6XLDb0lX12+Q=
X-Gm-Gg: AeBDieuAscsnYcLFnvHfuZ4y4ObZr5V1VUjcEAq2snuAtzjl7gixOeuqZ0B7vhFddHV
 bDq6MKuxOxfN8dsGzjxqL+FFjwrk+Ljp44uM/YD/TSjY1bJxLSW92DsTRbDDQZcDZu3nMancvGf
 XS+pdhohQBXpi18FTl/rbxRcQ1FtpfMYNifnA2mcVyigZg8uEjI41PDVfSlO9Fgd+H/BpxlQ7bN
 3ytux/S0D4ZshnaVwRRCWD9vtJvI/mEDRlJnjS/dfeil/1NiOpRL10KzFIG1tDJn6V9nnKpvoaF
 Lzm3KVpk0SXN2AwtCMBhbRgOcdKJea9QO1DYS5jDqgoRmcYNO5Nc8boMmQGv6HFDvfQ0WVm7gIK
 jGTS6Ye2fhDGEF26FF0kZdomY3Kh7d7q2/mWAOmHAhcaCQdcWwa3aJyomL2ovg5M405WiZry/yB
 vNE5eEDYcUG1g6PNP2VBVwtQQWt7VmIbd276PIz/fuRNTwgUMgQCKHwmPEY1/uugHTN4KpFc18V
 RUR
X-Received: by 2002:a05:600d:8451:b0:487:219e:42d with SMTP id
 5b1f17b1804b1-48e53f33f08mr13817845e9.11.1778055357251; 
 Wed, 06 May 2026 01:15:57 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538aca14sm28412215e9.7.2026.05.06.01.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:15:56 -0700 (PDT)
Message-ID: <edb7a015-6da1-4f29-8d4c-5008c40d5277@linaro.org>
Date: Wed, 6 May 2026 10:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] config.mk: support vendor generic includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
References: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
 <20260505-b4-qcom-tooling-improvements-v6-1-a5fb673f4af6@linaro.org>
 <20260505163206.GS1614990@bill-the-cat>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260505163206.GS1614990@bill-the-cat>
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



On 05/05/2026 18:32, Tom Rini wrote:
> On Tue, May 05, 2026 at 05:48:41PM +0200, Casey Connolly wrote:
> 
>> Currently only board/vendor/$(BOARD)/config.mk is supported, add the
>> additional usecase of having a vendor generic config.mk which will be
>> used to add a Qualcomm specific make target.
>>
>> Additionally, fix the ifdef to correctly check for $(BOARDDIR) rather
>> than $(BOARD) since that's what is actually used in the fragment path.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  config.mk | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> A common pattern is to have board/VENDOR/common and I think qualcomm
> would benefit from that, and it would make this easier to use elsewhere.

ahh that would make sense

> 
>>
>> diff --git a/config.mk b/config.mk
>> index abed9cb65c6f..28a4228b8fa5 100644
>> --- a/config.mk
>> +++ b/config.mk
>> @@ -53,10 +53,14 @@ ENVDIR=${vendor}/env
>>  else
>>  BOARDDIR = $(BOARD)
>>  ENVDIR=${board}/env
>>  endif
>> +else
>> +ifdef VENDOR
>> +BOARDDIR = $(VENDOR)
>>  endif
>> -ifdef	BOARD
>> +endif
>> +ifdef	BOARDDIR
>>  sinclude $(srctree)/board/$(BOARDDIR)/config.mk	# include board specific rules
>>  endif
>>  
>>  ifdef FTRACE
> 
> But BOARDDIR is used in some other places, so might this become a
> problem overloading it this way? Does this end up working because
> there's no "board/" code being used on these platforms?

hmm, good point, it works in that case but would break if
CONFIG_SYS_BOARD was set.

I'll fix this up for the next version.

> 

-- 
// Casey (she/her)

