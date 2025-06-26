Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419D5C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41D082E66;
	Fri, 27 Jun 2025 00:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QrVzgEKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5FA280E9A; Fri, 27 Jun 2025 00:15:54 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DE782E17
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40791b6969bso1088580b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976148; x=1751580948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gin8J1WvaR7rs2WJOj+S+aktGtNZ/XWTuqGopvhR3Ic=;
 b=QrVzgEKvs41YmbxHH0ivyb2lF3ec9r50bw4xynWEfLxQd1IEpZwhxJUsfa0nttpHPn
 CjSUSAHT3X+U5kE2tCdzPGyntp0cvf64/gY+dwj/fqTOfUcw40udAu9DwiDOb5pUZOBg
 JV57ijUXhG0uhAkH44AUhaSEbIVXk0FPkZDVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976148; x=1751580948;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gin8J1WvaR7rs2WJOj+S+aktGtNZ/XWTuqGopvhR3Ic=;
 b=wAvjmb50SPHGt8mI7J7gAmU82X+vIVJQz/qXsnBfNy2suHtiT2xBmUUeSssyDeh01f
 l1vCASx8E2qk0fL7gHAmJ8oE5dcwh7R5lU/bDaPlBUGqZ6uNXI9kJpEgCehn+zcaL2TN
 Y56bfpVi2XWtIIRcUX4jXHl1pcTrnT59qWOUIqA3ELVG+HEcKblBC52yLhhCbFPpK+zC
 BUAdp+dHMkHivtKO0PmZrIYT9xSaUfV8S4KB1vwVkPZCNXtmpTCtN3rVjG7Kdh9euCKe
 Rm9mYA5x0HEQXO5U/TnzVC3fBnBCCW/+0jy9vJbljXTx5M7bAelroTP8o2dvjt0SqHpZ
 /EtQ==
X-Gm-Message-State: AOJu0Yx8YmKzZWdccb8fRcHhmnVS9T5rYEOK0rvKXn/WDJB9dYlDUDyN
 i99d98DF4iTc1li1bMYYAg1zpDW4nZdyG6ZUEtX/9zMcqBAG/8NuaUM7qOD/tKBfeeE=
X-Gm-Gg: ASbGncvONxg51OL5VGpU58dC9GSZgmtkD6jcdv77roh7IIGstxgqxeMMLCOF93kRguv
 ZnhVJzVxs4hiJL9m9QApIzAIxuVvWERVA5y72l3qiInz/PiU2upxf2iGzJX7ALJKGj/dCGZemPj
 9vz+LWSKKw4b/7CFapjwK5Jr6ydVKfSeBRNSiFWXIKMXi/vvbyw69m4/neRSbVVXvUb0kRtaa4m
 w+F3RrXrvp6WHQPH0RF4rgjaOk5NxCG71OiafUreeive+qRtTOUW6uMAkoi/rpqejJl1VSsPfAq
 TVWL/wcMVzRrso9cvynOSEwgiYvOdzV/tFm/lXQTz8v9hziH28z+b+ra6QRM2oYmG2NGtuo8qE2
 NSstVFWgm6gLPCruM+yY0qshxY4RxI55r
X-Google-Smtp-Source: AGHT+IHQRSgzYAhcvM0HLe2vX53AJGKwv+7+abv4VLiqXWrrzBB5k5vEjRQYScoEAdDTj4l6eA9Zyg==
X-Received: by 2002:a05:6808:23d2:b0:408:e690:7e38 with SMTP id
 5614622812f47-40b33d9c928mr788995b6e.16.1750976147975; 
 Thu, 26 Jun 2025 15:15:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289ce3sm129676b6e.6.2025.06.26.15.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:15:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250616080431.3548976-1-anshuld@ti.com>
References: <20250616080431.3548976-1-anshuld@ti.com>
Subject: Re: [PATCH v1] arm: Kconfig: enable LTO for ARCH_K3
Message-Id: <175097614702.1909185.14114770055610097084.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:15:47 -0600
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

On Mon, 16 Jun 2025 13:34:30 +0530, Anshul Dalal wrote:

> CONFIG_LTO enables Link Time Optimizations that helps in reducing binary
> size. The config has been validated on all K3 platforms so can be safely
> enabled.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: Kconfig: enable LTO for ARCH_K3
      commit: 5609f200d062a25c1b3baac94a78e3eef0a3cd75
-- 
Tom


