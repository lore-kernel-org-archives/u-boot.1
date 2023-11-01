Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B20C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 21:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2448387691;
	Wed,  1 Nov 2023 22:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k89bAAjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76D8876C6; Wed,  1 Nov 2023 22:03:27 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554D9876CB
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 22:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d0ceba445so1854056d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698872602; x=1699477402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fowoSaC+X/fL4LTLPXOqMGFRkJcqN/kMNlPImihsEyg=;
 b=k89bAAjPahKYDHcjBw3Eo9I+PVVYGGStj3pv9g8n7NzZXYubVRQhcNYj6fbb806lG6
 0t2Q1Jz7rDNsvQYLzBzvk69dp78PZIfIyf7bVfWIELPgcTJT6yNqGJhJztzkd5J8zt0k
 cfrX2BrbmbPerYg/6TGOZ+KgOeeaAQMIp1oMOSkEdXTZqtnH+IcYjpUvLx5dYtTUxy25
 /+w4Kv6+viov/7U67Hf98XMj2+q9qXSxEguTA5XT7gChY5l5dd28+TGg2tdDcPCcHjev
 XkFsh1pHjVMH4zR4KSe2x5fnSWKgxFzVbaSsEC1MtV/+7GpNH8MqfjVssXs+726AYOHC
 lRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698872602; x=1699477402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fowoSaC+X/fL4LTLPXOqMGFRkJcqN/kMNlPImihsEyg=;
 b=Rieia97ABKvRlFBZxvPvW8vFEjcFiYRAlTBsPAkciAHxFOsRNzMleE39pGwuIvtq8B
 6q9ggHDc1yamACJvPsdD1YPeVcIZRa0jTpu2W1d8W2NIF8POK8amoKiPDuQvYx6SJHcw
 HD5qq/6MHQMMWFLNIzN159r8qR/hz1o+eHkHNmPNbKDYXWYwLmzy6DX4WHzxzCmvxv+P
 dPD3wZeKPN8CmqS+DnALq2DopTreGbU6S646UwpgFZk68b0KNlwOtcbt2cgHdTSThvjT
 XDXkZ82nAUB8yXWtlbYt/kFkaFNdUWzDGCWDM3WvIp3zHVEP5Hg37bTEnUJAL4m0RtDH
 IHNA==
X-Gm-Message-State: AOJu0YyVID037CmqQ1iIgl4NqxhnE0Wj9QQOvbQIOIAQAdTP/uGC8squ
 vcgD1cp+7mjw9sHgS9ELBN0=
X-Google-Smtp-Source: AGHT+IGj+WTxNiBOqphn6JnlW6EojB65KzV6WIPeoHtQqsrq4g3gI3WxT0gnPVPIRyr494lj2jDoGg==
X-Received: by 2002:ad4:5aea:0:b0:671:92a4:6a52 with SMTP id
 c10-20020ad45aea000000b0067192a46a52mr10230851qvh.12.1698872601856; 
 Wed, 01 Nov 2023 14:03:21 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 u16-20020a0cea50000000b0064f4ac061b0sm1815362qvp.12.2023.11.01.14.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 14:03:20 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: nathan.morrison@timesys.com
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, Lukasz Majewski <lukma@denx.de>,
 greg.malysa@timesys.com, ryan.matthews@timesys.com
Subject: Re: [PATCH] drivers: clk: Adjust temp var data type to properly match
 that of struct clk_ops
Date: Wed,  1 Nov 2023 17:03:10 -0400
Message-Id: <169887250360.1352526.5256101941617697204.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230515195005.1961495-1-nathan.morrison@timesys.com>
References: <20230515195005.1961495-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 15 May 2023 15:49:58 -0400, Nathan Barrett-Morrison wrote:
> In commit 5c5992cb90cf ("clk: Add debugging for return values"), a
> temporary storage variable was added around the ops->get_rate() call
> inside clk_get_rate(), so that the result could be passed through
> log_ret.
> 
> This temporary variable was declared as an int, yet when we look in
> struct clk_ops, we can see this needs to be a ulong:
> ulong (*get_rate)(struct clk *clk);
> 
> [...]

Applied, thanks!

[1/1] drivers: clk: Adjust temp var data type to properly match that of struct clk_ops
      commit: aed6480fadede2b87103568aaa117a423a1c3fdc

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
