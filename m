Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1A6C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A8387CE9;
	Tue, 30 Jan 2024 02:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IP/9h2ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C432F87BDB; Tue, 30 Jan 2024 02:54:16 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159A487CDD
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-602d222c078so36646937b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579652; x=1707184452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BNGsuMjAf31cVmTtjjSkd9kcKx7Dwxiwi/Aj2vClgQ=;
 b=IP/9h2geaFE59CSjE74+sr8D8rBN1KWueN2PLfYhoEBiVKmtsZfoVl0DrBDEvxeF7x
 wwGuninSoV/s7EcOh8xb2tu+odkQfzV5ypLo/gYoaH2vnQR2Jy/jxAUlDt1ps/TzkHtP
 VzduJrRfA4VQ4v7Ph+ZStczRf8eOwp7CHKC6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579652; x=1707184452;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BNGsuMjAf31cVmTtjjSkd9kcKx7Dwxiwi/Aj2vClgQ=;
 b=AkB0D+o7E40fFdnQWidilbSBg3SdmEzB/nZQx3HFouT7Bm42bpU6VGbQWHJfmnlmhb
 8kLouMBtc+VnX0L7YLSLOvBfP+FsteLPbR9rsrih6MGsJ+kuNth0SmzpvghILnqupQ36
 WsK1xuVe3lo5u6ukPIqSu7f7jGBkQh+66bAsEEbsSqkRWDHQmk3vdfG9d0X4Svc7nHut
 lmNfc3ofFGmkDCm0ddMJlQrtdmLK/1inrkjqgcIOR6uJ+M1+pjj2xWWNo/VvjlTvSjJs
 tWLgeyIgGM62fOywmcVWr5FIQG6rAmZMSYFysF1GZJGvOPjGTeFVUdm2vlTcCzfrp1Vn
 np6w==
X-Gm-Message-State: AOJu0Yzg5erydckLyls3nEFTMOKFAjbOLi2IFIxZ/8PKhu88HjjiNEhl
 UuR2BsM2b9KXZnW6oOR+hmHqvIinY4giB1oVqs/AIurajbX4xfeDeN6vD6LSh7BdpvCd77kD5rp
 T
X-Google-Smtp-Source: AGHT+IHpmi/crN9kEZjC/Mpfot0KD7dIQ/wOJmp3eymu859971B9rDR0p/tOJ6IoAHpxJ/5EnpfKsg==
X-Received: by 2002:a81:b1c4:0:b0:5ff:5cfd:7127 with SMTP id
 p187-20020a81b1c4000000b005ff5cfd7127mr6087169ywh.14.1706579652693; 
 Mon, 29 Jan 2024 17:54:12 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240117-console_truetype_x2r10g10b10-v1-1-25b11c6d7e40@jannau.net>
References: <20240117-console_truetype_x2r10g10b10-v1-1-25b11c6d7e40@jannau.net>
Subject: Re: [PATCH] video: Support VIDEO_X2R10G10B10 in truetype console
Message-Id: <170657965195.1823400.10532675539363237294.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 17 Jan 2024 23:27:34 +0100, Janne Grunau wrote:

> Without explicit support for VIDEO_X2R10G10B10 VIDEO_X8R8G8B8 white
> will be rendered as cyan-ish. The conversion leaves to lowest 2 bits
> unset for more compact code.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


