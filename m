Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC0BEEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A1984175;
	Wed, 31 Dec 2025 18:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lwE7Jzxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799BC840AE; Wed, 31 Dec 2025 17:23:20 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 395CF83F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-803474aaa8bso3992315b3a.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767198197; x=1767802997; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1cs+7CYaqE7Vjw21DUhkqE6QlRPtOA24lVKFpOu2Hao=;
 b=lwE7JzxmvMw1Ctr78n5dlvEQx2HoxQQYnjd6k6a8G4pIg/GhAXIUKfQOnk/PC96WYw
 zlL+o9n6ak6NMAxcqjX3UZrDrIT5sI9iCIRuBcUqKurZDLdG6v9WxJvY521gIAKRKq+3
 R3X8JfoR7CtzcSyD9b4ps85xzyYRyC0M6ZhL7YnDnBDhPvGiny6aOigiNnH2iWCAZGV/
 LhaLftolKD8wWpJ200N5iIPmF8GY3Jk6ijgCQf0APTIuoPE2tS0EgKMwiLKp7uZvuhgU
 Cc2rTdq/RaeGSJHU0xSMxdIdugWR+XKLZLn8VvHbW5Kk+oGH7fxyhGsyKYPg/P7zsRCk
 Wy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767198197; x=1767802997;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cs+7CYaqE7Vjw21DUhkqE6QlRPtOA24lVKFpOu2Hao=;
 b=kEc98nUyExeex28Ael2sYtBDFG/s+KySqYRp8S3JfhuXlW5afgjjmjhkq8cTGbTl7H
 R9YDQk7wPH1weJCuO6sqxfq9ECbdVnKYjAqPkx1QYqrqYbBAonrhlWbgzhG2w2qm+k01
 skU6faV4HvDpDKcWn3IqGDBLNZ+daR+LC24LcpU78vBj6v7Xs1YtKJilaqOz2BU2tnpJ
 zZMoukrtsnSiiS6IZ36v3TmQav2BmTbUm4y9rgDPeLrtBlRkHLavEHbzV2h+0TRNCvS1
 Ly1lJ1kNZ46ff2oPTLrcb0aOFzjFyaG0zZZ6hYtLZ6rTNjz6lAug0PURiZi9WqFauvB3
 WnSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPxi7UOFOiv9n1U69qGLZLwbwBoIg4suJBXoSubibCVoGkp4FfKSrSGbSxIQ8fEC8P5f+8Ibk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf6Tyspg+dLTHGGiJJVeoW0fm1VQKJD83XS1KwTpLHvJJQ+Ftd
 9PcxzZRPUOrKuS6Pk6SNxpGGhOdLluNhm8KjhieRqvITRgwVzt9l3WKl9h9DYg==
X-Gm-Gg: AY/fxX4Gjb70ywMaLcEiShISAASikxWvT2QIPWWJzfbnCsEeVW1iMk+nScEcrsBrXmk
 i7DSO2LCh/AMyEMTgQe//8KtM7Xk9WWdEt5Y2UnC5Jlcind4N/HgIvfZYYdj1t3jfW1oPy54s+7
 MwlDJE5jF2isiBtJkMXBrT0GSMaCN5gS31UdV61vZ1tdodi3RGRXaLC16ABsA0WqBSlrtp/CeMN
 Io8UgxUqWRC0iq2k25cSuoPwCor2K7iL8LSD2C3Kn1KRMO36ajhM3aEy5nq7XbkcIsS5PHl+Wpf
 QP6UEFjqnocRmLVB153x73JrvqkxNMbfW6a0Q48QnH9GwUiKXyTrki3/hrPtMnaJCCVXs3l2ClX
 aM+sa44+kjl4rniaJzSyONEgNaJvuQZ9kXOZIOW4F+qmfvvHXOJXGZmYXiz6TIm5Urh4M/JrTey
 zWi8qA1rBJ3GXcFMpYRWwwtgY8
X-Google-Smtp-Source: AGHT+IEl4aPCyR3MTyXBAxdMZd365KHoLQTBwVTosIxHNT+oZR1gcfqLMSYGsWNWmx0wyV+B/z31vQ==
X-Received: by 2002:a05:6a00:2f8d:b0:7fb:9851:d520 with SMTP id
 d2e1a72fcca58-7fe0e9303b5mr27782327b3a.35.1767198196508; 
 Wed, 31 Dec 2025 08:23:16 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:671b:a2e7:4f81:f445])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b22536esm35323790b3a.23.2025.12.31.08.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:23:16 -0800 (PST)
Date: Thu, 1 Jan 2026 00:23:12 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
Subject: Re: [PATCH v3 3/6] rtc: goldfish: Support platform data for non-DT
 probing
Message-ID: <aVVN8CxdN7od62j_@google.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-4-visitorckw@gmail.com>
 <3983ea9a-e965-472f-aced-d74f27ed95e0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3983ea9a-e965-472f-aced-d74f27ed95e0@gmx.de>
X-Mailman-Approved-At: Wed, 31 Dec 2025 18:47:14 +0100
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

On Wed, Dec 31, 2025 at 01:12:45PM +0100, Heinrich Schuchardt wrote:
> On 12/30/25 17:01, Kuan-Wei Chiu wrote:
> > Currently, the Goldfish RTC driver exclusively relies on device tree
> > to retrieve the base address, failing immediately if dev_read_addr()
> > returns FDT_ADDR_T_NONE. This restriction prevents the driver from
> > being used on platforms that instantiate devices via U_BOOT_DRVINFO()
> > instead of device tree, such as the QEMU m68k virt machine.
> > 
> > Add support for platform data to address this limitation. Update the
> > probe function to fall back to retrieving the base address from
> > struct goldfish_rtc_plat if the device tree address is unavailable.
> > Introduce a new header file include/goldfish_rtc.h to define the
> > platform data structure.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v3:
> > - New patch.
> > 
> > It appears there is no specific maintainer listed for this driver?
> > 
> >   drivers/rtc/goldfish_rtc.c | 10 ++++++++--
> >   include/goldfish_rtc.h     | 15 +++++++++++++++
> >   2 files changed, 23 insertions(+), 2 deletions(-)
> >   create mode 100644 include/goldfish_rtc.h
> > 
> > diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
> > index e63a2766c76..900daabccb9 100644
> > --- a/drivers/rtc/goldfish_rtc.c
> > +++ b/drivers/rtc/goldfish_rtc.c
> > @@ -9,6 +9,7 @@
> >   #include <div64.h>
> >   #include <dm.h>
> > +#include <goldfish_rtc.h>
> >   #include <mapmem.h>
> >   #include <rtc.h>
> >   #include <linux/io.h>
> > @@ -77,11 +78,16 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
> >   static int goldfish_rtc_probe(struct udevice *dev)
> >   {
> >   	struct goldfish_rtc *priv = dev_get_priv(dev);
> > +	struct goldfish_rtc_plat *plat;
> >   	fdt_addr_t addr;
> >   	addr = dev_read_addr(dev);
> > -	if (addr == FDT_ADDR_T_NONE)
> > -		return -EINVAL;
> > +	if (addr == FDT_ADDR_T_NONE) {
> > +		plat = dev_get_plat(dev);
> > +		if (!plat)
> > +			return -EINVAL;
> > +		addr = (fdt_addr_t)plat->base;
> 
> addr is not a pointer, it is an address in the sandbox virtual memory
> address space. This is why map_sysmem() is used below.
> 
> The suggested code fails to build on sandbox_defconfig with the driver
> enabled:
> 
> drivers/rtc/goldfish_rtc.c: In function ‘goldfish_rtc_probe’:
> drivers/rtc/goldfish_rtc.c:89:24: warning: cast from pointer to integer of
> different size [-Wpointer-to-int-cast]
>    89 |                 addr = (fdt_addr_t)plat->base;
>       |
> 
> Please, use
> 
> 	priv->base = plat->base;
> 
> If plat->base is NULL, please, throw -EINVAL.

My apologies for the oversight.
I agree with your suggestion.

I will update the code to assign plat->base directly to priv->base in
the next version. I will also verify the build with sandbox_defconfig
to ensure there are no issues.

Regards,
Kuan-Wei
