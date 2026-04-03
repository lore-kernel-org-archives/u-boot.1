Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671AEE85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF6D84197;
	Fri,  3 Apr 2026 21:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QNB2c6xN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514648419A; Fri,  3 Apr 2026 21:47:22 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2EFE8415C
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbb6c072f1so1160743a34.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245638; x=1775850438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ID0ViYMIJZrdGoMnx7mL9O1xO8eHi5sqdQBb4sbdifA=;
 b=QNB2c6xN17dhJkC1rIBcE4202zhuAoo0e4NwbbHag7tbig3YW/BTqQ4tstFhas/CzV
 WtblhkDQF4SBcfs0Eraaop8fRvLNzRQz0wJzaXCvjiwVienV8lPbX82I55336EStQarE
 fPU5Sa4MFXyWJuS4M1Q5RUeW+3vuyhy4xNYAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245638; x=1775850438;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ID0ViYMIJZrdGoMnx7mL9O1xO8eHi5sqdQBb4sbdifA=;
 b=YQ1QUIp+C/gOO9b1dHojCb+ua9koOHBMqrpzx+FpwJbJtnzOCxhvB9Us+T+2PatazL
 t41cdXYKqKdbfXoLDz4hdIR4WI94m6Mj6Tyn1pq5wdep+8qeTt0GXms97LIHAfUOG52n
 Sps2TpYkU30pMLh8/n/IaQBYumHAyK9wPJMT0UFDE8vhbDqZEAsAI5jseXsoMppuw2eu
 ywrRb7BU1mYYtsQjZ9eOc6Y/FtZWo3TDCDzcRiWvmWT1rA//jF6aEJTMe50g4Q3+bjBN
 ZfJ1tnwshj2TP+o0HiWQAm6i6xvonbngXZZPt2OcABSnr0GjGhYlwxXnjXm7dDwiG31r
 k73g==
X-Gm-Message-State: AOJu0YxPcjYHPLtqY7jnP7dKdLnx1LKStXolhA/lYqfsa+ir5bQxS+Sk
 sPPgAAfoaoyv4YK1IfDOwj4Jy23Cvl3c0PmsNzGkaXl3iXt9LsBhlES11CC8JiNXXVU=
X-Gm-Gg: ATEYQzwh/L45uwMv4c6vMjyJqcfEPyjX4j+YnVqFav0ugSVGOfbb3CGYogHz3eNaYF5
 gzGgSwS/llSeL1iqxonsLtm+lo/y901f+WIbaTzocWsmUA5wHNcw1912jxUW6gD28HbARZhqb2E
 8w9EsJPhZ4CmnkGJa6vhcGvybYG4UaDKv2PZbUadBY/1j6Bu33/DZ3FvmmLEYvNeacdbu/iW4q5
 NCQXmJfwWvHNSqSPHcc4mmYAUKMmC2DjGdq60eEBSJCM92JI9hFIZYb1fvGfzO2S7eTVjZyvQM6
 PLsGJPI7BRfjY8RrN+K6UrXaY2aLXc6bJ9xQtEXfISFN7DeGYR3DvpM25JeiSJV48DnAIzmreKd
 8yI0NkPu8EC4954BGuIQ4/FH5KbZHl0VIoETDRLxgjfUInpQVOT/eQ6K/ZEHFxviR1yBaayUqpk
 LXYGW9kneK3oXddMxi1nNJzKDKSUKMJp9ZGj3FdfEww7gqi2AlbEqYPkHtUn+FylsSNnkDClVrg
 xHwC1DJt/ZvXnVO9fFOmK0VFEVu1+OyRfPVTitt5foR61g=
X-Received: by 2002:a05:6830:628a:b0:7d4:4af4:b7d4 with SMTP id
 46e09a7af769-7dbb6f248d8mr2942024a34.1.1775245638505; 
 Fri, 03 Apr 2026 12:47:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205339.3788814-1-trini@konsulko.com>
References: <20260320205339.3788814-1-trini@konsulko.com>
Subject: Re: [PATCH] env: Make use of IF_ENABLED_INT in spi flash support
Message-Id: <177524563800.2281750.10529481638300614337.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:18 -0600
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

On Fri, 20 Mar 2026 14:53:39 -0600, Tom Rini wrote:

> In order to build the spi flash environment driver, but with
> CONFIG_ENV_REDUNDANT disabled we must make use of IF_ENABLED_INT to
> check for a value in CONFIG_ENV_OFFSET_REDUND otherwise we will fail to
> build.
> 
> 

Applied to u-boot/next, thanks!

[1/1] env: Make use of IF_ENABLED_INT in spi flash support
      commit: c1e17ac28466f9ba68cb65daa9d7f8b4b3ae0a25
-- 
Tom


