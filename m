Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95885CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1658081E18;
	Tue, 12 May 2026 08:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="YqPixE5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65C583015; Tue, 12 May 2026 08:10:13 +0200 (CEST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A476D80F0E
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4gF5mJ60KVzyQK;
 Tue, 12 May 2026 09:10:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1778566209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx7vPc//TpH1AnelFKDbUCbV1muO5aQQD7oa1ofPn+E=;
 b=YqPixE5eeZjKIDPkTqfV4ITVlJcCfUIG9m40A0c13YWpAtXDc/P8AVeLPraR927wuD4wJj
 FNvsCy5q8w8VCsCf/ygvEjQjMrQCH5J2Ivu1fTc6fvAFtFriXFARYIOpovFlvLpDXr20LH
 ZOadXXXsEXO6W9cnz9ls3TtbOsZ4+bs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778566209;
 b=nsNicAXo7vh7idRUtVPO0+Pwd+225MjFmG8jE6/Wlvt2qbtM8fsmS4+34WBdUK3Lkw75Yb
 x9CjbYVYKZ2jT9/CndZG/fHmOAMLTc3MQ5dHi9clccu8kdYP2N1y/TGZrY0EEndLsBkmjP
 CMO176k6Cxi4oiHYRO3TEXKC2KTqIQw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1778566209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx7vPc//TpH1AnelFKDbUCbV1muO5aQQD7oa1ofPn+E=;
 b=ZjgVo5ct53wFAbq87G0L2400dAfCStr3Qvdy/uRLRo94+PISgJfPq7pT3t1FTe8/Jis8xl
 b/phE496Rh6qIW8O88/IssHxxfUxiactAX+LSMkA8gdBT+pU5AHOFUwA3O1LQ29Cj/YWy3
 iVbuDbHbq9NdfYakh2BMG+uOKP8aHo8=
Date: Tue, 12 May 2026 09:10:07 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <agLEP74BpPCIFbrd@kehys.lan>
References: <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <aeOdF46Ny1AfNsMi@kehys.lan>
 <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
 <aeTeiZER1IJar_w6@kehys.lan>
 <CAOCHtYin=6r86ThsagZrdFu5+_b2ACGmMZs3yK3tPd45PXJw4w@mail.gmail.com>
 <aeZubllYVLLpznWr@kehys.lan> <agIcJSyF5vf99ouY@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agIcJSyF5vf99ouY@kehys.lan>
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

Mon, May 11, 2026 at 09:12:53PM +0300, Marko Mäkelä wrote:
>U-Boot 2026.07-rc1 (May 11 2026 - 17:58:12 +0000)
>
>SoC:   AM62X SR1.0 HS-FS
>Reset reason: POR
>Model: BeagleBoard.org PocketBeagle2
>DRAM:  448 MiB (total 512 MiB)

I tried applying this patch series to the U-boot release tags v2026.01 
as well as v2026.04. On the former, the compilation would fail due to a 
missing file:

arch/arm/dts/.k3-am62-r5-pocketbeagle2.dtb.pre.tmp:15:10: fatal error: k3-am625-r5.dtsi: No such file or directory
    15 | #include "k3-am625-r5.dtsi"
       |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:421: arch/arm/dts/k3-am62-r5-pocketbeagle2.dtb] Error 1

On the latter, the boot hangs just like it did on top of v2026-07-rc2~5 
that I had used last night:

U-Boot 2026.04 (May 12 2026 - 05:40:25 +0000)

SoC:   AM62X SR1.0 HS-FS
Reset reason: POR
Model: BeagleBoard.org PocketBeagle2
DRAM:  448 MiB (total 512 MiB)

When I built v2026-07 and this patchset (exactly the same source code) 
using the build_u-boot.sh script in 
https://github.com/beagleboard/u-boot-pocketbeagle2/ instead of my own 
code I got some panic output at the crash point. I tried it 3 times and 
got similar output each time. I did not check how the build options 
would differ from my own script, for which the boot just silently hung:

U-Boot 2026.04 (May 12 2026 - 05:54:06 +0000)

SoC:   AM62X SR1.0 HS-FS
Reset reason: POR
Model: BeagleBoard.org PocketBeagle2
DRAM:  448 MiB (total 512 MiB)
PANIC in EL3.
x30            = 0x00000000800047f4
x0             = 0x0000000002860000
...
sp_el0         = 0x000000008000c520
...

Could it be a stack overrun or a clash between heap and stack? There are 
several register values pointing to higher addresses than sp_el0. Should 
the stack pointer be initialized at a different address?

Best regards,

	Marko
