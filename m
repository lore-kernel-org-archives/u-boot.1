Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5F7C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF56082BAB;
	Fri,  2 May 2025 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IvIHokXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9475582BDA; Fri,  2 May 2025 16:49:28 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF27082CBC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so4087864a12.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197365; x=1746802165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2E0oBNYfqr+ikEFFk4YZUnSRjLG2CUA9B+MeNyBcxek=;
 b=IvIHokXtDjyEFUqe8AjroR/HQqQy2EAPL3ets7CYlOaoE1BheejN1rWbGTtDAthwB0
 Vy1qrMGEeacDpA0YGhKeqXcbjP2PkUJbC8MaQuYdjw5N/DFuCHZyEoFv3b60KrjAoUBK
 achf0e7O8Onr9HpdGQsHXKtKDq05Dg505mGJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197365; x=1746802165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2E0oBNYfqr+ikEFFk4YZUnSRjLG2CUA9B+MeNyBcxek=;
 b=i1cx3Mx4kt6iaCVicVsoAujMny8g1DLxXLAo8ILCBJnMGHnN50+y/aogay+d751Oj4
 HWVw+JRoKuciJlDHei7UsxqcK6RqskNhSgAd7Tcac6QROuCuZvzcKBtnzcCHxekcsZqQ
 7ei0Auo2BSd1tWwQ65ph2wwQf7bzztxhzcNyW90baMUUd0U4zZ2JoqcIZk1LTSJopdz9
 Rl52ObF1pZnPw3MfRds2jMGvCVIc8kTlqvCxncgeoUQgLXmH4xDb/eXQNK7lQAzby7Yi
 5ZgJIDvIZfQpYXpMDBXOA9c/7kljIh4l6ldcpvMaFNUJnxLPOK12Ad3svjrrWLnAfewH
 geFA==
X-Gm-Message-State: AOJu0Yxtyf9bmNHkoyp2pMLcq3EnT6C1EhPoTIjo1yTj7GhSS4zHx8lv
 rtiKfOafELOCq2PvuuolVRSKxo+NpIjQU1RFjK/dctkrGpfcm2u3YDr1xUwPE7e/d85gS+ZiNb7
 ifGtnf2SACxORVnx5Moj1xLq9X6WUxT8lAnBttIy8M7T+POE=
X-Gm-Gg: ASbGncv27Pwt7t8r1dYQAlUNwwcNpwPryhVvkMIDQcTnu6QycC/aNyMk5jF8SA/f0Hi
 zVZTAYv7vpslktPw5Nkhnjg6UU3cPOMqwFptbtOdZggiSvbL0aA5QvtUO39d/X1nuw5MwqRmRqn
 cV+ypzche1W71xg83mPqRj080=
X-Google-Smtp-Source: AGHT+IFgCuQqRnS2T7fB3Q9Q18lFPUcxthTzqL++3llKSy0qmeZ2Cfp4E6kRCfsU9AH7qJGKYOEcu65RD2YSWf87UrU=
X-Received: by 2002:a17:907:8b88:b0:ace:cbe0:2d67 with SMTP id
 a640c23a62f3a-ad17b867329mr276516066b.55.1746197365297; Fri, 02 May 2025
 07:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
In-Reply-To: <20250502143359.GS1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 08:49:12 -0600
X-Gm-Features: ATxdqUH0PAA1iZNz4XR-e92F98BAzm2meLLubs6F4UuISsxHmbifHrQIVtLCU9g
Message-ID: <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
>
> > During a recent discussion with Heinrich we discussed why the hooks are
> > kept in a separate repo.
> >
> > The amount of code is small, a tenth of the size of the recently added
> > lwip, just by way of example. Testing is a critical part of U-Boot and
> > one of the things that distinguishes it from firmware projects that have
> > not kept up in this area. By having the tests somewhere else, we are
> > signalling that it is unusual, or difficult, or optional.
> >
> > The hooks mechanism also needs something of an update to take account of
> > real boards in 2025. That will be much easier to undertake if the code
> > that test/py talks to is in the same repo.
> >
> > This series brings the hook files in as first-class citizens of U-Boot.
> >
> > If we do go ahead with this, I will send a different series which has
> > separate commits (with correct author) in the u-boot-test-hooks repo.
>
> I think bringing more projects directly in to the repository is a bad
> idea. Your example of lwip isn't applicable because it's a read-only
> subtree that's maintained outside of the project (same as the dts
> subtree). But sure, lets "Say Yes". That said, we still need to:
> - Remove needless examples from the tree.
> - Not include personal labs directly in the tree.
>
> That last one is why I really think this is a bad idea. The point of
> having the hooks standalone is so that any given lab can easily add
> support for their lab and manage it, without worrying about disclosing
> internal layout. There's going to be hard coded default passwords there.
> There's going to be repository secrets there. That kind of information
> really should not be in a public repository. Integrating the hooks with
> mainline will make lab management harder, not easier. The point of the
> existing labs in u-boot-test-hooks is to provide samples.
>
> I think this is all why no, we should not go down this path.

Is it worth discussing this, or is your mind made up? I have some
thoughts on the last one.

Regards,
SImon
