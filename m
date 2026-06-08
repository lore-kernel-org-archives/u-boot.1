Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878F8CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD5584154;
	Mon,  8 Jun 2026 09:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iGWyKusE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA1E84154; Mon,  8 Jun 2026 09:48:13 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B139846D3
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so3884654d50.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 00:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780904890; cv=none;
 d=google.com; s=arc-20240605;
 b=KDKsebbhS3Ges0NG9gUJfPrUPFxxT/CUjjNHe03xvRP39Q7hIXxqixnSJ09JqdbgXp
 tMiGxVDd+2gH/WkSRxyQdSInx1Gt0ni2WeBXCYj8bTlgxwSafm3KILGebOCVS3pDBKOS
 7DP6aQO8LjfmIR5kM9imFYPfbwdr5cVNqQDpOxFNwEhrEDnw38oL0zhbG6vGoCkelK8s
 D4et2ia/4kJi4jmK8X9uo1X+7YmkXvbSjJU2E2DXqmfI+f0yagoXxgOA5z4jypx0NPOo
 aACCOa9zBOa5FCJdrWary4ygn/l9/fJll/7hy3YlWDhYTzm6oMNCoG0ZTtHZUaYZVq/k
 XmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tIeuzN8baKpl/6jfzN0E+XKauAxlao8Tf2IL6ZLJLZk=;
 fh=gXgc3qdzfhhR9oWTIh7YN12eVIYyhW0jpPzlD9IkQLI=;
 b=Xvw9Z8XFtS5fweCwiWIg77H/iLH4nXZy1gURj+Ug9TxrQJhvLFe087zOzi0z98kz2g
 jJfyjT8WtBtb2X3NldIocqfYvN7lolMuXa7A+PMEfV0W2SJxcx3FYFteNSGRmjZ6gh1U
 Mgbg+W6/IjxCGg189J0P6+2+zTqiGirrvj5Q0KJHEhgfIWgpPXD9EugzqFnJXvDnuxtL
 NSI6llSPk5xhru1dHq3//1XGiZ6lRgEZdsNNFQ89E9C1tHHhwcX+mkYC0Lfcpcg6g5AO
 gLhyhev6+o9Eka+ZdS6Nt7tPBK/0VepkI2vuuDt0WJCSwEYnMCV85pmQBbweSHNGmWo5
 Y1wg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780904890; x=1781509690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tIeuzN8baKpl/6jfzN0E+XKauAxlao8Tf2IL6ZLJLZk=;
 b=iGWyKusEoFAobvLsl+RzUQFxq0kdQ4DT2SRh0PyymKm5Q0PGUmVspWpJqdOiqxir/m
 5onoedlDjGRMg8vdvonsw2QCmv3gn/KU/iuQMaXjGUMjSFSaPTBZ45ByFKCHSIEwiqcN
 1n3iVzUc4gII7SlKFZFMrNmay7wfvkINk9FgaG0jCm7H9F20SAHJS83ozOS5FEcTbpBX
 XVesGkNHdwlbYbcyMpEHq44pdLEg1UfyEWwTaqU7dse3oHjJLv31FC0UICQhtyNdTFTx
 o63rjNdDikbjjmsITBWw863EImUNP1sQcozOuYyoqihQBHu5KaQ4MnxWAikX4VTz5YoU
 emAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780904890; x=1781509690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIeuzN8baKpl/6jfzN0E+XKauAxlao8Tf2IL6ZLJLZk=;
 b=APXUOP1FSFni8+tGZQDZKqMPdnjck+1RNLbD/7UFC/tUB7HSTSMRmgEkx46jwhJ7OA
 NeQu7tbYAhMbyAmhbKLKECqKkqdsANrSZVg5rCVWjRdagtPKSRSr8I/LGOX3gL11WvGg
 NiBw5E6NJZekimAzST9X3gcItQ0ve11xfIec6MlesNojNQdg/lH/2Aku5h8XxEbvT1xB
 so1AIDLjbVC48ab9yfAH/0ebLqqHk3dExI163DCoMk6i7dJC9lvWv56TGLFUcekoTBUa
 zuThW3Ii1KqAtaiK6JTGRlnDGH1GvlOyghp+ytLXN8DUocgi0Uuz3QDZ0UGl/kFgc1JS
 Utmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DcoPuhyq3UhERmAVDu/C4pSyMsHwp2o8aQ1EGX8dfY8zVR6mCLZaK2A/YTYPxYNiXf0+qFvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwG3ALEn2NhfG396e/K4h5veqtIaheDVW7TBAC3FFKqX1aPrt2c
 O6ETkQ+BdfLRTrRFLwBzwzp9JwcEbxluePYo3Lyo+2jUZ2sqKOBXIGleZbgU5OkV8c0ww1k2oIA
 zCGhErCTqZHhawCXR45tCJd4xSE2qJqZ1MoAbIHtr9FwyzP98/Y/7zoM=
X-Gm-Gg: Acq92OGKw8K71YwKxmvvNoNBibGJqqGLUkaURvRUazvvbLGy5uugxrQV44WEalbqzBp
 vSuh9JStD8ax/mTt7nQai8T1rk+9qlC3vMhCiP1jqgXOvMhoTwVm6kNhHplAVBc0FmuVLIPBELA
 xJOrgHptxvHM+r/lC8kJJiyEp3XYlOVRXrSphUwU2EU6i2pNuo+pnnyhQMRNQE/K8zJmSneQfuY
 1A8reBGFevW66UzyJuNUB8zJ4ZqxyhceBu8cY7jTQonA3dlBQdpAYYmmcgtyCyDz73qk0hdXQl/
 nOpaFefPISJlNQHx6cOp5SejEbzDU8EiYMqavFAfB617NE97YvRD/RX/jrexTyVuGtMtwNHUhuG
 yUqAuQ0cp/ZHmk3ScILZT4RLHxHXPbO9e5DpMw/V97YE6kh5d0k4/5zXCMqwslGicOqGKDzFOYT
 69QEGqb5Rk7AlMslK8QmFOyf518vKFScZNgZDLZ+rgdut84O9/Vv6Grvb18q12MS79g3QrKvu6H
 UuHZHeUvpXJH1ZBUYbMlw2wE0+Nq8YE5mCC60gJ/yPPmj2TVA6jjEnhky2ZwvBf7xf22XGnXKGB
 DtwaHkf+tgvglYrgi0h55amG0n0X6ez0cjgczOfbvFd5dajce3fXqV/if3y5ftf0lDjE+AvtbPW
 LU6cEDoh875AW3y5v
X-Received: by 2002:a05:690e:4090:b0:65c:6f05:adf5 with SMTP id
 956f58d0204a3-66106fbd515mr12246842d50.60.1780904890077; Mon, 08 Jun 2026
 00:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-8-ilias.apalodimas@linaro.org>
 <CAFLszTj9K9AkH4HtEDHvoeH=YFQeTo0xJHG-pDNWx2FMQJ5YmA@mail.gmail.com>
In-Reply-To: <CAFLszTj9K9AkH4HtEDHvoeH=YFQeTo0xJHG-pDNWx2FMQJ5YmA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Jun 2026 10:47:34 +0300
X-Gm-Features: AVVi8CeK4rb_WcpKsJ2d7UGTZUOF3DN6lilwqAD3WaY3RJQUzjnzFcl15Fn2LpQ
Message-ID: <CAC_iWjJK2D+5uyjBneB9wcruOVcOMQju8h4o5okvwrrxzAU7SA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] doc: Add a warning about using RELOC_ADDR_TOP
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, u-boot@lists.denx.de
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

On Sun, 7 Jun 2026 at 21:20, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On 2026-06-04T07:37:05, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > doc: Add a warning about using RELOC_ADDR_TOP
> >
> > Since devices that can't DMA above 4GiB will misbehave with this option
> > enabled add a warning on the documentation.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > doc/develop/memory.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> nits/suggestions below
>
> > diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> > @@ -110,6 +110,12 @@ U-Boot Proper Flow
> >
> >        This follows the same as in SPL flow. In board_init_f(), a part of memory
> >        is reserved at the end of RAM (see reserve_* functions in init_sequence_f)
> > +   #. Relocation address
> > +      By default U-Boot will try to relocate below the 4GiB boundary. If
> > +      RELOC_ADDR_TOP is enabled U-Boot will look into the dram bank config of
> > +      gd->dram[] and try to relocate to the highest available bank. Use this
> > +      with caution as devices that can only DMA below 4GiB will misbehave
> > +      since their buffers may be allocated above the 32-bit boundary.
>
> Can you check the rendering here? It seems that the title will run on
> to the text?
>
> Also text only covers the default and RELOC_ADDR_TOP, but does not
> mention that boards can still override via board_get_usable_ram_top().
> Worth a sentence, since that is the other half of the new behaviour
> from patch 5.

Sure I'll update it on v6

Thanks
/Ilias
>
> Regards,
> Simon
