Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F52CC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3728A883F2;
	Tue, 18 Jun 2024 16:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oLg3kEec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C36188363; Tue, 18 Jun 2024 16:53:27 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1994A882DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f971cb3c9cso3086450a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722404; x=1719327204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byWyZlwXBjG7HNbWuL1FqmxWEaZ7uunP1r5D0HUyAjI=;
 b=oLg3kEec7A9QeeVinMRyy7QVc4b07CJ92U4GVzjHxoOazxgYcR0UlWroejO2ijGvAO
 siCAI6r96z2mpwTqmeH8pDZaA8ec7zV0WAqL4vSbhoCsLAOlaIRiwflcd89mr+NYX1tS
 jTlQHfbNsAiWPnYrfW+Wf5rSVGOAc4KorV4Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722404; x=1719327204;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byWyZlwXBjG7HNbWuL1FqmxWEaZ7uunP1r5D0HUyAjI=;
 b=j+tfUUEtePli3N/TJVL8JMtEZJzNYekLlizb7tDTZFyXieqrGjhrZkMFSRxO1eGU8o
 0CtDzpTDY874rsr9sie1KjKsow7m4adW9ff9O1q22HWjSDalOAa2Z1cLyUgw+sdNOiNr
 q/NrX/s/dlv/SMbqRdz/PwJGR/d3UDFIOC8q12nzbw5exKPbgAcePLQhe1HwIBkwiBRI
 oEP86ZGFDoicECDNaZmm4joE1ZqYY5Mb214WF09aPFQHZxSNdA3R4h3OBmUUdA5MT7wq
 FXbgCdtjpWaReQ10HifQjXw/ovWWF8cz9lPy7Y4MxSPg9tBaMQTy9DEfi4PSedxdHWhA
 muCQ==
X-Gm-Message-State: AOJu0YzSTorl1J+W5289VmrOlRullp2hfbN9FVzV/2HQrJ/ArbTxvl7S
 vZNhGz7uFh2jPHz8FyHMo99o6/0TVqiKmmauBovKBbFoQga1KA9/wpGyI3Apjw+CYvA8qerjq/j
 CrU8CVA==
X-Google-Smtp-Source: AGHT+IFAP5JSPuQzC/LOg8iBo1ePH2coUwWQdcHQQAVS/2BEtn6S8vAyNLgsmqc3Iy/PPgvn3jUsMw==
X-Received: by 2002:a05:6870:2252:b0:25a:6d14:f84a with SMTP id
 586e51a60fabf-25a6d14f8d0mr629162fac.42.1718722403896; 
 Tue, 18 Jun 2024 07:53:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, Vibhore Vardhan <vibhore@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>
In-Reply-To: <20240607085640.2900395-1-d-gole@ti.com>
References: <20240607085640.2900395-1-d-gole@ti.com>
Subject: Re: [PATCH 0/2] binman: am62a/62p: add support for signing
 TIFSStub
Message-Id: <171872240326.3307069.17243775213606021010.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 07 Jun 2024 14:26:39 +0530, Dhruva Gole wrote:

> Add support for signing of TIFSSTUB images for HSSE, HSFS and GP devices
> and include them in tispl.bin and tispl.bin_unsigned in AM62A.
> 
> AM62P doesn't have any GP support, hence not applicable.
> 
> These changes are required for Low Power Mode features to work on these
> SoCs as this TIFS Stub gets used in the Low Power Exit sequences.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


