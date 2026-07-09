Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54241C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F50C84AA0;
	Fri, 10 Jul 2026 14:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KmA3z1QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DE484BF6; Thu,  9 Jul 2026 20:36:33 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6A484A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698beff7178so199741a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622191; cv=none;
 d=google.com; s=arc-20260327;
 b=IfCl9rqBg+Kszrw9Kf+U3lCCIFVyAMmBQ3aE1juwoGVHyq2CI2Xpekod/2tU+9QHzU
 CxvWw7vRpSbjsT/OMNM0CBMFH4e2316/lLdTNzbM5+On6pMhU2vcTt3YgdDNA3lNEhMQ
 0wSZvHpA32p4pHE/ugpR3zFBfwWZrArbroQg/HZUzL/VMlNFbsJf75ceGfjd+/xgkT/y
 WoYCA6shdCoLAj8yxItf9GS1k9PoppiMrEnoCqntxqFBN24nVy3HgZETZKx5cRYl6jBb
 jyEJ1rQbxW2kKCMBIRV1BvwDB1BK/P1VWmQyRNqCJK2biXKWrVI6uolDuYHBoxMOyb2r
 cr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s01gdhmHz27dV9sPv+h+LpknhOdRT88YUUXjvnhzP0c=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=hEwKEKLz9SSBaJjAaBvv278hLpSsDrhxVf2tqHZ3cRYnVypzm8nXnspGKslC0I6j1C
 ucQqcFMkLc/DP9T33cc2mSkidGD18niWEljz/k65klEABshArX84EqomZOYWxXvRK6DY
 6fmSlTPWFa6/a/XiS4+tiTTn5wbw2vyAd16Qnvgd7Gm7HvWwX5al7Be19y9s/e0NvJXp
 IkelGkHf/vgEDsoTMnqfB+nCXSYzJi+ZLoLkKq5uLyukASKQgzCcwcH05rd4VETpeQhA
 06qBR9NLzBYIDZ/TfZaaWJpRxIioPSxn4OcCeTwT8RGmQNFFNBox7Hmzdf+ZkIEUW6kn
 MYrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622191; x=1784226991; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s01gdhmHz27dV9sPv+h+LpknhOdRT88YUUXjvnhzP0c=;
 b=KmA3z1QGt3gJS8E9O8uT8Ly8bzBDazO3FBMAQVzh4bopPZsrucEnTjiVT5Cw6Qnasr
 BQDKJzZklVs1X7ORZm1h8ezwjMNhA1MUHCiur35YMDww4q1Ca17wSVMUjDCiDqUPzTWn
 H8lU11Ei6tf8FIo06zVL07VyMC5mreCygIn2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622191; x=1784226991;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s01gdhmHz27dV9sPv+h+LpknhOdRT88YUUXjvnhzP0c=;
 b=BavLww16TPBHcxojviDPfOEhmrp9l/FuIGL7A+bj1zPR6sQl27KfTkGICvzQJYj+sj
 m9uukINSE/UybOWECQcc0uDFWbjEf1V8oODEpftdAGeN5ENp5caExyNoVX2FkqLMtjmk
 GO1Dc8bGfdk0bsBN+MfNTTN58OvJs2H5xYvRWyy8mQcDLT3SMvi92J4ft5ZyfEHlis4q
 vsbFP4xxwte9Fx2GURPBdRiUy2OEL0fxuzUtBxw9++x9UK0DBtzZFNYdp09gUGQH28hW
 f/TnDbUUzx3hVQR4RyCOfj6+m6dzt35k82ZffF/RckClSFrozPkX6D9ftTHviO+pQQNh
 vzFQ==
X-Gm-Message-State: AOJu0Yz0fuji3lye9IafbhbnZDgELDcYMxDVvy7V5fO8NDZfuPnFLngk
 x05PJMYfWM6bDyi1bp60eJdtu8go7GU7QE+OHyB1n3itcJ6FsV3A02BZMgPdeyD9ZRHne2s6LnX
 D2gsgq1ltTel2bYB64TievNw9CrhdLkELbr50PQis
X-Gm-Gg: AfdE7cm8F478IQj514K1o0976m6NObG4hxxbdiJVTLYeJzZtfOywtOLmUmTTOvdyywd
 8TQ7/onl/1Cwc+guM/CTHc5RX4BmeR21lLfRahJsVv8ACcdQHAzq9nFyYrRpzk0uFz1RT6e9u3f
 YT8/ZJ/2acv1CefqW7prGczg7kmLVChISISTyd9I9Vk8OnnCKH0D/sk5+4MLWifZ/eN9xJRbrfX
 3+5CjbvgdYKm204GmklET7JoHqkpu5C9A54kzoNxZrgoQvYhyjBwtRknwP//95bNEQR/rs=
X-Received: by 2002:a05:6402:268d:b0:698:9251:2f72 with SMTP id
 4fb4d7f45d1cf-69ab44b563bmr3754273a12.35.1783622190733; Thu, 09 Jul 2026
 11:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-1-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-1-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:36:16 -0600
X-Gm-Features: AUfX_mxoru4821OlXNtbzEPqmMwWj2T_DCx-7Rf_JXzru7_740WGcSgapIxMp7g
Message-ID: <CAFLszThkhOmY_b+FQUS661_bK4k0UvfBAM8bMAKY6nQKMe6TwQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] cmd: aes: fix DM operation handling
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

On 2026-07-03T01:49:45, James Hilliard <james.hilliard1@gmail.com> wrote:
> cmd: aes: fix DM operation handling
>
> The DM AES command path takes operation-specific arguments after the
> common arguments. argv[1] holds the mode, 'ecb' or 'cbc', while argv[2]
> holds the requested operation, 'enc' or 'dec'.
>
> The DM path checked argv[1] for the operation, so the ecb and cbc
> commands always returned CMD_RET_USAGE before running. Parse argv[2]
> instead.
>
> Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> cmd/aes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
