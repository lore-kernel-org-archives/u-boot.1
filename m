Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D96C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF85987C05;
	Fri, 19 Jan 2024 16:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AQu5PNZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2742B87CB6; Fri, 19 Jan 2024 16:57:10 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21FCF87A82;
 Fri, 19 Jan 2024 16:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JFulak043062;
 Fri, 19 Jan 2024 09:56:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705679807;
 bh=3PdO6q3NWoROLWG9kG53LgxYWUNTQv0ztf8B9wM4kl0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AQu5PNZqtu527j6wv/Wr9Ie9CcDsN0d3/JPi5nzVClOgPMWYu/21CheuZrhqgYJM5
 2suHtJ+fKxRmT3kRCBKCQsjObT+ZURNscqmM/P0JJIi3PkArfwiP/mWazN8aoZI/6E
 yqYkGBraN9xNRiF0cD//Wu+am8MgvZBbMovbTwq4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JFul4O006804
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 09:56:47 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 09:56:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 09:56:46 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JFukgP026459;
 Fri, 19 Jan 2024 09:56:46 -0600
Date: Fri, 19 Jan 2024 09:56:46 -0600
From: Nishanth Menon <nm@ti.com>
To: Sumit Garg <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <u-boot-custodians@lists.denx.de>, <trini@konsulko.com>,
 <sjg@chromium.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor@kernel.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <ff@shokubai.tech>, <daniel.thompson@linaro.org>,
 <dgilmore@fedoraproject.org>, <pbrobinson@gmail.com>,
 <ilias.apalodimas@linaro.org>, <maxim.uvarov@linaro.org>,
 <b.galvani@gmail.com>, <xypron.glpk@gmx.de>, <michal.simek@amd.com>,
 <seanga2@gmail.com>, <rasmus.villemoes@prevas.dk>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <rfried.dev@gmail.com>, <marex@denx.de>,
 <mibodhi@gmail.com>, <bb@ti.com>, <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240119155646.qq7bvgmha6cyftkv@nullify>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 16:05-20240110, Sumit Garg wrote:
[...]
> Prerequisite
> ------------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-Boot repo via:
> 
> $ git subtree add --prefix dts/upstream \
>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \

Please use https://

also what is the baseline? didn't seem to apply on (fails at patch #2):
next f28a77589e75 Merge tag 'dm-next-7jan23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
master f7cca7ccc511 Revert "test: hush: dollar: fix bugous behavior"

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
