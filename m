Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F287CC369D7
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4F9810EB;
	Tue, 22 Apr 2025 23:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aDYdcZHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0213C810F4; Tue, 22 Apr 2025 23:08:21 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D99E80EE5
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c47631b4cso3597633a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745356097; x=1745960897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrzZIQRdYAew5a/eFYjurkDn5XgsbXo8//2amEZIJxY=;
 b=aDYdcZHxk1SOBeQrliiNrhBxVGUuFmv/vRP1mBmggwimqhF0xnX3BBGGvj5dIKR10Z
 DCCo3X5ik4vZ/J5RBXmX9g2sIwBQIuq7vEHAkk/Si+DSQwSj+mK0FJzvAw15U9jIl6iS
 b/WUB3d5oMUM+kMlCKHchkrsYTW2UccNUL4GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356097; x=1745960897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrzZIQRdYAew5a/eFYjurkDn5XgsbXo8//2amEZIJxY=;
 b=Nv2/qYxCfR/DjErxlZ1PkWlhbCr8XMiEC2qHm5sYNh4qwtJty3c5k/WVRspbs82WXd
 MpAYT76F3P172m5+PIF1sJFYLh9UQf/GvTTCppPuT5xiPF6RGB8TfualsfDmGJuZuTbY
 CJEAiEn/lcrvli0SxdNtrE2KbQdqqNMOUSAOKIPpp7LRPtr9U5i6zSTMGdQmu8pdbtID
 gMqOZOu6w1zADNJx1NS5l1WZY+SmBEmLBbi5lsME4F15Pgb1xXqNffVGIO0iKEVnJOYM
 SYvFRNaixujKCo3kKMCu04wFtGFyFLXoStjs7XogQVLC18tyqKRu65y7Vtz3cfMSpSUa
 zMRw==
X-Gm-Message-State: AOJu0Yx+ykGVt2OWgl91QDJhwIRHpjS3lftiwd8/fihqpqQPhPiLc8fx
 mo1pKnnnm/hF5G0TO8xp1g7imXjNu/wI4lQ07S2Nr8MrI3X3xWSpOlqN/7cUoWg=
X-Gm-Gg: ASbGncuZwFm8a9yBHI1idWLE8Z6/EndSu5mCuxG6psCGD7rf4h9Ei2C00Ek7DcNIw93
 tLtaT1UqpYs5OofJ62egYkMplZe+dsrViYyut8crJAoAc2S8SLpxbWQ0ZUrcHSkbFg4yIg9Drcb
 wrKbR8K237MANXifxjBOgU7n3eR6Odiqp9qYND32YD3ioQMT0ATNqqN/CuplEMh18SnFy5+K3Ir
 rJCG9HWiyrYR/NGoqlSk3KkaIdcdU9ZaVRpqUzFGJMsB+NkNElVUX395I4VmB/Npy5ydzeWL3oF
 pTGV9WKGPPhauscn5eNe9UWpFg7Z48iEk37lRRRwQp3TLQQ000LdbqSe2sBzRs7F7ZUQuPYkJbq
 E
X-Google-Smtp-Source: AGHT+IFKPy7p0tsAqAyoGLXJxN2upSOM8goNWhXKoX0PC1bbXzP5KnMbUhnOKoxsk7uvezO8hudgBA==
X-Received: by 2002:a05:6830:2aa0:b0:72c:320b:f0ed with SMTP id
 46e09a7af769-73006334126mr10919099a34.27.1745356097295; 
 Tue, 22 Apr 2025 14:08:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300488495asm2128388a34.43.2025.04.22.14.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:08:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
In-Reply-To: <20250416135744.1995084-1-jerome.forissier@linaro.org>
References: <20250416135744.1995084-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v1 0/2] Enable UNIT_TEST for all qemu* generic targets
Message-Id: <174535609616.3811396.12664828006695851450.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 15:08:16 -0600
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

On Wed, 16 Apr 2025 15:57:29 +0200, Jerome Forissier wrote:

> Enable CONFIG_UNIT_TEST in most of the configs/qemu*_defconfig files
> to increase test coverage in CI, and fix what needs to be fixed.
> 
> 
> Jerome Forissier (2):
>   test: run some test commands only if HUSH_PARSER is enabled
>   configs: enable CONFIG_UNIT_TEST for all qemu* generic targets
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] test: run some test commands only if HUSH_PARSER is enabled
      commit: 83fc6005cdaf703ff26d635d72bcccf2081ad5d8
[2/2] configs: enable CONFIG_UNIT_TEST for all qemu* generic targets
      commit: 753b7219c23191cb2a6468cd1acbfaeccf1380a2
-- 
Tom


