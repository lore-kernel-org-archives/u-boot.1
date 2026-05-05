Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F9CD342C
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 01:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE675846C3;
	Tue,  5 May 2026 03:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iu/lAeWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43FEE846DB; Tue,  5 May 2026 03:12:08 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF7F846BE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 03:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7df05fc49e5so1245247a34.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777943524; x=1778548324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpOt2P+ZPZAJ+hK0uZzSFw4pH5Beh5xbQ4Jf+PUlPV4=;
 b=Iu/lAeWbSXbCLy2RgX4Uon6vGRl+KlMrXKdRXIoZ6sQajy7BQfWw2ppmTav86WJJPu
 hTcXr4+J2IFDnmgyduXvJOSrspx18bMfKjqZbSZ0OBjWgLVOMfAZAwlzhGsdpyVbLVme
 Q0GCwug/Wzx/JFHgQ/ssGaknJWHTPrgrzgeBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777943524; x=1778548324;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zpOt2P+ZPZAJ+hK0uZzSFw4pH5Beh5xbQ4Jf+PUlPV4=;
 b=E/DXSW6UH1Y3lQ43oMCzVB6IAwIIZ6Z32oss0PTNR/hw1kyEcpmhA/bNIwpjbkNnlk
 tV8jBWwhSvPyptXV29wnusxfaBgDXRVxHAjNNz8LxGeX+avK+BpXAJRhm4b/eoL6mFTs
 zYJvjuy4+brlS8SJqBjF4Or0a8fCvJLY5wEW5u5xLRUJivMN00t9UKX4Rg6bRyySLJIu
 X++ZtoUnoygqCku4mdU5ZpyOYKRGywcGM+PXxIvjnFgZG6fNtMmEA/fEMuNqa+sA+0aR
 3+Hjp6ZVNlMvDN+8wvgZcU2Qjjjt0FVjZhLTutSmyS0Txf5A64ZN7UzZ39YjSEy6LmEb
 S1UQ==
X-Gm-Message-State: AOJu0Ywn+av9iZDlgiGq5yjtBV6G7GmP4AfQ9k1FJ66ddAONzdDI1B5T
 aEGnOg077NLqcsNc7u4v+1xM8zwgTiKRJyQgMlHAKwzy82D94jF3t+jhCyv9h/qL8/U=
X-Gm-Gg: AeBDievMIydHk6i/hYR1oFke4twI8dLyXDvLkQ752gdzT1s7b7kaXxj0LBZIeKVbs58
 QMhCbE8WkFCrmhMklIl2XQfYxZDFzmMowEzd5InPq6LewIpr9gddKNRBkbusil6jMzgY7gS6ckL
 FOCJiz0j+uyKBZYwTljK3cLNGYVzsjl9wfLnW7et6A/dW2/kzL5LU7HP4qy1QGa+p6FbzK2XVsr
 OEbsPG8v6SAhGP/Ms20m17GJMMYrXcITZ9lwFI2EtczDRozmjGye4H7yl91gAdHJgy+RshYvMU2
 kvdvExB/d+yzrki0CgXblIRrD08+V3Oft17Y/3OiY7f6QN25MjQ5qPbFVTru9VyBw9GbNOBPfHM
 ER63hDuTcrBA0gvp5st0E13+v6h4uPEwTg2RIkGg1HsIH+2ijD/WRtIcqpKIOoNuolBW9Zm14Ld
 Kq5iDbTgtwT52v8AywXl5+ek0yVt9z7mxNwkTq9UpKgrHBYhYiIqkDKxB+OSHgZy0itfpjTcY9D
 XS+hWMOn6CBe0mX/2eVFBhmPQqiQhDvGh7EGiUjzZvU5FAAF8DhQHIXXUsk
X-Received: by 2002:a05:6830:630d:b0:7dc:c620:aa18 with SMTP id
 46e09a7af769-7dee14c5a51mr7080032a34.22.1777943524607; 
 Mon, 04 May 2026 18:12:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a9149sm9153516a34.1.2026.05.04.18.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 18:12:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Angelo Dureghello <angelo@kernel-space.org>
Cc: alison.wang@freescale.com, Kuan-Wei Chiu <visitorckw@gmail.com>
In-Reply-To: <52347f0a-49e8-46d7-987c-73bb9c2add95@kernel-space.org>
References: <52347f0a-49e8-46d7-987c-73bb9c2add95@kernel-space.org>
Subject: Re: [PULL] Please pull u-boot-coldfire/master
Message-Id: <177794352381.2294859.3315258276566879830.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 19:12:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 4 May 2026 22:30:17 +0200, Angelo Dureghello wrote:

> The following changes since commit bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sunxi (2026-05-01 08:12:31 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.denx.de/u-boot-coldfire.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


