Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B456BC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 21:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C98887F6;
	Tue, 23 Jul 2024 23:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X2y5E14T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D303887F6; Tue, 23 Jul 2024 23:04:25 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA44A88792
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 23:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d9e233873aso2882222b6e.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721768654; x=1722373454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5uMeqR0BJDBsXPgorykQRB1R4nQHox85m1Cci7Y/nE=;
 b=X2y5E14TJzLErY/APg1Zd3zFwdgnNXQ5A5Ap8KHOSy8FKK+IV4PkvtMm1t+BEvVkfL
 fLAZkX94BDEg77naUS2vi5sivwKUl0S100AIiEMYwubym9phl1nQY6dyNcH3ME8plw6j
 8Cbd8HbturQFeflG0EB10AZHPLLu7zdH+skMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768654; x=1722373454;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5uMeqR0BJDBsXPgorykQRB1R4nQHox85m1Cci7Y/nE=;
 b=c7prhANlNqJHhxV5zFR8i2eb6zq/qQg/Paoq1xaHPxKrAbViObnJblxb3EZM/mXRJ6
 E5B8ZrdAq8g+3VgqD9X15YN/vI5zEAeS2JNQhTmXdTpGp6xiyg7OPB+U8iJTWql0Gjw0
 qM5b7DBfDcVpFbISJc+edge0zyrGay+RxvZ11Hc6B0cxVC+lqCk8RXe6/RbOYJW0YfQN
 VTXzJ7gqHF/6a2rEbxTVm/9mP3S5K7HVMMdDGaWR0aD0v4bzSZHhaX9I4qpm+yXDBfEz
 lJ9xpcm32PiGcbEByBTB/0p5CwWAaKVdmgB4RbiVnKZfz2n5Z7utq3UZK3RIm/zX/g60
 Vl0g==
X-Gm-Message-State: AOJu0YyvLZuub74u4g4xQo+ReAtyyjBN75w3rsnP5X2ievzsgL1BzrIp
 iT5Dpo/FHGXNc84wDwOhZWalqDJDWNdXPJ5/pTx1KO8uWVsd5fK3CnNH873IDB4=
X-Google-Smtp-Source: AGHT+IEPHOGDbAh+NudnYwuq9ovmMp0oqbuL7smbRhg8uEnxQhgOUUu38wNWVnIlhSBdyNK3YVc9Fg==
X-Received: by 2002:a05:6830:621a:b0:708:e969:e0d9 with SMTP id
 46e09a7af769-70923439b04mr1198112a34.17.1721768654592; 
 Tue, 23 Jul 2024 14:04:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d59f04938bsm61321eaf.33.2024.07.23.14.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 14:04:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>
In-Reply-To: <20240720165439.3620434-1-agust@denx.de>
References: <20240720165439.3620434-1-agust@denx.de>
Subject: Re: [PATCH] pxm2: switch to DM_I2C
Message-Id: <172176865406.2258489.3970809800619544205.b4-ty@konsulko.com>
Date: Tue, 23 Jul 2024 15:04:14 -0600
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

On Sat, 20 Jul 2024 18:54:39 +0200, Anatolij Gustschin wrote:

> Enable DM_I2C to avoid board removal warning.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


