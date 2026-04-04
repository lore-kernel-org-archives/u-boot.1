Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698BBE88D99
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 11:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE0183B8F;
	Sat,  4 Apr 2026 13:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ri8zdFLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A2483C14; Sat,  4 Apr 2026 13:46:53 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612C583642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 13:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-38cc0b91b01so20753911fa.1
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 04:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775303211; cv=none;
 d=google.com; s=arc-20240605;
 b=I1AgLmrhmfDFt7aM+Yy3OdB7OrPLHNTODc75QrR4BFZnyGA9BIJZdl5ozmbNgpzQC4
 90VFA+LmUROdmjES9b8ADjE2Jc7BK8CuwiQhp/aDAyZc6wFN9p3X2sjDdzg0jq3h4cGS
 GbuuI/KcshIPNYJ18HUi36lqeYpPEPEtXjxbZ5fC7dvVjGMAqBHfrTjY4NcBon7ES2TT
 /vOIG58holt8M1xp7F1+fB5lFCejktBW3JaDOeV+74Q0I+U3L2IbKuEmPzkzja/rhwRA
 SfUgcWF2VJNJSMYQcETRx6MSKFD0MSmUfRCIZXFAlCt8Glsqf0caAtWfdjSZEEty0KUj
 DC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QVd7nJxz0PCp57p9oMlXFfJyfUOfGeiM9BH7pSb3BiQ=;
 fh=dkZ6DCIkySrLiamv4fSrDk2M7Vdi2VmBSpHsTdOEUhI=;
 b=FsdzrBU0oV+zpOoCWrbQ34jFhxYk5k+mhc+NO0LqeNGxbfSrduJRjUYV0eK5wrpO9q
 pHqbvzPzzWwxliczQohwe+WPIxjPTURDGLSZqoYQW+zbn6I+LTCqIGg/ISB6dK9Gtg7R
 yHWhzF5zl19pYQAbibA6xDKTtEfeHEy906Yk9HGN3JxkQOJSEzQx7MSY2HNddEyUGzLH
 B51y35YbMDma3W8MzV6jyszd1JlcX7/kUnPSEajubhOyIDBDafAt2ytrI7qg6GvdFv5c
 vdcBV+2T/0+g68OKWcxbg0ZuT71ILVjKLKBL7GO+S8TQ/ezw6YL7L2tqeum1QNzosS8A
 d9vg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775303211; x=1775908011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVd7nJxz0PCp57p9oMlXFfJyfUOfGeiM9BH7pSb3BiQ=;
 b=Ri8zdFLEi0JWvkYBPtFxroFE4TwPmUXACA3LiDqry/dQfnU07x7EljsGIO85eMnQIK
 Ct0G/rIIJ54XHtAVkDlRPi7YLB1g62NWoJNSBtt3cEiG5jBhdY9CVOd0+QqL7HdtHY31
 3s23hKlT75pVm6rwc2zP1bp/9Ix/G1KOS01gxwLL+z49/QWdiMIoX+xlL7BVUjRtBYzb
 yYflHR6PVVJJANOdtll0NywpYwNEzOnHroJ6A3B8ESNNbxflW7MRVOvAIPMcFab+RN1+
 b9pAemSBfgoE1fFqH//vaXBbpjZIxhapiKbCpbKu4o/LhD4vq7kaudFSurdEeaIw4rYU
 sVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775303211; x=1775908011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QVd7nJxz0PCp57p9oMlXFfJyfUOfGeiM9BH7pSb3BiQ=;
 b=PYdIRkhjkYarqcts3L9lCwAKmNZcc2qcoZNZ84Yb/+jf8I08/ZtOHaY2OfkyJ0aY8t
 JKNP2h7DsrMfeArSpKkDgLxkxGYFu3Fy9cghqojn+I6eJJ/TareHyodwzUuLGHPaRg/m
 nTzDSJ/9oE8prMeJexv/Z8ohsJZYlMdnl9ZNSj7OypRuOhfTVzvLts8y+1e6nD47NUMS
 /tQZ77GsYdBRmojXhF/g5bpsWFlUmKMWbLOCnn8dtrl0KEbiSlFjsxZflu3O4ClXRZsq
 8ySAXxCqzLWwDCykbKhGwljPCR5toA6aML0HDgo149Ged+2GviaBquHtGdbR8dlzT4Bo
 24mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzoHNM9f0IWdO+YVwPZwRvULfYG1Egw5wleobiqb75d9vqxLT4R2DKxTQbLX6xGzoa2LO58b4=@lists.denx.de
X-Gm-Message-State: AOJu0YyU/z45ns/W/+rNG2y5MplznDpt6ds8jg0ia9OzgFWn8+c8wvXR
 1ZM5foUOwJE1R4EEnM0d+++MCndIUuHXn95CWfzcS2OfeYbtP/1RV8yoJfbvgTwF8GjH1Z6/MYt
 TlMAYv0ybkeqWwDB+RRijq4+LaAFek9U=
X-Gm-Gg: AeBDievmtrd3+wPPMHX7emcDzpI0gSbsTPcB2KqbQkDhINiw/rY2owQJJusAML4KSo0
 TupDPBcO4gqmqUdQEOu+RYyYx/c4swp/tNFq4TUaY6a3I/1jM3Evsji4NQQUkK467dtaJi1ScV0
 MvayjmBTP/S8UB8DPlv1kMi5lCbF1wjGEKBTXgUNimruGDFIBfrIzEqs4AHdyVzJ7mfmu8M4LvV
 WP9RfO20XJ3c+/drF4jBDClvRkDMmktR9mKdF0npq+U1+r6MMAoeOL//QSV9iDv0QfGkIQF7H9y
 Ydx/rlEOtT6AuLSzCnJzjhlw9VZZD0CJQ1GV35v93r0hDTgXo8klkv7v0yMQYO7rsCfQHHlEmj1
 WTaHnaXo=
X-Received: by 2002:a05:651c:1b13:b0:38c:dfb0:b6bf with SMTP id
 38308e7fff4ca-38d91c4752bmr17660771fa.28.1775303210252; Sat, 04 Apr 2026
 04:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <bf216cd8652419e9ce7b9133775a2ea4509fe763.1775121078.git.simona.toaca@nxp.com>
In-Reply-To: <bf216cd8652419e9ce7b9133775a2ea4509fe763.1775121078.git.simona.toaca@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 4 Apr 2026 08:46:38 -0300
X-Gm-Features: AQROBzAXZGP2iJhrH5aagxAgLJnnuE5c3tGp_VJEUvR4_xT4e77mZFrTWJrLJ8c
Message-ID: <CAOMZO5BHFB5rabbwbNdj0JEVHHNZUmJHKUmDDUN35CFN_UNHdw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] doc: board: nxp: Add Quickboot documentation
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, peng.fan@nxp.com, alice.guo@nxp.com, 
 viorel.suman@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, 
 marex@nabladev.com, sebastien.szymanski@armadeus.com, ravi@prevas.dk, 
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org, 
 tharvey@gateworks.com, qijian.guo@nxp.com
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

On Thu, Apr 2, 2026 at 6:29=E2=80=AFAM Simona Toaca (OSS)
<simona.toaca@oss.nxp.com> wrote:

> diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
> index 8cd24aecf33..53ef220d989 100644
> --- a/doc/board/nxp/index.rst
> +++ b/doc/board/nxp/index.rst
> @@ -30,3 +30,4 @@ NXP Semiconductors
>     mx6ullevk
>     rproc
>     psb
> +   qb

'qb' is too cryptic. Please spell it as 'Quickboot'

> diff --git a/doc/board/nxp/qb.rst b/doc/board/nxp/qb.rst

Same here: quickboot.rst

> new file mode 100644
> index 00000000000..07953a1b7e9
> --- /dev/null
> +++ b/doc/board/nxp/qb.rst
> @@ -0,0 +1,54 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +   Copyright 2026 NXP
> +
> +DDR QuickBoot flow
> +------------------
> +
> +Some NXP boards (which use OEI - iMX943, iMX95, iMX952 etc.) support sav=
ing

s/boards/SoCs

> +DDR training data (collected by OEI during Training flow) from volatile
> +to non-volatile memory, which is then available to OEI at next cold rebo=
ot.
> +OEI uses the saved data to run Quickboot flow and avoid training the DDR=
 again.
> +This significantly reduces the boot time.
> +
> +The location of the qb data in NVM is a space left in the bootloader by

Please use 'Quickboot' for consistency and clarity throughout this document=
.
