Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357A1D149F9
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 00:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583DA88F92;
	Sat, 26 Oct 2024 02:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UTKnQkh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E155C89020; Sat, 26 Oct 2024 02:32:22 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC67A88F57
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b152a923a3so178934385a.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729902738; x=1730507538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSeyJnNqOwQ6heh07mtnkuW/z/Hg7Muv2dL4oUfcFs8=;
 b=UTKnQkh9BFmFW0qC52xsWMFy9gtfcubCE55OUbj6//yaArgvKur5emwhZq+f0GoOlu
 ufXM1y0FB9ba2ISilDcOj3co7I9nSDziu0eVnuvoW4AxxY1R5WXKzuy3HyaC3qjDU/e5
 Lg8jbahCLVMR5jO9NjrmKW7sPqTBdRAoJPTUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729902738; x=1730507538;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSeyJnNqOwQ6heh07mtnkuW/z/Hg7Muv2dL4oUfcFs8=;
 b=YoTkU4tZXXrwefBhFvmVNvaEbo/3r2kpfI60OHSH4EXRM5LpFhd4e2W//9cSLyxk/m
 qmw7PfDpbUtX1rol5onITxDLcvVzmegC1otiWqya9gAZNMfY5N57tOxWfic1jQlqt6Ct
 2d/VV9uM0XwTCkHZvSzRoMpM9CuAsdw5NsvFaty4EaSj4BflEjpZrzp9vTGo9oCylOFt
 xVHL6UOCrdQT1caz3OBzuciMOLf6f7uesI+lhShSx/S0/cDZYqxO7tKCUJUd9r7iDW/C
 PJruT5BcXcJ/mH37SonuRRTclY54qhhvBMiBn6OrnvDVpCBq7+CSUgIL2rS+zf7D9Y9u
 hi9g==
X-Gm-Message-State: AOJu0YyR/GoA6QoTfY3zSPtgW2GIw8kus3Lg3BPmlDB2ujGY3VJVbhDO
 kMcJS5NR5cbPTofpp/5KXhVV9cyD9/d3Q8wQq8DrzhK/ezuF1Y4IpP6CZFzoQ/I=
X-Google-Smtp-Source: AGHT+IHxptHQpkZh6+6eMDOw4wKCcB4jz8FhCEZ9gsJDM3jb/ZeLA4rDWi3iX8eQ3VTf0Xq5AiUkOg==
X-Received: by 2002:a05:620a:d86:b0:7b1:4fa8:af90 with SMTP id
 af79cd13be357-7b193efd710mr167872485a.30.1729902737828; 
 Fri, 25 Oct 2024 17:32:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d278244sm104125985a.4.2024.10.25.17.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 17:32:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Artur Rojek <artur@conclusive.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Eugene Uriev <eugeneuriev@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Sean Anderson <seanga2@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
Subject: Re: [PATCH v4 0/8] Allow showing the memory map
Message-Id: <172990273419.502739.7844795066224107789.b4-ty@konsulko.com>
Date: Fri, 25 Oct 2024 18:32:14 -0600
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

On Mon, 21 Oct 2024 10:19:24 +0200, Simon Glass wrote:

> This little series adds a new 'memmap' command, intended to show the
> layout of memory within U-Boot and how much memory is available for
> loading images.
> 
> Changes in v4:
> - Drop am65x patch as it is not needed
> - Add patch to export the lmb data structure
> - Add new patch to show the lmb records
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


