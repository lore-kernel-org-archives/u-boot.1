Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B27606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O+9ecUyl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VmhL9QKr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85477608AB;
	Thu, 22 Oct 2026 22:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqiYoaT2hqKa; Thu, 22 Oct 2026 22:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE45860848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792706736;
	b=mxYKf2mFGFBJP76gA5QaHxHWjyubN7kHN9kFm3Va6TbwaeRDUT2HPKH0eKN+JzotvQra
	 NQU+/vsRqH6PCuaO0ZRiLPKjXPz8Sz9LgjifwZxKXBxyhLlepUDUavbHwbXtSEgIaQ19U
	 lm2OexqEkJVUBYkeRnLEtX76YnZ0HEMrgDXuvxHBKp650pmHs3Evc14qZYp4r/OuDJxNM
	 1LPtk6OUDLaiE6wh/ts8DDHAGhbjFz4ffm3iPsy0TWyhSFynCQi8hkYCFZNIrZS3rVO42
	 2fZRDYIwK7CJVLHSjagtawGkDob4JY4rXNXQkfK3KHXw24hpTtYG7lvwBs0ak1XtWZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792706736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mdmj+QQfkIklwKabb3ihpXgKCLWZf492UKJu5lTzgrE=;
	b=Q89bn70j1SPlxaLlx9TyDfYmMQmSRRL4iQlyF3TcFhHShT7Q7wts1ap4OrRr3KwIfeJH
	 MJ0IhavkDTlHyERniZWj3j4D8opoXhol7AMuD1xhAoQ6z0xCErsKS+OawO3eQzVp4bVwD
	 j1VwAw2IocBhZNb5qd/bMdDT9gkZJle6yuNvj+3W77EvWwjnEs5b9TzCMo6FXwbkK7P8Z
	 oqTSY3MENG/cKZ78VHQHl0OX8niRX8wt09ibjvJoEBWzJ+s1oj+L6e5bZEaVpd51i1zc9
	 Aez5jR4ezg+F49BEbmZ9JFitZkgyxXPp+JzjIRXlGBniw85Q9TnnUXq0fKD5Pj+3DUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792706736;
	bh=Mdmj+QQfkIklwKabb3ihpXgKCLWZf492UKJu5lTzgrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+9ecUylEmVJzX4BIHHofHVPTy+5r9MOVoS8yVte8V3Hj2xAW1qmQfXkKVXA5bnCT
	 hrrOda0P+vF8pTMDCtHAWXmy7R1/LNhEYdeWF5bENGHwqW7dFK2s3PcJTlLJX+CSB5
	 O/n62mPdR3sl1bXzpZvAbD+nuI/fUF7BsGZoQIXujXPdecVPU2Spv8YhohT8zj39oI
	 1DDOUwMpCSofpJK1Kp9K0kve+qaq40oC57+F3OLJVYwsN5mM01t4wqabiRGtqcqXsX
	 H+7ZHRg1Ugmn35q+Rd/cDZkNhS+GLyDf8LG1exqMClfbJAIzIWvNqoBkh3uh/GzRno
	 kGxhtXECBakJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE45860848;
	Thu, 22 Oct 2026 22:05:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5C7A499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B789409BB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aF1zSfgSO7hJ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CE36409B2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792706733;
 b=hdeTYbrbcuCx/LB3L6kewvDrYkOHuvAcEeokzQCvfxbt/9i1Kj7//d/8C7CQyr571fj5
 EYVrbkKUiJYn/orjTZs39EtZ2hDCU5ahOZRgVz/3hJGs6o5RFSo+oPx0ryaG35Ro264CM
 Myv8om3xxLjTRG3H+UOtNEo4tFJskFUQUCcgqXihPHQFrCX/0GTLPvckotyvbkWW1RZhk
 ukm5NFMaxitxIcn7YQoPWewKucJOwc8MHRl2ugZCanFSKxH1HeFtE5UijXtal6bkgG+ZK
 tuAE276a29rPoMdCsj5Cze4dUYwJ00OXUUHLODUVkJGb4btfCqUCgOAA8WqKsGAukkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792706733;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Mdmj+QQfkIklwKabb3ihpXgKCLWZf492UKJu5lTzgrE=;
 b=I2e6I3MpAXebN+ultcaJPiv8Mdzqdvw7JNxRoYOCf8Xbs6UnyBpeiWUG/Lrh+5XID0s4
 3EajgcN2WN3cSw766U98S5xrO5qxv817wjJ2YfKiOra1LSvYVtqPVyaaTWeg2V8aJhZLx
 w/XtX4s0n4LhUS3vxh6NdlxraMbZGBkfP7hQxGqARuFgCCd1PoAx0Ok9GjxpEZKkFHo3d
 di8U+ZPIAcxQsKVucQ2zcMRdL64nt9sAi0ZNxlMFOgIGRVG7jqZi9mpeRtsVR096F9ZBE
 UCP7lMnCXj4EoQx0GIXCw1V11Vm6mxCKwu9ss2GRO0m9BDwiW6jDeGXMLQTz0hzOZJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VmhL9QKr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VmhL9QKr
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CE36409B2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:05:32 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6cfed5dd083so201065eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792706732; x=1793311532;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mdmj+QQfkIklwKabb3ihpXgKCLWZf492UKJu5lTzgrE=;
 b=VmhL9QKrFtseYlFXYvL0rhNsFrspooJaSXWCeKGiQ7V5pX3gI4Uyi3rxM6SxGosAUm
 CF8/g9Tc8AyHs0B0TxbYZC9Crtt6/ZulCCdnF3pkshoBnEFXUnUA3Xs5pBFVIQ/WFHN/
 LtyZ4youGr1sXb4NKi/YCS9EsW71KLa15LmWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706732; x=1793311532;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mdmj+QQfkIklwKabb3ihpXgKCLWZf492UKJu5lTzgrE=;
 b=vtLJJ8/TAGzwdzUu1tWp+sWk5nz4pOi0RY7Bv1Brt9pAdj4yYEfQrRYt5IgUqGL2h+
 D6WHflCtsxpBa/nvnRHMIO34dwWKK98Op846Z1abKqC36xUtLO51uH3L34R1vgVJX4R/
 +9sqOvcSuSu1YqO8t7J9G92OR1+GMBJWXxXLpWj7qU2OfsHFq2bVGaJHMozrrCKGOdhQ
 qVX87mgXM6Vss8MJWOj4glo9/fB6k2PBsQYXCdJVehdh3Y6NLeq7lXvq5ISKgxXEqj37
 fLog8/fK+60/dG7SMyJOToChwfRwOhi3gQMlXewJ+2vo3x8jTtMaeEZ0VDSLo2dg/kPF
 vSrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv5MfvOnxFkuiny1hdwJ1quwz5INWfbTRbzvF9palQrXP+ms+sw8R/9wXxS4xidhTqCLQjreo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLrDaic4dws3U5tNkpaoMy4K135q7hqOZp4yS4CQKOsJLET36M6
 rZVefW7RGk/KCI2QtZSf+30TNqwY4+9b0f7fQicFJaFcPEwWKfTXWi0nm9aAz7h7jq0+JI1aNTS
 bYJ7UQG2f1I1j
X-Gm-Gg: AYBFou1lW/2yK3OtK7xRkot5gmsbvFTmPrp4fHAR4mO/7w+HeAjiyK1MdwqDAxCkjDL
 xQA41Ur8qZUGzqfi7Rx/3mFAgHvaANy0bAWSNGxDLHOF1QU4nE+MIXUD1BD4OnkaTgTJpoPKeF7
 vq3+WPJor5itoWAcJG844xlGGxgRIsfCo+YasLhv00hLHbioKs1HT5z+rhgZP5CAPuaTLeMze7W
 2OOofRV4+0e1HU+yAefpIjXBCN2Bleuro6fB3MTDj2vTFFuszux3RVOMBZDT3LHFV2QmcBSxq+7
 eSglF0xgvLuUu3WXNlCW+lA6XHKoqBRIMP2lgO/PZO7htBvd3Zm24Mo5tx71LxFsBGqgZYx1lzq
 sGG3NRiU0U4OP+ycNUWWn+53/7Ijomyck5g1IuzSjC6fJ03kx75nteg984K/ayd28VuXDaHrDzW
 7KYSgPR0o1KdP7HR5XMfyxqlUPrQwp5IMswPCq3gJXcPFhVgeWepmVSjdDm/xBwt4Cd7XJfVDC/
 1QoRRfyzHGWQBIJ6c7vTiGvc4FfzaVrK1usuibmidcpRCkMgqetdzrSCx96tS9LHn7+60YJ7Xf6
 ClaCL1lY0RG0ZL6vXvhICkWM2BTU1kPHe5X49M7GhyETFMar1Df//zjDnGO9XhjLhZrdJG6OrIa
 zpKhpRa1eXE/jyP8gITB3cQ==
X-Received: by 2002:a05:6820:603:b0:6dd:92d:3ff with SMTP id
 006d021491bc7-70b88af9e91mr502543eaf.51.1792706731758; 
 Thu, 22 Oct 2026 15:05:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbdf6814fsm289035a34.17.2026.10.22.15.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:05:31 -0700 (PDT)
Date: Thu, 22 Oct 2026 16:05:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/8] arm64: qcom: Add initial support for Nord SoC
Message-ID: <20261022220528.GC3596691@bill-the-cat>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261022213356.765702-1-tyler.baker@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jVB4BasUJmThNmkN"
Content-Disposition: inline
In-Reply-To: <20261022213356.765702-1-tyler.baker@oss.qualcomm.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--jVB4BasUJmThNmkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 05:33:56PM -0400, Tyler Baker wrote:
> On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
> > This series adds foundational support for the Qualcomm Nord SoC in
> > U-Boot, including clock, pinctrl, USB HS PHY, and configuration updates
>=20
> There's no Nord DT in dts/upstream and nothing builds a Nord board, so
> none of this is used or tested in tree. Please send it with the board
> enablement.
>=20
> The commit messages only restate the subjects. Say what U-Boot needs
> each controller for.

And all of the more general types of comments I made today apply to all
of the various SoCs that need to be upstreamed, to be clear.

--=20
Tom

--jVB4BasUJmThNmkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatqIpAAKCRAr4qD1Cr/k
Cl44APoCdxXLcnbhJC1LxOUwHwYOXmA0hpga8QYH0wZ2CqA88QD+JxLvLa+nvhb4
+XYtUL+h/JYqSl3dYhdVLduuz/amsAE=
=Mdwa
-----END PGP SIGNATURE-----

--jVB4BasUJmThNmkN--
