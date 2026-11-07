Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32896606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uFmlPGw+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPJFZ8Xf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA244072E;
	Sat,  7 Nov 2026 17:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKI6p51h1mYq; Sat,  7 Nov 2026 17:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD6A9406E7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794073944;
	b=ZSWe5tzqpLy6Hhb0RdXFasH0cT0n1cwtgNMRTqU8feRHGuyKdBgn4Ta1PXqdlVVGkPEI
	 oTEBXE+ROt1r5r4tZfjFHM22fSBFHQMJdbbpzEIymT31DxtrBb7E/US8rEfVCz/Da2X9K
	 ctfCzx1yIx2q8OQxAP6vc4a1Ckc/B26YPNyyVbrYQB2ExDyXVy6+PWk4k9yfWT+eMtQx1
	 hrd7d/Np/GcLtdvBl5DJXqIVKuMoVnTkC2TktLqggSrpbQ5eF1kFxi93iXSTXSRb3O2fu
	 pQ6w/u7fw8Xzfhb9nJXGF1a/2QH9q7u5rjQBxiAUwnnJ+FiBoXtmAQdCwFOUJUH0HjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794073944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BXg7ACQ90KocIjkSTQ2j5Naf/WYeqyJHe941GHeXiUw=;
	b=S78u3PW0ipm/gEhMU4Tir3Dxmsh9aSKG0xGQ2xztOuvvmMNt1gKYbis5ntGWpLHmKqy3
	 HVLqV6G89NA/am/efXwc+EiHrQj8Wk6ApQP9DImTmrArgv60YOXgrbBbruZ9IgkFsW4iR
	 oIa8yWb6jrtGWZZ2MiWi0wFdtgqBL128lg/V5L+Y0vQ70+jPK+/Wp0Xb47y/wLR4wlJSn
	 JPJVRNnXDLctM5wNr1PijGKRSGx2Ky55DAf5FxKLoOPVPJ2EwxDNpJbeS/UWqhvqSgEzW
	 amKmNXNk1Ekvrg1Rx2QS2N2E0RheAiFwICln9k/7cilceqVQhvsTBH5nhLEUGfdcLWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPJFZ8Xf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794073943;
	bh=BXg7ACQ90KocIjkSTQ2j5Naf/WYeqyJHe941GHeXiUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFmlPGw+kR2pnuPfoV6YjWmaZBrXwsxkU1YBUcp6BVqJIm8ucn9qeB3XLXZJKaSEz
	 q5yNaVkegdWFyaUxUeN6mTuUSx6xOb56ygJPtuTAP3mlmivC3GHLUgM9UqkEfq7MIs
	 WATTOuwgbh5gkfq5IWNVn0Xg0OMHNpsv5BmKFi9TJwRA5JJ0eWvAwrcV6RtvDlK9wJ
	 fXlN2Fcvcae66ENIScPsprX6l3qOwnZzyZ6gWyzvIy+Nfu1ClZAs6dUWiSGEv0F+zN
	 bWHN+4rUgLE0Xh+asJ0Ngv2ETAcOEHs+24Ash/rliha+fDeMpgjUDA0iQyyRC7lJTp
	 xVGO07ah0LhPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD6A9406E7;
	Sat,  7 Nov 2026 17:52:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAC82211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC9C7406E7
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-LAOIbO8-1Q for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 17:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0ECB406D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=lPJFZ8Xf
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0ECB406D9
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 17:52:20 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-36fb88ea38cso782733eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794073940; x=1794678740;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BXg7ACQ90KocIjkSTQ2j5Naf/WYeqyJHe941GHeXiUw=;
 b=lPJFZ8XflaAjrzsVP/hu60cnSpI1ejewp3VViY1emKZTLgZK1UzNeVPuz7tCGOSPJk
 fjpQZZc7HWAT1xAMksORbeNk82Z5+m/mLF7HG/LFjr8PQ6PfJnFM98OkKL6/8Hu/Z0Xw
 4ZZ9VYHFRmy2MN3lvLVORPUgsoiOnVVlLisVNzoHVOyKTzkyoOQ/czK3W3zfxgwDljPM
 oyRJ8AYeV0gqJJbRkcb1RXD98MHH5zCXRVMJzX7/6nLtWkhpEB3iWg/UGvG29UDMRg0x
 mMMOy0weKLgY3tuNaS5CIDd5CNWMp2g6lpYrW9bJmkAF+0autc5+k3BDyfAszf8h18Kf
 UTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794073940; x=1794678740;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BXg7ACQ90KocIjkSTQ2j5Naf/WYeqyJHe941GHeXiUw=;
 b=qD0blEqE5bZif8B1Zoeo1QbQPWqjHA3nnpoP9S4502yQ0E4NVAMTH4LxHIlLdo/7K8
 wCd3qrGEyAXRdwRtGNLJ3R7QR1rSTzfmO/xioRBpVytM4NUTU5AkwTMXfGLVQM/NIioG
 6Ita1UijrDNcIZTd/N1eGSUqqT6OUkC5lld6bferXx16vJAIBENrdeb2YIvIxpTxzSwt
 cjMlrEYIJHpOFHFiW3fp6gXKYhH0Mn7WQmBagbUrDpH48Caz34atLrxCumEezEzSvv7G
 YkW3cPKP+44brf/OIZXmXBdxndKsHVkL91TQadZeuY9mom8kERDP0huQ+KpPEJj4vxeE
 yPWA==
X-Gm-Message-State: APuU4Z+MdkNiVyaN2hiuJmR1BlBoa2M1fcRiUoqVJI7YwkYziviG6H08
 VNRrKj6KJKnagFpvrm3lJ4M+2jVMKhQJyEWFkoOVhe0kaljy15TlvnDu
X-Gm-Gg: AYBFou0S3o3CVUg16l8wbYYOOJFCgTWmJb1RnOoeBbxQoy8YmxcEw3zoWG29hXpjbnQ
 9syUHbvFXjmALtvHNsVygUJUEI+h2MfeIKfDJzj924Sb6zWhMO2IAFhAkrQKWkw3seOrqNBqj0e
 AACENusaqPgTE4h8U9BYXVIz37nCiRM05KhI9T64pjz5+LpYNN1w05us5l2FTj1tou+ZVhcNDKi
 jeXS5/kHKcaz5cW+Xto8VQsic4HShyU5Tpd3ymYTUe3DweokS6npwLMK7eIHG1niQBCyFMVRMr6
 1Dr9+eyiGX61laSPxeMq+O0UtueEfPZXVrlhYxWeUJQvhRpXchEv5jKJuw9Oxj+SBxblUkjb9yd
 nA/Vm6ZsZ/BYChCnjnkso8kqRobFfOeXIk2SDmYpKkoHlmUoDAHV/AQswdz3neRImIzxhihwsYK
 Gs7gB/WkOv8EfHuqX53Gz9P4uwBgfWZWs4eAJe0Q+hZnkqbU0eSv5EeQWcH+VtwOl2oNKyE0Yp3
 Dr40bY75fljgwwRuezkgxs+5Ia72uzgof8O++1lb8kdQcdAGru+pZfLDd+rxLbSlZRt9tk5OMwO
 v7LhYZmqtHfIafkhZWxcFTOn6kZBEpmKhJay5nUyaFw=
X-Received: by 2002:a05:7301:460c:b0:36c:a26f:83c4 with SMTP id
 5a478bee46e88-370f68e715dmr3615832eec.13.1794073939327; 
 Sat, 07 Nov 2026 09:52:19 -0800 (PST)
Received: from jpg-duosnb ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa922b205sm18118244eec.11.2026.11.07.09.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 09:52:18 -0800 (PST)
Date: Sat, 7 Nov 2026 14:52:13 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Gui-Dong Han <hanguidong02@gmail.com>, 
 Joshua Milas <josh.milas@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, E Shattow <e@freeshell.de>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH v2 2/2] board: sophgo: Add support for Milk-V Duo S
Message-ID: <au9f753E44f-BY2T@jpg-duosnb>
References: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
 <20261025-upstream-v1-milk-duo-s-v2-2-192b68915c92@gmail.com>
 <auq1Pf0xDMoxRpXR@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auq1Pf0xDMoxRpXR@pie>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yao Zi,

> Personally speaking, I prefer to turn on EFI related stuff
> (BOOTMETH_EFI_BOOTMGR and EFI_PARTITION). Here EFI is more practical
> since Duo-S carries 512MiB RAM, and I do have a device booted through
> EFI.
>

I will add the EFI configs on v3.

> > diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> > index 19c9a19b1d4b..61aceafceea3 100644
> > --- a/doc/board/sophgo/index.rst
> > +++ b/doc/board/sophgo/index.rst
> > @@ -7,4 +7,5 @@ Sophgo
> >  
> >     milkv_duo
> >     milkv_duo_256m
> > +   milkv_duo_s
> >     licheerv_nano
> > diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
> > new file mode 100644
> > index 000000000000..9f6bf04d1842
> > --- /dev/null
> > +++ b/doc/board/sophgo/milkv_duo_s.rst
> 
> ...
> 
> > +Boot flow
> > +~~~~~~~~~
> > +The board boots from a FIP image, fip.bin, which contains the following
> > +binaries:
> > +
> > +- FSBL (First Stage Boot Loader): the vendor bootloader [1]. It serves the
> > +  same purpose as U-Boot SPL, but U-Boot does not support SPL for this SoC
> > +  yet, so the vendor FSBL is required.
> > +- Coprocessor firmware: the vendor firmware (cvirtos.bin) or custom firmware
> > +  for the C906L coprocessor. It is not needed to boot U-Boot, but it is
> > +  required by fiptool.
> 
> Please confirm whether this is correct. I remembered the coprocessor
> firmware is optional, too.
>

The coprocessor firmware is optional and is not needed to
boot U-Boot. However, the fiptool from [1] always packs an RTOS image.
If --rtos is not given, it falls back to a cvirtos.bin that does not
exist at that path, so it fails:

$ ./fiptool \
    --fsbl data/fsbl/cv181x.bin \
    --ddr_param data/ddr_param.bin \
    --opensbi fw_dynamic.bin \
    --uboot u-boot.bin \
    --text-base $((0x80200020))
Packing Param1...
Param1:    0x0
FSBL:      0x1000
Packing Param2...
Traceback (most recent call last):
  ...
  File "fiptool/fiptool", line 84, in pack_param2
    with open(args.rtos, 'rb') as f:
FileNotFoundError: [Errno 2] No such file or directory: '.../fiptool/cvirtos.bin'

Passing an empty file does not help either, because the tool always sets
the coprocessor load address in the FIP header, so the FSBL would still
try to load and start it.

The FSBL repository has its own fiptool [2] that can generate fip.bin
without the coprocessor firmware. When no coprocessor image is packed,
the FSBL prints "No C906L image." and continues booting. This is also
how meta-riscv [3] and the vendor Buildroot SDK [4] generate fip.bin,
so it seems to be the more correct approach.

If you prefer, I can document this flow instead. In that case the
documentation also needs to describe how to build the FSBL from source,
since that fiptool is part of the FSBL build.

[1] https://github.com/sophgo/fiptool
[2] https://github.com/sophgo/fsbl/blob/sg200x-dev/plat/cv181x/fiptool.py
[3] https://github.com/riscv/meta-riscv/blob/master/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl.bb
[4] https://github.com/milkv-duo/duo-buildroot-sdk-v2

> Regards,
> Yao Zi

Best Regards,
João Paulo Gonçalves
