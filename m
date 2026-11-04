Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFB606C599
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CpU52qSo;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=t/J2RyW1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 694C9408F3;
	Wed,  4 Nov 2026 21:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VBRiMt3HqKR; Wed,  4 Nov 2026 21:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A372408A5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793827959;
	b=raMPhRNg/1w0PdlRtX4Hv90Xo12D5uOp6zCaMjBrMVKrd6vdBzhAdkkbB1GYjGWflxhp
	 DPkIYk99MBpw//0CBwFRHQaME558evlFU6xYrzV5waNbBqOPH85gRxRB1xwSY5H0lCR4m
	 JxUKSVItmL8/Ut+cOKY085cs+GFogLQ1DgHAzCEtzxZOYyqU/t2wq2A/kiTQ0L/DsD3JS
	 Y7HlkhgMcqt/Iw4QqaV0HaC84ug1p+AltCDua0P0NRQLeUPyxsLqGmS2TvnSJwAzClnFb
	 i6iNvny51hYXhoLFf5QuHJNqyvz4BYngGeC1/EhV4b2kVq0FlhzQUUkW5tt6OAR/9UQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793827959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1FO9jvNkufm/bJg3ABkhnoYVKkJR5fBxlpqiozQXx4w=;
	b=hcZdiN7XkXMXtxCG6jdcnyncL4LB2NuGZoO3oZeY04oibF2vMgslf1ttd0lT+G41bGtH
	 PCzSqhii2XI/vxP3L2ezCzDc7swbASbrFkW+t38e/R2A/SbtRNSWILDxtKlxgOeLJsWDY
	 8auLuwP0IRG2lrqKFD+R+vMmnwDxg1ym2IjRp5Hu7sOyD18dW5FMWzPN/nqZBDhFooDw4
	 LHbdEgOoX6XtjHKhTqDpZM6ee3PPZPM7UVbxye4B9oW27MikEQDD0HRZfr1UUjQG0wpD0
	 JZc2pZQ7DQyvDSeJ1Tx2zw1QEmRxQ/AlLAH+ceMQs9o+rrj9G4XOh8Fr+zmvCC0F6MQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793827959;
	bh=1FO9jvNkufm/bJg3ABkhnoYVKkJR5fBxlpqiozQXx4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CpU52qSot/9xVKOfk2kb0gDWIn5hqyITTS5rZa8mS28XMbcEid0hLvbHCNXVeKWs8
	 LscUJsYZJioGotO8+mQqi5o13NGHNxZ1DcCClKwc1nsVVgK0R/A9aX+fLn93rUqCdS
	 AHoNnFzfMYpmXq7jW/sBD1ZusMOoPpZ0CAKoqiRrkEE6hGwzjsGzlYsAsn+2Kzutlu
	 drb80xGOT0TgjP8RQCiQC64qJe3gxosDzb2KgP01RnBVR+tuJ4ws7RDscrazy7hID2
	 oeGe1POlotnw9QYhViulVJFmjDIjkvf7nxv6tZspj08rFYNoS70Mx1D14T9jbXJ5Z0
	 ZeDWU3NOtG7Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A372408A5;
	Wed,  4 Nov 2026 21:32:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30708177B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 168CA8123C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KsVwrF1t44M2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6237281230
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=t/J2RyW1
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6237281230
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:32:34 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-833e671ee9fso1189002a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793827954; x=1794432754;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1FO9jvNkufm/bJg3ABkhnoYVKkJR5fBxlpqiozQXx4w=;
 b=t/J2RyW1vfN3nj3A1lcltLiepm/PxRZM7h9D1G9hRAVgybeIkxw4NanjSYdg7xAJeZ
 en4C4Ephpdkdj+Z95K1goKdNSD+yJTfT0XN+3jk64IMeG470wAkGzE1ucDlrD6buxu8j
 ZTF5eia7nauhwwCd8OI4cI3uC4aDHXhzHuPes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827954; x=1794432754;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1FO9jvNkufm/bJg3ABkhnoYVKkJR5fBxlpqiozQXx4w=;
 b=VvNsZZn9hSiwUSTwabuv12mhM3uXhgpcGUpcwTDod4EkM5khz/rUm0yq+iwUy0x20o
 KsQxzirfGM2qHsTEIt8+0deh113J4hPLsEEoPKDUC80TX0ff2RFeynQFSrSjFwCHThfc
 YOCyBjwVNEi0LLsi1rr5rvbZ1eGaNNrVa/wMexxO6mYJaNfHEc42IgmEdY19dORnYwuj
 1ixKpj6NtjH1Ghp1RJHSVClR02vxB3M0HIsNXmdhsjb5TtEk+Cy/zwx0lmvz1blwbRO3
 3hkU7Dnvs5QW35kT10vKTgjlELdQjEdu1JsRzc0WPvmgTYBnyg2NI6BerZuWreG0jomi
 zZHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ0pz+OPXcpaS5lQArR3cw1RVwYb19PX06DZSYPcV+V9j36/s1ynVgNvScCZJs9tbKVhZye6g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9LtBT5vzldEF9v/Kw062GwjGC+wW4G9mCf8GbknllquCE/Xq6z
 aI5lSVPKJs3Sln0zQC8iv28Jw2AKxKT+bq+4kIvdHc/m8wKOfIS9ztBksYSFhcmjUFw=
X-Gm-Gg: AYBFou1qVQMcPD9bcI9sC4rxrYmijdwitHm77f8cN4798oIkgOy9Q5ruOe/+rYqFCDm
 tKOXV4cxhIZUuvEBB9biEZJPoFcSss7g3LldLCcM65tBGPbw7X7gGQVSX85yx1zKNJpsE3YEwW6
 xtLwF2DPPJnYQxCvIj55oymnR/9Uadw7Onag57QTrsOuJW3ffAbb/k1FMlzyiFYlwVkqcNXGQrs
 2M27uwhMpEZ7qHM2ATxvmJkGQTMzDOelx5YdF4GmnZ+lg3Dz4M57pSGt7/a8ZR6pMDD4lG6bjs7
 JBQK1ok52ItU3CZcs7t2+QV7kUYIsoInSoCCkQk51sERU5jAauAnW5f7zR8n9CZ8hPFBhCUQnep
 7je9X2fOuCZDYcdpuBPo1NevaV2DtfJvMx4R4RGYfPIG7dG+IxdjOOfVsN0pyo/23CmX3wc5jzZ
 EDyF2XGbO1jKBPcIPRM2B1XMjDCy8U3R5T3yhpRJM6EUqSq711QV3k79lfiq0I+9IaYphE1hV5+
 MrPlCF0Fh9BsYyv/rmZ72VMUVkmQ5smUdWRan0HWAoFOlDRVN8EMPjjkPOzj1O6ZzCoG59nXxw4
 uawFtXxQI6FGX7OlcK6VhU+2o2wIsGIPZiMhIWcEyrWekoXsVaXxvJzolJYxtd2MOe9mWPugGpG
 o3WzqePfLhCnuiaMu/lTuZBRXFsD0dq+3vy4192/Jmm/RoDoA6gILkb5Jec2WgCDMOqzAS9qxLB
 5Rk+7dpfPfVXVOpOQlHniAkzySLDo9nQ==
X-Received: by 2002:a05:6830:43a1:b0:844:ec25:c7f3 with SMTP id
 46e09a7af769-85d365683c9mr14555592a34.18.1793827953793; 
 Wed, 04 Nov 2026 13:32:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3a1a6c8sm2891183a34.2.2026.11.04.13.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:32:33 -0800 (PST)
Date: Wed, 4 Nov 2026 15:32:31 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] bloblist: fixes for transfer lists from TF-A v2.15
Message-ID: <20261104213231.GI1164024@bill-the-cat>
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OMbC/Mv5c72xHidY"
Content-Disposition: inline
In-Reply-To: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--OMbC/Mv5c72xHidY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 03:23:07PM -0600, David Lechner wrote:

> U-Boot cannot use a transfer list created by the transfer list library
> that TF-A v2.15 and later use. The first patch fixes a hang when adding a
> record to such a list, the second moves to header version 2.
>=20
> I found these with a DDR loader for the MediaTek Genio 720 EVK built on
> TF-A v2.15, which passes a devicetree overlay to U-Boot SPL in a
> transfer list. With both patches, U-Boot proper applies the overlay.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       bloblist: align the used size before adding a record
>       bloblist: move to version 2 of the transfer list header

Thanks for doing this. I think it was on Ilias' TODO list around when
the version bumps happened but got lost with other things going on at
the time.

--=20
Tom

--OMbC/Mv5c72xHidY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauukawAKCRAr4qD1Cr/k
CgOrAQDCnHHRIULEm0dkqbAfUz8ZNo5cPj5vCMKrKgJuSI+S1QD/emmirrRLn7oN
eszpxwT4Uda7pTaxg0p25pMNHwaWswg=
=9TXY
-----END PGP SIGNATURE-----

--OMbC/Mv5c72xHidY--
