Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D09FEE49A6
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE08F86BF8;
	Sun, 20 Aug 2023 23:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lBPok+L+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677CC869B1; Sun, 20 Aug 2023 23:57:33 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47B786A18
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso3419144a12.3
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568650; x=1693173450;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iTM0W03CGIjuA83gH8nh8RYwvXXqZdpvJ10Tqk25L0Q=;
 b=lBPok+L+ftEvryQ32taDkywWQDejU33SZ8iE79giN+EMf19rFfhXMAQhqTFbN0og9C
 R/7UT+3VeYV17X9WdMC1pwJ8jceICYRlVbkcLrHs4/ad3BrTa56EtBNrKf0rJQEcgVmS
 12wEXNyJ3fAXjuuIvroGf0PZJHE1dsbtEkIag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568650; x=1693173450;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTM0W03CGIjuA83gH8nh8RYwvXXqZdpvJ10Tqk25L0Q=;
 b=SrQJBsI6FbtsJOUVyYYrxLZApt5PM6V88H0RZYahXxgWBwDwO4DpQU99TZuAmbr+nR
 OeHbs2sHMxTKoUDvX3RGv5G4DBiLk1JVvDZn4zGNEmqndOe+aFt/0ZI3SCFChJdYBQv6
 efQOuU0+paqgtaTi0ze2QCZRaJ0N2dwEJs4bZmXefIEWnwRssXw1KychE5aTRUyhyyxr
 LyfIhNf1rPUQHxihECbRxTVkxU4basFx6Y+bTaHqzZ8Htdn+VN4XegAvbXHQSX/eaADt
 NhvpkIdhfZYAQQpMWiCygMcSEOWSgNbukHVi1deKr+2++wxEImqIM8RW0IA8Ij9v1sRr
 7tiA==
X-Gm-Message-State: AOJu0YzeLceGvoC19dr8dm9RDGoMAmOfrhnFlakLVlm1QUCFWP1fnTQM
 GqrlUI/8O93eBnb0hiAI8Yb3WBS0lInRv6xnSyLukfinE1UI6olGL+M=
X-Google-Smtp-Source: AGHT+IHDrfMvOpXVlBYqPF3XUIbmmGfveKEOSw5Mrqq1BJ00Nbf1OmsI1ksCGU9nimH1PIeZK5LIVHoEhaKf3oOGzao=
X-Received: by 2002:a05:6402:2051:b0:522:b1cb:e6c with SMTP id
 bc17-20020a056402205100b00522b1cb0e6cmr3782372edb.38.1692568650340; Sun, 20
 Aug 2023 14:57:30 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:29 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2VQGOT6qTmV9SS1ngiS=uYpwBCPrH+t_a1ube9cm5BXA@mail.gmail.com>
References: <CAPnjgZ2VQGOT6qTmV9SS1ngiS=uYpwBCPrH+t_a1ube9cm5BXA@mail.gmail.com>
 <20230813195150.159499-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:29 -0700
X-Google-Sender-Auth: RXB9rBRsNaG_Wlu0qDk2MXQK3cE
Message-ID: <CAPnjgZ2ag+2bLEzWhaTz8jVrCsP7DhOjwrp+WwvHqGSSbN4utg@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable PCI register multi-entry
 support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sun, 13 Aug 2023 at 13:52, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> PCI register multi-entry support. This fixes ut_dm_dm_test_pci_bus_to_phys
> test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
