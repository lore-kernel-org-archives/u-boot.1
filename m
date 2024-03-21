Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDDEC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 17:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF26880FD;
	Thu, 21 Mar 2024 18:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XQUwHHGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C7C880FC; Thu, 21 Mar 2024 18:05:55 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 713A6880DB
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so17237111fa.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711040753; x=1711645553; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SsvZf25TnjuCLi2GIb8few/r+YhQoMiV09fkFup3Ikk=;
 b=XQUwHHGfbnCEqs6xn4QUoJG5R+adDv+ygx7DFCxYxaxPS8jp22FeOtEYMVXjfXp95C
 sy97DvvvvYsJzohdMC3YUF3zG9SKfz5nlRsGM6qSNzb6ttloTo9wcI8AXfkamVDr8oCt
 s3Zj9jpTFlT/kQ0Cpw/6Hg/Ea3uR7W1eaeRylU/0Mqq64/ITgfsT0r2pngiXzTFUUaJ3
 9Kzanj3e7C5EV89P5uyIs3xLw61AUXFCmigCy9HZD8yKqTXc41IIv5A6ZyPnDpuZ/ibf
 mp5abNWHq0ugFTljKwuAnHb2/sB5M/s9XhVPDr9e4xQaJyPq/gxs4A4myQ/FO5FrQIaW
 tsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711040753; x=1711645553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SsvZf25TnjuCLi2GIb8few/r+YhQoMiV09fkFup3Ikk=;
 b=FHq4QccDydWqpwosvPnohZnfrhfIP7roLupYE9waI78Ym+a5j8N4DlYusfw5d2Oz6Z
 4Q+inkq1YkLE44yxjGsnhP2WNsiD1doJ4vlK5AwYG3ySjfBVfP6BnRYfKPbFu0+COk56
 UHrjahvRCoh/EZr1GGgNhC3XhV2SvYXpRldwp6T4Lm3H5R1tZjmZVGiLLSZRyJC0voIa
 2lQ9ck/AlyxhnL2uRJE6EOlCuwjwrqtV496PUbpbQ2/K1Gv2LaRgbLdBFdQUoguN739F
 SFQz6ziFRQHqe6HWv7I39s3mOoJIdBFw/ep62SoeBXLbKdgVUmmOKo/0yyN0HvcYzlak
 ThRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeNPs74q5SYgVgbDB2122QhaVgD/1M/Iv6AAuwzPhixWF7Mn6RCo8TiFzadCgiI9jA+FN/VjHeixMpuaKWXuAY5YMqew==
X-Gm-Message-State: AOJu0YzvV4VPQiFuL3tvfDO4hmqnAxewaQK9/29M4/13LCbmjtbs2z1u
 EsgSbzhZ2FhFYUpDRZmBa5/Udryqborx7q4Qmz7L/QVRQ8h+0DPmevjbb/+j5UE=
X-Google-Smtp-Source: AGHT+IFir37/21zyVRN/5j9BKGBkShaPOWldeJJnXMOdereVTReDuAbVDm/Wu+I8oWv4uwY/KOFgZA==
X-Received: by 2002:a2e:8608:0:b0:2d6:885a:d3fe with SMTP id
 a8-20020a2e8608000000b002d6885ad3femr85396lji.30.1711040752705; 
 Thu, 21 Mar 2024 10:05:52 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bd6-20020a05600c1f0600b0041330d49604sm6212462wmb.45.2024.03.21.10.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 10:05:52 -0700 (PDT)
Message-ID: <9bb30db8-08d1-49bc-b89a-6c3bd4d898db@linaro.org>
Date: Thu, 21 Mar 2024 17:05:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
 <b20f5e01-d45c-402c-90e2-9593558bbeaa@linaro.org>
 <3fd317b9-6bbb-4ef2-b806-9e364b4e06de@mailbox.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <3fd317b9-6bbb-4ef2-b806-9e364b4e06de@mailbox.org>
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



On 20/03/2024 20:18, Marek Vasut wrote:
> On 3/18/24 1:47 PM, Caleb Connolly wrote:
>>
>>
>> On 17/03/2024 04:42, Marek Vasut wrote:
>>> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
>>> this into DWC3 driver. The OMAP implementation is special, add new weak
>>> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
>>> handling should be called, and override it in OMAP DWC3 code, to repair
>>> the special OMAP interrupt handling code until OMAP gets switched over
>>> to DM UDC proper.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Thank you. If you have a hardware with DWC3 , can you please also test
> this series ? I am afraid this may break things, although it is likely
> to break mostly select MX8M boards.

heh yeah it looked like it would be fine for qcom, but better safe than
sorry :P

Thanks for the ping.

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # qcom sdm845

-- 
// Caleb (they/them)
