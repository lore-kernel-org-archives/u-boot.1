Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63953D30000
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A84288E0A;
	Fri, 18 Oct 2024 14:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqaXEZXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786D688E74; Fri, 18 Oct 2024 14:33:40 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315E4891AB
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539fe02c386so3190606e87.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729254816; x=1729859616; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVxT7z9Tad0+qkwGB/82IVFM4QReyANweYAxLKw1GRs=;
 b=NqaXEZXQQQPiEp+/Ottf5OS/wvBXVH5a8GVZNK0PQJkxX8zgPUlPSopa6p5MaosTj+
 U+R9saJ9UZmAd0hJkt5OINtB1/RVq81RiLvey74asLRF9l+9FQ/inWZ4FEovxXIdkcLb
 m221rftUhXfDtQRp/yKtLte8NEFIk+PyyTJh+i1VulDeVc51q8NiFzUKB78IThJcTlkd
 jTCRFwvwjyNb2D1SCq5BIMv86BN/SxdGsx2MHzMbjo75RzttqNlnvbid1dh9jZT43alw
 L341dKJw6a83owbbiDcgJF/StFNmTN7sEPQbi45mcd7G9cVOQAj95f59NLwlWYiohyaN
 XtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729254816; x=1729859616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVxT7z9Tad0+qkwGB/82IVFM4QReyANweYAxLKw1GRs=;
 b=RN4gINyxpkIaxWcgSbOCtWydL/86nneCG0NYsQwyIxVhq/ewgcnfOE9lFW7JW5D/6H
 CHAlBUD3c6wmExBgDmpWJY3VDWeAFmAKif36suXwY4Vh3gI/0G5zhOhxBNK8K4yrx20X
 5RUcknozc27X9ubz/vfP1VEPBKwdqUnJTG1LHm0dBrMTheXOYY1HLeZzQ+2fvJiDlhjM
 OlJt8rvsz/2O6NGwaJ49xgbzBCp6q+0/VhM33Rvb3b7Linb0v38JbONImbA/0/GPCmoW
 Qex0eLPcSrJ5v98zL8AXZPJ6M3lahKN7J6av13bjkiIDnhcek0jUUqGaPk0NgqmZ9Sp9
 vfHA==
X-Gm-Message-State: AOJu0YytM5tD2G1dnuEgP89ukImmYMW6rI508CHW8IewmwQgDlgLsFDH
 ACefbPG+nuDXQDneccMyDTlq7h5C8UTl9GzD5+uwM4li3sUff7mfd1L2XBg3o9wCytEpRl0YdlU
 lxExwtAtRo1Ye9t+Qe2v2FWilLsTtjA==
X-Google-Smtp-Source: AGHT+IG4ejlggmDFp67hG3WPNqNAEM3Gxf+dzjNnQTbM+nH1l4aScbA3IJQ+UBMPmNn3YC7R+zjFjSCCRXOyiESpMP8=
X-Received: by 2002:a05:6512:1193:b0:539:ede3:827f with SMTP id
 2adb3069b0e04-53a0c734bccmr1973512e87.24.1729254816265; Fri, 18 Oct 2024
 05:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241015234502.129086-1-marex@denx.de>
In-Reply-To: <20241015234502.129086-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Oct 2024 09:33:25 -0300
Message-ID: <CAOMZO5A0_=QUS44Voa6G=y5gn3P8B+acNi21oFeCbN8cYqjYUw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6-dhcom: Remove fdt_high and initrd_high env
 variables
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Tue, Oct 15, 2024 at 8:45=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Remove both "fdt_high" and "initrd_high" environment variables
> in favor of "bootm_size" to safely contain a kernel, device tree
> and initrd for relocation inside of 256 MiB region of DRAM.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
