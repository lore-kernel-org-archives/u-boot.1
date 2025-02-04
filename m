Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76048C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460D8807A8;
	Tue,  4 Feb 2025 20:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t/gGSNm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DBD806DC; Tue,  4 Feb 2025 20:43:24 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFB780040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ebb1652729so3348290b6e.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698201; x=1739303001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkhhEBf5XdvYlgdvXzfiFg5RYsj/HlzLaVdujFzSnFo=;
 b=t/gGSNm5n5IhXZZOE1E2rnJG2EQfz6s44+ntQqtOAooCgNrqJDV1sO7QTLfDhuqtEu
 fFLHqE3/K1n00jBNBfQV05/+pEg5Z0KYY27dNQ6Ir6aY917MVUWjTsVjNanrS/PahZkH
 ABVPv35qQgEou4CBFuO3ihVsATR2602fNloTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698201; x=1739303001;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkhhEBf5XdvYlgdvXzfiFg5RYsj/HlzLaVdujFzSnFo=;
 b=ZvQfZVUjFqlC5DNg04m4/30VpDZDssP+WOBAjWiooMsqpcgDa7bnC06xA6BsErWsTp
 +SIJvaHkU6Qd5DoehNUg+PdCmiygGD6YaoP/3zkHv4imftBtjuc7ZZ8WM9nA7aH2+ZQA
 AnA2Ie7Bw3/zDqHFToszPLoHxwnJ9SM6WqG00ICyS/u6VyntvTGNF9ULmIrsV/PwpHoX
 5hbevMy56G23gpCwET9O0Uju8hAwmlXBgb7rY6pbrciHd3xO0O3BTXnzGGCkTJTAsArZ
 i/VEAfy8b63jZhIuB43QCZnN9d6whMMJYjuv0UxfP1vFpNlyRv8l4BC732ni0t1rKrC3
 hzcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvYx0DFDNme1QWnw343p5LwVCViukrGSE9h9B6f0wf1PxoB85OagTT6TOUWmKeovI+I8FwFug=@lists.denx.de
X-Gm-Message-State: AOJu0YzcVG0qM3/8H3bvZL7yfZaRyrUOn3TaK80+W7dCRVRROZYqVW+C
 dRnB5lhQoFTESUDq4gdz1LI0jTgUkssZJMUCP9ESlm3VwMmj0eRxc+MtgAnvHas=
X-Gm-Gg: ASbGncuqj2s7X3rHjy0S3916IPl7VCTA2NqUVcBOxXlOoLpf9tfkxVLi0M06hPU9WRk
 VRh3MUPk5HEaJ0NoXMkorYW0VLVe0jSCs0hH84DtUBoj7yTkr42tClf1or1dTWNPf7qjzhlniuu
 qGcKgtw965MQZp9x77g+kFzVnBwOonlZV/vsq1Dlu72hoYsGNm4LV42o53WWmq1Njz/vmuf0oSX
 QVMgOW73XgyV12RGutXDNgYDv4bvi7NUkGZFHrkLND8zbHHu+zG0D8tvTmLR1ej+4KvjxClj8Mj
 JQbvsFaLlAIURg==
X-Google-Smtp-Source: AGHT+IG6jO2KOrVBb2q5pyHTHeZJR62lfYQqx/RadA7cFchqSadrVz/rjGx5y/W1UPxr23Gt32NRXA==
X-Received: by 2002:a05:6808:1a02:b0:3ec:d34f:4c82 with SMTP id
 5614622812f47-3f323a51c1cmr18601861b6e.16.1738698201081; 
 Tue, 04 Feb 2025 11:43:21 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Liya Huang <1425075683@qq.com>, u-boot@lists.denx.de
In-Reply-To: <20250127064936.43539-1-heinrich.schuchardt@canonical.com>
References: <20250127064936.43539-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] examples/api: improve determination of LOAD_ADDR
Message-Id: <173869820002.637016.3643052659813474981.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:20 -0600
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

On Mon, 27 Jan 2025 07:49:36 +0100, Heinrich Schuchardt wrote:

> The current load address for the 'demo' binary does not work for
> qemu_arm_defconfig.
> 
> The suitability of an address to load an ELF binary and run it does
> not only depend on the architecture but also on the memory layout of
> the board.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


