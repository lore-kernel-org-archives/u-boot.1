Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68A6072883
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hpGGRFdN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEUhslbS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B44F840B1F;
	Thu, 12 Nov 2026 08:48:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpRvxXAGNleq; Thu, 12 Nov 2026 08:48:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C7BBA40AF4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794473329;
	b=dYHRPyuYd8BDcavCcq6QEWZlkutkYKdLIUnagS8KMWbr6DIqwjgkdsbjsoEaClZr9OSr
	 czDqgnKkVc5+tv6jrGDXblRc/WjQAhGkMwBR460AW34q+wWIekIVpsW1GFpbOZXMFe2Wq
	 KjwjjOGuSuTN1Sgd4r19BFGhNXq/gaIddqqONG0TPL7g+2qu5R0Vix38Z4LSnjGNpVOT0
	 1TtZ+TDspnJHjZpj/E1AnbZmeML3D/DnG2Z73HA5FXILY5VeRAr8GdA9YtQjtLjQltqbU
	 lUpNKYNpka4ZcwaZPUJN+hnqR2SrrHrNDunetKDJWinQMP2GUarApXCcYPFUJN9NFqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794473329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XQe4s81nZvQUXg8c2tKXzMzsAxNL+bMN0RBK5YtJETk=;
	b=SeyhqG83gYCygbob6Mf+rhC3JFf9hHxzvJNA6E5LiTlMD7C/ryNcivSESj6zJ6UqyF9s
	 5yQXpCT68adBUfd+97JDcVNUAaLmKj9Pzz1BfbF56+pQSxhgvDZOE2uvY8Bf9b3ddR4Av
	 u8ancs0n0tWQGu0lipgUCdd0QmNE0Snsn5vcMzNSxB4E6hrhuGdDek618z6L1tVI+WePx
	 mgiVGJRPYB/ahYRZ+dQVD4B2Yfk6ZrXJtxlR7LI98wissIPKHYtI4D47xIFcZYh0aG+em
	 aTlYjCtdldM4+ZYzpkobYLAzAQk+gOQ0Y9PA9pssxfuzGHbXxDa1k5fy4QsV/G/2X6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794473328;
	bh=XQe4s81nZvQUXg8c2tKXzMzsAxNL+bMN0RBK5YtJETk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpGGRFdNUVAdv86MsB/EKa2YD7SbyKvLSQg5FdcZNNW0rAGCj9r2TVZmQ0iY92wMp
	 tdBEKjEmYw7+6iFxmyI7R7BM3yVgeoU83bwVBnEA6cLVRaZuy2g4Vb1bCyBBshrQ+6
	 xdpoaFang0uVDMfpMdFz8Pbf+tuerLWsohMe3oZBEAm6vtIG+25ZpBZIBCilvq56fJ
	 SAlxdTmgTZVE03rdgfUXyaqn8LQfBeq9yrH+1A4BFTCDfkNpu2NuUa8FTM5akE2JyR
	 0O3dtVE1cuijr800dRryRF/WYSLI7aBbgPulcDZjBVlU136ecb94bIoZzYgV/lPOnp
	 0O/HvQDdGNQAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7BBA40AF4;
	Thu, 12 Nov 2026 08:48:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69BE4335
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F07E40418
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:48:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZqnVG62Xchr for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:48:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4E69640416
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=tEUhslbS
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E69640416
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:48:44 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-91f0b9f0b1cso11233566d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794473323; x=1795078123;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XQe4s81nZvQUXg8c2tKXzMzsAxNL+bMN0RBK5YtJETk=;
 b=tEUhslbSy2gDCSYwgpcDWr7AtCG1iifBobgVLuDpDzC1T1llmHkS0QcEyBwbOAyoaN
 EyoYef3LvqGFIf/O4TYrA4QcgQsGDd1LYXaqkEFpEi5WhumRyRtQoNy3+ddtcP80beNB
 2xexCsbNY7nCDvx6enVA1lrpfDAlsXM9y54E6RQsTpby21gVUniCRnom2MuE4Ql+8lHq
 ZgtNYc4yd4V30FOQXpWhXx2DOHoBZYR8i3Xj3ee4RbxbH31/UiYyu8DCEWzrjgAGFO7Q
 cXydr9skHO1BnT2AaYm1E5sL7u/1khlRhPz1vkqjhlToahbDhamJQaX91eKKComWSBlM
 LJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794473323; x=1795078123;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XQe4s81nZvQUXg8c2tKXzMzsAxNL+bMN0RBK5YtJETk=;
 b=X+VrMn0QYQ7M8g5wqSP98VKMQmmcIhFy4Syev5rQZ7GtBzKdCxElUekxR5uyhe5mWM
 squWBIUW1h9PSSeTdisuKkM8+l0oado5G5LGwf1CbnEaAxx/BCkYP3uQZPb+f8qMVjct
 NLfoBx3eO4JC5CYghT6jvmwFP1UfDaobOf7GFO1SocML719KMtcoYSb7teNhFB6ifFtv
 n2Tjly7xNc5xYq0aTVEhlkKdnU+g/vgdV9i1TQ5N5wUaUzJlr30xd7VUrQg/H57NvHKg
 NjtnMgpnU9dkS1pxNlLCTi/Lf8UHBneJqdfs2nA6GE4nzJnpVn0+J8j0u6a6kT0oYkf7
 HNQg==
X-Forwarded-Encrypted: i=1;
 AL+hErFzIxKoOPR1lBDX6RDpEpEpyBFPcb+BHcr23Sqh6i5lk8SN+Ooqt4t5oQYHdXNEmWk+ycA3iXc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/rvIo/nHHtaNnnjA+sw35nF6LemxjKiohW1t4IzfVScXI4Y8xl
 T7A5RAVEKplKhX7MZA6z4iwxJCAcwxL1gcpa5PKGkSGu4lJ1nt4JKapmY/m1uT36jtML573BPEn
 JygdadKtSQtsdsDRzEt/PCaQjuiuUD+E=
X-Gm-Gg: AYBFou0DEQaJ8yKaJHRYMPPrEX1+cRgZefhwG+xraG1cHiVJPPxmkxQfUbGuzQmB1N0
 wAFmMiyyceeSqBbWI4KlK2mnHNcxITUSUV5dabA/LZI8kSyiVkM8NiJZ3dezyyBJttH1u7uRao7
 OikZVXZL9PpIhZpGEDHUB87DQfXnIXEnqb8HxidAg8ZCkpZM5wJzYw+VRHxv5d9vPhGLtyS+fqr
 GrOOK8BLOv8w2yVlivY/3lnIE7M7k//GBb/r+TRQQ+bxTdDmJzjtK4DgT7ou6YSaBguxbicIIYh
 r9VsuXiU/2G6O11wLEvmpVXCuRKbHGROrxBw02DE0woc0yznn0UkLh6h+QRREwsTpdzvfs6Vkfq
 8rd+1MYx+4cAidQNlJ/gSL1mRSe/3c6yCQby/dLel/xS3tGiw5tfmfx2zfEEUU/A5i1Dmmk0Z8g
 17VsMv/kyADQhxGjy3ThaynYMrfU5JcBRZ+P8Fq9KeiPB6nwSPfUSwhFYfcIdonPRdGdcs5Cusy
 5VmUBo2cOvxAvvszi2OjzKB4WK7Ii9yGtU=
X-Received: by 2002:a05:6214:21e7:b0:91e:9d18:6a61 with SMTP id
 6a1803df08f44-91f03e270e0mr94562846d6.5.1794473323152; Thu, 12 Nov 2026
 00:48:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
 <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
In-Reply-To: <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Nov 2026 08:48:30 +0000
X-Gm-Features: AclHuK_7DQZrkEHp-Vg2c5_-Lxb7BSqSKIMv6yFsvnXjbfrrDY25H0uEmmGi_6Q
Message-ID: <CALeDE9NtK9F5zebiL6vXLHm5V-iBw+kw5Ld0JuzAb8EHPQauDA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Jan Stancek <jstancek@redhat.com>, Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, 
 Bastian <bst@pengutronix.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Content-Type: multipart/alternative; boundary="000000000000fc4a4c06601060ad"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000fc4a4c06601060ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2026 at 04:24, Eddie Kovsky <ekovsky@redhat.com> wrote:

> On 11/11/26, Quentin Schulz wrote:
> > Hi Eddie,
> >
> > On 11/5/26 5:56 PM, Eddie Kovsky wrote:
> > > On 10/30/26, Quentin Schulz wrote:
> > > > Hi Eddie,
> > > >
> > > > On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> > > > > The Engine API has been deprecated since the release of OpenSSL
> 3.0. End
> > > > > users have been advised to migrate to the new Provider interface.
> > > > > Several distributions have already removed support for engines,
> which is
> > > > > preventing U-Boot from being compiled in those environments.
> > > > >
> > > > > This series adds support for the OpenSSL Provider API while
> continuing
> > > > > to support the existing Engine API on distros shipping older
> releases of
> > > > > OpenSSL. Build dependencies for local development and CI are also
> > > > > updated, while the final patch adds support for using hardware
> tokens
> > > > > with the Provider API.
> > > > >
> > > > > The changes have been tested with the FIT signature verification
> vboot
> > > > > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All
> 37
> > > > > tests pass with both the legacy Engine library installed and with
> the
> > > > > Provider API.
> > > > >
> > > >
> > > > I'm NACKing this series quickly because we are having pressure from
> multiple
> > > > projects and Tom would like to see this fixed ASAP, and this versio=
n
> here
> > > > should not be merged. From a cursory look a lot of feedback was
> ignored,
> > > > possibly because I did too many rounds of reviews and it got
> difficult to
> > > > follow. I'll therefore spend time next week to collect the reviews =
I
> made on
> > > > v4 and that sill apply and post them condensed on this thread.
> > > >
> > > > Please, we just need to fix the build issue for 2027.01. We don't
> need
> > > > providers in 2027.01, just the ability to build on OpenSSL 4 and on
> distros
> > > > with OpenSSL3 with engines disabled, without breaking OpenSSL engin=
e
> support
> > > > for other cases. If you get a patch to fix this, please send it
> whenever you
> > > > can, I'll still collect the reviews from v4 and post it here. If
> you're not
> > > > interested in doing that, lemme know and I'll take over this part
> and you
> > > > can always test the patch(es) if you want to.
> > > >
> > > > Cheers,
> > > > Quentin
> > > >
> > >
> > > Hi Quentin
> > >
> > > I designed this change from the very beginning to maintain the existi=
ng
> > > code base and preserve backward compatibility for users of older
> OpenSSL
> > > releases who are still using the Engine API. We cannot add support fo=
r
> > > OpenSSL 3 or later without moving to the Provider API because of the
> way
> > > the OpenSSL project has changed their interface.
> > >
> >
> > That's not true, as already said in v4[1]. We currently support OpenSSL=
 3
> > and engines, and we actually test this in CI. You can test locally by
> > running the following commands from your U-Boot git repo:
> >
> > podman run -it --rm --security-opt label=3Ddisable
> > --userns=3Dkeep-id:uid=3D1001,gid=3D1001 -w $PWD -v $PWD:$PWD
> > docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> > python3 -m venv /tmp/venv;
> > . /tmp/venv/bin/activate;
> > pip install -r test/py/requirements.txt -r tools/binman/requirements.tx=
t
> -r
> > tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt =
-r
> > scripts/dtc/pylibfdt/requirements.txt;
> > export UBOOT_TRAVIS_BUILD_DIR=3D/tmp/tools-only;
> > export PYTHONPATH=3D"${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
> > export PATH=3D"${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
> > ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board
> > tools-only;
> > export TOOLPATH=3D"--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpat=
h
> > /opt/coreboot";
> > ./tools/binman/binman ${TOOLPATH} tool -f missing;
> > for test in testFitSignEngineSimple testFitSignPKCS11Simple
> > testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test $tes=
t;
> > done
> >
> > You'll see all engine tests pass.
> >
>
> I assume you are referring to my second sentence "We cannot add support f=
or
> OpenSSL 3 or later without moving to the Provider API ..." I can see how
> that wording could be confusing.
>
> OpenSSL 3 deprecated the Engine API but did not remove it. The Engine
> code is still present but not callable in v3 because the header files
> were removed to help prepare users to migrate to the new Provider API.
>

Are you sure that's not just what Red Hat did as part of migrating RHEL
customers?


> And OpenSSL 4, which is gaining more adoption, removes the Engine API
> code entirely and only makes the Provider interface available.
>
> Some distros, like Fedora, added an optional package to put the header
> files back alongside OpenSSL 3 so that projects (like U-Boot) which
> hadn't migrated to the new API would still build using Engines. I don't
> know what the base image of your container is or what release of OpenSSL
> it's using, but it's likely doing something similar to keep the symbols
> available. But as it stands right now, U-Boot will not compile in
> any environment that does not provide a bridge back to the Engine API.
>
> I've found that the fastest test of which API is available in a
> particular environment is to (optionally) sprinkle some printfs
> throughout the lib/rsa/rsa-sign.c and then build the tools target. The
> build
> will succeed if the headers are available, but quickly fail otherwise:
>
>     =E2=9D=AF make tools
>     --->8
>     In file included from tools/generated/lib/rsa/rsa-sign.c:1:
>     ./tools/../lib/rsa/rsa-sign.c: In function =E2=80=98rsa_engine_get_pu=
b_key=E2=80=99:
>     ./tools/../lib/rsa/rsa-sign.c:115:9: warning: =E2=80=98ENGINE_get_id=
=E2=80=99 is
> deprecated: ENGINE_get_id API symbol is removed. Define
> OPENSSL_ENGINE_STUBS to mask linker errors. [-Wdeprecated-declarations]
>     115 |         engine_id =3D ENGINE_get_id(engine);
>         |         ^~~~~~~~~
>
>     --->8
>     /usr/bin/ld.bfd: tools/generated/lib/rsa/rsa-sign.o: in function
> `rsa_engine_init.constprop.0':
>     rsa-sign.c:(.text+0x15): undefined reference to
> `ENGINE_load_builtin_engines'
>
> To fix this build problem in an environment where the Engine API is not
> available (even if OpenSSL 3 is) we need to call the Provider API to
> replace the equivalent functionality. There is not another fix to the
> build failure unless you want to make a declaration that U-Boot is
> pinned to the Engine API as a build dependency.
>
> I also want to emphasize that I have been careful to keep the existing
> Engine code as it is. The new code is there to support the Provider
> path. We collected at least one Tested-By trailer from a LibreSSL user
> early in review, and I recently found a way to test for regressions with
> OpenSSL 1.
>
>
> > Additionally, from my branch at
> https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit=
s/openssl-providers
> ,
> > I have tests for both OpenSSL engines and providers *at the same time*.
> > Here[2] is the log where you can see none of the OpenSSL engine tests a=
re
> > skipped and only the PKCS11 provider tests are skipped. They are skippe=
d
> > because we don't have the proper package installed inside the container
> but
> > I tested this locally months ago and they pass if the package is
> installed.
> > If either the engines or providers weren't supported, you would get a
> skip
> > with a given reason, see [3][4]. [5] shows that you can build both engi=
ne
> > and provider support in lib/rsa/rsa-sign.c.
> >
> > If what you said was true, we would have had a build issue when every
> distro
> > moved to OpenSSL 3 when it was first released 5 years ago, which didn't
> > happen.
> >
>
> That's correct, because as stated above OpenSSL 3 only deprecated the
> Engine API without removing it, and some distributions still made the
> headers available.
>
> My second patch, along with the CI work Tom did earlier this year,
> addresses the missing package in the CI container.
>
> > [1]
> https://lore.kernel.org/u-boot/8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherr=
y.de/
> > [2]
> https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/jobs/7=
9119/raw
> > [3]
> https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/o=
penssl-providers/tools/binman/ftest.py#L8339
> > [4]
> https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/o=
penssl-providers/tools/binman/ftest.py#L8719
> > [5]
> https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/o=
penssl-providers/lib/rsa/rsa-sign.c#L22-L33
> >
> > > Both I and other reviewers have tested the proposed changes on
> different
> > > distributions using different OpenSSL releases. The build failure is
> > > resolved on OpenSSL >=3D 3, while building with the Engine API still
> works
> > > as expected. (The only obstacle we found was that signing with a
> >
> > Run the list of commands above with your patch series applied and you'l=
l
> see
> > it doesn't work.
> >
>
> What commands? You said the podman local test runner does succeed. If
> you have an example of a specific failure please include the complete
> output along with the commands and environment that reproduced it.
>
> > > hardware token key using Providers didn't work, partly because the
> > > existing code doesn't make the pkcs11 uri parsing available on all
> > > paths. But Johannes already proposed a solution that resolves that
> > > issue.)
> > >
> >
> > I'll discuss the provider part later on, I would like us to focus on th=
e
> > OpenSSL engine build failure for distros where OpenSSL doesn't support =
it
> > anymore (Fedora 44 without the ability to compile code using engines
> anymore
> > unless openssl-devel-engine is installed, and every distro with OpenSSL
> 4)
> > while still keeping OpenSSL engine support working when it is possible =
to
> > support it (all other cases, including Fedora 44 with
> openssl-devel-engine
> > installed).
> >
>
> See my previous explanation.
>
> > > What are your specific concerns about the code in this version of the
> > > patch series?
> > >
> >
> > See review on patch 1 (posted a few minutes after you sent this mail
> here,
> > unfortunate timing). But essentially, this breaks OpenSSL engine suppor=
t
> on
> > OpenSSL 3, which is something that is supported by OpenSSL and which we
> want
> > to keep supporting.
> >
>
> As mentioned in my commit messages and earlier in my reply, I have been
> careful to preserve backward compatibility for users who may still be
> building U-Boot with the existing Engine code path. Your other email
> states my patch "will break" distros like Debian and Arch. I've been
> testing on Debian stable and not seen any problems. How did you
> determine that Engine support is broken?
>
>
> Eddie
>
>

--000000000000fc4a4c06601060ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 12 Nov =
2026 at 04:24, Eddie Kovsky &lt;<a href=3D"mailto:ekovsky@redhat.com">ekovs=
ky@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 11/11/26, Quentin Schulz wrote:<br>
&gt; Hi Eddie,<br>
&gt; <br>
&gt; On 11/5/26 5:56 PM, Eddie Kovsky wrote:<br>
&gt; &gt; On 10/30/26, Quentin Schulz wrote:<br>
&gt; &gt; &gt; Hi Eddie,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; On 10/29/26 9:13 PM, Eddie Kovsky wrote:<br>
&gt; &gt; &gt; &gt; The Engine API has been deprecated since the release of=
 OpenSSL 3.0. End<br>
&gt; &gt; &gt; &gt; users have been advised to migrate to the new Provider =
interface.<br>
&gt; &gt; &gt; &gt; Several distributions have already removed support for =
engines, which is<br>
&gt; &gt; &gt; &gt; preventing U-Boot from being compiled in those environm=
ents.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; This series adds support for the OpenSSL Provider API w=
hile continuing<br>
&gt; &gt; &gt; &gt; to support the existing Engine API on distros shipping =
older releases of<br>
&gt; &gt; &gt; &gt; OpenSSL. Build dependencies for local development and C=
I are also<br>
&gt; &gt; &gt; &gt; updated, while the final patch adds support for using h=
ardware tokens<br>
&gt; &gt; &gt; &gt; with the Provider API.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; The changes have been tested with the FIT signature ver=
ification vboot<br>
&gt; &gt; &gt; &gt; tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL =
1.1.1. All 37<br>
&gt; &gt; &gt; &gt; tests pass with both the legacy Engine library installe=
d and with the<br>
&gt; &gt; &gt; &gt; Provider API.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I&#39;m NACKing this series quickly because we are having pr=
essure from multiple<br>
&gt; &gt; &gt; projects and Tom would like to see this fixed ASAP, and this=
 version here<br>
&gt; &gt; &gt; should not be merged. From a cursory look a lot of feedback =
was ignored,<br>
&gt; &gt; &gt; possibly because I did too many rounds of reviews and it got=
 difficult to<br>
&gt; &gt; &gt; follow. I&#39;ll therefore spend time next week to collect t=
he reviews I made on<br>
&gt; &gt; &gt; v4 and that sill apply and post them condensed on this threa=
d.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Please, we just need to fix the build issue for 2027.01. We =
don&#39;t need<br>
&gt; &gt; &gt; providers in 2027.01, just the ability to build on OpenSSL 4=
 and on distros<br>
&gt; &gt; &gt; with OpenSSL3 with engines disabled, without breaking OpenSS=
L engine support<br>
&gt; &gt; &gt; for other cases. If you get a patch to fix this, please send=
 it whenever you<br>
&gt; &gt; &gt; can, I&#39;ll still collect the reviews from v4 and post it =
here. If you&#39;re not<br>
&gt; &gt; &gt; interested in doing that, lemme know and I&#39;ll take over =
this part and you<br>
&gt; &gt; &gt; can always test the patch(es) if you want to.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Cheers,<br>
&gt; &gt; &gt; Quentin<br>
&gt; &gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Hi Quentin<br>
&gt; &gt; <br>
&gt; &gt; I designed this change from the very beginning to maintain the ex=
isting<br>
&gt; &gt; code base and preserve backward compatibility for users of older =
OpenSSL<br>
&gt; &gt; releases who are still using the Engine API. We cannot add suppor=
t for<br>
&gt; &gt; OpenSSL 3 or later without moving to the Provider API because of =
the way<br>
&gt; &gt; the OpenSSL project has changed their interface.<br>
&gt; &gt; <br>
&gt; <br>
&gt; That&#39;s not true, as already said in v4[1]. We currently support Op=
enSSL 3<br>
&gt; and engines, and we actually test this in CI. You can test locally by<=
br>
&gt; running the following commands from your U-Boot git repo:<br>
&gt; <br>
&gt; podman run -it --rm --security-opt label=3Ddisable<br>
&gt; --userns=3Dkeep-id:uid=3D1001,gid=3D1001 -w $PWD -v $PWD:$PWD<br>
&gt; <a href=3D"http://docker.io/trini/u-boot-gitlab-ci-runner:noble-202510=
13-23Jan2026" rel=3D"noreferrer" target=3D"_blank">docker.io/trini/u-boot-g=
itlab-ci-runner:noble-20251013-23Jan2026</a><br>
&gt; python3 -m venv /tmp/venv;<br>
&gt; . /tmp/venv/bin/activate;<br>
&gt; pip install -r test/py/requirements.txt -r tools/binman/requirements.t=
xt -r<br>
&gt; tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt=
 -r<br>
&gt; scripts/dtc/pylibfdt/requirements.txt;<br>
&gt; export UBOOT_TRAVIS_BUILD_DIR=3D/tmp/tools-only;<br>
&gt; export PYTHONPATH=3D&quot;${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibf=
dt&quot;;<br>
&gt; export PATH=3D&quot;${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}&quot=
;;<br>
&gt; ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board<=
br>
&gt; tools-only;<br>
&gt; export TOOLPATH=3D&quot;--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --t=
oolpath<br>
&gt; /opt/coreboot&quot;;<br>
&gt; ./tools/binman/binman ${TOOLPATH} tool -f missing;<br>
&gt; for test in testFitSignEngineSimple testFitSignPKCS11Simple<br>
&gt; testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test $te=
st;<br>
&gt; done<br>
&gt; <br>
&gt; You&#39;ll see all engine tests pass.<br>
&gt; <br>
<br>
I assume you are referring to my second sentence &quot;We cannot add suppor=
t for<br>
OpenSSL 3 or later without moving to the Provider API ...&quot; I can see h=
ow<br>
that wording could be confusing.<br>
<br>
OpenSSL 3 deprecated the Engine API but did not remove it. The Engine<br>
code is still present but not callable in v3 because the header files<br>
were removed to help prepare users to migrate to the new Provider API.<br><=
/blockquote><div><br></div><div>Are you sure that&#39;s not just what Red H=
at did as part of migrating RHEL customers?</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
And OpenSSL 4, which is gaining more adoption, removes the Engine API<br>
code entirely and only makes the Provider interface available.<br>
<br>
Some distros, like Fedora, added an optional package to put the header<br>
files back alongside OpenSSL 3 so that projects (like U-Boot) which<br>
hadn&#39;t migrated to the new API would still build using Engines. I don&#=
39;t<br>
know what the base image of your container is or what release of OpenSSL<br=
>
it&#39;s using, but it&#39;s likely doing something similar to keep the sym=
bols<br>
available. But as it stands right now, U-Boot will not compile in<br>
any environment that does not provide a bridge back to the Engine API.<br>
<br>
I&#39;ve found that the fastest test of which API is available in a<br>
particular environment is to (optionally) sprinkle some printfs<br>
throughout the lib/rsa/rsa-sign.c and then build the tools target. The buil=
d<br>
will succeed if the headers are available, but quickly fail otherwise:<br>
<br>
=C2=A0 =C2=A0 =E2=9D=AF make tools<br>
=C2=A0 =C2=A0 ---&gt;8<br>
=C2=A0 =C2=A0 In file included from tools/generated/lib/rsa/rsa-sign.c:1:<b=
r>
=C2=A0 =C2=A0 ./tools/../lib/rsa/rsa-sign.c: In function =E2=80=98rsa_engin=
e_get_pub_key=E2=80=99:<br>
=C2=A0 =C2=A0 ./tools/../lib/rsa/rsa-sign.c:115:9: warning: =E2=80=98ENGINE=
_get_id=E2=80=99 is deprecated: ENGINE_get_id API symbol is removed. Define=
 OPENSSL_ENGINE_STUBS to mask linker errors. [-Wdeprecated-declarations]<br=
>
=C2=A0 =C2=A0 115 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0engine_id =3D ENGINE_g=
et_id(engine);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~<br=
>
<br>
=C2=A0 =C2=A0 ---&gt;8<br>
=C2=A0 =C2=A0 /usr/bin/ld.bfd: tools/generated/lib/rsa/rsa-sign.o: in funct=
ion `rsa_engine_init.constprop.0&#39;:<br>
=C2=A0 =C2=A0 rsa-sign.c:(.text+0x15): undefined reference to `ENGINE_load_=
builtin_engines&#39;<br>
<br>
To fix this build problem in an environment where the Engine API is not<br>
available (even if OpenSSL 3 is) we need to call the Provider API to<br>
replace the equivalent functionality. There is not another fix to the<br>
build failure unless you want to make a declaration that U-Boot is<br>
pinned to the Engine API as a build dependency.<br>
<br>
I also want to emphasize that I have been careful to keep the existing<br>
Engine code as it is. The new code is there to support the Provider<br>
path. We collected at least one Tested-By trailer from a LibreSSL user<br>
early in review, and I recently found a way to test for regressions with<br=
>
OpenSSL 1.<br>
<br>
<br>
&gt; Additionally, from my branch at <a href=3D"https://git.u-boot-project.=
org/u-boot/custodians/u-boot-rockchip/-/commits/openssl-providers" rel=3D"n=
oreferrer" target=3D"_blank">https://git.u-boot-project.org/u-boot/custodia=
ns/u-boot-rockchip/-/commits/openssl-providers</a>,<br>
&gt; I have tests for both OpenSSL engines and providers *at the same time*=
.<br>
&gt; Here[2] is the log where you can see none of the OpenSSL engine tests =
are<br>
&gt; skipped and only the PKCS11 provider tests are skipped. They are skipp=
ed<br>
&gt; because we don&#39;t have the proper package installed inside the cont=
ainer but<br>
&gt; I tested this locally months ago and they pass if the package is insta=
lled.<br>
&gt; If either the engines or providers weren&#39;t supported, you would ge=
t a skip<br>
&gt; with a given reason, see [3][4]. [5] shows that you can build both eng=
ine<br>
&gt; and provider support in lib/rsa/rsa-sign.c.<br>
&gt; <br>
&gt; If what you said was true, we would have had a build issue when every =
distro<br>
&gt; moved to OpenSSL 3 when it was first released 5 years ago, which didn&=
#39;t<br>
&gt; happen.<br>
&gt; <br>
<br>
That&#39;s correct, because as stated above OpenSSL 3 only deprecated the<b=
r>
Engine API without removing it, and some distributions still made the<br>
headers available.<br>
<br>
My second patch, along with the CI work Tom did earlier this year,<br>
addresses the missing package in the CI container.<br>
<br>
&gt; [1] <a href=3D"https://lore.kernel.org/u-boot/8d7ff3b6-abb9-4441-8491-=
99c538ea5f2d@cherry.de/" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/u-boot/8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de/</a><br>
&gt; [2] <a href=3D"https://git.u-boot-project.org/u-boot/custodians/u-boot=
-rockchip/-/jobs/79119/raw" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/jobs/79119/raw</a>=
<br>
&gt; [3] <a href=3D"https://git.u-boot-project.org/u-boot/custodians/u-boot=
-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8339" rel=3D"nore=
ferrer" target=3D"_blank">https://git.u-boot-project.org/u-boot/custodians/=
u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8339</a><br=
>
&gt; [4] <a href=3D"https://git.u-boot-project.org/u-boot/custodians/u-boot=
-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8719" rel=3D"nore=
ferrer" target=3D"_blank">https://git.u-boot-project.org/u-boot/custodians/=
u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8719</a><br=
>
&gt; [5] <a href=3D"https://git.u-boot-project.org/u-boot/custodians/u-boot=
-rockchip/-/blob/openssl-providers/lib/rsa/rsa-sign.c#L22-L33" rel=3D"noref=
errer" target=3D"_blank">https://git.u-boot-project.org/u-boot/custodians/u=
-boot-rockchip/-/blob/openssl-providers/lib/rsa/rsa-sign.c#L22-L33</a><br>
&gt; <br>
&gt; &gt; Both I and other reviewers have tested the proposed changes on di=
fferent<br>
&gt; &gt; distributions using different OpenSSL releases. The build failure=
 is<br>
&gt; &gt; resolved on OpenSSL &gt;=3D 3, while building with the Engine API=
 still works<br>
&gt; &gt; as expected. (The only obstacle we found was that signing with a<=
br>
&gt; <br>
&gt; Run the list of commands above with your patch series applied and you&=
#39;ll see<br>
&gt; it doesn&#39;t work.<br>
&gt; <br>
<br>
What commands? You said the podman local test runner does succeed. If<br>
you have an example of a specific failure please include the complete<br>
output along with the commands and environment that reproduced it.<br>
<br>
&gt; &gt; hardware token key using Providers didn&#39;t work, partly becaus=
e the<br>
&gt; &gt; existing code doesn&#39;t make the pkcs11 uri parsing available o=
n all<br>
&gt; &gt; paths. But Johannes already proposed a solution that resolves tha=
t<br>
&gt; &gt; issue.)<br>
&gt; &gt; <br>
&gt; <br>
&gt; I&#39;ll discuss the provider part later on, I would like us to focus =
on the<br>
&gt; OpenSSL engine build failure for distros where OpenSSL doesn&#39;t sup=
port it<br>
&gt; anymore (Fedora 44 without the ability to compile code using engines a=
nymore<br>
&gt; unless openssl-devel-engine is installed, and every distro with OpenSS=
L 4)<br>
&gt; while still keeping OpenSSL engine support working when it is possible=
 to<br>
&gt; support it (all other cases, including Fedora 44 with openssl-devel-en=
gine<br>
&gt; installed).<br>
&gt; <br>
<br>
See my previous explanation.<br>
<br>
&gt; &gt; What are your specific concerns about the code in this version of=
 the<br>
&gt; &gt; patch series?<br>
&gt; &gt; <br>
&gt; <br>
&gt; See review on patch 1 (posted a few minutes after you sent this mail h=
ere,<br>
&gt; unfortunate timing). But essentially, this breaks OpenSSL engine suppo=
rt on<br>
&gt; OpenSSL 3, which is something that is supported by OpenSSL and which w=
e want<br>
&gt; to keep supporting.<br>
&gt; <br>
<br>
As mentioned in my commit messages and earlier in my reply, I have been<br>
careful to preserve backward compatibility for users who may still be<br>
building U-Boot with the existing Engine code path. Your other email<br>
states my patch &quot;will break&quot; distros like Debian and Arch. I&#39;=
ve been<br>
testing on Debian stable and not seen any problems. How did you<br>
determine that Engine support is broken?<br>
<br>
<br>
Eddie<br>
<br>
</blockquote></div></div>

--000000000000fc4a4c06601060ad--
