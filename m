Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F398C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 16:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3A887BC9;
	Wed, 28 Feb 2024 17:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qme7RPb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6B9875B9; Wed, 28 Feb 2024 17:21:37 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06F488074
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 17:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-608ccac1899so53624427b3.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709137294; x=1709742094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TNKtXxIPF1CxyhHJNeBh955W9AQOTgtW2j+HfF1QtXU=;
 b=qme7RPb5sZ3wogJ5kxtSEt6Rbd8BfoC+lOcvsvPHEYxnlxu0yHy5YtNGwJ4GMiuzGF
 TvQqUR4wPA3IUW1Q2P5aDLaYKGrZf9YhsGVtb4HaKAj5D+R6/UicukNo3ZiASJtYsvxV
 3sh+AlYzvDdWnLB1TJvaQOeQHDn1nC208IYkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709137294; x=1709742094;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNKtXxIPF1CxyhHJNeBh955W9AQOTgtW2j+HfF1QtXU=;
 b=o7g2Kl4Ri493M3ecYeqxz8pKI48KPsp3yACYRTDdrGJk1kA3C4EtvcpaqNNtfywqY/
 h1wUDXBMhHGC2aB+LvvMaXD78KIVmWyse4z30HR8sc15aw8TF5VJUaK2d13NNIdV00/e
 YaZdbzhaxXkiS/14cF/3dB0OQRpla7J4gowYZpOlwHhaAcuJGcNLvWAr0MP0sMme2W6o
 vtE5bYOZaM5/O6/VP5ygCIKYl+ypWrm/2MhsgY1uhJtwjrmPbxvyJBLKfWFTz2Vgf7u3
 LQAaqu7KIxD/nxYAKKgxMXUIe8YbOhMzfCqvV8ecURGUI2L53Lyy2Fq+3Ay49ErqbnSn
 JZ8Q==
X-Gm-Message-State: AOJu0YxlrIcgNGwN0iyTFY0v2xorsbg9mY5xbuVoLV1fsL+kdr6+4N+I
 1Kk9ZQ9WDzceqdVMKkNEv/xim5HXgZGdhIGxfHvpLo4TIgqs6SCF6nXlv/uLPNAv7U2seQQa/iq
 v
X-Google-Smtp-Source: AGHT+IHyMd5/GdrTbkPWq/XeDwv+XrKxl++FJXzQpK0znaHzwHzDMKcfPemMNoFl/Rv5S5uIygzTqQ==
X-Received: by 2002:a05:690c:85:b0:604:eb7f:30f4 with SMTP id
 be5-20020a05690c008500b00604eb7f30f4mr5994814ywb.31.1709137294032; 
 Wed, 28 Feb 2024 08:21:34 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a815e06000000b006079e8f3572sm2474094ywb.85.2024.02.28.08.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 08:21:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240213143928.91443-1-trini@konsulko.com>
References: <20240213143928.91443-1-trini@konsulko.com>
Subject: Re: [PATCH 1/3] Dockerfile: Build coreboot from source
Message-Id: <170913729309.3423095.6567813943469567149.b4-ty@konsulko.com>
Date: Wed, 28 Feb 2024 11:21:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 13 Feb 2024 09:39:26 -0500, Tom Rini wrote:

> To make CI runs rely less on external servers, build a coreboot release
> from source and populate /opt/coreboot with the output.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


