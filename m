Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF1C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 23:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C2B82977;
	Wed, 25 Jun 2025 01:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Fuex+GU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B9482C84; Wed, 25 Jun 2025 01:07:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC587803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 01:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz0cAM3Ch9F8WiBRzAy9aIhiOuI2LFepBWdUPuwHpmZaTKJhHhPKqZsbGjULQUb2mNpgRsDdFzUS8SqRzimB/RYTllXWp+EyXuVfBB9m7m3Q8GNt5dnK7bvMytV+7cZi/liBqOj+YFLGHyUpGO5HnPswIh4nZEI0JdyJkTOFtEVibFK6Mwy1ru/7lTCXXkz1oy/FR/uYxSXSLpfIthRE07Y0UAGMRw+vwDgB2+MDRDe0VJKQsbvzKcXIBwZA2L+R4SIKCCiOHFMQcQqujRCqfWfWrdw+dfUKKI0DemtdduNb7RGmb4Ml8g69kC/pvJxoqZbZw/CVCzH5mcXz4sJkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIQ1N5fubfotFMt6yW5UbyWm123jk+12YHorHOJlnrw=;
 b=IqnrykH3/AdlR5G9P0TgelLSi5bU3ZjICtfTwoELoG5LhfLR6Dghn5qvczD71oKhmYlZkOw/YNKIbM5nR1zFD5xUaUA6VVoEyk5PGtaYzafklEuFnKgoWurCXuL6dwD7cAb/n+p6hiMvs+reaI6HAGqXZhSVRpVYRnN10iVJogrKW+2GyoS0JXS5mTSEStaL2n3UZm709J7jnCcq27YrEi5rNyHWvLaWfY8t3GUCggCXymXoFIup5EyhciK7yhyPFVKXT81BqQioidmXO2c9f/159sI2tGkhd1gJn3SsBhYtJxUViyHZgGOeGWeEi/5SOLFzabRNkTA0X6uWbPvyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIQ1N5fubfotFMt6yW5UbyWm123jk+12YHorHOJlnrw=;
 b=Fuex+GU1r3do87lumLbHVwT8oXnQ7Po10WLft21jtYSKa/Upz62CfdPu030UTtzX63Trw6As+KCgLh3vEMTGX5FTC/nkaRc+74/TOGwsN8ku2W45czUZgNTLSSleCVPsyWNgz0LfJ84hAb5NQWwMev4hmnYz/pTEo+3paeM8epyBbnzFaVcQwTkOpCF1oEqCnRNN7dkNfj4GGcIh/iZOg+yuXFKvUW/rbTgeNBYtvp/vLe07fIPlxQ/52XsSy1NfMFF6vHq75VEa3xbDNnfdf9LV3PXT18YABpG4X8NDWU99ioNl5N/cY0sjce3obn77RPDAAE+m7lV9JxzCPPPgmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6360.eurprd08.prod.outlook.com (2603:10a6:20b:33e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 23:07:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 23:07:44 +0000
Message-ID: <d9ea1a92-2a92-4257-849a-c9eb8971d67e@iopsys.eu>
Date: Wed, 25 Jun 2025 02:07:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
 <62500d98-9489-49e0-9c34-b8033c708687@iopsys.eu>
 <3637667b-d7af-4e2c-b79d-fa20fda232ba@canonical.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <3637667b-d7af-4e2c-b79d-fa20fda232ba@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cd36cb-3d71-41de-e323-08ddb373ed44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjBsZitEdzhEbkpVdDUrODhYMVUveDVXZEFXR0dVZ2Vka08xWmtyQ3ZRNG85?=
 =?utf-8?B?SjZJdVhWTnd5S21hWDNJWUF6YURwM3c1bWRXem1SMU9mblAzRzRMd1U5QXJw?=
 =?utf-8?B?TkVJUm1iUDFMZVI4Vyt6d08xV0pTR3BrOHUzYWZKcFJkOThGalFWakJHYm5z?=
 =?utf-8?B?a1Zzc25lcVh4WjFScTNiamZYbkVMWnJSOUdqZm1wYVY4Qzl5Y1dJSmVmZnZh?=
 =?utf-8?B?WGltdk9vU2ZxS3ZQOEcwN214d1gvYW91TzB0OG1QT2Z1Wm9YN2FCaEtaZ1F1?=
 =?utf-8?B?ZVNPYUZPelpJS1pUR094aWhsM1FwTGU4V0xyckRmNjhtdkpHNTY5MXRyNTVC?=
 =?utf-8?B?aENjRDBXSlJ3b3BkRVdmNG45dEFMYnp4OXprcVkveWFtaXJPM01xcjZjdUE4?=
 =?utf-8?B?d29qYUVaZ0FzWU1nRWRBbFlnY01sSHpjYmhoT3VmQlUyWW1za3p2WWw0dkRq?=
 =?utf-8?B?RHlNaG1IQzBPV1NMUk11eGhQUElzN2cyVU5JRGVKTk8xRU9hNjF4aWFiWDAy?=
 =?utf-8?B?WDU0cUdBamVja3B5T21kOE5LNmhHTGd5K1NFMXVRZ3BOa2tTM1YySUZDZGJK?=
 =?utf-8?B?ajdZTDlxRW9RSXhueUpwYW9QZ1lkRUZidHQ2OTVXZUZnV2VoNE9MTWs5NVps?=
 =?utf-8?B?R0dYRnZZQ3hPSGMwK25MQlNlcVQxcGRQNjYrenE2eTVTWUJOV1RhcDJrUEFX?=
 =?utf-8?B?VmdMQXlIYmRGSVpsaHEwaXFydGlMVWNjNHVWclJrdEoyU09zc2xQQjZDYWR6?=
 =?utf-8?B?NjNQZHpBcU04bnRpTXNMeC96b3NkSnYzODAvd09PZzhuMG1sejFaMjJCQTRP?=
 =?utf-8?B?QllQMW00RGNQV05lemJkS2lkc20zeEJSU2JzelA1cDg3MFUydTNZanR4UUI3?=
 =?utf-8?B?THU3OXhPWm1XNDV1K3M0Mmt0WWRTaStlamhTTktGNEtlWFNyMGROZTIwMlJY?=
 =?utf-8?B?RzQ2V0lOYThqaXdZQW8xdi8xeEU5VVFlSm9lOGNiWDhjZjhjdUpNc0pmdzQ4?=
 =?utf-8?B?bkNVSSt6ODQ4WWxES2ZROGdjSHhtOGIzTTVURXJwMjF0cFZlZThjWWVwaGZn?=
 =?utf-8?B?Y2Z1b3dCaW1lcXBJMlhGTFUrVFRMRHhBSGJnZ1puYnJDMmhqQkJLSit1aDR2?=
 =?utf-8?B?ZFIyRi90Zm9JSUpwMTVMSW5MNUhaM1pNVnVmTi9ISzBrRFFVVjFTRjVzdXZt?=
 =?utf-8?B?QXZVaFNwMHpBejdMSHhLeWx1MjhuM2VTT2tScXpZejMvS2lCdnJ6dkprU2I2?=
 =?utf-8?B?THZEMWdMMHNObTdoZDVmY0taRkdHU3RKM0xIdzNoZjMvWTVBdUFqcXR3NGR0?=
 =?utf-8?B?TmUxa3ZQeXg4ek1RZ0ZPY2NmR2h0OGx2Yk1ZdmRnRTYyK2U1NW1HUmRtOGJy?=
 =?utf-8?B?WlloRzBtckVmTEFYWndnc0RIRzhsWDZ2cnl3RkY1ZkQxOXZiRndDVlAxUlpS?=
 =?utf-8?B?K0J4eEtnaFFIV2FtWU9WSDcxK2U0QmxLYmVYdjBCUDV5TEZJdGZSUGIydHJD?=
 =?utf-8?B?RmRZTGJsVFlHWHJDaUVIRTh4NVhVcnJRMHovcmgrK0FJVWxNS0NCMWlEYTM5?=
 =?utf-8?B?QUlGRjhvUy9nc0hyNHdZNzJGYXBLelpXMW5HbFRaNDUyR0UxaCtZdm84RHRU?=
 =?utf-8?B?eklxY1I3UFBXL1M5TlZZWXJTMlk4cG1Dc1M2bkxZeVd4V0hKeGFRb0tLQjY2?=
 =?utf-8?B?czRFUDMzY0N0Rk5WSzVmMnZoZ0RualE2M1ZTNHQxL0NYaUZlcWlCM0Y4bWNO?=
 =?utf-8?B?L2JKdVgrdVlzZDN4UlBGY2tkcTFsd1NuTnYzM1pVQ21ucUh4TUs2a0RoQTRU?=
 =?utf-8?B?VGR0YUswQi9NZlY4OVQrUWdyb00rVmtIYmwrQUtONnkxWG43ODQzbjVTL0lD?=
 =?utf-8?B?UitKTSsrd3B2TlBYZktQQWcvVkczY092UUFncEthQW5DcXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(13003099007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BlbCtpN3Z4OXRZd2FNQkZvNU92RnIvWjVoSU9HNVlzbnZEZFNia1VXOGRx?=
 =?utf-8?B?dXlsNjBpSzAxSThEL01IcE8yR08ySXIxVzA2V3BDMGEzc1NvMjlYcDBTVzNB?=
 =?utf-8?B?UTlYMU90MG9jMHE3aExsQU5UdGJtVTdkVTRRdkdVaEF2RzhmMEFjbVdCVFB1?=
 =?utf-8?B?MjlMWVErZFpQd25hZVB1V0pXUDFUYU5lU0IvWmVUb3lPaFJOQmZHUFVPellW?=
 =?utf-8?B?SnB6cTRvZlBoYi9ZMzd4RGFEQlBvaGdKOEswbC9WYXVEWVJwSFp6WllxaXhn?=
 =?utf-8?B?NlNqZlBXKzBnZTZZMmZlSkVZOEYyL3I1RzJVTWZhMEdNQW5McllNaFVXNG9w?=
 =?utf-8?B?b2hyb2tMVDlmRnJZZ1h5aS9VSDdYRG9QbFViYW9VKy9DTEtjVEtxbWZnY3ZR?=
 =?utf-8?B?L0U0NS85SmlTT1dPRUhTallDSlpKN2dZbzFnb2lSMEJhL3BFUzNzTzI0QmZw?=
 =?utf-8?B?bkRzdjVla3pVcHc5aEpXZ0lMYW9LUlJJT3pNVXVhcDBEWktPMktkbXNIeExk?=
 =?utf-8?B?U3dhK1VyQnozRmZvVTlmUnNxQXVWNnBJSVRWd29Ub2IxUUJvY2hGK2pScXRo?=
 =?utf-8?B?Qk4zZ1BJSEtldXlkYXdCVWsxYkpzNkw5ZGZtaUIwQ043SHlXQzNJK1IyZmk2?=
 =?utf-8?B?VTNhNkJjcDNGblZmblZ4bW93K2pPWGIveW4zdDF4aUduYlJWbWt0MEJ3dklJ?=
 =?utf-8?B?QzVsbXBUamhVVzJMWm40RnBYRkxQYUo0SDMzQkZ1T1pkZlJvZlZxN1RHVUEv?=
 =?utf-8?B?cmxKMTkxbnpVVUEvNXFyOWR1Rndvb215MXN0bWdBWE1DN0Jwekg0OE5KWG5u?=
 =?utf-8?B?MmRESmdaOVdab3kwYjdnaWNWSUxZU1JKU2QxM3BHVU5DTnhkNDFiWFBXeXFN?=
 =?utf-8?B?Zk1WeXUrQzRVQVQrYzI0MkVYaGZhbERhdi9jLzI4SVdlbURyWkl2SnNmampq?=
 =?utf-8?B?czMyVXV2ZTJJOGE3MWtTSERLT0k3OWtPRTFyNUVoN205MWZReUxaNUNRbGFt?=
 =?utf-8?B?SlBGYUVqbGJxb0pOcko0Y3lUeVp5RXQ2Z2QwNzJCUUlLSUpyaFhueFlTcG1E?=
 =?utf-8?B?eEo3NTVTa283Z0w2ZUd2VHU5czhWUUtZM2tSY3V4VlJ0dkh6ZjVjeHJjWmhX?=
 =?utf-8?B?NE9hc0dSZmdyd2g1RkpXSGJQeGJlcFR6cmc4b01rZi9HMHYrUy83QjB4dklF?=
 =?utf-8?B?WVdTZDltTjcrVW5ITE0xZzF6akNUWWF5VHdoTTArMFJHSkx3VVVBMk1HdnI1?=
 =?utf-8?B?YVZhMVpqT01NVzNRenJhblZOcTE3bVhMT2VNeDRCNlozcUgyVG9CL3FVV0Jz?=
 =?utf-8?B?bGIrRitoTi84dnJnYjJ1WXpCSzFLOFo2ZHBtMFJxQkpubVdoMVJVU1IrVW1L?=
 =?utf-8?B?b2F5QkJJUDJyZGVWQSsram81bXd5clFLRVNrMXFaUjUwcGQ2M04xT3ordG1k?=
 =?utf-8?B?Snc4a0RmL204amUrRDZDR1psckkwSUptekRoMEFlVmkxb2JzMzU3aTdxOXU5?=
 =?utf-8?B?b2x5dUQrdkY2ZUVlTmJrV0lwcmM4WjVmQzRyRTJSajk2a1JBSUVhT0dITHh0?=
 =?utf-8?B?SjRKalBMTFM2WUl6NU1lQUFSamlaa2txcWFSWjdhK1Y5bURrUEFpcXh0VG1Q?=
 =?utf-8?B?dGpxN1BrYWRvQ0sveXNaTGlpdFhDaVhDcnpRQTJiNzlZWFNlQUovMStGZXZT?=
 =?utf-8?B?Q2JBYXBwUzMvcXlHQWFUdHh5Z1EwRW9BWXlOc0Y5WGlTclltSFNHZzFkNkxz?=
 =?utf-8?B?eEc3VnpmYU9OeTVOeFZFcXBHNWFCM0gxaE5DQks0N2RhZzF6S29YU0MwYUtC?=
 =?utf-8?B?eXp1V0FqcXowZTV6ZytTSHcxcms4WCs5ZnhjYlhBNnFWMUlpMndXbzNXUjZB?=
 =?utf-8?B?TGFuc3Rnbm1DL05GcGxVYkw1bUFRUGVhQUNmOVRjS1hSVjFnTlVTb3JteGRM?=
 =?utf-8?B?NkoycEYxckk5VXkvOFdUMjhNV1pkYU5KR0RoU1pPa2E5WURmTXBQbUNEWllt?=
 =?utf-8?B?OVU0bVVZcExSajVwY1owSWZsM3ZVSHljMEYreTNVOXZqWFl0SFBJVGxqQi9B?=
 =?utf-8?B?L2dKdWd4YjAvdit5QTRWeTNWOTZPQ0xLMyttNlQ1STh6bVQ2eXQ3bGNPeW5B?=
 =?utf-8?B?VE1Bc0VaSmNXdzJKNXU0WkU2ZTV4L0c3SThVTzZwczYyM2JMTDdVOVhBRmlT?=
 =?utf-8?Q?Qj//B4omVuzVChZvaILFwjg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cd36cb-3d71-41de-e323-08ddb373ed44
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 23:07:44.1256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IgpubsUGkk5+pI09r7NHPhA5G7KOGreei9fr9Xy3K3/ICMgXH83roY2LIQns6q+aLUIOW1pnkI5gwtGOpYjQAS9xomVQxb+5NOAP7sZFWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6360
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


On 25.06.2025 02:05, Heinrich Schuchardt wrote:
> [You don't often get email from heinrich.schuchardt@canonical.com.
> Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> On 24.06.25 23:05, Mikhail Kshevetskiy wrote:
>>
>> On 24.06.2025 18:34, Heinrich Schuchardt wrote:
>>> [You don't often get email from heinrich.schuchardt@canonical.com.
>>> Learn why this is important at
>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> A malformed FIT image could have an image name property that is not NUL
>>> terminated. Reject such images.
>>>
>>> Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   common/spl/spl_fit.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>>> index e250c11ebbd..25f3c822a49 100644
>>> --- a/common/spl/spl_fit.c
>>> +++ b/common/spl/spl_fit.c
>>> @@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct
>>> spl_fit_info *ctx,
>>>                                    const char **outname)
>>>   {
>>>          struct udevice *sysinfo;
>>> -       const char *name, *str;
>>> +       const char *name, *str, *end;
>>>          __maybe_unused int node;
>>>          int len, i;
>>>          bool found = true;
>>> @@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct
>>> spl_fit_info *ctx,
>>>                  debug("cannot find property '%s': %d\n", type, len);
>>>                  return -EINVAL;
>>>          }
>>> +       /* A string property should be NUL terminated */
>>> +       end = name + len - 1;
>>> +       if (!len || *end) {
>>> +               debug("malformed property '%s'\n", type);
>>> +               return -EINVAL;
>>> +       }
>>>
>>>          str = name;
>>>          for (i = 0; i < index; i++) {
>>>                  str = strchr(str, '\0') + 1;
>>> -               if (!str || (str - name >= len)) {
>>> +               if (str > end) {
>>
>> and if strchr() will return NULL, then str will be equal to 1. In this
>> case str will be less then end, so the loop will not terminate.
>
> strchr() searching for NUL will never return NULL but search until it
> hits NUL.
>
> And as the patch adds checks that the buffer pointed to by str is NUL
> terminated we will not read outside of the buffer.

Ok, good from my side


>
> Best regards
>
> Heinrich
>
>>
>>
>>>                          found = false;
>>>                          break;
>>>                  }
>>> -- 
>>> 2.48.1
>>>
>
