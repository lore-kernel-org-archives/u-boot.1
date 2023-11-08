Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3423EC4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9818721A;
	Wed,  8 Nov 2023 16:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tg/+sZ+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78BE4870F5; Wed,  8 Nov 2023 16:34:46 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C9B87208
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d060aa2a4so47508606d6.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699457683; x=1700062483; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mCICSufYAduNOICliI0uUddopQROzO/Ot8MiUKevbsA=;
 b=Tg/+sZ+/SngctLP89eWi07MwrFd0WewFn4WbDFREe7VIpDE1+amaN7g4R6mS6xEYme
 BNwyZhYu12GPRkx1pCE3L4jwVf2PDEzhMWyy6+oGAVlaz/sJeDuLAVrKjt6PsD61vxm+
 nB7iK8+wNwIoJVu36itPJB1mfi1jYVyImDowJuz3vx0YHj0tz1hKj32KUUUin6lLyM+E
 r9OIab613Q0QbTRCWFUkQ4TUVPCFZGVTeHfgCI7xcznne4N1cPZyKkuEF/ypZE68f88g
 8MN53i0v9iVeXUc1R9l1xsO7aj37FcjRL0Za4wH98IF82gbtGej3lQxzVjKf4IoGec9j
 gBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699457683; x=1700062483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mCICSufYAduNOICliI0uUddopQROzO/Ot8MiUKevbsA=;
 b=F1uCmTRtiVLvOfXZyi0hd+k8azgxEX0GnVUY6PzbIIxRD709unzIDvrUQLP4uUJ+xd
 xBQbc6HmMRMrKS63NXKN4gwVTvnse/E7RG7DSaZabAdEGEtJdaVlIya7unHX/yuud76T
 tPxTQgUnxs1G81kXRrXTXxUfcZ2jLp7I8/qFzheNItFax1xzRUYP9+9kUDV5Y7J1MYpx
 NJ223RdnoZGsb63Q19m3QPBCQOajmhTWgkKzkeQXoRGIh5ItPP32zxDlD0cAdX7OHbWP
 AI6qrZKUnZoxmEJw4g/w2lQ7LAJ5vUQ+otSE3cQLNGqE93Ql+JCv69tkqqqJJAcqw+Dy
 T+hA==
X-Gm-Message-State: AOJu0YxvPGl4q9leTVjr92x11QE39P9OTcEQHsdS6fmPvZur+VEH2M0e
 P+FTrBWwo0PaFODtPVrE9yo=
X-Google-Smtp-Source: AGHT+IE+PXQBLPM+sfcTudiOe2TaSutRgnyQrK9Ap2jPPpBRlmNXCDpALabsKJkhpJkGCzfI+bt4Ww==
X-Received: by 2002:a05:6214:2a89:b0:653:5bed:83d4 with SMTP id
 jr9-20020a0562142a8900b006535bed83d4mr2140134qvb.30.1699457683002; 
 Wed, 08 Nov 2023 07:34:43 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 da19-20020a05621408d300b00670e7ae4964sm1171568qvb.91.2023.11.08.07.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:34:42 -0800 (PST)
Message-ID: <dbb62be0-6368-8069-3c04-3c5d01d9b077@gmail.com>
Date: Wed, 8 Nov 2023 10:34:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 09/25] spl: Remove filename from spl_load_info
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Stefan Roese <sr@denx.de>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-10-seanga2@gmail.com>
 <CAPnjgZ3BDP8-eT29EdkDz7tW4036WSHq=iR5PyHDPuKQ_bchhQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ3BDP8-eT29EdkDz7tW4036WSHq=iR5PyHDPuKQ_bchhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/7/23 23:23, Simon Glass wrote:
> On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> For filesystems, filename serves the same purpose as priv. However,
>> spl_load_fit_image also uses it to determine whether to use a DMA-aligned
>> buffer. This is beneficial for FAT, which uses a bounce-buffer if the
>> destination is not DMA-aligned. Remove this logic, and instead achieve it
>> by setting bl_len to ARCH_DMA_MINALIGN. With this done, we can remove
>> filename entirely.
>>
>> One wrinkle bears mentioning: because filesystems are not block-based, we
>> may read less than the size passed to spl_load_info.read. This can happen
>> if the file size is not DMA-aligned. This is fine as long as we read the
>> amount we originally wanted to. Modify the conditions for callers of
>> spl_load_info.read to check against the original, unaligned size to avoid
>> failing spuriously.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>> Changes in v6:
>> - New
>>
>>   arch/arm/mach-sunxi/spl_spi_sunxi.c |  1 -
>>   common/spl/spl_blk_fs.c             | 10 ++++++----
>>   common/spl/spl_fat.c                |  6 +++---
>>   common/spl/spl_fit.c                | 23 +----------------------
>>   common/spl/spl_imx_container.c      |  8 +++++---
>>   common/spl/spl_mmc.c                |  2 --
>>   common/spl/spl_nand.c               |  3 ---
>>   common/spl/spl_semihosting.c        |  1 -
>>   common/spl/spl_spi.c                |  2 --
>>   common/spl/spl_ymodem.c             |  1 -
>>   include/spl.h                       |  2 --
>>   test/image/spl_load_os.c            |  1 -
>>   12 files changed, 15 insertions(+), 45 deletions(-)
> 
> Er, I think
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> but I wonder if this patch could be split?

Into the filesystem bl_len stuff and the removal of filename? Yeah, probably.

--Sean
