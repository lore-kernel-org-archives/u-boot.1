Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258CDC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 16:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7AF81298;
	Fri,  7 Mar 2025 17:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hreG4UmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A0D81420; Fri,  7 Mar 2025 17:22:02 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F5080F4C
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 17:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527GLwri4018057
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 10:21:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741364518;
 bh=Zcv8YWpzHva86UJIhjxHQxg4g0ZIjLBgtoN8ygBN+wI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hreG4UmKWYAcv/84BPT7G6EaUFtry8Nzj3s2IuKGpKgQTC4qMClDSBB2XLdKWuWz3
 6KKvavuLUoQi84sWqWreLEKOB+P4nHIhm98MZBpcP9KCuUXZXVt8Cs82tPbc+8MCSC
 hBeCAKDf+IhhjhqUMuY6/M9vv04PEou32PYirzE8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527GLwBj081506
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Mar 2025 10:21:58 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 10:21:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 10:21:58 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527GLvFE069187;
 Fri, 7 Mar 2025 10:21:57 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 7 Mar 2025 21:51:56 +0530
Message-ID: <D8A67B91C5MK.3KCZUQ1GM5700@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH 09/10] config: add falcon boot config
 fragment for am62x
X-Mailer: aerc 0.17.0
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-10-anshuld@ti.com>
 <20250307155809.GR2640854@bill-the-cat>
In-Reply-To: <20250307155809.GR2640854@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Fri Mar 7, 2025 at 9:28 PM IST, Tom Rini wrote:
> On Fri, Mar 07, 2025 at 01:25:37PM +0530, Anshul Dalal wrote:
> > This fragment enables falcon boot for the am62x, 62a and 62p.
> >=20
> > To have enough stack and heap space for loading kernel image as FIT, th=
e
> > memory map was modified as shown below, the PRELOADED_BL33_BASE in ATF
> > has to also be updated to 0x80200000 since the kernel requires to be
> > loaded at 2MiB aligned address.
> >=20
> > Memory Map (changed addresses marked with *):
> >=20
> > 0x80000000 +-------------------------------+ Start of DDR
> >   512KiB   |   ATF reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
> > 0x80080000 +-------------------------------+
> >   1.5MiB   |            Unused             |
> > 0x80200000 +-------------------------------+ PRELOADED_BL33_BASE* in AT=
F
> >            |                               | CONFIG_SYS_LOAD_ADDR* (loa=
d
> >    30MiB   |   Kernel + initramfs Image    | address for kernel)
> >            |                               |
> > 0x82000000 +-------------------------------+ K3_HW_CONFIG_BASE in ATF
> >            |                               | CONFIG_SPL_PAYLOAD_ARGS_AD=
DR*
> >     1MiB   |          Kernel DTB           |
> >            |                               |
> > 0x82100000 +-------------------------------+ CONFIG_SPL_LOAD_FIT_ADDRES=
S*
> >            |                               |
> >    55MiB   |Initial Download Region for FIT|
> >            |                               |
> > 0x85800000 +-------------------------------+
> >            |                               |
> >            |  R5 U-Boot SPL Stack + Heap   |
> >    56MiB   |       (size defined by        |
> >            | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
> >            |                               |
> > 0x89000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR*
> >   344MiB   |       Device Manager (DM)     |
> > 0x9e800000 +-------------------------------+ BL32_BASE in ATF
> >    24MiB   |             OPTEE             |
> > 0xa0000000 +-------------------------------+ End of DDR (512MiB)
>
> This information is good and belongs in a relevant rst file, not just
> commit message.

I wanted to get some feedback first before updating the documentation in
case there were any changes to the boot flow. Once we have finalized
that, I will update the documentation in an upcoming revision of this
patch set.

Anshul

