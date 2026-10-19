Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2A606A31C
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hyo1kH3s;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lHG7QOe8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C85DB606DB;
	Mon, 19 Oct 2026 16:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ai94gaOgojEN; Mon, 19 Oct 2026 16:49:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B693360613
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792428597;
	b=GFGckymzSIfhZxcbrgh/6nltWeT6a7vIr29/whxE8IBydUqcX/M7taB0cAsM0EYDkNe8
	 qRE0gh8svJKoSqmNrLKMKZR7vbGE12frLoEJZgKreuzUJnOI+gNK+pB2YZTOthm0mvftc
	 AsWSq8HMfG2BQ0ZBXOJwnzSEHXhxD/i+ZHYIQY8mds7QSMIXQbtbHlMV3Mj25uhkSZ/1V
	 Cm6knptWZTBGFCwwVRqnff6IYWkqg48Xm7ge3OG4QN81f+QEG15J5728ZIlJlWHG6Y5EJ
	 KaV+ovH/XwYtLbwNK3QJteNEYXeiy7RtvOhsIlxJ3gVqf5ze1YJAhnJ1iBrfO2SORlg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792428597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rXRfPmytQzyQrKST5oUAMGwzk0KgKB/4U1erEdIntbs=;
	b=CtwRg0+LgyfxErqZHPgyFitWqbcuZTW3bzRwLYZ8r56H29T0SnwJS35YC5ArlWDJPKjM
	 8yFMCMcmcbdlauPbBHOqL5+ifP6wibH1j1rraCBfx0VTHRPoAB9/FWUZFvfxAZA8v+FY5
	 AOs1guo/Ja97bNdUyTYx8aAyl6a7qe1suXPiSg9nIEeRKH86gezLkEwXVkddVOf2yBgx7
	 8yolL1IFUjy7UzZr4747Z+bbYSAcUSaIIZvkLRmXPtlObMe9K7tEuK/hFFIb4VDdfzrak
	 XLYsT9CbfU+87JHU4pUTOfNRtQXQsJ61qAW4Ax57pzd8Y9XALCtdzHd6m08xgzbEBFQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792428597;
	bh=rXRfPmytQzyQrKST5oUAMGwzk0KgKB/4U1erEdIntbs=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hyo1kH3sJtR2vhIgxq31TITx6FzwOLPwsiZQmkCjItHe9dFQQacRzOWnqyeaos8MF
	 4jjslJrmU3RzU9X2ZHRgATkSs4OIX9mKtxvtlC07J7lkHd3kkczEhkTTHMX8YGE3aF
	 nwAienaAbb4wjXHGWKgahrDtpyY5Um0CTcCSr39cvsY570Q2Go8EVtW1d2rQLTagxe
	 pydZ22po68i4y4kTd2uoT7xf+JT6R38/30bGGDZavJc+bKJFtK5e4eZcSDzHiMsfcO
	 zsrTaloIdIjt0AdSz3bzVJtB/s8zQnVMIJhiPtSWaVeuRr6NVh1LVcr3GtgMTZa49e
	 cHelJYWQNyybw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B693360613;
	Mon, 19 Oct 2026 16:49:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CAC1279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6261380E3A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnLuPwHNOa_D for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 16:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2063480E39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792428595;
 b=o+2VjvtNEDjrKb8HSmCHnI55eJ+79koiFTx4xBB+fzU3EMUyYXFKPJZ5P8FdDq36iLTD
 NZbKR9KbCHOCFNRUm2KpBGi5IJKBVzmOV6rnINjLJHULKF+bbAAlcZJVqeVF4E1BFSmSC
 jE9jr2wZbnZvP0gyNGgW/U5nShxyBJG5rF0lgjkzgCIygzQoZMbMZQl3bOF7LJJsWWmeN
 hOIF1maTaFckjxADXbSOzVX5G1knySYc36ctBdmZMPPktbUDmkjYls++3B18me9Yu9yD5
 qZ9JQNQ12CiEhp9SHYlQ3fjmkncwGXjDMbVXpdw6Y81cOG8dSLEAu1Xmw9vtYeUEsBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792428595;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=rXRfPmytQzyQrKST5oUAMGwzk0KgKB/4U1erEdIntbs=;
 b=KSeA1uSFBinFFD6T3bEy35kdFbA9iwVIjdk0ruAdCgOfZMyBc5yRY6otU/wj5rVIgYuz
 WytuzmKWJhtmVUl3fLChcEchWq1zdjL37msKXuUgJXcO6sEn6iDkPFhseesw0xdtehZEo
 nNbIbxr/kJV7lYIw/TavOBI/BFzVDluDnwAVc0sr+ED+j1nRmjty6ROqxYta9rogjeWM8
 RmcRj1K3EReIKlIdLD9N1FTKDhM9u6LlZprnYdEJ7TzVIyanmEwI0NDteqwEno8BvX2N+
 L7ntG8mY1mc5IniJPeMT4PciHLCmIWtDdIw//T4U47Tap8sKBI8orUeU8iaa3gwtjkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 spf=fail smtp.mailfrom=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lHG7QOe8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lHG7QOe8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2063480E39
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:49:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05618432A; Mon, 19 Oct 2026 18:49:52 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F78801E5
 for <u-boot@lists.denx.de>; Mon, 19 Oct 2026 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c3fd91337baso307082766b.3
 for <u-boot@lists.denx.de>; Mon, 19 Oct 2026 09:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792428585; cv=none;
 d=google.com; s=arc-20260327;
 b=eRxHuJWsAgs2h1JPPW1I+H4CgO2aw/GdpTxR0Z5JPAHfLObhruvHt4I7lN5aw0fQ5k
 f0yKEF1IJwQn8K/u9Cmk9Lpx2aOJj2fDsoBhSDagyrpMKHYtitg/xAFGlxcwffDdWEVB
 lQ9+h5rWoLPUzxrLuOSEHBPFQ17+CtdeeSPPTzOvJRg4NiquivrDcEixdYwVRae4QO6A
 5KlkKx9CR4Asz2tLiDW/HJYFmhwGHmVb9aIU/hXTy9le+b/1VuNpCbXNkt2SLmiU51mW
 BKH5O/Apvz22oKBKNQUjS80wWKnNjkFoM3JSuuq/mPrtiwg2lerde9JULByNr4AcrY6H
 oDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=rXRfPmytQzyQrKST5oUAMGwzk0KgKB/4U1erEdIntbs=;
 fh=a/cp5nRhZbNkPs+1yaJ2ZP0NcD0tZ0nq1pb+vS9088U=;
 b=sZ8vaJBbUdoG6IPD9ahMeUee9JiCq3fTkW7932xKq0E9KffcI2ckCQUI6gCrA6txPq
 JvGjTpJIY9v5fua2yaww7Pj0PpHvEHwEeWya87/uWo0tm5DYoLViaVjBOMLyNLqr+PR+
 iXLKvDZS91oGCGgjr3MF3iCrw96CLvcIZMY1RPqWdPuYDXxu70o/STC+gAIoboZhlEIo
 yP3h45+QWE6QEVPP4jl5pNJDYJ13DYI/QvfshVN6tN+QT3nCuAkuCq4yQvrcIewCeMEZ
 NWK7ERXNtUBVq2yT8f3AVRc8sV97TjF/uIhHeiGxb6U3+d8XydfWO9JLhbTd1kMj0Cu7
 0+VA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792428585; x=1793033385; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rXRfPmytQzyQrKST5oUAMGwzk0KgKB/4U1erEdIntbs=;
 b=lHG7QOe8hrzMkmWIRHWwaBNVJXmlA3Y37jQsseNW7RCtUT4TTl7mwPUCuy96j/5MWk
 nQ4+Mvz8y2TRe7OqH7uwFq22S72z8lihKxMgPf6ESYRO4TvPnFggBQEyG+pEJQuz0xUv
 9VRlN1soWhQyRAj8anv2L/kh5onlp2Y0WQy9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792428585; x=1793033385;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rXRfPmytQzyQrKST5oUAMGwzk0KgKB/4U1erEdIntbs=;
 b=UEQMxdpJR3PTCN053J9/WN96+J0UMShyRZ6bYuHQFB3f1WUhRwuMNXxVhi3bPw8zDg
 FbpZSXJN/foUJCS3C78FFOZcXJ8XmQJQJDBcGcCrmZnfqt9Rb2SRblcAhKqBGisutYS4
 ZvhZfRfvWkbBfJ6Dsow+GdiYbzgZKJMBhO4IrPvgVC2lHmh/mYuJlLAQtDcYcHKcGdge
 DdGaFkUCSUuOnI0fcJE4hTSad1F69SIcap1wtvfZ7hvrpG/Fo1TzXjs8EERs/yoDKrR7
 BTDj8rwd2R01CzkygZjEAFMHQl5jjiSSsu8XsjN/amecXLqu0282nrTO7yX9vNXNcXBe
 +Fbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAFcPyHksrSV7917+rH/dGgbUXu0bTp6XTuh0yruSY2Fyyx1Z1GRaYQEi8WLosglVAGzAI0qM=@lists.denx.de
X-Gm-Message-State: AFq9FYKyA1HdFJHWGihhUM8Cwug0gFN2mPP7bK4cNaLGNfDgNE6BESdK
 PDcb5RO5gFjQ93j3cd7mh+y5EhVYlUQA36ofg7mwx6K/T+sGrcAhdrVpJb3WA5X6W+0MXAgfJL1
 zrgQrJaLDdn/lZ7KoO2Y3GyRRkRIA4G3IEynDX5kP
X-Gm-Gg: AYBFou0hmiaUnHwese4zI+Ussu+NlMHWcWreAdUEotUSJaPbSvLDWeR0S9NpEo35Ry+
 T4h6x4+yb+QWadkZan+sRaz6qQqHoOyzbkSyFZZTyWIlYoWN5iYdYkMpWWFsceY5QCOwVvxIa9h
 8RkusZ5H2x0jcsnaGimVMj+zjb39oP3Mo9Yfj5/1PmO9nQuuwkXsqZ5VsZPsGnK59fW1pnd3ha6
 Cto/mGxdUQ+xBzaecVP7jaJjvU+O3NOPsAAu4uAgylGQF74lISM3NmmIQR1h/aaccyrZ2ZigA0y
 byjWQTwo1G5FL/RfZLDNcY5G6kZCG4DkHl6S0Bey7x+LPn25fE8oKAKe00/JERFs
X-Received: by 2002:a17:907:c604:10b0:c42:3a77:80e5 with SMTP id
 a640c23a62f3a-c423a7781d9mr315406666b.29.1792428584675; Mon, 19 Oct 2026
 09:49:44 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 09:49:42 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 09:49:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015183907.50298c31@rocky.lan>
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105615.1E6E668C4E@verein.lst.de>
 <20261015183907.50298c31@rocky.lan>
Date: Mon, 19 Oct 2026 09:49:42 -0700
X-Gm-Features: AclHuK-Ryih0Pw-aLNS-QeJDT-W-4A6w06JX0N_Xh0nfIiDFeCT-Im4DQvuXq7Y
Message-ID: <CAFLszTgi_HJX5xtAx0NM8e1z5A4qHc-FQtKO-wjjUsuE=y_p7g@mail.gmail.com>
Subject: Re: [PATCH 1/8] core: skip parent device nodes without a DT reference
 when looking for dma-ranges
To: Torsten Duwe <duwe@lst.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Filip KokosiXXski <filip.kokosinski@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Torsten,

On 2026-10-15T16:39:07, Torsten Duwe <duwe@lst.de> wrote:

> Solution A seems to be the least problematic one; it enhances U-Boot's capabilities.

>
> Solution B is more like the Linux kernel does it, but without allocating its own node,
> which makes it look a bit hacky.

I agree with Tom - solution A looks best. The appeal of B is that any
later code which asks the dynamic device for its ofnode gets a
plausible answer, but that answer is a lie: dev_has_ofnode() would
then return true on a device whose properties, compatible string, reg
etc. actually belong to an ancestor bridge. Any future caller that
assumes 'ofnode present => describes this device' would quietly
misread, and the breakage would be far from this file. Keeping the
fake-ofnode trick out of the core and localising the walk to
device_get_dma_constraints() seems much safer.

> Solution C would be for an ideal world [TM] ;)
> Nonetheless we could at least for the RPi5 craft a DT overlay and send it upstream.

An RPi5 overlay would be nice to have regardless, but it does not help
the general case where U-Boot enumerates past the last described node,
so it is not a substitute for A. I would land A now and treat the
overlay as an independent clean-up.

Regards,
Simon
