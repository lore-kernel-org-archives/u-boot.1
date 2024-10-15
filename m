Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FADAD1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA43488D15;
	Tue, 15 Oct 2024 21:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="btbW2Vv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640C18888F; Tue, 15 Oct 2024 21:44:07 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BA688CC5
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b10f298052so281198385a.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021444; x=1729626244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgX8o2VkmR6J4iGtOVacHbNCnKxDaSTB0q/A2bBvLKM=;
 b=btbW2Vv0WdnbEx4l8FyZ/Aiqb9XDL10RXVCd7DrHsth7vG370B/qPH2IksJtoVs6jM
 KpLQz6DecEY6dVPDam/5HLIKFUHIUe/XNibyzaQrbujhq2QZJEyO1At0s7V7sAU7PHeK
 MeusSW3KBI70Bbbzv+kVM6fEoMc5cR25ksygE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021444; x=1729626244;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgX8o2VkmR6J4iGtOVacHbNCnKxDaSTB0q/A2bBvLKM=;
 b=HI05pCui1sMmJHgyN5n2KOGjzRQLQ5vOGTxMkhssdptuwaMisBWSZc2vtY9/CZ4na8
 reOtMANTznlCqwmgexcwkBcsaYNqrd/c0dfNZMMiAvFLZ2zBX4BhWAlcadZTbOA1WdzK
 wI48o2BD4nx87IHOjxD/nBORHYKwz2qwBvEPzODTiMykpVTSx9boWtVW1Nf533bYkXVK
 L1uTr8QrIxhua1/npwR2mTBznyT+fXqyUHLRCNHqnMh1d0EzI12Yw1klW+DBa8ThTmpb
 opOSKzAPkE1n8EBTySy6rtvNx1pYDcQIfAD0HuoVYYLVhxWq/afvPfVhagsXuf6kxkh0
 1JWg==
X-Gm-Message-State: AOJu0Yyd7Ow9nEMTN1z2qyPiy/ATvzIJRcEwEzRtO2kf/5t2gAxBsbca
 XP5PZWiXiyULTuILVvn2P7OlrQ8OEkwCj35Mj/A602wrvJCcf7SGp8POLUyTb9qvt6kzHfiIZTl
 Z/7E=
X-Google-Smtp-Source: AGHT+IF9sKcQynuVTlfu/DX+/vROI/NfMs8HTNd/o83PrmMX2iTC0Hoi7Sr922S8OcJoGn+XqQ0h5Q==
X-Received: by 2002:a05:620a:4402:b0:7a9:ad65:f4a1 with SMTP id
 af79cd13be357-7b1417f78aemr194910585a.26.1729021444018; 
 Tue, 15 Oct 2024 12:44:04 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:44:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20241014201753.1902999-1-sjg@chromium.org>
References: <20241014201753.1902999-1-sjg@chromium.org>
Subject: Re: [PATCH] test: Drop mention of old flags in a comment
Message-Id: <172902144297.5381.8975103179199295187.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:44:02 -0600
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

On Mon, 14 Oct 2024 14:17:53 -0600, Simon Glass wrote:

> A comment in test-main.c was not updated with the recent rename. Fix it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


