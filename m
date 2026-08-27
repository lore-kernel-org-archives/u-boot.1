Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FDDC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 16:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C91C940550;
	Thu, 27 Aug 2026 16:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBd1fr10waUW; Thu, 27 Aug 2026 16:37:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787848661;
	bh=KGOczZfbBs/Pwyx1fvwVoP3Fzu7WDOtwYePXUP2vM9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X+0lZbWnRNvJ/MR9k5Ka+CdAKtoCOAY2zU+LKGaqHXdiz4vIjiYR/Ii/jLjizBmvs
	 lJ05ToYiu2hmP70OxAkIDyqy0JyxgMrumXtxCcqhcT28Glv0LDpY7UiD3F032tGvNd
	 +aPEXP1NTxwuo6GLfPh3J9RgJYs/ZY2xPimF0KjaAjz6umnTzPhBvkvcnWEiSdPEcd
	 ipzppf/JA6PPmhQqu4WhFzyddMAUDgMMGSWoMGxFZEC+BBWM2ZWR6ZwWNUIIbwwGlC
	 Wc70UAnJUWelRpX7zFHDHOfwTak0PQh0bSz+gutDi0Nh2pANrcG0RZedOMjQV4VBIv
	 1vrhCnhFoOFuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E332E4047E;
	Thu, 27 Aug 2026 16:37:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60998E09
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 466986078A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZzCftcZgs_w for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 16:37:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gCLyWoxK
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 665ED605D2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:37:37 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8565d77c277so486587b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787848657; x=1788453457;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KGOczZfbBs/Pwyx1fvwVoP3Fzu7WDOtwYePXUP2vM9U=;
 b=gCLyWoxKqvVcVRv3GKgHmfVt3eA/fKHFSTCkY+Bz5CNo77ZBJv17whu3390m0SBWX1
 cM5SYv/hL1VeBAMd6u9HOI2uDq6dz5BX/YdwbVm/hQwMhIAG7HjqL4QtDdgImsIUljla
 cHqPTbgF6kP8U09fNldchjU2SRxC5ffIRS5Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848657; x=1788453457;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGOczZfbBs/Pwyx1fvwVoP3Fzu7WDOtwYePXUP2vM9U=;
 b=S716+ppL4tYZr6BP2VeyfPFNlx/c4BrIqzzl7BIs0MJOyXIRBppa8UoxsyQ0cyFimH
 PcXANddijT+hUHKtJWpz8FIZWq7XQp7uMlYjnITOk2BvLXELx3ZrniW9Hqf1iYZ9DoZD
 8GJAfcTEjmryrnrcx15wpVCJ4Bsadd4IujClRHI/TMM5C7PF7sJCpsfK08vCMlmNvFOk
 Ed5cMNqO0ZzwP6vKkKszpIWZe06VFgE/RLpcZDmmkoeF8TsauRqOvcd2OcXw5sFRXoJc
 6yM9ecl8VFhtHcrfk8AVA9bh912Z1Bh3pBTYePDx0pCmYMOFQf3IFJ2ajBdU29UenW4r
 lcoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGX8yMTVzi2he+7oNWpwn66N6oTVuyOqOudT2nOaGempSvCVV+CLD0tQFC6X7ASygCUzx36Ck=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nC1VGnanrI2/XHwnSwJXXlASBG8qyJ9sMJnSuh8DrhZPUgnJz7
 YPbZrWvN+7+Ag+EOmwY4R9qCkk96P682Jaq7jikAJZuZQE6nes/xbeHbSEHr6QACi/E=
X-Gm-Gg: AR+sD11iFKpxxfkr/FFcI4CjooUslgoMbUXkGenSXivpTyjqsKLzOD8xnj5NgGto2G9
 97A+2QNKQUPTm+bh5Yd5B1JXofdjJKej1S/+fjcfx/jbV2acJVOgmOWtEUsDw1iyX4fKZsd7ehn
 HZyvB8LDdyJ8qxYahCDu50kdBejG94i2NPuAGjP3EwdtB+uwS4pJdujwK3HwsWDDTZqCJTHaMNj
 lYrwqKiPJu0mZZ6qgMq4XlpgqFjKs8jXpI1IjdTcNs5QghTvqfuO936F4SjuuuBfwAr57NjcJEP
 AWkJLrW8RIYkAuGmRAtQARJDlJfSvEP/aZooDEexgyoQm2go32n2AHPCHYZwcPecmkPgZwYonnY
 cAlm1mvqmcKMP4a4e3gB9Xfob2L/rlLxj47cQVhh15Q2b286Tmw8Iqt9cokGqJniop44515xudg
 ecftHy5L5U7tDdv9PyxYfNAu04D+QsC4Ija1dK0Cfb0AN4+cglwVasANut21uHKAM8mRjO5v6tl
 EPdnjK4eNeMSmoafww/EPTB/9BvDpQkl7miXjqcCO+ncWANzA/Iz9+O05dXP3h8Knw0DTO9vsrR
 8rQa6E7sfg==
X-Received: by 2002:a05:690c:315:b0:841:773e:8d86 with SMTP id
 00721157ae682-85d6b464e55mr3938617b3.15.1787848655292; 
 Thu, 27 Aug 2026 09:37:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b624fa606sm12911457b3.43.2026.08.27.09.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:37:34 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:37:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com,
 padmarao.begari@amd.com, Simon Glass <sjg@chromium.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Borislav Petkov <bp@suse.de>, Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code
Message-ID: <20260827163731.GE3959812@bill-the-cat>
References: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
 <20260827121108.1775123-3-suraj.hanumantkakade@amd.com>
 <CAC_iWj+WXkNAZPyRup4w09jSyr6TbkjLgZRyDxKzCQdFaK8-4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/xIx2Fq3FF9zui1z"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+WXkNAZPyRup4w09jSyr6TbkjLgZRyDxKzCQdFaK8-4Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--/xIx2Fq3FF9zui1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 04:29:29PM +0300, Ilias Apalodimas wrote:
> Hi Suraj
>=20
> On Thu, 27 Aug 2026 at 15:11, Suraj Kakade <suraj.hanumantkakade@amd.com>=
 wrote:
> >
> > RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
> > reached EOM/EOL on June 30, 2024. While you may get extended support,
> > it is a good time to raise the minimum GNU Make version.
> >
> > The new requirement, GNU Make 4.0, was released in October, 2013.
> >
> > Raise the enforced minimum GNU Make version to 4.0 and drop the
> > now-unreachable compatibility code for older versions:
> >
> > - Add an explicit "GNU Make >=3D 4.0 is required" version-check gate.
> > - Simplify the "make -s" (silent mode) detection to a single
> >   unconditional check instead of branching on make-4 vs make-3.8x.
> > - Drop the GNU Make 3.x sub-make workaround, which is now dead code.
>=20
> Overall I agree on bumnping the minimum requirements to 4.0. In fact,
> I think I did that when I did the Makefile bump to 5.x. However, the
> macOS tools stopped compiling. We need to check the CI for that before
> merging this.
>=20
> >
> > Fixes: ffe29ebc0701 ("kbuild: sync top Makefile with Linux 3.18-rc1")
> > Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>=20
> Why do we need fixes tags?

Yes, the kernel didn't enforce this requirement as the minimum until
around v6.10 or so.

--=20
Tom

--/xIx2Fq3FF9zui1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapBnxwAKCRAr4qD1Cr/k
CsqpAQDB4CNDazvxf1B3S9DRygHmti7GPvJRPgQu7CQNimAK5wD+OZByAs+I0M+F
VkzFxa3P47ZpfcYmk31Wes4pbvblqwk=
=TOWx
-----END PGP SIGNATURE-----

--/xIx2Fq3FF9zui1z--
