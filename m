Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F6EC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB7187C10;
	Wed, 31 Jan 2024 13:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BHDIxnVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18C787C39; Wed, 31 Jan 2024 13:57:13 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0105C8753A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe5844so1407126241.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 04:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706705828; x=1707310628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NtyR/Z9ER6WygVAnspoDYe1XzLDH3swBOB0ZyErE5+c=;
 b=BHDIxnVdjwpSPNWg4pMsRLf31uBaWPU0EmgztLJo0RaoqChIhdDXZ6Q7IP1xYZ3C+Z
 lXsHcf18d67xXMnXQmH7ySpsCelMtF//8cVg7hqITA6jzrjwN+wyObJDhAEH69V0BUa+
 ja14prZWW0mckiTs/Nn7c8QazYWYk/ltcXPcP+sT0mU+tK0HGsdH2+1PbrdzEW+kjJQb
 NLvCP3UKW2Bhcg21IYtGwrxqM75QM2vGJmXMTQrwiwyyY/nTp0b+wBJe+nm3mMG9H8PR
 B4tSC2lk8wmPGEvR7O5IG7XjAbHWq0eJJ+c9rGJtkjRZVq7RHhSBl3xfE1CN7/RXcs80
 Jp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706705828; x=1707310628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NtyR/Z9ER6WygVAnspoDYe1XzLDH3swBOB0ZyErE5+c=;
 b=JjCYzGpEsVeskcRkoBBrqBvcBJhvfFqyoOZiZePvrcsmovrR2oGTW3sBqEr9IPSL2l
 mlrR0+iOlt10kL6q0AF527u33OoGDzMT6y7l0J8mR0S1v5Fd+Sw1C6JV61tvuHfXomuq
 Brn9kpX+zn/tzAXDF/cBFghrBBMaOzWLZ3whEdx9hke8BVJyr5YvEZWJrRSyYuyGmX3e
 ivgzpue9eP+sueMk61ng09AwfS4iAepIBq3o9FX+SLt2qPxnvKHuOCzFm402Qsln0vAD
 6LmwJx5Bk7+IJun7VyBCQf0KeMuCOp6dzeavBarApJRi4HLxyVmoEOwGLfQoZa9SAxXS
 b4cw==
X-Gm-Message-State: AOJu0YwNCXURIGJtDv85wMW4ejK6RsOQPPTGpRNu+Zb1TPn6zSAjcDKZ
 uC43uaDkkPAzlfVksA/StGAtGYjHgzP+I2oWMhjn6qD3hF4o5A0DtKzY03ped97YlC6bpatYWnq
 z8yMHDD+0b0BA3NXu5ZE6hrlEWKlYhd8QlYAt5w==
X-Google-Smtp-Source: AGHT+IHrIedNctD/NmPCmZtdJY1jahuFo9DqjsF1NdsZQ+dTJd6mPqQyeXyGYFvi4pl2KVNqiiC8+xdidPUY3tWghbI=
X-Received: by 2002:a67:eb82:0:b0:469:877d:fc1a with SMTP id
 e2-20020a67eb82000000b00469877dfc1amr1281070vso.8.1706705828527; Wed, 31 Jan
 2024 04:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
 <20240125231933.GY3652023@bill-the-cat>
 <0d4ed462-a5ec-4114-84ab-d2e2a6d79b69@denx.de>
 <115d5376-8cf9-474a-9344-223df4ee1d6a@amd.com>
In-Reply-To: <115d5376-8cf9-474a-9344-223df4ee1d6a@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 31 Jan 2024 18:26:54 +0530
Message-ID: <CAFA6WYMP0=LOJhHYvXSB9CA-EaSD0+dfxZcb6U0BTgfRiGk4hQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
 dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
 jh80.chung@samsung.com, rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl
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

On Fri, 26 Jan 2024 at 12:35, Michal Simek <michal.simek@amd.com> wrote:
>
>
> On 1/26/24 03:10, Marek Vasut wrote:
> > On 1/26/24 00:19, Tom Rini wrote:
> >> On Thu, Jan 25, 2024 at 05:38:23PM +0100, Marek Vasut wrote:
> >>> On 1/25/24 16:04, Tom Rini wrote:
> >>>> On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
> >>>>
> >>>> [snip]
> >>>>> But at this point we have to move away from apprehensions about DT ABI
> >>>>> breakages and provide real examples of the DT ABI breakages in the
> >>>>> past. Are you aware of any DT ABI breaking change backported to Linux
> >>>>> stable releases? This is the sort of information we would like to make
> >>>>> DT bindings maintainers aware about.
> >>>>
> >>>> Well, how far back are we going? There was a serial related one, but it
> >>>> was probably closer than not to 10 years ago and lessons have been
> >>>> learned from it already.
> >>>>
> >>>> The real breakage comes in the form of (from the Linux kernel):
> >>>> commit 37685f6a63eeca2135d1f704e7638409a071b1f6
> >>>> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>> Date:   Tue Feb 19 08:46:33 2019 -0800
> >>>>
> >>>>       ARM: dts: am335x-evm: Fix PHY mode for ethernet
> >>>>
> >>>>       The PHY must add both tx and rx delay and not only on the tx clock.
> >>>>       The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
> >>>>       the tx dealy is disabled.
> >>>>
> >>>>       The reason why rgmii-txid worked because the rx delay was not disabled by
> >>>>       the driver so essentially we ended up with rgmii-id PHY mode.
> >>>>
> >>>>       Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>>       Signed-off-by: Tony Lindgren <tony@atomide.com>
> >>>>
> >>>> And this is of the style "the DTS was wrong before so we can break it".
> >>>> This is the specific example (as the board is in my lab) that comes most
> >>>> clearly to mind but there have been similar examples in 2022/2023.

I agree that these sorts of changes should be done in a DT ABI
compatible manner to U-Boot or atleast proactively adapt U-Boot to
those changes. But I am not sure how we can improve here without a
regular DT sync cadence with upstream and a Linux kernel maintainer
profile to say that DT ABI towards U-Boot has to be kept in mind.

The existing ad hoc syncs won't be motivating Linux DT maintainers to
care about U-Boot regressions.

> >>>>
> >>>> The other just as painful examples I think may be where Marek is
> >>>> concerned and it's around nodes being renamed for correctness. We've had
> >>>> a number of cases where a - turned to _ (or vice versa?) and whoops,
> >>>> platform stops booting. Down the line, tooling would catch that, and
> >>>> it's a problem of not being able to use better tooling until we have the
> >>>> updates that might break the boards that need the better tooling.

AFAIU from this [1], the DT node names aren't part of the ABI. Given
that we should start motivating people to move away from relying on
node names, for eg. using uclass_get_device_by_seq() instead of
uclass_get_device_by_name().

[1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-ofw

> >>>>
> >>>> And really this gets to the crux of the problem, how much testing do we
> >>>> insist happens prior to a re-sync being merged?

I am not sure why custodians/maintainers depend on the global re-sync
to be merged for testing purposes. They can very well have their local
vendor directories synced-up and proactively look for any regressions.

> >>>> Do we want to go with
> >>>> the whole of the dts files are re-synced, or do we leave it per vendor?

Leaving it per vendor would be somewhat similar to existing ad hoc
syncs. BTW, what about bindings directory? We won't be able to enforce
binding checks given the different state of per vendor DTS directory.

> >>>
> >>> I'd much prefer to leave it per vendor, with the recommendation to use
> >>> synced DTs. Eventually things will stabilize and vendors will start
> >>> switching over.
> >>
> >> To be clear, every SoC (or really, board) has to opt-in to OF_UPSTREAM
> >> to start with. With that, I see switching to OF_UPSTREAM meaning that
> >> there's a commitment to keeping up with dts change in upstream dts that
> >> might lead to issues within U-Boot. Do you still feel it would be better
> >> to have the re-sync _also_ be per custodian tree? That might be a bit
> >> harder to handle.
> >
> > Maybe the best thing we can do is just give it a try and see how it works out,
> > esp. since it is opt-in per board .

Yeah given that we are conservative about re-syncs with a full U-Boot
release cycle to detect and fix regressions.

> >
> > It would still be good to solve the part about pulling in fixes from
> > linux-stable though .

So I did a demo experiment for this here [1] where cherry picking DT
fixes into subtree just worked fine with the next uprev. Steps
followed:

$ cd <U-Boot tree>/
$ git remote add dt-rebasing
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
$ git fetch dt-rebasing master
$ git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/
9de355a75fdeffc26486508107bf644ca2749fdb
$ ./dts/update-dts-subtree.sh v6.8-rc2-dts

If you would like it to be documented then I can do that for the next rev.

[1] https://github.com/b49020/u-boot/commits/v4_dt_demo_fixes/

>
> I would let board owners/custodians to deal with their boards.
> There is very high chance that if you do it globally that it is question of time
> when something will break.
> It make sense to talk about how to do that transition and describe that steps
> and having tools/script to help with.

Given my comments above, I think we should at least give U-Boot
owners/custodians a chance to opt for this and see how it pans out. It
will give a better opportunity for the U-Boot community to engage and
be a part of the current DT contribution model.

-Sumit

>
> Thanks,
> Michal
