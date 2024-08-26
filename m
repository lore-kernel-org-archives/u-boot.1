Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E863C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F03E5889C9;
	Mon, 26 Aug 2024 19:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NSRdQJmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9987886A7; Mon, 26 Aug 2024 19:58:25 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC7E88981
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf6606363fso25185526d6.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724695102; x=1725299902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LyFS7APjr4VLoqaWnaJJAkzn2J91m/Xyivhc++XdrPM=;
 b=NSRdQJmFj+VqhLBF2grviwxxHRyhbSWA7XO42vnMcN5cyvRwP4x4eCjctiakjVGwFR
 R4ifhNKVnw5Jfsyz8X66Ob1XrziRI1IiHlMSyyDc+kjmlgjVwh/76SGJ4gnIseZcLMnB
 n0aGaqR7Wqnb883Ok7KRB89IbKYLoulkObrx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695102; x=1725299902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyFS7APjr4VLoqaWnaJJAkzn2J91m/Xyivhc++XdrPM=;
 b=CyHrGTAZEKJIo4e7kFeY5xKBUUdMbgeXUjgo3a90FRjBNOgL7zVo6L/B3eZQc+/0St
 qrud72FNNB9w+Fr1h6LMbfyJV4aPqofQMWFLuTk+qi6wLS/6H26Qdn1e6OJLfjXbPza6
 IomQiO6Y9THzRFRDLUzVlxK1UkdGJ9Oyah4HSZ3JG4IYwaRuUvgSz7fpzacl5Zhrko7Z
 tbum/0U5Ot+KkFniLVpSqZ7SDY2k044ttdagbgAaHrsl+9h1vO7R+ZKh6toEmiUxJ0yl
 GX3xiN0zRLpYquULD23RFNEMnrwzVf35zdguhpOrmydZrrgx5IoSFYntea1MSaOo8t3+
 IvLw==
X-Gm-Message-State: AOJu0YzuCd98fBvzP56pgt4sUypBiPaVcQUp7WTQFL3xKQyb3hNV94Xx
 9vaSbvxVXtq9mkfvYuWxuSx+zUHUiTyplMagH9MYkWc2o1fXrdEdDQpQGRXXQtcdhqjwAFW6xJg
 12a0j0vQTLO8wwkXc7mO/PGGwVK79fHr6l5RS
X-Google-Smtp-Source: AGHT+IHOj4Lsa1LNweUs5NdW0RVmZJK3owJ+jIzksljsnVD88WhmyXfNq/bHDecp4Cdwj/uSPafw3phn1mC99vNDq5M=
X-Received: by 2002:a05:6214:5345:b0:6b5:4338:e029 with SMTP id
 6a1803df08f44-6c16dc88e38mr127321216d6.28.1724695102701; Mon, 26 Aug 2024
 10:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-13-sjg@chromium.org>
 <CAC_iWjK3Tcx+qiDmLeVvzKyg9O2Ju12ODG0M+8XzcpH-md2+MA@mail.gmail.com>
In-Reply-To: <CAC_iWjK3Tcx+qiDmLeVvzKyg9O2Ju12ODG0M+8XzcpH-md2+MA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 11:58:12 -0600
Message-ID: <CAFLszTi_SDnFwZTkp722T+ocdbne-M9LsXmoAFVNNq+NJGCB2A@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] efi_loader: Avoid using sandbox virtio devices
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Mon, 26 Aug 2024 at 05:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
> >
> > While sandbox supports virtio it cannot support actually using the block
> > devices to read files, since there is nothing on the other end of the
> > 'virtqueue'.
> >
> > A recent change makes EFI probe all block devices, whether used or not.
> > This is apparently required by EFI, although it violates U-Boot's
> > lazy-init principle.
>
> I think the early scanning is due to CONFIG_EFI_CAPSULE_ON_DISK_EARLY.
> I also think we can get rid of this option, but I'll have to dig a bit
> deeper
>
> In any case, I am fine with the workaround
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>

Thank you.

Regards,
Simon
