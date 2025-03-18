Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8454C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD9081B42;
	Tue, 18 Mar 2025 18:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CTSnh47P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C538C819AA; Tue, 18 Mar 2025 18:01:43 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0DE8193A
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3018f827c9bso3349409a91.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317300; x=1742922100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zT0bYIcG0Y7qBwkajhOqoq0V6jkKBkspKSBicDV3eus=;
 b=CTSnh47P5bEvl7kOaHxlKRMiYmGQdFnRNF7Xkw97dLTgNJqy0lqhHIGprr6+wYRYMA
 ANMMqj6usl+vIo/vSPDd4TsNgtGBjv98zG1hsUAkhxK2s3roDjOIts+d+QymZrNQGWGE
 66i9MfX475gRuB8dcwUvShklvZ7WwdKPWRxy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317300; x=1742922100;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zT0bYIcG0Y7qBwkajhOqoq0V6jkKBkspKSBicDV3eus=;
 b=Nhwfwwgsq9GF5EsuTLRdfvCjWF7OSAP+nOVQfDkzOiWQQvj5nwuakNCB0lcADusCwM
 mD00rwkOnHaW8rfCBmZbSHJcEmR+k7ZrwDeETZIgfeIj6yRMDrIoaLminFzWKlzfIPNZ
 +2l4VXxUkWHjBCK0LV+srNOnVHHWegY4ecsvo1V2Q+WOH+h7Gwdtxt/dCU5ksnZU0xzk
 3wsf9daZI76qwNzba/rqBMPnankniGD+bWn6YBniGC4h8u6fiWfoeZIdAnZk/g0whotE
 4iyKcWan96vRmYpA4A422mF3V3FnbHwNucoWtQZCxZKhiqtb4mIC4C9z3O3VDdSL2gML
 e9Tw==
X-Gm-Message-State: AOJu0YwUBG60rOIBqzDqhafrMV4gckHzz/aAcZt9m9tEwxj7KqKb4fU0
 8t8ZgeElhjFQ73r83icrYZPlemoLHzzsXcWFbT1prPDs8/sjaQkvVb7c8o37zt8=
X-Gm-Gg: ASbGncs5RIHXNgBPJ5fjhFBk/0WIJ3pxUbesxTi4rCpXLBdXOdze56XnlutZcjt4y+A
 QrsPDaePkQ0GxxCkB/de8gZuIqBkZlvlGnmZlUZ52kYbirLHOtscY96+vvVmNY8VGxk70fxNnwR
 LMbgR0pHopXL44ZW6yW7smxpTixQn4vAzjuGSTN66LDfTylr0aLiC+xdyoqf+pxRLhnwTY2YzWa
 JI6lBMo2riwuYVixXO49OPRhBUE7bkHX7/9e4tmJeeH4oz5vRXLMY6wKKXLK9AcfuIN8ErS5pgT
 0DFCqvAK/D+nomVyHnajrSGbf05DzIfytgxQgw9E8Iov
X-Google-Smtp-Source: AGHT+IF9jQuE/LxGrTYkdvHr/ub0uAhvDrCOVj2qMJHXwx2NVm0w8IrH0cpKvwjraoERfEZGD/Yu0A==
X-Received: by 2002:a17:90b:4a8b:b0:2ff:5a9d:937f with SMTP id
 98e67ed59e1d1-301a5b87bc4mr5400476a91.24.1742317299613; 
 Tue, 18 Mar 2025 10:01:39 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015363273fsm8458551a91.34.2025.03.18.10.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:01:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250304203235.2834031-1-trini@konsulko.com>
References: <20250304203235.2834031-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox_vpl: Enable missing TPL_DM_I2C symbol
Message-Id: <174231729863.1761337.8633317012816534398.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:01:38 -0600
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

On Tue, 04 Mar 2025 14:32:35 -0600, Tom Rini wrote:

> Currently this platform implicity builds CONFIG_TPL_DM_I2C support
> without setting the symbol. Add it for clarity.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox_vpl: Enable missing TPL_DM_I2C symbol
      commit: d1e82970db8400b6529ccc3e31cd999c3968783e
-- 
Tom


