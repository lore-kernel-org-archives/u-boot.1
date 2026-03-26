Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A7106F309
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85AA83CF5;
	Thu, 26 Mar 2026 10:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="BimANsD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F1983E76; Thu, 26 Mar 2026 10:03:38 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9576B81E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uftGhtIsiKYV0btJU+MDtCdzq51XpwAipUgcNe/kCiwqLK8KzutDC4xONIeQ3F1Zo0kYC6wHZgOH0bnl+gJ+YXnl9e3O+P4diujH/hyoeZYPGNkYjgJM3nrhgrgJ6qG8JVxRVQ9wghL3Dnfx3uqyTT5xLfVcCNZFY/CBwE12XDD7mOx1YhmPz41mjpyWBBlgyRLTdl+nT18962+y00p+vZYySChcHyasnmYFZpR6vZNAUJ8sa6B/4ESNTBXVPaZesf1c/+SwlupdrfmvdMeBwVG86hg2FxKHarK90asICU6mKKv3nopMA8o6ucgTdBwOa8FcANEaQuJkpx4iJ1fgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iug3atNn9dF6xrRzbdAw8enS78HZ5FpbmEkXyoGXMn0=;
 b=JCr421tbNPHonIzawLslm1M5Qm0hUwQ3F+CGkhxQ+1+HiwjKiCKtyuxNOcda2kXnxlkL4I2YWR6+CL9krx2i4sYL+H4svBD1X3CyrPXSRkGwLvdZwrd5AnvyQxswDjGzEeBMc8AhgWP42wN7n/nSN1KRGaqK0FwjUPt8hugf/WUuQmbFlvqvLJqQC7DOBIhxPwrpBKxlBbXKkqxujyyjuUKvhFt82ZImy96kZX/Bp4dyluh6gMbHXV3yADD6WzEIyFJbWNLp8TYwxtvP498dzM9rN+fDj9HMSkf130PJuA+S774Rt9fKYL2aIIieT8sQXE3IZe+fOPs8SR0H4++C9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iug3atNn9dF6xrRzbdAw8enS78HZ5FpbmEkXyoGXMn0=;
 b=BimANsD3MRQoMd7xXocaFpANrFxg7ZFNCr4wLQUT0hprWVacZGzxSlL5/UwYlSyWY02uacVtb8nTl8ToNwB+ZggN47AiGgprlRe/fSz2is+YGUmchzsPhd17NOuF4YLZ8iTzEAmq2+sF+JGyn8ZF8wAmGUJAvVx1LVKxHaLzBDiPGNlh6X3mVfG3FLG7CIRxmY3AWHYa+LqoEVAG3to4c630aFCIeIhNBiPpNK2Vq+vdLHe6Qxe7qok17wLuNzt6SNSWlZJLT5SoBNtJq+kVGG94n+pr+lbbBuABdbIA11GN73FWWio7qoBy4OJ0i5HQt5B7QhmzMJKRQzhdlZLHPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by PAVPR10MB7441.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 09:03:30 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 09:03:30 +0000
Message-ID: <89dafd9c-7a05-4b75-975c-4d73314150bf@kontron.de>
Date: Thu, 26 Mar 2026 10:03:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
To: Peng Fan <peng.fan@oss.nxp.com>, Teresa Remmet <T.remmet@phytec.de>
Cc: Peng Fan <peng.fan@nxp.com>, "sbabic@nabladev.com" <sbabic@nabladev.com>, 
 Yannic Moog <Y.Moog@phytec.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 Leonard Anderweit <L.Anderweit@phytec.de>,
 "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "matteo.lisi" <matteo.lisi@engicam.com>,
 "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
 <acPDFUn4R/nsQcg0@shlinux89>
 <d10bc263-3129-4504-acac-e751c0f8e3c3@kontron.de>
 <acTov6d4vNMnG5qY@shlinux89>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <acTov6d4vNMnG5qY@shlinux89>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|PAVPR10MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 395c168b-d06a-4e0a-7b90-08de8b168cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: uBBjqJrU8Ld3CIsXupynzRX/cwM1me8XBq5Zqig79w3i0MvIjzBBFIidpc6U2PZk8oZ07ATa5p2XSFggMkuATteBpeGTYhkzCHe7VjWNOXdVBriZYOW8asnYBrU3DI4JtehLHG04kQz229JZS/5nydegnhgkfpppBltT2x55Jjv9/Wf1VTPEnXfNKQzynAJEt/qsSxbJu9fWDqG+nvacwG9+AvGUapbw0r2HhGKFzaUk/W616Jw7ZXHV3+R61c6CI12g5+Vq7cfZ9Y0CKQnItdAbyWrZatu1H1QKvFjF5gReuscXV0dywOnFPYnGbOITLAT/lVK2VL1DBYzKFH5tM26S0AoVqtibSdtoGmCvP/krwzIyd1XkuT4Kw4DJ8yQMrtIfUkvfA6MTuKTbLbWhqtUpJKy0ToROpdKRNhc7/F7DuuH0OVxwApnJKoYLkS82Wg2/iuw9BRYTXQgnB7ASofCNu16YWwD5HvNyuExoKv8kOCTmGzoe+wX2BuogP4wkum8KYqzNzZE4vTX0dnjAmLh20HgtzR/v9O//ksFDeIuUxrEzl39+Og9NAbQ/yFw2LO0QkmnYyODq6xfmrpNs0hR2btMa8VvUtXfP6J/uDMcTBHyzGfqWre0NuYGI57T/PowtVCQTTwIvy8GfWNHo2e6Y5c2CZ7grfgzqg7ZdbSUSIi7LGklHjNty5oUAaVIJCY5eios1A3kNXE5CPMXJ7lZq/4+JIlc3t9+OYsaFOwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R09EelhlUFRYdWVUTDI0clRFekZZbkF2WVJBS1B5RjZjNkFrb3N1WmNZVmlo?=
 =?utf-8?B?YVVEb3dyYVBQbzc3SGRNdWY2eSs1aWVpdWhSTG8zNGdCMTJSNkJpRktxcUs2?=
 =?utf-8?B?eWtpc2FzWS8wZmxkL1pJVmViNkFTZHBaYjRuL05nclhmV3hxV0FWNDhpZHJy?=
 =?utf-8?B?bHdJOWpXZGdIdGZWWW9za25FN2ZPc3A5bksrV2xCSU9xRU9NUmZ5VW0wbXRx?=
 =?utf-8?B?T0VOTytpQjFHZEt3UGdTbHpxZk43ZGNsbXE2QjdFRjYyVStJOStFM0ZZQUJy?=
 =?utf-8?B?N1I1aFN0YnJ2N25FekNUUVUvQnJSWS9OcGFReWdlWlU2NGRuVGlvYWJ5aC9D?=
 =?utf-8?B?eEtncHJ1eFVXYkYxQlN1N0ZDZUdBeStzK1BZTEpRV0wwdENNSVYrQ2F1WkNo?=
 =?utf-8?B?YU9qYXh1d2Y2THRmOHFIYzJRMEs0aEV4UEVQU1JObUlwNEdZL0hNSS9QeHJR?=
 =?utf-8?B?UkN0cDFaYitzeTlHcmtDRGFIZTVFUHBLTlFCQjZxSnowTTZoNlVOZkxvUFRL?=
 =?utf-8?B?NnNNUlJOcDRlbmQvTHVVMm1IWkZteHo3ZzhmNUtXai9nSm40VDgvN0E3Zy92?=
 =?utf-8?B?RWtocUFUQk9Zalk4NjBib3EybEFOZDJFTW00MWNBSjhDTk9wZGJmWVJuTmMx?=
 =?utf-8?B?czNmQWg4QnJ4a29ZeGlZQ0xOamVDUGw1MXRzRXdsK0hJUTdKL1NzTkJ0Z2pY?=
 =?utf-8?B?U0RlSU5FMjRuaGkrNVlvQTF2bkFoR3hwbG8rNDRXMTROZVdoNjNRR3I4cFl4?=
 =?utf-8?B?SDRGUkNqanU1OEp1TEFTNVdyUE5tb3VPc2kxRFdkbXkrSGt1WlVUdkk2aElL?=
 =?utf-8?B?N1RDL1Bpc0JPK2R1d0xQWkk4U3JvMjVxRWRSQzNpaUY4R3RYNkpYMXk5VjJm?=
 =?utf-8?B?cVlkcngxVWFsa0VXZkRXYXoxcnJvSjFvNG5oUDlQY3BsczNkWmI2ckhzMC9q?=
 =?utf-8?B?NXRxL3RJdCsrUXNORjNialoyT3p1eFBvNTcwWGpIY0lCNmpGelpRQ2hDYVhN?=
 =?utf-8?B?dUpMaHpxWTU0NmdTaFhjdkpXd0l3WFdKdE5ZZkwyZHN5UlkxODk0eE9RVERR?=
 =?utf-8?B?REFTWkNCREltcDBqeXk4N2ZabldSS3h3QmRleW95OGJsQ3kvT1JYOVgzandt?=
 =?utf-8?B?bk1wK2s2MzZpS2hYZlhDNVE5d0xxVkUxRks0Z0xLRitYMVg3VlVDUjloV1lx?=
 =?utf-8?B?bDNXSkxWRkF5ODdIS29xU3hrRlc1M0Y1SFVmWW51R1F3cjNlR2NDZjVrQ21P?=
 =?utf-8?B?eEhGdVE5dkJ2TUk5b0YvUUF6S1RhZy96RGhPM2ZEM1h4WTYxVklMVHJRZXcr?=
 =?utf-8?B?Sk9vVUxFamhlMCtjSDJkdzB6WVk3T1dzczhPdVRzTUJYcEtJZnpmRkhyT1Jt?=
 =?utf-8?B?eEZsMWxvanJIaG85elFxcW5YVUFVRGlIeUp1Q2pzNzl2OFAzNWNpVmVsYXpH?=
 =?utf-8?B?SzVJd21CV3RWTDd3Z1JZYm9kWHYzdFNHczJTc1ZDMUZkOUU5bTErb2FRRFNk?=
 =?utf-8?B?aDlRTHR1QVIxOEhld2c2MGRIL0NsK0FGbzBCbXBOcjhBcXI5ZTRoQmU3Vnlw?=
 =?utf-8?B?Ykt0YzJVb2o0Y3djZitXY0JoanpveWFlK09Fck05c2d1RkhiYVdoa3hER2o3?=
 =?utf-8?B?aUdTMDhpT2dmVHZQQWk4bEp6YlowN2ZuTVhuYzY5eWlMZFAycXNxeEZKUDM5?=
 =?utf-8?B?RFFpdnA3RDlzeVdVSm9UN01JUFlYamMrdC9SKy84bGRIaFhkVG1qdVBmR05i?=
 =?utf-8?B?U2w0RUl4d0tBbWVKMTR0a0JpcURjUXdVK21HSWJ3TmVva0s1cUp2cXVpZVp6?=
 =?utf-8?B?dWs3eVUwdWtWRGR4OWxjbmE1MkpKRTVURU9sY21DbXdPaGdmeDhKRUFNak9U?=
 =?utf-8?B?RlVRek9mbnJBRXVjMFBQNS9vdFplUDJJYW1rL3d3Z3ZIMWJXN003bFJSZi9s?=
 =?utf-8?B?Mm9nNm44a3lOR21oRW9wSDFTR1hPYndlcytHU2s0MXpLUWlxZzBhU1RCRkpT?=
 =?utf-8?B?U0xaOUNHMnZQMk1EVEFvRjk4N2ZaOU8xdjl3OFNOay8zdWJCMWtOZXhVOTgy?=
 =?utf-8?B?K29FeE03bjNzNnVva1VtSXJnaU9ZaTlNWHd2aEtsd0JnejlMQnJrNHIyMGNM?=
 =?utf-8?B?ZFBtU2JWTGNwTGR3eS82aWNYenFuRjNTbXorRHJSY1BOQ09WMnVqSkpOaEdT?=
 =?utf-8?B?MjJtYWIvN3Uyb3k2VmZTWk1mQU11UGEzZk44bS84MDRZSmVWbXdWWDJzYzNV?=
 =?utf-8?B?bS9yN0piK1R4dE8vZGxkOHJzYnp3UGEwVnBxMi9GT1lhbXhVZ25DL1lyeklr?=
 =?utf-8?B?eTZlbmxNSGFuQ1ZzSnZrdk45VFk1OWZzTU9hUFB2ZTM3a3A3dElnaEtXLzJE?=
 =?utf-8?Q?0cc1bGXz+Z/Yedpc=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 395c168b-d06a-4e0a-7b90-08de8b168cad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:03:30.0169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI1oH8usuTFmnNt3HVyR0Z8ilkYPfw/tSeQX5c/OuxW+u77Hta2vfoPQo6KSYGvsz3U4UJIdQZM+M7a7Iq1kTtvV72hegi+Fsn4h5kY8Fkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7441
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

On 26.03.26 09:05, Peng Fan wrote:
> Hi Teresa,
> 
> On Wed, Mar 25, 2026 at 12:35:59PM +0100, Frieder Schrempf wrote:
>> Hi Peng,
>>
>> On 25.03.26 12:12, Peng Fan wrote:
>>> Hi Frieder,
>>>
>>> On Wed, Mar 25, 2026 at 08:40:26AM +0100, Frieder Schrempf wrote:
>>>> On 25.03.26 04:50, Peng Fan wrote:
>>>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>>>> DM_PMIC
>>>>>>
>>>>>> Hello Peng,
>>>>>> Hello Yannic,
>>>>>>
>>>>>> Am Dienstag, dem 24.03.2026 um 13:33 +0000 schrieb Peng Fan:
>>>>>>> Hi Yannic,
>>>>>>>
>>>>>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>>>>>> DM_PMIC
>>>>>>>>
>>>>>>>> Hi Peng,
>>>>>>>>
>>>>>>>> On Tue, 2026-03-24 at 18:30 +0800, Peng Fan (OSS) wrote:
>>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>>
>>>>>>>>> Convert the board to use DM_PMIC instead of the legacy SPL
>>>>>>>> I2C/PMIC
>>>>>>>>> handling.
>>>>>>>>>
>>>>>>>>> Changes include:
>>>>>>>>> - Enable DM_PMIC, DM_PMIC_PCA9450, and
>>>>>>>> SPL_DM_PMIC_PCA9450 in defconfig.
>>>>>>>>> - Drop legacy SPL I2C and PMIC options.
>>>>>>>>> - Remove manual I2C1 pad setup and legacy power_pca9450_init()
>>>>>>>> usage.
>>>>>>>>> - Use DM-based pmic_get() with the DT node "pmic@25".
>>>>>>>>> - Update PMIC register programming to use struct udevice API.
>>>>>>>>
>>>>>>>> these changes break something.
>>>>>>>>
>>>>>>>> Getting
>>>>>>>>
>>>>>>>> Loading Environment from MMC... Card did not respond to voltage
>>>>>>>> select! : -110
>>>>>>>> *** Warning - No block device, using default environment
>>>>>>>>
>>>>>>>> and SD card is not accessible as a result. I also worked on this
>>>>>>>> modernization and got the same result as with your commit. Have
>>>>>> not
>>>>>>>> had time to investigate the cause, yet.
>>>>>>>
>>>>>>> This change should not impact sd, unless pmic not probe correctly.
>>>>>>> You may give a look on "regulators", "pmic" in U-Boot shell, to see
>>>>>>> whether pmic is good.
>>>>>>>
>>>>>>> And you may also need to confirm, whether SD works or not without
>>>>>> this
>>>>>>> migration to DM_PMIC.
>>>>>>
>>>>>> I see the same issue. The error is gone when the patch is reverted again.
>>>>>> PMIC probing is working but the voltage change of SD-Card is probably
>>>>>> not.
>>>>>> We have set
>>>>>> dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi:
>>>>>> vqmmc-supply = <&ldo5>;
>>>>>>
>>>>>> which references the PMIC.
>>>>>> The evk is not using this property.
>>>>>
>>>>> I tried to add vqmmc-supply for i.MX8MP-EVK, I not see issues.
>>>>> Not sure why this property impacts phycore-fpsc.
>>>>>
>>>>> The only suspecting point is 
>>>>>
>>>>> -                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
>>>>> +                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0x1c0
>>>>>
>>>>> No more ideas as of now.
>>>>
>>>> I'm pretty sure this issue is related to the VSELECT signal in some way.
>>>>
>>>> With MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT being set, the SDHC
>>>> controller controls the VSELECT signal that goes into the SD_VSEL input
>>>> of the PMIC and switches the LDO5 between 1.8V and 3.3V. Internally the
>>>> PMIC uses the state of SD_VSEL to decide which one of two voltage
>>>> registers for LDO5 is used.
>>>>
>>>> When vqmmc-supply is set, the driver additionally sets the voltage by
>>>> writing to the PMIC LDO5 voltage register. This can potentially cause
>>>> conflicts and lead to an invalid state, where the driver thinks the card
>>>> is in 1.8V state but the voltage is set to 3.3V or the other way round.
>>>>
>>>> One way to handle this, is to set the SION bit for the VSELECT signal
>>>> and specify the sd-vsel-gpios property in the ldo5 node. This allows the
>>>> PMIC driver to know about the current state of the VSELECT signal and
>>>> use the correct voltage register when setting or getting the LDO5 voltage.
>>>>
>>>> Below you can find some pointers for additional information. I hope this
>>>> helps to solve the issue on your board.
>>>
>>> Thanks for the detailed information. But I still have a question:
>>> For current phyboard-pollux-rdk, vqmmc-supply will always use
>>> PCA9450_LDO5CTRL_H for regulator value configuration.
>>>
>>> In drivers/mmc/fsl_esdhc_imx.c, when configure with 3.3V, PCA9450_LDO5CTRL_H
>>> will configured to 3.3V, but SD_VSEL is low, so no impact. When configure
>>> with 1.8V, PCA9450_LDO5CTRL_H will be configured to 1.8V, and SD_VSEL is high,
>>> so it should work.
>>>
>>> or I may miss something.
>>
>> I think you are right. The process is the same as in Linux and I never
>> saw any issue there. Just the fact that when reading back the voltage of
>> the LDO5 regulator in Linux or U-Boot you could get a wrong value. This
>> can be fixed as described before.
>>
>> So I'm really not sure what the actual problem is. I remember having a
>> similar or the same issue with our Kontron boards before switching to
>> the upstream DTS with sd-vsel-gpios. So it might also fix this issue
>> here, but of course it would be good to know the actual reason.
> 
> If possible, please help do a test. After applying the conver to DM_PMIC
> patch, then apply below patch to see whether you issue is gone.
> 
> diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
> index 335b44a8a1a..f92c0c91c4d 100644
> --- a/drivers/mmc/fsl_esdhc_imx.c
> +++ b/drivers/mmc/fsl_esdhc_imx.c
> @@ -1454,8 +1454,11 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
>                         return ret;
>                 }
> 
> -               if (regulator_get_value(vqmmc_dev) == 1800000)
> +               if (regulator_get_value(vqmmc_dev) == 1800000) {
> +                       printf("value is 1.8V?????????????\n");
>                         priv->vs18_enable = 1;
> +               }
> +               priv->vs18_enable = 0;
>         }
>         return 0;
>  }
> 

Ah, this is the part I was missing. The driver is reading the regulator
voltage to check the mode. This returns the wrong value due to the
reasons explained above.

Thanks for investigating!

