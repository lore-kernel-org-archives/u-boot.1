Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72508C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35B1540ABA;
	Fri, 24 Jul 2026 03:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGclf8Ap0zc3; Fri, 24 Jul 2026 03:40:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2606C40AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784864417;
	bh=DDuNZoVYCtmP6Hk+N4tp9YPo/PXOFKfzjIi4vyT4bTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLOzKhB88ay0lzirF051OTWpD6UCdek4cok8SPhoW66HzM/rCJs6eThcHXZUqkBdL
	 ozoYQpSPFSl5baDMGvgtRGRthhsNVXYeMyqMTZlD3P0Y7JxmGwW3Q0uO1z8KA9bjT2
	 cs/sIL1Thybx/TV/7FAT3/Je/aoePMTgxRoKYI6ncjrC+bY4ukSba6zAHNZ6Uq/SbD
	 TPV4xE2SU6pCaa3YyuumP36J7Gw7Roar6r3iaeIGzXhfWC/t+xDi9XAz6uzAARbod7
	 8Ui3opLRL5Bhuo2ei2/iiVCh6P6jTpsZUeIgQs1fgN86HHu9l1OGm8fuCTqA9iWB6i
	 LkikSchaK1iag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2606C40AAC;
	Fri, 24 Jul 2026 03:40:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D4BC490
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 438E060B10
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5rpuQrGcfc9 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:40:14 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1A79460B0D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A79460B0D
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A79460B0D
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyEBjhZtjifQCc29EHy4sZ//9mkdNhHqR7kpgmAMZktBFVji43XMSPfIG0gmseuiAGoIvVpWbwEz99EtleRGnpkLzzG76vaCawc8P6AEvF+vR3DItqw8GvIDVb+zwON67T2mqVnhDWxiGwMwzQsmvupAWisDZC4227ahP0rKncoT5t6Nn6NX0cVNJp2WTgFZyLRPLvWR6v72TtmV0fL77wjDThd0x3EHW/Bp01iOvkXq7Rulhfbio8CogMI/eLqy8kUpL57JGA56JpBiCnjF2b1+qhucwdJm6SnrkURA04OAlGmOodbbWs3nJPit6mWeb3gGBPoU/xmcah/L8IvdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDuNZoVYCtmP6Hk+N4tp9YPo/PXOFKfzjIi4vyT4bTc=;
 b=iMDg6eQmjIC0okUUANF70icCkHlAe4T4bOEqXT0V33hxRzNuShtLLhXz5HQ6WRb9ZTOisVWNAINUdp+2n1LX5ZESPQOQtdtTBBv489eFQZwqsjYpz8Um7m3zcRwaWLK9U8Y1k/za9kfwI6RDoQZrJGrkhjvI7YHmVMRnl+rJGyzmndx/Wz8qeIT5Fkb/udxMFsE3/4EV2TIkn8qmCuInLWqcIOI9reAC9Okmv+QFw0bV+dikuB5d/igp53EdsrG0qoSMtWwD5oc3+nDDEzlGOVwQfl4S72lrFN8w1WTqsxlC/ZzmbaqIn7hGBrKX9qsEiqLXQS7pUwKP89NT4tsjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:40:09 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:40:09 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 24 Jul 2026 11:43:24 +0800
Subject: [PATCH v2 2/2] net: fsl_enetc_xpcs_phy: Add 1G SGMII speed mode
 for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-imx952-v1-2-bb060ca157e8@nxp.com>
References: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
In-Reply-To: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0260.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::13) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ac4dbe-ca05-4161-56b2-08dee93540cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|1800799024|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xsxu4yvjpeQb65TaGNuziHNm82OLwqwjLvYGq+3Jdh7C2UTtjI9jghGWC9Ah/eO4UlLBjc7Bix21rSQRwxCzSPvDrv+8i5Lj6aV+1i55TCF6Ec62WQhbq1/AobX1zqy16sBDbbFJ1oSsbHVxyjNfwiDbrZ+QkIRQ+JiUqH3upoaC6OxDUX8W7wiY2YzcRMlEHtKH7tL85eKQzBKDtnN2VY7/n92Yc5pHctc8ap5DQTVsV4uoh9P2WmefhlQeC/0BkNliQvD5V6yftIfYVJiPTT6qSv8HcDJBv9aP675GNxJk8lUBjRYxG8ZQqvvspAQfEJA+8jdaDatkx2NclJAZ/OIbzV/BxNXVxRnXZZ5DvW16cCtrBasKxIa/ammNkeznsH0712DPRZYp8jHVz/bnD8y+Qt1rNnN0iA0MFWbOfWUnaxPg+QFPNgQNb8cPo5jhc4dBPyhsgvwqxQKcatdwnJqJBVADiUEWCTcFzBn+FC9DFBlOQ5Jur7UDRFi+0UsTweCvu01PCRyDA+yF6ppZTnz5tIi6vnWmZ8H/MSpZrUWwjWikIY1L/9Tz62cA+XbR16ABZl9w7Rx8R58RzGSnnQZDLEP6131iFtRo359tArshLBnC+MyNiFAApFYWFqcq/i9iOe76LzIc4UN83sBlXYkCKlmkp7zQF0xxWYBkNCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUIzcnZ2cy8waG5TMXBjNHRGdGREa01BSHpNTWdMdnNlQU5ZNkpPV2Mrc3V3?=
 =?utf-8?B?S2had0VJYS8vWWFjK3M2UTV2SWVjMmtjY2d2eDArUUt3VDVwREJjOSswVi8z?=
 =?utf-8?B?OTgwWlp3UXlDelZpMkhCbWp5OVZUMDVEZ2RGdEdiMlNlQzRGS0FyVnBPbVpC?=
 =?utf-8?B?OWFZOHk4eWdYdUc1bEUrVmdRQUJRRG5GeVlUTEE3WG5JNkdNUnhEVExwSy9y?=
 =?utf-8?B?aTZEd3ZtRmg3dlhjR3QyVmRSMk15c3pzL0lDcE1mRFVOSDZ3bzB5dE15OE9j?=
 =?utf-8?B?MWh4MVh4ai9DS3NHNnlNR3U2alJoWGp1MU05OUpDc3k3bFZRL1hUekpoNmlH?=
 =?utf-8?B?RE9hRlN1OFdORC9uK2dKdm45TmphNWdYc1llcHJZUzRDcGlNaGJpTjNIdlZx?=
 =?utf-8?B?YmZuN2JZTGRxZUVqSURxb3VtT3hpbDNTM05iVVNaU1BEbGpBckZEQUFxeVA1?=
 =?utf-8?B?TDBvdkkyYy8rUGxHMWZGVDVReE1GY2MxS051ZUlINUhMM1EvdUFPbjJjQ1I5?=
 =?utf-8?B?QkJOOUVBL2h4bTl4K3lYQUt2WXJ2Vm5TKzlqalZsMjF1Q25YTlFVUU9Bbnpo?=
 =?utf-8?B?Vkc1VXRwbnFnZWowRVEvOXpSYjMzSEgyUFg0TWV1UHZveGJsSDJOU200Nmw3?=
 =?utf-8?B?c3AvUXhOeGV3REJhL0dlcVlsdCtpTFFnTzVNdkVJMmVwZzhWSHYwOW0xa0tB?=
 =?utf-8?B?dzBncTJBdmRwRVd6T1p5N0JXVEN4NWlZNGZhdko4amFuY0tDTjFiVjFEZExD?=
 =?utf-8?B?TWVIaWN4WThuZ3RuRmlEVHNtZnIvOUdjNk43bnNoMWcyQWFjaVpRSnArN3la?=
 =?utf-8?B?YmFHYzZYMVJzQ1VqejJkcEY1dFI1bjB4Slh1eVJsR3lxdkxYN0NZcjc1U2pk?=
 =?utf-8?B?cDZ1QXdQNmRrWXd6bEo3Z1VvYkR1YkJXRjg3ZlJLYzhTbjNiazFVSm9iRVRX?=
 =?utf-8?B?WTdKSnZXL1RmckV1dnFQOG9IUDc4d3NmOTZPYTBTK0JwQnYrNDZEcW9TYXdP?=
 =?utf-8?B?QkNxQlF2TFhaZ3pHN0F0eUc5QVhMbms2VXo0RG1kR1hURmRsQXNlSzRyRmVn?=
 =?utf-8?B?ZVdEbG03Q1ZTTnJNMUtvMUU1TmhXTjkzSVZzN3dva0pHYzNyeDRaSVVYODdY?=
 =?utf-8?B?RlQ3eEhCUk5yekxyYzhmK0pwNXdwQ2dKRTg0UG4rM1gyZm5aOTBSMjZLZTNR?=
 =?utf-8?B?Rk9pQmg0UTlIQ3hVaFQySjgwUDJHVzZ3WjFCZmRRT0JLNnJuc29CSjhlOW44?=
 =?utf-8?B?MFRKeXpsMnZiT2JmQTFIUzNyaGlNWHRSZnd1d09yUURGRGF1NVBnN2NOMVRU?=
 =?utf-8?B?VWhKWXJQUzFhNDFDd2d6anY5clluU3J2SGgvd2U1UExzbzh5MGZLYUVjWHgv?=
 =?utf-8?B?S3Rrc3FsK2xscWg0eWpGZEU2Nnl6eDVTdE83NWpQNHh6ME5DQzF4dW9RZFFr?=
 =?utf-8?B?ZzBkb2Y4NlpEVU1GL25iaGcwMG94aG1hRXJDTXNDOENtY3hxQ3pyNXcyUk12?=
 =?utf-8?B?S25DS0FBZEZRQ083WGJNVXJQYitqaXZaMXQyUnBLNi9kTWZmdEtSWFVQbjVi?=
 =?utf-8?B?bzh6cFNiakk3ZW9RQlJQMmttMDQ1bzQ5RGc0RjEzVGwyRlVyZHJSaU0yY3lw?=
 =?utf-8?B?ak5Rb2c5d1h3L0trZkVxZS9oU1ltN0UzbllSd2d5WUh3eWx3T2ZoenpPd3Rr?=
 =?utf-8?B?eUtmL3pwZE9ES3o5OW5DQTdMTG9nd2k5bEwzaWRpM2w5UjlNTHgzTDExY21k?=
 =?utf-8?B?aEtNOHdRRkZMVUhIbSs0dGdNWnJxTEVPNVZyU2NVMzRNa2t2R1ZnWEpNbnhs?=
 =?utf-8?B?UFB5Zi9MdXFaN25GOFNYNWUvMkE5MkhSa0hZZFRuSUVTSkEyNmdPVExMVzU5?=
 =?utf-8?B?dlUwOTlaalFTOUV4N2VlbGpCempudmRTWDdqVk85bENSTEtKb0pkWm9Beit4?=
 =?utf-8?B?ejkzWndCaVJTeS9Qbms4RHZBSUZVemlLMlBHUWIzVFZydUl1dXpPeWRXYWsy?=
 =?utf-8?B?cGJkaWU2dVFJbFJPZ3RIZGVlZExVeW1lWEY3dHU0S0VSWGd5MXp4VzdBVGln?=
 =?utf-8?B?ZFlxellMR3cxYm5GcmhNdDZHR3prREpDdUdOb2tjbVcyMGJhajVjVzZiRXQy?=
 =?utf-8?B?bkxObHlveDcwZUF4blRTN2R6bVlCWTF5V0pxZWZHcVZ6Y2tDekhuRDVvMW14?=
 =?utf-8?B?SDVHTWg4ZUYvL2VEcWNTb3E0Q1dFc2poaUJIUmZrTDRCa0xmMEtidVo3TGFF?=
 =?utf-8?B?MWt6enUxcTFUR25Wb0k1ZFA3Y0FCbE9ibWF6SUxJWStHRzQ1T0tHbGptc3VR?=
 =?utf-8?B?VVJPSjRaSjJ1UEhkc09OSFMrbEZyckVNZzNNNkZlMkFmWHp3S0N5MjlqQnM4?=
 =?utf-8?Q?zWTKITFWyySDTK1Y2KIngLkXPO83vMgaRVtkn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ac4dbe-ca05-4161-56b2-08dee93540cc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:40:09.7001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73xtjXmdzWYd59GIOyaDwN7yTwU0BKKsr6/X8dF6rO8D5E2E8ZM1CUlf04UVjhC4euLPtlR7ZdLvKK0k5ul7hDkshj1qTbSWjBKoVwPgkX0dN93GcnTL3Wa5fF01/HIh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDuNZoVYCtmP6Hk+N4tp9YPo/PXOFKfzjIi4vyT4bTc=;
 b=OdNh6kADGv/zpIVFIudCP1yU4fKkJmXKfs3o0MvvsH62+4KptnNY5XNJ6V/2GlWi1iVabDpP7MhCWdzbV5puvRnyygJPdlw2hxDbSP6BcaCFXOq/l7DGMJXusQzEKIesF1+fYkJcrgFQZ6RSnC8hZSyJoBEoaMaWV0ZnGlh79N4mIby1DSpbjbYO94LKkk9jeYOGt1ZnVEjXsXbKFE24wbXea4ganlZCqQTdub4gwtq+JPP9m2NYpVAxk6knJ9MOGjQoLAyuEbJs5dgYgkHkelk9RJ3C+P8+dazqC6I7IoFlzyw52YjGMgrxrqnSehHi3/JySNdtfvQtKbzihKKLBw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=OdNh6kAD
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alice Guo <alice.guo@nxp.com>

Add support for initializing 1G SGMII speed mode for i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 284 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 060fe3ffb34..f7662a709aa 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -225,6 +225,35 @@
 #define L0_RX_VCO_OVRD_OUT_2					0x214
 #define L0_RX_VCO_OVRD_OUT_2_RX_ANA_CDR_FREQ_TUNE_CLK	BIT(0)
 
+/* i.MX952 PHY_CTRL_EX registers */
+#define GLOBAL_CTRL_EX_0_MPLLB_SEL			BIT(7)
+
+#define GLOBAL_CTRL_EX_4				0x124
+#define   GLOBAL_CTRL_EX_4_PHY_PCS_PWR_STABLE		BIT(8)
+#define   GLOBAL_CTRL_EX_4_PHY_PMA_PWR_STABLE		BIT(14)
+
+/* i.MX952 VR_MII_MP_12G_16G_MPLLA_CTRL2 */
+#define PMA_MPLLA_CTRL2_V2_MPLLA_DIV8_CLK_EN		BIT(8)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_DIV10_CLK_EN		BIT(9)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_TX_CLK_DIV_MASK	GENMASK(13, 11)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_DIV16P5_CLK_EN	BIT(14)
+#define PMA_MPLLA_CTRL2_V2_MPLLA_WRD_DIV2_EN		BIT(15)
+
+/* i.MX952 VR_MII_MP_12G_AFE_DFE_EN_CTRL */
+#define PMA_MP_12G_AFE_DFE_EN_CTRL			0x100BA
+#define   PMA_AFE_DFE_EN_CTRL_AFE_EN_0			BIT(0)
+#define   PMA_AFE_DFE_EN_CTRL_DFE_EN_0			BIT(4)
+
+/* i.MX952 VR_MII_MP_12G_16G_25G_RX_CDR_CTRLL */
+#define PMA_RX_CDR_CTRL_VCO_LOW_FREQ_0			BIT(8)
+
+/* i.MX952 VR_MII_MP_12G_VCO_CAL_REF0 */
+#define PMA_VCO_CAL_REF0_V2_VCO_REF_LD_0_MASK		GENMASK(5, 0)
+#define PMA_VCO_CAL_REF0_V2_VCO_REF_LD_0(x)		((x) & GENMASK(5, 0))
+
+/* i.MX952 VR_MII_DIG_CTRL1 */
+#define MII_DIG_CTRL1_VR_RST				BIT(15)
+
 static int enetc_mdio_read(struct mii_dev *bus, int addr, int devad, int reg);
 static int enetc_mdio_write(struct mii_dev *bus, int addr, int devad, int reg, u16 val);
 
@@ -1479,10 +1508,265 @@ int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
 	return 0;
 }
 
+static int imx952_xpcs_phy_mpll_sel(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4));
+	val |= GLOBAL_CTRL_EX_4_PHY_PCS_PWR_STABLE;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4), val);
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4));
+	val |= GLOBAL_CTRL_EX_4_PHY_PMA_PWR_STABLE;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_4), val);
+
+	/* MPLLA - SGMII 1G; MPLLB - SGMII 2.5G */
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0));
+	val &= ~GLOBAL_CTRL_EX_0_MPLLB_SEL;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), val);
+
+	mdelay(1);
+
+	/* Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_SRAM));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	mdelay(1);
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0));
+	val |= GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), val);
+
+	/*
+	 * This bit is self-cleared when PSEQ_STATE in VR_XS_PCS_DIG_STS is equal
+	 * to 3'b100, that is, Tx/Rx clocks are stable and in Power_Good state.
+	 */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PCS_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_CTRL1_RESET);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val = u16_replace_bits(val, 0x2, PMA_MPLLA_CTRL2_V2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+static int imx952_xpcs_phy_mplla_configuration_sgmii(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* Disable 2.5G SGMII mode */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1));
+	val &= ~MII_DIG_CTRL1_EN_2_5G_MODE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val |= MII_CTRL_SS6;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* Program various registers for 1G SGMII mode */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_MPLL_CMN_CTRL));
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_MPLL_CMN_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL));
+	val = u16_replace_bits(val, 2, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL));
+	val |= PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL));
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_REF_CLK_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL0));
+	val = u16_replace_bits(val, 0x50, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL1));
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val &= ~PMA_MPLLA_CTRL2_V2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val = u16_replace_bits(val, 0x2, PMA_MPLLA_CTRL2_V2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val |= PMA_MPLLA_CTRL2_V2_MPLLA_DIV10_CLK_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val &= ~PMA_MPLLA_CTRL2_V2_MPLLA_DIV8_CLK_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2));
+	val &= ~PMA_MPLLA_CTRL2_V2_MPLLA_WRD_DIV2_EN;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_MPLLA_CTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL3));
+	val = u16_replace_bits(val, 0x3f, PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_MPLLA_CTRL3), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_VCO_CAL_LD0));
+	val = u16_replace_bits(val, 0x550, PMA_VCO_CAL_LD0_VCO_LD_VAL_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_VCO_CAL_LD0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_VCO_CAL_REF0));
+	val = u16_replace_bits(val, 0x11, PMA_VCO_CAL_REF0_V2_VCO_REF_LD_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_VCO_CAL_REF0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_GENCTRL1));
+	val &= ~PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_GENCTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_RATE_CTRL));
+	val = u16_replace_bits(val, 0x1, PMA_TX_RATE_CTRL_TX0_RATE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_RATE_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_RATE_CTRL));
+	val = u16_replace_bits(val, 0x3, PMA_RX_RATE_CTRL_RX0_RATE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_RATE_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_TX_GENCTRL2));
+	val = u16_replace_bits(val, 0x1, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_TX_GENCTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_RX_GENCTRL2));
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_RX_GENCTRL2), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL));
+	val &= ~PMA_AFE_DFE_EN_CTRL_AFE_EN_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL));
+	val &= ~PMA_AFE_DFE_EN_CTRL_DFE_EN_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_AFE_DFE_EN_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_RX_EQ_CTRL0));
+	val = u16_replace_bits(val, 0x7, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_16G_25G_RX_EQ_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_DFE_TAP_CTRL0));
+	val = u16_replace_bits(val, 0x0, PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_DFE_TAP_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_CDR_CTRL));
+	val &= ~PMA_RX_CDR_CTRL_VCO_LOW_FREQ_0;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_RX_CDR_CTRL), val);
+
+	/* Initiate the soft reset */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1));
+	val |= MII_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1), val);
+
+	/* Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_SRAM));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	mdelay(1);
+
+	val = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0));
+	val |= GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS;
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_DIG_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & MII_DIG_CTRL1_VR_RST);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0));
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0));
+	val = u16_replace_bits(val, 20, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL0), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL1));
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(PMA_MP_12G_16G_25G_TX_EQ_CTRL1), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+int imx952_xpcs_phy_sgmii_config(struct udevice *dev)
+{
+	int ret;
+
+	ret = imx952_xpcs_phy_mpll_sel(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		return ret;
+
+	ret = imx952_xpcs_phy_mplla_configuration_sgmii(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_2(dev, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 int xpcs_phy_sgmii_1g_config(struct udevice *dev)
 {
+	struct enetc_priv *priv = dev_get_priv(dev);
+
 	if (is_imx95())
 		return imx95_xpcs_phy_sgmii_1g_config(dev);
+	else if (is_imx952()) {
+		priv->without_pcs_pma = true;
+		return imx952_xpcs_phy_sgmii_config(dev);
+	}
 
 	dev_dbg(dev, "SGMII 1G config skipped\n");
 	return -ENODEV;

-- 
2.34.1

