Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE3BC5473F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E41E88AA8;
	Wed, 28 Aug 2024 01:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WdkcLhLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E368388AA4; Wed, 28 Aug 2024 01:22:57 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497EF88ABA
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5c8c1006eso4375893eaf.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800974; x=1725405774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSJ4IkXPkzt0E1fhZDg0WOeTvWYwXFpCe2VnDmw9Qfw=;
 b=WdkcLhLd010pTQ0u/D7cxaXeSfKN3mSjlz+uZUqU2Pm/lhLEChiPUmnF5rgI2vi2AL
 iQVJvy1qCG/9SDTYueVEjOMsps8YoIprgmbGxeWht9Y4xc+8Gf7jVbKwtaBVCZbtiRW1
 Q49BDX86SZnl4PpTC5GQ/teX2z9O+hJU5yVCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800974; x=1725405774;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSJ4IkXPkzt0E1fhZDg0WOeTvWYwXFpCe2VnDmw9Qfw=;
 b=SgaSrurA8KRKtR6PPqSr2mR7IR7f9O5XQIGXDwFoCBynrkNBdvnEfhWQzCpwEDH9mi
 Uynj9LctXIJGXHXUgLdp/koA5IGhp6ILOB1Rxp6uJwpFBEhnKSU2bxqabhDcu1Dw7IQu
 ykFRkn8fDcswdn19e7cfrKeP4wgbT/SH26sbcaPrsQcQ6VLVo9hK+4/5JedIailMoyqO
 X2rJsVOL+xA4gDw8SebG03kVV6P1G8Jktsd4aBEhFWNwAXSvYHIsC4AsySk7q7TR83nZ
 QyRgKUhu46qp0xmuYJSVFYQK3oEj6yatyelsJ/psir+ykNd2fHZklbCQcI+5P/oqXtya
 VFrA==
X-Gm-Message-State: AOJu0Yz/SuZVkpPUNyo4H5YaCpi1sNV+bYt4Wmsqc0oONEu6FXaWl+wi
 sL3Lt6PV7c5bG9+z6z/8ihnGg/Nesxu+n8lzFGbBYsZfgdzufPfZ2RZLcV175r0=
X-Google-Smtp-Source: AGHT+IF8s8h2c1bFdRQgnw47fyr/+3v6Ccabcw0dMFxqsQOrdBIl0RPODOV2RLD89Fzo6mXS3moJmw==
X-Received: by 2002:a05:6820:22a9:b0:5d8:6769:9d85 with SMTP id
 006d021491bc7-5dcc6259314mr15404479eaf.6.1724800973906; 
 Tue, 27 Aug 2024 16:22:53 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240729090406.3738089-1-JJLIU0@nuvoton.com>
References: <20240729090406.3738089-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] timer: npcm: Change counter source
Message-Id: <172480097288.2972894.3700646168697008191.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:52 -0600
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

On Mon, 29 Jul 2024 17:04:06 +0800, Jim Liu wrote:

> The counter value read from TDR register may not be correct.
> Read SECCNT and CNTR25M instead to get the correct timestamp.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


