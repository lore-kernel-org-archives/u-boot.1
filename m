Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C7FC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F043607E0;
	Thu, 20 Aug 2026 15:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0daEyqv877vB; Thu, 20 Aug 2026 15:40:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787240420;
	bh=nIk6AUcCupmbssUDutnf/7XZImfEKgelkBP6xAziq/Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbKHeH4l/l4kuSSo8ZlzPoi2WfvAdUnAhiZLi2FTXp7FEL694329/1LE3uqmHtv2o
	 T9Rjvcz2m6PiHFpfXD/3xBFstGt1G2QTEXSfafPBVpOMn0BAST9iXnLzpkVmL9nBsC
	 03fc046DaXiDrU+GZPTHUGdl52o3fsf7laLn7k/n3D4xfg3qz87IS5C7AB6U4yPb8f
	 q/+xbq+ENnQA4JYio4CCO8IL8vKeeXhACGz2CM2NrC1KIPvCx8nh53ZSzAM/sylxik
	 6omg8Gvh6jZeLhOgZTOoxxy4gM/C6Dreu9EijFN+swcv20ItMqB+Q0CFhxNSLLZJA4
	 /FFi4mscwrZjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92F62607D5;
	Thu, 20 Aug 2026 15:40:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CAFAB279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0A4F607D5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxqapgvoJQ1t for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:40:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=If2JLYZ4
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FBCD60739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:40:16 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so21257075e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787240415; x=1787845215;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIk6AUcCupmbssUDutnf/7XZImfEKgelkBP6xAziq/Y=;
 b=If2JLYZ4rrRqOAWhfLOErHJ79cI9vh3N459X9jouh1rX+4kp5kRmNpr/Mn326ur0Yx
 uTlrszFg1i3ZLs4VfmKJv/l18IGIhkWeHBRSID4YN+oiVh6MqHIer/uulv85GusKMF2f
 GhDCUJOVFtwNS7OSE64/rUR7MTocMhVOME53mXAhS8mPmKm87XeWg/roUCfDpDfmguE8
 1fCrXtYWpa4o2qlAWZwAkaPxmJ8y8sfYEXOPYqDG0dZp4T+zy/rG8h20sSWN1k3ULjtk
 +DiPH4nMU3gnW36ubarJTyJxIpVmnFD+5U+qNE5f53ROs9ftapJWFjccAho0K01Woys8
 LA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787240415; x=1787845215;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nIk6AUcCupmbssUDutnf/7XZImfEKgelkBP6xAziq/Y=;
 b=L2pcEQw8I/jcnE7/j6F9qpa0nV9Bc/4/wIFtV21kU/BlM8+oDpUuoHzDO2LeHyzBot
 KQY8/+UNwET63czvXLTOAOT3P9FBNphnguTM+kPVp8av0fBpLB3l54qM0kjEruBNQZDk
 40elPtzKtZNrnc4aJ/LzF8Z5J9Ydk1dNInlKwAmlykPjN2JDtHg1sgU/qBORyvrtECvV
 0kDyCCdugaS96drZwx7Ht8gJO7kP7QKCOuRaTTCuoQSV3B2qXjUL4j426iVTRgVG0DYt
 6YBaMW5pirB5fyEnRRk2hvAWNjkZeqHoPF/YggOM0uXSa8xa96dkUFYm2GJL68QjpdC9
 vpxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoaefAyaTojX/LoGE4zHXl3Junbk/pIGzE8DfLOjoL/hTRo+TVElm2ePDb4svGHfzwbXy8DF6c=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxQ5CyKIr6duAUBkBvkG92I77RYVhtg5vLsihvmmZYU8QnFpny9
 PwOMtuLojQPS2H8Xbx85YropKLJ6wkDJ6PhDntrzmQgOkLMfwv3q3OdlJAzc+7H4GOhiCXlwsm/
 aN3nB0O8=
X-Gm-Gg: AR+sD12IMwPlO+7CDBtLlQI3q3TmGC1TU27IiZiU8yLa1QDBarhr9KtvrJm03KG/XHi
 XkzW6+P0/+9tigV3c33roHfzVqycnkI7Zg2TahtjCKOVi55VtNasR9mYXvTADT99hvMCjNGzClM
 T5L0P61Vb+UduZ1WZemVKhvNZgDtnN7moP1sLev1XHZ7yh/t08zOH0ps3Rms0FcdWfoMUB5L5rq
 Pkp8jZO24HTpnph1E6NS6uyGESjDty3Ojk0gVo/Ciq7LiDYDb1EXsDYso8tmgxg5JXxmM+ME6z2
 7YGrfDCvgFgytfz7yDLGLUehjuoAPDzdhlkd6QWhNRYWlshvTR5uc3//KnEWneQkhDkShiZK4Hm
 jhB1eO0V6ouDUagiinW80O3dd641Ntkgywf/whTx0GLoQtKjtOQdR8H5sFGLqlHzuOIUDM4Pjbc
 R4XCU8AO62If85rqdO6QcxI1XhhT/hFJF3FIkyFXuIytUaX+I1GHVyhy6Z+5HjVccGy9rpVGNZo
 mQ+dd7AwIUy8Nx4jeSI9tED9bbxKxvPp/sit9O63067eeA6VXJerSEQ
X-Received: by 2002:a05:600d:19:b0:499:b4aa:3d70 with SMTP id
 5b1f17b1804b1-499b4aa3dd7mr50275185e9.14.1787240414856; 
 Thu, 20 Aug 2026 08:40:14 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm194296035e9.2.2026.08.20.08.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 08:40:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 17:40:12 +0200
Message-Id: <DKTVUMXOM1PK.MIFZ75Z7BXI@baylibre.com>
Subject: Re: [PATCH v7 3/3] usb: mtu3: add SPL support
Cc: "Tom Rini" <trini@konsulko.com>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Julien Masson" <jmasson@baylibre.com>,
 "Alexey Charkov" <alchark@gmail.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
 <20260808-ccaione-upstream-mtu3-spl-gadget-v7-3-ed659a79a918@baylibre.com>
 <3c8bc13f-be4c-49d4-ba43-65f787d82796@mailbox.org>
In-Reply-To: <3c8bc13f-be4c-49d4-ba43-65f787d82796@mailbox.org>
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

On Sun Aug 9, 2026 at 8:45 AM CEST, Marek Vasut wrote:
> On 8/8/26 3:40 PM, Carlo Caione wrote:
>> MediaTek platforms may need the MTU3 controller before U-Boot proper is
>> available, but the driver is currently selected and built only with the
>> main U-Boot configuration symbols.
>>=20
>> Add an explicit SPL controller option with host and gadget modes. Make
>> the driver build and its role checks phase-aware so each phase can selec=
t
>> the MTU3 role it needs without coupling it to the U-Boot proper controll=
er
>> configuration.
>>=20
>> The upstream binding locates the xHCI child registers through the parent
>> ranges property. Select SPL_OF_TRANSLATE for host mode so SPL can resolv=
e
>> that address before mapping it.
>>=20
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thanks Marek. Just to confirm: this patchset should be picked up by you?

Thanks,

--
Carlo Caione
