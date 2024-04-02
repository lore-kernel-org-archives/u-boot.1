Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F244C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439AF8805B;
	Tue,  2 Apr 2024 12:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Zzogft18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7B5487FDA; Tue,  2 Apr 2024 12:57:49 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26788806A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDdGFza+Sb0hpjEkxxjTYwxsfxDqUIkLRS9QIF638B+fuND2fbRtwuTWSFl+7eEBbmACsh5KLDUJwJ3buOkjouicafVBPAPovW6WbPkL6VeIRwUFnURqiX/OrGiuVPVMOxXOf3DNPzzKA2zGb/T9CRZySO42YoHfQpmFcjvePhsQUTDLRHMh413YTt3RLIEjGZaoKZjFILnspF5p8Yfb7GJPBdHWNFe2DfegNtr4CBkBD78QxRrSBEVCkim9f0a0RQpjkput/Ui2lH1A7xEVGHKIOlRpb8Bx1R1q4WWDTp1J6g3v/rpah2U6+DVR8GMgwAjwHXZD9I6Vb2isy/JCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBFSB49wSQ7gAtVKVW4dq2/dotvEJKy0mJYPTH2MVzQ=;
 b=ml2GStR9uIb796Tkmf2q4ggpoUHi1KBu4ouhSYdfI9ABynjXbXHBG7zx3HqNuxCxSeCUoEUvFTDekQ/k79Mqw2kVl9uHSs4yTltv6m95Bva9+Z+bYPrdEh2a1As/2PqfQfMsTXkbefUFvTE712U/umRxQUNRdEj6PpQizDmwCzt2Mat9F1eqjT4wKjo2UQ69+h8vS1+wLvhxUulN1PHLYzP9k8sSwf5yIS7a+vfaUeP0Yw67R3z5PCSp8YszO4K2fgQESMB9Rp0fx2/yhIA/q3NGLBeSvehjiNVmzXyW6/JK0DP+iXSfDP861iVNjgFccc0Yd90/hT2CJvJgFVNP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBFSB49wSQ7gAtVKVW4dq2/dotvEJKy0mJYPTH2MVzQ=;
 b=Zzogft18jJjMdUrSgFSDYQjZXUoz/UIH9G/N0EnKaw9BlohzpAMSVVIYm4WfNhTrUFoj+KzvUKrUW/hKyV/+rEXaQU3o+czwOh1mZKE1bt0Z61sZ77NM9d6EEfoRaNQ0XQETG3viOjasGwMYaxrcRwNZwdJ59Z1PzixRpAdZaOR3fbw3cbq038+PQG/+oYvexHfH9bKxv3IqP+pb2y11nTBpe7oFxL+crOzlBV6lMiirBfUa47Hwfa5hhEsJPOA9r1pxaU35zbLOxl9LfQQ5qxdlnMfurRKO/sluRBYG18px/0iKtvDlpC+sdRNbFUxqv1+85JrgjEC3NzUhKcaObw==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAWPR04MB9741.eurprd04.prod.outlook.com (2603:10a6:102:37e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:57:44 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:57:44 +0000
Message-ID: <bb89edf6-81ee-4c15-9de1-991967b566af@theobroma-systems.com>
Date: Tue, 2 Apr 2024 12:57:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] clk: rockchip: rk3588: Add REF_CLK_USB3OTGx support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240329190224.3613471-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAWPR04MB9741:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRmNQSl5XrteCBSnIDpdEyE6buE9Evp/V+o6zT6eptzlZpJX4xGHFIMWYJEpPSYM7qAhGBzxXfaM15ZnhI+9KaApqw069i7KvTy/4n5VUhdx/B29C6E4eSIqYXKjVQNEprMa0FDxt9KGl8nXiIGoTpKwkbnEYSBefF0HiKlU68uriuG8p0A3cIeUcHIoDkFu7VSwlgAuIwp+3MiHJDksA1f24fxPkorDcnCjnlIyAYXuqoSvTxHFxsamyqOlYFS0GjCyf999DVVg7kSvldkuzFsMojEytPrM6UjcLI33WhEpwNO844I53sfHQzVoF7IlXLB3Td9pqbp1qPL3YwCaV33zX7NkvR5dr49WHAorYHjwODQ+pS5v2MDOX8jdqEaXH7p6AZH9198EODcPZucdvvRUoSf7RfQvVzIz86jjuupeKWuRIPaZlKJmpuEVWYAocgjCF6/gmSumE4a8+oYhqAr/drUcScT5vLzneAY9cwAkxJlCbpyXQezCyg0/8pNzIB4APti0oeNRXSLSR50eMfMx6et+jE1URjuRw2KhCCYY4N8KTIYkqL3pWfie7pAc7fmMUhU/fNbIDvAT/ArfK3iKwYGD0TDWBYeIVn+bDSwrbN3p/rIibSzQczDGxhvF/ImA+k0viJp8gOcKwuwCpE1mVqHJ9YDwn0xcg3QZqsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZQV2tzR3JVaUhsK2VOeGtpUldOL2hvSi9GS21yTU5JdXc5R1VXLzBmTkFJ?=
 =?utf-8?B?OG03cUc0SW1nYXloRzhkY1FIalkvYjliWW5WcTFuU1c1UFFOMXovNEgzN2Vq?=
 =?utf-8?B?MzhtcHpLUFV3UHpDbFFkT251VTJqSXFkdEtXSStWZ2trNGNiaGw3QThxY3ZI?=
 =?utf-8?B?R25XLzdOa09FZEJhRURUTHYrR3JMcGY3Z2tZNnpnbEVaMkw4L2FPU0hHS2c2?=
 =?utf-8?B?bmt6blE5RnA2M2hqN3BidDhvMzNPcFd1SGV3NDlnb0pIbXVQWmFVcVRLNEo4?=
 =?utf-8?B?TThVTDVBTDVNaGF3VVFKRW1kVFU3MlVXNVhpWHVLdnZuVFJXTmtvVkxBRllI?=
 =?utf-8?B?c3FZL2h3WCtEMzNlcjdIMzcwSSs1SUx1Y09ONnQvMFdjcE9panZuaTNIZ25H?=
 =?utf-8?B?Rm0rai9DQkVKdVdJV0YyQXU3OHZ2dXV5TEFJVVp1WENDelNlUk5CbFFQWUM0?=
 =?utf-8?B?UWtkNWxQOTZ4SEJRVEs5S2JCclFWR3VORDAvcGdzV3VhVTZjcnRpZGdicDVL?=
 =?utf-8?B?R1lQa0RZK2tBRG1YWjJzK2dobVFNMkFRYytMdlltY1dxazI2dG1vUFNldHpX?=
 =?utf-8?B?RTVYcEJsU01EOUxodG9wc1d0cjYzWWhrM0o5b2J5NEwwUzFuMVdUZG4zT2x0?=
 =?utf-8?B?WUxIaDNKQkpuRHNOaW5nZ1dvWHZ0dHZxU0xscXNTQ2hMRmF2UnNqckJGaEhm?=
 =?utf-8?B?TW5XMFZxSWV6RXo4MjRrV2Q0eWNidktMVUVhZGVEV21DazY1SWZKd0RUL25Y?=
 =?utf-8?B?Z3dPaTgzV0ZpNER2NWRSUElLSEh3QTZocysxVFJ6ZkJ4L2dFZXAyN29ZcFd6?=
 =?utf-8?B?OVVuNEoxM09BTFlFRkFTenArVHhYS0ExcURHNTZndHlzU3ZVcnFDSTZFZ0NS?=
 =?utf-8?B?K3RBejVyRVhqOXFlUk5Tdmp1MWY0ekw1VXVIdmxXNFBRSUpqYWl3cHZzOXgv?=
 =?utf-8?B?L2hiS0toK2M5RXpvL29nVWpoTkswNkJrcERodTBwZ2xYSzhpZ1JtSUR4Rk1m?=
 =?utf-8?B?ekhvL1RzU1RZMklFOWVvbi9YdXFCdjBTYXdtbzNkY3BteDFpVnhoUUs4ZlVY?=
 =?utf-8?B?ZEtWbk5wME5uQ3hoelg2YVBlZmpuSFA5ajZOYXpycmdPMnFqZjl2cU5ETHdJ?=
 =?utf-8?B?aUxlMUxGa2FaWlM5ZUhUOGl2R2Uva3ZBL2g1cE5mR1hwdVIrcm5JbTJKUit3?=
 =?utf-8?B?WGs1N1hXS1JNYUJ1TXI2T3haamYvZk1GRVUrYTFVVy9KMDcweHp6Y3R5WTFq?=
 =?utf-8?B?TU1LZzZRcy9yckppOHFwSzI1U0lSMW1kT0M0UExJNmNwQkx4TVgwOE14M3Jl?=
 =?utf-8?B?TGcrT0FpeC83TWdxczZia2FmRUYwbkxnTVFHTWhkdTBZaUVMZjNZSkc1L0Er?=
 =?utf-8?B?bm8xN1QxK3BMMmVrMHhQbFhJMmFNR3NOc29XMTNkNm0rUzlvK29lUUJEUy9k?=
 =?utf-8?B?K2E3RTVYT01iVXFqR1VjS2t6WkNNdGhQTzhUbGpadFhXS0FHNXYvVUhPMnVW?=
 =?utf-8?B?TkNBWmVVUkFhL1l0MXo2cS9nclFFWnBSVzVBSndZNXJCN3NnRnV6bGZEWWFu?=
 =?utf-8?B?emVWUU5pUDloY3pWUEx0UWRHSkFqdzBiNjBqVEpNS05nMW1uZDF6ZW1LL3N3?=
 =?utf-8?B?aVB1UzhGYVlJMzNDNzdvMVAxaGVhQnVuN1l5M0lDRDJaMnhLYWhOazU5ZmUx?=
 =?utf-8?B?VE1vQjIzVllwNXZzSHdvVnV6VUdxWDFacG1vTll6eWYxNkhZVS8zSm00dy9z?=
 =?utf-8?B?VVg4cGh3SFMwV0tteTBVbGo1U1lvQUMwRlR3NHhzWDZGNWF0OEtrRGhlcnJu?=
 =?utf-8?B?V1ovU2o5Z3dIdXhmTXFZdGV5ZlhkSVJqb0ora1FzSVVpczMwQUVwMGJjOFgv?=
 =?utf-8?B?TEN3eDVESzB0WGp2RndRTDZiaWpkYkJGQ0NnQ0p6Smp4WERuMFFzL1NMNEYx?=
 =?utf-8?B?eUlhSDNTOFZDS25hdjBMM3I3UGx5OU1FSUhRaDZpMlVjOFo3QUtkZjk0MDJO?=
 =?utf-8?B?WklPRHdPWjZud2Z4S2NhUWpKcUZRZ29xa3cweERMZ0s3WXV3blJlSEZ6Nkto?=
 =?utf-8?B?YW85YUxtR0Y5SmR0L0hNRytvWmxFMlpzT3oxZzdERjdzQVNmNGxveEdQYzhW?=
 =?utf-8?B?SWE4Y2JEbWgxVGpVeTE0c0cydjc0ZGZsRkVEbUR2RzU5V21TSWJoTHl3R3RT?=
 =?utf-8?Q?f3Eq6201bHZbpsd4zK6YrRk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aea858-a1a8-4483-57cf-08dc5303b940
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:57:44.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuzV2wjZXDeWOkgissmCTWz5cJAYachoENRXSccC7bka46RrTnWyN7j7ehItCMmzHYMLKmHjq6Pe+hcWjokvB2vK+wGIEaHr78evrDZ3DLSuvnA+jwLwiv2T3N6X4glr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9741
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

Hi Jonas,

On 3/29/24 20:01, Jonas Karlman wrote:
> The REF_CLK_USB3OTGx clocks is used as reference clock for USB3 block.
> 
> Add simple support to get rate of REF_CLK_USB3OTGx clocks to fix
> reference clock period configuration.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
