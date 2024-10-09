Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB75CEE330
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 17:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A561E88CC5;
	Wed,  9 Oct 2024 19:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sjXIFc+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B5D88CC5; Wed,  9 Oct 2024 19:32:36 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F48888CEA
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 19:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbcd49b833so580166d6.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728495153; x=1729099953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwT5QeOhMi3convKLkrvP8mOiIK2To/qjNvcqHSLoeE=;
 b=sjXIFc+R6spP21bZZz5poKAVePGZHcUqlx5GuHn/sODiQ0ZE9iaZ2y/78mtSfQ9/er
 OqyqZMFAvADV2wI+fpbHVq02qEDeZdKqRa4Mm9CqLwrB5qnkLvc9ToQszzb0np8TlbeZ
 9xn/LjwDWH5ki3jZPZL4SN7vEv0LMQ+X49/Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728495153; x=1729099953;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwT5QeOhMi3convKLkrvP8mOiIK2To/qjNvcqHSLoeE=;
 b=BEFPWCfXGnSl6IziWtUkfmRlYdFKSIr/kRsGCiN56BLvQe9zydbHjoLzVCvE6RLHBq
 7tf+tCFIEHFO/dNiXBtvrgaWgKpy7zrGmNX0J8iUx5YuOPsT62pdI1Hy44RVxSVhhCOg
 K5lzqbR1DUjKp/CFKpVQBAFnw5g/JW3YwQw4z9nSlIJgopxz3nIKdX8nCwt4REENTLwj
 UFyeFfu7RHRvIuWZyKH9xsm4Qu6syKigYuzO8h0YhJGVCFVF+FOFunpaBguefhGSHN5W
 LvMii9OCmwsc5OmBCqjDXB3tE2vjmxgd/TrPHs51vxVbDvI/R2eFG5hC4S8lz3DliaAT
 3BDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbwupLHJVLDZNLQloNZqgGis679RxkR62FfUUZvmRODk8Sh3ncRCkF8LNrVQ9/9yeJKXezL8Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzH53/dsFw+jIfeiQ/OeVL083cGhaXqaB7vr2K1T93puSM6SZiw
 gKt3GDFXGgrtUoz+y4PqNXF1ZpvM7B+V/i4JKF8TMtjGq7t/mWDjn8ulsAJ7qec=
X-Google-Smtp-Source: AGHT+IEFmRE1cwu82b99TxSTF5xFuvQeq1dWvlpe5n3AvSrSBB2oJqnpeDcvadgjOZMzV82trb2faQ==
X-Received: by 2002:a05:6214:3f90:b0:6cb:bcf5:5121 with SMTP id
 6a1803df08f44-6cbc959a8bbmr54832396d6.49.1728495153251; 
 Wed, 09 Oct 2024 10:32:33 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbcc50996esm7439606d6.58.2024.10.09.10.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:32:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, n-francis@ti.com, a-limaye@ti.com, 
 reidt@ti.com, j-humphreys@ti.com
In-Reply-To: <20240911083722.1285509-1-u-kumar1@ti.com>
References: <20240911083722.1285509-1-u-kumar1@ti.com>
Subject: Re: [PATCH] arch: arm: dts: k3-j7200-r5-evm: Enable AVS feature
Message-Id: <172849515059.3523085.8165400263003522781.b4-ty@konsulko.com>
Date: Wed, 09 Oct 2024 11:32:30 -0600
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

On Wed, 11 Sep 2024 14:07:22 +0530, Udit Kumar wrote:

> During DT sync with kernel 6.6, AVS feature was removed by mistake.
> So adding back AVS feature.
> 
> Fixes: df73e791ce09("arm: dts: j7200: dts sync with Linux 6.6-rc1")
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


