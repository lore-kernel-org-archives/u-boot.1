Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0FFC369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B2D819FC;
	Tue, 22 Apr 2025 23:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XD3LDrUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D26180EE5; Tue, 22 Apr 2025 23:08:23 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1406A80EE5
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72b82c8230aso1718691a34.2
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745356100; x=1745960900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjDghdTifvlNGsIK1HFr+ESgCYy/cVj/NRjuEMtw68g=;
 b=XD3LDrUBoZ+unvk4GvbZc2pPMNE/CqUZ4GZw5slNuetG7O4uM1rjyKf1G7ieN/cIkS
 VC1xDFDYuKX3OJuOETX2K3Lqz6Wnr/upk1mvgmBrtyF7n5v4nejqP6qmjuWR5ezzvIa0
 IGywsSkBKbIGL+ptQICamyPzBn+8JflJ+zyVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356100; x=1745960900;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjDghdTifvlNGsIK1HFr+ESgCYy/cVj/NRjuEMtw68g=;
 b=qvQLSQlsiNBtbpmCQh9uhFDyD2M8b2aOHQO8kUsOv6XV1xGw0MqKNeCZaKjA48j2JK
 /AtMyiyGPPFqYJCvI7gt9smuYuWIg+mT9e3pKYfJQ5GOVfrIRD1ZyXrbM4xL2rVUxPaE
 T8oO8/hfRkfDLq5zjiQjlkm3h8enfe79J8LAeYhom+R8k+9nh1jaJcRoYz0vw+ql6cKE
 5mxXxfF7cFl/8wj0haLVd+LV1Xz6GAlwPCU0Q75LdyefB9w3iuChYc0Oo4uKVbNuLbDa
 RhwNwP4WLrWuX5YHdr3906OdndWy/sXu5Ak0Dy4FC3MO42wUB8fIIvSsJtoSsQHmFmIz
 kmMw==
X-Gm-Message-State: AOJu0Yxomwlc6DZiwHgdLgJO9xIuYJF04o0rosUaUMJFr4J4sBN5ZD4h
 oN6zgpOWFZQA8lC8OBkIETYKHCXwFlP2HaihkPXtQ306O9eV8qCegSylo3t/cFc=
X-Gm-Gg: ASbGncu7BPo6HX+nXpihGuT5geEAb3xGsUZoaBILY16Rdfc2eoJIq/4PAMh6IjQ6v6e
 L95SGmQZlhebYfxKga38vVY+E6in+3DapEjWdoyZ0ElrBUQ3wTe6hTyL9ob2D7nQEK+piciJ/v4
 GuyaVQuE5MsSKUVA++RIBWvNaTKfZidQxX6O64dSj5+79QRZcTezlrJCj1b9wmPMFK81GqP/7Vx
 MCP3/9VghoVXOWxiCLTlTg7N5lcIuWeKzvg1O7r4eoLNnz1znGw3g92BWqA2AzKrRwY/Sw6+RfS
 gA06LVWhg/VN4QWKYStIVd9F4dGvmJ3GpbnCK1qxoMqDx7W+QURy9+qTA5qhSVLlqutobvHU6/W
 m
X-Google-Smtp-Source: AGHT+IEnnJiCgEUvXuGUQEQR01KUX4zQvUkF/yHqy0emRAyNJNgA6R0piYlM0EJpMLvfyUD8hJE79g==
X-Received: by 2002:a05:6830:6112:b0:72b:98d9:6b2d with SMTP id
 46e09a7af769-7300620a0e5mr13750162a34.8.1745356099797; 
 Tue, 22 Apr 2025 14:08:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300488495asm2128388a34.43.2025.04.22.14.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:08:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250416074839.1267396-1-jerome.forissier@linaro.org>
References: <20250416074839.1267396-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v3 0/2] ut: fix print_guid() and enable UNIT_TEST for
 qemu_arm64
Message-Id: <174535609846.3811396.518708877407201897.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 15:08:18 -0600
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

On Wed, 16 Apr 2025 09:48:19 +0200, Jerome Forissier wrote:

> There is a bug in the print_guid() unit test in test/common/print.c when
> PARTITION_TYPE_GUID is not enabled but either CMD_EFIDEBUG or EFI are.
> 
> The first patch fixes the issue and the second one enables UNIT_TEST in
> the qemu_arm64 defconfig so that the unit tests are run in CI (this
> platform has CMD_EFIDEBUG so the bug applies).
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID
      commit: d54e1004b8b171d18ad216a817018bb7aea6ec60
[2/2] qemu-arm64: enable UNIT_TEST
      commit: 020ecd7b464fa4d151580fd297b07ad6f1c38aab
-- 
Tom


