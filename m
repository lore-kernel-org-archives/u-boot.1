Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2270EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D3484142;
	Thu,  9 Apr 2026 15:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cK66sgLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9317A8414B; Thu,  9 Apr 2026 15:36:54 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98306840B0
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso9973345e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741812; x=1776346612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rZLwfRaHT3u3wUIuaugegVpr0T5uM/7zDGwrA6N7Z1o=;
 b=cK66sgLaE5f9HnY/n890QVCQzhZvTnU92h6/Pv20O1IfoKSP1/af1It0f3AATcII3k
 DoF003SRY+DxzBQfwlVoiPhm9CxDAPrx0BUk1d0WWpeZT+udL8w6jZ1U4FVixZryD54u
 JWLKPMrL1wgDcLzLt3/FtwnNrVhr6H0WQ4UCknIO/aVVDLZoPZbHs3iLoG8BAmg4hQhz
 e4x+yfoWNqqFkSQ9hbnGiX2YViGAAobZ66UGAJY8XSrYPEeMEMUA9sSIXMRV+hzuESE9
 l2udGsdUAARP8CcJflVkUrwOKnOKV8nAIeQPYU26dnsMMLOV95xrp/AThWno2cAp6JyQ
 VYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741812; x=1776346612;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZLwfRaHT3u3wUIuaugegVpr0T5uM/7zDGwrA6N7Z1o=;
 b=pafxIvP8o3D3zI5TQ5sGDB9TdBihj+GDdi+q7SmU/s2BEDYAGYuyZbzAO+/ADJpfgM
 NgdUi/KSZmPNT5FA91tJW9jNZhWwucTSsls2EJIaSWwJKvntS2Hvs88oOfZTa2Y3gMnE
 4yIwrcuuMIdJSPNRowOoiQNGGdD2oOXJv4xdXjR6RImZ1AxAKgirxHDkaJuhK5/ZsfF7
 zSVEtLFjwr7q5Cte7HMOI/+2uBiuB3lnwx+lL5pAKUx3+mScjEZQDk+WfZhlVClinkNH
 fQ433sQi5jvBQXgiGjE/bEVWTPTk13By44QE9mIDAT9vMs+d9TIq8TZ0QvyiAmh7yRHp
 oZmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0gl22yy2ms/M7A2k45gc+Yh1mrOzffZDc9NsswJXqIOuSA9yxiI0n6WkJcjthv/R/uWIWohw=@lists.denx.de
X-Gm-Message-State: AOJu0YwmHTpZyyxwWO59BoPK1xXvFpzA/jO4faFRWtzVevY2jmsonOL8
 FjQAZYYmAL1rvE/XtRei4iulTF+durPHyYLYW/grTDxKtu3WGJq7PWna
X-Gm-Gg: AeBDievQL2Ff7ZEFXAKbvfEm6pZRy4SpWr5wnq1r6X54VG22cmhju5Y/JOg2VbPI1sf
 nOwT4ihDLFliBHhkk7jk0u6hS0gA1HAJjRHoYNxT87MluGQvDpHidXjKsIAilRCBC7jAJZYlZxJ
 qQoYrvt7d8RPnwv+azTjxUCcbFz0oWt/YV3srQNqRsoiLJVYhJgiXrFX32atl77Ik6ZARx2TcAt
 aWuJFNYuRGK9qh7LXgasQ1F/0iYKuvpc8jYwBCBVhQFUUDGGV5yN13KbnDqR1KaD68oO0q0uH4d
 oidFmLgrwjj7tIQ/ZmQiE3Xfpap6miuK9VlSpoEIaG+h8n4miXITu3C6+OO81Hh1VEERSWmk/RD
 eeJ3gi+1mmmCb+lhmUktNUVEpMQT5BJyg3IcaMN3mLsVEuh1LBLAqJEPqf8w8RP4TEeIgJ16446
 148lJCVl1IEOyqhfUGCgLFl+jB4dYa9pfWFg9QQV++4cbdi65LJ9iOxReQkDUV04XzG/zrgQsuV
 jnvb6Vn
X-Received: by 2002:a05:600c:19d4:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-488cd03c4b3mr55647965e9.21.1775741811802; 
 Thu, 09 Apr 2026 06:36:51 -0700 (PDT)
Received: from Ansuel-XPS. (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd1ed16esm39083485e9.6.2026.04.09.06.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:36:51 -0700 (PDT)
Message-ID: <69d7ab73.050a0220.ecca9.2809@mx.google.com>
X-Google-Original-Message-ID: <aderbwU73EfHgDb4@Ansuel-XPS.>
Date: Thu, 9 Apr 2026 15:36:47 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peng Fan <peng.fan@nxp.com>, Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 5/6] misc: fw_loader: introduce FIP loader driver
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
 <20260403135205.26979-6-ansuelsmth@gmail.com>
 <CAFLszTjHv+vVunXKHW8ppyq0z3Tr=LZTqiFQEGc4nFcTWwiFgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjHv+vVunXKHW8ppyq0z3Tr=LZTqiFQEGc4nFcTWwiFgA@mail.gmail.com>
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

On Mon, Apr 06, 2026 at 11:14:43AM -0600, Simon Glass wrote:
> Hi Christian,
> 
> On 2026-04-03T13:51:57, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > misc: fw_loader: introduce FIP loader driver
> >
> > Introduce a variant of the FS loader driver to extract images from FIP
> > image. These image can contain additional binary used to init Network
> > accelerator or PHY firmware blob.
> >
> > The way FIP handle image type is with the usage of UUID.
> >
> > This FIP loader driver implement a simple FIP image parser that check
> > every entry for a matching UUID.
> >
> > Similar to FS loader, this driver also support both UBI and Block
> > devices.
> >
> > Also an additional property is added to handle special case with eMMC
> > that doesn't have a GPT partition and require a global offset to
> > reference the FIP partition.
> >
> > An example usage of this driver is the following:
> >
> > [...]
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,578 @@
> > +static int blk_read_fip_firmware(struct firmware *firmwarep,
> > +                              struct blk_desc *desc,
> > +                              struct disk_partition *part_info,
> > +                              unsigned int part_offset,
> > +                              const struct fip_toc_entry *ent)
> > +{
> > +     ...
> > +     size_t size = ent->size;
> > +     ...
> > +     blkcnt = BLOCK_CNT(size + firmwarep->offset, desc);
> > +     blkstart = ent->offset_address + firmwarep->offset;
> > +     ...
> > +     if (pos) {
> > +             to_read = min(desc->blksz - pos, (unsigned long)size);
> > +             ...
> > +     }
> > +
> > +     /* Consume all the remaining block */
> > +     for (i = 0; i < blkcnt && read < size; i++) {
> > +             to_read = min(desc->blksz, (unsigned long)(size - read));
> 
> This reads the full ent->size bytes but starts at ent->offset_address
> + firmwarep->offset. Compare with ubi_read_fip_firmware() which
> correctly reads (size - offset) bytes. The blk variant should also
> adjust size by firmwarep->offset so the behaviour is consistent.
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,578 @@
> > +static int fw_get_fip_firmware_size(struct udevice *dev)
> > +{
> > +     ...
> > +     return ent.size;
> > +}
> 
> ent.size is u64 but the function returns int. This could truncate
> large sizes. The same issue exists in fw_get_fip_firmware(). How about
> using ulong which is the common type in U-Boot?
>

Can you better explain this? We need to return int to handle the negative
error.
 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,578 @@
> > +static int fw_get_fip_firmware(struct udevice *dev)
> > +{
> > +     ...
> > +     ret = fw_parse_storage_info(dev, &info);
> > +     if (ret)
> > +             return ret;
> > +
> > +     struct firmware *firmwarep = dev_get_priv(dev);
> 
> Please can you move the firmwarep declaration to the top of the block.
> The same pattern appears in fw_get_fip_firmware_size().
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,578 @@
> > +     if (ent.size + firmwarep->offset > firmwarep->size) {
> > +             log_err("Not enough space to read firmware\n");
> > +             return -ENOMEM;
> > +     }
> 
> I suspect this check is wrong. If firmwarep->offset is an offset into
> the FIP entry, you likely want to verify that (ent.size -
> firmwarep->offset) fits in the buffer, not (ent.size +
> firmwarep->offset).
> 
> Also -NOSPC might be better, since we are not actually out of memory.
> When people see -ENOMEM they tend to want to increase the malloc size.
> 

This might be confusing but I feel -ENOMEM is correct here. In
firmwarep->size we set the maximum size where we can store the firmware
data so the random guy might be correct to increase malloc size.

I posted v6 with all the other comments addressed, these 2 are the only one
left.

> > diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> > @@ -25,11 +25,13 @@ struct phandle_part {
> > +     int partoffset;
> 
> partoffset is declared as int but used as unsigned int in
> fip_storage_info and read from DT with ofnode_read_u32(). Please can
> you change this to u32 for consistency.
> 
> Regards,
> Simon

-- 
	Ansuel
