Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22951CCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27AB9836D1;
	Wed, 29 Oct 2025 00:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="by5p2Z0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 584B680422; Wed, 29 Oct 2025 00:57:32 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366F280422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c0e8367d4eso2256889a34.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695849; x=1762300649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPLQjRzxXKSBfXKxvutZATrnDklpE3dgq/TLLr/yBN8=;
 b=by5p2Z0y4O48CXIp2kXbSWQxzijhmPKy7djj9WWozMbf2M+4QlNn/oDQA0WuU+YkYW
 tXUVDcw5eRPf7qmJBDTEDGBh5bB5VgBbODCiq5dfAvlqEtO1FCESz6wb4hohLfY1x6tS
 yKnqhZ75GBrcEW5EwwzfW7DdMwMuwAjpkJhFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695849; x=1762300649;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPLQjRzxXKSBfXKxvutZATrnDklpE3dgq/TLLr/yBN8=;
 b=BWasyMXcWlN+6v08oYRNZ4NhZ2AYA0eJ4vPL0h83COS0ma7WOMiXGbP6nBONzrHE4w
 kYF/U5d09eqN/fBwPwUbx+7yii8OilFvm/U/F2EqejQSqccL+5YlREr1kJLr4GvZsjDR
 09Jx/wS0yM0uQHNwchsm8+qfE+THAmeWj6MZPuaikvZEMJO6H1gY9rI7r5kUg9j4Pz1Y
 4Zzfp8AmFB63j0SKSjWIa6FaYKlzH1ex7E/2wz3Hw0Kl9lpmMp/nzCGaWhU3hBQX9rG8
 M0xO/fljvKluv5JOy7hhRM2hx/MvlAbNGQHaa90Efa1DB3IvcCkK0Amxfvp8z4y41wWv
 wzyQ==
X-Gm-Message-State: AOJu0Yyh/aWxlqboEhxU4Xr0xGOoYkodglrbMbt2TizJFptvNWU0jmbR
 hVvQ0JXTtp3jtCtf3XNRymiRQL/RECMp76r9TSzR1fi1dKyJ+ElglvNHhQUpw4qQJ2kJRZbE6tt
 FJvDoojGllA==
X-Gm-Gg: ASbGnctCUnl9WiOSeOz5PiWDaaHLkhLjFzDsM1AivIVRMSuVC/Lc/+uNBWIKVHGCNOF
 0AF2hiD9CTrsbdOIapfB+Ez+lE881pGPU7rx2lOOWinsSXtjfNTEa4n5LMOtjCEVCWq+s18XNOR
 bdpOCXOaINgCQyxgWFhdTg0fJITVlV/d5G7zEACk2ZZNE47Z3pkgumeLa+0Bd/ye06evpmDrfkH
 xTX/u5IOxajpnt1SXBse+j9+EfTpeTHltzPVXTSLS59wWYO41EkPV+0l7Zy4eVxPPsyWKEASTTD
 VepPhwpFMvY2ZITmqKyZU5AzktMH556caQr/flLHXK6BPnRNq6+U+WX6K114KdWobuJ+LIkRHj5
 S8Xvtd70RXEhZLrKOvKtnsuKEFWqKAf14TYbGnvLdAigFqDjuYs7TABLimLidAcW7TRxCqS2632
 +hRKqr5ELITJ7OPYqTz5kLNqyLf5ao1T3YwENaCw==
X-Google-Smtp-Source: AGHT+IHu/KEX0Ncx2qYXYo426SZhvJzaXr8TJD0SsRoGyS8NznkUlWbhEbAwcMjI9IZBDxihdf6uZQ==
X-Received: by 2002:a05:6830:922:b0:7b9:c17b:1475 with SMTP id
 46e09a7af769-7c683065a66mr818841a34.8.1761695848848; 
 Tue, 28 Oct 2025 16:57:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
References: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
Subject: Re: [PATCH] cmd: mtd: Prevent use of uninitialised variable
Message-Id: <176169584790.2287207.5576483898517388408.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:27 -0600
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

On Thu, 26 Jun 2025 11:49:32 +0100, Andrew Goodbody wrote:

> ret maybe used uninitialised in some cases so instead
> initialise it first to prevent this.
> 
> This issue was found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: mtd: Prevent use of uninitialised variable
      commit: ce1bdedd2f4b3c5c8c76fbf2fc1a234fca470573
-- 
Tom


