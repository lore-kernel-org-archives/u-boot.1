Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA6AD6AAF4
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 18:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E9E840AA;
	Thu,  2 Apr 2026 20:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tB/ESfUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A60983CF5; Thu,  2 Apr 2026 20:46:05 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3FF8408D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 20:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-467161c4a1cso420914b6e.3
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775155561; x=1775760361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyyJXvd+h8KPsOp8B38LjX2j25+nRs6GL+9EfF9VVio=;
 b=tB/ESfUgPyXsI+HhBn/yBqlK9BSx7wZf7ZQ95/rPh7JtVmFP2DzwrbMnw7xFx92cZi
 QN9OtgbEAiiVsXAjZKRN1nZsBOPi53jyYNEzINOyKrxF087IU3Ih8OPSOKp0ZehZdyVo
 UrbQAEyXYxXdFbz3Y/Dez4PxsBMJOxaC+z7RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775155561; x=1775760361;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YyyJXvd+h8KPsOp8B38LjX2j25+nRs6GL+9EfF9VVio=;
 b=iOoMxlxKD8PlH5CbhHZkHrDuFxGMpelplpZx1a5kLvDwG86ctyYy9ZeBpPYRJc2LlR
 P/zCmj3MbiCp/hx0t6E/E1Q3HK/hBcQHdBBvZKnQ3QqaMNO3ihy6/kzO+6qOS8WavFYS
 +gB9qFfrMexHAykgUpzcR8s+oLMumZswlB43VabixQCQaC+77BHjl9ijNhhbX3KfqvOp
 y6e7i8cjDB+9tje5Hq56ik6bHNipvFXQ0nBPJITpGCVfHZvzQa0+FxWzwz5XWW5OryFI
 mn+hyASoq1AWTLvMmZDsKklIDptqgXurT6u5FB+ALI8SLzKHHJBZaRlZPApJHz5EMvYX
 ml5g==
X-Gm-Message-State: AOJu0YxTFzchAFo8B3e6RPvuUEe7XzSs0h8hSoR1c/vnCSIdHpv3ATIT
 zRoaPn4BbWcPPr8ZBT4jneR2BnV3KfA8lVVIvXAhTfLA9Cdl7b/XwhJ1gZMS37VpvaA=
X-Gm-Gg: ATEYQzzY2Y41QAxWP7qZOjRqkjZrCoQLkh38+SFO5VQTogXkTOPEL0+bGpSHptxZvgq
 E2ky8ugtLAYE1kEiQ1ktr5a9RjfF75QI26z8kA7Lc1VYA9BgLG1tzsrOyuavw0AUutZuuZOVFPr
 S8163xf9zMA9WvaMJyS0gFWqpwgMiJg9/0dgQ3lYcN9IA9bS5mYagN07uRDAvgiAapzPiJCfKbL
 zfVspPPJPY4j8jLQyj3Ce/C0fGfoxDtGacyK6H7fNx9agYU3tlXQVuZ/X7PMzwZyzXbCtrKK/hd
 f3EpSpTSvwDeCfS3KlO/PNKc5pVGdJ6nzPqi70HTVQfWEok5HPG5dyUUj/nJbz5pyOnP2M30ejd
 HrXB/BzR6+Y/K3mBNhRWyCNIRr5tAPFw1BBc0ZJhyYyKMtxdKBs+elyJtXSOzI9t9p9eqKxYWJc
 b5TIpZg3wzj3kB5B4G+tvW4cYNY3ht8wj5IILZeYdTPe+McaygdXfgSKXdeh0j7WdHcRe0iyEn3
 lKgrB6z+r43U/7FNDXYugVvUulT8gLoFi4EOS1lsv3qY7Xn5pc40TwrOw==
X-Received: by 2002:a05:6808:f8e:b0:463:8a49:ca7a with SMTP id
 5614622812f47-46ef871d0demr268718b6e.52.1775155561037; 
 Thu, 02 Apr 2026 11:46:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d9044725dsm2085830b6e.8.2026.04.02.11.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 11:46:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, fra.schnyder@gmail.com, hs@nabladev.com, 
 krzysztof.kozlowski@oss.qualcomm.com, Markus.Niebel@ew.tq-group.com, 
 Max.Merchel@ew.tq-group.com, peng.fan@oss.nxp.com, 
 tomas.alvarez-vanoli@hitachienergy.com
In-Reply-To: <20260402163227.1538209-1-festevam@gmail.com>
References: <20260402163227.1538209-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260402
Message-Id: <177515555985.1935668.4677805637251142330.b4-ty@konsulko.com>
Date: Thu, 02 Apr 2026 12:45:59 -0600
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

On Thu, 2 Apr 2026 13:32:27 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 98cf83d81617f489d7ff7bf78d33e693e2799254:
> 
>   Merge tag 'net-20260331' of https://source.denx.de/u-boot/custodians/u-boot-net into next (2026-03-31 13:06:00 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


