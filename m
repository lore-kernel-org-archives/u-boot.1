Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD22C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B9787BF1;
	Wed, 24 Jan 2024 08:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GmQk1GRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40CD87BF1; Wed, 24 Jan 2024 08:36:23 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901C787BCE
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4bd3dcee54eso653016e0c.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 23:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706081780; x=1706686580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XwLkLXos8arye6Q9LT/d+K7t8p5sAS/biFkdo8KW8M4=;
 b=GmQk1GRsScH9S0V0ES+TuwoPOP3yjwr4x/O/Hfkjc24BCYFV7v5qzWkThJoVIupzVS
 GTYVNM0skGA25DietAT0CCxrvOpvkycAzQFEgXPvIK5fhtV3CZ1o/uiMEMOtgSbTV2bk
 NQExsuP3J7oaxhWo/ouzx5EpBmevM2SKXlND5RWX15/duvcRxqN/8RS3VTlvziMIuuCd
 7YlqprmOEPfbuqakm4p4XfQkF8QQDXTB4xQMrrWDPOVXB89GWtjbLNBSr1K+Au1A8bea
 V5IaefRth0wNbqx9+bVXxIo2jBknu0PZ2aePnLrtBB1+IittjANgKSTFhy0DDFjLWSNc
 l8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706081780; x=1706686580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwLkLXos8arye6Q9LT/d+K7t8p5sAS/biFkdo8KW8M4=;
 b=XZxeb0p7niDgAG+X+wVbL5Kwiyul5MvmPeUZAt9tWT2LkCgSvWdOffKQ/UzEVSmjQJ
 vN3w14xaU4irMhw9rpWDum8RlvFrGBxDek4CdW7sIeVzw+WarJ1/Xsj/4GGQYHNy0vI0
 uP8U7eC47lY7ielfedQPYRJgBfHPm1Ra2dvMDECVKuwpJSknrNu5WUSE9imUNVK/2uHQ
 9Jl7Dv8IRfqHIeP5wIfuuDw3RlVX/cF42b0SrblsCtVkpxv0q2JOGpPEU4L8Wjhzwf6k
 k+zIaiDSZ4QpbSjTPppw3nYVyTPKIX+bsLw3bxiJHtpKH3jxTKp8VayYEbwhEIhkhEcu
 ssVw==
X-Gm-Message-State: AOJu0YzLMz1p7r6DVNLNQH2bD03WvfxYczg+N6C8JbG07l6X3jTtWhVB
 IQIqlF2kTjsdM5AgC5PkkHUpXP8nMVHJWAJjsbMsopwyUHvFCoJVXvHIhaBTT05nl7CU7s4FHQK
 BuKZawN1zzf/gADNgo5mjf5fDpEIPC+1vL7NFMg==
X-Google-Smtp-Source: AGHT+IGMpWXZhSjESRfcE+CaD4uCOdOSqylccXv8iswNuKTUjyEslIwh2ZXnMpAp0s8lRGZU2tE+BL9seLIjNn44Qls=
X-Received: by 2002:a05:6122:3685:b0:4b7:2382:b4 with SMTP id
 ec5-20020a056122368500b004b7238200b4mr516576vkb.6.1706081780295; Tue, 23 Jan
 2024 23:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <20240122000103.GE3652023@bill-the-cat>
In-Reply-To: <20240122000103.GE3652023@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 13:06:09 +0530
Message-ID: <CAFA6WYMB_vpBHacNUARNa8q7c8BYn65rNoQNMNLeQ18Vh8T6+Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
 dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
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

On Mon, 22 Jan 2024 at 05:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Jan 21, 2024 at 10:41:51PM +0000, Caleb Connolly wrote:
> >
> >
> > On 21/01/2024 15:33, Marek Vasut wrote:
> [snip]
> > > Assume that there is some large breaking change in Linux 6.(n+1),
> > > something which would be problematic for specific U-Boot platform (e.g.
> > > i.MX) or would require a lot of work to sort out, will there be a way to
> > > temporarily pin DTs for specific platform to older DT version until that
> > > is resolved (e.g. pin to 6.n) ?
> >
> > (Upstream) devicetree has to be forwards and backwards compatible, were such
> > a breaking change to get merged without prior discussion with DT users (i.e.
> > U-Boot) then I think the correct course of action would be to revert it.
>
> The caveat is "unless it was wrong before", which happens more often
> than is generally thought of I think. I'm not sure off-hand the best way
> to deal with that.

I think that's the reason we just want to pull DT at once in the
beginning of the next window and allow U-Boot developers/maintainers
to detect and fix problems during the full U-Boot release cycle.
However, we are open to discussions for a revert if there is a major
DT ABI break among Linux major (.0) releases affecting many U-Boot
platforms.

-Sumit

>
> --
> Tom
