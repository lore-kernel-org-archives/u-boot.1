Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BD9D68BE6
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 14:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B466488D4A;
	Sat, 16 Nov 2024 15:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aW/DJRIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A2A88C53; Sat, 16 Nov 2024 15:49:15 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E3E88C53
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 15:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMD3A20HZYVYIyd2oDyMDsNIFCPOK/JLovbJZTm5kdkITYF6jX4SW+4Sq8q+iENKc7+kehrL5DY0m/ktbAHi8572zi7jVW75snH/5tkKjyHuJMMEI1dUxLGNLfPzUPkuAMpD+ykw3j6ffLjBa2lWc4cGKB+UudynbmFrkSBhApjT4qPHOtozEQ2l8t4mIj4hJpHV81DmEA+AyLWoIerbdbPB9cucvLoigJ5pnK/t3AcxOni2wb8jumNy1V0HVI/MUGAH9nBmZVUH0kwlVZc0ugcBgJKt60BWFwx0mFue4dgH5mM+Szx8i/TK6ob3iCCbJECv1j5ypZ7dX1mggs0A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaZsmfnzPwOzXG20dXF1DfjRtHVMjh7iw28TYCAJUeE=;
 b=o704qOPCpq0weyEG6VHZeEbdj4S551uu4RO6JUWwyotTvm7zkPwAKfuZP59HSnuWiNBFAm47z9opjTGdymsMbbE1kK1wMuhFD9+s2HvOfo13U5WcQ8YL6oZkRDJFY4fY5y2HDAP8ygl2Hss8QpgpbBO+Jb+g085LWoW0/f5nnPTLWSPPn7NGA+Y3fhiolGYTP7LM9YdgHZLo0/4FwiAdUgygc49AOmNbeV0iVQZ6Tp/M/x0CcRzs7NUBdvuffQ2kXccx3iHfX/vk4ojV7MNCjWpiUey0P59qXXEdPu1bsiaEV3d+HmUa7zNitOOC/r2iqtPiid4qJjLEFtNG/4YL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaZsmfnzPwOzXG20dXF1DfjRtHVMjh7iw28TYCAJUeE=;
 b=aW/DJRIOGqoMLmfn5Of95lU6w4XIJc4IA/HBzIUpT8QY2bBbb7GllHFF7HFZDj2grdPHAzGq0GRgmB1Oen1Qc0aNafnWbj5m0I7hbo67oXi1Cvzf+uMImir+17muovrsGwgQaYoLSz7xXY8wJyxCt+7ismb2aLSVPQOF3WNJxkjE7xQrofcUv3z+J9tfFgs24baSL3bN+qbyRQ/xOkoUru6jlDp1yRU+FlcrbMjN3vnvnd9zErU1prdTekzlfdbOmh71JeGLvCVJFhB1NDbWfUHva3fGR+uYnmc14Kyimak+XNvGdAGF+QSJgj3JjTQOpVfNYRc+ySadOpn28oO0lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB8621.eurprd08.prod.outlook.com (2603:10a6:20b:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 14:49:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 14:49:08 +0000
Message-ID: <9da1c8c2-efec-4c46-a159-f1efcfa6827a@iopsys.eu>
Date: Sat, 16 Nov 2024 17:49:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
 <20241116003153.GC3600562@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20241116003153.GC3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0095.eurprd04.prod.outlook.com
 (2603:10a6:7:54::24) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: b4978846-11a7-4add-81e8-08dd064dd354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFJSVFQvZTFwVy9hdkxobitKaU5OblgwZUl1cktrRmNPeFlEUWJ2cTBxeWZm?=
 =?utf-8?B?RmN2c25nKzZBRUEyS2hIc1RtanlFM2k1UngxalNaT2t4Z1lKelhCUmc3UWdi?=
 =?utf-8?B?cERpUTFMdDZuMHk5WTVQTHJxTkVUYVRRdm93c1I5VWtpZDRVNit2enBPdUYw?=
 =?utf-8?B?WEk4S09kQTNNQnQxdWRYNFpzTzJGZnNiTFFkODJ0VnZvb0E4VnpFUTJjdDgw?=
 =?utf-8?B?ZkZmUFE5dldTSUNpQ1BtZ0tSOU5WaThPZFV0V1BhSkd2NG0zZjVLN1cybERR?=
 =?utf-8?B?MkJYK2MwMjdOcTh1ZTBubUl6Qk83ZWloZmltUG9rY05zclhvQ2NLSE5IMU9P?=
 =?utf-8?B?cFJsYTRuQTlyWHhueHJoN0V0aUJrZEkyWGhjN0ZrVk9Rdkc0SFJMaTJyT1hG?=
 =?utf-8?B?WURJalJ4Nkp4dG9SQzZLY1hMb25RVll6aVkxRXRFd3pyYmkxaWlISlNlWHlU?=
 =?utf-8?B?U2hXWis2YzdIbzRFbzVMbGpzNENPSkxnRTZrbHhHRnhESHZPQnd3TUZzWk5U?=
 =?utf-8?B?N1piOHdDejlaMzFjS1k4MVZhUHRTaDh5aE1Qd0FuNVR0alVYdUxVOUMxQUdL?=
 =?utf-8?B?N3BqQXJlNXUveVl2REVuWWZiT1lvSFhJNE9ldE5IQkVIVDE0QlJCZThvcHI0?=
 =?utf-8?B?S2JsK0JWL1NHYkZ1RFh6eWh4R0dOV1ZXblBqaDVvNkdXK3RTZkRzWitneVps?=
 =?utf-8?B?TmdhQWo0VkltV1hmR0tydVhCQzNMZWdrdWVmL3BPOVJBbFFocDcwcm8xZjZY?=
 =?utf-8?B?MzBWN0lsOXFobGhHa3NNRDZIQ3hKd2lmYm5MeWZvdzYvS1BneXVkMnNhMGkx?=
 =?utf-8?B?Ky9NeDhpV2xFTjJ5QW1vcWZNZGRnOG9MS0Ixb3UyMG1jT2FMMjRiOWlQNmJ3?=
 =?utf-8?B?eUlwYTdqMzdTNXZJS0Y0aFFZZEtnUmI4L0JmaG5sb0xjSHg2RlFKeEJ0cThZ?=
 =?utf-8?B?Q2J4WDZ6WXAzSnJHdzFUUkdmUUZubnFVV1VhVm5kM29yc3QxSzkwZytKZWxu?=
 =?utf-8?B?bW9YWFAwUVB5WHJDck9ickw3WXY2YUlRSTZVMzBxeER5YTRIUWY5RUlFVCts?=
 =?utf-8?B?SmZqa1lKRGdKY0UwdDM2em1ZSXRzc1lDRC95aDVuWENaVVNHOXprcVdLTVNl?=
 =?utf-8?B?Q3Axc202aUVYVjM5ckh5ZWhtMHZPVFBHcTR6TjFyV3dDUFRITTByUWdZMkVJ?=
 =?utf-8?B?d2FsTFpMZjl4TlRSSzdiT0ttektvTnA5V1d3dmtQZnhGUUsyMDhPK08vNldn?=
 =?utf-8?B?ZEJHSDdvSGJGUHVTWnM4WTFLSHhOU01nY3hyKzNIZG82eWp6R0E2RFh6TTBj?=
 =?utf-8?B?ZXpLemJ0aDEvS2xpNFBGd3VmeUx1MS81VE9kYXhPRzRCZTROallvRFlzcUtx?=
 =?utf-8?B?dmhVWnhsV3gxdG55ZGJkVWlvNnNpVnRxUXVVQUs5OU11LzlLYmpDbGd2Y0NJ?=
 =?utf-8?B?WlJTTFdYN1RyV1VwZ29RZGNCa09DeXliRzFzdjQ4WFQwcGVEQll3L0dmMFN5?=
 =?utf-8?B?TEV5VnRNNVZpdUFSR3hrbHhkc210OHVjY1Q0alpsQ3JQbGZoZC9kNUVscEZT?=
 =?utf-8?B?RkNrVTdRblVhQURtbE5tNEkySmZGUTJPQmxFODhaaWhzQm5YdTFUU1I0S1Ev?=
 =?utf-8?B?OUlSc2l1U2ZDa0gzcFh1NTJyRkVTcmgxZGRIeDdPMzJwcHdLUlI0VGloNTF4?=
 =?utf-8?Q?xxk7+V3l4PidWb/ouUYy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdzRmxJQll6cHlOcXlQaGMva092WTJGeDZuYXhNdXltOWV5dkpVTTNFR0hn?=
 =?utf-8?B?b294K3dvN014TjJwY1A4QTFKcWk1b3ptSW9VRnY4TVZqd0xvb3VOdHVOWk5P?=
 =?utf-8?B?K3lsYThYc0JBMHAwbjN1bklERFpiNjBIdldpQS9GY29LNGpmYlBjZDRsSVIw?=
 =?utf-8?B?b1JaWXBDZFJqeDI0M0Q1eE9yT1p0VnE0d2IyVm9WVldxTFpNMkhxM0ViZEl5?=
 =?utf-8?B?T0IwSkt5QzAzV2tzUENIWEdoNzA5TUdXV3JETU1NNU1aallSOTBUODA5ekNq?=
 =?utf-8?B?OVBkOWtKTktHQ0RzMmFTUnpPekhWVVhSZi9ocENPNkp2bTdXSkRWN0IvV1l2?=
 =?utf-8?B?RFpXR25SVXY1cW1waE9OczI4NUF4UmE3bnpNTFFTZWJFaTN3K3crdExtdy9m?=
 =?utf-8?B?dDhuL2FDOExYUlpFVVorM0g2NUpmVXE3cmRpRFN3L284S3JsTEo1dDdaNERU?=
 =?utf-8?B?MW5BZnNVdWY5UEFxM3JrSHBOcTkxYm1saWZnL2Vya0tMUVBsZncrWG1CMzA0?=
 =?utf-8?B?U3NFQ2dMV3VyQVNESW84YWVKaTd0aXEwWlFwRFNkeEpEaDR0MWpVUUw1YUxx?=
 =?utf-8?B?c0tvRU1CRWQ0NGUrN0Vwb25qbG5CTnM0Y0ZWS1lKaGh2SlhZTEtYUHJXZVV2?=
 =?utf-8?B?dEg0eGI1REVhS1RKZXRPZnNFTDVPMFFjTGF1TWlrdjlHSUYycnhKbkp0a2FF?=
 =?utf-8?B?NU5OOVd0WXBFemNKUkdCbmt6L1AvUURvWW14cUZQTlNVL0VCOG9qd0VNM0tj?=
 =?utf-8?B?MHNHaTVOL0Fwd1JUUUZEa0xoRVZ2bTZjU3BrTThQSnlsNi91QnVnZWtZb2Fn?=
 =?utf-8?B?dGYzczM5Tlg2ZmlPMnM4UTQzOVZmUmNyMG12Z0RaaUI0WXY4dTFkS1BGQ1N6?=
 =?utf-8?B?dWp4V0I0T0lNdi9WVmgyVWtsZWFwdXZrWmhrK3V2by9uRTBlY1R0cFczcTla?=
 =?utf-8?B?YVE5UVBOSW5CSlFyWHZmU21FRENabDN3ME40RDFBbGQ5cU1KanQxdGh0VHNE?=
 =?utf-8?B?eERFNDgyZmg3ZFVUWTlhdTBQeVlqakRrL2xKOWVvNGRSZjZSNXNBZW5SRHg2?=
 =?utf-8?B?K2hWY09VU1d4OUh4NjZyZ3lsK08reis5T25LeExQZ0FiSHk1RzFnQk9yeUZh?=
 =?utf-8?B?OTVhZDJqWlBVRnlOcFVpbWdtUWp3T3M0SFJ0ZGFyOVNqR2poMFlkVW45OWVa?=
 =?utf-8?B?b1drTnIwamY3WTkzVTdjMHdrUWYvOGI4NC9uYlhzcXM1OXF1K0xGMnVWNjQv?=
 =?utf-8?B?aUhWYmVUVmg0MnJ3VTN3V3hTb1RHbDhINUlTQUsyQm82NzlBYm80OXRmcTRi?=
 =?utf-8?B?VGV3T0Z4cnN0c3pMOGVDZkZJRUZ0eWRRb2IvQTcxTk92VkNvZWtydUoxbjRR?=
 =?utf-8?B?anlRbnM1Z0VMMzlub0hqRFJTMTRVRlN3YTFTSWdvb2pMRkN5OGZ0aWVjTGFR?=
 =?utf-8?B?UVVHY0RsS1NHWER5WWJtN0JOaldMckVhNVNiSmJvRDZoZHJNZ1d6VDNDemRZ?=
 =?utf-8?B?RHhhWTFpRlorS21tNXlXZmNBSjZzQW1vOHloSDByZk1ha0dKMjBpcWorcHpz?=
 =?utf-8?B?em5kdzkySlBIN2tMb3ptNXliQkRkbUdybjdsMU9GZWI0Z0R1Vk45VnVUeVNp?=
 =?utf-8?B?aXBCOW5mTC94WXM2Rkg1eE9JVzRRQjlSb3FteFMyaTQ2Snp6Q2V5eGsxdFVz?=
 =?utf-8?B?UzBodnY2NjQxZHRqOERLUnkvQUlWRVF3Q29sNFgrbzI0RUpDeHZUcHFYOEx0?=
 =?utf-8?B?Q0dkYXJvZWFCYWp2YUNlR3JRUy80L1N4SHhJemtVeEdpZnFmaDY4T3Q1bUow?=
 =?utf-8?B?RlkySWJxOGZsMHcwRTJDc1hPL3pzQUE5azUyNVBYYzJhRWxDYVNNeUhFekpk?=
 =?utf-8?B?SEVUT1hGZE5Za2diSjdPTHE0MWZmZUdFYzFIWnZWb2RScUd3WjdpVk5xd1ZW?=
 =?utf-8?B?TGViSGRRVndzN0ZVejgxM0l5TU1vbUlwL3lUUHMvR0UzQXhsOE4rYklCQjQv?=
 =?utf-8?B?Uys2L2ZWUXRYVENmUVV1UkI4Z1puV0pycytvUHhkbGs2TEVvTXdvbDZnaFgy?=
 =?utf-8?B?SFhpNHVCT1pIUlFjTXE2cGxLTU9CZWhQVXp6b2ZsQ1UrL01LRFo1UkxjNVpp?=
 =?utf-8?B?NHlDOXlZejB4ck92aldSbXRERzZQeXROenpIbkp2U3RPZkZtc0lKWWMyWXAz?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b4978846-11a7-4add-81e8-08dd064dd354
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:49:08.6879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0RXavvnmB81XC9jFImvDMN5XXkBKsjuLc6QtL8F1iFJQHNDumlj1fr5JW0sK9qwKwZSc0AkWbod3Yg0nQJs0DC0vY+ZcvRK6DY681/Y/as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8621
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


On 16.11.2024 03:31, Tom Rini wrote:
> On Thu, Nov 14, 2024 at 06:36:33AM +0300, Mikhail Kshevetskiy wrote:
>
>> Legacy TCP stack is bad. Here are some of the known issues:
>>  * tcp packet from other connection can break a current one
>>  * tcp send sequence always starts from zero
>>  * bad tcp options processing
>>  * strange assumptions on packet size for selective acknowledge
>>  * tcp interface assumes one of the two scenarios:
>>      - data downloading from remote host to a board
>>      - request-response exchange with a small packets
>>    so it's not possible to upload large amount of data from the
>>    board to remote host.
>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>
>> This series of patches fixes all of the above issues.
> Can you please work with CI to get everything there to pass? Thanks. See
> https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
> help on starting that.
>
Hello Tom,
Could you look to https://github.com/u-boot/u-boot/pull/692 ?
It fails 2 times on ut_lib_test_udelay, but this seems unrelated to my
changes.

Mikhail

