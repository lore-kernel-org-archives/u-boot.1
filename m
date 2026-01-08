Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D33D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C37841F2;
	Thu,  8 Jan 2026 18:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O9QEurFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A9A8425F; Thu,  8 Jan 2026 18:43:07 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36C184158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo2439737b3a.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894182; x=1768498982; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vwVzuU39fQfSTIJLEVR7n1ncU3U/Wi0WAFQ12M3jE1Q=;
 b=O9QEurFnYk+BJ5b2xGg4pmJzWqQASBY+KPcDsZiezRRW20QHnnEMSBTHBuqx2yG/Pj
 lUzJaiEETAJxDnmMmOpZrSe+0kk+M6uoXmEezPAg41ojeh7pNYKM+uGJp9PvCQPXJSem
 Qua4v/Tw4Y0LzrR3tn4zYeM7U6DEmUkwT7ki0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894182; x=1768498982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwVzuU39fQfSTIJLEVR7n1ncU3U/Wi0WAFQ12M3jE1Q=;
 b=igSZHXdXKR0QFDmV+rZlIRUOywkbLYYWqBRvZkU9lkEVzOcQ5WtHDqGnyp/OiqFLzL
 ztkd0txhVQc2EBg67C7jr6J0kA+vNzdgFUUIyRJMXbQp0rEROlZwBDY297NUfZO6gdkz
 GCl9bAePv4CiDezX9ldGMLiuZjJpNYfkF32VnvQ1bApqWiVb6XGSnFdU6UsFA5VuXvcg
 +YZa9ahikqzlSMhKmsgDySebMQpSvLUsQEosfXe0IVDIhYJLqOUyOHnq75m9sF7w21oE
 I43o3lXdYHGVoo1sM83figUReYAuGqnhW+YUltVahS2FY4LyLLWWi2HrfQFNx66lv7bt
 pNng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8BsGveTXJXfx5YagH159GYJEWJ9OVFvevha4XSHfij5k8pz1WoSRI3loiqKnWqX8taCxZgds=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb+VVWOP2YI2HXS4EHmhZGUQfUWlDTtUgBAaq8vHbVnrGzCuIj
 uOEw6kdceIzH4Y227+k6n6Fsz7iA8f/o6nLQC6jUEWwfbu94knT56svDjaNfA/nGwqAli9WJ6hc
 bmAo7boYfRINsTUkNN0QtrSQKF9SsjEgNLAHm2RHQ
X-Gm-Gg: AY/fxX4pgoh5r+H60HtpzJ/GLQRCwixehRV1Hzf+rl71SNGItCSifJCFgX7u5k6B4yS
 4jP+ic/m4nvSNWOCUHBHIcQsHkWK/aGyxU9VI/AEHj9Tg5fCcoG18Yh54n8RR7tPcu6LkeZV/c1
 yC1gM80/bW/D+tXTMwk2naQCFFc7DvHKTqvlwUlXxRtN0wIeOTJFh3ys8fr03tZjXpnABtpfJ2d
 lFsTwgH/McsxcxpqtF51S0GPzLXiBdh+UCionvRIDTZKh51LiEcAfOdawTwuTd+7TDWyw==
X-Google-Smtp-Source: AGHT+IEsSVOJNTnpL74gY4MHX7pCXOQf4i+DHsn2gJ8WtQKmJMR1v0lGI6C3IqtKMn2oRPCA5PiglfajmA8hS3svH+o=
X-Received: by 2002:a17:90b:568d:b0:34c:4c6e:beb3 with SMTP id
 98e67ed59e1d1-34f68c00199mr6859043a91.18.1767894182439; Thu, 08 Jan 2026
 09:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108064947.3237361-3-balaji.selvanathan@oss.qualcomm.com>
 <aV967ZD8Hdjed/ss@hu-varada-blr.qualcomm.com>
In-Reply-To: <aV967ZD8Hdjed/ss@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:41:56 -0700
X-Gm-Features: AQt7F2rKhN_dBuEeBGk4Kaqrc2LVwU3x4_PFxnecOkyK1aIkVVcPXHSlVpNfz94
Message-ID: <CAFLszTj3xb1e4D70mNk-88F64-_Opk9-vxR13m2+GBZ4udTXbw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] scsi: Add partition lookup by type GUID for SCSI
 devices
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com, 
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, ravi@prevas.dk, 
 javier.tia@linaro.org, quic_varada@quicinc.com, 
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, ansuelsmth@gmail.com, 
 mwalle@kernel.org, anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Thu, 8 Jan 2026 at 02:38, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> On Thu, Jan 08, 2026 at 12:19:45PM +0530, Balaji Selvanathan wrote:
> > Introduce scsi_get_blk_by_type_guid() function to enable SCSI
> > partition discovery using partition type GUID. This function scans
> > all available SCSI devices and searches for a partition matching the
> > specified type GUID.
> >
> > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > ---
> >  drivers/scsi/scsi-uclass.c | 28 ++++++++++++++++++++++++++++
> >  include/scsi.h             | 11 +++++++++++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> > index 3eb6069649f..42a6b5233c2 100644
> > --- a/drivers/scsi/scsi-uclass.c
> > +++ b/drivers/scsi/scsi-uclass.c
> > @@ -53,6 +53,34 @@ int scsi_get_blk_by_uuid(const char *uuid,
> >       return -1;
> >  }
> >
> > +int scsi_get_blk_by_type_guid(const char *type_guid,
> > +                           struct blk_desc **blk_desc_ptr,
> > +                           struct disk_partition *part_info_ptr)
> > +{
> > +     static int is_scsi_scanned;
> > +     struct blk_desc *blk;
> > +     int i, ret;
> > +
> > +     if (!is_scsi_scanned) {
> > +             scsi_scan(false /* no verbose */);
> > +             is_scsi_scanned = 1;
> > +     }
> > +
> > +     for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
>
>         max = blk_find_max_devnum(UCLASS_SCSI) + 1;
>         for (i = 0; i < max; i++) {
>
> Else, i believe blk_find_max_devnum() will get invoked multiple times.
>
> -Varada
>
> > +             ret = blk_get_desc(UCLASS_SCSI, i, &blk);
> > +             if (ret)
> > +                     continue;
> > +
> > +             ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
> > +             if (ret > 0) {
> > +                     *blk_desc_ptr = blk;
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     return -1;
> > +}
> > +
> >  int scsi_bus_reset(struct udevice *dev)
> >  {
> >       struct scsi_ops *ops = scsi_get_ops(dev);
> > diff --git a/include/scsi.h b/include/scsi.h
> > index 8d6c5116419..e0b2f869057 100644
> > --- a/include/scsi.h
> > +++ b/include/scsi.h
> > @@ -361,6 +361,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
> >  int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
> >                        struct disk_partition *part_info_ptr);
> >
> > +
> > +/**
> > + * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
> > + *
> > + * @type_guid:               Type GUID of the partition for fetching its info
> > + * @blk_desc_ptr:    Provides the blk descriptor
> > + * @part_info_ptr:   Provides partition info
> > + */
> > +int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
> > +                           struct disk_partition *part_info_ptr);
> > +
> >  #define SCSI_IDENTIFY                                        0xC0  /* not used */
> >
> >  /* Hardware errors  */
> > --
> > 2.34.1
> >

With the above fixed:

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Regards,
Simon
