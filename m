Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7673CCA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB21C608C7;
	Fri,  9 Oct 2026 17:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mmu-IVlhrn3; Fri,  9 Oct 2026 17:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C37D560680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791566518;
	b=NKU6PVaHwYiaagA02U6Lo4ESH9uqpVuT/8TQRRO0lK1KAbGX77xUYlh64YR9+6cKx0DO
	 oDQiI0oRLFRiyjcCSh3iXfYiJMBfVkJgYNOza6dkeGP79nTWhApwv3zvOAa3cdcQ0Fm+8
	 V8wuS/ILMqDNL2KrKeTWBqrJFJmyPU1zf+7SXlwt2kBQgZ9F8oP7+oXfiQEYI/ADL0e7/
	 Ffu35Rq2eFdjpZJ5B9Iarkg1D3uvi+7mUTk8cfklOn1rpwLCf/nqrRJlxDPGqKnn6R0h6
	 0Os9p/RTzdl2VJ8Qit1FLV2ool+jYpYPM8z+ooSVFTiWhs629LF5uuAM5hAARqNAoEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791566518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sc1vj48Nl3+ExIvAtDx8EeoFcnddA16ogYElGAQNEg0=;
	b=CAsS5zFKS4+dwwHxEs/lVdFAHh8pjKOfMV1MBS+hl96ZEov/nPu+8KzS/Q2D+65wwf6t
	 Ji1wj90Zq+y/IMDIhmK11yQN991sdQs33Hf9JSzOoE1diQD/VwQ4tpZnsSAHKMmp21lUK
	 /HMLt7jWvg8RGl/MY9y7zh1tgq/X4soHwgdBBdzzCASBQM0Kcm++rSHzZDfm3GY74BpZ6
	 5ks+BCBzYjALWOh/GSI1Ae4Dt3y5x16vK0DfI+Vlnfta9MlDi1ihSWsXtZZOvcFjFtl9T
	 OChJ3+rQt03Ke8TIRK+El1xaX73ZmrLffrBSJlAr6/Tr7KI9O2SKpPde7CkgHMfmz1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791566518;
	bh=sc1vj48Nl3+ExIvAtDx8EeoFcnddA16ogYElGAQNEg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IIiVDqBHzcbAiP82cVB1MhDTDvJplkfVl1/EWd5LyBu73XPfFLc27LRNdfcGvZDD0
	 wLmFvZH3XGl2wbk83FG/jmG6/+2387r7ktVR7QlnrZRfacQTnVeK64o7ReXFwpHveK
	 kLytRheTVB0+Y26+64FSYlISvDcqH1me6/MUN8GmCPRnzsORpj7UhdB8pFJ9jQ9QsF
	 xjYmtzfkWeEdSvcpf/qUoWmk5cTh9SyhvGwkSRIkGBN7Rr7jiw77Z7zMulWF3pdtrv
	 YBQz9rZbLOCsRN30fLqRt8hpH6P9yQHq1ltp3VHt3nKoFtxMzrritwqCCvLV0ORpqU
	 GS85arMPJYgIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C37D560680;
	Fri,  9 Oct 2026 17:21:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAA17317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9055C403EE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62IVAEQ0gnKi for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14C3240385
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791566515;
 b=LUyYiyDt+TvRY33oQQoidWnz5297IDeH/lGT6cJ94ThYB2USSD5tF9bid08HZbCSX7k1
 oZkOCVIoC9idFIfVc3A8q4EDy+s+/TYSZOuln6QxVbFsimcz1Yuj0ki1XZ9mAnLFPC5b4
 zct0KCoV7K1aIzf6B1OT4In4SqgV5Atu1QHhWr1l255hkwplXr9QemL9QMTS3WsGN15pe
 9bmr3tvCdVpiUc9/GY0Mj98OGu9AT2lPOBjhXSuK/U0gTCXv0wqROPf/u64IChtuRr533
 e7wFwbYc2S7G2/FBO6Q4vVQ4ix/czXzsRiA8TsEoDrilMY9ctwjH4jB2eqoVa8FgnQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791566515;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=sc1vj48Nl3+ExIvAtDx8EeoFcnddA16ogYElGAQNEg0=;
 b=A40xwYsKdXRi8xGUOvutZAh2J/0H1vpJwOUSv9Hmcc+KZbAGGmrcO7KkZEzqaZybUXv/
 RNxL1Jcs8b3mqG9gwaGbExfC/M/Ft7AlQ/eI/Hf/7v4cWZ6NrBBTpUgBh/igl6rMJv83U
 C9KXY1Awaw5Sm9mArxQvZXOi+fZFQVEloejLJTHOnju559mVlw7Jl4L8trGGdH93x75Me
 KBmWOsbpSIgzs7WNewWt/QtPCVFY7Ql8Mux88AputFkmwhXcNDs1MxjVaQ2ih2eyGQKzy
 n8EsBvzimK+I/61BmwU5K+pmyIE2nlmuOoVAcHic58osKAajZxkzGNeeMARZqkbKafQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ElKPnZTJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::5;
 helo=mail-oo2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ElKPnZTJ
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14C3240385
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:21:54 +0000 (UTC)
Received: by mail-oo2-x05.google.com with SMTP id
 006d021491bc7-6df36d0b4e1so27588eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791566513; x=1792171313;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sc1vj48Nl3+ExIvAtDx8EeoFcnddA16ogYElGAQNEg0=;
 b=ElKPnZTJFZB/scPiM8sabhIsDshG/i5sQp8hzRqju31AzyKm1Qhzzr0+YoPtRdOiS0
 d6xmmKouUr53kuVIx1HKa57Z+0fNanKclxztwO76/WP5BGJIBGW4pqtjok15MkXgAeBw
 yNWuhRvPT9H8ryl+/gWvgV62JRj90gsurNaSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566513; x=1792171313;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sc1vj48Nl3+ExIvAtDx8EeoFcnddA16ogYElGAQNEg0=;
 b=BXMJZyqauyn41w86TnUcaHHgGzDDs6v8JkC8+kgPdFRPiFJRk+f6EYpSZku4QjkWBn
 dvVFabhYjS7Nzpx1OyaUjMb3OsbvyPqw8io7ngkNIyiMULUF6DLqG4krfxeEIPY1kjga
 hvUfHsK/fu9q67Uu/BSBBHdjFMo+lRt1L221VH+q/yiFJP6f9W6VWyIaDYcm9B7Q1ifM
 2Fe/VkqSNzBQVKzB2ZgpydGctut2ousoVzsfXiX9Ps1xxhxaEqGEsdUlo1nPiu7ZNQdX
 sb/W7Dp8q8+3Q/lfk9y7ZNoALBW5I3M1KxItOtHDFzm7zYaKF5BoDR3PG1QgKR+6oUG5
 VLVw==
X-Gm-Message-State: AFuF++m4WP1/As4uuTtGLFR6DDEtTeX1Bma7uIDU67AH9ox15zovJGW2
 vnWW+4zzX92TZJuXYiZnNKJ4pp0zSprr3yxafwNCqIaveod8WJb5OCCnYOj1rA8clyuRnYKNmFY
 LycfUq3C7AYQwWWs=
X-Gm-Gg: AYBFou25oDcWEfjwNlouZGny77LeHiS/fHpSmD/9zUttEJp17g4ggDf1vuUIAFsj80P
 1B70zngq1JP+tZ3qoUTHllxOoZ/WA43Q43jGMnssR2wO3XnjSeE2sQo69daFixvh2YpR3/BE3rq
 YlFiNYqxUCXmsefTBmyi2Sk/Sy6QK+XW5QA4WL0eE/UV4eKMGvKSRlXXi8YfrpjARiLz34qEXHy
 IGOR67FrMLWaSY1MrK6bNGgerrR5Nshv00NsMXmuFWHqEef/zx/uV+DVWsh2TBNa3KoyztUd1u/
 5zoxoI9pR8G6SQnLpoUh+H75m1Hx+jsRHO5P28LJ0+ET9TKhovwC8qPipqI2SdPrhmRsn36pTyZ
 T0CV5UYsoP6tK04gRrr3en1I783fcaMoU1BIcNzz3rl8r2CrN7J1lKXdvch0GImyTfGV5RYtZ7z
 ej9Ilr2E8M8PCMgVwFqbmd9uKYOyncCX63THs1IWLJaxhqOovN29nUq6x26RJ0wnoO9817GGMe8
 koyj6uvQyNDVKhl/cfpMH1RlEOzIhG0gDIPEWe3j9K2YnkO/Y2S4lNGUty7ttVQ8RZuvc/hZ/GG
 CSVK3030QfaNhE3Ucmc=
X-Received: by 2002:a05:6820:98a:b0:6e2:4cc3:b142 with SMTP id
 006d021491bc7-6ef0d333ac8mr1796858eaf.29.1791566513487; 
 Fri, 09 Oct 2026 10:21:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef011ecbedsm2176681eaf.8.2026.10.09.10.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:21:52 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:21:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
Subject: Re: Please pull net-next-20261009
Message-ID: <20261009172150.GD769217@bill-the-cat>
References: <00ae9774-169c-45a4-bbdd-89665bd45515@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XWdnz/IWdW/AelBY"
Content-Disposition: inline
In-Reply-To: <00ae9774-169c-45a4-bbdd-89665bd45515@arm.com>
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


--XWdnz/IWdW/AelBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 07:16:12PM +0200, Jerome Forissier wrote:
> Hi Tom,
>=20
> The following changes since commit ed869863c7e2aca50d57a05d843830dd843138=
c4:
>=20
>   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.=
org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/n=
et-next-20261009
>=20
> for you to fetch changes up to b6aeb2b880fe96b51ece8909cf37a73a7927c4b3:
>=20
>   net: eth-phy: Add reset control support (2026-10-09 18:22:34 +0200)
>=20
> *** Please note ***
>=20
> Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a build
> error detected by CI that would otherwise be caused by "net: e1000: use a=
ll
> RX descriptors". I did NOT send that one out for review to avoid delaying
> this pull request, but if you'd like me to do otherwise just let me know.
>=20
> Similarly, the test added by "test: net: cover lwIP DHCP autoload handoff"
> initally failed CI and I incorporated my own fix (see the commit
> description).
>=20
> *** End note ***

This is fine. Can you re-send the PR however? Giving this to b4 says:
Looking at: Please pull net-next-20261009
ERROR: commit-id mismatch between pull request and remote
       msg=3Db6aeb2b880fe96b51ece8909cf37a73a7927c4b3, remote=3D28ddd369e2f=
7199539cdefe22ce014c592b890bd

--=20
Tom

--XWdnz/IWdW/AelBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaskipwAKCRAr4qD1Cr/k
CnS3AQDJV0J1hbe6RU8xuCxyZ5GXzvI+FzszBcADnX7vwIbqbwD/Qm8mlNEBhNqE
CEd5z4FcJv9gsrFTV7eErHpNnND6OgM=
=WSii
-----END PGP SIGNATURE-----

--XWdnz/IWdW/AelBY--
