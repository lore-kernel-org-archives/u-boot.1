Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387CFD377A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA45083DEA;
	Wed, 25 Feb 2026 18:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dfBlonYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B1183EA6; Wed, 25 Feb 2026 18:26:31 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB7B83D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-463208653d6so4886671b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772040388; x=1772645188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOxei5ZeFV1yKZFe7XidE4tmliqqgwN3okIgMOyivZw=;
 b=dfBlonYp9IXlofu9eN0yG78O6DuDi4kZb5DEhZuxiaaAHSbb1WTiAUGoX7PdeFqzog
 W5rIB9Yh3BUj05iiZ6p1JDLzCX2laUk/dZq2TQHHFAK1rQdUV54P19m9oK8xbrhWuBui
 MK6ueLJ3y1V0U2GAtzN2lujCqwRzMPqM539Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040388; x=1772645188;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rOxei5ZeFV1yKZFe7XidE4tmliqqgwN3okIgMOyivZw=;
 b=P+eRCB7Zupn9TxOgoaV+UaODiExyx/OfiVt+zasOeERuUpcnrCR5gy+jovrlLuA8ds
 yKiAef8xtF3beA0n9sImyeEanYKwQQGydUzC7nx2QhZnpbOqds3gMm9vpjrPYWwpd9Uk
 Yecmb2WfJqvLPMr82hs+Or6GAh+pWgnXqhUaE65Ai4KJ8IYnYU5Ax+zwTDdY8UhMtxOh
 ZGRbYAsXA/AIyKp0ageJzRmJutFY22jI0vVBSc1j/QmYu9Vxj8xD7X3rkos2IcVhJ/pz
 NYoXkaKBZBEuTYlJszonmURa6fQw2ylMb7/5vy7jP7xazjLTHxLIQKnw+qEcaLvjNhHE
 GpKA==
X-Gm-Message-State: AOJu0YyYvuqsQohconyB74HWrPQYyUlnb6v40W8N8OG8/zBLxCy4tItO
 0N3iz/r7f+SlzwU6ymXkPlgHPI/aCDJ9ltVjgJgTA/x5vyme17xClEMmNqTUMCiwd5JDxYYxc98
 BQf1D/KU=
X-Gm-Gg: ATEYQzxldweEaJRtPOyCSmQ8eAXMY09VertM3T1HKvqzsRwApzcyfjd2aUMZfoX9Irs
 ZrBsIpQK2GHJW7/zlk08W7hoyDf7p477cPMi92orbsnxwpCKl91SGuvqkeUnn+k1unEXH8Wy1TC
 mdFujVz2WDLJMI+4PyZQXW1ZyIbKFytjdjzltb1b6yCUaleB6qhdebzG5gjWkZe20NUQyTQvnKz
 /deVajHnog8gyaTuf+UcTX1DN6HNRBWm9Veg2OOxU+ew8+tl69a18SmC9qke2qI7tOsWe2kmMZg
 fCi9VvYQ1y66+A0vCHFhhIqlT9ZoG0t7h3koIcCHN/qczR4i6qKYWlMNZpTx+qgOdqpb2h8/v2V
 Bcu9o9XTl0BdFSGeeg/eiY/ZBz1JfEhFyIqkJmb6ORVuUeul7qRFZsgKhrfrCoBavyUnJ4N55LC
 WFI/1fPojVSUFBcxtjaql5iPub3PHkzlDHgTO7dWGQ30uBsEWI48XHGEjoOuRBxYh7wOZrZw3m7
 sutlup/Yt/brrmS4xIK5HxN/h4yRLKU/a66qNR3z2SO0JhvoA==
X-Received: by 2002:a05:6808:1911:b0:45d:336:5609 with SMTP id
 5614622812f47-464461b43abmr9099452b6e.20.1772040387916; 
 Wed, 25 Feb 2026 09:26:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78503sm12775586a34.3.2026.02.25.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:26:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Thomas Bourgoin <thomas.bourgoin@foss.st.com>, 
 Gatien CHEVALLIER <gatien.chevallier@foss.st.com>, 
 Gwenael Treuveur <gwenael.treuveur@foss.st.com>, 
 Fabien Dessenne <fabien.dessenne@foss.st.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <41b7139c-9b00-413b-a6c5-0d7e7b5508b3@foss.st.com>
References: <41b7139c-9b00-413b-a6c5-0d7e7b5508b3@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.04 =
 u-boot-stm32-20260224
Message-Id: <177204038706.3528029.96999547874468124.b4-ty@konsulko.com>
Date: Wed, 25 Feb 2026 11:26:27 -0600
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

On Wed, 25 Feb 2026 08:52:14 +0100, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2026.04 = u-boot-stm32-20260224
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29353
> 
> Thanks
> Patrice
> 
> The following changes since commit 4f70106beafe30df8b0528a3d8b2543cd48fe241:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


