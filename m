Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3436ECD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF05284717;
	Fri, 15 May 2026 16:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JdaZnpjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB36E847B0; Fri, 15 May 2026 16:41:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84FA2846FC
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so1334200066b.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778856086; cv=none;
 d=google.com; s=arc-20240605;
 b=MyaeSSa+TIQ6HroTKzCOZ67BEjfZNfX+xKrOlL7umIEMYziPukMlclgmGzdDaBM6ZA
 SU+KfsH2A5pLWxRo1EFIHCf3sbPSlBYRiceg4OHRKdCEqx8t1HB6KImSllpFh25ogdTK
 WdfirW2aarayGgtn2WFdWGQaeCnM/uJcXrVW4Zc1CImNJtS2IETd8wN+nEaswiRRHDe5
 aiFNLhzDaBSd9s30zYzu+BvKBIFifAQzDM9rUoy7MccqaKyGu9X/i4r7UUI4glt/y4aa
 zrGPdypU9CVTmmM/rJ2c/o1JFTUjLTE3Jq0fbqnnEzpiRCt7VohvjKF7Wf2cSopNare7
 hfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K8q++9S++nZlmg2t53yBoQyC8yk91/Fn+Lud8gCO/os=;
 fh=4YubCvbzOnWz+L4u1OgwmukR5Vm/Y53XvnD5SfEgUlk=;
 b=FArKUzkgYEBIjX6teL5C0ZbGlGwobqtFp+i4XDDi6p7ldipqMgZ8fVZHwf0cnnXcFe
 h1whohsBzcYdEvF960EJFnMf8K/DjiWrF1No+JlFzJ/vpq3Tkwvy0xlMUVZeYqsjicIY
 7JjB+TBUay7pOceoTPAAMtO6nO8h+D4kMDikujsq62Gib3jjfX4y93zYJUZDtA4PJiHe
 dPt4ogs5Frdzgr8BOMF7XQ/6ZQVJT30w74hOmHBf2HpKiFIbV3pz8Mcrai8mBrzZ8iRf
 yN3wJq6BmfMV3LSSRgCFCeKtTCZg3dkB+ow/ROwBUHdU5D793b/Cmsk+IjwQUTtocfkd
 6vRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778856086; x=1779460886; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8q++9S++nZlmg2t53yBoQyC8yk91/Fn+Lud8gCO/os=;
 b=JdaZnpjB7dXCCJSuOBOeNFgZN+M/M21qjund49OAUvvmJXF0HMCgKBqDPlGySV6mv9
 3MUcSs5NevSbmeHOHpxSy8A9arznByNdvxcZZRNrrd40qpj6k56TratmDrhq8yTtm4Ws
 2Z/DO/3z5KISR6VbfJ5p5+6l5vWUHbebT2XexDRAcaXhO+hDSJkfN3XiUg++kprQdiI3
 rmRRzNOYGwY3TU0qCAzduXb57aDGR/5nR/6cUrhpYRuN2ylhDawqWmuM+TC4nt4kXifT
 So1/4LIWkb+JvHs+MMj7LC8qnvNNOILK0iMcpUnKLPey3XcJPj8E7FG9vkNSOK0K91Yv
 hYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778856086; x=1779460886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8q++9S++nZlmg2t53yBoQyC8yk91/Fn+Lud8gCO/os=;
 b=E08ofqbGAVYuvjBAgilxIv0DdNUTt7QTwCFSzwn76+72Rbf29PeeqVuLruAOTZp65/
 3JnZ+qd5sbJ9oguLHAxIN7/AepI98oXhgUejOS0joTjt3yUXMj9BW/jOy2/YORoXqrrE
 XmL5ThPlmxIBjAZ2AHrn04hhEkLkZdqPEuBtCqnHTWVCCnGXJVxyBLziV2xexg2p90Vw
 huSGXTTuMmGm28z8DwrhjzlQh9mFrQ6niTNlAG7DKuSSvfbexGZO+focbqzDUZ2C1/5E
 Nhf1w2amHJNjBDsv9eD6FpdEAkvqAr/WjJb5XX6OVJ0v2Jl/VP/a81T/YqcwZVqjik28
 AGZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ810jx6mjHS6bxWJV2kaSkH9y4lJrHmPu677kNjJlvmpvsrKV33abqe0Ui9RhD68gwVYgcy5kY=@lists.denx.de
X-Gm-Message-State: AOJu0YwhXmkux0xFJvcJ2BVYg/nZ0xEnfm1Agmk9cG5SVL9x4yw4y1hy
 NNx6fim7aN+cwqL6bRrPTBaxoyT06WdJ/OEkJ50s0JRPptPtxKYGG4ZwvRdrvCELK6FwUH115sG
 kmuvmD0PWK2boDwolHxbwegeTF0ehYgE=
X-Gm-Gg: Acq92OG27fEJ5GcLX1tnGupvjDfndH6Lx7cDSyagRUHn2HLcxi6NPNbOIiSw6Hl9OOM
 P7CObBbeaH1LSG+SCCa9VsQ5KY0PMne6tH7qRAlI34Xtux1C8YVw+DtCgVe2M1QIj8Nkfp36IDp
 K2cZrj5Gl8Wgot1PS3fpucSErXUHP4QwI7cJDANiFYvgR/zOUR7LuAjQ3Y9xlBs817qoRTp770k
 vdlDKyVmFnOJwDO7X0DiNpepJKduTUUBSD90oDNi1qenfo9S8dCDxi0CIISry8ORIU+Nz29gkpK
 OzkWP68ERfKbhj6XGHRHjIUWjvBLbvM161Z6XvMa01y4jCToFC8enQRwv1IAdt9lkn/wmNIWnWU
 TiflmkPmIUm+P0h+DwXdOttXiE36VDths/g0zVn6k48Ced1vACWRYPmephhHC2E/9HAwIkLj/7G
 Ta
X-Received: by 2002:a17:906:6207:b0:bcc:3dd8:58da with SMTP id
 a640c23a62f3a-bd517930092mr235258066b.27.1778856085671; Fri, 15 May 2026
 07:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260511220555.GM1858239@bill-the-cat>
 <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
 <20260515141043.GY1858239@bill-the-cat>
In-Reply-To: <20260515141043.GY1858239@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 15 May 2026 15:41:14 +0100
X-Gm-Features: AVHnY4IHy-HnKEHgU4dDgAvtE9zw9Tfdk0N3gTeSdegBy5Fm6isjPtpl9ZPrvD8
Message-ID: <CALeDE9OjxWXtqA8T=5v1go0ZCn+hc2V4Kxv4yOSbwAkK5jufgg@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2026.07-rc2 released
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

On Fri, 15 May 2026 at 15:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 06:49:25AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 11 May 2026 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > So it's release day and I have tagged and pushed things out.
> > >
> > > As I mentioned earlier today[1], I would like to again thank DENX (and
> > > the Denk family) for supporting the project for so long, and we're
> > > starting the process of moving our infrastructure to the OSU OSL lab and
> > > the u-boot-project.org domain.
> > >
> > > The delta between -rc1 and -rc2 looks OK to me, and I do still think
> > > there's a few outstanding PRs to come in and a few things I should pick
> > > up as well. But, the next branch is now open and so bigger changes
> > > should target that and I will be applying a few things there shortly.
> > >
> > > To repeat what I said in rc2 (and will keep repeatint) is that it might
> > > really be time to retire support for running our tools on Windows under
> > > MSYS, rather than something like WSL. The move to support more modern
> > > OpenSSL versions has hit a lack of support problem in MSYS[2].
> >
> > I'm not really the right person to answer this, since I'm not a
> > Windows user. But as I understand it, this would mean not building
> > Windows executables anymore. Is that right?
> >
> > Should we perhaps just build without the pkcs11-provider feature?
>
> In the age of WSL, I'm not sure the value of supporting MSYS. If someone
> is using this, and steps up to resolve the problem, great. Otherwise we
> should end up dropping it. Unlike the macOS side, we haven't had a
> report of a user in well over a decade I think at this point.

I agree that we should drop them. Put details in the release notes and
if people come and complain we can revisit the decision.

Peter
