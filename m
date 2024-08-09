Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3381C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 16:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2878D8880E;
	Fri,  9 Aug 2024 18:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ELM+1Fln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D1888B36; Fri,  9 Aug 2024 18:11:11 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE71E8870D
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 18:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso15039956d6.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723219868; x=1723824668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfhzlVUFZQoGMcTRhunNGmmWUZ5tgkEp1hjdeVFaNFw=;
 b=ELM+1Fln4ADq9OJbWRz+KXYO2e1rzbO2mQhgIiTFLDsK+sGUjW+irvAp9A9F7wvaxh
 YPWg3pC09WebwWd+KwNycAtU8Y8EdEzmt11G7fJCK+1Mpygbu6tcoMDct3gV/ARBRyYv
 qKOOskuaxtBBYje83UNYoVtidaEcrqbTTBEE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219868; x=1723824668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfhzlVUFZQoGMcTRhunNGmmWUZ5tgkEp1hjdeVFaNFw=;
 b=Lt5TylXoGZUd4t2kxTYHxd+198PtzbGXjgpdX8nW5YBmPB5ofmDOoW035FMMOKhKEg
 0fbAZ+fEdIMSCe8XagfwxmbYDd862KiVp1q8A105AXc0vn06RUVfbZ54ATT2Wao7kUFS
 cpG/P6j/rqf0LWTP14ZJqBeU38HdqvAeYl+YSpQUEKdO172ka6W7SM5E/DRrUZoJhHeK
 rsPr+I5irFEAZ7wR1km77VvAgtHzPIqiM7IYlOz8rjZX++7j9W4mFYeSNOsZI6Kj2c4s
 cB5Cgrxo7KGZ43KfqdAAot4MblvkH2ZzieENxVqmXLwtKuZ0RRW4kjwqQHuEft6dKIcE
 zqFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWagfIzjrLOpwSOO6M0e3JdtAgYTfYE0JXbgVB49h3C9uT8Om2UrRukPHR+unRh3maZLv+trdnNnheYX7QJ7vGKw/Jj8A==
X-Gm-Message-State: AOJu0YzPV1hm2XXC7FWX8F25Ooa75sji4622MdvqtLqP5PIf4VNnvanS
 GXs5gBuq2q6zQYZ9Me/K5RLIa3bloz5rWgtlqsVGvUhM55hJWFIaRAFPoAjsJpj8C8pTximIKfB
 yF46E+wAl7fa3CCJ8wXFzVNqtXed/IU7Q10q8
X-Google-Smtp-Source: AGHT+IGZEYZ+On8WB+6Hbp81Ufa9aqagMbtzxlIw1yWOlqMgCGK4dkz7S3ST8f15ISQpcBSvb/Ch66uV+tkCu/2FDKg=
X-Received: by 2002:a05:6214:5d87:b0:6b4:fdfd:fece with SMTP id
 6a1803df08f44-6bd78ea443bmr24490596d6.44.1723219867722; Fri, 09 Aug 2024
 09:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-20-sjg@chromium.org>
 <ZnkchlJmYdVCkQV+@toradex.com>
 <CAOf5uwkQDzOpj-XUojvfWD6tU2cOxZkv4OEvOK7eZJZcRHTjfg@mail.gmail.com>
 <20240624180149.GF38804@bill-the-cat>
 <CAFLszThdms5TT_o0CjQOp+6pqXF9nMUJKq5rvz0Y=EGZa2Tj-g@mail.gmail.com>
In-Reply-To: <CAFLszThdms5TT_o0CjQOp+6pqXF9nMUJKq5rvz0Y=EGZa2Tj-g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 10:10:57 -0600
Message-ID: <CAFLszTiAYmAdm0eyB6AsDM7oUow0spM1G-dy++Cg9sLC21sAig@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] CI: Allow running tests on sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 25 Jun 2024 at 06:30, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Mon, 24 Jun 2024 at 19:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jun 24, 2024 at 04:56:02PM +0200, Michael Nazzareno Trimarchi w=
rote:
> > > Hi Simon
> > >
> > > On Mon, Jun 24, 2024 at 2:52=E2=80=AFPM Andrejs Cainikovs
> > > <andrejs.cainikovs@toradex.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 02:32:13PM -0600, Simon Glass wrote:
> > > > > Add a way to run tests on a real hardware lab. This is in the ver=
y early
> > > > > experimental stages. There are only 23 boards and 3 of those are =
broken!
> > > > > (bob, ff3399, samus). A fourth fails due to problems with the TPM=
 tests.
> > > > >
> > > > > To try this, assuming you have gitlab access, set SJG_LAB=3D1, e.=
g.:
> > > > >
> > > > >    git push -o ci.variable=3D"SJG_LAB=3D1" dm HEAD:try
> > > > >
> > > > > This relies on the two previous series targeted at -next as well =
as the
> > > > > bugfix series for -master
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> > > >
> > >
> > > Do you have documentation on how to set it? We would like to do in ou=
r
> > > company too
> >
> > I _think_ from some talking with Simon before the biggest sticking poin=
t
> > might be changes needed on the labgrid side of things. However, that
> > might also be most easily remedied if there's a few people showing up i=
n
> > the GitHub issue(s) showing interest in getting changes made/merged and
> > to use the overall feature.
>
> The documentation is in the PR [1] mostly in the last commit [2].
>
> Yes it would really help for you to try it out and comment on the PR.
> I may end up splitting it into a few separate PRs, but code review on
> the project is very limited, from what I have seen so far. You will
> see an example of my lab (devices and environment file).
>
> I also have a few minor updates to the PR which I just uploaded, to
> work on top of the grpc branch and to support QEMU.

Just to mention that I updated the Labgrid integration to support
beagleplay (which as you know combines the U-Boot builds for two
boards). It resulted in no changes at all to this series.

So perhaps this series can be reviewed and some of it applied?

Documentation is below.



>
> [1] https://github.com/labgrid-project/labgrid/pull/1411
> [2] https://github.com/labgrid-project/labgrid/pull/1411/commits/c4b13af0=
e6169228c9adef03d4b66401201edd23

Regards,
Simon
