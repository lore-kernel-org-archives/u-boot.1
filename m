Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B97C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 16:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE4A882B8;
	Mon, 24 Jun 2024 18:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TdFNdnQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1B287572; Mon, 24 Jun 2024 18:39:03 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E08882B8
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 18:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d24724514eso2716668b6e.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719247140; x=1719851940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4ikWD7DjT4q4QDvAIybToauGfOKMU5mXIxr0xi7ONo=;
 b=TdFNdnQNep2Ro93ItJcWKsKplPIMNrvZ6bWJyZNy2zhTU7kbNAz+l2xdeGzA+5bRyA
 xEAO9HTk241xEK3Z1yv9P30jR96zCZFKWBeG5Nt+8vVycVImMH9KwzPfn+BRT9v4BC0V
 eWVz6IaeDF+P6XcX4KF9GI1RuACbNBMEu24eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719247140; x=1719851940;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4ikWD7DjT4q4QDvAIybToauGfOKMU5mXIxr0xi7ONo=;
 b=DCE06r1T61mjtTjorEF/f+YO6lu1imx2fas8lO6TeuAMpCTSeQrbQls6u/sF6rrZLm
 4Bp3lFWwEC8NJHR4jJIQlV+9w9uuIJssfl/ACxYutt+YxqXTJnW8ijJQVGUTcypKohi7
 XAzkhSHsl35ZvgfGiefYj/HAVx3J+AX+DhbE6upeBubFeJUmxOB8+RqA/kOX/rHlZ1hC
 QDUgZsqnUs7ur1sFQIZtIC6vUo7OyLiffjZ6Gyt4BlUSDmPEtvkrlYPnC7TQEPBNvZZo
 OTxHviCVjAgPb7wsYfVpz/ki6AmzzU2xcVfb90Yizfg9O0OSUwbkL33peAblY/B4A7Ak
 kLJw==
X-Gm-Message-State: AOJu0YyDq8KVn0NkiZILR1g0HppXvby4pXIhciU1/sabwMkEeW0t5ODq
 6INq1yIAsN58zfrkLheBSwFPid5IVuqdQxy+qnTKsGvAQVIdOJFvxEu67/A+Wdo=
X-Google-Smtp-Source: AGHT+IHb24g+xbVg0LjDmutqkQkPVg4fdqjgaqN8jabxzK0r3OSNLXQYt2rDPQ039ISPoSBYn+DYzQ==
X-Received: by 2002:a05:6808:1707:b0:3d5:123b:e2db with SMTP id
 5614622812f47-3d545a555a3mr6729454b6e.41.1719247139498; 
 Mon, 24 Jun 2024 09:38:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5345e0c6csm1498120b6e.53.2024.06.24.09.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 09:38:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-kumar1@ti.com, a-bhatia1@ti.com, afd@ti.com, 
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: n-francis@ti.com, nm@ti.com, joao.goncalves@toradex.com, 
 j-humphreys@ti.com, d.haller@phytec.de, hnagalla@ti.com, bb@ti.com, 
 seanga2@gmail.com, sjg@chromium.org, clamor95@gmail.com, 
 martyn.welch@collabora.com, m-chawdhry@ti.com, a-limaye@ti.com, 
 sebin.francis@ti.com
In-Reply-To: <20240614124442.178280-1-j-choudhary@ti.com>
References: <20240614124442.178280-1-j-choudhary@ti.com>
Subject: Re: [PATCH v2 0/8] Enable QoS for DSS on J7 family of TI SoCs
Message-Id: <171924713797.1682286.16213893248130375890.b4-ty@konsulko.com>
Date: Mon, 24 Jun 2024 10:38:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 14 Jun 2024 18:14:34 +0530, Jayesh Choudhary wrote:

> This series adds the QoS for DSS on J721E, J721S2 and J784S4 family of
> SoCs.
> 
> Before adding the support, cleanup is done for AM62A QoS support[0]
> and common bit mask defines are moved to the common file so that they
> are not defined every time we add QoS support for a new K3 platform.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


