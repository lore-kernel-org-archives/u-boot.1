Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5996CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1955D8407D;
	Thu, 11 Jun 2026 15:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sCDQ+SoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B9283FF5; Thu, 11 Jun 2026 15:48:29 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969F98407D
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-486539875c1so3451496b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781185706; x=1781790506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUNlu0ZHMWc8XLJHIYA/7lyZelShbA4s4lvK2l99wNA=;
 b=sCDQ+SoHHTUEawUhuHwQuwKujFMq5gFyTzu/fPLNC56u0YO6JgWG76y8fwazl/iNnZ
 WM5dDVHaDDmPbIiTieLjrTTJc0KM7QGW4ZgNhh8IhTIc33Pz9/OzllQtZ34K7UKGp3lR
 ELsz9SYA3MpprgaOyLKYmzqcP+rgEJDkj62ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185706; x=1781790506;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUNlu0ZHMWc8XLJHIYA/7lyZelShbA4s4lvK2l99wNA=;
 b=S86uahUVpMxD//dmDVACIj6nMY/e5+Fe+5EHSofLWvimCLqYCzKV3nr9slvMqBTOWQ
 snyfVvKWcUjNYixiXTBSAZWhOOs/6JjGA1bSfbvXU69JG4ILmioeCswf6uvp9T9zc3VA
 lsOTIUKpiEOTnrels7e/uyhzvzd5BalC/ZenV9vuGvs5NPSKoKq/vaoCs1J25w6IbQZ6
 +LdlljeIKRDIe1TksU6sEi5QRVStn2slqBZ7YczywXCEwF36jjXhXivSfnd5lXvXqFn7
 f/T22wyh/MRwiQp47DkfkWXv6ZOgvOZTuV3vVe1TajQrPrzn9LSwkJtn1W9Zsvw8rprO
 3GuQ==
X-Gm-Message-State: AOJu0Yz9W8A+1CTC2s+K39CYwyD7mArXaeOcjB+Gq7eqJxXmdi02svey
 xUXdUjmsHUp58frDt4068YwHzL747aBUIbxp+wpRsZW73yzEysXq49tXHtOoTG8XArE=
X-Gm-Gg: Acq92OFi9VdL3/H/hEQOLOOAuEjhTbinbcL+T5pbhHaUfgMdLqSfNX3b1R9J+Nhq4I4
 otHClnKFsEXYVsQ2QArvL7yeCayGf44tAsHKnOPLA/sT1dNP0NIKTfG1aAOsve3xIqR06CgXFhA
 IpS2q0fZw3apeEJhPiarDPCT54yMlzfVnQe8fRDs7WX+3iNNyPo5xqvB9VH5YkFXT5LMsbmTnkR
 NDiOdLi9eXgcwRtUHzIOMMw6QzYWC7uE0jipjoosyi8WNoijd9fHVKbS2nJBuKROYTXQod4wkIf
 KyBs1i4bh1f7AZl6eM835+nYaQdy99HYpn/CGrd9NCMxP09zeNBFZCc432wWkUfiHhSdCuuOaSe
 mVksOvIlR9ONqJJDYUFEC7ZenuFE3uWQ/094bppDD3ICGVbz+L5rdyTRmkp+TeUax3tqnQ3395/
 7/e6PjecJLyvJXZlpMfzuiGkb7BAA3zEuIHifOrIB3turAV7kd+zkFt5oJNHVSVNro1CQ1HvWo/
 sFMv7cGXV2o+iR5CI7qdwZIGQgI/4+c3D/c5BZtHx7SUvmCoZNCnpaQKQ==
X-Received: by 2002:a05:6808:3986:b0:47c:be93:9214 with SMTP id
 5614622812f47-4871a0f6b6bmr1963202b6e.20.1781185706266; 
 Thu, 11 Jun 2026 06:48:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774988094sm1368249a34.1.2026.06.11.06.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:48:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Siddarth Gore <gores@marvell.com>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>, 
 Richard Weinberger <richard@nod.at>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Adriana Nicolae <adriana@arista.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Javen Xu <javen_xu@realsil.com.cn>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Francois Berder <fberder@outlook.fr>
In-Reply-To: <20260526014144.3519-2-aristo.chen@canonical.com>
References: <20260526014144.3519-1-aristo.chen@canonical.com>
 <20260526014144.3519-2-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 1/1] treewide: prefer __func__ over __FUNCTION__ and
 __PRETTY_FUNCTION__
Message-Id: <178118570504.472730.9825941804691545511.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 07:48:25 -0600
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

On Tue, 26 May 2026 01:41:40 +0000, Aristo Chen wrote:

> __FUNCTION__ and __PRETTY_FUNCTION__ are gcc extensions that predate
> the C99 __func__ identifier. scripts/checkpatch.pl emits a warning
> for any new use of __FUNCTION__ and recommends __func__ instead. In
> C (unlike C++) __PRETTY_FUNCTION__ is identical to __func__ because
> C function names do not carry signature information, so the
> distinction has no behavioural effect here. The majority of the tree
> already uses __func__, but a handful of older files in arch/, board/,
> boot/, drivers/, examples/ and include/ still carry the gcc spellings
> (55 occurrences of __FUNCTION__ across 19 files plus one
> __PRETTY_FUNCTION__ in drivers/usb/musb-new/omap2430.c). Convert
> them all to the C99 form so the tree is consistent and new patches
> in these areas do not have to follow an outdated local style.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] treewide: prefer __func__ over __FUNCTION__ and __PRETTY_FUNCTION__
      commit: 6c636eabbde7f7915fe37c84395b23c61c66ce64
-- 
Tom


