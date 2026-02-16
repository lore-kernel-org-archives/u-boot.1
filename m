Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01BAE83827
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AE883B8A;
	Mon, 16 Feb 2026 20:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NW8wC0d2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5265E80FA1; Mon, 16 Feb 2026 20:39:04 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EF883B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d1890f5cafso1223627a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270739; x=1771875539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p+D1f7WACk1FSPNE6fw2oSFR6edmLrWvGtyow9KUau8=;
 b=NW8wC0d2kTJ2LtdH2wF4NaQdoBxwweFuBMcYxudT94Zd7rkGXXKOEif1hE+Xqmwru5
 cHVq0bPHi7xzzMw+/cUEo34/+b0a65VktieTO/aJZLNgWeIU7tsgF+kKX583yTmM45jp
 3zzjTCogj36QipwHsNNqMR94IcQYeSyURD1mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270739; x=1771875539;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p+D1f7WACk1FSPNE6fw2oSFR6edmLrWvGtyow9KUau8=;
 b=j5e5VuSSH62/5tvhLrY5hsb8gh06ErT2aqtwSnOgNjeyw2LDcEZa12SCcq6z/j19dW
 toTuyWAk0t/nYhGa0NHbqReoaiKdgzQFO1l2jNLxBJ+UoL5zYWI1OP6J1sxeH8P2qYGX
 8o83fsGrSnv/WzbqBXwiyEXB8on4vha/nDCWK/f4aHoWahoMwXe/DKfXTmqb7g9+zwMd
 Mmu2uyP05RUasWpeWIsOSqoRvzQyiCZoAYuYKKkuS3Mi/eRpBATh6sphgbM7G37g5QSH
 EHHV3qnYONtYjPup0nBui6IjnhGy0ExXkSDdtuxnKro8x/3voBCoXQc8ky3stgGH+g0+
 in/g==
X-Gm-Message-State: AOJu0Yy1j0q+lkvF1QQ4u13Obengg6bvyMmFLBfQ/ECJC/YIWnN9TFZ0
 GjQs2dciG6xbLNipIRiwwzWwMUfQTYuzCAUiweUEyZM1n3tqx0Ydn03z2GDAVEMjGoAIxHd/NsU
 mlmdOXXQ=
X-Gm-Gg: AZuq6aLarr1G5VphiE5wz2mIWUHrLAd9jVRqutql7doEUuatnnrqNRsvl+O5FAgfKm3
 MdMSaa7BCBChgRq2ST1HOoKFpvsGtTazIYpAxCXUsURtKixi1LQ+hUA31XljZOTJzG3vGi/fyZ0
 OHYMbGNl1sJ6GJTBM0quAwIif6pT5De2oazuxMgqS+xPMYvBXPAiscQfuTt7Gfb1/uoRUlOmFx2
 iWcvklL2RY+mcb8agnW1UHsMXGh5pPHVZFa7OVfAiZtyJ5W9g7oLXFGs3Vwq5i/J+Z81A9QEs5n
 ZILAHAFtLeCRUp3YbSEfW8Q/+w74QNqDeOgZJZ5OyFGjysRL14oOIXR7i7j60/YEyO8RDZZBwc1
 KgApIMoD7V+tiNwyPzOrLINgOj6h08012nG8MlOgoAAodIQvifCvjvwfGwOqagsDrBijzKgQrrU
 T3JOFKOlcwnrZID+XEEPClojFUq6kXfu8JXz2iWz7RHKUnsYrTLah4nhStYMDXfSJF4xZw4PL1Y
 q4IiaNA9OMaEU7wReZSZ7WFToWcWg/aQpT/bVX6NZpCDvCf4Q==
X-Received: by 2002:a05:6830:a91:b0:7d1:582d:71db with SMTP id
 46e09a7af769-7d4d0c78d66mr6902039a34.38.1771270739275; 
 Mon, 16 Feb 2026 11:38:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:38:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260210171344.2723799-1-trini@konsulko.com>
References: <20260210171344.2723799-1-trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Remove a few inactive people
Message-Id: <177127073869.2634449.8836088981965428811.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:38:58 -0600
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

On Tue, 10 Feb 2026 11:13:44 -0600, Tom Rini wrote:

> It has been a long while since Jagan Teki, Joe Hershberger or Ramon
> Fried have been active in the community. We thank them for their time
> over the years. Remove them from the active maintainer list and mark a
> few things as Orphaned for now.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Remove a few inactive people
      commit: a79edd52a80ac346ac605362f1a61a6062b2aec8
-- 
Tom


