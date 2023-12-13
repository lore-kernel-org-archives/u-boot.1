Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D24C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA7087917;
	Wed, 13 Dec 2023 21:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PvxiAHtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DC987906; Wed, 13 Dec 2023 21:39:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720F5878F2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a22f59c6ae6so180415666b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499975; x=1703104775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eTEw1TWWaWX6rdMah/Lf/ioCwf5lyAjZiMs+wAa/784=;
 b=PvxiAHtqCqer5xbwJCHEYr0yC/FTGsyOr8aKzeDffHbc7D8TZWvOpmvAHsZQOqCh/D
 z6UgF+KjRFLDsPxVqNASmfdMEoVDJKcGmJ2MzVE1Vqy2RYSM97BcpY5JMdMR+qkCIUAa
 3TqDkh7wLhPq7dSVe+eff5rnrSusIEFJfiuzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499975; x=1703104775;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eTEw1TWWaWX6rdMah/Lf/ioCwf5lyAjZiMs+wAa/784=;
 b=dsWlF9mrJvZGaclbT1P4Jk9i4FO/7LK/0w+Bj60K0ghLNBwvgnq8BgEzj2zo7Yx/YD
 zSz5TfMUmOrgvshq02BcuZfEyTWlZs2FOVjJclYLkBe9naSvpeyEcTR/wyGXDyVDtSYb
 wCS0iKBvVRsdLWmSAv5LEaSQU+erv0gS4TuQlIp0x5kbFJTat+Y3puDqG/cN5K4zBzZc
 /1ty+m4yi1Y25vju8Ck75wwb0hJ9ggJcEe66++DHcu77iS1LHpGdUShfvDCBFgSWHUX/
 bQt0/iYfCaOAJSTDsUGREvQuJmh+hwxvkT6oeyYpZepKRPqauJ3k5tUpUwJKqW9TM1ns
 +ETA==
X-Gm-Message-State: AOJu0YzO3d6jqtTaLUCbU+QdS7XpXA3089H1o30jK50n3j1/qdFdryym
 3QZksPP6BL1Gk2C31HD98jsZmbBO6b1XSNcESE4Wdg==
X-Google-Smtp-Source: AGHT+IHxkWHsOHhVqhNkJOA51bq3MpHCy1H+ZMBqsKk+tCbK1NRUzZaIXxPo08vaoDJQKkhs4Shp77vFy9thHd4PXCA=
X-Received: by 2002:a17:907:971b:b0:a19:a1ba:bab2 with SMTP id
 jg27-20020a170907971b00b00a19a1babab2mr2981482ejc.88.1702499974818; Wed, 13
 Dec 2023 12:39:34 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:33 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-12-sjg@chromium.org>
References: <20231002011553.463514-12-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:33 -0800
X-Google-Sender-Auth: rqOrZPvhOdN_SCtiKnu0HcgkN1E
Message-ID: <CAPnjgZ07p58e4yi0WM7K4_EBUGoWPCbe=qmitj+-+HVOx80gRA@mail.gmail.com>
Subject: Re: [PATCH 11/34] test: lmb: Move tests into the lib suite
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
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

These tests are marked as driver model tests, but have nothing to do
with driver model. As a result, they are run as part of 'ut dm' which
only exists for sandbox.

Move them to the 'lib' suite and drop the requirement for initing
devices, since they don't use devices.

Also put the lib_test_lmb_max_regions() macro inside the same #ifdef
as its function, to avoid a build error if the condition is false.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/lib/lmb.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

Applied to u-boot-dm/next, thanks!
