Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D6DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED467878E5;
	Wed, 13 Dec 2023 21:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="imSM+aQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69E387887; Wed, 13 Dec 2023 21:39:26 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5038788E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a1f47f91fc0so888322966b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499964; x=1703104764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b8ARArviEtTj94lo8oE5RG4x1/WDpoZIJa6L/fkCg2o=;
 b=imSM+aQGdbNasC5DiDITPdgfvznqjFZb4SJkKRSEjETpQGVh6MzCGEhnQ4KC7SN383
 WRpoyYXF9/Pv6J/kCA1mZExxqmaHdyAx0aZ+A0S2fvzOcWITaQsvdi69Uxmif9UAipFv
 nLGpcswBY9dG5HTNlZ8Mh374m+OrJlNvWSEl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499964; x=1703104764;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8ARArviEtTj94lo8oE5RG4x1/WDpoZIJa6L/fkCg2o=;
 b=u0ueUDoCFSrheENPFV+jqQ8bSUiroopNqHJKxhU+l/R+nWyvjVBMIO6XUdRg3g9bw2
 nm4qDbK/zv3GeWp2PHKFyt7m/FXNU/+P+Acs8dR4XC8Gq2JwoglX3BYZvOPvNO/eoLP7
 vjJGPPcqjKyrOO9JfGkW4HZa6YGXSsdZQhQOabRY3y2By1Xj/TWKRN4Nz9Rsswvtpmpu
 VClD3w/3/wQ8NYsIJ6tkBtnvlIhogrMiO96+ICfpxpqwtSgEzQBDe1nT5s7KFn2oVHcV
 uq1STDCZa6Biy9v7UMISyaggL1LzzAn1eDybDQ7BJbOOfRjeVLBTsaZb2eV8MpBVFkVm
 1dvg==
X-Gm-Message-State: AOJu0YzoHkFTMWWRCW+8ArUUOCxITlQYekfO6F+8BUjpTKR2hu3cxGKB
 qJtW+O2t/BqYmqtQ1vpIhvAUllJ++BumGwQdnD2cYw==
X-Google-Smtp-Source: AGHT+IHSRSY0XcDjAQVHTHSN5FK8YTrkn0JWDv0H+kbdqYL9jmK2Wkn8t3w0enTNBTdEeEoc40qqflb/u0uvuATwvrs=
X-Received: by 2002:a17:907:94c8:b0:a19:a19b:55ec with SMTP id
 dn8-20020a17090794c800b00a19a19b55ecmr5561253ejc.124.1702499963779; Wed, 13
 Dec 2023 12:39:23 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:22 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231112152754.130399-6-sjg@chromium.org>
References: <20231112152754.130399-6-sjg@chromium.org>
 <20231112152754.130399-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:22 -0800
X-Google-Sender-Auth: woiovBqiJZMC-hqQGieuLdRU33o
Message-ID: <CAPnjgZ15G35UuZNewVpB-0+qijT9KxCzJ2WFp3hNwfRAdn4Pug@mail.gmail.com>
Subject: Re: [PATCH 5/7] boot: Move adding initrd earlier in
 image_setup_libfdt()
To: Simon Glass <sjg@chromium.org>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This may as well happen before the general event is emitted, so move it.
This will allow us to use the livetree for the event part, but the
flattree for the earlier part.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fdt.c      |  5 ++++-
 include/fdt_support.h | 12 +++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!
