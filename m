Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18726C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 20:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D008781E5B;
	Tue,  1 Apr 2025 22:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TUP9pN4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E3781F7B; Tue,  1 Apr 2025 22:36:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D1F81E5B
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 22:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72b0626c785so4599570a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743539785; x=1744144585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h/76+132DSK07FnObX4Ifg2yOJBB1mQPHzVA+3PELFs=;
 b=TUP9pN4+b04T5YvMCQ5IwOiB1eDkZYb78SbTRCynRUTJ6AveLU3fPkp8YXh0s4CVqM
 mb4uVF3FFyZSS5uGa/KCdHaeyqrnXRQqJ7ubgFdtfKT3TmF8NJNvRKk6YNbRwkgdNMuH
 lM+5ZfU/L3oeJ4KDaqQoBbJ5wOPmDKKhg/fHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743539785; x=1744144585;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/76+132DSK07FnObX4Ifg2yOJBB1mQPHzVA+3PELFs=;
 b=GXcNj/tOqXeokCWAasBBGwirYU232ksoElQ+hA5ZScC/Cy0oA/W0W93MO/toy67Ey2
 iPdidkXt+SrlC1S7+ODhdhYr75lvCKv81tNViSEZXawr1vruCqJf6GKClOHibkg5r4zO
 BooQHHCfNM1yidwNeoUe51BreP8ctvlXZrdPBmF2lpcLmuJD64vWsH7ZsamSnZkl/jQ/
 rAyWGEMXd+mKtupFImSYSU43kI+Q5EfiCsXgJ6KousGxHBpibuvWjTN1dNVZe6cm8XzN
 EPbm36+ydiG55NFaFkbkk26ItDFmOl0tX8Kx52A9nK9kunjcxw6crlQoeAmiZmXLdM8U
 IXqg==
X-Gm-Message-State: AOJu0Yw4hRPj3H8MWoN/0F9EebQ2yBzD3/nSfls4lBXO2EmTV+qL2y19
 8pb466zePauTxvTZuVhIDA4/JQN56+r9r7v9b2Ew8/tqVjGFyARQAa3Itma1BIw=
X-Gm-Gg: ASbGncub0GFaz/Dxqgr39cNmAGbO4DXhkmmzg9YOoqYHjtbjimZD/rSpsGekJiaKbK6
 uh3dputvH0hYRt6md+XcuIzsqZcI4DjXw1BsV7lCXVC2UciR5zd9Sdg3GdRseidAv/rGN22efOG
 9Izhy+8MCJT+6JSKGBjAvPPA1VhCFh/kmG4VOoUMB8D7AoH0eXC7cwt+jpEhVKFde4Jw30J8I9c
 y6TseOgf8bFaYusLZLKzNUX24uzWmats2wicx0n1CKrf/5X0DhWpoQ4QEEJGMQ0VUGAGtve3+mf
 Zdan1C69reSGDn4qxz66xLI8FSBvvJaWsw00cDOMuB8tkU4yMf9TFMEybTxoXhet97OAGrHGPZS
 YIbdx
X-Google-Smtp-Source: AGHT+IH2AGcz7Lsv/b0D+RYv0TCaPNuMnha+nV2uhhLRAg0i1rLBnxrvTaCn+bvEiJXNjDt07H2xLQ==
X-Received: by 2002:a05:6830:2808:b0:72b:9dc8:7f30 with SMTP id
 46e09a7af769-72c6382d179mr9522527a34.20.1743539784944; 
 Tue, 01 Apr 2025 13:36:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58266eb4sm1956027a34.51.2025.04.01.13.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 13:36:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250315012856.399360-1-trini@konsulko.com>
References: <20250315012856.399360-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Correct dependency for CMD_LINK_LOCAL
Message-Id: <174353978423.1112159.3612039737062656632.b4-ty@konsulko.com>
Date: Tue, 01 Apr 2025 14:36:24 -0600
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

On Fri, 14 Mar 2025 19:28:56 -0600, Tom Rini wrote:

> Given how LIB_RAND is handled now, we should be depending on one of the
> implementations and not selecting one of them.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: Correct dependency for CMD_LINK_LOCAL
      commit: be7693386d7f2e46e4907ef55bf9cd1ae4af2903
-- 
Tom


