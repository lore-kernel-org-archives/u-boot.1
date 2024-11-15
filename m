Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A77D6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B0B896BE;
	Fri, 15 Nov 2024 05:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t5xngIXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7B78969A; Fri, 15 Nov 2024 05:28:04 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA2D89353
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-460b16d4534so7703991cf.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644881; x=1732249681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyjbfTx1bpsPtI5SMAmL903tBGUyQhKl1hYXkVyP5S4=;
 b=t5xngIXzGihXIxagzeD+QVvpiNoRJqW4qFJf5cWPDFH2vKWIXD3fMDugygevsZdkfe
 icihOLsi7FGH/KhPYCWMAbbFQerrkWzGCFk7zMbOe36HULaL/v6jAAhT7/c18BAzM6GL
 ysMbwL2vaNexSRl3ZH8XJyRcOQFUpY/pU8+gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644881; x=1732249681;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyjbfTx1bpsPtI5SMAmL903tBGUyQhKl1hYXkVyP5S4=;
 b=itmrU2CBnzgWYKGtOKY5SxV1fz0FUvLB/mQGy9nRz32OuIzRwr3C8PB4xUvt/3bTxd
 bq/1ZQN7oH473NxGQdGc5YsW6rvD3uS9M0D/4qKE0zjZ5TXJOfV+EPIl+wokw0NAgv5t
 oerztcHTfEVggFyQeBHSRtjJ8u+NGOEa+Zy4/LIruiPs/SzFAKzGDhByulgFSkeVy2Yp
 7adsTlHmk4d+lwO1wGc1qHveYtoTA9HY8KA5zsVoo2Hembzt/0lGanSsKAVJjIDG6mnV
 Qz1fbuiII7FVduYJRvmpzH7eCbjmLxmyZcoVv2ZD0tK2NAT6dN08Q7cDZnVZBhl2DSBk
 kjsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6AQaH4wP4yPjX1c2V9UIEJYXC+iiVMSDqF8KM7VBAaiaA5vCuSojtNPASQlUMf5067fD3E5c=@lists.denx.de
X-Gm-Message-State: AOJu0Yzwe+0GgEXli0Ld2b6Unq2e3QzLovBrxjVFa96FCmvKAhiccpI+
 65AnM0ULc0FCKKqrmddCMkp1PvaXRHe814lLumqDIUUMDBr28J1qLg9jN+vuSO1UvEWgpGyso1E
 Frkg=
X-Google-Smtp-Source: AGHT+IH0ZJdWtPz77F7H+w/XxIoRH/pXQ3e024BoAjKi14l+fhlf1wxuUQVuRfk1F3xjK+ERnM9zWQ==
X-Received: by 2002:a05:622a:549a:b0:461:6157:99d0 with SMTP id
 d75a77b69052e-46363e9733fmr15881511cf.41.1731644881187; 
 Thu, 14 Nov 2024 20:28:01 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:28:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241103204642.175928-1-heinrich.schuchardt@canonical.com>
References: <20241103204642.175928-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: print_printf() must check availability of
 %ls
Message-Id: <173164487882.1205089.10317842614508178863.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:58 -0600
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

On Sun, 03 Nov 2024 21:46:42 +0100, Heinrich Schuchardt wrote:

> Availability of %ls in printf() depends on having
> CONFIG_EFI_LOADER or CONFIG_EFI_APP.
> 
> Respect this when testing.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


