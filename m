Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81104C7EE32
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 01:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F5482C65;
	Fri, 27 Jun 2025 03:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GQgJ5pyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663CF82D21; Fri, 27 Jun 2025 03:10:27 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29AB82E40
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 03:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-739dcdb012fso343738a34.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750986621; x=1751591421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQcwUD3QD7soEa9VXS8fkvsytf127xPDZoP2xSndTkk=;
 b=GQgJ5pyWsuRsf2SV0GjZWyHF3UWeGezIC4XS3Jttli8NdUtIm0uKO9PRuo7Epl5VIi
 1q0YhqJgP0MnCeZymMSyDzXB9c8XftpJb8HiHbNAF/dvMvoRsbjP6C31vHvvlVY3urYX
 yKFjsegE/Ld7umUs4s3goDFBsk691nGlyudXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750986621; x=1751591421;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQcwUD3QD7soEa9VXS8fkvsytf127xPDZoP2xSndTkk=;
 b=FDT7HtJTUQnsKNlXJNSzwTzfZkcUWC7vjOdciZEhmg0adDR9+9izx/0Sbt0deUEcI1
 zSIB+HrBP2ajqJ1P6CdqALT9LWfuxupzs+dcpQjtkz2YCX7MLZlS0DzjAhcI5W+wWBJl
 N2r2RuvRnb97NnBXvw2tQ/I0ufP+DAHBS2aKmrZTrcE9MgoYpTQk/6oy5O2ypIExr8JG
 gqXjkOPSmXS0haoke0QHhqXE9oqFlTCxSKs/i3oBDFzgerhz7yWn1ixwzpG+WJPDo5GV
 weNAnew+YZGREQ8Kn2vIc4MTCqDghr9f7qSXabekConLonjdiskQJtvGHAuYbD5r9XXq
 6jGw==
X-Gm-Message-State: AOJu0Yy7Hlv0e7mTAN3HcUOo1AdeKjcIgaNwoXg6JfPDPUqHBOayrdBD
 MnTEQGhvoLl64pDrSGLTPczd8Z5V5sdgiag5DBXqN82N00JRmZVBFEOqE7lnsDv7TgU=
X-Gm-Gg: ASbGncsO7dSMYV96IKz6T0vx3Eb2spWZ5R/6OTGLAWZVMp2h/WOX+drjjAoY59GpeTK
 TGrlExxfro8beEm/zWmgj7AvvHg3JXmTn9EAiOvxceVQwkrjSBr/ANTqJFMDPvW4ngKbYLJg8VF
 W6pgws9Q3yLJdN9a+STsVU16Gyv+xaMPcTk6T4dU1B2EFDdfjaaWXxpmgupeClwgQGqCtzV2qBY
 C9fRBveR8GS75Q+JBKocfCAXkxkA58gwIHlTF47keN76YUELKlmxIAZH2+rTqEhpDxpADR9JpeM
 oO7nFXF/3VR5RXzFfaoEtIoyb+wzltHcVIMseOMIypuktZ2MnzhHV/fJkNnFmEDpy4oWlpB/SLd
 9VGqshwBkmsdyxfsOuf8515cuxoGreol/
X-Google-Smtp-Source: AGHT+IFoftLnod/xHZNvgyjWgGYou6WvNnfd4KHV9zcRwAEw3NXz2wS8azez9Q1CB0+n/siJog3aKQ==
X-Received: by 2002:a05:6830:3c8f:b0:727:345d:3b83 with SMTP id
 46e09a7af769-73afc6b62e4mr827140a34.23.1750986621547; 
 Thu, 26 Jun 2025 18:10:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb122973sm185860a34.63.2025.06.26.18.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 18:10:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, rfried.dev@gmail.com, jm@ti.com, s-k6@ti.com, 
 rogerq@kernel.org, afd@ti.com, sjg@chromium.org, danishanwar@ti.com, 
 anshuld@ti.com, n-francis@ti.com, Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, s-vadapalli@ti.com, srk@ti.com
In-Reply-To: <20250616164929.631791-1-h-salunke@ti.com>
References: <20250616164929.631791-1-h-salunke@ti.com>
Subject: Re: [PATCH v2 0/2] Add TI K3 PCIe Endpoint Controller support for
 AM64X
Message-Id: <175098661987.1928306.16153229800176946154.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 19:10:19 -0600
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

On Mon, 16 Jun 2025 22:19:27 +0530, Hrushikesh Salunke wrote:

> This series adds support for the Endpoint mode on Cadence PCIe controller
> on TI's K3 family of SoCs. The driver is an adaptation of the Linux
> driver (drivers/pci/controller/cadence/pci-j721e.c) and has been
> implemented specifically for Endpoint mode of operation on AM64X. A minor
> set of changes will be sufficient to support other K3 SoCs as well.
> 
> This patch is tested on AM64X EVM. Following are the log corresponding
> to this feature.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] pci_endpoint: Add TI K3 Cadence PCIe Endpoint Controller driver
      commit: a4a0edc6046dd5b9ebe24ad72dfcdb43b36f0bd6
[2/2] configs: am64x_evm_a53_defconfig: Enable configs for PCI Endpoint mode
      commit: 7d70986071ea32b2d496ecfc4f9621e454dc1b75
-- 
Tom


