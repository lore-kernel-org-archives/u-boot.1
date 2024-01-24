Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36800C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 08:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCE087BDF;
	Wed, 24 Jan 2024 09:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NjZr8AwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F67C87BCE; Wed, 24 Jan 2024 09:17:04 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BD087BF1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 09:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4b739b49349so932157e0c.1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 00:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706084218; x=1706689018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kcu2qB5NydoTUxTRUtIRMPtVzR48LuxFWR1j3xm7f9o=;
 b=NjZr8AwDabMEJQ5Wh1P+xIl6R850+wEe2XTb/BRKVWLg+oHZHGQaPj9yB9rxHFi8Yw
 BdMUIUnYoYmt2GtbxAuTto+ISw2tKuhrkI2klAmQBathuOkJfAve004mSgo6a2AIQWlg
 QxQeTC4A0FfPODb2+YUEte9hYbH77vYuRp9pT7Z0qM3SFAsnA8JjMn+mQeZSy2O/iFlz
 RR/I4DavBGO8ejbkWoogH/lU4geDQdB5ZF35IXADbBNGIymscJCwP1yTA6ectOvzfKpf
 KloWnCD/ZPGQtrSH/isxVGxLUstwLA+ZCoCLANmJwJTjhd6mSn2FAe5GvypjsXI3ra0w
 W3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706084218; x=1706689018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kcu2qB5NydoTUxTRUtIRMPtVzR48LuxFWR1j3xm7f9o=;
 b=Rh6Rrg3YD/b3/0u9lcXUPex6H2e3qgg0AjKtNMa38DTqVcYD8RWRFQhgzPHsj0p5xH
 JmKQb2ntxVTaudt/T0bckTzEEG3fRpanQRUTmlvgcXnhzyAiPJxopFeldPpX0tzBhtwZ
 cbRKGJ3cVbm0g9Ksh57qAMu0hBYZa2Qtnt30WXth8zTctfFcR8lAableaRnYDWdMTyM9
 TEKluviXxDnc050AJgZ11a1OxTk4Er3EJBwl7AbUBGbZt/Mwtkkte9G9urKIRllJ+5eg
 R559bxQBp+BfoT83aqk6mWTDRsxzTP2FZZLX0+ipiTy3Zei3E2xe1enVSe1u0cXmZ7Go
 FgRA==
X-Gm-Message-State: AOJu0Yw7a9JJZ8jI5ns1TZGYv+5byMeyLpcL6vvJ9CPf1ZsR0PlLTIag
 73jhEAEHjpd2G5xLJfkUGJho2MSA8PAL0HNffyV2BYIAmSYp3ywHvI5WjR2CcMob72cJAKKS98F
 FSzPlVFKIkcXL2Je3ql1eq2IHxmByj0/EZh5KHA==
X-Google-Smtp-Source: AGHT+IEhYOR1QLdRCSuB6qqXqIl3m2xLIv+DZnR7s6FI5/rS9odFQ/SiLTTuZw83MelpqTowOf6wb1qZjroB7kki5Rw=
X-Received: by 2002:a05:6122:4499:b0:4bb:3b81:d21 with SMTP id
 cz25-20020a056122449900b004bb3b810d21mr3055698vkb.21.1706084218361; Wed, 24
 Jan 2024 00:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
In-Reply-To: <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 13:46:47 +0530
Message-ID: <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Marek Vasut <marex@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, trini@konsulko.com, 
 sjg@chromium.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor@kernel.org, neil.armstrong@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
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

On Mon, 22 Jan 2024 at 05:47, Marek Vasut <marex@denx.de> wrote:
>
> On 1/21/24 23:41, Caleb Connolly wrote:
>
> Hi,
>
> [...]
>
> >> How do you propose to handle fixes to DTs which are applied to
> >> linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which
> >> has some defect that is fixed in 6.6.1, how will that fix get into
> >> U-Boot DTs ?
> >
> > This fix would also be in the latest Linux tags, so I think it would
> > find its way here - as I understand it patches aren't accepted into
> > Linux stable unless they land in torvalds tree.
>
> See the devicetree-rebasing.git:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/refs/
>
> That only contains refs for release versions (v6.6-dts, v6.7-dts etc),
> not any follow-up updates from linux-stable (like current 6.6.13 etc).
>

Here we should only consider fixes which are critical to U-Boot. I
think -u-boot.dtsi files would be suitable to carry those fixes until
next uprev. However, if there is a fix affecting many platforms than
we can consider pulling that standalone too.

> Would this require syncing in -rc versions of Linux DTs to get the
> latest fixes in ?

Syncing -rc versions makes U-Boot more prone to DT ABI breakages. So
its a chicken and egg problem as per your comments below. However, we
can revisit our syncing strategy based on how the current one pans
out.

>
> >> Assume that there is some large breaking change in Linux 6.(n+1),
> >> something which would be problematic for specific U-Boot platform
> >> (e.g. i.MX) or would require a lot of work to sort out, will there be
> >> a way to temporarily pin DTs for specific platform to older DT version
> >> until that is resolved (e.g. pin to 6.n) ?
> >
> > (Upstream) devicetree has to be forwards and backwards compatible, were
> > such a breaking change to get merged without prior discussion with DT
> > users (i.e. U-Boot) then I think the correct course of action would be
> > to revert it.
>
> Not really, this could be a perfectly valid change, and would work for
> Linux just fine, it might simply be pulling in something which is not
> supported by U-Boot just yet and therefore syncing the DTs into U-Boot
> would break U-Boot on that platform . Using older version of DTs for a
> platform could work as a stopgap measure until the functionality is
> implemented. Is this possible ?

For this particular reason we want to pull once during beginning on
U-Boot next window and allow sufficient time for platform maintainers
to adapt to it. However, OF_UPSTREAM=n can be an alternative for a
stopgap solution.

>
> > On a tangential note: as I understand it, DTs built from dt-rebasing are
> > still subject to U-Boot customisations via the "-u-boot.dtsi" include
> > files, this allows for dealing with incompatibilities due to missing
> > features in U-Boot.
>
> Would it be possible to auto-update those -u-boot.dtsi files during
> sync, to minimize the resulting DT blob delta before/after update, and
> thus also minimize the likelihood of causing breakage ?

In the long run the DT community would like to avoid any DT ABI
breakages at all. Rob is already working on a DT ABI check tool and
seeking inputs for what could be an ABI break [1] from U-Boot
perspective too. Feel free to provide your inputs.

Along with that we wouldn't need -u-boot.dtsi files once we make
U-Boot fully compliant with DT bindings. Until that point U-Boot
platform maintainers have to keep their -u-boot.dtsi files updated
corresponding to latest DT rebasing releases.

[1] https://lore.kernel.org/all/CAL_JsqLo4nXrJ93dDsfp3UYLs08V02aMnbCCnsDj0MBBomc35w@mail.gmail.com/

-Sumit
