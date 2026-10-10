Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6930FCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 14:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09E8E4098C;
	Sat, 10 Oct 2026 14:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXisWOzLnnTa; Sat, 10 Oct 2026 14:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2204D4097A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791642572;
	b=TvvjRNQA/10dgIh3MW0ulYoR/MdxIGdxIqG856hXSYql+kdfSszISP1f2QcA0tTtU+/8
	 5YtKrSRv9UwCk1N065P/uURUKxKSMW9GwPTrryrQzAwZMi+7xzO46b9zmqf1869LpTxy+
	 f+iNC4A4DJFhAQV50uus+R5hyDrBwSZ7a5Y5zQBln76QysSXzoAv9O6/6lwqnWJKrvFsO
	 BVYlpjTqtDdKEdAf6/C2kA837dLrMkM848lL2d7uSVQENg9FSrTKG/GItvSPtQf617px4
	 5FbjzC4Ti1UNsIEZ5WdtCJkGD0876Jzc5bCM2ZKwStqEHEopTDITOqQ5Jp2NMD9ucSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791642572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rhG5ExyuVGSemzXp62yoAlhXfrFceN8+tT616ryOX9w=;
	b=r0c+lZnZx14VcIjavpgR0b2xHm0uYyD9NHa0aYAlfBa1ZSbVjfAgrKFkyF3kHCmWbZlq
	 Pvwv0JnWHrOEtTY388I3g3AIhFAItJT6G5UV3elwJ4P+9+84dNyZRAgaNxbZvVEP1sdEU
	 TpGmQpcjwfSy7TC0KjeerHyP/uKy22xN4AjNbIU5Zc+l/VBC6adneYMYK10wyhhkSVECZ
	 zXAtG/MMkkGig4Aduio0ziVJutSr0vX2Hn7ChgXWAfvEA07HlGaNFaCBznR1Cuq7iymZT
	 UQ3sO2TYEKx+s986rC1OpOyThyskYWSBzxbQoRkM8/IQGTxKOOF4cMdsTww6hbNy2Iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791642572;
	bh=rhG5ExyuVGSemzXp62yoAlhXfrFceN8+tT616ryOX9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHBuQkPWMoNzJDqr6UbAurdX0wCGgGkJiaxV1VlawPij+QmBmrG/sjnR5lkuBI3LZ
	 wj1wGtImb0vNVuV/9pA/2DRzfQPOTj4FP+jM2zH3Bi6TrxebLlfHuEeWQmNxFDl+/X
	 ojb8QHDmdXsodjFUPf3QIg8qw+ViCJYSEhCCr26Aq476wgzvB0dmGEnvFJfZT8ZOaD
	 jZz2C8fAx3p/+GRcCG0/NgI3ITWvXSX9JidFJkIRCuKGurfKPaMy3U8sFGfRycL+pN
	 fYZ9BtuVugtM8nWT9kFdzJzuf2f0btzAwXSdJOlKDDVlxtzQwSFhcb4YCJcExx7flk
	 cNUg/ADwphaLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2204D4097A;
	Sat, 10 Oct 2026 14:29:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E22A105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 532DA40071
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9iNHtMZY_2Sj for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:29:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E80AC40004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791642567;
 b=r+bKTXU/dKnK8Jof2BvKRgMWt9H6+lC1aGdmaUGZqbmth8IJ4ENYE2tOJ5mpOBJCUhnn
 bOviBL5RBXPM4n89+BA4GDDa548hzEOHEj2HeprknREPyCppYX+rwOf7sGVFkCOwI59C5
 cnXsFnn+C4v6NRJeT10Jc8MS06D0iuqOW+FsVtgJ8+IEFFzIgO2SUD7vyiOFnzl6k7ggs
 bjPWdE5mO/YWP5SwM3x74S+5ROWmWhW2fmQNEnGS8s5WJzVWEZqvaKq6PRIrUPvlj//9S
 kNVqgBPKrvpU105J0idfJkGq1WmBmhwelFrxAENz/E5E3jzMwfDUp7TT4HwVlB+i45Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791642567;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=rhG5ExyuVGSemzXp62yoAlhXfrFceN8+tT616ryOX9w=;
 b=N+SmYM34Q+HcY7G8WHZbBYUMCc2X0+kXpiH1nkFtRMJyD9s5aERSEqjY9/RIQDzvogjn
 8h50/UDfO5Vh5gTnBAU51+DagCBWHXpSEKvruxFlu47sewjH62FRONdCPnIBhH+gbPx/E
 VbUjy4ut1iOkJLYU7OTzZMRjw4BRPiBA4Y3USQCZfzl+5xnuVQCpmYypVDXuCWHXrd5ox
 EMTkW2wO+a07tvUyGOt1Y6KXMeCRte6C6A8U3hrWQp5l1LX18adkW4UxbX0faz2CQFvsC
 qefit1s6bw21494qhz/5lILvcKDvPZYtW/XBJEiJOuCRGCnaQZGITDqdgPtPkPRaEOg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kbh+HaOc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::b;
 helo=mail-oa2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kbh+HaOc
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E80AC40004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:29:26 +0000 (UTC)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-49e404f72f2so213122fac.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791642565; x=1792247365;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rhG5ExyuVGSemzXp62yoAlhXfrFceN8+tT616ryOX9w=;
 b=kbh+HaOcddLF46bdnwbhpAngSdjLdXyespJ611Rh/o1loSCnH0R0UCOHGXNAKEehje
 u7Vv4y9T/+O8JV9PR5IzzupHQMnOcJA09ccWyYKw4zlO5ZORQ+JHdLNsMCYezPujUeg/
 K7SPyPEsQ2T4T0+UNWh3EmDCc3aEt3Cr4knfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791642565; x=1792247365;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rhG5ExyuVGSemzXp62yoAlhXfrFceN8+tT616ryOX9w=;
 b=RkfmfBSnpBH+otKjGC628oEjQ3dgZ1xPTCo5dv/JCwXCyiB2iMLPiaG6icQA+RUfjW
 YYNH4z5ozaIZHiMvPoFTuPmQIRtC4u5J71BNygyAm4PJm5IKzIefvKrx36JrncwYM0HD
 adpVLk/JFFvsL5/prFJIcrF095ryJA4pvhNpvpQOwaHyVxHq/S4oGojUkDO7ulRa93xO
 qaUwoGuKSoVwswcX29uMrDw/F+WrTiuTgUbaMpmtdFk6XUd7AeHhtDIQ+m8lwt+5V3OC
 8lo7/mlRkTyyFvmvy0EYNZBjiPFTttXCiN0jjZJiHJz/Rdj1k7bd//dMQDaGBsWevqVq
 t/8A==
X-Gm-Message-State: AFq9FYInHM6mZSi5Ou7aR+10lQuDZOFjElv0mkb03NVkNTS8rYpbTHCk
 /XAqW2VXoRVB/FB4ZduCxTsKKuY2gXQry3pUviLT7Fp5bPU+/CLUJbLfNHYsKMs26sb+HJeGLHw
 k9yJlcFWSmeZnLlc=
X-Gm-Gg: AYBFou2n3FR7VlMyOnvEbNKy1F7LHTPRHGE3kod8oXrD61B9t/2Cv7gmU9XehANd0xB
 7ofWI0LpzDnmyR4Yz7V+RJj9507+QmmaN5HzCn8e8yXT1gF2MneQBChQZY8VugtWL239oql9WRT
 Uat6KeK2+c6EWCpunBPVbU+IWYCBr37+2PqyZpQ1oiTu61PHKc8Jl9loAr9rh7DCudPoEKnuA07
 FXJPxms4EGEaCxvq79sb9BodVM6DW0yfS059s0yHSqstAg0Uo8Bt5A0ON9Ck6+PFTRa3m8he7st
 kcoWNub5lm7ypUAmUzIxlYHGB9U+UZVFUn2tx8GmN2skfpiPhnEDMXvUot9jqPy+vqLLHx1Mk8P
 cxZngdlxhWt1SJC/aFEn8VqfkNxTfxsnhABzBGUF5WLR1tbcDrvctWBAPw669i7EN8Sp+zSuiHT
 zc75E2yIUSTiUatOzurOvOJM9ION9wrv+IEVZf3KccDuqKwehMxqF3GQ7q3x1ViqViAdWN6ie/G
 Ey/769EMbeiIqmMFamZw+nQr7DsKNvw2LD1qYpTgwZa74brCtO2NlJBpkDu5osdsnJ6MCYHg1/1
 IBlYq3hqaMsAThjCA9I=
X-Received: by 2002:a05:6870:c210:b0:498:b423:b137 with SMTP id
 586e51a60fabf-4a2a8a9950dmr3725526fac.41.1791642565444; 
 Sat, 10 Oct 2026 07:29:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8557a12sm3876477fac.8.2026.10.10.07.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 07:29:24 -0700 (PDT)
Date: Sat, 10 Oct 2026 08:29:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: Downloads of latest version and RCs are missing from ftp server
 and mirrors
Message-ID: <20261010142922.GI769217@bill-the-cat>
References: <CLfytip-colyUOPhc3sBqUDEz8ZvN5khfJZr8p_mbfHvbe4fWk4JDYQk6Nj4ZjjD1wDbeFldMUbcI16zcLHK4u_Z6ej6LkT3V8Hq4WIrV7k=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oEGfsMRIbbHK+GQg"
Content-Disposition: inline
In-Reply-To: <CLfytip-colyUOPhc3sBqUDEz8ZvN5khfJZr8p_mbfHvbe4fWk4JDYQk6Nj4ZjjD1wDbeFldMUbcI16zcLHK4u_Z6ej6LkT3V8Hq4WIrV7k=@pm.me>
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


--oEGfsMRIbbHK+GQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 09:07:51AM +0000, Michael Pratt wrote:

> I see where the website directs you for downloads,
> but historically we have used the older mirrors.
> I'm mentioning this just in case you're unaware.
>=20
> https://ftp.denx.de/pub/u-boot only goes up to 2026.07

Yes, we've moved away from denx.de infrastructure. We'll have some
additional mirrors configured and announced soon, in addition to them
being available (still with GPG signatures) on
https://git.u-boot-project.org/, thanks.

--=20
Tom

--oEGfsMRIbbHK+GQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaspLvwAKCRAr4qD1Cr/k
CiwCAQCFXu9W6r46Javzz2DBV2K84CuCrH9kgny5HvLfuN9NigEA0F+WOTn/bWCn
wtNa7UJeqAmvdy+t/LBLoCHyyIVyowk=
=6nRB
-----END PGP SIGNATURE-----

--oEGfsMRIbbHK+GQg--
