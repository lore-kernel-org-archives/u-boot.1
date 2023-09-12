Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECB3CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 08:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40EA086CEB;
	Tue, 12 Sep 2023 10:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9232E86400; Tue, 12 Sep 2023 10:26:29 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 1B0CB86CEB
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 10:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id BE8842400C;
 Tue, 12 Sep 2023 10:26:26 +0200 (CEST)
Date: Tue, 12 Sep 2023 10:26:26 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Jami Kettunen <jamipkettunen@gmail.com>
Cc: u-boot@lists.denx.de, Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Shengyu Qu <wiagn233@outlook.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: Re: [PATCH RFC 2/2] configs: visionfive2: Enable MISC_INIT_R
Message-ID: <20230912082626.GB16039@m1>
References: <20230911153253.20701-1-jamipkettunen@gmail.com>
 <20230911153253.20701-3-jamipkettunen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911153253.20701-3-jamipkettunen@gmail.com>
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

On Mon, 2023-09-11 at 18:32, Jami Kettunen wrote:
> From: Jami Kettunen <jami.kettunen@protonmail.com>
> 
> Used to select mainline kernel fdtfile based on board revision.
> 
> Signed-off-by: Jami Kettunen <jami.kettunen@protonmail.com>

Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  configs/starfive_visionfive2_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index e9b63e5b84..33f9ec8ad6 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -125,3 +125,4 @@ CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_PCI=y
>  CONFIG_USB_KEYBOARD=y
> +CONFIG_MISC_INIT_R=y
