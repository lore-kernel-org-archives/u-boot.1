Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168DAC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AB987E26;
	Thu, 15 Feb 2024 21:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QczA3iZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C433D87DF8; Thu, 15 Feb 2024 21:44:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFE487DEC
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708029889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ivIOCzwMFmYI7jjd/VU64gubxtfSp6+gFPI5ZLDx6g=;
 b=QczA3iZc84LfWQOSVHHYbP84u89Kp3Uoi2bYC8GrT0oJtShEcP9FNTHeuL8Rros/1vI4l6
 OqlI2iJ1xgNbxUDVaY/eKJuLNrGsivyx3WIi0TSm4emq/zf8pcvk+ZRcddKhezCcrly3kH
 UC5dAEa84eMFI1kSOF/wU2coEJSjXeo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-S7_LFB4CM0CWzqe_pnqOyA-1; Thu, 15 Feb 2024 15:44:48 -0500
X-MC-Unique: S7_LFB4CM0CWzqe_pnqOyA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68f00966e27so11520866d6.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708029887; x=1708634687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ivIOCzwMFmYI7jjd/VU64gubxtfSp6+gFPI5ZLDx6g=;
 b=WJ8tSDgBDbgU/XcaLwPtmgmBchCcUedHwJQOMBUzhqumLkHv0e7B/dsNRpmknKZyz9
 mG5XxUW9jIXYwCtavwe6jCowm0L6R7mBGvybuYc6Ps7Q+nKRnfUDhB3XBQihnSm4q2IF
 C6xtaMgP0leJsXjCtjWFEpBHuhris/H5b0FwXsqp6W+sxCihvLvhKFMtEf2ud4kQdt7J
 iJtGLlnUQS9kcBGLglnFBua5GB2aMA0V7gN2m6jji7hDay7X9GajRfnSNcJG8cozSYoa
 O1f4n3YG6PbWhOfcyDyZLhl+bLcS9sqFUj9catwnlCdl1pjTAsqJ2xWysUEq6SpM18ye
 wfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIrFxKK9fEbEfcyequ+bMViO0ppAlhkPd/nYhedy/7VgleE7Ki9T09QcnoO0sIldlsOs+/+r+CHrj7OYMpt0ULowVFpw==
X-Gm-Message-State: AOJu0YzT2VYdEjw2peJU0gIAWh3+PzjKOOrq0iW5s5MkuCblpvgtsWuZ
 JPlBTCNVDVvmj6l1q96sADyoIQcNEGz2rCt5pGCExuLccmCMvM9+gKV5RIIvCwyGIQKUT+33B0W
 cckpWVIPBekjRxiTYX1/cdN6iLphe+grXy9aNUickkaMuTFSO5Qc=
X-Received: by 2002:a0c:f349:0:b0:68c:b694:2f05 with SMTP id
 e9-20020a0cf349000000b0068cb6942f05mr3070127qvm.2.1708029887690; 
 Thu, 15 Feb 2024 12:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIQT3xr3fzHRbx4iy36VJbFU9hHY1w8C47XzBRWOWmjhEAgwFbicvD2THmQI12rAOrsx+jWw==
X-Received: by 2002:a0c:f349:0:b0:68c:b694:2f05 with SMTP id
 e9-20020a0cf349000000b0068cb6942f05mr3070107qvm.2.1708029887359; 
 Thu, 15 Feb 2024 12:44:47 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
 by smtp.gmail.com with ESMTPSA id
 lh5-20020a05621454c500b0068ef8db01e4sm1024858qvb.40.2024.02.15.12.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:44:46 -0800 (PST)
Date: Thu, 15 Feb 2024 14:44:44 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v8 16/16] doc: board: ti: k3: Add J784S4 EVM and AM69 SK
 documentation
Message-ID: <5lgshkyfxnvxt6okk3yooxjwks7bqtc2u5k5o7wzmorgxs2jwh@qylsklcedwp2>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-17-a-nandan@ti.com>
MIME-Version: 1.0
In-Reply-To: <20240119175043.3904751-17-a-nandan@ti.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 15 Feb 2024 21:49:48 +0100
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

On Fri, Jan 19, 2024 at 11:20:43PM +0530, Apurva Nandan wrote:
> TI K3 J784S4 and AM69 are new additions to the K3 SoC family.
> Add documentation about the J784S4 EVM and AM69 SK.
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  board/ti/j784s4/MAINTAINERS |   1 +
>  doc/board/ti/j784s4_evm.rst | 299 ++++++++++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst         |   1 +
>  3 files changed, 301 insertions(+)
>  create mode 100644 doc/board/ti/j784s4_evm.rst
> 

<snip>

> +
> +Switch Setting for Boot Mode
> +----------------------------
> +
> +Boot Mode pins provide means to select the boot mode and options before the
> +device is powered up. After every POR, they are the main source to populate
> +the Boot Parameter Tables.
> +
> +Boot Mode Pins for J784S4-EVM
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following tables show some common boot modes used on J784S4 EVM platform.
> +More details can be found in the Technical Reference Manual:
> +http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
> +
> +.. list-table:: J784S4 EVM Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW9: 12345678
> +     - SW8: 12345678

According to spruj62 I think SW9 and SW8 are supposed to be
SW7 and SW11 respectively?

> +
> +   * - SD
> +     - 00000000
> +     - 10000010
> +
> +   * - EMMC
> +     - 01000000
> +     - 10000000
> +
> +   * - OSPI
> +     - 01000000
> +     - 00000110
> +
> +   * - UART
> +     - 01110000
> +     - 00000000
> +
> +For SW8 and SW9, the switch state in the "ON" position = 1.

Referencing more from spruj62...

SW8 is a push button for a user defined interrupt for wake up (I think),
and SW9 is the main domain warm reset push button.

I'm not sure either of those are what you're trying to highlight here.

Love the TI documentation by the way, it is very nice.

Thanks,
Andrew

