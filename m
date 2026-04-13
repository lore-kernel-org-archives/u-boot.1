Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96541F34C5E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 15:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA7883DC9;
	Mon, 13 Apr 2026 17:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mQqpWEMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFF8839D5; Mon, 13 Apr 2026 17:03:48 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09F3839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 17:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f22ec4501so774553b3a.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092624; cv=none;
 d=google.com; s=arc-20240605;
 b=afda+IDr1IiTCbhYSCQiA3jkAZlKVcH1uaJnVOulvu8W3WBM3l9d9HIrS1u7BIU3qK
 szMS78TbT5l8LGe6OwUdF9c1QQoXrW6ctyRg22r1ue8N2F7LEDDYnVPTtDRh63eZs0wN
 buatObcSFscxCS39ujvjhIeJl/+IVOZh+w9ehtxMHtmT45aJrVFL/wS+nny0vzxXLb3a
 +BUJrNC1v9K3P/iBBGHcqK25v+BOm6kGxo23g/5vM54wKUsO+5XKkBIr43owdTDibgAR
 RDHkPo3XdL3C6JU7OGSTTDqehC/xIsWs+Vybv3Bv3OhcHvQFLLBU7xwuAPzsgtj+09K4
 aGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5gbOlESjYBS+cHxUT+Nf5GjE/th44PvB8VJjnh086Bk=;
 fh=COzWXKRY3hNFOd79u2uwJyzfoPBPX/816DBFSpwBslw=;
 b=WdHYw7Jj0Dbtax4ttQYnhxDckVqw1BxBg1aggBX6RbycOIh0jglzGZJRbY8/YQEEiu
 MpMZiXv1+SdecVh36ARNIzEms5jMZVKL+ouM+uiHSjY+5Ykw1fdtlu0hEM3wgxZCnn77
 yBimnDGeuWJJlMqxj8N1GKjagPBOYnIptTUW8HvsrOmoku1IHOT/joL5bH19CFO1v1E+
 102I8BFemQfi+VDfHS3oqZfMq6sMdfkcTkzoP9W14dQg7d/A59jHzrS9RRcSvQJ1BBxB
 1XHkEdXdPQnzyDi2nbwFiToI2xp9ISJc/7BefE7qyUm9gMEWojF3QuG9/Q060VvUQuJH
 jlXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092624; x=1776697424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5gbOlESjYBS+cHxUT+Nf5GjE/th44PvB8VJjnh086Bk=;
 b=mQqpWEMmv0V7RMh+VKk251f0ITY4A/Cckhh11HbcVX5iCJ2liCeaDwCLW6LQleUmAc
 BBBBssNlDxvhy9kqN86dbIQngh7rdFtpjulMEQHMyrLHt/vlubWGYrqJDL/RQVaKOV9U
 QNED0S2z2AQYlwNz2QulSMdHoTSS8nIPmmILw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092624; x=1776697424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gbOlESjYBS+cHxUT+Nf5GjE/th44PvB8VJjnh086Bk=;
 b=Sl3yszIJrPzeIRddtRhgIhh08CIkG6Jmj5HMyfHaFho9ejZaaScWKWl1fwcqbwtgP9
 jHO4axBzQ5UCF4SB0KLolrR0DfUiSMq5p2Ej5RfIlNlHA3nVPCPkjb0Li8rEcV5+RHXA
 nVLhN3089lVQqfXABhtQkEiuB5YyrlDoY5h2GvNVsNALf5YIhJJ4DgOigWg7zLfPQjC3
 FfCDHVupwkzKXtxSqFIuUMklHjIp5w5Yv4ilUvaKbni0HcbgNEMzgIvYcIWWLChCeYVb
 rVBskL2WpNVrta0/fi2u7+YJLRtPGoxIKuoiJnmj7Omr3ovyvlJt/aNDaEGFe3WzBg10
 I+NQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Y7EwO2+C6W4odsJYspnUeNBTYiFen1TF3xOWLGGHp9K7Iu6tiy9KX4+biCocpoIUb89IbQHY=@lists.denx.de
X-Gm-Message-State: AOJu0YzqKcSjrecDo7N8xtdcCX3Qb66cW2YQWndh4zc5wJmG/Os0fqsy
 NrnxMrE1GV4+Qd9vRrBkRSNNuUEYxXjwBRAv6v6tDiZiWAIIGnK4p6Y4fwwSp2fTJwqSQKpADfk
 5HG+kqPAUnHw0kv1mtabzezfyuWj2yiWNLlJh9aoh
X-Gm-Gg: AeBDiesq4k6HclbsV+Qj8gaaUeWE25k6ZS5VYMbr0njayBaYvhY4f/Bi9Q1WD40xfMz
 jKgqxV0eA7jDU4NURJ9F7evwqedECblYioShz8+PhlMZPj2Fj7FnxC5lRHh5pPQUxvRhPGF1HPd
 XcWZIJvl29t5Z/9E4T8vs/7L5KEcG69W5Lr0e2iUHVDT7N9gKSBa7vL3ZD8pN2Q5NMAKQJhZxbJ
 4/HeRyCuyH2nfK06jlkU2NuGE7iGL+jhYIZi0EJQNGUBdO33qsPystVlAjmql1DBLB5TW27aBD9
 2Z5Z5g==
X-Received: by 2002:a05:6a00:4511:b0:82c:d7c4:4c69 with SMTP id
 d2e1a72fcca58-82f0c25e146mr11883468b3a.3.1776092623839; Mon, 13 Apr 2026
 08:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-5-daniel@thingy.jp>
In-Reply-To: <20260413092240.3719260-5-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 09:03:25 -0600
X-Gm-Features: AQROBzCdNO7LoMa0H2MQVbm4_i9DjmMe2ewvaCXnUAegHFFLmvYV5DKpayA2LAE
Message-ID: <CAFLszTh4jin60cNR1g2nmEd0ymE3dTx7JFt9WRcoSs+z-g2zyA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] virtio: cmd: Depend on VIRTIO_BLK
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-13T09:22:34, Daniel Palmer <daniel@thingy.jp> wrote:
> virtio: cmd: Depend on VIRTIO_BLK
>
> The virtio command is calling virtio blk functions but currently
> depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
> causes the final link to fail.
>
> Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
> on just CONFIG_VIRTIO_BLK
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> cmd/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
