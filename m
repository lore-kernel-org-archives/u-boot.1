Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56507C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 16:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4748091A;
	Tue, 13 May 2025 18:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EZzgP1Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DD680AE0; Tue, 13 May 2025 18:41:36 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A38800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 18:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f7f7b70aebso4423632b6e.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747154493; x=1747759293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMg59mXVr9/7Ajzh/4RjalgzvQwMcpsGgpM1xZQ06MM=;
 b=EZzgP1UvmwCyBj2CJcddDFKUMKPh0FPXKxV+cFD0gOQjRAD6+gnraxz9pl5Z9pAW8x
 +4+6zMkavs3N4pylhyurAbE1uqQH/IawxRMrklZTFLp8IOjS+vfvzDH8TJyx2OognVPk
 sj3LR7FPCDW/eFUuGtSXt5b6V+ZnFbAwDu+AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747154493; x=1747759293;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMg59mXVr9/7Ajzh/4RjalgzvQwMcpsGgpM1xZQ06MM=;
 b=SPfDLijG5BXgA4/wqhmAiPYXLepI+jz6KdGKrCvVva+VR+JmrqQWBqQgFXfBwR96JA
 p7pZvcfUiCYIcsP72j5yW9+FgMuyvkQcgVIQOrHuvNMK1YZYskK+ZHvlZKIVODQOgT5O
 +V5gvgwNV3YPHFe6uYlChW3mDDKonATg42KyJkbpa1ZBYfiaAOqvXLlGjOze0Z39sDMV
 uNpGPyj+xMjo5aoJFv1G9g2441qfELRDUU0RTVjOIBY9J1T0nJWilYXfKLKzHz0ZfT5h
 7fOqX1UPveIL3hINcE6VUr1IdWdw0FDWeeAqqP6ewJpRFyDTPH+qFRv+JtcSQBM3fhhM
 8WbQ==
X-Gm-Message-State: AOJu0Yx3loM11J4lV/90QwZ1VwBp4Up+hyjh0n9D2VDmxzkY+DQ/mubC
 nFmO2JpMlxavD7w6gXSoIbGAZus4X62AdKEAmlCBUPuZkLaYVawgIOb4u3ur1EhGbHwbYUaNG/e
 c
X-Gm-Gg: ASbGncvR6K0ClRl58pyo/KEZ67gWVkwkWv+7z+KxaCn/KNruyWRx2XHgDEZhLHT093M
 QgpWgImBvqpjdm3iAey8efon1rMts2tG/Ee0q05p3Ey2lGUTwvKVMhs2zrxbIoryYfq0PVjTnTW
 z/zcJdponjh1XJI5siuXLiTz/YYBE9u2jkWzzcC6hADyxzeeWp7fCfzc/T2XPAlbYlh0mg1igNM
 4HWG+661159C8T6O3AiGjDSDFL4hez1R4Ptm5T0nkklgyzIFmxiUwW+/AJJw3hT5F16CQqYWHlz
 4L7EkaMRnDIYoHUGtTl4qLg0oKcltX1HMqxliulUwEB96Xhwr68FweUrmMkq1sKoVuRliwNmL7N
 CWCUJrpM9vmU=
X-Google-Smtp-Source: AGHT+IHFRVgWui4nHAa/Tkk+O7rPslA2+qtZ/4H36g/w5+2gInsU6FiJLaLKLLr/FkMhm1Qg8U6nZg==
X-Received: by 2002:a05:6808:6a88:b0:403:31a4:f410 with SMTP id
 5614622812f47-404c20bb49dmr167996b6e.24.1747154493124; 
 Tue, 13 May 2025 09:41:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-403802f1cc3sm2004620b6e.21.2025.05.13.09.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 09:41:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250512214927.3839357-1-festevam@gmail.com>
References: <20250512214927.3839357-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250512
Message-Id: <174715449245.2459465.6027374569059896016.b4-ty@konsulko.com>
Date: Tue, 13 May 2025 10:41:32 -0600
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

On Mon, 12 May 2025 18:49:27 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit cf37480bc8335494cf88b7180dc3f1eb8cf63a9d:
> 
>   Prepare v2025.07-rc2 (2025-05-12 14:33:38 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


