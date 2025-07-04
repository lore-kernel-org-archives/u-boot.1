Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F357C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 11:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85618091A;
	Fri,  4 Jul 2025 13:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC5582063; Fri,  4 Jul 2025 13:02:08 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0B7806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 13:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 564B1QI2055155
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 4 Jul 2025 19:01:26 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 19:01:25 +0800
Date: Fri, 4 Jul 2025 19:01:22 +0800
From: Leo Liang <ycliang@andestech.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, <u-boot@lists.denx.de>, Ivan Griffin
 <ivan.griffin@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>, <Jamie.Gibbons@microchip.com>
Subject: Re: [PATCH v2] board: mpfs_icicle: implement
 board_fdt_blob_setup()/board_fit_config_name_match()
Message-ID: <aGe0gtU0TaeHYlNd@swlinux02>
References: <20250623115137.4017059-1-conor@kernel.org>
 <aGZW8cabMrd_76sw@swlinux02>
 <20250704-mortified-defense-b100145ed06d@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250704-mortified-defense-b100145ed06d@wendy>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 564B1QI2055155
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

Hi Conor,

On Fri, Jul 04, 2025 at 11:40:21AM +0100, Conor Dooley wrote:
> [EXTERNAL MAIL]

> Date: Fri, 4 Jul 2025 11:40:21 +0100
> From: Conor Dooley <conor.dooley@microchip.com>
> To: Leo Liang <ycliang@andestech.com>
> CC: Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de, Ivan Griffin
>  <ivan.griffin@microchip.com>, Cyril Jean <cyril.jean@microchip.com>, Tom
>  Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
>  Simon Glass <sjg@chromium.org>, Jamie.Gibbons@microchip.com
> Subject: Re: [PATCH v2] board: mpfs_icicle: implement
>  board_fdt_blob_setup()/board_fit_config_name_match()
> 
> On Thu, Jul 03, 2025 at 06:09:53PM +0800, Leo Liang wrote:
> > On Mon, Jun 23, 2025 at 12:51:36PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > The firmware on the Icicle is capable of providing a devicetree in a1 to
> > > U-Boot, but until now the devicetree has been packaged in a "payload" [1]
> > > alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
> > > The address of this appended devicetree is placed in a1 by the firmware.
> > > This meant that the mechanism used by OF_SEPARATE to locate the
> > > devicetree at the end of the image would pick up the one provided by the
> > > firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
> > > when u-boot.bin was.
> > > 
> > > The firmware is now going to be capable of providing a minimal devicetree
> > > (quite cut down due to severe space constraints), but this devicetree is
> > > linked into the firmware that runs out of the L2 rather than at the end
> > > of the U-Boot image.
> > > 
> > > Implement board_fdt_blob_setup() so that this devicetree can be
> > > optionally used, and the devicetree provided in the "payload" can be
> > > used without relying on "happening" to implement the same strategy as
> > > OF_SEPARATE expects in combination with u-boot-nodtb.bin.
> > > Unlike other RISC-V boards, the firmware provided devicetree is only
> > > used when OF_BOARD is set, so that the almost certainly more complete
> > > devicetree in U-Boot will be used unless explicitly requested otherwise.
> > > 
> > > Implement board_fit_config_name_match(), so that, using the firmware
> > > provided cut-down/minimal dtb, U-Boot can select one of several
> > > devicetrees when MULTI_DTB_FIT is enabled.
> > > 
> > > Enabling both MULTI_DTB_FIT and OF_BOARD will lead to a conflict
> > > between the two options, with the latter taking priority due to
> > > board_fdt_blob_setup() being executed before board_fit_config_name_match(),
> > > which causes gd->fdt_blob to be overwritten with a pointer to the
> > > minimal devicetree rather than the location of the fit image containing
> > > the multiple dtbs. Let MULTI_DTB_FIT take priority in this case, by
> > > explicitly blocking the override when MULTI_DTB_FIT is enabled.
> > > 
> > > Link: https://github.com/polarfire-soc/hart-software-services/blob/master/tools/hss-payload-generator/README.md [1]
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > 
> > > v2:
> > > - implement MULTI_DTB_FIT too
> > > 
> > > v1 was a year ago here:
> > > https://lore.kernel.org/u-boot/20240625090806.1787287-2-conor.dooley@microchip.com/
> > > 
> > > There was some discussion on that thread, but ultimately I didn't find
> > > what was mentioned to be worth implementing. Heinrich suggested to me, I
> > > guess on IRC or something since it's not in that thread, implementing
> > > MULTI_DTB_FIT, which I have done. A lot of the reason for the patch when
> > > I wrote it was speculative, but we have some actual users for OF_BOARD
> > > now - hence the v2 after about a year's gap.
> > > 
> > > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > > CC: Cyril Jean <cyril.jean@microchip.com>
> > > CC: Tom Rini <trini@konsulko.com>
> > > CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > CC: Simon Glass <sjg@chromium.org>
> > > CC: Jamie.Gibbons@microchip.com
> > > CC: u-boot@lists.denx.de
> > > ---
> > >  board/microchip/mpfs_icicle/mpfs_icicle.c | 63 +++++++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > 
> > Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> 
> Hmm, I made a mistake in the MULTI_DTB_FIT portion of this, and the
> strtok() is causing problems (I forgot about the modification in place,
> and the testcases I had used didn't catch it). Have you sent this in a
> PR yet? If you have, I'll send a fix otherwise a v3.

The PR has been sent and merged.
Could you send a fix for this?

Best regards,
Leo

> 
> Cheers,
> Conor.



