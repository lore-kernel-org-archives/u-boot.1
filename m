Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA59C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 15:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94A56406B3;
	Wed, 29 Jul 2026 15:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 08n5fiu1KqjE; Wed, 29 Jul 2026 15:17:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAD19406C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785338246;
	bh=9ymNKiUunO7j1WBad5j5UwNjevtkYJNpkRW+srKw4Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BD7coH5UK2bcU2GR2XnUxabBTGXjnKN7R6/4FoXjtl8MX5eyX/wbJUslnAnjBqUpd
	 lwhxu3nU1XWtncS2QWKsPixuKcEIpJHyXjnFoHIHz/GCb0yb65+BFBqXTR2gtBLYr7
	 CUpuSz2Ptk46Hx0TTO28PM5eA+JGj44vZ6H2iYkhaGwUxiqQ91afZsbXdDHyL9WMXc
	 Yr9FayRvkOl8yAMFwutiTwuhHTnoEJQoZPa+lK1JW3ugjmb7WdYyNjY49BFHSxDlXf
	 JrfGEbS44GVjjioAZBNQePhDmj24ALBWCsQFluztBJgmpdpKj1F7ilkh6K8WmBst9j
	 aCJcj85ZyzACw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAD19406C6;
	Wed, 29 Jul 2026 15:17:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94BB3788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86AD680EB0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nhr7oz9sbiK2 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 15:17:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C2A7F80E42
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2A7F80E42
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2A7F80E42
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:17:23 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ee4399c423so924733a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338242; x=1785943042;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ymNKiUunO7j1WBad5j5UwNjevtkYJNpkRW+srKw4Dg=;
 b=rigqMbRPXV0+sXHisregHyaHU7XPLKlvVG9hRMyG3VEP1qxyVGbRk7xdyoFWB8HVbF
 OObkwdJciOfc3Hp01FshPN2djYe//N/UsKmqUGi0OmGg6JAKH8m8IrD4JgKmt1wNjB9k
 /QnGvI2aR+reIji5zyK5utIWik4Kwjn6Cz7NoR+2rdJv1b4gmJrPQVnvjic8NnZS8Bl3
 B2/nvQg1urEbQwxo8+FZwYewcc8FIhV7159URXWdCjcFVYAofE5IrxQb61hSDZJhGe13
 UFaKq3CGo2EvXkQHIu7EWwvLvgy5ly8ItrIYxngpHsURiFQidsQM1whFFxXF5YOywdRl
 +6zQ==
X-Gm-Message-State: AOJu0YyZliYgjaNg4/EGawbFvfIQBW+8E3Sksm8ZzNnXur20tBKmT8Ep
 nr6dAhkxtbm11DVSlGcRNkaJkXz4ws1pkMA5hieQM2MnuxejV2255AEqQWSG44vqPCd/NDHHiCM
 S3pawuzA=
X-Gm-Gg: AR+sD13CTkwGgI9nZyzIdHnfPUM3sJgYqYThmlUWQhj4WD9WXnzsWJAFUWA/cq5ZGmh
 b2BDdnrm3YZBuQm1V/j5FQZvuuZXlbVXqh1gPFNMeSkEVjPnNvUahWZ9+TVG0pqNi08vtvqkqRy
 bC8XRE51z0WNclfSOrQF6/3USaFLJtUVhA80KS2S7XbPyhqj8avLyP0hJWfifkmwpR6rc98ZE1g
 xy7By3nkEqNgPb4b0hMqCtAcAWXBFiwkorLtb9/a2oOReV7Rz75U7glqC3pfDMwJFq3nNZcrHWc
 /jruVwAviZkhYe1PAhCHsr2WbNKkJmm+acFXnhG9hpLELGRoOKyqFgryaWU5utBDz0roTI1DZTc
 l0cgu+ezqSrNiPZLewFL1ge0LoHPAeboUVVwQIgOKHxHU7EKsHeKzlXsSbTnm0Pr1khboVbaxiV
 QdwAoIAyCliU8v/zl/CzMmuykT6EffTDA0q8H2eAfJMt61EGk3oVehw6VDM5rvateXJFd7gergZ
 ZtyA1bSTQtV3THbpa/PSZrO9TnIkunT+Nv+S5tfl0JPNcykXLKaC/WegRGR4ZdMNX3DazgcyRTU
 LFSzXoiqsWI=
X-Received: by 2002:a05:6830:6ad6:b0:7e7:7de:ca8a with SMTP id
 46e09a7af769-7efff2bc79cmr3900441a34.22.1785338242646; 
 Wed, 29 Jul 2026 08:17:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d5f4f62sm2571061a34.12.2026.07.29.08.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:17:21 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:17:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.u-boot-project.org, Bryan Brattlof <bb@ti.com>,
 Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH RFC] env: ti: fdt_high: set no DTB relocation
Message-ID: <20260729151719.GB1773261@bill-the-cat>
References: <20260729-am62_sip_fdt_fix-v1-1-b0d814983d28@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ughSNUg4CJCITzqi"
Content-Disposition: inline
In-Reply-To: <20260729-am62_sip_fdt_fix-v1-1-b0d814983d28@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785338242; x=1785943042;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ymNKiUunO7j1WBad5j5UwNjevtkYJNpkRW+srKw4Dg=;
 b=tBKQEmY6uwmaf33bXLJgKtTi/20qVUlaFWm+UBCw4JSHyXGxEiaNDSBubo+ad4kEE/
 yem2/aP6jKRwnEPKyHwYCLH2gmjG0GpGkiBthUjuxgbRp3r05jOJw9l3T7+P0AWD2R2j
 JtTrPUkGTaZbP6ulETRLm6iV6YSGH3PnC7vN8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tBKQEmY6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--ughSNUg4CJCITzqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 04:48:55PM +0530, Anshul Dalal wrote:

> From: Hari Nagalla <hnagalla@ti.com>
>=20
> AM62-SIP SK boards have only 512 MB SDRAM. u-boot relocates the kernel
> DTB to upper SDRAM region before starting Linux kernel. This region is
> overlapping with the Firmware IPC carveouts. To avoid the overlap, set
> 'fdt_high' environment variable in u-boot to prevent relocation of DT
> blob.
>=20
> without this patch:
> Booting using the fdt blob at 0x88000000
> Working FDT set to 88000000
> Loading Device Tree to 000000009ce49000, end 000000009ce5b8f9 ... OK
> Working FDT set to 9ce49000
> ...
> and subsequently during Linux boot carveout reserve memory fails:
>=20
> Starting kernel ...
> ...
> [    0.000000] printk: legacy bootconsole [ns16550a0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: Reserved memory: failed to reserve
> memory for node 'memory@9cc00000': base 0x000000009cc00000, size 14 MiB
> [    0.000000] Reserved memory: created CMA memory pool at
> 0x0000000094600000, size 128 MiB
>=20
> with the patch:
>    Booting using the fdt blob at 0x88000000
> Working FDT set to 88000000
>  Using Device Tree in place at 0000000088000000, end 0000000088013375
> Working FDT set to 88000000
> ...
> and subsequent Linux boot
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: Reserved memory: reserved region for
> node 'memory@9cc00000': base 0x000000009cc00000, size 14 MiB
>=20
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> During linux boot on AM62x SIP board, U-Boot relocates the fdt to
> reserved-memory regions for IPC. This causes the kernel to fail when
> trying to reserve said memory regions.
>=20
> I'm not sure on what's the correct fix here but this RFC addresses the
> problem by disabling relocation to begin with.

The correct fix is to set bootm_size right, among other possibilities.
Please look up some of the older threads where I've explained why
disabling fdt relocation is wrong.

--=20
Tom

--ughSNUg4CJCITzqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamoZewAKCRAr4qD1Cr/k
CupnAQCC9cm1jm4OMeIFmDdv8Bad8tPeo0+1IqWyNxgm0RfoPwD+MzinF0MNmJI5
aOeh9ZOIY3XtyI2Tk1AR+iHvaI+IzAw=
=IxzU
-----END PGP SIGNATURE-----

--ughSNUg4CJCITzqi--
