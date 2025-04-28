Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D0C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 06:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF441820F6;
	Mon, 28 Apr 2025 08:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YF7acc+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A3A82103; Mon, 28 Apr 2025 08:14:30 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E05A820B7
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 08:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S6EPqD3455092
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 01:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745820865;
 bh=n9+/0ZY1+yn+nRlnvBvP5anNniE6uutps7nohN49dCo=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=YF7acc+nayKeAiF2PEPpXJUqzAfNPUujZgM0wW+HISE3LBrsdicItI2HYlO6QmMGw
 lf77Ci+E8gf6PtcVzjWt6M3wInM4pLUHN+ANTvBT19BHFvau37N5n8ClMSM7Ai3BNg
 +V916MKwF+fEqfOqPIMSVfp21fpbx4gUJzeGUcQU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S6EPVa081473
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Apr 2025 01:14:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 01:14:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 01:14:25 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S6EO8x123897;
 Mon, 28 Apr 2025 01:14:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Apr 2025 11:44:06 +0530
Message-ID: <D9I1U8TT57S8.3OE688N2ZHRST@ti.com>
Subject: Re: [PATCH v5 9/9] doc: ti: am62: add falcon mode documentation
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <khasim@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250425145644.2228186-1-anshuld@ti.com>
 <20250425145644.2228186-10-anshuld@ti.com>
 <20250425180511.GW5495@bill-the-cat>
In-Reply-To: <20250425180511.GW5495@bill-the-cat>
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

On Fri Apr 25, 2025 at 11:35 PM IST, Tom Rini wrote:
> On Fri, Apr 25, 2025 at 08:26:40PM +0530, Anshul Dalal wrote:
>> This patch adds user documentation for falcon boot for am62 platforms.
>> The main section is added to am62x_sk.rst and other documents just
>> include the section. Steps to build falcon support, usage and the
>> modified R5 memory map have been documented.
>>=20
>> Two svg images have also been added for reference, one for the modified
>> tispl_falcon.bin and other for the falcon specific fitImage format.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  doc/board/ti/am62ax_sk.rst                    |   7 +
>>  doc/board/ti/am62px_sk.rst                    |   7 +
>>  doc/board/ti/am62x_sk.rst                     | 248 ++++++++++++++++++
>>  doc/board/ti/img/fitImage_falcon.svg          | Bin 0 -> 5511 bytes
>>  .../ti/img/tifsstub_dm_tispl_falcon.bin.svg   | Bin 0 -> 9466 bytes
>
> I suspect these SVGs suffer from the same feedback that was given to
> some of Neha's recently, which is that instead of being good line SVGs
> they're embedding other graphical blobs. Please check and rework these
> so they show up as just good xml files on the inside and not binary,
> thanks.

Actually the issue seems to be with the .gitattributes file, after the
commit 284ef1bbcefc ("doc: memory: Add documentation for system RAM")
all svgs are treated as binaries by git by default. The content of the
SVGs I posted is just regular xml but git still treats it as a binary
blob.

For now, I'll send the next patch set with the svgs added as text files
instead.
