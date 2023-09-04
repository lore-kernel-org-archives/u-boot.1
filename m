Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86BEC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6718698D;
	Mon,  4 Sep 2023 17:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iKMQapVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0248698F; Mon,  4 Sep 2023 17:27:10 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C6A86960
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58fae4a5285so14945907b3.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693841226; x=1694446026; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MZsp4RbIT7a/ij1RUcYOKo/3fer/HLkMkwK6CQg5+S8=;
 b=iKMQapVrpfSyGs2OXvbrmftn7qSkLd5znlvlVys4S/MuVByeRvX4LNojA06F5D/8Pe
 bFBBn4y0hGb3XjXoWvR2iBi29mOcn8sScn4Do9Q3qatHVMFXBk7IdlbKcju+A1489i2e
 BEBSYr5KzFBruS3mnAnMJPThRXt4fmk1ggBxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693841226; x=1694446026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZsp4RbIT7a/ij1RUcYOKo/3fer/HLkMkwK6CQg5+S8=;
 b=Q6F2xByCl9DM7mUpAhzvCQ3AGPxdPFqVidYxl5dIs/yQIWfwBJQ27VnVAtvq6moHFm
 ib80zlGGn83VTrTxUBYjbWWhJpWQlulxkjTE0tumscnSXVj88jsm2L6eYvTH9Gkv2ujQ
 G5IKgs5aWV0XaATd5zF9iC2CWBTGTAFMSreg0ZzfWXbiqwe5Gp0o+Qmpim1ejQ6pDPke
 pLtkOHhx599oRFjxkVrC35xpn6dY0pdqa4pXks9Y9m0UQtM557nnm/s4Uwg8/Hmr0V5P
 mBWlxn2K7+jl+eJCW1/5JUgpNPPQP3OmOT+GZJ3tdx/gP+CuRWqKyYOzCi/Pa7+NwQUj
 TzVw==
X-Gm-Message-State: AOJu0Yw33KUb+3gKbIJvB3Jw/h52ChknWpiQRf/0JWcvTSocb7IqdfoA
 QdpiPYX8V1DeTyxPTz0vdV+8SD30tovYD1lMgYNfYA==
X-Google-Smtp-Source: AGHT+IExUsGfFpYp4KLES7GDRHacTph6nJJKUkdCnZ1bONztNbwOz0QvzPQfN+//D11C2cWwA8Dx/g==
X-Received: by 2002:a05:690c:288a:b0:598:48bb:37 with SMTP id
 ee10-20020a05690c288a00b0059848bb0037mr8131222ywb.24.1693841225876; 
 Mon, 04 Sep 2023 08:27:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 i145-20020a819197000000b00570599de9a5sm2695498ywg.88.2023.09.04.08.27.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:27:04 -0700 (PDT)
Date: Mon, 4 Sep 2023 11:27:02 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] event.h: Documented some newly added portions better
Message-ID: <20230904152702.GE3101304@bill-the-cat>
References: <20230904152120.634858-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hsn3lVmjxViNlqW+"
Content-Disposition: inline
In-Reply-To: <20230904152120.634858-1-trini@konsulko.com>
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


--Hsn3lVmjxViNlqW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 11:21:20AM -0400, Tom Rini wrote:

> After the merge of v2023.10-rc4 to next include/event.h needs to be
> fully documented in order for documentation builds to complete.  Rewords
> two of the event_t descriptions to be docbook style and better match the
> rest of this enum.  Fix two typos (flag->flags) in other comments.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Hsn3lVmjxViNlqW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT190MACgkQFHw5/5Y0
tyw7Vgv/eC+a5K0Lq94iIujFqb/D6id4z8bj8D8l/soS86Xl1W0DT4N7Fv1rcPLc
aZTSGWVTuKcWjzR4i8hz8LiFapmn6YusgphGHOPNSCPulS/31+sJr9H9WTTr4ut0
U7tvjN/zu9k2pLQbclnB5mCEYj+wks4VMXwgJc9if117W8UHdNukKHo/won2ZghO
K9Hy/Cr6LIen17FvbWqDfxtXbNLEVx23CbxwtXh+N7uPU/xm9eLjt09R0ZNvpK8u
ZPplO/coMUCz7iObiYH1jt8BwnfoAwHe92xb5KucqX1UvItqwrcU3wZZhdQgZril
uK1A9v1EzmW+/S67pcoBxuUpJsWOCBjVpCxMrru3Ni6smJqOxWQHwPbr9R3YqsMt
3DBS0yCEVW+cg2wTsICaXE6G++qVY5DjUuZa4mKElJEaoO5Hn+uBJ1nt3Q0+7JRc
Kg90JqSw1BagwB9DYPDvdNrQtCLXyxWq5W6R8uWnDgb5yPdniLBluUPVnbq80OMT
I89BRa/1
=v71Q
-----END PGP SIGNATURE-----

--Hsn3lVmjxViNlqW+--
