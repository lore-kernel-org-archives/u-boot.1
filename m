Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605C4C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EF8886AF;
	Fri, 19 Apr 2024 03:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s4Go4jJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8F5886A5; Fri, 19 Apr 2024 03:58:00 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4DA88667
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69b9365e584so21556756d6.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491877; x=1714096677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaz9QVI9/bPVxwTTFWRk1ufGlCt/8J1J+wUeWnOiKo0=;
 b=s4Go4jJxMj3zi0XWdwEI5zY3/PiV8YzMjx3xfGy3WNScLuPU28cT6ASldqdZNheCI5
 8Igpk3AQCPnVqjQ4XzYa2x4ccq/FSkrxKlnr7DCH8uBMrVx04Ebx3ydfQI3w19Qtf6c4
 4dCi8k5qvg2MrYesZYp1hoDP/ZiRvL42BEoxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491877; x=1714096677;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaz9QVI9/bPVxwTTFWRk1ufGlCt/8J1J+wUeWnOiKo0=;
 b=g0WHWK4+6xGWaJC+qB3pi1FC8BrRptXlCmgxQwYLTwWwh8QehA8qqhcJzbrAK/FB4Q
 av5M6hmm4hlxgxMUfRvp6SGELSBpOF3qjEsvHbKpJz1J5Bapc3aRcBPoIdur//p0wTF3
 xivhaIyVl3tMgVHmvtoHaVSCp5MYXyGxZrDoHY6KdL14GRAeL6PDqxOqxoLGQHsXzZTj
 LA14sm9PWEIzAfgVizHwBKCwB+i3Hn/xaCsDkQrMI8P5qljbO5nr8Ad+WO916m4mn4iO
 qu5QH+dB7Dap/MF3aorzl+QF7A0KMaBZMD6cjgNgTG2Ibiqn39s33XDPqG8XlMzi7WM0
 /E2A==
X-Gm-Message-State: AOJu0YyFsostVhyztT2bB3JluR8ZJcYvqe8gclvQzifvHD4hEu0UGBrq
 NNojc99F+MjkhMOOByEaxhWcBaMB+zjs4aptGjXfrbfRIR82O8xzvCui7JF6wtk=
X-Google-Smtp-Source: AGHT+IEywhkqW4udO+vJKvpaI8aejMk6voDb2BYwCL4t/jv4ddSm+nVRUxKP5Am65lLeD+BhGMtm0g==
X-Received: by 2002:a05:6214:a6b:b0:6a0:50ca:7347 with SMTP id
 ef11-20020a0562140a6b00b006a050ca7347mr1508972qvb.31.1713491877005; 
 Thu, 18 Apr 2024 18:57:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:57:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240411175244.937795-1-caleb.connolly@linaro.org>
References: <20240411175244.937795-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] input: button_kbd: gracefully handle buttons that fail
 probe
Message-Id: <171349187594.1524174.120925837175488916.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:55 -0600
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

On Thu, 11 Apr 2024 19:52:37 +0200, Caleb Connolly wrote:

> If a button device fails to probe, it will still be added to the uclass
> device list, and therefore will still be iterated over in
> button_read_keys() resulting in a UAF on the buttons private data.
> 
> Resolve this by unbinding button devices that aren't active after
> probing, and print a warning so it's clear that the button is broken.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


