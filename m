Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBDBC4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 21:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A2D876F2;
	Wed,  1 Nov 2023 22:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PP7gCpvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF97F87691; Wed,  1 Nov 2023 22:03:22 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A8787683
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 22:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so796701cf.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698872598; x=1699477398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/a6a+3+KknYQBjDrfWgAfVyQkwZfFxPQu3zc5H9BHVA=;
 b=PP7gCpvKj0xUlEjpSwKxdPiAuXPHbOByIqMC7c7l9AIdg4jjxVyeCVn+/5cCapf38J
 eSKLMRMo4rdLOKVLpsaf8QfAFS+h8X4ilTp9gmYb3x8inQ68w/1XcJlA1+TaoSQeo0y9
 1lNm9jOV+vZzr5fP9VWE/k8p30Q/GxXLLvz1ZESQV4Ty4Flhxjd2s+eQyN4aI8fbF4ux
 h8seZTR8Oi2F168DQ21nhBzQmKCOOvixSIsf4EQcxlD9j4zyfLabnTzMWIan07cnTWmd
 eJAKhTuB7HFPfoXa4jFjZAus8yuxqivwJxRlL6BOlwJl3ZyXHp7ZAxm67JPgawS8gm63
 R28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698872598; x=1699477398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/a6a+3+KknYQBjDrfWgAfVyQkwZfFxPQu3zc5H9BHVA=;
 b=cf4mxpMkXGWEkNoo/dfih8ZtSHa25ga0vX1lvz2z1RCW6Mp40ude4px8uWLvs0v/jk
 bDXLzawboIi+GGT0VzziObFkfcntSHNI4vYQuFOoImJ153mpv85Gj4fa7DzPu/iRpMEy
 hik0lmVbwOI1/Was/vRrvgFrzRUDQ4TvdqX9+9bKpH14fE+IUlSM9Vdezz1G/rPmk5xa
 uhi+f5idMHbOWaYweqwUHVWAybqyCez2830fnRH9p4HuIH6l7l1kHl/JxexBda0ZaYBS
 fYljf1ZVxBByA5SSQzdOVKwztGS6AX1oq3VkpnJQpfQNvnrNyh1zr3wofZ4VwWo5/lml
 +GjA==
X-Gm-Message-State: AOJu0Yw3/Ts+omknIP/7ds8+wSFHLDjxL6y2H76G2eTV1gwWCi5P7HGh
 iBMAryd8ZVRs8m78ZkBJ0+s=
X-Google-Smtp-Source: AGHT+IF4qr+3gpVxKeERDVu7CKaxPsujEYQypOGOb+hB60Y4nO42X/33MrfLj4/d8vxCX1wlzXlk9w==
X-Received: by 2002:a05:622a:190c:b0:418:1088:7d69 with SMTP id
 w12-20020a05622a190c00b0041810887d69mr19829466qtc.18.1698872597871; 
 Wed, 01 Nov 2023 14:03:17 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 b19-20020ac86bd3000000b0041b3a1462fbsm1709371qtt.37.2023.11.01.14.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 14:03:17 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: bigunclemax@gmail.com,
	u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v1] clk: use private clk struct in CLK_CCF's
 enable/disable functions
Date: Wed,  1 Nov 2023 17:03:07 -0400
Message-Id: <169887250361.1352526.9757279098005499151.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230905221649.3577929-1-bigunclemax@gmail.com>
References: <20230905221649.3577929-1-bigunclemax@gmail.com>
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

On Wed, 6 Sep 2023 01:16:49 +0300, Maksim Kiselev wrote:
> In clk_enable()/clk_disable() functions, when CCF is activated,
> we must pass a private clk struct to enable()/disable() ops functions.
> Otherwise, the use of a container_of() construction within these ops
> should be banned. Because passing a non-private clk struct to
> container_of() results in an out of range error.
> 
> At the moment, clk-mux, clk-fixed-factor, clk-gate and possibly other
> clocks use container_of() in their enable()/disable() functions.
> Therefore, for these functions to work correclty, private clk struct
> must be passed.
> 
> [...]

Applied, thanks!

[1/1] clk: use private clk struct in CLK_CCF's enable/disable functions
      commit: 0755db477fa7478e2659568bb7da038a9eaabb8d

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
