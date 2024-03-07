Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CF5C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 07:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA9E87E21;
	Thu,  7 Mar 2024 08:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DEyB7V2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF19987B7C; Thu,  7 Mar 2024 08:57:00 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4560B87DFF
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 08:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47273838a21so954853137.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709798215; x=1710403015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Mv0UJ2kC0xH+ixozL2Ken+h/aMgxK1QAV5NGg0+/y0=;
 b=DEyB7V2He6mqve2cLlBFu2CxwfZiY8ljetFdanacqNMQdUrPsaQssm30oxhp+iS6Cu
 MHLwN81VK3OYjRIhSJNxUh0hUftuD/dnnChMfYfMFJ+RQGG9PuDr3GZv+jQu1lH/MzDc
 um47lO7B6zG/8vyCmICpQwwmd17ZOn4extDhH1ia4ECIC9XPk9Xccncs9YAKAn19pSg4
 spGdeyZEvP8IXA6AfYfNbamyYjYkmxhxU7Y6McHC6oAIEVJqy9WfVvXKSKXDb2NwcuRX
 mM15p5NOvU467sIUmdEKN5GRB89yRTXd6BV0HQgXnrfuHEjuPswvlzId5eOQWKrFutnz
 gyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709798215; x=1710403015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Mv0UJ2kC0xH+ixozL2Ken+h/aMgxK1QAV5NGg0+/y0=;
 b=R9NwAibJSA9mIiF7X7VTFCDIfi3byy7HGWkQnbU2WI1OICNnhcVGP9uOS6VfgSW/1H
 n2cHKYyI8qGbKJQjkeDUOqgf6E45/YQq8wTAccvGw4Q5YH85whuvhPNV9385zXXYIWDf
 v+Mi1CuAYX8WpQ9KQQfn7iLl47ddhfhrTZQHNW7AjQac6MHEw8JIt3yqParUjTEtRcnr
 5WuAYi/QqVIOOeK911urwpSEhPx7Z8jeIK89c5aMmZaXXRCbqu9jaVuTW4ERSlO1bOHy
 3l6dTU6vSQC4hDfU1GW9tHnVYgAcZTRvpE/BhsWRqaT1dh/Qp/SBzk/JfQ1DU6POIsDl
 jEeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8jNBWag8qaJ4mq2rqjnooDB7OKca+AufyV55BoENqlljIWU4NaOeIKE7LdxFVJIB41O/YXk4MkF+Y3Fm/fS0Bkh19QA==
X-Gm-Message-State: AOJu0Ywzl7gXfKeRrKTh5fDdqpaIeDNDzKViC3bqsdW9jEv1j/MBK/J/
 e29STOt2Sh3r7oLm+HHGRqG0bQtsY6OYSYTZyJq6lXXJ37gGbDKr57Fc4H5gceQ/ZJCFIXp+PkT
 Y+pni65lima1sKyQAxSxXU5+QpMwbmYWzKogTCw==
X-Google-Smtp-Source: AGHT+IGA/zm3XZnHztU1qF92VPrKKouK3RbWk4GDcucgoPVuxpolDRx3pkVob+gwlWKSd/ORtCkFJ8lLLrhRGve3gTM=
X-Received: by 2002:a05:6102:2908:b0:472:a4bf:8c24 with SMTP id
 cz8-20020a056102290800b00472a4bf8c24mr357173vsb.1.1709798214777; Wed, 06 Mar
 2024 23:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com>
In-Reply-To: <87y1av12bg.fsf@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 7 Mar 2024 13:26:43 +0530
Message-ID: <CAFA6WYOKmKReWYXM7ReqvWjMSxUbjq8BpzgGfdHNjYA5qyYX3w@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 7 Mar 2024 at 02:54, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
>
> Hi Caleb,
>
> Caleb Connolly <caleb.connolly@linaro.org> writes:
>
> [...]
> >>>> +};
> >>>> +
> >>>> +&tlmm {
> >>>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
> >>>> +       reg = <0x0 0x03000000 0x0 0x1000000>;
> >>>> +       /delete-property/ reg-names;
> >>>
> >>> This won't be needed if we can make the tiles offset in the pinctrl
> >>> driver compatible:
> >>>
> >>> #define WEST   0x00000000
> >>> #define EAST   0x00400000
> >>> #define NORTH  0x00800000
> >>> #define SOUTH  0x00C00000
> >>
> >> Hmm, I assume that in this case pinctrl driver should map all the four
> >> tiles independently? Are there guarantees in U-Boot that four separate
> >> memory regions will be mapped into virtual memory with the same relative
> >> positions? Linux clearly don't make such guarantees.
> >
> > U-Boot doesn't use virtual addresses on arm platforms, it only goes as
> > far as reading the address from DT, nothing else, so this is totally
> > fine and is how the other SoCs do it.
>
> For me it looks like we are depending on implementation details
> knowledge. I.e MMU API does not provide such guarantees, but drivers
> know how ARM MMU code is working internally and drivers depend on
> exactly this behavior. But if you are saying that it is totally fine,
> I'll rework the patch. No big deal. Actually, I already tried this and
> it is working fine.

I agree doing it properly via mapping pinctrl tiles individually is
the appropriate approach. BTW, the current implementation just relies
on 1:1 VA to PA mapping in U-Boot, it just avoids deviation from
upstream DTS. If you are willing to change msm_pinctrl_probe() to
parse tiles properly then I would be happy to review that.

>
> >>>> +
> >>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
> >>>> +       /delete-node/ phy-reset-pins;
> >>>
> >>> I suppose this is not needed as phy-reset-pins also configures the pin
> >>> as GPIO only.
> >>>
> >> Well, yes. This also puzzles me up, but for some reason it stops working
> >> if I leave this node intact. Looks like I need to look at this deeper
> >> before posting the next version.
> >
> > Possibly the pinconf defined in the phy-reset-pins node causes U-Boot to
> > misbehave, can you check if this patch fixes it (there is a bug in the
> > line "return msm_gpio_direction_input(dev, gpio);", it should become
> > just "msm_gpio_direction_input(dev, gpio);").
> >
> > I had the exact same issue with the gpio-regulator driver and this was
> > the solution I ended up going with.
> >
> > https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgRbr63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p50H3pf7nbxit$
> > [lore[.]kernel[.]org]
>
> It is exactly this. With your patch I don't need to /delete-node/
> anymore. I'll add a comment in the cover message that this series are
> depended on your patch.
>

+1

> (and sorry for the mangled link. It is our corporate mail server doing)
>
>
> >>
> >>>> +};
> >>>> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155p-adp/MAINTAINERS
> >>>> new file mode 100644
> >>>> index 0000000000..03fac84f51
> >>>> --- /dev/null
> >>>> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
> >>>> @@ -0,0 +1,5 @@
> >>>> +Qualcomm SA8155P Automotive Development Platform
> >>>> +M:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> >>>> +S:     Maintained
> >>>> +F:     board/qualcomm/sa8155p-adp/
> >>>> +F:     configs/sa8155p-adp_defconfig
> >>>> diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconfig
> >>>> new file mode 100644
> >>>> index 0000000000..b6969767f8
> >>>> --- /dev/null
> >>>> +++ b/configs/sa8155p_adp_defconfig
> >>>> @@ -0,0 +1,35 @@
> >>>> +CONFIG_ARM=y
> >>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
> >>>> +CONFIG_COUNTER_FREQUENCY=19000000
> >>>> +CONFIG_POSITION_INDEPENDENT=y
> >>>> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
> >>>> +CONFIG_ARCH_SNAPDRAGON=y
> >>>> +CONFIG_TEXT_BASE=0x85710000
> >>>
> >>> Being position independent shouldn't require a hardcoded U-Boot text
> >>> base. Can you try if we can get rid of this?
> >>>
> >>
> >> Well, it is required if we want to load U-Boot instead of hyp.mbn. We
> >> need correct addresses in the ELF file so Qualcomm loader will not
> >> reject it right away.
> >>

I see the hard dependency due to prior stage Qcom bootloaders.

> >>>> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sa8155p-adp"
> >>>> +CONFIG_IDENT_STRING="\nQualcomm SA8155P-ADP"
> >>>> +CONFIG_SYS_LOAD_ADDR=0x85710000
> >>>
> >>> Ditto.
> >>>
> >>>> +CONFIG_REMAKE_ELF=y
> >>>> +CONFIG_BOOTDELAY=3
> >>>> +CONFIG_SYS_CBSIZE=512
> >>>> +# CONFIG_DISPLAY_CPUINFO is not set
> >>>> +CONFIG_HUSH_PARSER=y
> >>>> +CONFIG_OF_UPSTREAM=y
> >>>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> >>>> +CONFIG_NET_RANDOM_ETHADDR=y
> >>>> +CONFIG_CLK=y
> >>>> +CONFIG_CLK_QCOM_SM8150=y
> >>>> +CONFIG_MSM_GPIO=y
> >>>> +CONFIG_PHY_MICREL=y
> >>>> +CONFIG_PHY_MICREL_KSZ90X1=y
> >>>> +CONFIG_DM_MDIO=y
> >>>> +CONFIG_DM_ETH_PHY=y
> >>>> +CONFIG_DWC_ETH_QOS=y
> >>>> +CONFIG_DWC_ETH_QOS_QCOM=y
> >>>> +CONFIG_PHY=y
> >>>> +CONFIG_PINCTRL=y
> >>>> +CONFIG_PINCONF=y
> >>>> +CONFIG_PINCTRL_QCOM_SM8150=y
> >>>> +CONFIG_POWER_DOMAIN=y
> >>>> +CONFIG_MSM_GENI_SERIAL=y
> >>>> +CONFIG_SPMI_MSM=y
> >>>> +CONFIG_LMB_MAX_REGIONS=64
> >>>
> >>> Apart from above, I think this platform should be able to reuse
> >>> qcom_defconfig as you can find most of the config options there. Can
> >>> you try to reuse it?
> >>
> >> Honestly, the whole reason I am porting U-Boot to this platform is
> >> because I want to run Xen on it. And to run Xen, I need to run U-Boot in
> >> EL2. And to do this I need u-boot.elf with "correct" load address and
> >> entry point.
> >>
> >> I am planning to publish and upstream Xen patches as well (once I finish
> >> them). And it will be really nice if Xen users will be able use
> >> mainline U-Boot to boot Xen.

That's fair and I am happy for it to be a separate defconfig.

> >
> > I would like to enable the SM8150 drivers in qcom_defconfig (for
> > chainloading and supporting other platforms). But I'm totally fine with
> > having a separate defconfig for this board with this configuration.

Probably the common defconfig is up for renaming:
s/qcom_defconfig/qcom_chainload_defconfig/ since that seems to be the
only configuration we can support with a common defconfig.

>
> Yes, this is a good approach. I'll do this.
>

So you can probably drop CONFIG_POSITION_INDEPENDENT=y from this
defconfig and rather use the common defconfig for chainloaded
configuration.

-Sumit

> [...]


>
> --
> WBR, Volodymyr
