Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9D1C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 02:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B54F806D8;
	Tue, 11 Mar 2025 03:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GfpiMUQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC3D807D7; Tue, 11 Mar 2025 03:47:08 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02B8801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224191d92e4so85480845ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 19:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741661224; x=1742266024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dmU0Q1xaKZeoY1VFrtauTPSFiKY8zqoQwxnqE2gDwKE=;
 b=GfpiMUQAQ1pcxO6x3yRcy+xvtKgogPKFaaLLPnfgoCzz8BrFzrkrdDg7ZiMMd4y6y2
 hLhq/OvTjHF+hwi2oipkquzskErU3lSxIrbqcm6ig5697kkJK/+nMMpZo9r5KnE2NOPl
 CvlgLk/fCwVw6TgdcZLvITYwfVvoyMwH4C9ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741661224; x=1742266024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmU0Q1xaKZeoY1VFrtauTPSFiKY8zqoQwxnqE2gDwKE=;
 b=EsyN0owxQN4U6LIYZbQ4fzFbpsKwDuTjZxBX9H6qKzHh5bcTAd1MjGjGK/EtW+iOPZ
 1/WIXFgNOFvlUSaRWtfAChsp7SxEvPKifs2ZjDHt9CuChbFkCTLJTIHcjVkpfIRmMFFl
 Uzlp3A0LqPx8rV8ETjKPyXkjeifXITuiSkWJSbSnFq69BnlzQDrOCQnH38ceIv8t0dQE
 sRc99yemyqyffOz6I8V+7mglujZYd8A1QY2bhIATHZpseynN4RwNiYE4VNi/zzUYspOF
 RnQnEzrZIul6vUYNwtjj5X50paTAV+aTR5/gafDHlNXKfo2hhWWOZkda+fzVNSvBngqv
 AbAw==
X-Gm-Message-State: AOJu0YwXk+WfAE3oeBuQJwqYvot4NoHxNMW6bFPA1+ZnADDqXZYvkc6e
 HWcMk8xRg76SgXZ3e8vQ/8WvIUU0+5g/jokSqz7AsTEOTEF5nJvTWGi3nagvSVuaXnpB4bp6gBO
 f
X-Gm-Gg: ASbGnct4VGOF4cFwWGF5P9rth+KbpiMGOVqcnxNXdchpcYMspVrDuL1N8SpzRTKV67V
 vovChdH+AefBZ9yGBjEHLycoy/33GPyIvVX3vtdvO213JmVLeioVUqhOgTTzMk4lDJ6x2VpxlMk
 jIOlyGVe2yuSWzxfJAVMt1AwGT6K2W2kMQf925AT1tI6T8qsototE6PtZmarNMAjLLR4U+CqYNK
 VgvHX5e5Idn7sssTJbtxuL6nGpvcpFErY2fVhcYvtYA1eYTGw8egv3nT/boqD0tRVy/bmRcM89U
 Uywgc2amOb7IkrEuDlp6fD2UOZJQyVt7EpjYuRFimzpbUQ==
X-Google-Smtp-Source: AGHT+IFDYX5CDM5VMLYMKODfsi5AxwwpLo5Sfmt7Npg2W2SslVsKBnobNtrKbyTj6xdA5PSpo/7+QA==
X-Received: by 2002:a17:902:e74f:b0:215:9bc2:42ec with SMTP id
 d9443c01a7336-22428c0f643mr222758625ad.47.1741661224276; 
 Mon, 10 Mar 2025 19:47:04 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff6933996dsm8819334a91.4.2025.03.10.19.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 19:47:03 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:47:00 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: Merge of v2025.04-rc4 in to next
Message-ID: <20250311024700.GT2640854@bill-the-cat>
References: <20250310234651.GQ2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7BAZpcxtep/0GiVp"
Content-Disposition: inline
In-Reply-To: <20250310234651.GQ2640854@bill-the-cat>
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


--7BAZpcxtep/0GiVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 05:46:51PM -0600, Tom Rini wrote:

> Hey,
>=20
> Attempting to merge v2025.04-rc4 in to -next fails on two files. One of
> which is common/miiphyutil.c and is easily solved (miiphy_init() goes
> away) and then lib/efi_loader/efi_net.c. The latter I need help with,
> ideally one of you, as you understand the code in question, sends me the
> merged file off-list and I'll drop that in, or points me at a tree with
> the merge done and I'll work it out from there. Thanks!

After talking with Heinrich on IRC this is resolved.

--=20
Tom

--7BAZpcxtep/0GiVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPpCEACgkQFHw5/5Y0
tywFPwv/Q5z7Hya4rJK7dbcuwNwuJ0ReMMdH3YgsDQ0iC7L0fy80Ce2BLMaHKBLO
fEqdy47HVgl1cUMaGURSAh8QKC7trP0jLLcJUMclEXoZ/G61f2k+Kx92MXyFNpvA
tA7gC772VOyFePOIUnffqDXb7eL7XvOuxQVIBmN6LLb9Vr0Vs117HrxWRVIRhP4T
LtXILOnAEgTsjf9kyKAlhvEoR+kpD3G4FKyCRzucsYrafPMAGfytbZ3LbojoEZ4e
ae4w30bcfYyV01pe/pG2BZAneLoqmUYxfb0tiCUHb6N9Kar9oGt4AUNp67g/Kdz5
NiJygxhuCJfgFwHC22zRMFfZlqcNH2tcnm7DCvn+VNggO9EdJBMSh0Gp8yCo8U3R
eCAxv75DTauPONFAapz5W/aXVdcyhrsqxA1QHhgLONCJKKiDb5A/0bleo7CDk2bz
WIyJC8ViUYQSvU749BlI3tG7ZKbnVhOlUTxy/SBY4OLwGjKfH3A01EaW4zDrMnSI
GVuG6lDm
=Jtnt
-----END PGP SIGNATURE-----

--7BAZpcxtep/0GiVp--
