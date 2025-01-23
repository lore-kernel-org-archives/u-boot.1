Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D01AC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 23:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE4F807F1;
	Fri, 24 Jan 2025 00:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PrmU2ac9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094DD807E4; Fri, 24 Jan 2025 00:14:10 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7775803B5
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 00:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4679eacf2c5so14742801cf.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737674047; x=1738278847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFtDbAimqY/X5ueZQ4Pbf0NbTiDe6yYGjgaXeYcTUD4=;
 b=PrmU2ac9FkcPCvA9Kkso+O+mQtuu+kaZzj1aOzkzdKPzMoJdFwIWnYjrvl73dU848x
 raU6yFjKbZvrYzLweTKdn7fqqYPRPRmse6kXaGD0EgcjOmiA9e2dCYxBwm4O0TS9Qtt1
 zmtHlCEwE0wCC4W8pS6iwQjAzuQTfd1J1i7dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737674047; x=1738278847;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFtDbAimqY/X5ueZQ4Pbf0NbTiDe6yYGjgaXeYcTUD4=;
 b=eUQmZ+oSc7J1IuSFswqeiG2NBy1+5RnRAwS3AGiXiP6oDQpofI9JYxnh1aQTNUOdRA
 jpwl7iF/HoXmYdxvRjjoJqOBHPWEUCFDjezLTAMJzdFqJVCTb2CFOOtYpSvqf7I1BVsd
 mqaDLL6CA+62Mb0spiif8TPvasjZ2hgPFeajq331L/o9enuakTMdm3k+9bquldW4V8EI
 k7tZpu9X1iCnA311k3W/gwcc5PngO52XvfyxHGOw+WkFSVg4DnDZhvv3FZquVdVOt5zR
 eb6lA2hQ7w3J18tzF52sJoeZ8FBGkaufQuL9Ez55h/pcNcfPBvxDVm28gwiWkhJQJjRs
 iasQ==
X-Gm-Message-State: AOJu0Yzu1zaQbAWH9lG9etsH1RdggMHeXC185xf76aH0quwEPmmN4lkD
 niQm9KlulJOx8ps2omlqyUbYysHwrZ0G8GeFkwgg7tpRZ8usXMk/80D+NuobTxY=
X-Gm-Gg: ASbGncsAR2g6k0ub0gvaZn0aGSCjaucRa+7gLA2Bsjrp3EtTS3gDAqkiMJNvEDtZKAV
 oz03iLnQAoYVgS/2paldKxfPk5qqvJnQWe9Ovd9E1vYr15JeFXsZ6CRIsJCAkU9hu7dgXbekmQE
 O7ejuzkCrd9wTU3mseyAqIvLq5CRcG39garHBuFVzlePD28z4PnSc9clca1hnoBW05Pd2mvxjgb
 eh6nsqIM1Fpg6yB5ZJVaK4ZVrFr9WjO0Zce71dPf6BdVApqsfoLDTG1nA3NArYBH5iDQybEMjrk
 RYw=
X-Google-Smtp-Source: AGHT+IE3PZNLkZlh612T3RMO3KgSmWw/TdkMX47FLbTa/o7l9+a2R9SOQ/yFwUKsDU7UzH64VgLCkQ==
X-Received: by 2002:a05:622a:144e:b0:467:6e45:218d with SMTP id
 d75a77b69052e-46e12a25235mr418619061cf.3.1737674046783; 
 Thu, 23 Jan 2025 15:14:06 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b89811sm3753441cf.77.2025.01.23.15.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 15:14:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: sjg@chromium.org, d-gole@ti.com, d.schultz@phytec.de
In-Reply-To: <20250115094129.702272-1-w.egorov@phytec.de>
References: <20250115094129.702272-1-w.egorov@phytec.de>
Subject: Re: [PATCH] board: phytec: phycore-am62x: Add DDR size fixups if
 ECC is enabled
Message-Id: <173767404550.3025404.1126269216296091650.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 17:14:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 15 Jan 2025 10:41:29 +0100, Wadim Egorov wrote:

> With commit 22ce56a3ebdb ("ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc()
> to solve 'calculations restricted to 32 bits' issue") we need to provide the
> detected RAM size in the device tree node prio to K3 DDRSS driver probe.
> This is done by calling fdt_fixup_memory_banks() in do_board_detect().
> 
> After probing, call into k3-ddrss driver to fixup device tree and resize
> the available amount of DDR if ECC is enabled.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


