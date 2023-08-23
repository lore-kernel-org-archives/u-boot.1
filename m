Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BF4C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FBA864FF;
	Thu, 24 Aug 2023 01:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jmghWi3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D95F864F9; Thu, 24 Aug 2023 01:59:28 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0257486519
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7260fae148so6071937276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2Ed6oToOvlGg6g3kUn34dmlPVbiyCNmCQffdFGmKu0=;
 b=jmghWi3C1BdTTDKrEaGZ2fF5aUd73r8d72mCRSBo2skU9gHdnKyOG38X/iIpXJLPZi
 3Z2TwmSLrcUXXp7HeamcXFkJlVygiPDpj2CErW58wAWu0a4ETFzAmwKFs1k7ku17hNhi
 wY95pwHx82+AbXfSK4qduKgmgNMqZCrtgHANg6d1HlqTeBNnk6FVnSB5Uuxrf1dEv11w
 Lh8ksy0uM5OWN2/+ZR/KziAe6MAje0LcftYFJ8DF/uKC+dtxU63GTHcveNlT1PEgsjfr
 rgJpZZlvmLKUWlIlOJALJtyKBjkwod5ED0nP3z1KzC/L/V0g0NEiMLcEJyxsiMQpquyH
 cX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z2Ed6oToOvlGg6g3kUn34dmlPVbiyCNmCQffdFGmKu0=;
 b=ND/HTB+cnYbizwWnHSrof4rMeoVDodml6rPEi0ZrUOmKAXm9VldolnpB90M22DVvBb
 SN602dGbD4AFRRHQ/mA39eE3q2mJpt0PtXdKOlERXj8kzp0cNaqw8agGDb9aSrCbUVqU
 DqLhFZ+CnK18vB8uFUT24ELzMI99nQP8m+m/Xf9MWSGie1nAOMYT54QRt628w+FlkBCa
 ZZ6NTPmKc/99A6zDu/RFINtFyc/zK7IPxUQnWuTZqWBuTpZKRUH/8HocgsEvrAsUltI3
 sPRtJmYTbXTKtpYzApTXmaG5DaPeQTJermh/w39vN8IMvgsqjoPtJ3B7JA/fJPp3q145
 ra0w==
X-Gm-Message-State: AOJu0YxU0lJUO8/LYWk+6VD1wgOS5umh1thq3VQR8b7j9V8eHOT9h5dP
 MWoJItz+tW+NiNntgXe93LNsTPiV2dyNc9pUlP4pcw==
X-Google-Smtp-Source: AGHT+IExB9n6F/r7YO/TS80a4EQP1tVW16XAqmN8i7PXguvFiWLyIbRfSjBTv/++pr34nwLLgnnTpPp3/KE6wvI54LM=
X-Received: by 2002:a25:4293:0:b0:d5d:4bae:6fe0 with SMTP id
 p141-20020a254293000000b00d5d4bae6fe0mr13564570yba.21.1692835156454; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230815162726.1524958-2-JPEWhacker@gmail.com>
In-Reply-To: <20230815162726.1524958-2-JPEWhacker@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 17:57:38 -0600
Message-ID: <CAPnjgZ3OLJuEyEGEt_Ym1aZGYebthqBgwbbpAVpxxxUZu3quvw@mail.gmail.com>
Subject: Re: [PATCH 1/6] cmd: gpt: Remove confusing help text
To: Joshua Watt <jpewhacker@gmail.com>
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

On Tue, 15 Aug 2023 at 10:28, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> This help text appears to be a fragment of the text shown when
> CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c | 2 --
>  1 file changed, 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
