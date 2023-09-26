Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B088E7E626
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CD286BEB;
	Tue, 26 Sep 2023 13:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eCDXe6iH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF3A86D3E; Tue, 26 Sep 2023 13:37:49 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB3486D47
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5031ccf004cso13935085e87.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695728266; x=1696333066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJI+Kkqgt7y0uBDfjAQTFjOWJx1bu2M3KDKSS63IaQs=;
 b=eCDXe6iHSGrBD0eHRrfCruBxOFYNDAM/wzmg5ANpV6Lp/eLW8LOgdCbInVwQUSNKlN
 CQIhydnNoFEpF8+xvxCxllHWyiqkXSxrTM/nol41lkeqHWAavNkh5fcjXlwrWW942Qdl
 V+6e+/a+hzRO77EQzngXiCnvyrA1xr6IdUzpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728266; x=1696333066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJI+Kkqgt7y0uBDfjAQTFjOWJx1bu2M3KDKSS63IaQs=;
 b=TeA8xVRKmz9UO263hUkkUG+KsXL56rmU9depoWJcJy3ht/gplRlPy8sTdCOGeQvg0D
 onNE3rNxmQGLzaQhnxGI8lUi5ctETmn+nmUG9ElaWSA2CZeCKhC/XFNG5n0mEnkPBbPL
 sXt29tbEWQKsVx3QEusvdfk0E128uSLDc3cjEw7riEzw+P54A42dM0FuJGrgmS+b3RoR
 /g7AmQsWfxW406rLSgsN29xBkJRRbcU9HKHyyX2/JGIjE6rjdrjwcjgnK6gZJBYQri4d
 F/5ChsOiFfQ/11VoK3ahhVXuHUclZ3fHtoMy6dSKvVmgOkcf6LUPiDfomWFpkyWQatAY
 gVkQ==
X-Gm-Message-State: AOJu0YwuynLOy41JTn0zCFcwsqelntwIjVhVroz47nvEzlkgH3vrkOIk
 xSf5HJS1n9tGZ+9zE+9/cGUdcH/LAAFTX0sJhMnHPA==
X-Google-Smtp-Source: AGHT+IH6Tp3dDpuNgFjscy9AulRque/VIGvPdVZxg/NNCuCTa8gfACMVpLDN61AwgagOR0//zZw2s4398Wlt+nODk/w=
X-Received: by 2002:a05:6512:2245:b0:500:a66b:b189 with SMTP id
 i5-20020a056512224500b00500a66bb189mr11269094lfu.51.1695728265796; Tue, 26
 Sep 2023 04:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-39-sjg@chromium.org>
 <20230925201709.GP305624@bill-the-cat>
In-Reply-To: <20230925201709.GP305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Sep 2023 05:37:32 -0600
Message-ID: <CAPnjgZ1_i1ehK055tJHDq2uAFRpu1BHsUrwVucZ2R2Upt9GPEA@mail.gmail.com>
Subject: Re: [PATCH v3 38/38] pci: serial: Support reading PCI-register size
 with base
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Suchanek <msuchanek@suse.de>,
 Nikhil M Jain <n-jain1@ti.com>, 
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <sr@denx.de>, 
 Weijie Gao <weijie.gao@mediatek.com>
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

Hi Tom,

On Mon, 25 Sept 2023 at 14:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 01:25:23PM -0600, Simon Glass wrote:
>
> > The PCI helpers read only the base address for a PCI region. In some cases
> > the size is needed as well, e.g. to pass along to a driver which needs to
> > know the size of its register area.
> >
> > Update the functions to allow the size to be returned. For serial, record
> > the information and provided it with the serial_info() call.
> >
> > A limitation still exists in that the size is not available when OF_LIVE
> > is enabled, so take account of that in the tests.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> So on platforms that end up here, we see consistently:
>             eaidk-610-rk3399: all +224 spl/u-boot-spl:all +224 spl/u-boot-spl:text +224 text +224 tpl/u-boot-tpl:all +224 tpl/u-boot-tpl:text +224
>                u-boot: add: 2/0, grow: 3/0 bytes: 224/0 (224)
>                  function                                   old     new   delta
>                  fdtdec_get_addr_size_auto_noparent           -     124    +124
>                  devfdt_get_addr_size_index                   -      72     +72
>                  ns16550_serial_of_to_plat                  316     328     +12
>                  ns16550_serial_probe                       132     140      +8
>                  ns16550_serial_getinfo                      84      92      +8
>                tpl-u-boot-tpl: add: 2/0, grow: 3/0 bytes: 224/0 (224)
>                  function                                   old     new   delta
>                  fdtdec_get_addr_size_auto_noparent           -     124    +124
>                  devfdt_get_addr_size_index                   -      72     +72
>                  ns16550_serial_of_to_plat                  316     328     +12
>                  ns16550_serial_probe                       132     140      +8
>                  ns16550_serial_getinfo                      84      92      +8
>                spl-u-boot-spl: add: 2/0, grow: 3/0 bytes: 224/0 (224)
>                  function                                   old     new   delta
>                  fdtdec_get_addr_size_auto_noparent           -     124    +124
>                  devfdt_get_addr_size_index                   -      72     +72
>                  ns16550_serial_of_to_plat                  316     328     +12
>                  ns16550_serial_probe                       132     140      +8
>                  ns16550_serial_getinfo                      84      92      +8
>
> Can we optimize this in any way? I'm less concerned with full U-Boot
> growing by 224 bytes than I am by TPL growing by that much too.

One option would be to have two functions in each case, one for the
address and one for the address + size. We do that in some other
cases. I have to admit I somehow didn't notice this large size
difference, although I knew it would have an impact...it is so strange
how the compiler changes what functions end up in the image willy
nilly.

Regards,
Simon
