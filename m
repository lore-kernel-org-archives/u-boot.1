Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B01C07E8E
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 10:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB83A8870C;
	Wed, 24 Apr 2024 12:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="i2jNK65M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A953F88709; Wed, 24 Apr 2024 12:57:02 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E37D8870C
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 12:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrzhacqOv2oVFCfPmxicfukYlQIYh1gfv6uNoWEj3KeoHVQnt0VDmIhr6+X300DsPWxIi2uFXla0du5repRGLt9eyi2Ej7vCQleow2OdgUWw2/0ugrWRO/2XYCNLnn1qRVbheA1cO7IGwX/dzxu9z7E4NkiyXmJtj9Y2ImE7t3UIp9vsU9uITfiPbe0wjJpIw2wwFoJMZtZrzNZhHt4dsN6wiFCKQ+dBgl/jH1Qdt6kM8V2TfX5WL1Su4k6+PBdxtyh5OTk4wkxg3d12AcoNvN7RnP1EmIAN2n3If5663C0mLlEr2YMpTBP6tatJU3KGJVG6zbi6L7BEMID/PNBk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d51XVJcU3CQ3TtJnE+Igw/LZwO975bHLDVETDnThGv8=;
 b=bsRxFgisxliEbc2xiYKRC3n5zbMUlUG4xc884BvyrOINwSEJEy+677B0GbtH9XEifhtHIccerf1LqsICqk0g4Wci0UJ6tgWHrw2VHCRYRy3F1wxhlR3tXvjPGAK60+fjb+ePqeEkTCcVaFCeorwRC+iieSdzyiIkMku5O7QT1DHM7Sm24KpmnwreScop0crLW7MZWTwYmys861kpfUTJcV1sQ86fFP+XIAdeWLM0/33DjbyK+6X/Q1EUwrBT8r/dna7pxP3MNv8Gr4Il0+LOCrma+hLWRjKwOOzL/QzIQzpwnmRuWXIHSqF7EfNydQBus+v3GrqZSrEP6ou+uT5uaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d51XVJcU3CQ3TtJnE+Igw/LZwO975bHLDVETDnThGv8=;
 b=i2jNK65MI6b2TuugW/FAsoS0GvfF6DxaD8XtXiGhqKZYbbKEhze3te7p9ubGXqFT/3Lw3slE1zJXP3+zAGMmaoJZu191+gUiVa0R0GLO+nQobZaYViP3uASPi9mRtNkr6v+/gVPj1o2Wh7FUjUv1EaIQPEDRJVIRyx23R1WeWvHXCkBNbQEMk/tIp3ZFtKqWsUS7VVWrYTwAgjKJvlqHqjkLjz+GtRcj3ER4o5E01lw4vqGMFF7CE7DCZ2TH4dfyaje9EpVZbYDVHxLlBAvem+iNcn9BQ+S3Ug7XBa67uGekp3GcEbNL5fwOw19xypnEgPGtF/835MdSf5bJiLJ4XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by PR3PR04MB7244.eurprd04.prod.outlook.com (2603:10a6:102:8e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 10:56:57 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 10:56:57 +0000
Message-ID: <af943d3f-004f-44e8-947c-0d18afa27cee@theobroma-systems.com>
Date: Wed, 24 Apr 2024 12:56:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] armv8: generic_timer: Use event stream for udelay
To: Andre Przywara <andre.przywara@arm.com>
Cc: Peter Hoyes <peter.hoyes@arm.com>, u-boot@lists.denx.de,
 trini@konsulko.com, mk7.kang@samsung.com, ilias.apalodimas@linaro.org,
 wqu@suse.com, neil.armstrong@linaro.org, sr@denx.de, michal.simek@amd.com,
 patrick.delaunay@foss.st.com, sjg@chromium.org, patrice.chotard@foss.st.com
References: <20240423081005.23218-1-peter.hoyes@arm.com>
 <20240423081005.23218-3-peter.hoyes@arm.com>
 <8ccd1c8a-5ab2-44ad-b49a-26bff13187bd@theobroma-systems.com>
 <20240424112913.1b0c22e5@donnerap.manchester.arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240424112913.1b0c22e5@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|PR3PR04MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: c20cf5b7-6774-4ca1-0ee1-08dc644d4226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2l0Rjl3UXNNMTdtWkYwYlRNOGJtSVhoNTdibEFxa2FWVkQvY0lvNFhhdWlE?=
 =?utf-8?B?ZE11OEJ6MXpieHFJZEdSV2lFNkxxQTEyYm9Obm1BSkdxK3h4M3ZvT0E2SFVI?=
 =?utf-8?B?NW56M3dvdmtFeEpjRXQvanJzWTlqVWdWWVJLTytsTXFocjQ3T0RIM09ZcmlB?=
 =?utf-8?B?K0l5K0o3QUpMdTdZWitBTjQra2hoY0xoRHh2QzhNQnUybFFZMmxlS2NzTDli?=
 =?utf-8?B?RjNMei9WNllJUE5IYm11Z1UzaDBkZXJmSElubVFKckZYa2ZONVdhOWFCMC9F?=
 =?utf-8?B?ZWxsUG5qV0c4cW1rVzFjWVJLOFh5RUU1S3RtU0pwTTdWbXpSM1VwM3UwT05O?=
 =?utf-8?B?Y2dNUkdNdkhMaWxqMnVPUjIrWDB2L2Q5MGNTNUludnl0elAyQjRPalQxVEoy?=
 =?utf-8?B?V29RVlprTFR1QjVsSEo0VENZRkpPYmZsTmdIWmxPbGNoVWVlMTF1eHkyTXR3?=
 =?utf-8?B?N3NVN0hIQW9JQVp6Ri92RUtlSnRVdkVYbU5yUEkrM21VbHhQWGd5b00xcHJS?=
 =?utf-8?B?cnhRYmo1UVU5QkRrVVhSbEJxUHZLamlTSzZEWmRDYzVnNmJZVE9SOVI1ck5S?=
 =?utf-8?B?VkkvZlZRcWFKcjZEYmZUa2kzMHo4YTFjN28zZld2VzVlZUdkYmYwdTZCZUov?=
 =?utf-8?B?c3F5cXNsTy9iY3lEMzZxbHRJSnlsNk1HQlVYOS9JZVZETi9vQ1JieXA3UVlP?=
 =?utf-8?B?YlBvbTRWTG94MlpTT3puME1URkpHTmpXckUwOFA1WnRadml5QWE4MUpweVdo?=
 =?utf-8?B?QVVKMWZWTU8wK1p1K2NKMElYSlZGRW10eVlSMlpnK05CRjZ2a2U2R05UMnd5?=
 =?utf-8?B?ZjRTa21zQkVDY2hXcG53QW9HSW0zUHVPd2FqVWl1SnVWU1dOS09nUENZVnBo?=
 =?utf-8?B?aVYvZEE3a1lBNmRzb3YwdWlVcU5PWFhLdmt2TklQZ1VPSjdCb3NjbytCZExn?=
 =?utf-8?B?ZFhjZGoweDJnQldSZTZUMWhHZmlldXdRYmU0ZU4wMXE0VEQvR1h3RDl1YXdv?=
 =?utf-8?B?NzNIdGI5ZVpQRGNmRTlKT3RaUFRzcTNiNzRRNm1OdzI2eDJUZXZ5Q2k2cnFS?=
 =?utf-8?B?UTRxekIvdXNvcnFOL3NDcmhHa0FKQkJCWUdZMGFYMEl6K0wxeHFseHVlTnhU?=
 =?utf-8?B?dVExQmlqTHRMUG1WUlFReFE5YmxCYi9VYmVhRVNUTXNKTUlhN2dFRXRXR1Rw?=
 =?utf-8?B?UEErQy9iRmUyN2toS1NQNnJFVkZtTFdVaE5nWS8wNS9VR0ZDYmg1ZEJScHJU?=
 =?utf-8?B?QXN2QkxGUXhJZlNKM2FwTVZxNmxtOGNlTUt0S2gzaHkrWm1TZ0xTNFZFQlRl?=
 =?utf-8?B?UkFlUGZGa0FBMjdDWWF6Y0l2cldQb2IwNWw0SFVoUHNoYWVwOXVubHNCbDJL?=
 =?utf-8?B?eTkvNkd5Z3Zmall1amI5d1UyUXFyS01ZSW90cFE4VHFwcXRyQk84RmdFeG52?=
 =?utf-8?B?WUNCdHN1WHR1QmVKbTVJM1ViZlR2K2NCSzdrc3hXeXg0b1R3dWRaYlg1cFBn?=
 =?utf-8?B?UHYzNjl4TWdCVHdESVZaM3FJSFI0Y2IvRHZ5RkN2NkdneXlPL3pudzRPaXRs?=
 =?utf-8?B?ZnBnRUw1QXdvL1JTQm5vUTJ6dGtIWUVMTE5IT1lVNXB5YjkwMEMvYUlqTjJ6?=
 =?utf-8?B?UXNZQlE0ZDZPK1dDQWJTV0txUTQxcmhSdzhYSG93L2xYNWYyb2FsZ1ZWYW5B?=
 =?utf-8?B?SnozYjZTdHlBaXRwU0Y3bmt0cnJxS2FOVUtoczlMQk12VHlmdCt6QTZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4833.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjBSdVAwdmhLNytCd1FxUU5DcnRXQXE3VDR4dWdqRUtaN0ZpOU9qemIreVB5?=
 =?utf-8?B?VTJRU0MzeDhWSUpWVENjQ0JVcjFnbXh2bXFtc0NQQW5qMkNRRFhXYk1WaUI1?=
 =?utf-8?B?YnQwU2Q2TDBvcnA3eDBSQ0ZNYStTRlh4d0Zwa0dtVW9kSkZaZ0t4SW5xZG0z?=
 =?utf-8?B?MUUrQlJaTmRQWFFUaXlwMWg4L2xNaVpkRjFnZDhZc3ErRjVCbm15WXcrNzkr?=
 =?utf-8?B?cHliV3ljOGlEb3RzQXZkbmlJdmhYaUVJckdjN0FhQzFuRmJUamIybWZtV0hZ?=
 =?utf-8?B?UWEzbzFEWXJ3UVh2Z0F0SWxIY1FOWko4S3kzbFlSVGR2T3RjY2s2alkzaS9k?=
 =?utf-8?B?Yy84ck9tMldmNzZxZnRydTJhdlczOHM2eVpTSE8yWXhHSDFjS1dwZDJUYUtE?=
 =?utf-8?B?QldwVVVHclhVLzNESENaRmFHdjUvOWNJWS9YV0E5MmpReWhKM1YvQUhyWTc4?=
 =?utf-8?B?S0VRQW96VmwrM0IxWGUxMFhWUGNmM2x1dHhZdTRtbzRRd1ZzT2RoMlN5NUYx?=
 =?utf-8?B?cEZiZVN2cnk5UTllcXNJSGsrYTJXRGp5QTNhdnpwKzVYOWk3TS9vc3RubGlC?=
 =?utf-8?B?RmU2QnAxcS9VSDl1OFFycDczQWhSYkpTVG1NeEUvc2xRdi9mVjUwSit2UFhV?=
 =?utf-8?B?OWJod0FpWm82YUFIUGVtWm5Hc2QzemdFNXZQK09GMkY5Y3NvUUtwcXFpL09j?=
 =?utf-8?B?eE5rLy9TT3dPZ0xBVzc5SnlaSjIwaXQzcTZ3Q1pLbDFLTndSenRMTlNYWG56?=
 =?utf-8?B?U2hZdUppM2pENTZMWjEzOWFiMm1ZcU4vYlIzUDIybGV4N3lWblJEQjByZTJy?=
 =?utf-8?B?NHBKemFVTVpKUUQ1OERoM2E4UnEwMFNrQndmQ3NGNTgyMEx3bHZwT0h2eEk2?=
 =?utf-8?B?N21lRVg5RGF6cy8vR1hjcDRGMVdvUTJENDhzb3kxTnJRMmlxY0lzVTBzMWVS?=
 =?utf-8?B?YzNHVGJnS240bXNraUtrMHlVYjEwakc3NkUrMThoazVrZVhPb1hJRno5clFQ?=
 =?utf-8?B?WGxBZ2dSdCtYUFVNZkd1UjNSOHVjTG5UMThOdGpFU005am55TVE5Ukt3WUJI?=
 =?utf-8?B?SVVKaHNsbGh2UDBtQjg0RUZKV0xMMGtIeUY2MUNDL0Rzc2ptK0VybDFkckZG?=
 =?utf-8?B?N09Ebkd6TklaVlRjUW93U0RiNWd3NkszLzFiUHJDU1Q1T1FnTVplRXFxM1Mx?=
 =?utf-8?B?OFk0cGUwbXpmUnhvQ3Y2Yjh5ZmNHZFJXNmkvNEZIY2lvQU1qZ2hiK3JnKzg1?=
 =?utf-8?B?bGlhWFYzT2pyQ3V5QS96UFFHc2pYemJkWXpRdmZsOVVEbkdZWnJKYk1meHF0?=
 =?utf-8?B?M2htc2VaVUM4amc1NnNQRkZNVnZKV3J4bUlBSitPdE4rRnJxUUZrSVRuZHlO?=
 =?utf-8?B?b1dQYW1OSXB1d0gzYWdnVW5iSjN4RUlWYjFCVnoxUzBBUElNaVNDeFAzQ1R3?=
 =?utf-8?B?dmY1a2Y4MGozOGgwTDgxRzJGSnY4TlkwOUJzejVXelhSV2dRVmpYYmNWRCt6?=
 =?utf-8?B?a1FMbTQrd2VFL1dyWEF3akh2S3FjZTRUQjEvcmhZQzd3L25xMXZPMmxiSWxa?=
 =?utf-8?B?NTRLemVOdUZDTGpDY2V2U2JTZ2ZGazRUYll5WTdYNTJiQ0JySUUvUUZ6b1FX?=
 =?utf-8?B?WDExTEJ4a0JvTjdBSEUxbEtFV04ybm1ObkIxSGk4cEpFN1NTUEc4aWFyMGla?=
 =?utf-8?B?WW5qZFpRRmlPcXNLQmlKSmVMN1ljYmFIWEJuK2lGZ0ZidnhMZllpRXliV1JP?=
 =?utf-8?B?Z2grdUMrTEZrM0txR3pkajQzVFR6UnJWZDd3VkdlZjdpZXpyT3BFK3VSOUVy?=
 =?utf-8?B?bWJiUDhScXJTS0plai9mdGZ3b2xxbkMzZHlUQ1F0YWhodUdJVk9kR3k1UmRu?=
 =?utf-8?B?dUFlZ0hMZWR2NmlZZkpBdHIzc0RlYzlWYUZnYjRxVzR0QWZuUiszcnNSNCsw?=
 =?utf-8?B?eGdIemtjcHd1RFlQSk8xZHNpSE1XVEJXd04wVkpBTmcxeDJ4Q3FwK3drWVMx?=
 =?utf-8?B?Y1cxK2FadWJVb3BNSU81dnpNSnQrQUdBNUtWcG85aHIyWVV5ZmZ6MnVQUU1k?=
 =?utf-8?B?RDZ2NU5XUjhCc3I2ZjZMa1Z0MUdhR1ZtREY1ckx1SDNkYTI0bWdGRVdHcFk4?=
 =?utf-8?B?bndTNEZBeUFFdFFQNElNN09jQk51WDBZZkFaazNHb3psbjNiOVY3SjFmeEVV?=
 =?utf-8?B?V0ZqTFlmWWlaVURNdHQ3RHVzY0F5VWdLWGk0WnFGelBrS2h2ZUdNaWE1OXZk?=
 =?utf-8?B?MzR4WTAvNU16amdTcHpLUjdCdnl3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20cf5b7-6774-4ca1-0ee1-08dc644d4226
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:56:56.9817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6gKFmPabvoVO2lQ/MC+Hq4xwQpykwuYM2GzSNH0dS+j7frp5AOQrX5vBZFXZ/HseBsMK1xxRHStll8FhLAnu0YbFhK8ub9EvyFKwbP73jg0xovghiW5YUmU3SgzjrhR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7244
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

Hi Peter, Andre,

On 4/24/24 12:29, Andre Przywara wrote:
> On Tue, 23 Apr 2024 12:55:55 +0200
> Quentin Schulz <quentin.schulz@theobroma-systems.com> wrote:
> 
>> Hi Peter,
>>
>> On 4/23/24 10:10, Peter Hoyes wrote:
>>> From: Peter Hoyes <Peter.Hoyes@arm.com>
>>>
>>> Polling cntpct_el0 in a tight loop for delays is inefficient.
>>> This is particularly apparent on Arm FVPs, which do not simulate
>>> real time, meaning that a 1s sleep can take a couple of orders
>>> of magnitude longer to execute in wall time.
>>>
>>> If running at EL2 or above (where CNTHCTL_EL2 is available), enable
>>> the cntpct_el0 event stream temporarily and use wfe to implement
>>> the delay more efficiently. The event period is chosen as a
>>> trade-off between efficiency and the fact that Arm FVPs do not
>>> typically simulate real time.
>>>
>>> This is only implemented for Armv8 boards, where an architectural
>>> timer exists.
>>>
>>> Some mach-socfpga AArch64 boards already override __udelay to make
>>> it always inline, so guard the functionality with a new
>>> ARMV8_UDELAY_EVENT_STREAM Kconfig, enabled by default.
>>>
>>> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
>>> ---
>>>    arch/arm/cpu/armv8/Kconfig         |  8 ++++++++
>>>    arch/arm/cpu/armv8/generic_timer.c | 27 +++++++++++++++++++++++++++
>>>    arch/arm/include/asm/system.h      |  6 ++++--
>>>    3 files changed, 39 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
>>> index 9f0fb369f7..544c5e2d74 100644
>>> --- a/arch/arm/cpu/armv8/Kconfig
>>> +++ b/arch/arm/cpu/armv8/Kconfig
>>> @@ -191,6 +191,14 @@ config ARMV8_EA_EL3_FIRST
>>>    	  Exception handling at all exception levels for External Abort and
>>>    	  SError interrupt exception are taken in EL3.
>>>    
>>> +config ARMV8_UDELAY_EVENT_STREAM
>>> +	bool "Use the event stream for udelay"
>>> +	default y if !ARCH_SOCFPGA
>>> +	help
>>> +	  Use the event stream provided by the AArch64 architectural timer for
>>> +	  delays. This is more efficient than the default polling
>>> +	  implementation.
>>> +
>>>    menuconfig ARMV8_CRYPTO
>>>    	bool "ARM64 Accelerated Cryptographic Algorithms"
>>>    
>>> diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
>>> index 8f83372cbc..e18b5c8187 100644
>>> --- a/arch/arm/cpu/armv8/generic_timer.c
>>> +++ b/arch/arm/cpu/armv8/generic_timer.c
>>> @@ -115,3 +115,30 @@ ulong timer_get_boot_us(void)
>>>    
>>>    	return val / get_tbclk();
>>>    }
>>> +
>>> +#if CONFIG_IS_ENABLED(ARMV8_UDELAY_EVENT_STREAM)
>>> +void __udelay(unsigned long usec)
>>> +{
>>> +	u64 target = get_ticks() + usec_to_tick(usec);
>>> +
>>
>> This can theoretically overflow, do we have any guarantee this cannot
>> happen in real life, like... we would need U-Boot to be running for 100
>> years without being powered-down/reset or something like that? Can we
>> document this assumption? Does this make sense?
> 
> The Arm ARM guarantees a "Roll-over time of not less than 40 years."
> (Armv8 ARM 0487K.a D12.1.2 "The system counter").
> So that's not the 100 years you are asking for, but I guess still good
> enough?
> 

I guess it is, since it is also stored in a u64 and is reset to 0 upon 
start-up according to the ARM. I also assume nobody is going to add a 
udelay of years in their code :) (and if they do, they would probably 
figure out something's wrong before it reaches the final products :) ).

Thanks all for the pointers to reference manuals and current 
implementations.

Cheers,
Quentin
