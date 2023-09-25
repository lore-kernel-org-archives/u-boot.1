Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA8DCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 11:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7BD86BE7;
	Mon, 25 Sep 2023 13:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C822686B7A; Mon, 25 Sep 2023 13:42:43 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFF486B93
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38PBf4us031359;
 Mon, 25 Sep 2023 19:41:04 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Sep 2023 19:41:01 +0800
Date: Mon, 25 Sep 2023 19:39:50 +0800
From: Leo Liang <ycliang@andestech.com>
To: Simon Glass <sjg@google.com>
CC: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>,
 <u-boot@lists.denx.de>, Shengyu Qu <wiagn233@outlook.com>, Jami Kettunen
 <jamipkettunen@gmail.com>
Subject: Re: [PATCH 1/1] starfive: visionfive2: add mmc0 and nvme boot targets
Message-ID: <ZRFxhnn2gVjz9904@swlinux02>
References: <20230918083231.20092-1-mps@arvanta.net>
 <ZQrpXpdKKbXyuDkY@swlinux02>
 <CAPnjgZ3AVe51nJqc2z4dds9T_Z3AVOJ503qv5zQJQZnDH5ihYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnjgZ3AVe51nJqc2z4dds9T_Z3AVOJ503qv5zQJQZnDH5ihYw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38PBf4us031359
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

On Sat, Sep 23, 2023 at 01:53:30PM -0600, Simon Glass wrote:
> Hi Leo,
> 
> On Wed, 20 Sept 2023 at 06:46, Leo Liang <ycliang@andestech.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 10:32:29AM +0200, Milan P. Stanić wrote:
> > > boot from SDIO3.0 (mmc sdcard) first if it is plugged.
> > > If mmc is not plugged try to boot from emmc if it is plugged.
> > > If emmc is not plugged then try to boot from nvme.
> > >
> > > Signed-off-by: Milan P. Stanić <mps@arvanta.net>
> > > ---
> > >  include/configs/starfive-visionfive2.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> 
> How about converting to standard boot and then this will be automatic?

Hi Simon,

Do you mean that we should implement this feature in a more general manner,
instead of implementing this in only on vf2 board ?

Best regards,
Leo

> 
> Regards,
> Simon
