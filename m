Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEA4D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B708E8918E;
	Fri, 18 Oct 2024 03:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NDCCIOQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E910789117; Fri, 18 Oct 2024 03:57:51 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DE789155
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so11467596d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216669; x=1729821469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GJVwQUIoygDd0q8b+KOjE8pbKSWuNK5z7cLHEE0YWnU=;
 b=NDCCIOQUT0Bk/4uSFgYAE5PBkogNgLYbtALdqSNGJa6QmydO8+dUxVttGLlI97mSLs
 vTuHPoL1woX/euPaQRxfZRdNSVOdhLpS/qQ6IMJ6WAmljvyiAX4kKsLZl6NIrAe7GnpE
 rIZv8Zi/jPZJkn5cYv/cmqk1QABmtW2+HyzTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216669; x=1729821469;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJVwQUIoygDd0q8b+KOjE8pbKSWuNK5z7cLHEE0YWnU=;
 b=H3ra2CszjcmGSWU2q/BAtcSFlY4aWWmLsvY84nTfOFHu9FVIvMmtk8nObv54UPnVWQ
 D0Noik/fvRqVVrzCf1z4XCfrirgqHcYl2PsxT5u+tP+HcmcPmd+jVGOl7oT8Q827KVFC
 JVwA8SmwBBMWEW5EpFBbBq7C/xI6SqdHvaYauIzobr/7msdXSd3FInBBEsP8eGpVjNjF
 KPdchq9PL7A5hyXMApiXOSa5CKk14BBzh90+O2x7r+aPkQ7PbQqansZFrKKq7eHQAqMv
 G4caBV3BMW3TcGkdRYoWd5L4do376nR78NwwwzogNSr9iR44hZBJ5+pZvBVlDLHomcSC
 +2oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPSTjxUAbiP9LCEp8LnMTZxJvnPEjBhs7GaKrZraTikbtYM8KkG57LaiU8ck/1glxutT3B6nM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxya2yF5jyBJAonEjWTlnqo26aaVOqlURmfH7tlbbVRyBEsDUw3
 ZmbQSx0RFQ2CoyfbSJTBEhyZMDsfgFoK6JlvsFwP5PeLqcCkcJRLcGjraPFqoq3jWpSapF9X32r
 COc8=
X-Google-Smtp-Source: AGHT+IH9j0C3baRyvZxMsPOWekgS1pXrvN9Os5F2mqeeqtyOUS86qUAI8C64wUJr/wB4pTJbiyrn4w==
X-Received: by 2002:a05:6214:5784:b0:6cb:f87f:f073 with SMTP id
 6a1803df08f44-6cde14c111fmr11078806d6.6.1729216668810; 
 Thu, 17 Oct 2024 18:57:48 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: n-francis@ti.com, u-kumar1@ti.com, kamlesh@ti.com, j-humphreys@ti.com, 
 d-gole@ti.com, bb@ti.com, u-boot@lists.denx.de, 
 Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20241009110447.296776-1-j-choudhary@ti.com>
References: <20241009110447.296776-1-j-choudhary@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j722s-binman: Add support for HS-SE
Message-Id: <172921666662.1016776.17297027142563895006.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:46 -0600
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

On Wed, 09 Oct 2024 16:34:47 +0530, Jayesh Choudhary wrote:

> J722S SOC have two variants as HS-FS and HS-SE.
> Add binman support for HS-SE variant.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


