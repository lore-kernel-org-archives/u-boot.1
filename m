Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC51EC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BAE5880AD;
	Fri, 10 May 2024 21:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kIF0HsaI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B132D88054; Fri, 10 May 2024 21:32:34 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B71C88025
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43de92e236fso15912931cf.1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715369551; x=1715974351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwQxhE/L2JtVskaF/nBS6a6tnjVixNsQUhIm0ufV4UY=;
 b=kIF0HsaIZ18b4Qr8xgY2ytzQbrbSFaqlBTtqiC0u1BXAdYB7YSPNJu9kvmIdDF6q2C
 zl8Q7ja4i7MGzHIvWrmZ3TT/Wekk7X4xOTwOF7g+eziADJSXJkEoPVmN1JyqVsP/xZAt
 crkigZfOnNqoI1mcxOoxpsioU3TKAQ3kI5aJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715369551; x=1715974351;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwQxhE/L2JtVskaF/nBS6a6tnjVixNsQUhIm0ufV4UY=;
 b=oJkiF4pW3Se0dQ+9eoH0FnR6gwAq+hSYYHiaqcrn+Csbd6tFD8IrQPYkX2q7b2ZiBS
 8gAo4rP4ERghxbNEfUiMPqsQ7qK6hcLK0fGhSXoGit9AJVUcQlKs1IK86ngHIH1355Un
 zKQY3OdyOfEIklEKkGe0wteS+rW8SMN11Udm0e2ecRMpvoM/1ErTPDxoZhvOj5dL7pt+
 pERHrM+ezl6ck0iDy3OBCxtPhG91FfsUu+fOs1EooD8dRQU0lPouKPS125IX6qf3X9Q4
 NbOudBl/ICglBWXNQHSDrEwopZoilkNDLRrAgm0VCEpOQ7GU8JmoGcPFcKUtaLfG5B3V
 M0lw==
X-Gm-Message-State: AOJu0YxIZjtO7AFCYolHbyUgNk5erfl+aqO+s6OxkqBws/5UMk2dbOtY
 Iq2qPB3vzXPgXJWQYmJngdzjpKz9LdffosGgV7LI3v63LxrX8JgUlNr1ap3OfMtbSlZQm7ZFYdu
 vmzk=
X-Google-Smtp-Source: AGHT+IHOVph0jl3S3zu6ZRQW0bHH8NwASEIDrpuLWnnrGhZNykMcoP//QZYMPiLAazaFLgJO3hucZg==
X-Received: by 2002:a05:622a:58e:b0:43a:fa0d:68cb with SMTP id
 d75a77b69052e-43dfdb07132mr39816931cf.6.1715369551184; 
 Fri, 10 May 2024 12:32:31 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df5521c21sm24474961cf.48.2024.05.10.12.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 12:32:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
Cc: upstream@lists.phytec.de
In-Reply-To: <20240424125335.2306132-1-w.egorov@phytec.de>
References: <20240424125335.2306132-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/2] *** Commonize board code for K3 based SoMs ***
Message-Id: <171536955032.3410219.5738921295349254313.b4-ty@konsulko.com>
Date: Fri, 10 May 2024 13:32:30 -0600
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

On Wed, 24 Apr 2024 14:53:33 +0200, Wadim Egorov wrote:

> Factor out code that we can reuse across all our K3 based SoMs.
> 2nd patch of this series require patch [1] to be applied first.
> 
> [1] https://lists.denx.de/pipermail/u-boot/2024-April/552021.html
> 
> Wadim Egorov (2):
>   board: phytec: Commonize board code for K3 based SoMs
>   phycore_am64x_a53_defconfig: Enable CONFIG_BOARD_LATE_INIT
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


