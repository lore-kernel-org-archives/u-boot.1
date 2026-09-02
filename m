Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62592C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 16:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F61160835;
	Wed,  2 Sep 2026 16:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYkOL72V_C32; Wed,  2 Sep 2026 16:25:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788366309;
	bh=6XToc7vp1g/VvTtO49YMUoGE9DS6mJsh1VsCCBpKKAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQ/LiHGJBh82guawGC46GaWtx+OBgMqAGLE5OiTaMbdyN/0lPLms6J18gbW3HgHIZ
	 AhN1MhMgHqWGqfbsFzVNVJccwaxIA8A038268+63ZnC0dm/xpdsO85fCBrutOvmSfQ
	 ptjF3O2D6awhYFFT2VBH6WTzVqAJetevl+8iB6x4gLx5KJhUxoIVPaCQqx+MD59ljf
	 zMKT9QyenVTzkv5f5xNCkUyOI7YCP5KmPzDjwlj7qLzas+BmjPJoXkXyjX1GKpxMb3
	 Qto5nNNn+nb9Y1xrXy/7VUVWPBX/OVH64ge5VtRt1B3m4l/WgXWBusGSy2VYW4vsxk
	 yG8SY0zj3KT6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64F41606F5;
	Wed,  2 Sep 2026 16:25:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A6EF2B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87A634080B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TNytcTjT33t for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 16:25:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dNcQFRAh
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D94E5407F9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:25:04 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7f4f824de5dso612192a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788366303; x=1788971103;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6XToc7vp1g/VvTtO49YMUoGE9DS6mJsh1VsCCBpKKAA=;
 b=dNcQFRAhzXDQQl+xl/RbARwsE9mmj9saNbgOfv1BSUB7mD6NVuwWpakk9tRO03WBFt
 OjegjERAZb22CPl38D2f4MC+WL3gyiQh6wxYwfdHn17Tj1MdqtOEcgufWkHlUO8dLPeQ
 TuxNREh6WIUgsM3hyfgCgKYFZFIqhhUVm/7v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366303; x=1788971103;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6XToc7vp1g/VvTtO49YMUoGE9DS6mJsh1VsCCBpKKAA=;
 b=JZ/rizEzDy3++kUxFMLZ4UCqZoiNesfj7quFbnyyJr5+srKvbo4WkQHAb0+MY/Wo45
 +D9wyD+N6jKKkbFYoor27G+/f1RtchKiRM4xAAF8iGTUMobhgSiIUJg+bn3auYmuRVBt
 lZOvQSw1MulrVzRl6W4HyzaYkr/3izyz3QanWyavbUaEbVDP68V2ggAqK01PMLxGQiLG
 Y+WV4uplAQE9F4ZegSQmHRcq+TlcVzFOIzT4+KaG2AkWDn+wv7H4MZkp+9gR9PMKx6Pk
 +JBNrNslX0ImkRKH5NoQ+WIaXkTaJtdyb4coyZtVQNQXN8ysf4zAuSj9jClsgvn8rquM
 8hMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou7NWBQnFTzEuDJuGTNF69tYUf8wZ3zXZAkJXcS5IckKh2v0WrP348aC288fAmSn47qGMSeMY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kID5+ZQeI3nDGUVlAqE+LS5fZse5nbHEKTOyQdRO7Ofz4BaiMJ
 YONb7wliDSVwEhcNR4MrOTPmdRwP+gmOOd4qpvQmxtR1A/+EDV8L9jRaYxQuYb6g2vA=
X-Gm-Gg: AR+sD13GBbgdw6a4DYP49F5ZF9bovHjXBavfCEPVv7NbYevLN868whtqAvXv0hEZyie
 mBNKLQ+teatdHBXhIduZhT8QQ6CvKEoKwR2CrE1vWEbs9mKOYjHRybYBeDncKQsdkExy/PyTVDu
 Rj+U56Orl60ww/qa6PqLvSTLM2kaQEzFqfJL+gtyqxJrBl/aS0Syl5xOoPzrw9cinNZ2u/wnpyo
 TaGRx5aOMH5b6uvpdFsI7Zm6/8aKKSwYSukc61s2K/UZJkL9Y/aJjSJk2SCN3uG9D09Ano0LTsz
 LDuY9rQJbzLr9JcJvuCP9evv9hKeIhzDZEoW2C1ybDgRefy1QQpKOjXvahGFCl6EPptzvpqev+7
 eoIk4DW9ah3EQDdqoluNjmZ1yVSZdglkKmXvIQd6ZS9KrTH9etXePDb4wnxNH38yY7K1Q5lltjn
 96w7SLnPCMplX6riEOgSR0CHejMIbPNhEHsLFgvIyuZwUb+XxCF+t28fJs01iJD6c7cBdkcUpab
 UJ5KInkiGmOlcXqO+Jmz1taUcPufncKZEYovqeu9bE043U54/FOhafqix3gB0GT9cZvnbRhK/a8
 ppHvY8Ac/58=
X-Received: by 2002:a05:6830:3c0a:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7f77c5c7478mr5982057a34.0.1788366303429; 
 Wed, 02 Sep 2026 09:25:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74caacab3sm2562800a34.6.2026.09.02.09.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:25:02 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:24:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 05/16] reset: airoha: Add support for Airoha AN7583
 reset
Message-ID: <20260902162459.GC1764417@bill-the-cat>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
 <20260902085311.1550804-6-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OytJ66LrZDsxht48"
Content-Disposition: inline
In-Reply-To: <20260902085311.1550804-6-mikhail.kshevetskiy@iopsys.eu>
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


--OytJ66LrZDsxht48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 11:53:00AM +0300, Mikhail Kshevetskiy wrote:

> From: Christian Marangi <ansuelsmth@gmail.com>
>=20
> Adapt the Airoha reset driver to support Airoha AN7583 node structure.
> In AN7583 the register is exposed by the parent syscon hence a different
> logic needs to be applied. Also the reset line differ from AN7581 hence
> a dedicated table is needed.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/reset/reset-airoha.c                  | 60 ++++++++++++++++++
>  .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++

Since this binding isn't touching dts/upstream, has it been submitted?

--=20
Tom

--OytJ66LrZDsxht48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaphN2wAKCRAr4qD1Cr/k
ClGlAQDpfBmZL/DE6FiuwBLhd5JGKyu1gmHxN9XfSOUJKyEMVQD/RHzTx1UglxVu
zlG2yGlRxBg9UNkCeKuCQv6usIbIpwk=
=wVic
-----END PGP SIGNATURE-----

--OytJ66LrZDsxht48--
