Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DFCC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 19:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7D6883FB;
	Mon, 24 Jun 2024 21:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEC0883C9; Mon, 24 Jun 2024 20:51:47 +0200 (CEST)
Received: from EXCEDGE02.prodrive.nl (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC64287E30
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 20:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 20:51:45 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 20:51:45 +0200
Received: from lnxdev03.bk.prodrive.nl (10.1.0.14) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; 
 Mon, 24 Jun 2024 20:51:45 +0200
Received: from paugeu by lnxdev03.bk.prodrive.nl with local (Exim 4.97)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1sLon3-00000004TbA-0H8m; Mon, 24 Jun 2024 20:51:45 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <festevam@gmail.com>
CC: <sbabic@denx.de>, <uboot-imx@nxp.com>, <trini@konsulko.com>,
 <peng.fan@nxp.com>, <ye.li@nxp.com>, <eduard@lionizers.com>, <marex@denx.de>, 
 <fedor.ross@ifm.com>, <rasmus.villemoes@prevas.dk>, <xypron.glpk@gmx.de>,
 <elena.popa@nxp.com>, <tharvey@gateworks.com>, <sjg@chromium.org>,
 <vitor.soares@toradex.com>, <u-boot@lists.denx.de>,
 <martijn.de.gouw@prodrive-technologies.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
Date: Mon, 24 Jun 2024 20:51:45 +0200
Message-ID: <20240624185145.1067080-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAOMZO5D69WsyoKzccHNxmfc3mWpQkNOd0-Nii+KypXa4j0qahA@mail.gmail.com>
References: <CAOMZO5D69WsyoKzccHNxmfc3mWpQkNOd0-Nii+KypXa4j0qahA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Jun 2024 21:08:32 +0200
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

Hi Fabio,

>Hi Paul,
>
>On Fri, Jun 21, 2024 at 10:06 AM Paul Geurts <paul.geurts@prodrive-technologies.com> wrote:
>
>> -struct imx_sec_config_fuse_t {
>> +struct imx_fuse_t {
>
>Please make the struct renaming a separate patch.

Yes, I will do that.

>
>Peng Fan, Ye Li,
>
>Could you please help review this patch?
>
>Thanks
>
