Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB6DD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D20183BD2;
	Mon,  1 Dec 2025 17:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gs1qCAUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21D983C0C; Mon,  1 Dec 2025 17:03:41 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC54E83B81
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso2750590a34.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605018; x=1765209818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Af7xbPQOyg4XrMRBb1ZHOhYAQ4h2Xu6rvFI3NyXfHt4=;
 b=gs1qCAUlfBSfpYuwot8RypxcQS4H4aGvzTTUcUR6+hw85gM2Ap0oB+i1qZ/RTAIwSZ
 o13NXRotuGTjmoKpTgp3WX9r/DeaUQACBcSH8QV5NPajvDXAmCiesvNXfR82AvL48JLF
 0tnbPMayn2T6qVADMNJkrIramzVxuh+SfqLrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605018; x=1765209818;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Af7xbPQOyg4XrMRBb1ZHOhYAQ4h2Xu6rvFI3NyXfHt4=;
 b=MLXF/Uf4nalfGD9YoBzlDDBElnSu7Kq8s8JN0/l+3YGbU4NBXHgwQW1XzIVdYi/hVo
 eiqrOR9shG1VqHsCOkeMeLUk10wJeUjEW5/lhcPDIfCx0d+r9zBA+zfTLxtxWfCJYQBf
 HyKnbDLyz40w4Zut0AJaiVl99+v4PWIc55XDcRgGY9psp5Abg+mC4SP6Q7IJ+O4i6N/3
 4+wCmyBdmkhmGvjx/pDJX3w4hok+IA2NQfYfY2K2B31a1jNlqI5uirHaErh+74IQbFx1
 CbI0PaaoJu04QZEy6trD3GbJvySpXrES16Pmm1+72fAdikZfdNvpOi+gxbVN+KYtcacS
 Hr+Q==
X-Gm-Message-State: AOJu0Ywb/bjDko3nvpxbwntUOoa434CIRiB8D4S4ZEcgut0/MPWeP/DY
 KbTNZF6nW/BeUMUMBqnATqN8alGaIDXaOJbm19c+xmfTLp6f1VSnsDxRBWXz93OQjc6UTSbznyW
 RhQlXfGA=
X-Gm-Gg: ASbGncvQvolXDCf8EEl898ozNgasAa/ZYJdoz0Gdi+mA04FOyeATbNc+eLT9X3QYUNj
 m4DAlFN7sXI7Vpo6jcVSDcsRJMf8PRQkWJPZYFe7+rg6xnDB1SboEl8t4lQbALi7jqkA5ohZusU
 6Oj4h9MlgmS3hu9P/MgsZlOcSdUcA8FJxJyge1lyIwHLVptYpCAjc/XmUNM2RjLrrmA2+h0daI2
 Lfqo2eVI+Gf4mqxo0bFEWAna8GtmKh/SkTsJzISjhbpesZAynmKuoLMgx92EKuNMFXu1co93cgd
 qpnxBUfa1dhLCojTYW7meuIZfFeQnYcYw3aJ7ECJ8CIAsuO6NyOuULqRCcVuEsOBb0kT0f69QIO
 B0h39+eGhMrcNYATZcGx5wu84WwNIkWqwHVMEOMQhauL2eXQeyzlroF5AcEjHMkt1TA1/lNOocX
 yj88CIIqpjc+6QquArzx+L+11RldELJz7BiF92VlrEnLEQY/4d
X-Google-Smtp-Source: AGHT+IHkkKVIC+yh3dZ5A2n14KOAwYDI89dz1beEU+lnL66whiW0uGsjMkudnv36JuBPKJtTF4qdmg==
X-Received: by 2002:a05:6830:6aab:b0:7c6:e92f:41e1 with SMTP id
 46e09a7af769-7c7c417815fmr15634161a34.14.1764605016928; 
 Mon, 01 Dec 2025 08:03:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d811asm4708061a34.1.2025.12.01.08.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:03:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251201140656.1045134-1-trini@konsulko.com>
References: <20251201140656.1045134-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Update to latest container images
Message-Id: <176460501632.1117748.5866125537905395871.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 10:03:36 -0600
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

On Mon, 01 Dec 2025 08:06:56 -0600, Tom Rini wrote:

> - Bump to noble-20251013
> - Include tools for sage lab, build TF-A for platforms there.
> - Switch to distro provided trace-cmd, add libengine-pkcs11-openssl
> - Use mirrors for GNU projects
> - Switch to QEMU 10.1.x
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] CI: Update to latest container images
      commit: 42a4ff5f63baacc414b564c02541cd1f5c0862ee
-- 
Tom


