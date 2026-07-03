Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA17C44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CB0849F6;
	Fri,  3 Jul 2026 14:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jFOvHCby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 257C484A0A; Fri,  3 Jul 2026 14:27:45 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94EF849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47863f723ccso99510f8f.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783081662; x=1783686462; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hhYKAg2aDxEsHuK3/lp4hNgiZn1rIimqqDR80o4ZWac=;
 b=jFOvHCbyVnzz01ENA2n2aj/C3t3hlCkT8XWI0qNdwUrtlOjrlU4xLqk4YYfb1ZON7n
 SvaG0m9A5zdS5Jze1rE/xdmP8FUyed4hBB1dWvk3El9EIDMvhWwbebaWAVQ9ElNaiV3J
 BMU4h5hge07nxTo5Z8wJSj5pw5+EUI+QGvscaFNIiLI45XqtFQeH1EWI6WG980j9/646
 PG6sXgGHZXbp2/HGbalbAO7WFpC/wtpqCjnEiwBuyZXby1QPVegg+DGey1T2ierBhOUv
 qwI7Goy/D/oEPKVQ+WbbnvS26sZ/O/OGq8R95Ryz8sVcfGIeXjrk+cxjUF3Lwllip397
 Wpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783081662; x=1783686462;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhYKAg2aDxEsHuK3/lp4hNgiZn1rIimqqDR80o4ZWac=;
 b=hMToNVtDApjtTcBsuI2zCDXeyods1Dc8TC/h8BZ48zV4UMuHugLdSbVqUJCFVl0TnL
 y8ZdQ8vGGxEx4WZgfhfHCcOprww8cCpYGIQgy+lb/pLVXzYhKwsMPu2vBCkDvngOpykq
 Fm1nN6ljLlUJc5BRPCndBxxUZOwUfga1jxGcsRfEaVXPkNUvGRLO0PbqirxAErnjfTdM
 XodOoiO7SI75yBrL36BQv+jCyHlmNleir8dOGI2Rt2cS4Bk6OF7Ko/RcclZc7E0dqH3W
 fDlNC00UE+QGWivlzw7mg3xKPrlXpuFbVFyMIzS+eG7qpVfP2rR9PBcFkDHVBNWJdnme
 R/Fw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rryqu/c4h8GpslTmSzsZsISLTDB8n+BolrIecKRYSG5MdvkCo21595SOInx7DdWrlnh/foB2JA=@lists.denx.de
X-Gm-Message-State: AOJu0YzyLpR1S17YiWzqTaAr29ijEKYnPdYojgxgoeNRE99I4vHuKQJ/
 dTosgKKfeC6Hg8ivYH7RDIyvI24pCnCOyyq6ey4O6dvJRhdjQaEot39tPdMSgz0Fi0g=
X-Gm-Gg: AfdE7cm2pCBrPJ2h8u1+5H7GiT9b8woPBuz14IPNt5mepePDclATwShXQnEyyvVP/p9
 r8YWylpwln7pZ7W968HJXxDd0a+G4I873kiX2rcMtUDgVFH5J9y08ZGlkmvsPjNiGXdVAthRJw4
 mY1fr4Zfrb9Bv3LAT7BInDXPl9Pbop+wMMbYZg0pppYu6B4lKFaFJE4iLd9rYEHN89Np3f9OWKJ
 PkuogQjMzI07h1I9rxojnquID8QXb5ExrUHzeJx6wJmHlBYuv99oxiWQWIBAElT+xj6SnRVc6vQ
 2J9i4ZRcoddLsZhhikYw1sSOE/CQU6guUZY5ckfrSf2SSf172gdd3PoFRKIlbfXi+TTAEUrQGEU
 HCesGkfVrL7tCBgPoKuFh+ANu6IlxtAjYYn35X7yPnr0GVKyxJEEnDzEmE1b9I+Ac4UlEEErJAN
 PG7V6/jvttq2SBK6uc+FLp+bhsZEKjBH0DxNSceeEEDow2WeSuMEU9pcU5A8EoUcFTKQ==
X-Received: by 2002:a05:6000:2385:b0:478:4de8:9b91 with SMTP id
 ffacd0b85a97d-4784de89c96mr10264299f8f.41.1783081661874; 
 Fri, 03 Jul 2026 05:27:41 -0700 (PDT)
Received: from [192.168.1.245] (p509936c9.dip0.t-ipconnect.de. [80.153.54.201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94c8ccsm18602986f8f.21.2026.07.03.05.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 05:27:40 -0700 (PDT)
Message-ID: <2ccadd61-59e3-4f97-950a-47928c83c7c9@linaro.org>
Date: Fri, 3 Jul 2026 14:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drivers: sysreset: revert support for args
To: Quentin Schulz <foss+uboot@0leil.net>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
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

Hi Quentin,

On 7/2/26 20:27, Quentin Schulz wrote:
> The args support for the sysreset uclass contains a logic bug. The first
> sysreset device implementing the request_arg callback will consume the
> args, not support the specified arg and thus return -EPROTONOSUPPORT
> which will stop the iteration over all sysreset devices.
> 
> This is an issue if one has multiple sysreset devices and each with
> support for different (valid) args. If a sysreset device implements a
> -dummy argument and another -foo and one calls reset -dummy on the
> U-Boot CLI, it'll depend on which sysreset device will be attempted
> first. If it is the one implementing -foo, it'll return it doesn't
> support the argument with -EPROTONOSUPPORT in which case the device
> implementing -dummy will never be attempted and instead we'll do a cold
> reset which is very likely not what's expected.
> 
> I suggest to either add an additional return code for the case where the
> sysreset device knows it isn't supposed to handle this argument because
> it isn't among the ones it supports, and thus we try other sysreset
> devices until we find one that says it tried and either is in progress
> or couldn't realize the request, or no sysreset device supports this
> argument and we end up doing a cold reset (but should we even try to do
> a cold reset if the type of reset requested by the user isn't
> supported?). Or just don't try piggy-backing on the reset command and
> have a new command instead?
> 
> Maybe I misunderstood something or misread the code, so please correct
> me if I'm wrong.
> 
> We've tried bringing up this issue multiple times over the last
> month[1][2][3] but it seems like we're left on read. This is the last
> resort to get attention on this patches, hopefully we don't have to get
> through a revert a few days before the release though there is only two
> working days left before the release. Sending a revert as requested by
> Tom[4].

I'm so sorry I missed this feedback. That really isn't great.

I'm with you that this is a pretty fundamental issue with the 
implementation here and I think the best course of action is to revert 
it and come up with a more suitable approach that isn't so open to 
trivial logic bugs like this, likely with some deeper refactoring of 
sysreset/reboot-mode code in U-Boot.

In hindsight I think I should have pushed back harder on this 
implementation, this is something I'll be more cautious of in the future.

Acked-by: Casey Connolly <casey.connolly@linaro.org>

I don't have a chance today to test this today as I'm OOO but if it 
doesn't break other platforms then it ought to be fine on Qualcomm too, 
maybe Neil can give it a spin on 8650.

Tom: feel free to pick this up if you're happy with it.

Thanks,
// Casey

> 
> I've not even build tested this, only had a cursory look at what to
> revert so maybe I'm missing some patches or breaking stuff up. It's late
> here and I wanted to give a chance to people in Americas to have a look
> at this today, or people in Asia tomorrow morning before I come to the
> office. I don't have time to wait for the CI to complete, but it's
> running here: https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/30604
> Yes the commit hash is different, I rewrote this cover letter to include
> the link to the CI pipeline.
> 
> [1] https://lore.kernel.org/all/667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de/
> [2] https://lore.kernel.org/all/4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de/
> [3] https://lore.kernel.org/all/20260623165021.GJ382693@bill-the-cat/
> [4] https://lore.kernel.org/all/20260702174613.GC749385@bill-the-cat/
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (6):
>        Revert "qcom_defconfig: enable psci based sysreset"
>        Revert "cmd: boot: fix edl being shown when not supported"
>        Revert "doc: usage: cmd: reset: specify when the -edl option is available"
>        Revert "cmd: boot: Add '-edl' option to reset command documentation"
>        Revert "sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs"
>        Revert "drivers: sysreset: Add sysreset op that can take arguments"
> 
>   cmd/boot.c                            |  6 -----
>   configs/qcom_defconfig                |  2 --
>   doc/usage/cmd/reset.rst               | 10 +-------
>   drivers/firmware/psci.c               |  4 ----
>   drivers/sysreset/Kconfig              | 15 ------------
>   drivers/sysreset/Makefile             |  1 -
>   drivers/sysreset/sysreset-uclass.c    | 37 ----------------------------
>   drivers/sysreset/sysreset_qcom-psci.c | 45 -----------------------------------
>   include/sysreset.h                    | 18 --------------
>   9 files changed, 1 insertion(+), 137 deletions(-)
> ---
> base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
> change-id: 20260702-revert-sysreset-4579ae458f2e
> 
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
> 

