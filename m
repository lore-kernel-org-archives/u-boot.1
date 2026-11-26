Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CD606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I6uuPFxf;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MVnWIuwp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2636C409AE;
	Thu, 26 Nov 2026 13:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RoLdG79B4HJi; Thu, 26 Nov 2026 13:12:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67C3C409A3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698720;
	b=irFsGACBb4WV17dGOiAuGcajzvolw89Gh1qcHw03fhnU4qr/gp9aD5wTnOjhhWhDiBWw
	 pe6LwXIfR1IGRrwXVoYCwq/IC8AQm1SStYU8CGddTH/VoEvk8j7k/QWQTFSC+dVNobeWE
	 fvCuDfwr32z/Cnc4oKJIohgbNXC4nBbWAvUYVDEW7tLOs23ga6bYcOqApdo/rSOFVMRLj
	 t43KMltqa/IGz2u5dpmiHUy3kV6KNg2/++xisrr8Evot5P4jeeUdlo+CTdT1WVOzyVz6G
	 210+r3tLzv6oNZGNNh4+/Kj1cGyqfZxgMFRDR1nTo/oKbIIWRse0x+gEhIbg5MqDCxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HW3pqqD/t1QyhAlXbjMQdzevyw7KfWoeCucxAZ4RJJo=;
	b=BaT7hPmVOiJQjJCeR2zW9XOcL5aFe4w7nbO0JC/pMwaB7rxqG9guFsSEHPJtlJ/YqSho
	 vJx79T7iLz3IsrxRX4HWoMQVSP5yYa9kSbE4RSzdLvMyBcMdIow1Joll7nzT+FeCILvAI
	 cXbcURIQdS0EAfeqm2VVAxdaYgAQxF5qRAnQp0iG8LejZ9L4Yc9pqjF+yXPLqpo0thVEE
	 AaWHDbIFmUGkNtKjAAIX5EusyLnPp41UnvKtIc21tXtJm0Ja1YLgrBNsoT9XpY2OF7lMs
	 RBbTYBHscvCmG0dnCIrfQRQchotqpG1+KuRhcxh4Xo/PArfXH2RYgekU0u4z3CdlN8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698720;
	bh=HW3pqqD/t1QyhAlXbjMQdzevyw7KfWoeCucxAZ4RJJo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6uuPFxfCYrUXFRvo+D4EEopO0rmWxmh8Tlijdbzu/M7HCsAA+aZ3W9GxTLHdLhIx
	 vHkhtxQ/VieoZzZBbmY/3iiD2IIF6VmyAclOKmbFZNYy7idmpgALdjriRKUgp/PJtw
	 YkqfGexV4/BPLNLkYPyNLuO0fe8nW9WvP4qNhFLuoHBPKPs2MXnsCDGAU/O1Wnja9B
	 V1fbzwhIwO+dDl1wMw8rEdpUGNzHOft6kcUFZWjLZS/Km2PKpV21kiSZvQKMCB8TyB
	 SmeJ+TEIjY0RS5WCh79teFBzgebhggtKZJXpbWZg+zkwHG9MwDV+rHALOZ0Ii0D3dW
	 A7oykVekEyVtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67C3C409A3;
	Thu, 26 Nov 2026 13:12:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23AC22DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15483404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tOci9mcy2Trd for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:11:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 18CFC404DC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MVnWIuwp
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18CFC404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:11:57 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso49987985e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795698715; x=1796303515;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HW3pqqD/t1QyhAlXbjMQdzevyw7KfWoeCucxAZ4RJJo=;
 b=MVnWIuwpdBGDwFJ4DPIAf2hQoyfwtBoDh1hZi034Sd+lsNcPxtsp8EIJuQpG2dfCQX
 SUHZOT5SLOZ0Z2sLOlfhf035qpUqiDQT1pHUWHLJ5mqDaOJuGpQb2R1hsT5Q9115xmmL
 Ff/1OyaIBd25RsRAKDgg0R9RMhyUyVgbeu8gFN8r1qZsnkhbcWdY3KIT6d9IFtlfNOAD
 /HIN0yUcm2xcZb2BjoszUikNnySzl1uh0sw7KJKwbNcpXpPkAxkHKSKWwlYoRMfnfhcp
 sLHjTMUNstVFfVw5ck19kPIjh6JHdyl9AlmWLHRge5LINfhsnRlnvMSJiqiTyU8wx48y
 SB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795698715; x=1796303515;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HW3pqqD/t1QyhAlXbjMQdzevyw7KfWoeCucxAZ4RJJo=;
 b=yurkh6PpW7iSLf/XuyM4gqQuxiMkkbCy93NGlT80qHtawLNxHwrxSMoMqTpInUCzuN
 F2UGoCiA2U2yGTgqOiy/VneOfZBCIaQ4Wy8pgyCGnT6bFPdR1CZd0E+9dp0GmfHh78OK
 cvaM6PIhW9B9TbCXi/gRrXMhJZ1ADg9mJ9mu/JgZxztIfcYlenJ25Lunvvrft233WOjG
 BJT4OZgv47xptVnG889KKfHcy5iZo/QbpRkbI9f0Ohfj7TmJGWFaNY99hlGNCh0pciCy
 G/mocZgfNnVmOZLTAJrF68qa2Rom/eU2xOMmw+aOBMSj+fISE7TrS9+0fOCHQI+zffUp
 E3cA==
X-Gm-Message-State: APuU4Z/IrHI9P3f/x+l5IpAbnLOC+f3NnLTOTg0jzo2HLQ7fIHKJzbkc
 Bo1jnxAaErc/7k5VY6VpXG0WrndqBpecbtZY3exYbUvcvzxG1+kdr4xbG43hzaaLelw=
X-Gm-Gg: AZFdTZeBi9sgGmp64HH+XZPMj8ElveHoHwnBvOKoNW/xE5Lp35eE6p5s1UZ1kMTQFnk
 +eam4h0I1wDsc5iYvE+46z9VL9wawOOhDSQLB8frtmse6sAojKEPLW73rRRsJTdzjXrc71uW4Zu
 BEijq/qAdCB5kXf9+ChA5C0DCU2qVaVnovt7g51WSzw3liQKWY+DUDSTpmWdKY9EOqhOS4GHr1k
 Avo45rplpMX3Ap4jVLOhdDy02PvHtX42GOipNtRAwRlZ0MnTBYNiE9at42uQmF3XfYxTkoUkPlx
 GMoGFuaHFS+I9goufcq2684C7e2md7gwrUaHM5svZV+DfbR0Ke1Yts5CHpYzbwUbYUDFPBkQCt1
 3Tp/ZcoaPfrByh9IgPc11tfF8gTOem1F/7GhviocZA1jLvFKpWplKW4brrBj1H40xxEks/D7Xmh
 Vv5k+Fy4U43/AqqR3dITZbbk1fs9S/y6IKBrXGEXyzZnXxhwnW+ILIi+XnqaQKepZp2bZtzIzF3
 /Gez9BNSsX5ACBSmoWuFCOgV4GOBM1anyO41DCMA2Ae5XQ50eZk1NBKyCECIGQEDBaaI1RvU1MH
 yE5/nlZTHYCMIXOUW3HN0ix7AZoy1mgOnnZKP0IXYav8/fTucVM=
X-Received: by 2002:a05:600c:b8a:b0:4bb:7007:4a5a with SMTP id
 5b1f17b1804b1-4bb88817772mr435408995e9.23.1795698715507; 
 Thu, 26 Nov 2026 05:11:55 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm521422445e9.2.2026.11.26.05.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 05:11:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mmc: spacemit: k3: Add compatible string
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261121-05-spacemit-k3-sdhci-v1-1-0c9eff3d6b71@kernel.org>
References: <20261121-05-spacemit-k3-sdhci-v1-1-0c9eff3d6b71@kernel.org>
Date: Thu, 26 Nov 2026 14:11:52 +0100
Message-Id: <179569871260.2402123.15029160949676379277.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795698714; l=1111;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=b52GzfyfZ/mnp+urPPY/XWwXhcAmnCFSs4XyCHjHorU=;
 b=A4Xn0t2hRSADu5TT13RALiTuEP6it4swnIRz/5N5ut4ChLqYxNGcilJ0AZJrCASCvyshAgEvK
 OwyriWyWwZaBM8s9yNI23ra3cYovhnVRkP41JHTtN2GQRiwCM9iZIoC
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Sat, 21 Nov 2026 00:14:23 +0000, Yixun Lan <dlan@kernel.org> wrote:

Hi Yixun,

> Add compatible string for SpacemiT K3 SoC to enable support for
> the SDHCI controller which necessary for bring up eMMC and SdCard.

Nit, this should read "which is necessary to bring up eMMC and SD
card".

>
>
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index fdedb9a301a1..35f6c0a7cd7c 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -660,6 +660,7 @@ static int spacemit_sdhci_bind(struct udevice *dev)
>  
>  static const struct udevice_id spacemit_sdhci_ids[] = {
>  	{ .compatible = "spacemit,k1-sdhci" },
> +	{ .compatible = "spacemit,k3-sdhci" },

spacemit_k3_defconfig does not enable MMC nor
CONFIG_MMC_SDHCI_SPACEMIT yet, and only the CoM260 IFX DT enables
sdhci0, so this cannot be exercised on a Pico-ITX with the default
config. Do you plan a follow-up enabling it in the defconfig?

Thanks,
Guillaume

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
