Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCF7C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B99280BA6;
	Wed, 22 Jan 2025 17:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fF7cR02D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F3E80944; Wed, 22 Jan 2025 17:13:02 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5778080A09
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso213481366b.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562380; x=1738167180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlDdJ4km3AFsJLkv/cyYoZeb5CQKQyhWGWAMIgu3aww=;
 b=fF7cR02DnTabOGfBA3wvL8jHQkpg/kbEqZw34XDLyZEFKBCdwStGK0j8U/9V/+LlDL
 oaAVcHtdJrN0poaimoTg8kxBf7bgjC9B7CdOdBiSUx56Xbl2nKTaCks/rR9h/iWZXGZq
 Y3m04+fpQNDZmKuUpL2BQN+w9gsd6Hl8KQlZzS933zWUA+nwa1Kz/3Q6eL0A7ZcmEatQ
 iwga3Uv6hb7ffDWjK0neprxE3HSo/5phsAqEZ0YafFAkI5z29wV3NnhVyhRnHljoammk
 TCodMeoIzjw6WuBUopB5zH4n2EidR4qrgK9fDo1q8ogVUZvuj8VYT68oNtFU8SJZbb/s
 f7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562380; x=1738167180;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlDdJ4km3AFsJLkv/cyYoZeb5CQKQyhWGWAMIgu3aww=;
 b=QEvUFhYNMICRAvc0yF83+lhawwrrpLd6l/F25k1/AfA7AOO5IfucgBV9c56WBuSNSR
 G8Kff34t0HwQL4bEcFL0Oeh0y5SpgmRp/Cy4nhPY663CJfUYBZlB+YspchqJQAuUA2dF
 2xP3VLcP8RlOsEewWyHgsj5swodP87IBWyeSSRLQQoP1OjbE9Uz640NaE4V929JKD+gT
 erwcnMQSbgo+sENn/Q50r/xOqf3BVpUGAYSfbrMrCIHMpJAv8X9Gxo4KU8yNpKr6uAIV
 0meFvSuoMNEFP1ePiyBSO7ARPUiDdErfvQt7xl2vGF7t4n+7h5ZaxR74u7RQgf2XD9Hm
 fc/g==
X-Gm-Message-State: AOJu0YyMrZWJORk6pgY6SKravQPG7loB+kj1ekFHlLiei4Af6h67wIR6
 /ygrnZzkMxtiRpMev2YQHz+E6ATPZbhEJ4Zbu/+ZR8pSVHBVhKY/hc4WCvOXhkLhFhvzyhXn1uL
 xPXc=
X-Gm-Gg: ASbGncslLNi+t5wWfKRj4SV2/xXUS0tH/Mh/5bkA4rK8bQwzLw+3CPScxUBJuCB+IDH
 FABWz3cz9Qx2eWWiINSxz/IdXAZqR/S1NHVMC8qis5pRwHBRw8jkTjOL/9IK2BnA/7wRZg9aqXt
 Iag5PfjLcwE0JWl405ZvxMcvYzueNvRIAKICxtJeDwbLiaxIJ3l2/nBif8NjjC4DQyDLaT1LILS
 mcvG3xY3/uT1/2D+kxJGqagTK0WXLyXIbc+372JyQhdLw0pgbxl33soydYIwbrsnjuwgHZ7S/eh
 lkvCJjHNxogN
X-Google-Smtp-Source: AGHT+IFHxtBsWvgbVsBumUsr1R7JUKbdzLNYEQgW8zTEIOBOyZl9h9IUGjF0IIggrUWaxIsw1Wjjpw==
X-Received: by 2002:a17:907:6ea7:b0:ab6:437a:74ce with SMTP id
 a640c23a62f3a-ab6437a9435mr676719966b.4.1737562379838; 
 Wed, 22 Jan 2025 08:12:59 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:59 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
References: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
Subject: Re: [PATCH v2 0/3] cmd: ufetch improvements
Message-Id: <173756237896.1864727.13356737961259385526.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev
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


On Wed, 11 Dec 2024 23:25:24 +0100, J. Neuschäfer wrote:
> Following the recent addition of the "ufetch" command, this patchset
> improves it in a few ways.
> 
> 

Applied, thanks!

[1/3] cmd: ufetch: Fix type mismatch on 32-bit
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e288366364c3
[2/3] cmd: Allow building ufetch without CONFIG_BLK
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c38d5bad3507
[3/3] cmd: ufetch: Show CPU architecture under "CPU"
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3db33a6fd690

Best regards,
-- 
// Caleb (they/them)


