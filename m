Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D21EE6B44
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DEB83AA7;
	Fri,  6 Feb 2026 19:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VXd3s611";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8935836D3; Fri,  6 Feb 2026 19:15:24 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9583B836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1890f5cafso365396a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401721; x=1771006521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQl31SfvmYJX1NhE9IE6OMnKCEOD0lUFiCj/O+sCSSY=;
 b=VXd3s61178JnBzY8j4zByHPwW/xRSQ/hJQTgKQUlaznFiiUFf2eTDlLTdQdbQSHvOY
 mEL0LsyzGraXBXU+O7ylvRCBaM0mxEBwHj479knoUYvcBGhXsY4GaHQ/HfnAJXZoW4Dg
 Y5c01Yi1tIasDl/4isHLfoLMOn157ssX5NgZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401721; x=1771006521;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PQl31SfvmYJX1NhE9IE6OMnKCEOD0lUFiCj/O+sCSSY=;
 b=HgVZqGEEEpJ631jfiP4K8+Djxk6VGoHFM5dzndfHSu9EJp6Ov0PiV841ZQiHeLjkOf
 1VlUXJGMu6WKkJ1NNyJ26bZ/mwVP38HCj31xoAUlveOpn2GrNgyUXYpNwHfCWOIHsUbx
 0fsBqxPFxOiGTWbJat0ZEiO9wq/OFubCvjsrh7JnojvP4jUA9qqvuXvdIEckEGfBfFhq
 s7mFNT5/Z1ckWsnQS9XJaVOyOjYc86S0YHqcEYoLdPkF13c1WP/CveagW7fmcBDzfEU/
 L5dVdFxlaI65AIvxzVln8hCCbw7x4Bp2elv9k54GWbAJapJYuX1MvJtA8vgerGN1LCXt
 nj5Q==
X-Gm-Message-State: AOJu0YzBtjK0FfKMixTwFqkzbPacQDjzY/VSvkPX9lpRedmp9KdY6WhX
 xutrRKB+4/wm+JG55Ww2RQTtPaBqvHJFHkEE9c/uSEMcTLFcmezHFNoEwtGtPaKOA+I=
X-Gm-Gg: AZuq6aJhWvHX/rioi1uFQFAIlF4Vhs6olmq0C2mtV22rySStbcQFHbIrvFNinBqtGnp
 j/WobH9bJQXON2PROTQxEajCQ6w5lIeFL2w4uKz/Ws45SGlKqqp5OmOKtYRzmF0Gh4569ISD+X1
 /xTRqPacydaPHPopUC0MEdPTaj3x8V00Nv323HKnZdYeT2qnrO4DsFR/4eFipghSBZmIesS3vvv
 lBO/TY8TPqUCyvfo5Yz+h7tPJ2f9P3C7jnLHBJny57siPRkGwNjlEONDr/cg4gK0vKl8nz7qikd
 Ttvzjnmi6EidCak3Ua3ULNLuSMWCTGLsQFfIUPYi8FbBwCahITiyDNHBAE/qLbGlW/wptm6aK+m
 xXCApcLfjt3HbrPXxG5/dT17dl9k69I4lMCbbCPn6PQH2rNp2y1pke/qZ9lgBAYIhbdN5YQp2lv
 dkT1AxZOQSIa90R1ffjwSrBt0Oj7Fu6v7XdAXgu09TvMcyJqmLabI3ULGePCi7CaGHDTZbOr/08
 Ur3FKZPxsKxdYlAoYCt2N9FT3YWHUZ3PJH5qw==
X-Received: by 2002:a05:6830:3889:b0:7d1:582d:71db with SMTP id
 46e09a7af769-7d4646c772cmr2072110a34.38.1770401721266; 
 Fri, 06 Feb 2026 10:15:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Anshul Dalal <anshuld@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Garrett Giordano <ggiordano@phytec.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Andrew Davis <afd@ti.com>, 
 Gowtham Tammana <g-tammana@ti.com>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
Message-Id: <177040171984.4023747.6786276250663802944.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 22 Jan 2026 19:38:38 +0530, Anshul Dalal wrote:

> This patch refactors the nodes in each board's R5 device-tree to common
> SoC level dtsi. No functional change is intended from this patch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arch: arm: dts: k3: refactor common nodes to k3-*-r5.dtsi
      commit: 3382d75f7a6ccc661c840b0257d85ca7be0ab5d0
-- 
Tom


