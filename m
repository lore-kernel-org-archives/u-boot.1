Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EF6CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F128676C;
	Fri,  1 Sep 2023 12:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jc6sPHMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD27E86564; Fri,  1 Sep 2023 12:04:30 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A4C8676C
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so2351871a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693562664; x=1694167464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bfgheOJel6ez4MLJuex3G21MlvhmSzbQ72m6inCLOcc=;
 b=Jc6sPHMawJicdbKuWOGhz1Y/Nxx6+sOUtzw4plTXJUbLYktvGc/ZqyAzLPo/PW/ZrI
 CEcVb1cohJOFNQvyQRUBQHQu2lWDxiouICwE0NKff7yyw58WnshZpEuM/Rddg08VN5W9
 f8Eo2Mcqwq/TOdTm2N6TYXMSID5J+5mU1ImFIdREmFg8AptrdvHTf4o/6z87Rh4tYIR0
 aMXB9X2iAYPImT6jcw1jzCHOds5Ryd26MwdXX+DzuY4Y5KcEQ5G3oFjGMouSJz9jd8tF
 LKcw3sU4SugM9eCZ92B2kNYBF+HEp0iH13JLcJnSRy88wBnBc/A6nyKxU6M8H3C5jfyp
 B2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693562664; x=1694167464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfgheOJel6ez4MLJuex3G21MlvhmSzbQ72m6inCLOcc=;
 b=DG2W9bHvMilOTlR35LSFYB5F9p7oLAItRuhJcSrPzGPnHKGtGB1x453/vvmiB1cNYE
 eehG+h+EipFsunXzcONUCpmDlgMvlSLOYx43ZZOzeo4gnVNE0dU2B4hK+MdCotZSTKfT
 9Ddq6xHnFO2J8OP+62uLhh03/wUDM4VlJt+rkZaTzBueNvQySc9Sb25KKpgwI4ASSncI
 h/nyZFNwNXDHkrqOj92oLP6e/1pN7Hab0N+FPLIG817jAE/J6LJX2vkUitEb6NPylp1E
 a7WXi8gkGXRvbQcBjjBreb1AmekiPX3rtbr1NwJX4/y/3/aSCx6qQKVstpxfsRIagqdC
 EW+g==
X-Gm-Message-State: AOJu0YzQzrNTDacytwM34Mz5J26i46DpDW4pYKVCochO/cRysRN387a/
 78eiYW+rXylQdR8thVll/4VkC/2TARrbpBAvaGedbz02D65BQJlJ
X-Google-Smtp-Source: AGHT+IGo/GbPjH2OypGshTHpr3lUiZHMeMTkbH/l+jc5su2BeWgFl43xBNj7LcxloUQy5X9GL9YqGsDC6eVm2aFR0uY=
X-Received: by 2002:aa7:c555:0:b0:523:c35:c209 with SMTP id
 s21-20020aa7c555000000b005230c35c209mr1382625edr.12.1693562664427; Fri, 01
 Sep 2023 03:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230813083912.532982-1-loic.poulain@linaro.org>
 <a00ee265-d65f-f15b-48a0-4112b7e762dc@denx.de>
In-Reply-To: <a00ee265-d65f-f15b-48a0-4112b7e762dc@denx.de>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 1 Sep 2023 12:03:47 +0200
Message-ID: <CAMZdPi9fupGqHhEOH_kTREUUOzmrCCZPbVbK5u5JGwRHTuMeFA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: sdp: Option to enable SDP read register
 command
To: Marek Vasut <marex@denx.de>
Cc: lukma@denx.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Mon, 14 Aug 2023 at 01:53, Marek Vasut <marex@denx.de> wrote:
>
> On 8/13/23 10:39, Loic Poulain wrote:
> > The SDP read register command can be used to read any memory
> > mapped address of the device (ddr, registers...). It can then
> > be exploited by an attacker to access sensitive data/values,
> > especially when running SDP from SPL, as SPL runs with highest
> > privileges in ARM secure mode.
> >
> > Without read, SDP still useful to bootstrap and jump on (signed)
> > blob such as u-boot with write and jump commands, but reading
> > is optional in that case (debug purpose).
> >
> > NXP SoCs usually have a dedicated SDP_READ_DISABLE fuse to disable
> > SDP read command in their ROM SDP implementation, so it seems quite
> > reasonable to make it optional from u-boot/spl as well.
>
> If there is a fuse, why not read the fuse and disable READ based on that
> fuse instead ?

Well, fuse is more a way to tune a specific ROM code here, not the software.
It would be more generic to make it a build config like other features, and one
may purposely force SDP READ in SPL, even if disabled at ROM level. That
said we could also introduce a weak board_sdp_read_allowed() function...

Let me know what you prefer.

Regards,
Loic
