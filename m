Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FC2C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B87882A8D;
	Tue,  3 Jun 2025 17:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qeR9p1q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2EF82A8B; Tue,  3 Jun 2025 17:00:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4DB8091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cd6b511cso35170495e9.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748962842; x=1749567642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbgFTbbwn7i5WMx1xq3wYfWXpOAaxZpD8XlGi3ThX+E=;
 b=qeR9p1q4/cY7jm5S4/9NvfYhO3oGvZkMCrshPWK68bQ9xfhuM53M5xxouKSfG+kS4y
 EL8LGpuZgl8QziD3saNzH+65V9XA7sNLdjLXToKkNsxRTxi46AzfknXHgybLmGYkYpkk
 Oe5GiPSLUS6veevp5EutyX8j5jx2Z8WKHhcZrvOSsbshtmjXSWOTrcD9GsXNDlQe4g+K
 mm1e5BmybxtdRL1BRAyca7XrWcsHa0AqODiQwl2W1mHr0Rdzap9xtCKB7Tz68gm0uMA5
 y91u0t46HCRuy9MmVmOQGsSBpPwgtS4Ezkzbpjv7WQDZuw1AjMAt+QET49rMfHC075qz
 8gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962842; x=1749567642;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbgFTbbwn7i5WMx1xq3wYfWXpOAaxZpD8XlGi3ThX+E=;
 b=O321o8q7LKz9rEJcKW+YkxZFFA0hmPWkiuXKgt7NdXeUO026V3hH2GeiIaICb7Pw0w
 djLI6iRiUt6CnSq/a2U8ROSbLE7o608Tq8uuVn/slDYSn5FjVlm5SzeMYnTBt2wt/LWK
 3Ww1GCUuvcPF1GK5NBwWDqbH4kYch3bp+/2DRVKdd4q2bew9LMgoa1UdpifpTrJxapv/
 4jA9xCVLxlwmW4MpfZ+k+IpH5b8FvV5pNfaabg6iVQEFzq/b5gKmc8A0aAjxTIl7GRmp
 RolxkOeYtZUXmMZhtJJTD4jsOqkzenL7kbz6VGMSt8aEAVjC4JVgeISsNlK8wPGAcNZ8
 t9zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAR0N/etuv04ZHXcORZXezkEEbHKSntKRr9ydU46SF+PFKIxMhUdJcLCh55tK9G/Suy5rU2B4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi5CK3CfGGeC3qeTzsvPujhzLJhup2vcreX3S2BHGKvkp8TGEo
 irNaakH7sFs2fvPLLonVs/1X1P0rGvHGuqz9tWOpwo3U8fUZ9iGQ0f5eQcRI3UCBePI=
X-Gm-Gg: ASbGncv8WWSxfGOdcQSajpuQnAZJTsOtmdzEZRcoIJIn7WK5d0lKt9NE6V4jRbAsdsH
 PYXrW2DiBWy6s/hMVJT5K8Fp0ud9SNTsAZ4KWQOzRQTRT7CVEgwvQmOqNhkCCNT/tOlrNST7+VB
 uFbR1IJLtWvZuzNeIbzgX/JvDd7csjyCjphref89pNy8bDjuCgVH/h/DoyeSOqadx7/obE9nkDX
 ZiybTUPt8yRv3mkmQq0mv1m5Rp55qcZUuKO0bSdkNGqXQ+8U8SCdXXREKkyi9BAdJ+tgCTgbTr7
 Mg1XcEURWqudUCY9HjjUwfszrxrreazSRS1p0nXV8b8OtoVKPQM4VF0cFIDSICMrSgsTtVMFa/R
 4HwPjzsZFDZ2H5heVCTihKw==
X-Google-Smtp-Source: AGHT+IFeufgKZEQvxG8/SBk+8OqdbTRhGJXMsL1sGn7vAPnL91W6nE34y4F8e8yyReq0pzfiHhkuCw==
X-Received: by 2002:a05:600c:3542:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-450d64366a0mr192412895e9.0.1748962841515; 
 Tue, 03 Jun 2025 08:00:41 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e5496282sm19845165e9.1.2025.06.03.08.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:00:39 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
References: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
Subject: Re: [PATCH 0/3] board: dragonboard410c: More fixes for U-Boot v2025.07
Message-Id: <174896283917.1020546.5356388054846637577.b4-ty@linaro.org>
Date: Tue, 03 Jun 2025 17:00:39 +0200
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


On Thu, 17 Apr 2025 15:49:10 +0200, Stephan Gerhold wrote:
> Fix some more issues in the U-Boot configuration for the DragonBoard 410c
> that I noticed when testing the current master branch after the recent
> changes were merged. Ideally these should go as fixes into v2025.07.
> 
> 

Applied, thanks!

[1/3] board: dragonboard410c: Fix button cmd name
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b28fee5cc2ae
[2/3] board: dragonboard410c: Drop custom reduced malloc size
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/036b54c7200e
[3/3] board: dragonboard410c: Enable support for KASLR in Linux
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/792ccccb46e5

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

