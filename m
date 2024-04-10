Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD467CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D991881B9;
	Wed, 10 Apr 2024 19:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SaY42Zb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BD1878A1; Wed, 10 Apr 2024 19:43:21 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C8887D8E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78d723c0dc5so134103385a.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712770998; x=1713375798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bg0APPmqtb7AxwuPs/qKTK9fPfHIF2uJ5IoF/3QmuZg=;
 b=SaY42Zb2+6AHKvnJgSa12wAekKib8UHOTk5/9J5lh5zQfNk1fqkRKgHT4YHsw+wxsF
 Z+vFqBbYrQwoSPo7oIYJAVFvOXS+XimG4GNOEylNFLe34wbzGyoxOdFE6SJ82JtjwLv2
 cHey0KgZO8aUbK5DZy2l+/0MayJTKXISog4rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712770998; x=1713375798;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg0APPmqtb7AxwuPs/qKTK9fPfHIF2uJ5IoF/3QmuZg=;
 b=lejRJEH1WM72law1rr+thq77LxPBw8TIBaQNPtDRNRD9GMfZz7wtcpgtenazNEuJWg
 nJAO7AQgxpzzG/RBG8lnS8+fLPqFayGt8dhJlVULkiqf0ARFgIeSyVn3iMVPvGTKPICo
 Mwi6r7DvWcrwAnpjjC/jMdjqwUb/U5cSkH8sXLQ3EKNxAvorov2QWzsnGMlY3/qiSsLc
 a+3IpjkUP61hjkI1mLYRLO9zpyihl+wVpNiRa937x2jJJsqIlO5SMqDt4dllWCGuA6w7
 qWuECMFfFnZ1X9ZlykT0oudQ14q9N2887+MWOhWTMMtPMXiB9ro0esSuBJ/t/kxeJuPE
 srzQ==
X-Gm-Message-State: AOJu0YwEz3bM8oh8Xq/fZ0ds6QTiPXiM3yi3NYwKz4naxX73us579KQ2
 maL3qMocxMemBp43oovtoXcpD6GymhXJax8hlLrpRgbsrghl0gCSzvpHxW9TLPW0xSJosHKdWtj
 wQJcsLA==
X-Google-Smtp-Source: AGHT+IENG0aCnfcDMPnnXWRG14Z3CZQAY0h2vRIYvsB+CpcJMCHlrcfswBQg1wDTpNz7EGaFXBB4Vg==
X-Received: by 2002:a05:620a:839b:b0:78e:13f1:303e with SMTP id
 pb27-20020a05620a839b00b0078e13f1303emr2737429qkn.54.1712770998205; 
 Wed, 10 Apr 2024 10:43:18 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jixiong Hu <Jixiong.Hu@mediatek.com>
Cc: jjhiblot@ti.com
In-Reply-To: <20240319092041.8089-1-Jixiong.Hu@mediatek.com>
References: <20240319092041.8089-1-Jixiong.Hu@mediatek.com>
Subject: Re: [PATCH] fs: ext4: Change the Settings of file permissions
Message-Id: <171277099739.98421.9580891400053922740.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:17 -0600
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

On Tue, 19 Mar 2024 17:20:40 +0800, Jixiong Hu wrote:

> When a file is created in the linux and corresponding file permission
> is set, if the file needs to be modified in uboot during the startup
> process, the modified file permission will be reset to 755. Therefore,
> when the ext4fs_write() function is called, if the file already exists,
> the file permission of the new file is equal to the file permission of
> the existing file.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


