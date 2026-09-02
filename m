Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1304FC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 07:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18B0180EAF;
	Wed,  2 Sep 2026 07:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VXkTdHU861hn; Wed,  2 Sep 2026 07:24:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788333859;
	bh=ynPd2z8Knha7XUtbdRUrxT37DKRhRl+rGCrgzTsdaAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDCGokgl2Jcjt+Z8RracEEOzmg/Q612U9oi66VLgz0UIKeqdSjQlptgg3wQUFh/aG
	 woYRiNhyhbz44BRD0j2l6wZTra1WdqnqIO763tyRl8NIk5k0R7CSp2ntWPFpg0U9+L
	 gOJ6L8tedJmv42Ju1FaSJ6K2x1rXjBg8ICv/rUBlfjkQLlRqaRMmKipnWQe8Wsiq7H
	 4/3JZRQ8bH3bzD6N7IIaXd2cnXbNe5mOKgcVDw//JL8nnrASkFLkRerS1Gf4n163xp
	 F0JLfReAvolBMxzWa8iCU6VFZfWWQh2DYIv6y4G+eM29+swXHPVtsCD0snJfUAd2gr
	 3BqB8JEAGUaEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 930F480EAB;
	Wed,  2 Sep 2026 07:24:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C441A498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A99576081F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4Y_v5QsbrCe for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 07:24:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=brrQPt9G
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B63260811
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:24:13 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66dbce0b639so506770d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 00:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788333852; cv=none;
 d=google.com; s=arc-20260327;
 b=a+vDrF8YPZxVL+C2ggeuySPie055hZVhnuX7A/94rGSacI4IvChuoNrZcJ9phwYw1w
 jQV57+Ju3H827zhS03JDZCwL5hnKuS35+4Dx2YlMjedoroqtVqjdaIk4DycYXEP0Agkh
 i4FY/texr/eaFLAZWMI5mKSepibOGCDqfnkvMJJXocXpuQZfXe6rszl2psD7S0n70Lxg
 r5SaTLXGCNPrsP0Rq3ac2Hj0Z1LphfUhV9N0/+7Tu5sVFkK+OkmpPrkFDujBZpg4IQaj
 xGaCC6OrNYon/s2XLh6DNwPnHy5QWnfEGLhYaceccmtnvEMU90rKFycoCwL/KPx+GhfL
 tVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ynPd2z8Knha7XUtbdRUrxT37DKRhRl+rGCrgzTsdaAE=;
 fh=ArjvCS+yOs3oxqSaO2Q7xvW1Fpa/Dck+AyrBr4xN6k8=;
 b=dLuDln6ueo18U4AGqRCR3XGlqYxkEQP/9bL+9pjZrZt1s1qwbUmcraMujIQYj6R555
 PEJzlPJ7T/pjbGODRsKCv/SWmrEn9GrwhQMtFFCF4JVF2bYonW1WUYwWoaNEkOJDMlzg
 AfY5rGLNcY+WwV8RVi/zx+1ReH8/upVaVbuYtSdRI96hqKI1QC0UpGxUv2OmzdO6742P
 zfNsqBgpHmfNmAvuIGfYF9XMZf8n7RFXZp4bFetZ8z8Q1MQKdCgxqjC7zVq1UltAHjVq
 NldZX/9fTZuH/DGYeN9LQ4fUzOzGiXUVr24TtDTssU8txjcc2GD4C86zOIiITJUUk3Za
 ruZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1788333852; x=1788938652;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ynPd2z8Knha7XUtbdRUrxT37DKRhRl+rGCrgzTsdaAE=;
 b=brrQPt9GnuZF31+DyEtZbqMWHyihiy4tCctlJxK26SlKFngRpfD5tu9KMOC7996HDP
 C+qGCnWdICCKTu6QcjFaH0nGDnMVaESDIRRaZGeHmPN0dMuKVqwbGbIEkuCGg6Cs+/dX
 3jnZzFso3J4lOKhWpNBuKNg0ZjPguwbZYgQw3L3NlAtzXdRvMmPx7QdFfMu26z4G8tFE
 jEiNQPs/a/WICkjbOGPsQ+vo2KhU8VzdJWK+Zo/rZl5/tMWZny/9UsLOgdJiHm9amchA
 HNJaCmHZ5K+ON5QD2MFv/4+IqChLoQcDsJ987kAGxP4QXBVvThSVTHYzM8KRPLsRlIlc
 cH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788333852; x=1788938652;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ynPd2z8Knha7XUtbdRUrxT37DKRhRl+rGCrgzTsdaAE=;
 b=T9bBJdJ3xKZdl65Afp4q1zHWsyOm+drrScX9WJlIms3kCkPVxPy1q+c+5uq9UZYjfe
 w1QHpK4wP5eXlpSVg9NPXATXnjRvly86weW2k4HqUG0BuRva3YbYEMbUbbGVdPVoZ2h4
 imcBjZErxE257dxkbNaU2MirmAEWp31unjgL1/tmvsAZpt9Kt3B6AAmloy2PNok5IYDc
 GRMJQ2hO2Au/Rnf0IvmHmBXSdahaP0uk+UjkPDoLmOQ+rDMyhgYrYGfgRncQkVnx5a2V
 18I44QJbobGXbH5G/fvlEKJMK167JIIXlnZOFuSAO5auRMLu4SkcZGaRod+8a6YrCHp6
 i5xQ==
X-Gm-Message-State: AFuF++nR1V5CgpgxbYglfQVzvx/Jr/HH/vueQxxneNjufugCnBI7ADx9
 ASv6W5zGx4rCnuI5V15eYGVaOlGkE/reW+uERVoIlJl29EAMNAPHq0VO19jcNi5vxhaLR4zeHPf
 A7AXyN9hGshW2Bo78MmDUe9KaGAAyWBfoCeUBBW7y
X-Gm-Gg: AYBFou3DiyBAMl5v2ljstc1eiA5eCOx1bhGdeMCHjcwXz1CVY0EOucZcd5td0zfACFS
 gcREr7RBBQWh7Fwib5gI9FF43e/p+JX+GOb/D19mF4sXcIyMBmfjG0K3TU5kMaJByzmWexHMj5q
 ixAbjdBwfXUXEXoSLx8RwT8QMO8KoPRy5UFQVWZr2rE9qOVQisVKFhyQ1tY13SSOUUNAslCexRV
 d2/1+m7Z6k76/L2NoC36uM92V0uPru1I87ZnbFnEmQEmEcvFW9D3IrvqSyD5lWY/WLFL7bn4M1Q
 nOvrmQIVn4cpmMa6AaFhqXaze8MmkD75Anim22n+7ylHWrMpX/KXkenq02QU4j0fH/ADnYIxTyp
 AEQR+NpJH7nE=
X-Received: by 2002:a05:690e:d03:b0:66e:54a0:cdd3 with SMTP id
 956f58d0204a3-66f9bc2e8admr855250d50.42.1788333852389; Wed, 02 Sep 2026
 00:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260827051212.2683473-1-pranav.vinaytilak@amd.com>
In-Reply-To: <20260827051212.2683473-1-pranav.vinaytilak@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 2 Sep 2026 09:24:01 +0200
X-Gm-Features: AcwNN1XUWfsE8zaC0FVBW3S2WBjiLUlkAuxIicPGLwq9kxw0MjYo_tKJDkKrKEg
Message-ID: <CAHTX3dJpgBwrM6A32z3CGN9hE2bOqdgfrqRgvSE7BWZcJC4BMw@mail.gmail.com>
Subject: Re: [PATCH] fpga: xilinx: Check bitstream length against the supplied
 buffer
To: Pranav Tilak <pranav.vinaytilak@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com, 
 padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>, 
 Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=C4=8Dt 27. 8. 2026 v 7:13 odes=C3=ADlatel Pranav Tilak
<pranav.vinaytilak@amd.com> napsal:
>
> fpga_loadbitstream() receives a size argument describing the length of
> the caller's buffer but never uses it. All header offsets are read from
> the bitstream, including the 32-bit data length at tag 0x65, which is
> passed to fpga_load() unmodified and becomes the DMA transfer length.
> A header declaring more data than the caller supplied makes the DMA
> read beyond the end of the buffer.
>
> Reject the bitstream if its header and the data it declares do not
> fit within size.
>
> Fixes: c26acc1a43b3 ("Remove bit swapping in Xilinx Spartan bitfile loadi=
ng")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  drivers/fpga/xilinx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
