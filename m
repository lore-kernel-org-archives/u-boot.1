Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D795C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 20:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFD08851E;
	Fri, 26 Jul 2024 22:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722026295;
	bh=Ok1YgjjrqbIzJxWTLXJuVW7Wg3L5Sn6s7PsHFWL5U3U=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdm25Bf6jWH5eeOLfFcVsJLgHbXQDElQx0bZErW2Y205VPc8YB9WkY4nlAhnWNu4i
	 p4uB5SGJcrQmmQb5T4rNU5pi90DA1zYp5ZPgX2crF3EKWiAuJJkCG5MYl2lFUreMNm
	 EhwAfmeJy65w0wNCWVSluSV4vo4i8Ab1NpRSP/c3Zvx3zV1POCPkXEZkOw+hrt9Q3T
	 d9Ax3vVELgjSy4/nYQZV5rl5CF/lCkUODRpBZWZQCS2+EoeAjlgVrBBCZsZ9O17VxR
	 tIwNA8XbjviU2j3ocs0xTf2Ykz5S5ilIp6MXAgMzsvbWAwbNAzq9AwIItsSI9dLFpS
	 PKT8cIU0sv3Qg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AC33A87C7E;
 Fri, 26 Jul 2024 22:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722026294;
 bh=Ok1YgjjrqbIzJxWTLXJuVW7Wg3L5Sn6s7PsHFWL5U3U=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=USOFaVaehMJ4y2fG36FRVYIw+HH2Jufyiy4bqvSBCAJxBkuTBuXKD67iC6+MGhjZ1
 AZsOhDLTd1pXhCxG4AwVyFSuxlwPW1VxciZBXO7fgLHkJZ7knzX+N/5MdzUwKnU+yX
 C6f8+5FPZcgf7vx1/yES6rCeh6TwoOAgddObZimQUthZ07Hc6DfhOLQfbOWoIzSBOf
 oRn984xXALPOMw9KuOZsrIORv6ZCW8Tf9ANkmZjY58/pn1OnInRYaLFptrpuQENR1G
 YQQ68StypSHECChHZ/VUrTJsX4ePMI7pk55pyob2DFzCFLpiEXwdvEWpd9NfkyYdBp
 +xhmlc05vqrMg==
Message-ID: <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
Date: Fri, 26 Jul 2024 22:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] clk: imx8m: register ARM A53 core clock
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/26/24 6:01 PM, Z.Q. Hou wrote:
> Hi Marek,

Hi,

>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Friday, July 26, 2024 10:05 PM
>> To: Z.Q. Hou <zhiqiang.hou@nxp.com>; u-boot@lists.denx.de;
>> trini@konsulko.com; lukma@denx.de; seanga2@gmail.com;
>> festevam@gmail.com; Peng Fan <peng.fan@nxp.com>
>> Subject: Re: [PATCHv2] clk: imx8m: register ARM A53 core clock
>>
>> On 7/26/24 12:29 PM, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> Register ARM A53 core clock for i.MX 8M Mini, Nano and Plus.
>>
>> Why is MX8M(Q) not included here ?
> 
> I don't know iMX8MQ and it's not in my work plan.

Uh ... why are you adding this patch in the first place ?

Is there anything (driver? arch code?) which requires these clock ?

MX8M(Q) is very similar to the rest of the MX8M from the software 
perspective, also up to quad-A53.
