Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA072C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D76380DC7;
	Thu, 20 Aug 2026 15:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xA9U57cqty49; Thu, 20 Aug 2026 15:10:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787238630;
	bh=zPav01SVtrIgOAE4kOBOlL5TjD8YT+jNEiCrMNb7HgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dcp0/9kS2KE+E64Ja0wsmBDCt+mgaLHTpx+41wqZ8WhnZi4xx5cYmX3Rl5JBftx+Q
	 sHo8CiOMgr9RJ0EqS7xOIQ+6HGi7WfPB+/+tXwzGXK9gj3idneSH1FKByBNlhAH9+1
	 4DXCEgby1Ykzre+BYGe1Rmk6yz91+DkboZUJKfi0NbSlA2+UEAyHXId2+u4ncmd87z
	 oAppS1/mfuDaF7MLaRG8/AiZzcFMJBVfSESCkG3zWf98Okh6SPihHnuljyi2ti59d3
	 CAACeLC0kGWlFRDtjrySPnQir60jp1CtInu7gqPE3kp3tPzWyOwW8p4memTZ7rRK41
	 EBAW3xmH1xRIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D586380DC9;
	Thu, 20 Aug 2026 15:10:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1701A263
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02ED840329
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuy2DVLL2Iu7 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:10:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DPAUkhzz
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 852714031A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:10:26 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4a4836dc117so762615b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787238625; x=1787843425;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zPav01SVtrIgOAE4kOBOlL5TjD8YT+jNEiCrMNb7HgY=;
 b=DPAUkhzzVgxsdmXCrzmtXd4gkUdSoXleDg3dTGuD3eTs5FD+BRPWc4a69ETnt5qHvH
 jTjbOSzCQ3z/+idnzDr3cqlmhyh0XfWlhmQcZ7ZsmhdJ/MmIK74Z0y+MrQrEJmUy9jCl
 mmQOmwxxI9NGNVJIy4KDZpqYaU+S84tCJhpG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787238625; x=1787843425;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zPav01SVtrIgOAE4kOBOlL5TjD8YT+jNEiCrMNb7HgY=;
 b=sdRDrN91MYb4oWCxNH09XZcFNZYvynV/PFFUBWm/VRnp1sdwYN8BrcbqSaVWiInuCF
 ZYf9Po4B9tNsnbvZIpvllN5myy0dNAGo0Hlge7hXDo/NZuvJoy+Zcmwe2fejlUZXpmzp
 93S8g24B99rZD4wdbe7hDHFdlasRt5Tf8hp3CEYqyvuqHyg8r3OUnj5eQJmzHlO9E743
 jucNDIt5ZnaYp3ulaBJ2my9ORg5MigPT/qHmc34RJeLvJN4DpnnH07bvquVC20jq+63e
 fCvespNxkIh6SGbxB3UoiuP+xPn//k3+mDpM5yCokbt9tAuWxR5UwMstV3N37u8xxP1G
 1Tvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3H6n/h07DSuCGqv8T3BZGGZ1jYoMyYmJWGU5nMf3uITfOQdV064AJ6oSWDiNGjnUvPAwJRYg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxapNZokGDQhMIwKjq3D5+0G3PgS3Tz/CvMsB1OfZ5re3muUD6/
 1nP7Jm49HHffTA3m525C7/yMQOggfPlorEHZfVutLUPEhe4sNvlu/lI6xy4UPwd5DBc=
X-Gm-Gg: AR+sD11Lch8XN/uScsUNgHbdLd/+RLIeKopAGmjyNmqRTbJuXuNm66+6LZodrx820/P
 qrnmOYFZDpBZcd67Vip26Rxyt4DXP+q3g9+Y6K216G0Z6YhBj936asG5TAxNM3HVPaEoC4ZzUXi
 UrsSa/NLyDeh3zkFHbb9c4XVLeAp1nCX9tz5Nha5wCuB9kHQxsbb/sPArMqGtyRuMUkmuFL5yJD
 Cw5LOGzFabT6ekpfijOqLQQd9h3Rw08+cyKZKIGUNjvC8E3f3TXJPyW3jJLOHPzO13cIpxDTurq
 0NEoUWdlB+SOcSyWqkF8jfzH+gGDLkrM5oGQd1MXicQsTxwwgsoyxMtc8l/P7aHWmsx0xoAgdCj
 xqCWG8CeQscthTj1Zp3pits2EzZMAnMuEEXb/cdYDUlG7AM+Eq/FRiRldH6pZKRSEhPOsFbcwMo
 AO3ZBzrqngUGuGm78Kvnf81o20sXy9cHC3xFt/OBrcEEc/Ddua4sGfDJFk4t2grZxgTRgBjjno2
 LESyTer263poJdTtjFVyKEfnfu2sCXlkvsB+LfopWO6FKilJh/E+QY4tzp/DygIUzzWvWZKCuvH
 WE6fyIdGKQ==
X-Received: by 2002:a05:6808:6c96:b0:4b2:67f1:11d7 with SMTP id
 5614622812f47-4b2bcb962d1mr11882720b6e.17.1787238625249; 
 Thu, 20 Aug 2026 08:10:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d68509aesm1896093b6e.6.2026.08.20.08.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 08:10:24 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:10:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: valentinliu@icloud.com, u-boot@lists.u-boot-project.org,
 mkorpershoek@kernel.org, igor.opaniuk@gmail.com,
 alchark@flipper.net, quentin.schulz@cherry.de,
 marek.vasut+renesas@mailbox.org, daniel@makrotopia.org, rs@ti.com
Subject: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support
 to bootmeth.
Message-ID: <20260820151021.GI523975@bill-the-cat>
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W4dLkNU0IxZazb1T"
Content-Disposition: inline
In-Reply-To: <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
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


--W4dLkNU0IxZazb1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 06:31:18AM -0600, Simon Glass wrote:
> Hi Valentin,
>=20
> On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote:
> > boot: android: Add Android 13+ bootflow support to bootmeth.
>=20
> Please drop the trailing period and keep the subject under 60 characters.
>=20
> >
> > The devices launching Android 13+ were using a new partition
> > named init_boot to store generic ramdisk.
>=20
> >
> > In the new bootflow, kernel still be stored in boot image,
> > however, the First Stage files in ramdisk were moved to
> > init_boot image. We should load it to memory and verify it
> > so that the kernel can execute init program to continue booting.
> >
> > Currently, we have supported loading the init_boot image by
> > abootimg command, but we still need bring this ability to
> > bootmeth, so that booting Android 13+ will be more easily.
>=20
> Please use present/imperative tense throughout: 'were using' -> 'use',
> 'kernel still be stored' -> 'the kernel is still stored', 'were moved'
> -> 'are moved', 'we still need bring' -> 'we still need to bring',
> 'more easily' -> 'easier'.

We do not have any sort of grammar rules and requirements like that in
the project, please stop giving people feedback like this.

--=20
Tom

--W4dLkNU0IxZazb1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaocY2gAKCRAr4qD1Cr/k
Cln7AP9MDdIjkViv0GFYRFMZqfvn1v6VIh+Kgyxh1hCYXVvEgAEA0kDEv4hj+fJx
7P0dqBrma4KRflTXLXrbldkL/klfegA=
=voH7
-----END PGP SIGNATURE-----

--W4dLkNU0IxZazb1T--
