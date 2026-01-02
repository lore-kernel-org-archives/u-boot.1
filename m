Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA53FA3751
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F375842E1;
	Sat,  3 Jan 2026 00:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IwVFuao2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAF3842CE; Sat,  3 Jan 2026 00:23:53 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C16683C29
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso9780672fac.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396230; x=1768001030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P68WPCDUmRFmQHki1+NqhL4HHdduOW136n4Qp2GF0P8=;
 b=IwVFuao2iy3pXO5UbwPcJk2MB7x6Q2i8sup+/iTwLDUV+iYpD+9EFjT7zm0eCZr/cO
 Pt33l+/zX8O2gDlv01wMA7DaCj7FgEEo+Fd4xR2dt4EAE28sotFSDAsHVZ8n8dlS2C/Y
 SzvRG+cFfsUSDRMDSWFGHtOmFWpR/EuLpCdsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396230; x=1768001030;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P68WPCDUmRFmQHki1+NqhL4HHdduOW136n4Qp2GF0P8=;
 b=iU8VcrgWQfmdUs9ya6PcheVmzxrxB29GWkoqaR8BMCcnR3Lu6QR8RoILCvEQP9klZe
 hzRxZO7vJUjv50jbi2+4PvWsNsO1s5qia0+mkM74pZNeXRdNqqMH7RVhjuAtARWdsHzr
 HToR/+awuQtd2UzpJn/aTGNYjDff4CLqjHCVtMVOHtDaCdjVa3u4gbSxD6h0DWhMwnec
 Py0R3/J2dnlonLfAPWxyOyoaj+vWudgWx63COIAubgo1RgkaqqQ6K5zx+AgJ7jfwjjCA
 NMqGccEMf1iFn37NXRyvCG4SHqb9wsrcEkcxRdU+05QgzbKgzyTDlWaiyqvW9HpRm6Rd
 WOnQ==
X-Gm-Message-State: AOJu0YytrgXORs7jTUXlVAaMG4RQkw4ONg92jWCgLSU/pivylwv5RZ2E
 YFYCfEZWs7MfY1nE3QjX431iCpuJlN9r5f2WkXMvPBRPsGxbp2jI5TYosTW/IpaBzMA=
X-Gm-Gg: AY/fxX6WBEps5xGeUf+8kmbRymU/jHLK8oTZKtxq3altn9Mru6XoJnlR6Fu/FJZfLYc
 ahdSncyGe3ezudOqPEArXUjKsd9XzNaJ7fGIKun/9nOjCdU/IJy89TRgl7OB28zyIyrHfHQ8tc4
 4LKNiaMFClFCppPx6UO9OiSB1DJ2TqNQthvNn270WBvNyh9d0j7jFiOPrxNTczTNdzR3cNfuLc6
 R6Ag2NFAXOz2aZBGpPMy/ruojOSrCwU06Iou7b8ixa4oGxxkoMybdpkSh0NbEv1kzJJda3XaAi8
 LWfCoCvfTfz3tSW5ZPxsDHnUfQ308oWDIEOdSpYEZng5tdwwsqjvXmszN3Dugyni6aOp/GFgq7q
 RsdwuivApXuaTg5k1yruin0lSeHEJhEMPj95Gtj5MiIClgNYCR7vNrXmS3obFNXDjtfkPm9AK+a
 dd4JlYiITDH9b72/TvobXkSFOYm7oFshRzN9j6hUdiWK74B8xo0yvbDlUwSvVpNgaEimkjDGi0a
 sOmTmy0uwNJGQ1IEh/cLvGJ5odjOo/SV+PsTg==
X-Google-Smtp-Source: AGHT+IFe3qR9M2zdxDvvhBDhrPBTmFtn/h6wqQ3EqibBQG3j3/4zglcH2OQKiNb/aYzQk12LamJ2GQ==
X-Received: by 2002:a05:6871:2015:b0:3d2:a9e:f03c with SMTP id
 586e51a60fabf-3fda5293319mr20975865fac.26.1767396229871; 
 Fri, 02 Jan 2026 15:23:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20251217200313.755200-1-marek.vasut+renesas@mailbox.org>
References: <20251217200313.755200-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] configs: sandbox: Select environment in FAT FS support
Message-Id: <176739622893.296893.6558202372475694539.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:48 -0600
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

On Wed, 17 Dec 2025 21:02:50 +0100, Marek Vasut wrote:

> Commit 2a38e712652f ("sandbox: add FAT to the list of usable env drivers")
> made environment storage in FAT available on sandbox, but did not enable
> the matching ENV_IS_IN_FAT in sandbox configs. This leads to environment
> driver lookup failure when env in non-EXT4 is selected using 'env select':
> 
> "
> env_driver_lookup: No environment driver for location 3
> priority not found
> "
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: sandbox: Select environment in FAT FS support
      commit: c55221f1a274886260a7ecdf9da9884bb49f1f38
-- 
Tom


