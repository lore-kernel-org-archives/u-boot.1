Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F56C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971C888A4C;
	Tue,  6 Aug 2024 16:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="G1dvHlsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4294088ABD; Tue,  6 Aug 2024 16:56:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A75D88AB3
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JatWdfa2j1aUS8W+td2Y5dj/Xgt8NEHZkgU0TeWp5XGhrp9NMHEmhMjvwIp4kQ23iiJ304Y024p3d6n9la5f/3ljCcNS7FmmQtff5g0/dzYOWYJU2X3xq0qTXSMVB6lv9KIC93+VarSeHx5cVCCazjDHC2sO58Le8xxFPLDJTZssyANfoZ/N2fFUlI6uUTNxLJmXRb0yjeuqv7iOtJOR3IS9b5otFeEnreM/j4btu9kZwxxy3v1o3je5VmZp8yVYlE+Wy7aYjlUmkpx+/Dz/Oi48xsLpJp+iJGe3i+/ywHyL5xHptuMXDulUxXqUA7wuJ/5gRwHwRHfbR/m5r+lo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeKEHh0UnrZ9qG/Y+yWjrOO/tepACIUSuJQOrmg3jYo=;
 b=uz6i/9K/snrTPVI+205bhZ0MaK362yoq/hPOuE40OIKoTsmkICdB8dhk0v4V4uKdqCT0QFod2o/IPcP7WOZvpn0am8VkjQQY5rwgIqwbg9zaGpyjr/YhaYbfVNvwmpMf52E90S+0nlHuLCFx6kxQMeLW9ry9WvMUi8mGkmJ8uGQenbhR6Z1ndKCRtneHrsrO/1g/tq3qvPF4kMrbncHB7qXf2jmMwxBRMaJsNEPL+I9y0hGHbMMrrNOUs/CV36TWbMRceREpUEGadiSjx32UumTEj1gcB4z1UwbduCEH/gJwMNlbVRu0vGkICJmczeOZBRuo1HhEYacX6GbOyE5x3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeKEHh0UnrZ9qG/Y+yWjrOO/tepACIUSuJQOrmg3jYo=;
 b=G1dvHlsWiz6g/MIVmQIu2sHNUI8JM0a2puzA1I3dKRA3tHCyfyYXb7bI3lygyMzUuEAbnr4RSR17mRm9CM379HyhfpleRH/aloNWQ4mVCF238GSMvc/4VaU8T3+C/RLMiE6DhcsvY8uACTgDlt+HC6SH9MdUzjzGcxbhg8dDOr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9419.eurprd04.prod.outlook.com (2603:10a6:10:35a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 14:56:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:56:37 +0000
Message-ID: <f2adc304-200c-480c-8d2a-cbbd33e43987@cherry.de>
Date: Tue, 6 Aug 2024 16:56:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] spl: Use unified inline functions for
 spl_load_info
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-13-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 204df2ca-8ed6-49a7-0208-08dcb627f89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejcvOWR2clVDQktsMjlhekVhYkxDNXV6TUJzQ3JWMXhLVGM0RUVaU3dZVnIr?=
 =?utf-8?B?Y0dQM3ZCNUJaSWMya3ZLYmFibllkT1VUeDdmYkpoODFDOUhvR1NDWExGeTh5?=
 =?utf-8?B?bHNJcGRCRXJqSXRRczh4RWFuelRoN2VzQVpxVzFGdVYrc2dpRnVNcTRHR0U1?=
 =?utf-8?B?QkpNM0x1TUJTcHowajRrSnJMMkVBKytIVkR1ZDNLQTJVdDl4TEZmMWd2ekpE?=
 =?utf-8?B?ZmFObUt0bU9zcXViZ21SMFFGcmdZTUsrL21VOXNYb01BV3lOSHlzb3FuQVFy?=
 =?utf-8?B?cHdMUlZCSXdoOUtXTlZocUEvMGl4Zm9jOEJRaGZPWE9ZMUhGelcvdEs1eWFC?=
 =?utf-8?B?bWNpOWNtYVcrZXcvM1QvVkh4LzBuNlhGdnFCNjI2bFExUHMxYmRZa3lzVUtQ?=
 =?utf-8?B?UVoxbCsydndGWS9tY1dHdE5WTFM3eHdzMWZDNVhqN3dUeDRDNW9wUFZudDQv?=
 =?utf-8?B?WlMrdU9zNEpvRmthRGxXcm9vSEZsRzQrdmtBSlNwNGEvdW4xQVJtVUdiUng5?=
 =?utf-8?B?ZytvTXVraWdXd1UrZmo2MzZnUEpEV1Q2ZW9rL25QczRTT2lwem5VazJrbk1D?=
 =?utf-8?B?UUxyYUJMN1lpd1NKU2RmTm43eG9IRUZFMmJ0TS8rQXIweDVVUWFNYmY3T2hq?=
 =?utf-8?B?SmlwM21aMVJBOHl6RzRQZWFBVEhYRkl0V1R1MEI0S2RwN3RyWVZVTHJyM2to?=
 =?utf-8?B?SnpWZmVWVVR0UkVsUGpzUi80RFdoRUlLc0pjcFdoN0xmL2dsOHJERkxzVEp4?=
 =?utf-8?B?dFhremZac2c1Q1BUS3h5d2pJdGJmbklIMmk2U3ZUa3YzdE00NzhZQ3kvN2xN?=
 =?utf-8?B?TVNSLzlORk5pZURQdUxHOEY1VXVvcEYxTkJ0eTk3WWFNNGl0N0s5VlhhTG56?=
 =?utf-8?B?WThYRG43bFk5Smw4b21Tb0ZzOWJkNk5KcitZSEhKZDg3SzVXSWQ4dHJ5cG5Z?=
 =?utf-8?B?eFI1c2RmcVYrSlpTdXp0UktCVTgzQ1doV3ZTUGJNdjM1ODllNVVMYVNURVFw?=
 =?utf-8?B?YWVQM05qQm1IZ21LelhiWkhBcmMvWURWVXJMaG5uODlYclFpK0UrR1kzUVRW?=
 =?utf-8?B?RXRDV040QisxeExjNWNWZmNWZnZaWlJjUHBmNXJUMjR5Q1F4dFVIdzVTc0R4?=
 =?utf-8?B?Slg5SmJQbmd4SFpRUEk2QmU4UnR0L1dVbXV0ajdFdythTFl0WVlHL2J4bmZh?=
 =?utf-8?B?TVlOWEs1MFZUZDJrcUoxOTdBS3AwTFdmcC9ta0hEZlEzamliN2RhUW9rR25q?=
 =?utf-8?B?cmRVNTNrb3NTMlpHZmRmMXRydi90U3lsTko0VGRrUm5kNWxFUlRSaUNGeTdp?=
 =?utf-8?B?OXBYTHNGQmRiS3RpL0orTllGV3dTMWg2TzdvY1VlbGF1c2drUXBJVmJ6azEw?=
 =?utf-8?B?M3VDVkJUTk9qL0xsMEgrNnB0Q3VmR3NMZDB2Ylo3QnZKK216OGtZZ2M0OTBh?=
 =?utf-8?B?bDcxT2pFYm8vOGV4TzV6RnExUWVQZVdEL0FwRFAzMEt1N2s5RGFPYTdLOWt1?=
 =?utf-8?B?WmpDZEV0cFRJa2FlaHlUR0RLbVp5V282YTQ4OHg5YmJRQURQUThVb0tSbFho?=
 =?utf-8?B?RnNuV1M4Q1lkTE9MT0o3ZGI0V2hYK3BnRlczU2Q4OFFWQW8wVjYwVmpWbC9n?=
 =?utf-8?B?NUdFamxFcGk2V0FPOFluSkJDR3BDcFdNZVNwcTBoRzZPVGJKUFhRdE5aam9l?=
 =?utf-8?B?L0I0VTBCUHBkcTJJVm00eWZ5K2UxTXcxQUxvcm1ZRHJQWDBvR1ZKbjlQYXdC?=
 =?utf-8?B?cFNmOTd3enAzQ2RVZzJGakRtdm9UZTkzbUpzV1l1d09hU0k2MEptc3R3bFpS?=
 =?utf-8?B?ejV0aFBqVVZFUG1xM0FhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVxb3BVSzRBZ29lSjV6Um82NDlkY1VxUzk1dlJJbDROM2hqejdLWWdRN2Vp?=
 =?utf-8?B?RzBLOHBySjlHMkF3a3VXRXd6VmNZNjBNWHVGMldXMFJqaW5PSk5tZ0xkR04z?=
 =?utf-8?B?VTB3ejNqSHBUWkJmUmVOcFpJKzlGQnZvZ2F0U3FVMmZtSTBmOHFIK3p6MVRu?=
 =?utf-8?B?RnFCWC9mNlZHb1VidGtBcEczR3B6Mmk4bDNNd1EwRUxvc3ltZGpyYVNxV2V3?=
 =?utf-8?B?c0FyN0swbmhBKzJsUW1XN2dSOGRFdkM2Qmt1RkRyVGM2TnU1bEVzYmJvQnRz?=
 =?utf-8?B?Z0Q1bmQ3MytLMFM1Ty9zVytTR3EyR2J3eThSbXQvaUlxVmlOQXV0VHJ4THUx?=
 =?utf-8?B?eVZPTVJHb2l5VWFQcTVkeGdmQWpRMlE3Tkl5ZDZQb2s4QmZJNHViL1VtRTho?=
 =?utf-8?B?eEJhSWhvblJtYmFNOWwxMFc5aEN5c09XOUQ0eDlTV1Vya0FRYktxb2VXY2JG?=
 =?utf-8?B?b3RWc0V5b29ZRXZBcUFIWkdpcTJLUmFWUVREWFVOaThTMCtJRklybzlIMUJi?=
 =?utf-8?B?ZzVwYm1URll5SVdqVXp5SzBPS3h1cUN4M0V3eWJnYnJlU3NaTkN5cDNKV3NF?=
 =?utf-8?B?K241d0xOdURtMnJNdXZ6SGxLTkwwd1V5Mmx4cm40TFJyU0lDcFdHc1hrUHow?=
 =?utf-8?B?cWR2OGhILzRoN3c1c0ZNbExLd3hXbkFjNzA2b0VLQWpkMGdKWTk4bUI1NWFX?=
 =?utf-8?B?UzBzY0VabjEzaTJtMm40MWtXL3NsSEl3YVU0bGpmdjdzV0ZxTkJGUmxSWXEz?=
 =?utf-8?B?SkRoNGRCZVhIVXZCd2NuRlpkYUMxT2NIY3Q1TUZ6bnJCdlZFUFhtbXVGYmVh?=
 =?utf-8?B?eSs3MDlnM3JMcG5Hb1V0bUpMcVVLcmI4dHl5SWEvejFyQmZHemJmSHAyamtZ?=
 =?utf-8?B?dkdEWHBKYTk1UFk3UDEyRE5iTTdTTXJ4UFpicmpJdE9JZXdybkRyUHBDamdu?=
 =?utf-8?B?SVY5dTdsejZ6cU80ek5aQ0h3N1JoWWhESmdoN0J4bEI0WHM5UEtuenJqZW4x?=
 =?utf-8?B?YzVkaHIwYVFXZklDUGRmYlNiNDNTUUFLNjVkNUt3aUt6bFVtaHZmcnlPbHl2?=
 =?utf-8?B?M3JGamNBRytUUENUMkdnZnNhaVo0akNZdUlwQ2FiemJRZU9VUzY5dCtoOWlt?=
 =?utf-8?B?azh3MSt3SlFIcVNvZGZESDM0RlZtYmZWaXB6MVZaY3JWZi9QUDRyTUlkdzEr?=
 =?utf-8?B?U1F1L3ZaSTg1S25ZTzJvZkpRMXNjSDlkRWtUZjhpTm9waUpaR3loaFhPZ0tv?=
 =?utf-8?B?Y0czOU1TZ0xnUnd2dEFxYUJUVVAvekdnWkVsWjNieU5RcW8wTTNsYW1vTi9L?=
 =?utf-8?B?T0tBajBDSk51OXcrNkZySGpFeWQxYkRXMC9rVVoyUjc0V2RUY2JOcHZNTzh4?=
 =?utf-8?B?a216dFFzRTJNeDdxeHJBZEFzNkFJbmNrZDI2OEo3RGZUSzlwNzNkeUZmTlYy?=
 =?utf-8?B?eEhRYjdJZi9PM0VwWWVqWjRSZnNxeUtrVER3bXloRjE4dUFxSzE4Z3U3Ykwy?=
 =?utf-8?B?S3g5Q284Nm8ybTdKamtXMi9wWmZ4YzlOOURvZ2RSSGlUY0tWajFSTS9DN2xn?=
 =?utf-8?B?UXIzNDNwQnBHVmJGdGFoaWpIclVyb2pWTFZMVUQrS0RCZ1l6VlFTTkRaZVBu?=
 =?utf-8?B?ckE4WkY5OGg1dUlQL01WM1MxT0ZMQ29IYlNQY2xlRkt6bHVBVzl0WjZDemc5?=
 =?utf-8?B?MktuZmFtdUVzZm1YNXNKcko3VzFVaVF1MDdTc1hocGM5bkpXdklTTXRuY29q?=
 =?utf-8?B?MC84SFZxa25DdXhoYU9weGgzV01RNmhWZXFMQWJuNjI3djZNYWNqaUQ0bXBK?=
 =?utf-8?B?dXQ4bkR3SHR3Y2dzREsxQWJGdEFSMEZ5QmRDVk5KQ0hlZXRZbUpkZzFJdGtT?=
 =?utf-8?B?VCtWNHBwUytCRWNvbkR4SXptcVBPN013UlJicWJvMVA4YnZ0blY4MUV5VWJT?=
 =?utf-8?B?UEhkQ1ZhMDUxWXlvYjBtRWEzRmFTTjRMdzMya1ljZzdCbzVaa2FKYVloTEtP?=
 =?utf-8?B?M1UyTEVYbzczNHZTWlYwNURpWDVUODMwUG1MSllZNzVSRmZhWFFmLzlOZWgy?=
 =?utf-8?B?aFl4UXBuNElhMGttMGVjZmlqTWUrU2VJTXJnU2tsbUVaTWtqelAyRlNzL3Ri?=
 =?utf-8?B?RUNydW9CRktLQ0VTRVlDQnB4QU9CRmhTMW9TSXA1eENPc29kYXk4b0dxY1RC?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 204df2ca-8ed6-49a7-0208-08dcb627f89a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:56:37.1888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvFIvfLmcS15v1wwmy/Hzr1Y1xafVAxeXEO7OxAB5WvIEtVlRi0/FRPq+b0FnJp2Oj63mqa7FUA0oqa75Zg+9jFenXs2e52Zxose6OZ61+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9419
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

Hi Simon,

On 7/21/24 5:25 PM, Simon Glass wrote:
> Rather than declaring completely separate functions, put the code for
> each case into the same function. This makes it easier to read.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
