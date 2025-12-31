Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F0EE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3CD8412C;
	Wed, 31 Dec 2025 20:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N+L87DoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF6E83D1A; Wed, 31 Dec 2025 20:00:25 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5259383DA9
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3e83c40e9dfso7244179fac.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767207622; x=1767812422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3fgps7texUuxzRWPRAgAPDbxneWL1+UXouAdNcQVTY=;
 b=N+L87DoCayYc4MvL0ozdJC78wk8rVE2eFO+n9wDN+zgs2AB+jdMwPDcFtWqkRJOYkN
 bTn0Y3j7hrn39ezU2awlyMkEIkOu+ka+7bLD3H/0/qeiAn60CfxcW9S6XeziZdLkpjFS
 guk77HwBVDF4WAdcdl0fZ2Ox7rfHabP98RFPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207622; x=1767812422;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A3fgps7texUuxzRWPRAgAPDbxneWL1+UXouAdNcQVTY=;
 b=alADUJEVw44PV6LfktxFticfhqi/oRgQ3pk/HZia7K/hT03DV6VMzp4Jmx8bnLvPYJ
 xBkp+VV6i9PLgaqVHu1T2TfApTbZdm+qHmJDc3gy5ekg36Szc6lA8yxzhl5QJ7W0bZ0e
 cTg46TmF5EsEAH2b++CZut8Al9FIXhopuDHskFfhtW1Mt4j/L7wfDb0GBYmkmd8xM2y+
 XDH6dwW/vJp1XqPseDGn1l8tXHVE09nAxxCXfwM4gegkGJrbmP09fWNZ+Wa7LkCLWG2u
 qCPH4YNjB6RqBo2T90Du9byWVjhjJ0KBMW6bSB+HwrU1Ef1CKL0TX9lOnkKokJ5PD+6M
 0CgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaR6z5VLxSWsTWO8dZ6686Kktq2TOw7N3nHzIGCStlwaN/7ioFh5zZ9CtTRSJ2Fy76XzbCwtM=@lists.denx.de
X-Gm-Message-State: AOJu0YyO4SVnrcjUdfBvRjdn4H9SAgeNJM32iIHqL0MKHa+g5IkJ1OXL
 hEur4RGPX9fDl39+oLAzqgHCr0OI589FuB/2A+1Le13/9kqh4VtWrx4XZr6hipOjwO4=
X-Gm-Gg: AY/fxX4825ozBQpTKDCkoeWeBgEPlwtewXEAsQ+nJhaIjUSwGjrNEzLAbJFWgLL5smI
 rCuUu6PjX/xNyNMnZLgL2/HXPqdnFFazu4xChXwmnBTauW1WJArDBoPdUHQlGuvNUiMGA31E4EV
 9QPEAXydd+HYtSS6uyYC8zH7CeJpTclv1ilZWZfk9DmmJ+Mrpml/+yosH0HiBNDpuKpFQMtNrnT
 8o2asVn8CZxmql0woj3p4ARIemJ8/qmp5SKZhmsdx8pfW9BNxpwZBxB6J/Xcgma4BpClAfrJt+I
 J9KzXdUo3xG4XjjtzUw75fleFxrrvbBZPxu0s2y0yEdJC11lAqaNn8XRHzMV6o/I0fsGEkWG6fe
 NXgEe2/Tf3iG8IXgSY3uyk7dUkM7Z1ikI+Y6uJXkaIj6rbJHTuigTBqz+us9KTPgZasojiZDLX1
 BSCf9GTCtpTRrTgC/jq1DECi0vcVrK8Lp19DZLq5EtKkUgbF2umg49zFhO9GiXASAI3HkWpROB3
 E+B+gnef5fn5Yj7Gf9l1qIWAiwTcXfsN8TeOw==
X-Google-Smtp-Source: AGHT+IGK7dYv8hbuOh4EGGqou7mRzMscmMXnXWvJ8aBBy5IWHUuu1lfRmzWKqTCSDHgZeHk/vBcJiQ==
X-Received: by 2002:a05:6820:2290:b0:659:9a49:8f6c with SMTP id
 006d021491bc7-65d0ea9a1f2mr17343202eaf.49.1767207621729; 
 Wed, 31 Dec 2025 11:00:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69b9e9sm22099392eaf.12.2025.12.31.11.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:00:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, Julien Masson <jmasson@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20251210-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-71317e50d414@baylibre.com>
References: <20251210-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-71317e50d414@baylibre.com>
Subject: Re: [PATCH RESEND] arm: dts: mediatek: switch mt8365 to
 OF_UPSTREAM
Message-Id: <176720762053.3066473.10729163425674291127.b4-ty@konsulko.com>
Date: Wed, 31 Dec 2025 13:00:20 -0600
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

On Wed, 10 Dec 2025 17:40:14 -0600, David Lechner wrote:

> Change mt8365_evk_defconfig to use CONFIG_OF_UPSTREAM=y and delete the
> U-Boot copy of the devicetree source files for mt8365.
> 
> The upstream devicetree is identical to the U-Boot one being removed
> (other than having more nodes for devices not used by U-Boot and
> upstream fixed a compatible string in &scpsys, also not affecting
> U-Boot).
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
      commit: fd104bea0c9596d34d5ff9fb1071936b42c333e0
-- 
Tom


