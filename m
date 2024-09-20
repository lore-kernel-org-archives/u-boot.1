Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8B7CF9C5D
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 17:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FC788875;
	Fri, 20 Sep 2024 19:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMU4e5hE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90C288883; Fri, 20 Sep 2024 19:33:22 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7E48880F
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 19:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a9b3cd75e5so218199585a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726853599; x=1727458399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQnfJN4HraHQCcOW/2+OgDG5hja/TnuI5woTozGJhYA=;
 b=HMU4e5hEO/2xX1GUDJftJMzFZAyEOw51Qohdlg4gK2NBzVyXgStpVKE81ZhxzvtYx/
 Bxt1fQKzELGEJ3DCZyS1v6E8o7Zxc9fNyOfbkD6LLUPJYN6Y/NgeVtrLDVA7pu+FLfbY
 oc0c1UFrFL24W/LbEVyrpOOff+W72aPzRfHJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726853599; x=1727458399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQnfJN4HraHQCcOW/2+OgDG5hja/TnuI5woTozGJhYA=;
 b=wnGsvf88N009VgTuzuMnAN1DL49Xjw2WUovpgjNzxNLC8P10YJz2Jx8TPkDZezj4YM
 CqcXu2rcIUcLoq/E/XEj4VTOpDqE6FODICEibkW9EQXacJBe0Zwf92Y7X+V5EZSOLotN
 L2MnuzFliXR52yUkpRhwqGJ6exyggLaKKz8c0Q6DOrJBgE2vsfqsAGw58slnYpKWBD79
 nVlJw/HGJnVmLdL9XYm0jY1fN7eaS2t7Jpqi0NuljGcXE+/j0Em6hxchgcpKde2f9WcP
 LBTkTztmxfMdUtXVIxAw59S4MRlulcX7fip5PWFZNGPaunCtow54oe3RjRjDy9Sdju/P
 N0JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOZZgADalwNazvdMdldUP3haTwNqgwJ8/+cXAMMYo7Ckl+YpT6JDqG7xxSwpWAlV/tdvQ1an8=@lists.denx.de
X-Gm-Message-State: AOJu0YwN1Ep17iLPHmTVgK8eHOlV9yGs+2G7ErxyealyiOLxcShz9qOg
 yt4TUBnDtfo4g4oqXb4RkziAOcEG1ZlHGzthOzGAQnNacMcLI7NfLjzV1iYZaeg=
X-Google-Smtp-Source: AGHT+IENyki2KeBB9xpMiLgy8iofnFYUbtcCYeuYdEv1ygqkNCj9Tg43lBrd22yZHhN4nS8f2lj8gQ==
X-Received: by 2002:a05:620a:2983:b0:7a9:af5b:6921 with SMTP id
 af79cd13be357-7acb8d8ae15mr479097085a.21.1726853599484; 
 Fri, 20 Sep 2024 10:33:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb082a025sm203613685a.62.2024.09.20.10.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 10:33:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
References: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
Subject: Re: [PATCH 0/2] mux: mmio: support "reg-mux" compatible
Message-Id: <172685359825.2413155.7189031595413828983.b4-ty@konsulko.com>
Date: Fri, 20 Sep 2024 11:33:18 -0600
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

On Wed, 18 Sep 2024 16:49:20 +0300, Roger Quadros wrote:

> TI upstream has moved from "mmio-mux" to "reg-mux" that doesn't
> require the Mux device node's parent to be a syscon type.
> 
> Add support for "reg-mux" compatible.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


