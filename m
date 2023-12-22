Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72FDC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDAF875FA;
	Fri, 22 Dec 2023 16:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="geJdgJSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A863F87650; Fri, 22 Dec 2023 16:37:11 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D6C871CF
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f91d48863so6338496d6.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703259428; x=1703864228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYoOuP4x/ir2kCWeNxfJ1oY8QVhLTX/3baF+eICHLq0=;
 b=geJdgJSb1fI/1urs1Hmhk2pKW+gOb9XPzI6bUbyhsQAAkWyO8EKMkt57Xh9FGLqAsB
 BeNhR+8VExaHSZ2TO6YC7m6YRDhrHBuiSVQc9hV+6BKY+dKDJBZHTjvMDa6/WiPm1JcO
 tH0TBp3NRUa3CP06Pq0UHYwwzlDBzkU0+KWiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259428; x=1703864228;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYoOuP4x/ir2kCWeNxfJ1oY8QVhLTX/3baF+eICHLq0=;
 b=IY7XgoCtvAUgW+ZbajlI0zAwQbIsqeRDrjzdfpOOm+CSos66QsT9YBV9zYV2BtYKeY
 b1AnFx/8ULZund2ssa9fJ9FxjVabDO3k6YMawMRrr/UHf7t/nLCZI/28bzbnE6jkg2fZ
 mdASk6iHqYqHTZwPyHIjrT7gz6mS0vnWI4xvGUVxl+AbUuowhDGYM3h9ARg8lHUz4XEi
 2Ph1DcnXY+LnJn2dxWRNKflyysURoAUdAhv6+D1NqRAIiqmO0UwvL2w0sns0jXSDl7qO
 8ccCvt6jdy3lhayo/KzcFfmk/vscMsLl7k3hnv3XmQgIavULoN5rpiAhSOr4e6Td4Sqb
 mCpw==
X-Gm-Message-State: AOJu0Yz3LaY8EygkOpf4ckvoO4XQpmqJZU9zFtQ93D9Sz19bdIN17LRJ
 YdC9KaUPTaNADrUMyYqjRRvfmVuzBTAYsw==
X-Google-Smtp-Source: AGHT+IG+L+z/lMFRYVhbADrNuKm7iL3U5LCv4XQnX/iC/yWYkHl1E6vKKlcKPbM3qIHmgS1F2wVSXw==
X-Received: by 2002:a05:6214:202d:b0:67f:5326:651d with SMTP id
 13-20020a056214202d00b0067f5326651dmr1873500qvf.13.1703259428419; 
 Fri, 22 Dec 2023 07:37:08 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0cf8c1000000b0067f07683decsm1447009qvo.99.2023.12.22.07.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 07:37:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20231222150156.39783-1-xypron.glpk@gmx.de>
References: <20231222150156.39783-1-xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/1] bootmeth: pass size to efi_binary_run()
Message-Id: <170325942760.2653128.4640507980296072811.b4-ty@konsulko.com>
Date: Fri, 22 Dec 2023 10:37:07 -0500
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

On Fri, 22 Dec 2023 16:01:56 +0100, Heinrich Schuchardt wrote:

> If we call efi_binary_run() with size parameter set to zero, we get an error
> 
>      Not a PE-COFF file
> 
> Fill the missing value.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


