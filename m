Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0A7C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B9E2875F5;
	Wed,  6 Dec 2023 06:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FjHc9WQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8721E871BB; Wed,  6 Dec 2023 06:05:20 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0158744C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4b2d08747e7so1158278e0c.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 21:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701839114; x=1702443914; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n9A86xV45IKqz21mQAWpnUex7u9XfQVXODvHnpdnZLs=;
 b=FjHc9WQHMVWVX2QYDpxIq8kSTCqoFFovnzdSpBjlgqmGdc48BuVndRPoUfyn7pEbev
 ap0HOtcfLw06NudODzjDcQ0XdCz+QlzUCwi6bpBGhsFlB9BXENPoqCgQOUlD5lWQ6rC6
 Qw7TMQXk7zCKDeacdak78neA9H30QMyhzhdtyzHYS3WHiiOBpa8MyzWHpumf808xxIfv
 0iI0xMGHgQHtJ4RU4lyT2xwWqqRjjzGohZilPd7iFstPjZNd3DbmYeDtCreiXveWQKlH
 pj3VaCyb2AAxLqnGkZ6q6WCL4WsBIPy/DXuW4LzIZiFYAAydKUxndU1oGEawGmGEO4uc
 uLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701839114; x=1702443914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n9A86xV45IKqz21mQAWpnUex7u9XfQVXODvHnpdnZLs=;
 b=jwK8/148uLZ4SrPt8H0Xe26dQqDhtZUfGVHnPFmDi8naRnjUv/593yjjmTtWXZ7kxz
 T/Gx1S6pCvoITXGdChJLbn7wS3wwokw0YZd9kyWG/LrY3S5C8zoBUozxKhyJr93Z2+Hk
 W2zZVeiVZJ6nnu2iqGF4Iq6yqHu86IeAWmx3jxs3LCxp13j9HJ0uCtsIBo+FsKSR6CH6
 ifEknVYxFOUyeivdwClbxxYpAJ4pY2XWp8NMb2tPL9oKfMkC9Y7/Hcym2YLHQg2zxK95
 as2/0XM8qVa6Af/88uIvtomeJjprSiDaFmi9HE0zVJWqxpez0uOYnHOOiSQDG6op5jE/
 tIwA==
X-Gm-Message-State: AOJu0YzZm7ny2x9l1BbcpM3MQ41/k2b0o4fxBkDs4WffWFd+FtARNLGN
 kkmijalcke73ZghjeOz42MDbSS+abhIEy+7S7HoeFA==
X-Google-Smtp-Source: AGHT+IFodHfJXc2V/Fjo23yBg5iDdt9x80+ebnADHvTCkIdy4ROMkg1IOo5NjZrEcHpDMzV0EHmdgZc0O/SJDqypnxo=
X-Received: by 2002:ac5:cd4f:0:b0:4b2:c554:ef00 with SMTP id
 n15-20020ac5cd4f000000b004b2c554ef00mr359890vkm.18.1701839114213; Tue, 05 Dec
 2023 21:05:14 -0800 (PST)
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
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
 <34334add-4017-46f6-873a-d9233e29f640@linaro.org>
In-Reply-To: <34334add-4017-46f6-873a-d9233e29f640@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Dec 2023 10:35:02 +0530
Message-ID: <CAFA6WYN_uf0+tHm7RxXXz_7U3tdbdsK1rttnQN-rcfRknrcDQA@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: u-boot-custodians@lists.denx.de, Rob Herring <robh+dt@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
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

On Tue, 5 Dec 2023 at 15:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/12/2023 10:45, Sumit Garg wrote:
> > + U-boot custodians list
> >
> > On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/12/2023 08:13, Sumit Garg wrote:
> >>>>> @DT bindings maintainers,
> >>>>>
> >>>>> Given the ease of maintenance of DT bindings within Linux kernel
> >>>>> source tree, I don't have a specific objection there. But can we ease
> >>>>> DTS testing for firmware/bootloader projects by providing a versioned
> >>>>> release package for DT bindings? Or if someone else has a better idea
> >>>>> here please feel free to chime in.
> >>>>
> >>>> This doesn't work for you?:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> >>>
> >>> Thanks, this is certainly a good step which I wasn't aware of. Further
> >>> simplification can be done to decouple devicetree source files from DT
> >>> bindings.
> >>
> >> Why?
> >
> > I suppose you are already aware that Linux DTS files are a subset of
> > what could be supported by devicetree schemas. There can be
> > firmware/bootloader specific properties (one example being [1]) which
> > Linux kernel can simply ignore. Will you be willing to add all of
> > those DT properties to Linux DTS files and maintain them?
>
> We already added them and we already maintain them. DTS describes the
> hardware, not the OS-subset of the hardware.

Let look at some numbers if your statement is justified or not for the
example I gave:

u-boot$ git grep -nr bootph-* arch/arm* | wc -l
4079

linux$ git grep -nr bootph-* arch/arm* | wc -l
267

It looks like there is always going to be a catch up game regarding DT
properties which either Linux kernel or u-boot or any other
firmware/bootloader project don't care about.

>
> >
> > However, DT bindings are something which should be common, the
> > hardware description of a device should be universal. IMO, splitting
>
> Both DT bindings and DTS should be common. I don't see the difference.

If we really care about DTS to be common then the contribution model
has to change where there is a single repo hosting DT bindings and
DTS. All other projects whether it is Linux kernel or u-boot or any
other OS/firmware/bootloader are just consuming DTS files from that
single repo. I suppose this is something that Linux DT maintainers
have objected to in the past for ease of maintenance. I am not sure if
you folks are willing to change that stance.

>
> > DT bindings alone would ease the compliance process for u-boot drivers
> > in quite similar manner to Linux drivers.
> >
> > [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/bootph.yaml
> >
> >>
> >>> AFAIK, DT bindings should be forwards and backwards
> >>> compatible.
> >>
> >> The same with DTS.
> >>
> >>> So if you pick up DTS or DTB from any project tree
> >>> (upstream kernel or stable kernel or u-boot) then DT schema validation
> >>> would ensure that corresponding DTS or DTB doesn't regress the DT
> >>> bindings.
> >>
> >> And why is this argument to decouple DTS from bindings?
> >>
> >
> > See above.
>
> It's not really explained there. You can pick up DTS from any project
> and validate it against the repo Rob mentioned or against kernel.
> Whether DTS is in that repo or not, does not matter for your validation.
>

It is similar to your earlier argument to use the whole mainline
kernel repo. What is the real benefit to keep DT bindings and DTS
together when every project has to maintain a copy of DTS in its own
source tree? It will be just a source of confusion for developers:
- One DTS coming from devicetree-rebasing repo
- One DTS coming from local project

-Sumit
