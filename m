Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFABDEE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A3B86A26;
	Fri,  8 Sep 2023 15:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0FZHamL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7244286A35; Fri,  8 Sep 2023 15:59:29 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F32A85894
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7260fae148so1945055276.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694181565; x=1694786365; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+koaox5SWqokpQvFp9WRL8n1miyDolUaYm/fmWOXX/Q=;
 b=t0FZHamLi0JsNJpLEK3ym29qE+7PaE+5WtnRLAs0UihpLjYsDpiUq+0PztxFeuOtDn
 5QDZLBVzjGuPSTcZlhHwg5H1FCVo+7ZtEfUtHzEyMM+9evnCSUWjfLO0oA3Xuzwb717b
 +JueezwUXiykI2FvkQCWu0ECYzbStIHal7c4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181565; x=1694786365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+koaox5SWqokpQvFp9WRL8n1miyDolUaYm/fmWOXX/Q=;
 b=HyGireKXsU9bTsQAssRIKdBI2u54i9Hcf4YKCy7CPiRxaPOtR/+P8NExPatDyjPkl7
 QXiXLnsQh0+Ql50gB4CgEqEFYmj3cNSjP9gbHRRNeQA9okXhKau5UYsUkqZ0C/aWSANN
 9YCxYk1h5mhWlsKuetHOl1dpaGNn1J4qwtHqSnCk3HtJjEj7JqTIf5jUUG4ON9J0b8Gd
 o7z0Q6EP27Bmu1MDKMNgN1CvaedFZBXEWDCvI8GlxO65pkUbqh98X6OaNcgxKK9GRtUh
 sUB4DeQcfFOurFTKaUbGN849SwEpVRTf2VUirCYRw7LVALLuW3cGtQVCvjlxCs3uG7Bb
 LdfA==
X-Gm-Message-State: AOJu0Yxb5+ZkOIjgzK5xgljWkQ4ne4DVlDjNsUz3m9LGlGrfbZnzAaIW
 BU51wV7vkoTrqVP/drxSZrKjbQ==
X-Google-Smtp-Source: AGHT+IEVEvgr+/vcKHAmIw1uF+KlR5lsTm2X3asMYGU/TNPeo8tdw8Wmx0KDUKztnXDi0mZE7kOrmw==
X-Received: by 2002:a25:3716:0:b0:d78:40da:3b25 with SMTP id
 e22-20020a253716000000b00d7840da3b25mr2191521yba.47.1694181565095; 
 Fri, 08 Sep 2023 06:59:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 j62-20020a252341000000b00d1b86efc0ffsm381336ybj.6.2023.09.08.06.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:59:24 -0700 (PDT)
Date: Fri, 8 Sep 2023 09:59:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
Message-ID: <20230908135922.GC305624@bill-the-cat>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qI0C3RYnzGbPtQwf"
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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


--qI0C3RYnzGbPtQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 07:53:05PM +0600, Maxim Uvarov wrote:

> Before apply these patches it  is needed to create lwIP merge into U-Boot:
> git subtree add --prefix net/lwip/lwip-external https://git.savannah.nong=
nu.org/git/lwip.git master --squash
> or
> create git submodule, depends how it's more easy to maintain external
> library.

So, I think we're going to go with subtree.  Please work out how to
integrate the above in to the build process automatically (and such that
we can maintain it via upgrades moving forward).

--=20
Tom

--qI0C3RYnzGbPtQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7KLQACgkQFHw5/5Y0
tyyicwv8DME2BvZR3p4edO0UWEb7E2Yld/bQ1TZpsnIakAMOhgkfxzKg8BoCe1pP
9f31XfBuSfccfK3Iyz83KrmCz7bL2UcCPimNxCYUsQBuOb2Ka+q+e2jdKGOtAf7B
HnCH/A/G0FA2MNoG6gDLhbvl2OJrg1FSof1FtNxau5Lv9Y8IKrSKkNKvECk59Myk
qcCC9DgQHIdKsVHj3QbpAqrIxJAu3BWoNPU7CH2hgkbYRsPxe0f54iSQH7ioZ+pB
w0mAKXteEBt7SY2Ny+o4Nd/JCVLRqba4gmCHHZQ1P9Cy+CtNs7F6BVfzglt7sIke
eGkD3FiAzV+TEeGdrBZ0TbwX2wll/UzhN+jUYz6anrKlUnBejN95870OXnqVAyQP
usDSRK5RIqKOqLxTvqI6ldpgznDLL4s7vmiXXc0HLtrz9egjJYPhZgzZyRAbyqDs
9aUdx/P/ZnjJCj/ERy4baPdhg/bjdSc6/qf3Po+YQex5OrDP3ohp29oBGuTj3Bvk
XZiIXJYu
=QZ6A
-----END PGP SIGNATURE-----

--qI0C3RYnzGbPtQwf--
