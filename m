Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC4DF483CC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9907884206;
	Mon, 23 Mar 2026 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SzHrwoaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F5784206; Mon, 23 Mar 2026 17:49:18 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1EB8410D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so891960fac.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774284555; x=1774889355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksQ6WbhdF5bMtXA0L76c9bk2TvrtwntGjk2YVbXdLu8=;
 b=SzHrwoaBAK2nIrOrUIjNSVZ8KRZcgxnWAjCvFsqv345yNrO+OToNXD4/9XDUtwwBR3
 IXnSLgztnZDqEeewr9yyH0Fg6uhGQv1Tf0m7LqFoFe2TTb8JXbddIuCbafQNDGDwu6Ph
 3plfzkzI9nbiB6ErALOIjLriLHt0Aq9lrT0YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284555; x=1774889355;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ksQ6WbhdF5bMtXA0L76c9bk2TvrtwntGjk2YVbXdLu8=;
 b=lm63S1DIIpTiTGW5f+mUx8Nlkw4CXKiqC5fcz7PBbfaS1Q18C0QxauyvGQTeSucSq7
 xuED88wTy9Z9RmmodCwpuUMOVcm8ofF5Ji4NjvdqUfLscIKzC0SC/7acYIfkrnzUIqrY
 kl9hRBM7dh1EopH3OeN3BcIsD60yeFlLSndsdV6ku4J110fU8Awg+gr4DqB+s+KeyvyY
 FqkOxEX7GU459Qv5XTNAI63WRPCie7IFhtu3VjJ1IBQsQfp0VSHTg/2zR/3/3JGEMqyT
 sJeTIURgU7es/deRBsWidA52cYdJSpnZTHVpNoojOljunK9cIruJCgrys9d+h1Qh1SWE
 6tKw==
X-Gm-Message-State: AOJu0YyW8fGsKbJZHySGvbE7VFgx0bzOly+0/W9AM3WvmApkHfFHexGf
 6WM1woLytGpomDA4S2jhs06BBPc0rUf2SEeito5dJBOULZ1ISSEapQ0uqQ1mQ2BzL5E=
X-Gm-Gg: ATEYQzy7KK+vEVlPsdg9nZmufQoxDWgzzYbxf+x227+Q3U1FFZnWAuYR5i849RBjZpv
 pSGHNVKz5gyVm+vzzdHmNXjF2RM+5S883y5T/di/SW1eyxs/SL6eRnb8pNKlyzow99D5H2vIiGY
 bnK5Eb/6DUkJYZKMOS4iazZwMCmD59f0cefveSX5HmzW/3ACk2BILG20oVjXU2EN2Ql7bkvzNul
 TEMhWS2wfB0hwuSm8hfC3w/Oc1xpAi1ube0GBFOM+REjjFa2l19mCBMYrlNElsDV/3CsnS24F85
 qgOARmZL9VKi4pMD/DWW4IMUit6wuPNSVmiS2d3T7tbegRE3LK0ZGkDe1LWgEtQhSCLNk0iNsCG
 lzvjP6PQOoReXzIuJv8BO4b6KpJlqGmqscyw0tnhS2w44mcfkvOGuT1U/9hIfvGjXCNYfaih4CB
 1ZVCiKv5gDNBDqDUtMWiHxVKkCPLavkmAjOPRrrODiKO6pNLl1DSMjXdZHFVwXDIUXaf+pSl9Hi
 wjRsHWccEmp97QquOxArZBf4Pgr+ujxwaTWOFoog13ngSI=
X-Received: by 2002:a05:6871:740b:b0:417:4679:d550 with SMTP id
 586e51a60fabf-41c1110df31mr8131000fac.22.1774284555486; 
 Mon, 23 Mar 2026 09:49:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d73a19sm10016158fac.11.2026.03.23.09.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:49:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Bryan Brattlof <bb@ti.com>
In-Reply-To: <20260306-board_init_env_introduce-v1-1-22220dddfa47@ti.com>
References: <20260306-board_init_env_introduce-v1-1-22220dddfa47@ti.com>
Subject: Re: [PATCH next] include: env: ti: move board specific scripts out
 of ti_common
Message-Id: <177428455443.2303875.16806654346545315111.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 10:49:14 -0600
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

On Fri, 06 Mar 2026 17:32:37 +0530, Anshul Dalal wrote:

> bootcmd_ti_mmc had cpsw0_qsgmii_phyinit related scripts even though this
> was only relevant for the j721e/j7200 SoCs. This patch instead factors
> out those scripts into a generic 'board_init' which is called as part of
> bootcmd_ti_mmc.
> 
> This allows boards to more easily add custom behaviour to the ti_mmc
> bootflow instead of having to modify the ti_common.env file.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] include: env: ti: move board specific scripts out of ti_common
      commit: e853610b560c072dd7207f2ccff01772aff1b748
-- 
Tom


