Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D85CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 18:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5D48367F;
	Thu, 16 Oct 2025 20:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPjIfDgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74120836A3; Thu, 16 Oct 2025 20:28:37 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D19F83631
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 20:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4439ecf6004so349360b6e.1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760639314; x=1761244114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr9IXf6tqufQp/kuvGLJKb1VDYXxcyre7G4GfKv22Yc=;
 b=GPjIfDgEpzGndqazCgVl7J1qfPAk+YmMrZ/6CPGtm/ey56VTPQBYO0+b2+wPoNmbwL
 gDYhPmUWDw5y0A8p88ONTFadcqBxnfi5s/1Z9v6oS2V844Obg9t8R3yLzPgB/yl13aES
 hycgzU9SUBkiyxkgiLK6s8gzNZkVJvi2ZtfI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760639314; x=1761244114;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tr9IXf6tqufQp/kuvGLJKb1VDYXxcyre7G4GfKv22Yc=;
 b=FEyMG8vqqjYO7C0fsuWV8erxthfun+iGmVP0dPoJ1eCmJvRYN31CLuFlqiEIX2Dhci
 cfpzL1V2pcaFtWossKpb+lV0YPfXxQVk4fA4Bs2klVerHZ/wsT2GxqVxw+oqb8f85mVO
 r8cii16Vdq6UqIRZp54X/N5rmyztfG6WCr9gvg0+S7MAqfjJUbRq4WG1DjhYK1F1NcFQ
 eDBphSsxPXWUsIN986Dl2U2Qd7hyGM9KF32ptT4OjQ4ZsK5MnQt0nJMBY9TaLUjgGN8D
 2PKmCiJcXvgXnuvwpj1yzZQYvnO6Vbha3DDOyk3OExKwvtwvL7AvMhJcXUN5h5vEH1Wh
 8Olw==
X-Gm-Message-State: AOJu0YzBNixS2/6Mc7sfQ87czaBV3kyIPv8tqv5PTfyKPaH2UqNNbxhQ
 oM4DXo+xd5X1qS2lR0ku5Mi8chJk1Vl1lvwyh4dUZgFMRjLiXAxwLGsFFVbazAKh1pA=
X-Gm-Gg: ASbGnctQ76np9J0aG+Krat0HBkZDwaWW1udGH+8gmdtACSPWq1sawz+Cncjm4FeFKH/
 WlkGcJFHlDYa9Iao/ygbi3Tf+Cz0tS5rrQc6Wf+A3KfymobCwJktYEAe2w4YWtRnePuQ2eV6lFX
 pzPDFJier8C81omD2iRY7gQlhKgvtrCJDlb6gtHBE2VfcVQ9HUL3rKoeSaC8CRpCBYtgKLLXwAO
 2QRGvboyLLeQQZEOCUgDB/43ylnLPvwKoYSJR7arzE04YRZ4acDi09wEHT+ZfH201sb0B+wm2Qc
 wcAjOaZwu1TquqZf8c+7ASShf/viX0gSE6F/6+Eb3lBY3XUItsVu6wL3DOVW59wbxXxjFbW9JMv
 PNWChzY+0I6yShq71vplUxdnuTnu9jVoB7LAgQjikhS3NOfXfjMV3iYbTDnsZnJECG04TxPa4HM
 /itEjDH9t6kWVJsQ9ck3l4VIJogIf2aQ62YE2e0ZAk9ZKQOv7d
X-Google-Smtp-Source: AGHT+IFDpyqkBoJ8P1Qx8imMwBiwrqXLRM8XXvTWaBQ7P9BrP0CBJnIkMlSNJ32sSdWloAZiQHqrOg==
X-Received: by 2002:a05:6808:1907:b0:441:8f74:f00 with SMTP id
 5614622812f47-443a1acb829mr659679b6e.29.1760639313988; 
 Thu, 16 Oct 2025 11:28:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44202cf0a4esm698931b6e.24.2025.10.16.11.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 11:28:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20251003191918.767698-1-raymond.mao@linaro.org>
References: <20251003191918.767698-1-raymond.mao@linaro.org>
Subject: Re: [PATCH u-boot-test-hooks 1/4] travis-ci: Group the QEMU args
Message-Id: <176063931205.221550.14928650820544533018.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 12:28:32 -0600
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

On Fri, 03 Oct 2025 12:19:10 -0700, Raymond Mao wrote:

> Make grouping of QEMU args to break the long line and modernize it
> with '-m' and '-semihosting-config'.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/4] travis-ci: Group the QEMU args
      commit: 0d55075bc992ae3a83545de8f3b4e0b2c1067a12
[2/4] bin: Run the conf without board_ident as default
      commit: 48a0f7fa96199284de11932f8be142ee87524455
[3/4] bin: Add support for testing firmware handoff on qemu_arm64
      commit: 0b615349974c28fe644f5b170ffd0ec1f248c767
[4/4] travis-ci: Introduce env for Firmware Handoff testing
      commit: a1020f3be5cdde2285faf8e90c31bc4df121bde4
-- 
Tom


