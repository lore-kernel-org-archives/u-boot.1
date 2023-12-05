Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09649C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 08:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 003FD86E73;
	Tue,  5 Dec 2023 09:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B6986EE5; Tue,  5 Dec 2023 09:57:16 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D35E86D9E
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 09:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3B58v8Lj011539;
 Tue, 5 Dec 2023 16:57:08 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 5 Dec 2023 16:57:04 +0800
Date: Tue, 5 Dec 2023 16:57:02 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
CC: <u-boot@lists.denx.de>, <cheehong.ang@starfivetech.com>, Wei Liang Lim
 <weiliang.lim@starfivetech.com>
Subject: Re: [PATCH v2] timer: starfive: Add Starfive timer support
Message-ID: <ZW7lvg7Q_4rS1HM9@swlinux02>
References: <20231128064254.635-1-kuanlim.lee@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128064254.635-1-kuanlim.lee@starfivetech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3B58v8Lj011539
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

Hi Kuan Lim,

On Tue, Nov 28, 2023 at 02:42:33PM +0800, Kuan Lim Lee wrote:
> Add timer driver in Starfive SoC. It is an timer that outside
> of CPU core and inside Starfive SoC.
> 
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Signed-off-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
> 
> Changes for v2:
> - correct driver name, comment, variable
> ---
>  drivers/timer/Kconfig          |  7 +++
>  drivers/timer/Makefile         |  1 +
>  drivers/timer/starfive-timer.c | 96 ++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 drivers/timer/starfive-timer.c

I have already merged your v1 patch.
So could you re-send a patch based on the current master
with all the fixes you have in this patch ?

Other than that,
LGTM.

Best regards,
Leo
