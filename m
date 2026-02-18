Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D3AE9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF9983A47;
	Wed, 18 Feb 2026 15:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bxrmn8HA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260D783CF2; Wed, 18 Feb 2026 15:00:51 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2C383AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46391e91e16so3200985b6e.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771423247; x=1772028047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjcGC+6SFvyBgCtB7sRI9DtGNwgJE/lMCTBLG0GxESc=;
 b=Bxrmn8HA3L4JpYCQEv3YrnRE7+RYI1D/khyeu42tPJMmfZ2Og6mwzqU7u2jycI4wUa
 VBCilLRtjQ+8XKCcsuEqC0fYZIyZcCk/YcQI8otuWsqymuUriXVmLgIQQf/Ec5IU57Tk
 Dz99FOrF1hWs3K7qomOSIZ+6HSjgfhEvV82KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771423247; x=1772028047;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RjcGC+6SFvyBgCtB7sRI9DtGNwgJE/lMCTBLG0GxESc=;
 b=jkXix2SAVNylMKA97XE5AVQmoi3iGMxV1LpIZs6oRDCZHoHFGiezf6A/RPx8vhwVA4
 AwMQ1SRaJzQm779F9K+ZoNcz2puOjKeY+AbvAX9SOSvE89wPVrChsVbcmUx1k9w4C5t+
 J4Vzr5q+xctWplAT5wKzvyV1bjzONG5JIMvRBfv0qBOBYjzyZmuXdQ1MfbwO+TyUGGNR
 DKwVjxxneWOs0TdvxAGEsXEnJ7gcSSdMborgaey+UFNx0FUvdk1BzqUAM2sN4ClkZFPW
 kffkNiNmFZzSj3A8Rl9AKdIdqkscXYrjl1epl4Efh4Cq/zQHn4+DeFAwN9O7bh33DAqx
 iIqA==
X-Gm-Message-State: AOJu0Yw2OLnfuhlGlq8/iP1uQ+Me2G87b7RsX+WrepjxjHI7fOfMyA76
 Y4hmkAGNhrGpG7qV1YB02uwlUaXWi9qBHjnP2HKRAAF2eTYWUGVyHo7pjPYNj03kA5U=
X-Gm-Gg: AZuq6aKXv0N+18QSh/UJS7IYTBgFaOmJ+WbdP3knzDu0jtPA1Wa6KSBbqllygB7kfvf
 vuW0gKj8Ks1BbIRSeNm4Y6Iz5dhYs6b62NHVgAPZuyZDVREdPhQHv0aTQTklZ4loj6C9knlNgtD
 hhwi8e2IYHI+PuMCQJ26yBopSSvvE3601Yk7hOmJBO+uMOsA8P0JEVQYU9yRp2Ijd/oD1Um4Jn7
 QzoVkT0SFseP3T5Ud93CAjjdTJYzdDEiKLQmatv0TBRIUufIr0GAWAIZZs37wUn+1YFpXLhZ/pH
 rdCRXdnQiO0b4pWAjunAmNoOP2mFqBRJ1LSXsEQr4txbSvc8WHd7gZGoeDU53ZxCc1/ziH0t8iI
 8YRDsyn4Tg2ZtVevF3oF5UQnBZfOabATMagyz8dGPIdy/LiFueS13pmyInWADQWHSynTQ40lZij
 z+nk0ftaTrQ6u9iKKzP3qnDuxdIEAwYRC836KnHh2TNwMg8z15/hwmFyFZ7R81dvJROg5AnpKrS
 FBRUNZYeSTsOy/6Gu5QMXtgnZprTM3+Fg1Du5rtUZX8af/1qQ==
X-Received: by 2002:a05:6808:302c:b0:45f:2042:8fbe with SMTP id
 5614622812f47-46410b46a69mr1029876b6e.13.1771423246444; 
 Wed, 18 Feb 2026 06:00:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4638e05aa10sm11976233b6e.5.2026.02.18.06.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 06:00:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
Subject: Re: [PATCH v2 00/14] treewide: Clean up usage of
 DECLARE_GLOBAL_DATA_PTR
Message-Id: <177142324537.3530872.17243928229527223257.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 08:00:45 -0600
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

On Mon, 09 Feb 2026 09:30:04 +0800, Peng Fan (OSS) wrote:

> This patch set primarily removes unused DECLARE_GLOBAL_DATA_PTR
> instances.
> 
> Many files declare DECLARE_GLOBAL_DATA_PTR and include
> asm/global_data.h even though gd is never used. In these cases,
> asm/global_data.h is effectively treated as a proxy header, which is
> not a good practice.
> 
> [...]

Applied to u-boot/next, thanks!

[01/14] beacon: imx8mm/n: Drop useless files
        commit: 090536b8e6f89b31698e20c2a48e1c7ca50e1555
[02/14] mediatek: mt7622: Drop useless board files
        commit: 87b9ccf6e429323a64359df119df75ddb9d6ddea
[03/14] common: cli_hush: Include vsprintf.h
        commit: befa5440b9d484b0d389864e59bcb3aa5d50695a
[04/14] cmd: mem: Include vsprintf.h
        commit: ecbbea0d1657856d1f9515e0ebdd1f9e4be3744e
[05/14] test: log_filter: Include vsprintf.h
        commit: 68ab09e3a2986b570a249d6c1b12baac0e539274
[06/14] xtensa: relocate: Add missing headers
        commit: afbeb3a0922e5337e5b473369245e2fe55cac9c5
[07/14] toradex: common: Add missing headers
        commit: 49f60d60f70bf429319d72b85bbf5bb37519a7ae
[08/14] tegra: pmc: Cleanup headers
        commit: f025f9de6022167e494a88f22751a329b4ac023a
[09/14] rockchip: evk_rk3308: Cleanup headers
        commit: 90d7b4c8a5b094cea20e60d4ebed58aa571b734d
[10/14] nxp: emc2305: Cleanup headers
        commit: b2db865c4e5e625c4b4fc9eb3204ac96effa3af8
[11/14] pci: layerspace: Add missing header files
        commit: d3b0b3c1184744a3471ca98363b7bc31e7ccb882
[12/14] renesas: common: Include asm-generic/u-boot.h
        commit: 15398169c4283d50b7c578363baa4e4054e7b4fa
[13/14] socfpga: clock_manager_s10: Add missing header files
        commit: 406982f091c76e6ce0734373426bd756f97d64e9
[14/14] treewide: Clean up DECLARE_GLOBAL_DATA_PTR usage
        commit: 0f90b1e715f8abe41b0875752eb184f46032ff11
-- 
Tom


