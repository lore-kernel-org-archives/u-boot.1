Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22020CD5BA4
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5975984869;
	Wed, 20 May 2026 15:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GzUFCs4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E5584857; Wed, 20 May 2026 15:08:48 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C03D84841
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so2037324f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282525; x=1779887325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+Fqx2k2J9ISBsIBsslxXxXzJLue3k1xSqS7sH6CzVs=;
 b=GzUFCs4JNYByr60Lxca5bp3x3wQsifJEb+xlk2CM8gyFRAD6t98Hr6Y4rJQ0jKIvui
 ph/THVqlXCiMpJS+Me1aO5zHB09ERD5xTm49lAklPCsrN3aF+vZ7KH1hY1XXSwjm6Z/W
 eJ+cGNEeLaSn+f7qvSiZo/fU2Y5obM1HfTZRcyqYuyzVNuWVbsrWT77lxW4mGBjgqqv9
 2iJiL7REbi7PQR/nrVbgtxvcPa+/QY3BDjCrCDVsgnBXU076dM/b44D5KknKlzLOJXsU
 iNVMDRlyOGpDE9RAhcqbsxqWefEbiWzA7RAT3+6GqAnFKQSVDFPbJ7Q1CV6kUShm9ZWI
 LR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282525; x=1779887325;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+Fqx2k2J9ISBsIBsslxXxXzJLue3k1xSqS7sH6CzVs=;
 b=DTB7zrf2UL1ed/HFWvJMkMvbtlu5nnofiQZrPOuc4f29J+aX9H2Rt40TTt4Uvzhs6O
 67B/ag1FRMP1Eex/5rZ0Y6KuqgsKYOslYIK9Uwtfri23ehNhZ2XmARtPMF4frdXQKevc
 anMOLWt0lqkLUat/y104O1k9RuupYZ0EabqKbj4yf2Gx311RrSrB3OqxVaefLG2RGpG8
 10AhzchyWtVaPPeiLyR3YT06jEu+4mkksPscd9fltKbHpFRnsdh4+OPvUzVHD/zQusrQ
 s+eMcSn+bFiv+x9ST6QD5AHiUr5wj3JWURt6MWomN/2aKxFuzOUwUBnFzXlgIa4vzO2E
 7rcw==
X-Gm-Message-State: AOJu0YwC1zwubf8A+iLYuq+cvhk9E76yVwjC9w7xGSEKAxjCh0e6grQc
 tVdh7amZ5FBR/gEfhdwgHu5YlYm3sn4HV2NHPRz/3I7YaY266eFw7etZwXu6OgU0np0=
X-Gm-Gg: Acq92OEY0QshehryuruBVe5c1KL8PGvMcWHZcns1g+9piVWhX6uPJABUysUadjFHY+k
 3o5pDbBrUb0V29wXgLVHE1yPBXSTso6eTXhtj7nhVZuezTuETHLIyg1sYkfwfQmxTs870JzWryI
 j2lrgN2qrVZ+7Mc+5oxZihTKFPQFV8bqP5mgnOA4tdLrn9jl8pAyt+Uc+iSCVqwkv4cKpmj40Qj
 YT7CjLpVtWB00VB1A1lYUoP7P0f5olkgkMu4rKX2fxN66BmhCR+AHG7ddunXp5c7Q18mymSDhb2
 bLKX65h74TuOBcLC+/MOcTfQHRY0C5Bx8cdxCgLvjtr6ZKT3h7JlN8MJ+lrjWXcF16hfG9s7abV
 OrpNO78WTaqpFPhqjoO7fW5Tx/BAxQQ8UEEjjGOhq/wwF8XILR6l/OxjqXTN9E7yb8fBeZw8UPh
 FUFyqexZy4R31mAgAldGQeZNU4X2hsRWAup/5dHTxowLU7
X-Received: by 2002:a05:600c:46cf:b0:48f:d5a0:284e with SMTP id
 5b1f17b1804b1-48fe66267eemr353419225e9.28.1779282525318; 
 Wed, 20 May 2026 06:08:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm371316615e9.5.2026.05.20.06.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:08:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Mark Kettenis <kettenis@openbsd.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <BESP194MB280542535B098A33C8A815EEDA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB280542535B098A33C8A815EEDA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] nvme: apple: Check memalign return value
Message-Id: <177928252477.3008922.14912293129667719689.b4-ty@b4>
Date: Wed, 20 May 2026 15:08:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Sat, 09 May 2026 22:13:31 +0200, Francois Berder wrote:
> memalign returns NULL if it fails.
> This commit ensures that we handle this failure before
> filling the buffer with 0s.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: apple: Check memalign return value
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/63f0f19803ee28a3612dfbef719ae7bac5143eef

-- 
Neil

