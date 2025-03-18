Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A66C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 14:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E89817D8;
	Tue, 18 Mar 2025 15:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EU64718S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70777817D8; Tue, 18 Mar 2025 15:32:21 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED58A800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 15:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso18050165e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742308338; x=1742913138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjzDwxZdS0agJ/4ounegG02oBXOVZnc/ipU6Y8RBM0c=;
 b=EU64718Sr5TQe03NWt7G0DiNV3D9wn9iJQ7O3fagPyO2XSxsnyKicaxGLyo7+HYz1u
 m1/0YZs+6XuGr8YjywpLw5AJJixYGd+vSIXfaIldLhldI+FLWAlYHXxobcNReQc+Ejek
 PJDJDbu7Z9lrwIJWKGlpAWEFAmkPp6Wy3RTArtxaA+2EiznimIgetJa/A1zQhPOc4XnX
 q3+z4G7yqg7+KRftvfHgJi8BpTmXNVgnmZXvX3vVXqE8r0MOXBdb0+fR78ZK/l20UQqs
 CdYOQepFEEyxM1QwxCx6ZwBxVvQknTt3r76IKJQuSo8zPYOqTDsMqemeUK6TgjkahvUS
 /ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742308338; x=1742913138;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjzDwxZdS0agJ/4ounegG02oBXOVZnc/ipU6Y8RBM0c=;
 b=gDP2rp/YiNNI7e1uPMQVmPhXYki7mqhyaCt8eksYmzYM3AN7RuOV/MPHz3zo/TUZqQ
 brILptm4ra3OwpQOccmx0eAIfBPvsV9vTij3r8BN0P7OXP7Z9G7vCjBxHeJdw3mhG+H0
 rRciKhguIle1q+PrtyikwJoI4PogBEg8PhvQSlP/fR/clVgVGPdgnfv/pM54zfXfN7TK
 88Al2FDZJtwLizPbt4h+gWihG/cAkbCaPfACDKOh9+fdanmcF89j5ieXtID8ivX0kwXh
 jtTcCqX+p1nniFMUfg5BDxAjEIzi6ut/VqcjoHRryk5i7hnHI9KK/e5rXeNC5qD+OvL0
 BSsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1pS4MfZDdDg6kf9Zy6c2GcL912pd8aaqW+DR90VVzvGi5y4P7G/28vJH1yoKmz0VRm1zcSCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4oczyV86/selvJKOaA3GusVJrxiCueuNyAhkMOSCBNX+j8HRb
 lhbNe8ltMXe/qcuJwKgdbP5WNFswt2cmG87oVEBHtXDBeGELfLBZeYBcJiWObg8=
X-Gm-Gg: ASbGncsIAuu4iqhEvkDm4+nxHDvHpvrt2do+jlWenjcjYV+Y9GLW5+SGnyMElevYYjx
 5jAsE+nvo1xgmeJYMKXYsxsDoiitC9WUTv/5qt0Xg2+/+5s9Wfe+ERx3qCVVEfwU6nlfwfOKGPk
 fZXKcw2jqx2JiIDzdx9L5+6P5lPemp1XUVLyPKk76QNEHMX9S8+UKI5XbNLOTpyu4Bt7ZfkDom+
 F23vFiXVUFwVScEAogGy3QbJxaMczx1lDQ8Ve5hGBrbX8RwT+v50jXu7PEPWmEM0FOGOil5aICo
 TQb0HC+bZOAMyniRv25j6f9d1mCRsejDhecglRMsQ6DQpktUtk6DHariPu6IpjAMKVYoT2EisCf
 n
X-Google-Smtp-Source: AGHT+IFQOXcHPvZ4g+ztwBf9Gh595kL+gsLZc12JmxMk7PUofA6x0W3M5AXqEhiI9lOgWstSEM2rJQ==
X-Received: by 2002:a05:600c:3ba6:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43d3b9cd740mr22165735e9.29.1742308338294; 
 Tue, 18 Mar 2025 07:32:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df35bdsm17836971f8f.5.2025.03.18.07.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 07:32:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Love Kumar <love.kumar@amd.com>
In-Reply-To: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
References: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
Subject: Re: [PATCH v2 0/6] ufs: core: initial cleanup and defines sync
 with Linux v6.12
Message-Id: <174230833764.3931542.14369419014688447493.b4-ty@linaro.org>
Date: Tue, 18 Mar 2025 15:32:17 +0100
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

Hi,

On Mon, 30 Dec 2024 11:30:54 +0100, Neil Armstrong wrote:
> This serie fixes the build and checkpatch warnings, and
> does a split of the ufs.h into a separate ufshci.h which
> helps syndhronizing the defines from Linux v6.12.
> 
> No functional changes intended, tests on hardware
> are welcome.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/6] ufs: core: include missing include/ufs.h
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/938ce571b89cdada5ee210150254972a07df6ef2
[2/6] ufs: core: mark unexported functions as static
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/c20826be04046ebe7f5a03070cf00645e4380e35
[3/6] ufs: core: cosmetic fixups
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/03012e85998fb0d796359c7270d2b3887863aee6
[4/6] ufs: core: move ufshci defines in a separate header
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/124ba1eb9fb5537b9b600727e99d4587b733be64
[5/6] ufs: core: sync unipro.h with Linux v6.12
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/2f2c7c3c8d67fd4c40d1c0582f641cef1fa1b24e
[6/6] ufs: core: sync ufshci.h with Linux v6.12
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/a59fda334828596677a2a764d12bdb3eb6381730

-- 
Neil

