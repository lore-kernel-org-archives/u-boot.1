Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF3FF8873
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 14:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C1E841D7;
	Thu, 30 Apr 2026 16:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LMDXj+dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4821284198; Thu, 30 Apr 2026 16:57:11 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323A783693
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 16:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479d9b155deso392631b6e.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777561028; x=1778165828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1WTaAgFL08jXCkJyuUdFbp5d07OrgFY0GeH7ys7y7Q=;
 b=LMDXj+dOvn1HgH6YnAYgtYbFCNRCjtte12ICzWMkTnyl7ZE9Y/yd3MRC6O9Zj7yRo3
 2YS+9LR+c2gltTrhJDESP1wokpPlBiRfzFOQ3q/R1/N1FjS8Z/6N6GnNVF/7+x6LYebn
 ZAM4IOf3gfsis1l3wpr77PBjnzGqZ1qnOTN4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561028; x=1778165828;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q1WTaAgFL08jXCkJyuUdFbp5d07OrgFY0GeH7ys7y7Q=;
 b=FYSf71SyU/Vu68hAEfKsv/14MHZOrlKHby0g1ZiqpKhl77t974Pc9VL7UYtwvcdioF
 pYJNP/W+5GLMqxpi2KvBiLKyXtcxZAeClK/t8JpqRpH2qf2QX1OkcI1HGSvOXh7On3Am
 K5iExS76SC3I2QcfRMPCDwVhq/zCfO/n2nfpysW+5MD/E/owJdWleXoDZRj3I3HneKNa
 1UO1jRclZbqxGYlIkMH8/efOsP+FNHEUKatn4FBIgGFaWNbdX8hPiUf4xa+41RBd/Ykx
 4eYG33+h8UJtpog1PPOL5wQezp04GyhZ61IqagyDpvU7e/73FhDxBV8FS+6lzG110Uex
 qjEw==
X-Gm-Message-State: AOJu0YybygwYYjxgpmnjUtu8zubClNg9RZqO4qp6sd69Cjmo3V9o9hv4
 b5tZUSeHHGkfwjoJoLbwu50cE+tXAvQ/kIDfTxmSiY3Vpw7J9nxHgZt6SBcFvfogVu0y8l9tndy
 LYu1Aia/h5Q==
X-Gm-Gg: AeBDievuDPdwtXJda+SkLvKNeH1yHzsqch/17pmA8vkQDTfCxb83En5nYHtwG5Tec4J
 whd5JWaQGnue6FffplUK5hXUZQJ6sCjaeuGBMzSt6Xi1XFpVamyVtiocxNVqg+6frtLcjzOZjsm
 Trrq6x0Np0+9npldD5YOc+o7Qg4ybdu5XfhvL/tGarMheHzJgfi5ZYhIw8SbjoxVZXF917hSW/Z
 2DEf7Gjuk5lRFob0uLQGyCKKdZDQq884GuVJOEB+fQPEF4BIknDfOYIgK6gQLF2xmJbUfXKuIni
 v0ftSDzpw3piWVFwQ6K/0wv4RdqyOAndWIXSdJU/YEhh0RkKSEUYxT7PIimEX81zQB/7eAyG0LI
 SQiBfEL+yR9gfE347XB9Zlg42Vbj14mXV80XDY/N3nMRgXBlbc3/zIg/dpO0hK11/RzAtgg5N8y
 mw+KeJ/JhDaMWCX6EJaz1Yf4qQg1G/bX0y/lsdznDVI3EAvrHf9ccI8D9ma05iLLFj9IBjTTXwJ
 jQR5PuBoZ81adHgZWntZefeUotq1BpxvNtixagCYtpm0syJ7uBSKPB726rI
X-Received: by 2002:a05:6808:4fc8:b0:479:eb19:6e6f with SMTP id
 5614622812f47-47c5fe1508cmr1566961b6e.45.1777561027836; 
 Thu, 30 Apr 2026 07:57:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43ee0400sm2998426b6e.7.2026.04.30.07.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:57:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260429204109.2548796-1-dlechner@baylibre.com>
References: <20260429204109.2548796-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-master-2026-04-29 into master
Message-Id: <177756102579.1633235.9898877046770178389.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 08:57:05 -0600
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

On Wed, 29 Apr 2026 15:35:54 -0500, David Lechner wrote:

> The last round of new MediaTek features for this release (we wanted to give
> these plenty of time for review and testing before picking them up).
> 
> The following changes since commit 4433253ecf2041f9362a763bb6cb79960921ac7e:
> 
>   Prepare v2026.07-rc1 (2026-04-27 17:03:18 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


