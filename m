Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2D9C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF29360A88;
	Fri, 21 Aug 2026 16:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3BxUUgILJZY; Fri, 21 Aug 2026 16:20:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787329249;
	bh=+sRHmHXtBz3XG3/MhJQry43lJ6VPPE0rfw2SiKH5EMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GqTI1tueZg4OSosuJk6twpmIqjCoqJehtnkmWe7XEVrS+wjeARIPLpLZ54zUnCCxL
	 /spcIn5Z6P7bw5W52MNCwenDLqgfNap2DwztYrc0elkBXnJFiT/5nCUDAa/vZSTdrM
	 XpGRthalKMaP3bYNyi5u0shXFLMSHN9FUYIgKv7HcHWAxjdDZVVOAe5/6vh58l9TPX
	 aK4C1JXTSrbIIqbGPW+f+aYCNbTgESKMaJKAHPjOyIFjM+UiUH0pO8HyX+0oTPMDzs
	 tnyJZlMd/GswtpdHNiSF5n85GiJFbfiCFrswFCLQoxEuO3Raqfo/i31sk5VAOYgAAJ
	 vrU/yU4GhJKNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A793660A77;
	Fri, 21 Aug 2026 16:20:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C177EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E028409E4
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6B-85A8C8F2F for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:20:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:42::a;
 helo=mail-yt2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UryFcXBe
Received: from mail-yt2-x0a.google.com (mail-yt2-x0a.google.com
 [IPv6:2607:f8b0:4864:42::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA00340A14
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:20:46 +0000 (UTC)
Received: by mail-yt2-x0a.google.com with SMTP id
 00721157ae682-81ce92c1a48so6874217b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787329245; x=1787934045;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+sRHmHXtBz3XG3/MhJQry43lJ6VPPE0rfw2SiKH5EMc=;
 b=UryFcXBebhToINyqJPoulG5h0x4RR2Ir69hjaKbiZgDAzOl3nH1ZTliaGhwETOJBOC
 abchW6y1NTRuXU1tKDFFFrN4tVkL4FVs/jt4mqnaOZMOPzT11DsoDlamYPIqh58JTHiZ
 AP8zM5AmCvjhlFVD7VmMHFv38v3sleMwpHgVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787329245; x=1787934045;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sRHmHXtBz3XG3/MhJQry43lJ6VPPE0rfw2SiKH5EMc=;
 b=dzgiGVyEeu+0x2CivHDnboE2IojKSUU3KffRZia2poeiIZr2LwNH02UdQc9oDcAYOH
 E4HyW7A62Sjm+arnVzsvc7mwoLdR2k53f+so4PUYuu72gX47uy0CcBcFBKHEO1/GvM0D
 iWpodQ8MeZG9HF5ecKIio0tlSoqtwMWBFM61mWH+qUn0LVGqWH0UgVoLlLvc1oRCKkfI
 YpaF92cylxCBrbRCD8IGQak0sPtV3n8MSQmkoIoAdYGga8PyMzJDg3+qVkOFHMZ4sZ8/
 m9nDfvZt+LfTeFZVRCZk5DDmBwvVIn9fQgBIre/CzqqiyHrQ9KPci3rwg8iFWQktEiGh
 7xwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKSFa1Jd6Xu+iFiNQSgUsBOUSkUfdrkUW557POjRr37M42BuShi6PbEOLJdfrzWt4GlIPfFH4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kvW9JBq/oR/arKGXHNIWSZxJ3vh9w6Qv3znK7gy3cHgO/iOXle
 rtee22yvj66qACYluhTL1qo/6KZaZYuiobT47n+XnJ3SrcT3gb4eB/PoDP+2h1SBioneC/dtRY5
 fBRMzoe//M0Ue1C0=
X-Gm-Gg: AR+sD11xpoHDgtqE6jZ6gJZ9wXb6d66qm/49TXiD0npdFxGusScKigdCExZu81Bg3Dc
 +IMiVot/ESMigt4oiy0LkwhmWLg2lmXg2mbEInnvXbE2B78eZz+6dguA2B6LGHA/Ly/sDbf0Z0o
 icCCxzjAkWjRWd/OlVND/qwyd5d4hARE+GMuTxe0xEHNf5sYRW8gxJZkt3Xnrptdy9Iq4gElE30
 8/zPQuxAW84wFsqYzWkVYGp/+8u1GP+tRscSaiilzJL7TGpUDeZKzqDUWe31nRICMem7WHXVOrR
 5Bu//87qs7ytmPnFL4p9h40e2v/2/r7e1Iu4aGOvITe4ZTQniN0rDCBFSDiiMyuAT+z1uFdwC2o
 QAEfKWHZUbOtfN+txrJ3/nA1ctEsqrf1Bmcm259s/+W07cEFCpe3iqe23OKtjnkU0TIcM5ssw97
 ap66CHVbvSYfglq/sbRZxEu3vQAzueAsRKpUXYYteJCp82pI6Ndn81u+yz3/+cIi9kBOZg6orM9
 ru0XtEjGcDkVcwt7RfCbZ4sux6kKUO2d1+BcnW8VTqBvoq1w/TplrPCrfzhc0MLRYqibEF4EHVV
 ifOz6o5Ujw==
X-Received: by 2002:a05:690c:e68d:20b0:80d:f376:5ba9 with SMTP id
 00721157ae682-849f5c0ab87mr22711927b3.24.1787329245116; 
 Fri, 21 Aug 2026 09:20:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84517825632sm42807197b3.29.2026.08.21.09.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 09:20:44 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:20:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 03/19] image: Take entry point as an output of
 setup_booti
Message-ID: <20260821162041.GM523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-4-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dEtkUStp1H9oc3Ev"
Content-Disposition: inline
In-Reply-To: <20260821084219.1703743-4-me@ziyao.cc>
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


--dEtkUStp1H9oc3Ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 08:42:03AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> For LoongArch, the start of the image is not the entry point. Refactor
> the code base to allow entry point to be supplied by booti_setup().
> Also update the kerneldoc comment for booti_setup() to reflect the
> latest argument lists.
>=20
> Link: https://www.kernel.org/doc/html/v7.2/arch/loongarch/booting.html#he=
ader-of-linux-loongarch-kernel-images
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dEtkUStp1H9oc3Ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoh61gAKCRAr4qD1Cr/k
Cp38AP4uCB+bPG6ldZH3VeV8eDTtYwBbgTymSO8dVWzwVEmrKQD8DB8Uem//QlQn
WWfypNOXjVHnCPwkwkUf7ENCTYabTwM=
=umd0
-----END PGP SIGNATURE-----

--dEtkUStp1H9oc3Ev--
