Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A68CEB2DA
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 15:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FFB983C54;
	Sat, 15 Nov 2025 16:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7Errx4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628FE83B49; Sat, 15 Nov 2025 16:33:20 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1A483A47
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 16:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-450b8afe3e0so69497b6e.0
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763220796; x=1763825596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUiLQO/DlUalxa+jjLSlV2gJnr2lR464O3I1QLKH0Og=;
 b=X7Errx4gnJ9SBkgVA7oyWLQE8ARiKOeLFlLQML8OoduoSGUzy0/yPnDVYamFNQrKbw
 qVX/1/8AjueKZvabfjFjkRy/CeFL4GOqSCCl/ajRQzfiS8hFaUX1W9nH2n0W/vBWnOrC
 aHrGJVSLX3quoWsSWvIIa7zxa2WcBr5vpTEeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763220796; x=1763825596;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUiLQO/DlUalxa+jjLSlV2gJnr2lR464O3I1QLKH0Og=;
 b=cep3yOhqPPSWMp8Xl+M222rM4xvC7EZOvCGaSDtifn9VvmyJ4lRCjnt+YSPX3fq3cU
 jljACeFo3V534wIAgoifkv2PKwXIrsRX8K0uuZrLKW2EhadkOx7ewbk+leGdTkN7+HMc
 LzHKVQ1W9LA+g4Ui6yxzuHGOobie66bziy2QY4Xo7ZPTwQdiaKZtmdq5VWecA6sqf7GP
 FE6AF8ro/WohdVcgR3xuyRUppxpLGwcOGeX2MwwrLh4VmcKKeW3i1LJPFi2ZkKXiAoOm
 HAc2xLBkmMhSTE9GH5ywSKxzIHTxT1Pb4Bx9gyeo9jru3Vm6l2uys4ZwmhfbP0B61EU4
 gsxw==
X-Gm-Message-State: AOJu0YxyuY6hn5iYJpio7qWOo+JfjIthgg43rfmlPc1qwKQ1sWHFvWB9
 N6eC5fm6po57gOtnLvgwGbxgk4lQ4YmXsuiNv4qvr+KjEdSDRVanVsgoSQPUbVSHusGLM0PX13n
 LYpKCkY/B7Q==
X-Gm-Gg: ASbGnct5AGbmPB5M+VX7kSFdzLdUUzL5wUXRT/fIBSi7csl8QBZPO7P1EGgaYVVfpTB
 21AJmA7BgaQg03SN5UWGsR+k0nin+OiC2tusZVCTzH2mRA+ao3LrazxXmq/qp1Rh/svLTgioPWQ
 b3CATcIPnjrAGMhIAlSV7w5O9n37u/rLNIS0etdIXWhqUDUU6Hoa0fKj0c0O8nRQ99JmsVomT7k
 GWEaLuDq6N97ArawfHNR3RxbO+x2KrBjFWQslFlp6dpYqsJkqGPU9aZ3o/7ge7l5bTuH1oByT2a
 DKrKcqFKysGF8BLLiIysd03kNHMJNNbELJUzl0SOoHBlORg4FgGbmyBGFb1/ijuc1MtkJUytCT6
 VsYMZtdWKjf4SRMh7n1UW8qcNn4OWhx8qlLcV2//u1QrnBs5N32EW6IRtZo/3/a5TwAQ9LGPKOW
 wddAkKoZOj/Ij2JAujrIX+5qgNHkwNCMi5obaxnh4+ZDJ2knRw
X-Google-Smtp-Source: AGHT+IHxmUZDdmD7jN0dr+RyqAG/DDouQzautf5CixE2NkdwwAtHbaqT5fbeZ5cJJrdK6S6D1KmbRg==
X-Received: by 2002:a05:6808:48d4:b0:450:ae23:54f8 with SMTP id
 5614622812f47-450ae237388mr648340b6e.19.1763220796676; 
 Sat, 15 Nov 2025 07:33:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724e0055dsm2932739eaf.17.2025.11.15.07.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 07:33:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>
In-Reply-To: <26b74dd7-6fa0-4327-9b75-0c750dab5774@gmx.de>
References: <26b74dd7-6fa0-4327-9b75-0c750dab5774@gmx.de>
Subject: Re: Pull request efi-2026-01-rc3 for branch master
Message-Id: <176322079537.2593579.328432759936730962.b4-ty@konsulko.com>
Date: Sat, 15 Nov 2025 09:33:15 -0600
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

On Sat, 15 Nov 2025 13:21:58 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 6c2f2d9aa63d1642dffae7d7ac88f7ae879e13d1:
> 
>    Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-11-13
> 08:01:57 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


