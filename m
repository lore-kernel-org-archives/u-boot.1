Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42FCCCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CC0B80DC2;
	Mon, 19 Oct 2026 08:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNP4oVmdFQM0; Mon, 19 Oct 2026 08:49:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9745A80DDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399743;
	b=Lpnx5v5jXFJQss7NOMkZcvmp0YPg2B6IoWwWHSF30cOyeD/ZvVL8Sa1gl+fbFRSYtbd9
	 ot82jJRfbhjws+rWxlMkTnahf7SSnlvLkf0MrZ8bSakq0h2WjW243aip578L2RveS8dg0
	 sPjGqCV+yQaNRAh9WscpaRQmQluQ3h9Jk5eE6sU6WgKDEH3rcbFZP6bLOpsbv96LC7G8W
	 k0LADupyyLyOkPU12p02bwPcLUhZ0Nncr8xljDvU33IvNex455xRdIW+IEy5MrYxnHESG
	 7uz/mliKKAuorF/dGjHT62qib6Uw8/EV6j2lIFzFBy29oxMSF15Z23ZWXnnXVWWuJBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792399743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=01GmEM8UqIF303r5hGvXAtbB+IfxiTYYLVwXQHDi4YE=;
	b=X8au9q9/99/ZCeR78Whu5KiP7zKwuz34jep65XXKhw25AKw0BLL2Q+t39V1ZaA1JTDkz
	 6EG6ghMv/qjMq4l0C+aJwU+ziGNQHZ7JTALTSs6ukHa9PxAq3fJ9GMbVVhCRRWf/c6Yc+
	 fZshkk1fAn3JLyMKpsrxOeMXvdQnbC1LkRdlA6juCed88axxbZEEd8tuZQcNaUlcinw1i
	 eTkHnlPzdcze4pGjnUMpTOlMxm3MaKdQeFvgSZ+P4ytwWIqocJzAcYUx1gix/B0Nu8ZC7
	 L8yAp8BeWQAZGYVk9Y2AfRbF2v+Xq+yUb6UtmADpT3+ZgRHUTYWZ6ZB5TYNrAHXYWIQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792399743;
	bh=01GmEM8UqIF303r5hGvXAtbB+IfxiTYYLVwXQHDi4YE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AALMO8YKk6aM9bK3gkp08+y6V9/I/ot8ywg3w8QYoxToLCHrDseIcssqj6K4vRMln
	 zJHuked39/Kop9L1cqqoPrMUg+JtgVM8SDYVbpV5RuQIT15H1wBVYULSK21DraCImt
	 F7jZll+Rewtgfvzxf5CvHGUanPl9LEoStAVtwXUvhECZzjTEg8NLYyTjP2e3Sgttad
	 zSIlShifIOw3r0T1FtcpTNzftLILdw0t6iwgvrk3OfsezQyniuH/UtuFsx9JCr2vdD
	 PDIaPB8DTIFZ3sKGcD9si5r0pHmqvW3D+qc4b9PfFpqpKJ0aUarl1FQoubK1mv97L3
	 DAX81E+viLrxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9745A80DDC;
	Mon, 19 Oct 2026 08:49:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2960E465
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0EF0D60600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bc4HBcYtpiML for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:49:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D30F605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399741;
 b=n0w6eqnEJde65eCKLqLLhqgiOJ3CM9KVPw6cHIv9x6bpJYtHHXswII+88t8FMW4vO9jf
 mUvpDrZJRqZoX82oQ9cTrjRAIiTMOr1xsQNGfAzXHKIEOc1/4mjyarJGUXbVT1JCeK1al
 VPiJaW93N0xmUmiwDXvGhh3uf1ithPtbNft/q5xthNALHRluCm7A085dkjp4QjHom3yq7
 DkMrvdpqxOAxyogB2jnpz5l2LWEgn6h4r14LyJCAR3DLvhrb9C+UMlJavQdImPVbYilLC
 4df41Q+LSUEhgQVXa+fCTSfcbbRUBYpm/I3iovJgH0YzVn9530+z2OXEK6WBEaRZpig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792399741;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=01GmEM8UqIF303r5hGvXAtbB+IfxiTYYLVwXQHDi4YE=;
 b=EKdLqiv/eR2FZTU7JUGkeREx6O3Y9DTWFPr26ZDQ7FkBxvVxbeHttANHAZEgwEC7oT3J
 bVaRos7gp/rD1Ih5dZssEJ/6KzUR/uC14AzCcbVK0zn6XGZjeg0gF+CpeV//ruh1RNLqa
 GuNY0sfqFk3vZdusQt00SsARgVFkdz5BCGr53op7KkZDOg+Tq9arbX2GhM/rXRxWQbt3W
 4u2nLC1+4PuynMPYcQBKKKwPvt62tJHXCNOQrF/4mhXyUPf++4vugXd4ExV5EFRNLpWmq
 Qv8Bi5kX2U0GQosNxH2geUeEvqKdZMZVHfzTlg3BpJ6GNt03KUdv0D18Lc8M2CHq6Yg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=0nNu74V4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=0nNu74V4
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D30F605E6
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:48:59 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5be47aa555cso1934347e87.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399737; cv=none;
 d=google.com; s=arc-20260327;
 b=hFoO0SeelTdP4IqHW43CuBKWfuucEyjGAjzGQX9gpekh5/bOwqAHPtK2fZfnymVdnP
 df4KP345/gxgd8TaO0ooEE0qJ4ZV6/IbHAaNMH3V/puDT7I2Mg7Kh8TXyDOqZp4OYfzD
 1HJ5OtBf9lJoIwngcvnSZMKTZJjL2zOs6jrHPgWjB4rA/QxEAp0SQQJhPX5Kql7bfEYI
 CiF2BNXvkwI3WJ3zPyFv6oQGjEkEWpYOZKLIl0aAYb6Wf13UlBktzFkLWKXwVNwQoWfQ
 bPrBfKw/EK2HyQsmCDhYLgzuN1g1tqs8F6Fl/fwMe2SjnzVlqueWCx4S6ZiIGf9CNdmq
 m3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=01GmEM8UqIF303r5hGvXAtbB+IfxiTYYLVwXQHDi4YE=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=JfMXpAlaS1ekTjf6bba2C94K6agY8wEHzLVwmgu4iq19ZhiHOg+KE4eqEgpigZS/Mx
 kg1DCZr+pgkc4GW+oChe3awddsdYmjDVCbjNaCsX5RFjirS8V7QKqe+R3dbSp+kBJqXQ
 Ca4jYh1pzj/Eb0zv43sXYaz9WVrQTTqRwKo6CcnqyY3DNMpHYuISt+4Ukro+9RTYPb0k
 A6yvDZ0ryh20TwMCgr2gVPMju1+olXKaWcsi9J9gMll+zqQBMy0YvIh9lQwZU5Ov3TMp
 +AiYhhyHKAPkr+4whEEvhPOSPb7oYfMqpkZ/Qa9UcMGJPiReNSDlAIpt+3C2RoPHplkr
 oHLg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792399737; x=1793004537;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=01GmEM8UqIF303r5hGvXAtbB+IfxiTYYLVwXQHDi4YE=;
 b=0nNu74V4d8v7dfdzmNqSJzhIWX3hrP1GbL4ycG/Gz5Ullf1kcV3zfHU08F1dM9IJ7h
 mXSMur9R1TeDvDKL6lm4UMFMFaWFtZsIaibkF3RkcsHkcineLngeiSBC2rPebGCiQfGc
 1pkWz/AMW8WECDvbaaGuM3JKXnNWCGuUDvP5qJHHO/obHPANi+fU3skSEUSV+yguaQU8
 fMr9M/mxgx02eGIVbTLxrnknSRDuPkqacqnNouS3Zuenx9NmugkxV9KrJygPG370StNt
 wvaj2k6LGXUvKHBfP7TTgeRZ4ANH+rrWP3HEIAfa6ZS1uiHb5mc5Lq9qz+kLyb9ADeRV
 aKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792399737; x=1793004537;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=01GmEM8UqIF303r5hGvXAtbB+IfxiTYYLVwXQHDi4YE=;
 b=KZ5OJZ9a9s4+ijOboLRlxFs4qryw+/J0lIdyRvPYd48R+8BDdRxOIB6t3SyoVNmuXE
 m/O56ijW0pPZFCK3Wy9frBc82qIjUGB3SmvNmY/IMDQZ9PquqxnQT8eQYRX+Mk5Ofj5n
 hlz30f8gVEH+nF2Xqmf4VfyiuN7jGmx2KJxdotN0SU0oZ4COdrfVCa0yocgSLm8Nd0AC
 FYi+JVZIrlwK8viSOQwBYgLmDG6hikvcuiOx0v2FvRkLXvuPCoGg8mT0qYhLBHx2aXD3
 TCaMN9NbNWonZfgOFyVvFN53z7cB4pY6eyQOMMPY/FRwfrI3zD/zK5ejIv/YaxbS+A0a
 wv0Q==
X-Gm-Message-State: AFq9FYKYQX1fmoJFYOGlSMYVaXMpDLd4bn0q8ZLAn4NhZrjzeryOE58r
 elBs/Fi8hxVtA5Su/wZfcEHVP5cJodVnhuEZAOW58qtZzCVkaVnTDwYHwigoG+xOGHdNAa9+gsJ
 xnF/RsVLuaw7wbRvB/CUUlt/HHsYf5VZTRMqA7NvMKQ==
X-Gm-Gg: AYBFou2E9I/SZk/MgwxYdXgNl+xyqPRFHUMtsNomTtFmWCCiuUdCxb/DcMDmb6vxg+z
 rtTMShFtjpRG12vnEIA57bld1quR2CL/KQDzJdH2xgwPjeDUlwD5ckoMRdAqKduwG0YydGHV+Lz
 3L3R52nsxqIctRVOxR2Qd/Od4d/Mh15k7wkUq4tSCKpCgEneKWVSx9PErZT6lyKXtXKfZ1BM1qz
 Jqjgw8C7kDa6qgQya7cgHDS8zK/7/3EhLEJxZrbc7FvXhb00LSxyrxyA9hS1cncv2JXpADHjrhY
 liT6EgPWzE4BYdas35Hacza4gVejq8MTs9mwYWHAag3hPIfjw0BEmaOnMaM2XVpeGhAnozLE2RW
 PSkA9axhZd64kvl8fZIf35l5b7GCWK7tBRhmoRniM0f/xQ5kwingmSDwIvlPQ3sFDl+7h62hqRn
 s4Pt5yRGAl1CPi
X-Received: by 2002:a05:6512:1289:b0:5be:4323:3cf4 with SMTP id
 2adb3069b0e04-5be50a67495mr2214601e87.10.1792399737498; Mon, 19 Oct 2026
 01:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <fc3c34a14be221f72a3e861a9b8bf82df88113c8.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <fc3c34a14be221f72a3e861a9b8bf82df88113c8.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:48:46 +0800
X-Gm-Features: AclHuK9PaCMK1-1HYZ3QxEjmPqGxBjL2HPUQEhr_Sw6rNoCZFK9ULW0yelSv7TU
Message-ID: <CAH22mJxbrk1SK+mk=pFENtkiXGeG=0Q2uvuCM1umSStRxvbTVA@mail.gmail.com>
Subject: Re: [PATCH 4/9] pci: spacemit: check clock,
 reset and iATU setup results
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> clk_enable_bulk(), reset_deassert_bulk() and the outbound iATU setup
> can all fail, and the probe ignores all three. A controller whose
> clocks or resets did not come up is then accessed anyway, and a failed
> memory window is reported as a successful probe.
>
> Fail the probe with the error instead, as Linux's driver does for its
> clocks and resets, and undo the clock enable when the resets fail.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index b85de73ad3..5e0871986b 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -230,8 +230,18 @@ static int pcie_dw_spacemit_probe(struct udevice *de=
v)
>         spacemit_pcie_toggle_soft_reset(pci);
>
>         /* enable pcie clk and deassert resets */
> -       clk_enable_bulk(&pci->clks);
> -       reset_deassert_bulk(&pci->rsts);
> +       ret =3D clk_enable_bulk(&pci->clks);
> +       if (ret) {
> +               dev_err(dev, "failed to enable clocks: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D reset_deassert_bulk(&pci->rsts);
> +       if (ret) {
> +               dev_err(dev, "failed to deassert resets: %d\n", ret);
> +               clk_disable_bulk(&pci->clks);
> +               return ret;
> +       }

I'm fine with disabling or resetting the clock when it fails. However,
the probe function has several other error return paths, so I'd
suggest adding the same disable/reset handling to those cases as well.

>
>         reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
>         reg &=3D ~LTSSM_EN;
> @@ -317,6 +327,8 @@ static int pcie_dw_spacemit_probe(struct udevice *dev=
)
>                                                pci->dw.mem.phys_start,
>                                                pci->dw.mem.bus_start,
>                                                pci->dw.mem.size);
> +       if (ret)
> +               return -EIO;
>
>         return 0;
>  }
> --
> 2.55.0
>
>
