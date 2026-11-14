Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03380606A331
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lhiFzO50;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=n7jmNL9G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C921B81684;
	Sat, 14 Nov 2026 15:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dvpfFVe4QuA; Sat, 14 Nov 2026 15:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CB9E809AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794668409;
	b=JCHGkI6yaWCWr/OZZAHKS+7khB5WHC2xo2Dp7TqKvHNB34rmsK1NZ1+HgLXSUU96zUFn
	 ugW1D/ot1WKaG/k9+cJtquRDVgUoibkXSEDOw+6xZslRH//SHTiyiD+R6DBX60PvGfpPB
	 PqLm5y+PKju2OPJ+dTeaykv/q/zCs8lBXzcHTKV+4agt4kNveVuFgMH+OvJNSc9FWrDk9
	 HVy6XwErGgu0Ji9/6PyoonOVWdJDFfzYd/yyFDg9aDKzYj8jsZFfA643u/iTe0mTPuhxS
	 JFVRL10RCi0tX1pElFY5MBtD0+WwCmE42wNHRsqTDVsLkIdfDsWoBIBjNCcvLvh5pcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794668409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BcpvFUqJqYCosC2bdwcdYHD7BmqhvPsK9otsk0zp1l4=;
	b=SZyi6RaoUuUL5d++mIiUBrzJeOZX6JJj5bxE+2GM7+qPyfavoenC+uVV2cxjLaOoGh2k
	 EqF5N+mSENMszBBlSVa50atpIoQ43zRWV9pmtkh2VjM82JDYIPK4is3YsGSwPjSmNrmgU
	 flCtA9iUFgL+RoL1awW6efQuTHXcdUN+gw8mbge09VA3BE6uY/F/PIaH7x1ikg/wr5eqY
	 r/gj5CANwM43ovl1DtyUoP+YiE5+/MB/9QQneLhAhx3u5qfhqVMhMxrOnHgve1aShi7rv
	 lUrilKOqddZ0ZUEePjCDpsf4v+zTDy+rsu4JV/qzQZBM6JbKRJDtLqTBxAeYH1YWLeg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794668409;
	bh=BcpvFUqJqYCosC2bdwcdYHD7BmqhvPsK9otsk0zp1l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhiFzO50UXP6LLLblG3UOi6C/IW02rbcjcMvoZfsURLyzLa7EWNpzAvUZUP0iHDyZ
	 gTqnIKiDsJPmbWX177FmAIiUer7B48twtyd88mYC6yCRWUoWQEM0/j+tAqe07OEKPD
	 ibCxuDjATcVPhqlO83q35Ia9FP2rNzB/G5pCB9v9dk/m0WtOBtyRKAWcjXlK0zhtba
	 xwdX7JTCx8dwcB8GEc+1Vq9Z2zkBz6n4eQ+9FMBGI/K+jfLbF9tqH8Dm5UkPMqrAja
	 uPeVWs1dkO6NntwrwLJQeU5U45D5Xj65qw4vhM8CwUKZLY1GztwD0WrKNdiM3GIgbc
	 lGDV7gpMJjFow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CB9E809AD;
	Sat, 14 Nov 2026 15:00:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44CF272D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 369FD406E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yM4iYG6t4Z8k for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 15:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3BED9406C0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=n7jmNL9G
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BED9406C0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:00:04 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so10694085e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794668402; x=1795273202;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BcpvFUqJqYCosC2bdwcdYHD7BmqhvPsK9otsk0zp1l4=;
 b=n7jmNL9G4DQ8cwLJgC74yFLSaBBzRcH0DXtCMZ89h2QAjdo4VMDq+9eBpnn8SHKzj2
 ocfoLKS0Y9Y9YUPwfjx93F/BT24GgAo+xTgp34iPU9xh6uO4b4+Su3n6YA311n/JA2ji
 2Y9ihc7hDSYpAgTVxVNRuX0C+ebaZzPIk2it0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668402; x=1795273202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BcpvFUqJqYCosC2bdwcdYHD7BmqhvPsK9otsk0zp1l4=;
 b=b+n6y+bLZo2sYiA/jQfATjoMJKO0qdcm9cTaxznKwdx3dRs9tIz3n57sDa1Ws8RqLo
 ljjQTDTDJ6ztBABC1yYE2z0fM4wuAZZVhdRHVs3VeafDCpFpcIMvcGEeT7iPwTTrf0vy
 q8ifGLxZOd2D3PoxR8FMLIZLfFTFzWZeEl26j+0cqoFCvR3cbVCq+3u9GTN3v/9t7JzA
 WGRd5yzj3J3Kam2YIxO0vukKVYF8wfnBMpNSjuxWTBIvbtYPEWhqgsmTLA7dOVP8lqRc
 pwPR3FzQc9Iyk0elIkh0Z5gKXSkPjfTET5QPQdkYtXqmAfvupS+Qhmg73qaTkhTGKiDp
 +o5g==
X-Forwarded-Encrypted: i=1;
 AL+hErGosYcZMqGfXp6qCLEkrbuX6dXGsrG4hAbUmf22RenmJrUuNv3sQU0EgB2LXwHelnbIqPQZpQo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ej044Sm19ZtPmnsKoI2dEUeaXPE3bXbVKxgVYf4n+Wp2d52Ch
 7Um0aPhOXnNT0Ld7GdBb124K6+B8uuUB69ttPkbcoFsK85fiJZ/uxBNtQPF1uM7gSNk=
X-Gm-Gg: AYBFou3Ubmd1VJ3HSay+Qo47uUciVLmRsUll4GNTauezvwUXnEfhIZub8NgQIHIYNZ2
 jSQvJLkzHH3Zxdt9GnLl7rwhrQ8Abgc/3Bpycl5FFli9Hr2OR9lLVRKeH0aDFtSEyE29YYrbsgW
 1ZU9BELcXmWGCUZ3YWptPSdySVkfVNSq/dUe0dlFx89swqEJjv99EzTshrf1NwEmjU6GhZt2LfW
 uNzJ/BxXzisHZ6B2qGyAp5gin8PXGH3o3/6nNAPyY5qJma1jiXtCs2Br/MLj2BOadEdRZ9uLWiA
 R1qdSQW0aXyXqvepxs6S6H0gkdAJhh04NMxm7uKa848Qw/JUN8cqBk6nK+BPpg6ydIfYgxld4Pn
 G9jURff3LDGfRupo6QsQoUJioFsCEqahgDOHNSkkLXRjtCce60eoqedAeQu6gF5k+GRVyGxSyQW
 ar1lPx9aGjfrJQ5FKRDsCUHqN+LLhRDYy3iYEoeBM2kIt8p8fZ5vNC9gzlZ3RCnosj+CxccZVGO
 1smSWq9kY8NbDu7HkruDnn1gu/cpc+CTye0+gTC2yqhXDywa4/iOxPPHLmyHqaq8AgRyLiKIME3
 M2dnw7bCA9N3OsncdNlA4nFRCVahd6wAaZ7RIPAf8NtYhm9/ZSdGfQusf3JeReN2oKuy+RYtkt/
 HuMAkWo7D8EXC2+K1wIqCPYos/+9H4WIwgVvq/WikLKqXboVM3KfBHa61BqIGjrh2RZXobDUU5M
 USVJ30wu5CCV731bV0V6a3VQNbmQ==
X-Received: by 2002:a05:600c:83c5:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4bb5599af0fmr124028495e9.0.1794668402055; 
 Sat, 14 Nov 2026 07:00:02 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f782396sm11728413f8f.24.2026.11.14.07.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:00:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 1/2] configs: stm32mp25: enable the LVDS panel of the
 STM32MP257F-EV1
Date: Sat, 14 Nov 2026 15:59:43 +0100
Message-ID: <20261114145957.2197295-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114145957.2197295-1-dario.binacchi@amarulasolutions.com>
References: <20261114145957.2197295-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LVDS panel of the STM32MP257F-EV1 has a GPIO backlight. Without its
driver the panel fails to probe, and so does the LVDS bridge:

  stm32-display-lvds lvds@48060000: panel device error -19

Enable it, and raise the maximum framebuffer resolution to 1024x600,
the resolution of the panel, from the default 640x480.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 configs/stm32mp25_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index e55ca2e3f0f5..02e5efd1f48a 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -95,8 +95,11 @@ CONFIG_DM_SPI=y
 CONFIG_STM32_OSPI=y
 # CONFIG_OPTEE_TA_AVB is not set
 CONFIG_VIDEO=y
+CONFIG_BACKLIGHT_GPIO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1024
+CONFIG_VIDEO_STM32_MAX_YRES=600
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
-- 
2.43.0

