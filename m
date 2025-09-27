Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39FFCAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 14:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B385832C8;
	Sat, 27 Sep 2025 16:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="brQJ+1iN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8340F832C8; Sat, 27 Sep 2025 16:05:01 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E1E830CA
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 16:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7b4f7a855baso9487a34.3
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758981898; x=1759586698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f/3+TwbRp971Ds4jB2A0VKvl10tEPommzl6fjo8jnc=;
 b=brQJ+1iNCY2E0QmNaEM9+cCHuhjWjvRGgy2BlwzuU5BsHz6IwnTWYlmsSC+CnEbzYH
 aXOdRGmijKcHATfAHcZcYUcQ3zAWg0Xqct7PB/o/nS+cO/76mqnn89TIxVsa+igsHnTX
 6LZ7QCpU93fr+kS8mHWVx3KaMI90/VSIAWuUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758981898; x=1759586698;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8f/3+TwbRp971Ds4jB2A0VKvl10tEPommzl6fjo8jnc=;
 b=kzvNxiwwMyM/b5H+0HtBmbPEMtj3NmhLuHJibYPr/8ZVyKP/HJlYwz5kljt8eNK1YT
 uDqdhZPqn/daK3DR1bCUZFr8euPW4vrx49EWeT/IzEXGB/vH8DPuc5Ao5sJ8855pSE8g
 6tasZFo9ezTqde7QtzeXCdjJnttmVzto5lO8giUuOeSmUMsDbRP8T0nU0RGZPCPg+dSE
 X9tw7KrvzsvVmguVQMeon8BDyxtEbXOxBLU/rnwP3vvsVYkF6HJZF4SsLDMCxye5UbIN
 LJQ+ATEbeYpz7Ph7QwJI4PSzT3l3eMRv/lefA5c4uHrePoPyRm/quqYU3T07ArDzdQN4
 xciw==
X-Gm-Message-State: AOJu0Yy1sTvNvvQkCv2Cx2ClgrX0DfiGh3Y4quVF6yitX9dYqXK2CihU
 hQmo4Txi0LmbAuBuzaHvY0rUrJSpNRYfRlQD31W8Za8bw58yM3dsmZLMZTFo57QHe94=
X-Gm-Gg: ASbGncuneaXILTNrU+edsj11Az/JfL9PoE3btvBhAL9DrEDBbjUGkih6Z1NClbAN58W
 zFwZogd6Vj9gqgNVNbmTQE6OrtFJLzxdU13snWvAxBedg1h6NN6BWQ/QTvD0PoQA+eriKVxHNZ1
 DSgN+QOFUOCeqgt7l8mX1NGpas27tdv6rIF6nOhgsGmIpuz3oB2mwnOxL+lfW02nXK8nnyJpYxT
 xP1WcfH0tV/ykLECScIjsDluW0I+jQJ+L9BmfHV7cQE/91QoM15wY2P+hIGVmJUvmDnxDO9XgTp
 k55F0xw/gI36GgOtBD8nRZh7tQI9VvLn4PPXKiJjzoQg32mod4Sbhipu3WqM+nRR4Q+REpnxi67
 mTarXfmgu+T24sBU5VKm3V4xXGmt6RjJtYxk+i8ZN91IQyM5N+1BRMeo=
X-Google-Smtp-Source: AGHT+IF8Nt1fOnHxYydhUPS5rjuDW46NZwOUKfcRY3jkqAJnOggHfE6r8j1VY83qSNADM+wnX0qoAA==
X-Received: by 2002:a05:6830:621b:b0:745:9f89:a9b9 with SMTP id
 46e09a7af769-7a05c33b88cmr7071205a34.27.1758981897796; 
 Sat, 27 Sep 2025 07:04:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7b4c0e92da9sm20077a34.26.2025.09.27.07.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 07:04:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Debbie Horsfall <debbie.horsfall@arm.com>
Cc: fenghua@phytium.com.cn, linus.walleij@linaro.org, Peter.Hoyes@arm.com, 
 liviu.dudau@foss.arm.com
In-Reply-To: <20250917162222.1061111-1-debbie.horsfall@arm.com>
References: <20250917162222.1061111-1-debbie.horsfall@arm.com>
Subject: Re: [PATCH v2 1/2] vexpress63: Set the DM_RNG property
Message-Id: <175898189644.3905802.16793370880252371569.b4-ty@konsulko.com>
Date: Sat, 27 Sep 2025 08:04:56 -0600
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

On Wed, 17 Sep 2025 17:22:21 +0100, Debbie Horsfall wrote:

> Enable the DM_RNG virtio random number generator driver in order to
> consume entropy within U-Boot. This allows U-Boot to inject entropy to the
> kernel via UEFI, so the kernel can use that early, for instance for
> address layout randomisation, or when the kernel does not provide an
> entropy driver itself.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] vexpress63: Set the DM_RNG property
      commit: 6190036e2365209d7d084c5af5c7558b5ff554f9
[2/2] arm: vexpress64: Enable SYSRESET and SYSRESET_PSCI
      commit: 1f3f1e090a2695e0b17cbf9dc50ccb59d100458f
-- 
Tom


