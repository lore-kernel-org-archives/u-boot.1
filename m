Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B607AC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 453A180D92;
	Fri, 14 Aug 2026 18:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNM1Y9_C2Qgg; Fri, 14 Aug 2026 18:16:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7428E812E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786731398;
	bh=pe5BzRPhIie3V+kHN/m6n2tgG/ALuk/jz66gDRhypOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SBr0TMhY7sr6gqAACqlSCnFTg0CGVzOGX4X4C29eJbZwlD3smXZx63Fl0TskDZb2f
	 X56FEvIxolJI+4kUbNqOSIFpiqsC5I2iSpk2qlkUDQsxjtCabNFPcNEVsXAuEFV+t0
	 aRjD4bB0tqtpvK12eOOBaGHqBf5jKhck7ellvBlox8YP4Iy5yqchkSaZIfT09Pn2x+
	 +Rq1sTwLT5xykETNe/2n7FL3jdWzeobV1E6PF+lbynSA+LDHESU+Ey7UuWSBN4gJ27
	 JK7kkTN3ZPhSZUgUAnaHWKRZpdjGrgZ4s5FRSfiPUV4LO+EW2qqhjEdIBoVO+umUuu
	 Sr+EhzfGf1xvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7428E812E8;
	Fri, 14 Aug 2026 18:16:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EB1A3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8C30812E8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jEoUYDzMSasa for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:16:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2E8B280D92
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E8B280D92
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hdJf5/zV
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E8B280D92
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:16:35 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso684112a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786731395; x=1787336195;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pe5BzRPhIie3V+kHN/m6n2tgG/ALuk/jz66gDRhypOE=;
 b=hdJf5/zVy04g29w+UD799SbiLi1bR0sUwrh9EnyucFuPvRir9ChXAz1d1i3DbxxlVV
 E6uISqgkZYtBhobRtLMyEBkj18tKTOlf2EwYU6S4quEAYcStXLsS3t8UoabNNWcmo+as
 F0ZqkPoQHUg4MDKV//b7s/H2U/9Eu6LQF2QEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786731395; x=1787336195;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pe5BzRPhIie3V+kHN/m6n2tgG/ALuk/jz66gDRhypOE=;
 b=j/11GXE4T+f6SkocSmmJ1e1K6pmtmPR1ij8HQxRg5SI/aPHtFJgSbLHMJQxr690FLx
 QWpllGQFm435cESOI7tPrEYs+rzh2i4axe6AdoqxpkrC3r01z7Gdv9lnSzAZ8kMmWUm3
 z9Zk+ncvOAx9Sv+Cvo+lK6Z84KPiNQoPBcJonwB89ZLntvM0QdXC/yu8x6YvOCbgZ5+E
 pDwxgF6TPzQcy9T5iD9qkGyCo2ag9bm40msYrZDMitB5nrFqP1G3NZS4zlJPVBnbmGZD
 KGVyc6RTAb5GmPYfeF69bLtMCHRg1rbfw6lsGw0VRKEwiZb24h9oz3enrgiXBoZ7gKKy
 vj8w==
X-Gm-Message-State: AOJu0Yz1m/Po01gBkHC+MUXVG3S9TB6lOVvoAGqGGikCYpv9j73dp22m
 J4WW+0cFfgMIoNA345yAOtjDcMmsFQ+AGQq7+0fyHr+IsuVojcH8r6d/ZBsGNf5+DNo=
X-Gm-Gg: AR+sD10grQUi11lEz5479uM6cEqTHQi4QqmBejJxU2f4ic3nOMpmmeboSaLIZ9/T9la
 QLmwJpF+1AXdSOeNFg8FA643KdbLZLsgUxeKCkoQCPWYkjrxn5rlDGs+Q284Yg9tC9I3EPvqQpd
 l51UZ8Hhc5WGFC7Hk2fk6r5eghqf4qCgGw87XAGBE8EV6mlxOgkOHSAIHf5CeZtp8HzTQNBRUTs
 Qm/CqB8c4SRL+/UEM5mjSlAtkCbfmLAxhIMSxIQowEMR9QpP8wRUL00W3DG9AnSU00xseO99Cuk
 mMF5287teQ5597xBj4gn2m40kCtLPo6U1h4ewUaubwVAWaRAmZvKN4/6Txw3/LXFPq0QjVL8pVc
 fF+2Sg1sQuNu3Qjau9WA3BeYC60kTIwxYx7K+cWuCNL8Rn5p1ECyKq7P5nQcSkhPTdOW/IDwv+D
 LePRf+jcNVrO6qCU4LglSobBt621BuFvUwcbTriCHtGjQPBy7/9MhtbRkqQiJtqxVWhvpYIOPjH
 KAmLBqCwtT4k8UlUsCX98mz+u9ymGAw+SBcmSm08fqbmaZQ2SbSuriljMjgMEmpX/yH4UVxGUUs
 OtatUCeKCA==
X-Received: by 2002:a05:6830:349e:b0:7e9:cce4:803b with SMTP id
 46e09a7af769-7f3de49bb3amr6795755a34.8.1786731394982; 
 Fri, 14 Aug 2026 11:16:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8668831sm1484381a34.22.2026.08.14.11.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:16:34 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:16:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH v2 2/2] test: cmd: add a test for bootd
Message-ID: <20260814181632.GA3874174@bill-the-cat>
References: <20260806133724.336755-1-mehmet.fide@gmail.com>
 <20260806133724.336755-3-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9schj2nDaHz6q5Vx"
Content-Disposition: inline
In-Reply-To: <20260806133724.336755-3-mehmet.fide@gmail.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--9schj2nDaHz6q5Vx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2026 at 03:37:24PM +0200, Mehmet Fide wrote:

> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>=20
> There is no test for the bootd command. Add one to the cmd suite that
> covers the documented behaviour: bootd and its "boot" alias run the
> command held in the bootcmd environment variable, and the return value of
> bootd is the one of that command. Also assert the recursion guard in
> cmd_process(), which is part of the code bootd carries.
>=20
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
>  test/cmd/Makefile |  1 +
>  test/cmd/bootd.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 test/cmd/bootd.c

This causes most of CI to fail with:

=3D> ut cmd cmd_bootd_test
Test: cmd_bootd_test: bootd.c
hello bootd
hello bootd
Unknown command 'no_such_command' - try 'help' !

--=20
Tom

--9schj2nDaHz6q5Vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCan9bfAAKCRAr4qD1Cr/k
CmCzAQC7apOjgtU8hN8AIG56CNAxspZLTWbf9xL4QQx++zHrCgEA9QMbQvv7w8Oh
1RcnQWk2u8/IlV6/okExQODjjRlqwAY=
=GwY/
-----END PGP SIGNATURE-----

--9schj2nDaHz6q5Vx--
