Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D59BCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 17:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCCB88341C;
	Mon, 29 Sep 2025 19:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U1jt1Y8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EA183448; Mon, 29 Sep 2025 19:58:16 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE5B98341C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 19:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-43f88d33872so542461b6e.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759168693; x=1759773493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lmWGMqIuZRxAZZdieJPghl36RTGn7qscxigdWgP34tQ=;
 b=U1jt1Y8eujIF5fCt5bTe6/dQFp33eaxssiTnVzMHZPeBjYaB9yjNX+ZXGNNbZjF/sA
 gv+npj4RcsnAck4QaUMEmKuIoBPF3znZFIcuIRBT7+guXMi8sFcyKWzNo9sTcEOqeDE9
 U3x9Uke3K52YDf40a0HCf36oeunoIvkav3Ks0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759168693; x=1759773493;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmWGMqIuZRxAZZdieJPghl36RTGn7qscxigdWgP34tQ=;
 b=KeBFBzAPeP4/ExhHdtTaq7KFRBEXDnXQ+XDWmcJFoDBCC4TLFVnv9FDv4tKnufW7rq
 prgIo8z2HkX533Irnu1Ra06xCo+Aj5/ZBQF9xrXk4YSBvhb2sA98YEH+cSn1Rpy4t2uC
 W9PNBsoRFGG12XltgC7o06Gnds02VuOsQnRAQQoRL6HcBGR64GD7HoCtY4JwkBhv0CZi
 4QQLg90PBRwmA83oZL+y5oXdhcubcq54Nwa5CA3d+BbDFW00XBPP/ZJj2a1QTAtTkL3D
 QTzqtFUB/NnWwaU25BhvlG8oDuYpO0Ebc+xnoER4Bdpp84JKO/R3UE+8FsV7HoeaEBv7
 AYkA==
X-Gm-Message-State: AOJu0YxpG0gp6VMX6B7zxflydKCL4+lP3cPxfsb0hXN+EoCwdjvxse2G
 a2+aUYyug1X0QCrF8L9t4T/Xh8ZS/HKAO+/0Re0UDMO8FbjxWzWE0psUWe/EXW/y29Y=
X-Gm-Gg: ASbGnctQxvVtYEUfddZq1Bj//Or6p0ngYRfPRhY8N7EqehgerLG1seLePU/BotUYJAx
 ubI6Jc3686fjAeiJRJpfzX4XnG+zMiHCaXPlvDoO6B2/UH71qwLX2UfAekqtZ9FcNaxGrevxe/S
 qQ1ubZd7I9DP4Yvjv4Uq6UQ4iScaxjEQnol4F1dm7JHOW2h8Fa4dccQxz7nBNzgayDjYDgjw5iw
 UuJOLbm3ym2zXUiVlBgRJrNVscNOi3VwW7nV5MugkZc/1zoAkM1GHyl3FD1L5bR4bZxuwXwXp54
 ZoRxqsDU1um1nAUEepDyU6IabyJufnFutoziAvKZkvui2VEmw6tbaDJgvVbShTjU+9as8ZxlbOl
 7zhNOZEi4a6UXgkWkrRjPTF2cr0jHnD01HvBx+26jl1ZlQgkVp4UKcPLsi7fxXTT4FA==
X-Google-Smtp-Source: AGHT+IFFgGZCfQ8gqFpdR1lXBguJT8nA2zRxJzxO0aPIYX8R4ywCvqrH0ccArHB26EVvpzyO3pA/uQ==
X-Received: by 2002:a05:6808:d47:b0:438:2199:6874 with SMTP id
 5614622812f47-43f4cf43350mr7239039b6e.50.1759168693359; 
 Mon, 29 Sep 2025 10:58:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43f512145d0sm2291956b6e.17.2025.09.29.10.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:58:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20250926094546.1904854-1-berrange@redhat.com>
References: <20250926094546.1904854-1-berrange@redhat.com>
Subject: Re: [PATCH] Add symlink from gpl-2.0.txt to a COPYING file
Message-Id: <175916869209.375271.9415181723119926800.b4-ty@konsulko.com>
Date: Mon, 29 Sep 2025 11:58:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 26 Sep 2025 10:45:46 +0100, Daniel P. Berrangé wrote:

> While it is good that the "Licenses/" directory contains the text
> for all licenses that are applicable to u-boot code, it is harder
> to determine at a glance what the default and/or preferred license
> is. While humans can look at the Licenses/README file, this is not
> machine parseable, making it tricky for license detection tools to
> automatically determine/report on the overall / aggregate u-boot
> license.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Add symlink from gpl-2.0.txt to a COPYING file
      commit: a239b0b0b6dbe6a168969b8cd6e600cf85db278d
-- 
Tom


