Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8FDD3C541
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FEA8917E;
	Fri, 18 Oct 2024 03:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PkaRxrSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3934D89171; Fri, 18 Oct 2024 03:57:47 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D84F890A9
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so11089366d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216664; x=1729821464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=06gx4mljTb/vq1hO15wvMdMoccQWYFMU+s43wjsYiQQ=;
 b=PkaRxrSX/K0M3eQUoKHoI9cqRMk/f7+AGwejbHSCY4taFO/lEvMnSamLkEE/Hkvnlc
 DwR5m93OfJnrpAptiCanNQxDUuCjCOY4GrvayeBitdkc8iQdCN5KD7tbhY4dlt+QiQhX
 PCCA3iebMOOvRBHo8FvgnnMokC3QlbkEEB/tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216664; x=1729821464;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06gx4mljTb/vq1hO15wvMdMoccQWYFMU+s43wjsYiQQ=;
 b=B5yxhuTLUuC1lKKAq9SFkoU7xXg5AJdMlPwI1QXUloOgkAqI4oaNOMsM5ew1wSTdhH
 wXQCP4vwRj4DLND3uYjwmhvb9faaQmBVjGXCH0hxExnWB3B2Kr5FAqcBKZsWgWg1NHFb
 hM913lFI6l73q9tkS2X4CHTAWSOS5uA3tDeYUNMCOhInka7b5MHMKIPSkYAGg6MxpqvM
 A5S0THN1WBeJ0coXaunbV4+RUl5ttggWj6rmET5nEqOHqVQ1jD7AwjMOklVwzVmV1h3M
 SmULJ3yLIvBbbLkZJzus845dykxtLzfzMnY4w2VcIYboWMVWGFrK1xC05zc+KpfmI4b/
 efLw==
X-Gm-Message-State: AOJu0YwuSyHvjwAmYaac4wNhcrffOCa8S6PSUV6ukVnhi2SjOSu/56IP
 AM7KseQM+4fAkdj6CfbLJGcnHQYJDa9bROVIQ3hbC2mjgs/5tCYQ52HroVeQnTa+YCVSdtF/TqS
 /Ar4=
X-Google-Smtp-Source: AGHT+IEspU/fafzXe+eGqMSPnswgu3OYF5Bpr017zn+O4Bv6qmgx1ykT8/5hfTH3PJnTKCHUFPINMA==
X-Received: by 2002:a05:6214:5542:b0:6cb:ee38:1bf8 with SMTP id
 6a1803df08f44-6cde14f2e78mr17757226d6.13.1729216664068; 
 Thu, 17 Oct 2024 18:57:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241005191429.1927741-1-andriy.shevchenko@linux.intel.com>
References: <20241005191429.1927741-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] cmd: irq: Move do_irqinfo() prototype to a
 header file
Message-Id: <172921666239.1016776.7304709481459105372.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 05 Oct 2024 22:14:29 +0300, Andy Shevchenko wrote:

> Move do_irqinfo() prototype to a header file, otherwise compiler is not
> happy:
> 
>   arch/x86/lib/interrupts.c:130:5: warning: no previous prototype for ‘do_irqinfo’ [-Wmissing-prototypes]
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


