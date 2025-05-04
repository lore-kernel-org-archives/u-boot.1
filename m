Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B071C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 17:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659468294C;
	Sun,  4 May 2025 19:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rhYPqIxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2449682982; Sun,  4 May 2025 19:05:43 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA298293C
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 19:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c7f876b320so3549016fac.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746378339; x=1746983139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EFs99ZTxDvx9Dm1fS27vKG7tzGxW5dme+Eo8ukCI3Y=;
 b=rhYPqIxooQWSGTaYo2HxNYIv/1z+xAFrcMTPCmdu2WPziDllqsaYUmYhNkCf/YqtVe
 bQ1JTHRqChJCyA/8Zg0buLBQ6SC/9s6E5yYOB9Tw3+13d/nNEoIfBcmqtdzfvFbKBYN2
 hv19ZIszh8U3+zh8/pRxgHn5SrUHuWBmQeELU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746378339; x=1746983139;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EFs99ZTxDvx9Dm1fS27vKG7tzGxW5dme+Eo8ukCI3Y=;
 b=jy49hap6SC0lKBnPlslFq7t1DCtHUle2MEEx76hyRNnVZo8ngfF2J5XYAOXN7v1l5K
 +CNkXKAza1Qqae7l2HFehU1uafzW+Q3qVGZ+9MKOyIxTdPvEwd0BGqZvZins91HZxm5n
 Tmk0mq0D+RqWEvk9SnbOdWkEK/fUdbgnk69KtQs9btW19Jvo0T+aE4xW8nfRa/fFv8TT
 9qUbzF1CgUDMto9mM3LU2Jrd7i6FQC8cT1PIc8KoApgYE2I1HoVXTmJz3LCNHxcFViM0
 XiS0ljkCSsJ1RFEdkmlNB1xZzuh534dEWEQ9iwIjjWqAzBqA1gDXl3jvrtsoPMnWUGi9
 FayA==
X-Gm-Message-State: AOJu0Yx8ziMIWNNb5kNTR6K9VdCuM5mGULVO8W5og7A159cDnejQYd8E
 UnMqFr9kG6EktSWNdUugVjNUbmu9hrs1ByJyiE6I7oYWrqR4Hwf4wlK+Z3xJQ10h5xB0+aryeVA
 ObaU=
X-Gm-Gg: ASbGncsr4lHzX7g+Vz4UAN5HwIbwn074gSzCFWft8rlz2lXtvqQEeBb5wbixfc7Hmqo
 h4rk/W2kIuOXy8nEcuzn8cHybnEF83TIaHRolQX3BIemuLztLA6Uz+6XdodZhliOcss2paz3cXv
 eqpr1/iSScvbtQRm755NBz5/rNigFLuNa3xDCa3izTzBKUHYRRQDXtmDlmjnnm7oCd2XYtWKAmY
 955CbtjyxKH3NxaA84Gb7TkGFMnSlKlevBQp/DXkeUo6/Mhv8x2STp1eFoUUyf9Dr74TgCwxNkL
 4ZC//zFnCAkcmhmxi874K1OskPZOms+QMTojWQXIw3TFPiLlmKKxbUiDU5Nzc5PpUegbpmNZU1r
 J
X-Google-Smtp-Source: AGHT+IE56DzZ5ihzdIBGGzfnb8tBS2g7VKH8mdaCez00+McGkFRPhS6MJQbI0l3miacOpjGr7WAGhQ==
X-Received: by 2002:a05:6871:73a1:b0:2d7:3885:7885 with SMTP id
 586e51a60fabf-2dae868cbf1mr2581312fac.37.1746378339671; 
 Sun, 04 May 2025 10:05:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f6d9aesm1593536fac.21.2025.05.04.10.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 10:05:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250504023007.3864911-1-festevam@gmail.com>
References: <20250504023007.3864911-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250503
Message-Id: <174637833817.1732961.10737208160011837477.b4-ty@konsulko.com>
Date: Sun, 04 May 2025 11:05:38 -0600
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

On Sat, 03 May 2025 23:30:07 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 0c8a89d252c3db3401ffa572ee2e4dfcb94e2c3b:
> 
>   Merge patch series "k3-j784s4*: Enable ESMs and related PMIC" (2025-05-02 15:32:45 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


