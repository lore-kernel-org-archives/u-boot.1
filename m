Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C5CC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1EF81E72;
	Wed,  4 Jun 2025 01:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoliWLdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B76803DF; Wed,  4 Jun 2025 01:19:42 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D2E82103
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-407a3c0654aso3012857b6e.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748992778; x=1749597578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6WPeXxoKXj3JcOXXC6jtOLRjgdgxTfIGR1MA5EWDrc=;
 b=OoliWLdGGe39GIC0PrD7SLS/zEfWlAwIMyhgS3E1ZOhGKBUn8DmdAoCAG4qP+JbrOh
 UmhBomm+dRSM2hFvGe3lFEfumO1wHKE+Ua8s5hzw2KKnqG0B50KMGLmSepscV2I85eNF
 UH3XMlFHfFZkeKvvExASQ/X5EI5dP6QulfpHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748992778; x=1749597578;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6WPeXxoKXj3JcOXXC6jtOLRjgdgxTfIGR1MA5EWDrc=;
 b=ZuB59WeaXv64OXpaacmIm2iXD2eHJSaRPci0FLy8jnEmf2v+FHJlel6T0dLIcq7Nv4
 AtF/EbuN7msNgcqvCDsTokqtnWeracb80breWZcrk4Zn6AEV3UoqNJciDYIdsfvTa6D1
 BwGdQ6UiflM+DI7661O/EXXiAtfWkezw4Mp89ij+bCiH4KdELXHzSgZ1g0Es5HCnBwDK
 Z+It90OuqbE+HCCSpN/rv6NrpCzOsvErGCf/x6PC1xYlHUWGWBqGfmOZPeTGEb9lHMeD
 vNLKXGQlhXxIxz4SrIJ/D2djt3yGgxYMT0XY57rWWhbDMMEeVcA9UKwMsoRv8XistqWc
 6C6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDlES/zy3NCgMP0vcIWVWr5PVvw805RvxgCLGT+5lYoxIEvnJqs/yGw69ArCmcANn9tjLxVkk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/OE2ZvQWV/25kKG8AFJGUdJ8hrSpka55QQ1hR9QwIYpXeyIkr
 ijNIL62C314/pzbuo2HEsf+9RXS/zUJdEc96Ku829lMMpvOCHCIr3v1AqjHZJ5Dw312Qc9ImRVg
 WrqGRWNo=
X-Gm-Gg: ASbGncstynpvmOrIMEfsYXetG9ulVdhzKJmhAmeUE9A5cwIFb4og/77Zk7iwx/Jccsy
 STcCrhR4rn2WIi/iHi4qUQYC5pGHXf8vOog55Mxs6g9ahIc1bP1NreD4FS0YNR5rwtsM48zPpnn
 lX0k80Gjg60pAwLZp4mqv7EYeTwy4RvpppAByaZWTwtNltSwn9OZvrzVun5fiy13tZnJpuO6cep
 UbOM+O16+m4GAN5ivfoSsCM80PE7noxlVa9oiTxXIfRcOcb/VcpB6Y0N4IVdGRVcrTP1dGv03pK
 4VNzYLNUy9eHNoA/Nhe6tdsUS3FYxr3X9l/i4Fght6k+mPri7OSe404/1lr6SFfrtKsptM1I8T/
 C9f4PzssZ4FZpzqdEvSnjgQ==
X-Google-Smtp-Source: AGHT+IFd+IwGAO0Og8aLyPzrGLzzDu+R/XA6XGo9TScfLvdJtLezJf0xjmpeL3oPB9eSkMhXSarBvw==
X-Received: by 2002:a05:6808:22a6:b0:3f6:a9d4:b7e4 with SMTP id
 5614622812f47-408f0f6e3c7mr748153b6e.20.1748992778657; 
 Tue, 03 Jun 2025 16:19:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c1eb9c13fsm1991380eaf.35.2025.06.03.16.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:19:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20250603145933.1019742-1-casey.connolly@linaro.org>
References: <20250603145933.1019742-1-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-more-for-2025.07
Message-Id: <174899277726.1527866.2574431091249483641.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 17:19:37 -0600
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

On Tue, 03 Jun 2025 16:58:11 +0200, Casey Connolly wrote:

> Some late fixes for 2025.07.
> 
> CI run is here (just has vexpress_fvp disabled)
> 
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/26489
> 
> The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


