Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC12FCCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC85E84563;
	Thu,  9 Oct 2025 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iPslD2Lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DBB8453A; Thu,  9 Oct 2025 16:19:04 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D297A84547
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7b6ac55cf86so721813a34.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019540; x=1760624340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AT5x50x8k34WnxeW/bIcH2B2Ia8UI8c34o73W+89nlU=;
 b=iPslD2LbGcg7QuwSzKI84/7V+Fgdw0OEQbLJzBtgKF3Ii7xD7DjE9HG65XD2qbazpc
 COJZu6hIv2kpLhyWRPdOcrIWUEW+TsIMspKUS3k8NjiVK91PaDGQKRti18Wgr1qsD/Zx
 XhwiBRWQOxlnXndZG8gpgRUYPPM6TBrWK6e7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019540; x=1760624340;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AT5x50x8k34WnxeW/bIcH2B2Ia8UI8c34o73W+89nlU=;
 b=l6CgwLNxHhybY4ld1GBY+jFOdPlvvpJBXUbTyLbRum89mCPWz1qzeSv/j2rpIsbHob
 laX5FtbFG/lLZq2flQBsrAQdduJ7kVg7cgM+XiOdSTwXkM4D80EQgGZtrf6/8Q3aW2OB
 bZWR23lE5Gjs2ffYF/05SNVxQ33bvoRRMiackjWXGkdVNv0Ot8SAJJt6qcKFJZtQmft/
 6gdoRDz7N7sFHXhoRfjlwO/ZMr8KYzsoEqe9i9C26n6U5VgygIzYbGIBZG9VYV8rTiue
 rJ8lAsGoKLnZCJOC0egFXXLyflGj4EGmzszFcdla6QWl/0koNAPYbvmmIXanYsHZ69MQ
 arzQ==
X-Gm-Message-State: AOJu0YxUyNvABB8ndcZRxr1EhVDLf+XupoIwMDR9C9hgLmabc6NGZ86V
 QMoQ0ZBAcp1S/OtlCUxrTbrBY9LfA5bFels21DA5MCS3WbNv1VM2RORlTOcSdwqR6I4=
X-Gm-Gg: ASbGncvcB6GDK630214FyyWGeiEVmcms9aCDjOPu1e6e+yVVp3++EJFz0UR+yW94gfZ
 8i90HovSg1ZAvuSLlECxdJDGVxxz5wkA0jZFXrRORmVXNs8z3erNGHOfRZTiLdgt9km2Vz+YsT5
 sLLzbsPJAfsJ2FeXZFtMFisE5x4DSBebSzfY2GmtsCUw9rcr2C7y+9sQaht2CVijrb+k+yhP974
 ioiPN/p2OLFoNqpJxCtqY2CVVinr48xpIF0q+EFdOnwIvwGRLe+LgulrCaa53zZHqCqsDHqGSf4
 Vyu4gxKc9a5fSNY6r7agr/CH3/QhgCadUiGf9kAZrwojc860H1KAEb7hJz4u5m3vr2D2ta/cbJh
 68+BB8NdHkY5j0BTYssYVB3L6EwMruR0rfeypN08KHAB0fqcJz9hBfdwON/IX0jXw32ihIf/Hli
 6FDp8EyqNm
X-Google-Smtp-Source: AGHT+IG9nR04mvCEP3wvgEWJxVSedxKVIa+lzl+g4WfVu4tgdWGjpwECDRC0TimAbjXfyWcE59Y5qw==
X-Received: by 2002:a05:6830:6b09:b0:785:1b36:69f2 with SMTP id
 46e09a7af769-7c0df75195bmr5137811a34.14.1760019540584; 
 Thu, 09 Oct 2025 07:19:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:19:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Harsha Vardhan V M <h-vm@ti.com>
In-Reply-To: <20250926153138.3680886-1-trini@konsulko.com>
References: <20250926153138.3680886-1-trini@konsulko.com>
Subject: Re: [PATCH] misc: ti: k3: Tighten K3_FUSE dependencies
Message-Id: <176001953956.3159859.10122141664732886878.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:59 -0600
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

On Fri, 26 Sep 2025 09:31:38 -0600, Tom Rini wrote:

> This driver cannot build without access to some platform specific header
> files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] misc: ti: k3: Tighten K3_FUSE dependencies
      commit: 1d77a98b3d8c39a1421b7ae44186cb3a1c22ec7a
-- 
Tom


