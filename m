Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1039AC10F04
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 13:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2971E87538;
	Mon,  4 Dec 2023 14:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YRXBYayl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC38186FC9; Mon,  4 Dec 2023 14:24:59 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C495487554
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 14:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7c5d16a4bc6so177784241.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701696294; x=1702301094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=20uymVJmL+HUvcOn2G+iEmWMkjAMhK8O1mtsucMRtYE=;
 b=YRXBYayltSWeWTwHm74MnbsuX8VIlFPkpGUdvZjDeJ9riDLZxyjr8Eqg/9d7Wrdo+o
 oY9auHIVYBHMRv7Odq8D0DDlrW60juJGw99qM7EcJRcCgVNQQoVCgwWeEOtx08rULtBB
 LpNdXI8ArlD8QHGzIEkJnZ9MV7lx0NZApVNDk+WFCNLqqWyUGpsQ75LiMVKEtj3erxvf
 ZmttywodiNFmp4mKHA+nM0jtBtuEr/LlxATA1jrjKNmRY2yL4D9ZRWMiEMZ/ZZk2Qyti
 3FR5yM2KzeecG1OaEYR6dMXsSY5b/jxDQjjUHPTCtjavNqCmOyHN2dtaN2f2eMD/ExsG
 7D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701696294; x=1702301094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20uymVJmL+HUvcOn2G+iEmWMkjAMhK8O1mtsucMRtYE=;
 b=Ga/Ro4Ds++duYrigS9dpzr/agKnnJchL3uwMRdTaskOE2uto1UaKRzMFxHd+OnNy04
 ucXt+m0UYP44eMCVJBOz7rHJiKG8ukLsXqajVyK6DdMFwt/KM0ZH/q3sy37XPq3dlgQb
 EGL+Ue42hc7v6JaQvRM6XYhQHO00weS26jogAPHgagdFIuLgJB9W0dKqujpcSyU+0OZ0
 m+LC7urCg9smzh96D8yo8i5vOFAZGNoC/k4gsc+b5Wm25YdCKxK2DT3P2UmirLUs06DL
 ZsDNNfCjKi+fCw0Vh9eC0izX9ok0AAqZ4TXig0eG2vjMDCr42mb2JZ8sGneTjLKrAHKS
 GSMg==
X-Gm-Message-State: AOJu0YyB8UWo9Xae5gCnlk9NesPswMlAhM8cagGizF8MIYcVQ/TCoRKg
 L1JwQITSRqLA9MI/Z2I5xirCVyBiESr66m/Rvky6gg==
X-Google-Smtp-Source: AGHT+IGsMtzSbHDbNjb2bmr+0iC4tjuRcaIYzy0Sr4HkQm+nd+1ViCbbh/DECzlsbLIgMGeYKfn07J8GSTRykEdjk10=
X-Received: by 2002:a1f:4c05:0:b0:4b2:da3b:a71f with SMTP id
 z5-20020a1f4c05000000b004b2da3ba71fmr1429224vka.25.1701696294485; Mon, 04 Dec
 2023 05:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <20231204110025.GA27965@aspen.lan>
In-Reply-To: <20231204110025.GA27965@aspen.lan>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Dec 2023 18:54:42 +0530
Message-ID: <CAFA6WYPYfKU9hHh5CCbgcb6FEDX7ivGO=tGv4N2dAX6_gAGuUw@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, conor+dt@kernel.org, 
 Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org, 
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

On Mon, 4 Dec 2023 at 16:30, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Mon, Dec 04, 2023 at 11:02:57AM +0530, Sumit Garg wrote:
> > + Linux kernel DT bindings maintainers, EBBR ML
> >
> > On Thu, 30 Nov 2023 at 20:05, Tom Rini <trini@konsulko.com> wrote:
> > > On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
> > > > On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > > > > > I've been thinking about and hacking on this for the last week or so,
> > > > > > sorry for the delayed reply here.
> > > > > >
> > > > > > The value is in preventing any of the existing bindings from regressing,
> > > >
> > > > That is actually best addressed in Linux by checking the DTS against
> > > > yaml DT bindings. We don't have that testing available in u-boot and
> > > > only depend on careful reviews.
> > >
> > > I would absolutely love for someone to make another attempt at updating
> > > our kbuild infrastucture so that we can run the validation targets.
> > >
> >
> > Given that EBBR requires [1] the platform (firmware/bootloader) and
> > not OS to supply the devicetree, it becomes evident that
> > firmware/bootloaders import DTS from Linux kernel (where it is
> > maintained).
> >
> > But currently u-boot doesn't have a proper way to validate those DTS
> > against DT bindings (maintained in Linux kernel). Although there are
> > Devicetree schema tools available here [2], there isn't a versioned
> > release package of DT bindings which one should use to validate DTS
> > files.
>
> The kernel is regularly released in multiple forms (including git
> tags and tarball). Why isn't the kernel itself sufficient to be a
> versioned release of the DT bindings directory?
>

The Linux kernel may come in various forms (upstream vs stable vs
vendor). It's difficult to decide from where the DT bindings should
come from. Should they come from upstream or should they come from the
kernel which is actually booted onto a particular device?

IOW, as of now which kernel version should u-boot pick up for DT
validation checks?

If we can have a separate release cadence for DT bindings then the
platform (firmware/bootloader) can attest the DTB against that. Later
one should be able to boot any kernel with the DTB provided by
platform.

-Sumit

>
> Daniel.
