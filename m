Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C96C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 13:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEB483197;
	Mon, 21 Jul 2025 15:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TiE+8T/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E7D831B5; Mon, 21 Jul 2025 15:11:32 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D3383118
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 15:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-32ca160b4bcso37987001fa.3
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753103489; x=1753708289; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjOiggIKIIECugvg68uAA3zJb3I5QjQEmOOYm+YllMQ=;
 b=TiE+8T/EJXKPC//SI/Gx60rXgtReMbYTWVJRB1B8i8XHlmICW8/0VIgus02qPRzrON
 UCAxPL2NnF4Z00RLLyTJgbrycLeny9rYqnM3n2BmP9gGAYDihMRVZea3oqTGTBpsa5WS
 pPui2p19QYO/OqflyBkRALewlKrSHFuxYRW51NDm0Yye5rWK8HSaHLSul2ih5SC4e76Z
 oO/MU3WSOYxP8M/yprv6DwN0fjr+5B/X2XNQpT1yPMftpePE0QRPZ5DZ7TiSr/lNyudJ
 jl3cIx+YbOC1+L01MKDcoiyrQFevS/JaOEoD3IaZdR/AvlD/Lx1+GvuIfN0sG2OjbV2/
 Ek9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753103489; x=1753708289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjOiggIKIIECugvg68uAA3zJb3I5QjQEmOOYm+YllMQ=;
 b=a909FMXgUjarms155mKFp4FD1Tsf8955q2lOPFfFnuC5ANrvJ5tZ2KydPzqi4f9G8i
 kQXEfSlp6Qp8Pt2IAgoGXIIekVAdNVhov4A77hygto6yrxejdk8qC0+8Bd6ChTCCw0bE
 cBDPW+a5RY5cZjMLSKy6NYY06rj6RVGuilFT/FJ9dp5JyK8W3CpiSxOnUU/ZYukNflWq
 jbPXkbN8dxjz1i7mvNyQ3ikXZdWfXbINDMW2sUAqWHQkCwjswyKd16yPS5s+TMqykXQj
 ZRvRY+1n1ULl+sxVTBtSd8E2azJPsL/lrEoO9BIpISo1cU1F/z96v1LNPVUs6B3TJes0
 tNcQ==
X-Gm-Message-State: AOJu0YxAY46qysquZy+sA9cQLUtnIKXAK1B/jWg37xoirIy9AY+dNCVa
 pSYJZnakd1Dd2x2gYn8g0Bxkt3hptjdgPjaYRuYH8/Gf9LmoTAikye6svjuGAYIpK63kzH1aY+s
 cgwzfDzNBalFQC19LpcH5hGOXr3dBaGc=
X-Gm-Gg: ASbGncuHTUvThUfvVjCnYgua3xtz2YZhbcyB+fA9WZMIXDtMZ68D8XyCSPy32Npo7QP
 okbphd5PN9RCXhkqBiF6j3NLytJyfrLuqGMQW8vDfeKgli2Ev96cKugw/9K83LXTRvP2X2+1kZQ
 AVt43vg47dRF0KqGFN0FTaWdb4aAMDn2ihe8eI4hqCrIrfbfnb9OXvfS508EP8Zb3idCHVO29OL
 XvZM813FtnQ/+aKGXLMxaRC2myaO4AuuTJY8ME=
X-Google-Smtp-Source: AGHT+IF120Ha2KGIKaBmOfBe+Qu+FKuSuoUJiuBnpJbjn5aGLjk/1W0yau1j0FhTStkNwLdMOM3SIzcEatPQkdKCLVo=
X-Received: by 2002:a05:651c:20cc:20b0:32b:7123:ec4c with SMTP id
 38308e7fff4ca-3308e534766mr39175801fa.38.1753103488866; Mon, 21 Jul 2025
 06:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <EB8511BA-0BBE-4770-85BC-EA2E8C56E5F5@public-files.de>
In-Reply-To: <EB8511BA-0BBE-4770-85BC-EA2E8C56E5F5@public-files.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jul 2025 10:11:16 -0300
X-Gm-Features: Ac12FXw6CrHTCISkpZePVgmGrOWJprhGG-7KTTazEF0wQguza2UEVEfOaV0Eiwk
Message-ID: <CAOMZO5ALd2FhnpySAK0pKKRUoNouPR8j6Ssqyv-d=PPZMkekeg@mail.gmail.com>
Subject: Re: Gitlab down
To: Frank Wunderlich <frank-w@public-files.de>, sf@denx.de
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Adding Simon.

On Mon, Jul 21, 2025 at 7:50=E2=80=AFAM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Hi,
>
> I guess you already know,but gitlab on https://source.denx.de
> only prints a 502 message since at least yesterday. It does not look like=
 maintanance.
>
> I change to GitHub repo,but i want to know if maybe your own gitlab insta=
nce will be dropped.
>
> I found a thread from december 2024
>
> <https://lists.denx.de/pipermail/u-boot/2024-December/573566.html>
>
> But no actual one.
> regards Frank
