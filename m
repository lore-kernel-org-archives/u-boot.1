Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD6CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 04:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 458AB83968;
	Tue, 28 Oct 2025 05:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uzk/0cNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2ED18391C; Tue, 28 Oct 2025 05:39:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6508391C
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 05:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59S4cpN62574129;
 Mon, 27 Oct 2025 23:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761626331;
 bh=88dKdOFhVoP67tm7D3KEBeWaTeeVBbIoT8XaopgJE/c=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=uzk/0cNtFGCTP00JFcNDg1zheoRPsggk/cdrX9bkPjyzl1GQW4yuxMwMCY3bMP0zQ
 gnS0d8ME9fqSxHDpVAczd8f+P95LuzqFD32WfWAGKE8kaojUWM0/Xkvtwp+VLluV6n
 9eqltLfsrkWh75AKugaYTaNOyonRt2I4zE0Jc1/w=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59S4cpnb1814945
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 23:38:51 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 23:38:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 23:38:51 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59S4cnui1747253;
 Mon, 27 Oct 2025 23:38:50 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Oct 2025 10:08:49 +0530
Message-ID: <DDTOEZHOH4OK.1ZQ850D6UHD0Z@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: Re: [REGRESSION] Re: [PATCH v11 00/11] Add support for dynamic MMU
 configuration
From: Anshul Dalal <anshuld@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251017131540.3636067-1-anshuld@ti.com>
 <20251027165225.GA71553@francesco-nb>
In-Reply-To: <20251027165225.GA71553@francesco-nb>
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

Hi Francesco,

On Mon Oct 27, 2025 at 10:22 PM IST, Francesco Dolcini wrote:
> Hello Anshul,
>
> On Fri, Oct 17, 2025 at 06:45:22PM +0530, Anshul Dalal wrote:
>> Hi all,
>>=20
>> In U-Boot, TI only provides a single memory map for all k3 platforms, th=
is
>> does not scale for devices where atf and optee lie outside the range 0x8=
0000000
>> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
>>=20
>> There are also issues for devices with < 2GiB of memory (eg am62SiP with=
 512MiB
>> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB=
 in the
>> current memory map. Furthermore the second DRAM bank is mapped even for =
devices
>> that only have a single bank.
>>=20
>> Therefore this patch set adds the required functionality to create the M=
MU table
>> at runtime based on the device-tree.
>>=20
>> The patch set has been build tested on all effected platforms but boot-t=
ested
>> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platforms=
.
>>=20
>> The following effected boards have not been boot tested:
>>  - verdin-am62
>
> it seems that this series introduce a regression on verdin-am62, I have
> not done a bi-sect yet, but we run daily build of U-Boot master and the
> regressions seems to have started when this patch series was
> merged.
>
> On verdin-am62 we detect the RAM size at run-time, see
> board/toradex/verdin-am62/verdin-am62.c:dram_init(), and now we always
> get 2GiB even for modules with only 512MB or 1024MB of memory.
>

This patch series modified the behavior of enable_caches to configure the
memory map of the device as per the device-tree instead of using a
static map for all of K3.

The issue with verdin-am62 seems to be that while you do properly
configure gd->ram_size in your dram_init, the '/memory' node of the
device-tree remains unchanged with the outdated 2GiB size.

You could try updating the fdt's memory size to the correct value in
dram_init and see if that fixes the problem.

Regards,
Anshul
