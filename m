Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B63CF397E
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF99583015;
	Wed, 19 Nov 2025 17:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF8F835C6; Wed, 19 Nov 2025 17:48:37 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5866F807C0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id 038BA68BFE; Wed, 19 Nov 2025 17:48:32 +0100 (CET)
Received: from rocky.lan (p5b2ecc04.dip0.t-ipconnect.de [91.46.204.4])
 by verein.lst.de (Postfix) with ESMTPSA id C254568BEB;
 Wed, 19 Nov 2025 17:47:47 +0100 (CET)
Date: Wed, 19 Nov 2025 17:47:40 +0100
From: Torsten Duwe <duwe@lst.de>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, Gabriel
 Fernandez <gabriel.fernandez@foss.st.com>, Heiko Stuebner
 <heiko@sntech.de>, Huan Zhou <me@per1cycle.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Jan XXermXXk" <sairon@sairon.cz>, Jerome
 Forissier <jerome.forissier@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, Joseph Chen
 <chenjh@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Leo Yu-Chi
 Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [RESEND PATCH 2/4] pci-uclass: respect ofnode_read_pci_vendev
 retval
Message-ID: <20251119174740.00be0a78@rocky.lan>
In-Reply-To: <20251105164432.C8AA4227AAD@verein.lst.de>
References: <20251105163553.15F2A227AAC@verein.lst.de>
 <20251105164432.C8AA4227AAD@verein.lst.de>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi Peter,

please don't apply this one yet.

On Wed,  5 Nov 2025 17:44:32 +0100 (CET)
Torsten Duwe <duwe@lst.de> wrote:

> The vendor:device read in pci_uclass_child_post_bind() might fail,
> which is currently ignored. In that case e.g. the RP1 on the RasPi5
> is erroneously being treated as a host bridge.
> 
> Mark the device's PCI info as invalid in case of failure.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  drivers/pci/pci-uclass.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> index c370f8c6400..4092e8ff5a9 100644
> --- a/drivers/pci/pci-uclass.c
> +++ b/drivers/pci/pci-uclass.c
> @@ -1200,6 +1200,7 @@ static int pci_uclass_post_probe(struct udevice *bus)
>  static int pci_uclass_child_post_bind(struct udevice *dev)
>  {
>  	struct pci_child_plat *pplat;
> +	int err;
>  
>  	if (!dev_has_ofnode(dev))
>  		return 0;
> @@ -1207,7 +1208,13 @@ static int pci_uclass_child_post_bind(struct udevice *dev)
>  	pplat = dev_get_parent_plat(dev);
>  
>  	/* Extract vendor id and device id if available */
> -	ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor, &pplat->device);
> +	err = ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor,
> +				     &pplat->device);
> +	if (err) {
> +		/* Mark PCI device structure as invalid */
> +		pplat->devfn = -1;

While I guess we all agree that an error return should not be ignored,
there might still be a better solution in this case. pplat->devfn = -1
might prevent the worst, but I assume the PCI dev 

| 02.1f.07   0xffff     0xffff     Does not fit any class  0xff

is a result of that.
 
> +		return 0;
> +	}
>  
>  	/* Extract the devfn from fdt_pci_addr */
>  	pplat->devfn = pci_get_devfn(dev);

thanks,
	Torsten
