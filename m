Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7203606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p9gqWSAn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bs1CvyHZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C146F80DE2;
	Mon, 23 Nov 2026 18:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1b2mE4vPQSat; Mon, 23 Nov 2026 18:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19CEA80E5E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456823;
	b=NQooN3NLYTJrvtYbUc0vgiAdAoJeHUyJwQhY9jkCfd8zOxqwBq4acDcuvpTUnWu6HaZF
	 ysxRPr5wz3LgcuBdw9KWwPm4mihBSTtRbbaQ025pD0pJOU5hDstHdtyIBtSunLuk235WF
	 1CssyP/CBSJcV9jcvzYsDgj27wR/FbgHIvM+24bvywSbCIyOHNXqa+GO27U2O7nlr0t4M
	 C6GAgs0Xitw20LnTpmXqnwCmXKc++VIdYtwCYfYej+RaQhwGq2sDQ0vJWerXIm8xbsG5K
	 urPB5mzv8qLHUdGyvzonK/efD7n6pndmHbbDpYPBNVCS3VIp1LFwfONac7AjXFLuimQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=86z1uY193ZUUmVsyWUOp1OCc8kERPwJ6kbzKl+5ztFU=;
	b=SfvWw6FRvXNhwXzgxZfRlaHAnYoG/pkCCWxi749YsxwV25FjsLqMDowz7yfbWu69jvO8
	 QZ57yCwPqgQxZQ8h4pU+8NkjE9MdXDHXf5npQBLW+aztzn5chJlDTMLise3mjqDrbJIFH
	 0IRYZt889BuXipPTDEXD62e9ZpazWLp8NOW9r3CmtTgBMfKv9d1vVptANVKLH2brlcCoL
	 N3YlUQDeSfKMMnrwm0b7LiHR828tiry3l1p+68S0skzbD0QANinMEY2swTLANOCIPUcUa
	 ow0W4Hsdj8USEcwjKIh930gthpqr1M3telAYSZjN4+Etospu/IBufU3QgFBGja72haQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bs1CvyHZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795456823;
	bh=86z1uY193ZUUmVsyWUOp1OCc8kERPwJ6kbzKl+5ztFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p9gqWSAndo1zslENkwKAam0QaRWeK/+9rgDOFxaMGMe8UqIN0371BAS4Zxli12mzY
	 s5pf+cYa7VSbK+XziXNZ2ahe+eVYYfLftOrqV1G/391ihU85YXn+J0Jc02EBBgFmSm
	 DMZM7i4E6L5mXa+qgQGCHwwjg/3lauUJ+XhPxoCgYEW3Ped2N+nFoQkqoy++bSXjgU
	 qMwNITINTDHYXbyePQjIwbFXpYHB850xpamwbApA+WpEzQvNHeNVX4N7NSB6t+mNUm
	 nXPZfATGyQSv/ITfdeHNGvtT3Vk4d5XvceLuo9jU4RA4ksX6JVF3M+yEJl+dq6NT3s
	 A1HH1NBBdlUmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19CEA80E5E;
	Mon, 23 Nov 2026 18:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E2015D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 590FE80E07
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auPEi9VzLmAq for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B74380BD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Bs1CvyHZ
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B74380BD6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:14 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so7130485e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456811; x=1796061611;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=86z1uY193ZUUmVsyWUOp1OCc8kERPwJ6kbzKl+5ztFU=;
 b=Bs1CvyHZ7Wx7lLqPfK/YX66Muayg+eEuyq6PqSeCg8eEa/jxid//RFkFicluBK7LQN
 D8MU0XENEEAN2+U2NJV0Kb4JdTYjQzZhMRXhohub/PDCfs2BQSX8yaaLpcuIl42waSXt
 iIMPSfzLDA4T3rLt9ECclP73aAjx3N9Mt9jLZpIQFBdDmMH6Y331Ou2JhQYJFWim9G3k
 iMCtgzw5N0ibShb+Olb3ZTTgvvg09MXeMKcDAo3b3TO5qCjUhBASQdXs//4KivG2dkic
 Ro2LrRAcSieLFX7SCPzm0VeThjSeGHTsrHHZkHPXC3fpob+EiGoGDLdLbma+je3030mX
 899w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456811; x=1796061611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=86z1uY193ZUUmVsyWUOp1OCc8kERPwJ6kbzKl+5ztFU=;
 b=WZRX58I+JuOjO59sQ1kMCduz6WDtiGPPSLP8H3cnF4UvEnxZj7sel1B4guN6Q0Mhjv
 0lK56okZc7MtqGh2fo9+AizMv6X5JLZijMPh8I9tHRl+wDf3LLz8YLEXmjjV6KZK/fu0
 ahYh/vVdS6tCTRN/FLRN7GthnsMCbXSX4X1YuAd4STPVRJDGbwLi9RH6aXR4SHP/hDeo
 uy0r0O3LJN488qSiUHfUK4cVbRxl6ZZQhXXmP4sI2eoIpH/R8IBeF4fIti4jQ4qxWvms
 GgdVEeZZ9vOFSwuW9V6zzi33wWFooxtmdu1QqpWzlelfDesPFoIockJNPwweCKwnQs8I
 j8rg==
X-Gm-Message-State: APuU4Z8hRtlqJDr91a2FxY1vDQT+dx7JoWuRy724upYbpV6ICs0osKEu
 4Qk1lEVaohFRepcbE+0JfWCCr7ziN9/T7Ks9v8IJGanycHkp89GszVhX
X-Gm-Gg: AZFdTZdmJwzYqwzV/rtPa9AX5tjb4txNp5pU3zPGCelXPshWivLX1yzjij9wSVHO0AT
 qTaJhJyeh5fTsc9fgH31LAptYpiNh1OP86n/lu5CuyHBnySWum/wK+nq+hi0ESrsr0UPW9APjeK
 FUrFbKeHF6H5NBXipB+qLeh0DhTf34k4zCfEgjBQPAWGb/6Ywlr7i7BTN87vW/OygM1DcYID6v3
 2PjcKA0J2BoeVcsYDu+U08wJesmd17Yl52A64SmOARgS341Eihytlu9fOn99gWZkUmKrbrPRlbr
 M5oEqGslaGw4uzkBaw+ZdBk5l8XqMeryd5TupHM5r5GSoH6dDmdcC5HP+TgHTaBZa0TkOlATO61
 paWVMcFooC/FLSLC4tsnCldEcoTqIAUclfOJVIwfa1IIMrGWzdBUgrct8S+wM/IwLKF6C8LfGCe
 k6RsVWdWADoCexEAs1OCLLH7yXRaGbLhAq7Q2dVN+kjNMQ8TvGCGpDdmx3/awnrSvCvg/ZqCxhw
 Supq75OTI1e6Ppg3uFOY0e45azNLXqT7Wvsi9nVFcxmbFFqbwGeq4mmHW2eePqIug8+DtphXtNS
 2+YII+8G379rLG3Wx0+PugHQdMjPihcGFRwWoSPeRGYc6mtTyfu95fCNneCQWw==
X-Received: by 2002:a05:600c:3555:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4bb8881da76mr249944575e9.34.1795456810794; 
 Mon, 23 Nov 2026 10:00:10 -0800 (PST)
Received: from [127.0.1.1] ([151.51.12.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm543353365e9.13.2026.11.23.10.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:00:10 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 19:00:08 +0100
Subject: [PATCH v2 5/5] arm: rockchip: Remove unneeded
 SPL_SHARES_INIT_SP_ADDR check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-config-v2-5-be23de2a81f5@gmail.com>
References: <20261123-config-v2-0-be23de2a81f5@gmail.com>
In-Reply-To: <20261123-config-v2-0-be23de2a81f5@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ROCKCHIP_COMMON_STACK_ADDR configuration option depends on
SPL_SHARES_INIT_SP_ADDR, therefore the logical AND of the two options
values is equal to the to value of ROCKCHIP_COMMON_STACK_ADDR.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Fixes: 008ba0d56d00 ("rockchip: Add common default bss and stack addresses")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- collect Fixes and Reviewed-by tags
- reword commit message title
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 11062c4c5c1..7720c928e90 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -798,7 +798,7 @@ source "arch/arm/mach-rockchip/rk3588/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
 
-if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
+if ROCKCHIP_COMMON_STACK_ADDR
 
 config CUSTOM_SYS_INIT_SP_ADDR
 	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000

-- 
2.34.1

