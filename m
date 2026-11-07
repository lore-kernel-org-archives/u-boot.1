Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1A606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xDrtVvrs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Ov8vgVfZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC97960602;
	Sat,  7 Nov 2026 18:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t0STXvfL7Uj5; Sat,  7 Nov 2026 18:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE6506064F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794076385;
	b=QKH2dZOYE9KL8a2M42fTDwFH6SlDVd8T4kQXHHKYqp90qIdexJ0LFILi8L/NImyVKDpu
	 Q0tpqATHCWMDRArDxRrQsJbhIgE8B677UahLF266rPPGD8+qatrMWFIf4P2AToF4BE+jT
	 S22JgwO/9RA8BY+cvblP71UbAK5LYP5HnWZTX+6p0wCQz0X/bkfts/vKe77g6TXdGvKwV
	 5MnZ71lJsW2lYgmf9dT5RC8O0s/rH4VtjxLj6vqYdALnaBdcGRwnWfSRzzq7i2qXgrtIt
	 xBqZk/conc6ZBBcRrKZoIhGHs1f4Gk4NojwVZmh4Ny7LIZMqNbDnGzrDIoFInKd3FWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794076385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QXXewgjcQyFyE9s9StLq9N3KbTnRvLTurINPTu+yhdg=;
	b=Rr+IzyhXsn0HkgZlKZIwKHPglSi2463no+huCNyr4UU/eQY0nzxnKB8ThIffVp1wZayl
	 bLcIfUw7ErHJ6UA7GwpqceZZOr2ij9qOs8xiMMki7g4sxC+SnYybR1BIAtCkwxwmXSit1
	 CjY0X7Tx8PBLVWqNgfJOmE+lShVs3+bGoBzL2f0H3MW+jV2yCmo8tJUwRTHZTQv9hbZ5+
	 vmJ+zmuvAl+q6XXzle7CgZQqTH+3bIOTaZBunxWVgUYt+cMUfOpq+1SzI+6YqcqF+bYFj
	 8KIHVe4ef9I/WVVSiZ6f0NCDo2bYvWcRR0YNGZY30ihFYiXehZSNT4PKuWVvq8e19jg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794076385;
	bh=QXXewgjcQyFyE9s9StLq9N3KbTnRvLTurINPTu+yhdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDrtVvrsAgLkommD7rTRgxZye6x8HIIxm3LFZXqErcTVGUg8yu1RsCL4rfzffLMFn
	 HqbLtVLA/LUp+VFIDSTG2SDj1XcEJOj91DsvFd7wPYwKZmDolBFFbOk35XvwtUozJ/
	 6GPh2bzZZtfsLa4S0cYyjvDOPZxaFFl6LOpq+bhg7IC7ieVdZ3anmDr95HjB42lcyl
	 XSvrF/t/hPiLwBE51kHOCA/GLmBp0SzJvm76zpWahZmpKEsRirZWbyENK2JFDqxgLS
	 NN3dZfA29cTqj783CzY9G1Y+VnUpajv0kuP3cKh3nsRI9demzBZBKtou4WVFpSZZ4C
	 K4Lxh8SN70Vxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE6506064F;
	Sat,  7 Nov 2026 18:33:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28AFB32A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 18:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E307400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 18:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXm90NZi6vX4 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 18:33:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70F8B4009B
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Ov8vgVfZ
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70F8B4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 18:33:01 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=Ov8vgVfZSBIh3JNTbfl4yEJ+i9WKDC3rqdCzYUVXQPqrQbDPyes62k11R4WeCl3hjK1Y0vvRYmFdJPuMNCik/zpz9jw8tSD7fwAlA2nOZJD0UlAJcQzeNtCpZlGE5d/cCi+0tHJ+oVJYmrjTKFRU9SdVyxKuDODUPViRLvgYSnA=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=QXXewgjcQyFyE9s9StLq9N3KbTnRvLTurINPTu+yhdg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17940763585768.661681667126231;
 Sat, 7 Nov 2026 10:32:38 -0800 (PST)
Date: Sat, 7 Nov 2026 18:32:30 +0000
From: Yao Zi <me@ziyao.cc>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Gui-Dong Han <hanguidong02@gmail.com>,
 Joshua Milas <josh.milas@gmail.com>, Chen Wang <chen.wang@linux.dev>,
 Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@kernel.org>,
 Andrei Lalaev <andrey.lalaev@gmail.com>, E Shattow <e@freeshell.de>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH v2 2/2] board: sophgo: Add support for Milk-V Duo S
Message-ID: <au9uvm_HtLyvI3C1@pie>
References: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
 <20261025-upstream-v1-milk-duo-s-v2-2-192b68915c92@gmail.com>
 <auq1Pf0xDMoxRpXR@pie> <au9f753E44f-BY2T@jpg-duosnb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au9f753E44f-BY2T@jpg-duosnb>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.65.33
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 02:52:13PM -0300, João Paulo Gonçalves wrote:
> Hi Yao Zi,
> 
> > Personally speaking, I prefer to turn on EFI related stuff
> > (BOOTMETH_EFI_BOOTMGR and EFI_PARTITION). Here EFI is more practical
> > since Duo-S carries 512MiB RAM, and I do have a device booted through
> > EFI.
> >
> 
> I will add the EFI configs on v3.
> 
> > > diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> > > index 19c9a19b1d4b..61aceafceea3 100644
> > > --- a/doc/board/sophgo/index.rst
> > > +++ b/doc/board/sophgo/index.rst
> > > @@ -7,4 +7,5 @@ Sophgo
> > >  
> > >     milkv_duo
> > >     milkv_duo_256m
> > > +   milkv_duo_s
> > >     licheerv_nano
> > > diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
> > > new file mode 100644
> > > index 000000000000..9f6bf04d1842
> > > --- /dev/null
> > > +++ b/doc/board/sophgo/milkv_duo_s.rst
> > 
> > ...
> > 
> > > +Boot flow
> > > +~~~~~~~~~
> > > +The board boots from a FIP image, fip.bin, which contains the following
> > > +binaries:
> > > +
> > > +- FSBL (First Stage Boot Loader): the vendor bootloader [1]. It serves the
> > > +  same purpose as U-Boot SPL, but U-Boot does not support SPL for this SoC
> > > +  yet, so the vendor FSBL is required.
> > > +- Coprocessor firmware: the vendor firmware (cvirtos.bin) or custom firmware
> > > +  for the C906L coprocessor. It is not needed to boot U-Boot, but it is
> > > +  required by fiptool.
> > 
> > Please confirm whether this is correct. I remembered the coprocessor
> > firmware is optional, too.
> >
> 
> The coprocessor firmware is optional and is not needed to
> boot U-Boot. However, the fiptool from [1] always packs an RTOS image.
> If --rtos is not given, it falls back to a cvirtos.bin that does not
> exist at that path, so it fails:
> 
> $ ./fiptool \
>     --fsbl data/fsbl/cv181x.bin \
>     --ddr_param data/ddr_param.bin \
>     --opensbi fw_dynamic.bin \
>     --uboot u-boot.bin \
>     --text-base $((0x80200020))
> Packing Param1...
> Param1:    0x0
> FSBL:      0x1000
> Packing Param2...
> Traceback (most recent call last):
>   ...
>   File "fiptool/fiptool", line 84, in pack_param2
>     with open(args.rtos, 'rb') as f:
> FileNotFoundError: [Errno 2] No such file or directory: '.../fiptool/cvirtos.bin'
> 
> Passing an empty file does not help either, because the tool always sets
> the coprocessor load address in the FIP header, so the FSBL would still
> try to load and start it.
> 
> The FSBL repository has its own fiptool [2] that can generate fip.bin
> without the coprocessor firmware. When no coprocessor image is packed,
> the FSBL prints "No C906L image." and continues booting. This is also
> how meta-riscv [3] and the vendor Buildroot SDK [4] generate fip.bin,
> so it seems to be the more correct approach.
> 
> If you prefer, I can document this flow instead. In that case the
> documentation also needs to describe how to build the FSBL from source,
> since that fiptool is part of the FSBL build.

Yes, please do so. This sounds clearer.

> [1] https://github.com/sophgo/fiptool
> [2] https://github.com/sophgo/fsbl/blob/sg200x-dev/plat/cv181x/fiptool.py
> [3] https://github.com/riscv/meta-riscv/blob/master/recipes-bsp/milkv-duo-fsbl/milkv-duo-fsbl.bb
> [4] https://github.com/milkv-duo/duo-buildroot-sdk-v2
> 
> > Regards,
> > Yao Zi
> 
> Best Regards,
> João Paulo Gonçalves

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
