Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74FEA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84FE8429E;
	Mon, 20 Apr 2026 04:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yw6Q8fSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E84842B7; Mon, 20 Apr 2026 04:13:19 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C21B8419E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so15150955ad.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651195; cv=none;
 d=google.com; s=arc-20240605;
 b=kd+wA8xG5nWs4b0YQ5R/kKwM9kECTpeLKrJkDrcsfiS85E1hYfh6M91Dpbse/diwQi
 nCeUNx6XRdTUjAn0pYbxhySRP2Ls+dvrtZmUAQUmkjpG/BCqQPd5TRDzrrj2Wfw5+nfI
 7aQzPchjhvX8pIk4HEeQMI81p+q6UnXC4Q9jlo39EPk5BAR8+iaZt82o/JTKkYQL0AJK
 FjQdFcBiAPUjTwJotNtMhZ/HrMgVtEIS9y1b5lX3dFIKHBhBvKx+9PS97BUIrlWI3Pi9
 GaQwZwsN8hPwW5jlDOSnlH+jOrNFyx0qt42q+rPzdC85s4KF4RAyBBtfepMbjLP1MQhD
 1eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iqIub2Hijsg3MOJuPpiA4LZGLLDPR3LX4khAyh9sL0c=;
 fh=J+gK6geXMCx1s18EMQh5TEzs9DUXvdqfnDuILhrF8Ig=;
 b=KaVIhakW1gJJOsvkQhdM3Sd/1V2ZAcazNwIRcTLLb3bCNiiUu1aD+OhIWtOUjhOzM+
 4foGVpKkcaQf0Meflz7q/HCTWwOF8y+SuWxnuttATfiJXikGvbZyEd4kMqw/34bfnvXC
 aAJJi68VpqrraO24f8ULE6ktsxy1KGnx2wuUdZZImHA13i9VsN3ETE9NE7ehtsAFV8Lc
 Q7aRq/559rLN7F/FDfp6zMwu4sE1QeWeIuCsysAjz9DUTq/8px6bdMKqc4raJje04XUE
 +myKxwENR7hmVt3dcRNU+TjqACro7O5mo2X5ZND2asPrJceGn/+7LMP3IAeznbdsYql+
 k6lw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651195; x=1777255995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iqIub2Hijsg3MOJuPpiA4LZGLLDPR3LX4khAyh9sL0c=;
 b=Yw6Q8fSyANVzxi/BiRCpsIpbTliHjI6Bq3OyvY7RHcPhfsBIOE3To1z5DhHdqsyyqG
 nUfOGRz+0dx1gCrfTrePQ5e6LHDz6+2C4e/dwNL2yvOsKDJPCo6WWVkFLXvZZBEdPgre
 V6XBjksukIzwVothPdZRyDzcP9dZx551MDTjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651195; x=1777255995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqIub2Hijsg3MOJuPpiA4LZGLLDPR3LX4khAyh9sL0c=;
 b=EyXTAzShbYG2aKKykKhsfA2waO4ziil9uIwrZnvQLVS78k7Hqb9RNUerWAsnH2xYtA
 0tBZaBv814YUM/qPjHgRljYvzVRgnct2F43/3KMME7CIrwLeGtjwBwbbrb7k0ZJYcNFP
 1DnQtLtxMI4qBs1EXt6TxSea2uIDHB13+seRFzY2ym/mIGqe4Nc01Y3HQeem76Xn4/72
 5zh9vvRM2AODpsGYi3YKwWrAxSMhv8HKj0fhdA/NkwqIwHYdn/lhxaTRFOiutVvK7If5
 iuupP1qz/rIvuU2igzWqzCVPLgZ0mXN+1Bg1gV2tSaleo2HgSsEGYvtqTwRayVyn3Xdc
 fiCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dSQ9PywFlbmksFxWQQMke6wr3r165zXjw0ItqYFlLYXU62/QvbJ0BU+dq8QcKyEK+Z9sR02k=@lists.denx.de
X-Gm-Message-State: AOJu0YwcoinTAFQSSVXl0FZ1nizqylsc3DnrO9jmwPnU3OIJWFX/OOPq
 2YQ/wAg9e5WONgA1SLOJl716zJgYPR5+bHv3GbAM2WCFenGx42WGo95tMy+WNnclju4A6Rv75jd
 2cMZzOIb/rUHoLehJ49PHaa3D9Uf3DnLHDXGmszKm
X-Gm-Gg: AeBDiesnYeWFs6dKgGEA34dInq1CfxDDTOugSTsNr4O7j1AO6P+9tkJaMbqne3DtoXV
 WLhK9mYDLBp2YK2P6cKsaF1UuBFpk63Yjm9HSKjuniGi+0zfiPH0PjPvgv+NhsyD7YKSDwwwkGN
 ZnzUgFS5Bdjj5NtvuM28bSsSSZHO6CgJdnAIXGG7sCTdiAsTuSBeuDzQQRwYrmfB7KS4EtVmH5a
 OrtsrwowRPDP2/aK053hoicHoX0TQPxQGC1Utm4lcjpAIc1LgQLCm/h8kWFR7subC2kmd60/xEM
 X8EN7aZGGXJ+/JSZ6Ryr
X-Received: by 2002:a17:903:1ac6:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b5f9e77d75mr119466605ad.1.1776651195495; Sun, 19 Apr 2026
 19:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-14-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-14-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:12:45 +1200
X-Gm-Features: AQROBzBNSTujfZT9zv7iL05cS0W5FzBOWqhxlN9kwiKrOU81h9JOrehX9twz9mM
Message-ID: <CAFLszTgLpjHcz+Pj_9bbtHhOjqeOcPU-8T6j0_7tXiL3aSPJeQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] test: py: vboot: prepare test for global
 signature with ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: py: vboot: prepare test for global signature with ecdsa
>
> The vboot tests only consider rsa for test with global signature.
> To prepare the integration of test with ecdsa test, the signature
> algo is now explicit.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/py/tests/test_vboot.py                                  | 12 ++++++------
>  ...sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} |  0
>  .../vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} |  0
>  ...-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} |  0
>  ...x-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} |  0
>  5 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
