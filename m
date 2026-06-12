Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1688FCD98C7
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 01:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70519848A9;
	Fri, 12 Jun 2026 03:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tylKLX9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D2484841; Fri, 12 Jun 2026 03:59:18 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D058005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-48677c167b7so264391b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781229555; x=1781834355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9aLewqi73SVnh0wTAOfaBiW6vqAafKrgSGRawYfQpOo=;
 b=tylKLX9se9t4Ix+O480qn6yfk/pbXIFvC2Mv853eSEVlH3Y1G/CYiXJ4b5iksKYbgO
 cLimViMTScYPd8SVH3tjsCg9QGF10M1aJwWDITD9KxZ6eNu6n0OnI5FbkEskydnOwlPr
 0AtV8iI8O30HiaiRz6wjf2tIKG7/eL7U8gptQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229555; x=1781834355;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9aLewqi73SVnh0wTAOfaBiW6vqAafKrgSGRawYfQpOo=;
 b=fx0fQAPm/+Pq71TJaj8qR2asyt6dK3XwJKa02IVc/Az3MSqaKUHPBPCnC1MLWp+Wt3
 Cq21Tm+sCvZ3ZiCgOTczmFy4ltohUuXjMXse7++z8QIyXRkhnG56o2S8QOXZR37wjxcd
 nOsBSd8oWGgWeS9kfjmIRYT9to0HP5h49UnOZd611BKUhgMgHJAQxjTPDw8xfHS2QJDI
 6HOzeiXBDdTIvTpbNblgxhBjUW30oknpVsdG9GOqXFja22Spcm5bzOJhjqGFKejqGpOT
 GgKqsXIZUywd4B0c6k6etAXPs71hB3B3WLn7+zSNybNkZUFgH9hPgKz1NpX6CnOWbUuS
 DGDQ==
X-Gm-Message-State: AOJu0YwbGJfVCEvehlRqEj/d+sbbKLshXU64gy5SqGTMotyCUfdzXMS0
 JP2Lc9JTpLKSU0O82JgP7nDL0xbWF8gK0pWs+NCswf1/ozm6reykAhC4yqoGbNI3kSX5EpB8BC5
 cyqzc3yk=
X-Gm-Gg: Acq92OHpBYLhAJyxKgXgV8BCzE0gAKZciTj1wOcIZQnrwf8KNJceBjx78wZ+tAr3SqI
 /MUUhB1dDbkrSvTCMNRFh1cCF5xgd+hGlWNplfqrYcXbBEpauvIHJeoqQDZjCHHQrz7KQxKic5r
 lPTTgMRpLidg9ZfhXUGqz0svX+1EUqr43lcXJdZ4yqaMa295c/pFQ0P/DHDSHuvY/PKkZqZZQs6
 XcGOQVr20c847K+shtYPQRSX6uWibaT3VTL0gKsq7aods0LXSN8Tk7hxReQk1vp3o8YhTQeINs8
 58yoU+ZuM9zR6gYjHFJ/2/8rtzOGhH8PJsJVEptMp8zeAojy4UTPgh2OXDlWdaROYz2eX0YHEHI
 fkw5lKOOtRBlqH07vRY0PaL1DWTqlqAdV/wVK816Eun4Tr1V/X9+TSf8vTDHiWUOGbgUiq2QwHD
 LFTwha9kL5KWRqmetisXYIFBxQyusCquOkHc71bC/TJGhYywmFfbn/EkhiR+2N4sygh83AQOj+k
 hnJhRZi3Rb4QiKMlQf955Gbd4EaAFrCx8fACLfy8wgGXB8=
X-Received: by 2002:a05:6808:250c:b0:47b:c703:4239 with SMTP id
 5614622812f47-4872f574e66mr613543b6e.37.1781229555195; 
 Thu, 11 Jun 2026 18:59:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426abf184asm534734fac.5.2026.06.11.18.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 18:59:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260526070336.23199-1-aristo.chen@canonical.com>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <20260526070336.23199-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/2] tools: mkimage: fix get_basename crash on paths
 with dotted directories
Message-Id: <178122955439.605671.324313618659542584.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 19:59:14 -0600
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

On Tue, 26 May 2026 07:03:31 +0000, Aristo Chen wrote:

> The get_basename() helper in tools/fit_image.c searches the entire input
> path independently for the last '/' and the last '.'. When the last '.'
> falls at an offset earlier than the last '/', for example "./mydt",
> "a.b/c" or "sub.d/leaf", 'end' points before 'start' and the computed
> length is negative. The size check uses signed comparison so the negative
> value flows unchanged into memcpy() (cast to size_t there) and mkimage
> segfaults during -f auto FIT generation. The helper is reached on every
> auto-FIT build via the -b, --fit-tee and --fit-tfa-bl31 file arguments.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] tools: mkimage: fix get_basename crash on paths with dotted directories
      commit: 759968136d68ba178904313c38ad1003525c58ac
[2/2] test/py: cover get_basename crash on paths with dotted directories
      commit: 4a4452a03916d8687442b1d0af5098be986e439e
-- 
Tom


