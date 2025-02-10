Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE92C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C1C80C96;
	Mon, 10 Feb 2025 21:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQOov1mV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D133803CC; Mon, 10 Feb 2025 21:38:54 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC7180C7E
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f77b9e0a34so36054647b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219930; x=1739824730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGPNiJlx4xJLck54ohdGvZ5Eb9JkoqGQK15eXoYkYMo=;
 b=rQOov1mVbq51omOqp1eh7/xFwc8DkqVyApRHya4uW5dx7AIIeqH54vx75ri7/OzyCR
 p8LkNrxnYEJwV/AeeHSssvyMk4h0M5GcR2+nKZ9MeMWE3Jw8oDt9VFhIlH/HOCHougvY
 LCA36ACxe95qoyKh6yYK7SabiPKmX2OEbZ5A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219930; x=1739824730;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGPNiJlx4xJLck54ohdGvZ5Eb9JkoqGQK15eXoYkYMo=;
 b=a6VUOD80rRf0NMs00QKQr4zYaP7XS60VFDCQqIww3hH6b8BcsMuM2QIYfZjyHUu7+5
 zJZATHdtS3p++S/4c/T8lL5NpHsHZ74TjVQ/3BRoxOT60cMiiWrflerTeJy5ygOAQ0Kk
 g9l2BI0e9pAySQRNqR7xFFoNB/whHLQIB7WxLeX/cKwkBwsPxPH+gOm9RTC8Es+8dfio
 WLM6Z7ZEM6Z8cO8x0zi/41+FeL1CCyd15vCHMbCuMVU0EQ2iqOfeaAZe7a0tMVWrAQEI
 RSLf7V5QvKPHx5D3n3Nj5QibyguKgxw7CrUXTcIoTrXECpoUIlc1oTot5U253dOickx3
 B1nw==
X-Gm-Message-State: AOJu0YxZofbjUI3GsLIu3na1iAPPcjst0exXoTMwHn5UVUZGVaMC3Nk2
 1nROoQQuz8EmKl0BcDS8ANRJBMTodhijNXkc/Qs9rFP75zEC+OJzmE+tO0IsacJZafwLZdpDP+n
 N
X-Gm-Gg: ASbGncuwJAIHIyHBYPfKt+Ksw72Y3U3UQwQtAKvUo0kV8+lB/OWN25TO6SNEy62maQW
 AuE64TkM0eJgxwryOizWlVA+qx5Jxm7DITT2sRbCpjnXSW0tPFwmUzXm42o6jGDeppwLar5eKhb
 If5aAOwqHAf/2u2EMUFIL7QN2cVcFVYI4c4gxE7CNhOCvOY+tIBC6QTxyDl3uKA1Mnn/6HzsKIK
 Xh+Nmw/1fAguwCyS6iWWPYD8+IEe5J8g8kn9QFydvzKpVnrzLQhHnWCks+d1qw3AWHClgWLaNVf
 tBEEJPQmuZhfvA==
X-Google-Smtp-Source: AGHT+IHHr5BygHfXfLKkccSaYdU/VA/F4pHFiRsOIUXBbLkCd1RAAgGv6fCH1gkCTP52vNj43FguzA==
X-Received: by 2002:a05:690c:4b8a:b0:6f9:a212:908 with SMTP id
 00721157ae682-6f9b2878fc1mr142373507b3.14.1739219930341; 
 Mon, 10 Feb 2025 12:38:50 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <8ebf5355bbd29a38dbe4ba83816f6b196e3891b0.1738574335.git.michal.simek@amd.com>
References: <8ebf5355bbd29a38dbe4ba83816f6b196e3891b0.1738574335.git.michal.simek@amd.com>
Subject: Re: [PATCH] rtc: emul_rtc: Make emul_rtc_probe() static
Message-Id: <173921992938.2921783.6883663970859803155.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:49 -0600
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

On Mon, 03 Feb 2025 10:18:57 +0100, Michal Simek wrote:

> emul_rtc_probe() is not called from anywhere else that's why make it
> static. Issue is reported by build with W=1.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


