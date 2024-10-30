Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432D0D6B6B4
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 22:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A30889228;
	Wed, 30 Oct 2024 23:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SRTuuNd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DC189265; Wed, 30 Oct 2024 23:59:36 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E48689212
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46090640f0cso3360461cf.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730329173; x=1730933973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAbHWBKKrkACYdlGoK8J067mzQzmC+W/nAlg4At714Q=;
 b=SRTuuNd5g720nQ7BoYr19wg1BLlsrHHSiwKkOdKW0HWeW9heeMJ+wWFRfZnGqdnInw
 tlFUkHigpyRcyJlIjhnBxzMWty5zu9P0c7cBN5WZotIMVqVbRkBUjtAa+rjmIqQdez0v
 nWUkWI4xu8kWmF1lRx9eTrP4/4um7wCS4UM+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730329173; x=1730933973;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAbHWBKKrkACYdlGoK8J067mzQzmC+W/nAlg4At714Q=;
 b=fmKfsPAtc8UPDp+LdeIJ6bgeWIRuJGP9K/B1svRdEo//ZaWeUWbeecpgwIOEX9q0Wl
 /tp1cJ+Jd53OgRPKLbDeEzQ9OYyzdv2wss//RyhY2A873POEnquaoMUqlufrilN/tOUz
 wJ7UAZmTDUldBpazDIEKzwU5tWEsOPduMyy+EfZ0zW82nTiHqV1oe8r8gq7j9DyMKX+G
 w+iIdQoj+ZmhftSktQTaVHrvJO44QtTcWIJOpEHpDzk5pnpJJVdJ1GsP87UjrEjXrFDL
 Xq8AQNTfg0HvJeJ4zqUrNA7h+ZHwtt/HsrSS2I6WcEhVEXbGZGfqOEHQwzNo+9IjWM2r
 RKcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+xN5YczA+5yoYev/Sve7TIR1ubfxoNtYUIMVmVmEQ89qc+8Pn/MoXnJX16LgJu7ITj0PLCAc=@lists.denx.de
X-Gm-Message-State: AOJu0YylBsvI59uAcNWNJ/8s9/vAZ8o4TXPd8e/UtXeeFPmpz4p8xSZU
 0Wv4HTeE5N/h63mMVF/4G+Eiu5dr5s5+/yH3uCA8nSMn6cqoXpNlEzt1JCVUpfY=
X-Google-Smtp-Source: AGHT+IGZCzCvkrrA6KNUqH49HwxoJM9KIjS4qJ5dSh2S/zU2oHOEJkpHpW1LBk0zFWEFNYuLQ5Z7ZQ==
X-Received: by 2002:a05:622a:106:b0:460:aac2:5c06 with SMTP id
 d75a77b69052e-4613c181a0cmr248210541cf.57.1730329172974; 
 Wed, 30 Oct 2024 15:59:32 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0896e9sm1257861cf.11.2024.10.30.15.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 15:59:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: jagan@amarulasolutions.com, vigneshr@ti.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: marex@denx.de, u-boot@lists.denx.de
In-Reply-To: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
References: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add tambarus as reviewer for SPI NOR
Message-Id: <173032917120.2233801.16288081359679513685.b4-ty@konsulko.com>
Date: Wed, 30 Oct 2024 16:59:31 -0600
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

On Wed, 30 Oct 2024 11:02:21 +0000, Tudor Ambarus wrote:

> I'd like to get Cc'ed to u-boot's SPI NOR patches to help review them.
> The ultimate goal is to have an aligned approach in u-boot and linux.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


