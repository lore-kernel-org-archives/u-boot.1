Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1971DCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D261582E37;
	Tue, 19 Aug 2025 17:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nhVsy9sZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CC6802C1; Tue, 19 Aug 2025 17:25:29 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872A680FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-74381f217e7so3594669a34.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755617126; x=1756221926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5H3ilZjRZVHMdHwn5Ag8ozamCw9M4OHScDdlQJFzCo8=;
 b=nhVsy9sZsnvlldNT2H8FhQNliSACFHwdBD+74IAdWpXMTBzw//3Yck3HAAHDaFBxee
 QJqVp5WYEs5F6gsFmnT5ozp6vmu8vzDtuPXphAV/UZFvKX0+T3H3nvCDLpZUsBXUt0Ts
 5QdElzacthOkdeJLhVKZlQSGVw2S8vKvEey9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617126; x=1756221926;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5H3ilZjRZVHMdHwn5Ag8ozamCw9M4OHScDdlQJFzCo8=;
 b=XFkjGdCCc8c6IQmHnu8Cm+S7x1XYTkxgugQYUWJIVI3JPd7Bxw01s7dMI6aUH4lzb/
 hvEKVZGGSGnHHT9SQ2gNioRJPWlq5buIbMHsUnDCeuz8EjdGl3vEBEqUb2S80xaRllUU
 JtMbw6XvcuHHHO6h4DkDvph6qqwRK0so33I8VfQBMCQR1SKEGWrbw7h5oSMHcE3Sxpvw
 RbSpMrvrf/06c9b8JrJItwPttTwkiT+vfjaDgw7MScaQAkA1y5USSQYQDu/rQfnNRCG5
 vBKs4Kk8wPUg8ZeBQ1xzTAt2Z9wjlu5nkrfoJCKBvKzmxR/mIkZgJ0bfzBOJZ6ypCJuv
 sTmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz1C4xTLEg5nyiZZm14WqCIj9ryOP33pi1vNBYtYeRDBUnincAqRuXI4hscXsvqz/0uuKqrqo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz57zZQx/yfspET9B7CtdvKmg/+cIGbEr5bLIaSrkWW+wDVLVGG
 JoIu6ywpKg/V82rXRAUNXFyN2+CYcwwA9zt0/X9e/3F8eGfCpfyvJXjkNEyudUe+ogM=
X-Gm-Gg: ASbGnct29t4j1CJptt7HlA7C85kChofHMyEH4M/mw1DHHEHkjBTsW8VFFY33csKY4qE
 ua0h9/z5ThLGthzUYidJBxiuKmTOyhqemOHi9UYF94XMIYWFknyTnLF29PUp7L52J5Fb79fam26
 H9/9SvNHhjlHn1JDfGRDBbGjwN91uEGNCW/tKeSWhDkzGJxsu4dcFKWUuoGPYXuDWgA5e+juZYo
 SVTn9zhLqLevDdmu8ND3Gyg+8QE2eNIBZR5NJmu/lq6EiPU/1xROaI2i2I934WjHQ7NOOYKEvO4
 pbt1uti0MU10tSsa9hdS+J2pJWyPhh/zGvxg9jdsatRBatpQndoMdCNTEc7Dxnoorf8EDYXqyAu
 y7Kp11JfG/pjPsVWuybFB0zss9oWghx1QfDOLRdDv2eEgsL/cQO/LcMA=
X-Google-Smtp-Source: AGHT+IGVodVVF2IXvKOSpd5HSwZ+aUQ6T+xxZ3kns38cmNsZ6iavjdyVT6KPS+eDQWp8jWVRxnnxuQ==
X-Received: by 2002:a05:6830:2813:b0:741:c46b:4fd9 with SMTP id
 46e09a7af769-744e0afa74emr1695172a34.24.1755617126204; 
 Tue, 19 Aug 2025 08:25:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310abb34366sm3459731fac.23.2025.08.19.08.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:25:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
References: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/4] test/py: Correctly restore the DT after capsule tests
Message-Id: <175561712530.3333765.5202514334961563334.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 09:25:25 -0600
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

On Thu, 07 Aug 2025 11:08:14 +0300, Ilias Apalodimas wrote:

> Some capsule tests are changing the sandbox DT to test various features,
> e.g authenticated capsule updates, versioning support etc. However, no one
> restores the original DT and the CI pops errors looking like
> 
> /u-boot
> Bloblist at 100 not found (err=-2)
> Failed to find FDT file '/tmp/sandbox/persistent-data/scratch/EFI/CapsuleTestData/test_ver.dtb'
> initcall_run_f(): initcall fdtdec_setup() failed
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] test/py: Correctly restore the DT after capsule tests
      commit: b0465eb88f0406ba286df9ee056b9a62c8ab9c80
[2/4] test/py: Read from the correct offset when initializing capsules
      commit: 5096f81bda1cfac2a8a325e850442bf463be2f00
[3/4] test/py: Fix race conditions on EFI capsule tests
      commit: fa2a2e20d0b4d7af92ee118d66f3245055cc9ba3
[4/4] test/py: Fix capsule update tests
      commit: fc2686d2a87391dd1b165e44ffd525b61c93e521
-- 
Tom


