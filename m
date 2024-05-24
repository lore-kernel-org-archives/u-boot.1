Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7720C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F0A88640;
	Fri, 24 May 2024 18:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YfOJvCEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA7788646; Fri, 24 May 2024 18:11:29 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D6C88552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43fb8cbf86bso567611cf.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716567085; x=1717171885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GIrPwwyteN2yfDJSUqiv9V8I7KVBLdE3HGzeuk3AB18=;
 b=YfOJvCEXHcwLrL0xbkQO7RpG5+7V3NovUcUkdUiBU4nJOcRjMzfnE/auE4DLeMDdzg
 vlT1X9b/g0OCRE11sTi+aUi9OM+RhnnfUmXt1u+hyrWoSmZjzAmqhiAvElPw207bgqST
 5xhEUn9CpE/8j2W+TD62jxetKWPT10SQ5JJzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567085; x=1717171885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIrPwwyteN2yfDJSUqiv9V8I7KVBLdE3HGzeuk3AB18=;
 b=ouhyMYWfGrIpeUzKpx2TokgZnXZEzzm6R5c9vlo2cNYGuO2i52axYXaNuXrVK1kdlH
 Nss5A0xM8umf0lkxLu63umqZ5MYtDJd4shyiSiTOSsLpjXsvUvwdjjoAgXxvRfH8Iona
 au/tnuiYRYD4M/uocO2G1r2Vwfq7+zxEgowPqDOm9qXHWrvFpkt/8C8W7JNibboOBLEg
 zFYnb26dmtsyg6pxRazidtL7rGdOEGjn1tyqv5VAtCxREJLBYAdj7CxSTUMkFL2I4C/t
 v7U3BBrQhZvo0jaiZ1Tb+Q99u9GSc0YXnd8VFkhgZsSH3mGa7YGHld5bvA/ZCONW0PfM
 VHfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH5op95smWrWTwkpUTOd2rHurNfnBymarX6t5GPjgEjh36H84h7t50vfZxQcFoRzTI0l2ty9tr5M8/0Vzmx+ntg2lkpA==
X-Gm-Message-State: AOJu0YxfzO5crB9psmGuIoYrh4ZWJbtJR0sBj/gPcqMBplPC7MYHxLZT
 35dvgA1xi4jmEzFXKEADDE6ACPWieAGWUj/dPgyy7+x4QVi/XQ801+Y34xQSCaw=
X-Google-Smtp-Source: AGHT+IEAmqaxXZEN5pbgHVYa3dA1veq8ybIveygDQWsbooJccq1veA0FeJMXNtVrWDMauf0tiEjIcA==
X-Received: by 2002:ac8:7dcf:0:b0:43e:3bc9:b5ef with SMTP id
 d75a77b69052e-43fb0e45116mr28285641cf.25.1716567084664; 
 Fri, 24 May 2024 09:11:24 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb16bff5bsm9278921cf.3.2024.05.24.09.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:11:24 -0700 (PDT)
Date: Fri, 24 May 2024 10:11:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240524161121.GC2568172@bill-the-cat>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20240507154836.GV2568172@bill-the-cat>
 <4250e775-1269-4929-8451-d8056c6f2f23@amd.com>
 <20240524152646.GA2568172@bill-the-cat>
 <CAMty3ZCyNHYC=tyWZap5CDRnFos-hK1U68AFdPGv3jMpWct2TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="10Gfoua2bg0UDJE+"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCyNHYC=tyWZap5CDRnFos-hK1U68AFdPGv3jMpWct2TQ@mail.gmail.com>
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


--10Gfoua2bg0UDJE+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 09:37:58PM +0530, Jagan Teki wrote:
> On Fri, May 24, 2024 at 8:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, May 24, 2024 at 04:09:00PM +0200, Michal Simek wrote:
> > >
> > >
> > > On 5/7/24 17:48, Tom Rini wrote:
> > > > On Tue, May 07, 2024 at 04:15:14AM +0000, Abbarapu, Venkatesh wrote:
> > > >
> > > > > + Tom Rini
> > > > >
> > > > > Do you have any comments for this series?
> > > >
> > > > Seems likely fine. Jagan, do you have time to put this in a PR for
> > > > -next? Thanks.
> > >
> > > No reaction for quite a long time. Can you take it directly to next b=
ranch?
> > > Or do you want me to send you pull request to get this to regression =
and see
> > > if this breaks someone else?
> >
> > I will (am now) taking a look directly, thanks for the reminder and your
> > patience.
>=20
> Will clear this weekend, if not if you are already on it. let me know.

I'm picking this up for next now (once CI and builds complete and
results look good) but please pick up everything else outstanding SPI
related, thanks.

--=20
Tom

--10Gfoua2bg0UDJE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQvB4ACgkQFHw5/5Y0
tyzq0AwAs9kqD0+9YxEHCb3cnBiTpHScarYWWvrqXhfbLXSwq1jzsbreTlp+7uWS
Pi0B0T6b6SuZw/7Na3uxkaqa4ueTrVxv63jinDLaqfShMiDb9EjTUiQtYPmcgmZw
9mE3ptdfLz4KakeLPV40nawY31t4cioxTeJv1ACQzBBqJ4sR/M+cddIPsOA18SJn
wHF3cfLuKOX6q/KvvpS9deVjwvH4/vo0IKKJPRYLSEbs4UYchiRO5n0qRCfshZSu
3uYtWG9fzqcku3rzw00uSq3ozRq8/v1Jvo8A9ySlnqumLP7/9U5Ok1Ypx+4RluqX
A/jkza07Ur3fsGCqcYJ/4yxxdpJ4A+gwU6EThdpjxvrLW9JuaGg9NCadkWySiNn6
LDIMQdW9h0ru25IltAjrZZvJVRC7NTDU9dx0TvHJhv0+yQ75TopmzXRV21dkcdNF
q8BL5HGRqWfidZaUbHb63B0tjpGT7b5jsZD8ffYE5ksBE49f2mZIkXCiYU3rsNI0
I65Zltpj
=LB3t
-----END PGP SIGNATURE-----

--10Gfoua2bg0UDJE+--
