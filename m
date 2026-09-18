Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E55C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 18:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63F9440B2F;
	Fri, 18 Sep 2026 18:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLY6r1gFH-Ye; Fri, 18 Sep 2026 18:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 56C8B40AE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789757243;
	b=PNt7MD3kO1k6EJxfo0rdxycryrOGKs8D4QVzRChucIAIT1qwbFMkpfBQlboO/0DhwrNG
	 ti9YlCgRq8Y56lvfHkw/7bUIRJvsKuG0+Ox+fwhu+CP6hCiInURMKOMGTr+vaxZSTuzab
	 ArumYAnmHAyslfnl5GCYDsfJeSP7vrr/F0Lo600JceofhfSXDcmGHeukC40JUgc4DuNBV
	 6a3nJDiTnnwnBi2HXsybU3r1dwdG9tPkch68ijepHoaxz7iUfz13GhM5J2lCmX436NJlU
	 kjLbTD1QYgui+ckvh89MB+qQ54+GXgY110Q4AP7GYLegor1zXA1g0eerqzUKxoio8zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789757243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9KTUVb93iiyK1UHVv0+zE0QuZhMcWpoYsf+FcjgUFt4=;
	b=d3SRqcuJifPDzanpe1A+cLg3qVJneyvssXqQR9+IgNDE31Qx4KxvTocKBAZVq20Uif4p
	 h0OLL9caDsg3Ttr90lJonrDrVCJMiYpjMNAbJIYd8tEnwquvSh++V/jPnSoiWAZ6BC02g
	 mvRQ9UcvuhgbfByKEDiS2Tgon/CZazsbRR7KC4WYUYDviPGC26WGTTmFZwOnZ2cAfWV9c
	 vkI/6j0E9KQM6gtBxacWbWmDrdadXP9hgvmpYvIRF1QIWe3UOGvkh/ACZqz0jYxdkaUtY
	 jy1/tzwDiYtRto++2XEnEbDFp+riGNDm87mWgdLzw/7FfX5XkeLMQj6ODtI93LVGWwQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789757243;
	bh=9KTUVb93iiyK1UHVv0+zE0QuZhMcWpoYsf+FcjgUFt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bsTktLSxalsWb4Cr1HmJc4Amjfdl8z44MKItUWJjoK8Y8GcGJy9PKuwgsIH/B4jRz
	 mG0KswRHNfPeESh2Flyp0F5AGK/5/Lyhx3XcvX/5KFUGp1HS/If9yF4T0F4d8kJGvG
	 xQzs258RQT3qZTMqsaelwdPa/PHkH1FWSNHvk4mMx1UydG8BFojIrwcRT8DGBN26J/
	 OZ05jYUT3gVu3YmVfzOwFs8sRwESZeOWy6BNEEn6jQTf2sn6+i4yc1zfUs3sju7o+b
	 Qf3nNVNTMmNC3LfbfepSWoE+Ra2fVueLg4kbg6V0zfNZIAO5gB0Tb8y6te0JFXBSz2
	 LIi5wKtvmNzpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56C8B40AE1;
	Fri, 18 Sep 2026 18:47:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23684237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1592C6064F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_DPhEvuQsdG for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 18:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9BAA76062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789757241;
 b=CjDKJWk9QD5GOHKHEC6BQPPo2cyfUAthZe2+RG61Rkwr0dsmEwQBMqyO+gx2oC3DZCvR
 4kkt0gslKrC3R4GXAqOVmiOaPOK78EHXbp8NkOmMQgD2z//GS0pznd1O2KDCYvvypjN2x
 Xy67obrB9H5IDezpDTlSBJWEGYDkqQdFJ9cwe3o1XkyYa432ctkSX7emEHdLnkzZ1ADxv
 boBTtQYq02h5rtFqr4U7Soti2ZUITT2nsSufy1oP1Nx7kYQgQtQ7HfeZ7nUWyD3IO1Pml
 W+7+FBqcgUzPbgYWkNqQ0dnW5Vk8Jezk6rJPfhL5SYkdQTXqKodzb6C5AtVw4L7WsUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789757241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=9KTUVb93iiyK1UHVv0+zE0QuZhMcWpoYsf+FcjgUFt4=;
 b=l0Adx/OFlwbunSHHagUZdriAuoOerAPG01eiAzYXKKgnadcgn2nMAMO16hFwbtM1iG7s
 YxZHp1WoDrhy7m/Lpz7x4s1H/FjkI2VjSjmcnwxSNMOU0SFfhtbK1JWZFjElxZWBcE/uo
 BpW9NIyiHFyZZaZlq9C3DaEfyNYE1eF06yZpPgMPkUgQsoZRN4ucUHQih56s969iaUMAj
 qhYCWBEQKOXmfdYdAwAQrEUxNiJJt6pgGPy/J/k/LSzh9ccjUqOZip7LtOZWC8uIxmffH
 uB8pG3jEr+0cgBv0owmhDJJlNmkSfuqc5vahjd8ZREhwtpwB8NsYmXmcMqUQVyS5HFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Cp+h7Cdz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Cp+h7Cdz
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BAA76062D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:47:19 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2dd68a16955so21051615ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789757239; x=1790362039;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9KTUVb93iiyK1UHVv0+zE0QuZhMcWpoYsf+FcjgUFt4=;
 b=Cp+h7CdzQdaA/nLLt4LiPAuuvPxMNabHqhc2DQd9kkcB0Jkkj6VJ+Lm+nelZE8oTAr
 49ojwrTH6cJUlw38QhI+unyWACqNURwNXjrDc8Sk0zgJFygRhLl/yNb/bz1ICbEiCUH5
 dwKD0ddQ64V3d84t09e7LRUwYm503mkCKTW4uTQVhezxfD1cEroXfBe1qgUEd5LZr6Gb
 AN2K0rndihzKXqhaiHenG5hfUOpgGiEo3jVvHzIZiluBqSmUs+SSRbwxNT5jPOXqvPpU
 gCjAuky+TUx/e4LZXCMTI/XFMyu7XHbUWF/HUhsYe2ve/WnUncfQKblSiYKQwEAhQRMR
 Q6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789757239; x=1790362039;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9KTUVb93iiyK1UHVv0+zE0QuZhMcWpoYsf+FcjgUFt4=;
 b=kP0/pjCQH1eB0yDJB4dzqLVxvW+Bpv7Os3lMRP8Tk1P3x2ktbsFACSsRpsaZotHCOE
 084IItHWUc0OG54vZLMXu+aCKIaJwH4bKWn8oDWAxaeIcLJNx7WixnjTIJ8MecuY1fHt
 lIbnXJvhoQb8wQeC596siAy2JVCP4L3v01yldKTITY/eCaU7ICvbeUJOc6uB7WT5dvrG
 bnx1+/4z34CN0lZeQExqrEdx6nLkNg9p13Eec3H5Qmp39cHyTQTsst0ISlEdnuh0Ze7f
 re1TKL3MdXHxf3s9vyGhpSj3RJ1EUnh3zh68bFwi5jlWgNnr1HpZAIMuofP7WKXgM6C4
 uPbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqzwP/JGHzzIneReeUJ7aaOv6llD0v5S0dBA0bdM8I1bGWZ8SJeGyuGzhGvCuI8/VZgCs2zYc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m2wN5H3q3xsgM6mbHrq9AD/GFPeXNVDYV8t4U+gDQ8MTANpRQe
 O06t/KkgsC0gR/n4tj7x5u9Ps5qEccZXCtpiLA+XrW92Fp0bv3Upp7MnF7+ogF6n7hs=
X-Gm-Gg: AYBFou1uZWJq5FD6V1DwrvvnKS2BxZFn8GkWxv5FbtSTuTyAyA2XUQhFKWHozx47Rfa
 clJLZBV64sKvFqk3EDyCbyPjctPFBWxW3V5huqE7bu7hvE7urLbE2o6CiuN1VbQdAEKehxEUIqd
 R3fWJRHC/3PHNnY17570l2QrphTb6nnw+HElQoGZlkAdNHIdOWvuvy+hUdS9t//RcQ0xRerKCSi
 bC3VNBBYpwhHzcqWfZkK70PdFs17PhYbW2JcPU4jFcuL6H5/bQyOzCLAUxPCFwhc+cjDgUp7Fbd
 o38uIE2h6C5dLPj4tMpd9ZodbjciH71HnWrGqO8ipgz/bi9VXVoKxEQSBQZxjveX8njkU6aFo5p
 8wOBunh5mdAJrfuL7zsI+fM87rjd5NPkVq6Buz6QW+xLyI4WCldzpsEgPIjlbNYgD9by3vV2Bnp
 XOQuHlSurMzcLlAZMzXm5TDpJLxoK+ZHu3uxXnQc2lx1p2p4fao6gHyxoHZ/YGAX6oafdHg1yzW
 GAbjhfpj4EbTk/8riRrMGMehAOHR+OxoFMd0BxqJZJIrsJI
X-Received: by 2002:a17:902:d547:b0:2d8:d4d2:d135 with SMTP id
 d9443c01a7336-2dd9ca26cb4mr107494935ad.17.1789757238839; 
 Fri, 18 Sep 2026 11:47:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f41d:ad29:ec63:be4f?
 ([2600:8803:e7e4:500:f41d:ad29:ec63:be4f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3318c49dsm506515eec.22.2026.09.18.11.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 11:47:18 -0700 (PDT)
Message-ID: <6c68b4fb-96d3-4616-a96a-711c9c0f709e@baylibre.com>
Date: Fri, 18 Sep 2026 13:47:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] video: panel-startek-kd070fhfid078: new driver
To: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
References: <20260826-mtk-video-panel-startek-078-v2-1-c56342b77835@baylibre.com>
 <CAEHHSvYCCi1Aksqb1mrkTOV8gz5852uzyqOkTNWPX4dcbhg-Wg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvYCCi1Aksqb1mrkTOV8gz5852uzyqOkTNWPX4dcbhg-Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 9/2/26 8:33 AM, Julien Stephan wrote:
> Le mer. 26 août 2026 à 23:22, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
>> used on the MediaTek Genio 360 EVK board.
>>
>> The display mode and DSI mode flags follow the upstream Linux driver
>> panel-himax-hx8279.c, which is what the "himax,hx8279" fallback
>> compatible in the device tree binds to.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> Add a driver for the Startek KD070FHFID078 7" DSI panel.
>>
>> This depends on the mipi_dsi {generic,dcs}_write_seq helper macros series
>> for mipi_dsi_generic_write_seq().
>>
>> Note: no defconfig enables this driver yet, since there is no MediaTek DSI
>> host driver in U-Boot at this point. It will be enabled together with the
>> display pipeline support.
>> ---
>> Changes in v2:
>> - Added missing BACKLIGHT and DM_REGULATOR Kconfig dependencies.
>> - Use the display mode and MIPI_DSI_CLOCK_NON_CONTINUOUS flag from the
>>   upstream Linux panel-himax-hx8279.c driver instead of the MediaTek
>>   downstream driver.
>> - enable-gpios is now optional, matching the binding.
>> - A missing backlight is now an error instead of a warning.
>> - Do not request reset/enable GPIOs as active, so they are not asserted
>>   before the regulators are enabled.
>> - Use mipi_dsi_dcs_exit_sleep_mode()/mipi_dsi_dcs_set_display_on() instead
>>   of raw DCS opcodes and check their return values.
>> - Dropped stale InforceComputing/Linaro copyright and author lines.
>> - Dropped the unused dev field and the unreachable mode check.
>> - Link to v1: https://patch.msgid.link/20260814-mtk-video-panel-startek-078-v1-1-5f84a57244bc@baylibre.com
>> ---
>>  MAINTAINERS                                 |   6 +
>>  drivers/video/Kconfig                       |  10 +
>>  drivers/video/Makefile                      |   1 +
>>  drivers/video/panel-startek-kd070fhfid078.c | 283 ++++++++++++++++++++++++++++
>>  4 files changed, 300 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fabcb8b2968..b3bf5b1f8c7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1723,6 +1723,12 @@ R:       GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>>  S:     Maintained
>>  F:     drivers/video/panel-startek-kd070fhfid015.c
>>
>> +STARTEK KD070FHFID078 PANEL
>> +M:     David Lechner <dlechner@baylibre.com>
>> +R:     GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>> +S:     Maintained
>> +F:     drivers/video/panel-startek-kd070fhfid078.c
>> +
>>  TARGET_BCMNS3
>>  M:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>  S:     Maintained
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 37ab17f0ab2..495e4382a22 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -330,6 +330,16 @@ config PANEL_STARTEK_KD070FHFID015
>>           1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
>>           built-in LED backlight and touch controller.
>>
>> +config PANEL_STARTEK_KD070FHFID078
>> +       bool "STARTEK KD070FHFID078 panel"
>> +       depends on PANEL && BACKLIGHT && DM_GPIO && DM_REGULATOR
>> +       select VIDEO_MIPI_DSI
>> +       help
>> +         Say Y here if you want to enable support for STARTEK KD070FHFID078 DSI panel.
>> +         The panel is a 7-inch TFT LCD display with a resolution of 1200 x 1920
>> +         pixels. It provides a MIPI DSI interface to the host, a built-in LED
>> +         backlight and touch controller.
> 
> This looks like a copy/paste from PANEL_STARTEK_KD070FHFID015. The
> built-in LED backlight is wrong for this panel. drop it.
> 
Not sure what you mean about the backlight. The panel certainly has one.
Maybe you meant that the backlight is controlled differently? Not sure we
need to change the text here though.
