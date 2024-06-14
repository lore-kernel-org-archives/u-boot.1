Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50265C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECEB688A13;
	Fri, 14 Jun 2024 16:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i8WSBhC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62ED988A11; Fri, 14 Jun 2024 16:54:29 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DB388A06
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-250c0555a63so1105977fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376865; x=1718981665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIIWDZMqxrXnhwyhrLKnq5RjnyzANjVl4BIxp2RR3Eg=;
 b=i8WSBhC4kDYZ698sX/26iXSdiiJJj3OmvHGw+KD9CJ4Xn+djaMfTOgXdmWMtaAdHs8
 IV8f/z3uYqDyM6gbWtI415/pNXynQeMDCjiR58HU6sTxZujw1YGpindtNt9+DtQHbB6f
 VHMC/78L95PaDdYpNDOnUyf72x9VOl8yh78UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376865; x=1718981665;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIIWDZMqxrXnhwyhrLKnq5RjnyzANjVl4BIxp2RR3Eg=;
 b=UsxB8GA1Ub1X2eoGar/m1tNJJHgo3c4HPVh1tEeIpcnGyBKkLmQhbGkrazlvnWXeZn
 vZPmzil/8ZHZdYV0WaZ9fw8WAt/pNUSslQTqbvkyB37/cLdMA5U9yE4vBOtBd5gTlCxQ
 iDJPHMeTphjAs62M7cj5QQcnwXFe5tfxcHqeWlI0hOsQ+nGFN5z6gZRS7CbNbph7fExa
 mksfimUmx2h5CyiukWRIhhmXkaLhFdWmNAOIPvnNGNI/nfWdO+VyB139EpL1/cJEAoQj
 lDVYGOkE6IgLoi3ji6aj5lG9agB8qxXUn5UJp3E+C+54UaNG2eNnkNsQE+chYcW5wDuv
 sIjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoir9dPRwy5Y4K4uLTduXGqe0j/PdwRIUrATYHd+4gN5Rhn48PQfynsigDAUIRY7k73x6O5wzzbOwbx4jGJL1oWfN0pA==
X-Gm-Message-State: AOJu0YwIr9K/y5Dbx/QsVt/J+gY4AIZB69Z7rd0dB8dvf4/5IWXoD9KQ
 4SffLOpp+UmIognW8kp7tEBB3QOjNurGAKpkPUQXsNWuoR4/NjecxmdY6H8PVBY=
X-Google-Smtp-Source: AGHT+IE05FkTKkztWjch5FHnl1f4RFewj07TUUwGhxK0kWFobk2Nu7S3IUzjBSG1RhQtNCjo0zsz+g==
X-Received: by 2002:a05:6870:472c:b0:250:7a43:af02 with SMTP id
 586e51a60fabf-2584288ca96mr3021087fac.11.1718376865555; 
 Fri, 14 Jun 2024 07:54:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de, n-francis@ti.com
In-Reply-To: <20240531144636.288599-1-vigneshr@ti.com>
References: <20240531144636.288599-1-vigneshr@ti.com>
Subject: Re: [PATCH] spl: Kconfig: ARCH_K3: Set default
 SPL_STACK_R_MALLOC_SIMPLE_LEN for R5 build
Message-Id: <171837686474.2655592.6488526674347854919.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:24 -0600
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

On Fri, 31 May 2024 20:16:36 +0530, Vignesh Raghavendra wrote:

> All ARCH_K3 platforms need about of 2MB of malloc space post
> reallocation. Since, this space is allocated from SDRAM, provide a
> generous 2MB space by default.
> 
> Platforms requiring more than 2MB can override in defconfig as needed.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


