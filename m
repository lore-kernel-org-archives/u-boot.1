Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E9107BCE6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBF88420D;
	Fri, 13 Mar 2026 22:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+CDL0A2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAA18423C; Fri, 13 Mar 2026 22:19:27 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03CF98419D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-38a7edda377so14522601fa.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773436765; cv=none;
 d=google.com; s=arc-20240605;
 b=cd5NPY66xHiUyR30KukDX+eeMAzufo5nl8r5vQgQUFaJKwSnuPz0Lne2gNmQkW1NTy
 2VWBPEVSyM/dsH+HpMfDVoPZ40L5gW73MQNt2Ml2i1K8prCi8qlc9JSAn+VBnhsfxXfU
 PyThnf1RyFMva6EBEE6tHnr2bFoW/Ti8li3uZyJzRhwxLj5iaKBb5+MVYnelYQyTYsW2
 tcyZHaO24Z+XBRqEDlTDqasrAwKJD2NiYz60wryiWLFa6GRgz89y9eSI19BMb9qkpc/h
 IW+6/3JOevCh0azMKgxkmal7R+7MzeSqcMxi1/nKZaOcfCitIaLtjVRHbDkz/3sfkt2y
 XPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lNUv10o+qq5dRKUU+s36oDDbltlNTFFmKW8a0m1Keu8=;
 fh=A7OIrilzeTf8xVuh7p9P9/WtBvPKB7WdnPdoQqxv9YI=;
 b=J4pp6y8KuEYDC6uY/5XngL1XTsx4ZQwtjpCO2GkiMGvjoiTOi1eAjsz4AWTU1agR/f
 KQ3guEj+L1K7Uk2l95AhBD4LekMH5g+82awBMctVC4f5kPDcEUzz/03ZPfn13ZpCefpD
 m8prLp63syMCWBM26zlYn3GmsQoK88JZ1RnD49QWwk1C2dIYXweJQSQWOMdGs4pMaq8W
 jQuMqbGpa+nURtPoMYrDgTqAlVsuIBEaTRK8rKklIKEWIAc4myAqj3A4KyqGuMFkfRvG
 3UiKz18sM7j0IFnMq881ZXxl+xKRIAlb2Q432tFdzYwhiTZODriUoKBUpTA+VG4Y77Hb
 ktJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773436765; x=1774041565; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNUv10o+qq5dRKUU+s36oDDbltlNTFFmKW8a0m1Keu8=;
 b=H+CDL0A25L9h2N/Ce6C9dvysy7otNnJ9Y1XdLQTOzWJmTArwYaSxN7sjqXquzmLk0B
 lNjbBLBmHuUeOhekpBUV8XrE674bc5Nmw5TS2U8K0HOSPCPJybFw3RgGYIHI17qrcZMh
 f2icwpMWBCC7hqkGOC/FhRV4lKbXKNS6sQra5tKJRI60blhQJn/WcSDEzL66mP2YKx0v
 5757NMSA37Rr8sVLNVaLc9RpE8HAz6tXvuHVM0ulMsyOAnwH2Sq9i3jL/nJY9VAEt8fi
 mvv8FpdKmDo+/t8BXJB1YKN3NLh4WWnRyjV86SewzVrfA9DY1g5nAgS5A5Ukiu8GvgHF
 6TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773436765; x=1774041565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lNUv10o+qq5dRKUU+s36oDDbltlNTFFmKW8a0m1Keu8=;
 b=kx/5qwAUyGD9UL1GE2b2QOkTLXFKbJ7tZZ+G6MJPyEXsBzY4AJET8K/CTa9kOrzCM1
 6cX8nDx4J4e4WqxDcbx4bKkYxn8pjQfif8NvmCMDGvsbPCxpe6fgIA9xjprh68ntvpTD
 Db+UXC022NW93DqdqmVrm6w39dlD0zme15KbpUcx22oGSYTvIREok2AHGCx5mx2XSNJ+
 RuL6gYyXkR0bhCGEicOnDehhywICf+vZDLSV7MIEiqoH6y7dH/ezonFT4Zlx9+8adtGa
 ozcYnh4GkUxALPUGREQkGoXH/clPu40DG0FRjfnopOYsX0eo8f/5/cr1cGru/mX3Xnve
 qW1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkvtbiDl3lVE8DzYM5VLSqdtbNNzF5oSpMSQvUWaZRujihdGQDvtNr0t/YylUYLEPpp4KGdVc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywnv3qyRpT4XkaIKnY5P+mtQ3O7faB6Pv/+/bVLFW/OUPaqWIqm
 3HXel6Ue1X8lEAPoqfNEH4GpQyB0K0y10rnUkKh1inYB2b4036N/1kqiz2D1WUbXdvRmVEZjq0a
 PJ7gUc6BiGrR3Ee5a11g1xcJHqe8xuGc=
X-Gm-Gg: ATEYQzyKTzclNG9Dd9f6t5a/5Qe1S0swdkwPqNeIrgLcIK+HUbQEelpTwyvDMTmV2em
 WaUZq9KaQKvIX9nUvmvsvSJ/xsDGOGXoTUo6VV6YFGw3JT+I4fu+2Gh0vkNBCBazU41Oh9WAcmM
 8xWJ/2/h15ciTkJhyFXViI56kry7fthkfLAU4yHZnxPlB9ORdqH8pINAmOS8lsEv6UE1z5zL/a9
 fnSEKreBTUmCQyNpubqIvMOxC72hr96uHpSrbefB+Qw14WiSgzerOoFQIXZny3TVSW5OPua0nT+
 QxBOJ7Vo9u3XklHcApaguYHWw9Beexjpw2ffGZgE+st0WTLqcaqT3Y1LpdTZmflcxoESo+hR
X-Received: by 2002:a05:651c:440a:10b0:38a:5f1e:5a53 with SMTP id
 38308e7fff4ca-38a89831374mr13607191fa.32.1773436764806; Fri, 13 Mar 2026
 14:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260313210005.781958-1-festevam@gmail.com>
 <20260313210300.GH502704@bill-the-cat>
In-Reply-To: <20260313210300.GH502704@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 13 Mar 2026 18:19:13 -0300
X-Gm-Features: AaiRm514JGbJDri2ZEr_lObx9kRzFZJ4UOCChY1bcQr0NTkn-ckrVD1MLYem_Mg
Message-ID: <CAOMZO5Bc_Xq2QkYQxMdqa-c8MkHX1h9EJhSExcO0Sq=cBbXu0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain version to
 14.2
To: Tom Rini <trini@konsulko.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 marex@nabladev.com, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 13, 2026 at 6:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> As this is no worse than before, OK. But we should really be globally
> consistent about toolchain wording and that CI runs with the kernel.org
> community toolchains.

These specific Arm toolchains are required to build imx-oei and imx-sm
binaries only.

The U-Boot binary is still built by a standard toolchain.
