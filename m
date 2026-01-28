Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B7FD3F064
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF27B83F4C;
	Wed, 28 Jan 2026 15:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rYIe8ZpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DABD83CEA; Wed, 28 Jan 2026 15:02:38 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B8D83EAC
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4086661715cso4633977fac.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608955; x=1770213755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmiRQpBdgavRvSZQbCkN0CTDOstUcBl1azZYNz935Z8=;
 b=rYIe8ZpEGba+jWS2S5XVpwAoscGYp0ChjBfgfEsqfbDlwoxxx63AaHW0oRRoRXs+vm
 ArXt9cwpVCs7ANBVBfjbwN2h9sA+D1xIuPD9/e6NPe1JohwL8GmSlqugZXj7NXQorzPu
 rRUmHXG3h3cDy6lZ0fZ2br0XJFZk+2CL1+gsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608955; x=1770213755;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CmiRQpBdgavRvSZQbCkN0CTDOstUcBl1azZYNz935Z8=;
 b=oUIr5lVbx5AnHMFsa/fAwaP+iYkpKTh7GpILK0F0iaL6o2n3zRPOkjEkvE/bHslR3t
 cC2/wwOesJ3TZMrAJVEpAy0LHEOs9/Hj1/l3227ME1cXslcEXOcQ5yd3ctmPHKtj8nOU
 0sdpe9zRs3+CRA/1r7FaAXCBbRnnRngtzVP7DJoVk6DgycL/RYPEEE9V47AwWSsgpPpo
 MnHYIUHjAIkL9Vc/m2qYWZ4i04/vcZCXF+ZvGdBLh0Hgax7NAFtA76UzS7tXFDEjSgvR
 sb+jrEFbQo5twS58wiMt6zFsK7UT7Exv3w2HVZJ7wGy7G5gsZynmnvITUlMeeomSf7Ra
 xSKQ==
X-Gm-Message-State: AOJu0YwTzYIProhRDu3efKKdqh/cDmjFeMYwwVDcKUwP6aHwtsXR6Xo3
 VGu1bmnz0zvidlzdutZzAulFZMmHGEWUvgUl1QwnX8roEjrHmzm9kHzkkVcGIWrKCzg=
X-Gm-Gg: AZuq6aK27WqEwe8w3gFtSZ9ia66lzNmF/i83KuuwrLCKN6UfA5Lz8pu9f0Cp8t0NCHt
 bomyqsLqw0aJ93JEGTOmQFhULxZSpPBOasUAQUoGtI7FY+fynjs4AXzvWKT7oZT3TYgsumWdTlT
 icXkoirc06VO1lPW3j4PNl4VYO5XT5w1dRcwJ6moqQrP6o9qxbI26achKcL0NvhJWb6atufxtw/
 moan2vmCAkR7yURxNoSdMRkGZTyEwfnb4f5gOLP0J9apWUC1cWngjpb3ErcfnHAjZBcwJYt5T9L
 fAUejG+ZhcOD1T9HejNU6hZc9OPVxSljb89rXhtiDl2A0kKmneSt8jzxLPPXbGRqOb+WaXWVw0N
 7bYahVr0b6pl9XrL8Yp79gY6swgq1Z+BUFN1kiWDDpwfI9pUXafzX8uXcqCwBQq/I7gjcNnf9k8
 h2FB4J85jWpxg8gYprBzcvigGTZIg+sGbyiJp7BTzjlcz/vljd13LGg1wCQmMETROAX1W9FlkJM
 q9/i/+024ZSs6SpCALP20v4ZKrhVhBl/7/l4G/DkBm0Hf03
X-Received: by 2002:a05:6870:ad03:b0:3f5:694f:9366 with SMTP id
 586e51a60fabf-4093ff09979mr3675087fac.30.1769608953566; 
 Wed, 28 Jan 2026 06:02:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Simon Glass <simon.glass@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
In-Reply-To: <20260122224420.2679336-1-simon.glass@canonical.com>
References: <20260122224420.2679336-1-simon.glass@canonical.com>
Subject: Re: [PATCH] binman: Regenerate expired test certificate
Message-Id: <176960895265.1640006.1370983922834730888.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:32 -0600
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

On Thu, 22 Jan 2026 15:44:10 -0700, Simon Glass wrote:

> The test certificate expired on Feb 13, 2024. This just used for
> testing, so regenerate it with a 100-year validity period.
> 
> 

Applied to u-boot/master, thanks!

[1/1] binman: Regenerate expired test certificate
      commit: 4234f4d432bf1dcd30b5fee91c71abc1acae5e75
-- 
Tom


