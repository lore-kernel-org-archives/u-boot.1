Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB470C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 19:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BA7A4085B;
	Thu, 17 Sep 2026 19:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJDEiCjc2AeN; Thu, 17 Sep 2026 19:53:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AFF2540A0A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789674787;
	b=Df/tk5Y0YsBMdOj4S3DaG0wP9eMHWx3nrBdVpsO0Z8+TqnlO1MYxU/DLxM3CqyS+I4SL
	 MpAcu3ln+6+8UdC3KkfjyFSXoOl7j8780tawAHB0TKncmu6/JqEEOAVt5c0kEDd/291+/
	 MCrK5WCMS4+N7+ds/rUgfpHBNvbdvWTZAkJpc53EwR2ovjIIw7yA6oSjY+LA+9prvuUDG
	 s6y6CNdqNR0m7kHox5cGIj8A90Yo0gVhqsOwq/VIyB3G9QA3JEWHL8iP+9XGfv9nwgYm3
	 h/YOtrVA0Z+FAWLbf2zwOf5M2kWm85/54Jl16G4ZIhWSq01sLP5GNFAp+1LxqIpOITA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789674787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TO3CKXulvvX4HSQImedeERDin2F8zFLo8p1QwQk5264=;
	b=YPFNYNJeMxAUs6Uzz3MYfKklI95FhkcyRtB8LTAuAQGxvRyi6bCd3lHOp0GmGg19vOmD
	 lta6w1qxJmJQzpWn2wsNXCPqI0AxM7uHCZl780UaLm369jHt9Z0G+Gb1AY4xGlflp7iKK
	 1ZwSUKQbKDrZT+bR1nspoym7g/ULEQkQTSghX5ElKar42Ecv/40eEo37qMFgAjLettQ+p
	 m6vl8VxlvhJz//u2bWJkzWbDcGYwmEKGXWTSwRqwTuJ7X1YHbzw6kmyBiEWr/CK1EIvdv
	 /jgiJSUZZ6aHGElu81o4gKigcHndtVh8SMwemkgE2+dnrZokKxpv1ugrjF+X7AXZjVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789674787;
	bh=TO3CKXulvvX4HSQImedeERDin2F8zFLo8p1QwQk5264=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pEJ9BJAE8r2kdvVtUMHMbd6qNozJrqE+QRbebOeOc3AC5vnumzsRA3VcHKFoiIpaC
	 DeljHwkHZY+i5/dtzoN4n1uctXA0y6SySLmYCWX3BHhIejvb/l5Ff15OZYCGQFLhyV
	 7uyU7+dPE6GWxQnBpq3LpRBmfAd+S2uFnpz/IEiL8QeLSh6TWEQTa3B+9QEitrq9C2
	 MUW0CwMCn3G2LEdfoK5FYdlwLTfmHCofnBQNX9JIEkmYEx1tHW/NAXPAsQ9K9nNNvy
	 EXv3eP9rynOFURB9+nBHYVTD5ZaA2MpzN9CiRLZddg4xSWB3xf3zr81mrb1SA8CzMd
	 tx3gayw1mcqcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFF2540A0A;
	Thu, 17 Sep 2026 19:53:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 991EA3B6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01A3780F7B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwMuwLWOCo9m for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 19:52:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 48FE98098C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::27"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789674776;
 b=kx06wcf/wjOuFSntRurCJ31zu2TkP+09Hmg1fkMvyrf0uf84ZkTlWEnkBlhe6AkMqzSe
 oYaDazkeJuc/tS7r99Ufwq9wNS9/C24hNvQApTdjrRZLXGkohw8o6eVChbTsKZq9sXtaE
 MnTrPfGraDXy/WyZay0+GeAl1OYxmvsCe9+f5swyfCfjWr0jO2uRZj3ug6O2Z1yKvvMyn
 qHQh7LsWT0EydbXy5XLkzMyOdnOzdVcJ43Rc7AbMus0Ms2zuX3cYjUG5oWb5KgTZP6A17
 9YKh2cP+TyVtGGGcZR6qua8lL1q+y5C+2SVl6l4LN9xRtpc4stmF7JCuZSF1Yi8pFPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789674776;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=TO3CKXulvvX4HSQImedeERDin2F8zFLo8p1QwQk5264=;
 b=fxDtpYAjD9BVplbUoJgURdDA6IFL6cztKVsl3SmuiAjzfWL/mi/HOHGqdvEyY5NNjaC6
 3iD6vNvWhxqu05eyrPl4IQNcEMiYAIPTscGKayvqu2qxpQ0PvAz64fUQ7A4OVV2rFY+Uj
 8VZyDDrADgPLJcYrf07X6oxDuV69BRUtuXmWVi6m0ZfHOirNrutQ9wYF8f4I7zf0iUMlN
 Su9UBjVN1mdyTFyqYqS+f2QTsOWB71rWf1hu75L+VroW9avF3Aq1J5/0CLwCQo4Ag/JBu
 FSO315PxeAHB2kyQAgD1AKQFdXy4oRPH2GBHlU81BGCVJiWks5N7Jiviouy0y5fNduw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CiK38akr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::27; helo=mail-oa2-x27.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=CiK38akr
Received: from mail-oa2-x27.google.com (mail-oa2-x27.google.com
 [IPv6:2607:f8b0:4864:30::27])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48FE98098C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:55 +0000 (UTC)
Received: by mail-oa2-x27.google.com with SMTP id
 586e51a60fabf-466ccdd77e3so34924fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789674775; x=1790279575;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TO3CKXulvvX4HSQImedeERDin2F8zFLo8p1QwQk5264=;
 b=CiK38akrzYyJnxZo/AiLkBq2bsHRoAHZyl25KHnqZSfy2wFtcH+L2CAd7zykrScHig
 SkPV+PKS1Fn4krJsGcoTUd7NVUwpbKk79Djeyz3tec5rrPj7Frrl6YrHlV+hK8wuJkQb
 lt1JU+DLrQ5N5IshuyN+HL0pH8ROI3OQ/5d0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789674775; x=1790279575;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TO3CKXulvvX4HSQImedeERDin2F8zFLo8p1QwQk5264=;
 b=11D7i5sfASdeuBv+alEM/BdC/j8Skclb57jiyopBWyMmVZTpEk0C93IOEZINSFshP5
 bINgurWP25iJnLMgCazG9SDD2gmLG2SjpWY4BbSRGIA+/iOxfIIbdArU4KGvl651msuz
 ukGnMdXxfyzaC/4duvAtWW8lzUvCjvPnW0qONUQTInabnnpRCXAu/J/X9CqBlY3oQ4Nr
 kkt6AeTIIRBMGZgBqg/awQJIu/XsccQSh9mptPesCysLKDmqRUByg/2Q1pU75v9Ag+2u
 hPELXsyAJUF/kcj2tdHSrcTMml4u98zMyCzytuQVc8XznHfUAuC0QRDUbEERUXA3MN/r
 2Aiw==
X-Gm-Message-State: AFuF++lAg+ZmsstzcgTpQtCT39A4zEryzi6QYT55YfmsW1lT51XtcCUd
 z20fwGvJDIpGtEePTH1vsG/JZJv2gYXlp1/IVS+FZvZcN7VCc11+heO8CUSr7uYXO9Y=
X-Gm-Gg: AYBFou1Uf3RxJqmcRGuOOaW25j2JKpcxyln5VZ8YSdxizszzPOpvD15qk0P5JDnR6E/
 xrzPGXsyTmCxjtpnCgARpOAXi1wVq/9dIoWLjCC+V0j3GvFCqZ7jfbwkXzKGHrGsMLbASp71Fkv
 wkOqdeg0LeddKB2iWDBFonxAjuqJ9mxq7ssX34LMdcoDMb2Y/EKw+9tpsC/1DOSM3chvRGmLbNp
 bZYqaKa1l6JidPzyo1t5oehklMst4RA5J7vjBaKGITVHpUd1gCfeDKQ8rVdMhlyjgt2kdkOeJHZ
 NT1I/4Z6L1TXS4BNPG7mcn1peokrqGMZSPrkggKe2qdGKhzeNGpW2+NuslQ//9ulDc51EuzBheE
 60ijvs3XGDobwfY356bxrdpvorvBzz2vTRUjiRGiTT/YWTjIKPRVUzzkSVpBlB56eYoaDx4czXr
 MhV+kuXEOlw4jbTByk0+9TvPePpiR4+cN+BBg1wqvY6oIhopVJYVG15iqkkgBwF+aIpf25rjrTn
 yB4YIqvoecsx66dEwpDS0C2zsFi4SLdAOPphC+7IqqrqoYMFnmf2iqVLoYkUEktVTR7QQ8fp5+C
 N+1kBHYIMQf1Ta/SBnyj
X-Received: by 2002:a05:6808:1a21:b0:4a4:744:a4ff with SMTP id
 5614622812f47-4ccf59c79f7mr360690b6e.4.1789674774751; 
 Thu, 17 Sep 2026 12:52:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cb6cc4290bsm3561776b6e.8.2026.09.17.12.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:52:54 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:52:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 04/11] lib: Track whether a phase has a decompressor
Message-ID: <20260917195251.GM858934@bill-the-cat>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-4-7985ac56ee9e@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4q2Qf2HWd7TqkDG7"
Content-Disposition: inline
In-Reply-To: <20260917-spl-fit-compression-v1-4-7985ac56ee9e@flipper.net>
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


--4q2Qf2HWd7TqkDG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 06:02:25PM +0400, Alexey Charkov wrote:

> spl_decompression_enabled() names the two algorithms SPL happened to
> support, so every algorithm added to image_decomp() requires editing the
> header. It also asks about CONFIG_SPL_* from a header included in every
> phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
> wrong phase.
>=20
> Add a hidden per-phase symbol selected by any of the compression
> algorithms and ask about that instead, which also matches how
> image_decomp() gates its own cases.
>=20
> SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  include/spl.h |  6 +++---
>  lib/Kconfig   | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/spl.h b/include/spl.h
> index 8a9f799f192a..50b41a3a3908 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -1204,13 +1204,13 @@ int spl_load_fit_image(struct spl_image_info *spl=
_image,
>  		       const struct legacy_img_hdr *header);
> =20
>  /*
> - * spl_decompression_enabled() - check decompression support is enabled =
for SPL build
> + * spl_decompression_enabled() - check decompression support is enabled =
for this phase
>   *
> - * Returns  true  if decompression support is enabled, else False
> + * Returns  true  if any decompression algorithm is enabled, else False
>   */
>  static inline bool spl_decompression_enabled(void)
>  {
> -	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
> +	return CONFIG_IS_ENABLED(DECOMPRESSION);
>  }
> =20

Is this build time check really required, or shouldn't the callers fail
out appropriately already?

--=20
Tom

--4q2Qf2HWd7TqkDG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqxFEwAKCRAr4qD1Cr/k
CuW2AQD08rV5/Y7OKRRH9xl0ro+6VLvaQREPVmoYy6Zgt0sHtgEAuAi1NG1go7wf
rJOD6bJm5k7sV0KaJGpABsicooMa/Q4=
=oW43
-----END PGP SIGNATURE-----

--4q2Qf2HWd7TqkDG7--
