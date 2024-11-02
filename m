Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30FFE6781A
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64ADF89169;
	Sun,  3 Nov 2024 00:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gv29ryFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08CC892DB; Sun,  3 Nov 2024 00:25:26 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA149892CE
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b155da5b0cso248382785a.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589923; x=1731194723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LH1Kz/vRuHuQg0Wd1+tmF0CON4qzLq8ArDSKX8XeNrc=;
 b=Gv29ryFoagAe6tKuancsKFgqtStjPNZjoDD2OH2aPB9tYB/j+2Parr1+YeeoLDSfCj
 i2KD7VelcLjCtei6102IxdvzuAYnbNnEa6Vq5XNHqINKP1SGgGg/+QmHhGBMUOcTPD9w
 5vm6aOWp8SatRQt4+gVbYXC+oJ5r5x0HFonfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589923; x=1731194723;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LH1Kz/vRuHuQg0Wd1+tmF0CON4qzLq8ArDSKX8XeNrc=;
 b=Kkb5T6MSac7kkzJ/bQpWGMaYkvG0OngWzx+yH9PU9tnNogPtNbgxorHG/+2Yv7r7v5
 I2m9Yl8gwZ9Ngt8q3SgaHgoqaWlkeh80B7vGx7SBV3U4mCR7iB0v3gdvwtt8b64U7eBJ
 5kZYecwYBGO5derlM3CMCmFgW40ZelZEgTvSKq7b28e4jxNMr9yncJLNRNH1Xyn7JyU7
 KzFrrL3B+1LAOmISmyvYVJbnyot4a2TBEj+pi06HjyDLiuNTBbEqUEuRBmUQfBO0Q11a
 ewfSM+BWipDhgEKvsXQHBPjaf76lc+4caV5CnC5zmA/v99JSuxn3P42zNiagZwVlj6Ka
 Q6EQ==
X-Gm-Message-State: AOJu0YwuXuGkuItnxAFdP3MMMymvzoLPSF7M3o+gGxDzUfDMjF3oIZga
 auwUhk0F0w84Ec2TzCYClEKfCgcsJ0l2WrvlOmyf2XUs+9wt/pLmn1ZTtRGwyLNHmuU5yd4FUXW
 X
X-Google-Smtp-Source: AGHT+IHEEyyho+J4nalvjpoIgy94BUrTyyho1bp9XdzNVJlgiF1xYvN2MlnguI0gYTttNJjl0dFIig==
X-Received: by 2002:a05:620a:243:b0:7b1:c604:b26c with SMTP id
 af79cd13be357-7b1c604b4a8mr1507424785a.53.1730589923475; 
 Sat, 02 Nov 2024 16:25:23 -0700 (PDT)
Received: from [127.0.1.1] ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad19b4f5sm32412141cf.83.2024.11.02.16.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:25:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241030003649.3506474-1-trini@konsulko.com>
References: <20241030003649.3506474-1-trini@konsulko.com>
Subject: Re: [PATCH] test/cmd/mem_copy.c: Use CONFIG_SYS_LOAD_ADDR for base
Message-Id: <173058992163.1044919.1660170006731631581.b4-ty@konsulko.com>
Date: Sat, 02 Nov 2024 17:25:21 -0600
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

On Tue, 29 Oct 2024 18:36:49 -0600, Tom Rini wrote:

> When reading/writing to memory we cannot assume that a base address of
> 0x0 is correct and functional. So use CONFIG_SYS_LOAD_ADDR as the base
> from which we add a bit more padding and being our tests.
> 
> 

Applied to local tree/v2-tidy-test-dir, thanks!

-- 
Tom


