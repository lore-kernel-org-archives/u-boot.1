Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF05E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C096988FFC;
	Sun,  3 Nov 2024 00:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d9womPps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFE388FFC; Sun,  3 Nov 2024 00:25:29 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A5E88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46090640f0cso28803331cf.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589926; x=1731194726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+UhxBRUGwnSxmaCD7obmKINUVJVmiVo58a6vxrhIXg=;
 b=d9womPpsHYQsoY8pOCwlEJRoQS5N+4h9C3TF8PTBKtbpgePtUgGbc9CmPsJ4zmr5gL
 5qsbT/TqtPCxfzqhjN35DpHe6ovMXmWs5v5XdlVu9pWST0u/mL/Klh3j9poxVqwf9Q8D
 CQ+SYr+UmHCKCZrSjc+henUtJV5MXqlOY4Zug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589926; x=1731194726;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+UhxBRUGwnSxmaCD7obmKINUVJVmiVo58a6vxrhIXg=;
 b=TMAH/EhO5cc/XY6pBPa2mVmuifpdxrQ+//UB5u7mqVKGc02lKehmBrawR05T9UGuAG
 qB8RV2e5dU7oJ71ZLw0AXzQvQcz/P/8AZqu3e532Q/6Nq0Ms+fx/MylwGS57Ld+sDkxC
 OtGtq/JEHyXD9S5ameuy6zGDpciibUkp52atyUe6ZRB7X3Dcq6wXd3w8Kdxa/c+ZfLgH
 tFN1zp9WIfoIqbOqu4Dlvrm/tRPg01xwxus3i/8/7xayagZUyarECZpbM/oJvs+Bp7W7
 SFAA8HdubqqVzbobda+7k0rxDFzaMzhp+GVhjLR+uzFAFyT7twOtMQSCG277X7aOgxJR
 xjmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEnhud1oXrw+LldVUCd9MLrb9E/JUCcLr9EktOmo43FAelZSwWEpXCAqWEKmAR12J6ngcpwgQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1ZSAfIyk0QPfecktTkx54TwqeT1seZ7k6AvIIhG2Iz3tFSosw
 DrlPbs1pdoldtmyEh9UseWpjplTLHf+GPn1XI1BPWrxuxT4C1aruASMMct/OKNM=
X-Google-Smtp-Source: AGHT+IHa9llIVlqvex/uRfmO0AgxxbSRq+SPGboj6PvPnELx8ZnejTm0Nvg9MlJ5eoLeL0S1MyG0MQ==
X-Received: by 2002:a05:620a:17a2:b0:7b1:43e2:712b with SMTP id
 af79cd13be357-7b2fb94db55mr1264100785a.11.1730589926059; 
 Sat, 02 Nov 2024 16:25:26 -0700 (PDT)
Received: from [127.0.1.1] ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad19b4f5sm32412141cf.83.2024.11.02.16.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:25:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
Message-Id: <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
Date: Sat, 02 Nov 2024 17:25:23 -0600
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

On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:

> With this series opendir, readdir, closedir are implemented for ext4.
> These functions are needed for the UEFI sub-system to interact with
> the ext4 file system.
> 
> To reduce code growth the functions are reused to implement the ls
> command for ext4.
> 
> [...]

Applied to local tree/v2-tidy-test-dir, thanks!

-- 
Tom


