Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E99F103E162
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 11:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A517984114;
	Wed, 18 Mar 2026 12:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rYTuYrJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F346D84118; Wed, 18 Mar 2026 12:28:33 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C04840CB
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 12:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43b4121c40aso480518f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1773833311; x=1774438111;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWvOL/XleVdzt+FI7Y17Y9FltGC+s/F3Ve5SNku94Ag=;
 b=rYTuYrJv/9sHFZbuCB4jrJ30BaEesOExu6jC2FeU5Mvgw4+Xlrzd2rXDTKiLIk6i2u
 740NGsX3dTnW6BzuVL1sHrLG9KWNvlricBS2+c+wPq9BBNFHXtxsdMSP++VzRNAUV7rQ
 r9QHchhIjwcahOLoi0RHYKgzSywTd6FX/Jv1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773833311; x=1774438111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UWvOL/XleVdzt+FI7Y17Y9FltGC+s/F3Ve5SNku94Ag=;
 b=dTI1MIkAB+k6ET81KVfsjvsC42M7vLdHKc13VwnIBKushtRo4hvXcIhctyUIWrSf1m
 +zfxNY+fHG2rcE6n52CZUyb9bNhbKQe8FBINu/IhY/wK3ffpkaNr8GdDYwsNDoaFePTk
 pSUP0p1QNqXdC/jiRDi1cDD4TEa0QRZrMJKizU037hvwKFX+q7F4qKz7iAbR911STvGz
 cFT7Gwp4MqXpQ0UDivvwH85sU+rDFCXT/xUgkltbvuo+ziVXOKZ9p5fqwSq/OU2ntfsW
 B3xkS4xjWvwisD9TwqsxX5TSOtIlgO13ysH57UZwr9/DQHh+3RaTRoVMIFYxJrIvWxPd
 iI8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGdNxr/Ty08Sgt3hCP/78vZapuivDntbZq4GWV66anLqI736s0NrY0RGdffv2iwBcZ2WfcOhs=@lists.denx.de
X-Gm-Message-State: AOJu0YwpKFoJYNs4JJqvV9u4uIKnxJYcO8obkUvTTuSo+86NKvNS911M
 z9zWgSwV4KtFhbdOeH2iZhNkx4nSETLmR+uSfN7OX1U9w+fV9h9mO5JhP1CX8rz6X2c=
X-Gm-Gg: ATEYQzwfcKrZFYrKx6IIG8xa9hzYivV51sjZv4bU8U90NT4Ccu6rJZbw4x2fY5op76s
 /zCE4/0gqXCi98JVy73Quy3GLuv9YlMG8gen6ZdwF0bMl44M7Yq0wEAvR0TB6VyYvBP0FeZJ088
 WCSJphKSe+Ks6FJG/t3IdkMioxBe0x+VNKNMFjGiG1ul1C/COtXdC3072SJOTk4dnbzyk7qOngr
 XFtLyrILSmlwvmfP789TxuR5jsKyRvsGCsdOP/QmYQfG8kaDqHYkIjb4eG0D4P7zsw5pAijT4yd
 wkiysnLT+QYGyPfJ/Pe5M1D1DNNjgvjLCPdNsv1jvxauai8FqRHFC06XUtonJQ1fDY0YNxERTZS
 Yu3TNZLEgYpB7yuBh44eF0PPHRZ6b+rHQLTfPYMmWan0aA74ZMmWZTcqQxzbh4oAHxC+PZmxyOR
 1anLDymLxg5YjgBHj1vZWFkYiRMWkouaX6es1MxyxEQmDyf90KpfebGig5UCAyQFeDdebne/MD1
 5nT5ZB/2+mc9DViabGEanjtcrNTojajNZrOXuP3gkp2OJLMZZ1bgk9cjTMJz8MxAWHhkSDji9Gj
 1FC4VYckKZitArCI
X-Received: by 2002:a05:6000:26cc:b0:43b:4983:5d2e with SMTP id
 ffacd0b85a97d-43b527ab23cmr5174780f8f.24.1773833311456; 
 Wed, 18 Mar 2026 04:28:31 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-87-9-97-160.retail.telecomitalia.it. [87.9.97.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a2cd3sm5885476f8f.32.2026.03.18.04.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 04:28:30 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: kory.maincent@bootlin.com
Cc: alif.zakuan.yuslaimi@altera.com, arturs.artamonovs@analog.com,
 daniel@makrotopia.org, duje@dujemihanovic.xyz, e@freeshell.de,
 hs@nabladev.com, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 l.anderweit@phytec.de, malysagreg@gmail.com, me@ziyao.cc,
 mkorpershoek@kernel.org, nathan.morrison@timesys.com,
 patrice.chotard@foss.st.com, paul.henrys_ext@softathome.com,
 peng.fan@nxp.com, raymondmaoca@gmail.com, sjg@chromium.org,
 stefan.roese@mailbox.org, sughosh.ganu@arm.com, sumit.garg@kernel.org,
 thomas.petazzoni@bootlin.com, trini@konsulko.com, u-boot@lists.denx.de,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 xypron.glpk@gmx.de, yangshiji66@outlook.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v4 0/6] Add support for fwumdata
Date: Wed, 18 Mar 2026 12:27:54 +0100
Message-ID: <20260318112800.21578-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223-feature_fwumdata-v4-0-680ea4ad6ce6@bootlin.com>
References: <20260223-feature_fwumdata-v4-0-680ea4ad6ce6@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Kory,

Thanks for the series.

I have tested the fwumdata tool on a STM32MP257F-EV1 board using
metadata with banks containing 3 images, and everything works as
expected.

Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
