Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C93C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 04:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57AC888060;
	Thu, 21 Mar 2024 05:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K0EeOC3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A92287FF2; Thu, 21 Mar 2024 05:54:03 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AC08805D
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7e05b1ef7caso289939241.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710996837; x=1711601637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6Axfdd95F8AeQd92ZGFFn5x3R+6d7axEg3X2WB39Io=;
 b=K0EeOC3r6+a+x/ZFQcXUCGrzH39d3jCJ/X8Y8fz2tpma2JRT1xG/TjQvRqXoiZW7/d
 DF0OxonTvtNtlQwCTSkY//SGaDKIhMuyoQoqf+sBOTcMPNP2dvKHL9QxBJ51QC1/MfoX
 09VNVW4uCCKwZe1HVfXj5Gxz5HuMOIcLJfh60a0NHy0Vbgsc7znKC98dahnij9H1uJ1b
 cUAFek3QcLSt6FrcQpdDy/DX15QeB5wljcj9p0oDfDYZXY/RKyW2FNVgX3QnIvXZwvZv
 9lydBqa9IMLF5eYMAGHSiiY10mCsVM/FUgJkEE3h7qJdS2lyxcYTwcrTtJYJlolXNhRd
 mDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710996837; x=1711601637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6Axfdd95F8AeQd92ZGFFn5x3R+6d7axEg3X2WB39Io=;
 b=rS6oi2C0BF/hcmTnjyYJcnrZEfJ/t3FJtKTT6auosZzSevC7ip90U6r6xdT36DkIPb
 0PmDgyS3CqDpHCZ26TC+bZxIRNNpHTWdQYWZtgkL63TTCcM6WxTpebjFI6IPbAI1ZqDX
 twO8M6TDhaxPhSczWqUZIZGyZKGWL8U/Ju8wk/oIvrUSHnxaJasGQkyM40wglMO578VR
 TIy4bnAgpTYB/WFTKm7S8uT7XaiQHFjXhUxjCP/wZ8UTKU+KjepEdj8XLG320KtTWgrn
 /RwefoGNp5tOE2e+2jPjx9SzjHNDOzPWtGdH3pL13IH7w9gtnptZPahkIQE4rmDeBPux
 lA1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCC93jvwzlWXl3DLbW7k7bExNlZpmxqd1VeEEcTWUalKH58LmEq8faiS3V1nFm5j3uuL2kEFjU7lIU87rWtUnGv848Dw==
X-Gm-Message-State: AOJu0YwI2LqFHDkwBDhZkV6DnKEDHuNUeuPco9c3sAb5C7/Kw+kuG1uG
 0Uuaq03tlsUx4PCN9JQzpUCrBgVXC9crC51zZUQQWpfzpWS3C1U6wvUomexZSls5TOrOxBFvuIe
 DA8619tiYSeRhAvE0CCvDFQsHWgkKipb1DLjqPA==
X-Google-Smtp-Source: AGHT+IFs9CUVzeHT+mi/D8Ii63vIbUWgFuGY+Atj9w31+iyhlDiLa236Ehlz/s0dYOsaCeZ6IoUR7dh2nuJzI/OeapE=
X-Received: by 2002:a05:6102:1349:b0:475:48c9:c4ed with SMTP id
 j9-20020a056102134900b0047548c9c4edmr17463680vsl.29.1710996836751; Wed, 20
 Mar 2024 21:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-12-e1b38d9b4fa4@linaro.org>
 <CAFA6WYN3MZ0Rh-XEEggc4OUk2wUQngT3EJDcHQb0-n7jxfMd9g@mail.gmail.com>
 <1bdbe86d-abe7-4e14-947f-245cf9661f08@linaro.org>
 <259ec55a-df31-4a7e-a937-b20a24344531@linaro.org>
In-Reply-To: <259ec55a-df31-4a7e-a937-b20a24344531@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Mar 2024 10:23:45 +0530
Message-ID: <CAFA6WYO_jH50Y0gtx9AHUHsWgBTiatGnu9dvx90spueEM=6O6A@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] dts: sdm845-db845c: add u-boot fixups
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Wed, 20 Mar 2024 at 18:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 20/03/2024 12:33, Caleb Connolly wrote:
> >
> >
> > On 19/03/2024 13:55, Sumit Garg wrote:
> >> On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>
> >>> The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
> >>> This is incorrectly modelled in Linux where only the PCIe dependency is
> >>> expressed.
> >>
> >> Can we send a fix for the Linux kernel DTS to correctly model it? We
> >> can then later get rid of this modification once that is accepted.
> >
> > I spoke to Bjorn about this and apparently the correct way to model this
> > will be to have a usb-connector node with a vbus-supply property. There
> > is some work underway in Linux to support this kind of thing already.
> >
> > In the mean time he suggested to just make the regulator always-on, so I
> > sent a patch to do that [1]. I actually hit this issue when booting from
> > USB as the PCIe drivers aren't available in the initramfs, so USB never
> > turns on, and the always-on hack fixes that.
> >
> > In the mean time, we'll still need this vbus-supply reference as U-Boot
> > doesn't automatically probe regulators.
>

Try adding regulators_enable_boot_on() to the common board code. With
that there shouldn't be any need for this vbus-supply reference.

> oh, forgot the link!
>
> [1]:
> https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/

-Sumit
