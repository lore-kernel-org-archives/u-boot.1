Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942E8E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44AD8021D;
	Fri, 20 Dec 2024 07:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2293F80243; Fri, 20 Dec 2024 07:12:36 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C357E80087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tOWFT-0000WU-TS; Fri, 20 Dec 2024 07:12:31 +0100
Message-ID: <30375711-d4a8-4e53-a804-a721d45e0ac1@pengutronix.de>
Date: Fri, 20 Dec 2024 07:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX8/9: question about unused DDR PHY trained CSR board array
To: Ye Li <ye.li@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "barebox@lists.infradead.org" <barebox@lists.infradead.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Steffen Trumtrar <str@pengutronix.de>
References: <8074530f-720b-4aea-934b-c0643c356617@pengutronix.de>
 <PAXPR04MB8459A8BB89FAB50D6871EA9388762@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <2200ece8-593b-4ac3-be3e-b05570165e5e@pengutronix.de>
 <d4acb710-7c80-4b71-862e-cee0a16d8cba@oss.nxp.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <d4acb710-7c80-4b71-862e-cee0a16d8cba@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello Ye Li,

On 20.12.24 02:58, Ye Li wrote:
> On 12/19/2024 6:27 PM, Ahmad Fatoum wrote:
>> On 30.09.24 08:38, Peng Fan wrote:
>>>> I now have the DDR settings for an i.MX9 LPDDR4 board in front of me
>>>> that has different contents for struct
>>>> dram_cfg_param::ddrphy_trained_csr than the default.
>>>>
>>>> I will inquire how that came about, but in parallel I wanted to ask you if
>>>> this is supposed to happen and to alert you to this issue.
>>> Thanks for raising this issue. I think board specific csr should be used.
>>>
>>> I will check with DDR TOOL owners on this.
>> Did you hear back in the meantime?
> 
> We have discussed this internally. The DDR tool may generate different board specific csr. Currently in DDR retention, because we load csr + ddr_phy_pie, so it is safe to use this global csr.

So ddr_phy_pie contains the firmware to the DDR PHY µC and it will
train the PHY and thus will iron over any missing entries in the
stored CSR? Is my understanding correct?

> But we agree this global csr is confused and waste some memory. It is better to switch to the board csr.

Thanks for the confirmation.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
