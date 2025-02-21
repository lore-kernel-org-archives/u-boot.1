Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB646C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C9D80FDD;
	Fri, 21 Feb 2025 18:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b0kHvp/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6114280FC6; Fri, 21 Feb 2025 18:38:24 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779DB807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-221050f3f00so54446875ad.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159500; x=1740764300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4KL1OXpwrY1Sgis9jVzS0gKM4Uv1BzZxEDWAXgLAqQ=;
 b=b0kHvp/z8gztBk5f35tO/m9xUfWcXN9ke5LB/hun/WjQYQE+JgIFc2b+Td2qsseSWf
 KnCEj92EN9n4TMGx39ma93Rufew5Ik9kLRoFi7gcG1ykCY9uiHYhYWlXqFYWkg2NRj+r
 QNliTlJGDZzPRxRm8IXgAXHYJvXFkW8a6eCHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159500; x=1740764300;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4KL1OXpwrY1Sgis9jVzS0gKM4Uv1BzZxEDWAXgLAqQ=;
 b=Ej0JgjD92Jij+OSUyK3MH9/NAcWmBQ6cNHW7H3Z61BGx7yljEA593YKkM7Taw/GigK
 M0szDNfFc9tEZWFGZ8edhukuOoE7b/5h5Iuwod0PDg/sMptS2ylgiLhl3txG8j1nGCHO
 LcHI3hsd4zHoL/4bmRA6Uu3VkofShI+j8yyl8PMfyNrU/R0gEqHWof6uIvQ9NZKg3V4s
 GAdWhCtJERrr/GwK4SWUBXIl13sTiOKvsoAI4+su36xs2pnNfz6baJBPnPpJUfRgAlDu
 of4kMrCU7zfluJinmj9s0aX1DUjA3Byq6co+gqG48BUN+ed8ErVwRTzixiSDFDqjgKqw
 PrpQ==
X-Gm-Message-State: AOJu0YwypkplEvnAvSyZrGrtzbz9nw/HackKbWsLVkK0sWPlg/OzmWwu
 AtXoTvU7yW/RJDYo30sR/71uQ/gYg52cToN9AYP6LrnI5CKE8RS0ElUumEZPmlpTzAnNSBxMe49
 gHkM=
X-Gm-Gg: ASbGncvYDVKdmryzgMJeiE2yv/vCYuF+t6RddV00bc+newYrxocdjT8kS6lr+zVWSe0
 AGZwo8agYbmSKpjdQJE/R8B4LSiA6IbjLKWvVimZzpz8FavGYbqZqcPPtACe0rUx9Kx152ZH33J
 eFS7VNFC4pKtS/NsSn3x3Q8cPxkpvMjJOvjBcW1LSdGFTFKWrezvHv2PoEWwQ6wS11fzhcQoY8C
 LpgeTB69fdRS5GLZNkLAAwpq8LaEesj9NR19L9YSitVdCjG3rl7+wf1aqDbUwo95dw3YSUK6jBc
 6Sk9biu+LuXg6n9hge70tVc=
X-Google-Smtp-Source: AGHT+IEDWuR/hA0+64F7z4lDzzbTyOCTkARrTf17zt4bYOKXwgS+LPv+vEjKwDYWn1TODq6BUrRJLw==
X-Received: by 2002:a05:6a21:9218:b0:1ee:cb08:d0a8 with SMTP id
 adf61e73a8af0-1eef3cb91d7mr7694720637.21.1740159500043; 
 Fri, 21 Feb 2025 09:38:20 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20250213090034.83834-1-weijie.gao@mediatek.com>
References: <20250213090034.83834-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] arm: mediatek: build u-boot-mtk.bin only if needed
Message-Id: <174015949920.3526942.10135919165795318770.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:19 -0600
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

On Thu, 13 Feb 2025 17:00:34 +0800, Weijie Gao wrote:

> Not all MediaTek platforms needs u-boot-mtk.bin.
> 
> This patch will let u-boot generates u-boot-mtk.bin only if
> CONFIG_MTK_BROM_HEADER_INFO is not empty.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


