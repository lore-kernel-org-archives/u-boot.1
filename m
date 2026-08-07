Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2EDC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 10:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0DD040A36;
	Fri,  7 Aug 2026 10:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WPUJykXGzlHo; Fri,  7 Aug 2026 10:27:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8189340A37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786098433;
	bh=rqBlT9BN0pEO4Pf4bHOUpGSPDkhmFnnv37XKukVidXA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FgfhmfGxGF5ovIISfdO+51iiUT1UinVIY1cVRZ9ub9scNj2jyq/G9QLGKAk8U54+e
	 riTVX6cA4OA6BTvwLWAfywIyVItULyVxvozb3lCcdaMOsZjySHoDPFQmzLfXPcihSc
	 BAP4bZuWtjj7/ehPIN3nZN2zIotvbx9gz+o0guCdl/fV8C/aJ7h5K4SHyag43z+nsA
	 V83C3A54c/7rWVQgWM0cHx+Vr+b0eFMo8vomzrb8otQTHIho5VnWmpYGu0tYzYKOB+
	 iBpnpIyzHo5DFFotFzTlu0WPr1swVjDzhkN01mjMSKE2DX9k3rHOTbaSydbpSDeucc
	 WtqtK44MOtOzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8189340A37;
	Fri,  7 Aug 2026 10:27:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6630610E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 10:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57AAA40A91
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 10:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W7rcr1uvQ6vJ for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 10:27:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D67F540A31
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D67F540A31
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D67F540A31
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 10:27:09 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so19418075e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 03:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786098428; x=1786703228;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rqBlT9BN0pEO4Pf4bHOUpGSPDkhmFnnv37XKukVidXA=;
 b=HRKtRRo2XYVXtIjE0kWUTXenbwNELtOLkN3wHbbgQOJuO/MvNp1/yNpremwPAgO8Ve
 35mOsMbs9kQLAyPyYVhVpFoba+UrGwdlggdCRUOETr7bI7flx9zwAuu8yal5ufAAL8qZ
 Jc/H8LNC5Q2aKsgnj/yGKYmELVLOGkWacD8SZwDDvMPtVWZoW561IM4JWWUtcIF0ZSb0
 +GY6q7ZQ5zZcPr4i+7vSvXn3qv4pWulK2zEdXemkiJYQihX+/P6fWsvQ3YM45izALH76
 8/XKQLoDgdhLhsiFdlYzkdVDu59sYUU3596QtzF+oBjf7PWdzojyVLp2qukALCAQ6w1U
 0xBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq7MWs3/B5i0956oXjMNtQTW//8eARzB+Pqzl0I0W2FZPgxyEyqWcr2E5idBo/1nqsKg734yw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx00yLyFxO0RWoOnuwD/6I/3FDFdpay6ADVGOsN2WlvKz0fLH89
 hT358j+Dhgwt57S4K/bVB4VCcFM5CLMcqqGsFOqYDEpBTVj33TOjpB2McF+Aryujook=
X-Gm-Gg: AR+sD118zjfYhov4yZHrRKXVFfIzaamdzU7BGjAjusX/4IQKEt4s1T2AdWmtTCVW2aK
 9txTiaacXmDMnQbahkHiTDzfrekUcp+iSAkUZrfI+2/sTChRIxcl3WDr3dC3sqA+Y1We2SdwQPX
 Ytp6WFg8tzJuOWYdwS5anPHzP7nINVqIqzN7eWrSbe0t0mR6qMrmLTFvHRazgPTc2HtkJCDhOYD
 eo7kL5VxNZ+TQc8swSy1HtR0F7oMdFPeCX1ogcB7r8o/B7yQSrQxYIchlYN3mzOZfj2RzHz0v11
 VNjmS5Eu8Rvaa2CxK0weALlrk1ta6G29zu0dSkADM+5kHcTQ2pUaiq2f3W9UGlZQgRL5l8pBafv
 Thidgtwa37mVDtCtUKFUSK/m4YqV98IuTvE0zNROX7xLgu0Hx/0AbhD5Mpe1eRyQpO9rbpw7uiy
 Vk0pFJgShmX8uA9TfNSFj9XoaG07AjmAU2ly7Kh0A+2tMdmfQQVU5XPr410MhAqo/A0VdEQM6rC
 Z6q8Rx0aFDp2MADliecohRqn6XyiRpNMIGKVz6+/rpNl9lySHZDdPSK
X-Received: by 2002:a05:600c:190d:b0:499:5a5e:f2f3 with SMTP id
 5b1f17b1804b1-4995a5ef379mr84469405e9.5.1786098427976; 
 Fri, 07 Aug 2026 03:27:07 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9eb1a0sm29832865e9.5.2026.08.07.03.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 03:27:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 12:27:06 +0200
Message-Id: <DKIN1TO1WZJK.3M819O4VFHXX9@baylibre.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Marek Vasut" <marex@denx.de>,
 "Julien Masson" <jmasson@baylibre.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Alexey Charkov" <alchark@gmail.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v6 3/3] usb: mtu3: add SPL gadget support
X-Mailer: aerc 0.22.0
References: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
 <20260806-ccaione-upstream-mtu3-spl-gadget-v6-3-66e133a4bf1a@baylibre.com>
 <67436bcb-45d0-4cd2-b6fd-6b85633532cc@mailbox.org>
In-Reply-To: <67436bcb-45d0-4cd2-b6fd-6b85633532cc@mailbox.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786098428; x=1786703228;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rqBlT9BN0pEO4Pf4bHOUpGSPDkhmFnnv37XKukVidXA=;
 b=aFFeBn3rD8/ppN0+5XmB+tH6Q72/HezN+AlYoyC7twu5vyGnWop2OUFyX/8G8rVQKu
 zAFYt26ZgjU9yPYFdpGiqBGgXfsHHKVCYpATsYhD2GW+gnxY6Ql0ou7lijlRIISyREgd
 n/s6ePJ7Q72BtArhjtiumB2Kxf09ebx4yuKJd1zZH1Us1D76gTxTws4wHW0i55I5Ou2U
 /j7Ov83smStGrUWvZC2RA1Al9LbFPxPHNkN+En4ixL3LKTBNHiSPqo3oqRy860zpuRzF
 3qNKEHbysFNWOurKj3VgVevHMoPqcHmXJO3hOkF9AtErvfBzicZGH99gCVg2/oj3PVcn
 +Ddg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aFFeBn3r
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu Aug 6, 2026 at 8:05 PM CEST, Marek Vasut wrote:
> On 8/6/26 2:54 PM, Carlo Caione wrote:
>
> [...]
>
>> +++ b/drivers/usb/mtu3/Kconfig
>> @@ -42,3 +42,23 @@ config USB_MTU3_DEBUG
>>   	  Say Y here to enable debugging messages in the MTU3 Driver.
>>  =20
>>   endif
>> +
>> +config SPL_USB_MTU3
>> +	bool "MediaTek USB3 controller support in SPL"
>> +	depends on ARCH_MEDIATEK
>> +	depends on SPL_DM_USB_GADGET && SPL_USB_GADGET
>> +	help
>> +	  Enable the MediaTek USB3 controller in SPL. The SPL driver currently
>> +	  supports peripheral mode only.
>> +
>> +if SPL_USB_MTU3
>> +
>> +config SPL_USB_MTU3_GADGET
>> +	bool "Gadget mode in SPL"
>> +	default y
>> +	select USB_GADGET_DUALSPEED
>> +	help
>> +	  Enable the MTU3 peripheral controller in SPL so USB gadget
>> +	  functions can use it before U-Boot proper starts.
>
> HOST seems to be missing here ?

Damn it, that was lost during the patch splitting. Thanks for spotting
that, shame on me.

v7 coming, cheers.

--
Carlo Caione
