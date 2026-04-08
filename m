Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5FC10F9943
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0929E84189;
	Wed,  8 Apr 2026 16:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a+aop081";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F51284132; Wed,  8 Apr 2026 16:51:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CDC8840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d1872504cbso1016100a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775659879; x=1776264679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqHULDeOjZYbudiZtew2u9jA2RjxHMry4gXWdD2a6IM=;
 b=a+aop0814pYZZsofDnKwPMabD8l/GlnyftSsOJ016hNkgj6iHcHxXea7T1tKE5Ur2U
 eK4JthUDSo+wm0AOYrR9ptGrYoIZFWrn9khQB1jZkYcaj7/9bVzZg7Zh1gJtbgF92UP+
 eLVXizDuH8sFdFVNy6KQ5xNAsNX+tH3NDZLVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775659879; x=1776264679;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KqHULDeOjZYbudiZtew2u9jA2RjxHMry4gXWdD2a6IM=;
 b=Cmln/D7+OKvfXeuPMlHBd1Zow5c6JrhQI153EJ4MFemCPp0DfN360NgS9N2/NE3Fiq
 rzF8QL3lMTwalQBoX0lGY3MlEO1O/sqC1lyxn1ZMIchohiEd5N15lzyr8Zkh/DoRPIrU
 cqWq8K1SI0rk4Oetp8+mtdJONPO7+QdCaPCnOvRM2D1/o+OpGldaMZYruVIXmRhSgDWa
 +/lphVLcj5OFtT/OfH/OrkaxG+HFoombrEMpejm7P2XLD/czGvWuSUtN+0rgiOV2Ep9U
 UzxH5Z5xVptjaafKgfutlaTpDyieU00RsjG+487DodAlkV2iKA0YvZPct1YI/e56Enmg
 aY2A==
X-Gm-Message-State: AOJu0Yybozvr2zjqnnYbfJHktotvl55N6BYIyYC+uvRxAtbkMw/LTyBa
 c4czMtiNlw3tXM+hACxuQa+2au7p1yXFMCIgRjbClMrGpTyxHKU6LbtHjWvNvEffCO4=
X-Gm-Gg: AeBDiesofkGteOrdXHj6YpTiOGR7C1KDx7NV8YPnjnmr5HUiS5enbAp3F3eMCCf9LNa
 D4XSs8Cy6zQO91z2rDFL9K/EGyNGpqEWIgd2rc7QoKTBrg7QSnEWctsmO7h+OB87x49AOg4LUso
 ug6t+hFy+rtykCq1y/cqbnUFnh4lkOoswKl5He3FBf6NqJ7Ivt/wvRFViSaUBxBGcIa++ZuiJZV
 VTLSZxoQDTHjyXEmr0bVzWCMmrgyVJiOS34T0ZtpVPcWyFtR1mbKv3CxUZ3fOkNNMsnoiCSdrHi
 sne14q9rEfhJuuXZleZ4KY5x7svn4to0wBbKCwwNOF9eJfI1cYThYOnmo49SVifN4oXESmJBrkN
 gheW2uur9bjbucfhE/cGjXWLgKKPIxwHOMaNDNHdvScsLlZobqlD/E7MqON9ppnlt9KvHgeC6mp
 aHgRnuv0Y86uSRpGpJr6xysH6ou9YosTV3P/XZKZ3kCNzRoohbV7/OWrAn8EzvaE8Nvl9AfEjwI
 wao2X5OardUM7Yl+icKwUXFISfTQD9+bbn6WLPFNBzHgSg=
X-Received: by 2002:a05:6830:700a:b0:7db:b6dc:c5d0 with SMTP id
 46e09a7af769-7dbb775653dmr12258742a34.0.1775659878944; 
 Wed, 08 Apr 2026 07:51:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc081753f6sm1514644a34.6.2026.04.08.07.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:51:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
In-Reply-To: <20260325190033.3428670-1-trini@konsulko.com>
References: <20260325190033.3428670-1-trini@konsulko.com>
Subject: Re: [PATCH] hikey960: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-Id: <177565987821.779397.6559458480458553859.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 08:51:18 -0600
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

On Wed, 25 Mar 2026 13:00:33 -0600, Tom Rini wrote:

> This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
> do-nothing board_early_init_f function. Change to not enabling the
> option and so not needing an empty function.
> 
> 

Applied to u-boot/master, thanks!

[1/1] hikey960: Drop unnecessary BOARD_EARLY_INIT_F usage
      commit: 6201fd7c1ffa134f8ba229b434e6f14a3fd5bb14
-- 
Tom


