Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F718CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDD88489D;
	Wed,  3 Jun 2026 18:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RF+6t4ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3704884915; Wed,  3 Jun 2026 18:22:52 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA13F84898
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so7311665e9.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503768; x=1781108568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPwgoBovBLDV0DKcopnmGaEuPwJI4FUZ1B7RYKZNjrA=;
 b=RF+6t4olz8WcP2LRfp9t6xvypDSEak7Yb2Ki1e0qupwVE9/GNkY6dtkqhhb+BlMjEQ
 w8jytrjV0gTdQX7FS4CIsas0EkJr3RYYYJ1vaBUzetXvBTY0/bF3Hbh/H/HUxZ+gADax
 dAX06Acj0jGaXp29JnUvvouT2Fs/sQKUwT7Iiiv8yaS3jBC21qgfak+UJAuAOW4FYBGT
 8SqIOwPgOA/O8yr5N+1oQ9N9wvGLEsraZvU+Q1952yoEULrkkajssjlnRA0lPLXOFnaZ
 Z8PrGPKzxmqFgMEcEaKG3/ucIu4/jCCcxCthfohNSgmG5KNiCOUxV3D4hBNG+mgHh5Mr
 PbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503768; x=1781108568;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPwgoBovBLDV0DKcopnmGaEuPwJI4FUZ1B7RYKZNjrA=;
 b=ZyoARn5lCcpNfkZzBYAxhyjHjJtGLqT2jpC06n2vuWYhillA+IBbG5r1ZTEZk0rXFq
 LfSUqD8Kc4Hqj1l4i3TfBbPBwOF7t/grUKhthub8rTiYDuCzZdljvMNzBJrEM8qube/e
 XVftx0lR2Ooc5cjx8n0KWZ3XeilbQYNa87yQYA4ByE2VS3ztK6cHvl9VBurZZC3dHdSz
 YO44PyoUPu+nbEscuy2GCZF6NIw0RJAIQfd0KcchdNgt3RJe+QBLvTggev+YJWr8je+z
 QTJB54xghG1+7qZKu/bcnA1pFr5ChPltGGWUgweKBtZq2W4OU9QMHKsszo2rfisWNrhG
 Nu7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ol9GnkzJecWhMH3630FgCz9zkYxxCC5imbkif7+TEXJdixzdtk9lKWhw385Jn6qOQwmgIApA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5bptyDEGGpnPTgCuW1zdr7nuJmh2ASoZkFey6jyz/Sx7sJ1kW
 mj1b+9FnCmRbeNnhrZyPUtC43Lum8fUMTE3lD0Qfkt2mVqeL3X3UyQ6PBQIklmL+OZI=
X-Gm-Gg: Acq92OF2stwNnz3WiTIL/0xMRuEf1aNZkMar4srCPwhGA6EFafveLJbJQz8WS+kYmPb
 BObgxHRjjZPZG3ypT+jT2APKx+rmkkaASG3gVOuM6IyAwG/BMMx8FpSOTBzDhi84Xu0srSflIU7
 9uMaytm2z1Kdgl1RTKaEuhfSBZQsGSKmaIqs8gc3ZgwKDP8EVVaqtkvBwdI41qCUZ+KNU/CjO2p
 dySC4BSWg1VVSwo8Wa3lVIXXKAaeQ1w7TMn5DGgwVbeS5VNqo0KlxkyLTjIvfJMoxcmjC6rb9Au
 3NplnHj1oGfBCom2OlG+x3e5j4laLJ8pYSWcL4nxQ/gfE12gnPyNB0XMXn2QWBwzAV5v/WqulT7
 CIp/ZeWgnUcG0NdzdsgHSFZJalzWKJvc9C47a7Mmb4gzERaOuPDGBuM8iwG8rElyLDeX8xaouOv
 f/uy1dv4JZI6NSg/h8uet75aJA8zNciMkYZuE2iSAStPadTPRe8SODMsg=
X-Received: by 2002:a05:600c:c10a:b0:490:b9c3:6c45 with SMTP id
 5b1f17b1804b1-490b9c36e39mr38876495e9.18.1780503768121; 
 Wed, 03 Jun 2026 09:22:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7d6b990sm33713275e9.2.2026.06.03.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:22:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20260524145721.9206-1-prashant.kamble223@gmail.com>
References: <20260524145721.9206-1-prashant.kamble223@gmail.com>
Subject: Re: [PATCH] nvme: free prp_pool on nvme_init() failure paths
Message-Id: <178050376742.31799.66788521672583213.b4-ty@b4>
Date: Wed, 03 Jun 2026 18:22:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Sun, 24 May 2026 20:27:16 +0530, Prashant Kamble wrote:
> nvme_init() allocates prp_pool after configuring the admin queue,
> but some later error paths return without freeing it.
> 
> Free prp_pool before freeing the queue array in the failure paths
> after nvme_setup_io_queues() and namespace ID buffer allocation.
> 
> This fixes a memory leak during NVMe initialization failures.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: free prp_pool on nvme_init() failure paths
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/11e056e3207d3b4eabebb1a7630b0195ee9eb5ee

-- 
Neil

