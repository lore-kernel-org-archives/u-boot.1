Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEDAD6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92112896C1;
	Fri, 15 Nov 2024 05:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qV+bQ0yd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CEF896BE; Fri, 15 Nov 2024 05:27:57 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439D789326
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so9123641cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644874; x=1732249674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zorgUhjymzgHyyLnfeJ766Fa2QX5OQ6EStTobO3XAjo=;
 b=qV+bQ0ydusFDPIbJY1Vcfwpbyx+krhiDLKJ2iZwbj3EuHmEWN0S6QhkJHco5CJk0Bv
 aWgVDHXKdXU0aS0b9DIqxToujkHXF4SMCrNLKRI4hcJCkoC4k8nwkKxMKZFBSom3A0WK
 PY1FrR+Qx8cEuU0u8sh0uUneH7M2p0kcxIkYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644874; x=1732249674;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zorgUhjymzgHyyLnfeJ766Fa2QX5OQ6EStTobO3XAjo=;
 b=tXlwJ5YAy906UCFN9k+6E5h4Qw6McnxuQrq/mQP7bLd1YsXwbSqNWGpwwciKmALQDh
 +RCXS5EUALntFxSRLDgZACXVO9yNn1uFLwLUdcgG4eWwcsJd4n31j8BsKfiKq5krppUp
 7aEsmq/fjmhzH8uDljcRp85WU47xzNo//6SDPP1mfsRw1hcWps9aa+e6AoomFzuHYUAw
 QOQ2HxM85OVWvC90p2UOc0UA5E1jdu8HeaLsSxRxok2G/uyMiTEZzBcHcYRqBBgIpC1L
 i0vpBDxHLX62v6XHef5usAYOGt5o2jmRtePu8qHy+f3w95DiZTxOVT4jznoG7HjAQlD8
 s0BA==
X-Gm-Message-State: AOJu0YxOMXmBibKXPb0Dq9uevZ6VhK7SLsfZTvS3ekgY+8STK9u3NubG
 37Z7TVJPdqY8tWv7LflLQ7s4ZuIu8qoIrjYIMB6yivFUTJhAbz2QVSxNPKrM14M4FrwzKbyc5P5
 KzcM=
X-Google-Smtp-Source: AGHT+IGuFIYPsxA3BPdhD3rrgUWyY6LwpNzv1BORfnW9c3BqAhfQV52mcPyKUb2x+/E/Pz9ZP+a1sQ==
X-Received: by 2002:a05:622a:34d:b0:458:5716:fbd8 with SMTP id
 d75a77b69052e-46363e31414mr17904441cf.32.1731644874217; 
 Thu, 14 Nov 2024 20:27:54 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241102150413.133499-1-heinrich.schuchardt@canonical.com>
References: <20241102150413.133499-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] upl: fix parsing of DT property
Message-Id: <173164487215.1205089.3807034364390072061.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:52 -0600
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

On Sat, 02 Nov 2024 16:04:13 +0100, Heinrich Schuchardt wrote:

> When calling decode_addr_size() we must pass the size of the device-tree
> property and not sizeof(void *).
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


