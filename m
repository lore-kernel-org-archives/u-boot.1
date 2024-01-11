Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5E1C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F2F8786C;
	Thu, 11 Jan 2024 04:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bxR6qww3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5A6878DF; Thu, 11 Jan 2024 04:51:30 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F26B87847
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx2e2cRKQ7u1mxbrAB1ylKNHrPjZiKTqrKQRwHATHWnhV+/try3cpAtUTo1bCGteihR8laG150DL1mlGzLFB9zQyaa+JH0/52xJKIf8bPDftafshlXKqjVKj/lkpQCmivkRh00jhsqQ/yEPqw3sk+/0KXcup61XqiVfS68tLqHbe/p/cdqVmLyHMJxiQmhbvvr54oB4l9cqvo2iPE2zC8nPspMUHVr6RSsQIjOsrPehz32fo+PlDuTW668dTxBDiaHTiAYO047p1XbZ9TxMhchwpCtDyI0yyKmo63O0WLLkk2XytKZv7SCA/VS3ySF7Q+SzJh+JNBGV8CZlhSCgqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myTs+nEaZ65rGinJKDdl76zcd/HgQGAjMAK2/Vww/8Y=;
 b=j2Nm7zZQ6qsCZGZsmYBm5YaEMwZiSMMnbgJux0ySjH/X97U8aSqhObFeJ1up4VWwtDLCvEbwrvvctfj/ppfRB9hEaf2QfZz/N7HqJh3spaL0ym4LYA8qUFRIAfB2nJRd2hXJ70gJeJ02f0idi6vi9j6PsPrO5tJQA6yvIOVoYT4RL0rAiUDB2vp+WBNruq3TNZzAHw2i6OIkpwPSbMHCL745tLKXVb55NUW7eRp0aQZ7XqIqYm+1agE1C9dxQqlt/n2QbTvnF9n3Zv1pG9Rv3IVsV1rjG0pcbW7y7JrO1NXqn7Ywiw+bhSwX1aPWvJCpPggShwcdKs+G/sFRLqrVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myTs+nEaZ65rGinJKDdl76zcd/HgQGAjMAK2/Vww/8Y=;
 b=bxR6qww3oKKLyPibFqjMs1U7pjxFDQP/46qA7mlyXNuL4nCiJvS6xfo8gZ3FFQ07ZXVbLKEvZOeIW36kD0ssZIWXOzQyK1ew5rzkN5epv4KQzE/WzcgXYfZ/6B8VxfBKzXlxzh5v6OjLcRzClG2VV64ylvliM485HFDmD3jBph0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 03:51:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 03:51:26 +0000
Message-ID: <1dd93112-b593-6d8a-ce56-1ffe7ebdf0db@oss.nxp.com>
Date: Thu, 11 Jan 2024 11:51:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: FIELD_RETURN on i.MX8MNANOLPD4 EVK
To: Thomas Schaefer <Thomas.Schaefer@kontron.com>,
 "'u-boot@lists.denx.de'" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
References: <GV2PR10MB6453B5A6CA444FD371798D65F76A2@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <GV2PR10MB6453B5A6CA444FD371798D65F76A2@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b39f33-4ba1-44c4-334b-08dc12589577
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtqAkmXZpOw0FjdLo681kfbR0Ir/UI+spROIWHSPILn83liCvnrsKovzb1RL9ntsakHYOOi9jtc2EM2qxh37AB3dc+RUQeF3xfD2BX+KJo0v0ojsjTVKM9qY/rRkz8HPJbHm/Kx0rG3WriCjpbS1czWmkTCeoM730Do5nIMpl2T8r/00D0UL9Qu7/ljbLBRSc+Vuz3+u2hB9Bt+l5E0lLSNrDwxW/F0yK1m2TbeeGgQxfp6qrLXNBYXczljfNmZRGxpnrBRp2eUgnJApur+2UajeYx+UM7Xt0nmG6sbh89kYSkdYuRRF9l7+NxjHxa3Fvq4hWEIbmEYvlpXK8ncBLQRSqmX6+K6CD8qjBP0t0CepSQUXHl53Us5xFXMojDkzH7obgFOvQRWirY/NsfyoE6pjWB4jNmYXSxxNOAXdlXm430nPhKVKtOcqEvtyYC2ojlpPk/+FR0ftjXEf6w6gKUIOMGsiHnYJ8Zl1GdYtlV0ald0oF9ln79A0qlTgqlAFYaD7Bb+ULce7GL+CpFmbIBZG32cFNRmNJ+m88whYsFrDHmYY2182qhrrGPKHvcMiz762vrFWb+hNZc8Rvbo9jHxlXz4AnYH7gJrM/i+ODUcjR0M58lYWtr+QBgrQvLx6l0KND2Rr18W4KrJaEmLvzJjxdW2Lq1doh17g7mA0WR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(4744005)(5660300002)(15974865002)(478600001)(6486002)(6666004)(2616005)(6506007)(6512007)(31696002)(86362001)(8936002)(8676002)(41300700001)(66946007)(66556008)(316002)(66476007)(110136005)(38100700002)(83380400001)(26005)(66574015)(4326008)(44832011)(31686004)(2906002)(43740500002)(45980500001)(491001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNrSWFpUUdGb0IrMnBoSlc5VHpZaDRMS3lzbHkrOGtZSDFQeVZ3RE41ZktX?=
 =?utf-8?B?YzNKMDB3K1UxcVc5V00zZjhqSGh5NlovUjlmaWo4VUphKzBGNldIbEtpMUNt?=
 =?utf-8?B?TVd5MFRTRWxHVVp1cnd5ejNxVVBNYUY5QnBJeWZ6c0hxR0c4Y3pFYjVHVk40?=
 =?utf-8?B?MWNGV2VOQUh3RytveEF6eXVtMjI5K3hTSFJReGlaSzNOTmZCNVVtSFV6M1Jz?=
 =?utf-8?B?N0VWUUZlVDk0dmlhaWJzc0RzR016SXFxenVtS0RRWG5hYkEzZFNXMFM1dk1n?=
 =?utf-8?B?RUkzYUlsR25GUEZCWWdFc0x3QWsvd0xqTTJMUVAwekxDWGNRKzJSTFJHRFQ3?=
 =?utf-8?B?ZzlaRW9KVGZFUEN0TEVnWXpYWVM1TlVjaWlIY1Rna0NyLzdpa0lmQlQzTWRM?=
 =?utf-8?B?MDNXQzdBaGIxd3ppYkllOTVoYk81ZmxYbU1IL2twWGxnNkN3TGNrUkxZZGcz?=
 =?utf-8?B?Zlh4dnJBS2Z4TEkzVytxN05RYWRFcXNVK2dlQnZDcGh1RHJONGthbUYxUFhI?=
 =?utf-8?B?UlBJUmwrRU5Bay92RmlrYUFQeE4xQVhHOFMxSTg4L3graHoydDRZSXErRHlH?=
 =?utf-8?B?alhLbmpPcU5UZ2N2czkyT0Q4U2tiTzdSTzZlRWhVNVNNcmxCN1JWMVMwZFdM?=
 =?utf-8?B?UDNsSEdCdERvT1UxNlg3dUcwaWxveHphdnhUWGY0bnFBbUJmRWx4ai9KUS94?=
 =?utf-8?B?YW9GbHU2UC9tUlRqNXBnTHFMSG5pRGRHYk1NWlMrMDRwMDQ1K1RDZW40K1hm?=
 =?utf-8?B?cHhYZEV5NDlXOVNFTER4VG44Y296d1Y5S1RRZmlWWW9LbXo1TEJwRUo4cUhN?=
 =?utf-8?B?aUs0T2FDK2xSTGVRUjQveVFyY3lCSEI4UzJOSzEzWGcxWW5ubDk0VmxmOUlj?=
 =?utf-8?B?c0h0cmk4dlFMTlBkUExiN3NyamZIaC9UbVd6eW1IMmlxanlZdVVXVkVKQ2Z5?=
 =?utf-8?B?dkwrZmZMSHpYQ001NkIwUVNSdXdhZ1QxZjRhL2cwMW1peXRubjNKeUM5ZVJj?=
 =?utf-8?B?VW1PZjVTa2FtbVUwMVdUdnBPMHBVd3JPSzlYWUNKdXlDZHJLeVpwS0hMT2xt?=
 =?utf-8?B?cEJpMG92RDZxVmIyYnUvaUlRcXlyTit2akUwb3VOZURBd3AyN1Fva3l4RGd6?=
 =?utf-8?B?cVpGSW1vUmcyYVhpU0RNNEhUclZ5Y3N2cmJDL3ZWL2JVZzlQQmQ3eVhIMm5T?=
 =?utf-8?B?UHJIeXdhemZvNHdrNE16dStZY3ZpS2NSLzZINW9vcHVnUWZvRTBPbnZQMFJX?=
 =?utf-8?B?TkxFckdqakg5eEJGVkJheFRQUm41KzExVEUzYzB5ZzBvdm56ZEdJV2xPQUJX?=
 =?utf-8?B?U1Z5MC9JMU0wNmpwYzkrYU04WWlwakQ2SlhGSW84bFU0V2RoYUJ1ZVU2S2h3?=
 =?utf-8?B?SzY1YWNBU1NGZGI5aUQxQTR4ZXZlaWF1K1czZFh6SmlaTmZHcW1rRmlPTFBo?=
 =?utf-8?B?SitKc2VYeVd5QzFtNVlrem5qTU9BRGtrTi9iVmpJWmlkMW9FMThXRVNQbGFX?=
 =?utf-8?B?MnQvTWNvUGh1NjFmSmI2bFlpME9JWEhqSnJlZmJVeThvQWltK2JvbzUxU3dz?=
 =?utf-8?B?SU5NRDJxdFBzS2dDcVEvMVVaRG04ejNKeCtVUDI2NGM4RXBUS2ZZcTUxZ1dE?=
 =?utf-8?B?UGlReFE0OXhQYlltdDV3cjh3Nk9PRnFQYVI5OEQrclBlMUFSNld5K25wKzBs?=
 =?utf-8?B?NWUvYjBBNXNjRElOY2k3R1VReXNLSUI4Qk9maG1ENFRaU1JEYkYwMkJvcFNU?=
 =?utf-8?B?czhEaUI2S0JSc1FRM1NIb0o0M1l6NzNaQ08ydWQ3RVpPRDJ6NWE1bncrMllO?=
 =?utf-8?B?WTZoeG9YckhDemRIQVVrZmVkR1hkL25KbG9rTk94U0hLcW91dWdsZ09BdTJt?=
 =?utf-8?B?cGE0YnJqKzZmMjRsaVB2R0Ywb3ZRV08vOWwveGQzMTFlR3FYUkgvMzdqTXJ0?=
 =?utf-8?B?N09MTTlQV1grczV5VHYrRVZIallkVy83THgrMFh6MWpzaFVGY0RMWWhCU0tT?=
 =?utf-8?B?RmpQY1dkWU1oZ1RJVXNMMVpmMWNUVG50QmtmVUtXR3RyejdTTC9mdlJMK2N0?=
 =?utf-8?B?bzdhbE9mc1UxTVRFT3c0ZGxwT0Z1SHllL2VvWTY5U1RuYWlFYTFLSkVZZGdV?=
 =?utf-8?Q?oM8b013XymZN5jcixoqFgnIn8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b39f33-4ba1-44c4-334b-08dc12589577
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 03:51:26.2000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp5QeGvAYOCTyI/ha5u155GpWwTM6n7XaLUUodc1RZkIqk/mOUlq3e5irbEgDJSyp3nU2ia9L8ccrJTZdwA5bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874
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

+Ye

在 1/9/2024 4:52 PM, Thomas Schaefer 写道:
> Hi all,
> 
> We are trying to enable FIELD RETURN on the NXP i.MX8MNano LPD4 EVK board.
> 
> We enabled Secure Boot in u-boot in the first step. After checking proper execution of a signed bootloader image we closed the board blowing the SEC_CONFIG fuse.
> 
> In the next step we created the board specific signature with UID of the CPU included to remove the FIELD RETURN lock. After that we were able to blow the FIELD_RETURN fuse with 'fuse prog 8 3 0x1' command. But now, the board cannot boot any more, it will hang after execution of the SPL bootloader part.
> 
> We can observe this behavior with both signed and unsigned bootloader images.
> 
> Is the FIELD_RETURN feature for the i.MX8MNano supported with u-boot v2024.01?
> 
> Best regards,
> Thomas
> 
> 
> Thomas Schäfer
> SW Design Engineer
> 
> thomas.schaefer@kontron.com
> www.kontron.com
> 
> 
> 
>              
> Kontron Europe GmbH
> Heinrich-Barth-Straße 1-1a | 66115 Saarbrücken | Germany
