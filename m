Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A0FC021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32768007D;
	Fri, 21 Feb 2025 02:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RE7gSJ9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E83807C4; Fri, 21 Feb 2025 02:07:06 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BD28006D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220bff984a0so30145875ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740100022; x=1740704822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Osyz1v2pAhiXEHQ7x2Ghew0pmWvYjDdqTwLiNKWPRuk=;
 b=RE7gSJ9q5+JApl9Wp+mH0Thy4c0hxdP6cQEbJZDVMa+E0ehRbJBCD7ynoI4Ww0z1em
 yqIX1HXHlfO7zsVfYtz6HN3OJqcOX/xqTZAKkpR51HzG/MdwVVmX+Xb8m5kuMu8P9C3X
 WDHxwRK4DBbcSx0da3ZUBZOvaa40IZ81rUseM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740100022; x=1740704822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Osyz1v2pAhiXEHQ7x2Ghew0pmWvYjDdqTwLiNKWPRuk=;
 b=l6Mcj9FnPCB4qYVhRox7zPQUHOsRlzEu4DPWK5j/vpEIPlkOYFGTFFN7Oorw3GzRvu
 RMOKIO0SvtKV4hlnNnQDUn332zIrnUQm/Wu2ATE/StwknUWLGiSk2vGyDotSCpEpHqVo
 +PYB5pmql78NeXgFudQ0c1TfBYPdave5jBbaVZe83FTB7TGN7C2biSBa17F1JRtCPwB1
 x3F22BjNCkxMBdwJrT0AHjIxY4+MKmfuIEZ985vKV6tUkUGSH7PAK8qF15/ZNeOBDydO
 ProN0F6jG+l/l6plEjb/aQfK9knI4SMiCfTZp/XEi0M37zzcbZI4VQVm0gtWBij8iV3/
 yUew==
X-Gm-Message-State: AOJu0YxkY626rdJdlrUwjhzLpk/zQqM/N+t8YGK4ANvij0LaksTYw0hX
 4fm1RnlOjgTYfKJfYG6CUqXQtlCW+JJXYpFSkpQM96cWz2twCv6RbrRjZUtgW0o=
X-Gm-Gg: ASbGnctEybP7jaROjjx39rLoSS509Q6HGvJEvc+yrKJgAsIMD7s7/wGgb7UW6lkg09a
 0uIAIWdrpYd793ehuaGMjRIbC0cfYuipzV09KE4kFqTFTDHRsBocUZkfMRn0vdCWDFKIWCyPFNt
 /WOKGTunG1/QdIW/tfl+oH3QA2SU2olKEmHyo5Yz3J1CEwQ7TNOIdMSP1O+9vfFondCna94Xioe
 a7Ebps1ZNAERhKbFY4VXoa34nBN0piUbH3YDTvudGnoRtwfUhEVX4Vo6HNZVGY81AqTOpxLtMpz
 6zEdj6dL6NawdA==
X-Google-Smtp-Source: AGHT+IGekmoZlG9hLQMR8vCJGA9iWA9kSnNLi0KP1Pq7nMUDz0b7U7Nu0aO7IhtQRtTcke5U01TlRg==
X-Received: by 2002:a17:903:234a:b0:21f:859a:9eab with SMTP id
 d9443c01a7336-2219ffb5d0amr19448445ad.37.1740100022313; 
 Thu, 20 Feb 2025 17:07:02 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d621sm126521415ad.136.2025.02.20.17.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 17:07:01 -0800 (PST)
Date: Thu, 20 Feb 2025 19:06:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH 04/12] coreboot: Move coreboot logic out of x86 to a
 generic place
Message-ID: <20250221010658.GD1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="syA2HYds/sXTB5KI"
Content-Disposition: inline
In-Reply-To: <20250220205900.3127680-5-swboyd@chromium.org>
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


--syA2HYds/sXTB5KI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:58:46PM -0800, Stephen Boyd wrote:

> Lay the groundwork to run U-Boot as a payload on ARM coreboot based
> devices. Move the coreboot table parsing code out of arch/x86 into
> lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
> to be globally accessible, so move them into the top level include
> directory. Introduce helper functions like
> board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
> dram_init_banksize_from_coreboot() so that boards can still override
> these common functions while also supporting booting as a coreboot
> payload.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

I see how the abstractions get used later on. The rest of the examples
in tree today are of the form foo_dram_init / foo_dram_init_banksize, so
we should follow that form instead. And I'd be inclined, but I'd like to
hear Caleb or Simon's thoughts too, on just overloading the weak
function we already have and when we don't, #ifndef CONFIG_SYS_COREBOOT
the existing snapdragon function. I suspect we might longer term need a
bit different abstraction here to make it easier to override things when
U-Boot is a payload and getting this information elsewhere.

--=20
Tom

--syA2HYds/sXTB5KI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme30acACgkQFHw5/5Y0
tyzAyQwAt+HkafvfpTFdOyUMNhSajTDM1vtOPA12G7pltp1uQaR5gxELGasf/wra
uPSWEGUJtLgVEmG/tO0LOAZA1zzjFTQvnZ7Dwzlvwvv2dhdkowoiGl0Q1cZI13zK
YhVeU00p089+u+JlDsegIq1rqWuxX1hLp0uOfaoaAC5xclR+vFXitZVNXVerbFD8
yI72duJAgkiIuMCk9SVc/BjO48h+EpGUFPUZyk1c4RmLxw2xD+Y3d6Ys27FIDHhO
QuNWdIj7+8DZ0eIe2AK9uhZR/xB+citvFWHRc/oWeWfmQCDuwv+6uO226JkLuyH6
svyUz6cxJXSBvB/Z8r4nm6b35yBBgvXNjTnaOXNHL4tV91kkGuWSVoxMNes3m6d3
5O7K+vdXgn4WcYAzsgb17bfPjVaLRilClNjRv6bIQf7VSBspyo8xFIniE+4bhKTo
QDHhmInF+Ue8aWck0WYUuajzgEdhLUv+sMGK7zm30f9Lkz/lcZQiEQlIZ29SoIag
2lSt6WAn
=bsDb
-----END PGP SIGNATURE-----

--syA2HYds/sXTB5KI--
