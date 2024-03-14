Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38372C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870D087CEA;
	Thu, 14 Mar 2024 15:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LHsdnFLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AE9087C9A; Thu, 14 Mar 2024 15:11:27 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D245C87CEA
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-789d5fb6ba2so29739585a.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710425483; x=1711030283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKhItOGFMcITInHnN6szVBVsc1uZT4QrVyUlEuiC338=;
 b=LHsdnFLtaoltY22QcW4TQ8nazrtI4bZZrBy0jab0D20owDIHrAT0N0tR1bAGOe+hEO
 98d0i4ufvMo3HChK2agGCp9WzIDOf17EOITguNFrtS5yKjDs0NGhXrZKMV2fOM6aXOTl
 voCifLFISFnct6loq3QnDG7olxbtIV6is6u+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710425483; x=1711030283;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKhItOGFMcITInHnN6szVBVsc1uZT4QrVyUlEuiC338=;
 b=ZPTyIxpZFSxchkUllZ1vdIZJmOkXHkppz88UNNSXzeFvN+I075qYvhexw7933i7L6k
 DHaLQPGtRU1QgJuU42XW5sTuIjc/EpJFt8vmMkku2im/p8tb/vVGpDBgVHIUr3BBpQTW
 vVma7utwDum0sAspAqcNNY+IFp8ptyF5u8k9wqyx1vzIBv3QTHGmDpEYsjfQqCZn3M6z
 mXOXtRD83/MPsi6hGIt0I39XZNkWvrE5mkPVEOFr7fz0vGXWxCSrNDAizmr77YwhegBr
 EPtICtWj+050EIgZp2O8B+wCKY3wuJhNWEDYZcjWPD1HRn5DpqtZIWxCTmdRNKESM83W
 9VoA==
X-Gm-Message-State: AOJu0YxOVFW8CkfQ77KBwsOhIr4z9SYkfN0KW68ZgNUqcuRsnFentFMq
 +ikF7hoioeWL7yGL4rM8wuQb5gUwcvUuEcG60klkYodwsWGqLOJTLZ+Ibzuq/z4=
X-Google-Smtp-Source: AGHT+IE4MzZlleh5CwO1zhABEXF6gMUh87OcK2irKbbQw6JR+eEEgibrwJbBPX2w7rc2Ez7MdNqW1w==
X-Received: by 2002:a05:620a:3bd6:b0:787:ecea:6518 with SMTP id
 yf22-20020a05620a3bd600b00787ecea6518mr1731012qkn.46.1710425483495; 
 Thu, 14 Mar 2024 07:11:23 -0700 (PDT)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 bp41-20020a05620a45a900b00788577fcee4sm861907qkb.91.2024.03.14.07.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 07:11:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Hari Nagalla <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
Subject: Re: [PATCH v4 00/13] Introduce basic support for TI's AM62Px SoC
 family
Message-Id: <171042548238.173271.944410998399426746.b4-ty@konsulko.com>
Date: Thu, 14 Mar 2024 10:11:22 -0400
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

On Tue, 12 Mar 2024 15:20:18 -0500, Bryan Brattlof wrote:

> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


