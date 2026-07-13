Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC9C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C96C184A4F;
	Mon, 13 Jul 2026 02:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a0U1XjUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AEDD84A4F; Mon, 13 Jul 2026 02:19:35 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485FF84A0F
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso4696869a12.3
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901973; cv=none;
 d=google.com; s=arc-20260327;
 b=CkTg3A97Se8CV0gZ7b+rRpJZq0zJA5hRL5P0mS9LZqaK7etO7Von88gGBCRnnW8TM3
 O8FP2Saedotop2396aLvq2jl5gqKqDP6ApYp4Tbx9iQiCCBre/d8RNhLoCKH77fEeRT5
 6GHnZp5W1g08qmwyf1vFm/Oq/pOp2hNhrdewyFdvFUaPvr72RwP9Y3lb9otc2ajOTVuJ
 0Hn87XJ15ag5Pl3RNjFCqhYiKcITI7DpINIYE1E4yJcRsHVscVWPFHb+mI2CZELTLfDT
 /RJpl9xEasZhS79W2ZhnqolmuCtAz3SRCDjfSZcLdZ6ceomJYZkMiXqiB2nYV1vu82zQ
 xp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i2L9wzk9Gt6vbUSnfFLeB57CHVYYW5cmTM2BCrVIQ48=;
 fh=3a0EwrvlStGz9lF5axNoCLmtcSKunRuNusv0y7ONUmw=;
 b=R8zbdVXLutJTZrndi00IpTk4JBpuha7FQl5s+rIqzuoStBmeS0QM+QzbfqCBFk9Fjv
 IY/NoY/vzr0EWVaZ4DTbo2FQSy7Azfp03qH0LkxRC2HOLoc1JKMJR4oBfDwUaPfz12Fw
 WcAms3WErbqxOh3xK9QikoHWdZSbi4CYT1zNZryuFG09s9Ys4OHSi8aBNBvuEiWV0Lio
 Q8yg/cLncNptN9j5vS0EoyIiLy3+hC7eCejA5MrlwwPMDpPPxmvkmqKY/vYjoMVMQimf
 lxmx8bRrGOq7sXEcbk6eZV/n2VNYpVnmiQ6kmqlPdVaOY0892ql2exkQm/ryM1v7boBZ
 P18g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901973; x=1784506773; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i2L9wzk9Gt6vbUSnfFLeB57CHVYYW5cmTM2BCrVIQ48=;
 b=a0U1XjUJBup572992vNPmopLBzgcWFOt3GNEMiCsKm+7wobu1ET1vKSglB6tEFqcTu
 VGB2O/Q30/O7rks+gRlMr5SbynvCPtg0BmpoD2Fh9wq0ZvLLC3QDx6wukpPkG3OejS/A
 l6HKjO662ugS4k0n68CeNPSPHVffVbYQ1y9To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901973; x=1784506773;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i2L9wzk9Gt6vbUSnfFLeB57CHVYYW5cmTM2BCrVIQ48=;
 b=aBj/ac1W09ukxDahLdgDeoyjoJNxvKLiXr5SNdnMiIVaqrHeW21fUipSbYER1us8iR
 pYEM2I4Inv/DjiFQpxsbsJdYF1HV3zI4Ke28u39mxboSXHNtSMovTly6F8sxcpl1PRM8
 t4rvpuOE+mFDx8Sna4VqETDk3Q0gGZ0inZSe9iiDz0lk/U8tfMp3s00RroZrpTemab+N
 JZycebwr2uyuGpCnemEEWHqZSXqrSuAsAtuXFrVWVc27s1hq3mftjGvBj2AwXSK8AS6x
 DYjcAqg4OR4bWQRI/sqLO8Ho8tksZULvarj1wyHRr5b8WtImJiG34hthCQrcJ08kSj7X
 q2Qw==
X-Gm-Message-State: AOJu0YyioZpcORFlyvQY2/G+i8bVA2faIR5o9Rpv6FQ5LIkfJbTvMiwD
 7VbjvAWvbc4aCNpkvTJ+wdegyhF775QwNGzfIlSG4D66Ex70bzkEM5rJzY8v47DXwGd8YqbBvh1
 qgg6A0Aul4AKa2ubfQKHn++x9iHfqHZfltnrBXF65
X-Gm-Gg: AfdE7cl0NF01xHBc6w251ONSQl3/NrUUCwewnd4nBcdVrOckibO6Z9nQNwIJAKI2EDG
 bC2T0KiQrjs6jVXY3Rhu+pNWlpdhmP92V5Bsl4mCjLeudppCZwgSFQV3ns12/riuc77jjYwWEWw
 RKdNfu0RBM8cLiQEp7I6dOSvPnAA8CmeUJgoXUrDXcMXWmaoRZZqHMR7zor7JdRBPUetP2at1wh
 oMGCn/iBkuG1olnL6iSph5xwRKAN4ndqrQgxERwb9vt0H/W+IBoDQnkgySb9tdE3nCM1m4=
X-Received: by 2002:a05:6402:380a:b0:69c:7a0a:334 with SMTP id
 4fb4d7f45d1cf-69c7a0a08a8mr2036357a12.28.1783901972737; Sun, 12 Jul 2026
 17:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260708103452.49277-1-aristo.chen@canonical.com>
 <20260708103452.49277-2-aristo.chen@canonical.com>
In-Reply-To: <20260708103452.49277-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:19:20 -0600
X-Gm-Features: AUfX_mz6HDzDEpGWfWKqBFif2Qe7PT_oEz0S6NntjR0V9xRgpv0nHKgiGQ5AAgg
Message-ID: <CAFLszTjjvaChArjRY=ObWNQ_okrANTED30Wmm9ZySC==DgMD7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spl: fit: bound the external data size before
 reading it
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Michael Walle <mwalle@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@gmx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>
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

On 2026-07-08T10:34:47, Aristo Chen <aristo.chen@canonical.com> wrote:
> spl: fit: bound the external data size before reading it
>
> load_simple_fit() loads an image stored as external data by reading
> it from the boot device with a transfer sized from the FIT data-size
> property. That property is listed in exc_prop[] in image-fit-sig.c,
> so it is excluded from the configuration signature and stays under
> the control of anyone able to modify the boot medium even when
> CONFIG_SPL_FIT_SIGNATURE is enabled. The read happens before
> fit_image_verify_with_data() checks the image hash, so an inflated
> data-size overruns the destination before the corruption can be
> detected. The device-tree overlay path is the sharpest case, because
> there the destination is a fixed CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
> heap buffer.
>
> Pass the size of the destination into load_simple_fit() and reject
> an image whose data does not fit before the read is issued. The
> check is done in two places: an early bail on len > max_size, then a
> bail on the block-aligned size > max_size. The size check is the
> mathematically binding one because size is len rounded up to the
> device block length. The early bail exists so that
> get_aligned_image_size() never runs on a hostile len, where its int
> arithmetic would invoke signed-integer overflow.
>
> For the overlay path the bound is exact: the caller passes the size
> of its temporary buffer. For the firmware, loadables, FDT and FPGA
> call sites the destination is wherever the load_addr field points,
> with no defined upper limit at the call site. Those callers pass
> CONFIG_SYS_BOOTM_LEN as a conservative ceiling, matching the same
> limit spl_parse_legacy_validate() already applies to legacy images.
> It is not a tight bound on the actual capacity at the destination,
> just a cap that rejects implausibly-sized data.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> common/spl/spl_fit.c | 51 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
