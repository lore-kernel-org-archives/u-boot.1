Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3771FC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 13:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FA8832E6;
	Wed,  6 Aug 2025 15:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RSaLhQvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0318783303; Wed,  6 Aug 2025 15:54:20 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36C08327A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 15:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2eb6c422828so752779fac.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754488456; x=1755093256; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdD6v05S7bv3s2D9KvLeuMufnqKER5FQommPADVX72E=;
 b=RSaLhQvqVXgERDiB5NOj2Rk1bQGkfIwFy208YcYJDk+y5xbr1TG729kKMlrCd0WIgA
 5qJDOQ6C9rn0/GeiOdz/moocQymcN2fVLBVmozY+gXEMmB+3UhhsqWP5sUkTRCLMhtkK
 Vy5nXEuAVVA+4j3ElgUKUTgiZ+o+qmwP0wE94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754488456; x=1755093256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdD6v05S7bv3s2D9KvLeuMufnqKER5FQommPADVX72E=;
 b=FQuI/FcpOezeX7qTY2X6rrO/O//RgHGVTI5vl/Xya8D8BOVetTOImEUf66UMXIew3r
 cOAcUZ4ZiaCEzlsICKKC2/7iejA/t36qXD0m6x+nwF1tlVc6hzby21YrTDSEhu4asUKH
 NQFEXaeJgdSxEd8nEbj1mAFVo6608LeOIG1r0T//6ZXHNibpMj192DIADUKdtgzguTwQ
 7P5q7dKZpO8c+YeHwANkuJKHvefWfU8SUVmZP5Vd8lP5c2CgS52BYY11d6B4jugdRIKs
 53Gb+RdHcpZl+xjrMUMiriITHX3W0Sfxm8AhJe57DEKN3VVUZNtC0uUimnQxb2Ot9qsD
 r+iw==
X-Gm-Message-State: AOJu0Ywq0gjcQaDCWlvmN/0Cl9YDVBjc/fIxhFK/0YbHkcVmBLZPZF8C
 jGF+PmcVKjZcTtwRNQcMhiywsAQk7OlEDmR5ApERBgG7FwTHh6hns2I0cqvU5poSeVE=
X-Gm-Gg: ASbGnct5K6oF0DXPpjR+OsoeCtbKubWF8vUxRBVhQEHa4te+9MUilYyMRBaI9c+8oP8
 cpseR62PKbRx0hUxMdd28K5RRDd6ENPJu31kWqfP21ONOymR8sxfWInCl/p3pWUcstfmVZAWvho
 A23UYgS+umqD+7Q82BAn/5O4hFcA297By7SAmW0jVmjux/to/TQ/MOFE7y9ZJ3UtbXiRmN67IsC
 4IKq9nFzvJ9zsgYk3glwS4PcIcfkiHDm9qsU/trgIQ5KqAXwBj0IEKhDXNUssI6AoiFFJa0kRB1
 Bndf6bIEpuJUjmq9ss6vFuRxgepcHNdNTrS/sJBkkEYHVXxxz9reSj58dLviqRKUjMvwHlaSo9Q
 tt1JCrC899gTvBgXyu/sbMguCLyCcRKknLSUQ3WLGdLvaAknmQMv9FB0H
X-Google-Smtp-Source: AGHT+IH985nxGOyZVNCwUjy7QC6Mwo/Gp3z8E0fCg/pgVyKqcvaUeUmAF7RN7qCrPu6d9PbJ4CrrLQ==
X-Received: by 2002:a05:6870:1c6:b0:30b:70d9:b957 with SMTP id
 586e51a60fabf-30be2c6ccacmr1882642fac.17.1754488456373; 
 Wed, 06 Aug 2025 06:54:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a7120beesm4201321fac.6.2025.08.06.06.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 06:54:15 -0700 (PDT)
Date: Wed, 6 Aug 2025 07:54:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak
 function in cache_v8
Message-ID: <20250806135412.GM124814@bill-the-cat>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
 <20250806032206.16688-3-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fXsOcGy6RjWAVHnJ"
Content-Disposition: inline
In-Reply-To: <20250806032206.16688-3-boon.khai.ng@altera.com>
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


--fXsOcGy6RjWAVHnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 11:22:05AM +0800, Boon Khai Ng wrote:

> Add weak function dcache_disable for undefined symbol error
> when dcache for SPL is not enabled. The dcache_disable function
> is being called from spl_atf.c file
>=20
> Add weak function dcache_status for undefined symbol error
> when dcache for SPL is not enabled. The dcache_status function
> is being called from common/memsize.c file "get_ram_size"
> function, which in-turn was called from "sdram_size_check"
> function defined in sdram_soc64.c file
>=20
> Add weak function mmu_status for undefined symbol error
> when dcache for SPL is not enabled. The mmu_status function
> is being called from arch/arm/include/asm/io.h file "__memcpy_fromio"
> and "__memcpy_toio "functions, which in-turn was called from
> "cadence_qspi_apb_write_execute" and "cadence_qspi_apb_read_execute"
> functions defined in cadence_qspi_apb.c file
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

The callers of dcache_disable/etc should be doing:
if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 ...

--=20
Tom

--fXsOcGy6RjWAVHnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJNegAAKCRAr4qD1Cr/k
CiMVAQCylH+AvD/MZAd1PuRSdoI0xqinoGt29/NRb5GVtc8b3AD/Yt0EAXebet0r
3HXmKiPSp07l6Gm6yhlsWRRYmWwqRg8=
=Zv0U
-----END PGP SIGNATURE-----

--fXsOcGy6RjWAVHnJ--
