Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F9F54AC7
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 15:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C827F80517;
	Tue, 24 Mar 2026 16:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Th9i8L3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A945807C0; Tue, 24 Mar 2026 16:07:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217A680212
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 16:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b40fb7f95so1366686f8f.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774364838; x=1774969638; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P5ZdFYh1bLXmKv/xLtFTZBUW421AXSY/+eTav2poOSM=;
 b=Th9i8L3etvEjpiHgMX0H8VataLpGWe1WVlu/QEDohFOIcdshSsNdS0V/wy8OAGwFgX
 RvxLympvuYMZYj7NRCQ9vIq01l9Ov/GgV10/G9KGfvxUjuV2okZ4tUXlun8SGazyXXsz
 dlYiEO4KSBMFgf8T+c2lo1fY6pgQROKinBzA2qURXMByd5kzFOKGC6OpfFzrb3tFWSaH
 xS83U7BFftjCv9GtEHj/tRafSYA0fa4rt6zZsR6S21Xl+dEVWNQTDzugIombhZ0qok6p
 xrzmfi8myd7zOhpnZ9Noaj2mlk+MwMATNkbVF6Td2leHVsgDBWATEhdAiJAGkHduLtc9
 MAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774364838; x=1774969638;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5ZdFYh1bLXmKv/xLtFTZBUW421AXSY/+eTav2poOSM=;
 b=NFEtPYsTem+lOi+MX9/SFzn/4eU95iyTYEiVSIBCnekowlayR2RaQToHGcqtoABCtt
 4R4tdlg5s58UUcGtYi7Bl74XcS71q1vN/2XSRiKW7K2zzFRXZ1C8XWyaY9XpCL4jFkaU
 aNOG3hRu9cKvgeszbdsp8Fdtugn+xswsimSpMfzVbNQgt5JM5Kv7TY2m+eKvlchidxKp
 CdmWAIyG3VM2kjxd2MyY3ms4jkwgyz5Vrm5A+xdkmWqBUo/itV3hVwS4q/qCbjWlQ0fN
 HzMfXQKGTSdzG+x3Mya+a0kheufHeEb8/DlDQOAu+mRUhOGuPBd8TXhDrR/F5iIqbzXJ
 L/Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe+u+6arjPEpk079JVYAvHcfdSYHIhU7y/nqZEI7aCY05IX/YEjWBbeFVHxsZ6DriZXvnApDQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzzINw//WdOZB+sAmr/CQP0aGhCboCFJAabXAw9CklYGFXTJPxz
 uV6yHi5X4qpUR3sKWHFfDuLpZUTBD+oJg3whd3j42jWbbPbzbtWwZ88C6+Fev9VAxcA=
X-Gm-Gg: ATEYQzw5lj29h7Adjg5yZ14HE3bBDJd75WadJWFG7vgajwieHndKDIhsKoqZ57/0Tjy
 uP4hN/bBNM0U/TtmBFG5H81FitRc3UU5SOzBmp2pU5LhUVvJpBHYJGXnOWC9jSS2zGTSW+Xb9Bn
 2wjO0BrO66BxxD3u4GF9iadAp8POUO/Ko2QaAnvXj57zj84znXjGJYL7IgXU4hcWTfvZ8jFgkUS
 PIr3PR5QwAvjLtDsf1qbe8k4pBdRBTgz6kaFphJh6MISe2dBpih8uCEGDN1OvGyp0/cNfGS2QEv
 4Gcz2GLC/vldigfFLHzYWEngKiwSm+zsytu3U67NTaqiOh5BGUM1fpMHozDtPw06aRi9HZXLuvI
 swAIREK4ToMb7bPjKIIFd/0nDs9k532bg8+VB+gDHbumDR8SLKLk4lg5ZK9eApV3ZSSTzJ8Rpgu
 yPpi4Tuxh2V3YC17nMQhG4atVnOTj6
X-Received: by 2002:a5d:64c6:0:b0:439:b4dc:1e1e with SMTP id
 ffacd0b85a97d-43b6426493fmr24948925f8f.29.1774364838270; 
 Tue, 24 Mar 2026 08:07:18 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470393fsm39839147f8f.17.2026.03.24.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:07:17 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:07:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@denx.de>, Greg Malysa <malysagreg@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Anis Chali <chalianis1@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Ye Li <ye.li@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v2 3/4] scmi: pinctrl: add pinctrl driver for SCMI
Message-ID: <acKooSHo_FB45nYH@stanley.mountain>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <1048331f5d3c8e0cdbe1542bcb65bbf942a4275b.1773256350.git.dan.carpenter@linaro.org>
 <CAD++jLmfRVGGHH1EqMAeSVHVCr1-s2JPyuY_w=2h35_mKUXj2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLmfRVGGHH1EqMAeSVHVCr1-s2JPyuY_w=2h35_mKUXj2Q@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 02:19:34PM +0100, Linus Walleij wrote:
> On Wed, Mar 11, 2026 at 8:41 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> >         scmi_pinctrl: protocol@19 {
> >                 reg = <0x19>;
> >                 pinmux1: pinmux_test {
> >                         pinmux = <0 1 0xFFFFFFFF 18 1
> >                                   0 2 0xFFFFFFFF 18 1
> >                                   0 3 0xFFFFFFFF 18 1>;
> >                         function = "f_gpio1";
> >                         groups = "grp_1", "grp_3";
> >                 };
> >         };
> >
> > Under linux the pinctrl subsystem will parse the function and group
> > properties and use that to handle muxing.  However, under u-boot the
> > pin muxing is done using the "pinmux" property, which feeds raw SCMI
> > pinctrl PINCTRL_SETTINGS_CONFIGURE commands to the server.  The
> > numbers are: selector, identifier, function_id, config_type, and
> > config_value.  In the example above, it sets pins 1, 2, and 3 to 1.
> > The linux-kernel ignores this pinmux property.
> 
> This whole thing is a bit of a hack and shortcut to make hard things
> simple isn't it?

I'm not disagreeing with you at all, but handling the default pinmux
property is the only mandatory part of a pin controller driver in
u-boot.

regards,
dan carpenter

