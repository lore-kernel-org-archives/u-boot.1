Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C61CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 01:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 684E960769;
	Wed,  7 Oct 2026 01:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxvvRNg9KKKp; Wed,  7 Oct 2026 01:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6FCA3606F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791335139;
	b=SrHi2rka4F8ac+2W48Pm33KREXh/m8J3w0ZEU42Lr4LSkwxIzxtfMBmBMtW5zvF89gWo
	 M0Nz4g4+ztNZEHiUBgpIo81b0DNU5JmLrzJhQMtpmG360t0nHRUxAdGD20XCksCIMG1I2
	 2yz1NOoEbSxYhUo1VzbYgtNmv4v83jY+c049zkSdjtNk/gJdzoSx2gMQ4gvrRW9dH2A6v
	 NsD3XJvXAPsbCV2FUPQoq0ngo960f/MLopSLpjjNplY6eSrVsqWXA6o1AETuyl0XLEzwF
	 iac8ARvTSYYv/B7JVPXbTXadOgm3Hteb2YkbPkO9T7Vu+yu/OOtJSiTh0MiFjCRBeAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791335139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mryQRwRbyDMrirmEvP9f5GN55h+P4WYSjqfo0ZSLN8Y=;
	b=nlyyNaUZ2fnik6S8ghsN2Fg8DVXTmu3TmmoZuImeCvg4bDE/m7tNO2g2Uah6Y1l4wxnx
	 +gM4MZQ34uCyW+0Sm0LungrqsnGechw4mDWd1a0LkughWijGUilPG4VQGurLwsewnFTna
	 MgyttEjgQap6eHMp4VZ/v1AyiQ9myQp/OkjV0ibAM3sInuAA+xIltcmaSj6dL1xe+wbsp
	 2Dc8qc7KoQnnvGc8F2CKmlEGsPVwp/SWwbw2YI+hqm/MIOCsg6BD1sZGDIZ17PrVdf66a
	 5qJXWyNFSKFfcHe/HfzafallqvUhM3PxiXErqlY+oceAGuhCzxtfuZ8KwilgdTKa/6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791335139;
	bh=mryQRwRbyDMrirmEvP9f5GN55h+P4WYSjqfo0ZSLN8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kxUrVOiSpbstUYBO7AO6/p50LLPB2HDHs8XDOzQrqD5zLEiTnjKi5PY5hBWPmTKNy
	 VF5aVGGPfxk/0wN+OVyt7lyAryHFIiqT2OG4n9ZudwafBtDetwLDVurItN0RGr3vOV
	 uFqM4ns1oq/KcZejJKyW65naRrTr1gF2md11NzO7d/1mkhT8Nycg030PWXTbYZaK2Y
	 OR0ZojB7s5a9g854R79QMdKO2N7Wi2CgQbnFOCir6Y/oqmCFtxYXERTtMQllnXKHx4
	 hv2F6BtdV3oWj23PTFbQ9k00NjcbeC/JwydeYam2OEtUL9OglTepsUwiZPMR9AC71y
	 mD4oIc/rguXSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FCA3606F1;
	Wed,  7 Oct 2026 01:05:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B88FF1D2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 01:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A20574060E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 01:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_uXKa5WTgpE for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 01:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 676AD405B5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791335033;
 b=gvgUacD5aaEeqTYn4+ezJz8n1vsfFPVulDpGBwJm6r0ACfCDDhiXLeV0akvlOL8wSKdd
 uewxOomocg60CEBICdPA4Zm3obmRxpgBPfTqoYKa7GOIQA3b/RoOQQpYU4lEEZ9EenM2V
 BWbIJXRYHF1j0R/1aL4vqEoOeiqeUARjuU1bD1n+uuYn0A5zxtByZechsT+2YEvOk5KDT
 5DObdnDB/P5a4+1JzgYGeul4Vv7n6gHov1XBLOpx2TGbV/0IcQzmb2HlXVg2XLoA7CxVU
 doPQAf/eilGOGF4PdF5pRyIVb96+iBqDWoOK4q5WQWABBZLUcHK8rXsP2BEbwYMmfrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791335033;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=mryQRwRbyDMrirmEvP9f5GN55h+P4WYSjqfo0ZSLN8Y=;
 b=RQRlnY6OyrxcE/JdxuXSinmQIavkz8uGHBIPBnBIDcWo0ND7RMmqWaN7a11MY1bxri6p
 7QLwsPRpJ1guuyluJCCfUxaqRYeTUz3laCM38D7P0A7TSNExLBegyJmmyjGgeVvuUoJui
 qJja59XbdVb/a0f7oD85QPIbgrUuTqALWo1fnBCOeNj+7hF9pXhBCnC4tfXcVNJLHPKUS
 f/P3riJqkJencdTxXhfxf2Rxq2g978ATi0tChbHq58Sok2LbuENzvKVMBR6eBNf+LejEs
 mOTwS3Lc3soWbx2n5CjqFNJs5MRVWpFSwM6qxhIePkAt+WZk+Wikb5AK14ClMMO3nWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C7AP8Y13; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C7AP8Y13
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 676AD405B5
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 01:03:52 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f4032704so914592a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 18:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791335031; x=1791939831;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mryQRwRbyDMrirmEvP9f5GN55h+P4WYSjqfo0ZSLN8Y=;
 b=C7AP8Y13SmGzfNxLl/B7oE8zdk7299hpDYDyckOyFl9mABZMJLOdFDem3jGrXJwWHQ
 DoCoulfzDi1/oC1OmB+GSr3tRwl4qV26AqVGtS9dLC4eBwDdNe4KqJYhTgjzDuZ2jPMH
 07J6IA+wIScaXYZb5l58MbCY/TFnBFMuTPBpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791335031; x=1791939831;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mryQRwRbyDMrirmEvP9f5GN55h+P4WYSjqfo0ZSLN8Y=;
 b=FcqvH6A9t4wX4PogiRuju0dzoZBkoF5K3D5VyG4zrUdRCHVQwjrLeWKmu04PwcgKe/
 eRVrF+4Y7rBAd9fM8VsWEM5TgxvFewO7RNgSwIUzUmnJ1tT8AD9Iy74ZXHeMuq5fMzW0
 f3HN/108bOJDc/49hVdfgMrTzilnsOj1xRUdS0SqWJRBLWeo6rKnduF7S6s/mq1Grfpi
 76Ax4l6xo9+5MoZiJDW69diMPO4XWrKbP+/QAeHCNGW3EkgClztBPu41CzvFac6HAlBT
 JeEQNA/m4C92B9xS+WWkTzyWVi7cyK80M8USbYCxAue8yLz+YKYhcltg894W21zAeWBY
 vZsw==
X-Gm-Message-State: AFuF++mfVwrhuv+7YY50fvPq0YW/u6S+nRI/xVlZIjNtddB34er2HAG/
 an3+5vWbK2UicYWfgR67SPfODqtcI77Msj0gCgEz7KftNG2HdtfjSvB+1rmH3NCG8j8=
X-Gm-Gg: AYBFou3i7KvaCaW8dGhDqQGDKMVGL9902K6ue/IadWbXSHxwr/Waq4kBgEiJAYXuYL8
 H4SyI6fYAvAN2xUWGiI3jt4x1YGdsNz5aN6JkCDi6YRqDXV2JpgQcwO+LNOIM36Zheb6YZtfj9b
 /PqOz5uzr7LbS9YhiyQlXm5CvT+b0Kvyv7lmF/g29PegWiVzkuMKbcCmNxkWrg4oTzUPTftGvfe
 001bJZd8RyO3GpUMWpA4ZdaoSxnSV2Hfj/RM4HYYPeUX3EmJUYKDofb3K2Ykjp8z+9zIe+tPulq
 5sOeOD9HD2v3lmtWQJV04/DdFni5+AkT08wublR52nTK0kfrV+VtFmE4WLHljX49TesFw+HTAQB
 r78Ut0H5ZwAiOoq9+JPDbmAXciQKy1lI6eEMNcgTtqFVsU0uvRD0b9x9alPXGxq3taMtbnc0pU3
 YfEE+1fV/WGxgqNOulo/t4sGqb0mGq2AaFrjopaHgrq3C7Nd+uJS1pCjGG+j2HvHnXMbU/J8nGR
 nKjAkPdUSg0ti14lEJHHspaYIqXZAehsyz0HNQzW8/b9nIP8U3luyeOOBnb6Ib4f76rUuz8WRMG
 w7JssZU7F7VgtfzefRk=
X-Received: by 2002:a05:6830:388e:b0:829:8a9b:de5d with SMTP id
 46e09a7af769-82acf292660mr1183767a34.9.1791335031466; 
 Tue, 06 Oct 2026 18:03:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82adc80d2b7sm1264426a34.21.2026.10.06.18.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:03:50 -0700 (PDT)
Date: Tue, 6 Oct 2026 19:03:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261007010348.GA2100789@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CMHjQDWAA/1yMZl8"
Content-Disposition: inline
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
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


--CMHjQDWAA/1yMZl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 01:49:27PM +0200, Ludwig Nussel wrote:

> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:
>   - make signatures work with QEMU. QEMU brings it's own device tree at
>     a memory address. U-Boot expects public keys in it's own DT though.
>     So merge both.
>   - (optionally) enforce signatures so we can't accidentally boot
>     unsigned fit images. Quite an easy oversight, esp when qemu
>     previously didn't even use the built in DT.
>   - make iminfo verify configuration signatures, not just image hashes
>=20
> - Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
>   incompatible with the intent of the qemu DT merging feature, ie merge
>   built-in signature nodes into qemu's DT. To be sorted out at some
>   point.

So this leads to a CI failure:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/106655
and I wonder if the merge of the device trees goes wrong, or does
something unexpected, is why this test now fails?

--=20
Tom

--CMHjQDWAA/1yMZl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasWacQAKCRAr4qD1Cr/k
Ckc4AP9O7VQVLwc0lTyLOtbYJY0MgjQ8AUHyCrObI6Jdhsnv8QD8CxPEmujreePe
/cNa52w1+zngqw+CmWKx25i7g2v0/gE=
=Ht62
-----END PGP SIGNATURE-----

--CMHjQDWAA/1yMZl8--
