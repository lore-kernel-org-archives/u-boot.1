Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD55C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE83381ECD;
	Mon, 31 Mar 2025 15:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RxTk2eEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093D381E47; Mon, 31 Mar 2025 15:46:25 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF67581E47
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72a4793d4e2so2870905a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428781; x=1744033581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6MLC3qbaUwRdRAnnth8VeZUM+w01uIF6wGohx7YLbE=;
 b=RxTk2eEJGYWIyvNqk/6R0vSGu4KJLZMgWKigxdHiNEcnmtji658CM4F1e/sfJgk6nN
 F0VbyuLmZSS55y/WCdos2gab0V592tCbXGaTQbKc0bK+M861PiczXrvN/OErVsKcoFw5
 TB401NQU3MgB9a1l83korVcffk0u+fOCxXEWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428781; x=1744033581;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6MLC3qbaUwRdRAnnth8VeZUM+w01uIF6wGohx7YLbE=;
 b=ExIk57P1+nFOIY++xrfYy04j9WW0x8rLUV1wdnHXCKBBdiRkV8ua76GdrJ9BeAT8Ru
 8zRtNeAk0A3xnZ7sDDCjdTg2pmIkrKBk7ZVNUpkqjQqFAaG0CNh7OLz9fpLnEyGTOXOa
 q8v2IxlS4sfElRgRu0KaWxoxANMYeHMz97FXCdJBe1sBsNXeSTXqdNyeHkYTMUYBVeen
 XwY1Mpqf8AkRt2yhYL983XbIdgaCSQ7Y0Wtju5zU64HC7CjeewiF644t5jK6Y/TxqzCg
 2Go26AO6EJjVrxxNF3BmiEuemSPuPPT45dw3DHt4+PeYCy4/OQBLWup9DTKZWxWS9E60
 Uopw==
X-Gm-Message-State: AOJu0Yz7EnVJwNEmo4xLur8+ZKCadP35AdnDcbRORaz9qlT7iBnSUJ4d
 Nh5/L4jeFChlT3wl262huJBu1/XCQAT4OYD8z66OocPMyK/0sBhPjbHD4wcYt8c=
X-Gm-Gg: ASbGncuWsW9p0CRV9UvyU78RPuTf9aWtqmXOIORzWcaP84wkUymp/fp0R0diFN4JeNt
 jy1hc7K4W6d3UatjanvXPhENWVDmCxNyVQTbbgOEhoL6upcMA0JHipZ7JawCvmsKaA2bmNHDw33
 m0qrHd3MizLmy11dNY7pwSn6FLkq9D/3epzV5EEVb1AAo1k3glWY6NQVKiZm6BrfP1I83/xGst3
 OPe6nVFpk5HxfAFteeyahCYD4/npSxZs4XzH5oPL4cD0tKa93g1fAgcpOVv3mNF6D5GRF3xUO3i
 gyk8uH2EdsFmpMe4cOVnps0izBReZwFcz9CxoI9GYYILlaQcmupEdAgAjBrjatsckmTWSav6hth
 qNN/h
X-Google-Smtp-Source: AGHT+IEzl660xF3ku1ukYQYULQLgqsWC/ZDc0QQtzMYBPGukrmuECVyC30YDSCedTBSaQgjFTxAlJA==
X-Received: by 2002:a05:6830:6011:b0:72b:93c9:41a6 with SMTP id
 46e09a7af769-72c6380e7cemr6210723a34.20.1743428780710; 
 Mon, 31 Mar 2025 06:46:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, bb@ti.com, vigneshr@ti.com, 
 Vishal Mahaveer <vishalm@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
In-Reply-To: <20250310220257.25414-1-vishalm@ti.com>
References: <20250310220257.25414-1-vishalm@ti.com>
Subject: Re: [PATCH] board: ti: am62px: rm-cfg: Add support for HC BCDMA
Message-Id: <174342877954.1318045.1386479206362291752.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:19 -0600
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

On Mon, 10 Mar 2025 17:02:56 -0500, Vishal Mahaveer wrote:

> The first 4 block copy channels and rings on AM62P support
> High Capacity Block Copy. These channels have approximately
> 3x improvement over the normal Block copy channels when doing
> DDR-to-DDR copy.
> 
> Currently, during allocation these channels do not have a
> separate interface and are allocated with normal BCDMA channels.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: am62px: rm-cfg: Add support for HC BCDMA
      commit: db8bcdb00af59e4a88d72f7ce115200d554c8d2d
-- 
Tom


