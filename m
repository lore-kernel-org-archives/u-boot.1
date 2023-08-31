Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B89CC83F21
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DFE86553;
	Thu, 31 Aug 2023 04:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cxj93as7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC2386547; Thu, 31 Aug 2023 04:49:28 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7112E80702
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7d50ba994eso176496276.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450164; x=1694054964; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8gSbzAra4xA8tPUJTJa2jvuQoF8Wi9MXZ1u7xtT3CQ=;
 b=cxj93as7NsmQXgLexwZJEcFrSnk43BCOqF+9rn4HYY55j3nErpz1ShxRAPlnC4TYvW
 /rzKa0D6IcoQ4wJuPYQ3a213d/2UgyiweH3MapxUvNYU+1fOxsN30Aq30X9P85H78m09
 fiqE5mqnBSOJszwep43FpV2G3qXHMUCONp9AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450164; x=1694054964;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8gSbzAra4xA8tPUJTJa2jvuQoF8Wi9MXZ1u7xtT3CQ=;
 b=WyDGchPb12MZw34uTcFIQqYOvPqVjTP1ae84acXTGNhEShds1gllrJGnBxPQdMJnEb
 aEmUyht+/WOKzS/PjKpoNSivtOS0W6vRfDGW2/MvI6n+1FSYekmgISF7UtswCTbHS2C6
 VjuYJnO1WrGxIBKKTTEujD7P4j36j6tog5G58ifRmWchRwtlarfLJ1l355qKGRszlb5X
 1eSev8MlxTOF20TlCO1dQTuwQ6hDldn/cdXHUnGbiyCSKUyUGjYH3Zb2+BWUTV/fTbkO
 thwzyAZwrHFypGTozoQN5X3CoNxuX8hWxy1Q8/3/kwiFGdiNSuO4NIXDnn79dgXtNMkB
 5M8g==
X-Gm-Message-State: AOJu0Yxr87qhUO32I12/yq1Z389nIqymd6QqIZ1VU6nH6u8P8xf+A0mO
 tOQOg+jXTBYufpPUqYreVeUBZZ4f9pkdOqlkn0ERKA==
X-Google-Smtp-Source: AGHT+IEisxxvuAIS8NgvvX+NOCZLx37XyxFsU3piI3ZF0msZtpt06A0le2PdfaHsC638fIrt3D9jZ6jDv+yaVfzISWs=
X-Received: by 2002:a25:81c5:0:b0:d62:9b77:a41a with SMTP id
 n5-20020a2581c5000000b00d629b77a41amr3538389ybm.31.1693450163815; Wed, 30 Aug
 2023 19:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZO/g8T1ohHI23xM8@octopus>
In-Reply-To: <ZO/g8T1ohHI23xM8@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:05 -0600
Message-ID: <CAPnjgZ32h4vtMiScP-4NKEVFCSYcYHV7=bKVSqT3mQSfDPQ=FA@mail.gmail.com>
Subject: Re: [RFC] make sandbox UT more generic
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 sjg@chromium.org
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

Hi,

On Wed, 30 Aug 2023 at 18:38, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi,
>
> I'm working on implementing SCMI-based pinctrl/gpio driver,
> and want to re-use sandbox UT to test the code. However,
> It is somehow sandbox-specific (with additional DT nodes).
> How can/should we make it more generic for other targets/drivers
> rather than just by copying the test code?
> (I have already created a test for pinmux since there is only
> one existing scenario, but gpio test has many.)
>
> Even if I say 'generic', my case may be special since real
> hardware (device drivers) cannot always run all the test cases,
> while SCMI-based drivers potentially can with a dummy SCMI server
> for sandbox.
> See:
>     drivers/firmware/scmi/sandbox-scmi_agent.c

We don't have a good way to test drivers that talk to hardware, in general.

For I2C, SPI and some PCI devices you can sometimes write an emulator
for the chip and then your driver can talk to the emulator as if it
were talking to the hardware. Sandbox does actually support that with
memory-mapped I/O too, although it is fairly rarely used.

We have done this a lot with Zephyr, as well[1] and achieved 90% code
coverage on some boards.

But I'm not quite sure I am answering the right question, so I will stop here.

Regards,
Simon

[1] https://www.youtube.com/watch?v=usXCAXR2G_c
