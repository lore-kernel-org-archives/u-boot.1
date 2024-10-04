Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DAECFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37FB8899C;
	Fri,  4 Oct 2024 07:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sNa2TqeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BA088CEB; Fri,  4 Oct 2024 07:59:18 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F3B8897F
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 07:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71afb729f24so1426259b3a.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728021554; x=1728626354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p+g2YVGP7JBPCZ5GDflrGCGHurFD4HYsyt0cH81GFMQ=;
 b=sNa2TqePpOUE4eV9vhOpTaJg+wR2a5S3HVhYzKC4QoahW49/bbK+nHfthRSRXqNVci
 iQPUjpWb9sQMVE/FjxJ4Xfi4wGamUXp4YAIuwoWvefiggWomqYkpVMLBK4UI+8hhJASi
 4AFB7Lc5oOMuovNNfzQpxoNVPmeuMcIoV9EsxK6+qowepPKzFwlaDWg8OdOWDeM8rTnH
 4t8RSXwDlme+FKwyGjmL7TQS+IEXGys3S3cx5n9TXfLsWAjjUUpPnJTX8XIWanv/3EmM
 jxnhroqFyD+/s4JAYu/E3/Qcr27o/5pGZq6AdPPNQsbJZpsnSPWFdXnx9RalATzcm19+
 vXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728021554; x=1728626354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+g2YVGP7JBPCZ5GDflrGCGHurFD4HYsyt0cH81GFMQ=;
 b=YicFbO38mfJhYG87ZJBdaL4OeCUEB7OeaYC6Ly/AMZ+rpBoYfja0ngym5vwqRl3sqp
 Wpvx927VBbE1oNihoB2UhnZyEzPujT3T8fJOx0wQiPUcykZCE/BE440FDKKkYkHkm4yD
 /Kvds0Wwqfmv5Bg4fsAWsVqMxSWidSoVM9Q28KZg+BkIEGoaO6isy/aE9WYRy5RgJsDC
 97j3sj0Z7KEbJy38mYrhwePPPNy3MHX9ZKuQRi9+K4BjGug448cnBLpcc4CzYXqbXSDJ
 NnhRLOCGAeHjsJxWtaPalAYt1fy96k13To7Y0hUXYjrQzBJiEokSl55PsHbBgxzo6sLr
 ThQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqf2fL3YQo0/yUb9nrW18Txg2xOh+nrYFE+pH61oJnt0TsUI48bsPsH5nIqtKl/WbIc3/9mOw=@lists.denx.de
X-Gm-Message-State: AOJu0YxTBPxvt/gcc5NBW9uisbKYqiBykFHozrjT+LJKCZBOFyr7Keyo
 JzlDN2WFQUYJRgwTdCvrTH6SokxU/fZ86a3eNeLVL/WV7D32WGddvMQVaJ8ffXSc1vkyLTWVu4Y
 vjYiyI64VI6Z5TkICkZVaUigqD0xhS4kHqyzGaw==
X-Google-Smtp-Source: AGHT+IGyxC7G6ToKdXdMzunELdg2BI4DczUyulVOqjAsYa9ZdYzvprlK9zE91Vudo+UuJa40/nMoBwMi3TKHgYJOqEo=
X-Received: by 2002:a05:6a20:d045:b0:1d2:e888:386f with SMTP id
 adf61e73a8af0-1d6dfae2994mr3065295637.42.1728021554311; Thu, 03 Oct 2024
 22:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241003142030.1610222-1-jerome.forissier@linaro.org>
 <CAFLszThy6TXhZ_fkgsWyoMmK_F3ciC_CV=fd3KULjqQuRPuVzQ@mail.gmail.com>
In-Reply-To: <CAFLszThy6TXhZ_fkgsWyoMmK_F3ciC_CV=fd3KULjqQuRPuVzQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 08:58:37 +0300
Message-ID: <CAC_iWjLT6Ob__1dj+okJ96T7QSboC1F1gYZi41s17h3Xff-d3A@mail.gmail.com>
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 for CPU_MIPS64
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Alexander Gendin <agendin@matrox.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, 3 Oct 2024 at 23:46, Simon Glass <sjg@chromium.org> wrote:
>
> On Thu, 3 Oct 2024 at 08:20, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> > exception may occur. Fixes an issue found on malta64 with QEMU:
> >
> >  Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
> >  31                      if (!strcmp(name, entry->name))
> >  [...]
> >  ld      a1,0(s0)
> >
> >  (gdb) p/x &entry->name
> >  0xffffffffbe04b0d4
> >  (gdb) p/x $s0
> >  0xffffffffbe04b0d4
> >
> >  $ grep __u_boot_list /tmp/malta64/u-boot.objdump
> >  4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  arch/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
