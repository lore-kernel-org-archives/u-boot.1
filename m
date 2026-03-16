Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9398F53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99468413A;
	Mon, 16 Mar 2026 19:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLA0apY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3715284082; Mon, 16 Mar 2026 19:07:39 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E0E84127
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso3377260a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773684455; x=1774289255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VFikKL4MwFGGpjot5hydNYE/OG/XFIjQ0KDDvFdZqM=;
 b=bLA0apY3Bg9kBEN0TpPnSPiTOYghpMuOjuqDFy7JYQmtMfFufcxDdQLBPQ+71xAgPC
 +OLoy3OCdf4M171E0LbbrHjPMt3+PXgEwIwRnKg/PH28Of5ACblFSdEqHTtHLvrbNfum
 4b+jN/Z+VikAglFLMRM9isvLdcHCf4oTPiUDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684455; x=1774289255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7VFikKL4MwFGGpjot5hydNYE/OG/XFIjQ0KDDvFdZqM=;
 b=in2tERFFY3yYWfWp6BpqIWZ5QJevckFHGI7/gItOAwFSza40xOpxw2YF2Nh4GuoZgZ
 uMNKNN1zlENSrIxvcF3+g9V+ThVj+WgSUtWAsV6TZcOWBTCox2Vd3/vHXSCKsHDV52Hy
 Qdavk3KEphJdwCNP6wsGUZBRngnBv7VnXYLlm21hpJQFZZ2maNKJN4uUj55JHTYBtfRV
 MXIKj8vZya8WEFjkA1TYgTu1LiNx+ntUY0T1ELgfzmNptfADzn22kCNtqD7Mia7K64Ex
 l9GOTmKOFXTAkcyCP92OoDMZHk7rXC0hYPPubEznSJdqmjBAUH1HxIjyVv6v+5tZQ7g6
 4Bgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqdN82GbUezHBENKOdMUYuPjcVWopq47KE1SAY6fwQyfVM8U2LevJ5zQZ3WJEwtgkJzAcl8gA=@lists.denx.de
X-Gm-Message-State: AOJu0YynQxZm9RPp8vFSkOj8cKM7JC3cRoxSo8bhYfc2icATiWW11aX8
 UH8ErAbIbdzSRprUwKxcUO8wA9lc94KWnhqi3b8ZamUdT4w/N/grmxl/ZXp/JUHudRQ=
X-Gm-Gg: ATEYQzxbpm8qoYFgEBsETlTR8/OPPF1kGlLGd6z8ATviWz1I9r4g+grbmuBbxOsp0DN
 pKosQVP8JNz8J3T+UxMvSxCxMIPye+0vqbV0BcJHSuqvfFgxkgtguTrJfcbqmTubQO4v4TPtLkW
 FlwJF18mstuYeO8UHsnYozkueXW2uGbh3X7VmMBsdJD6+mtLqVcDEOUXncW81cIjsFU6K+kEro2
 DZUZerUxi8pvu22p4Zp30qjrXno4wZxAKkfwF4RpxTvigokZPYvk98ilohC4vsBP5s0gPy/1l+D
 CqKVZ9T3WXWBAs+iUJU7ivKXAmqt2bBhvh/m+k31jzyk4UBN1CdlWz8H9uCpKCLzNukqKudxRIV
 jwQ/I5bAwZ1ddS8tgPT/zbUBRRYWryk8T6iCEKrfhnzbavWmqIrjmLpseKMx3yWkNrXcq5awHFg
 CNQQaEj5GmwEpZz9XAemRhfNJW0CFuPwuWRF7TxSIS3Mm0RqaSq7WUF8oSgDZNUYF4VZPH8odlz
 BhsqSxk6aO0y5q9VfJLKC4vchvu5Syp2EciegQVmmOvqS8=
X-Received: by 2002:a05:6830:82ae:b0:7d7:6610:73ae with SMTP id
 46e09a7af769-7d7825b8f92mr9788524a34.25.1773684455595; 
 Mon, 16 Mar 2026 11:07:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac32913sm13255393a34.5.2026.03.16.11.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:07:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20260213120200.543875-1-ivitro@gmail.com>
References: <20260213120200.543875-1-ivitro@gmail.com>
Subject: Re: [PATCH] toradex: tdx-cfg-block: add aquila tda4 0223 pid4
Message-Id: <177368445495.2276702.8496864054725954371.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 12:07:34 -0600
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

On Fri, 13 Feb 2026 12:01:59 +0000, Vitor Soares wrote:

> Add PID4 0223 Aquila TDA4 Octa 16GB IT to config block handling.
> 
> 

Applied to u-boot/next, thanks!

[1/1] toradex: tdx-cfg-block: add aquila tda4 0223 pid4
      commit: d89dd94c0ad3f7f5cfb2fd0d3e7bf70e84e3d70d
-- 
Tom


