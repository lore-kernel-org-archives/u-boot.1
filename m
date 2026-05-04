Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF57FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647CC8484A;
	Mon,  4 May 2026 22:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YrYgZLXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AAB38483A; Mon,  4 May 2026 22:36:16 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A8C8483E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1872504cbso3845394a34.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777926973; x=1778531773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrPB440B8I/BexH91AZauIev6LlHA82oIgxdLgTWf4s=;
 b=YrYgZLXd/TTxqa3chbSI41L5soZooS5ze3nNC+7/O8m9qrgeZ7AR3Qdi+SRWczt9P4
 dK0ldclavsuu1ufe9xME9dMLUz3SsJRphnIbKIt7yhVpvic/LnnwsSQWEnVxdaNEgGOv
 0XuWV8c+ohP3h7QamenVLQRfNATz40CqhvqRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926973; x=1778531773;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vrPB440B8I/BexH91AZauIev6LlHA82oIgxdLgTWf4s=;
 b=XVIJFPVsZm1f7EJ0fJvLxNLlhzlG5D/9gxPeN+aolULuc2dMgr+m0VTeoZFPZi3NmU
 ZKy/M8baiiqYVI2eiNzQw1Rx1k0jEPMk6kSRMu9OyBdv9FHiZWBM/vSGFUh0U7iYBVXl
 3NgX37mVkxXf0Zs6XmF+MUCT6+1ihzVC/BMH427Rj39FARTmeIPz2cPFctgKkkXkOsb5
 I5uVDbhW9foX9n0/YfDgRVlO53TCz53hq2vsZHMv1zcT+jYDz3QpRe9kc7qSo2xr3awE
 OEa9nxPC8VC0raTMk8XRvyPodX5RvgtaBgEy9k5hzXunZXyJyNCWCaVE1ba+PEFv77OH
 accA==
X-Gm-Message-State: AOJu0Yxml1MUOt8xsxpKIUTNmWSm2kpjVsSJkJLPl34ZbkZ/Bhbs6r5q
 Ly5HBy5FhikdfOgVFwbzcNngOtPBbVlmfK/6duXSMbvYw16D/nSHOgqQitdrk8/PtRKqa2lAY8o
 psJYUCPrKp9zP
X-Gm-Gg: AeBDieu0oxlr/cdCDHVcgT6fykdCEArxjY6s/ypsq0TnsdYrIv6D4Wup5wL2EAdEpgd
 7emGUDkWimyh4bqwoql18cVZydTs0R746Ca9hRRROkYW57RoI5GOPwNrw3AGMVBes4pqwnlhVCz
 F8T9u08pg6Mj7tVDJrxRSuQsdUrei/C+2Az+fOLYEpLf714Y8Zr+o45EiCb4pE4jthRft8YUUsB
 mHHmPe7WR0wEkC2xlRAoYpIs7jikdE1U+BHu5rukyQGNBgKs0abjOOLfkuTW6zSt/bkNgEmgNx4
 ji3umb6GA8y12tjj3h7X4ouweHfVarHxzcqwtVMLHJNYmMBFTxlqNlE0Ozm7/XvfgLu/ZCWiGd0
 ZVUa6b903sQCqCJbgZgI8OdzsMKV4ZVrgCPn5o/Q3KofMmTnCsaSuSgmnid2bOKKq5beDYny1Tr
 35+u2V7louCyb+nOsXoNxJRCu9Z+odt+zblWm+Oq6XcC/a3wdbmX0YD23TcY/HgbZRzLN/rfC4x
 ZZGJBF0QLxIJyuE9CWMrP1qbuLRb6Os35ooj467hZDx1IYpymG34aQiA7sG
X-Received: by 2002:a05:6830:d02:b0:7d7:dcbb:280b with SMTP id
 46e09a7af769-7e0bfc6902amr701300a34.1.1777926972972; 
 Mon, 04 May 2026 13:36:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26330sm8464401a34.13.2026.05.04.13.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:36:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260504145820.1727552-1-sjg@chromium.org>
References: <20260504145820.1727552-1-sjg@chromium.org>
Subject: Re: [PATCH] .mailmap: Update my email address
Message-Id: <177792697222.2985766.9030338503762575249.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 14:36:12 -0600
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

On Mon, 04 May 2026 08:58:16 -0600, Simon Glass wrote:

> Add a .mailmap entry so my sjg@chromium.org address is used for all
> email.
> 
> 

Applied to u-boot/master, thanks!

[1/1] .mailmap: Update my email address
      commit: c7a6d4fdd7d40c5a3da11cd1ab298ca2c8b7f18b
-- 
Tom


