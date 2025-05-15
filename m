Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89076C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 07:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 899F782A9E;
	Thu, 15 May 2025 09:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W8dSwHoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6334382AD2; Thu, 15 May 2025 09:35:42 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E87C8288D
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 09:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UB6vacxCMsNAIOxuFj1HQnls25PIyW+38KMuMeOtl4+N5mW5Q/0ye+2aLNKbe8hhUxy9jehRQ9FezmnSY/6uvRd1GMnQCAbtaKl5rPgKC0WKGPjVNJV16V86tSj7OYlqxG+mriw3HtehqRSk4pUa4iY72kaG9rPydzPJ+yUxphSLtRxD52LET+F5Och6FHVCz1CJwPFC6C+zeSZDxmoQGnWD67QXqZFDQp2aI4XjC97n7BXQUNTXe+om28KehjkJjHatHLvQYRAgGQaBeLIR9jtatQOUbMemfAFs+AcrV9VO1vjr0qJvPdpn955gMmgj3XIADxVp/gDZr0JVs4EViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf0MWsVQJhMSb3MOBu3jUQRlcBSFIzJDhVFT3X1UGbA=;
 b=tJLg4YF+ohEQwE8/K13fZEqqFN43qIjGHeXiMnRazYTuHA8QTuRpRlnWrbN3T42zdG3XRbDUAQd/M0uADESswzzUkz3jIA4QOKgQWaabur+6wnWUNHwGuCfBR51MqvfB0uzksS2jykEsLoFGPYMuf672f9e9O+n1Qz+c2QiJyck8XDNrANlBlyq4tHL35r4Lwfv1i89KOpPR4r7lo4YfzvmSymUeYEy8KPH//3bBIoh5/hFa0ly7jdUdUxJKH1zwOXHn9z/IAIqxHeMCwbp9RLidz6RPVinUsoG+KE/9zKh7jlDfKPSGZGpzQkNC7OXi6Mm3mbe3klimwgwmwVZ05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf0MWsVQJhMSb3MOBu3jUQRlcBSFIzJDhVFT3X1UGbA=;
 b=W8dSwHoPEp+GMy+s+ucWqwVANDCAX28cTluNymHxAmbsC4x1XacvxahXy+qu6gHMf+lTVxLJW/BnA8+7hECQ0y1xn3GGnzAxrtJETm/OvNhxQiKpOYp8Wq6GZn6x7rcDCe7LzBfsLSp+0gGwTOMAUIp15SeFPB4aOKHKkGyle4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI2PR04MB11050.eurprd04.prod.outlook.com (2603:10a6:800:27c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 07:35:36 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 07:35:35 +0000
Message-ID: <c91a8565-7bbc-43c2-8aab-fdb32fbe995f@cherry.de>
Date: Thu, 15 May 2025 09:35:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools: mkimage: validate image references in FIT
 configurations
To: Simon Glass <sjg@chromium.org>
Cc: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, carlos.lopezr4096@gmail.com, aristo.chen@canonical.com
References: <20250505100852.9364-1-aristo.chen@canonical.com>
 <0cb64c56-8f11-4cff-b1a6-a1b6a4194c86@cherry.de>
 <CAFLszTg-4HKF0ZD9h0h2LVSGsSv0adX_=6B84EX6wuGP=oQxzg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTg-4HKF0ZD9h0h2LVSGsSv0adX_=6B84EX6wuGP=oQxzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI2PR04MB11050:EE_
X-MS-Office365-Filtering-Correlation-Id: c8407c77-b60c-4cdb-1ef6-08dd938314d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXBFcG9rR2VNS1RVRmI4NzJFbmszQ2N1TXBYRFJJTzJjVnd6ZnBBbWVGNG1L?=
 =?utf-8?B?eUFwSWM2WitrdGZxYVpIWGx5VVoyK3ppWFFUV2E2eUNSdlIzR2hSdWNuWFRD?=
 =?utf-8?B?VnppUkNjZW9ZMzZ3TC9lQTVSbGFEeWRxNHo0YkgraEtiVitNTWJxcm4wQTZI?=
 =?utf-8?B?R09xRTVXK2VzaVpkZENMUnVQbFhJbVlVb3pCdWdBaEhlWVlyL3NLTytTVTNY?=
 =?utf-8?B?eE42SE1jN2hFNWl0cTZYVkhTeDlLYzhYWlpJa3NOR0lLTzY0OHkxMS9iaDJP?=
 =?utf-8?B?ZVJpZWpJaENHWUI5QzlwV1M3cDZZb29WV2J2bURHc0s2dE9FNHovMzNZaWlt?=
 =?utf-8?B?STFuZk5CaXpDeEZMNjFNVllmczBpdDVoVTJFK3BSNTI2RndOK2FRdXNDZENY?=
 =?utf-8?B?Rk9vYzNWSEZ6YlN3WXo3Z3Q3bDdGUXlOTVZnanpac0ZDZE5maUNZd05yMVZo?=
 =?utf-8?B?V1ROZytqUGs1bjVYNWk5T3lKeW1DVzdSdzdxNW9XTFM2NTZ2RjN3NzJHbHAw?=
 =?utf-8?B?bTdxcnd2bGJvNkRaQm9DYjdwUTVCMFRqems5SWxlZDNWQ01iYkkrdVlMV1Ar?=
 =?utf-8?B?L1JmU0hTKzh3TERYek9YeklLR0RFR0loWmNSWGJrWmFZVGRLQlcyb2pqTlJ2?=
 =?utf-8?B?VlM0ZHN6SndMVjU2Tnd2RFk2eXh6c0dodjRRZDF5UEFvY1N5TjN2ZjhHT1p0?=
 =?utf-8?B?a3dNa09MYjIwT0tlNDd1YlkvYTJPYnJEVXJUTFFER2hyV0FDYkNnem9rMU1T?=
 =?utf-8?B?ZTJPRldMWEg1eEpZTjE4TThQM01UMDdpN0dqWE5kUFVEbU13bHBxbnZKWVpW?=
 =?utf-8?B?SENmcG16TElYRERnd1psUzliS2FGNDlURTN5M1p4YUpHOElrb1dhdkNkc3Fo?=
 =?utf-8?B?TmlwYm96b1BQUDE1c0IyNzk5QzBkV0JXLzhreUsrS3U2bDA2K2RlbGVkYUFh?=
 =?utf-8?B?dk9tcklmQ1FYZFlxd3VrRmFYNzIzZkxmaHMrTUlSOTBhN0IzZyt0ck1xb0Zo?=
 =?utf-8?B?YTVTbmc2eElTQ0k5NklUb3Y2VkxmenB0R05sUThwV05jTWd6UzlVQXUrR0t5?=
 =?utf-8?B?SUMwQ0RsYzdubXdyT1FEaUY4VzBVRzdQbmxoMkRibGpLci94cmVEUDR6S3Ew?=
 =?utf-8?B?cm9Hb2JCWlRIeXBtUkxtUmNOY1V2YWFJLzdoNVN1a0MvdW1MZnhLdCtYbFNv?=
 =?utf-8?B?a2dHU2Y5RXZtaGlZMEwyK1V6NGFteDR2OThNK21mVlM0Y3dUY0d6TW9iMWpP?=
 =?utf-8?B?VTNJQWkxYlRwNnBYZmJheGxZZUtPeTIwU24rMGxPQVJLalhuUXRqKzVnN25B?=
 =?utf-8?B?RDBrRnNqU2UzQXdyamRXSkRnWkpjeXVqaVJBNjMrQjJ1Yk8rL0YzQWpTR3ZK?=
 =?utf-8?B?VW1IZzRJRmRXcXpGNzBLOVpGZUVSLy9Wdk5Sdk41ZmU3UmVBRlI1WGtIamFn?=
 =?utf-8?B?aFk5RUs2SHpVSnIyVHR4MFdKek9EN3dIUE9US0V1eFdQZzN2a3J5c1k0akdi?=
 =?utf-8?B?eFhxa0tYVmg0dW5Gc1paSWdrc0N5UHVjUDBTaThoTFBrUk5BOVpFMHdlRTFr?=
 =?utf-8?B?VUI1QU9vVE40TUUyaW5Tc1A1TXd1ZGNaajZJNTFIdml0Qm15MUtkaFlIakJB?=
 =?utf-8?B?cEJKVi92L0UvVGw3Zk9vWFZIejFXcUxCSGRnUFFMblZGWjZlM3dmS3czS252?=
 =?utf-8?B?akZvdElMTUFlZ1hRK29XbFBLOXdCNWFXTWF2K0dPUGZGSGN5R2NjSWZjWE9R?=
 =?utf-8?B?YjI3TTRPcThtMlhia3lOZjVoQVkzRnZNWjlQR3JEN0RlN1FIWGRYSnNVZE4v?=
 =?utf-8?B?VTdWUW1mdG9wcWRCb2FVc0lIdlBOZXg1YS9rcVlyZGtyUFltNS9rdlVQZVhi?=
 =?utf-8?B?TUJNRnlhbGxMTWJOVWp1RXZzbXpVdFpFekp0d1lMOTE5NU91cmkrUnlPYlEz?=
 =?utf-8?Q?oMMR4r8UkDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVBS25ScmNtdnpPcU9SZXozVkxSQ25YQW4zL1puVHBvZWxlaGRFRHRKWDBN?=
 =?utf-8?B?dHVjZW13Q2krZVJTcSswWmJiUkhWeWxHQTc4bkViaFNTZHV5aGlOR2VxbmM1?=
 =?utf-8?B?NUZkR2c4ZUlZU2M2T2JyQUFpelhSb2tLNHY0UmczTEp4R21xdnBFd1gzN2JI?=
 =?utf-8?B?RnM5WjVLR1MrMzd1V3U1YldSaXJGWVJ3M0VINFNwU1A5S2c1RjJhWU0rR1My?=
 =?utf-8?B?ekE5bGhwTU92ZTZtSlBuU0RTR0pOQzVKM0ZCMEY1anR1SjhRZ3dKeFRpQ3N3?=
 =?utf-8?B?V21lb2lhaDAvTVphM3pQb3ZJT2dwSzNINXVqVk1GeW9TSnRQOGFBQSszeTMw?=
 =?utf-8?B?a1Zlb0VPdTIyeSsxNXdPSVJzd0RiOXo3NzlFY0VFWFYxd1J1UG92eXo5cVBH?=
 =?utf-8?B?M0tpeUpRVVpReEhRRzlWZ1BtS1RpSWdIQ1pScllhbjNsSTJwWjJBWWVpTlFH?=
 =?utf-8?B?ajNzMEw2ODdCWEdrTXZjTVkrc2l5VGg1TVFWeHVRSHQ1N0RjTFVOSUZXaTlP?=
 =?utf-8?B?ZjZRUXhWV05LZHk2ZlZlamtVUWQ5S2pHRWZKREt2MFEwOE5vYlQ5ckpCYWZQ?=
 =?utf-8?B?amNYWkJQSXd1WklUWklTQVlMZnpXY1dpV2NVTjFxbEVoSWV3SFdHZVl2SjZl?=
 =?utf-8?B?QU5qSURGZ29BKy83SUkzMTdKTmt4Mlk5bEViMjFkek5uWlg2MjFiNXFRRmlh?=
 =?utf-8?B?QUlzWWdFNElmc2pLNFh4T2IxdzFzMVgyM1FEVU9RbFJkbENrRTh2Z00rSnJV?=
 =?utf-8?B?Rm9oUU04U0dpNWttZVZESm1qbEp4MENNeVF6b0c5c0t4V3MrSFVuQ0NXR1ZP?=
 =?utf-8?B?eTNxNUNHbk00dUF5amgrdWxub2NvQ29MVVcrUXdEOHJqNnB2K1pqWUViWU15?=
 =?utf-8?B?Zzl1T0x2dUNTUFNMcTFEbFZJNWF6VXRmOXE5K3ZaakRoeVE5VUl0YWxjZVEr?=
 =?utf-8?B?akNFZkt0Zmx4OXNZZHd0SjdjRHdMY0FaNnRpaUVzR09VR0V3eW45RzBzaWJD?=
 =?utf-8?B?SXhoQ3BRL0NHYzdyZXpOamZoRHhjQ1dRNE1ETmhoRVZsNlovaGxRNW9UZ3Nw?=
 =?utf-8?B?N0oyQmJybHVnSlRoM29nWW9iZzhFNVBXZzkyUE4rUzJrT1N4Z2FpekFKVDV6?=
 =?utf-8?B?L1NSV1VaZUZacVUvVFFsVmhjb0IwUXF4L09EMVhIREFiMFZ4NVlKanpwUm9E?=
 =?utf-8?B?a05tQ0hMaFZ6RHpnSHkrN3NUZ1FOQkRVL3NsUjQ5emVkS01sN3NjSSt2NXZG?=
 =?utf-8?B?K1ZlL0hOM2dUeU4xWEI3NlNCWlBIQ29HUEdCUnd2VS9GL0gxbjJNandKYTh1?=
 =?utf-8?B?MmVZUjdtZDhHMVVoZkxhMlVTcGl2a29oVEp1S3U1TGhvTkZqQXlBTDQwZTlE?=
 =?utf-8?B?SEZDdWxFbGVMbHBtTFJoUWd0ODdYSGhsaGxzZVhDZ0dHQWx3ZWJVZzZ5RWJu?=
 =?utf-8?B?alVOT3ZkYlZlbkpUVGVONldyK2tpMjNZRDRjM1c2bWJjZjh2azF1eVNnLzNQ?=
 =?utf-8?B?YTVpNGRMQVZ3d09KQlJtRGFEbTdZd2Jvb0p2aW9Ua2w3aCs1YW9nQ0FNdGZP?=
 =?utf-8?B?STAvUnlxbmNveEFCcmkrUG9ZVm5Yd3kzTjBGcDhqUVpFNU84U2N2M05zNGd5?=
 =?utf-8?B?dW5vakJQYVVKbUI4UGNLL1lCdVlCdUNJNTZTcWg1ZjBwMzlhYUVCOGhDYU5I?=
 =?utf-8?B?VkNRckZhUDVKVllIWFNQMXFoQWhwTHkyMTJxeDZFNmx6STFEYm5hQWlIMCtT?=
 =?utf-8?B?c0NrcTlQNldieC9ESlp1YndMd1RPQnNZbGFPSUw5cDlDc3RROXFsTXVLRGNn?=
 =?utf-8?B?ZFMvZ3R1UncwcmpZdGlrUVhBK05vU0g5ai8xWHdYK3Jvc0htQWRHRmczOVB1?=
 =?utf-8?B?Rk5wcFBYVUpnRmZEbXFmSE1YRFdIendqTnFtVW5pYXByc1ZlSkVWMm5mQUhU?=
 =?utf-8?B?dklVUm1CUjYwdjJKVTUrME1MeVR0c00vQk12bElYMEZBaEZheTZYcStPRnhy?=
 =?utf-8?B?ZG5wSUovS1gzeHFLRUdKdDJLYkUraXlIcEdOdHVaUWpkemt2d2pUWkJidmNi?=
 =?utf-8?B?eVBVVktpeXZLWjVrYTczRWY1VVpkN1EwWmJhNjBQV2p6bDIyT2wvalNaSkhS?=
 =?utf-8?B?NFVDaE93MWw4bzZkUTBmYjgwc2Y3NFpmQ3R6K2ZOT0lvbVo4RWhZUUVWVi9P?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8407c77-b60c-4cdb-1ef6-08dd938314d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:35:35.7733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wu7eeQzsHrfLnVb1f8XZDY2ccajGgmFqSZakoN1XxGb7O4PGWEbe8UiPQG4zF8Fsknid2YMHmUsR0m5tw3XgFq0Cmwl7EzBvE08io78qXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11050
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

On 5/14/25 9:44 PM, Simon Glass wrote:
> Hi,
> 
> On Tue, 13 May 2025 at 17:28, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Aristo,
>>
>> On 5/5/25 12:08 PM, Aristo Chen wrote:
>>> When parsing a FIT image source (ITS), mkimage does not currently check
>>> whether the image names referenced in the /configurations section (e.g.
>>> "kernel", "fdt", "ramdisk", "loadables") actually exist in the /images
>>> node.
>>>
>>> This patch introduces a validation step during FIT import that iterates
>>> over each configuration and verifies that all referenced image names are
>>> defined under /images. If a missing image is detected, an appropriate
>>> error is reported and mkimage exits with FDT_ERR_NOTFOUND.
>>>
> 
> One option (for boards which use Binman) would be to put these sorts
> of checks in there, since it might be easier to code? But having it in
> mkimage as well seems reasonable to me.
> 

mkimage can be used to generate images from outside of U-Boot. I believe 
this is what Yocto does for example to generate kernel FIT (see 
UBOOT_MKIMAGE and others), so having an additional check in mkimage is 
probably a good idea.

Cheers,
Quentin

> Regards,
> Simon

