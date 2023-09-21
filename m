Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF53AE7071F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E7568653C;
	Thu, 21 Sep 2023 13:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XnQPdAlg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDFD8655F; Thu, 21 Sep 2023 13:36:29 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B528644E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso35427039f.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695296186; x=1695900986; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SdIydjKrDVKbL0Fxy79AZLTi3qkwqlGFernABlouF+o=;
 b=XnQPdAlg1G9Eej/AgoKRkBj2PBu/LGMZGKMo8XVIbrRZNyGKV/qedOvr9t79fZGqV0
 1HqYggrWjipoS2qlQozLc1xcQSaGweOfqbVInlpfNXMKUHCVEF9iThUBfa5zhJ2tavVw
 G/niz1KSG3GbR30WCNtZBHct0+IoJFMjqe5NnbwqYddzdRziiWn+uuBbC96pwxmZE8uQ
 +MnPXkBCN0qg5xETVN5ZOp+gMMRJ0kQoV9KHwThRFvPqHeBmzRdq/88pI1Kb25nf9zdb
 84T8qI36u7qBKEwo9OiLXvHWa1H3uIoFOgOu9WeRrNe5x/lhRuA1QzLDB+3rSFdmiHD1
 4c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695296186; x=1695900986;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdIydjKrDVKbL0Fxy79AZLTi3qkwqlGFernABlouF+o=;
 b=dD96R+81qIu8gQEI+NMisiOXDlBapTjkmKBFie6kUjow6FM1Xghccy3xT+22BYl4QS
 O9wtGJcasGX7gjblNiR8T0t6ZRhbjysEq1MlDKEAtz1xwjjP+usH74Kn5/cqfZC1uftR
 wUnTclvRlkwbSuL6bKN+KyBtZif4Npq0MJEm/JL6xeyCHnHmlNT4gxJd3eoY7YQu1Ylg
 eJdZ6jk9R/i8OD6NC7MGyYdXN4JOYL6aFYiVfWLNw0wvTESM8iMii3VMKL2ZZ8DGghp8
 B4ay4Ihh6fTvBLlpxvXhEvAPKZcgOCDJplFYcebdgjkI/B1rlpNeFU/5fJ1q+1ZUCcpt
 s9YA==
X-Gm-Message-State: AOJu0Yw6x1WOfKW3RBCcap2iL6Kspm8DDws3OlKEVU6k9HBhtMyMM/jK
 9G0ktvuaHvgq9kvT3wWBFaZTgA==
X-Google-Smtp-Source: AGHT+IEem3PhbGb0pSUiwEQUtmfRaeyCgSGRebCNwfw5+RWveCByToOz8IZ4lQZfzMDW0pRK0tRpNA==
X-Received: by 2002:a05:6602:20cc:b0:791:1e87:b47e with SMTP id
 12-20020a05660220cc00b007911e87b47emr4906337ioz.15.1695296186436; 
 Thu, 21 Sep 2023 04:36:26 -0700 (PDT)
Received: from ThinkPad-T490 ([2401:4900:5603:8473:c4d2:90e3:b3d0:fe96])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a62e301000000b0068bbd43a6e2sm1185442pfh.10.2023.09.21.04.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 04:36:26 -0700 (PDT)
Message-ID: <3aaf0234f23c83f0e4e23725b04bf38dda773446.camel@ventanamicro.com>
Subject: Re: [PATCH v1] fs: Fix SPL build if FS_LOADER is enabled
From: mchitale@ventanamicro.com
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Date: Thu, 21 Sep 2023 17:06:22 +0530
In-Reply-To: <20230914163957.GC305624@bill-the-cat>
References: <20230914160515.1121668-1-mchitale@ventanamicro.com>
 <20230914163957.GC305624@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Thu, 2023-09-14 at 12:39 -0400, Tom Rini wrote:
> On Thu, Sep 14, 2023 at 09:35:15PM +0530, Mayuresh Chitale wrote:
> 
> > If FS_LOADER is enabled for the SPL then the build fails with the
> > error:
> > 
> > fs/fs.o:(.data.rel.fstypes+0x128):
> > undefined reference to `smh_fs_set_blk_dev'
> > fs/fs.o:(.data.rel.fstypes+0x140):
> > undefined reference to `smh_fs_size'
> > fs/fs.o:(.data.rel.fstypes+0x148):
> > undefined reference to `smh_fs_read'
> > fs/fs.o:(.data.rel.fstypes+0x150):
> > undefined reference to `smh_fs_write'
> > 
> > Fix the error by populating the semihosting entry in the fs_types
> > array
> > only for non-SPL builds.
> > 
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
> > >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >  fs/fs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/fs.c b/fs/fs.c
> > index 2b815b1db0..074db4b20f 100644
> > --- a/fs/fs.c
> > +++ b/fs/fs.c
> > @@ -256,6 +256,7 @@ static struct fstype_info fstypes[] = {
> >  		.ln = fs_ln_unsupported,
> >  	},
> >  #endif
> > +#ifndef CONFIG_SPL_BUILD
> >  #ifdef CONFIG_SEMIHOSTING
> >  	{
> >  		.fstype = FS_TYPE_SEMIHOSTING,
> 
> This should be CONFIG_IS_ENABLED(SEMIHOSTING).
Ok. I will update it.
> 

