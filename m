Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F5C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8910C88A34;
	Wed, 31 Jul 2024 16:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K1xEx9WI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EA088A52; Wed, 31 Jul 2024 16:39:46 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECAB88A54
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b795574f9dso31354926d6.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436782; x=1723041582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QgtVLHdUcRCGY5u9B/rtXigm6W+oCbJyl0TUHTYmOQ8=;
 b=K1xEx9WI8+aGLRzc14Mn0F+vpMYun/MBvOaIgiw7JYNv95AkU3vndvSZCLwcJsnbS/
 5vfMXXXw8IGEIl56mt00HY3ty9vCd3Vr3XNYUxwnBZ3Trc99IPV2UBdBM852PpeBTv2h
 JUsI1zP7k1z81nt77xd4fcshS0WxqAHuwAK+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436782; x=1723041582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QgtVLHdUcRCGY5u9B/rtXigm6W+oCbJyl0TUHTYmOQ8=;
 b=IWegqeh9fBe4nwbL8goJRGhQkulOyrXp0yFwnQyizpb6T1EUGyPsZlilCNp8VmnXB+
 FeLFbD7XXZOw/alrnCVXIMI+PvhajP1dVx736MuLbmHMvkCBSQNbegaMjtQwXuMKzjCT
 WV1tz1rFVjb7aINUkfTSJZV7371FRnhAA/59rAq77R82lZwfro7ai5cZ9WPJvaaQEFCo
 6owT90sZCpG76zoPWzUm+0NgEp/1SHIwits5ThkNCjW+gj+3IOlyTYZWpCr8feTK/PVu
 sNbrsDnr2ad5/I1WmABxY9DGV78dngRPb6ZGi+rP8RzTx2bvPJk1BLFzXWrRshQmM29A
 q7sw==
X-Gm-Message-State: AOJu0Yy8wo/T5e6bCJtTdcNa+3jMeiSZr6d2NSxbAGK8Iwekpg1pic2d
 zZkysHTGHNfz6WpK3z9+BIRzdEEzgto+3IbU+YGBEAyy2apNB34+0TSrPAfAlXQ8AQOtjNnodla
 8Q4Yfrtr3lJBN4NvvvUS+4ixZT4zEXSMviL0T
X-Google-Smtp-Source: AGHT+IG3ZE2ex9SCOGEVORv8dYPX+HpJPJVk7bTazQfqIzQqYnUnWNfjzU0pVKQQv8bNkhMmA+OXKk0Dbjpv1FQE6B4=
X-Received: by 2002:a05:6214:2a82:b0:6b5:7e70:3537 with SMTP id
 6a1803df08f44-6bb55adf73bmr154565756d6.50.1722436782686; Wed, 31 Jul 2024
 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:39:32 -0600
Message-ID: <CAFLszTi3OzbcsLd1_E6m_oeeFrjCgoTKjye+P0WrUmnAPbccyw@mail.gmail.com>
Subject: Re: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com, marex@denx.de, lukma@denx.de, seanga2@gmail.com, 
 xypron.glpk@gmx.de
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

On Tue, 30 Jul 2024 at 01:09, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add documentation for the 'cpu' command, taking NXP i.MX 8M Plus
> as a example.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - Added brief descriptions for each subcommand..
>
>  doc/usage/cmd/cpu.rst | 101 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 doc/usage/cmd/cpu.rst

Reviewed-by: Simon Glass <sjg@chromium.org>

(please add to index.rst so it appears correctly)
