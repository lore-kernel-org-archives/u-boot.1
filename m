Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8267FC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B410F84B33;
	Thu,  9 Jul 2026 03:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bGIz3/Dx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE0984AB5; Thu,  9 Jul 2026 01:08:27 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF3D847AF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 01:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4472500e25fso650122fac.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783552104; x=1784156904; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bNBGr+8cxVUGzSFBEh685YT/CwjFivx8fsztSpTKRXU=;
 b=bGIz3/DxKLBoSNGkaoYc9Fg480ef8darrrheuHCRX2zCAO3p1w+KvcO362LtS4/3E/
 fXDmwfhstTKcQlKaW4Jc4k16bWm7Vxg8WfKuxa1LJDYAtPzt0+2ttrHJpfvQP77GUkhF
 6f7SecpBZhjtuk9daPyIGlWveZ3v7357epTdvaSk4Sg1Pu38QawXufzf6wgY8duSx81a
 SoyEHarl5Xd4DcVgjbUXeqkdrDsL51+xMAH8vYpriN8KdFgNWs6198pC52qFHa4W4oRP
 OlAJLMxnilluimIjvlgURvLsMI9r0jCLTsrMswKQsYtrP3iJtX4leAfgVcSQqP8DPmwY
 Q7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783552104; x=1784156904;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bNBGr+8cxVUGzSFBEh685YT/CwjFivx8fsztSpTKRXU=;
 b=Z40k0VFTm8IJe9fusCDmlG8p9db4oLrgJcW20olHs2fWrKtu67aW4nbBM0iRbjgp+e
 /1vGeZYyb072sm4pCG0mQJqo8KRDtXrWsv6je3YzHgI9a6DPk9IhUrmYC5n5eAQoFNMU
 dBWKQkf/p/GVRe6MAz3QjukIiSte5zgCDvr27hQjqleljb54qNXaTh/jLNLDLKBqMWLo
 fWW6/oWgR3zScTr8eS9R6ttTEj2XTwFzD405apfYqi5eA83SB78b7aD+N8r6CaViA4zF
 d9b651jbAhvEw2mL8hntxK567Bgc8KgBQ/QMXibUv6Rf0LJ13sOuN76JIztcRwXnYfEE
 r/QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8s5TT4rKUmQ9v5dWjsgFq02A+Y63V2bDsm5O3M89Hypc+8OrIlLBV3kjwYG8Sp0HuPO4QuntQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyzAVrPgLp7JMB1OfyjTeImrUZ/vgOSbTJoF8YzqwlPkA8W2J/B
 OuA4wiLprHofkDiz2KWv/XUFzTnAFTPxG2ZpWGaPmb1wE+nVG7uQhEcAPLAqj3qv0bk=
X-Gm-Gg: AfdE7cmLVwy0VTvaI8vYDCeD/uSpz0w2OSF6dP99ds5ACdLdh3oZE+XSFNFp9YfQJ4l
 hP36DL939GNoLbJjGDSEPyXrPD+GeOBWnYjWHne6FCTK6SbdvxJZ2AtQ7YvHDZGAdHl8ErKEjHs
 JC+FEaUyni0IeYqyHhTbRJM3acp88UJ6oSMM4JJehPawLb4nGf21etTqM8PxPMNSPjz7MRfytfg
 IU6211MM3vRec5UFMbR6uhqGsxq5uboFcz+53ZfVdBhxY6L48Vg+Zsytg624i9J6RioEG9IG0Ik
 7KO8dX9LL0GkQHCy1yQf/+27jZD+Vs1n6RQj88Dvok64lBC3jFXv/TLjo78/pEj7vr3QihIgDwG
 0UBArq7r4EHdE+23584dD9B1PdBwhcgcr/5C8Aojg1sa7HJHMHP8rHcEihmem5LpPMk6vueMiHB
 LkuWp3AJYpcf/8Uzzt07zWD1hB245lci5swS30oKAXBpkBI6L/mwUB96p/fT/A1F8=
X-Received: by 2002:a05:6820:2d42:b0:6a2:739a:ce95 with SMTP id
 006d021491bc7-6a36d869f6amr3319421eaf.4.1783552103916; 
 Wed, 08 Jul 2026 16:08:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a8cb24dsm2866879eaf.14.2026.07.08.16.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 16:08:23 -0700 (PDT)
Message-ID: <f3fb05de-bbca-44b4-bd25-1bacf47854c1@baylibre.com>
Date: Wed, 8 Jul 2026 18:08:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] power: domain: mediatek: refactor driver and add
 MT8188 support
From: David Lechner <dlechner@baylibre.com>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>, Sam Shih
 <sam.shih@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
 <dd017493-cd35-4358-8f1a-500b7c303770@baylibre.com>
Content-Language: en-US
In-Reply-To: <dd017493-cd35-4358-8f1a-500b7c303770@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:32 +0200
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

On 7/8/26 4:22 PM, David Lechner wrote:
> On 7/8/26 8:07 AM, Julien Stephan wrote:
>> This series adds power domain support for the MediaTek MT8188 SoC, used
>> by the Genio 510 (mt8370) and Genio 700 (mt8390) EVKs.
>>
> 
> ...
> 
>> The new files added by this series are not listed in MAINTAINERS: they
>> will be covered by the pending "MAINTAINERS: Replace Mediatek with N:"
>> patch from Marek [2].
> 
> Are we still going to need drivers/power/domain/mt*.c for the new
> files in "power: domain: mediatek: split into per-SoC drivers"?
> 
Nevermind, it is actually there in the patch already.

