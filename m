Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA341C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 23:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4663E87D07;
	Sat, 23 Mar 2024 00:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z1YJwCji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA88987B30; Sat, 23 Mar 2024 00:15:55 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF0D587CDB
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 00:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6962950c6bfso23999956d6.2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711149353; x=1711754153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ha9OjnTi4LaNxdOiZ0kOCPAogI0NVzSxz12bt/LBGWk=;
 b=Z1YJwCjibUAXSNoQ2RC1KLcnHyCglWkruMxSstCETRVNQyHH4JcoG3ymMSRMdbE5l2
 ToP7wGTTmfBXDXVNSpcbPMnl04U/RY4JbfH/xMXbdWVy3axiJJiCQDlRyz/cRIlCC/+h
 OzcQUJEMT1O1qyxP4ypGNXy1IInMofg1kcDPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711149353; x=1711754153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ha9OjnTi4LaNxdOiZ0kOCPAogI0NVzSxz12bt/LBGWk=;
 b=VniHcTU9gqIShUqiXJvNXgRV+mz9F7dJ+muSuilJh+Nmc0tv0XJM5lzPdZIRRsfqKl
 52VRwJvKx7F7/uR5M7kjVsPEVqPZVtPj59qZm0B+ok/7hNq9TQ3g9P7lAx43Zhd7ypRK
 CVesQcg2hwhjKeSszPcmwkX1X+Zldjxpst6Na1wdtJvC5H11ltEk4il/1LVmQzmwFsfC
 RGT7xLQXhHvWbrWzdvc9bpUVs1QBS3O5JVoa3cNLHn9juWcPKxaVVJ9Ktk34n9mv8D2r
 VOkwYtK00ld5ZQqGNtmrbJTy/0oQhsda4C61FtpNTLrL2sx/EaPYlLQWl3O+8HrBpSrq
 yGNA==
X-Gm-Message-State: AOJu0YwkEH93BK4BoB0eQam/MeQKu/w2ugRwV60dRTTH8qzEjcf6tG48
 opzw1lPxu0uER20n+1anHBG0SkZurTUtQc2kE2ph1xyn8jsgz+2Y5Wmnm0XZsuU=
X-Google-Smtp-Source: AGHT+IEjW336dZ6pgDbCVAB5y9fn1FKtD6smuHmOP1Uf6IueoKSWDQ/nnhSxvDJc2doA9XFgDbPsaw==
X-Received: by 2002:ad4:5cca:0:b0:696:3704:712c with SMTP id
 iu10-20020ad45cca000000b006963704712cmr853303qvb.63.1711149352690; 
 Fri, 22 Mar 2024 16:15:52 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a056214500a00b0069102f97e08sm1537500qvb.97.2024.03.22.16.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 16:15:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240321102819.1011011-1-danishanwar@ti.com>
References: <20240321102819.1011011-1-danishanwar@ti.com>
Subject: Re: [PATCH v7] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Message-Id: <171114935161.2210431.1695475448869985748.b4-ty@konsulko.com>
Date: Fri, 22 Mar 2024 19:15:51 -0400
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

On Thu, 21 Mar 2024 15:58:19 +0530, MD Danish Anwar wrote:

> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> same firmware.
> 
> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> load the firmware file to the remote processor and start the remote
> processor.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


