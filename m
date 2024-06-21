Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FE0C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 17:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6E18845A;
	Fri, 21 Jun 2024 19:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4ARv9d/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85858846D; Fri, 21 Jun 2024 19:50:58 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF6A88059
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 19:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f9ca219760so1180305a34.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718992255; x=1719597055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/fxYaPHHnYIqhmcKnur9D+ZYnel6APc3+6GJoUsR26k=;
 b=S4ARv9d/CME8TOs9Or7WAfpWW+mToFSYBcUGmhuXRdZhSPWrhFqSXBurarv3jhwDQp
 CsoVlbOfAw+pi1B9OkKhGm/9WpM8iUTj3Lc38kHOm68S2V+tT0wurgeynazLY+o+r7bR
 uZAh4aSP9em+fXE9eiGWOlJPiruGFKT22ImJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718992255; x=1719597055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fxYaPHHnYIqhmcKnur9D+ZYnel6APc3+6GJoUsR26k=;
 b=n6SKAJCEW8F+6NQ9ZWTMOcKjasQJrHS5r5EEyrY7cSc7TksS4cKBdw1g0ALtwosoGp
 XLrzqJ9v5Hc7kwYmGRidvw5Mh41Gj0tpLwzDSgH0O3L7+1qFRGcdqQ6m25dWpOCnk2Oh
 A85MnI5ZlqkdsaYp4y44klyN6TXIcKi6k+4kWFEFG0kn2ihdCrHn94MkQBhN3JlbS4AU
 S71IpIv03nlJgq16PredJOErgPl1JAV5aa90NkxkhDuNSPhkP4pcwy+36K1Wq3EXiFXE
 ivO8KjkPtjpAjw8/W+6CuHHE7uukw7eASh7AFHeIkPKKrRMXo+KPvb1TVpYM5H6gaPou
 rcOQ==
X-Gm-Message-State: AOJu0Yxz0WfP2FZECP6V121d5sNhpvYs+pIrrI42Kspp602hfW0vedbi
 HtirLHw+nF8+mpi6jbAMPfF6e1rxpy+Gb4IjkBt4kwM6vRmnbKkQD09XaZpXV5Eq++IGVfTybgH
 J+I6IgZAPBPzb25y7GRitsSCIbW/Xg9u1ZHbv
X-Google-Smtp-Source: AGHT+IEW3EMXTrAr2UJPLTDsSnnvSL1L9kUsCMUSxcy7+NYPukEhWkrTRHoI1p+g6xK1HWrpXI06zPjol/o3ZJcjdnM=
X-Received: by 2002:a05:6830:912:b0:6f9:b580:e420 with SMTP id
 46e09a7af769-70075a753a6mr9937373a34.37.1718992254838; Fri, 21 Jun 2024
 10:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-11-sjg@chromium.org>
 <CAC_iWjKtOjR9evF81MhTVUKsn6OB5s=8O40+CZE-Y4+YfQO9GQ@mail.gmail.com>
 <CAC_iWj+uQ2z=SQpWhdZqVm02csoyFkeE-gXd7YWWS-MqYjxG1g@mail.gmail.com>
 <CAFLszTiRgwf4T6h1T5-5BiWckc7062Tgcs-2M2qi+7y_k=YbRw@mail.gmail.com>
 <CAC_iWjL7kTVB-jj7VbAJDe4UZgDk55Gxax5V7csvkRsvJ8OK2A@mail.gmail.com>
In-Reply-To: <CAC_iWjL7kTVB-jj7VbAJDe4UZgDk55Gxax5V7csvkRsvJ8OK2A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 11:50:43 -0600
Message-ID: <CAFLszTj8QfBXjD3YGXpzfLv8pLVqKeB4gKE0f_jNSvfken6SZg@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias,

On Fri, 21 Jun 2024 at 09:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 21 Jun 2024 at 17:57, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 20 Jun 2024 at 23:49, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Fri, 21 Jun 2024 at 08:32, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 21 Jun 2024 at 02:06, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > It does not make sense to enable all SHA algorithms unless they are
> > > > > needed. It bloats the code and in this case, causes chromebook_link to
> > > > > fail to build. That board does use the TPM, but not with measured boot,
> > > > > nor EFI.
> > > > >
> > > > > Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > > > > add them to MEASURED_BOOT as well.
> > > > >
> > > > > Note that the original commit combines refactoring and new features,
> > > > > which makes it hard to see what is going on.
> > > > >
> > > > > Fixes: 97707f12fda tpm: Support boot measurements
> > > > > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v2)
> > > >
> > > > There was a discussion in the previous version, bout enabling these on
> > > > CMD_TPM as they are required.
> >
> > For reference [1]
> >
> > >
> > > Or switch this to an imply instead so you can disable it ?
> >
> > The thing is, we need to be able to easily disable unwanted features.
> > My reading of that thread is that U-Boot doesn't use SHA384/512 from
> > the 'tpm2 pcr_extend' command today.
>
> It does, it was mentioned on the thread you referenced. commit
> 89aa8463cdf39 ("tpm-v2: allow algorithm name to be configured for
> pcr_read and pcr_extend")
>
> > Even if it did, I would think it
> > better to allow the supported algorithms to be controlled. At worst, I
> > would expect a separate option to disable that subcommand which would
> > remove the implies.
>
> To control the algos you need to compile, you need to control the
> algorithms the TPM supports. Otherwise, you are leaving security
> holes. We don't configure the supported PCR banks today iirc.
>
> If we need the fix for those platforms for the release so badly, why
> don't we just disable the TPM? It's going to be useless and
> potentially dangerous without SHA support. Any idea why those
> platforms use it for?
>
> >
> > Some tpm code recently added puts a table and some functions in
> > tpm-v2.h - could someone fix that? tpm-common.c would be a better
> > place.
>
> Do you mean commit 954b95e77ef0a8? If that's the one, I don't mind
> moving it there.
> Those values though are described in [0], which is primarily for v2.0.
> Nothing prevents you from using it in v1.2 but all of the values apart
> from SHA1 are useless. Also, we don't support measured boot with 1.2
> anyway so I didn't see the point back then.
>
> > Also we already have a list of hash algorithms in U-Boot
> > (common/hash.c) so should use that, >and respect the fact that certain
> > algos may not be supported.
>
> That seems tailored for a very specific reason. Do you want to fill it
> in with EFI internal definitions?
> We could adjust some lookup functions which seems common.
>
> >
> > If there is a requirement that (for a certain situation / protocol) we
> > need to support everything, then let's have a Kconfig for that.
>
> We do. The difference here is that the *TPM at runtime* dictates what
> you need. So you can't blindly disable stuff.
>
> > It is
> > what my patch was trying to work around, perhaps. For boards which
> > don't care about extending TPM in this way, or don't use the more
> > expensive algorithms, it avoids lots of code bloat.
>
> Ok, I disagree here. That's potentially dangerous. Because someone,
> might need the TPM, easily misconfigure it, and end up with broken
> measurements.
>
> >
> > One of the principles of U-Boot is to allow configurability in these
> > situations. It shouldn't be too hard to have the best of both worlds
> > (supports all reasonable cases by default / allow unwanted cases to be
> > dropped).
>
> It's not. We can have the TPM configure the supported algorithms once it starts.
> IMHO that's the proper way to do it. Everything else is just papering
> over the problem -- which even worse no one will care to fix.
>
> >
> > So I'll await your reply on the above before figuring out where to go
> > with this. For this release I'd just like to get the board working,
> > but I understand that the TPM stuff is very-much in flux, perhaps in
> > -next.
>
> This is a very complex problem. Even if we configure the TPMs banks
> based on the supported algoriths, a previous stage loader might have
> enabled more. So you end up breaking that in that case...
>
> Let me see if I can configure the TPM on boot....

I just don't understand any of this very well.

My request is, please can you find a way to allow the TPM to be
enabled for a board that doesn't use the pcr_extend subcommand with
SHA384/512? I just want to get that 5KB back for this board. I'm happy
with the defaults being a certain way, just not wanting to require
this code for boards which don't need it.

Regards,
Simon


>
> Cheers
> /Ilias
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240610145920.3302001-3-sjg@chromium.org/
>
> [0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> -- search for EFI_TCG2_BOOT_HASH_ALG_SHA512
