Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E01BC79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 19:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DB40811A8;
	Wed,  9 Sep 2026 19:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5eJBeurqTIMA; Wed,  9 Sep 2026 19:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A5EB2811E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788982561;
	b=D0HL4LV4HpQA6kDb9YiNxUodKWnGzq/mgTedhYU6grjGxHr2Ctrk8/1+GypHI4/kfH1m
	 Fkeb0ULfGpBHkrbMp1v8a517GRg9InEkuxTVMVo7NxmlDU05jBrOMAj1KhBDaVltWSUw8
	 Tf1cSV1UYnEMWXViS4XtTmsB/IUkhOpCCoHjGYaSH99nOZ+mDkoZ6cCuf1UTaWoXbNBBr
	 LdNHIejHwhbf7G9gxJ2VRl3HnzznjGCc1YVbOQw1hYlY3ZdWepo3ytUinGlVr4qs8c76P
	 ey4IL0BSww4lrTUjUAke2ynET7xD6xCcV2QZATk6yY57bmGFOvjAAcbgarUcAjjpkYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788982561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yPTP2uepErgLlE4tsQ6Vvo3zFXCnQ2m7+2TnLMvWV+8=;
	b=SZf0X1NEn7PPS26DJmtEQepRikF4YG/gAiRRVhee7Ix3w/vmZXybQcs0WKZA/z7uUF6f
	 /Df5nfugHfqMBAj0l2v1spH7fov7tbhYFlz811cP5nX+HuW128sFTBREkjo7uel9+wxZN
	 LF11C6ndxOnbqGkahmIZSTUIwdvvq+4k7N1Sm/OoxQMuAy8l4i6d532G3bSM7oPUyxDGh
	 l4eTr7zwuzi8vnukJ99Dmpdyw2kRo5G2rGp4vVGND6qTleNRPhVzgNXcHUPxnaM1oocFa
	 PeVMWYGXv70wulV0s0zsAjIOMSCutOXV4WdgeVhqAgdztVQI2CfeXRknlM72mr21GvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788982561;
	bh=yPTP2uepErgLlE4tsQ6Vvo3zFXCnQ2m7+2TnLMvWV+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g4HfEeviJB70/rR5iDOTSw9XVcg9IxoCcohp78MnpZxnW5SnKYxBJciA7S1lB24rZ
	 GnkGvtRqWIRtUamrutCDmB5eQ6AWrqgJHcBZFBRI6qqHxsfGEjA2ENtsIgr+qviKln
	 miYef3792q5zkMv8n2SrmCQ6R2kr8iNH1jquZ1XMF+cem2D7DHZWCCEvQEuJ+hIC7A
	 pXF+bbzpxeCrCKdtIy5SqXErcnyJPmKwoWNZPRX7P4MjVzs/ORTcTPQPvvd+mbMwGZ
	 D7CzKOS0zBOBVnBMlxihNamsnNF9qegPDcIx6Qqp71OQRqk3zwME/DopDzRzu5TmCq
	 uv8cqKA/CJIVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5EB2811E2;
	Wed,  9 Sep 2026 19:36:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 258573AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B73340AE3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9l5OCtN0Uqj for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:35:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC3C740A3E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788982559;
 b=dRfwnNdtSOYeZNY1Gc+eETyyxahM8R/PoL1l9xxYHFj9gLdik7AKhg27DJOHVEdt+h4Z
 5bjbAl/PyCsYo/8s+inwY2WXefWYhv0I1T47LFvTWcf+Djsmg6Py6PYWVZyqwJ0qHOZjo
 x8k/Ub+tByrvyazQlUu+G3ljsK2RbnST9Z8fANTbiPNyhvJtvKdA6vvkJM1UfF8Sd5fZC
 Vk99bHmzp811u6m9DzTF3mFMQfRpsA0fjj+BpK+0b1c1UuKJm2rh4SmhXxmPqje4Plc7d
 DhWz3+Ua7jU38E5iiBV2ltwhcBtJ26//+U8FT7yq1GqZaKOB3wT3d9Hlnp7JJHmrHmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788982559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=yPTP2uepErgLlE4tsQ6Vvo3zFXCnQ2m7+2TnLMvWV+8=;
 b=DUF1aWemPT4vlpOqE01pea/IhsxB2tat53jD3iiTwHd0KEIr7RpCJ4WW10fSBGI9Zcvb
 +FET+fq8AbiCa7gzVm/ZNSYvRKCusIRZzsANCZj4GOSyioNKhkmJUHaikDc0LvYaF9Erc
 FV8eb8puvEjOyzbjLY3E7zFRR5EpDmBEuADIJzNj2KtuH6AalHryD/99r13tujbSGgQ34
 t7z00oXLYMHPhx9dq7BxBIJIftnT78gzFC/ulqLOJLp2dLfn3wruVEXot19lFTWyhKdfV
 cLDkJ75NQVGIvJrxSQwrKStRyH4r4KBXaWVM7ascxULlwr3Z3cs24KiOzs+skDF3GmA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LB0zmXhH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LB0zmXhH
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC3C740A3E
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:35:58 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-7fcb425fb6bso436393a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788982557; x=1789587357;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yPTP2uepErgLlE4tsQ6Vvo3zFXCnQ2m7+2TnLMvWV+8=;
 b=LB0zmXhHvCtRz+SBWh30d9dxFVgEmCWC2nRqZumLkWTS4jp+mMQF40gOJ52pZjYTqZ
 KwHAiDtzEDjYxLf1BzPiiWG2dOPuMakG666suc41gFrGUY4h1z3dzwerdbP4ENmPF3i3
 1+2B4/ioccACdcKVGZ2beXuQnCvELP77dI0HI4rlEwL6uLIez9iqoUm+14mQvLGsVSz0
 WdtW7Z+y8Rtw++wCxBOkTQohDpNJD67BMUFU4RJj20LJCq2K7vTmP08Km83CcdwZDclT
 BBar0uokSg/lf5dNPldepSHfyu4rHrOS8yHJRjonXKzPn3MMrZdsQRIZgaKwXscJ4/nW
 JTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788982557; x=1789587357;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yPTP2uepErgLlE4tsQ6Vvo3zFXCnQ2m7+2TnLMvWV+8=;
 b=Lpw5K0luS9oS4SscIuHa3l+XaQ/K1+YZLZcIZFlEKdibZFQ/znPF6rXE7hFkdHThfY
 7qlE+QVJxRscEItv+qNYkCp4tGgm1TVOZPiZD0R3+ja0qLR+tzn3rDmEcGQjphmDjTAU
 BMQMOl+XUihEEqTCQMemlwUPCUgIPeH7/JhDUZZ62c6NmFauCGcJyP2Y/1jBKIPyk5af
 hB2uCet7MTvMwUoOREPtSdB4xB9wdXAFEnmjvSN66AnbSGco2ZeFGSM5JqOR6Q3tgxzr
 Z+9tWLc/cDLxd92ALrpNUDoaKohjvQQuYH2PGFXCrHiNQYFsSwKzXPEC5nPD3uE4glpa
 pvEw==
X-Forwarded-Encrypted: i=1;
 AKwUvByVMa0i0PO/58NYyOGklXyGoQeF3Kh9dhQ6qTz7xqlIdM8D0MZcM56/Tm8zBAmZi/ehf80SKS0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mcXJPiNzpIIcFk7GGBeSR68adHn/zCETY60X1ds1grk4tHsj9J
 EeUf8ROeZIMlwrnXr2++nMtc38X4g3Qu5AynbUjlOlYCmHZdKTbYMg21Dxm9ukVsm1o=
X-Gm-Gg: AYBFou3jG9e2bp+04yAQTry52/m77dfdBsPg3ZcqOhvfYAQYAjO2HdXLYQw9j3BlDjQ
 Il8eNYAc5UIHpsRFJ0DUNeZ0WJ5SUb+Lj5NCTOkiUktSCaqbwqnFUle44kuMSBxn+F9uGbcn2BO
 dtGGnCKjOzMHbOhWh5yjjksIwvrL/K/SbQdAPQYFp512LWkuMegBf1xNfh3BiOU0hpihnOVFNKM
 vQHsnAdOYEUPpI+NO0akepaqTYJog5cuwsFLdDZeLyAXzRpsEOaUaD1I6yN3iVBADa1nhk29zfm
 GO2OCiHxhKw8EBSjDCeI69t/PBMzW6CqiPz6GlNy50Fl+nS6QnPL/5NByyduc0IKXhqnojMBA0s
 iMd7wJPSaTg36YXu30DpCXmaehZ1XYVaYAHCxUWdLCXJuGPlaCtYa15uKFmdNkEocvKdfRZkCTj
 9xYPTGrc8qw35C5Y1KJetqeI6AdE8Twt1gzg32RG6soZd9yp08jbAdhw3wKXUKq+SNXTc6j1F4y
 Wx0dE/VKRotPbTZvC5VjxNHkz3AFQYktiAdJ7AU65mL358=
X-Received: by 2002:a05:6830:67c8:b0:7f4:ea33:8f56 with SMTP id
 46e09a7af769-8020e9fefe0mr3832525a34.6.1788982557241; 
 Wed, 09 Sep 2026 12:35:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f6da949asm17614466a34.12.2026.09.09.12.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 12:35:55 -0700 (PDT)
Message-ID: <a5d869be-80f3-45fe-a312-615a0d7b4dcb@baylibre.com>
Date: Wed, 9 Sep 2026 14:35:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] configs: mt8188: enable eMMC FIT boot from SPL
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-2-4d4a11d5741d@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-2-4d4a11d5741d@baylibre.com>
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

On 9/6/26 10:30 AM, Carlo Caione wrote:
> Enable the shared Genio 510/700 SPL path entered by the external DDR
> loader. Keep BSS after the downstream SPL reservation, leaving a 0xc800
> guard after the copy window and space for the initial stack and early
> allocations. Use an 8 MiB heap for loading the firmware FIT.
> 
> Load BL31, OP-TEE and U-Boot from eMMC partition 1 using generic SPL
> support. The MediaTek BL31 stalls when given a runtime devicetree as its
> platform parameter, so pass NULL there while retaining the standard
> firmware entry-point parameters.
> 
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  configs/mt8188.config | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/configs/mt8188.config b/configs/mt8188.config
> index 29e2b3db878..a7a59940646 100644
> --- a/configs/mt8188.config
> +++ b/configs/mt8188.config
> @@ -28,3 +28,36 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y
>  # CONFIG_RANDOM_UUID is not set
> +CONFIG_SPL=y
> +# Fixed destination and copy window of the external DDR loader.
> +CONFIG_SPL_TEXT_BASE=0x40000000
> +CONFIG_SPL_MAX_SIZE=0xaf000
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +# Preserve the downstream reservation, with a 0xc800-byte guard after SPL.
> +CONFIG_SPL_BSS_START_ADDR=0x400bb800
> +CONFIG_SPL_BSS_LIMIT=y
> +CONFIG_SPL_BSS_MAX_SIZE=0x10000
> +# Leave 448 KiB above the BSS limit for the stack, global data and early heap.
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x80000
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +# Keep the heap separate from the loaded firmware and its reserved memory.
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_SERIAL=y

> +# CONFIG_SPL_USE_TINY_PRINTF is not set

I guess this is for SPL fastboot support later?

> +CONFIG_SPL_PINCTRL=y
> +CONFIG_SPL_PINCONF=y
> +CONFIG_SPL_WATCHDOG=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_EFI_PARTITION=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> 

