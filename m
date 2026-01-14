Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD11D37E3A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3C88063E;
	Wed, 14 Jan 2026 15:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bjph2NZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFE9830A0; Wed, 14 Jan 2026 15:38:46 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27F080325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so96371715e9.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401523; x=1769006323; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tb6jUqSeesEFo0IhbQNQ5Zc5sCrtMjE6WNgNNMQp/E=;
 b=bjph2NZMNr2NKF6ZHG0h7GvH/lv3sJOQKolZ88KUpsm6QIeh7jbq1jIduMSO/vTUkC
 mzujdB/fbqHPUZueEqgDtQqj6xw0bhimcZfYOWVNndgHH3ji/eQeVaTUQe0fohyLBRGo
 QwZB5WXQ5u73pX7jH/iOD70Lq7tRpvuys+rWUqZ9Qws5SqvLh5C8cQBaL+GudU9+Le2l
 /QdH0qiwqdvVZiz/vO67c8dLTodMlJyMOER3X73TJlgQON1NthBl59CkgO/bi8asYv08
 Rhcqh8Gw8STGF5Wbc1Djt06AoXZJZO4DAE5Gv3G0fyBGPf/w6TGYlTkU9qbb5y65wmrr
 I+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401523; x=1769006323;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tb6jUqSeesEFo0IhbQNQ5Zc5sCrtMjE6WNgNNMQp/E=;
 b=ZMi0nGNZRt9MuOZHWF4WvmXe4DT0DEWKiKgeIsJQLjj1dNWig4O9HaQPrQlVKIzqN1
 bLe7kfuco5DxfDc3JpmUngo3KamV6C7s586I4m+tMgnNI/ayreT6PgVKAl+0E+twnu1I
 M4fsdf9IIYt9Qu/+a7FZYrhXkRJGx/OsNHmCstbUmdJ8E1MPzFAT81Mm4oqPSCLXT6CV
 mnpqPZ3CqDF/QDJKZC48pSgMDIhtzOTcpOPnUaR21hiU9imk9WqgMiv1x+dB6oCM6Oj1
 F6EnH4KmDhC3jwP+FgTk7JcMsrCJ/aBlHFRkyUfQ2xQ2XMsUTqxMgRdCbDXO20MTso1z
 5t0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8oAGSfL3q2pcN5sIPLMaxPlRYGydRhbkwOEGuz9XbgbjFY0fx9BwHj6fu1ts6gcqipjj5I0s=@lists.denx.de
X-Gm-Message-State: AOJu0YzoFGEMgQs1Y36bBY/UJd/mif5WDiyjPtGez+HoYlgjnxi0THtw
 niG82XBJTDbK06Ib6xGtm3+T48DVqLqGXTjdaxzxhHv/4WaoExBIMgaJCrnHiGd86ck=
X-Gm-Gg: AY/fxX6Nr1JkS2/LfB3KuG7imALeoQtMr6XL7exr21IRiTyLqllOSen7bbYB8JD8wgA
 tlDJiSZz0HaeqK11TS9fYNE8sSZ7J49rMPRnLqLWevEZZbYS1A1jE4YH3RHfgBb1sgsEDV3IsJ4
 qLvr2U4WfwqzSVtilu+4k+m7R3L+Yo52JoE72badTUF3hs20uUNogdsM032vTAA0R47nhg/F//w
 SGnBy0z6aHTzUVnMtC7kT6SBFxrQtvehiiHsVHoMoiHI4A8WqiCixCI+AafbZ2oso1wCPHNCkeE
 UemFCqanwfI7lqMTNPN4c/wMVIPbKP6DjMzygd+NPLh9JhpLTS4X5b4r3HdOyWlm3FCpc690jHg
 dsBpbSE8MH1DZNHyMkL2YxFhYHFKSgsSDDkRkbUFRio5UbqoQd2ephBTChJ709eUtAOlR80nYke
 SsRFVJRPnmrhIt/csWuCvTKnoW2clVGvFQXf7u4mr9N4hJP6uYjT8=
X-Received: by 2002:a05:600c:4fc9:b0:47d:5d27:2a7f with SMTP id
 5b1f17b1804b1-47ee3372781mr36431755e9.26.1768401523150; 
 Wed, 14 Jan 2026 06:38:43 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee0b89ee0sm24703345e9.1.2026.01.14.06.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:38:42 -0800 (PST)
Message-ID: <5ae1432d-b5fa-4f30-b58a-0e4b08de744f@linaro.org>
Date: Wed, 14 Jan 2026 15:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Added QCOM RPMH Power Domain Driver
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, quic_varada@quicinc.com,
 me@samcday.com, marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
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

Hi Aswin,

Sorry for the late response here.

Still a few minor issues with this series but it's more or less there.
I'll just list everything here rather than replying to individual patches.

1. Please rename the kconfig option to something more specific like
QCOM_RPMH_POWER_DOMAIN
2. Removing the fixup code will break msm8916 and other platforms that
use rpmpd (non-hardened), it should be pretty trivial to check if the
compatible string for the power-controller node ends with "rpmpd" or
"rpmhpd" and skip the logic in the latter case.
3. The commit "mach-snapdragon: fixup power-domains" should have a more
specific title.

I'll pick this up as soon as I get the next revision.

Kind regards,

On 22/12/2025 12:48, Aswin Murugan wrote:
> This patch series adds support for the Qualcomm RPMH power domain
> driver, responsible for managing power domains on Qualcomm SoCs.
> The driver is ported from the Linux kernel and adapted for
> U-Boot to enable proper power domain control on SA8775P platform.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v7:
> - Droped soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data() functions
>   patch from previous version, since it was already picked
>   Link: https://lore.kernel.org/u-boot/176363183220.2293399.7296647117885059868.b4-ty@linaro.org/
> - Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
>   when power-domain driver is missing
> - Link to v6: https://lore.kernel.org/u-boot/20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v6:
> - Added the change in drivers/power/domain/power-domain-uclass.c to give warning
>   when power-domain driver is missing
> - Added the change log 'In qcom-rpmhpd driver, the un-supported power domains are handled with warning
>   in rpmhpd_power_on() & rpmhpd_power_on()' 
> - In drivers/power/domain/qcom-rpmhpd.c, the 'ret' variable in rpmhpd_probe() is initialized with 0
> - Link to v5: https://lore.kernel.org/u-boot/20251027113312.3815169-1-aswinm@qti.qualcomm.com/
> 
> Changes in v5:
> - As part of "qcom_rpmhpd" driver removal change did in v4, the rpmh_write() in drivers/power/domain/qcom-rpmhpd.c
>   should be passed with pd->dev as first argument to align with it.
> - Added (ulong) casting in rpmhpd_match_table to address the warning.
> 
> Changes in v4:
> - Added all soc entries in power domain linux driver to drivers/power/domain/qcom-rpmhpd.c and
>   stubbed it
> - Removed "qcom_rpmhpd" driver & unused members of struct rpmhpd in drivers/power/domain/qcom-rpmhpd.c
> - Moved the "soc: qcom: cmd-db" change before the "power-domain" change
> - Link to v3: https://lore.kernel.org/u-boot/20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v3:
> - Removed OF_LIVE_SA8775P config in arch/arm/mach-snapdragon/Kconfig & configs/qcs9100_defconfig,
>   since there is no SA8775p specific fixups are done
> - Link to v2: https://lore.kernel.org/u-boot/20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v2:
> - Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN in drivers/power/domain/Kconfig
> - In drivers/power/domain/qcom-rpmhpd.c, the un-supported power domains are handled with warning
> - Power domain fixups have been removed since they are now managed by drivers/power/domain/qcom-rpmhpd.c
> - Link to v1: https://lore.kernel.org/u-boot/20250626112441.143064-1-aswin.murugan@oss.qualcomm.com/
> ---
> 
> Aswin Murugan (5):
>   soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
>     functions
>   power-domain: Add QCOM RPMH Power Domain Driver Support
>   power-domain: Add warning when power-domain driver is missing
>   mach-snapdragon: fixup power-domains
>   configs: qcom: Add QCOM_POWER_DOMAIN config
> 
>  arch/arm/mach-snapdragon/of_fixup.c        |  31 ---
>  configs/qcom_defconfig                     |   1 +
>  drivers/power/domain/Kconfig               |   8 +
>  drivers/power/domain/Makefile              |   1 +
>  drivers/power/domain/power-domain-uclass.c |   7 +
>  drivers/power/domain/qcom-rpmhpd.c         | 278 +++++++++++++++++++++
>  drivers/soc/qcom/cmd-db.c                  |  45 ++++
>  include/soc/qcom/cmd-db.h                  |   2 +
>  8 files changed, 342 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/power/domain/qcom-rpmhpd.c
> 

-- 
// Casey (she/her)

