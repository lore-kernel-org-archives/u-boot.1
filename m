Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1DEF94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BD5842D7;
	Wed, 22 Apr 2026 00:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aLXfTmmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8592783AC5; Wed, 22 Apr 2026 00:47:20 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B88842C7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba699316b42so489586966b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811638; cv=none;
 d=google.com; s=arc-20240605;
 b=esKkD2rifejLm1G3NCKsYyUXWTieuCwEiFjRwVlqwEBYJetTFRx3eTgvHKUZsBGaHU
 /LHLAhyiEf9SJZ47nMBKIGgJaySHpBxBdFY/Ogj1zuVp+o2FI9TF/XWekx2bkaiEEiyR
 tSD0hKNJPKS/oKN4yp+yn9uXJ4zIZONHc7TKo2murnwU8p9w0+KK265+4mGfYhP0649d
 gu0fYuL0qbapoeVhNfm3df3jkUTGdVEXbFKLeVzCyzE88gA1KrfGYVHu3I2IqCoykeYz
 KhBCbE68yworsDGAlEREoC4Bj8FmjBNNb78h4fDo6jn3IwPGOFygq9ljtViSjC7YYjDB
 My7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WHS1twDd10ZZrXqCJVITXbm//PheyQicLM8Qs6fCuxY=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=WzoO5uVwuy7/nE6FAbJA3uwXfFGJ3YlOhbvasGT6TmrYv72WajBIIMSQZXpvB+HFHC
 D+fixzLJKjIBoUNGbcY1nEnnKKk5ALWDMcRQ9o5Ei/M8OIUqx5ZsW+7vfvjMXwE5+ov2
 QKrHmeRkTy9basisL0jlxYzbyuOvE4nIpo9y0yJeEK2UgQrC/0uAc5uS4E5grjb/szhI
 vTK+vrRmxSVP7ll7ktluF++iJhYCx1YfDTrAaqX+Xym6zzpheLwCwMgCDU7trQWyYIwe
 FHus+eV/uvIrHR3Pi2oNFyjEFUjF1EpT8zjJCSx1ho4R6KlMpS6hv9+7TrPCBN0+OzCR
 gGqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811638; x=1777416438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WHS1twDd10ZZrXqCJVITXbm//PheyQicLM8Qs6fCuxY=;
 b=aLXfTmmg5zbQKYsismqBd2X8Ga/XiykfWf8+8A6YOUI46B8Yg0CR5RcSo3L45x8jqB
 LI9ce2QoF/LJOaOtZFomPdTZbTSf1GNnYVUfT7N4lWV5ZEPBgk+eNT5PCuH3O3VeuloJ
 K6wZEJlYt25r1UJHBw3FZbdPt32rtbtnyk9nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811638; x=1777416438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHS1twDd10ZZrXqCJVITXbm//PheyQicLM8Qs6fCuxY=;
 b=R3Q8YKSFSYukf3Dt/SapKxN6u3fWa4V/+NhZlW/KkAEEf7alhv0QShCsYzIztrcSV4
 WLikv9Rxk9hCtfJK0E1K2NStQemPgQAhPee9VhkOwCHBxoelMeck7ppIPJOh+eFy9Pmt
 nnP4Fk/zQvw3zIwvlx5M9Xedsp6WCcgocoUikYFKpGnyzJY3OhN3t7wRdoBLHatpJ0MX
 mTHVBYxpbYgtpSKk+KFq0dYeuLzVlIEFEXB+QcBdF6wByjbevpkv80h32DYsds5vbxRj
 XouDXe7+aE6sjzYt9JBaoCNGhcoH6ZpdA+SRM54fH0XZFJfpKNvvLjNaC4u65fguDKBA
 1QZQ==
X-Gm-Message-State: AOJu0Yz74uKHlCgKAbVD2hXRhDTlcvqojcCr/8Aj9h/hG2qjSHmWwX8N
 m5+4NaFv/FDWBd2FUhLJQUCG1AHmGF4b3ztBTh6UnX1JWngHm9SyZlzLq/4SH5XhspzlfOxc72y
 Aa80pNjBPs3z0MgQCj7gza4SiZUcv/ffx2nFP36T6t5uGO/IsYwIXsQ==
X-Gm-Gg: AeBDiesS10C5zjAeJ9bjn3d5jIqClJuIfa2WPlbjEhzi39bqyIYdAMZI0KUsALDz6Y+
 pcnzwaGAtGL/8OX6nur0DYfcSSRFkKAwar8rjXT6VuD+dMHnxA1f51ideS6Q8VHX4uPfTFeVtRC
 hDZMaB/GmxCc15ppSejQMBv6lLuoibN4WtnPgd6HrDR1Z1rmFSqmvi9DdAvsyNX2ow6OfTUQMZa
 Znbyzyi6d+5EM33whlUIRu1U0Gb2XjK7u35ytaTFODOqHV6r8BW46GFxE6sVfAM75HraNJWde91
 oKWa24t7SmSjNFR65qHs
X-Received: by 2002:a17:907:7f94:b0:baa:77ac:97a with SMTP id
 a640c23a62f3a-baa77ac0facmr118844166b.36.1776811637646; Tue, 21 Apr 2026
 15:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <c5869dfea829dec7aa0ca0c39d5d1a6c54be2e3a.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <c5869dfea829dec7aa0ca0c39d5d1a6c54be2e3a.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:47:03 +1200
X-Gm-Features: AQROBzBeVB48fCG47gLLujEmz05wgjxXoytomuPS0CrvcJdjOcTj2XYySg6vS90
Message-ID: <CAFLszThZ0eXdGbSQ1074huxO4oc1+xskXjGLRSemD76TPLQbsQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cmd: ubi: allow creating volume with all free
 spaces in ubi_create_vol
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: allow creating volume with all free spaces in ubi_create_vol
>
> Although the ubi command itself supports creating volume with all
> free spaces, the api ubi_create_vol() does not.
>
> Since negative size is invalid, this patch replaces negative size
> with all free space size in ubi_create_vol().
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
