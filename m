Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689C0CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03452882F7;
	Thu, 11 Apr 2024 14:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FycGAtMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54633882D9; Thu, 11 Apr 2024 14:43:15 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E1F882AC
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a51a1c8d931so769805366b.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839393; x=1713444193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOFU19Zs31qDDB4sUs+9fRbqzwbYCicW94Twa6AOfOg=;
 b=FycGAtMIKP9sJMHkXv3X8QXXxPnhlgINnPnXgxcGN1pT9vNpK+DSBdcBim4YopTezs
 KzosNFoD78jRcpK+Ub1b84YMAggMyLIngEvUVCmgGAnNf5bKqvqorM9sywpBAWe2LOQw
 4+napdxQJOLbTF6SEVsobFmqp1XTixXd50+qbigqKLFiOz8mxMdBwf/myXcJGaaFgKcy
 emwYGzNLKYLOgZwYxjNAZttn+6laKWfY/wx7dCMBjm/me3n0OaJ0dVjEPSMiFMv4mdgU
 iGSXlGK4gLWxTB2+W3hYLxzI8mb8CfM4gOqsZwKWBR+BAx9zs3iK06+VRC0iZkue6zvm
 0FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839393; x=1713444193;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOFU19Zs31qDDB4sUs+9fRbqzwbYCicW94Twa6AOfOg=;
 b=VHDRm29e/WXUJ5unOokprTLkv4uvQQNOySsDlnUSbqFc++aEs65wKbLd9gDE3zyoXV
 +qBod0gL0IQbLs62Lvz0lj5KIaULOs4bz92RWycSBCon4PArXq2OpvjPyfeoTyWzmEgo
 bg56YfHSh4I4tLeKoJmuCytkYPrkNN0hEMFDA77i5jpoDAmIEjDzy0GUrmTMULLqslyj
 Er/ua5tB+tad2gvHkkRKjSqqXPXLUNmsK8rNTP4SnRn/H3Lv3maYHzflz+ns/fDmdk55
 BU8f2F5yEh3I9JbOqsoFJN3sJ3rAb2CGOspIpKDScSai6FCFL/VXFwCBIVpZSLjG+WUq
 t0Sw==
X-Gm-Message-State: AOJu0Yz+KusfbgLeqN0GOZEwpsVSDwQF4rxcyaPv1PANgWRtPXGQ8QCo
 1xZJ7Hb5nU49m0ilugF1UJKNADgwAdq33/z0/M5MaWn7cwAVQEMK4k1GQkTNxA/tB/mMNBoAsXX
 i
X-Google-Smtp-Source: AGHT+IElncH99BKyXjP2AoXPmCicDwBjybpPftH2ciqYWiBufUk/wMFBeiE56dewDHIhQlOS1fCaFA==
X-Received: by 2002:a17:906:c103:b0:a52:22e7:4003 with SMTP id
 do3-20020a170906c10300b00a5222e74003mr1319564ejc.49.1712839392701; 
 Thu, 11 Apr 2024 05:43:12 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:12 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
Subject: Re: [PATCH 0/7] qcom: mmc fixes and sdm845 support
Message-Id: <171283939135.622116.8766547419622647056.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Tue, 09 Apr 2024 20:02:59 +0200, Caleb Connolly wrote:
> This series does some long overdue cleanup to the msm_sdhci driver,
> fixes v5 support, and adds the necessary clock configuration to get the
> sdcard up and running on the RB3.
> 

Applied, thanks!

[1/7] mmc: msm_sdhci: correct vendor_spec_cap0 register for v5
      commit: a737d8962cae2a37634bf0fe9f2b6907f7a047a7
[2/7] mmc: msm_sdhci: use modern DT handling
      commit: 5fc028897fb16abd0823b545b6f7b8a1df54d4dd
[3/7] mmc: msm_sdhci: print core version
      commit: 0dc3cd3e5e501a575d0579b78b238bdd1b2a8274
[4/7] mmc: msm_sdhci: use a more sensible default clock rate
      commit: 6d327bca5ac7112f168fef8f2284e67211637e6c
[5/7] clk/qcom: sdm845: enable SDCC2 core clock
      commit: da74cd018493b5a1f6bb8785bf6cc7754e42dfd8
[6/7] pinctrl: qcom: sdm845: add special pin names
      commit: 691e3cfc645504397a5f0da7afd2db96e4445f26
[7/7] dts: sdm845-db845c-u-boot: adjust MMC clocks
      commit: 17cfde60a2fcaf3365fdef7755a825aeddc6179a

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

