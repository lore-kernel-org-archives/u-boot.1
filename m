Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E527FC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EDAD82DA1;
	Fri, 27 Jun 2025 19:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bJJpRvIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2B282DA1; Fri, 27 Jun 2025 19:40:02 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F05B82E05
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40a4bf1ebb7so93823b6e.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045986; x=1751650786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8WCZGKNid1QBOhqfnKzGqRSbjODCwFYKtQBHFQIv1k=;
 b=bJJpRvIZVWIzm6TRepSo0/UQBnm5MIGvU0VBJVvuHt0P5jqOehXhA268+VveIHf8eJ
 uacL7LfDQVSznlybFVOk4T1eeAWGDjIarsIUhBiboZqdyPj+feZo4v01NVJDsbZvn3yw
 NcEEqwAgzoFiQ+NG3nhqc6H2KqhhNxf4miwQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045986; x=1751650786;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8WCZGKNid1QBOhqfnKzGqRSbjODCwFYKtQBHFQIv1k=;
 b=KKLMvhmT2jWD3ML0js7wDX/+zN3YiDHzlODvyP9GkZvQS071RlQjEi0Nt82XI71E4T
 vizfZzBKi+aVEWzwHD5AEn56yOTogauW7mEhwojipxFXW00HTwpF5JLpNgMwVUrQHQqI
 o/xlhqGxZdTW6EQX5LOZa1jo1wQ4uaSU+9+8WaNMPwPQPHsFh2fIzqGCOfmhrLjXaIEp
 2iKPmYV1ybSXCxaGgeigDdBELBE6eT44sF98tQ9K1+A/zGdhYDbXpZWXLkC4dsM1ypKh
 06tjiHF1gIOx4JPCELHWZEQAemKnyyzoenaAavyNFkFTaJ5tMu6+73DvJqHPCch/Gh4t
 wstA==
X-Gm-Message-State: AOJu0YzvU6nkAyiHGZypIfc6nTYW8t5pJTTLmTmY68xPTT7qOxrnplNM
 3e7HZIw7roNRkflLTk8XGreS0poyXLI3WizTCQzq6Esqxd1EbvWZpyOv0rVfbJJQLm4=
X-Gm-Gg: ASbGncvOjOdy3vZ0Rm2M3VCn7kasBCpYi3zTn9RpkvfBgbraAEmtag+nbpvdP2vSUVN
 SrfcWnyrB4cH8Od0HQGSnrKLdxlsY8dUdmlooVQtOF0tSz0gHG1i/jTiqJkcTMwBSCAyOoulQFq
 MupoirNXUHZ5lVdYFMFmByHVZCePvGVxqTCoZTaNt6lrBWSPzCulkSUA2SkoyOXY+4Gy/GyUVm6
 vvpqCtKPDUiT/KpEv4yo++Vp+leXWAB981NxMQfxQGe4WVlCRisbBgKgsd7c2ZUg9AW5alRmOnu
 pCNFKkYPvYs68kVu0km7rNwyp5zM0m1jox2XE1BE5JCIPiKiSHY1xAnMSyfKxb3ElHHWGl9GYzk
 DtJFHgQ2AY4zte6SA7zEsQhoHuCwqLS+o
X-Google-Smtp-Source: AGHT+IGFmYDX3ZW+h+yffFFzV/Konp0HaVE2tvaDUZxph+Y/luTEN9y8vOGVSAy6+XbAMVZkZ3x0Ag==
X-Received: by 2002:a05:6808:13c9:b0:3f3:e9d5:7790 with SMTP id
 5614622812f47-40b33c2b29amr3600337b6e.6.1751045986159; 
 Fri, 27 Jun 2025 10:39:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:39:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Wolfgang Wegner <w.wegner@astro-kom.de>
In-Reply-To: <20250620162147.3419120-1-trini@konsulko.com>
References: <20250620162147.3419120-1-trini@konsulko.com>
Subject: Re: [PATCH] m68k: Remove astro_mcf5373l board
Message-Id: <175104598545.3877702.10068387523961976219.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:45 -0600
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

On Fri, 20 Jun 2025 10:21:47 -0600, Tom Rini wrote:

> This board is currently unmaintained. Remove it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] m68k: Remove astro_mcf5373l board
      commit: e5d4733c2e1937eb7b622771bfea9f1fda0425c6
-- 
Tom


