Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821BDCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD49883759;
	Fri,  3 Oct 2025 18:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j3KLB8AX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDC483816; Fri,  3 Oct 2025 18:16:15 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68D5836C8
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-887764c2868so232269239f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759508171; x=1760112971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFhM77IOzluNfqZ5lx66tt8HwM5SMnTAYqQXnP/7pn8=;
 b=j3KLB8AXLgFjTu0wseBaKceK0ckndAO2uNIPKUokUmEiOHOSiw0BadF5lhJZpSk8ah
 bjGuT9wELiatoAXDLu5oCmnu8lBGRwBJxtKyL6ThezTm8v8S9W3RaVNO9FjfLa+jumvC
 LueZjmusbaquxTJBovlQYSjw7yhHqoXMM1B/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759508171; x=1760112971;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFhM77IOzluNfqZ5lx66tt8HwM5SMnTAYqQXnP/7pn8=;
 b=vTRjl/C60J0SDeHXRh3xQJFiaqhfC6ssLg/pCIz3lcJNKq69ECyag7qEB5h8F9ZIuv
 GXnD/jQU2I6wLRlgiOyLR7FSaVSjfhYNAWEATweqzES2w43crUvU1vJnIEF7C5T0VOgm
 DxurXVE10CU+gkrzkvizR9n+lJyIG5CKUz5kwp+3MQThml4X0SFP2jZ2HwRIYEbDK+oS
 6S4GtpYvty15UQESkVJMzs0g6x/QhPpeqOh0GNKCtFotzCN1d5vtZur0a9Zhrgzjekuy
 EpN+KyOma2KNZHtE9Krk/CpKk2jEAlgAjVgQYm8ZcBV6P+/4VLwB+C9kwZt0lbFWfAuK
 m69Q==
X-Gm-Message-State: AOJu0Yx1GG+lHBkRFiXeBXQYjf+LINjrSySwyCqV53vbPQZkcO11z40V
 NVLW3102Kqmrg27tOItIJCmeKKouy+SzZs50v7tiaWJskpZ6mEv03BKhf0kfDeZRYHUdpoPPxyw
 2nGvK8PM=
X-Gm-Gg: ASbGncsdderRZnKv1NlyOf45duUnwCHuaILehyPRjelfxuJ94l2BOFjboHhH5KL/TMT
 Sob3QDaaagHO3lQYxDiloYNS2G/gOis6EiftngAyHAYIqGFtEjICFRQrEN+LwP+RTAqpxK48bP/
 FhSi1k69AZjWQdzaj8JLrimosQy6ZJkPAxocg+HHlam2cy3cefGTn3zHZeipwMhTkfcrQZZlQDz
 qTDfR0kt6IHsB2mu9eYagjF/j00FUNCXYQpVbh3PfRoxILIPefYMs7ZHl0QJzgKFzqpXOrDia56
 we4g5uAcq6L2A7q0SxZH58CEjlP3Z7wGouoOARAB4yKpmVswO99DAfK6U7WQHm8eDqWomzGdp/r
 03D9hKgI9CW1rBaB9wWJfpvQHnAqgevFq927Qyzvkkqr7RD8rczCsm9b0F4VEcForRwdZ7lebgl
 dFt9AW5e6ZEPav7X9RMGI=
X-Google-Smtp-Source: AGHT+IEk9km2l74GDgqFmZnjNrzLaSTb4JpW4S76/vtVZTUs4mb84Dt/YWZXwGjQNRHhxxEBjRJZwQ==
X-Received: by 2002:a05:6e02:1d94:b0:42e:6de8:4a74 with SMTP id
 e9e14a558f8ab-42e7ad972b4mr42592965ab.17.1759508171336; 
 Fri, 03 Oct 2025 09:16:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc83basm2037701173.49.2025.10.03.09.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 09:16:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Martin Schwan <m.schwan@phytec.de>, Javier Tia <javier.tia@linaro.org>, 
 Yegor Yefremov <yegorslists@googlemail.com>
In-Reply-To: <b1655828-f404-46b1-8f33-85eb58ecd52a@gmx.de>
References: <b1655828-f404-46b1-8f33-85eb58ecd52a@gmx.de>
Subject: Re: [MASTER] Pull request doc-202510-rc6
Message-Id: <175950817040.616824.8045776881091948390.b4-ty@konsulko.com>
Date: Fri, 03 Oct 2025 10:16:10 -0600
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

On Fri, 03 Oct 2025 06:19:53 +0200, Heinrich Schuchardt wrote:

> The following documentation changes since commit
> 72f72fab00773f7ee89c9635e490908c0a058162:
> 
>    b4-config: Improve b4 config for correct operation (2025-10-02
> 11:30:15 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


