Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B22C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 05:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E5E870A0;
	Mon,  4 Dec 2023 06:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bzfmHuEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A50870A0; Mon,  4 Dec 2023 06:33:13 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9048870D4
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 06:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4b2e73beca2so39716e0c.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 21:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701667988; x=1702272788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k4Ru6MzsoaVpzIFqVovKD4Ek3RfwKt4TMtUvf2H0Pas=;
 b=bzfmHuEa6QPDX66/sqsjuoYopNziHZUTowavCGUXCY2lpRhSsE5Tf6aPv3rFRghP6U
 tiUDPvYTW0Sl5wXcA1Bk/lnNU/EE4YIIfRuJUcFI8fotIq2/WEdVXzebrm7fh3gKXyOW
 uoDcWrblPAkQXuZJATHuZL75zc0nxbvtBxzbzwEikFAFloovbRM3v2a4M8YqLrbS8SrK
 iYZEUr02G3DvFFyt8XnhHUtEIqZmsB0XWa4+UbzX64Q0IZ2ikqo/HlrX+0DXHYiDlcQZ
 yPoXzp68FL3pJLU1kAkD71sazxyUTKvOwnsps8hyGO+X+39AxREGLyLL/+OPMWEJRakW
 H97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701667988; x=1702272788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4Ru6MzsoaVpzIFqVovKD4Ek3RfwKt4TMtUvf2H0Pas=;
 b=o7nSeotdQtjIYFZqFMnWmVCWUf0esWXklszd0VkQonbwbs5Iz/dpwv/dyDTAlQXngj
 yUrmHRXZqTO4FdmIoESmIRmhe570iv82OkbV6Heo1bXIqMGHc1gYohP14ND5FFDuaLPX
 /H+c8mNE4rerl7o7QH2EI5k1XiyptghYCcg26t78mXGhfD2HNBIuaD9Nzud8hzmlfabT
 Zgv7C0rgVQrpfdKsOwqKmQBSF0KF/pXDwtcLj1EmA/FJMLJpP21OdG7MywJmGwucJrtZ
 nw3IieIYmvNUYaFohCl9GmFS5E9EZLxXBalexToKTAKyvcm0LurIh+81oeF94DsztWS5
 61wQ==
X-Gm-Message-State: AOJu0YyHHFM4aNDMx8QKTt5MtMNO8cXntWp/9S0IqA6JKoz2L3ikb5xl
 rFhpIlubBFebXKPI5wYvfGd8UGULpyCWgkO2IQCozQ==
X-Google-Smtp-Source: AGHT+IETcKGQNvc46fzLqjvG5t9jc7Y1n6u6d6eEknThHl/1Q1cL/pAsam7ZIGNkG2kMMaBjKVqpuJXN5wTZxX/1a7g=
X-Received: by 2002:a1f:e204:0:b0:4af:f838:3ebf with SMTP id
 z4-20020a1fe204000000b004aff8383ebfmr544311vkg.3.1701667988369; Sun, 03 Dec
 2023 21:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
In-Reply-To: <20231130143512.GQ2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Dec 2023 11:02:57 +0530
Message-ID: <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, conor+dt@kernel.org
Cc: Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
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

+ Linux kernel DT bindings maintainers, EBBR ML

On Thu, 30 Nov 2023 at 20:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
> > On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > >
> > > On 29/11/2023 16:34, Caleb Connolly wrote:
> > > >
> > > >
> > > > On 23/11/2023 07:04, Sumit Garg wrote:
> > > >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > >>>
> > > >>>
> > > >>>
> > > >>> On 22/11/2023 14:27, Tom Rini wrote:
> > > >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > > >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > > >>>>>>
> > > >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > > >>>>>>> Hi Caleb,
> > > >>>>>>>
> > > >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > >>>>>> [snip]
> > > >>>>>>>> == DT loading ==
> > > >>>>>>>>
> > > >>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
> > > >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > > >>>>>>>> bootloader, so we can instead rely on the first-stage bootloader to
> > > >>>>>>>> populate some useful FDT properties for us (notably the /memory node and
> > > >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > > >>>>>>>> map changes above, this let's us entirely avoid configuring the memory
> > > >>>>>>>> map explicitly.
> > > >>>>>>>
> > > >>>>>>> Since with this change, we don't need to embed FDT blob in the u-boot
> > > >>>>>>> binary, so I was thinking if we really need to import DTs from Linux
> > > >>>>>>> for different platforms and then play a catchup game?
> > > >>>
> > > >>> For now, yes.
> > > >>
> > > >> But why? Is there any value added by larger u-boot specific DT (most
> > > >> of the nodes being unused by u-boot) than what currently u-boot
> > > >> supports? The more important part is to get alignment with Linux DT
> > > >> bindings. If you need to have memory/reserved-memory nodes in u-boot
> > > >> DT for generalization purposes then you should import those particular
> > > >> nodes only.
> > > >
> > > > I've been thinking about and hacking on this for the last week or so,
> > > > sorry for the delayed reply here.
> > > >
> > > > The value is in preventing any of the existing bindings from regressing,
> >
> > That is actually best addressed in Linux by checking the DTS against
> > yaml DT bindings. We don't have that testing available in u-boot and
> > only depend on careful reviews.
>
> I would absolutely love for someone to make another attempt at updating
> our kbuild infrastucture so that we can run the validation targets.
>

Given that EBBR requires [1] the platform (firmware/bootloader) and
not OS to supply the devicetree, it becomes evident that
firmware/bootloaders import DTS from Linux kernel (where it is
maintained).

But currently u-boot doesn't have a proper way to validate those DTS
against DT bindings (maintained in Linux kernel). Although there are
Devicetree schema tools available here [2], there isn't a versioned
release package of DT bindings which one should use to validate DTS
files.

@DT bindings maintainers,

Given the ease of maintenance of DT bindings within Linux kernel
source tree, I don't have a specific objection there. But can we ease
DTS testing for firmware/bootloader projects by providing a versioned
release package for DT bindings? Or if someone else has a better idea
here please feel free to chime in.

[1] https://arm-software.github.io/ebbr/#guiding-principles
[2] https://github.com/devicetree-org/dt-schema

-Sumit

> --
> Tom
