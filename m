Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0DCC79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 18:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E7F808BD;
	Mon,  7 Sep 2026 18:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eb8cpb7EvLC1; Mon,  7 Sep 2026 18:06:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 519FD807D2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804394;
	b=VP9xgeT0mAM8cdkmMUA3GorkA/19cv4bsfvjuU9gzCVW0v/qQNI00waVO3hpo/oA1Mr6
	 6LLRGFcPD8ss2REBlRaKFr6IBKw/Ke0m2FeeYSz4m/pKRThxoXbO2jqdnTGw/fDyIMpue
	 YjZZcgo8jBJ5AIiMxl1JG1SlEQ8JGK3siYX3yXzg1+X/y38UQKkvzbz4PNLU4SNSvOaXR
	 N+VSoDrUQHGHsohHAzfmfMHm4HrdSc9al59Tr8H6Fb3cPOajTloxnQgB1IDB0ZUlUsnC4
	 NUU/Zgz5bKBXfSPJDgz1FBTU+U7qpE/1Kb3cn3e5FKSr96CAa5vPVRkEsVamvPZbZtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788804394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fT7365WsUY5z0emry8XH7PXf+fe+8lnpiFYtrupP5wA=;
	b=Wny5LJUtJIQX4xFqX5fGo7nnQzaRa5jaIIJGxYe/fvTL6XyK3nv8+Pf1vHZ4YckTcYsp
	 /SEZxRisYgdLR8Hi/vQEESOHtrGPaWLzxp+4/ItTATb+dfoBy1LHq/erF8/U6WGwn3yZg
	 gFuYlNQVac4Kt37Jluq6xku6TC9Yt84ARQhBCJW9jXd0Rl6/8GlzNeqQJgHDaaFbrzn1r
	 zXbNyqze6dmfVQ34DJYHbJSLJSgDWRRjqLSF7Da1mLJJltb2l8TlA6cAxJjeq8dhiGWN7
	 Ag5pGXt5IFC6m1bI3MHGrbe4BjOydmRdbEWXXudPj+fHsMzc4v44Wo+djF05END22Gw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788804394;
	bh=fT7365WsUY5z0emry8XH7PXf+fe+8lnpiFYtrupP5wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KljRGbMqKNLTDvzFEH1d8Fo2LFlmuzQft4+MLNP9VpAjVSd9TQL+X/ZPGNBQBvyTj
	 am4llnw0enL8OpVYO3w50TivQtDlz/6fEUOD4/PHp1m8o0KikeqSyXmf+odWt4pHLK
	 1mmW2WsKEYyGf/oRwfDslWEeoF2zWo6yW3Rg4lOrWijdlQ199QPvSr03IIErLQWJVb
	 OIO1SDqDYujUxy9919BrKHBqhNM/KLRLSIpBbNGTbEW6D/eiIPiaMUp53syYUj8EOq
	 z0kDWSHmZictqOqBaFW1HbmOhWXtsirNBOF5d7NYkrvnNNt1qxjPz08+lJohbG/1Cu
	 d2Z0qaUeg682Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 519FD807D2;
	Mon,  7 Sep 2026 18:06:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 328EF29B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FEB140450
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1n8_T6NRmWB for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 18:06:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73DF340448
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788804392;
 b=Vg8l39I2iQEmIA/GcwUv6e8NNOCTQVZSru1bTYREW/nNXV6Xjf7j68i/KSG9UIas5hKC
 FOmkTM25mb9HMTW74EYIm48XHGUXKeRaMWLJYDIKoLiy+Z9tc+PbFuvwq92I23bNE4ND5
 N0ETrbxJRaqDt6L+zOSGLrXkQPcsHQrVjtfqrlaRrugyPQw6B9GMjDvQrwaYuyrwa5P4S
 D55ZqJ1knlD5Cf+/hahvecKnkqVLKCHSOPxpogT/DrnrhTpb9dgalAlLem7O7WwHJynRR
 DOb0Q1qpUZNU53+3IbhPbqZY4HrP1YzA6RESOfunyia16f5cBgsGUqYOzik9aKAYBcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788804392;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=fT7365WsUY5z0emry8XH7PXf+fe+8lnpiFYtrupP5wA=;
 b=DsyIQz2wMcecO7coDKVmS9r8Ob0I4/89akm1SysEqsmooG1BLLSUdvKUKeeD2IZWrogW
 F4w0CXXWmsTuKOdnaqadR7S7LD2h6XNOUYW2EsJqIp/7WNncbih0stYMA9h9CRtJB/lLO
 V1lIAbk/aOSUZp8tiMF+vR041WdLytVJ1mxmQ0g4X+JH+NYAZ0DHiSO1gffuaJqXEDp9g
 6ZrV1MVpN7oHwua1+QqhxSkeZTqI8AwEaASE+lUPxfFvP2Q5HqTYBIjn+VvrDDLiLdbSp
 tU4RdKVvy+EvitEftuq/cmwmok1Ppooh658pvPrIRS4kYhE+XodXmvJMQnARKgWWNKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mDph+it2; 
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mDph+it2
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73DF340448
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:31 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-46a4870536fso2646788fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788804391; x=1789409191;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fT7365WsUY5z0emry8XH7PXf+fe+8lnpiFYtrupP5wA=;
 b=mDph+it2TmaBpQaa7QDTjaAW5NMUY7yPYsAvRoOS8k/C1XnyFJ0taOReyODDx/Pbh0
 +ZjAzf0xxd0NzpaejKJV+yrblcRA8zjUar5wANwFSdiVNqeT4HLZ5iHGKlumPt9Nbfx9
 +uVkzoQFFL5xxemhEu8Y05kNCTVxUraHktNVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788804391; x=1789409191;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fT7365WsUY5z0emry8XH7PXf+fe+8lnpiFYtrupP5wA=;
 b=m/FP36LFx2SSUvj4Z/4/NsKOPpzI9PFYeZQ89CvnhACz0BN+uNetr/pYOEWnIfw1ER
 2jYSp1mBBow//l3JHdFR1FWhKDF3Z18jGty6LxBicHw45QSlIAUIQjbtIYoptXk7zkaE
 trdpunPLDP9ql2Z97uP3bC0rmLwoMYFmRhFyOsnPgNi5KALtNEVSFu/XzjVYb1w/xB5M
 O+kbbqDuTjofNFJJSXLn2Y0azqqmv0KbLLnt28G1aM1tso9z+VWvyyIcRGhiO+yDH3wy
 t8dWk8lO15fKeToEWkhJuiY09EzhoilmCKqNfAgBDR6oNy97mIkbVjzNCCno/Fcu7ABP
 JGLw==
X-Gm-Message-State: AFuF++kYzrPfznnIrbPz/pCGcH3nSIylbbmHWDpyU481VNQyl8MO2L09
 WeWGcioYr4EeN/wjyf4bOIftKspPAs9LGMvHGmWE9PVqDV1L+6NQQZQGol76c8TjCSs=
X-Gm-Gg: AYBFou3uv/xxCXWEzX6NY5lC66xjwIgeVBJQm1TpVJ9Yvfelshr4nI0/ga+yYfhHtr8
 rkufdvtLT+TrPk4GT5QSkflXYH59fMEbZwuGu1A0AKO9bmH21ul+ijtijBal/OzMooKUmJ/VvVm
 g/TWsKNAoz67tv+rWMjGaHdfz1/HS6aBmS42DT5dNJXcCOiaiJqr4eDd52kRvGUbolwPS+whUL4
 Eed7rA8s9KWiXXAeMKTrWZB9UycvDmHuwlDSs8IB5eC8ggmVuiWBMm3cwsVZqcTVlUwsfY+LbnX
 hzackXRegtkDrIcl+guZ5hDdpd8W8kUaCwM6OPUaFfWWWdJzBjbmWfIqRiWj7ay13czmaEPqV7y
 /Uziokj1q2zFSKT2Gko2OdLKE+Rl78mGENxHz0pC+u37zlhHeMWBeCqvLylXGpe952MP6DeE6ot
 3ZjU5v/XCMFi836Af08YXwZMOEMRjtniJ/Z5uEURipRZoIflTOodsS1DpW5kyUVrZ+qUZlwn8fs
 BWp1jk4v6QYEeSTMgGcmHgCg8zPRz7UCDCppdnXbGI9nsputGgm+/oVNUFh5TElkvk+AviMlFex
 ip4VkEYuUQ==
X-Received: by 2002:a05:6870:d624:b0:475:a153:2dcf with SMTP id
 586e51a60fabf-475a1537ddfmr14738529fac.37.1788804390928; 
 Mon, 07 Sep 2026 11:06:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47989a71ebbsm1525677fac.17.2026.09.07.11.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:06:29 -0700 (PDT)
Date: Mon, 7 Sep 2026 12:06:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, peng.fan@nxp.com
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2026.10-rc4
Message-ID: <20260907180627.GY1764417@bill-the-cat>
References: <ap4zcCvivppeXnM_@nxa18884-linux-1.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8JdMqpiGv9yn5a8r"
Content-Disposition: inline
In-Reply-To: <ap4zcCvivppeXnM_@nxa18884-linux-1.ap.freescale.net>
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


--8JdMqpiGv9yn5a8r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 11:45:52AM +0800, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull fsl-qoriq-for-2026.10-rc4
>=20

Applied to u-boot/main, thanks!

--=20
Tom

--8JdMqpiGv9yn5a8r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCap79IAAKCRAr4qD1Cr/k
ChogAQCS7s31Kai7EJ1v0pFVWZTevssBnNscb2IdXWa0P9STDwEA24Jhm6hn7CYM
oFDQ4sallF1zbZiiKXE4VcKT1WIMPgk=
=p0dB
-----END PGP SIGNATURE-----

--8JdMqpiGv9yn5a8r--
