Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5766FC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 11:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803BE82B63;
	Wed, 11 Jun 2025 13:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cOJKc7y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E461782B70; Wed, 11 Jun 2025 13:55:37 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D9C82B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450dd065828so45692955e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749642935; x=1750247735; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gaia0H+yIr+UPcT6ie7U8BdpJlOicDvPjiBfSSsfphQ=;
 b=cOJKc7y1qO1Nh1S55CiqyLI5RXrtqiwgrbhQXLgaIE0XXZSO1tUWzswFvO+goaYeQX
 EoQSuQjhjiE6j+FrfA0315vfIfCmPJLmperXGFXaODHMZIutOsiSGkmmvMxHt/kt1xBM
 Uwo/60dJ5Bj/jtwtTFll2Lb5fmVz2RSDyXOMdkrJwIyorjNCq+jvpgG7xx5rgypqgqtW
 9xR2LcglyXhvJ3adze/3nFFME61SgV5jf5SBOoQaG/jnaKeKn0YmZpFdAZW7D1bp284s
 ApYR5h0R45dz2s20omzPJJOaKanEI+sMef+3AhzHRGND/457UAY3D7MRKIj8pHyDP43l
 hhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749642935; x=1750247735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gaia0H+yIr+UPcT6ie7U8BdpJlOicDvPjiBfSSsfphQ=;
 b=F3+FYLVXlrbc7W+uKMFj+I3zTeBqZE6sRdT19XNZPjcIBSXUmy/aTceYlkZRdbjesq
 uvYWu9lxfbYw2t71i6Orjr2q3oyqLRqZiBgwkkJzWyn7Ps4vYR6IPkU1idB8ClappyeH
 b6MxAr6QtlgVKVL/zFWBb0B9AVFEuuxkPwEvwmIaI4qPLNZhF8n5A8D7WxU48nREQ5Uk
 sNKWyC35mKLJEqZqkxxWjLCCwhJqnbaw6V+ehgBANQ61FZ4V29WRZU8uXcN2hCXttJWN
 IWHhtOfWKGjMa0MzoxO9M4L+JDcGtA+6bbQ06hr25FJ3vEcH8hqGRhv/LSfrK83VF291
 Blkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJUNHrd9ak//SW4h0wrEJfnnyCxEHMYhlhKSZgLXOLbS6TS/WEDNEqtP+BLzX9MILxzTkHB1s=@lists.denx.de
X-Gm-Message-State: AOJu0YyAQlIB2CRsEij5QoLQcEItAkkTuREevgR4K7JgvDQamJm8hWsK
 DNOyNiAvCiiucjlfnssqwKBxiCYVL0QGE/yj9LIiNecnIrFxxz+LNWXzMDqovzBh2eY=
X-Gm-Gg: ASbGncsIcD9M5nO6M/l9E5F+5qP3ToZsWvS8uKXLKFWqHfuqr8D6n9+EZMH97HL+OtF
 BKEouRSn22+56pZPMR4ZcuNNtHyZtItxDh1tkwQUJqZLWq+dJbTgfqAY3AIj4jMb4pOxJq7KYwi
 Wh/amdX7MPD/lEUauDpaB9rZMTRte+LBk85b7drB+NQJcTEAXDWgXCinfOaPvK7OBec9ABRC33v
 z3AODhDfyzsPlnI32xdoDqNepFcfEoRnFs8W+47Q9Xlj1MYIETPIpwEFvXkKGKSrmtnqZE/lWWM
 lw/0XqVeP1EM1MY5EpCn3wfSmOegO48fFwIQpe8KWoMVfaSlgXiNs1CytkG5h08Y7pYHxJlJ1w6
 WyBZFT2fSosihPZx1mp5kVAe5o3Fi1hky2RkYrA==
X-Google-Smtp-Source: AGHT+IGgtdzUZwOcgeHt2nwZcTpp+2LaATenIJH1cE3zgfzNgxosGCuYNmFSGuCyNryEgzkdU9cpVA==
X-Received: by 2002:a05:600c:6218:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-45324f1ca81mr19339575e9.23.1749642935124; 
 Wed, 11 Jun 2025 04:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1a1e:c277:1c68:9459?
 ([2a01:170:117e:fc:1a1e:c277:1c68:9459])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532516b934sm18830175e9.15.2025.06.11.04.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 04:55:34 -0700 (PDT)
Message-ID: <fb46de68-c969-433c-8f11-2dbc258afeb0@linaro.org>
Date: Wed, 11 Jun 2025 13:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Implement reset to EDL for qcs9100
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, clamor95@gmail.com, robert.marko@sartura.hr,
 me@samcday.com, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250507070733.2871986-1-quic_varada@quicinc.com>
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

Hi Varadarajan,

On 5/7/25 09:07, Varadarajan Narayanan wrote:
> Using the 'reboot edl' command in Linux, the platform can reboot to the
> Emergency Download mode. Implement the same for U-Boot.
> 
> v3: * Introduce a sysreset op that will pass down the 'reset' command
>        arguments to registered handlers
>      * Handle 'reset to edl' alone in qcom-psci driver
> 
> v2: * Rebased to recent sources
>      * Dropped the first patch as it is not applicable anymore
>      * Bind the new driver from psci driver


Sorry for the late reply.

This really needs some associated documentation, at least adding the edl 
arg to doc/usage/cmd/reset.rst and the help output in cmd/boot.c should 
describe the edl arg if CONFIG_SYSRESET_QCOM_PSCI is enabled.

it also doesn't build?

../drivers/sysreset/sysreset-uclass.c: In function 'sysreset_walk_arg':
../drivers/sysreset/sysreset-uclass.c:93:63: error: passing argument 3 
of 'sysreset_request_arg' from incompatible pointer type 
[-Wincompatible-pointer-types]
    93 |                         ret = sysreset_request_arg(dev, argc, 
argv);
       |                                                               ^~~~
       |                                                               |
       | 
char * const*
../drivers/sysreset/sysreset-uclass.c:35:69: note: expected 'const char 
**' but argument is of type 'char * const*'
    35 | int sysreset_request_arg(struct udevice *dev, int argc, const 
char *argv[])

ignoring that for a sec, I'm a bit worried still about how this behaves 
on boards that don't implement this psci call, on sdm845 for example we 
just hang.

I think psci_system_reset2() should be adjusted to time out (though I 
can't imagine a psci implementation that would return execution to el1 
during the reset, so maybe the timeout isn't even needed?) and return an 
error if the reset didn't happen.

Then qcom_psci_sysreset_request_arg() should print some useful error 
message ("reset2 not supported on this platform, reset to edl failed") 
and bubble up the error code to abort the reset entirely.

Kind regards,

> 
> 
> Varadarajan Narayanan (3):
>    drivers: sysreset: Add sysreset op that can take arguments
>    sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
>    configs: qcs9100_defconfig: Enable SYSRESET
> 
>   configs/qcs9100_defconfig             |  2 ++
>   drivers/firmware/psci.c               |  4 +++
>   drivers/sysreset/Kconfig              |  6 ++++
>   drivers/sysreset/Makefile             |  1 +
>   drivers/sysreset/sysreset-uclass.c    | 32 +++++++++++++++++++++
>   drivers/sysreset/sysreset_qcom-psci.c | 40 +++++++++++++++++++++++++++
>   include/sysreset.h                    | 18 ++++++++++++
>   7 files changed, 103 insertions(+)
>   create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 

-- 
Casey (she/they)

