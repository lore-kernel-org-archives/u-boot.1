Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891E8C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AA886940;
	Tue,  5 Sep 2023 10:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2TuZY6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DDF86942; Tue,  5 Sep 2023 10:37:36 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCE98691E
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50091b91a83so3703244e87.3
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693903053; x=1694507853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jKJCRVryM1hwl+GV7upDy+MDJH+r+LJQQo46g5zH1fI=;
 b=j2TuZY6T8YmR+qXRiosKXYeBaq6x1/4e40cAG228u/fzqKDoXzXrDDlHRTt5lrAChu
 gh/0G8328p70OIgAar6s6WDKfF78KT19noNC1lxou86NYjCD/sG0S4dWJOpRGrdpQUUv
 AX9s+eh2ibdyg+6ykEacynV+OFw3UGKc+Uc0Nwvl/RaepqPw0vRSKe+UYdG43q032Aer
 e5OsdoAcFtoAF7S0X0cV7VMsmeMpTyBt2LN1vLIPQc99MTKoZFJ5uEK4GjpaP60Fg4xO
 Gvb0sEyQQBNXagYJKtbRwtZrYeWnwOdRibF3XrPW2v8886Tu/RqrsbZy2vOlMRoV5Ed5
 Vxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693903053; x=1694507853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKJCRVryM1hwl+GV7upDy+MDJH+r+LJQQo46g5zH1fI=;
 b=ajDOxpLs6h4JnsXa0PHc4dFzwWdN9zV8Nfm1taejjvWrPX814VJqJeb06UQjNisMPa
 C+Y8aWb5HdeHhDVH6d8D0V+8jg9vOqTFEBNWYI01391hd+65uCaLE9z8aG9iw28kZvQI
 fMIP4sqD128LDn+T9Oxax5vedzeHKwWsk4ZoaWbn6ORjnN702mlbNQ3eCJ0pd94F0WxK
 BmkDLH4PZEdFYPqynrb19XqnsiRc+cxGb4V3pqVfGAN+phFTcn+w9Q91r9oVYN8sTvTV
 T7nzqm6ISAr9LA3xlFpa5FweGTNAAFRRu3DVPItSeAuXE6HEeFn/yCCXU0VvaIAdCfvq
 74xg==
X-Gm-Message-State: AOJu0YxhrS9MC2it+RIxgh2Lwy4/3d55aK7IYt9JUayXEA90Ej2rC9Cz
 BaIfzx2JTzT2Jwxwbh7yHF4=
X-Google-Smtp-Source: AGHT+IGhw/PURPaA7lJgScsWGnYNxv7AWF+Cz5KHO+vKz0XGi2ChZP7jW1sy9AfxQQLrkr8iYcQXVw==
X-Received: by 2002:a19:9104:0:b0:501:bdd4:7e05 with SMTP id
 t4-20020a199104000000b00501bdd47e05mr890276lfd.22.1693903052622; 
 Tue, 05 Sep 2023 01:37:32 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a19ae0a000000b00500c8402aaasm2233371lfc.152.2023.09.05.01.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 01:37:31 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:37:31 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>
Subject: Re: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Message-ID: <ZPboy228t8rVajL8@skv.local>
References: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
 <20230905092712.6ba245bb@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905092712.6ba245bb@donnerap.manchester.arm.com>
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

Hi Andrey,

On 23-09-05 09:27, Andre Przywara wrote:
> On Mon,  4 Sep 2023 23:54:30 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> Hi Andrey,
> 
> > When using SCPI as the PSCI backend, firmware can wake up the CPUs and
> > cluster from sleep, so CPU idle states are available for loaded OS to
> > use. TF-A modifies DTB to advertise available CPU idle states, when
> > SCPI is detected. This change copies nodes added by TF-A to any new
> > dtb that is used for loaded OS.
> 
> Why do you need that, exactly? Why not just use $fdtcontroladdr for the
> kernel? We now keep the U-Boot copy of the .dts files in sync with the
> kernel. If you need to modify the DT in U-Boot, for instance by applying
> overlays, you can copy that DTB into a better suitable location first:
> => fdt move $fdtcontroladdr $fdt_addr_r
> 
> In any case, there shall be only one DT, that one in the U-Boot image. Why
> do you need to load another one for the kernel?

extlinux is used by distributions (sometimes with device-specific changes especially
for platforms not fully supported by mainline yet), then U-Boot loads DT defined in
extlinux.conf file. u-boot scripts are not used in case of extlinux at all.

-- 
Best regards,
Andrey Skvortsov
