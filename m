Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F8AD3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8694C83AAC;
	Sat,  6 Dec 2025 15:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M+kCheAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4EA683A9A; Sat,  6 Dec 2025 15:11:09 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3247830A0
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so2568438a34.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030252; x=1765635052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiPRM86sl8L7iKV1MJN26U0QhgMOWHmCPqor4HrdZkM=;
 b=M+kCheAU/QY2f1rNnwc06wbmlqnNV/AA7TWDPr9yxjiWYnasOhpWmUpFtQW9r7gWvu
 DS+SruGiwchD8TLdakWl+A5vR20/vpKgOmPMYf0MQd0qWfpqRBLrU0zVqXKiJK1FZv+r
 9fCPV0mhiipjq8laSh0tWoe55FwJvv21Jn0qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030252; x=1765635052;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eiPRM86sl8L7iKV1MJN26U0QhgMOWHmCPqor4HrdZkM=;
 b=aCIvgHQbVG5Ru8/mDZiQDJhQVufQYGvz7OooWXsD+0Nj5JKlmaRDDw6YoQWT+yo/Ir
 muqPGRyuBLkFVCXZY1cmF9WJTIyZG2ywEW/Xq9l8jM/eeKubJVQX5CBQ3A5+9SmsbGot
 NGsFoIX+AWwg3mgyz5vgxIId7f9CflaJzbRbKr53KKOeNXX+/tA0PnydlnGc2LdSnz6e
 HSLIvq7tePuuIXLg4scqGdGyMi9Epd08ZPl9g/1IcWNs+u7K1Vcaqgtk/0vQVgG3+910
 SfVQR/JAO4kL4DEVFbhk0hwGRDiyspMApUebpaJv0yaiNNZaiAbAhuPxgE04LfLKqmj3
 YU6Q==
X-Gm-Message-State: AOJu0Yy0I76Vud9435K+07KULD+Vpknk5WFf0yGTaFu0R2j6twnrMiTG
 ux9NL9rHXzZOxLtpCmOHoDxJN+PCpL/Ybdt2PQniG3Y8vNk/se17ctt3vqyiZzij98Q=
X-Gm-Gg: ASbGncsX4LblHjvcngoXWqEnsWOw2rBBI5cX2VgjXAdC4wb4LJ9cF6Sio84I71eEd6+
 HHGvvPaPRi6HKFAsPOKv7jLiItVNjvRD63NRIZKdv6yPJIuBvU6FpDJyV5ngxQ7+CP/npP/bct6
 /32QeCQ4nYvqA6zebzQbWuVXbbxgkU0O2p6eN9evDfavNVSKnAmfa/Ym0/ZrvG+yQ3N1rDfmSks
 1xWz/3443PWegzuocC52ok+8QTeEkDenYAa3PXtvtNScgIqHzb3dEHSE/Q/A36dzKr96U4eEMlP
 n3FlM15wXAzv8Gz1qODnxAmPzYEO5PQvQ/gdci2HWvvQoa+guXK7vK1eJTVEYvCSUdSBU6ZisBL
 XZJPKmb7AmyRBU8bCv8jFloU2XeOJRYAswyYExRMljynaia7pBjIsjubw1WhgxJhfelbP1ijLEe
 oz8LCI/OR//igLy2Cp3uKjXSiQUdbqrbGaZRzOJJ/LOO+mvzXA
X-Google-Smtp-Source: AGHT+IFB3mxF8nG3x8V/wcyaYxmCsSRWNPzg5qCbBp0p3F1diva/432udnODFxx21xb1OtTC1orymw==
X-Received: by 2002:a05:6830:411a:b0:771:5ae2:fce0 with SMTP id
 46e09a7af769-7c9707cb166mr1326075a34.20.1765030252552; 
 Sat, 06 Dec 2025 06:10:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20251006153859.280336-1-trini@konsulko.com>
References: <20251006153859.280336-1-trini@konsulko.com>
Subject: Re: [PATCH v2] clk: ti: Tighten some TI clock driver dependencies
Message-Id: <176503025172.2523567.15412036289428186870.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:51 -0600
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

On Mon, 06 Oct 2025 09:38:59 -0600, Tom Rini wrote:

> Attempting to build with "allyesconfig" means that we try and build all
> available options for the sandbox platforms. Doing so exposes that the
> drivers under drivers/clk/ti/ can only be compiled or linked on
> ARCH_OMAP2PLUS platforms as some drivers require platform specific
> headers while other drivers depend on these first drivers to link.
> Express those requirements in Kconfig as well.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: ti: Tighten some TI clock driver dependencies
      commit: 9d69a2d8a092abab761f57795e906a7a579b3a00
-- 
Tom


