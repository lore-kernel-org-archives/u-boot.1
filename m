Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E0CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 22:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D381283775;
	Fri, 17 Oct 2025 00:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NvupoiPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1151083775; Fri, 17 Oct 2025 00:07:39 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00AB383631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 00:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7b4f7a855baso825590a34.3
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760652455; x=1761257255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqLo/RSZVEFMCWIMauzQ4G3tF3voChi99YK7LODv/tQ=;
 b=NvupoiPs4J8Ictu94VWdiQsIm8to+ZLK0vQBIwGie+35HMCzMlxSE5CQCrZTxNbkyf
 3t0a4cHnFI9CYLAzuF4odTz42G/xVrITtFsbNIow4+P5khUzxYW2tTb4WzeLlmzbkzPr
 R1P3Z8zWtKTZIbbl4w93qf+Uqiyb37FMVAKYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652455; x=1761257255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CqLo/RSZVEFMCWIMauzQ4G3tF3voChi99YK7LODv/tQ=;
 b=tZHkkBnnwE5yV75Febakl2fxOUpW6HhqzLg+xKlPpocCaUsQwtrUDBhM/zHj8CZOzI
 1gAsd8dReNjVnXfuU3FztjIYFElpozE9R2ZMAEDKR5AqAMWadbXsiou9775ZvuNh+BR/
 6fHPjzYszfxvHi0MH/6di1dL9Q+DYlseQ1qv1XlwRbSYz656quESFXqEW8e6B/ktizgR
 UVU/r8sle8thOtKvz7PGVtJWGua8j3Tb3q6bE0yO+W+hCecwKbxQpYPdAm/plmG/mXxT
 DA3XrKYGPqzB/xN001JJ/jDPb2XvhL3AhSiz5h86vlsXZXXhNIvps4S2C7xIm6OP1jbY
 nwiQ==
X-Gm-Message-State: AOJu0YzCcXHsVJocJfvHJQodB9T6l8GmTZHQs346isU5nXOqFHnlG2E3
 GhL6Wrk8lHyvIZZC9YrPCkU5ulSChZVCTzEQhvNMEm7q48Z6an+tilmAKZ3eua9tey0=
X-Gm-Gg: ASbGncs9yufE1AxZ08CbiEq8e9QFmSAm4Y9wxuVNkp9LNIHHdMlzVmX9KjJNKA9fiFd
 UFQ7AzRg0PWcZCvcHBr/hg6u8OH5BpIauZztwEFTQPislvbwPrwCk4yG/NWKzOLTd3SAPaS8PK7
 VdjArQWzZk/CH2R1hOce37LuBgb3rjNDDxoFLQY2Ec3ENGTF74QEoHJ+fR0H+oo203nQZWYk8ww
 SYZcwrGcFG6Lt2EZUXjUmGTldxWAHO9H+Atdob2gyJ+Qg/P2RHPQQG/S2/iIxAvSZXIcqhi/5jd
 1kHDPtGeE6rejC3qOGKrNCvekmFNY1kfvBy90KeqUaGW/uFRxPSzBITYTy8eGebQAB2TOC6MqTH
 OLM/qaBi810bUT9DLHkPduI9rgKXJig6zFf3NIJMZJUJJ8yKInno974vWOsHUwaceimtNP5+hwC
 VFLuxL8VEk4W3ECU+teALh8DVkPFZRHl6qMDWsNQ==
X-Google-Smtp-Source: AGHT+IGKIABXuyQi3GSohlrh7bvMPHuWI14T1/qKgRqZvX0uUnCvnLyyLjeXWDVl2a0Gi1eJIF/MDw==
X-Received: by 2002:a05:6830:3c8b:b0:7b9:4dd5:1968 with SMTP id
 46e09a7af769-7c27c92c9a8mr768138a34.1.1760652455602; 
 Thu, 16 Oct 2025 15:07:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f9051d75sm6742427a34.7.2025.10.16.15.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:07:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 b-liu@ti.com, nm@ti.com, bb@ti.com
In-Reply-To: <20251009123435.960225-1-anshuld@ti.com>
References: <20251009123435.960225-1-anshuld@ti.com>
Subject: Re: [PATCH v1] env: Kconfig: disable external env in secure os
 boot
Message-Id: <176065245424.262817.8921064566527287297.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 16:07:34 -0600
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

On Thu, 09 Oct 2025 18:04:34 +0530, Anshul Dalal wrote:

> Falcon mode uses falcon_image_file from the env during mmc fs boot, but
> external env can be compromised. Therefore disable access to external
> env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: Kconfig: disable external env in secure os boot
      commit: 1e470ddd0743bbd1f229421e11e9ad2093f7fd20
-- 
Tom


