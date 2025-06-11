Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A9C678DC
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 13:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D490A82B63;
	Wed, 11 Jun 2025 15:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jrcR40DZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A50A82B70; Wed, 11 Jun 2025 15:55:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7F582B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 15:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zARSIcWTOcJh5RQWzBZ2YD+mogiNO471QaRmlCib95eWhLZgB0+NqQeaGupVUj/jkKCIxp5HW9aMprf0pY/SNpMgu1IxXGN1VgS3d6Xzb4X9BpdIpsNmOncK2kGeSwpQNfRdSd35aNH1RW2x92thkiQudliQ1XeUrDhq0cA1AcOpfbgNcuvtj8aamCO2XZUL+dXHV09M03m96iEPlQjcjgzvZnzUmm2FhxEJSnK9O9awlpbuzHf0W5WH3uqxJ24xmMLKLRBd1fFglYQEZHssMcG3nDSIImXQbeZsz/98Die4maGmTjbG4i4XlO5g89zSEeuRul3o1mHO/MTHJjcaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0up1CYuF+8fuFQKFecRLfjUdKk1yMx3D5MknsSFmsJw=;
 b=oWgSLzqNzXp2bUwoTtUg9EuZ/KfI7q2gDTVCD/oDnYkckoHub88/xrFmBQW1vWV/ZXktIY02zjwqUACmNl7AlLxwfAJePEAxyK4XZuemvFFeD2C+mqRg3U7my2/382ylXtWrFLEk7ETL3a60IQ/9I7IAmhXzfSoNTEztKez9A3pOM25hSB1YUkuZXv8ubgrQKpqAR8p+3QgKaTVswutc/MTWgJNOxEd3tTsobynLZkyfuLN4WI2Bal3l9iBK5LU5LCFNB7C2y8d68OUbONUG3g0aagBVCGbtmZ64EptqdSTgLHFzbu9KnsET2cF7+y9K/uwEDBNV/pn4zoUizX7fFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0up1CYuF+8fuFQKFecRLfjUdKk1yMx3D5MknsSFmsJw=;
 b=jrcR40DZThQZsA0dCslfSh0XA0KMcBTNlfzdi4tsZu316WqeZOcPVnYaLJWvGvKhsiSqM8flD7oKamlV/Cywqb/f15mZOK6Ptrk747t89VLazM8R4lKTlnfZqw6V/06hC1myRNAS5RhkzHLffjBvjpCkCvPSqJzCPYLNAf9uBtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8680.eurprd04.prod.outlook.com (2603:10a6:10:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 13:55:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 13:55:38 +0000
Message-ID: <33d65ef7-34ca-455a-bf91-11716bae5236@cherry.de>
Date: Wed, 11 Jun 2025 15:55:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] env: set fdtfile environment variable from
 /chosen/fdtfile
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
 <20250610-b4-fdtfile-from-dt-v1-2-aec4df0fa53e@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-2-aec4df0fa53e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a938a6-f6ca-440d-9f74-08dda8efa552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFNIc1JFekQ4R2grNzdtcnNxd0RvZkhBdC9DWm1GeXdxTllySHcvOXpRTFg2?=
 =?utf-8?B?UFlZQjR0V0o5TXFVNTA2cXpYNk5ERUtNN3lLZ0RQdlRnTGVkZzAxSGUvRDda?=
 =?utf-8?B?UzFqQkMzQ0xHVUdiREVUdFA0bkNWL2R1dGV3N2RGeU0vMEo0aS9zRndMYkI3?=
 =?utf-8?B?cVh3ZVdsMmJzRUFWaWJnUGRPYUx2aVYyMUk2Smp3d3RrejRkU0hIR1pkdE9t?=
 =?utf-8?B?L01RUEcyaEN5N1JOZzV0OGZidGpCeHVkWXRGMEZ6ZGhva1pMOUFHeUlWL0RZ?=
 =?utf-8?B?Q3pXTndoK05XVkFCTTVGNThkU3NEc0pRdGlBZ3krZXRqUlViMWsvR2U1aTM2?=
 =?utf-8?B?eG0vVklKa0V5NmoxUGdOKy9mUFJHYnk5NDZzSlZHb1h1S2I4QVR6RWExaHZE?=
 =?utf-8?B?TU04bTcvTWZhL2JQc0F6bk5vdDVJZ1VPVjZsWUFETVgyZ2NMSWRsc3FmREU2?=
 =?utf-8?B?RlRJZGoxcmJqcU42VWtjQWpxZEVkZkV0M0NNM0dKNVJiNm9XeTVqYnJHdXJS?=
 =?utf-8?B?bkRJWGlYK3VxRGJFZ0l2VUE0Rmc1MUZTQnRFa3pYNHg5OEF2RHE3bzRWMHg4?=
 =?utf-8?B?S3ljVUF5WENGUWhSNUduNHhnTU9UdWZtYjRsbDdBVFhJdlR0d2l1Rlg2OWFr?=
 =?utf-8?B?V3ExZjhRN3FFTnBMY1JRdnZTNU5LUHBrQkdnZlBOajV2VVZBMXVkdG9rS2VD?=
 =?utf-8?B?TFRqaXFLYkJQbFZzT1lpSmFvSTdZY3RXeEpXbktuNUpxM2x4R0duc2JhR2dZ?=
 =?utf-8?B?R0lTWkxhQTF2Z1U0MGExY3NPNnE4d241RFZYYzRDM2FLZWxGUDhFcENobFky?=
 =?utf-8?B?VVVIZm9Kd0xybHBLcjNzaVhGNWVxQ2lPWkltY2JFYmJobm11cHBXMzF2LzdO?=
 =?utf-8?B?a0dFZVhEV3p4dVJtVjVWdzl0VENKZjRRY2NJYk02S0pndllDVVh4UnZEOU5K?=
 =?utf-8?B?THM0aG9QK0c1R0pkVzFjSzd1amNZTFpzTlRwTWFYRGU1L3h5ZDdVWndtdkQ5?=
 =?utf-8?B?ODFuOFBua0VnUGd2R3MwQ2FHYzdUVjBtcUViRFFCOTZ1MXVCcWdKVkxqZ2FD?=
 =?utf-8?B?SDA4K1k2WkRQb0szd2liOFlrQ2RBVkdhdlkxWTNFTm1MQVI2MkluaXNVdlk0?=
 =?utf-8?B?Z0VlM1JwOXpFcnAxakFLZUsrZWhheVpTWFN4N0JJQThXTFNsQ29Wcyt4UENx?=
 =?utf-8?B?SzlPODdZRTlvUHpMd2s1R082QUlUM2RJbFB2ZFhDYTRuWjdLNnJVb1psdStl?=
 =?utf-8?B?QUd3bEVma2RFa1ZkdE8veVZuRUxIV0tNZWMwNUsrZVhYS1BVTUFqTVhnRENW?=
 =?utf-8?B?cm0yRTR3dEJSMGlrTVF4cXZjdlFGbDVaYU1XcHBHVHpWQkoyRW9mMlc5RFpC?=
 =?utf-8?B?RWYrTGE5TlRyK0NpRVIvcXV5RGhMenIyVHBydHkxWkRRQk9jWDB5ZytEOHJ1?=
 =?utf-8?B?SnQxRElTSDN2TG5tZWl6RHNkekVpV2hqVjdocUFwRjBIaEVNQnZ2TjhPRnNn?=
 =?utf-8?B?aVRKbWNMZHE0N0REM2NxWTdHRmJjRkxqcDdwYk5mMGczbDhtRXZLVE5LbnlK?=
 =?utf-8?B?akpSdHlKQ3lML1dIRU5UV0lvdFI5anIyMTc1MTZCVVNHUFpVNURRT1EvTEM5?=
 =?utf-8?B?eUIxbG42SkUrV0ozTkhUZlY4b0NhdVlZakVQK29POE1uSWQ2dERzc3VxQjkr?=
 =?utf-8?B?dXBYUXk5dVVreCtwSXRjL1RLTVZhMEZEK00ycXFuTlF2YXM3c3Rna2MyVkpj?=
 =?utf-8?B?ZFZ4NFVTVjYvWEl0NDhaSW5qNjZrdC9ZcEhVZkZsOFhQemJEUmNCMUNsM0JF?=
 =?utf-8?B?VTVQRmsrM0FaNzFTRGF2b2w3Wk1FSnFkQmpOUW0vUUFNOGhwdHVVcmptT1Jl?=
 =?utf-8?B?UkJueWlaMmFPSlJPZ3JHTnNjKzJ4eUxmYVUzcTY3bXFTaDc1azRQcDJocmdW?=
 =?utf-8?Q?LchUqdg5PLo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1kzeUpQeDJ1MGg0U3FoUlhCWGg3aEZneE0rLzd2amI0UHptRE1mK096Mmhh?=
 =?utf-8?B?SjNBbTBxalhoRTBuTkF4OER5elVQSDdXS1BDemsvUE5vdEVYS0JkSGhVSDli?=
 =?utf-8?B?QkN3dnlPR1dBTmZjbXF1Nmp0cUN2VWRUWE15MktMaVI4QnowUlFUTFRTS29D?=
 =?utf-8?B?bkllUjd3dDdtWnBnT004cVp6Y25QaU9UYi9lY3I4dFk4QzlEK1V0NisxVlpJ?=
 =?utf-8?B?TUR6NHdkRFZXb3BGaHBvQ1FDN1RzRmpqZlBxdDA2NnZva0tsRUVWRVJkRUR2?=
 =?utf-8?B?L1RmWHFteHlnYmM1NEN2WC9meGhDZ3BxS1lEYzNqTnpnSzVjcGRvMWZ4aWpi?=
 =?utf-8?B?MzBMdGtodXB3b2tWYlpJVjRSZGlkVmtRN1VObkwyQnRXWHBEMUg1TXZVZElC?=
 =?utf-8?B?aWo0MHNCSDJsOXdsRUd1WkN5MkUxdlgyNThTVFpHblZPZVlTUFIxMlJRSUNv?=
 =?utf-8?B?ZEFXUjVsai8xU3ZJQUI0NUNod0hXU1RtWUpRcUsyQUdTZ0VLMlBxOS92Zlp2?=
 =?utf-8?B?cU85WHpqWk1rV3VPbnh2T1Z3VUVleDhlUktCTWlIMHNlRUZmMHNSekQzUmp0?=
 =?utf-8?B?Q2g5SUtmcTdvZlpnU1pUSWtzWll5aDAwZlpkNGJwVnA4ZUtzampvbyt3d0JI?=
 =?utf-8?B?aENxOU45Mk5uRzRZUGhzZmZhVTZGVGdGYTA2d3FBVXc2TG1veUVrRGdRaXZG?=
 =?utf-8?B?TFFmN0RKY09FeU1pTE5tMkxUZVVVYVNCRVNCcWhBMVlmOFU5WjVJNUllM1lE?=
 =?utf-8?B?R3B0dHY2bEU3U1loT1VuZ3hlU24yRFRSU09oems3VGRyTTdGUk9TRll6SXVI?=
 =?utf-8?B?QThlaTRWdm5iOTVmVitsTEEvOHhYY1FmVllKQzlma1h2Q2M5ejFQQVpxUXlN?=
 =?utf-8?B?bEdoZTFkMmVQWXM3N0FyenFyV3ZjSWhiV3huQ3U2ZjlEdTFIYy9YMWwwT1hi?=
 =?utf-8?B?ai9RR1VjaklENVFwK0ovWU4zNXRYamw0bUFNQVYrMjBvOC9KaXlHMUluaXUx?=
 =?utf-8?B?VlBlTk5LL3BrVWEwVWtaUXVpWWRjc2d0STZnWnhIWng0eVBDRS9sRHQ0clNj?=
 =?utf-8?B?MXFLNU1LL2hGWXRJaTRhbU5ZVGNmbnhrMUEwaWRiamxEVlZiUVcxakZGSGM0?=
 =?utf-8?B?OHU4WHphdllaNjYwRWozcDJpQm9qMi9YWldqTTdzUHZyZnQ4cmlpclJvZ1dE?=
 =?utf-8?B?a21WZ202NzFwZTVTNitxY0lGck1ycldPZUNkcU5DVWJpT0lUR0NTZng4NFhz?=
 =?utf-8?B?dVRJZ0Via0FHNnRFNGYrL3VRaGVVUWtObGZBVXpJRTltdDJkUWtCVWJLdlhI?=
 =?utf-8?B?Q2VaQkxsN2wzMW5LbERzNkFkVkxsb0IrbUkzRXpuTDlUVmdiSFRLeVBtUTFo?=
 =?utf-8?B?TDdwR2xZODhyMnVZQ3FtVUZCUTBiOS9SYi9JUHZYSzhXZ1lpZS91eGFseDJU?=
 =?utf-8?B?TW0vai9TYWFpSXFNREtzWjF4R0dHZnJYYzVacDZEQjg1MUR5TmNSVmdzR2hy?=
 =?utf-8?B?SHk5TkYyaVg4aGQvK21kRWlDajJPS25TQ21pbkFSdkZQNlYxMGFPSFE4NmpS?=
 =?utf-8?B?MTFnSXQ1a0IrTFBYMVVJRzl6cEJucGZZY0ZXMWxrWm1pSUl1dkFMMGxMeW5U?=
 =?utf-8?B?N1FxZmYrL2NUZVdBaVpNRmhsc201aEVCTG5KWmVCZGNTL2plTTBHN0ZSWndZ?=
 =?utf-8?B?SjlUcVNleERmSDVOcGwrenRjTEw2N2NjcjFHajJ4OEUrS0dCQ09xRWtLc0Ny?=
 =?utf-8?B?bFVYZ04zSkE4bnlkdEpRVzZLcVFYNkdmNEFkeUlYT2hQT3lIa0pUOWhIQ0g3?=
 =?utf-8?B?NE1aTDBZd1RTckNEMW10K0VzV0xGWGk3NnZxeVJIWkhxbUxLVDNOMk80SDZE?=
 =?utf-8?B?K2hEUHdXY3FxMXVmL0RXTjNsTmMyV0p1SWFFNldZaHRjTnpjNG5RMTNVeEZP?=
 =?utf-8?B?QXd3T0JHZ1IyZlVqTHBIRDlLQTcrVnJqamhpa1U5T0RJd1lRb2ZSdTVybWlu?=
 =?utf-8?B?NkdZTHF4LzhWTFFCRjdUOGtZMGNjUU9PZGJiVTRSZEc2WkhJa1NFb1JvZWlk?=
 =?utf-8?B?N0dkaWVrc0ZMZXJWc0pMY0QwdmZPNXlUZDhNaWsxc0ZDVWV6NU1MQk5lRkNo?=
 =?utf-8?B?UzcxNFlCb2ZBTEZWaVc3N1FDMzZiVy9hdzZPYW5VSEMxQ29ienZBd1RRL0VN?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a938a6-f6ca-440d-9f74-08dda8efa552
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 13:55:38.2240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4cWiDmdq7+xmJb2LP2vT4EpO6bAx7ftYpk5obvG7zcvvpkupQw5bYcx1xM6vI9ClbcH11edjCIrnuRVBBt2B9CSYzwPeMyFW304Y4Co6eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8680
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

Hi Casey,

On 6/10/25 6:23 PM, Casey Connolly wrote:
> If /chosen/fdtfile exists in the devicetree and the fdtfile variable
> isn't set in the default environment then populate it. This allows for
> U-Boot to load the devicetree from the boot partition or ESP that should
> more closely match the OS being booted.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   common/board_r.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/common/board_r.c b/common/board_r.c
> index 41c8dec8d49ef21a12fd41272581dd94484dfa08..594c7827c39cfca5f4561b4699e5b66de54e11c2 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -448,8 +448,41 @@ static int should_load_env(void)
>   
>   	return 1;
>   }
>   
> +/**
> + * fdtdec_setup_fdtfile - set fdtfile variable from /chosen/fdtfile
> + *
> + * This function will look for a string property named "fdtfile" under
> + * the chosen node and if found set the "fdtfile" environment variable.
> + *
> + * This devicetree property is used to identify the path to the FDT in
> + * use so that the same path can be checked in the dtbs directory on
> + * the boot partition or ESP.
> + */
> +int setup_fdtfile(void)
> +{
> +	ofnode node;
> +	const char *path;
> +
> +	if (env_get("fdtfile"))

How do we guarantee that fdtfile variable is read from the default 
environment (I assume here you're talking about the environment stored 
in the U-Boot binary?) with env_get?

> +		return -EINVAL;
> +
> +	node = ofnode_path("/chosen");
> +	if (!ofnode_valid(node))
> +		return -ENOENT;
> +
> +	path = ofnode_read_string(node, "fdtfile");
> +	if (!path)
> +		return -ENOENT;
> +

Please add this to the DT spec (and schema) before it lands in U-Boot so 
we can have some sort of standard here (e.g. Barebox may want to use 
that as well? The earlier stage setting this variable needs to know the 
location, name and expected content of the property).

Additionally, you say this property is a string array, I assume of the form:

fdtfile = "myboard.dts", "myboard-overlay.dtso";

?

Which seems to be hinted at by the cover letter.

In that case, I don't think ofnode_read_string is the right way to go. 
We should

1) enforce the location of the dts in the array (I assume 0?)
2) look only at that location to get fdtfile, e.g. with 
ofnode_read_string_index?

Otherwise we'll have incompatibility with old U-Boot being unable to 
parse a string array and new Device Tree providing an actual string array.

Cheers,
Quentin
