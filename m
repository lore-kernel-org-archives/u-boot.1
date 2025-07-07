Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D25C71130
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 19:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1DE8319F;
	Mon,  7 Jul 2025 21:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V74roS4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE39C831A4; Mon,  7 Jul 2025 21:58:25 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3C28318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 21:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2f77591f208so1808645fac.0
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751918302; x=1752523102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJQt2ORoUjo0m+0DCjUYu/PZ7ZqPO6kmv6JvUj6/fqM=;
 b=V74roS4odBcX/ZQQ+eaS+8JcRM5L74YetVAktuGnKLIC+a3vrUifNY4d61CO9KkaEc
 pxFmbig/cbAvJNRcwdi00Mvm/8mO4rrh+QWQccwvCtiKZGjk3K4aK2ZvgA18ttmVC+ee
 49KiZHe4sc+/lil6Fd/WWJ+ZY9LhcML6OgtKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918302; x=1752523102;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJQt2ORoUjo0m+0DCjUYu/PZ7ZqPO6kmv6JvUj6/fqM=;
 b=WVtATK9LmvM22vIHS/gt12oi6/2QhYYdxK7CY3eIS9l2OgDn5sWzx7Wn2oHj0QX8HA
 qGNt1qm6YYhDDbm6xRe1gJex7MJzizK0IPxSdR068PbEwnQqFflulGyJD89atXUS2CBf
 q+uv51fNPzSrgfV3S8GNs0kIwEbfzSpaBy3Ar8gDDFaWOoag6/plTEg2Mz1POjXbPFfo
 3g39r+G+pTY+02RQzL84FWVxHitbmxOEgJ8hrQ9tSNLA3YRq6fy4riqRBBFFSpgl1xqQ
 GSFyEEttGlirukpRaWTI0I14zeXus4gXru/3tghXzeJzAFNEAiv+yfWoJy8fIywl2Zpz
 KzAw==
X-Gm-Message-State: AOJu0Yyo7Lwl9pGKgr4wyuMErq0Ny/gqLHJBvyMmoVTu8IZ5I/S0aO8y
 alhTkCwWQAwzNknmj/eaqCUypf11H4b/lftUCEwxw9XqT9AjutjTZSru92Yi9knQY/vl0Y9w57g
 e+IyNNr4=
X-Gm-Gg: ASbGncvdCDdAhDqeusylKtIUQSzTldzbIwUBIctlvBRmyZNebHxKZgc/Wf7EAm+ayQ6
 mKjIyoanotcmwlyxYI/a2lMhjiDI4Nf9gwa4IyZB5Qu2S78tVoA1n2ysS3kTxO9+KBh8k3TX7w6
 9YpcK5d1AaZmnksp52rr9Nn00hrcR+wxUaaUVy1/hU0btQHZA0H002Y1CN5pVaqNOYf/RFWsU/d
 2aKme7Q2jrtqAlEaLKKCNI97BtazwH9/nW7lDsq2d0sUV+jz6n3daZpla7CuostNDSmdEUH0pes
 s3VgeJJ3ok87V7WSuXI7dd8Bbt/5SrqGJ7iM73Uc5QJHoHNT8stFCahEPDJ5rXiQT+Wr+ocNZOA
 K8/aFgP+8j8ezv20qpCiWAs0eGfM0hA==
X-Google-Smtp-Source: AGHT+IE92sx3BcG81FW/v9Cqj411vCvVTm+VEghEODg1u0SxF/eyZuu+os5yGAWJnobweV8bs5QXTg==
X-Received: by 2002:a05:6871:741f:b0:2da:b91c:919b with SMTP id
 586e51a60fabf-2fb6fa00e4dmr37566fac.0.1751918302104; 
 Mon, 07 Jul 2025 12:58:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7901a6c1bsm2395984fac.26.2025.07.07.12.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 12:58:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <david@lechnology.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250704-b4-configs-legoev3-use-thumb-instructions-v2-1-efb85ee1a7a5@lechnology.com>
References: <20250704-b4-configs-legoev3-use-thumb-instructions-v2-1-efb85ee1a7a5@lechnology.com>
Subject: Re: [PATCH v2] configs: legoev3: adjust to reduce binary size
Message-Id: <175191830139.4126370.12675336348633143495.b4-ty@konsulko.com>
Date: Mon, 07 Jul 2025 13:58:21 -0600
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

On Fri, 04 Jul 2025 15:39:27 -0500, David Lechner wrote:

> Adjust legoev3_defconfig to reduce the binary output size.
> 
> As u-boot has bloated a bit over the years, the legoev3_defconfig can no
> longer build something that fits in the 256kB size limit of the EV3.
> This drops a few unused features, but the real difference-makers are
> enabling thumb instructions and using link time optimization to reduce
> the size.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: legoev3: adjust to reduce binary size
      commit: 15182ce25d5faa2d08bd08266a4d40fb5c2161fb
-- 
Tom


