Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A0BC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC5A8841E;
	Mon, 24 Jun 2024 14:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6112787DEA; Mon, 24 Jun 2024 10:20:23 +0200 (CEST)
Received: from EXCEDGE02.prodrive.nl (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B07387CFE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 10:20:16 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:20:20 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Mon, 24 Jun 2024 10:20:20 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1sLew0-006Ag5-99; Mon, 24 Jun 2024 10:20:20 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <marex@denx.de>
CC: <sbabic@denx.de>, <festevam@gmail.com>, <uboot-imx@nxp.com>,
 <trini@konsulko.com>, <peng.fan@nxp.com>, <ye.li@nxp.com>,
 <eduard@lionizers.com>, <fedor.ross@ifm.com>, <rasmus.villemoes@prevas.dk>,
 <xypron.glpk@gmx.de>, <elena.popa@nxp.com>, <tharvey@gateworks.com>,
 <sjg@chromium.org>, <vitor.soares@toradex.com>, <u-boot@lists.denx.de>,
 <martijn.de.gouw@prodrive-technologies.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
Date: Mon, 24 Jun 2024 10:20:20 +0200
Message-ID: <20240624082020.1470964-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <aba27158-0301-45b1-833d-ab84081b6242@denx.de>
References: <aba27158-0301-45b1-833d-ab84081b6242@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

>> The decision on whether HAB is enabled is solely based on the SEC_CONFIG
>> fuse. The HAB FIELD_RETURN feature is able to permanently disable HAB on
>> a CPU, after which it is able to boot unsigned firmware. U-Boot however
>> does not take into account the FIELD_RETURN mode, and refuses to boot
>> unsigned software when the feature is enabled.
>> 
>> Also take the FIELD_RETURN fuse into account when deciding whether HAB
>> is enabled. When The FIELD_RETURN fuse is blown, HAB is not enabled.
>> 
>> Tested on i.MX8M Mini, i.MX8M Plus, i.MX8M Nano and i.MX6ULL
>
>The purpose of the field return fuse is to unlock a system when it is 
>returned to factory, right ?

That is the intention of the field return mode indeed.

>
>Can the system be re-locked afterward too ?

No, the field return is enabled by a fuse, which cannot be reverted. The
mode is intended to be able to perform investigations on broken devices,
but these devices are not intended to go back into the field.

