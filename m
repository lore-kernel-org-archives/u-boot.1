Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C77BC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 19:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C142D86537;
	Wed, 30 Aug 2023 21:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pyQmvhXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571FD86548; Wed, 30 Aug 2023 21:15:40 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73FB8652F
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 21:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so180935e9.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693422937; x=1694027737; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSrRxP5i12OOCf8bZO6fm7DHUydpNk/O7ILcGjdyQfE=;
 b=pyQmvhXXfjS7BcefinKiyA/vNAJJrB2f7yEKfbK3UAleWCu8b/c0sWZcqeshWuMtxp
 NPtwKb1/YNnZ3lrTEwtJ6GfilnHIn1gBHbKOQCCrezC09zrjMFLw0Nfz1BS+FaoKG81V
 USV3WvsUy88KaINFGJkkbGXI2l3mqJdUCcSlOmtdUMgFqcOYwAhTWpUGdVt2IGuvZ634
 Ag7bdQx1u/yONv+mir/fFowON6P6ZzLWV7PV7aDDEENscBOGiy7xDHSuSQIplBw+C8+3
 7vhgqs5JbGOXM+/Ygp7Y3nXz26+Rq3OUztbMuaVt34mD50jA4V4SabyHcPjjhSNm1LqY
 8z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693422937; x=1694027737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSrRxP5i12OOCf8bZO6fm7DHUydpNk/O7ILcGjdyQfE=;
 b=CDQoCvQT3kItNBqNdB2i9CqsJyKXQKgnLmpYV00rU+mc9Zswo+vHSXq0d9e/l14Zk8
 GDnpHpwSEsVOGK9bncywVzS1yVs2qqdmvVM3y7AW4tnvrR31cEUJJJ5etmeatXCAovQ+
 ZcwDfHsx2OwvDOozpLbdXREuyE27PNXv3ia681qWyqZaudbTyZyFvdwxo/bKA6OqJdNb
 YauHYa6uIBK95iUWcQCl4ccNOUauGS0jsLCVc2xfG1ss6kwg+oTs9/UjMgul0GHrp3r5
 6A0kvCIlAmMYiRQ5OP2wWeEshJLhZLLyzCRO8EXuFovtuhitRR9r196ROd9HiDagyXCT
 lRkg==
X-Gm-Message-State: AOJu0YyTUhy15fsLlf1vk02Dfaz+ahANggqbXMiF4/hEOcmmB6S5ggat
 SdO2S13kX0l/5G/fYPa0VDk=
X-Google-Smtp-Source: AGHT+IF8f+KkXGTY9P2CIDKCaXBNmHiiL/A8AE4+KO0xT0Jis9cwP3Usxdq8vKw+vtCz6T1XWL/3Pg==
X-Received: by 2002:a7b:c849:0:b0:3fb:739d:27b2 with SMTP id
 c9-20020a7bc849000000b003fb739d27b2mr2747517wml.8.1693422936880; 
 Wed, 30 Aug 2023 12:15:36 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a7bc7d1000000b003fc0505be19sm3071178wmk.37.2023.08.30.12.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 12:15:36 -0700 (PDT)
Message-ID: <3bae5070-e99a-4179-a59c-833c9a2971f5@gmail.com>
Date: Wed, 30 Aug 2023 22:15:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] dm: video: Add damage tracking API
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, Anatolij Gustschin
 <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-5-alpernebiyasak@gmail.com>
 <CAPnjgZ20VRYsP=5S5HJWjR2sNvmOudseHiXUcjnZmDCA=0jfnw@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ20VRYsP=5S5HJWjR2sNvmOudseHiXUcjnZmDCA=0jfnw@mail.gmail.com>
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



On 2023-08-21 22:11 +03:00, Simon Glass wrote:
> On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> From: Alexander Graf <agraf@csgraf.de>
>>
>> We are going to introduce image damage tracking to fasten up screen
>> refresh on large displays. This patch adds damage tracking for up to
>> one rectangle of the screen which is typically enough to hold blt or
>> text print updates. Callers into this API and a reduced dcache flush
>> code path will follow in later patches.
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>> Reported-by: Da Xue <da@libre.computer>
>> [Alper: Use xstart/yend, document new fields, return void from
>>         video_damage(), declare priv, drop headers, use IS_ENABLED()]
>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> ---
>>
>> Changes in v5:
>> - Use xstart, ystart, xend, yend as names for damage region
>> - Document damage struct and fields in struct video_priv comment
>> - Return void from video_damage()
>> - Fix undeclared priv error in video_sync()
>> - Drop unused headers from video-uclass.c
>> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
>>
>> Changes in v4:
>> - Move damage clear to patch "dm: video: Add damage tracking API"
>> - Simplify first damage logic
>> - Remove VIDEO_DAMAGE default for ARM
>>
>> Changes in v3:
>> - Adapt to always assume DM is used
>>
>> Changes in v2:
>> - Remove ifdefs
>>
>>  drivers/video/Kconfig        | 13 ++++++++++++
>>  drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++++---
>>  include/video.h              | 32 ++++++++++++++++++++++++++--
>>  3 files changed, 81 insertions(+), 5 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> But I suggest an empty static inline in the case where the feature is disabled?

You mean with something like #ifdef CONFIG_VIDEO_DAMAGE, right?
