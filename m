Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22A5C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 20:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5526587EBA;
	Mon, 18 Mar 2024 21:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C6687DEC; Mon, 18 Mar 2024 21:34:31 +0100 (CET)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs
 [93.87.244.166]) by phobos.denx.de (Postfix) with ESMTP id 991BF88005
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 21:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1pro.arvanta.net (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 173F55D9C;
 Mon, 18 Mar 2024 20:34:29 +0000 (UTC)
Date: Mon, 18 Mar 2024 21:34:31 +0100
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Nam Cao <namcao@linutronix.de>
Cc: ycliang@andestech.com, yanhong.wang@starfivetech.com,
 chanho61.park@samsung.com, wiagn233@outlook.com, sjg@chromium.org,
 inindev@gmail.com, rick@andestech.com, bmeng@tinylab.org,
 u-boot@lists.denx.de, minda.chen@starfivetech.com
Subject: Re: [PATCH] starfive: visionfive2: switch to standard boot
Message-ID: <20240318203431.GA21567@m1pro.arvanta.net>
References: <20240221120014.149193-1-namcao@linutronix.de>
 <20240313184206.GA20322@m1pro.arvanta.net>
 <20240314130436.76a2892a@namcao>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314130436.76a2892a@namcao>
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

On Thu, 2024-03-14 at 13:04, Nam Cao wrote:
> On 13/Mar/2024 Milan P. Stanić wrote:
> > On Wed, 2024-02-21 at 13:00, Nam Cao wrote:
> > > Distro boot scripts are deprecated. Use standard boot instead.  
> > I had to enable 'CONFIG_CMD_SYSBOOT=y' in
> > configs/starfive_visionfive2_defconfig because it doesn't boot without
> > it. With this option it boots fine with this patch.
> 
> You should not have to do that for it to work, otherwise this patch
> introduced a bug.
> 
> CONFIG_CMD_SYSBOOT adds the "sysboot" command, which is only used by
> distroboot. So I suspect that you were actually still using distro boot,
> because you didn't "update" your environment variable (that can be checked
> with "printenv bootcmd"). For this patch to work, the environment variables
> also need to be updated with:
>     env default
>     env save -a
> 
> This makes me realize that the patch breaks boards if the users forget to
> update the environment variables. I am not sure if this is considered a
> bug. What do maintainers think?

Rebuild it again and it worked out of the box.

Tested-by: Milan P. Stanić <mps@arvanta.net>

