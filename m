Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEF6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1383879E5;
	Thu, 28 Dec 2023 16:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C0k9GN2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8672E879E8; Thu, 28 Dec 2023 15:54:24 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABDA87732
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 15:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-336788cb261so5470337f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703775261; x=1704380061; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xisQT76aI0cZjTM/DtNzCqAv1E90pIpB51ZGna4zgcM=;
 b=C0k9GN2XVsxf4qiI7n5LRYED9kucbXxceOmlgLejhn4CXxxQpC31pYG1zzd5LC6Q0e
 raRKeBUUSJektNqRLSapPWPSsSKsgLdTn3IN7Fj9Gfput2YsgrMEdKm7E9lYM5aHkFWe
 KNm2efPrpcx+b8SsVl8cHqZpsWdm/WWpaSq80WmX0PhT1JiJewSo2F2cBod4Bdt3QXeF
 rgZtsCHCMdgzTxMHvft/o73nMjZMe+b7dFPETxWjCoMmoCS4vUmfQ8qUlkJm2oBrMLi/
 ZRhnIHDxmLqdzHKSlntQuZL5XQqF/fgXMeNKCGheKd3Nk4fjfuAnuRd6RsJIVt8GOY5n
 acYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703775261; x=1704380061;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xisQT76aI0cZjTM/DtNzCqAv1E90pIpB51ZGna4zgcM=;
 b=UxjwZJeH5v0DWHfGri72iszJEgnpQRweD/hRbhaZRGT9az5kqQEPdC72eOFlqeIvYP
 f7V/RbM7/VRmGHdMjqEHG+3X+m9E7lM5Xh0dcMCaMoAi5sXd9YTjSOoV2KGUiGz/l1Xd
 QTcNc3Uuz0sPQpM7pJYShtcm21GIDKSsHYhG2tPdzy4lKJvZaMB3ifRpSkPvyDJ9mWyV
 tKz/yhW6r4H/UMhwjJqWngm64mu3vvZIbSMfue0RYzLxPlz3v3lq508BoHHyfKsOH0Y6
 LduDwY9qCGY17FVPrfy3HMRaSjE+jWF9N1OUACZ67uIATdRHyUQuEdqU7YkmAgtWLFcD
 CZUA==
X-Gm-Message-State: AOJu0YwrocFOLYecos1Xaq/3ZGEzzuxuIEVbjdytQ4c18CDT+RCZufI9
 nm0cSoSxskNsYn/hIZ6lXGBOLTVEyS8=
X-Google-Smtp-Source: AGHT+IGFA3glA8oXxxCNoPcKpK0paAUnHlGV8fo9xsurP1snzbjwzNpbOS0Pnf1D5qx6OjgJwg0Z/g==
X-Received: by 2002:adf:e84b:0:b0:336:a5db:e7cf with SMTP id
 d11-20020adfe84b000000b00336a5dbe7cfmr4639754wrn.47.1703775261265; 
 Thu, 28 Dec 2023 06:54:21 -0800 (PST)
Received: from meije ([2a01:cb18:830e:3400:3050:5a06:d379:11f])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a056000108800b0033642a9a1eesm17169190wrw.21.2023.12.28.06.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 06:54:20 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Add imx93-var-som support
In-Reply-To: <CAOMZO5DEwTgffO6RZz8BaFq+bmxM170mz6wWN+MQ76ss7r8O2g@mail.gmail.com>
 (Fabio Estevam's message of "Wed, 13 Dec 2023 15:22:12 -0300")
References: <20231209114555.16951-1-m.othacehe@gmail.com>
 <CAOMZO5DEwTgffO6RZz8BaFq+bmxM170mz6wWN+MQ76ss7r8O2g@mail.gmail.com>
Date: Thu, 28 Dec 2023 15:54:19 +0100
Message-ID: <87h6k274ys.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:10:37 +0100
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


Hello Fabio,

Thanks for the review!

> It would also be helpful to add doc/board/variscite/imx93_var_som.rst
> that explains
> how to build U-Boot for this board, how to get the firmware, ATF,
> binaries, etc, and how to flash it to the boot medium.

For now, I am testing the bootloaders I produce using those
instructions:
https://variwiki.com/index.php?title=Yocto_Build_U-Boot&release=mx93-yocto-mickledore-6.1.36_2.1.0-v1.1

I understand that it would be nice to have u-boot do the image
construction with the firmware, ATF and so on, like implemented on
imx8.

Do you think that it could be done in a follow-up patch, once
imx93-var-som support is merged?

> Please also submit the imx93-var-som-symphony.dts support to Linux so that
> it can get reviewed by the DT folks.

Done here:
https://lore.kernel.org/linux-devicetree/20231227170919.8771-1-othacehe@gnu.org/T/#t

> To not block the board support, I suggest sending a v2 without PTN5150
> support for now.

OK.

>> +/* Using ULP WDOG for reset */
>> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
>
> Is this needed now that we use DM?

That specific define is needed as the ulp_wdog driver seems to require
it. I removed all the other unneeded defines in v2.

Thanks,

Mathieu
