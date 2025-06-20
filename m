Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734BAC7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 13:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974C582CBC;
	Fri, 20 Jun 2025 15:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4361Mlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A0D82CF4; Fri, 20 Jun 2025 15:58:34 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DF580E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 15:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40791b696a2so482845b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750427911; x=1751032711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fBhAnIYlO5539TiUCXG2XaXCVlxKiapB41xEPa9q5Ks=;
 b=Q4361MloIMBbN1SPThfNyJ5NWClvJXhXwetg+dB4veswb/yYSVe8dJN81q2KI5GTR/
 wr6eKxCK2SLIKDPvfeK8HotK+DpkAuIe74faC4mfoQhwJRZKxH0A909Dy5fwwzxO7u1s
 gEDjsLCekv8nh2n+sGG2VQQFw0E1xN9uf18vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750427911; x=1751032711;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBhAnIYlO5539TiUCXG2XaXCVlxKiapB41xEPa9q5Ks=;
 b=jioM7qSUumJlvPpCxzTqO23HNGd6k06fgTRRLe2iEXqODsV7av7jnBh6SdB/pIctnc
 UVPAcrSqb8j6eJJGflWN8bhvsPPJhLMWu63NCkg2fUQatMrhj4CpFZXXFGyXTbaO2V7J
 g98UNAoPkRUkZDMlTwhl6PYDnlLkaM4TE5rJoOnyQlCS+TrqQH0BVi5nQyQ9D6Nxel65
 7XYrt+Mw6NL0ktlwyGKR1fVzThkHfog3PLMK2kbrJk30KPFoeSrQiIk28JUi9oRiEXF4
 0/5FA+1q0oUDVm8Mk7kvv9/iHJRjAjzZEZg/t/5kQRRdUMNc5yQWFo+orncArqELetRa
 WjqQ==
X-Gm-Message-State: AOJu0Yz4J37LOBqJP6Wf7C09OoDVtE2EGV8R8DffTLgHpP6JEZly2uYH
 2XzbnKPVeU66NbPIRZTOv/3ws/Mu9SfGdyTdRrvs9EcP2o1s0uUY4v1LJ2sSkVsrsGMfbmRLa+C
 ZsIVJYPc=
X-Gm-Gg: ASbGncv7c6qlPc+ckEMnhV0FQ0JUA5h0EyiNgJkmNSMuYw8KEOq0mC/Ez6OLqCfQpln
 0+3+spK33+E2ZI4G8+YBoLprLPL4AEp0M7RhbnkDR82oWZmSk9aPilRz5AWNvehE0aZImWCEGBj
 LduPfXTXxtOdxH45DqpxRtmgHGkCoftKQV2EY2+mDTxcXbQvZ1ULzHuRHiYSy2/zNNM4FY42Rql
 cbac3623q27Tpartifc147MDpdsVW0xQ0GwAgf2FjKNEIVrbMKDkzY7xAz0Z6KKsobYubWCsCEr
 WZJhw96aH7WZN1151uQsu12AJnXC8vbRC9+5WEtF2++kRpHU4a2QBqizrMj3goUYiwYLq73uYwH
 g+MG6TTeOJKRvglcZA5jABC+82nCvuBhA
X-Google-Smtp-Source: AGHT+IFyklXkjKjm28cHz+Gi6MFC63n1HYhqIipOVNkksu1watiTnWoabke6L3RNkOITDyq0bNfi8w==
X-Received: by 2002:a05:6808:4f09:b0:402:a5c:906 with SMTP id
 5614622812f47-40ac6f1f615mr2339206b6e.34.1750427911262; 
 Fri, 20 Jun 2025 06:58:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6d3b8basm298339b6e.47.2025.06.20.06.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:58:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>
In-Reply-To: <20250603170624.93376-1-eric.schikschneit@novatechautomation.com>
References: <20250603170624.93376-1-eric.schikschneit@novatechautomation.com>
Subject: Re: [PATCH] dtc: Add Kconfig option to pad device tree blob
Message-Id: <175042790993.2432286.5342964273820354633.b4-ty@konsulko.com>
Date: Fri, 20 Jun 2025 07:58:29 -0600
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

On Tue, 03 Jun 2025 12:06:24 -0500, Eric Schikschneit wrote:

> This will allow arch(s) that use device tree blobs to pad the end of the
> device tree so they can be modified by board files at run time. This will
> help prevent errors such as FDT_ERR_NOSPACE from occuring.
> 
> 

Applied to u-boot/next, thanks!

[1/1] dtc: Add Kconfig option to pad device tree blob
      commit: 5ba5cbf5a29d54763f30b6685e6c06ffd51d29eb
-- 
Tom


