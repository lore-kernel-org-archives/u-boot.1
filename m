Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A681E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 10:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56128021D;
	Thu, 19 Dec 2024 11:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D428022B; Thu, 19 Dec 2024 11:27:58 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EBF08021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 11:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tODl3-0000n4-4d; Thu, 19 Dec 2024 11:27:53 +0100
Message-ID: <2200ece8-593b-4ac3-be3e-b05570165e5e@pengutronix.de>
Date: Thu, 19 Dec 2024 11:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX8/9: question about unused DDR PHY trained CSR board array
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "barebox@lists.infradead.org" <barebox@lists.infradead.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Steffen Trumtrar <str@pengutronix.de>
References: <8074530f-720b-4aea-934b-c0643c356617@pengutronix.de>
 <PAXPR04MB8459A8BB89FAB50D6871EA9388762@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <PAXPR04MB8459A8BB89FAB50D6871EA9388762@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Peng,

On 30.09.24 08:38, Peng Fan wrote:
>> Subject: i.MX8/9: question about unused DDR PHY trained CSR board
>> array
>> Looking at the DDR setup code for i.MX8M and i.MX9 that you had
>> contributed, I am wondering about struct
>> dram_cfg_param::ddrphy_trained_csr and the global
>> ddrphy_trained_csr array.
>>
>> struct dram_cfg_param::ddrphy_trained_csr is presumably generated
>> by the i.MX DDR tool and it seems populated by all the i.MX8M/9
>> boards in U-Boot.
>>
>> This struct member is wholly unused though and instead a global
>> ddrphy_trained_csr is used.
>>
>> What I wonder about is whether it's possible for the DDR tool to
>> generate a different ddrphy_trained_csr than the default:
>>
>>   1) If yes, we should drop the global ddrphy_trained_csr and actually
>> use
>>      the board-specific array
>>
>>   2) If not, we should drop the board-specific array and perhaps ask for
>>     the DDR tool to be changed
>>
>> I initially assumed 1) and because all boards supported by barebox had
>> a board-specific ddrphy_trained_csr that's identical to the global
>> ddrphy_trained_csr, I dropped the unused array[1][2].
>>
>> I now have the DDR settings for an i.MX9 LPDDR4 board in front of me
>> that has different contents for struct
>> dram_cfg_param::ddrphy_trained_csr than the default.
>>
>> I will inquire how that came about, but in parallel I wanted to ask you if
>> this is supposed to happen and to alert you to this issue.
> 
> Thanks for raising this issue. I think board specific csr should be used.
> 
> I will check with DDR TOOL owners on this.

Did you hear back in the meantime?

Thanks,
Ahmad

> 
>>
>> The way things are, this is either a bug or a missed space saving
>> opportunity for U-Boot.
> 
> Thanks,
> Peng.
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
