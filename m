Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9922BC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CFF82B07;
	Tue, 10 Jun 2025 18:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zC3smrPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34AE982B20; Tue, 10 Jun 2025 18:08:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FDCE8004F
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55AG8Tn21127432;
 Tue, 10 Jun 2025 11:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749571709;
 bh=unLJOxzOX0Gf3jBwVXDYFRnCPOJtqz0dL3j4760T35g=;
 h=Date:To:CC:Subject:From:References:In-Reply-To;
 b=zC3smrPFPw7giMNQQHezmt+XUojsZf9FGUoFiUiwkhTUxNfhcpGKxhCtPlFim+tTx
 NnlrdHqDIgJZX6MZhvJaXth69cOq7g3ijM4t1FzWh5uv9dfeu6KYwpZr4KNZUNMniC
 ovXfyFdTlnpfkUU6N6kjmhoHIrXIDyLjU4A1CZyI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55AG8TWO2230316
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 10 Jun 2025 11:08:29 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 11:08:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 11:08:29 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55AG8SBG3310421;
 Tue, 10 Jun 2025 11:08:28 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Jun 2025 21:37:54 +0530
Message-ID: <DAIZEBF8NRLV.GPI5TVNOPT1Z@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v7 07/10] board: ti: add default dtb for am62 in falcon
 mode
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-8-anshuld@ti.com>
 <20250606190956.GA1382132@bill-the-cat> <DAHTVJ8QOH6P.1VUE8A6ES0CRJ@ti.com>
 <20250609145716.GM1382132@bill-the-cat> <DAIRTBR6H2UR.3D9X1G3AV77FZ@ti.com>
 <20250610144624.GZ1382132@bill-the-cat>
In-Reply-To: <20250610144624.GZ1382132@bill-the-cat>
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

On Tue Jun 10, 2025 at 8:16 PM IST, Tom Rini wrote:
> On Tue, Jun 10, 2025 at 03:41:21PM +0530, Anshul Dalal wrote:
>> On Mon Jun 9, 2025 at 8:27 PM IST, Tom Rini wrote:
>> > On Mon, Jun 09, 2025 at 01:05:36PM +0530, Anshul Dalal wrote:
>> >> On Sat Jun 7, 2025 at 12:39 AM IST, Tom Rini wrote:
>> >> > On Tue, Jun 03, 2025 at 07:54:47PM +0530, Anshul Dalal wrote:
>> >> >
>> >> >> The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to the =
kernel
>> >> >> (dtb in our case) in falcon boot.
>> >> >>=20
>> >> >> Setting it in board specific Kconfig allows us to reuse the same c=
onfig
>> >> >> fragment 'am62x_r5_falcon.config' for all 3 platforms for enabling
>> >> >> falcon boot.
>> >> >>=20
>> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> >> >> ---
>> >> >>  board/ti/am62ax/Kconfig | 3 +++
>> >> >>  board/ti/am62px/Kconfig | 3 +++
>> >> >>  board/ti/am62x/Kconfig  | 3 +++
>> >> >>  3 files changed, 9 insertions(+)
>> >> >
>> >> > Why can't whatever is using the fragment also set this? Is it becau=
se
>> >> > you're only using this as part of say:
>> >> > make am62ax_evm_r5_defconfig am62x_falcon.config
>> >> > ?
>> >>=20
>> >> Correct, having three different config fragments with only changes to=
 the
>> >> dtb path doesn't seem very useful imo.
>> >
>> > Then these belong back in the main defconfig itself I think.
>>=20
>> That's not an option since SPL_FS_LOAD_ARGS_NAME depends on
>> SPL_OS_BOOT[1] and due to the way config fragments are applied. Since we
>> only set OS_BOOT to y inside of the fragment, we can not define any
>> configs that depend on it before that in the defconfig like
>> SPL_FS_LOAD_ARGS_NAME, it would just default to "args" instead.
>>=20
>> [1]: common/spl/Kconfig:794
>> config SPL_FS_LOAD_ARGS_NAME
>> 	string "File to load for the OS kernel argument parameters from the fil=
esystem"
>> 	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOO=
T
>> 	default "args"
>
> Config fragments can be nested, so maybe the falcon variant will need to
> include the main defconfig, the falcon fragment and then set the args to
> the dtb.

So we add 3 new defconfigs for each platforms that include their
respective defconfigs and the fragment with only the dtb changes?

That sounds good to me though why not modify the Kconfig's directly like
I did in the patch originally?

