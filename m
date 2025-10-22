Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58EACCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC25E8392C;
	Wed, 22 Oct 2025 09:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vfr4S8Ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8649983303; Wed, 22 Oct 2025 09:11:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3036A82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAZJPJH4z4Rhuuj1Nc1VdkjCVh5oxAkkIhRdLwx87O6731EHVVUSn+bTlova+ljFU1LeRTeMQAafF/LCTykzuMXyBI4jiXNzTArUveJx9y7ng8v/w+bIDFvfdlZAxooyNYtZKDe4eiw6lAveXlFzOaCMmBR2RhX5rNtPbJzUkUBhdh0CAgJV0KvXMU1jOilNC+9I1p5vhaThWdaKQ8Tmn/p3Q8y6rijVmjG5HrkMqEx+pFDRPdxpXzlUuTkz6STd0OsLofS8GPehr4bgZWJP1HvwOqkcwPGicXR3fPKJeO9v+WRk5PCTTSLwz3r1z+Tt3uOTHToQ2Lj1YpLWFcniIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2V8Oys7mHVutYQ89nuV5rvm/5L46E+EMmnY6FcmqXI=;
 b=Th9QE8TUR0Xm8OwQVBHNvWbDE/jskmE9WSyPetc8f8GUavbw8M76cEXuAmHOwpkqbKXyKUoIcEoSTeVN0kKd3Ngi0f6wGfqn8GgGxA17my/p2SJFdXzI5KcSPpnizV9J7In/i3exhlA7IMqtIe6P2VPl471JamV8Yo/sayvuM5alQQP4l9a5Pbp/+HH8Erx2n2/Pjm+zGA9LhIcijQfusn0/x9lQhPD+7oiot1XenicMRO+r8elrtVhSauOgFVc9MNA5QVqWbdtJ76YtHI2OkvGovrUeWp4ZROuYpswV8+kKCXRFEGK+DTUKGhDItlvi4SuqnFRFKNrQBs8AplgDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2V8Oys7mHVutYQ89nuV5rvm/5L46E+EMmnY6FcmqXI=;
 b=vfr4S8HoyCvapAx1IGqrJXusxFHjI53LBTXePJVBwelEkBxV8tQnoU96fKxRGsSiy5HdhiYfmmB9SYMxG/ycWOUZWtkqNuXQrvPu3NO8Khif79Z2yZEt1eAz+Um1rp5BLQ4NRO2jH/3Z3DMqAaVIefmzQvZXM3oR3lobeLl/2UpbWSBwXOUTLwTXLI9sYEHR/oQ1YVDroxcWVCDXtaxUywvP4OFE0JfDWIReLCMDn9SceLkfWi9H68u4kxmaJ6F2N5T1WKH0zIHK9EtXFpo0usnjyHcQzZqZIFzJgw8IM2wxGTps7bVdNFTnZI+Nz7wdr9ifBix4ghaWyxKiYa6ZHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:10:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:10:59 +0000
Date: Wed, 22 Oct 2025 16:23:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 2/6] power: pmic: s2mps11: add support for allowing
 multiple device variants
Message-ID: <20251022082313.GK30163@nxa18884-linux.ap.freescale.net>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
 <20251017-power-pmic-regulator-s2mpu05-v1-2-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-2-91cadc0f4156@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 426b5363-a838-4494-c7b0-08de113a272d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7LwzyDRg5Y0jNjTqZU35uFA9lZFwOIwzjr/77/aa4rN4s+wAtkINgtjTTPu?=
 =?us-ascii?Q?KqPVexESnlXEwyUrXy7Qj1OiHQkbigyEcNw3Ytvhq6fXd3NwsjaPSG/oEo1x?=
 =?us-ascii?Q?99IzAZl4cpSXCTaEaR97H6/Jo5oib2nYozrU7CV1IddKLKfIftz/TbWAEQJn?=
 =?us-ascii?Q?bMrqgX8GBAW3/ZPToRZRNhoxVFUbwM54sBCWSeFNqMh+Vv4w56yHfsuUe4Gv?=
 =?us-ascii?Q?NDXjIyqbjlVYEiCtUGOEdkx4sexP1OJW7//d22vlceM1AAE1zMQO748keTU4?=
 =?us-ascii?Q?EYDoeyWpqTQhY7svBXelMT7lT6aP3XyktwfkuQkuZ2awHWAJdGlsQyHnxH/5?=
 =?us-ascii?Q?hJ7FFPoAhCArcQU80NpyhNrKuUiVkvyBUQN2g+7vXF3gBi+eIzj1KuUf3Pnd?=
 =?us-ascii?Q?30YIoJFQPhd8SUEM+8dOiGiTt1h/bb5Phhgxco1P6/8eaHCrnMHFa0sjMArE?=
 =?us-ascii?Q?9Lc6D6qg+L/nMPeCqXyVQSjqm7xjdjgVWb2gXmS2eWdN3cnLIC24722vlgMj?=
 =?us-ascii?Q?oDsqxuUsqY/gBlW1XLH4xoaF2gBjczd7ZFPEjJmfYbFZxQL1flMgp9QnyIg1?=
 =?us-ascii?Q?uhVf4eOXS+R6lu1lVRVXP6J5TBSzp5wHG64tMbAPsAcBS2/hlyzsNgxfXr6r?=
 =?us-ascii?Q?RiY/pa0wM9k+eIHwRBozNSALip+iwPK7Mf9lQBU24Euw5xPAh9sFuyuLry/G?=
 =?us-ascii?Q?Sb6n9Qp1ZXml3NZbdHsOdXbv3FEozIJpEqh4nZjw/A8SV1Vt8fRFBt2evXl/?=
 =?us-ascii?Q?gEBYKpzFTmbberp+rJADLLAVU63JLkWhl+58oRKYkYU38ntci71oW901r0+R?=
 =?us-ascii?Q?b6HN8/x55Cel2FxanKVaQ9/n9T1R4/+HziwniWCvdY2VrthGmWvq7orUpf6W?=
 =?us-ascii?Q?+A3aUFzYZ3NUVB+3nR4vD50srS5kDu1Z9CcBlBZ/Q3G/S4B/NexD5CpHLsSN?=
 =?us-ascii?Q?u4pN9Yl5BE+Qsc5p17A9qv7J6pd7nCyO3M3QJG9Hv3A0FuvbNa7KRefqz8KG?=
 =?us-ascii?Q?JACn62wXEVGJBh0FSBHOTEeG0nVXeLMHMpHS1KVNqEC3SWceTn6odCAmzKVo?=
 =?us-ascii?Q?/+Mx3ZgF/NLdXn3CbGbWI9EH48OtzxpQMy4rGuGPjpWzy1lmEJxj6ghMdmey?=
 =?us-ascii?Q?m5aDAzPRJ5Cw1daNMjqFv6Gg99vNoo5Q8rnmFC2gtowH541vkcCk/tsG8drt?=
 =?us-ascii?Q?0A47r3DrfcwGH+Rk7wJRviwLJNBjIC9+OnNPfoDCwMQtqjxFQU1HNCHLvIh7?=
 =?us-ascii?Q?7MMdwxVbtZxaE6/cNX3yk8WryzPOzikJ/0GSrFU5oyi6zpbKv6dNjvpccgO5?=
 =?us-ascii?Q?P9uGVio70i+M8+6fbCHClNgwQj7XU9jjrf3EMW5iUDBGM0YpIhZdHXsJQUoe?=
 =?us-ascii?Q?KoAXI+M7gUUMxO951zFNFk9vdVniQCYTHRQW3nSwFlVjb+ri79O/l6lNnAvO?=
 =?us-ascii?Q?5eoSj6C+o5U8XMr50BaUEfjyF8E31BPEgIZ5CSgc9sS4Lm6q3Q5oHVLIID6v?=
 =?us-ascii?Q?4IVpbIE13QCtZBEMvU2gxNmpy8XQkJrixZVN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tg0dwOQQHLstnKSfxuq39jf36YpnBft8fYR1C7dwS1wNcVu579/YF52b4ZdB?=
 =?us-ascii?Q?g76e0taRVPaoR1FsFQJUPEaaPJxweNC8ZGufh1Os7cniPAOTqHv/AKmcsNhe?=
 =?us-ascii?Q?AFR1JB6OWeaYEhxY3Xh1lIuOCXxesubBabhTPkN3V7I64tALKxzFG8aMnZfA?=
 =?us-ascii?Q?DQ5wVHfqA1EEQ2fXmBLTjA3UMhMU4T37/EKXkAe40PWEIiLUT4ILcoYrg+Hi?=
 =?us-ascii?Q?NbpIqVt9Q4amWj9sbNN3ATf886IagcSG2WZWv+Zl8Pf8QrfX/NK1W54jh0h+?=
 =?us-ascii?Q?e6hrYWKhxRCrL6V9azJr5yHns5/1G31MUCKljKMwyk++3oq7ZuLna/9LJoie?=
 =?us-ascii?Q?2nrM9IEvKkY9LVoFcyInejieNDBkoPGom2pFmhrku4n2sg1TbjbjCyXaGiTv?=
 =?us-ascii?Q?Bn8Q8XmOwuQctRmoP7JryvygehskOmCqQmcIU6dVHrz7fgsGRK2OjZ7fVDcZ?=
 =?us-ascii?Q?5CvLbVZGfLs2gUE0hn37JvXihXP0R/G2Rq3b5x5pZ2fcq5+I9EbbiYMRvV6n?=
 =?us-ascii?Q?9aw2l93adTLYtfS5zYfrqPqKjxDO5oM5tyi9I7SsZSRwKEITFH5zsdn0MKih?=
 =?us-ascii?Q?d02qV8VeRURgJZaYtJ0p63NmVdUUWgFK0IWPXtdExnuJvJ4D/0G6Ruvhy9JF?=
 =?us-ascii?Q?0wVdfQgBO44YKH3apFVA/IhrspLPlTHAjJqM1zXKxpd47zb4foa9mcFRsGd+?=
 =?us-ascii?Q?XgDMW2thYA7tU0jYzynbvw6eOJJOABeHLVlbE0mk3AkPANExhsYAqA3CIWjR?=
 =?us-ascii?Q?VBwh5E5piNj69/YL2zAgM+LZGF0n5LV4NGqa6tYlsgja8at4mGBupk3Bd+sZ?=
 =?us-ascii?Q?VPReP7jzD43m4YD0aoURv3h8vCP9iEgJR1hExYN+f/pfDbaMTtNHZvnIE4x5?=
 =?us-ascii?Q?wdF9vrVm2YCqYbDsDBlU565VxG/G0nBAOoTLdkC7X55sMUVIJA2o120huF+z?=
 =?us-ascii?Q?oTCdIraK5O0t4IpRcnKIxIQzH0Mb1hpu5otxg5gKpCtVcd94mGjFA2EOHgIP?=
 =?us-ascii?Q?bhfutExozkfIDNBGSB/hdivpXVOKfnEK5YeUNcyBpMc/vlxW/OptGHQg6b9Z?=
 =?us-ascii?Q?Gy0Caw+3yLGFEU0dj94V48Du43Jo7x+sGqnEeYs/94S3XMvfxmwnYkdvHT8F?=
 =?us-ascii?Q?mPFPFDv1xjL2SnUa2hEVuvaTt+Z2oqhDTSZ5/nPF+1OLOx8obevfaJY6m505?=
 =?us-ascii?Q?sHSRIlwBvtBmfLJVivljwOjaAe81kOPttDeGFLgubfH6EWmn0Amebs7qOKnq?=
 =?us-ascii?Q?GU5sh2JmP7Yxk+BtQmfJS/axT25vg/cWr61zMAJOElbgyLzo67w/sFihWENy?=
 =?us-ascii?Q?MACmp6QDF/IY9LPS6e2nfttLdRQ7wYxZ+b2iJ/vTfg1qVdXnYMoyoBssMIMR?=
 =?us-ascii?Q?hKrvhhBtgNimVcN2chazXKAst9FhrZ5bfF/8SFbJSb7mNMbU7as7sqS8Za6s?=
 =?us-ascii?Q?RWq87cFKU0H+qQkp3jQZELM45+9n9uDRxNGHCIHZiRluWvcMX0tSzCYCAb2Y?=
 =?us-ascii?Q?AUuQrbS5eABLMeiA7Gjgb96in9b44Q9aKzFIaAUpM5aDmzg5w0fdRYoaUF+x?=
 =?us-ascii?Q?7aa4ZHO938A/ypzfzqES0gJ87SiFL3mrC+BGI9Er?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426b5363-a838-4494-c7b0-08de113a272d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:10:59.7730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nweeAfINm3Naip5Ktw7IyaosJeUNGlZsPHQXqCrSBaJUYJpI+E3uo91gXnEzDAS2hI2SmFPvpmZPYdwWgQiFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:58:17PM +0530, Kaustabh Chakraborty wrote:
>There are multiple PMICs by Samsung which are similar in architecture
>(register layout, interface, etc.) and is possible to be driven by a
>single driver. Variant specific code and data should be managed properly
>in the driver.
>
>And an enum which describes all supported variants. Pass the enum as the
>device driver data. Introduce a switch-case block on the enum for any
>variant specific code.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
