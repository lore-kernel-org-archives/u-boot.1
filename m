Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D75C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4380786F56;
	Thu, 16 Nov 2023 14:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eTccVs40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D223D87206; Thu, 16 Nov 2023 14:30:26 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB88F8615A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b2ec9a79bdso506082b6e.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700141415; x=1700746215; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Mk3TYU4xjg3D4rYG0V01u2E0d+CoYHTvrk7TeZnr/O8=;
 b=eTccVs40OU+zdvL45XhQ+Dfkyh34Fwrs4DPrAQvrs4btfkMAL68MsOptR2QeI4lGkh
 kagIb5j9NgOL3pR7XJjAVdliLhIvh4aOqavoFvIDGy2e2mj21Z8i28tXC5P63FTnl6Dk
 NHNbFfO4YVenSxuwxw2ncklj23uQrZtOSb5OgP2/ymyvORXYBZcGHgMbGpu+FX6BzAva
 W4+RkO9FgmVPnjPrCRIiYE4lYKtXefJHPDUltZrh3UNX5d2radihkK43AmJvpzALAggO
 pAeltnJQPfF7SU4xM0nId2p50epSYm9hEaLS7FSspiDIlt8/JuV1xGuahrE2Q4NpQIJc
 +fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700141415; x=1700746215;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mk3TYU4xjg3D4rYG0V01u2E0d+CoYHTvrk7TeZnr/O8=;
 b=HHahLKnztPKzPFHR18UnjHMRLIkDssSSxSYWiugqcTfOuEk/ywJyxaYMl7I7EBkJRT
 rnZ6mvF5YN09GvCaU9y0EafjKIUqjqBwh0qY+A8ohkcEhONUes85hWy+pnIqv8QZGxfN
 3B9HPaPv02GSAUmpsQ07WfGWpW45jaBFusfnXIZ2hx6l1QHSgYm99gZdYGYCk5zCKmol
 DtNgIg+VK30rvbFIrOlIptMqsNVw/SvuPFsbXTRKtN0hgr9NjokMULFJfQV8MQRS4/mE
 LRWS1gwtTjcj4Go32N5rDV3isxpWcNp/w+Q3Y9AvIL2Sm7Qz93u46Nhp7rSAxgrPXCBD
 EJlA==
X-Gm-Message-State: AOJu0YzUAB1CHO/t2n9oZtDgMHMP3ZoHoJyJpG5I582Hq+XZPPrqwqK2
 MdqNdxW8dBfABNzEeSXUV4Vb8A==
X-Google-Smtp-Source: AGHT+IGVIjaQHTDvMr593uY3t3WN+LcRydy/xcSKPLQMbLPVV0JjIt4EFFwicxJXbp4f8HCRXP71Hg==
X-Received: by 2002:a05:6808:308a:b0:3a7:4509:ecc7 with SMTP id
 bl10-20020a056808308a00b003a74509ecc7mr22110336oib.16.1700141415298; 
 Thu, 16 Nov 2023 05:30:15 -0800 (PST)
Received: from ThinkPad-T490 ([2401:4900:57e3:f37f:7382:f75f:c0ae:4df7])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a63e054000000b0059d6f5196fasm2915554pgj.78.2023.11.16.05.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:30:14 -0800 (PST)
Message-ID: <c3062f81f12030eb786ef1d5aa25a10aea324761.camel@ventanamicro.com>
Subject: Re: [PATCH v2] drivers: pcie_xilinx: Fix "reg" not found error
From: mchitale@ventanamicro.com
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>, Puhan
 Zhou <puh4n.zhou@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>, Shengyu Qu
 <wiagn233@outlook.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Date: Thu, 16 Nov 2023 19:00:07 +0530
In-Reply-To: <d3933e18-9c33-474c-a69d-a15cfa36bdd8@amd.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
 <d3933e18-9c33-474c-a69d-a15cfa36bdd8@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Mon, 2023-11-13 at 10:12 +0100, Michal Simek wrote:
> one more thing here.
> 
> Subject of your next patch is
> [PATCH v2] pci: xilinx: Enable MMIO region
> and here you are using drivers: pcie_xilinx:
> 
> Please use one if you target the same code.
> I prefer "pci: xilinx:" style.
Ok.
> 
> Thanks,
> Michal
> 
> 

