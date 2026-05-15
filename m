Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AF4CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44EA846B5;
	Fri, 15 May 2026 17:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UHOEhFk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79ECA846BE; Fri, 15 May 2026 17:58:59 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43754846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so366624a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778860735; x=1779465535; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=psqtQdnLM0BNe6nDHAZHpgJqf/+7Db2xiH74jjdKuA4=;
 b=UHOEhFk/mmoy80P9asNNubXTLEYPYHDReFXmS9yWUAtv7Cc0dDr9DxibXupJE+oS2W
 mt4wvxcR9sNiBQsciqLVlWQN+dxGS3Hmpo0BEVZTiZ3u6UWD1zYH2lHgQvQo/PIYLUah
 ketQHTWlBof8gFg0CNOXVKtVghxrCZKRGDmys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778860735; x=1779465535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psqtQdnLM0BNe6nDHAZHpgJqf/+7Db2xiH74jjdKuA4=;
 b=mU3OrA/3Xh7Niw4TA+/Kb+0kUVKIQkKQPUdn3F4imHNhYkSALM5G6uyStjuJFlAgMQ
 v7LrQ43znM+IagavjDogWmXSfPglAjdhopXC0W2ul2tYbb+2jt8PfF6q/z+eb2y1GUKg
 mSygbPtE2oA30z+kN/MaxpOzsq07kQtFIP5R4RZGTye1NihdAtYYfEce4AACJTxeIEfW
 uqrPISl0Ib5E2MvGO422/9tdTnBsAu/V9fCecv3/4YB9d9fYaQ+DFMGwmzZqTJSZz99Z
 EYGaMnBQdZU/SPHHbdBDwGCLzfXI7R+EKqUR1h2j/NKwLlcPNBg4Oe3OHlmA9moAZl9R
 8uhA==
X-Gm-Message-State: AOJu0Yz2l3yU4FxFgLEvq5QwEO2J61utYPm+3qCZwXPAI0Xd/lnqD+C0
 8NI/s+YBjxFrCszCfrY4Awa7DKg9ZzbqiTHWOT27vbQSifDlP3Q8Ce14glLbqlZ8Z05OLeRR9x1
 dK88MdM6B5LP/tbQ=
X-Gm-Gg: Acq92OHxaBcRu322H53jkz/5u1NrHb/lwgFOLbV8xAJRje3e8V4JOdrrjlGBfxuZAxc
 wst5l4J2QvWV8pxOMNvYMN4ybVUG68zqd7hJB1tY1PMujEwyEG1PLH6+Cp+t1IEc1D6Br/O23Ki
 wJqFPnbeluwsznfIwMFA0pccx0hqgcXMYChfZA+G8EJ6qRS080umg7SDAaeyHVU6QEhP6Mgavc1
 nhEutYysKN1ll6pPsCnCjK67bfPuF3gFAPz0Mqi1C5PIACf//EvSON5oQm1rlpxhV6wdAdOKtEG
 7w3Hk5U5EDX0Ei7AFeC7De6YuskJULzdozT8fXmGkyL5Wx1E4TQ3aObHdVpzaeyctvy4Aw6SLHe
 taXVf08nvq27eLQg37EetX+JGZ9pWcyHhU2baS1JzwWWTK7uQt0LC+v0kAP1ai7a5w/Choq1X1k
 hDqNmWEprz7m+OVnBrw0NETl+JPX0VORfj5WMEigpPklCfC5TsBXQMFxF50v9FppA1zms0n87o9
 hPpMpXl0ZeDEdmvL2CI2sHHVwRwcaFpLGIf/5KUJ1gBsZWr8YTVSEof7q109Q==
X-Received: by 2002:a05:6830:90b:b0:7dc:1bcd:43be with SMTP id
 46e09a7af769-7e49a9379f2mr2739247a34.5.1778860734956; 
 Fri, 15 May 2026 08:58:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cce95sm1745716a34.6.2026.05.15.08.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:58:54 -0700 (PDT)
Date: Fri, 15 May 2026 09:58:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Eddie Kovsky <ekovsky@redhat.com>
Subject: Re: [PATCH] Azure CI: Drop Windows host tools builds
Message-ID: <20260515155852.GE1858239@bill-the-cat>
References: <20260515145942.133279-1-trini@konsulko.com>
 <CAFLszThwpS8ULztWURncyZa1hCGbam9Fw02FSxQDgqMVZKkeuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="puwbK/O2MQRD3HK7"
Content-Disposition: inline
In-Reply-To: <CAFLszThwpS8ULztWURncyZa1hCGbam9Fw02FSxQDgqMVZKkeuA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--puwbK/O2MQRD3HK7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 09:06:01AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 May 2026 at 08:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > In preparation for being able to support more recent OpenSSL versions,
> > we need to add support for the OpenSSL Provider API. This in turn isn't
> > something that MSYS has all of the required packages to support. Given a
> > lack of user feedback that these tools are still used in this manner,
> > remove Windows host tool builds from CI.
> >
> > Link: https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@red=
hat.com/
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > This is intended for the next branch, and to allow for a more visible
> > part of the removal to be made now. This means v2026.07 will be the last
> > version to support MSYS for host tool builds.
> > ---
> >  .azure-pipelines.yml | 28 ----------------------------
> >  1 file changed, 28 deletions(-)
> >
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index 4417ef4e5a50..b2a59bafa83d 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -1,5 +1,4 @@
> >  variables:
> > -  windows_vm: windows-2022
> >    ubuntu_vm: ubuntu-24.04
> >    macos_vm: macOS-14
> >    ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2=
026
> > @@ -44,33 +43,6 @@ variables:
> >  stages:
> >  - stage: testsuites
> >    jobs:
> > -  - job: tools_only_windows
> > -    displayName: 'Ensure host tools build for Windows'
> > -    pool:
> > -      vmImage: $(windows_vm)
> > -    steps:
> > -      - powershell: |
> > -          (New-Object Net.WebClient).DownloadFile("https://github.com/=
msys2/msys2-installer/releases/download/2021-06-04/msys2-base-x86_64-202106=
04.sfx.exe", "sfx.exe")
> > -        displayName: 'Install MSYS2'
> > -      - script: |
> > -          sfx.exe -y -o%CD:~0,2%\
> > -          %CD:~0,2%\msys64\usr\bin\bash -lc " "
> > -          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm -Syuu"
> > -          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm -Syuu"
> > -        displayName: 'Update MSYS2'
> > -      - script: |
> > -          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm --need=
ed -Sy make gcc bison flex diffutils openssl-devel libgnutls-devel libutil-=
linux-devel"
> > -        displayName: 'Install Toolchain'
> > -      - script: |
> > -          echo make tools-only_defconfig tools-only > build-tools.sh
> > -          %CD:~0,2%\msys64\usr\bin\bash -lc "bash build-tools.sh"
> > -        displayName: 'Build Host Tools'
> > -        env:
> > -          # Tell MSYS2 we need a POSIX emulation layer
> > -          MSYSTEM: MSYS
> > -          # Tell MSYS2 not to =E2=80=98cd=E2=80=99 our startup directo=
ry to HOME
> > -          CHERE_INVOKING: yes
> > -
> >    - job: tools_only_macOS
> >      displayName: 'Ensure host tools build for macOS X'
> >      pool:
> > --
> > 2.43.0
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> How should we document this use of WSL to run the tools on Windows?

I suppose the bit about WSL that many of the TI platforms have
copy/pasted could be moved up to a more generic location.

--=20
Tom

--puwbK/O2MQRD3HK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagdCvAAKCRAr4qD1Cr/k
CoaoAP9quRJhcgYgfNKJK9IqqadxTSu8cbWxnlBaJJxjunoyRgD+PghF78LfekFc
w8796dTK82yhV5wsYNvtk8Es2FsEYAQ=
=zVOB
-----END PGP SIGNATURE-----

--puwbK/O2MQRD3HK7--
