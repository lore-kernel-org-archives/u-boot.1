Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F10BCCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACFFD838EE;
	Thu, 30 Oct 2025 13:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WRJQ6d0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76485838D5; Thu, 30 Oct 2025 13:16:41 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 482A3836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so165429166b.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826598; x=1762431398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAaK2mcZcWYEIFF3v9O3xPstYVqjlcg9y08oF33aChQ=;
 b=WRJQ6d0AIxDzeQZvKT0ekWN2+Dvk4eGE3fFCrjZWRIQKOQ/W8sOmOKo+1LHLpCn309
 giVW8FPqyKDJcAfclkeI0sN0ZXwJM0pxbXQ80+KPE3M2UTiNGrTzRBcWEtF/FNWgIJrQ
 KDQG6piUsQ9lVpgL4cxlZr2ajisF6cp5lKSlFAmfCUKycbfysfYLYpVi/u89J4HBOU5q
 HSCpBbYj0H2xy7zChPY4SkMyEE+C8CVwg/scliwMoy7FZ22dif889SG4SjqV1t6dE8Ef
 HEDH7u0mMxW2o37udZoqqGhtXVw/ObdcnbOsaco5FFjns2lLabwO2vddO+Xv+rWUvJuy
 +mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826598; x=1762431398;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAaK2mcZcWYEIFF3v9O3xPstYVqjlcg9y08oF33aChQ=;
 b=ItGu0N9Uj9zBkYXvZ/Xq5C1ts5hWb2pKrHIM3TjS0OEvEd9le6Kjb1xVipqNVKzV6Z
 4yf1ntflEpDlRETgmcWCRx079fUZCT+qjnerkE9v6783+0VQ8D2Lhp09GUKTB6PNEtZL
 2WWGs8trILO9WLu0Ncl+ojmHE7FEFLRC7lNp981JQk5iNWRTuk00f3ENkw59OjYhSHXc
 gu+pv+S3/SXpAMiZ3ag9W8cuxb5daFfhNC1G4qul1JZSLrPVOuWVUiCZ6ZkxS8QbRX4Z
 TWmd5NZ/Z7fqQwguGLBz/Kdd+NiwETuwkKJsYNIhGiTj8WZWBJk+12Bsu3jPIvFqkKW5
 o00Q==
X-Gm-Message-State: AOJu0YwLNuW+LS+UtK8da32CHOMOodUwI4qAQr9FRBczHycL+n/fnUQl
 JWgw1xUg0oiIpbKZDJrFczVGdDMsb5cwttX2dtbfp3s4/LRV3BDgwVfehHctz6VmewVizFJ5q89
 dSIxY/os=
X-Gm-Gg: ASbGncum1ZIEE/MJSu/RoZp9FyK9k8hlqh3vp9bxdUE1j7erNhvZD4ZBEsoVS+xKX3o
 eqOsCdKulIRUmgC/YaajNTdPfVyiRo0icrWegI/tBDll5Go5g4RyqmcrcYqsOeFM9llK7wR+eDc
 6Fk38qxHy8R48nSOuDPo7SUNuXjqWJeCjK8/U0K7B6KOXBYQyURyiKU0Qr6VUCA/c6H2yRt8MUN
 i5q7tdNZm4t/62uZQ2V+BAyWWuG3kNLiSKUnic5IVdWqo3ggGPZUe8KvBB+iSSYWgEkQXn7BP9a
 l3+H5P83pvgeSuevhefkF6tXyelBUl/GHpHqL7FP7UXiKX1vGVLcHUbx8e7yepdxh7BYTfXvx1f
 xJIhx3UqMiidqh2+evXzqegqu04F344s8TeFPRW8A5D9YWcXWRM8yUDKK887Vk0e0g+Fg3U6vqS
 JoGMLfuXjtwFKejBG2czoxnNubOchgughK0RscrcrJWvXz
X-Google-Smtp-Source: AGHT+IFRi2XC1lAZe2PHIOhkknnVIHkS1wNM6/0DvEto/NtnXoIE4zUgXsH7j6jTIWoh/SGK11QSlw==
X-Received: by 2002:a17:907:9621:b0:b2d:830a:8c17 with SMTP id
 a640c23a62f3a-b7053ea1650mr269215166b.56.1761826598313; 
 Thu, 30 Oct 2025 05:16:38 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Jens Reidel <adrian@mainlining.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250826231752.60633-1-adrian@mainlining.org>
References: <20250826231752.60633-1-adrian@mainlining.org>
Subject: Re: [PATCH] clk/stub: add sc7180-rpmh clock
Message-Id: <176182659695.4111945.3408093841395871365.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Wed, 27 Aug 2025 01:17:52 +0200, Jens Reidel wrote:
> Stub the RPMh clock controller on SC7180.
> 
> 

Applied, thanks!

[1/1] clk/stub: add sc7180-rpmh clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c293a4772cbd

Best regards,
-- 
// Caleb (they/them)


