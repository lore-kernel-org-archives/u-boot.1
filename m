Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54585CD37B0
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBF784CE3;
	Sat,  9 May 2026 01:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d8gQxhL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B2184DC4; Sat,  9 May 2026 01:14:45 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0303684DC4
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de44ed7a11so1991178a34.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778282082; x=1778886882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML6rs/v4GMEYM4O7QeW2HmR9au1qbvuEQOoHt803RJ0=;
 b=d8gQxhL1y8d6Zd8bmi8ZZ+tZU8DFmmHGSdccE7P0flzVEtkPj75ts2IMNB8zZSoFWk
 sTf6+BlPDIJrQClAT0l5BtCgiqgbxbUAcZUmfOZmO688q7xq73Iaq7vW9WOhKgTdsA/R
 +bCzAEYMHPpskcjgkCGzui07HQRnE4DzP8qiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778282082; x=1778886882;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ML6rs/v4GMEYM4O7QeW2HmR9au1qbvuEQOoHt803RJ0=;
 b=Yi8z4f2CkyxiFlOk1F0tJ6swmz7s8hSmMSPEHhydL7dviRjA/+UOslNrFxuSSxIfy3
 49BTedXkhh9Ykz8lntZTcj9vUvAMWQqq7uRFQfsouJibR6cBKOdbnJLfS2S/bEXL7SIt
 OuntoGUKUIrHmslfQzhmszZLPCCP/ozk8lA/Et4DME5ao3bbBXPKj9x4YLqRMJyNBhIO
 LbA9TX4GHdeSzsnf9bLCfwTRlFM7BPukToFLn+CKabRBECTSjisefoOXVj6ejICswoiP
 O1fW0RmgW1eeDjFfnAbRkrjPWoGRjuk47HupUPiL0oKl1S+ZrlnzQie7vpxXdcQG015K
 Dobw==
X-Gm-Message-State: AOJu0Yy6I3Bqa9hiWzx0IqYFfcCZKtcEBBxuqyQiLRNqAlP5LlRNJWOa
 V7YYtwO97BirLUHpWta4ALpIIj9emmZrPg0j120YZuQsPNm4wGPYGyh6PZWOvCTpVSiuNyWNvTD
 Z+R9fGmUUsn6o
X-Gm-Gg: AeBDievvc2gWpapGvjVwzH+jVAOGK7LoNPua7jFckTDEImac/RY8t3jN6gMkU0BxRg0
 aU30y2kcatoIWctzF9ewAlyPBbeafZB+DRMvXVrbo0XahXaf9SwQZmOvtyW909O7qKNqa1JZbY4
 zEZ0WqjXPAQVAWvHdLRB5wrPXh7g5GNrIY/813C6YcJaKE4zbeaAoTeWOtA6PhAXy2OfBo/dbja
 AGakQNCzOMJfpyWJ0Q0+SFR8vIbzeXNVRyunklA+gNO7k3bP/z6TA+QDoK2VJSnQJNuE79JDlrU
 kBqWlUX0V3STSDC1WO47N/50y4Qi4Rb8Tr6lTOy3EVlwUdz7NkWQpUHpsymBdU3hg4jZdh4BBa7
 W6d0BAcHeg5m6dVwS0hBIKH8UJsTv/cmf2hXJ2q6U/U2xCJiskZfIOv+WNQRatARJ+kAvgFt9pY
 KWv3RS6YdE6Z9H0t2Dgkii9nTg49ZJBP7h7S69p5/bnmeuw5yPD6UsGbqKHLO3A3RM2so0fUmPX
 DRVNqTyzHPW0JZtmgEv+89iXvvkJAjfwfBj4m/81GyYiQJL7ag270+BRLHc
X-Received: by 2002:a05:6830:210f:b0:7dc:c926:4f87 with SMTP id
 46e09a7af769-7e3666cef1amr3130125a34.16.1778282081841; 
 Fri, 08 May 2026 16:14:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1168sm2005082a34.5.2026.05.08.16.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:14:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Daniel Palmer <daniel@thingy.jp>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
In-Reply-To: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
References: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
Subject: Re: [PATCH v2] virtio: fix boot device hunting in qemu with virtio
Message-Id: <177828208110.1997265.5841690996670230948.b4-ty@konsulko.com>
Date: Fri, 08 May 2026 17:14:41 -0600
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

On Mon, 04 May 2026 09:10:23 +0200, Ludwig Nussel wrote:

> Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
> failures") returns -ENODEV where it would return 0 before. That path is
> apparently hit in qemu and breaks boot device discovery
> (virtio_bootdev_hunt() expects only ENOENT). So return -ENOENT in
> that path instead.
> The remaining two error returns in the function are untouched as I
> don't know where they play a role.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] virtio: fix boot device hunting in qemu with virtio
      commit: 18806dae0e6fa9e0912a258e15f61b1b346dfdbc
-- 
Tom


