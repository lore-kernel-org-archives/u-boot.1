Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBE3C00A94
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077DA88080;
	Fri, 12 Apr 2024 16:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CJ4P5K2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3608800D; Fri, 12 Apr 2024 16:19:06 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A345F87DF1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78d6021e2e3so53838585a.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712931543; x=1713536343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phNbV/VUGrteBPdWc95j62kXXM+58Ai2YSvhujYi9w0=;
 b=CJ4P5K2PoQZnVf83k0LL9TZ0rYkXIDKyLXoIo4+/gJDVV+FjeP8kvhFooZDwfQhOgS
 pm69XPqWeSF3iPrMEpAhXtiCohjUHFno74bMXdbBryYKwdPW9heUg1ZCvupkOoWNgUOj
 wWRQxp9+ybBm9wKbo+jBKZ5LoHiA6b3E2LpXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712931543; x=1713536343;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phNbV/VUGrteBPdWc95j62kXXM+58Ai2YSvhujYi9w0=;
 b=XIgIGo9AM1AV01SeMQ9dfuZowfhZOh7L22nH/Smm1H/0vtfvJcnaNUsxcPkDl4wePk
 RD3Y51ssRQ6tOXqdlUtFYoZYwixJ9yp4lX/2Yzn1m0vQdWnCf3ofIdGzxVQaUkiniTKB
 RoClT0iPBkeLPOlW8GiBqVtUxRppRajlIdSSHAcUR4trn1B+jxHwLlhvgPI2ZlvWMOLK
 ktidJgiYtAMDhwAo5jjSzXhyvOhh5oDR32U8w7rVVjPzf3+HPowAFh4PkPCaoRWLFg+9
 oveyne/X3x/oC0YoP0h5nYBi5QZxbBCQI/w+Dg8PWDfqSqQMRpA/B7KC4DElX/yfV87d
 K1gg==
X-Gm-Message-State: AOJu0Yzrjh+DE1iGMAMXeA93HHsi7tmSWMSK2LYnbuAyFN5fPeouHawC
 mesgxcdER0gRehELjVr1hCFDjrNhjRx79V21sasHW7PzApgR3co8esKoF6YeIGo=
X-Google-Smtp-Source: AGHT+IFw35kpEqH/ypV1ezPJQAXg7DkSe7ijPTtbZqJ8ZIhixZJpo0sa5k366HizA6XPo7fc9Ks2Eg==
X-Received: by 2002:a05:6214:133:b0:69b:1ea9:c715 with SMTP id
 w19-20020a056214013300b0069b1ea9c715mr2673714qvs.26.1712931543551; 
 Fri, 12 Apr 2024 07:19:03 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a0562140c2500b0069b5150712csm1759399qvd.56.2024.04.12.07.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:19:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240402160908.508974-1-afd@ti.com>
References: <20240402160908.508974-1-afd@ti.com>
Subject: Re: [PATCH 0/2] Remove ti,sci-sysreset
Message-Id: <171293154240.965666.12893297098980834665.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 08:19:02 -0600
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

On Tue, 02 Apr 2024 11:09:06 -0500, Andrew Davis wrote:

> Idea here is to remove one more delta between the U-Boot and Linux
> DTB files: ti,sci-sysreset. We currently have to add this to every
> board's -u-boot.dtsi file as this is not a standard node. Instead do
> what we are moving the kernel towards[0] and remove this node.
> 
> Thanks,
> Andrew
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


