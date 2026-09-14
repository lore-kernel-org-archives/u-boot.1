Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A50C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F70C405A9;
	Mon, 14 Sep 2026 17:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YtWS7BDBKQOH; Mon, 14 Sep 2026 17:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2515D40583
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789406130;
	b=c05uhNVCTrJdXeWVnltP63Tghw9U29d+LUfWVeKXv7r1z/gbV9f/ASVt1KAqSoZcx9re
	 xNaoUpBRfBMUle4Z8ObOZnPm2h8ClEDopD+8t2oU2QSqlnOreTolGV1fZVhSWmxqyFSEK
	 D5lsp1fL8XKJv4D/PtOSZD05stKZt9m6qyZm8p23JtXYSxDnXcyl0cW6ZxaVlNuwaFT0W
	 ihFyfFKXe9My2IdQ16hwRKsHUg9KbNqNsMNvxBwpPGeR0TzKSixgD/51W4iIjt51DubeF
	 /lQlhnog2lwRHxYoNK5H/fJFbwCrRtK0qZxoEQaHHaQcbjEzhWdj7jbrXQnXprDwMJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789406130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qA1XpG8063IAtozifKhXM/cYiI0biudOt5xarza9VjE=;
	b=PDFRAz0K+LQuTit9GiAiHy5NxJbBM8jIyVNz/MXuw+jBd+dhiTEFT+p4E/Dtbqa/Vne6
	 M5SuNHKA0u2DBe0FIgYAOXbNcLVZ1lE8ZhrlsPD83Ckzk74ZJfLnCcRS5oMEkg0F3Tcv4
	 iOobns4fD7hRDVuWm9gZ4dOR86h/g8GXcXX+rycJ0EzzjBfOLNrqCDV2atz5yhEiDulD/
	 5FfWpU6forPqMEXkIknJmMP3/QKOmjViPXO8Zq4B5lEnWgkFTuk7fj/FtsuhGzYSduynf
	 DNd07ru5Rv/9RQLKcVvadfhkpnVqbDD6FXeG1Z26WZ+wxTcVNbAmj0rslR+8q8vajOA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789406130;
	bh=qA1XpG8063IAtozifKhXM/cYiI0biudOt5xarza9VjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ldvPEJmJABU9iSz8XzL4j02DmUcE/VGDRe1oyHSGye1TxIkEifKG4WpzYy6yFYTp2
	 Z8GR8UITk/YEEAz8cogV+at+eF53ZpQiXwVFhorXol3Hi1+xcoUDmBEnUOfKhC9tod
	 uwOVcN3rOySkWQYagJ2UasKeLRiG8RGEFJwD6AYgz8Ocl71T1IQuIgRAo95wZW1gA6
	 XsGqhrhPsRmmXqw10Rzk2Q7pPAN6hYNNc83NZNKjyVkhlzDTBKKqKKpW5V/WcJE/cR
	 BrXHDzr62XVm7YisavcV7EyAPU4XP/PWbiCFdnHdcL1YplIHyOJLYTUOR6BHlkcVWx
	 /9zb17tijW0iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2515D40583;
	Mon, 14 Sep 2026 17:15:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0972B259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E319B60708
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RMWMrP4fDOo for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C698D606EF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789406127;
 b=gLt9GuRqHMnZtn74EOAM1PkgyVA4rDt1WPT1P0gouiouqDonc9bVlgdCIFQn47ryN28H
 vjF+0Ex2Mt7sZX5CTb++TDYqStyX47E6dfM4fo8YfpI1htcwtDAbVhaBsAa+kfKgEp2GW
 tOVnPa+TTZd6jvwHZXn6hEyGI62ip1G+3dAHao/FJPpfceqnIuT8UbP3dzSzS0fWorf8g
 cthBV8yauGfnx5sxWqYyv2Viy0F0b9e7DtQTAhjkrvFWP5HRkzsAInvJ2XdHpjRypf/Vj
 6DxHJXqop90WlI0AqnkEoPUNDzBMR25NEgo2ETuXJ80CnCRPGTrdL/8evcEMHp1KPig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789406127;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=qA1XpG8063IAtozifKhXM/cYiI0biudOt5xarza9VjE=;
 b=RJySPK77yt4S4jBiiJZrtbDhl8kqROocvYj4FbylS7VnHmgGY229NVERYkerfoIp3XBD
 YnAVy+o1XnEdu9OXb3zSBh1lWYtKgdGshqRZrwq4svidB0UFMBI5q/pAV2RBmTn0n1ObP
 58edztcr1en7/UZM/uT9ZmtshY8wI/6ixzEnXI6bcy+CU/MjYD69zL/onpQKNmBxP8nbh
 dHr12mjmE5bOu2ELnwMohKOIZduZxBt3KdcxW3KPOdrsY+B3ZQTNuWKLhjzpw8CRNtmm1
 VJF0MZQqnuvicSYMjhxQjxJXieLUHlbcRKKMxK8DlEJWqUU9mO5qlAclFDwnW1LOK2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pNbpiscm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pNbpiscm
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C698D606EF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:15:26 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 46e09a7af769-7f4e2118db8so1277805a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789406125; x=1790010925;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qA1XpG8063IAtozifKhXM/cYiI0biudOt5xarza9VjE=;
 b=pNbpiscmytIkYmv+4AQ51rOIa2uGzNY1jpHP8biE6Y18twPSPFEXAKbySEjn0pD8De
 WTJ3AiV+hHKF+9wTiH2frX/g6fQ4pfqTToRIK1dMVRQQ78FAUNvBVWWz92sM4isOcUmx
 4Djpn9XeL3wwXFmsRcdCYQinRdqU80H4iVqfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789406125; x=1790010925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qA1XpG8063IAtozifKhXM/cYiI0biudOt5xarza9VjE=;
 b=g85YTAyjANdmAZVI9+RcZsVyYkbprZFM1WMhfy/8ijHIBSQC0za+NpReKp2Uv6J1DZ
 1HxbtZIR4Y8XWY642VAWX2A3v39Zw5GZ4VcPA5ENeYY2UB+V7VB4FnideEPxs+4DoUR4
 W8qlx6wqujbpZpKEk+ppw1/y7Vnel0YxFmrDOJQU3YJN53vuSyH4000XB05teu6R4xNI
 wLHITiUcll/6xXZ1eei4vPuQ4ANktthrgQFuYqy2TsambezwzeoF1KIh4tpptHDNu3X8
 SyKB2X8AY6d0JYso2GD00dhXZtr12+VzhZzlP3nxxwP1e1DGdDWeLLgCJgiknxznrSpk
 bpYw==
X-Gm-Message-State: AFuF++nKlEiLh9RHzDjMmEcUl6cM9Qy2GwVpwR+/iNb9PXgQoFrta+WU
 ptp5h1TyMXm7NHVjStizHQb6PRu7hcnBMFd8DnPa18Rb8dJ3wTRCHdF4UXltMT72EJI=
X-Gm-Gg: AYBFou0pZRWbW8fU9MgzwM/u84D+p1EOufekknkO8QytVbxMa0qc14Rp3IhhyJfohXt
 HTyPgDXbTTQ6H5TaraLP0Aq92ZB9kzzy0ejlkfJjkDxcnS/giBJWooXc6D6QOmFkSwPVVtm2XyX
 tImratQfBHqW7vaYe5pzBK3fl+H+XMcyG18kzMPrrHizBnZkKtuks8dxMjme2QCSHVoNlbkrsUB
 8TCkvAueBuMuM+DGZm2ucvp+LiSq06+gfQbOFmF0FUUFnIw4NIh9K4WEmGVgyovnP0ypuW6qjyQ
 zswjm5P/Z7csTZY8Sx6XsMCKHTsYryX61sc5OovZWPdOBwt6Tp88b5lCNnSbw1wkys67Jhf3A+s
 QHsOm/zniBPXoqlcMUT/0CYqqZHJ7u3L7weGSepkXX9z40e2d69xwzPzijFy8Ln7qlA2icEPreJ
 3hQ1Q+gpVqM8plFVHcJz2Qfcdlwy7yW2JtiETUhjPBJfY8FvqKJPO663a4xs2NK/3O00KKxY0bT
 QjeP/p/YtIkVFrAXHubMV8PMjF/nGAf/BGVDvUT5isiDOqXrkNdG0sS/lJn6ZySqIhFnzVxFjGY
 xxyoZ4wFq/ldBW4mcR7W
X-Received: by 2002:a05:6830:83b4:b0:7e6:f4a3:1df5 with SMTP id
 46e09a7af769-80897489f80mr4000460a34.1.1789406125331; 
 Mon, 14 Sep 2026 10:15:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f60fe54asm12387032a34.15.2026.09.14.10.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:15:24 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:15:22 -0600
From: Tom Rini <trini@konsulko.com>
To: leow149 <leow149@lucidmail.xyz>
Cc: u-boot@lists.u-boot-project.org, andre.przywara@arm.com,
 ilias.apalodimas@linaro.org, sumit.garg@kernel.org,
 james.hilliard1@gmail.com
Subject: Re: [PATCH] sunxi: add TrimUI Smart Pro (A133) board support
Message-ID: <20260914171522.GC1764417@bill-the-cat>
References: <20260912063037.81151-1-leow149@lucidmail.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e+itr8uWpLtSetgO"
Content-Disposition: inline
In-Reply-To: <20260912063037.81151-1-leow149@lucidmail.xyz>
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


--e+itr8uWpLtSetgO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 08:30:35AM +0200, leow149 wrote:
> Board bring-up for the TrimUI Smart Pro handheld (Allwinner A133 Plus):
>=20
> - New board DTS (sun50i-a133-trimui-smartpro.dts) and defconfig.
> - SUNXI_BL31_BASE: A133 selects SUN50I_GEN_H6 (shared H6-family
>   peripheral IP) but its TF-A platform.mk sets SUNXI_BL31_IN_DRAM,
>   unlike other SUN50I_GEN_H6 members which run BL31 from SRAM. Without
>   its own case here, BL31 silently falls through to the wrong load
>   address and crashes on real hardware.
>=20
> Boots mainline U-Boot end to end on real hardware (SPL -> BL31 ->
> U-Boot -> distro-boot).
>=20
> Signed-off-by: leow149 <leow149@lucidmail.xyz>
> ---
>  arch/arm/mach-sunxi/Kconfig                   |   7 +
>  configs/trimui-smartpro_defconfig             |  64 ++++
>  .../allwinner/sun50i-a133-trimui-smartpro.dts | 285 ++++++++++++++++++
>  3 files changed, 356 insertions(+)
>  create mode 100644 configs/trimui-smartpro_defconfig
>  create mode 100644 dts/upstream/src/arm64/allwinner/sun50i-a133-trimui-s=
martpro.dts

Hi. Changes under dts/upstream/ must be done following
https://docs.u-boot-project.org/en/latest/develop/devicetree/control.html#r=
esyncing-with-devicetree-rebasing
and so as their own standalone patch, thanks. Next:

> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index b0c5d3cd..c12f9b4c 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -268,6 +268,13 @@ config SUNXI_BL31_BASE
>  	hex
>  	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
>  	default 0x40000000 if MACH_SUN50I_H616
> +	# A133 selects SUN50I_GEN_H6 (shared H6-family peripheral IP) but its
> +	# TF-A platform.mk sets SUNXI_BL31_IN_DRAM :=3D 1, unlike other
> +	# SUN50I_GEN_H6 members which run BL31 from SRAM at 0x00104000 -- needs
> +	# its own case here or it silently falls through to the wrong address
> +	# and BL31 crashes on real hardware, jumping into garbage near its
> +	# actual linked base instead.

This kind of information belongs somewhere in
doc/board/allwinner/sunxi.rst I believe and not a comment.

[snip]
> diff --git a/configs/trimui-smartpro_defconfig b/configs/trimui-smartpro_=
defconfig
> new file mode 100644
> index 00000000..64d26459
> --- /dev/null
> +++ b/configs/trimui-smartpro_defconfig
> @@ -0,0 +1,64 @@
> +# TrimUI Smart Pro (Allwinner A133 Plus, sun50iw10p1) =E2=80=94 out-of-t=
ree hobbyist port

This file is auto-generated from "make savedefconfig" and re-generated
as needed, so all of these comments will be lost. Any information that
needs to be kept and available to users/developers should also go in the
doc I mentioned above. Thanks.

--=20
Tom

--e+itr8uWpLtSetgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqgrpgAKCRAr4qD1Cr/k
CiTBAP0V0o84vb4nRr3weeqbCpgaSmxX3YvYI9A9+cp/Ftz3gQEA90tLGQcj42n3
IQaBaehlDQbw/5hfVgH/j6rWEbXYbAA=
=0Qfp
-----END PGP SIGNATURE-----

--e+itr8uWpLtSetgO--
