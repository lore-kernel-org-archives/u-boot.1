Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3038EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 05:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C7988629;
	Fri, 19 Apr 2024 07:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="E99QsPRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870C78862B; Fri, 19 Apr 2024 07:38:17 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF11D8860F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 07:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240419053810epoutp0208c463d09c0cec01a3d5387fdaf1ff87~Hl80Ey9tF2673026730epoutp02z
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 05:38:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240419053810epoutp0208c463d09c0cec01a3d5387fdaf1ff87~Hl80Ey9tF2673026730epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713505090;
 bh=OZnJOjw7Vys5RgdcfcwE1c7glQ8L7LT+1UJky7lNok4=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=E99QsPRKLbRvMaYfdUf59O086ly3o6y2CvrQD3UpimKFsSqIDK79jgV9noqs9s72X
 u3I3nEwsfiVpt1yETY9PST9IpaKd3JsJfdAEfry6QcenMlMY72/eVAH6ndcMVjRUUA
 vahuRf6SIbxQWRSm/8VzG+zBKxA7esCW8nro3+DU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240419053809epcas1p363ad7e884d903770225d150bcaa3c5f1~Hl8zyTiFY1383813838epcas1p3i;
 Fri, 19 Apr 2024 05:38:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VLNhw5s5Mz4x9Q0; Fri, 19 Apr
 2024 05:38:08 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 DD.73.10158.04302266; Fri, 19 Apr 2024 14:38:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240419053808epcas1p464811c168a425e83b484295bc7cfbf71~Hl8yhDHru1944219442epcas1p45;
 Fri, 19 Apr 2024 05:38:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240419053808epsmtrp25a2f33b837eb77e5bec14e7ad88af785~Hl8ygT8e01606616066epsmtrp2f;
 Fri, 19 Apr 2024 05:38:08 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-0f-66220340d032
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A1.3A.08924.04302266; Fri, 19 Apr 2024 14:38:08 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240419053808epsmtip2ed954c853951e40de970092b2851483b~Hl8yM6DDm0145601456epsmtip25;
 Fri, 19 Apr 2024 05:38:08 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Greg Malysa'" <greg.malysa@timesys.com>, <u-boot@lists.denx.de>,
 "'Peng Fan'" <peng.fan@nxp.com>
Cc: "'Ian Roberts'" <ian.roberts@timesys.com>, "'Nathan Barrett-Morrison'"
 <nathan.morrison@timesys.com>, "'Jonas	Karlman'" <jonas@kwiboo.se>, "'Kever
 Yang'" <kever.yang@rock-chips.com>, "'Peter	Geis'" <pgwipeout@gmail.com>,
 "'Sean Anderson'" <sean.anderson@seco.com>, "'Simon	Glass'"
 <sjg@chromium.org>, "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <002d01da905d$c0d03600$4270a200$@samsung.com>
Subject: RE: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct
 sdhci_ops
Date: Fri, 19 Apr 2024 14:38:07 +0900
Message-ID: <060201da921b$c22bbeb0$46833c10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEAxbe5xUMRNPs0ZNxHEQLPRoWwAGNs8ZDAfotP9Sv//Ha8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmvq4Ds1Kawf2XuhanP91gsXh5/x6T
 xck3V1kstk3/yWZxeeFlRosfq76wWpx95m0x734Lk8W3LdsYLaZO2sxu8XZvJ7sDt8fshoss
 Hjtn3WX3eHVgFbvHiQmXmDzO3tnB6LHx3Q4mj7+z9rN4PPv3jd1j7/YfTAGcUdk2GamJKalF
 Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKimUJeaUAoUCEouL
 lfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM95+WMle8NCr
 Ytf+d8wNjFetuxg5OSQETCQOHTnG2sXIxSEksINRYvf332wQzidGiQ+HbzJDON8YJQ5un8wC
 03LpxRV2iMReRom23b+gnJeMEo2zJ7OCVLEJ6En8X7QQqJ2DQ0QgQ2LDG7CxzAK3mCTuHNjM
 BFLDKWAl8bvhHiOILSwQLjGj5wgziM0ioCrR8fgiO0gvr4ClxImvgSBhXgFBiZMzn4AdwSwg
 L7H97RxmiIMUJH4+XQa2VkTASeLVrWmMEDUiErM728A+kBC4wyHx9fBiqAYXidtLjkF9Iyzx
 6vgWdghbSuLzu71sEA3NjBJLlxxkhXB6GCX+NVxng6gylti/dDITyHXMApoS63fpQ2zjk3j3
 tYcVJCwhwCvR0SYEUa0icen1SyaY+Xef/GeFsD0kHsz+zzyBUXEWkt9mIfltFpIfZiEsW8DI
 sopRLLWgODc9tdiwwAQe3cn5uZsYwWlZy2IH49y3H/QOMTJxMB5ilOBgVhLhNeNQTBPiTUms
 rEotyo8vKs1JLT7EaAoM7InMUqLJ+cDMkFcSb2hiaWBiZmRsYmFoZqgkznvmSlmqkEB6Yklq
 dmpqQWoRTB8TB6dUA5OdVPFa0Xd2G0sLW/uDf59WsGJZKbQs+SqDtUiz2tFaHu+GFYv+qIcf
 lf7JcmVd2kXpqRVniwUjry5lVbp8JVM1YEeQnPjtfTmtgUcK4i2/W7i67rHKmL46e+3+Updz
 +teOd2Qt+8r3ncFmp9eWMp6u4yt+2vg9DZ44Ye7tGRp+SqGuyVPcS/7srl26y5+/fP40vrQ3
 RldPSwas+HB+3753b0PX8ize92PjySUbzi7VFmr+u+jfpwoGzuKGiw6XN+/UUXONXWnGZMmz
 LoT9okPfkedLpBMiWYxkl2/bJf/p4IEGoUJtiWux76pyNA9ucFS5pPr3qsDSiQl/M69m1ofI
 Lp3/ylYzbuk0ER7ec5+UWIozEg21mIuKEwFniejgVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK4Ds1KawaoDPBanP91gsXh5/x6T
 xck3V1kstk3/yWZxeeFlRosfq76wWpx95m0x734Lk8W3LdsYLaZO2sxu8XZvJ7sDt8fshoss
 Hjtn3WX3eHVgFbvHiQmXmDzO3tnB6LHx3Q4mj7+z9rN4PPv3jd1j7/YfTAGcUVw2Kak5mWWp
 Rfp2CVwZbz+sZC946FWxa/875gbGq9ZdjJwcEgImEpdeXGHvYuTiEBLYzSjxedpzdoiElMTn
 p1PZuhg5gGxhicOHiyFqnjNKzD15hhmkhk1AT+L/ooVgtohAlkT31z/MIEXMAg+YJE5PfQY1
 dRejxNuzz8CmcgpYSfxuuMcIYgsLhEpM2viGBcRmEVCV6Hh8kR1kG6+ApcSJr4EgYV4BQYmT
 M5+AlTALaEs8vfkUypaX2P52DjPEoQoSP58uY4U4wkni1a1pjBA1IhKzO9uYJzAKz0IyahaS
 UbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg+NTS3MG4fdUHvUOM
 TByMhxglOJiVRHjNOBTThHhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgt
 gskycXBKNTDNFmw7dC4zP1XUwMU1/tnGQMmK8oo13x6uNWlZWjylkk3x7rbJq66eTrzw9GWP
 9Oovagdnip+NXVyv+TSNa8c6i/Of+4qnLdY8uvvc4fKEL9tWNZtwfdwVVu/25LJT1IvgHHPB
 D1KqjjyP3fobxUu1ONSswyr2HFp8ZFX0hsVxvHtWzfxj9pbTzXRL9skn8XIak24bcz3yi5h4
 WHj+qa/3Tv3gmZ306rpUjdPuYxJmS24pX/m31pjz6VTrtf2zuZxqOCcuCXt/9sSPHeselt3c
 tYi/cdOKi+k9Tk1Hfvoqfz4/cdr5VtPlv7f53T649HDN7stbBYuPb/S/82bxvG2xi2QOGLY3
 PlY9422wfvE86SVKLMUZiYZazEXFiQBZvwApPgMAAA==
X-CMS-MailID: 20240419053808epcas1p464811c168a425e83b484295bc7cfbf71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326022044epcas1p4c22b3f79421ca2ba3e93988d29016192
References: <CGME20240326022044epcas1p4c22b3f79421ca2ba3e93988d29016192@epcas1p4.samsung.com>
 <20240326021819.770-1-greg.malysa@timesys.com>
 <002d01da905d$c0d03600$4270a200$@samsung.com>
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

Hi,

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Wednesday, April 17, 2024 9:26 AM
> To: 'Greg Malysa' <greg.malysa@timesys.com>; u-boot@lists.denx.de; 'Peng Fan' <peng.fan@nxp.com>
> Cc: 'Ian Roberts' <ian.roberts@timesys.com>; 'Nathan Barrett-Morrison' <nathan.morrison@timesys.com>;
> 'Jonas Karlman' <jonas@kwiboo.se>; 'Kever Yang' <kever.yang@rock-chips.com>; 'Peter Geis'
> <pgwipeout@gmail.com>; 'Sean Anderson' <sean.anderson@seco.com>; 'Simon Glass' <sjg@chromium.org>;
> 'Tom Rini' <trini@konsulko.com>
> Subject: RE: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
> 
> 
> 
> > -----Original Message-----
> > From: Greg Malysa <greg.malysa@timesys.com>
> > Sent: Tuesday, March 26, 2024 11:18 AM
> > To: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: Ian Roberts <ian.roberts@timesys.com>; Nathan Barrett-Morrison <nathan.morrison@timesys.com>;
> Greg
> > Malysa <greg.malysa@timesys.com>; Jonas Karlman <jonas@kwiboo.se>; Kever Yang <kever.yang@rock-
> > chips.com>; Peter Geis <pgwipeout@gmail.com>; Sean Anderson <sean.anderson@seco.com>; Simon Glass
> > <sjg@chromium.org>; Tom Rini <trini@konsulko.com>
> > Subject: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
> >
> > From: Ian Roberts <ian.roberts@timesys.com>
> >
> > Add this hook so that it can be overridden with driver specific
> > implementations. We also let the original sdhci_adma_write_desc()
> > accept &desc so that the function can set its new value. Then export
> > the function so that it could be reused by driver's specific
> > implementations.
> >
> > The above is a port of Linux kernel commit 54552e4948cbf
> >
> > In addition, allow drivers to allocate their own ADMA descriptor
> > tables if additional space is required.
> >
> > Finally, fix the assignment of adma_addr to fix compiler warning
> > on 64-bit platforms that still use 32-bit DMA addressing.
> >
> > Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> > Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Some target are failed to build. (e.g, j721e_beagleboneai64_r5)

+drivers/mmc/sdhci-adma.c: In function '__sdhci_adma_write_desc':
+drivers/mmc/sdhci-adma.c:37:43: error: 'const struct sdhci_ops' has no member named 'adma_write_desc'
+   37 |         if (host && host->ops && host->ops->adma_write_desc)
+      |                                           ^~
+drivers/mmc/sdhci-adma.c:38:26: error: 'const struct sdhci_ops' has no member named 'adma_write_desc'
+   38 |                 host->ops->adma_write_desc(host, desc, addr, len, end);
+      |                          ^~
+make[3]: *** [scripts/Makefile.build:257: drivers/mmc/sdhci-adma.o] Error 1
+make[2]: *** [scripts/Makefile.build:397: drivers/mmc] Error 2

Best Regards,
Jaehoon Chung

> 
> Best Regards,
> Jaehoon Chung
> 
> >
> > ---
> >
> >
> > ---
> >  drivers/mmc/fsl_esdhc.c  |  2 +-
> >  drivers/mmc/sdhci-adma.c | 41 +++++++++++++++++++++++++++-------------
> >  drivers/mmc/sdhci.c      |  8 +++++---
> >  include/sdhci.h          | 12 ++++++++++--
> >  4 files changed, 44 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
> > index d506666669..bd0671cc52 100644
> > --- a/drivers/mmc/fsl_esdhc.c
> > +++ b/drivers/mmc/fsl_esdhc.c
> > @@ -252,7 +252,7 @@ static void esdhc_setup_dma(struct fsl_esdhc_priv *priv, struct mmc_data *data)
> >  	    priv->adma_desc_table) {
> >  		debug("Using ADMA2\n");
> >  		/* prefer ADMA2 if it is available */
> > -		sdhci_prepare_adma_table(priv->adma_desc_table, data,
> > +		sdhci_prepare_adma_table(NULL, priv->adma_desc_table, data,
> >  					 priv->dma_addr);
> >
> >  		adma_addr = virt_to_phys(priv->adma_desc_table);
> > diff --git a/drivers/mmc/sdhci-adma.c b/drivers/mmc/sdhci-adma.c
> > index 8213223d3f..8c38448b6a 100644
> > --- a/drivers/mmc/sdhci-adma.c
> > +++ b/drivers/mmc/sdhci-adma.c
> > @@ -9,9 +9,10 @@
> >  #include <malloc.h>
> >  #include <asm/cache.h>
> >
> > -static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
> > -			    dma_addr_t addr, u16 len, bool end)
> > +void sdhci_adma_write_desc(struct sdhci_host *host, void **next_desc,
> > +			   dma_addr_t addr, int len, bool end)
> >  {
> > +	struct sdhci_adma_desc *desc = *next_desc;
> >  	u8 attr;
> >
> >  	attr = ADMA_DESC_ATTR_VALID | ADMA_DESC_TRANSFER_DATA;
> > @@ -19,17 +20,30 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
> >  		attr |= ADMA_DESC_ATTR_END;
> >
> >  	desc->attr = attr;
> > -	desc->len = len;
> > +	desc->len = len & 0xffff;
> >  	desc->reserved = 0;
> >  	desc->addr_lo = lower_32_bits(addr);
> >  #ifdef CONFIG_DMA_ADDR_T_64BIT
> >  	desc->addr_hi = upper_32_bits(addr);
> >  #endif
> > +
> > +	*next_desc += ADMA_DESC_LEN;
> > +}
> > +
> > +static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
> > +					   void **desc, dma_addr_t addr,
> > +					   int len, bool end)
> > +{
> > +	if (host && host->ops && host->ops->adma_write_desc)
> > +		host->ops->adma_write_desc(host, desc, addr, len, end);
> > +	else
> > +		sdhci_adma_write_desc(host, desc, addr, len, end);
> >  }
> >
> >  /**
> >   * sdhci_prepare_adma_table() - Populate the ADMA table
> >   *
> > + * @host:	Pointer to the sdhci_host
> >   * @table:	Pointer to the ADMA table
> >   * @data:	Pointer to MMC data
> >   * @addr:	DMA address to write to or read from
> > @@ -39,25 +53,26 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
> >   * Please note, that the table size depends on CONFIG_SYS_MMC_MAX_BLK_COUNT and
> >   * we don't have to check for overflow.
> >   */
> > -void sdhci_prepare_adma_table(struct sdhci_adma_desc *table,
> > -			      struct mmc_data *data, dma_addr_t addr)
> > +void sdhci_prepare_adma_table(struct sdhci_host *host,
> > +			      struct sdhci_adma_desc *table,
> > +			      struct mmc_data *data, dma_addr_t start_addr)
> >  {
> > +	dma_addr_t addr = start_addr;
> >  	uint trans_bytes = data->blocksize * data->blocks;
> > -	uint desc_count = DIV_ROUND_UP(trans_bytes, ADMA_MAX_LEN);
> > -	struct sdhci_adma_desc *desc = table;
> > -	int i = desc_count;
> > +	void *next_desc = table;
> > +	int i = DIV_ROUND_UP(trans_bytes, ADMA_MAX_LEN);
> >
> >  	while (--i) {
> > -		sdhci_adma_desc(desc, addr, ADMA_MAX_LEN, false);
> > +		__sdhci_adma_write_desc(host, &next_desc, addr,
> > +					ADMA_MAX_LEN, false);
> >  		addr += ADMA_MAX_LEN;
> >  		trans_bytes -= ADMA_MAX_LEN;
> > -		desc++;
> >  	}
> >
> > -	sdhci_adma_desc(desc, addr, trans_bytes, true);
> > +	__sdhci_adma_write_desc(host, &next_desc, addr, trans_bytes, true);
> >
> > -	flush_cache((dma_addr_t)table,
> > -		    ROUND(desc_count * sizeof(struct sdhci_adma_desc),
> > +	flush_cache((phys_addr_t)table,
> > +		    ROUND(next_desc - (void *)table,
> >  			  ARCH_DMA_MINALIGN));
> >  }
> >
> > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > index 0178ed8a11..65090348ae 100644
> > --- a/drivers/mmc/sdhci.c
> > +++ b/drivers/mmc/sdhci.c
> > @@ -111,7 +111,7 @@ static void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data,
> >  	}
> >  #if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
> >  	else if (host->flags & (USE_ADMA | USE_ADMA64)) {
> > -		sdhci_prepare_adma_table(host->adma_desc_table, data,
> > +		sdhci_prepare_adma_table(host, host->adma_desc_table, data,
> >  					 host->start_addr);
> >
> >  		sdhci_writel(host, lower_32_bits(host->adma_addr),
> > @@ -897,8 +897,10 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
> >  		       __func__);
> >  		return -EINVAL;
> >  	}
> > -	host->adma_desc_table = sdhci_adma_init();
> > -	host->adma_addr = (dma_addr_t)host->adma_desc_table;
> > +	if (!host->adma_desc_table) {
> > +		host->adma_desc_table = sdhci_adma_init();
> > +		host->adma_addr = virt_to_phys(host->adma_desc_table);
> > +	}
> >
> >  #ifdef CONFIG_DMA_ADDR_T_64BIT
> >  	host->flags |= USE_ADMA64;
> > diff --git a/include/sdhci.h b/include/sdhci.h
> > index a1b74e3bd7..4bde7db5c7 100644
> > --- a/include/sdhci.h
> > +++ b/include/sdhci.h
> > @@ -291,6 +291,11 @@ struct sdhci_ops {
> >  	 * Return: 0 if successful, -ve on error
> >  	 */
> >  	int	(*set_enhanced_strobe)(struct sdhci_host *host);
> > +
> > +#if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
> > +	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
> > +				   dma_addr_t addr, int len, bool end);
> > +#endif
> >  };
> >
> >  #define ADMA_MAX_LEN	65532
> > @@ -526,8 +531,11 @@ extern const struct dm_mmc_ops sdhci_ops;
> >  #else
> >  #endif
> >
> > +void sdhci_adma_write_desc(struct sdhci_host *host, void **next_desc,
> > +			   dma_addr_t addr, int len, bool end);
> >  struct sdhci_adma_desc *sdhci_adma_init(void);
> > -void sdhci_prepare_adma_table(struct sdhci_adma_desc *table,
> > -			      struct mmc_data *data, dma_addr_t addr);
> > +void sdhci_prepare_adma_table(struct sdhci_host *host,
> > +			      struct sdhci_adma_desc *table,
> > +			      struct mmc_data *data, dma_addr_t start_addr);
> >
> >  #endif /* __SDHCI_HW_H */
> > --
> > 2.43.2
> 


