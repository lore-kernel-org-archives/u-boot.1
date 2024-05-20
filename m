Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DB3C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 15:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A3A87ED3;
	Mon, 20 May 2024 17:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UZqrsOgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A88C881AC; Mon, 20 May 2024 17:04:51 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C84886B8
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 17:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57342829409so10523016a12.1
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716217488; x=1716822288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZTUyLKFrF0+PP3qtK7xeP4iNEnxqIzXyWeue/xJeuZE=;
 b=UZqrsOgIJTf0aF+QXLGr5favgWbsbKK9t+DWwRfhoQQQud0/ouN1x1X7/1OP4XIjte
 zLFZjc9EEqizpQbooBCvJw/8uv74v3HKyH48i/HAstKyrO35jllM0RdIg5n8IIsqpoh0
 qFrPXetzrXjLtnlfqB46sUGcaFAG8ay4l+znqQUhCglXJcRtItsCB1EhhkvxXShtHD/5
 pyVFX3f9HF+7Da7a6zRgoIvL25gUASC/HOh0IwiKFg3ktTVuKfn8jvseTgUzfFTPEKBU
 fH12bN2DRLERD6+2V4+IxGbBdgOxXshN8Z5ZHq6QigXMsWzhSsmPXM3SPt2zo/4fKTXm
 0xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716217488; x=1716822288;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTUyLKFrF0+PP3qtK7xeP4iNEnxqIzXyWeue/xJeuZE=;
 b=JFmq7J1tvud69C2KBCMlmGltbMY0x/egAdo9oTSKyUTfJM2Kj/D9csbKZzSb7vEOjb
 7skkZJ/jw9mOrUSV2a2SgvbDRR89fz62Ptz47SWA6/xODnoHI4KZ+q02YSJRz5Ny29zK
 qy51ZW7uooSbNn3RcwQEFYzwYY+92rEeJP5c9j/A4UV/CchJbZDZIHSlSZ/ZtSC+dQkI
 aLAFy9fL8g84Ggsbk8dR7MxCXHiDvPVfaeSfTFpFPrtR4/AfkPDF+kgBPV2Pq9Su5SJh
 XkWPANy2CMtmocR/bsDtTCkqWBdE2ibIoIuN90CA50jMAf1n139QBAt14gfI73SfgSCi
 oUMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvMXRu1ESm/pIRjBJsSi3G1b3HeBDIlIFfbq/DTo9w9f6LMD/1fOT8NaLvSm8yPrFGUQHi3NO2x9KNGUi4Zw0AARGSsA==
X-Gm-Message-State: AOJu0YwE41C95057bcCmyBElNMdwt3zqFFtP9HeXyEtuyotqgD72ZI1U
 bFaz54qAfwWSrkMAeMGTOavMaZEsBG3Hiomwp1SSkLFuWFZ+qLRSyBBMtqPUEmE=
X-Google-Smtp-Source: AGHT+IFjqDEVTqT7uP0c+27608fuljXhFXpvG9DYvWakB9OG4O9rDLgvDspHl5+5HIF89DLfQ14PmQ==
X-Received: by 2002:a50:954e:0:b0:573:4f09:793e with SMTP id
 4fb4d7f45d1cf-5752b40fbc8mr6239179a12.1.1716217487942; 
 Mon, 20 May 2024 08:04:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574f26d1574sm7488198a12.36.2024.05.20.08.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 08:04:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, sumit.garg@linaro.org, 
 neil.armstrong@linaro.org, u-boot@lists.denx.de, 
 Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20240424094701.21198-1-robert.marko@sartura.hr>
References: <20240424094701.21198-1-robert.marko@sartura.hr>
Subject: Re: [PATCH 1/4] MAINTAINERS: IPQ40XX: remove Luka Kovacic as
 maintainer
Message-Id: <171621748719.910636.10083846170599452658.b4-ty@linaro.org>
Date: Mon, 20 May 2024 17:04:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 24 Apr 2024 11:46:22 +0200, Robert Marko wrote:
> Luka Kovacic is no longer at Sartura, so remove him as one of IPQ40xx
> maintainers.
> 
> 

Applied, thanks!

[1/4] MAINTAINERS: IPQ40XX: remove Luka Kovacic as maintainer
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/db1d3404d82e
[2/4] MAINTAINERS: IPQ40XX: update GCC dt-bindings
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/dfa2645af1b6
[3/4] MAINTAINERS: IPQ40XX: add clock-ipq4019 instead of reset driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/28ad78df7a2b
[4/4] MAINTAINERS: IPQ40XX: add pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4191505216d

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

