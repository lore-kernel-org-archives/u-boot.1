Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5781C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D35A87BD0;
	Fri, 15 Dec 2023 21:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rz0GKTjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236AC87BD2; Fri, 15 Dec 2023 21:46:37 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE6787BC2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5906988ab8dso585802eaf.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673193; x=1703277993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aC0BMNyM0i4exYI4WkrkbJXDI9WloQIMUAFEvrjNtKs=;
 b=Rz0GKTjIMhyNdzvctaUMwPU8pfSzVnctIrLY9jP8139H0I1TFZ0/qZZId9uc1K0K9y
 +XMRnfKnEP5kYb0r6o8KYzmDh6F7pzv6mqtD9aP+Njfx5GA5hrIv/ePJk4PeyLw44r8a
 4yscIB3ZIDGlIt9U5v+L6IR6Xl+4VeFEejrAGJOuPsGiYj8x4Ml7IHZt+t8nZ73Oo6/x
 SWgpMHq32qGxPMpLZWsft/rOwvcJJ+JQkHrzZD+ocqD6iwVG2JOCfQDQ0MPucjpTLtDL
 a9KRvocPwyujejUzrGdpQXXO9C1RoSqgrRnc/R+5kdqEwpXzGbl3p8cjCUvP1FzguMcH
 UEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673193; x=1703277993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aC0BMNyM0i4exYI4WkrkbJXDI9WloQIMUAFEvrjNtKs=;
 b=uu/gyWCzVWnqIZZz7js03r0Q12DDvHfssEVm0/lgoarCzhd4SWXgV8/NK3GeRbJE9Y
 rffVZFHrJRaccqiORHzm1fIKHcA6t1wsEVyJkw+qMLgomojum4HC8c8MUdomXGROiZMi
 WF5wG/25OAEesJNyncQOUnXgYlKU6xJhvxpp4M3ELNYyXIeAb5FTIWeDZxhsGieM2/ED
 J3i/1iUR/tlgiPHqPQMLCTySwBw5KfnxOxctO6hBpAhzzo2btWWPbS6aLmEqu8D82MKW
 Jr+6azDMWkIskESym1VyXpcFGiUOZSgZs0vItPI6K9pzY/gO2CY0z6jLmZkc1ldok+1x
 7lPQ==
X-Gm-Message-State: AOJu0YyDMqWPiYPlv3WSmWkOK0t71u9kXejPiScrIo3h1ByRTBCL4Y0r
 Z7i2wW0lfNm2Y9HuyZPmBs8=
X-Google-Smtp-Source: AGHT+IFgQGjR/xKnepYo66CMpGo46D23tQtVM+DLToa4Q13b6RJ4Y2/qBcOonJa+mBjUdgRk+qLDPA==
X-Received: by 2002:a05:6870:c6a0:b0:203:f33:be13 with SMTP id
 cv32-20020a056870c6a000b002030f33be13mr4855921oab.107.1702673193429; 
 Fri, 15 Dec 2023 12:46:33 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:7c7f:3273:a81a:4618?
 ([2001:470:42c4:101:7c7f:3273:a81a:4618])
 by smtp.gmail.com with ESMTPSA id
 gu11-20020a056870ab0b00b001fb3143cc0bsm5288198oab.44.2023.12.15.12.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:46:32 -0800 (PST)
Message-ID: <9d1027fd-5385-9a97-7406-029e8132fe47@gmail.com>
Date: Fri, 15 Dec 2023 13:46:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] board: rockchip: Add the Turing RK1 SoM
Content-Language: en-US
To: Joshua Riek <jjriek@verizon.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jagan Teki <jagan@edgeble.ai>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20231214234647.296129-1-jjriek.ref@verizon.net>
 <20231214234647.296129-1-jjriek@verizon.net>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20231214234647.296129-1-jjriek@verizon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Joshua,

I just updated my own modules to this version of the patch and all 
continues to be well.

On 12/14/23 16:46, Joshua Riek wrote:
> Signed-off-by: Joshua Riek <jjriek@verizon.net>
> Cc: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com>

Thanks for the continued efforts, my friend!

Happy Friday,
Sam
