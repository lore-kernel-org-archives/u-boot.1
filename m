Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0D606A8BE
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=noPUS7ME;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YPAdpH8C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01D1A81762;
	Fri, 13 Nov 2026 20:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VuuRxZ4VKgCU; Fri, 13 Nov 2026 20:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AAD4817AF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794601495;
	b=Rh4MyxDvzuq8lQ2iETTHG6bj44aP1QG0P+xbskJWuK8pYtfyN862lmHSTTILigN1NYoR
	 EBsAJAw+6yy6dh7b+vlfqWd0X9dK2LkuTtrdDqKd21S50aAVFanSDsRZo9YPFMx1FuCeW
	 qflhesmmV35OMuWpAPp6hgJvarrRsRchxQ2Yt8BaipQLII/T3OfyTqXWYtptcdrXSRXgq
	 uIfQpjj/Loi1TS4zWVRFY2oflFo9PhUFVr1DmZARYKuTvlIlaCLq6GIEZWa/xcY/TpUVy
	 +NdkgdCQVhJFKrAcN/MfbMyBNABjcIUXyIc+0dDoZBnTsKeZ8kL0jliTx/2rzQrG2WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794601495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a0Hxkn1lwjhS/QDU5up+fRMRs7bZk4bxT1NdUxCSJjg=;
	b=HAyFYnu+c/1waIk2+Fa8rJ8iAb/4hyt6MNwrHoxOuIvy3yKGoD9Nnr4L7uq866wJIwZE
	 awyeHxdTrSys87Fti+oudGBpXxpB8/JiitmtDZ0AR8ED5NzFIB3+oUWsMTDrQR+2HWrth
	 500hPypTGUmFi6YYf5waO/aPAocNfps5PSZ+U5R2xoHV7LczdAqDYCS08GthEX67d5Lf/
	 QuSXQ0x9Ba/9K8oz+zfefo6mZwX6ofH2uhvWzYx7uJoWJzq7p7sdfXucF0ilIbYjdx7Ga
	 ElZJXb1lU7R/Cjwgm0bI+ki5tP2NKD05iB3jUbispWwbBVSfZX5hoPL74WpkKakNrcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794601495;
	bh=a0Hxkn1lwjhS/QDU5up+fRMRs7bZk4bxT1NdUxCSJjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=noPUS7MEqHDYHZPjAiZkiTpOnxOyM1boSSVEBgT4CMeT4oIH/LgLLfXeKUyGAonnN
	 3at+QadZjFEgdHcph3BsQtC+hK+inpQTNAOJVqCq7aDV1b3eqtMG9IOf6bTtNQvx/Q
	 oTQr4YYUFNC+DWjnJOaMf0ZxEiZ0WArijXfI+CAZ08o8lvLh1UnsMdc4X+MNdhfV/7
	 L4EsM1bA65AJV3H+kcdvIl25KvUXUBnRp2K6dJ7dsnHcFoBGmZ0Ly08X+to57KnmEu
	 xto7Jcn8U/PyrrFZrqJ0ptTWEidIFRLqqb0aSPTYbDZPkOFQmFOX+yGjUvHsmJ/LkZ
	 0nNHCCuQdzbww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AAD4817AF;
	Fri, 13 Nov 2026 20:24:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66AD0150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52C14608B6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wzq0L8Oqhxpq for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 20:24:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FDE260896
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YPAdpH8C
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FDE260896
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:24:51 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-71ad047710aso31024eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794601491; x=1795206291;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a0Hxkn1lwjhS/QDU5up+fRMRs7bZk4bxT1NdUxCSJjg=;
 b=YPAdpH8CnWBfJgJqsggpoMpVBpU0XMVzHT5O2tlPbhvd60adRTXFcH/Jw6qa3DmKcr
 wd1V6WmYyQpLEtM7LlI61919xglZRjFQDBgqChbHvKSY2BexEddCYjDsXuEx5D2/iOk9
 WNIrkzkI7WZSMTuBQbNEEn93ARk7cPHj3RBvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601491; x=1795206291;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a0Hxkn1lwjhS/QDU5up+fRMRs7bZk4bxT1NdUxCSJjg=;
 b=DBcgCS7Ekzx0AbMHxPpx+Lkf7cGlhD7cAQ/Wcjmj7mYlr67FbRty8150a2bH2RsZCZ
 fC/we6AR8Fz1zPKC4KeKzRTOCf0d11+v6zqQnhV9J8NWN0WWq9cIDIkBqUnJ9qxtDlIN
 WDof7doXxLWTSad4VDb503FEMpODYdxkg4C2n/mcYL/jmGrmRHjwB7lLOOT5BjrhbJSJ
 xiypa7beE8/D/PHi0twqi7kTHu++PmMoxQ/wmhRwUXcod4tqVu5Ax0Q9BhJunx0uhLQ2
 BDouCU/Ds3iBlq6Hu9CnQuN+uWpuwMvmJo4J6ILa9PZP1v5PigNcOcEGpN9uiio2W5pB
 LWlg==
X-Gm-Message-State: APuU4Z+YN16NAT6GrKYxtNzalJm9gLavuE/KXJ1mNGfGzv8DfBWuhSEy
 1Q7ods43i/FbbebEknE9Sety0r2n9uRCpOAShHE34ecw2InjwW4QtCFyQGnklORDi64=
X-Gm-Gg: AYBFou2jT66tk0Z7fOZE06f9OACTUj5Vq2uoBqo7s63vuq2KQl+BVACExDtvvqMHn76
 sPnBrNqYoIVntCVIxtyCHaxlC8df0CGDNvZVVbPOzml1Crs6r81ZWe4XFUcrhApxB/DNuiruV5m
 f8NdnnjGvkWjPWg0FEXh7w6hqm5DqONdxAXhDa3S3LgKAOOE05uM77HTuVFzB+BIrutalCNJFu1
 VvqtJGGtmsxaGSBLVBjaf2cO+Squxdfd4tYPpqMo8Vh38/Oce/mTxPfZQXs4PljerHzIRJvoIrT
 /hPmYLAgrSsxIpDEMt0Q1+cB2D00c19/Z9QEW7CUwXaXHNM7+cJGcjDqWzxIpvCF72Y3cl2PZHD
 zlRMU+ArwNGvc5Z3aMcYDTlNGCFHKkTyOLSMAQfT4XlAIb9BVv+4Iu8q4KGacXUseQe8sJ98xn9
 E8ucSVpuAjnmtDUCVdwvxBW6e59sn5/JLoW1jnMwQZFgrT9L5vszhVnzb7+JK+Nvj3+RmEEJKr0
 iIwyss8H1AQGqtNOxzIPyIldrCiO27JH6gvxCIX6eJJPiLOeODaIbOXj7PU+RaXV39Tc36lNxS0
 wC+mf6r+TB3iUZ2MoWEIUOkBIeVTu//2lNEyKphsUG24gJnlSDBKIAHuajo5+AmGvrPN2FHNoS2
 IUjWfI4DNRfAt8YhIMxvkm6wlJWzgLwENfBFmohfoNdmFn+5+WrG0w0/gILHoETqF/xLZBslOu0
 hO3UMZOUGdYV+oNFyU6Bsl0CsXu8xX+ko=
X-Received: by 2002:a05:6820:168c:b0:6cd:3fdc:5ff9 with SMTP id
 006d021491bc7-71acc4cba02mr807456eaf.74.1794601490789; 
 Fri, 13 Nov 2026 12:24:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab43347b9sm2466779eaf.12.2026.11.13.12.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:24:50 -0800 (PST)
Date: Fri, 13 Nov 2026 14:24:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Conor Dooley <conor@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/8] Add support for RPMI to U-Boot
Message-ID: <20261113202447.GQ554944@bill-the-cat>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113194911.GP554944@bill-the-cat>
 <avdtFdcuCvG6YE7f@MON-LT-C78453.mchp-main.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I8yoCnwc/lGEorQU"
Content-Disposition: inline
In-Reply-To: <avdtFdcuCvG6YE7f@MON-LT-C78453.mchp-main.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--I8yoCnwc/lGEorQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 03:03:33PM -0500, Charles Perry wrote:
> >=20
> > Once QEMU is updated, do you plan to update / add more tests, so that we
> > can run those tests, and presumably have more comprehensive testing, in
> > CI? Thanks.
>=20
> That might not be possible because I need a special patch on top of
> Subrahmanya's series to add the clock service and some phony clocks. This
> clock service isn't going to be upstreamed to QEMU because it's somewhat
> useless outside of testing.
>=20
> For CI testing, the path forward would be the sandbox mode that I added.
> The only drawback to this sandbox mode is that it will NOT test the trans=
port
> layers, only the services.
>=20
> QEMU is nice because it does test both transport layers and the services
> themselves with librpmi and OpenSBI (but I need the special clock patch,
> and we also need to build OpenSBI).
>=20
> I'm open to any suggestions that would improve testing and CI.

If you take a look at tools/docker/Dockerfile you can see how we build
QEMU (and some other tooling) today, for CI needs. A question I have now
is, is there value in U-Boot testing the transport layer, or not?

--=20
Tom

--I8yoCnwc/lGEorQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavdyBwAKCRAr4qD1Cr/k
CgiOAQDW0n1mvAhtxnhsCPZN9UhjZ4QzwPKna4kI1IY3340HZAEA7se5KQTEZx18
XFZqzL79q03Xh+KMMEeGjrO5gifIkAg=
=sLuw
-----END PGP SIGNATURE-----

--I8yoCnwc/lGEorQU--
