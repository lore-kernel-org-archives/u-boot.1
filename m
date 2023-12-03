Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FA1C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9838753C;
	Sun,  3 Dec 2023 18:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1A9VOW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD7D876B0; Sun,  3 Dec 2023 18:44:52 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3692876BC
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a0029289b1bso488684566b.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701625489; x=1702230289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4hWt7Bm16qYc+mqlDTcsPM+lUR/ZmfF2p6nEors4nZY=;
 b=P1A9VOW6qaKrtMOnVqZTLnU3n/Ex91IT4pQSDFqAa5tjIl4HzSn9F7eZNebb0+votW
 eRP+ln0eIsPQgnOH+rx6t2/K7kj+DbtMcFs3aeTlZaQyfdjmXsIBSbAJ4MpHqJZYE0YR
 XaD8cF91DsgqQ7kiCHInJ4LGUhAYvbTXCYFdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625489; x=1702230289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hWt7Bm16qYc+mqlDTcsPM+lUR/ZmfF2p6nEors4nZY=;
 b=jxiW01Po7s+ByvqL4u0nqqXL49xlcJkXZyVbpSE0C4k/wzwMpbEws2BdaRivZyRdXT
 01gYOna7J9ElVh2llgTZ1mnBIpRzvvIDEfrs3KVObJoAlH02eTeH2+FRoQ1Ae1bNqeoA
 Ptlv4BawAvk7dS9gbGAz/TUs2z+erZDv9y07TTU5Wn3ZTG1MssxNYZx+fEbMF1FDe/Mr
 VAyjpK5NeOMjUnwiIYjjz70b5Z4P09IYhfUL0be9cp3xsALWsCjQeiW2CZ/KQtrEs4pv
 /ZxKZAcbbSU4S/YPH7iffpaaAnzPO3XxqDrdECkyx9EdIPZcuLcpIzZzfGyxr0wDvB2m
 slLQ==
X-Gm-Message-State: AOJu0YxSPhvx20Qh66Fg5QtC4R0C2JQ36k88s6cPAqW9lifwZuMfh9E4
 RX0JNGG3+d1jf9wyM2BmiO4ihOAMs1p1jZAYW0VPoTlpAAzhylrlFCV39A==
X-Google-Smtp-Source: AGHT+IF3lOEV1MzpfIB0aJmDO+fr+8l6p2v31g6RfGdj8B4C5Ksfe1OGuPJjamVR+bHB71shfG4O7kz/xpFLc6GwPlA=
X-Received: by 2002:a17:906:2207:b0:a16:37ce:f81a with SMTP id
 s7-20020a170906220700b00a1637cef81amr2719052ejs.8.1701625489177; Sun, 03 Dec
 2023 09:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 10:44:25 -0700
Message-ID: <CAPnjgZ0zNGCiPUaEZ3NTdebm8a9uApBWasZa+=WHewpSVWcVuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] command: Allocate history buffer using calloc()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
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

Hi Marek,

On Sat, 2 Dec 2023 at 13:53, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The history buffer is currently a static array which can be some
> 10-40 kiB depending on configuration, and so adds considerably to
> the U-Boot binary size. Allocate it dynamically instead to reduce
> the U-Boot binary size.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  common/cli_readline.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

This is very intriguing...

I would expect this to end up in BSS, so not part of the image, but
allocated when U-Boot starts.

What do you mean by U-Boot binary size? Which architecture is this?

Regards,
Simon
