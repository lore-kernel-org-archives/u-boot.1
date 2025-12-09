Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E27D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C50A83B24;
	Tue,  9 Dec 2025 15:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kbWeP4PF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A36083B48; Tue,  9 Dec 2025 15:43:53 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B74D83A94
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65791c35134so2959841eaf.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765291430; x=1765896230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9le5NNg0bLGAHCoLkj62AzBzWyX1n+bJHMNjoWtRbFs=;
 b=kbWeP4PFQS4LP0LXR1IV8FVeGycyVzwSKhf2eXfXhwOdPcv9A9LLldjyotvKDsM99q
 1vRi1YF5UrWIR7M9+1SW8Yi68C66caBt3BwEQRH5b/oD9mVjBVh+7fJqPp07gab+EOOw
 k8AwZHCVZ04HYsItNQwOJ4EesvYKx2/cerhc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765291430; x=1765896230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9le5NNg0bLGAHCoLkj62AzBzWyX1n+bJHMNjoWtRbFs=;
 b=dQ9d18h80AYjdNXIAUXQXFA5Apt9suLKgyDeCJnUWPoYbHzscMJkHQRf4i6bhV9mc5
 OmKrdgd8bdZQs/Wq3OQIBmB2z8PySDO0h3/6gLJvP3fzziT6ws10+KKtleflUnFCGpGo
 SdJiqmmznYcwBGxX4HMXfRaLYIU3fi2ywQuj3xPcXC0qtF+3BDd5ZsTVrAoVT+8r5FqK
 T04GAI1crWLyWRTA1u3Mj61kMUULOoz/iAkzIPM5O0qnQy/ibhC9X/U059DCzNk7hkKM
 RrLtf9VUXbtsQhBxjYcH6JSwKZBdeA11Y2vyjZMLhWdpy2ov8FyRlsir7+r9kVJpjCpv
 kYjA==
X-Gm-Message-State: AOJu0Ywzb4AfhjtfqKNwSdDc4kcPC9YsE3O3IFwRMhDa9LDJVDL35uV2
 +15LmgPTNPNtiGnaotFA+jJygW40LVWrwJCIzXtxgHwPHxN3tw6IqUG3PV/GXJWVJDI=
X-Gm-Gg: ASbGncuLfXT9elr2ygJq6g2Q2sdG7hXW8oWBL+PAJYdjWYGquKDArnFPoswN9WEM/Ez
 G/a7KO6WHsP0ZfoXDp/uiHPEt2R4QE+YsDLntYt3USsAZdT6WhfRXE5WSC++UfkGdysDEdkyPPA
 hMUgjLsoi41gmpRSEy4UfpkAYk+wt939oqWOm1+ifK90eK/ZbcjjxAgdFGf11nP+Nfb/8Xmk6Qm
 ETtlUPHOD5XI7TIFI8dnCEoKDhlbb6Le1zjBuS8p8XHsmyZppV0IFhiTTc9z2RzUBzzskqhIUYy
 cQ3VCeRZ3dAWg+L9R3UDVWEHuxDunYh1GM2Gnm5j936zVNcK5Fc2vzRzestyCtEMxkxIwCKENOz
 YK+6DAjv9gBUKDSxkQAZqaNwI1sDe1yyEIv9pXsEW/21USgG10nft6M6wf05TymAf+Gv02JfXvl
 W5MJ7Q7DAe0cPz/ygIvSIOnLwaYQbcsuPyVyteS3yprSlN1McYAA==
X-Google-Smtp-Source: AGHT+IExh28uitWSIlUTpPfHreN4HW82LJjc5+457IOt0geMGyRey/qOrgTZo5DTTFjHNOQ5ZM7lTA==
X-Received: by 2002:a05:6820:22a7:b0:659:9a49:8eb7 with SMTP id
 006d021491bc7-6599a95a331mr5163687eaf.59.1765291429721; 
 Tue, 09 Dec 2025 06:43:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aa30042sm11234169fac.4.2025.12.09.06.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 06:43:49 -0800 (PST)
Date: Tue, 9 Dec 2025 08:43:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Pranav Sanwal <pranav.sanwal@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] arm64: versal2: Populate DRAM banks before page table
 size calculation
Message-ID: <20251209144347.GX303283@bill-the-cat>
References: <beb76794e4982085944bf167f242e6f52588dc44.1765289863.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tf6ztUk1lWa/K/TN"
Content-Disposition: inline
In-Reply-To: <beb76794e4982085944bf167f242e6f52588dc44.1765289863.git.michal.simek@amd.com>
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


--tf6ztUk1lWa/K/TN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 03:17:45PM +0100, Michal Simek wrote:

> From: Pranav Sanwal <pranav.sanwal@amd.com>
>=20
> Move DRAM bank detection from fdtdec to custom implementation to
> ensure memory banks are populated before get_page_table_size() is
> called during MMU initialization.
>=20
> The current fdtdec-based approach populates gd->bd->bi_dram[] too
> late in the boot sequence, causing get_page_table_size() to be
> called with unpopulated DRAM information. This prevents dynamic
> page table sizing based on actual memory configuration.
>=20
> Parse /memory nodes in dram_init() to fill versal2_mem_map[]
> early enough for MMU setup. Supports up to
> CONFIG_NR_DRAM_BANKS (36) non-contiguous banks with high memory
> regions (>4GB) and use __weak get_page_table_size implementation
> to estimate page table size based on the populated DRAM banks.
>=20
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
[snip]
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 120393426dbf..5be9513f5238 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -1886,4 +1886,6 @@ int ofnode_copy_node(ofnode dst_parent, const char =
*name, ofnode src,
>   */
>  int ofnode_delete(ofnode *nodep);
> =20
> +ofnode get_next_memory_node(ofnode mem);

This function is in lib/fdtdec.c and so we should have the declaration
in include/fdtdec.h and while it doesn't have a kernel-doc comment
today, it should. If you want to in v2 make 1/2 add the prototype and
comment and 2/2 use it in mach-versal that might be a good split.
Thanks!

--=20
Tom

--tf6ztUk1lWa/K/TN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTg1ngAKCRAr4qD1Cr/k
CvthAP9Jcdo75grndAoFLSQ/KIod+1d1SLRcu9FU+3SYcf+9KQEA/yofcQGipzBW
dj3eh7ZoZ8+PrdLllBqS9I6r8aYQ0AY=
=aLIV
-----END PGP SIGNATURE-----

--tf6ztUk1lWa/K/TN--
