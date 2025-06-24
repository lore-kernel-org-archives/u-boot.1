Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A46C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 14:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF19682C2F;
	Tue, 24 Jun 2025 16:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kCT6rD6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E535A82C4C; Tue, 24 Jun 2025 16:18:18 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABAB82BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 16:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so3214088fac.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750774695; x=1751379495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCos55hBOftGEkbkfNwMOqBYZblZAzINdsVsTFyP658=;
 b=kCT6rD6LPyqOCDcnIjxhmKuhz/td4I0+4I0hYVkm7xMsV8k3VsiH1vu2c9TrjWiRBr
 3wy8q+H/ZfdaMisQGiAzGsSvoOfYNJejaYE5vkXqDKbxNEm4fmDKUWCCtCisnf7FUnOz
 fbRZT0UoU1QoHwSRdgjc5HvLLJC5oKBqAeejY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750774695; x=1751379495;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCos55hBOftGEkbkfNwMOqBYZblZAzINdsVsTFyP658=;
 b=oAhy0hwvpDWkhUPPeXPtDH0KnmlXR2znnnYTuq12iMDyPk98p2/bZMtz+b4lkuKkS3
 Crc9/UPMmrST7eA2KLb8k0uOmWlqjInclYsdFnWpQvInzUtKVNH2A1hIyz20UnZM51io
 cIdGdx1qFohNx/ViOK2zwvztcZtk/95IO45aPa638Cd82p3CtPhN3lII0l6GPz6jz3jD
 TpMLdEXLWg1etC3pHa2bdfs5vyzASXYjSGm0xNEg7mjAYMr5/Y+LBEsHy0ZA6xDiYezZ
 BqfKo2mNKG6EHmAlhQIJAoNjSu5ENz9+5xKflxbIELHQWNHMUyWAe0+ICnuK/fNftUN1
 ICIw==
X-Gm-Message-State: AOJu0Yzq6TeBBfBGBkgheT8GHcW0lYb8XzFbWjSfLIobGCQ6tnkBTaVf
 fmXjvfjoJX+2TtE0ANuKNZUXSc6YBhgOaSpYGtBQjmeZW8ncaz3kAepHiYpYYE3DbnqJoIhc52L
 QJpb3goc=
X-Gm-Gg: ASbGncufoOCPKopJbyRz8Oty9NDPYty8gpuqjnFBWXb9H4aRjsi0ZcRzERVM0kJWi+B
 lSyAg1yGsLiyiGE2oa0/Ujbi75muZ5moGUZtzjHPQQJjZN8xu3LnJX5z22SELr3QxQGJh4qS4qv
 DpEtSc+5i6cI7rUaf40+inHl9eyVueKg47SRPVQN3R2mm/JKfJVM0vMnHPsueV1OY5KwHJOZPbD
 /KDHrjFWbSJaaacz5IFBiFhp1KmN88aTvDnnIjuX0B8PdeHDUlMwpsp9JqMYlmBCoXeor3Q971B
 4AJ65GlKAOji3t72wgLOSql3XHbF37xaIK5d06trTxfzY2vlhwARqVsWNsFcxS1UQrDTVnAxiWF
 6Q2qQwpYtRuiWIjK96r9pyg==
X-Google-Smtp-Source: AGHT+IGSlW5J9xw1qwtAWTB6SfjXC7Dv+k4Xw6iK8OusUXSqpm7Tm2XA5erfQYNwI066JthbkatKlA==
X-Received: by 2002:a05:6870:7191:b0:2eb:a2ef:901b with SMTP id
 586e51a60fabf-2ef95c3bcc2mr2329913fac.14.1750774695467; 
 Tue, 24 Jun 2025 07:18:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8a8ea8a4sm2135754fac.24.2025.06.24.07.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 07:18:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, hs@denx.de, sjg@chromium.org, git@amd.com
In-Reply-To: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
References: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2] i2c: mux: Fix the crash when the i2c-arbitrator
 node is present
Message-Id: <175077469416.1184032.12623287028427770749.b4-ty@konsulko.com>
Date: Tue, 24 Jun 2025 08:18:14 -0600
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

On Mon, 23 Jun 2025 13:36:07 +0530, Venkatesh Yadav Abbarapu wrote:

> Observing the crash when we add the i2c-arbitrator node in the device
> tree as per the DT bindings. The issue is with the child node of
> i2c-arbitrator@72 i.e., i2c@f1950000->i2c-arbitrator@72->i2c-arb, as the
> arbitrator uses the uclass of mux(UCLASS_I2C_MUX) and the mux uclass driver
> checks for the "reg" property using the i2c_mux_child_post_bind() function,
> if it won't find the "reg" property it will return -EINVAL which is leading
> to the crash.
> So, add the logic to check whether the  child node has the "reg" property,
> if the "reg" property exists then read the "reg" and update the channel.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] i2c: mux: Fix the crash when the i2c-arbitrator node is present
      commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
-- 
Tom


