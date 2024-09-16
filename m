Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521CBC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 20:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A953188EF5;
	Mon, 16 Sep 2024 22:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VYNJfgW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3224088F16; Mon, 16 Sep 2024 22:41:44 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4AF88ED0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 22:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c35427935eso26152466d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726519301; x=1727124101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=901bdAVYOwN4DQvphWB5Bt6b6+L0Aj0othqSnpE2FhQ=;
 b=VYNJfgW2Femm3SWCm2ubzsWSfRdItlZRlj8C8UxTAGZJXuYCq5sBLKhW2cLupUXJb4
 IszPEZiod5u6WrKPfLOSu3uVIWWRQJGl6t5qCXYv77Ugy9qX68NVvKBCfQmJH3BI2msN
 1g5cyNgNhUq9T9IISRdoEqiox+LC0teJmb/9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726519301; x=1727124101;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=901bdAVYOwN4DQvphWB5Bt6b6+L0Aj0othqSnpE2FhQ=;
 b=c7F4pAAOCBGq8gSHJbveaf0nN9AKsZ9mSaj1XXDEhHkQiBRMLQCDcf8ssFseGzMJ20
 Wv512npbZZUtqLrBnHebJZbJNMDtQkmIW6gU+1pLqVmiEIzUiA0bDuvYfNRzp0p+ygWQ
 02beyY3gx2CO9+Z8bOwi/ulpAteAmwhH0tgyi7vZ2idQsbN8DHm4OG8bV5aYj9nP0/Fu
 J1bidvruyD/8Zy2ahCW7b90pQtsgocrG0H/BKN5j9BzHycuhD8erHHS098D4sw2j+Vtm
 FK6YGhYDJCML8cA2c+SD6solNUFa0OoT16peS2qMLtaHbI2Jrx+FXDsKdAObHO+kGk8q
 9VHg==
X-Gm-Message-State: AOJu0YweF1HO/iKBlFU9+RD8TDIugzE+3U1W3SIuZ+oA94bHTKsBfMSX
 ex+y6+ygjGSyXXigqPwp52YCK1nx9Xxu/Qqyv+rmWOyO0VQVYuXrzD5Ggnx+c64=
X-Google-Smtp-Source: AGHT+IFnAhcK/3mw72Kmp0U/efaTn7IkOsUZ1gz5o+2H1r/YSDI6BlEuNJJrN+AJ+S/jaIrBbVGpIQ==
X-Received: by 2002:a05:6214:2b82:b0:6c3:5d9f:cea6 with SMTP id
 6a1803df08f44-6c5735832eamr263948726d6.27.1726519300820; 
 Mon, 16 Sep 2024 13:41:40 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c645df1sm28000266d6.70.2024.09.16.13.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 13:41:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240826163917.2786791-1-trini@konsulko.com>
References: <20240826163917.2786791-1-trini@konsulko.com>
Subject: Re: (subset) [PATCH] doc/develop/sending_patches.rst: Clarify when
 to use which branch
Message-Id: <172651929972.1958144.16416991374297367976.b4-ty@konsulko.com>
Date: Mon, 16 Sep 2024 14:41:39 -0600
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

On Mon, 26 Aug 2024 10:39:17 -0600, Tom Rini wrote:

> The previous wording on the paragraph about what branch to use when
> submitting patches did not reflect how / when the next branch is
> currently used. Reword this to note that master should be used for bug
> and regression fixes, always, and that next should be used once it
> opens, with -rc2.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


