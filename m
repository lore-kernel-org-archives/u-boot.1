Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D930C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 09:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB76888276;
	Tue, 14 May 2024 11:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ldR6WqNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43998882D4; Tue, 14 May 2024 11:59:11 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2FC788239
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 11:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42011507a57so19747785e9.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 02:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715680748; x=1716285548;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qc6iVlGFE4LgwB6BZs+MY1vs80JuQhfszJ1mJMGM24=;
 b=ldR6WqNRByzWl5fOGEtXzQHIyS+FtQFmD3AVUJfbsJRWbVd1OEYVsIV8PexhHJULem
 MBWYq76ij/fdi65AIsB/S3Q6MGsEmwvkOZLRfLAdYRdnvYup9zgQlidJ5ZRe2S0XR8VT
 32sjQAvOGQ14wN1CTZ5WHNhZAykEjP2q4zhLalmXUyBbx6pX5qyhYVPsDg4CvuKM4JEu
 1B/33uvtSnnFPm/wkRSvN5RK6jkvtQEa8fGhHuKcLhWSq4IjwEVmz13tXZLYJi+IZhJp
 1ZhlBzHq6ymFvji/XXocVkv4zCmMcTU+iuuEsMW7WB/Z5Ts+KHEgGpwKrifnuFixBsDp
 i6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715680748; x=1716285548;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qc6iVlGFE4LgwB6BZs+MY1vs80JuQhfszJ1mJMGM24=;
 b=HNkCVI4mK4JY4QnUoqhw2gyWS/JMaF6DHZlMXP0GzOlpxD4dPAzPq4NMk2zu2RpFbQ
 n7HQuyc2R+OkkW9XTjyVjAujxowdMCu/8Y8wIKEHlWhXEUBuKB3dXgomrQ2PkPxuTBVn
 bie/jlTjeyJydgpWpZqXHV03nLdmd29IIyXI4DO0I6ReAsO6neIv42IBnSXAI6r4ZMhT
 rHClEeOv3ChI1m2ZrpFQS8qzh26pz/XarDw2e8HkpD32b9ZA/1Ib1LyJRqkzZBxip0qI
 XS6QVgdcMXk+gXznDwnNbRkCqs9C/JlQYdTl9tSHdI9wbZA2BibEpBtY6YjTVVS4zSDr
 RUgw==
X-Gm-Message-State: AOJu0YzYvxVlZVKuUa+iUgIKI71bD0xw3hsx1QYQO9tl00R7euqTIZBO
 AplxJUe3+vMz+db7Us4tlgIBZQdeIvbXMByACHJVl3+XxceP+DDm0mqXq8DJtTE=
X-Google-Smtp-Source: AGHT+IEMvzXq26J5rjIZN82jpe6ttFl9m6XDYUgv3T8ZI4CuTZVWBCGNshSQQm6oVb6QZrdlW1fvVw==
X-Received: by 2002:a05:600c:4e88:b0:420:1551:96a9 with SMTP id
 5b1f17b1804b1-420155198b2mr42168085e9.39.1715680748379; 
 Tue, 14 May 2024 02:59:08 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8f8asm188510075e9.10.2024.05.14.02.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 02:59:07 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Parthiban Nallathambi <parthitce@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
References: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
Subject: Re: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over
 all PHYTEC boards
Message-Id: <171568074755.984971.15200589481911918774.b4-ty@baylibre.com>
Date: Tue, 14 May 2024 11:59:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Fri, 03 May 2024 09:00:38 +0200, Benjamin Hahn wrote:
> Set CONFIG_USB_GADGET_MANUFACTURER to PHYTEC for all PHYTEC boards.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] configs: Make USB_GADGET_MANUFACTURER consistent over all PHYTEC boards
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/371b379edbf3488d77bc321dc5d2a0e22e067744

--
Mattijs
