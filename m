Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C13E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 23:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0708022B;
	Thu, 19 Dec 2024 00:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HN7fvZQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D7D680316; Thu, 19 Dec 2024 00:26:16 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D059F8021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 00:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6e9586b82so10939285a.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734564372; x=1735169172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsQuFcQkOAcs57xiWI0AhyyqjA0peyI7GqAFpHEbqJw=;
 b=HN7fvZQXY5z7VWKjDA7EVVNS49goCERAGFu/QvUpu5XuqHISk7yRinjU16zM9kTpn3
 g4jRg4v9mE6rAxIq79YpADcnv4RlGrgX+7Z7XWFI7B4OnvMl9E9AcaUlwkEN73X4AvAA
 EUxSsSt5ms+BhZMLjsnmAdnSPuRulnMphwQq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734564372; x=1735169172;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsQuFcQkOAcs57xiWI0AhyyqjA0peyI7GqAFpHEbqJw=;
 b=aI1QuSj767Dg7R75UAVGiszrG26h/3YlMCcMvumE7xq/UTeEyEa6l22vAPXPIuCu0v
 EuqopoiHuAyuWlx22idCVetQVHrFRL8UTv8u5ZgtLut7aQ1lNJhbBsTgs/yVu3n+PriG
 RPPTP/9AXQ6tVZGyaxs6fjciK6TuaXFKyHqstHQbmKhz6MOWOMg3IGWg9zH6LUc4c+zR
 TgRvjabYJYPO4hpewfwKEwjqs9b8lKSo4vIZi1QeG3xBJat74bwf8RGKQEpHLsBsLNLD
 E0X8QhKIQ47/USH8sVWj8Wk0lilYusNGyoka7mCGI6WU/fVn2uc3VnL9KvZMo0CEr0IR
 7VTg==
X-Gm-Message-State: AOJu0YzTAcY71oxjuHtCRSEIkLyTeYNN4ghIrX/rCVuRZSuaZTpIUElE
 xFjl2Il//UR8SzvGBfx9ullcAKXO8x6vQAPtbYB4+4SmyrgmRCrCnO6fXUsgy/4=
X-Gm-Gg: ASbGncvMeFR8YCmgNsPs9g9Ma7koqKsjs3RZpX1cR6kLWZm5ux//v3DKcCtdNudPc2V
 q2c78moRNWQXYBuG8D7RpJCKQ3fiQ+CZlJ7fzA3o75Rgk3XOCglU6qQHb++jU4qgMF+2zkzHLS8
 TnTm1vDqgjwrC5h8g81rInI1HGIKCj4suxvd7lJHSKiFh2IeCTNzBsUxAtGty5aBnpRpX1nNTfL
 1Av5llDYZ/IqUZEZU4bsLR/1d4zXsWkGbrXl7jqyzgYUA2yHe6vtdM=
X-Google-Smtp-Source: AGHT+IGtC/q1wFHHwrFmvuwfGc/QqYMAzRu+W80IsynbCpNoRX1W9eHadqDN/EpCHe5GmQkJG/MitA==
X-Received: by 2002:a05:620a:404b:b0:7b6:e0aa:48b6 with SMTP id
 af79cd13be357-7b8638c40e8mr726792185a.62.1734564372773; 
 Wed, 18 Dec 2024 15:26:12 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e653f52sm270821cf.16.2024.12.18.15.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 15:26:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: sjg@chromium.org, paul.henrysd@gmail.com
In-Reply-To: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
References: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH 1/1] arch: x86: lib: Add support of legacy 64-bit entry
 point at 0x200
Message-Id: <173456437186.3535347.11285269991727289370.b4-ty@konsulko.com>
Date: Wed, 18 Dec 2024 17:26:11 -0600
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

On Wed, 20 Nov 2024 11:39:43 +0100, Paul HENRYS wrote:

> Support of legacy 64-bit entry point was already present when booting a bzimage
> with 'zboot' but not supported with 'bootm' when the x86_64 Linux kernel is
> embedded in a FIT image.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


