Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D84FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7600A88457;
	Wed, 17 Apr 2024 02:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Se6Ox6cB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB2C8836E; Wed, 17 Apr 2024 02:28:40 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2813688457
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6962a97752eso33680506d6.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713313714; x=1713918514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsEwObD6bXwkwxwIpZp19U4a+mI2LjmfAqJefRuT/t4=;
 b=Se6Ox6cB2S0Ry4r2sqxEUcfBHS5gwOGMfcqzafiHZP/xNUloWOhY6P0ZvW4vLioaIm
 PohHQqcy2t5veqCfR5szyQVe5JdgkHvMYEFhkWM682utMjJPxCvhR+mDTk4TXIkeUdbV
 v/bMFgote6FzrhKjYwKKzzlp+Aoy1bs1iDvLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713313714; x=1713918514;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsEwObD6bXwkwxwIpZp19U4a+mI2LjmfAqJefRuT/t4=;
 b=nKSVNYBesz4HcHwqL8zTIc6Irx6UDV3/6E/FT+I/JcJv5MJaxSsKFCJx0PsNKkmyJv
 vFiW5GJox8HdL0kzW3ESji4hvbPd5o4CSrK8Cny9RMD/WNJMWFrFQB6mNixyTHlR/UJu
 9SIdw+5MYD1GjPG+J7qH9Pwec4mmrrupmofWQ+ANbITD30Rkm1sUEGOPkaFfro6MjurA
 oHUNtqH5IeUFsZMAW5wSQLEobvQqG5EIo92/kAy3m2uuiGuwBIHSbBBSnNwmDuv7z9wS
 Buh5aqllz37Ww19Ltb7gWuAO3bKLNT5MXmfxCV4+sbyX9V2bBTleYQWcaEy/wkEp0fZ2
 gy9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpsbOoOxSTEMsaJEAriCiJCZhT4ud7TCo/fzyoZtnSD2/wYlrN4saL1MEuZ08Q8xG0khE2Vruoo7dsreNWC5jK63R8Rw==
X-Gm-Message-State: AOJu0YzUALJDSyxQk+KPRmMc3EPNWcZMDBPq+BQ1RpAPiir978svbXTE
 rd27i+pJiBfhdUao07B4nGjwAmZ25WmqMoMqX/ue8+fbVE4CVJdToBDne4UAzzQVFaVpABZQdmr
 a7aM=
X-Google-Smtp-Source: AGHT+IHjyRl69V9af7wWP8QvIoE5xqM62vb4dhvW4o4hpmobxB5AoqreaZthhzPi1xMTzjsePmZo/A==
X-Received: by 2002:a05:6214:d46:b0:69b:6afa:f15f with SMTP id
 6-20020a0562140d4600b0069b6afaf15fmr12097961qvr.33.1713313714563; 
 Tue, 16 Apr 2024 17:28:34 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 ec7-20020ad44e67000000b0069b61f8c0a1sm5389607qvb.42.2024.04.16.17.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 17:28:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20240416002624.1909-1-yasuharu.shibata@gmail.com>
References: <20240416002624.1909-1-yasuharu.shibata@gmail.com>
Subject: Re: [PATCH v2] net: wget: fix TCP sequence number wrap around
 issue
Message-Id: <171331371329.1158061.11862653134552730502.b4-ty@konsulko.com>
Date: Tue, 16 Apr 2024 18:28:33 -0600
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

On Tue, 16 Apr 2024 09:26:24 +0900, Yasuharu Shibata wrote:

> If tcp_seq_num is wrap around, tcp_seq_num >= initial_data_seq_num
> isn't satisfied and store_block() isn't called.
> The condition has a wrap around issue, so it is fixed in this patch.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


