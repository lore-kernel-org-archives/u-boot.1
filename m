Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB49C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 20:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197E487C69;
	Mon, 25 Mar 2024 21:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XkWGTVoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E5087A80; Mon, 25 Mar 2024 21:37:51 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B31D87A80
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 21:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6c0098328so3213757b3a.3
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711399067; x=1712003867; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uc1ahUCprBaHdZDdyVFZVU+U0HnRN9wykSxCF4/416w=;
 b=XkWGTVoWVvQF3bBd4xQmSgR7f8O7oG/r7KbBUyZCdmYNKLTXM9XCcahJUMv6BUAj9Y
 i+JV0qQxBZjRYe5QbUOGokbqbe+sTVEmhf8nxeXOW/U9kOUerchFCwvhHW/JL+uAcEAW
 zxMkcXEO8sOerGulxzrbp7t344XAyHVR21F5HVFVKqCjs+W98sNgGYWIRfgn0Ss51bRk
 x+fZNvUWmYMN2og4CFEpbCt9c2aEG4Eon4MGzqJ093nDGkXQOFedT9ZyrWjvRDZQn0OE
 Cf7Ypz18I5rDzq0dMDFt4hMrPq+6LP4IRxq/tkJAEBhRP6Z3zhQGMJWgQoLWvNvlJIr7
 k44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711399067; x=1712003867;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uc1ahUCprBaHdZDdyVFZVU+U0HnRN9wykSxCF4/416w=;
 b=aIbDienkUfweQ6D6kG972xqhxukTU5ggXjQ+l9Tz/KaFMMzDGlKrX9apTgRKaHanBy
 5XDzfJC/Vp0x95s8XzGkhrna7vpo4IO3DKhI7PYLO/o3KrsBQryMlzBrNe+y/pmlCQLL
 uSZHulPNtBN0a8rfZg5KxQGkTshSmLuRsSlPnXZ1VWBjRV7/8aJixd8F328Y6N4Ma6c+
 O728FvhNt9fyfWqgGLXLXz4s7sZ2J8Gj0/r7BVjl6t73p1gr3p8psa3h0LKJJGvYcg5r
 DeFJbQFStiwVi43TQjfDVDujzZW7cirjurbOXX0XTtDOgagaqSK19C4fTHma/vfFaPPZ
 XcoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7eOCqJvTfpfrDLTBYh3saHuMCstxKiA/hO4+M30LkHpTA22h6DpEg7oJFpi+0qj37Ozl24Ma1J3tk9UzCnLY3rklMjw==
X-Gm-Message-State: AOJu0YyEBGMiCnZIY+4LpGMNpI45JSPg7bPH1Bb440XFY97LskhJ78d4
 rLTwX6d+UjhDA5J2hEEHGtPZeIq6DsWoQsnn6oRhO2+zGWMWa/fz
X-Google-Smtp-Source: AGHT+IHKLPo2soxA5Y8VnFslGm7aTOgc7xTl+LdwptUZy9c+jD3wHh24dn988+a4A4dOp8c0NHJNUA==
X-Received: by 2002:a05:6a20:a11d:b0:1a3:c8c4:9c83 with SMTP id
 q29-20020a056a20a11d00b001a3c8c49c83mr4666973pzk.37.1711399067487; 
 Mon, 25 Mar 2024 13:37:47 -0700 (PDT)
Received: from frhdebian ([201.82.41.210]) by smtp.gmail.com with ESMTPSA id
 b7-20020a62cf07000000b006e6aee6807dsm4750225pfg.22.2024.03.25.13.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 13:37:47 -0700 (PDT)
Date: Mon, 25 Mar 2024 17:37:42 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>,
 u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
Message-ID: <20240325203742.kan3xp5i3aqcd5ve@frhdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DXy8nuVPx-8uSpcVvyLFSb++S6ad64Gg0MWM3guxGZvw@mail.gmail.com>
 <20240323143454.GA3442575@bill-the-cat>
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

On Mon, Mar 18, 2024 at 04:46:55PM -0300, Fabio Estevam wrote:
> Hi Pierre,
> 
> On Mon, Mar 18, 2024 at 4:35 PM Pierre-Clément Tosi <ptosi@google.com> wrote:
> >
> > The implementation of map_range() creates the requested mapping by
> > walking the page tables, iterating over multiple PTEs and/or descending
> > into existing table mappings as needed. When doing so, it assumes any
> > pre-existing valid PTE to be a table mapping. This assumption is wrong
> > if the platform code attempts to successively map two overlapping ranges
> > where the latter intersects a block mapping created for the former.
> >
> > As a result, map_range() treats the existing block mapping as a table
> > mapping and descends into it i.e. starts interpreting the
> > previously-mapped range as an array of PTEs, writing to them and
> > potentially even descending further (extra fun with MMIO ranges!).
> >
> > Instead, pass any valid non-table mapping to split_block(), which
> > ensures that it actually was a block mapping (calls panic() otherwise)
> > before splitting it.
> >
> > Fixes: 41e2787f5ec4 ("arm64: Reduce add_map() complexity")
> > Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
> 
> This fixes the boot regression on colibri-imx8x.
> 
> Thanks a lot for your fix!
> 
> Tested-by: Fabio Estevam <festevam@gmail.com>

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Verdin AM62

On Sat, Mar 23, 2024 at 10:34:54AM -0400, Tom Rini wrote:
> On Fri, Mar 22, 2024 at 04:33:03PM -0300, Fabio Estevam wrote:
> > On Fri, Mar 22, 2024 at 4:31 PM Fabio Estevam <festevam@gmail.com> wrote:
> > 
> > > As Pierre's explanation addresses Marc's concern,
> > > do you think this can go to 2024.01 to fix the boot regression on imx8qxp/8qm?
> > 
> > I meant 2024.04, sorry.
> 
> How much testing has this seen outside of imx?

Tom, I tested with the AM62 TI arm processor (Toradex Verdin AM62) and
it works fine.

U-Boot 2024.04-rc4-00001-g5db2e36c8e97 (Mar 25 2024 - 17:28:20 -0300)

SoC:   AM62X SR1.0 HS-FS
DRAM:  1 GiB
Core:  138 devices, 29 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from MMC... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Model: Toradex 0074 Verdin AM62 Dual 1GB IT V1.1A
Serial#: 15133548
Carrier: Toradex Dahlia V1.1C, Serial# 10952631

I've added my Tested-by as well.

> 
> -- 
> Tom

Best Regards,

Hiago.
