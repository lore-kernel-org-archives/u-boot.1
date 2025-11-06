Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBE7CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 11:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B7EF83B72;
	Thu,  6 Nov 2025 12:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+xrDZ2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF2983B83; Thu,  6 Nov 2025 12:37:57 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54F483B5F
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78682bab930so11455417b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762429074; x=1763033874; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xiq23W4ivs0T1b8qYjk01E2DzG2taXSHJDxolZgGyOU=;
 b=S+xrDZ2Ya/dlkfLeKOr0bFC8Eg9DF3gqBsee3sG0R7chpG3d4tjeE3UMHjWXLk2Nn7
 LG5fpJpL+NMMo65nXbb3S1h20dWXrmgHlDK9HRNaviTagmN//o2D5XSL9mWDNSW46+Ss
 DtJUg5Xl8NJG54TGBSoi0rfgke0qmDHF3bSlYfirEuT2iG6Q3WCgSQ5zX8vlwnj6pFh7
 TQjAybZw/9TfYyiNveF76ycqEvx8OzUA2nPUyfqcg4YFEWa04CaNVLiD+2rFYyM0Zk42
 JRHD+n+aZsRKmOnd+6kVAaJI9nVHK2f68moiga6hIGId5OjctCkJt3G26cfwnwVmux2T
 0Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762429074; x=1763033874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xiq23W4ivs0T1b8qYjk01E2DzG2taXSHJDxolZgGyOU=;
 b=TRH05DR7CrhZ46fMjGqUbQOTXKAmU2zK5Z09d55QT3aaCpXQO+JCgQyVzS9pKFbcJU
 Lty9RPhUXOXzP6M37nxKpjZZF1ZFd4i1V4Q5VzDX84fFtowFH5dN4A/s2pVwo8zqUzNC
 eGSU9CVmcTbe2weB1twGfeOinVpCcXjGYN6omHdM6gJ+jIo3LootIZzDBj/xvA1zyxnA
 pmqyrcbY8t2vjatqBJSEg6nMqhKCt2QSXbnGn7GxwDB14hv88dq3OIs5JN2yH6zdTCv2
 txDj5radWzEaNLWm8Q2hbEvIIdiL2NrZ1syxkaDaaqrvFfACTgWW0CnHFfTrmCbjAsoD
 3TTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXqw2pezoIu3lKJfshyj+WYqBlw57ix/Vai4+PW4RtfzvBTsNJ1O++apR4dir7rC7+hRkiml8=@lists.denx.de
X-Gm-Message-State: AOJu0YyJ3KLChdXCfrSq7B46L7vdLn8xLkiQgnATtTDHGtiW9lWFVCz6
 UE+F1UsCMf8hEZ/1OcYjjIYJ/+k0ctG3/hC4VYWbNAhA3CUFy1NTqJlZTadExYpBN56jnKYJLEX
 koN721pn66/79RqFy88oBaUr7KSDINTcsxJPg8nXRWw==
X-Gm-Gg: ASbGncsm9Qlm+CiWTUnB5/mApT1EDFLQNABeML6fUZgpDSl1lwqsaS1S8gtNkwB3Svi
 n2lbY2K/4uRr6pTM+2SeOovEaoGf3dkfzQlvg/8Weouq+07viTkfOQM4uoPBgJshAGfp1+XTaKH
 Njr7BH03CJSJWFPsh7hpuUsoJ804QhoBGuvmDS/GVRsbeus+FEu+pmi4FWCYVpbP5EBJFY2d8qQ
 iakfqZ3b9lEv2+H6PZ3UC9MIhRB1Jt0qwwuKhpG4RCWCChcShoT5Qmm+N+rBGGlsOFwMl2Xj63r
 ItGAbwSoz80vX8k6l7EbeqRDE+dsltw7qcFXzStnWAXvk08zdP1EbuT3Fqr4D08=
X-Google-Smtp-Source: AGHT+IGegYqIlSYk/wwdjsjSJS9Ztp9+0kxpbjVEDnde8/0j7O5hBQXOS1etPTyC9fupBo5PMq4/BL78cf7BAS7m8mM=
X-Received: by 2002:a53:d058:0:10b0:63f:bb86:1ae with SMTP id
 956f58d0204a3-640b53f9f74mr2407757d50.12.1762429074544; Thu, 06 Nov 2025
 03:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20251105122426.59479-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmUip+1EefA10YBCH2Gu6yqqZhKZsh9eqMBBoHsRs-uZQQ@mail.gmail.com>
In-Reply-To: <CAEUhbmUip+1EefA10YBCH2Gu6yqqZhKZsh9eqMBBoHsRs-uZQQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Nov 2025 13:37:18 +0200
X-Gm-Features: AWmQ_bmsMo9G36qfHhJPavdTqTFUeJW0NwZgH0CxnovO3NHh644HR6bTZurDz78
Message-ID: <CAC_iWjLQK_T8rF3GyjmESKo9-F=4XGyycGk8PakTLpEN-VBcsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_driver: don't leak name in
 efi_bl_create_block_device()
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 5 Nov 2025 at 14:37, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 8:24=E2=80=AFPM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > blk_create_devicef() uses a copy of parameter name.
> > We can use a local variable.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         use local variable
> > ---
> >  lib/efi_driver/efi_block_device.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
