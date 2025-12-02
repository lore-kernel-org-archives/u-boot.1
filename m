Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E25D12671
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 22:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A33D083F20;
	Tue,  2 Dec 2025 23:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFdlEjPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A0C83DA7; Tue,  2 Dec 2025 23:15:52 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9210483F20
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 23:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so3891288fac.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 14:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764713745; x=1765318545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Io5FysrbtGE+tTn8TRysgaezQy/ciVAi7Fi/vlw25K0=;
 b=eFdlEjPAER87rr/NFx1I6KwD20OZ+V4CNg7P1DhE7lTk2fsnFisuz7gWIgNrJ/5ulC
 oAOVv7Yu4i45mjOfmCb6LF1rbKZTex+ku2fTmmIi6ymLgsdkc1Zrd+XDfjmSSKQB0+Xy
 P1A737UwGq2EoCgLyjyXiTu/8gXCJJsNQvC4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764713745; x=1765318545;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Io5FysrbtGE+tTn8TRysgaezQy/ciVAi7Fi/vlw25K0=;
 b=jkmxBNgvaHxdgOBES/h/EBIdlF1yUi71Zo8v/Q4pgOB9rsYVVvZWa411czqMECctn1
 WQzEo5pNJGRiDJs3X51gvlSv+s7GaC/I4V5WguAso29xOw/eHx/cIqPZ6O+CkrPMoz2J
 JDn8ivy6VKl331YT6mmo/OCwI4UOFknq2TxgncLS6sgy220urzSjkAHANGxkVnc3Q/MF
 3qV/MYFnxhdixZ8+rWqU/mtmWaRi6n+A3CqxY8fAvAhKjgHvr1rF4uQoFOAr5nzX0JVz
 wlMARNpKHVwHUEHvq1ksN10Jqs+P4UXRj7+y5WabfJXqvgz8Eb1CuJ1XHKG0CINzZihh
 haFA==
X-Gm-Message-State: AOJu0YylkcO2KIWSE+aoBN19H7LzRJWcoczipRF/jwrXzbSEYmBjlOAP
 u5jC1BGJfm66fzwTuXbJcDmLeOuRf1vMpit50u/2fhyReDmL4aaO1unqACB8u66A0rQ=
X-Gm-Gg: ASbGncuD32eymKqTNK2Ac5+QViFf/eR7Mm/yxstj1m5A/gjqkxKZcEClme6jduCV+L3
 hi0IFiDqmHNnbXW8sS0YX60LqQ9vyTjeYwYcxd7wIiL9P7EIv9n5P1yi1mUXoQwPtTHigVPwjCv
 ML2ou+xqX/ixumKs6fSuWJh0L4nbr3njlZ57ZIC49t4i3ljMsNKUb1mCh8Im0smNeTDC5p19EWd
 BtghMkg/zjYgDPw/MPufI7FF/SIpTLF9aRQWP3XRw92bwYspszujdLrg89OYVDCz+q0PNRnWMZb
 knyqvYC1n1A1sAc+PJoBnb+ebdGrURrbtmpqfOl7OIvmaqxqlrDPKoaNyqFMydSAIw3LAF2yomq
 lSVdbVt7g2XwPcV1r9hKj6hWp4m1CbhxHB188VntFVdpPZg0dxYtela4cH0AXrL4wbR/zt/xeb8
 Ot1eEoV8CoFFLZ2OfXSMEaDK71H2SArYEvnravoW2q1DNwPgAD
X-Google-Smtp-Source: AGHT+IFqGE93YZh91JEaqdzBdy9oRcIceqaRmRx1raQ0rS34ICmNN8YSZIOaEUgyEaWqzX0TrCoIpA==
X-Received: by 2002:a05:6808:210c:b0:44f:e912:eaa3 with SMTP id
 5614622812f47-4536a29410amr633849b6e.32.1764713745162; 
 Tue, 02 Dec 2025 14:15:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dcfdb503sm8653606fac.14.2025.12.02.14.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 14:15:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251202195904.151388-1-marek.vasut+renesas@mailbox.org>
References: <20251202195904.151388-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176471374445.2966856.5458180808118981197.b4-ty@konsulko.com>
Date: Tue, 02 Dec 2025 16:15:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 02 Dec 2025 20:57:43 +0100, Marek Vasut wrote:

> Two fixes for R-Car Gen4 and CONFIG_ENV_OVERWRITE=n to always expect setenv -f
> to be used when overwriting ethernet MAC on all R-Car.
> 
> The following changes since commit c6ee44b5573a90b0a3a36cf858954e04439ae632:
> 
>   Merge tag 'u-boot-socfpga-next-20251201' of https://source.denx.de/u-boot/custodians/u-boot-socfpga (2025-12-01 10:37:45 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


