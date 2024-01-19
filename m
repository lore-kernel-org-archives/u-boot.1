Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1280DC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670FA87BE1;
	Fri, 19 Jan 2024 16:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TSHCd82X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CD187CB6; Fri, 19 Jan 2024 16:32:44 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F65587BB5
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7beda6a274bso34759439f.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705678360; x=1706283160; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RuzCcCGi5vCYc1IZNGfo9fiZAb11v30FUskr9pJQpE0=;
 b=TSHCd82XOPSkAW6VwEPXJp0QzK+5X/ALsvRG7OoJfjSuo+toEulQBjVGN9axVu5VDA
 LwJKKYi1+jMqMs7LfQNWLjP2qILQi6zLKs4v/1dH+OhvA3MGeGiVvTKC+7cpzFaNMR7d
 +5IPnSnxOUPgMDI68bXKLQ40Rg4R9Q5CjLwZSHyVIEOgwwjCBaSZkIuQ8bByCw++XaAr
 Q76N3ombJ/bOVANb1k7uGNKios/CSyWTjcDiWO11lvjOF8quWB+qC2vL7GETVstQcXrm
 FOHkVAgjeghA5REdLVrTelvphcE2BMAwlNh87M5t9hAGZyQfWPXxExIz6wCYGUwhymAW
 OdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705678360; x=1706283160;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RuzCcCGi5vCYc1IZNGfo9fiZAb11v30FUskr9pJQpE0=;
 b=H1DDnGycyLSFF2LcNEvSLAoDexj+AZEXBrgsYM3v343jtPrIMUdL6fBfbp62wcklDg
 vkQGmDuUv/48xcOQqpy4Kan9Cd2UJQANw9/Sq3yKiTjM/+EV/qjMTbDnis0FXFCOCPa0
 akOEmCU0vpSzzeurk13Zn+7JMkYLADr1lxQh1F89kTtVkUpLnCoEVffgT5TBha+wQU0L
 D4kfGEzJCVWLfTaNcYQrm+Ewep0ua3bqLgvYy36UyLHXhRNJhZxyfOaLOmgc6HfnU22G
 hFQdc3YxUdJQVOBqD8op5zfcIQVtu3siYNc5kfQmJeHXbTPc1Lt7W5ThRnMhw6RHjv2C
 kbUw==
X-Gm-Message-State: AOJu0YxYaydU7Q00rcj6/WLQRDc/1XwmQm+IE/nNARKgWugy/PfR713I
 O7mxDNz2BTQiiboo8GEPy35PZEbLNMJLX7n1hiECzK3E6xUps2rWbracuggAzHggb4npOUMC8G/
 8SRE0mQ==
X-Google-Smtp-Source: AGHT+IE7oiwfxzL5UMhgJ0q1zWCMkviKs+Xmju/0Q/i3iKlboAHPwPzDesUm8Va8NeOiAsl1fEmyaw==
X-Received: by 2002:a5e:8808:0:b0:7bf:4474:3753 with SMTP id
 l8-20020a5e8808000000b007bf44743753mr3183267ioj.25.1705678359836; 
 Fri, 19 Jan 2024 07:32:39 -0800 (PST)
Received: from ?IPv6:2401:4900:5623:b8ee:2ad4:6910:924a:aa6a?
 ([2401:4900:5623:b8ee:2ad4:6910:924a:aa6a])
 by smtp.gmail.com with ESMTPSA id
 x35-20020a0294a6000000b0046ec11ca04dsm626894jah.142.2024.01.19.07.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:32:39 -0800 (PST)
Message-ID: <e5b7396c936e8e3c3db2b202c719c4c9b4d73ff3.camel@ventanamicro.com>
Subject: Re: [PATCH v2 1/2] part: Add a function to find ESP partition
From: mchitale@ventanamicro.com
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Bin Meng
 <bmeng@tinylab.org>, Tobias Waldekranz <tobias@waldekranz.com>, Joshua Watt
 <jpewhacker@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>
Date: Fri, 19 Jan 2024 21:02:31 +0530
In-Reply-To: <77d00047-154e-4e35-8171-3028c4b5d3f3@canonical.com>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-2-mchitale@ventanamicro.com>
 <d3d71b07-9636-42e9-b29b-31ae84d8e4b4@canonical.com>
 <77d00047-154e-4e35-8171-3028c4b5d3f3@canonical.com>
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

Hi Heinrich,

On Tue, 2024-01-16 at 17:14 +0100, Heinrich Schuchardt wrote:
> On 16.01.24 14:45, Heinrich Schuchardt wrote:
> > On 16.01.24 13:36, Mayuresh Chitale wrote:
> > > If a disk has an EFI system partition (ESP) then it can be used
> > > to
> > > locate the boot files. Add a function to find the ESP.
> > > 
> > > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > Reviewed-by: Heinrich Schuchardt <
> > > heinrich.schuchardt@canonical.com>
> 
> I ran your patches through Gitlab CI and some issues came up:
> 
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/771497
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/771498
> 
> Could you, please, have a look at it.

I looked into the log files below:
https://u-boot.source-pages.denx.de/-/custodians/u-boot-efi/-/jobs/771497/artifacts/test-log.html
https://u-boot.source-pages.denx.de/-/custodians/u-boot-efi/-/jobs/771498/artifacts/test-log.html

If those logs are correct, I think the failure is probably because I
removed fallback to the user provided partition in case the ESP probe
failed for some reason. I think that fallback is required here. 
> 
> Best regards
> 
> Heinrich
> 
> > > ---
> > >   disk/part.c    | 16 ++++++++++++++++
> > >   include/part.h | 11 +++++++++++
> > >   2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/disk/part.c b/disk/part.c
> > > index 36b88205eca..6b1fbc18637 100644
> > > --- a/disk/part.c
> > > +++ b/disk/part.c
> > > @@ -848,3 +848,19 @@ int part_get_bootable(struct blk_desc *desc)
> > >       return 0;
> > >   }
> > > +
> > > +int part_get_esp(struct blk_desc *desc)
> > > +{
> > > +    struct disk_partition info;
> > > +    int p;
> > > +
> > > +    for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> > > +        int ret;
> > > +
> > > +        ret = part_get_info(desc, p, &info);
> > > +        if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
> > > +            return p;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > diff --git a/include/part.h b/include/part.h
> > > index db34bc6bb7d..30e049c8f19 100644
> > > --- a/include/part.h
> > > +++ b/include/part.h
> > > @@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
> > >    */
> > >   int part_get_bootable(struct blk_desc *desc);
> > > +/**
> > > + * part_get_esp() - Find the EFI system partition
> > > + *
> > > + * @desc: Block-device descriptor
> > > + * @Return the EFI system partition, or 0 if there is none
> > 
> > We want to be able to add the include to our API documentation.
> > This 
> > requires adhering to the Sphinx documentation style.
> > 
> > %s/@Return the/Return:/
> > 
> > Cf. 
> > https://www.kernel.org/doc/html/v6.7/doc-guide/kernel-doc.html#function-documentation
> > 
> > Best regards
> > 
> > Heinrich
> > 
> > > + */
> > > +int part_get_esp(struct blk_desc *desc);
> > > +
> > >   #else
> > >   static inline int part_driver_get_count(void)
> > >   { return 0; }
> > > @@ -700,6 +708,9 @@ static inline struct part_driver 
> > > *part_driver_get_first(void)
> > >   static inline bool part_get_bootable(struct blk_desc *desc)
> > >   { return false; }
> > > +static inline bool part_get_esp(struct blk_desc *desc)
> > > +{ return false; }
> > > +
> > >   #endif /* CONFIG_PARTITIONS */
> > >   #endif /* _PART_H */

