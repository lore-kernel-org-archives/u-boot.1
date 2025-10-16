Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F4FCCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 22:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BEF83835;
	Fri, 17 Oct 2025 00:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dctZA7Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644D783734; Fri, 17 Oct 2025 00:07:42 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA25D83631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 00:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7b3e2a51678so992382a34.1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760652458; x=1761257258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAisiFyQ7avi/YuntjA4L3rOCsu6bquxX94Cg3i7ZV4=;
 b=dctZA7RnksYhMhk4vkzbqqG52imkNa+kznP+NZ/6Qdv9m4UafJg3Qi6AtLBVTdIvZA
 DV1AGeuBBup3tas2Sy7gkH8tu8KQ80wg5E5ekg4s4SER983t0OjWJ/eY14rDZbt20jEc
 xxYxctSFNOlPfSjxt4u3o+WMPQsQo16bHZcuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652458; x=1761257258;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAisiFyQ7avi/YuntjA4L3rOCsu6bquxX94Cg3i7ZV4=;
 b=EX4j+pakGbqej7jZ6+1+dS2o8p3FOS4SgJqtxQ7iNYICcHFur3Z+6DBackcxUSDtwO
 +cjJGmmbZqokicqH7c3bro+eyHraoTEk70iRlwdqpzBo9aNPevFUX+7UirKUGBcX6Iyp
 Am9perncSR8hDKk5WKyYGL0Q+X89vb/fzZYmkvI8gjdP+DsPeU8W8tH1oaPEAaln7Nio
 2SBzN330TgIOf0nFsP46STub4Du87+joIN4jLctXPcVKYu9p9iJPhUsrG/yddl6fhEWK
 4K7AVcvVkWZSjb8S+xreUGAum/4qZAFnjWUoyLRtoA9+1E9uDVsYkvQlbN/glpzW3OIN
 87Pw==
X-Gm-Message-State: AOJu0Yz/d542iwqP8ix4gW57m4B1K6tTeOLL1Dri2Bie/NMafIq19tor
 VXNd4QwbNLrbcBV+P6anmX9AabvEywZ7n6WRmGWQj6m031265/IxJDgQnjor31tDzY4=
X-Gm-Gg: ASbGncvRis39FjfegdOJQ7RmXiPH1SBUTjN+ga/0k9Jr6xBxR4b+pjPUXzoaMPQ15nB
 IiW8FXceROoEmfvH0dbmxK8XYDajOaGBdUgd7jOJ72oGY/389SgvjdInc3OPN+S/4k3pnsfI5EW
 Xodxcczn4V8M3aLdkhPq3FrM0M1w3dedFd+bNyjCP11kP8nhuxQIxkxrzc8XIHWtH3sK1EmdRYl
 ovlOSbJfdDhx9ka1mmGZsB8La/xmfysakm7sDKc34qtl6wOdPGeRCC6pmGLJJ1CCdjDBnFMJLJR
 zioKsGBrS159+/wtRgBU6rzwQ0c+vmJSgZi11Zbv0aAExrZexooWR9UmfBPb+f9GwM/2gzITMyb
 6ac9xk5oDgpllOs3XI4lh/n7AcPpb9WbP7AGYCnDKQnB8q3KxMHJmsNXkLEM/LKIb/iXkm+tzq6
 cNOBqs4/bFMZuchinujK+xFsYugGIEMUNFZDwfTQ==
X-Google-Smtp-Source: AGHT+IFVfJeGiSbm6J4EqG6FrfnCHPPO23bdJsyH9iBwMRyy8IF/j7HaPOkFq6X8O0BMFsylcZEeoA==
X-Received: by 2002:a05:6830:3914:b0:745:9769:ea51 with SMTP id
 46e09a7af769-7c27b69a32bmr1062792a34.9.1760652458465; 
 Thu, 16 Oct 2025 15:07:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f9051d75sm6742427a34.7.2025.10.16.15.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:07:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
Subject: Re: (subset) [PATCH v4 0/6] Enable Firmware Handoff CI test on
 qemu_arm64
Message-Id: <176065245711.262817.6993355244514323460.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 16:07:37 -0600
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

On Wed, 15 Oct 2025 07:18:44 -0700, Raymond Mao wrote:

> This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
> 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> 2. build bl1 and fip with both Firmware Handoff and Measured Boot
>    enabled;
> 3. pytest to validate the Firmware Handoff feature via bloblist by
>    checking the existence of expected FDT nodes and TPM events generated
>    and handed over from TF-A/OP-TEE.
> 
> [...]

Applied to u-boot/master, thanks!

[5/6] ci: rename conf.qemu_arm64_na to conf.qemu_arm64
      commit: f6c01ec1510b95a623eb6d60647275a974582415
-- 
Tom


