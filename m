Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D930BC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9885A4033D;
	Tue, 25 Aug 2026 17:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IsU_hu6m6mJo; Tue, 25 Aug 2026 17:08:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677688;
	bh=Ir2wCyQQmdW+QgpPWYm8Q+UL+tNRwMhvcqFSqNBTYl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gmFpfB0BNpdJkgd6gg5TtDPsfInM/8XlY69llSu6fwgSWpMgUYNIaYrOvUcBCkJBd
	 eo3SZ5ckWtbZOMA2c1vPn6MtQkZS//+kxYBiUS+sdkdwuaXB1CaIBu6rkU/bz1SG1T
	 bKEw4N6b1pZ/jt1J5C7xm7CrdBz3TEQKLPSxiURMJFBWe+kqZ/BorzgxYxmjQAZH+K
	 qn9QUwj4mTr8QEY9xKHRQ6xlNErYm0GphZC/TbdftzlQJlHICrmdsliWW32sty2WmJ
	 /OsZzc4LPa2f5zS7a6+ooercp027c/AeFm0FvT7Mx7Fk1LXfwIPicHTBa73EpOZB2V
	 NOOluLJcWmSRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD3F540340;
	Tue, 25 Aug 2026 17:08:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE5C118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAB2540340
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADEh9K2KIJFb for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:08:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U2Y6RdZ/
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3CF94033D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:08:06 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb29ed2bbdso673a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787677685; x=1788282485;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ir2wCyQQmdW+QgpPWYm8Q+UL+tNRwMhvcqFSqNBTYl4=;
 b=U2Y6RdZ//zGYv+5GZ6Up/FWHMJbwWqw9rP8ar1gJUZNkMpdLfCzFywm4Ajw1WV7Mlz
 RTUMtSe4dxvZZb+VBHVdOWzGEWxgR3uJlRwLbELmW5cvaVslVPIwHQcLkVCTqTwLE3a9
 eMCMuuBI9SxEmS/+2ORGM2ERWNhAvghV5dXoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787677685; x=1788282485;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ir2wCyQQmdW+QgpPWYm8Q+UL+tNRwMhvcqFSqNBTYl4=;
 b=gBmpvfW8S2VEoU4LNjjbIkTjVbq+Rn6QaefmT7P7cou1OUX8sUrETYsip0yipPriYS
 LTr1pnhuBw7eT0Jq71eR1ERfcwJ9QZeDfOrDBSVENJOcxLaM6afZeVen7YU6vs3ARV2p
 G/j5qxKWIni4eFKZ2w065bzWmKPULtplrTwCERhdMmE9HCd4yb8z+dT9EVY6lTI6/bs5
 HMjNV9azBxsW/yXWcnA4Ibsd2DINXJIn5V8dsCHTVsZb/vWwA9fELYP3ssL80TebcwfJ
 PQ84qYptEH/Yp//nutzLYuT9bJn555AfV1LBt4FyAFMIMCJxtGELpx8cuatRJVLXgPHk
 c+ag==
X-Gm-Message-State: AFuF++lGOhVo7/rGa5i4XA0yCmtUem8PWvxxfHQpPaujoJ4W1Qhk+WK6
 na6sOnkgbvtynbDvqg0177/vPJRPqplfu35oGF0wW1/qHKqBWkeWk48XPXcHiM9CDrI=
X-Gm-Gg: AR+sD100RHEPgLtKueJY5CyQZA03IiyOCyHL6q4eOAw25rVzB3EoGReelLZH/o6pKc1
 ztAgMIKSlkMaqukuejmpFrml19KLWEhglLETEMKa+0gqJlnw+JNjr1RWMvEL3/jPdYPehMVCKVP
 7DVxXx2gU5Qp7+i6lLaSVF557fCHD1NC7toXKZ8Y4uT6lMMK/zMJOJVu8LO6pE813SvIFaE8PY6
 /psz8O4HiinbiYOpgx1QjliC8sXsiDUuZGj+KHxz9IETpRjvZB/6lqNmUgdqC+6KrbMsWJC/O3R
 44yOgv9DRtZQaoy7EyMql1xSxBQQK1aRIxiD5piF0Q45bGHy6/cfgIbe/iY88BXh84o83xyFEhV
 zUShTDEKirYCoShSfWKPG2BerZOS5IDVeK34jKTARhLXhP/PBNt8I6rITV+vIoor6NePn7fXezu
 50VB0uGcfIOzBqRhTpGbFl+LeLpxkSLamcB/nPxCJPTafZhETbMFFCAp23J9D3j2y+jA2PXyDih
 CSBkyM2sASR/XeYko90ORCfNu+Am4xv0dvc7Rra3aLp2FdE5/duHmdV8a6iy0LDZ6BJ+4TqWED9
 XIIJmhHeKw==
X-Received: by 2002:a05:6820:5710:20b0:6b1:2d0e:ca1d with SMTP id
 006d021491bc7-6b1a03d48aemr186063eaf.4.1787677685051; 
 Tue, 25 Aug 2026 10:08:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a0278f18sm82250eaf.12.2026.08.25.10.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:08:04 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:08:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 00/45] doc: fix some issues reported by linkcheck
Message-ID: <20260825170801.GW523975@bill-the-cat>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LvQyuLGD7FiwGSVa"
Content-Disposition: inline
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
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


--LvQyuLGD7FiwGSVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 06:49:37PM +0200, Quentin Schulz wrote:

> Saw a dead link and made the mistake of running `make linkcheckdocs`.
> Now I'm knee-deep in it and cannot ignore all the dead and redirected
> links. A day later, I've had enough so this is what I managed to fix in
> that time. There are many URLs still redirecting (could be fine, but
> needs to be individually checked as some big companies have a tendencies
> to redirect to generic pages instead of issuing 404s...) or returning
> 4xx. The issue is that those 4xx also need to be individually checked
> because since the AIpocalypse has started many websites now have web
> crawler protection in place and linkcheck will trigger those and be
> denied access (or be heavily rate limited).
>=20
> Please be mindful and only run this script once, save its output and
> work on fixing individual errors without rerunning the script, otherwise
> we would only participate in hammering websites even more (linkcheck
> runs multiple workers in parallel and retries when rate-limited).
>=20
> Note that linkcheck doesn't check for links in code-blocks so our
> instructions may point at dead links also.
>=20
> At an attempt to avoid tens of people running linkcheck at the same
> time, here's the output sorted and filtered on !ok status:

Thanks for doing this, it is helpful and appreciated.

--=20
Tom

--LvQyuLGD7FiwGSVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao3L7QAKCRAr4qD1Cr/k
CszNAQD1v3U0BUMeH3iX1RMMSuczjI9DeLPkoxndz//Wh4UxCAEAw0Iksq08nPff
dvw7i6j5VqwcO3rfmiCud88tTPXXmAg=
=EPdk
-----END PGP SIGNATURE-----

--LvQyuLGD7FiwGSVa--
