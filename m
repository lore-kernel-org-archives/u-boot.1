Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3398F53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3CB84142;
	Mon, 16 Mar 2026 19:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HKnvAPNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738E284144; Mon, 16 Mar 2026 19:07:40 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F10C8412A
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1872504cbso4898139a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773684456; x=1774289256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd3EdIC3iwli9UXrZYJUN70UjxfhKZpXk9qfJ3KNnO0=;
 b=HKnvAPNw2U/ZJDC6DPnXf+4RJMNcJjKg5+d+tYhJscQ7SIIpKybYTYerJz7yHx27pB
 7abT54BcTGDTdx+p8nQjlGLaInJ72g43vaQFUe2O5js1XLzoytB5cLMY/B8bpcKxRd/U
 ITCwRxVktJxyP6WGGORm83llv7VJHYkNtFM2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684456; x=1774289256;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fd3EdIC3iwli9UXrZYJUN70UjxfhKZpXk9qfJ3KNnO0=;
 b=cjs86/CEydWFuozNzRZuJquQFnGIBYe3Iu3/M24UCprANw9Bjrxd50Qnr30PflT82l
 2tQYGDDqBggfPLZSJyFOHalOcbB7oec2IKt0q3xByVDli5N49y9f1v+Ej4IdSZGxoAem
 IXQSk7StOBeAoo0K3+eaf+DlCGLl+Ai05xQ/wmM1/HLAza7s3zV4F5Xo3JExd88Q4eH8
 h4MlS14OKw4FZB+7XG4UFxKzv49kOM87Qxhs1IJTYBf08wKIvSOVpGEFNl+5tDE4WXMD
 sI/wB31CPkKffWoGhtn1t+Cq9pLjVuiHTXNymbhl6h6LNfHrenkrkaKKWvK1FFHMJpfn
 nncA==
X-Gm-Message-State: AOJu0YxXwZIdNeu5bGwC/xAv3YPbysaolaD5gkXqJnnmKSVpGfU6/GgW
 RL80/P4B0Q4XU1wDKw4wApNI1nCJ7M1V8bU2dNY50ZvQwKk7HWjWghzL/rxMGRUQzy4=
X-Gm-Gg: ATEYQzwSA/27QjZAntrmy/dlvgbdvrdf3qBZaBmbGSnNfvShp1VWiFvMvN3BOkC2ppg
 RDQnTXdzNmrWMKFP9K5A/Wdd3WYT2fvR1hQdXOWEZ4rD41LwskpUuZJ6Evi3ctTTbScwF6K+Stj
 JTudv/rbjrhZ1Vmpwm7WyA/InvVGn5xKC9q0j0mPkNCs1l69vQtF1NFeXaIsYRE4SvqpzyKZDf6
 rs/ayT3C7e2Wb3x0WdtyLoTeJ0pyw1Z/silFjeOODBY4uv+bHQbRd4UB6Erbk1yiZhCqzpZdHvT
 8VB2nAZJQi5xnz9tQmuNE7t3ROoX5sH1D12B4rzl7XfEs4HJRDm6SqLjTs+HBbJG+sofw88f4d9
 TpErrCVOvef9RmeCl0QrqqW6WxTTWtCWgjx+7lsHbSSTyJjqoSjVgzaDhMT6SGtM+chhFANa8EQ
 Sc8Lyy805WwE27T8yEF4345zIqFfFLuK/dPf/XVi/JbDhc1rOctOkl8hBtXaD8Iq8/LZiPLOwOL
 6CnBh7Cy3inwFVQQKRSRSdZ5agEkAFRzsC0M41Z1VaYmGY=
X-Received: by 2002:a05:6830:67cb:b0:7d1:9066:26b7 with SMTP id
 46e09a7af769-7d7bb7425e8mr390749a34.6.1773684456508; 
 Mon, 16 Mar 2026 11:07:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac32913sm13255393a34.5.2026.03.16.11.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:07:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20260226-board-cfg-update-v1-1-9d434890f537@ti.com>
References: <20260226-board-cfg-update-v1-1-9d434890f537@ti.com>
Subject: Re: [PATCH] board: ti: j7*: Update rm-cfg and tifs-rm-cfg
Message-Id: <177368445571.2276702.12182695068715736412.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 12:07:35 -0600
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

On Thu, 26 Feb 2026 17:07:57 +0530, Manorit Chawdhry wrote:

> Repurpose the allocated resources with version V11.02.07 of
> k3-resource-partition.
> 
> 

Applied to u-boot/next, thanks!

[1/1] board: ti: j7*: Update rm-cfg and tifs-rm-cfg
      commit: c4fcf9b806aefd6ab18edca59994c5a106d5e9ff
-- 
Tom


