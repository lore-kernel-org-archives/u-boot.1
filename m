Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8340ECE8E7D
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051EC88DDC;
	Thu, 24 Oct 2024 16:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b2GDSceV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B0F88DFE; Thu, 24 Oct 2024 16:18:49 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCEC88D47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-460c316fc37so6052321cf.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729779524; x=1730384324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dau2wVrCzmYEzacgCt0WpqtYfCkpr0XNxjrWFESOQBo=;
 b=b2GDSceVBFlYw9D6/E4LZD9V7w/fn+2fCzyvvNSHDWuZhcuAzWJhNExCm628nayEkJ
 yEzYBEDPQ2Fgo1ET4/UaoIdR9pKtJiDUKoZp0AgZIHmkd3NgOttAq0saL8VUE5WSmP3Z
 XP7BJ80Cs+6iVCd9AH/iP7K5XWEvmJLQHac8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779524; x=1730384324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dau2wVrCzmYEzacgCt0WpqtYfCkpr0XNxjrWFESOQBo=;
 b=rSD5ln3VzUS4WWftaEbuxNNR//psfvoYCLr0iU4tZI+//+W5UU3Shph1hFGyhashYr
 lkYQa3Jxpnwoaic19L5Yu+ysVs4tK1vF25Ak1AKW02f3rTQGc17xKyzDKW3RZExPiWn3
 hxPYg7+LK+4nta7MfLG1YpSQu+/kckpl9YvCZeHICMu+wc6rAVH0oKXlgXtyGPEaVOfI
 mKZN9TkBfu/oEOCQerAvDSrg20fx1IaXLc4WInbw3yP9oTxhZn/+yYjdZn4hUjp7n4IT
 0qvPjfVpvk4KptbGXorMUBiIqTjg+XxoHdS8fA4E0HZsTYaSfUmhhDo4jcQj+tdkrRbG
 fUeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/bDhp6kAeaOZrvhuQ57OKYZ6papGZNCPjS5pehPPZ2vDFp9ZyzwOlzDPRV19k3AMyzASmck8=@lists.denx.de
X-Gm-Message-State: AOJu0YzM04ta4JN4aL3o9uJXII45Cy1qvHrplloFg9XrrclIKkIoQpnV
 UEYtgzxqp7byravPW3WUWevy+X3DDOMi1bFqUZHAOmY6Qc0Z1LT2rq5ipWK2vQY=
X-Google-Smtp-Source: AGHT+IHr8CIzcs7cKvrdnriF0GovqMh4hu1St7T0+Hwp7WT2Z/fMKO2uF2FvH8r+T10HK9TGiKmc4w==
X-Received: by 2002:a05:622a:1184:b0:460:6294:67dc with SMTP id
 d75a77b69052e-461258a08d0mr21934321cf.10.1729779523947; 
 Thu, 24 Oct 2024 07:18:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00a03a97sm50969216d6.139.2024.10.24.07.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:18:43 -0700 (PDT)
Date: Thu, 24 Oct 2024 08:18:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] efi_loader: Mark a function static
Message-ID: <20241024141840.GR4959@bill-the-cat>
References: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
 <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
 <5fc1929f-c931-4c14-847b-6ea9333037d5@gmx.de>
 <ZxemNUOQ8UUQvAqO@smile.fi.intel.com>
 <5EB571BB-8963-4B47-86EC-1F1C5424D4F1@gmx.de>
 <ZxnohqlBa5LuIriK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/FFGi9YIxmxlL88k"
Content-Disposition: inline
In-Reply-To: <ZxnohqlBa5LuIriK@smile.fi.intel.com>
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


--/FFGi9YIxmxlL88k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 09:26:14AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 24, 2024 at 07:03:24AM +0200, Heinrich Schuchardt wrote:
> > Am 22. Oktober 2024 15:18:45 MESZ schrieb Andy Shevchenko <andriy.shevc=
henko@linux.intel.com>:
> > >On Tue, Oct 22, 2024 at 08:02:46AM +0200, Heinrich Schuchardt wrote:
> > >> On 10/21/24 16:40, Ilias Apalodimas wrote:
> > >> > On Mon, 21 Oct 2024 at 17:06, Andy Shevchenko
> > >> > <andriy.shevchenko@linux.intel.com> wrote:
> > >> > >=20
> > >> > > efi_bootmgr_release_uridp_resource() is not used anywhere except
> > >> > > the same file where it is defined. Mark it static.
> > >> > > This helps avoiding the compiler warning:
> > >> > >=20
> > >> > >    lib/efi_loader/efi_bootmgr.c:388:14: warning: no previous pro=
totype for =E2=80=98efi_bootmgr_release_uridp_resource=E2=80=99 [-Wmissing-=
prototypes]
> > >
> > >> The function is called efi_bootmgr_release_uridp() since 292a4a4c7b77
> > >> ("efi_loader: shorten efi_bootmgr_release_uridp_resource()").
> > >
> > >Thanks! The problem is that U-Boot doesn't have the latest tag (yet)
> > >that includes this change. You can help with managing the conflict.
> >=20
> > Patches should be based on origin/master (or origin/next once that bran=
ch is
> > opened typically after -rc2) and not on tags.
>=20
> I disagree. The problem with moving target that it's been moving...
>=20
> The tags are very good to follow and easy to maintain and test and report
> regressions against. What you are suggesting it's like virtually assigning
> tag to very each commit and tell maintainer to cope with this chaos when
> one does something in one "tag" out of 100500 ones and another person in
> another "tag". So, consider tags as stabilisation points, or points of
> stability. Then it's much easier to stick with a few tags that with 100500
> commits.

This isn't the linux kernel where there's constant churn. Most of the
time, it doesn't matter at all. Sometimes it does. Then it's a question
of if the custodian wants to do the rebase work themselves, or ask the
submitter to. And since again unlike the kernel almost no one has the
primary job of "work on U-Boot", the threshold for fixup or ask for a
rebase is much lower.

--=20
Tom

--/FFGi9YIxmxlL88k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcaV0AACgkQFHw5/5Y0
tyx6+gwAih/r7/JMS/7pDECQMbR07C9aASdKEIY8g2CN6BWttf7FA4Q6ChwpW8l0
AuG1aTDelm0m0Ar5xb7EQMcr2cCrmiy4FTg6Fm8s0V9xwOMCUyXNTq6dJn1ixGfp
hSoVB+McK1qL+nw4I2L1CbdW07XrnRgcrKgpo6kqK9i12p9Tn5P3n7jFRLsoy/GB
FnRgAfXt/bX65F2n1aoadQF/9zv9OSPM2Q+2EqwzNWdBx5GXrS6sxfcIBr0YTelo
uIeOr9on9UJa9Q06+CbDaoHy7m+Pn9xMfoTw+7mdp973WC5ulX1ndChCtO+Bi6yP
ePF5EgzM7R2dlLwwFnibZ6GQwTC2p7JfiGtBYyPVfdPgGEIvW05r9vpU0cF4XC6r
KCRh1jnyVi3cTEmwk22SJhV5RnvRpdmFd5r31QPNKTXNJVXR6hZs4Ou0FUjhwm0X
SdaqbESatueO7AJ0JQ2SlE5Dnw8S+MaCc6KZCLf04B8JE3UeUwTf0IFdvBNz0/UY
2NtNa1FL
=TJ2N
-----END PGP SIGNATURE-----

--/FFGi9YIxmxlL88k--
