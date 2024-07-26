Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12009C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766F188580;
	Fri, 26 Jul 2024 14:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Acgwe7m9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3017487B77; Fri, 26 Jul 2024 14:58:56 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DE587B84
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b79c969329so3055726d6.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998733; x=1722603533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GaJYBnidQ4FlNVpsWdAoEN7DVhZ5+WiSR27aWHjB8XA=;
 b=Acgwe7m9MRwUnDDIyMu1dyX+pauba1chYew0naPb5ui2b2qKbmsbu01STCbwu95EW7
 Lp3e0B5H3ju9ub5YctJemjfs5x8TZOF0P2X7UetuQjhgqFtxGcoowl/weKflugjNN3d3
 ZWt/v2tRVOQZK4nJRQKS3erhq/hv0NLYSy6ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998733; x=1722603533;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GaJYBnidQ4FlNVpsWdAoEN7DVhZ5+WiSR27aWHjB8XA=;
 b=Lw23q5jTfv4ayDwJeapgDYTWXFv6ekq3M3s9tnGNc6GPvqAnnrDrnoBh8OsvWMPdHl
 xpwGZHLcbSY7x5cw+C+iEsbPssc2XbA/eP4D3n/NPNrzVaKx7dzlO8yIvaX51yIXRMgx
 xR0YRtgPTE1WJm4l6RwLI534vgxoP6Yyr68Yc28bSCi1smwm93oau11b3jHRt4SbXJ1k
 fFA1aGVE6ch2RZLFlcAx+D4eZgNzP+tCOuwqPOEQVRVRcm/tD1TK100FFl63o+JhsauX
 Ms1TjaBM97Pjtvv2Bh7c7zmvBYK8DCy17wmQtSddaGxxlSLFImi6+EWq8vsgFelQTx07
 oWhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCzoraOGRHiyNgezT2UqgX5gbi0xuOzQ8/UNh848I8ZV9N4cTwGHt/KSa5KNvVGMRIKtfkrsZ7Bu+LW7XW7YRW8LBZVA==
X-Gm-Message-State: AOJu0YwlFVDKmVpvmGtQLFIWbJ2YAWSiTkrX1LpPG6IZ7K9BLkWaSiZ7
 nxijWWUmgwxc/1yqqzxcCTTizIFhRmeMljrb5prx981585+8ZiMMacOSswgmn/uKMYTZQ5tfdrt
 xz1h8EjDzMfoK1io9U7bY5UTQuWZOgFnT3Ng/
X-Google-Smtp-Source: AGHT+IGHjC5OzP9LpCUOC05m32RWYvNhY13bTDRMBiPvY3l/899vouBp/AYH4YR3TNvrkYxCtBI9UNSPSVNrqtz9dRQ=
X-Received: by 2002:ad4:5b8f:0:b0:6b2:dd54:b634 with SMTP id
 6a1803df08f44-6bb40894335mr62126186d6.39.1721998732979; Fri, 26 Jul 2024
 05:58:52 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-23-sjg@chromium.org>
References: <20240717155712.2913651-23-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:52 -0700
X-Google-Sender-Auth: 54KsElagctlkEFO-84QuvQ80si0
Message-ID: <CAFLszTiD6jms9C5EfbWm-nkLSZYm7Dz_rkK2CunVDwJOAaUdjQ@mail.gmail.com>
Subject: Re: [PATCH 22/24] qconfig: Drop col argument from Slots()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This is not needed since the progress indicator has the object. Use that
instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Applied to u-boot-dm, thanks!
