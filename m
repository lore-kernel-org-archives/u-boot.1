Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E913C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 15:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B2C82DA1;
	Thu, 26 Jun 2025 17:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oTvVfaB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6D582D88; Thu, 26 Jun 2025 17:43:18 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 928A182D88
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40a7322f081so305992b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750952588; x=1751557388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF1fxT8CnmzaBEU5yirLadPSeA/9GhJNJQ3HnML+xnc=;
 b=oTvVfaB4Ub25322m8D8FFGEhlRYUq62uI4q6OtCOQDJQ57Pcpo1LZA36hK+KYRMTPw
 2nBIjkyQbKmGUOuyKe01kQiaAwPOCKDpqVAXIPd8D/OJ7NLSX0UF7YlZv4lrKLBjj5CG
 dJJd0R8l34cVzdVbSnjU1BA41KgNKF3bRdo+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750952588; x=1751557388;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CF1fxT8CnmzaBEU5yirLadPSeA/9GhJNJQ3HnML+xnc=;
 b=Ns/R670R9f1SyKAwFIgIAq0K31xHf89ZbV0AJrod0LYsqZJdyHRIcnxcS1SlwOtxAs
 vXEnIy5NeCEwatIN2PPcCz3Wu5/fz6ESWMloS1xQrKLbiB3MpjUTLb4ZdTBMHLXFX+LV
 B9akYqaR1+09mdpy4Q0xGBeq93PXNuDXr1RXL6h10xq3qt789ziboowPmAxhuqn/4ALZ
 18d8eCRv8C11MugUHITpvZ/FBbD291rq7VVpf4ATKyAyyGGtBlAyWqRaN6Xx1dD6zgql
 zaoZOMMpnyzl7A4TD8z3xkD3Jvyvno1C8x2kjwZswF+p1ewip6kB1HzZz/+k3qdkxh0N
 QlRA==
X-Gm-Message-State: AOJu0YxM2KkPv/o4li9k8khuN7RaY/u+f+lBduwSCRFwqhJP95rkmWZn
 DZKNOX2HWkRrpSzToxt71uzVESuQMPdbSDlmolWejC3G1epPMG8lJYprCMBKFF89tjU=
X-Gm-Gg: ASbGnctVJDH6l5J7vM6cjfZayJYSdbm6+QZFaQQACdSL8/VqoMsGIA44hnsQ5ixmN8q
 3wGBMREy33j+TcxV2JI4hwJUTOP9bI5INv5b6edQW4zAL/C8MgRM2Sjpfx3exn35i5YBqbwZKdf
 Mr+vGoGNFxlrVv58JU8v+Ka1OYJEMRM5jtaon8JC+s/VSlZBBvB0QjUX/V32aEY4b+AIYpoyDnT
 hqb0J+xaso6uCV6yNWOstfs7ujTdYldYCaZp7BPTO5Evfxy/OiWwDwAPfwZnpIl3b3SEt0bYH5i
 d7J2BqN8C7NJiC6j7dnK2EZl6rV9t54yD9hvC8tfs/s7z6vSZ6A5wzKqHHuLh/RiQ+9FnYBySWT
 xPXoedUnRY8awcT0gStrVqQ==
X-Google-Smtp-Source: AGHT+IEwcyu5l8SodM5DIGUwIyEFVDsG24LWrZU5+pye3+6U+1VIGzwC9BTXLwgGAd5cgjgWFu96ag==
X-Received: by 2002:a05:6808:8204:b0:406:6a21:527f with SMTP id
 5614622812f47-40b05c75308mr5598725b6e.35.1750952588203; 
 Thu, 26 Jun 2025 08:43:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff2429sm20316a34.7.2025.06.26.08.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:43:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: sjg@chromium.org, carlos.lopezr4096@gmail.com, 
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com, 
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com, 
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
In-Reply-To: <20250610074121.8308-1-aristo.chen@canonical.com>
References: <20250610074121.8308-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v4 0/5] mkimage: validate image references in FIT
 configurations
Message-Id: <175095258688.1712035.9665307099803654909.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 09:43:06 -0600
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

On Tue, 10 Jun 2025 07:41:16 +0000, Aristo Chen wrote:

> This series introduces a validation step in mkimage to ensure that all image
> names referenced under the /configurations node of a FIT source (ITS) are
> actually defined under the /images node.
> 
> ### Motivation
> 
> When using mkimage to build FIT images, it's easy to mistakenly reference
> nonexistent image nodes in configurations (e.g., referencing a missing `fdt` or
> `firmware` node). Such issues are often not caught until runtime in U-Boot.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] tools: mkimage: propagate error codes from fit_handle_file()
      commit: 21705d39144a51a50c0206c74588c6e9e4018e7a
[2/5] tools: mkimage: validate image references in FIT configurations
      commit: 7a8b25a771f069819eab6134fd1c4df520ebc9ca
[3/5] binman: test: Ensure all config references exist in /images node
      commit: 3071e264c9baba4d55aa6d1a07a60c969d57eccf
[4/5] test: py: add mkimage test for undefined image references in FIT configs
      commit: 21f75eb7af40cd22ecee94554b2a226760fe9814
[5/5] arm: dts: phycore-am62x: Add missing tifsstub image nodes for FIT loadables
      commit: 647931cfeda1ed594904e7dd4262783a264cb97a
-- 
Tom


