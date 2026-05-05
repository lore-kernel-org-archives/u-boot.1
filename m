Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1489DFF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B928848B7;
	Tue,  5 May 2026 16:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hDSJ6j8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89512848B7; Tue,  5 May 2026 16:14:33 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE1984954
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488d2079582so56596085e9.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990470; x=1778595270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZpKNg+hDdxRK/HKYZJ0dsJdkYfrL2j1P+QKCHsU5x8=;
 b=hDSJ6j8oL9W+7qzZj0mDE267BGFE1iDp9+da6UaXHNEWlQNfghWghrgUeT7EFiyUNM
 wY1q9HtQf2ABuvJgtpz9s5VQ6Zq4MoOZorDA7zp/M8bL+E2Tep1b3b4IgTWgQj7gAXnX
 y3pR8gnqtRsfkgm/yiUcwxisF6LwE0ADZ9/SmI+IWIfhLJuiNci7XSVu59oUF8SJYySl
 +zpdf3xTYyFcWTF2D8ApDDgWBOBUcXiLSv1HXc8ggRjC3JaDleFb3x8x6FEeYCbnF+k/
 UZgwCDEUdwZFy8aPOx/jHo5OxoOgumimURC6Gm1xe2+RSZUKvE5U1JgOElnlxefiJmI6
 ClDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990470; x=1778595270;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vZpKNg+hDdxRK/HKYZJ0dsJdkYfrL2j1P+QKCHsU5x8=;
 b=JB1x2Aj80GjgNutUZEwUt0qlQmYYhjLrGtm3GnMyehK4iRSPUBdNbg7u56jIZaarGW
 ZFrYpc6nzkDrTmIK6Hj1nzW0d+94mb9JzfhhxczVn+wpAW4QxanH1JjKt9VMW+eCTPgT
 g5D2g2RXECAKNLk+ZoucpNq0u1/Qt8o+KGxn7aBDsezh2YvLAij4aQnVMTltoRlX5uSs
 2IiQ/NNnsDTeZLhNuzWDfYOtsySgowzwM8Z6sz+niPJvwNkpun7iO5+SdTnqc3RRlzig
 cqEWVLhWY1pYL0eaEJsFRMJYgj3gi3MRYXUwIR5CXZTSC68huZYWgQjJdxlUIgC6Hjzd
 5rYQ==
X-Gm-Message-State: AOJu0YxDL3sQ5d9D43TVkNM0wkjZHshqx2z6jbaT9xR0v+7jEUVaIVfp
 vJhPP3YWBNjkP2H13wb0kg+t8pUWycJMbJhXAUKGPbHkPk8TYBeyir35URN5gzwPJFlZ0Bh4red
 8GgHhylI=
X-Gm-Gg: AeBDieuILDSZmRKfAiZNCc8KbXyNOlZZ2Ro5CRtL3WRhzGXi6UnV3iRIx5fMK4wmJx9
 yrikljl4hFFDeoGuUmafQ6Y1b8A1kHG11WbnJeBzDJDQiXYF5eu8PmPlj2fy0zM9hp4jaPNfbSc
 onzttGAHXauuM83KHzpffh5NC8ThJTTuFo3Walw8ta9eTcjV2ljckhBcVub4IkYAQS0rYgUqA2Q
 86R3nI4RHXohtdLSezSajzPjnF+eGkTzyMAP8Y/2M1yJc8TpsXI0rA+5EA96m5vfD7M4Hlg5YSi
 NoP9zSxHNM0+sH7BM0rVlRfAfJOFGQ1KK1cLqKoDHxS17mipzMwTRV3zPdWlo29hT+UpGNg2jgy
 LfUKlAQTWVh2g/zLGPcNOSAGJx5Y8tFMpK+23xS7FolL30ujUhHeKuHTTsIKZYeLHprnNTzZFvO
 leKemkd+/gYlJUT7YuWSh2w72Ai0QdeZmnE3JxGjFshwCXQ4lYUxyOtlRZ0udrBUsVsZcBZtFNK
 ve7UQY=
X-Received: by 2002:a05:600c:8590:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-48a9865f842mr188790215e9.14.1777990470367; 
 Tue, 05 May 2026 07:14:30 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm581408135e9.0.2026.05.05.07.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:14:29 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
References: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
Subject: Re: [PATCH v3 0/2] cmd: ufetch: print Net feature when NET_LWIP=y,
 prettyfy if NET=n
Message-Id: <177799046931.839461.1297387191363695345.b4-ty@b4>
Date: Tue, 05 May 2026 16:14:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Tue, 05 May 2026 11:14:30 +0200, Quentin Schulz wrote:
> Make sure the Net feature is printed when NET_LWIP is enabled, not only
> when NET_LEGACY is.
> 
> Only print comma and following whitespace as separator if there was a
> feature printed before feature to be printed.
> 
> 
> [...]

Applied, thanks!

[1/2] cmd: ufetch: show net feature when NET_LWIP is selected
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b586802913b4
[2/2] cmd: ufetch: only show comma separator if there was a previous feature
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b61bf7f71dfa

Best regards,
-- 
// Casey (she/they)


