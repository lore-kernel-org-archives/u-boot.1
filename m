Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFD5C02192
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E7E82893;
	Fri, 31 Jan 2025 23:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VAQl3mdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFF3828E1; Fri, 31 Jan 2025 23:07:13 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D88580F95
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so403844385a.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361230; x=1738966030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaYCQ60/+ksVLbRbcRq0miP91XqB5MVv5SkeoxLPe50=;
 b=VAQl3mdAx0+Uu5HlVytRFml4kFvus0uG/7wt++3jExOSJ1UjVCHDkOXEX+vFgw3AXK
 RlXyn8lK335rH9OQ5M8RHUC5deGeoAYRAQ5tCyhRust7shEJpN5opnCkm8zczpWzjIH4
 eRwnLPbNx1bugQSE94CPvXuN5CWMO7UTJ+sDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361230; x=1738966030;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaYCQ60/+ksVLbRbcRq0miP91XqB5MVv5SkeoxLPe50=;
 b=q6BgblLwshPZ9EtvRJlK9sFzXxwDhiW/NCnf+H1r4U1Q9cXUiU/EItrDXEd9cawVtn
 YudIeo/V2pr4pwTfvxIFsw56fMTJvIhFXQ0KCyC1Q2GteC6WzGTzDF3hCPZyWakKecJU
 Ud+I3xsXYd2NKb/s/70dAodNsRJ+yoz3lxz4auwFe/7rIiIQTza4Aj8FrXo8DABPrN7o
 jqgeKHYgKOU60JXGXse13iCqkN/hDrxfgjblPbf5t+WqfrRgg4N4qb7mpytmUAx1D5oT
 jZBWr1zV9evdV2pQz2u9CzHOdVIsgTn6tYmIHwd25od3tMqvGpNrm9uy9CIIsfGR8hyD
 HEeg==
X-Gm-Message-State: AOJu0YxrJOfZEPEOLyUq4gZ62XgBUA8UBkTG/Kihl6rDO3g4WifNm0Qq
 vduguVGblMhghhA7Y8EHMnT2gsuSYIhvfWqny47dxZ864GXOgOQSDEkI82pLwz4=
X-Gm-Gg: ASbGnctYGhLzB9g4dZQSiPyK0At1CzklOO71S3gyj1I3fbuSrDyoQy/7oplhWjTWEVx
 wgfh4qzs516+BAMDLu/EqryeE2AwQpsH4y117LCMCPJXtSUqnCP0vNs8TkTbk8JEO+xRfMwUNru
 939ObxGdY0+Kca/jVNNrnenZH86nCK5VQgKJl05vhMQZ3hlz9TPCKyfFuX9oxMAdnylIs3A1nRb
 ynzLXt+ePyRTSlbfcw1nz7nrwheEzWrQ+nmirAGvIDwxYsQvlpXbp17yyHvvKxXBre+i5J7oz1N
 yvM+2GGGcIPnlQ==
X-Google-Smtp-Source: AGHT+IEQILNJx3rJitYY4UUwi/1bgF5/ABMvNbHceAkovtWZsJ4FHspMsjdEL3siovZgRl++WZ/LSg==
X-Received: by 2002:a05:620a:8395:b0:7b6:6e59:2864 with SMTP id
 af79cd13be357-7bffcd726edmr1948426985a.43.1738361229992; 
 Fri, 31 Jan 2025 14:07:09 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:07:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <7f37ddd44ceb2c3309a814329b92e48b557568dd.1738164269.git.michal.simek@amd.com>
References: <7f37ddd44ceb2c3309a814329b92e48b557568dd.1738164269.git.michal.simek@amd.com>
Subject: Re: [PATCH] cmd: Fix Kconfig coding style
Message-Id: <173836122756.3060818.71726896798800444.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:07:07 -0600
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

On Wed, 29 Jan 2025 16:24:32 +0100, Michal Simek wrote:

> Some entries are not using tabs for indentation and also help should use
> two spaces indentation.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


