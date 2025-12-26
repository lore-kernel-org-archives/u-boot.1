Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8D9E8FDB0
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 17:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E92839AC;
	Fri, 26 Dec 2025 18:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XxrlKP/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 951D8839AC; Fri, 26 Dec 2025 18:44:28 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4A283990
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so6486019a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766771065; x=1767375865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xkILvB/m5iZwZPhTgUOxp2H6xzbjTkFGKr/cf/SEk0U=;
 b=XxrlKP/EuiP+wwKb2fDI87GHeaFCXy2z4G60AMl+1fOhP4A21EzQj9h9fpbwzAtcxm
 mxn7AaJDQySDQY3L3KveOFeH2Ey92srzrTBZFZkqEiE5wABC4Y+2SPNZq04mo/0NbPsP
 XaEQvEsIKqU25F13sC9ghfBd4gyZGl8paCOuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771065; x=1767375865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkILvB/m5iZwZPhTgUOxp2H6xzbjTkFGKr/cf/SEk0U=;
 b=R9zMpk9EYGir7X6znvocQkSNl+JwCv2DIEgWAp7MLdd84ABQ/85tZgeZm97da4aVqf
 Xw2vyV3a7xxPz/2hXJQJJUq0Z8430GyrIU2xDFl9KE7SfPHuV+1cUvUsWQTJ4bKIirAI
 QeiV0vmGle6GF9B+7i8HcH3/BJ4WBUbGLwLnHBdgyLCC47Rcz0Cr22XsgSFnupZKwnD5
 fdkv08WWUvnL8dPnR4ZrydAzHhHObhHkZfW02VcHKJS+U9uT62S6UCOfCOlGx+eDZufi
 T9GXnXLcyDRmgoTFC2ZvSpH1JjwLWHDD02ed5kAVS51uQkp/LWx4+Y+0EBnFBI+U4gee
 OlQg==
X-Gm-Message-State: AOJu0Yxz9omGbz8kfR4EGBHFXzS/Jw+tApmgL0wqYNtd0IEUBBrmzhuQ
 HG/P34tWvIHyRNp13KdsmWa9cpVUOujoUjRQcivYTc2rmkJ+WCFGAkyGfV/MsdHFpQl37HqDbU1
 8aCvyUssd3p+rrtvZHWdr4+qdsoFnZd+KV705qmlt
X-Gm-Gg: AY/fxX5XQnyHKfFZ1Jpvvj006FXTO4y0G41/jXxe8QRXhiJBFebFRennLL8jPe9S+xc
 tJIwgx21BEwX2ZfGudpFQDV0SotLaO/NJJ0V/5uTAbmylw1aIt2YIge5moR1JbGElqmdWYDzy/y
 QTGXsq38uqP0Qsiw9DuaK/nq8MT+dej8sV1VjV8iGvcKOJ83LJP14w33SsZTB30Af1pf4MGR5V2
 WYevLMuXQie3AmdsvAxI3JR7gzDcHukQS3i7Y1S/YdmnzyQ3fxKenz/Q+5qnxbVD+dkZsS9faP4
 uVqc
X-Google-Smtp-Source: AGHT+IGjnbdws0T7/HFsoaOGmQXwKDU2urZjcMtLDuB3XCQfOQLr348B6YOPxc5mhfz48+n2MlqxQn73hyqKeV29X0M=
X-Received: by 2002:a17:907:d0c:b0:b73:9280:2e7 with SMTP id
 a640c23a62f3a-b80371a3eacmr2314608366b.34.1766771065419; Fri, 26 Dec 2025
 09:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAFLszTjyO9d+QzwC=9t-cJ1Kx9oNcNSD3f7T+11zWwD-PJeYag@mail.gmail.com>
 <20251226145347.GB710860@bill-the-cat>
In-Reply-To: <20251226145347.GB710860@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Dec 2025 10:44:16 -0700
X-Gm-Features: AQt7F2rjGzT5UrnJSUu8ixF7qGmMz3QpcvX-VeJhDavAmi3IaJv2bkkayTC6s7g
Message-ID: <CAFLszTg3RBxzLG_iom6ogCSFSxoK9=HMxnwtKXuC35K6J+LRPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Hi Tom,

On Fri, 26 Dec 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 24, 2025 at 09:23:59AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 19 Dec 2025 at 13:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > The devm alloc functions that we have may follow the Linux kernel model
> > > where allocations are (almost always) automatically free()'d. However,
> > > quite often we don't enable, in full U-Boot, the corresponding automatic
> > > free. This in turn leads to memory leaks. Rather than manually tracking
> > > allocations and implementing frees, rework things so that we follow
> > > expectations now and enable the DEVRES functionality to manage frees.
> > >
> > > This turns DEVRES from a prompted symbol to a symbol that must be
> > > select'd, and we now remove our non-managed alloc/free functions from
> > > outside of xPL builds.
> >
> > Most of the time boards don't enable DM_DEVICE_REMOVE to save code
> > size.
>
> I'm not talking about DM_DEVICE_REMOVE anywhere in this series.

Without that, devres_release_all() is never called. How are you
expecting things to be freed?

>
> > We certainly don't unbind devices. A memory leak implies some
> > sort of problem, but if we are booting the OS, all the memory is
> > 'freed' by that process.
> >
> > What problem are you solving here? It is missing from your commit.
>
> The problem being solved is stated in the commit message.

Can you elaborate a bit? I see a vague reference to memory leaks, but
you should explain the problem. Are you trying to free memory before
booting an OS? Are you worried about devices being repeatedly probed
and removed, thus causing a memory leak within U-Boot? It's just too
unclear.

Depending on what you are trying to achieve, we should perhaps make
DEVRES depend on DM_DEVICE_REMOVE

Regards,
Simon
