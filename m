Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD736606A321
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MJIlO4PY;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGHlALYt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 869DA40859;
	Tue, 10 Nov 2026 12:24:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckbHJhhfyRKn; Tue, 10 Nov 2026 12:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0F03408FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313474;
	b=CgtKl5dFlAqyICdITPretdWkjtQtnMr2ouMyC5ap3odSZHal7Dewq2vXm8kTN2yRFHUD
	 mCfoc4RpVLm1oKrvJ8BPFhe5DDUaYezyYVVa4lGir2Dhe8fCvzJmyJmo+uAQXl718Y4OS
	 X8nSW7Tfp+0Z9dDutF3njqAs64qpLSaaRsj1KuvV5E7v7G1jaCwT2olnaYgydtYeFuVGq
	 oXVZKxvCoebPcNqLkdeudtENXO9UZ6tNUUBWIs3qyIWgFPVi3ch4MCPGf3yuMlnlgnvAM
	 jmBqtFxiiVVXuoLsO/42W96B1+aF53WRxUzhQ6/8bVnDC3igMsADn1UT/WrRE1EuZyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lqkrda0Zzb/QHMwOL29/96Halr3MG2bhjO1yR1klyXU=;
	b=SX/0GHFwnFLWgDfHR41irDQ3DqqdnmCb4gkOoTTQ6QgMj77isHrC8NemSMs1igC3Ajbl
	 abLdAE7algYe0ITKCTNkriMCgP88n6zxtrKKQSngBRaM8K5FIbgGJcRjPNddHi1alc22y
	 QMty5ReE/BnP5FoSGLXshqkLTLFwZuSjJ1sFMxBhnUknisTu+6fwkG/DYf5KDf5ngg+he
	 PyuvOpbYxDAwb3fl33GIoiYlz9q0ZXCIZUflwqWfd98kduam0canDEwF/n+mRgbs0g6kk
	 TbQhR8LTl/XJ8ZA2nu7pYYyHHg3RQUQEYtXCZvJ0GkHVsibDTtDl1mRRS2yoEqRtxjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313474;
	bh=lqkrda0Zzb/QHMwOL29/96Halr3MG2bhjO1yR1klyXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MJIlO4PYufgK4Yf28nez3dIEWh2gsNhGTP5bfK/pLJe/9Awr3Bm0ZW2tN3thGAh04
	 Xq0P6xgMRuBvaTyB9ROoqiy0UwOaQM37ClLn1407aAlDBgvHFC0DDXTkUeMA6LPdrG
	 fZUyY7tNdy7tPKNZ5ape+U7IxgC1fov6OrHjYPjdK3sjIAd15tA3ZBoHVweI6GlycU
	 1Y2rrZWOFXeedd6WZVQ6VHraYWlf0OJkql155rxCayEL61ckjVcdorsPt41rB8eYN3
	 BL+7X8Iw1HMvclW4VTwuDUPstlvD3i9pujHxnIlcUBMNveiHxeuxYSLxzjd4Vn3KqK
	 E4I4UYQoNOCkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0F03408FB;
	Tue, 10 Nov 2026 12:24:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 886919D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A57940176
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8pucnlig9IX for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A513E40347
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=yGHlALYt
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A513E40347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so1199675f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313457; x=1794918257;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lqkrda0Zzb/QHMwOL29/96Halr3MG2bhjO1yR1klyXU=;
 b=yGHlALYtVEo98YlboaqnwbfYgKvUo9f5ZDwKQmd956OFIB1NtlYYBwe+45MvMkPXxy
 A969s0Xp98YhBdV0wQvRiMfH5D4aBbAE+Oj+kHP7tRHDOSEhnc3ibkSugCdofClKEwjO
 GuI5GGuW2EpCdR7qk7g6GuIQJgKhSId2yRw6slUPzjQJH/b756GlZnQ9b2M1J8m4I2ra
 TuEBVMzfty61HiF/oZpxj9tWKGyXBTRX9zzIjcf68SrOZzJCnqIq1EkxC3RYLEA5GZ5Z
 ql32CO0kXZIzJDBpYRrR/iTclvpT3zQBZFPuoWT6OF/UR185XoGJD4f/vtmW6GXWzHmn
 X6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313457; x=1794918257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lqkrda0Zzb/QHMwOL29/96Halr3MG2bhjO1yR1klyXU=;
 b=TX0hfxg4IEJ/VctyosD8tfZknyAPsXucwAWXvFbwzdvZTDRPh1q/ec95t3dycw0bPs
 KJc5P31GhVauLB+di48OZNkEAKbu0VDmJHclQfj31UPFfUkg/OGREb4BTHJUzcu5g2ai
 zP9ewuk7tjf22ETm4gdoxI3ln5S0z1eo6Sr3jSMAPbP4ke4EJiOW6myyTt4ZpoK5p/BP
 iyxCuicOB9sLHeSdGBWiFYm+1VbTKX9D2oJi/FNY4ZztfrbdaD4oXA6bJGxs8N/IoEtV
 wbL0vrVz+0FqEfrbPrqJZh+GZ5uZawIaaKUeJ74UfXDQUs7GJKWzlE6HY9UreQvObM9o
 qAIQ==
X-Gm-Message-State: APuU4Z9zPuhEOmxRhXXI0xuGxEt3N1FPl2V37IjplQsvIi8IvhgaPD7Y
 tIrst1ZcLayGgNP8TncAHaEEjgJ2jALnZLSM8Pqi6M6QeWk6vpF4ggF0ZfhCcEi271g=
X-Gm-Gg: AYBFou0SVmJGeH2BTUKpYzScGaaNWQTWJ0jrcIQNnMVX15NGcM8fO7RdTpQxOYTFrJ4
 sd5JAITkOvhRHcsES1ZiFc8v1a6ZtH1/pCf7zc/H0uPKo8d1QFI3YhSPqs5Xu6nvVbEVgLNQpZY
 Hpnxo8fmAMipfkl+0QtCHywkEDuv/V4PAxXqCBjfF7hH2rxxkL1dujQPgGaE+wgsnlQe1v0Ek1s
 t5OREuh024fENdXmIN+d+EW6lhIPl56DJ58+0yd/4jJBGz7QqEEhcDkEZtEcoISwlrY7u10duRA
 vk7F9/WppdlR9Zvvfb/+cNwPPefT/orcxhjGLs0TUtm/Req1B/fjmz3JDahLZo9mW0K4XALiNqH
 V50yaQDbY5SQ50jT+M/385T0L3hKf8bRQSIBJG7yz+YbiDOwOR+0upluCGOAWnImqmgnK1BLzNW
 qbCE4nn8TTUZbSgvFXSpnnN7CvwUfGPnxqVP4v0AXVxgtWFozQ5fcIxNusbIRRaFA7Fmc9P8YSH
 wonqVGwCRGNI1r2uqzPF+N2xF/MzY+20a80jyVmipT1MYV9oISBi3s+KnpSzaBXU4GQ/mLSYFfZ
 sVtZO3O6RCOp+jQLPXwyMgaI/ILY9KmDuFrgvV6pWIQfnSlr
X-Received: by 2002:a05:600c:348a:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ba0234d97amr42743935e9.12.1794313457236; 
 Tue, 10 Nov 2026 04:24:17 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:16 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:07 +0000
Subject: [PATCH v2 10/12] tools: Fix typo in name of command mkeficapsule
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-10-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The description for the config item TOOLS_MKEFICAPSULE has a typo, fix
it. efimkcapsule -> mkeficapsule

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index e151b30217e..78172e8f9a2 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -107,7 +107,7 @@ config TOOLS_SHA512
 	  Enable SHA512 support in the tools builds
 
 config TOOLS_MKEFICAPSULE
-	bool "Build efimkcapsule command"
+	bool "Build mkeficapsule command"
 	default y if EFI_HAVE_CAPSULE_SUPPORT
 	help
 	  This command allows users to create a UEFI capsule file and,

-- 
2.47.3

