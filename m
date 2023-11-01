Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6ECC4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 05:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884FA8769D;
	Wed,  1 Nov 2023 06:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="cY7hQTTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27AC987CEA; Wed,  1 Nov 2023 06:45:56 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801CA87D03
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 06:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101054548epoutp04847969417db52cb2e8240e6d886dd8c5~TaY9UTDdD1730217302epoutp04s
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 05:45:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101054548epoutp04847969417db52cb2e8240e6d886dd8c5~TaY9UTDdD1730217302epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698817548;
 bh=NV/6nvDNGIGURA54CxsLf16gEa5tkjuA1BKTk9MbOlM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=cY7hQTTDYkeflqNzXbQlkhEbXabNYAGWYMQSNCONP5uPkc0wDe4xLfrpUPN8eMBCG
 lE5p4fHVMAS4QUw1dsYPCiJRhrwT6BHusYjzePUfiE9rmgHyV/YBY2cpiir55q306Y
 14EsKJ3XnAhDO1yFWY1AXOVdXsUJmX+gsVBnoJg4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231101054548epcas1p1a6e54e0d222bd5a784c0ec110f9ab407~TaY9DthfI2429024290epcas1p1S;
 Wed,  1 Nov 2023 05:45:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.234]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKwwC2yF1z4x9Q2; Wed,  1 Nov
 2023 05:45:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 95.D8.09744.B06E1456; Wed,  1 Nov 2023 14:45:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101054547epcas1p313d45da890d2c3dc03ab440a751dd3e0~TaY7shz9O1249612496epcas1p3Z;
 Wed,  1 Nov 2023 05:45:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101054547epsmtrp1b1cf8dbbcf3b0ded5871bea7c6ffd340~TaY7r3IzM2135521355epsmtrp1V;
 Wed,  1 Nov 2023 05:45:47 +0000 (GMT)
X-AuditID: b6c32a35-eabff70000002610-f4-6541e60b0927
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.0F.08817.A06E1456; Wed,  1 Nov 2023 14:45:46 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101054546epsmtip2f09ed323073008acf683db7db201081f~TaY7hHFa50811208112epsmtip2t;
 Wed,  1 Nov 2023 05:45:46 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Henrik Grimler'" <henrik@grimler.se>, "'Sean Anderson'"
 <sean.anderson@seco.com>
Cc: <u-boot@lists.denx.de>, "'Rayagonda	Kokatanur'"
 <rayagonda.kokatanur@broadcom.com>, "'Bharat Kumar Reddy Gooty'"
 <bharat.gooty@broadcom.com>
In-Reply-To: <018b01da0c5f$fe8e3550$fbaa9ff0$@samsung.com>
Subject: RE: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
Date: Wed, 1 Nov 2023 14:45:46 +0900
Message-ID: <020a01da0c86$a966ab80$fc340280$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkfDbXQ+XSUf1bqSstKAK0/j5oAwHLhqSzAbZ7QqEDPyTDT7CaC5fQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQJf7mWOqwb/LohYX/h9ns3i7ZBej
 xfalTawW8+63MFm83dvJ7sDqMev+WTaPo1fusXqcvbOD0ePZv2/sASxR2TYZqYkpqUUKqXnJ
 +SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIuVFMoSc0qBQgGJxcVK+nY2
 RfmlJakKGfnFJbZKqQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ09fLF3QpVly4eZy1
 gfGjZBcjJ4eEgInE/jdXmboYuTiEBHYwShyes4UVwvnEKNF0+CYzhPONUeLd7q9AGQ6wlm8P
 wyDiexklFq77zAbhvGSU2HNtOTvIXDYBPYn/ixYyg9giAhESB48vA9vBLDAFaNKh82AJTgEr
 iRPPLwJNZecQFrCTaFUEmc8ioCLx+E05SAGvgKXEhlWzWCFsQYmTM5+wgNjMAvIS29/OYYb4
 QEHi59NlrBCb3CSuHTrFBFEjIjG7sw3sfgmBVg6J/V96GSEaXCRmt8HYwhKvjm9hh7ClJF72
 t7FDNDQzSixdcpAVwulhlPjXcJ0NospYYv/SyUwglzILaEqs36UPEVaU2Pl7LiPEZj6Jd197
 oIHFK9HRJgRRoiJx6fVLJphdd5/8Z53AqDQLyW+zkPw2C8kPsxCWLWBkWcUollpQnJueWmxY
 YAiP6+T83E2M4CSpZbqDceLbD3qHGJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1JLT7E
 aAoM7InMUqLJ+cA0nVcSb2hiaWBiZmRsYmFoZqgkzsv8qDdFSCA9sSQ1OzW1ILUIpo+Jg1Oq
 gUnkQUDwnowjLb0lBf2sFjnO3FJ3/9T8qv1Zvv+qr2Oh7boWnetiz69ZXLBaonT8stllsUsM
 FTwNCs/8Y9d2hnK7Hr6VNtPZZ/WVFb/P/D3Bx7xmvdi5WwU+Cst1rpQvZo2ebGjl8ottVYH0
 iZDENKep3xWai34uKttyqOCF+mrJllfStdEnDV0fTj0fnBHL8+j3rAc72v3EPL5MWyxx8XN0
 zpnY9LMdfCvWJSsHb762X/zFJPsfPcfifzJevC0TxNX1JGdvhffGNzeezDJUMDN8xVz2iK9x
 jU/Vxbl6d9Kbt52MEC6Yvtn4ecWO/K9dFzMKmKZvfXCDc6bx67WKl9l8u/0jPk7iCppiyhxr
 vVCJpTgj0VCLuag4EQBjHibDGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvC7XM8dUg/a/lhYX/h9ns3i7ZBej
 xfalTawW8+63MFm83dvJ7sDqMev+WTaPo1fusXqcvbOD0ePZv2/sASxRXDYpqTmZZalF+nYJ
 XBnT18sXdClWXLh5nLWB8aNkFyMHh4SAicS3h2FdjFwcQgK7GSX6WjsZuxg5geJSEp+fTmWD
 qBGWOHy4GKLmOaPE/GdbWUBq2AT0JP4vWsgMYosIREgc2T+RCaSIWWAKo8Tmh0tZITpeMEqc
 ebOJDaSKU8BK4sTzi0AJdg5hATuJVkWQ+SwCKhKP35SDFPAKWEpsWDWLFcIWlDg58wnYKmYB
 bYmnN59C2fIS29/OYYY4U0Hi59NlrBAnuElcO3SKCaJGRGJ2ZxvzBEbhWUhGzUIyahaSUbOQ
 tCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcK1paOxj3rPqgd4iRiYPxEKME
 B7OSCO9hU4dUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODil
 GpgKerKX/b9afH+7n8PVD8uvzpuasObHz9wNyy6L6G4/pF3Z+ybhbUPU17R5RrOe1s/XWGAW
 c03+lh1XmUdU8CrJTl0/3RuHS33WqTqdjCnW2Jt8+NTOE/n/ufY4lGw3V7Le+oCjYcmtyDqW
 9B6t+RMmRuXM0Z30Kt9YKDV/kseNHo78nmsr31xx/nDTZN7cji7brYyKcXJRqvseJ01NafNi
 ervv6ERPt7DlU/vzq9J6Gt+srb/Navd0yb7Ipq99K7q5d7UIau7v2lF3L0d0zY/ja9vXtk0N
 U1udH8Pu/oW9Q/5b1FNJrkcz9E7ahE6p0j2dpK87tUqDYZP1m5Jlj3bzfg/yTJr8MHeqrOIL
 1idKLMUZiYZazEXFiQDhxxpBBAMAAA==
X-CMS-MailID: 20231101054547epcas1p313d45da890d2c3dc03ab440a751dd3e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231028203117epcas1p35399709e03bceaaeee24d53537118823
References: <20231027205702.1549693-1-sean.anderson@seco.com>
 <CGME20231028203117epcas1p35399709e03bceaaeee24d53537118823@epcas1p3.samsung.com>
 <ZT1viTCUl-LKj8Dm@grimlerstat.localdomain>
 <018b01da0c5f$fe8e3550$fbaa9ff0$@samsung.com>
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



> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Wednesday, November 1, 2023 10:09 AM
> To: 'Henrik Grimler' <henrik@grimler.se>; 'Sean Anderson' <sean.anderson@seco.com>
> Cc: u-boot@lists.denx.de; 'Rayagonda Kokatanur' <rayagonda.kokatanur@broadcom.com>; 'Bharat Kumar
> Reddy Gooty' <bharat.gooty@broadcom.com>
> Subject: RE: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
> 
> Hi,
> 
> > -----Original Message-----
> > From: Henrik Grimler <henrik@grimler.se>
> > Sent: Sunday, October 29, 2023 5:31 AM
> > To: Sean Anderson <sean.anderson@seco.com>
> > Cc: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>; Rayagonda Kokatanur
> > <rayagonda.kokatanur@broadcom.com>; Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
> > Subject: Re: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
> >
> > Hi Sean,
> >
> > Tested on odroid-u2 (exynos4412-odroid) on top of 2024.01-rc1, still
> > works fine, so feel free to add:
> >
> > Tested-by: Henrik Grimler <henrik@grimler.se>
> >
> > Best regards,
> > Henrik Grimler
> >
> > On Fri, Oct 27, 2023 at 04:57:03PM -0400, Sean Anderson wrote:
> > > As noted in commit 3a6383207be ("mmc: sdhci: add the quirk for broken
> > > r1b response"), some MMC controllers don't always set the transfer
> > > complete bit with R1b responses.
> > >
> > > According to the SD Host Controller Simplified Specification v4.20,
> > >
> > > > In the case of a command pairing with response-with-busy[, Transfer
> > > > Complete] is set when busy is de-asserted. Refer to DAT Line Active
> > > > and Command Inhibit (DAT) in the Present State register.
> > >
> > > By polling the DAT Line Active bit in the present state register, we can
> > > detect when we are no longer busy, without waiting for a long timeout.
> > > This results in much faster reads/writes on buggy controllers.
> > >
> > > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to u-boot-mmc/master. Thanks!

Best Regards,
Jaehoon Chung

> 
> Best Regards,
> Jaehoon Chung
> 
> > > ---
> > > I've CC'd a few people who've added this quirk to controllers recently.
> > > Please let me know if your hardware still works. It's possible that my
> > > hardware is buggy in a different way.
> > >
> > >  drivers/mmc/sdhci.c | 19 ++++++++++++-------
> > >  include/sdhci.h     |  1 +
> > >  2 files changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > > index fc9c6c37996..0178ed8a11e 100644
> > > --- a/drivers/mmc/sdhci.c
> > > +++ b/drivers/mmc/sdhci.c
> > > @@ -306,14 +306,19 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
> > >  		if (stat & SDHCI_INT_ERROR)
> > >  			break;
> > >
> > > -		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> > > -			if (host->quirks & SDHCI_QUIRK_BROKEN_R1B) {
> > > +		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
> > > +		    cmd->resp_type & MMC_RSP_BUSY && !data) {
> > > +			unsigned int state =
> > > +				sdhci_readl(host, SDHCI_PRESENT_STATE);
> > > +
> > > +			if (!(state & SDHCI_DAT_ACTIVE))
> > >  				return 0;
> > > -			} else {
> > > -				printf("%s: Timeout for status update!\n",
> > > -				       __func__);
> > > -				return -ETIMEDOUT;
> > > -			}
> > > +		}
> > > +
> > > +		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> > > +			printf("%s: Timeout for status update: %08x %08x\n",
> > > +			       __func__, stat, mask);
> > > +			return -ETIMEDOUT;
> > >  		}
> > >  	} while ((stat & mask) != mask);
> > >
> > > diff --git a/include/sdhci.h b/include/sdhci.h
> > > index 70fefca2a97..a1b74e3bd79 100644
> > > --- a/include/sdhci.h
> > > +++ b/include/sdhci.h
> > > @@ -57,6 +57,7 @@
> > >  #define SDHCI_PRESENT_STATE	0x24
> > >  #define  SDHCI_CMD_INHIBIT	BIT(0)
> > >  #define  SDHCI_DATA_INHIBIT	BIT(1)
> > > +#define  SDHCI_DAT_ACTIVE	BIT(2)
> > >  #define  SDHCI_DOING_WRITE	BIT(8)
> > >  #define  SDHCI_DOING_READ	BIT(9)
> > >  #define  SDHCI_SPACE_AVAILABLE	BIT(10)
> > > --
> > > 2.35.1.1320.gc452695387.dirty
> > >


