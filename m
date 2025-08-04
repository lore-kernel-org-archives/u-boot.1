Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F86C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 19:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23B283AEE;
	Mon,  4 Aug 2025 21:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Of4A96oU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB81983B24; Mon,  4 Aug 2025 21:06:51 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4893C83AAD
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 21:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8817b8d2d0eso32153039f.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 12:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754334408; x=1754939208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZVswYLVbSL8iwHqu4BQfEREgeYqRxH9U5aKOpld4rg=;
 b=Of4A96oULbPdF/mic9el5wSo2k1qCqz9E3lE1Y3ZMcMWiW0TMriEPLxqLWpWeAcf5w
 3yDnbQbCx45mZqMgDJTHob4lHqgu4AgMlQTGOfvbOpFvJ59qkGOuScngi4HQh0pq2oYz
 OGw4yZCr8C48R0k8XT28J4KLbv4UgSjaJFKWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754334408; x=1754939208;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZVswYLVbSL8iwHqu4BQfEREgeYqRxH9U5aKOpld4rg=;
 b=u2wxULz1NOIMY8o0WQ3srCtKsSRr20SZ9rVmk50Skh1nDGHhkHi6EqhE8sGa8EWu8W
 dGuHIZR9uCAwdwbk8MYQsKsK2Vf1IySu+OjMW/vc38gOOkdHF+qMpprBcVjIJ+WdPcKs
 uoc2KdJOkwbm0+GhJuK8OKt6Jzc8NR9QfpzqNLB7ZboIejPDrfYVgu+WlLMAahrOfsqy
 tjsYjULJ0zyMi2Rt1/bqCAjWsJV4cYKU0JENHOge60+chmSO97qWgFkNw1rTuHIhtsrE
 y50QrTCiINAf5B7T20Mlt6sa6YhzTaLrfABUR+vPBdjtvBcXeiqvgFQgSCy72YbLIl6E
 k3dg==
X-Gm-Message-State: AOJu0YyYOhMRlLoN/xqpaDOqEvEb4b5RPjZ9iMtV0BlZU8GUmThmEvLU
 Uhn0hiHk1CJ94pchrgFZvQL20YvNQI+Fo70OGPz8LxPXDmSgP+KkXXVDyTNfHUf7KTVAUMx2kJq
 lg0KaiCc=
X-Gm-Gg: ASbGncvRBW/aO8rdNjIX3o5Ka58OUnNUAGpJfVdGM55+mDWThNuXaDYTGV3dpVnR4UF
 gUc+6j0QQH2L+8xIidL3LPgXM5OOUrLcOiCa34ObYNMfb+lsaDxuaVsisGRdS8/MlSmFrw91/k6
 +ygQjv5v0FJgerNFVrJ0423aBbYXaY6LAnLKtf/zwQdD6Y8J6mJRoT5vw09cTCnAXND13tJKQfd
 B7pcX5ILyAmwyiexzxJPXoQHKcsXXhJNEa3IsQdajEsyFt9u5Sjw9eTAhFyCbwkuSSA7g8O9N5Y
 tcYuhoszg/XJOF0bPHa7a8deeetLTA+FGuvO6Hwu0TaWqIedr7NOtB4/NhYVj842VzbAbJLcGxH
 9p1wyWWODboACtDhWwkK0WSo2pPHyWEqdkPOnLHB5o+aJYVAprxnq9PMtmRe1YJo1AQ==
X-Google-Smtp-Source: AGHT+IEd8M2j2eZr6Zu7H9ZyVInkKHls/SX91Jbn/Ad5FUisPzNdgL+VuHuiPX/UWhPkM+P8lxIOYw==
X-Received: by 2002:a5d:83d5:0:b0:87c:78b2:6ddb with SMTP id
 ca18e2360f4ac-881683b28aamr1692071739f.9.1754334407484; 
 Mon, 04 Aug 2025 12:06:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8814defb614sm344156639f.10.2025.08.04.12.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 12:06:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250804062417.7932-1-clamor95@gmail.com>
References: <20250804062417.7932-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <175433440587.248105.12176105840221835648.b4-ty@konsulko.com>
Date: Mon, 04 Aug 2025 13:06:45 -0600
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

On Mon, 04 Aug 2025 09:24:17 +0300, Svyatoslav Ryhel wrote:

> The following changes since commit f5e968a28e7cdc2c4365f5a382e02f074ee03fac:
> 
>   Merge tag 'u-boot-stm32-20250731' of https://source.denx.de/u-boot/custodians/u-boot-stm (2025-07-31 10:04:32 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


