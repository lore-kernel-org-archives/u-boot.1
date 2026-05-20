Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC42CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E171B84862;
	Wed, 20 May 2026 15:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uc2CiGhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCA898484F; Wed, 20 May 2026 15:08:49 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83863847F6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488d2079582so47012265e9.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282527; x=1779887327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4MqmbgfoYEQYyS24GU46PpsstBc5lztPBmRm6hfttY=;
 b=Uc2CiGhub8O36TcuYarBAgZnUP75MW+egiYLJsFSj4bfW+sCut9B40eJdKwYzt2GCA
 NsNs1XTD/YS9OfhfoEq6Jv+57oG1gWNmbmv9TiazKl02wOf5jn/tHjKnEFqwY3vK9Qic
 Nu737OxwDja8jum124OsvQTW/zIxbAKqQpXycGAZ8oJXIoWPegWGnufiYX3Topwrd2U0
 fbxCaCioKAP0v0nH6rwncI8yEW8luEXfidFax1DzjHdq0tZRoGG53Wqvc0vGCDaa05YU
 VqFQDZYXlG5gYeV4LFi4tIXftSYgk+qqnfGoCpuMJOiOnQ3u2b4o9kJ9IrAxdL0hNbnd
 zQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282527; x=1779887327;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f4MqmbgfoYEQYyS24GU46PpsstBc5lztPBmRm6hfttY=;
 b=H/X2IKA/9gQeAxrYB8aVg2m9pDw1Yy4QHLjMq+xqC3ZMzeYgYReqeTKJFuEsbfbgaE
 SvZsUPG4IPWNPypoA7Scq2Q01fnb/tKzzx7gg6LUeX0t2allCfX3Aq2owtXL68SCAd0L
 yNXdU/Rw2DS8h0iNBPJiE4h/508IF6oOFAIQhS7k71IQEie73qIkdYNGxK9m0HRxOCC6
 kmsSTaQvfSPXi8RiYl3tFozM1eVUqYoCitArb+UfP2Ni7ALPl20BUwIkEhgPQZGcD1mT
 /e9YF/LG5n27BAGnUorOrKTu5mYfmWDS2/lihx9tIAo0hFciMhwEtj48WWkWyFC51eMl
 9vOg==
X-Gm-Message-State: AOJu0YxJdQ1bBdD17crj1UE0rttAqom9JufAwH39hvj5Ht2OMP5dsRkr
 lJ/dMVfZ3ED/4t6SvjT1rQDYKoqHOHSzdEWdo02JvWBvWiqU0gnB6s68A6yS+0R9lsY=
X-Gm-Gg: Acq92OHjLZg/m5BWPsR7wjLviOA/z4SUGFqHF/Z/kdW2u0npn0hMWEWzeYv74QSCkrg
 waHqijOmIQ1I8Slr93WbQItcdnNi6iAdeizFnsqP54FgDwENSM9AGxfsHNhsaUEdvvxrEXugbCM
 nvQPkOYODvSTKMznVrfwP/q+RjjQHwzpHt+Uim/hjse7s0105niNrokuT9Li3UQwCXhN8T3HvgJ
 Z31r6vOyEcBdugbxOT9Fu+fYCNF5xHTeuBRLllFP8255PLseXKrooo2yqwkwaSl1cIYfs5ndVOS
 UEDiQoYH9/Emhe7dgZ1QDSxiCUtyyqcj1vq+Kc7/gBC2Xzc/c96uJMydfidIqAPyalAiVU4ve5p
 dRuFGkNrt/+Wpy/ZJB8d3XOYKc8+rQrneReDWsUdsiQZ/Mw23lc9xdTdZwqpPLi2mPSiOnmxiHa
 fzKxK0Zb/MGQ2uE5BM+5LrU8U8/EA7run7vabXe87YbVMpmI5YD+RYpx0=
X-Received: by 2002:a05:600c:821b:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48fe6515831mr354644135e9.25.1779282526811; 
 Wed, 20 May 2026 06:08:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm371316615e9.5.2026.05.20.06.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:08:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20260518022535.17197-1-prashant.kamble223@gmail.com>
References: <20260518022535.17197-1-prashant.kamble223@gmail.com>
Subject: Re: [PATCH] nvme: Fix PRP list pointer arithmetic for chained
 transfers
Message-Id: <177928252630.3008922.4975099427754924207.b4-ty@b4>
Date: Wed, 20 May 2026 15:08:46 +0200
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

On Mon, 18 May 2026 07:55:35 +0530, Prashant Kamble wrote:
> The PRP setup code advances prp_pool using u64 pointer
> arithmetic:
> 
>         prp_pool += page_size;
> 
> This increments the pointer by page_size * sizeof(u64)
> bytes instead of page_size bytes, resulting in invalid
> PRP list addresses when multiple PRP list pages are
> required.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: Fix PRP list pointer arithmetic for chained transfers
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/4f510505988928e129e109811587c4a00d28ec56

-- 
Neil

