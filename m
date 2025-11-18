Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FDBCCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 04:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D239683C32;
	Tue, 18 Nov 2025 05:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tDGeiaXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49F783C5E; Tue, 18 Nov 2025 05:23:30 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB3683C16
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3d47192e99bso3935363fac.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 20:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763439807; x=1764044607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nbgjp98bD4RCivIwc+AQgrvkUjaY7lOi5UQvNW8mFUs=;
 b=tDGeiaXJ762YV4xguTL3SqRQ12fkczdk/IKRRvLSXh/Rzn5vYBsiTDNqQ3IoW+fSQN
 sardwJNJ7V1a3SSStbhJ/ucQc5hPsP6kE56/VjnqYBBETmnBf7EYLwmdP5HXusidWFyK
 LhhlTPji1P+3ZXh0u78MT1H0Nk8WYhlMfWhYpeBfveWltDgeAYzjxJltauynlDlF5e7A
 K+Lj7aipQGbgEvAtVXtK5sKQzZSpj4OQkyNoQBHE++qkv1jcPp+vWQcqpjj+tuYkyk/A
 iv4N3JptBry4qpcVauPyU00+BmquKoHoNOaqKs1M6tJ2BGmc7mE9P79gV+WTUWmKDfIT
 BdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763439807; x=1764044607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbgjp98bD4RCivIwc+AQgrvkUjaY7lOi5UQvNW8mFUs=;
 b=oVVRwcpepeA7G0ALOXjIr260dw7v0eAI8gxN+gviKpmByvzboSc2GqTm4o7RRWrc3T
 cykBTwEdT6ve7wwihiAw04gfkqUYD2cuwAxDRHWaV5W5tyBiSZwxNSWOzHhlwThjzTCA
 OEttH1Y3JB1YNQOSRD1R4VLAXFa6mQJWK1ASNVjb0WLirqBfMehcIkMCOSb0keCqKdr+
 Tc4hjEeikk45HAVXMPOWvZEw3vPT0yhgLymlfb9Wyvvesj1WhaxID8Kqm5NoF99W3znj
 Wh4jrTEh7dIZjVKMMrMdfRH71+USXyX4KQMtzx0q8830WcveVjiWb6N3CatGhYptfmBe
 ExQg==
X-Gm-Message-State: AOJu0YwZ3w7d8wH+NbEbUCbfXqp3vghnTvKC6jHWDwQNNngG7WA7Gbv0
 My1YNqeSTihKWz3QEDkBWjhA+Zsz2f5MTeuJQ1XHF8Nfbea9V7h4OuiIy0GwWIpnXiafc8fz3rh
 osLza
X-Gm-Gg: ASbGncsOC/GfSUJylFWBXeYdJd2EDYEA+v9RMmrE4vWhsEvpGxWm48kHtXRK2ZeUQnf
 PZkrPnVdQuDQF6rJXpQEFqWer9+/ZWhHqdhFdrfTtYGZvbQmv/9lpGJcEu35wAk8UChUScf9vOL
 fTG7QtiBYuH3J/zCoy1RTfWYltnF0n13zhz7OiLe795WRcc9SmPjOLCQeL1CvZ4KwuYF8TLOzk3
 e1C/AqVyk/GgWurUIvdo2Do72hwtzI9Y3nGuoYfEb7kC6MJALihEX7vjyoWt+6Z3i+pwogWfgHL
 i01IYQq42EjMHEpeJOiW3MVolO+2TtkuXUxEcN5j2mzJ3L1JPwCZ8AlDDZe80bjd+sDeErfARxe
 bptj6+/xGsrJZAR5q58xD8QfxV2JCuyk5/qDTMyJ5TpFomT0qzeVLh3Q/V7TRzJMOPaIjpLiKmM
 ZachbcCyGLLMim9yHFalxD
X-Google-Smtp-Source: AGHT+IHjdZC2ZDfI2EuRQ5/mm4z7kk4NL9SPp0IvhbrjsMpugxXVpMUJ7UFzOoyQMXNXy/YfIWQTLg==
X-Received: by 2002:a05:6870:c194:b0:3d2:e6a7:e938 with SMTP id
 586e51a60fabf-3ec60e57afemr1177657fac.15.1763439806960; 
 Mon, 17 Nov 2025 20:23:26 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-3e851ffc62dsm6688521fac.5.2025.11.17.20.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 20:23:26 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] mailmap: Add entry for Sam Protsenko
Date: Mon, 17 Nov 2025 22:23:25 -0600
Message-ID: <20251118042325.16659-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use 'Sam Protsenko' as my name consistently in git-shortlog. Also map my
home email address (which I used at some point) to my current work
email.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e08dfd3a5263..c93a58d6f586 100644
--- a/.mailmap
+++ b/.mailmap
@@ -121,6 +121,8 @@ Ruchika Gupta <ruchika.gupta@nxp.com> <ruchika.gupta@freescale.com>
 Saeed Nowshadi <saeed.nowshadi@amd.com> <saeed.nowshadi@xilinx.com>
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com> <lakshmi.sai.krishna.potthuri@xilinx.com>
 Sai Pavan Boddu <sai.pavan.boddu@amd.com> <sai.pavan.boddu@xilinx.com>
+Sam Protsenko <semen.protsenko@linaro.org>
+Sam Protsenko <semen.protsenko@linaro.org> <joe.skb7@gmail.com>
 Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com> <sandeep.gundlupet-raju@xilinx.com>
 Sandeep Paulraj <s-paulraj@ti.com>
 Sandeep Reddy Ghanapuram <sandeep.reddy-ghanapuram@amd.com> <sandeep.reddy-ghanapuram@xilinx.com>
-- 
2.47.3

