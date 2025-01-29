Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F068CC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6957880A46;
	Wed, 29 Jan 2025 18:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S/5kq7H+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AF880B9B; Wed, 29 Jan 2025 18:51:11 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5469680820
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBIBfs/4fjTCV7VI1My8HLV672BakW5orQ3mW88y1L4Yy398Jz2Jz94WiD73DQWyrwHhGxjZUSUCIzcxdIfOQI0JML2H3PDuqHV/QeRKD0PqdijQeZdP9ZWrzZREjV8U/LEhdeQgRZSJnPjryU0OA6s4vfdUdcusaRl2WYwIzLNNAR4bVKSusD7Q8fUh91EBI5fE/yAwCvMQKlTsdW+gNdXZ4Hze0VQE9o3Mz6JZb+zAnsXoiBxKFgq5L4mHmZ4LXVsD/oE/8z63tD38s2JB2G5UjNPn/160xMApnwBHnMM21xxKFbanWUcUnegt0vlhyAcmYNYuTw9SYGoq4KCu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tje2Vl8weLQVJt00DheIDpconO2IVyv0SSS8PctvUt0=;
 b=XlUW8/eU1DnDRsonDSUpmRoDhM/YQk9m/XpByYpAd5TjJAhPBbliysxmEo/uYIKI8dTJ4Gu+OUyl7d6cOh2IAB70AizwyLhPyyGiUeRQ2fegn8kOS+nMdkmRPcsV/i17OGVoI7nO1n1hvS44ZKYAKNXuNqN4mE712pbxTE18QlydAPu+BgCvlhSrMgfaiWsW2CLuWetrAqO/I4jz5XxctAXjEjzZoUYNsDRLyMXC9aGaF0WMe0Opd62E1HApV76JX+esP9cjl+0+Hs2VWgHOaYTEzBaxs22JCzOyn2HjSfjIp1iOVOZy4/IFR80JhQkdCCtej+7QwwLHle7VQmrCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tje2Vl8weLQVJt00DheIDpconO2IVyv0SSS8PctvUt0=;
 b=S/5kq7H+Fn4gEfce4F5UuL6NzFHA/CnHlEwu9js63rqnBL8PKugIWfwo7N46zBlqkGPr489qnDuk9rYarENPjq6HpEDhfvIJ/mvxpD7jT0kf2WZjn+PSdaoYXF44CEkkbLVYfrnnsdPMro0hAbpjMTt1GllLtu6vj6UOPDux8EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10505.eurprd04.prod.outlook.com (2603:10a6:102:416::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 17:51:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 17:51:07 +0000
Message-ID: <2be1029d-f0b4-4c28-bbf9-3cbb6b1c6156@cherry.de>
Date: Wed, 29 Jan 2025 18:51:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <4097bdb7-8c8e-42af-8538-41338d49b328@cherry.de>
 <3523e011-b0f1-43bb-bc39-baa8fd2e51d7@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3523e011-b0f1-43bb-bc39-baa8fd2e51d7@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0236.eurprd07.prod.outlook.com
 (2603:10a6:802:58::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10505:EE_
X-MS-Office365-Filtering-Correlation-Id: 56779aa9-5652-4c3d-896f-08dd408d81c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHdRMThvVU1xUGdNbEhsQ2h3Ti9tUmEzQVRPYmszUWhieTkwekhVbGNDWERR?=
 =?utf-8?B?VTBwbXVlTVE4RWhjQ2RDRWFldkpTK2svclNkNmVXeituSDI0c1ovaGJYRUJx?=
 =?utf-8?B?cnQ1Y2F4cXcrKzZmUDBtREMwNEQ4aEtiWFE4SHlsWDV3MVp5V3JkeGNVUjlM?=
 =?utf-8?B?enhoVjJDVmhKc1YvYUNlTzJreWZ2bTZyQlFQanZUT011RUMwSFpKMnNZVVRi?=
 =?utf-8?B?QktaZVNZdG9ZenZGeW9wc0p5d3dLQmhkNG41MmdpcnNFWWd6V3FzZUpzTktx?=
 =?utf-8?B?bTNNVDdqdDh0bjhxbUZYYVgzYno3QUlnSWJlWkY1RkdSV3lxNU9JbmR6OWFF?=
 =?utf-8?B?YjcvOE5Fa3hlQmtodVlwaXlFT20vbi9FbW92aXE2c2hsZUpMSVRyVVJjNXNX?=
 =?utf-8?B?dFNnQkg4ZVRwTm1PWGZEU25XZzZWR1RGZEJiSVlZVCtRUjBnaXRRR3ZyU0o4?=
 =?utf-8?B?RE90QXJqN1NQN2tmZU1aaVN2bHJYaUVqQlNkaGZvSm1wS2tqOThSTWZ0YXpW?=
 =?utf-8?B?S3VJc0JZYjhNQXVNZkdvOU1IQ1FPRHlzM3NNMGZiOXRBY1lUOWtXYldkeXBj?=
 =?utf-8?B?UHdIM3FTWStndnRKa2xVc25XTncwM3BNUnJLcG10dzhsRVZMU3NSYXo5QnJw?=
 =?utf-8?B?ek9wbXNZdHV5elcwaG9aam4yT1BHTU5SVWNHUkZrcVlqMHlRNXB3REhyY3ZO?=
 =?utf-8?B?dHQrMHgyNDlvem9DR1p3SERoWVkvbXdTY2pRMlhKek5DWTRoUEpxczdMbkUw?=
 =?utf-8?B?aUVPUnVJdkZXaFF1NUkzcjc4ZlNrUTF6UGhhZVdUMEowTDVvQUdScUJWampt?=
 =?utf-8?B?T1NsRzNVTlozbjRKM01uQ2FBZGxpQW5wZ3l4QWZVT2tlbkJKb3JVenJoQnhD?=
 =?utf-8?B?OG50NVhZRElid1N0YUVxMncwRkZKSHg2bGhaV21WSjZsWTlRKzZNQUVYMXJS?=
 =?utf-8?B?S3grV25BUTlvVTdoQVZwamxWbUUxK2tDeWVteENnYXIzTS9QajJBS2RjODhh?=
 =?utf-8?B?c09FZ1B1RGlhcHhYY09MYWxFNU1uUUFtUFNhcUlqR284RmtqVFM0aUFCQVVC?=
 =?utf-8?B?NDBWWVUycjdzRXUxRmJjeXk5aG0ycEUvZWQ0UC81QUYwbjYrd0Vuc0wrQURr?=
 =?utf-8?B?SHVlMUpxUGtxQ2VGZHRrRGdMaEZWajdVR0xhY1RBNXlPZnJCN1BTUnZ5aW5y?=
 =?utf-8?B?bHBhOWRIOTdxcm5SSmNOUmFHNS96R2dUdzlGdlFFWG9XbGZnKy96V0MvS212?=
 =?utf-8?B?ZWdQaUNMTGVDa3NUekZDeUdtTmUvdTZ1a1lpbDNjTlo1RjNBUWNZcWkxbWJB?=
 =?utf-8?B?THhtTWMwa0hLQ2xyR3V1Sk1JUEgvS1gvc3hQWmU2Mm5pWmJFOHRhRkZuajFZ?=
 =?utf-8?B?YURaTVIzNzdjSURyUWV3VU0vM24xQUhoU3MvTnpNUmVvYkhYaTFFaGFJM3V2?=
 =?utf-8?B?VDV3UGFoZUNwZjV3Zmx6L2M0OHpiMjcram1qeFVEWlNrblQya1BJbmtIcm5j?=
 =?utf-8?B?Q2lWeTFNQWQ4TFU5MFFmU3Nra1BHZFMxR3ZoN3RPdm43ai9ra3YzcHkvRWxi?=
 =?utf-8?B?VTNkek5qbXhGUnhjRTFkbVNZamxhbmxXazhYZjdZUHNDckFSeTFFYVBMZGNt?=
 =?utf-8?B?UzlrbERyQlViNEpZSWZuYlF1L0dxQ0k5YnNDOVlDckFNWWxockh0MEI3T2kz?=
 =?utf-8?B?MkNKb09WRVJRN0hza3h6TjBISVd3RDFoNFZBcFJVQzdKRXdCSXRvc2tBdTJu?=
 =?utf-8?B?aGpXZ0pWYmE5UFRKd0pFUXZjVFNEdzE2eEtaS1JMZXNjejRCRUZsMnBBcUdF?=
 =?utf-8?B?bVBMU2x1MmRlNlpHempLa3hOUlZhWWV4SUtyc2VRSUtEK1dCSlNGVHczeFFq?=
 =?utf-8?Q?HNY6Dcq+EUlud?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VaZ3prcnF1VE9BQmI5M1llejcraGpQU2EwT2phSVFaa1BqZkIweFNLSi9M?=
 =?utf-8?B?L2tnWUxmMytDSGd1VEVCSkN2Z24wU2xvNU5nL3RLTTZrcll1ZlNBTS9vTytE?=
 =?utf-8?B?SkwxYWJQT1dmK2NVOTBOaXhBclBMd0NXMWJPeTUycXgvcFpUblNrYjlhZDB5?=
 =?utf-8?B?VTIybVdXYjJUNmJRdENweVFkRkpVOU9iMW5iQWNhckQ2Nmo1MGRlUXNGZkxQ?=
 =?utf-8?B?eVRJT3JudGptMkF6bnh2WXFlZW5qTVR1b2tNK0toVUpjLy9pbUowbE5OeFBh?=
 =?utf-8?B?YVpBQUUzT3Y0eHB1OEwwT1YxTVVIakRLOUZoZEdsbWRtRXRsaG5GcFVmcklX?=
 =?utf-8?B?TkxBb0xJNzNaeXNoTFp5dWV0RkVPTUlyRk9PcDFYdHV2WjRyZVB4dTFJTW9M?=
 =?utf-8?B?Zm94cVpXd2hGN2U3RllBSFNjTUhkK0hOcG9pU1BpOFdHSnM4SVk2dTF6enJI?=
 =?utf-8?B?NTRTNFhRQzFzcE41TzB0bklzdEpWWDlrd2R4Qnl3MjFtNFhPK1lldzBBNzUr?=
 =?utf-8?B?UmdPT1lHYnI4Y0ZHeEphSFVIcHZUN2RIaGdIYW1LVUl5bHBPMno5MG1WTzlF?=
 =?utf-8?B?b0I5dkZ4RS9jTDVQR0wyYUJkR3RTWE9MR1YzQmFKY0liUzdsQUw4Q3czR29C?=
 =?utf-8?B?UXpUVE1NOWJxN0J5dEVVZEhmdUdOTllHeElvQWlTUTlJTDl6dUowdGdOMk1N?=
 =?utf-8?B?aVdmYS9rWjYrNDJuNlVrZisyT2x1Ulo4c05PTTJOTW5HSWdiNUcxQ3crclJu?=
 =?utf-8?B?NXdSbzd1MW1COHZVYnRscUFtaW1mcXp0T2xrUE4xNUVzSHhKUkZVUFdIQy9P?=
 =?utf-8?B?VE0rMllmMllOenZKUnMyNUpScUdWMVM2dlZCTTlVelZCY0JYS3ZOWjBLQTU2?=
 =?utf-8?B?L0hmd0s2NFd0b3Y2bW9BOEwxUy9rWmVZMmU3dTh3RXFxSEREamUvQ1JWd0py?=
 =?utf-8?B?cFhHQjBkeW9IMWowMTRka3l3b2JrZmFmYk5YQ0hLWFQvUWtwTWIvb2RwallX?=
 =?utf-8?B?N1JsWjRPN3VrQ0VCMEErT1FsRFR5TjdDR1Z5NFJ6QXZMaVVhZU9WcFRGQ2gx?=
 =?utf-8?B?LzRTUlYxQU1qMVYyN3pJSWN4NkJVQzh6cTM4R3BCOUJCL2RhMEhzTWViSjJI?=
 =?utf-8?B?U2lIcVY5bHZaYStROVloUnh5NlZZK2FKUitUMnp6YUdBdkloQUo1RlBqR2w0?=
 =?utf-8?B?dS9NN045a1ByeHFhbHBaUGVPSVBsMkQ1MkxnSU9BZlpNY0dwdVNzRGFjSHZM?=
 =?utf-8?B?ZmFPeGNpbGpGZTYvUWxTWk90Tkw2Yk5DTlgrWXhLUFVqZk5MM1A5YWc1eW9r?=
 =?utf-8?B?TmU5WS9nQnFiUzFyVHEwUWxqazM5a0E0ajBMSDVDcTZ6V1A2ZEZ0dGZtbGZK?=
 =?utf-8?B?SW9UOTNpZ3BHTjVERjIvenpnSndMQW1xNUFld1RzdDExZnpqS05zb0FhUXZZ?=
 =?utf-8?B?UFVyTmU2aXJUZVpVT3hYYkRrS1djUFVlb2RsWE9ncHRLMVB4Nkl1aTIyU0lD?=
 =?utf-8?B?dFQxWWVhN0dVYXZjbVdLRnN3WTNtdzA3L2JyZytmMnVUaEttMlZTSnNheVBW?=
 =?utf-8?B?eGtUWTAzL0xLU0tBS05OTjh4ZUl4d0FPU3QvZ1AzWXdsU1kxaUZaeXpnMFcy?=
 =?utf-8?B?OTJkelZPTjRpY2lvUFhadFdXTnRMVWQyeWJGS0tJa2k4TiswSzRaOCtvR0NV?=
 =?utf-8?B?bEhJTzIxZ01TcEc2clZsSGxITEIzMU9Ucnl0QjUwSy9rRW5ET2t6RmRXdVJq?=
 =?utf-8?B?V0FXekQ1SUthYUc5eXA1Y3VYcUhpVkFSM0RvQURxS1dCeUlSZ3dDcjBkK29n?=
 =?utf-8?B?Ri9qUzMxangydHVzY3MzeEVsckVkSndlY05iZzl5V2pUdEdHb09wdzhVNzJw?=
 =?utf-8?B?TnlaaEpIREpJK2JXT2d6b0V1MTVJdzU4VTdlSVFXUktwNGhpZW9lc3pVMFJS?=
 =?utf-8?B?cHNwTGpSWFVpb0lHclE3MVZQTmd0UXdwR3d2VnUzazNuR2gwek1zTmMxM3BI?=
 =?utf-8?B?Z0dWZHpteUVTT1pQZGJMU1p3MFJYSVNqV1ZJQ1VDRDJBQU8xSDdHajIzdXFH?=
 =?utf-8?B?T3Z4dmFuWW83NFZlZ1ViZTZJL3lvelhDclNDYi9LQ1VPS1E4emY5K3A2Q25Y?=
 =?utf-8?B?Tk52TDRDcTlCODIwVFZwNFZEMEoyMnhpMDg1QktGRzZ6QklrZ0IrcHlFN2tV?=
 =?utf-8?Q?8nShgdiFOYkGiGQvq9vjKaE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 56779aa9-5652-4c3d-896f-08dd408d81c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:51:06.9857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdAWb94XGcM5Soac7stPGD+eAYFsMP53XNi8UnDyeooBKtuNuSuhH7uWQrlKjPn/UHdRwXtKnILezeeSMQ2KHQRZKv3d3HwnsiQhaDKlL2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10505
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



On 1/29/25 6:38 PM, Marek Vasut wrote:
> On 1/29/25 6:10 PM, Quentin Schulz wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 1/12/25 11:36 PM, Marek Vasut wrote:
>>> Add support for starting TFA from U-Boot running in EL3 as part of
>>> fitImage boot, so the user can start U-Boot in the highest privilege
>>> level on the platform, bundle TFA, Linux, DT into a single fitImage
>>> and boot such a bundle as a whole.
>>>
>>> There are two main benefits of this approach. First is the ability
>>> to run U-Boot in EL3, where it has unrestricted access to the entire
>>> system and can act as a useful debug tool, as it was always intended
>>> to be used. Second is the ability to easily and safely update of any
>>> component in the fitImage, be it TFA, Linux or DT.
>>>
>>> The boot process is similar to regular Linux with DT fitImage boot
>>> process, except the TFA has to be bundled into the fitImage. For the
>>> bundling instructions, see below. The TFA is started as a 'loadables'
>>> with custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
>>> handling implemented in board code, and performing the handoff and
>>> boot in case the TFA was loaded.
>>>
>>> The loadables handler is optional and meant to set up any sort of
>>> handoff structures used by the TFA BL31 or perform any other setup
>>> that is needed by the blob. The custom armv8_switch_to_el2_prep()
>>> has to implement the jump to TFA BL31 with return to U-Boot just
>>> before booting the Linux kernel.
>>>
>>> Example fitImage image and configuration section:
>>>
>>> /dts-v1/;
>>>
>>> / {
>>>      description = "Linux kernel with FDT blob and TFA BL31";
>>>
>>>      images {
>>>          kernel-1 { ... };
>>>          fdt-1 { ... };
>>>          atf-1 {                  /* This is the TFA BL31 image */
>>>              description = "TFA BL31";
>>>              data = /incbin/("../build/plat/release/bl31.bin");
>>>              type = "tfa-bl31";
>>
>> This would need to be added to the ITS spec, c.f. https:// 
>> fitspec.osfw.foundation/
> 
> Where does one do that ?
> 

https://github.com/open-source-firmware/flat-image-tree I guess?

[...]

>> Is this what you're recommending? We would then identify which part of 
>> the binary it is based on the hardcoded load address instead of 
>> reading the load address from the ITS. Or should we think of a way of 
>> identifying them directly inside the ITS with some property for example?
> 
> Maybe try and prototype this loading of TFA for Rockchip and see how 
> well it fits first (if at all), and then we can decide on the 
> integration later?
> 

Fair point. Not sure if I'll have time to look into this soon though.

>> Otherwise a global remark on that feature is I believe it may increase 
>> exposure to exploits. This means U-Boot will happily run anything 
>> provided in EL3. E.g. imagine I provide a script in the ITS which U- 
>> Boot loads and executes before loading the kernel, fdt and loadables. 
>> Let's imagine this is sideloading (we even have some wget support now 
>> in U- Boot so not too far fetched) some app to keep running in EL3 
>> after the kernel has booted. Or modify registers only accessible from 
>> EL3. Now you better be even more careful about what you're booting 
>> from your linux.itb. Is this a correct interpretation of the situation?
> You have freedom to do whatever you want with no restrictions, for 
> example shoot yourself in the leg by not authenticating random scripts 
> up front and running whatever unknown stuff, sure. That is not a bad thing.
> 
> Running U-Boot in EL2 on top of non-free blobs is not any better, rather 
> the opposite I think.

Up to distros to implement the proper security measures then :)

Cheers,
Quentin
