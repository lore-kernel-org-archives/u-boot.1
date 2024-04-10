Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3BDCD1284
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 21:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFF3881B0;
	Wed, 10 Apr 2024 23:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cvygi6DK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3D4881D0; Wed, 10 Apr 2024 23:52:09 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F2287861
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 23:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c5ebfd8fe9so992309b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712785926; x=1713390726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/cwwgAplAhONQy4Bm8JcooAVvI0nVDvRK2vKwzQfAY=;
 b=Cvygi6DKehB+V5pB1UBM/ZeVhTr0msxznsAaA8eogahDZCdNkiFxHipDcmPKwuNUYg
 OfRwmlurqv/HNAmNznTwT11MSov6NQHmlam1giSimWcIVq1p9nFCwyngb49itr4UafDV
 uuPLJMuEZAuo6uN/4NFoQKc66g5TeMCIzdhqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712785926; x=1713390726;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/cwwgAplAhONQy4Bm8JcooAVvI0nVDvRK2vKwzQfAY=;
 b=NXFm5dnE6eHZH+75JZhbs2/ZvmLq1/JEenusSfvNhSVzwhXk2KbEyj1XhfFsMw276e
 lcFitQv+ybboFYVuNPwQ9JlJG5xI0uE/NQOp67hnsu0umizC00om1DC/zHf2TdzDI1wH
 bO3hm5GfiRZ3PtiOFX8xlQeDsan+UPSwJ8nAgknGG0lTX+AK6NIcWr4qD18n0dJ9tI8E
 C1OPRV0bbOVa02yqWVQFkczZO3xDzYMjJgK7z1tgLgQ6Ft+JdfZyrpAs24Z+/W7NeTTP
 lg5PyHAOG/ngxSslp+/StZR099vyWyr+E3mDJ+xt2zjgcE/1h4K/extAphhhm8s/O/Dn
 vYlQ==
X-Gm-Message-State: AOJu0YwNkJToyW/3XrTYaYa8MQAiOi6jm3DNjYh0nlTRSoZNL43cNRfU
 V1onwl6cvNFKZOQN/xTDe4tzi0dVVt4E1XEb04HXor3QjT0sbzUEczlDoHKzbrE=
X-Google-Smtp-Source: AGHT+IG9kMvJvRIR735P2Kh3czssw/oAjKh45iEGSVSZqZJlUDTGHPTaFND+HDn1xkMGsxe9+1Iicg==
X-Received: by 2002:a05:6808:e:b0:3c5:f38e:af4f with SMTP id
 u14-20020a056808000e00b003c5f38eaf4fmr4605888oic.57.1712785926343; 
 Wed, 10 Apr 2024 14:52:06 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05620a124e00b0078d631f35c2sm121705qkl.24.2024.04.10.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 14:52:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Zong Li <zong.li@sifive.com>
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
Subject: Re: [PATCH 00/13] Complete decoupling of zboot logic from commands
Message-Id: <171278592441.135260.529703578872625997.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 15:52:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 03 Dec 2023 17:29:25 -0700, Simon Glass wrote:

> This series refactors the zboot code to allow it to be used with
> CONFIG_COMMAND disabled.
> 
> A new zboot_run() function is used to boot a zimage.
> 
> This is cmde (part e of CMDLINE refactoring)
> It depends on dm/cmdd-working
> which depends on dm/bootstda-working
> which depends on dm/cmdc-working
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


