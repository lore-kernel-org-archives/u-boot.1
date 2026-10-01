Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE40CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 23:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1EBC60863;
	Thu,  1 Oct 2026 23:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4bSCzqWdCYK; Thu,  1 Oct 2026 23:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0381A6080F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790897801;
	b=mwag7PS+wYa9HB1jtNUBLonQ9R+7Agkebbrd8YihqTVfBDuqeDAz7C2ZctF5RQoslagt
	 UjyJWMC5tW7oqT3T6flUsPndCSjXwfgRsChzFUijOhJw+UCQZyVZa0Oe3qz+ZPihMy7hc
	 FeL0YSoIL4kEkEUntvn4lV7QPf0/kMX0jc/WczmFtIdraCTW2ax0ENj1Uoric9CwI5j1v
	 vNBQR/FHbuRNv5tsErR7JWFRbpe6Yyuzaa2eS1pmSxf9EfIpyndtC+dV9v6HwpYFGX8RN
	 SXjDcMKg0con2r2vqEe3jLur1A/2BD3Hqxt+0g0Bg6OjGaMuCaZHIisPrzZ7ThMw3qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790897801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CVLdafFHfk7fb33AcHw9lIQSS9d4rak8LT/IkxV+hnU=;
	b=X3p04YkMAjctPvJyePUli9KvaYZv4KvM8uTtR9oYsdTkrT6/NXTH+oygYdKCSNnWsM53
	 TA00Lt5ioezRz7UTPVN1AIrP7K0AD8rmGlig3CmhQ1JTnei6AjdWR9FZkfv0GgQ29ShMQ
	 TogscphTrOvIcGpDCNGTpJn39pFv8NMJngxlCm5csy7UKPwxN7Cz55CDqfXseCO333aRm
	 28y7f2kthxiinoo0PeHt7SvY2qdw5nzuuwtaIuGi6Ru1vGOdv+Q8RMP+khwHnnJ8+W+y/
	 Mzx5YAbD7DBw4nPiB0oS93nbS6eqgLPTqDBV6vgeuI3KXlObM0RqjEvEBD0G+bQx9Rg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790897801;
	bh=CVLdafFHfk7fb33AcHw9lIQSS9d4rak8LT/IkxV+hnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtuaRi16yFZ1Bhqw9tsiJRuGsEXpBSmHcocIsqyMx2CMP9Y/YMKxZs1zXhkPHIwtE
	 6LOEDztiaTRQtaPX1sNVKDCtK7dKTX96jrnYQjoA0ENXOp/nfnCLxRc9MY8lp/3u3I
	 mcPHWoPo/1HX8NaD/KWPs1IPv3rBh62cWx7/ZFgzNlYXZZtQN8d2jGHIhMKWLoNo6Z
	 JyyykFH/tQdSiM44tuSN6d5oOvogMCuZXoGftnfNHtt4YV1NWnT/2Y2qx6H3AHv+Zj
	 DBtQn/z0NHXXLLtfT8QZPNgPD4eMmcuK5tF30nZ7N6g+KBuJw78+w2/hsr1FC92Fn/
	 +IMw4i9zr8S7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0381A6080F;
	Thu,  1 Oct 2026 23:36:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 831C43AC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 23:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FA5540B4C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 23:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZmuC4Xtkq1e9 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 23:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B16C240B48
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790897796;
 b=Zlr9zVb16wm09nxHizqvxQPE1/EWvzvvd+W7eBmGCDexKNU/WfHCEZwoZaglI7EKkEsN
 DCFxR0mihc4ik0GyvRylCpIpNWVlohXIABwZwjcbJuhni2iP8h9+MkDhNR5RGZYfJ5fD4
 9neuy4uRWxJFLUHrjWjr3s/zUF4ZwdLxLqh1zJu/V6olq3vA2wyvqwzWE9SAf4UrQmOYb
 /MzVBgEotzoBojfIPzWiRb3NIxX/hXA1DrbmIIicKYeyXchrXVHMyyzpKJtWWE2YXmoVS
 2GNCdD32hWUuKOhFAg7hKIY13OH/2bNAUsoIJsd45IY9S/wTfZ1SMiBuuKYf/Eh3lDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790897796;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=CVLdafFHfk7fb33AcHw9lIQSS9d4rak8LT/IkxV+hnU=;
 b=PaYMmFHI/XVG9d8sZ/t2ydlo8HIFvmf1oDu4jkZfbvtk3do3jc2teu3CPxONDx0ck9Z3
 zwz4T757qHrHCW8z08V2WJHiuTqG/iPRT2kX/a6c0fLEUzejP4ANuVMt6+wG6pK6SKKcN
 vb9nlRhshV5sNubXXS0xcFuepk3L+T+0LapLbLQud+Ta13o9y2DRCQ0Py2NRTvUmeerOC
 LuRc4Mb9EaRBwlzcItuBR26lDVk21xGHv0ZZFBqp65rh0drEZF3S0clnZ7aq/KmnF5bXN
 sI0+MC6NE+NpdQQEaNqs+K6A0Xlt/1rHJNb3StPhsaRsisVH/7ZmU3+N008e6JYJSWw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=js+xevZ6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=js+xevZ6
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B16C240B48
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 23:36:34 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-81b8e8e9cb0so3941042a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790897794; x=1791502594;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CVLdafFHfk7fb33AcHw9lIQSS9d4rak8LT/IkxV+hnU=;
 b=js+xevZ6Ais+LGwA00KDpfyC8lrx0viXOxr7m2f4Ys/lLEApzDgs0W8Ab9Xx/hb+SK
 LB/keiBg4TfGqXSzsumZ/jJSgTWuk3payTS7/TnbRwI/dtoa6kVKryAXILecSofGI01L
 Y5b7BdK4P7LnPH632R7e7kRQre/0MoiFNhQ3AWw85+O9ympmbXDquT9iN9dr8Jz5G3GY
 zeEZhTdE7SS7LhWlAT1RXkSzI7lwiopxAHFNxB3AkYiDt5EUbT25vgLarGVxdhdGwG86
 jlM0tHLNIRuG3tF0MXg78QDSmRYrP63vdSaIh3gacGEA8R8ZzApW4jfKUn27/0KmnDcN
 K9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897794; x=1791502594;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CVLdafFHfk7fb33AcHw9lIQSS9d4rak8LT/IkxV+hnU=;
 b=aWfaHp9V0QBY13QYh+lHto/tT9eeQHJTCQf/dnx+VtZ20uv3taPkuPMnK3XfhvXi6d
 HeeptOewf34SRJRv9d1Wt5dYYWbB/XsehlW5xwcdcILafYKvGqyOd41qFGWrJVS/dq1H
 0JYsBf6MDdOk6hrzLAfIoTIN88aEB4BupgOAZ5BVcAddyhQaGE/qfe2xiQZHxsKExZ8z
 NZw71qJFNR5VPTeg67gumYVEkOqpTslV/0ed2VvZkA0raevCUg05Yu9aYCwJwfFI0fOb
 6grdFJPQ1nUBsYdojXOdPRkcJJQsSI1ehpIi96fS9iVQHbvOX2QwgVQKCt/nZCwa0oQk
 MZVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWZNum5ShwVP8hLOnYm4Ejffose18XrqFo5U4da6oX88if+5Wi53EEY3UuoO5kXcHTdbYFzaw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lc73mJ1cCFiE1UGGMKnVaHkh8c9c3TUU+M1lA12SbdC64QF8HF
 wf2ffsWyRT6MPSGpBQUoLU7GYngMqL0+gK9LVzUoCNnH5jJxWm4sUeuLLm5a4J6L7ZY=
X-Gm-Gg: AYBFou0237441R1GvgL9F0hHtGXKIDhDiSS+BZcKkKt0x6sNOa5TFspH4zxhZqu3Sfi
 Rt94iZTB69A3TAP3/EHS9Li4jT1c7nuKHaGwpVAKmtPmZZK8pHVtszK0Bu99fYRFBLJsuD+tjlO
 UAa6bdAIDOD9o7JAJIVg3J5BXebO2gxamtiN2Z/FkM8lwRN2pihYutrFyXZ/CNXoej3SfszZIDc
 PsfdxH2+AOk/WmAz3F9fiJykP/SQxpv+te35H9lcycD9CPCYnl2CU3s3Tkh3WoLsBA0iBXt9psA
 abyyrFLmss2kfgNFlSIbotArvHAliqtlV3OqVSCcBPl0+15kOUe67SZPvr5/1kQ03NeB0SU0yTy
 1ICSY6rNvCWImSpQ8p+Kf6ivjif9mP4hxFklhkODhqKZ0Bc0R42snTPTc+WoHKpSdzdSTb4dUKr
 0ZZ4Ic+iz1vIcrlHgXZtfqrAFta1jvkVs7sz5CGi987TwRhYRvDBOB5LBrOdNOVL57SCzmD3qGq
 AakKDKtYQuSFbAXUmF7H+DMOBlFcg6RI/thux4xD4fnL+4K
X-Received: by 2002:a05:6820:806:b0:6b7:2cab:be91 with SMTP id
 006d021491bc7-6df2f6ffc1bmr981594eaf.10.1790897792318; 
 Thu, 01 Oct 2026 16:36:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b543:49c5:7c72:a244?
 ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3a2c4a26sm739493eaf.3.2026.10.01.16.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 16:36:30 -0700 (PDT)
Message-ID: <c6fbb920-b5d4-4430-9871-1e8ae128fc1c@baylibre.com>
Date: Thu, 1 Oct 2026 18:36:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] memory: mediatek: mtk-smi: support smi_common and
 the larb ports
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
 <20260928-mt8365-mt8366-add-dsi-support-v1-1-212f51b1742b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-1-212f51b1742b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/28/26 10:08 AM, Julien Stephan wrote:
> The DMA masters of a display pipeline reach DRAM through an SMI local
> arbiter, and the larbs themselves through the smi_common block behind
> them, whose clocks must be ungated as well. Drive it with a second
> driver in the same file, found through the "mediatek,smi" phandle of the
> larb, and reference count both: several masters share a larb, and
> several larbs share an smi_common.
> 
> U-Boot has no IOMMU driver, so those masters address DRAM directly: add
> a helper taking one larb port out of the translated address space, which
> the overlay calls once its larb is ungated.
> 
> On some generations, such as on the MT8366, the port mmu_en bits of
> SMI_LARB_NONSEC_CON live in the secure world, so clearing them from
> U-Boot has no effect, as the Linux driver spells out:
> 
> 	/*
> 	 * When mmu_en bits are in security world, the bank_sel still is
> 	 * in the LARB_NONSEC_CON below. And the mmu_en bits of
> 	 * LARB_NONSEC_CON have no effect in this case.
> 	 */
> 	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_CFG_PORT_SEC_CTL))
> 		arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
> 			      IOMMU_ATF_CMD_CONFIG_SMI_LARB, ...);
> 
> Ask the secure monitor for an empty mask of IOMMU ports, matching the
> physical addresses U-Boot hands to the DMA masters. As in Linux, the call
> is only made once the larb clocks are on, from mtk_smi_larb_enable().
> 
> Four compatibles are added:
> 
>  - "mediatek,mt8186-smi-larb", the generic fallback the MT8365 larbs
>    carry behind their SoC specific string, so a single entry covers
>    every SoC reusing that larb generation,
>  - "mediatek,mt8366-smi-larb", which the MT8366 larbs carry on its own
>    as that SoC is not upstream yet. It is the only entry with driver
>    data, since it is the only one needing the secure monitor call,

Upstream Linux sets the MTK_SMI_FLAG_CFG_PORT_SEC_CTL flag for mt8188 and
mt8189 also. So it is not that these don't have the bit. It is just that
apparently these work by default without it (at least HDMI on mt8188, I
would have to go back and test DSI on mt8189 without it to be sure - mt8189
is not added in this patch anyway).

>  - "mediatek,mt8365-smi-common" and "mediatek,mt8366-smi-common" for
>    the smi_common driver. Neither node declares a generic fallback, so
>    both SoC specific strings have to be listed.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/memory/Kconfig   |   1 +
>  drivers/memory/mtk-smi.c | 223 ++++++++++++++++++++++++++++++++++++++++++++---
>  include/mtk_smi.h        |  19 +++-
>  3 files changed, 229 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index a3b7c722070..772b315d41b 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -23,6 +23,7 @@ config ATMEL_EBI
>  config MTK_SMI
>  	bool "MediaTek SoC Memory Controller driver"
>  	depends on ARCH_MEDIATEK && DM
> +	select ARM_SMCCC
>  	select MEMORY
>  	help
>  	  This driver is for the Memory Controller module in MediaTek SoCs,
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b90f5cc135f..caba8b5c72a 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -1,47 +1,204 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * MediaTek SMI local arbiter (larb) driver
> + * MediaTek SMI larb and smi_common driver

I would leave "local arbiter (larb)" in the comment for those that don't
know what larb means.


> +static const struct udevice_id mtk_smi_common_ids[] = {
> +	{ .compatible = "mediatek,mt8365-smi-common" },
> +	{ .compatible = "mediatek,mt8366-smi-common" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(mtk_smi_common) = {
> +	.name	   = "mtk_smi_common",
> +	.id	   = UCLASS_MEMORY,
> +	.of_match  = mtk_smi_common_ids,
> +	.probe	   = mtk_smi_common_probe,
> +	.priv_auto = sizeof(struct mtk_smi_common_priv),

nit: I would not bother to align these. Alignment tends to break over time.

> +};
> +
>  int mtk_smi_larb_enable(struct udevice *dev)
>  {
>  	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
>  	int ret;
>  
> -	/* several DMA masters can sit behind the same larb */
> +	/* one larb feeds several DMA masters, only the first ungates it */
>  	if (priv->enable_count++)
>  		return 0;
>  
> +	if (priv->smi_common) {
> +		ret = mtk_smi_common_enable(priv->smi_common);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	ret = clk_enable_bulk(&priv->clk_bulk);
>  	if (ret) {
>  		dev_err(dev, "failed to enable clocks: %d\n", ret);
> -		priv->enable_count--;
> +		goto err_disable_common;
> +	}
> +
> +	/* as in Linux, only talk to the secure monitor once the larb is on */
> +	if (priv->data && priv->data->port_sec_ctl) {
> +		ret = mtk_smi_larb_bypass_iommu(dev);
> +		if (ret)
> +			goto err_disable_clks;
>  	}
>  
> +	return 0;
> +
> +err_disable_clks:
> +	clk_disable_bulk(&priv->clk_bulk);
> +err_disable_common:
> +	if (priv->smi_common)
> +		mtk_smi_common_disable(priv->smi_common);
> +err:
> +	priv->enable_count = 0;
> +
>  	return ret;
>  }
>  
> @@ -60,23 +217,67 @@ int mtk_smi_larb_disable(struct udevice *dev)
>  	if (ret)
>  		dev_err(dev, "failed to disable clocks: %d\n", ret);
>  
> +	if (priv->smi_common)
> +		mtk_smi_common_disable(priv->smi_common);
> +
>  	return ret;
>  }
>  
> +void mtk_smi_larb_port_set_pa(struct udevice *dev, unsigned int port)
> +{
> +	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
> +
> +	clrbits_le32(priv->base + SMI_LARB_NONSEC_CON(port), MMU_EN);
> +}
> +
>  static int mtk_smi_larb_probe(struct udevice *dev)
>  {
>  	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
>  	int ret;
>  
> +	priv->base = dev_remap_addr(dev);
> +	if (!priv->base)
> +		return -EINVAL;
> +
>  	ret = clk_get_bulk(dev, &priv->clk_bulk);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "failed to get clocks: %d\n", ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	/*
> +	 * Not every smi_common block is handled by this driver: where it
> +	 * isn't, its clocks are already ungated by the time the DMA masters
> +	 * run, so having no device for it is not an error.
> +	 */
> +	ret = uclass_get_device_by_phandle(UCLASS_MEMORY, dev, "mediatek,smi",
> +					   &priv->smi_common);
> +	if (ret) {

This would ignore fail-to-probe errors since it caused the device to be
probed if it was not already. Should probabaly only allow -ENODEV and
-ENOENT to mean that it is already bound to another driver or there is not
such a node.

> +		dev_dbg(dev, "no smi_common device: %d\n", ret);
> +		priv->smi_common = NULL;
> +	}
> +
> +	priv->data = (const struct mtk_smi_larb_data *)dev_get_driver_data(dev);
> +
> +	return 0;
>  }
>  
> +/*
> + * The MT8365 larbs also carry the generic mediatek,mt8186-smi-larb
> + * compatible, which is the one matched here. The MT8366 ones only have
> + * their own, as that SoC is not upstream yet.
> + */
>  static const struct udevice_id mtk_smi_larb_ids[] = {
> -	{ .compatible = "mediatek,mt8188-smi-larb" },
> +	{
> +		.compatible = "mediatek,mt8186-smi-larb",
> +	},
> +	{
> +		.compatible = "mediatek,mt8188-smi-larb",
> +	},
> +	{
> +		.compatible = "mediatek,mt8366-smi-larb",
> +		.data = (ulong)&mt8366_larb_data,
> +	},
>  	{ }
>  };
>  
> diff --git a/include/mtk_smi.h b/include/mtk_smi.h
> index b0166b37538..4c904d8bfe1 100644
> --- a/include/mtk_smi.h
> +++ b/include/mtk_smi.h
> @@ -15,8 +15,11 @@ struct udevice;
>   * mtk_smi_larb_enable() - ungate an SMI local arbiter
>   * @dev: larb device
>   *
> - * Enable the clocks of the larb so that the DMA master behind it can reach
> - * DRAM. Calls are refcounted, so several masters can share one larb.
> + * Enable the clocks of the smi_common block behind the larb, if any, then
> + * the larb ones, so that the DMA master in front of it can reach DRAM. On
> + * the SoCs where the secure world owns the port mmu_en bits, also ask the
> + * secure monitor to keep every port of the larb out of the IOMMU. Calls
> + * are refcounted, so several masters can share one larb.
>   *
>   * Return: 0 on success, or a negative error code
>   */
> @@ -27,11 +30,21 @@ int mtk_smi_larb_enable(struct udevice *dev);
>   * @dev: larb device
>   *
>   * Drop one reference taken by mtk_smi_larb_enable(), and disable the larb
> - * clocks when it was the last one.
> + * clocks, then the smi_common ones, when it was the last one.
>   *
>   * Return: 0 on success, -EINVAL if the larb is not enabled, or another
>   * negative error code
>   */
>  int mtk_smi_larb_disable(struct udevice *dev);
>  
> +/**
> + * mtk_smi_larb_port_set_pa() - take a larb port out of the IOMMU

I assume that pa means "physical address"? Can we put that in the description?

> + * @dev: larb device
> + * @port: M4U port index within the larb
> + *
> + * Without an IOMMU driver the DMA masters address DRAM directly, so their
> + * ports must be taken out of the translated address space.
> + */
> +void mtk_smi_larb_port_set_pa(struct udevice *dev, unsigned int port);
> +
>  #endif /* _MTK_SMI_H */
> 

