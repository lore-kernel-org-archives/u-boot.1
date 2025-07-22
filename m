Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C0BC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B596683445;
	Tue, 22 Jul 2025 21:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZDUNMMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700B2834A3; Tue, 22 Jul 2025 21:46:15 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52770833EC
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73e810dc01aso2777400a34.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213572; x=1753818372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NcHsZnqGmX6eY1ng++5UdKG1uD7egCqj0/q0k2fKRdE=;
 b=uZDUNMMoVtOLGmWc4jSb8jr+pTqatToHnp+c+o7t/daC9fFIi6ry2WtQ47wgrfs0am
 ulwf3zh5EEm4Bz1DFqYuigiKq/wTA+qRxP/eb2LleyA4W1fzvnSkfAhe5dZM1wby2Vcd
 ALjO/VRCQDb5EN8RftPxPo+XAOcOREMETLKbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213572; x=1753818372;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NcHsZnqGmX6eY1ng++5UdKG1uD7egCqj0/q0k2fKRdE=;
 b=RI7rSH3kvdVSFORFIzSDb1WRPkzqTfDYlxSWsIqRlsv6a0EPipRU527ebEgCSQLhF9
 WUA+QTeH1W/0xzRgDbRLsm7A2xuY1ftV2ACkn/fQ6ynKb739naXs3slTfa+IVk55VNr0
 fE+WBww6b5UrviJebSP7pXuU11BvhMiMBlHDSSf71Blg1JCIxLce9ed0JwU2x0dV1th5
 skQcUO97Itj74fUaxP8SjTawkQFq7drjaBnsQcxnA2MUmBZe5glXhMn4UCZtY4/P1fAK
 WJxYcpB/3x+64Az+DqJakWpXRfTHgNSSzX/E0u4gORbMa2vMwU049Pgfs1kcjWFnrieu
 scFQ==
X-Gm-Message-State: AOJu0YzSm+Sevutuv2jMQVO8vbLiX1UAHc2sMjopryHx8esUjMWh+hk5
 mkFBud2GNSqdJ6JQWFZ7wr7WankDaP8FWIQtHyrso9xxSoJlDrb0j+UPxbUhSVj0QVk=
X-Gm-Gg: ASbGnctYpter879bRwz+VUcy1/wFRdz1IQ1G7rXVc7GPpD9J1lsFpd/XHU8IhoiG3H9
 QyUhEKPwTp9vV9LB0TLfD9lXNpXJw6X8bonerm9sp0S8miCvnIlRQR9zFBIfFzGG42hc4GTDcoq
 /CjWcSHfEmbANfQ015bgCXAhBQA3F/dcOr0pTx1JSNVpoGV5NVKdPVeIZZ8d5X+oXck9jLNLR2K
 v0uxVMyrqnmSpnEsvQtUn3lfqWqhuUIVYH+JOoymnnLyHnocLoCrEHfHV7KoSZN/jwdubtqkOee
 jHwFzMt/XuYJN4u13uNhLDnkv+aKd+P8SU7xUDnoQ+8mDSzoGf41PrhbPzfKK1u4q4d7TWFV3D1
 JNcUk8ixamuUR3n2i5GQTNW5J6VhFy3vndQgkeVoe1KWpJMaXDXLDA9eQoEoZfT8hNg==
X-Google-Smtp-Source: AGHT+IHAUtzqSAwdW+95RSvPpmmX34azkjehciR9ImAPMmr1aeZeRwOG6FgtaEv8r5o2O03pUjiLog==
X-Received: by 2002:a05:6830:8218:b0:73e:b9a7:3328 with SMTP id
 46e09a7af769-740889a705fmr310608a34.19.1753213572033; 
 Tue, 22 Jul 2025 12:46:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: mkorpershoek@kernel.org, jerome.forissier@linaro.org, 
 patrice.chotard@foss.st.com, ilias.apalodimas@linaro.org, 
 andre.przywara@arm.com, casey.connolly@linaro.org, mwalle@kernel.org
In-Reply-To: <20250717135854.25126-1-ariel.dalessandro@collabora.com>
References: <20250717135854.25126-1-ariel.dalessandro@collabora.com>
Subject: Re: [PATCH v3] drivers: fastboot: Add support for SPI flash memory
Message-Id: <175321357090.77222.279502539276739617.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:10 -0600
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

On Thu, 17 Jul 2025 10:58:54 -0300, Ariel D'Alessandro wrote:

> Fastboot currently supports MMC and NAND flash devices. Similarly,
> extend the support to SPI flash memories.
> 
> Note that in this initial implementation, partitions on the device are
> not supported yet, but raw partitions can be set in U-Boot environment.
> 
> To define a raw partition descriptor, add an environment variable
> similar to the MMC case:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] drivers: fastboot: Add support for SPI flash memory
      commit: afca60620ad7958fbee2d5518de0383483c82ced
-- 
Tom


