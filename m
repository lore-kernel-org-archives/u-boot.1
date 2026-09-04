Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24710C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 20:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9811F40B75;
	Fri,  4 Sep 2026 20:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bm9baYF1-m0q; Fri,  4 Sep 2026 20:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 91B3240AA6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788552174;
	b=LuF8Via8fyiXLHZ62H8zYZNvknyblFp4VFy0L2YG6+3Y5TSp5Hw3WAmcdx0y/77KJpfW
	 nM60T7wl6qA6B+WoMBkUdQfp9IWfSONIwdx6IFpf6x+Ldgjt/4E6fu5GhU06C9nvvQF0V
	 D91G0aciNSx2QS5HEo07c8mASzpShuj2/jFPnAulvEF89rgHvAr/ZmZxk4H7M6lzDjBVD
	 rBBwVexVEuinZAo1xk3guoDO/2eBv5A94GNpUf4VPRzuBrJxhBU2oj93fvkVQpSXJtAiE
	 upGr5But8o1B4rv2flqxbdldiTd2O6I3Weqn4rigymVFvFlAim8vW58P46jkaY45Clg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788552174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jv95LU6qLMJcAXNkDxdTQD41EpFSBNTU8T7/ywDDOlw=;
	b=NSjJVIjp/wAeiOP6s/6nhMGcV6mFQZWpaWuRve0Di4cqP+TNUpnulSsr0kX8aQTF2CXu
	 HNVv1sfaIJ4sDBY+JvBVql3Db6P9BA2Cdx3ZAVG2ppqBWAwrE1kvbTbO4oQfW3zHcNnzx
	 P6/tJ0DJcD6NpQSgHKrXppxWeIEpSnxSi2p9yuYekTdTeI3FZENsEiRPzChOvinGtIbNy
	 rgX+ly+zXp9T0XqaRRl3EPy4nJ/Nczvl/HhLyCz1B++8SwwPyG6Gl2jN0w3LoQyINOeC5
	 1pCcUHlREd9uJH+JBWiX0ZXsH0T03kxS9a7c7NYCo8zZ+gnXFnOLWYbCQuxQC0b18Bw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788552174;
	bh=Jv95LU6qLMJcAXNkDxdTQD41EpFSBNTU8T7/ywDDOlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSlpZcNRJqaUdnuSKrpy95+zhPWBdjx5aqFCTaZITS/tzXZDtN2k2n9PXGKFTe61w
	 PfFEk02KEIvc4ztsOp+fpIqFxoH8E3n9VtGJ8udZx8Hl6tSwdbnphtDa2Bx8OKN2Qq
	 RE+rO/S2TUCE3QoU7Pav+Fb6obhHZFGzYdvSwciA+lwBfus0cRSE6HIV6em5Vz2Z7I
	 LlVLVsnZgc6mcssyQ0cZ/V64CcCdo/y5n1Or8IAMPyB/uMDoucsH5YgCAxAWRnmdhF
	 2vGShYfS58u3WysPGam55mLvOc5W9p7dm5t8imqjfL7LK737iaGgOJi435ds90lkyW
	 //6zpqI/+KYTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91B3240AA6;
	Fri,  4 Sep 2026 20:02:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A68B29B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7056B80F5D
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWYN0VExxkro for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 20:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B221780EC6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788552171;
 b=fGEQiTmGUmWN38u4Mz5CNRGy1B0U59AKfRm1JaJKWg08NxWjjb75g58q+GaihFpNG1H+
 6DF5pkZaKfXumY0hxk4cfykYNeDuzeonRtRSLRB/bcP0eEGDXplJvMpap7bPP3+AvY2qe
 X1ra2QiGSH5tsqnnC+YRoRPZwq6YkWhR472G1ks3AYw7b6jg0eK1ZcnHGrhxwJM8EeOXv
 xDZMX0ftExSb2CQYfWfDt6s3PmPSj7iZIzr90M/t/XvNhSv5CcLsm3LfuFWlOjAO8eRQC
 +2c80UxPMwfGpKj8IAj9xYneWWr3RsnADye7WWhaN7KXqIQO0HooEegZGzTOYbz346g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788552171;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Jv95LU6qLMJcAXNkDxdTQD41EpFSBNTU8T7/ywDDOlw=;
 b=E6Z4YMBDEfjxH3j9RxKXvlr5OjWgkHhPaKwZsg7w3H+Ur8pOVx9FcjbewONsqXhzKHtF
 li2lMrSm5bNRnOXV+J8N/ebmfWWFG61PMzqEgh4kprqpMCmDgs16pkxo0Pc0V2gC0gc0d
 kSeNRhinMnR1I3XXO+0jBnM/FGvMeNPzyRKD+BsfOOSEYmklV7NjqxaSpwS/mwftvxj1a
 tQnS+yfLmFvmDqRVImKdyNWsbYUlyKTqXt9eBjXplADfJsSEhhAoE3RbdOB58wy0THhRg
 69C/3/XyBWdRm5eJYAdCXjWEFOi5ECUR+bBokFohE6TYNXN94fqJlSfHNNnTKmKSZbQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DYdEG7dW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DYdEG7dW
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B221780EC6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:02:51 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4b21f09ea42so1362523b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788552170; x=1789156970;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jv95LU6qLMJcAXNkDxdTQD41EpFSBNTU8T7/ywDDOlw=;
 b=DYdEG7dWkOtcmbLmNOnnP9kymDS+8UNJXrkS2EqBuG3JHaTd9w4XbgkbZ9ntYyQt6g
 f/gun+egYf/rIivv8v5oOG/UmbgP0+9fYdLwVw/rJBgOpSxlbPyMltnpXcIqe0CO9mFT
 JVWZ5VZo8Bn+AweeZ4EeVzEyfVTP1f60oAn9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788552170; x=1789156970;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jv95LU6qLMJcAXNkDxdTQD41EpFSBNTU8T7/ywDDOlw=;
 b=hVAkQijM2xQA75cKapvazRk8kffyZSgh3xOywKYfYvRlIUaG2KwRBTq8nAgY+P4np/
 PVYXbA7gY5xVRR42mYvo1dlaD0aujgaP8b4nqa4nsE/Ug3dKxnABJiiQ9qyibcU1W86E
 Y4bf05I1zKo5DebmLgehsnUDjMHIvHPKEDQJAkE6s5NxIHxQa/mCmKngthTnp7ZDZVQM
 tbEiFgHGGG/T35Ks2w+Zu0ksYdf6syYsOdyWXm1qX+ZommvzVaxwwfLk+jK6dHu9VXKx
 wmqa0e02WDhjkADZjrEAy+LFn254Vo+Nm6K16b3nXQP0zjrrDDWkVKa4mjIA9X1BALpL
 Tkdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnjCn0o+VSlgG+dNW4Ovu2Oh+y9t2G+z1q+30Oq+RAEf1ZrQYNJULp7lj7g7IrKhmpHOizZeo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k4qInnDggmgd222vjvj0I2HRrzA9fpzU+5wQWVzB6t3g/cLIjg
 ARLss62W29PDBkManjZAf2gHTFS6Hp+RNdghEw6F1R6iqb63CfqNXLneflVd/Gziwzc=
X-Gm-Gg: AYBFou19eEbEqggjB2ocKda6eiy0PSz1S/NwZ303TpbCvT7CHUvo3dJ1vVbFDdV1Uew
 JpIMXHkcAU3MZJFHE+6h7EBwHzYtoAMVoip+1t61ZNwSjRQQ8YKAEv/lJPZOAiy1Ar1KxVgkkyH
 2t/8KqvLPk9burzXcREMSyXdaBpLjoQHEMMpobt6mq3hfOl0yqD5t1Cz5Xwtcxtq8vPtAFJSnZE
 msBYrjF6uTrPa168+n5RDonKNiPzwmHZQDPgLKZmV7gCrj2t5w8fE46ChYBbMEvZPnd4i8UNtxC
 BeZVZSIYdF5g0brsLIyGus+vPN+5eSNiSn3fINQodOT6DLNrHl+DCRctQL42MmszoDPW+icWdig
 enUiMQAEziuq5UPW9vDFaT6EGE1zgfJqRxtYuNIcr5YHVuQOEN2OJ4nMHKtx8Fj4R2n37g74DTn
 jOT5ri6eOkhRiCanwHeo7nMi6uIV342Rsc0b+vcUVPMIQ4F3OVnnVhiP5zWzSiEylomtfEy2XhZ
 KHmWZaBrZAhKLnLC4CBKR4LdwztXHWG+Binl4lEAekaCWX/c9y0XLZxUc/kIrBQDwlDqgV1DJiT
 7voWKsUc7Q==
X-Received: by 2002:a05:6808:10c5:b0:4b5:5bfb:f25d with SMTP id
 5614622812f47-4b9641d50a7mr6528772b6e.20.1788552170206; 
 Fri, 04 Sep 2026 13:02:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b96babc2c3sm3690401b6e.0.2026.09.04.13.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:02:49 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:02:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Include riscv_timer.c in RISC-V entry
Message-ID: <20260904200247.GT1764417@bill-the-cat>
References: <20260904193517.22312-2-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kyouI0IPbtnweB/v"
Content-Disposition: inline
In-Reply-To: <20260904193517.22312-2-me@ziyao.cc>
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


--kyouI0IPbtnweB/v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 07:35:18PM +0000, Yao Zi wrote:

> Maybe because it was added after introduction of RISC-V architecture,
> the generic RISC-V S-Mode timer driver, riscv_timer.c, isn't included
> in the RISC-V MAINTAINERS entry. Cover it with the RISC-V entry.
>=20
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b3a9ac1f2ae..ab8e611e4eb8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1518,6 +1518,7 @@ F:	doc/arch/riscv.rst
>  F:	drivers/sysreset/sysreset_sbi.c
>  F:	drivers/timer/andes_plmt_timer.c
>  F:	drivers/timer/riscv_aclint_timer.c
> +F:	drivers/timer/riscv_timer.c
>  F:	tools/prelink-riscv.c

I think adding "N:	riscv" would be a better idea, it will capture
other missing files too like ./drivers/cpu/riscv_cpu.c

--=20
Tom

--kyouI0IPbtnweB/v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapsj4wAKCRAr4qD1Cr/k
Cmz2AQC+JTlfrOwaLT0stlof2ormVa+HrlEcWsyai4gJH/wPOgEA6yEEqf/XUcmF
4H89sBGHzrEPdKcS9H8hbv0/waoIIA0=
=2eOf
-----END PGP SIGNATURE-----

--kyouI0IPbtnweB/v--
