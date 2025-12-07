Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAABD1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 14:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC8F83A9F;
	Sun,  7 Dec 2025 15:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UXRgDZdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A5B800AD; Sun,  7 Dec 2025 15:04:37 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF5F83A8C
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 15:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso3903424a34.1
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 06:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765116274; x=1765721074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpfWbLZL7PTrEBv9TVeyqQx8mWXQyR8Hdgh7RAHoFK0=;
 b=UXRgDZdF0+ApTH3PaydebMiJl0yKoOSZYQxusiy+xfv/jayBbEg8TD63a9Dr7vJ8xC
 u5eX+KhPAPA76lDDp2Dhjy9hf39vSE3xGQ0m/oApFwrw0KYybWw8QZTbp9pvcLem4gj6
 ZdgM6NJclFjADKc2CWSG5PSMVGu9jLvaXqOWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765116274; x=1765721074;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZpfWbLZL7PTrEBv9TVeyqQx8mWXQyR8Hdgh7RAHoFK0=;
 b=sf2p2V68IJHk5DcheRCdFQ5tooemU4mWtsial2XPwXsXQJ8WYUHTcBL6z56DauwwwV
 LbZ1YDcUxlPONru/eCaz693g0h92WkS/oMX2emm8K1yQSlum6JUjLc4k8ozV5ocnYFQF
 stIcphLCbvtcEBZ2O4JKV2jedQgU/lMLnSQ130ExL/JpNgY7mAfCmloRbxIDhGQQxf6Z
 l5Gz3QdVE5wB/wwWLzFwjBF6655qgmYAORKlGjYyh/XV9nKbxFXP905ldEVSMmEZuKB+
 es3PkAbvqt4TXyXyNXZ5rpRomu0OtQPzxH+rAO1OFRvdQ1kF1gwrgrlgX7/GGPEWNtCs
 b8Cw==
X-Gm-Message-State: AOJu0Yz7D/49z8g4mkwZg92JCcTlTBg4txk7ZxvCC6zWd+u19Ri3ujqD
 DATVlJKRertgs2XYU/qSoQlZYiOG+iBfyqpJTmaEuPO+lV85/wgkUK4JYx4VikTVtbE=
X-Gm-Gg: ASbGnct+Za/UTJ7cSGp30iIzAN1iIMUdunoTQI4spzOTBQNjLHqHNeRU91dwqcOVENW
 LKWzKJ8J7SzIDQ/bdNYo9n6qiMk7IqFcB0r5xaONlfoFczttjwaoLwjXHIHQjS09wzUKA+VTJqJ
 5/aEj0l3ib7M7gst/bljSh92ZpyJyjyKAy7kqvBOViRvWCqQNTtZZDI2aCcQDzn32WE19VEEiGA
 4DBRYGvMDuX6tIjNwXC9c956WL642hUNMqhxXU3tNWq3YBbO0T0oA1IpCJc7ZuiYcxHke5gqdCp
 YVlGXxmZAcASA9470I4Hw81yJTpPR+e4SF9rYl6x/BPqT6ytAj1Q2oHWo4h5ijeXk7UsI4doh3P
 Ac+c4eSZMFPvntG/jSkbAGgVtt2OiwbmYoebXiLIo4gjpffCwxL2Z+jUR1jJ1SqBVwGhngUTPo9
 4Y1sT1ZozkoxJUmNC/tgl6xubsaAxx+TEREx9YS3N4GU8BKiiXyc3UGJZdkPI=
X-Google-Smtp-Source: AGHT+IHQUepwvFKhR+MPPQ0OLwigvxkN4OaPIegMLKdZXQ6IJI4Zl6WrFwwBJTS/qkB4yOqyC/UqHA==
X-Received: by 2002:a05:6830:4425:b0:7c7:6626:b599 with SMTP id
 46e09a7af769-7c9702ac259mr3413821a34.1.1765116273726; 
 Sun, 07 Dec 2025 06:04:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac84d2bsm7892068a34.18.2025.12.07.06.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 06:04:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 =?utf-8?q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 u-boot@dh-electronics.com
In-Reply-To: <20251125154324.51940-1-marek.vasut@mailbox.org>
References: <20251125154324.51940-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH v3 1/2] test/py: fit: Deduplicate the test
Message-Id: <176511627222.2893301.16869211260913470703.b4-ty@konsulko.com>
Date: Sun, 07 Dec 2025 08:04:32 -0600
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

On Tue, 25 Nov 2025 16:42:56 +0100, Marek Vasut wrote:

> Introduce generate_and_check_fit_image() and call it with various
> parameters to test various configurations of the fitImage. This is
> identical to the existing test, expect for the code duplication.
> 
> 

Applied to u-boot/next, thanks!

[1/2] test/py: fit: Deduplicate the test
      commit: 23eb6c9ce11b6b781f7902ced7340f2c6c433e4f
[2/2] mkimage: Add support for bundling TEE in mkimage -f auto
      commit: 22aa122eee021a631e1b92c761ff1a434d46890e
-- 
Tom


