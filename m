Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570DBC25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 19:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE50877BB;
	Mon, 23 Oct 2023 21:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMMYDwiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63B886F97; Mon, 23 Oct 2023 21:09:03 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFAC86FDC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 21:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7d532da4bso36932027b3.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698088139; x=1698692939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMwBIetcPJKJfHf/LSE66tQ7yCHGTYHY16AinbJYgIo=;
 b=HMMYDwivRWtyIXxHXA4NUDRwGGUEgVSNNX+/zWJBgAxAfm5WGuxCU6syh6iUgqINKX
 ekZX1PXcfi4Og9v/gIINoHffno6Lizt/5M73Y85rAOpfD/kSxYHxn57DWn3oKc4occq0
 AqtLRsxuW6zBy8FoXmoDxlGFd8muoRfM927cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698088139; x=1698692939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMwBIetcPJKJfHf/LSE66tQ7yCHGTYHY16AinbJYgIo=;
 b=xBa1xOP0YRgOOJykv/IgpZuFME/d+iXAERQpSunWcEuvyYZOhYb4luTtel8uwsgjzf
 KQnnUxHaONFN+wIp5HIA32Q4XVEUFLvcUN+240k/s9QY1pRqO+ZqDlGKwthwGTxq7xdb
 Wld/yRf+Y/FP9xl7d5y5nvvIILL7iUJePxEpCnkJ2/pvzkQLIeYf80HQ57ya16YAn9rr
 CAkh5VwTDM81hbYca0seTigeUxR5NmLQgDuZdA23r9395adPTBlyPG/oddjV+92RZL18
 0TsOeO6dkSdyPM/WPWWPB5YtCQByqbY0TkqaAco/xDrP9kKAhUtm0bb81MbdEgtoTTKZ
 GoUg==
X-Gm-Message-State: AOJu0YxsT7nm/XzFrin1pjrdlCbwe2wRPNROVpO301rLKxXFRjBBeLxa
 e878aTB5ePEu6x60L9wsJgyt0Fa97yG/+iWjan6NBg==
X-Google-Smtp-Source: AGHT+IE6GNR5eqnU/QT2KRO1MH9J0hsiC7FDl+yUpsF1qxlp7OEuo3TuC2aRSpFqShldNoN1w9CZMw==
X-Received: by 2002:a0d:ea8d:0:b0:5a7:a989:b85c with SMTP id
 t135-20020a0dea8d000000b005a7a989b85cmr10575024ywe.16.1698088139310; 
 Mon, 23 Oct 2023 12:08:59 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-c6de-498a-c903-1c13.res6.spectrum.com.
 [2603:6081:7b00:6400:c6de:498a:c903:1c13])
 by smtp.gmail.com with ESMTPSA id
 l67-20020a0dfb46000000b00598d67585d7sm3353566ywf.117.2023.10.23.12.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 12:08:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5] bootstd: sata: Add bootstd support for ahci sata
Date: Mon, 23 Oct 2023 15:08:55 -0400
Message-Id: <169808766154.2558485.14888786871905858063.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011202643.9194-1-mibodhi@gmail.com>
References: <20231011202643.9194-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 11 Oct 2023 13:26:42 -0700, Tony Dinh wrote:

> Add ahci sata bootdev and corresponding hunting function.
> 
> 

I know this is recent but given their importance, applied to u-boot/master,
thanks!

-- 
Tom

