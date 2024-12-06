Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C45E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 12:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F41893E9;
	Fri,  6 Dec 2024 13:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="BXbZBXCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9AF789576; Fri,  6 Dec 2024 13:53:45 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CAD0893A4
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 13:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1WbGg/O5axum3MKoNF+TzjPZBsNJNEQ2a1qDIAMBm5spjwjnSZvW8KfW0xtsb44O2p0Ki8bvpZJxfjJR3HU6ah/gNYBUmQhoc5BjmV8M5L4ZfmCFXIW+UgfDHOkza8viCG5vz2IIxiVTwyCJra5gSSYfveqU5IEEfWxFSX/l1wCo6QCXBIZ/qrxTXcJOECMGf4Bs5wiGpjNCa7wat4rDDyn8e2VtPp9EjfMw4wLnnP1lrwH8bPKHS7Q2XIzDinWNSZToDLAkXSKy+fldRki1Bedtl1xVQwPr63op6XyAjacxh+0NyZbQhqQwudXOV0jCPtmXzsRWLrtV1gqltWqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK4NoTMBOHDlopy8KW5AVQzyqeEpn95lQhSfzXz0ryA=;
 b=gbDRUM2XnR/6DXG8yi6csYPYl+E5z//fcuhbT0PLewfG/hoHR3OTKq0IwgRN7n1qUxwPpzNZioBVVv3uv2O+Y6OBQuuo99E8hgZvFSLC5rH1CtZjyHKMZuw2TX45+rjv0kiG/+mPXutX7JzMX4kewMd4onGDnojJ3P9PcS/a16V8qYj6bGr8d4Pz5mQAlMZrFafL9Z7HJpG7NQVRPtTkyHMO/Ji/aHp0W53TKV1WODeRjQeZ6e+m+8dodMZu5UE0BxdMRoGGsh4nmXiLUeGI0cceAkb1KkPi554ZsQm+CvfgjASaPmarnfdyosaVzmpaEWMvzJ6mT6YxDfCl5yPuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK4NoTMBOHDlopy8KW5AVQzyqeEpn95lQhSfzXz0ryA=;
 b=BXbZBXCS99rEa2qWmLFL0fpnsGDcJVIs2ozyahrF3rfj4rlm6GamtOe3Y++Hqr83PGV492xQ0vWcrXeYlzvhr7DVjaKnykP5oGD4fKPZTijsXH8HLKfbe7khk/O3VTWG/7YA3lWiv1iJ7KIXhj2+lipgmOX+JgvsLFlI/m9yrl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM9P195MB1378.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:38b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 12:53:41 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8158.019; Fri, 6 Dec 2024
 12:53:41 +0000
Message-ID: <b7dc8b69-cb3d-433a-adef-56e54e8db275@phytec.de>
Date: Fri, 6 Dec 2024 13:53:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] ram: k3-ddrss: Add
 k3_ddrss_ddr_bank_base_size_calc() to solve 'calculations restricted to 32
 bits' issue
To: Bryan Brattlof <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>
Cc: Santhosh Kumar K <s-k6@ti.com>, trini@konsulko.com, m-chawdhry@ti.com,
 nm@ti.com, u-kumar1@ti.com, vigneshr@ti.com, u-boot@lists.denx.de
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-3-s-k6@ti.com>
 <20241023143905.xbrqu6eabaer6wui@bryanbrattlof.com>
 <92a86113-f2b3-4b1a-942d-792aaf63a34d@ti.com>
 <20241024161958.hxbtvbeaf52zsblc@bryanbrattlof.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241024161958.hxbtvbeaf52zsblc@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0147.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::31) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM9P195MB1378:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1b883a-f44a-4636-7d17-08dd15f50274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTExWVhhcCtRRHNyZ1BjQStZRFh2TkRkS1A0V3RSMG81UjYrSlhYUEdrYUQ1?=
 =?utf-8?B?VnZBOWtGNVpkUUFmMUNIdVUvdDk0OVJ1Yk5vNXFabWJZVUVvV2JVUmM5dmd6?=
 =?utf-8?B?STJOSnp5aGdGajlGNHZiODduR1dPZEhKWkhodTY3Z0drRjd2V2N3NWNuRURS?=
 =?utf-8?B?Wk5CeUlPbk5yUXNXajk1VlF3WHI2cTMya05Hc05oU2hnVENRTzQrM09SNVVK?=
 =?utf-8?B?SEJ4Yy9oczhEMXBVaDhCYldaOTZCK3RIMnlHRE9HV1lzRWdEVkdab1puUU42?=
 =?utf-8?B?ajF0c3ZUUWdEVEkwdDF0T2ZjZFBmUGxKdG4zWHJjZnZhWk4rcXpzdnoxV3o1?=
 =?utf-8?B?NCtuZnNLTWF3bnIzQTdKZXJTdUgxd21zaERydXRoRG8xQ0dveFpIM0JjbGZh?=
 =?utf-8?B?VGVqQ1Mvc1ovcHZuOTNVa3JjOWxwTGlBN2w0T1pLVGhZODBLVVQ2VXc1UnFh?=
 =?utf-8?B?WjNHKzQvRFdwLy9YZXR4TVB6TzRRT1gzS0hVVXF6L3ZmVVVDL3FRbjlTcGNI?=
 =?utf-8?B?YjRBRjU3am05RGJtUW1oUnpHU091bWhVWlFpMGxJR2I4V21qZ1FSK253aEpU?=
 =?utf-8?B?eVJLaTMveHkxb3UxQnZZV0ZJNXRkRjVDVklzWUlpUGEycjM0b05JbVN1QU5E?=
 =?utf-8?B?Yk9sc1YyZFNqc0pZRUtLMGVGcXIzYVFKckFxbnhQZ1RQSEo5eW5CUHBpRy8v?=
 =?utf-8?B?Y1U2Y2ZpRHV4V1RYSkh3ZzRCYU5TVUpnOGRIRUx2YlMvVkxZdEp4TzFQbDFJ?=
 =?utf-8?B?VGszeFh4bWE3S3FjVFJHK2xUSmh3dlhSbmdjRWlPUlFiZ0pHZUQvbUZDQlRz?=
 =?utf-8?B?UGJKcnduRlRmYmJMdlplNW5CaytOWVdhaTBDbDNYb2dDL1gvSkpXcFhWY08r?=
 =?utf-8?B?R0M1Nk1RbStXS0oyY3R5NnRFQW9KVzloRG9zK0ZmWGpYandXbzlmekFyWVRr?=
 =?utf-8?B?c1lzdHZoakpPNWsxSlY5N0JTd08xbXpQUklBOHp3RHE1TlRkUmUxK3VUMjJi?=
 =?utf-8?B?MUtNVHZaQWhGckhRVmtnN0pqam9LaHdiN1ZpbS83bG1wbW5zTG1TR2JrOXVs?=
 =?utf-8?B?cmJJN2wyUGU2aVR0WFppMDZpK3hXbHJ0SzMxOWY0ay8yblIveWU4bkdzWTFt?=
 =?utf-8?B?RjducG9WaTJoYS8zdm5pTTZnTHlkYUZjVUo0em1OY0hpR24vY2tVTmgyNHN6?=
 =?utf-8?B?eHV1Nmtlb0JZQVV5enhIeWpHRlZiejlkY3UzUi9DeitndzB6anF1M0RUcFh1?=
 =?utf-8?B?T2J3NVMyOWRPQTJNVDFjbVhxMEpyVzZkZnNwVnAzWkRzR1Y2YUoyeHgxV0Z1?=
 =?utf-8?B?RFJFUTg0dTBaMWdGQTBFVXJscEdJdnlvMkdHdXZpRnB2UWNIdVI2QXNLZjUz?=
 =?utf-8?B?eW5GQW1HMUpFZGJ0Qk9KQ1hKTVA1MzhTVmViY2JmMkx1WEp6d2VxNmhKc09z?=
 =?utf-8?B?c2hjaStqNDdvZTJ5M25wZm95NHJ3WWdYY0d5dWdrbzk0THpIVUFWWEFSc3Ft?=
 =?utf-8?B?cXJJVTJYMFBsWi91RndzejdLci8yQnYxODBMV0xEemZDbWdhWjFBOFRpbCtB?=
 =?utf-8?B?QVJBbE9wTWJXdHE1dkg4enZ4NW5OOEd6K0k4WGxDMjhBYU11Sk9Ia3llUE84?=
 =?utf-8?B?Y0UxRzZOVVZlRFZaS2Qzbm1odjFacStsN294OTNpMVNYVEVDY0pnYUFIYi9N?=
 =?utf-8?B?Rm5NUGtBRTQzbTYvcFltazZmMTFScnhqOEI2bVJyRVVhTk1oa3o3N0tpZ1Aw?=
 =?utf-8?Q?5SCuhYIrenL7AI0gt0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGZ1cnBlSmhtTjZHTnEzOUpzMng4dFNsVmpscFY1OHV4WFlrN0szQ01DWHBB?=
 =?utf-8?B?d01YY3pkamtOY3RsZ1c1TEIxSUxFRFJWN3VPZVRzVUFwMU5RKzdJRmdZeTJC?=
 =?utf-8?B?cS9URWkvbFh1dUhzMHlKQVRaeU1UdXNuMnZXU0hUMCs2eW1PbFdrWlptdXhD?=
 =?utf-8?B?V09mWTVLaFAvNUdjSEh1TFdRZ3J2S2xaQm9MSURFd2JnK2NOdk1ZeVpoUjFo?=
 =?utf-8?B?b091cnVmZnA1VXBYdUpUTXg4OUR3YjlUTUVYUDRJZm1KSE1VTXJkM0JaSEJn?=
 =?utf-8?B?R3BUM3NaMzJGS3FoUGtzNVdUeUlSczVHUExmWGxQZHJ4ZllIdzR5TW9DcHg0?=
 =?utf-8?B?VGtjZlMwNkxtbkhJMVNGdHh0ZmVPYWMveVlPQW5JSHBiL2RFRWVrVWlPODVK?=
 =?utf-8?B?NUQrNjBkdWZoNzlhT1hEQ1NsRlZpOUdUT2UxaXZHQ2RRZTlqWUxuV1BGNmpJ?=
 =?utf-8?B?Kzd5amxSWWF3QzB3YkZUTjRjcXI2NmxpZHhrNjc1d3U5VC9Hb05BNjlSY2Zn?=
 =?utf-8?B?elBhaHM3cDRxNXhKUVRyeXN5SHVTaE00b2dOeUdZRmRvZHpISlhhdjlrZHRV?=
 =?utf-8?B?dHBxcHNuaVlNZFhDd0pvWU5XSzFhbTlkK1M2S1lmTTJyNE5XN2NZY3pvYllO?=
 =?utf-8?B?SS9jSGlDUUZKbVlyMjdZWHVLQk9nK1dVdjcyK1NPNHB1Q3J2YXp0ajI3eVdI?=
 =?utf-8?B?a2JHZUhseDg2c2orTTgzL1ZjNDQwVXpEazJ0VkIyaCtqeHhMd0ZCYnBubGhZ?=
 =?utf-8?B?YWlCSnR5WTY2Vzk1RnFOVGxPVjdseitKNDQyRmV6VHh3b2VpbERmM3l4aGdP?=
 =?utf-8?B?YTl3VzJNR2JybC85T2tLa2ZSa1lMNjZuUS9rQ1pWQXNBc3lPYVl5MStMaEVH?=
 =?utf-8?B?S1NsamxCZkk2VWgyWGI4YzQyc0pkbks2N3RnK0tSYWNOWW8xUWc0aXdqVERy?=
 =?utf-8?B?MFhJdWNadHV1YWc3V2s1UEFDSFEweHlXYloxTXFPcTdwelhCaDRoNWU5MmFT?=
 =?utf-8?B?TEFORDRqZHlHUG9MZWpWRk11MTNuRzR3Sy9OZnVVV05ibjRtVDYyS1lRNzBJ?=
 =?utf-8?B?akV4WWRaZWU3VFV5ZFVmL0ZWZjVSZXlWeVJ4T09paHg0SjhNZ0Rtd3NLVGZL?=
 =?utf-8?B?aHpHdVd0YUdPLzZtWnJwK2ZSUXEyWnJGUTVBT2M3cjRRQWIvWXZYaWJQNGoy?=
 =?utf-8?B?R3M4d3FBK1c2ZEJES25NdkpzcEhaZGFUUjZXSmRCT0lueHNvUDVoU3RNZStu?=
 =?utf-8?B?OE54QldSOUgyZkpyYk14RSsxNDEwN0xyOHNuZHhEd2FpNlZwbTRNbW1LNmFz?=
 =?utf-8?B?VUY4SER2Nll3YmxMRlJ1NnJFQXhqNnp1VTRucGIwbmFRbEZDTE1EaVRoQlhx?=
 =?utf-8?B?NFJ0d2l3eUx5dktTQ00vd3M5M0k1aXNCcEEvWTVYTW44Wk04UitCMk44YU5S?=
 =?utf-8?B?RzJkSmVvUHZGMEx0VWkreUx1bzQ1cEJxcXNTbm02MjNJZHRWMHlzYVR5V2l4?=
 =?utf-8?B?S01UeEFGaWRyYm5nditra0wwNWwzMFNQOGdnbnVydldQS0tsUEpuUzdaR3dx?=
 =?utf-8?B?VmhYWkR3M1RwQ3hnVFJZZlp4STN2RjdibnJldFM5R0JtVG5mZUJGem83dEZH?=
 =?utf-8?B?UWw2OXprUnU3WU1WZ2QzSHE3NHhLaEs5djRqejJRSFFLVlQ2NnQvcnJMV0JI?=
 =?utf-8?B?VVp3QXhnS2VSd3FMeTVGeEN0aGcwQWE1QTQ3RWZGcUxKakI1S2ZObUVxb1Rt?=
 =?utf-8?B?eDR6eitzN1lkdHhLaUFwMHhlelJWdFNySDh0UnQ0cVBSRU1VazUwZWdRMFg2?=
 =?utf-8?B?cVhMY0VsVWRWMWhRczF5anR0M1o0bFVnckt4L1hsMC9TcEFLUDRSLzlockdP?=
 =?utf-8?B?Ky9TNzhEZXl5Y2lUS1ZqSGRnZnRCMkltenk2Qis0YnM2YnYwQzJBcHNmWjZu?=
 =?utf-8?B?TXpycGRKSG4rMDZmb0xpQ1Q2aGtNbVVDL0VlczlzSVB6SUN0OUtaSEFUOHgx?=
 =?utf-8?B?YTRjcHMrTlZaZHJsakFwTy9YdFlwVVNKWVJnZzZHVkdFOW04emhDT3FnckVE?=
 =?utf-8?B?UzNXbXlQR0NVdkx0MGwveUxPT04vb2pGbEk0OCtjUjIyd09MY1NwMGE2SkRE?=
 =?utf-8?Q?0eX1qSgb+ILkxK7ofGh8CE3Of?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1b883a-f44a-4636-7d17-08dd15f50274
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 12:53:41.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SskrAcOfhOKdzN4Nrt6k2Y9c8b3qFihbyoT4B6MSXULouUpBUV25RIxcs3iaBNNoAYY+3CXq4VW0HSbeqGStKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1378
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

Am 24.10.24 um 18:19 schrieb Bryan Brattlof:
> On October 24, 2024 thus sayeth Neha Malcom Francis:
>> Hi Bryan
>>
>> On 23/10/24 20:09, Bryan Brattlof wrote:
>>> On October 21, 2024 thus sayeth Santhosh Kumar K:
>>>> As R5 is a 32 bit processor, the RAM banks' base and size calculation
>>>> is restricted to 32 bits, which results in wrong values if bank's base
>>>> is greater than 32 bits or bank's size is greater than or equal to 4GB.
>>>>
>>>> So, add k3_ddrss_ddr_bank_base_size_calc() to get the base address and
>>>> size of RAM's banks from the device tree memory node, and store in a
>>>> 64 bit device private data which can be used for ECC reserved memory
>>>> calculation, Setting ECC range and Fixing up bank size in device tree
>>>> when ECC is enabled.
>>>>
>>>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>>> ---
>>>>    drivers/ram/k3-ddrss/k3-ddrss.c | 72 ++++++++++++++++++++++++++-------
>>>>    1 file changed, 57 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
>>>> index f2ab8cf2b49b..bd6783ebc2cd 100644
>>>> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
>>>> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>>>> @@ -147,6 +147,9 @@ struct k3_ddrss_desc {
>>>>    	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
>>>>    	u64 ecc_reserved_space;
>>>>    	bool ti_ecc_enabled;
>>>> +	unsigned long long ddr_bank_base[CONFIG_NR_DRAM_BANKS];
>>>> +	unsigned long long ddr_bank_size[CONFIG_NR_DRAM_BANKS];
>>>> +	unsigned long long ddr_ram_size;
>>>
>>> Should we use the u64 typedef here?
>>>
>>>>    };
>>>>    struct reginitdata {
>>>> @@ -668,11 +671,54 @@ static void k3_ddrss_lpddr4_preload_full_mem(struct k3_ddrss_desc *ddrss,
>>>>    	printf("ECC: priming DDR completed in %lu msec\n", get_timer(done));
>>>>    }
>>>> +static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
>>>> +{
>>>> +	int bank, na, ns, len, parent;
>>>> +	const fdt32_t *ptr, *end;
>>>> +
>>>> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>>> +		ddrss->ddr_bank_base[bank] = 0;
>>>> +		ddrss->ddr_bank_size[bank] = 0;
>>>> +	}
>>>> +
>>>> +	ofnode mem = ofnode_null();
>>>> +
>>>> +	do {
>>>> +		mem = ofnode_by_prop_value(mem, "device_type", "memory", 7);
>>>> +	} while (!ofnode_is_enabled(mem));
>>>> +
>>>> +	const void *fdt = ofnode_to_fdt(mem);
>>>> +	int node = ofnode_to_offset(mem);
>>>> +	const char *property = "reg";
>>>> +
>>>> +	parent = fdt_parent_offset(fdt, node);
>>>> +	na = fdt_address_cells(fdt, parent);
>>>> +	ns = fdt_size_cells(fdt, parent);
>>>> +	ptr = fdt_getprop(fdt, node, property, &len);
>>>> +	end = ptr + len / sizeof(*ptr);
>>>> +
>>>> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>>> +		if (ptr + na + ns <= end) {
>>>> +			if (CONFIG_IS_ENABLED(OF_TRANSLATE))
>>>> +				ddrss->ddr_bank_base[bank] = fdt_translate_address(fdt, node, ptr);
>>>> +			else
>>>> +				ddrss->ddr_bank_base[bank] = fdtdec_get_number(ptr, na);
>>>> +
>>>> +			ddrss->ddr_bank_size[bank] = fdtdec_get_number(&ptr[na], ns);
>>>> +		}
>>>> +
>>>> +		ptr += na + ns;
>>>> +	}
>>>> +
>>>> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++)
>>>> +		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
>>>> +}
>>>> +
>>>>    static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
>>>>    {
>>>>    	fdtdec_setup_mem_size_base_lowest();
>>>> -	ddrss->ecc_reserved_space = gd->ram_size;
>>>> +	ddrss->ecc_reserved_space = ddrss->ddr_ram_size;
>>>>    	do_div(ddrss->ecc_reserved_space, 9);
>>>>    	/* Round to clean number */
>>>> @@ -696,7 +742,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>>>>    	/* Preload the full memory with 0's using the BIST engine of
>>>>    	 * the LPDDR4 controller.
>>>>    	 */
>>>> -	k3_ddrss_lpddr4_preload_full_mem(ddrss, gd->ram_size, 0);
>>>> +	k3_ddrss_lpddr4_preload_full_mem(ddrss, ddrss->ddr_ram_size, 0);
>>>>    	/* Clear Error Count Register */
>>>>    	writel(0x1, base + DDRSS_ECC_1B_ERR_CNT_REG);
>>>> @@ -741,6 +787,8 @@ static int k3_ddrss_probe(struct udevice *dev)
>>>>    	k3_lpddr4_start(ddrss);
>>>> +	k3_ddrss_ddr_bank_base_size_calc(ddrss);
>>>> +
>>>>    	if (ddrss->ti_ecc_enabled) {
>>>>    		if (!ddrss->ddrss_ss_cfg) {
>>>>    			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
>>>> @@ -761,30 +809,24 @@ static int k3_ddrss_probe(struct udevice *dev)
>>>>    int k3_ddrss_ddr_fdt_fixup(struct udevice *dev, void *blob, struct bd_info *bd)
>>>>    {
>>>> -	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
>>>> -	u64 start[CONFIG_NR_DRAM_BANKS];
>>>> -	u64 size[CONFIG_NR_DRAM_BANKS];
>>>>    	int bank;
>>>> +	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
>>>>    	if (ddrss->ecc_reserved_space == 0)
>>>>    		return 0;
>>>>    	for (bank = CONFIG_NR_DRAM_BANKS - 1; bank >= 0; bank--) {
>>>> -		if (ddrss->ecc_reserved_space > bd->bi_dram[bank].size) {
>>>> -			ddrss->ecc_reserved_space -= bd->bi_dram[bank].size;
>>>> -			bd->bi_dram[bank].size = 0;
>>>> +		if (ddrss->ecc_reserved_space > ddrss->ddr_bank_size[bank]) {
>>>> +			ddrss->ecc_reserved_space -= ddrss->ddr_bank_size[bank];
>>>> +			ddrss->ddr_bank_size[bank] = 0;
>>>>    		} else {
>>>> -			bd->bi_dram[bank].size -= ddrss->ecc_reserved_space;
>>>> +			ddrss->ddr_bank_size[bank] -= ddrss->ecc_reserved_space;
>>>>    			break;
>>>>    		}
>>>>    	}
>>>> -	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>>>> -		start[bank] =  bd->bi_dram[bank].start;
>>>> -		size[bank] = bd->bi_dram[bank].size;
>>>> -	}
>>>> -
>>>> -	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
>>>> +	return fdt_fixup_memory_banks(blob, ddrss->ddr_bank_base,
>>>> +				      ddrss->ddr_bank_size, CONFIG_NR_DRAM_BANKS);
>>>>    }
>>>
>>> Have we looked into passing this information via the global data pointer
>>> rather than fixing up the device tree on each boot phase?
>>>
>>>       https://patchwork.ozlabs.org/project/uboot/patch/20180926215520.87168-23-sjg@chromium.org/
>>>
>>> I don't see a clear path to pass GD from SPL to SPL but there is a TPL
>>> to SPL which I think we should be able to copy.
>>
>> But we also make use of this to fix up the device tree that passes onto
>> kernel as well, I need to look into this patch though. But from a first
>> glance looks like we will be able to pass on the information from SPL->SPL
>> (with modification as you said) and SPL->U-Boot but U-Boot->Kernel would
>> still require this function to be present.

Just came across this series again and noticed that this will be a bit 
tricky with boards detecting RAM at runtime.

Updating the memory node with detected RAM size prio to DDR driver 
probing should be no problem. But the next stages will need to update 
u-boot's and Linux memory nodes too. Unfortunately, we do not have the 
data at this stage which tells us how much space was reserved for ECC.

It would be best to do the memory setup for GD or memory node once and 
have other stages reuse it.

Right now I have no idea how my board should be aware of the reserved 
ecc memory in u-boot. Any suggestions?



>>
> 
> I agree. If this scheme works out we can place this kernel fixup
> function with the other OPN fixups we do though later on in the boot.
> 
>    https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/common_fdt.c

