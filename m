Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E5DD3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 14:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A117B892BF;
	Sat, 19 Oct 2024 16:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XwUdzEsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F465892C5; Sat, 19 Oct 2024 16:16:54 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAE8892AA
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 16:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b1511697a5so183207685a.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729347410; x=1729952210; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6YgExZAebRZKN9ZiJlBP9Qv0ZUgwsJkGUwVem0K2juk=;
 b=XwUdzEsEU3CnOp8W6EDXUJUDDJZw36jwi6dtv4sd0qGrHFGBuPtPD60gwGQm/DlxYM
 xjxac3uaifCDkGeO0QVXeV9wpZ2KGl3smQktnI1iseGa06hUKILQScy+OSsk3B0mMY7p
 CMN2vt9pGxXx4LJxsCRcW8lHd7jcJrAlRVS98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729347410; x=1729952210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YgExZAebRZKN9ZiJlBP9Qv0ZUgwsJkGUwVem0K2juk=;
 b=o9EAPXUtFgmYiBZsdokLFdui6Zikxaoyug1Mm6Fvo84CS4ALgtIdvJ99t36h10jqXn
 cJNM8otv1h4m9j86pHQW7Uu8ki3FOOTQT8wZmYKbiDEfwHSFjlYgP7j3CKnVq9jYybR2
 n3GQT3/anATLex3qMo0sn6rCntRtvuCMVwR7DmLQMHBbTvbMInBEIRbCSYdJ8mlyxApN
 +yw68xhVXr5cGiKzZVRKed2lOt8fywVtKUKFE9tpuWdu3Adq3Uq16T8jbjtscRsBcG36
 LL+oKpTXDzIiiclxxvuUScx334QFAODYSE+b0Lf41nVPbedfZtHETUO1d5edK0xEjwLN
 xIRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX445yDR5Xs84P1WJ/0nhLIyK5c+/qe0RXFqMTksLKqBJGJaxQtQezOBUCiDOJXUhs882HtjgE=@lists.denx.de
X-Gm-Message-State: AOJu0YybTaxPu996RvieVBtB6SH8eVOWl2tpM6DknXB6/1fMRbqevFt7
 g20L9trrE8Tp+DXGBWD5d9F4qJ6jJnTWdePKTOOQ0ziOtcxGbBGES+ngP8FssDU=
X-Google-Smtp-Source: AGHT+IHOP/O8oRpXSZrGVRLOXSD8MDpo6DposYMTnDkumxsOLPm1694C8cc03WlVuN8jYe3rcokKVA==
X-Received: by 2002:a05:620a:29d3:b0:7b1:1a1e:3013 with SMTP id
 af79cd13be357-7b157b43497mr856018485a.8.1729347410590; 
 Sat, 19 Oct 2024 07:16:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156f95089sm184624385a.53.2024.10.19.07.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 07:16:49 -0700 (PDT)
Date: Sat, 19 Oct 2024 08:16:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] mbedtls: fix defects in coverity scan
Message-ID: <20241019141646.GR4959@bill-the-cat>
References: <20241016234829.3836359-1-raymond.mao@linaro.org>
 <CALeDE9PpzBEQBYXMf9VCDWZD76LmEj0X1fq9W-=wjdwNOD1-nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iDr6J1px1ebE3hDz"
Content-Disposition: inline
In-Reply-To: <CALeDE9PpzBEQBYXMf9VCDWZD76LmEj0X1fq9W-=wjdwNOD1-nA@mail.gmail.com>
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


--iDr6J1px1ebE3hDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 10:37:38AM +0100, Peter Robinson wrote:
> On Thu, 17 Oct 2024 at 00:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Fixes of unreleased buffer, deadcode and wrong variable type detected
> > by coverity scan.
> >
> > Addresses-Coverity-ID: 510809:  Resource leaks  (RESOURCE_LEAK)
> > Addresses-Coverity-ID: 510806:  Control flow issues  (DEADCODE)
> > Addresses-Coverity-ID: 510794 Control flow issues  (NO_EFFECT)
>=20
> I think it makes sense to reference upstream commits/PRs for these
> sort of things moving forward, Tom maybe we need a policy around the
> third party libraries now we have a few more.

We should have a policy about what to do with issues found in external
libraries (Raymond is going to work with upstream) which is likely just
formally saying we'll report issues when found and depending on severity
cherry-pick the fixes once resolved. But these are issues in our glue
code, rather than upstream.

--=20
Tom

--iDr6J1px1ebE3hDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcTv04ACgkQFHw5/5Y0
tyyNDAv+K4c5yZX2nRAOhC70y1r4BgfWSyOtKcmLLnhyHxHsEijb1RFqw86gR9RZ
fH67OrTrypqpFMhRATGHN1miaSwcGwQRGxmoRAc8oARYGJE7yx1OETfBvGdkCFcL
k5eXfHyyBQIz3L98YCJlnck55n6x9RCtnQVlwOMziPHDEvUtAfWAxo+XPjFsRm99
B+gVJ7qT7E1UDDOzWW+hMiyWhVc7V/MpALQayDipyHniHsKqAuEVXlYMC85f858/
58iwtr5CgpTxJjrNdGvL73npUS8x9bVw7oPIarszozBBmFcMzgROQJlDe9qkxtXx
Kas3ED+xezh9Fva4AzoOLKl+IaVx/D5XdstPGka+WC1TreWC8BRSCruLJ+Ra9Fxn
rJc7gpVd+W/XzSWK6CMnVos+7IAyQuxjlQMH7ldayhaSXft0pDgadBPMhkpbABf8
122EJPiZyFP2ur6H54c4b9TEX/GECNU/rbACbd3b7uTClae+fXFnWgbLUe+3ekI0
+NpC4rZt
=p10A
-----END PGP SIGNATURE-----

--iDr6J1px1ebE3hDz--
