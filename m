Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BCDE8536A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FDC84105;
	Fri,  3 Apr 2026 15:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIOufBex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D84F84142; Fri,  3 Apr 2026 15:22:24 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E1583642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66bf15430ecso3445220a12.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222541; cv=none;
 d=google.com; s=arc-20240605;
 b=F2enodNrDyTJLlniG/1RbVL/Sj46IOn9ZfELDNZdoX635v5iaVk1tLEruuES2yzM75
 S+E4y1VO754LlmCeUxIiTD0Au/b3UeHwCI1t7ysJg74cQ4eexlEY8dAlEtQWEN4ND48d
 cngkURVuY90cmSfZcxQlryToCVki+YNCkm1dn9BLHXlb1TjCQz8iTRL+r2Oqh5cmPKoD
 q+CvBv3Egeu7kQZbF4EI7ajIcv1CYMwFy7xQwjkMwp4bNPO32wnNRYXxUuD5nfOp0kLn
 B8JOM7G/2zCDIRl3RrPpWhHzBI3QOUYuZLtRIgny9qntUDOTpOyBAtmF37gxQxyiuL3J
 WNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZIixh334PcGj9Ezwz5Ni+6EVLiFW8YDk9Dv4ruWEWt4=;
 fh=2Ai/DF/OygrgX5KD/xptwaXayaptkAAlqyY5KCXDcm8=;
 b=CHUyZcajzDHZtXMvCckPu6Ub5Jj1OreTzBK6ZzmJN+j2p7m3BZFUhUaymNwSQBmSH4
 gQR/jWBg1vP/3O0syXVXeNQBXCfJyllpnFG7Q5cCi8x028V7WWYHRVH7Ej38/L5HIqeX
 w/itxXBKGAugDLNoBpRe9ZVyeq3sXQVkvFveWl5XdP9uz9YcwoiX7236nArYZAYjdYn6
 Ws7nZ7nFkdv0GAG6J8mtHc4ysaaLAl9yQogBSpJ1FY1mo+7IqJfxIwutJXAn8uio63Nt
 RAMfrThk9C07z7dp5LcmvemoS3B40NoAbBuDxYXtWYj7XnFBsckrM06wjBWNCaW3SLZu
 Rk/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222541; x=1775827341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIixh334PcGj9Ezwz5Ni+6EVLiFW8YDk9Dv4ruWEWt4=;
 b=kIOufBexYI91+NzpGWA0FxEishhXclArTMpVtjU3rUSwLDu/gdYlaQK0shBm3h6yfh
 TIAVM34wC9trZOu55QOa7m3ZKYdAq3+StQJ7tm8TuR2BswPwZwHkXdZ3hnePnR2qO/NU
 CLf9DeN2Kavfud0KsA8JIM45eIWVEz67Z3HrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222541; x=1775827341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIixh334PcGj9Ezwz5Ni+6EVLiFW8YDk9Dv4ruWEWt4=;
 b=UQ9niipC0p8rjOEsDVbrglp2f+XImoPHCWIg/0qW2DoJDrU8JiQPzfgjtGY8CnxZ0v
 qAJQeXcnP2rqEc3kTuFpHtzUXQXlzRpwrW3pztTCLtJIKVk0+cKcz+77QUV0CqR95fqP
 ga9k816hdjIbX+bH9VjTg0U9Xe7bW9GQennDmyBXLgDBO0uLXfvjyhWLyskM8eW915C7
 bV9UnPzQ8aWBmp65OlsIWs4Kz20JhGbCf8WX0ocPWCMOmwfdJoa07cYAKlkF9DFUyI4K
 VqTL79KZRuRLr/X8/UII3wmvjTNEgOwPf7+m6k/dTJzaUw0TSvlvr/xfuKwNGEMIWg4O
 uIHg==
X-Gm-Message-State: AOJu0Yx10k2fvqBrhAs14t8kpnpCRakVC7sBv5Vl7pRn6XKXCOnWWTWe
 R0kBl57v1tJINTLaFmaWz+on2OYbIQehrJFWIDIDzrWkgITO3bFuMa6kJFKm/Iz0hg855YGaFwv
 5f5jEd6Rfp6m900Say11yPlprFbpR/6N7xqqmq8PN
X-Gm-Gg: AeBDiesHZQcaCxVOqzhgOYBQdU/FVL5ulQvKVm+dNfrNrfurne7ZLFMkrupH3Bm0B7Y
 s65AT4eO1gNgEvR0E3Go2OVBJ5ehTI82eQB5gX8iRkFl0g0OydYLKxOVQlXCiIL6r1Eszy/UvJm
 l4GwqfkiAYNh7JmOYQn4fwGradJ5AtCsS25kmuzGJpg1gkpBy81O3vw/Ln/vULpLYz70ewPupgA
 Hfz5g7S4ohUAHlOerT44Z2Ebt+V/m9SZ6Eit39Mb89S45st9/I0t4OUIlnfvMPBjTLHVORMSUrJ
 EDYcrg==
X-Received: by 2002:a17:907:93c7:b0:b9b:1511:a865 with SMTP id
 a640c23a62f3a-b9c67b474f4mr107711366b.51.1775222541589; Fri, 03 Apr 2026
 06:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:22:04 -0600
X-Gm-Features: AQROBzAxeyLrFafmxUTvmFCgME-u0BOytzcPfVx2get8MFA7lbJ_zE3CEp4ZXzI
Message-ID: <CAFLszTgoEiVfWCBwW=mmqCUKREwH1n9xapKaLH=m2uZHYFJ5aw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] tools: binman: Test signing an encrypted FIT with
 a preload header
To: paul.henrys_ext@softathome.com
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org, 
 trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, u-boot@lists.denx.de
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

Hi Paul,

On 2026-04-03T07:55:27, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
> tools: binman: Test signing an encrypted FIT with a preload header
>
> Add a test to verify the preload header correctly signs an encrypted
> FIT. This test exercises the case where encryption uses random IVs that
> would change between mkimage calls.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5895,6 +5895,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadEncryptedFit(self):
> +        """Test an encrypted FIT image with a pre-load header"""

nit: for bisectability this should come last, since it relies on fixes
in patches 2/3 and 3/3.

Regards,
Simon
