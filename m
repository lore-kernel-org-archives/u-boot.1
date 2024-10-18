Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB54D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BF389139;
	Fri, 18 Oct 2024 03:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nhAsxVCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C8688EE5; Fri, 18 Oct 2024 03:57:41 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B8E890A9
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so12373616d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216658; x=1729821458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nb7B33k0+6SENgWE2YtRGdG9PiGHlP+WcicKEjGd3JE=;
 b=nhAsxVCoVchzukFrwVCrnoiwqQHoR2m+Ob8CIgf3hDqOZr68070dk3veox0DrQDi/P
 1IYPCvinT0SVDlMS9ujOwt6hQrnZ2fRGzsRSINBeWT11d3WPJ7ctPhCNUPaGNhcMxE1o
 eyxDKZsLFG25w73nXnrLfDtL0o4qVLAJQ0yzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216658; x=1729821458;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nb7B33k0+6SENgWE2YtRGdG9PiGHlP+WcicKEjGd3JE=;
 b=pO+IV7f32jF5ZGNIPOSz9z7XoLlRiQXGPKvEp21rJLiJ055/mDzHUlTqQx65V2P/xP
 sbbR/mi/fa0ZaJNrc/EeU3mVqCzNWuofdpW1M3bX1GIhC8/P7U/OGbKd+ZjZKQHRqZuR
 ebHyKBaJLsPDnFXdWRNgrKRrgHiYB4De0J4AjRbhey2uex1K57QgOyvUBKvtzQunOfRp
 PHoRcZks0m8lmRlxcgqj9YIXyay94VVOCZD/2mwHZs9MAb7+ecHseuwTU3XgZNSMf/Bg
 TxkK/6hY8UIGd79e2EmsU53ujPMs7LHv1nChq1SgRiTUqiMQiSUze+NC/+uhB0jOm1ZU
 ewdQ==
X-Gm-Message-State: AOJu0Yx5vH0H1YAlAiygAlBBH6JxlNl/4CetTzOCVmUyBwONCAaje+Y4
 G0KhUFagrgCjfwhPPi0gXLKiHROm9kCCk9uaF3kWk8ys0l1GRs6htU+GnOd/D3I=
X-Google-Smtp-Source: AGHT+IHtWa8jO10iQfEmJbFYaqs/QQyx2TyxzkuBP2QobyVtb7DdpIUyYTjw7es4Oq6/GWUopWOD6A==
X-Received: by 2002:a05:6214:5985:b0:6cc:561:43eb with SMTP id
 6a1803df08f44-6cde164b0a0mr11577586d6.52.1729216658504; 
 Thu, 17 Oct 2024 18:57:38 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>, 
 Frank Wunderlich <frank-w@public-files.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Nishanth Menon <nm@ti.com>, 
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
In-Reply-To: <a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com>
References: <a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com>
Subject: Re: [PATCH] Extend usage for OF_OVERLAY_LIST beyond SPL
Message-Id: <172921665626.1016776.1779599313259840996.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:36 -0600
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

On Mon, 30 Sep 2024 12:20:36 +0200, Jan Kiszka wrote:

> Allow to use OF_OVERLAY_LIST also for the case that the overlays just
> need be built, e.g. when they will be picked up by binman as artifacts
> of the final U-Boot image. The IOT2050 boards have such a need when
> switching to OF_UPSTREAM.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


