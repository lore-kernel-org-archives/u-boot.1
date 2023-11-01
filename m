Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6583DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 01:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FE287B87;
	Wed,  1 Nov 2023 02:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="jfYVwcfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDEC87BB0; Wed,  1 Nov 2023 02:09:12 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A19487B85
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 02:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101010900epoutp04d3b6e18e58a70710ffa139d4d71564ca~TWnSHEn4I2211922119epoutp04G
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 01:09:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101010900epoutp04d3b6e18e58a70710ffa139d4d71564ca~TWnSHEn4I2211922119epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698800941;
 bh=wu3k5RR9Yvf8NX16WnwB/y81i9lQI+OG1isE2cEF8Lw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=jfYVwcfXomwuQpbrt2uzYdRZEow9EmsvVPX0s+HZWQ/WZZk8B9iHs6WXwPa5rrof4
 D/brxpitgYYw35Bo6f7lThnCl180Oy19cZAxf2Ff/gXUNPP7+D7JYKWrVLOJkYhE2i
 27UVdSTXKYPEZ3F2VaDOxVMQtkLwuxrWO9aa94n4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231101010900epcas1p24e9dbf1a5e3dd2ef637004d4ef4d116b~TWnR8K0F_3192331923epcas1p2N;
 Wed,  1 Nov 2023 01:09:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.231]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKpmq6JLfz4x9Q2; Wed,  1 Nov
 2023 01:08:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 AF.E6.09744.B25A1456; Wed,  1 Nov 2023 10:08:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101010859epcas1p157d08937fd7964a5fff2866c100fdd70~TWnQy8jNf2816428164epcas1p14;
 Wed,  1 Nov 2023 01:08:59 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101010859epsmtrp2272e767f972ebfd9c8ced4cedf80d364~TWnQyVjSN1642916429epsmtrp2x;
 Wed,  1 Nov 2023 01:08:59 +0000 (GMT)
X-AuditID: b6c32a35-7239ea8000002610-98-6541a52bf391
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8F.DC.07368.B25A1456; Wed,  1 Nov 2023 10:08:59 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101010859epsmtip1bed30c24f8feec635ca228620dfb3bca~TWnQh25Qp1677816778epsmtip1R;
 Wed,  1 Nov 2023 01:08:59 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Henrik Grimler'" <henrik@grimler.se>, "'Sean Anderson'"
 <sean.anderson@seco.com>
Cc: <u-boot@lists.denx.de>, "'Rayagonda	Kokatanur'"
 <rayagonda.kokatanur@broadcom.com>, "'Bharat Kumar Reddy Gooty'"
 <bharat.gooty@broadcom.com>
In-Reply-To: <ZT1viTCUl-LKj8Dm@grimlerstat.localdomain>
Subject: RE: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
Date: Wed, 1 Nov 2023 10:08:59 +0900
Message-ID: <018b01da0c5f$fe8e3550$fbaa9ff0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkfDbXQ+XSUf1bqSstKAK0/j5oAwHLhqSzAbZ7QqGws7UwUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTT1d7qWOqQf9HI4sL/4+zWbxdsovR
 YvvSJlaLefdbmCze7u1kd2D1mHX/LJvH0Sv3WD3O3tnB6PHs3zf2AJaobJuM1MSU1CKF1Lzk
 /JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoMVKCmWJOaVAoYDE4mIlfTub
 ovzSklSFjPziElul1IKUnALTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMu6tOsxXsla7on3SL
 pYHxrGgXIyeHhICJxL+j11i6GLk4hAR2MEqc7roP5XxilJjc18sE4XxjlDh0aQ47TMv/p89Z
 IRJ7GSW2zFkE5bxklHg26SwzSBWbgJ7E/0ULwWwRgQiJg8eXgY1iFpjCKPHu0HmwBKeAuUTf
 s+dAC9k5hAXsJFoVQaIsAioSu1e9YASxeQUsJVobNrBD2IISJ2c+YQGxmQXkJba/ncMMcZCC
 xM+ny1ghVjlJ/Gl8A1UjIjG7s40ZZK2EQCuHxKyvs1ggGlwkLh+5xwRhC0u8Or4F6jMpic/v
 9rJBNDQzSixdcpAVwulhlPjXcJ0NospYYv/SyUDdHEArNCXW79KHCCtK7Pw9lxFiM5/Eu689
 rCAlEgK8Eh1tQhAlKhKXXr9kgtl198l/1gmMSrOQ/DYLyW+zkPwwC2HZAkaWVYxiqQXFuemp
 xYYFhvDoTs7P3cQITpVapjsYJ779oHeIkYmD8RCjBAezkgjvYVOHVCHelMTKqtSi/Pii0pzU
 4kOMpsDQnsgsJZqcD0zWeSXxhiaWBiZmRsYmFoZmhkrivMyPelOEBNITS1KzU1MLUotg+pg4
 OKUamJYWvOMt+3XJ8vfTaeGfNF7uFOn+vHH6ZcVl87gm754hrMBftkzuiYy+gMWG859uXJgp
 WRShoss3f63iMstLx0TvLSv9FrdvzRy/wOMdJ0+Wf2mUM8m+tz72oWbtmSelVzjtXVjvyyxn
 VVu8tO26u8zp+keehv2Vei+ad4RoLr+Sv+zZMqNi7tlKFUknenaulat8Y+C8Sf5WInvhj0O3
 t1ua7fF0sas3XLenhLEjedLa99x7ri7ULinaPrX30Ny57Mundk/5XWciLBY/pdLymVrvlzsX
 xa1b9YM4DN5dk0+TiF3x6enL06lMWnJqAh1muw9OlXzK6/rthHNCkfmxHpurPb1972b+av0y
 51n4AyklluKMREMt5qLiRADss16aHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnK72UsdUg4kfpCwu/D/OZvF2yS5G
 i+1Lm1gt5t1vYbJ4u7eT3YHVY9b9s2weR6/cY/U4e2cHo8ezf9/YA1iiuGxSUnMyy1KL9O0S
 uDLurjrNVrBXuqJ/0i2WBsazol2MnBwSAiYS/58+Z+1i5OIQEtjNKHHk4BtmiISUxOenU9m6
 GDmAbGGJw4eLIWqeM0rsftMBVsMmoCfxf9FCMFtEIELiyP6JTCBFzAJTGCU2P1wKNXUXo8SS
 zjcsIFWcAuYSfc+eA9nsHMICdhKtiiBRFgEVid2rXjCC2LwClhKtDRvYIWxBiZMzn7CA3MAM
 tKttI1gJs4C8xPa3c6DOVJD4+XQZK8QJThJ/GiEWMQuISMzubGOewCg8C8mkWQiTZiGZNAtJ
 xwJGllWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMHRoqWxg/He/H96hxiZOBgPMUpw
 MCuJ8B42dUgV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1Oq
 gSm8R3mVY8JxrYNvez/WLWb98ngO482sDyEzDF5Z+Thy+K578cV7dvS2W3Jfjq+zn1+h+uHq
 e1XBsuUfpvHXKJjaLmOacH9a8ezyh8+XPjnGcf6tvMREdZO9j5PjHPpr9rC4qImYXPv8dLW3
 1IWaRY36vz2lGA4dXvaHWaM15dzyVfET9h+e8Oetkeu9iW5nT4aYnj21ifmq3BZTFufqg77C
 91eeUNn1xGjiww/W66YbHJ+RLPGf13OHT6eeZtacmB9i7lytyiuM5nzof3bmeoepSmDDetcz
 WTfs4qUmLQ551C1y8lS8z2bp/ZrvRILXrP0VwFP55OSmRS/SG8RW9F14n1nzKHhuxZ3cGauz
 wtNqlFiKMxINtZiLihMB7GOQDAUDAAA=
X-CMS-MailID: 20231101010859epcas1p157d08937fd7964a5fff2866c100fdd70
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
> From: Henrik Grimler <henrik@grimler.se>
> Sent: Sunday, October 29, 2023 5:31 AM
> To: Sean Anderson <sean.anderson@seco.com>
> Cc: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>; Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com>; Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
> Subject: Re: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
> 
> Hi Sean,
> 
> Tested on odroid-u2 (exynos4412-odroid) on top of 2024.01-rc1, still
> works fine, so feel free to add:
> 
> Tested-by: Henrik Grimler <henrik@grimler.se>
> 
> Best regards,
> Henrik Grimler
> 
> On Fri, Oct 27, 2023 at 04:57:03PM -0400, Sean Anderson wrote:
> > As noted in commit 3a6383207be ("mmc: sdhci: add the quirk for broken
> > r1b response"), some MMC controllers don't always set the transfer
> > complete bit with R1b responses.
> >
> > According to the SD Host Controller Simplified Specification v4.20,
> >
> > > In the case of a command pairing with response-with-busy[, Transfer
> > > Complete] is set when busy is de-asserted. Refer to DAT Line Active
> > > and Command Inhibit (DAT) in the Present State register.
> >
> > By polling the DAT Line Active bit in the present state register, we can
> > detect when we are no longer busy, without waiting for a long timeout.
> > This results in much faster reads/writes on buggy controllers.
> >
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> > ---
> > I've CC'd a few people who've added this quirk to controllers recently.
> > Please let me know if your hardware still works. It's possible that my
> > hardware is buggy in a different way.
> >
> >  drivers/mmc/sdhci.c | 19 ++++++++++++-------
> >  include/sdhci.h     |  1 +
> >  2 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > index fc9c6c37996..0178ed8a11e 100644
> > --- a/drivers/mmc/sdhci.c
> > +++ b/drivers/mmc/sdhci.c
> > @@ -306,14 +306,19 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
> >  		if (stat & SDHCI_INT_ERROR)
> >  			break;
> >
> > -		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> > -			if (host->quirks & SDHCI_QUIRK_BROKEN_R1B) {
> > +		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
> > +		    cmd->resp_type & MMC_RSP_BUSY && !data) {
> > +			unsigned int state =
> > +				sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +
> > +			if (!(state & SDHCI_DAT_ACTIVE))
> >  				return 0;
> > -			} else {
> > -				printf("%s: Timeout for status update!\n",
> > -				       __func__);
> > -				return -ETIMEDOUT;
> > -			}
> > +		}
> > +
> > +		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> > +			printf("%s: Timeout for status update: %08x %08x\n",
> > +			       __func__, stat, mask);
> > +			return -ETIMEDOUT;
> >  		}
> >  	} while ((stat & mask) != mask);
> >
> > diff --git a/include/sdhci.h b/include/sdhci.h
> > index 70fefca2a97..a1b74e3bd79 100644
> > --- a/include/sdhci.h
> > +++ b/include/sdhci.h
> > @@ -57,6 +57,7 @@
> >  #define SDHCI_PRESENT_STATE	0x24
> >  #define  SDHCI_CMD_INHIBIT	BIT(0)
> >  #define  SDHCI_DATA_INHIBIT	BIT(1)
> > +#define  SDHCI_DAT_ACTIVE	BIT(2)
> >  #define  SDHCI_DOING_WRITE	BIT(8)
> >  #define  SDHCI_DOING_READ	BIT(9)
> >  #define  SDHCI_SPACE_AVAILABLE	BIT(10)
> > --
> > 2.35.1.1320.gc452695387.dirty
> >

