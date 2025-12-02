Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6261AD116F5
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 14:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3005083E7A;
	Tue,  2 Dec 2025 15:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD1683DFA; Tue,  2 Dec 2025 07:01:50 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF63D83DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 07:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB1D21A25E0;
 Tue,  2 Dec 2025 07:01:47 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 852C11A25D0;
 Tue,  2 Dec 2025 07:01:47 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 297F41800098;
 Tue,  2 Dec 2025 14:01:45 +0800 (+08)
Date: Tue, 2 Dec 2025 15:01:44 +0900
From: Joseph Guo <qijian.guo@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, festevam@gmail.com
Cc: Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 qijian.guo@nxp.com
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <aS6AyGzhsl3cpOs0@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
 <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
 <CAOMZO5CbYn544xKUb6QApg0bzc_cQEqqTSSC1r9SUgyfpQGSEA@mail.gmail.com>
 <PAXPR04MB8459355C0CE42DFCB11B17E588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5BbFUSMp_sOt0FkBMh=4a1QTbpFTjSMfTNDGvxo3ZEqfw@mail.gmail.com>
 <DB9PR04MB8461A3967CB098498288476388D8A@DB9PR04MB8461.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR04MB8461A3967CB098498288476388D8A@DB9PR04MB8461.eurprd04.prod.outlook.com>
X-Mailman-Approved-At: Tue, 02 Dec 2025 15:06:33 +0100
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

On Tue, Dec 02, 2025 at 03:36:13AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
> > 
> > Hi Peng,
> > 
> > On Mon, Dec 1, 2025 at 11:36 PM Peng Fan <peng.fan@nxp.com>
> > wrote:
> > 
> > > With ECC enabled, some DRAM space needs to be reserved to store
> > ECC.
> > > With ECC disabled, no need to reserve DRAM space for ECC area.
> > 
> > Thanks for the clarification. How large does the ECC area need to be?
> 
> It is auto calculated by reading the DDR settings, for 2GB DRAM, it
> is about 128MB? I could not recall clearly.
> 
> __weak int board_phys_sdram_size(phys_size_t *size)                                                 
> {                                                                                                   
>         phys_size_t start, end;                                                                     
>         phys_size_t val;                                                                            
>                                                                                                     
>         if (!size)                                                                                  
>                 return -EINVAL;                                                                     
>                                                                                                     
>         val = readl(REG_DDR_CS0_BNDS);                                                              
>         start = (val >> 16) << 24;                                                                  
>         end   = (val & 0xFFFF);                                                                     
>         end   = end ? end + 1 : 0;                                                                  
>         end   = end << 24;                                                                          
>         *size = end - start;                                                                        
>                                                                                                     
>         val = readl(REG_DDR_CS1_BNDS);                                                              
>         start = (val >> 16) << 24;                                                                  
>         end   = (val & 0xFFFF);                                                                     
>         end   = end ? end + 1 : 0;                                                                  
>         end   = end << 24;                                                                          
>         *size += end - start;                                                                       
>                                                                                                     
>         return 0;
> 
> 
> Regards
> Peng.
> 
> > 
> > Joseph,
> > 
> > Please add this explanation to the board's README to help users select
> > the more appropriate defconfig for their use case.
> > 
> > Thank

Hi Fabio,

ECC will reduce 1/8 ddr size. In i.MX91 FRDM,
The ddr size reduce from 1024M to 896M. Sure I will add this explanation
to README. Thanks.

Regards,
Joseph
