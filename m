Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F95F483CC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596178420C;
	Mon, 23 Mar 2026 17:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R+jCw9/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154ED8421C; Mon, 23 Mar 2026 17:49:21 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FF78419E
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so891975fac.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774284557; x=1774889357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvfO7m2j7kWhi81cakeJ/GkXQzzQeQVeQdAYptjK/gU=;
 b=R+jCw9/jw1IP1UstKNQJRh4uTAGen/R8K0PZxz1NGOkVAhPz7LzwjNRBI1+8Sfjz8A
 iPqdWFB9579HOy6a2aSXp50Hy5ux3uTz/XzG6pxjiIH6S2CmXRG6k6RgQH30grUUMpig
 /97mCyp21CXezrgXBIkX5iqOd3CLtrLU376tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284557; x=1774889357;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xvfO7m2j7kWhi81cakeJ/GkXQzzQeQVeQdAYptjK/gU=;
 b=s+Ic/ffv0CYsF7t2IyGmnPtzm3GncYM8ggXcE43/63OtLKX2y6vKds9LTxgUefrB5p
 BFzNOElQcwwCL1R8oH8wf/z9x53mIyRTI14vGmKc2Ak0L78Dd31GWEiyOBOIkvu34/wD
 2sfgAPiD557zjFjPnYEnZUtBg6CgYPs7M0zGy1DsyqK49TRBeAqDKBNnW36UkIVt154S
 9eyks0aaf4sEEQHC5eUVMwJgwJ2WkWDR8sPj32yMiLJmvZa03WBx9zcV2lhQbSytFnAk
 GcoGf5j8J74zM6stzp3WaXjsReAO67uNR6TB+7EnY94zxaEPyeMhQMCICiWiWPYaf5YL
 nSeA==
X-Gm-Message-State: AOJu0YywWNhko5qKwHfnVcCnfqxzkaVmy1T8TkLr+oeyzNsZeY16Xx0I
 MaFOr1GXNAj5dIIqOWZn3RqYBpXK7mjWEuofTuLQmwIDE7Y3bcAXS8S3Sqv5xNn8YN0=
X-Gm-Gg: ATEYQzzsCjlbG5Vqans3lykbchOrnnJpOSxQw3SiYzKKTftdsXCy6g12iu52k2w80uH
 ynJN8yK8slI1PdYM6XXJ6Kp9wudlxRgfN3gAqPUK0YPpyjpfaaz2TP6pZXLB8/rPaR5f03TUKJg
 dQn46p3S0f9ZZRoio9THMcFRETgS8RVr4+hKJy3zzLmTNKzr+f+thDy9WBw1WL7fKYjjbyQg/Ne
 jC68loGCqiOB60wGKRtaQVKGAMhE85+lhuF2Ybdlsei6jF646W1ykCv7y0RV5uADkuBwnca4uZN
 ON70F2kpMTARPw25UY5Jv638inpQav3jrUkHZj1KvFOV5dqSrFpd5S4aGBn5/b8wh1gdpQBRrmv
 7fxBI3wyliNYH7j5QrO9RZXA/SIjcxrCIoc+v0GgKli9fazm7XEjhzP1llCW2x02bErG5Gwo5BE
 4qZGaMH7gUvXYbVWnP25WeWZNZdu9jzMjPFbjGQvuxlIpNGwOuH508wjyYnK/nqHSWAYzqUwI4q
 dmTAWrQl/1oaLE7DL1YKe6cVrDoK/icWZdaJrdC6MtEmqA=
X-Received: by 2002:a05:6870:8996:b0:417:31f3:5def with SMTP id
 586e51a60fabf-41c112b5cbamr7880008fac.32.1774284557203; 
 Mon, 23 Mar 2026 09:49:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d73a19sm10016158fac.11.2026.03.23.09.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:49:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <acDbGwsosXBP8C3p@nxa18884-linux.ap.freescale.net>
References: <acDbGwsosXBP8C3p@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2026-03-23
Message-Id: <177428455652.2303875.11310839459185135478.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 10:49:16 -0600
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

On Mon, 23 Mar 2026 14:18:03 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-next-2026-03-23 for next
> 
> --------------------------------
> Kconfig update for SCMI_FIRMWARE
> Add SCMI pinctrl driver
> --------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/29614
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


