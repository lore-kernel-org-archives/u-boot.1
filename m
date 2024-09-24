Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14B0CF9C6F
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 14:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B94F8897F;
	Tue, 24 Sep 2024 16:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kGkI+sep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E699889E2; Tue, 24 Sep 2024 16:31:05 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7977888646
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a9ab8e5f96so104022885a.1
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727188262; x=1727793062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iat7EJ9irl+2s5Nqy1TGVUnEc6OmDoWPqqwvFKF83Co=;
 b=kGkI+sepx2wEBUmIr2d614NMgcwxW+fvB3rySY8EQkFPalnAgBUGrYZT9vnm2wIwfd
 7JuPVT5E+rMR9/qGLVDj8VnYNfMxn2oIp9fiLrwZT48Q1xhR0n44uc0NXVETtPJQjCgx
 ZDtl6h1okJhQvs4Wgnr3H6cPOfIi9pxyIRLJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727188262; x=1727793062;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iat7EJ9irl+2s5Nqy1TGVUnEc6OmDoWPqqwvFKF83Co=;
 b=MVjBW85i1nUr1pnmbByGEdn9i5Vtub5ibCQHzB8VWN8FsdIvb9qQDiWeRrejY+o0Z9
 W8koAByMnLiNaw6RiEE5hBhvuMlMo0Llo1WKUvYf9OE5VcNxIeF8FIvAtaq+3J9brmHO
 xaKxKIMDbB84Bw6hA/cRvWbx2lWUw9/0pySs+Q16QRZsbtcmvpmu3D/TvgH5W54PzfQ6
 yYUQLQfifjgHNTnRUi7D6a9ezD+OpYUhVYBLxQiFhFE9hB8HPusgX/Vj9wM6cd3wr/Fh
 lxzCU3t9MZaDPUCeO5ROIgFrgH6F6cKF6Y2Hx0lR1vJv2p38La8+Z8SLU3HtthY9d+qQ
 tLUQ==
X-Gm-Message-State: AOJu0Yw9hoJYijsm//KOabBcw0yseQbgLydbVfm5uObizEOPVg9v4VML
 H3Z1X5VgwrrNVp7BW9sLwjZe+v6VyjlMOcmPHIEUydpeVFgARb0Q5EaHNsB9tCRtmTMa0WsOkQa
 E
X-Google-Smtp-Source: AGHT+IGRR0u8wN/LNxi0vw5lZjsox1G+DmKe/EeN0sZtYuyqrj0L72Kh9PZz0vWKMYz4YjdTYxmjfw==
X-Received: by 2002:a05:620a:4101:b0:79f:148d:f611 with SMTP id
 af79cd13be357-7acb80d1670mr2343928185a.29.1727188262175; 
 Tue, 24 Sep 2024 07:31:02 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde5fd594sm73336585a.106.2024.09.24.07.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 07:31:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240924084935.431168-1-patrick.rudolph@9elements.com>
References: <20240924084935.431168-1-patrick.rudolph@9elements.com>
Subject: Re: [u-boot-test-hooks][PATCH] travis-ci: Add qemu-arm-sbsa-ref
Message-Id: <172718825999.4076564.12428517789489687129.b4-ty@konsulko.com>
Date: Tue, 24 Sep 2024 08:30:59 -0600
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

On Tue, 24 Sep 2024 10:49:35 +0200, Patrick Rudolph wrote:

> Add support for testing sbsa-ref via QEMU. sbsa-ref has two SPI
> NOR flash, one for Arm-TF and one for unsecure firmware, providing
> ACPI tables to the OS.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


