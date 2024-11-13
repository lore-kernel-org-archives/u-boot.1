Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3665AD637A3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EECA891A0;
	Wed, 13 Nov 2024 18:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N3491p59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D518955B; Wed, 13 Nov 2024 18:40:50 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A1689417
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e6075cba82so3804443b6e.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731519647; x=1732124447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdywctmGZ1vRwO51xLgqcEOfuznU21waWJ9AuZrZ+d8=;
 b=N3491p59s5uP7KFbxBpIBh2RXJCnAFNvQ6thV+v9cWk+f0eQbxivBzRSNspZ86Jj++
 X2vAcvFajFSfVQnSR3JzivLjCF4PM4Otc5OkI3mo6Y2QXEmstenem0bPlJcToF5C3VLb
 msgn2jPGDEDmF+gsKGbgPErZzNPHx2tJj9iFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519647; x=1732124447;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdywctmGZ1vRwO51xLgqcEOfuznU21waWJ9AuZrZ+d8=;
 b=rlsP2meBqNvbEOu/Fc/O6F6CzZM1UiQ9Qe+QxfzHJOAK5HsN9NJiptwnqHq85am57Z
 egIAjbB0j9FpFCT6FI1k2UPKCzC13NZ1yTWJ287Za8a9OFts5eq/yE8lQDRwoxin+nh5
 mU8Vw+3NDImqhPW/vLgrLxZborzlN9hy2n1Oeo9GI5NI0M4mJJCMALF8y5It3khcOXEB
 7RiHbXjJ6RuUzHEhofvK3l4Yw82ylpIefof8AUG99nqpR8HivKGo25H15b9B6Hx7pB1Y
 htf6uvrW2HqOXe4OQHVZFvKVIZl7ofJDsW5BKOlxW/RkKMydnzhy9ChcCmPT0EkY43LV
 W9DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwzDV1fVCFZJeEmXfbgV/9YAmFv3NRaPQ6RLzzwKgpYEZE6LtSWAmJ3tAPvxbuxUHbuo6oVRo=@lists.denx.de
X-Gm-Message-State: AOJu0YxMAlS23zJgaHq8Xc7qf2zJOpQGBLEEW9WXd0jRIa7mjZFY+3s6
 CcVJvbSL+IJqlVSCQHSFu4FIs9naK7fQX3mIof6oFPFA3gIc+zyuKfe0vI3dnEx7hptl8XXZPu/
 GtFM=
X-Google-Smtp-Source: AGHT+IFz8rwkDESm8WRuDFNKoeEWt7yLYFMdmKt87yespB5G3Z5wMsWej6qU7QCnLi4yaQa9ys360Q==
X-Received: by 2002:a05:6808:201b:b0:3e6:5f5:5e25 with SMTP id
 5614622812f47-3e7946a5fd0mr20559350b6e.19.1731519647085; 
 Wed, 13 Nov 2024 09:40:47 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096bdabsm736295b6e.21.2024.11.13.09.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20241107093854.42184-1-heinrich.schuchardt@canonical.com>
References: <20241107093854.42184-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs: ext4: correct error handling
Message-Id: <173151964557.1299521.10602933653472960986.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 11:40:45 -0600
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

On Thu, 07 Nov 2024 10:38:53 +0100, Heinrich Schuchardt wrote:

> After calling strdup() check the returned pointer.
> 
> Avoid a memory leak if the directory is not found.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


