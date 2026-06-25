Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FE0CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7122E84704;
	Thu, 25 Jun 2026 17:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VRqe+e3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D9384894; Thu, 25 Jun 2026 17:25:49 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4005A8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bebb72b845aso20746466b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401146; cv=none;
 d=google.com; s=arc-20260327;
 b=YneF/eQ5TQgc42IUo+WMGtDTW+n1vVdgaJykEDPni0ECXAjWAd5sco7tf94dc3i+se
 7u7AemSlQkr+nEPrbM0PCHQF9HSecHZhdeEaWGvwFhNDsF1vr8hwkBpEhyjYF8sV5iLr
 jF0QNDpvJhBBlXYeIQCuLDmDek/oMluwdSiwcRm7vliVHb7hOGgKBhbOkeZatZwgFIHf
 snNURjGHLjbXPm3LC6gHx0eYBc6ruIiZUHdZdUrcw36IqS1wzRy0/eXVHmugZW9h4D9B
 aDVvAFU+SaG9y6dRvzwi0zbtejHZFAh/R1CFA0EW3cmreiaopn5H9+iYXKrxcm0tMgq7
 ifaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KQOeV+2rJNZ6GO5P+5xTkNWHRpvlf13HoJ//dDH2Bw8=;
 fh=pqQDfe3LJMDmm+c9NDum1Jzf1ll4C62eeHhIID4fPOY=;
 b=amJrtc5Y7DOoElxKah1L1EK2/eQmWZS2VUVRGDU21sFerCN3RSJJlM2YTQBR1Rzxsg
 y7LWula2iGQW9e43tEOsKX2rnFqf943iRA6SumC1W3+m5YzAu6a3IYCr/MR0Gk2yQvWY
 QWgb0hDJiE9uaFSSPpGVGTyAjA9ouls9Z6mHa9QmlbQklAMxC7eySM5z8Pcid//kQ5Gh
 BeLcZQpJKZ9MwYz1hdHuy3/bdoJhUYDq6ll6BJnPYaQCxXN1vdH7LfEn4TEo45FFXLwI
 4mmh+RrlzWzP5yDluARmgPLSENgBHoc5Ay4x84uw9E43YjvUJK5HDxl1wL8tPANUCLvM
 WoQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401146; x=1783005946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQOeV+2rJNZ6GO5P+5xTkNWHRpvlf13HoJ//dDH2Bw8=;
 b=VRqe+e3jnSjptCH9jBs6ChPH2iTIhe5ht3wpLvRsL29JFPk8YtHSOLbAm03aNUoFUt
 mVDM1pnPIqqzd86FKfgMP6QlWEF4xDVbHCxblNnQeWyzSDmRhb09AVSPdTv84kArUEm2
 3U9qS7jrCTWC8j6wROFdqdD21MbYRdpKon7AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401146; x=1783005946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQOeV+2rJNZ6GO5P+5xTkNWHRpvlf13HoJ//dDH2Bw8=;
 b=O4C08qlbMWvfp2cv0RDJTuKwm5NxyK+TIB1aUsuuc290pZPBLlzRveDkdGct+cQpIc
 n30X3hCqdHUfDbvOvABxCOl/ou73L2JYY4MNf0fzZbpBPdsc7nYnmB1v++RdGAArEAVt
 9Gw42rEQmaBCvpBHsVjfsWqIbPFTOBR3rmAvbBSUN7J4GBGROg71QK689sRW0A3g39BX
 ddwD154rXXHSYxJavsUmyBtPyobGuqZSexA76worlYV6okVOEI+eBsw1rpBUSEDAciz4
 vITiBtgwVwXtnbrYdSG7mKQyaNHZmLp1IQFG3PkyHww/cUxD+/ERJxX1rfWERwoR3Zg6
 qLsw==
X-Gm-Message-State: AOJu0YzpJIdMKK8Pro6WIZO+MlmMQWglgF/fNWD19BTKXX9g9dxGz3UD
 E5uAIkmSIXtCAPdgBZ9MhoV/6mTxJxE8eBhq6aDQCsP819XtTdTIKQMvqM87Ld0bnDdcUmTv6GH
 m+jFXL/Th236pRQNyjZ5VWTt406H2PFn3dDE0xQHpvYKSVkBryVJGIg==
X-Gm-Gg: AfdE7cmNKjTYskZKWGllDFfsBD5+wxJNQNcm7PS+/bHnxtYzrmiYhn75RcxCtNCJ87j
 uJddQZYkAa9Hd8lYpBDo8n+JQl1kQrfUV/YYsQd+yZ7I7N4u2/kWQ5zlttCTbt0pjEXH6XT7Lyz
 c2oyxFRtHHIDuvnTp3WARgjcQcmFFYcIIyy1kIlfOegFTgx3KBfMifx3yreunaogQ65ic4swVx/
 HkMTyd4vb5KXhPZbpFK14KC96uDCB+zbNefmpU+kCqKMu7GwvwY4ctcjKBwUVPimOlWZ8QrLg==
X-Received: by 2002:a17:907:972a:b0:bfb:b43a:b084 with SMTP id
 a640c23a62f3a-c1205ef07acmr234844866b.40.1782401145661; Thu, 25 Jun 2026
 08:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:25:33 +0100
X-Gm-Features: AVVi8CezgeDoIU_AeJ1IKBX3ukZ_jdQtJvVPDZzlToh0ECAt8tf-UJ0I9RhYjcc
Message-ID: <CAFLszThxHdN2rxM-BfzzcPqjC5dephD_dPPRZU-FN4G7ixjaRQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] pxe_utils: fix W=1 kernel-doc warnings
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> pxe_utils: fix W=1 kernel-doc warnings
>
> Add the missing parameter and enum value descriptions reported by
> scripts/kernel-doc when building with W=1:
>
>   - get_relfile():           document @type
>   - get_pxelinux_path():     document @pxefile_addr_r
>   - enum lex_state:          document L_NORMAL, L_KEYWORD, L_SLITERAL
>   - get_token():             document @t and @state
>
> No functional change.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/pxe_utils.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
