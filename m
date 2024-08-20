Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937BDC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 06:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD93887ED0;
	Tue, 20 Aug 2024 08:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uGuKKvXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67170871C7; Tue, 20 Aug 2024 08:23:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C52888D5E
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 08:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so41014685e9.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724135004; x=1724739804;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RAHgZLr30+JchiRXJaNMlkTB8nx7UT3UFx2UazV1EM=;
 b=uGuKKvXP44286DPDdMLkxSL6N6IhZ4wgVvr0elYYUxaa22MQyaLIKIurJl1GacNOaI
 taCUNpBLyc1EKscFIJcE7a7827bQq9CgigZmImj2tG+3ODx6kmUXKuhwuVKm25D4ep94
 shRh4sgwYUGVufqYlzpuKGBEky2il24XPrM4nkZwRS45PO3NnJfOoNAL1u9m0+gCnd45
 Ecl2jrudDCYAOLG0p1MyBu9cKRdPlomXOHsHN0NhRtiusg2jF9uTC1Mz5RtB/qqqNWP1
 7LHdGyd+4GIqVou9ryyT60/BCgge+OGLW6jdHy2SWsKiSxrF3bc/lzxqfrq17E7tK3sf
 EOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724135004; x=1724739804;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+RAHgZLr30+JchiRXJaNMlkTB8nx7UT3UFx2UazV1EM=;
 b=K6lUzCp0l0sIoaX0tEuu0y609Pktd+mfp8NDTEMwg1o9+nbKqxttvuPZBbwZcNaKPa
 DTlrEz6UOxiEb9zHzYYrPgjEEMmEhoj4PXuT6jAKQf2kjYcP4eG7STOzdEmWiAjBqfGz
 7U5E+LEsYqh9HFNftZ9eHNCyeAKpRh2iDuaLZOhoi1doNUPRMMrcZty5AqJ8Og68L2Gs
 set2gGEAsmydyJb1lve1zNOOTE5CjSnXPvyCJzUk82a58mUXKBiX19oMz/tx82O0hifw
 q2QHvOTf7eOb/fet+QlKzc6cBiu26qTftHIRiOqyvv9/yupOs3NNYEw7XmA2uS7V1RDm
 lMJg==
X-Gm-Message-State: AOJu0YyOygjfLTHjyyM4ZiC6c4GVbqrsLBSkcZTauKnluQJo0YgFeFXV
 6yykJULmwcU/qnsrD4pVGX7Tg+00+SDyDleqA53FZAUwEEUPVRMLTUSYimEJ6UOAuMyeVgk2edq
 d
X-Google-Smtp-Source: AGHT+IEKtwnLO0hqTUNBh9JX3E5CvGUwjFBcfWqtuZUd6J32BPXIqnSowk90LicvY3v1UpbvY5XmuA==
X-Received: by 2002:a05:600c:35c5:b0:428:387:79ac with SMTP id
 5b1f17b1804b1-429ed785c67mr95947275e9.6.1724135003989; 
 Mon, 19 Aug 2024 23:23:23 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded29303sm183134225e9.15.2024.08.19.23.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 23:23:23 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240802092820.917450-3-admin@hifiphile.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
 <20240802092820.917450-3-admin@hifiphile.com>
Subject: Re: [PATCH] cmd: bind: Use device sequence instead for driver
 bind/unbind
Message-Id: <172413500327.69624.5444644456831665790.b4-ty@baylibre.com>
Date: Tue, 20 Aug 2024 08:23:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Fri, 02 Aug 2024 11:28:13 +0200, Zixun LI wrote:
> Currently uclass index is used for bind/unbind which ignores alias
> sequence numbering. Use device sequence number instead as it's
> the number explicitly set in the DT.
> 
> Also update documentation to use sequence number.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] cmd: bind: Use device sequence instead for driver bind/unbind
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/0c48507eee08b5e7d4e8484727efe47cfabff0ee

--
Mattijs
