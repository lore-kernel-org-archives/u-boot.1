Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B0CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 977F084859;
	Mon, 25 May 2026 17:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eTO9XXXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3695484862; Mon, 25 May 2026 17:19:23 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF168484C
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso1467116766b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722361; cv=none;
 d=google.com; s=arc-20240605;
 b=KGA2OtwNJaBw/NWhPWDP+KaZl25FQAz/85/0hm+9w5fCcIFqcTgkHk7l69a4S68cVL
 K0IpkBHiPo2Bs0MzkR7gTP1pBgKZEAoNo4Zis2Us5+q9z6NANQLYfcKB5+vUT62+rpdi
 5/g04jMmj+FaRFVG5CQzxoLpe/9OR5IXd9myBa7qW0TNjJRynRz3JUmGDfqRVHJB1YWF
 E1RBX0re+GR6HidFFonxvxXCqCID5hA7hQsCb2JlV2xceci8NI6ZTIo8xid+r3IIse5k
 WYO9XILpnMN40i5TQOiP44MZAczWTlKybiHzf3pt+vTZ7JOyVxUv22vuD2oKrK+LP32Y
 SbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y9k/Ci7vnx59eZVAaTFT7oQNWOC9NhVPUI1EtaEqGGU=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=H3VN9MHyCiADQ7YGReNprdo0QZlfJAehTptOV/RQRzf+hunsf8mCAwwfLZWB8b/WIT
 HxJOTfd3GkOT2b63FnqfVg/IU0XBy6ZfWAXm3NvItarOZNt4iuK+/4qyAjhh1ybSBTQH
 YNEErV46HfZjTOQhMhdQPLMI7DGrGMm0hi0iJl/ueBqkSLx9y/oKWK+3XScPBy3fjh3u
 LP6PlPCVFqOQpeQIQ17zE9JMrzQjZ+6Nd10J+QHqYGL/zJlKkOiyVTMh0CjDymMl91T2
 j/D2LvidGBl5/5KjEqaYXORkCdhVq1dLw1DCcwnYWmBaIpxgHjd0PI8RaMwug9CryblO
 RLKg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722361; x=1780327161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9k/Ci7vnx59eZVAaTFT7oQNWOC9NhVPUI1EtaEqGGU=;
 b=eTO9XXXp95r2c1Vxkba9RDHLTIinaZaaPEZNdpnvGW8iTOL9BgGaeq/0xGPbUhG+eT
 eG/cm/2TIVQcSMWqFHE7graUh0cwYZhMOCmkNHv1eebR7GkQ6vwz5H/ppynmlbtQkUMQ
 ioRi0eYrICyLL5uKJAVMktakGkfr+NBM16BWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722361; x=1780327161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9k/Ci7vnx59eZVAaTFT7oQNWOC9NhVPUI1EtaEqGGU=;
 b=EumQiFrpbXgdNp1F/CQM+IUoiGBBSPUBz8EgNycEGADhvvmJmhKeQZApkjvreamSep
 vo2+b5MeZ8AnUIFgKtjAk6W7rIna1uxBWuPUBBXCiwdZE8VT8feoPyCaiuVr/kxKsvuH
 o3ZIBloBp8ICFBzW93b9BazHHYbdoOh3R0NQ+nmSOJbQCjx1XTRC/44rwRIhkrlJYkze
 kS2wUCYohxyk38pu0CHRt9THwkq+e3ETQP7fB56sEeUKn6oxHbnsIiENGsZVvSZaXZEr
 UJYGZcpcgQ8btbKH0KpMKU0fHFvrsA9zSGikKuGQ1l+rTWkXzGaxzpHuWvY/EBAnve7I
 ZFBg==
X-Gm-Message-State: AOJu0YxUpHge8eHK4jUXdsIcb/g8xnJYtjnuVlkkrgUhpNHt/krta4r6
 NPEs7Qe6bFn257m87b73u0sXk4DdV5WtK4bcICgThs86oP6KOGteHRnNMOO8Kjkbczz+FiVxIYQ
 D3vlQjAi3Wy8XyAyTb+tVhkcMOFCdUAvJbTwMdIXc
X-Gm-Gg: Acq92OHH7C8IR1Oi3WQAAehngmyX7p3DwPyGWb03XxFp9y5AdAFgQkxeDgqFw9Qru4t
 B612fce1ljG++ncdZ28yH/iyT1GcJfYjG55uPT/Rhx30tu4bD4BmPO8pHJwfgkcmITZBMtb+Sek
 NGSaPbhtKAaOJ+F75YDhxQzMxoT7lZVnBn0TSnQqjeo8ChAI/nOzBkO1fmKuV5qLSnxdCcWcxa3
 MNX5hjyrfq4sYiW9cMKprXAA4O+E3vuPfgLnPt00/mLsVCaw6UopeI2i1w1nn8ELRwdPQHcN91o
 R6NShQ==
X-Received: by 2002:a17:907:3e1b:b0:bd0:6e7:7a7 with SMTP id
 a640c23a62f3a-bdd25136a2dmr957246566b.9.1779722360602; Mon, 25 May 2026
 08:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260522012312.860026-1-dmukhin@ford.com>
 <20260522012312.860026-3-dmukhin@ford.com>
In-Reply-To: <20260522012312.860026-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:19:08 -0600
X-Gm-Features: AVHnY4KpHve4sB5bbFmRjtrBU9b5jdzOPppwv7XFSM7zfLeIwhEaNyykGssmmhM
Message-ID: <CAFLszThYsPP9GymXuA3Ji+DT7B+MNG7CCG2c4eYV-_wy0Qvv+A@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] reset: Add explicit cold reset support
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:
> reset: Add explicit cold reset support
>
> Add reset -c to allow explicit cold reset.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset-uclass.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -162,8 +162,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>       if (argc > 2)
>               return CMD_RET_USAGE;

>
> -     if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> -             reset_type = SYSRESET_WARM;
> +     if (argc == 2 && argv[1][0] == '-') {
> +             if (argv[1][1] == 'w')
> +                     reset_type = SYSRESET_WARM;
> +             else if (argv[1][1] == 'c')
> +                     reset_type = SYSRESET_COLD;
>       }

Since you are now parsing more than one sub-option, please return
CMD_RET_USAGE for unknown flags rather than falling through to the
board default. A switch reads more clearly:

    switch (argv[1][1]) {
    case 'w':
        reset_type = SYSRESET_WARM;
        break;
    case 'c':
        reset_type = SYSRESET_COLD;
        break;
    default:
        return CMD_RET_USAGE;
    }

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -162,8 +162,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +     if (argc == 2 && argv[1][0] == '-') {
> +             if (argv[1][1] == 'w')
> +                     reset_type = SYSRESET_WARM;
> +             else if (argv[1][1] == 'c')
> +                     reset_type = SYSRESET_COLD;
>       }

The commit message is very terse. Please mention the motivation - with
patch 1 the board default may now be warm, so users need an explicit
way to ask for cold. As written it reads as a duplicate of existing
behaviour.

We should also update doc/usage/cmd/reset.rst

Not sure if we have any tests for the reset command yet, though.

Regards,
Simon
