Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DCCC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 15:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F81587266;
	Mon, 30 Oct 2023 16:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sczpvi7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1198287122; Mon, 30 Oct 2023 16:24:45 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EDE87A34
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 16:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66cfd35f595so27195666d6.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698679481; x=1699284281; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hdaAN5YPp/CHC2JW37FOm0DxydaCCaL5wWShcy4/8Fg=;
 b=Sczpvi7mLV+uqy+TIO8xhzzv047KGXqYA4dGn2+pP+o8iLLQdnfmX+zCSocrb0t5dI
 Kst9+STOVkhsLSmetU8YElSQQFPQW3FulSkeN2qMAFxdV+BjYRh+UDyLkdL2kXyovmKa
 FlwZ6n7iCMl79OPB6Hd3wNG20Yb6EkOT5GaWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698679481; x=1699284281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdaAN5YPp/CHC2JW37FOm0DxydaCCaL5wWShcy4/8Fg=;
 b=EGDeGr7oxdoq787HA8vWNTJoZErMNqetV+ISLhK0owS4HuIO4+O1q7Jg6tzN+PEDwo
 FopVN5RCpRAgqe4hVLAjjHuDk8pDClu014NcndTN4mpt4sTR4U3/Rw/QuSO39Kj1sd9r
 15YHGR7B8viPKCc5aLr9mtQilYXzVSg9xiNq9XqQ31jex4BRe1k4IYSuBHpsMvHf6Cpl
 OqHJffQJO56lAArXUTdwRyb+4TLKEAzYP/GkuiVinte6t4mr4040Q5SO9QOSYCLJRpoI
 7jtoNWMWxorAF6Rm//+lrNeH8zqf/vnYAkFfb+mO+aKvajluBIzw245mCm+q99QD5tTB
 JMRg==
X-Gm-Message-State: AOJu0YwZ8Vz7AOLyzPySvbQHdA/zn328JvW+vesyYdl3GTwNOukOwfcg
 Gm+WBCkAypxH6iEcKrr9QUHI4Q==
X-Google-Smtp-Source: AGHT+IHGpyNsX8MWTN1+SO/bst66HJZYwVvbPlnSd+nPNrPXRxFjEe258EL5hBmR95V62so1DanmoA==
X-Received: by 2002:ad4:5e87:0:b0:66d:2785:a2b0 with SMTP id
 jl7-20020ad45e87000000b0066d2785a2b0mr11668781qvb.29.1698679480882; 
 Mon, 30 Oct 2023 08:24:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 z16-20020a0cfc10000000b0065b24c08994sm2593311qvo.128.2023.10.30.08.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:24:40 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:24:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as
 pre-reloc after relocation
Message-ID: <20231030152438.GA3621286@bill-the-cat>
References: <20230820220316.3517102-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d4Gtrk5iK85tNlkQ"
Content-Disposition: inline
In-Reply-To: <20230820220316.3517102-1-jonas@kwiboo.se>
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


--d4Gtrk5iK85tNlkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 10:03:18PM +0000, Jonas Karlman wrote:

> Nodes with bootph-pre-sram/ram props are bound in multiple phases:
> 1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
> 2. At U-Boot proper pre-relocation phase
> 3. At U-Boot proper normal phase
>=20
> However the binding and U-Boot Driver Model documentation indicate that
> only nodes marked with bootph-all or bootph-some-ram should be bound in
> the U-Boot proper pre-relocation phase.
>=20
> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
> with a pre-reloc status only after U-Boot proper pre-relocation phase.
> Also update the ofnode_pre_reloc documentation to closer reflect the
> binding and driver model documentation.
>=20
> This changes behavior of what nodes are bound in the U-Boot proper
> pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
> to restore prior behavior.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>

I'm following up here now that this is committed because there's been a
large number of commits to update dts files because of the change this
commit makes. And I know there's other platforms still broken that need
the same update. And it seems the change is almos always to mark more
(or all!) nodes as bootph-all. So, is this patch really correct, and
really what we want to be doing here? I was not expecting this much
fallout when I saw this come in. Thanks.

--=20
Tom

--d4Gtrk5iK85tNlkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU/yrMACgkQFHw5/5Y0
tyxLTgv4xAR66dcrTchgUYR4TgAr+uXI5i0OI757C9opiqQMvCGRgc1S15szuDzV
mtvxxKzlDj8mNC6GU50QmWnlmKMAa+0/aOK+qyBgKYma3MGnswNVjL54+XNLSXAX
FpH2aHofUfDoQxK0Ckom/v+MX4NYlmX2Mqe0DgbfJ/mEuz0OuUHJCDdYKs5h79tf
PTt+h6g3Y7vWpG8D+zVNBEVdhAD27qhLLQxAM/JF6oy/ibswiSoGTMbl3kR0XdGw
3IFew4LZ79QokOtpOm70NA5N/V1vTIG0Gb8Raa981M0nS/KvrBfKC8YyzgJSHfUN
XnfoiMv1Wbxnns4gEpoWrChSkY08Gfs6Jx/NgSl7olLjHQKncZvBJRh/8F9/qX3J
/g8wJYxzrRTxPISNb2Qiuj4R0xGRynQ7KG05wua6W3FZrIULSSalSyN/dL3G5NGj
eWl1lcqYRc9+xJnuC4NH/iQmq4CnG/7d2q1ocnsRFM3DjYwoGDXtRNK0pnUNKNZt
yW4ppxE=
=qHdD
-----END PGP SIGNATURE-----

--d4Gtrk5iK85tNlkQ--
