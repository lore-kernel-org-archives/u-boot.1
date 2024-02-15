Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318E5C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 16:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C4287DFD;
	Thu, 15 Feb 2024 17:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="SehA9x//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B89C87D80; Thu, 15 Feb 2024 17:56:20 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BFA86D38
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 17:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH275qEhWJ4RKX6XB/dNqineaSGTGrAHfPlq6sCD+jGxn2J0UN+GsCzBsgk5V4zjylHFcUWpPS1kDhmVQ9Kn+sPs4Ta8NE/5YvfKZv7XUtJGRqcYgQs9rNaN+cQWKb+bBKIalclIbnBMydA8gdA+maQmJFypa6cm/tqx1ImXhXBUX/8dBKXObIw+0EclPXIx9TbDakItcXAcJ5iws9mUOL3uVt5WwpESMbArcNSYWED7CttX9cwdTTo9Bqa2nbqQZ3BQh98vPfY9I4G94lNMrABQVRa5OibMhAR4JQMVpJDkHOPXibhiA54u+b4InzsyKlj5xY1GShnxq7xg64sIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZIIHtx4YOE5E0hWqyllSua7UXXHkpJtmBLHt8lKlaY=;
 b=XECANoNLKh3xKbgVBqxxp7rxGgZRqotfUqQIZUm4VswYobvaT4s0BwrSMocz1F+nmDtdKd1eYlTe4Zu57IvQg4tBjqcV+1hpxKdnwkhqVv0O9v5B3LSUwpV6/NCKL6v7ck0aYE9TBZVBg4/MQdxawEDxD2EGbMeblB++0N5LHrZA90DXQhV8vZgveOlBoKPETNG96Z8eoXSsip7fJAhjdR3OwtceGQCvOXStj/+Lhp/eaZ0xhNKOQwbkFN9a+0s8eTJji67BktVw9+MXZ3Co+ie5XIWEijEYXZ102BcnbpxmrWxAHM7Lyxg/bw6n3poHklU+yxxcHO0SEhlIU7tWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZIIHtx4YOE5E0hWqyllSua7UXXHkpJtmBLHt8lKlaY=;
 b=SehA9x//z/oNd/6xkbUBI6YseUy2MRbCeNVnOfCj3MO910V0nddy8XASdBP9NAXsPcJMTPH2qCx4N4Jt7fZl8TO0Q5TS2hgePx8OMIl7Rkbc1IYrnxIp/MXOWBOJGFdcwN8u7dkc2VEOJzS2i83O/7hgsz7tpWczz+4WV8ZwMQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:145::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 16:56:14 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 16:56:13 +0000
Message-ID: <dd662626-279e-4a71-b964-1553cb27c7ff@kontron.de>
Date: Thu, 15 Feb 2024 17:56:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
Content-Language: en-US, de-DE
To: Andre Przywara <andre.przywara@arm.com>, Frieder Schrempf <frieder@fris.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 Dhruva Gole <d-gole@ti.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Neal Frager <neal.frager@amd.com>,
 Nishanth Menon <nm@ti.com>, Ricardo Pardini <ricardo@pardini.net>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215165054.4ddc8846@donnerap.manchester.arm.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240215165054.4ddc8846@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3506:EE_
X-MS-Office365-Filtering-Correlation-Id: d94e719b-fa45-46b7-3a36-08dc2e4704d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szNWo50d9hGfUvQ3+kpAK7AvuSSSujsilkpDyzDW+OcfbeK5WRztgkY8Ygiho4OE7Xe0sWYSCNJ7NUI8c25kvtKCSk17yzoPNDPkGw8IZe72EXuGZZEE24bQFrTkwPmGXBJm9KcLGvYpjuLuULm6Vu1A5Uyo7RhCMcE57GcSksd9TSYhskaj4ozUKyl8C0+648cY6H3xWL/CjFmpH/K4kdmuhJfZvMlvLeTIOQrnFaPMqXmN5zEXhOFPQAJ9FeD/nJ9raG7GDWqT2Pa3txsZAHch1Dc5N/jksmHojIU7KOawXM4C9xjFnhCyQywpRWaKc7ReMmJvZj2Sko/4Mie6neHlPDGbeLXwxlrfNZ01qp4z5rn3DdQ1Zb0QMwcGF4yJ6DaYrL/uTJDgAXPuwTvqvl4OvBI0Gn9v0SeB54V8X5ZRD4az0YTn2RD3wisTME0e89ibUHnElDIT9N2xcRtB91PXcd3kzEZfsJFZQpHLE+ABINfmBvBGpJuWQQ5Isfi9e1OtptbUCYBQz63CibSxugZU7mqFLMx1bye2uJGORWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(66476007)(66946007)(66556008)(8676002)(8936002)(4326008)(7416002)(5660300002)(2906002)(44832011)(478600001)(26005)(45080400002)(41300700001)(2616005)(316002)(110136005)(54906003)(53546011)(966005)(6512007)(6506007)(6486002)(86362001)(31696002)(36756003)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Iwa0EzZFJWNjI4V1dhU3JTVStPZVM2aG1Da2dhYSsvcXp6Njk5MWlhcXFr?=
 =?utf-8?B?bzRxdlNFaEVCc3cyVHZDTEZsaElEck9JUktGdGNpamZvOWJHT2phMlM4NzFh?=
 =?utf-8?B?Y2VCeThpeC96Q2Q0ZEVDYXB3UmpkdHdrYm4wd0dPS2VmUFh5SG1PMVJsaU5i?=
 =?utf-8?B?S2hiQnFveHN1U2Vod2dzRFFnaHRza2xvcElrN3piUGxxYWE3T2RsNzd6RUw3?=
 =?utf-8?B?YzNvUi9kdUJTZlhMR1p2N2VrSVhRelBkR3FuTi8yWk9JamcyTTBCbXZCQkpX?=
 =?utf-8?B?N01mMHRTTVJnREJqemFpTm1GaE5mVkR3NExCSktFaXJZTjVTZVJqSUduMHVS?=
 =?utf-8?B?UmcrNUtMTWM4Ry82Nk53T2JQR0V0TGZCWVQ4V214dWFaZXcxaEo2RHR6Y1BS?=
 =?utf-8?B?RFNKOFJwWHc5N3ZsekdSTjNMUG5FNFo0Z054eGFPZVhYLzRSeHF6aWR3aXY4?=
 =?utf-8?B?N0krZDhEbmZBd2FDSnd0em52T05WanllaUZUNE9sU2twekFlanFFQ1ZROEJ4?=
 =?utf-8?B?MnVQbWduYkN0TXRwd1pZQWFqOGFGc2ZnaUdTRmtLaWhRcGFmLzJpMS9sZ3Nh?=
 =?utf-8?B?dFh5aTFTcVo1NGRXTlQ2SDhadHFmUFVxRTZyeWV4SEVIL0dCc0FsUzREdnpI?=
 =?utf-8?B?N1JjN0MwNVMrd2U1REx2bzNVeTFGZ2lsVC9rak1qMGpCL2x6eTFiREE1cFJV?=
 =?utf-8?B?N1R0eUJYYmVYY2Y3K2w0SmM5RFNmT2dFVzU2a2grOVVCNTBiNUI3WmN5Vjh0?=
 =?utf-8?B?VFd0ck9tNDI5TjBENUFpWnpsSjhhNkQ3WEU1UHY2NzIxUGZ1RXc2RG5jL3pO?=
 =?utf-8?B?Qml5VEMrejgwejFyTDFKMkM2WGlKYXJxZTBydlVsWlFNN29neW1QMW1YY0ln?=
 =?utf-8?B?eU1YaGJibVZxdDc0VzErRlhXWm1jSlhxN3BXUlgvb2pBZHMvSEp2cElCQ1c3?=
 =?utf-8?B?eEVwSnUycmFpdVJmNFpRZCs3VkdVRFdLWThNWjF2UStoTThEZE91U2xNdkc3?=
 =?utf-8?B?KzM3UTg2NTFPZm1YWlhtWnY0bUdhQ014Zm5CNjNFb3JLTzRWbGhaM1hKOGpQ?=
 =?utf-8?B?TU9UVythd0trcHNBTGZ2RHBXZ0FubUZGRDhRbUFtOFBBd1h0NVVlZmNCa0xp?=
 =?utf-8?B?R2x6RlA5Mjk1dVRkc0JFYmZtK3g5dW1EWmhHajBwQy9nak15MG9YQithZTNR?=
 =?utf-8?B?RitVYjlNVjZPZ2l3czZ2TEpMUC9sbHMwNWNWMjgrNHlYRFBNbk55MldkZG5O?=
 =?utf-8?B?eDVjQkczM0lnWWZNb2Z0ZnFsdURBSnh5YmNseTZlV2xDb1FrMi9lU2NrbmdG?=
 =?utf-8?B?YkJtYlVTc3BMdC9SaVJHaHRmWWh3M3R4QmhWZE9MeE41aHNGZ05UMFdCT3BD?=
 =?utf-8?B?T0dIMU0rTXprTkdDOVQyU1MzV0cyL1VNNkdTc0hiaGs4V3ZaQm82RWZyZ0dj?=
 =?utf-8?B?SUl0VWR5OU16N0p0UWtMU3V6TzQwTUk4MWZvVzBGZTJWZ09scEhuSWdSV2Rl?=
 =?utf-8?B?RWdFRkxOOEthTXNhUEpaZnc2RGE1aHBhZTY5U3pZSzM1RWgyVHVhZ1g5M2V3?=
 =?utf-8?B?djBwK08rck13TnE5aXdpZEp0QjZaL3BOQjlhaEJpYTJtaVR2VVZSSVR3MFpP?=
 =?utf-8?B?SVlXanlCVk5PM1JoRW9mWThXT05IaVVYQmdyOGw0cDNFTkMxdS9XZkxSa2Uy?=
 =?utf-8?B?eGtlVXRNTGNLV1d0WktQSzhsdzlML1ZjekFoQnY0SGdNenFBSURzUkk3RVZs?=
 =?utf-8?B?MHUyYUV3VkxyYmJ0aXF4ZFdNQUhiZ0hzSWIyUmh2anVlTDFRdHhGTUwrSUR3?=
 =?utf-8?B?dFUzQTd6SUl0VUhQYVVLSFYrMm0wRkRNYnhJMVF0RTl2QUtPbldHLzJPR3Mw?=
 =?utf-8?B?WnRUMGFpYVNCVDJkTk1OZmI0TDB2TDNmWThVUDlTNTlNb0pLMS9GUnNxUVEy?=
 =?utf-8?B?cmRqQWZGU09TTFp3bEdEN1kxQ2VCbzRpcEFEc1crTkpib3JVNEdSTGVXWTQy?=
 =?utf-8?B?UTdYQ2V4REVua05IME9qVUtzM1RJa2h5ZTFpR2E1a2dYTHZPdzl6TjFTUE5v?=
 =?utf-8?B?d2NNUWhpVzZVZXlJYlBHdEhHNkF5SE91WHdET3dxREdUdTV1ek9vRWovNWxq?=
 =?utf-8?B?TzNkN3plcm5ySDVNcVpnaFRFZFdaQUdFMVFCT0JTUzhtNHoyc1ppNlZ1OWdZ?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e719b-fa45-46b7-3a36-08dc2e4704d2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 16:56:13.9149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+WoJ+7YCJkMzdIGKP+6nV/FYlx07YYIbB/3CktpbVsRs1Bk+qTqzYjRZIqVsvmBC0d7mJkbZZiSVmCBDqnOz3XjYaNOY5Bkh+F0flkxIN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3506
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

Hi Andre,

On 15.02.24 17:50, Andre Przywara wrote:
> On Thu, 15 Feb 2024 14:35:19 +0100
> Frieder Schrempf <frieder@fris.de> wrote:
> 
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The datasheet can be found here:
>> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>> Changes in v3:
>> * none
> 
> Why do you resend then? Also v4 seems unchanged? Did you adjust the people
> in CC:? If you want to notify more people, please just reply to your own
> patch.

This is part of a patch series and there are changes in other patches
within the series. The usual workflow is to send the whole series again
even if not all patches changed. At least that's what I've always been
doing and so far no one complained. If there's a better way, please let
me know.

Thanks
Frieder
