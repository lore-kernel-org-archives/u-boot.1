Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECF1C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448EA87F2D;
	Tue, 19 Mar 2024 13:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q35R2BT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7371787F50; Tue, 19 Mar 2024 13:13:29 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A014187F2D
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dde367a10aso3589345ad.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710850404; x=1711455204; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2TMNYc29zegxG4JC+vXhpKbIFu/HjRgTt8SQm+EQCE=;
 b=Q35R2BT3ZyVHCD5AMfhq4dUnsi3dgvnerRnRl341v/YZsxg96Ek4rC8g+V77DoJb38
 /Co4bpNAGhHPZc2jzysCl5kwZs51Z6B/BI5jXPlVrA44B4AiTTfe0FJCtVecRw/RqYc1
 D8bVglFTBRLtoHF1GXIiPfhCCUisNRTE+TjxCVIDokUtSATzyWrZbtJTWrcjiHMS+15U
 YkItxjy6D7nV4JYz59RMTIfYbCp36dLsZJt24m3bLmH7tFTCgewPTyOFdZdybRqDRtqx
 pl+Ohw4s6vNFW0A1wbDK73RstYPqTEnSNAltQWYjZmGJLljPK3tn3Am0AaTKU28tKjPS
 it9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850404; x=1711455204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2TMNYc29zegxG4JC+vXhpKbIFu/HjRgTt8SQm+EQCE=;
 b=Qjf421Img/1GbGiEphdfvfyZACFQ4QUfbPLMH2WrHr36KBnbXBCG/HiDuJ/Rr0CwZl
 BPFmgjCINJIsz90D5HtzauvMsEDu7cvxrqsicplQQvWQmQ0WqbSfosOMwaqvJXB6l/bh
 zP73HFfTXbrjkuVoiG5rAYxBG9hrSFY0z9a6ah16vFKd7tQBXDHDUcxLBUewA7CseW2S
 ZRTDI3LZIzjHatBL3bIXHLkicmVq6Bu+vCOUuN7lNhc9lbcUhpKo/2gpKjzmlibNXNoB
 0kA3xIHiRyAPKaJVQkX2nqo25c5CPBXi5VGQ47xVVKQq8/aQ8e/VzZNYfuk6WOsJKQxQ
 X04w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURp+ffvThCOs6HXsxI8i13N8EAv4PHiTcdRcGeL7m0J5FKLjRQ/9AVg5+WBi8ZA1W1jv2Yac7TQ5Y9hi1s5s9ezCfq1A==
X-Gm-Message-State: AOJu0YybIoGmPA7eMH3u9jOuFT6bNt5K6+fvtjtEa9K0UpMxidEQC0EU
 8hHJONgdnq3Gq8mSJK7wDzA9Q//fsKZFKOPMmOZnVQdFHRRXJJFIez1P0pxb3iZIH6wUtRQUbre
 N7GTx21NWFkHMfFiJkzlvh1Vv5R7hpeV3bGY=
X-Google-Smtp-Source: AGHT+IGsojLE3R9dQgPRdob1V3POTxvMoGKmtctBvaOUo+pbiPpLce5iNNK+Ra2r3d6VCY50sIZLMZqoTHKek9atwDA=
X-Received: by 2002:a17:90a:bd87:b0:29c:7614:1cb4 with SMTP id
 z7-20020a17090abd8700b0029c76141cb4mr1845321pjr.0.1710850404400; Tue, 19 Mar
 2024 05:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
 <86o7bazheg.wl-maz@kernel.org>
 <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
In-Reply-To: <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 19 Mar 2024 09:13:12 -0300
Message-ID: <CAOMZO5CNgJUbDGdyP4tS7YBXPqcmyT+FkhaF+phbR64grA2i0g@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: Marc Zyngier <maz@kernel.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>
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

Hi Pierre,

On Tue, Mar 19, 2024 at 8:39=E2=80=AFAM Pierre-Cl=C3=A9ment Tosi <ptosi@goo=
gle.com> wrote:

> This means gd->arch.tlb_addr pointing to the live PTs during setup_pgtabl=
es().
>
> In arch/arm/cpu/armv8, setup_all_pgtables() runs with SCTLR_ELx.M unset.
>
> In arch/arm/cpu/armv8/fsl-layerscape, setup_pgtables() is called twice:
>
>  - early_mmu_setup() calls it with SCTLR_ELx.M unset;
>  - final_mmu_setup() overwrites gd->arch.tlb_addr before calling it iff
>    CFG_SYS_MEM_RESERVE_SECURE is defined i.e. if CONFIG_SYS_SOC=3D"fsl-la=
yerscape"
>    so that <asm/arch-fsl-layerscape/config.h> gets auto-included through
>    <include/config.h>.
>
> So can CONFIG_FSL_LAYERSCAPE be set while CONFIG_SYS_SOC !=3D "fsl-layers=
cape"?

No, this cannot happen.

Only the following Layerscape SoCs select CONFIG_FSL_LAYERSCAPE
in arch/arm/cpu/armv8/fsl-layerscape/Kconfig:
LS1012A, LS1028A, LS1043A, LS1046A, LS1088A, LS2080A, LX2162A and LX2160A

I saw the original boot problem with the i.MX8QX.

The i.MX8QX is part of the i.MX family, not the Layerscape family.

> I suppose Fabio and Stefano can answer this and/or help with ensuring tha=
t
> setup_pgtables() is never called on live PTs.

Let me know if you need any clarification.

Thanks,

Fabio Estevam
