Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEA0CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01AE82998;
	Tue, 19 Aug 2025 09:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="r7nLA0Gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDCA80422; Tue, 19 Aug 2025 07:22:30 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C92B8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3tQ9HVT9jeEstahhkqv7tzIobxyjv9LMQzDTsw6uBoYYaVUG/pxN0XLspvzHlfAPcytZjlwLLyZ4nm7ZssrCAkkhvJs4YY2ki23UqAPYORbGE4IT83vVzhZTZnujR5S09ElU2Wx8DXVhEuYKNaxJy0vX3qbn0js2p35+egTezT36YARVDPUf5NpEL1XRleQBV7rZIlKIzU3e/7LhimhIhCr4xdqOLushtpXDuMP3o0dmU5/h9gbzcs0i91cJrAoaEfXR0nBXwyLZC9n+zCL2hSFExyYh4TCmRfMubEdGyKVESP4oU6MeQcotT8U3xNbwRkHSZmQXYwCXbRIrKMJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgEinGLZwD3ywAJ4cd6NdQVcp8hyZy5DuoXRFP2PqG8=;
 b=EjpqxGpXA/Kc+hT1uGZlAmZRvKFRrUcLZBOOiF3ZNccjF4gz6k8PAeL5tFZrbYtZZvHN5OPuwdjpqxOcvNOYVw2nb8usDjhCyMk7DOcXaZczwzZNLEX7OL13PcDHbsWZtU/eFKPuoDrR1GdDVD5ncZ81Br4Q+jncdHnWWPCX9iss0QH9L952pFDIYPx+O8oGI+dOSbL/lTRv9zlDoH/jEWhGGTkKN+5SLyA0LF4dAjGfzHdr39LKQ3rEJ0Jdq1q4BT1KEjISY9sxtGf5ee31TDxPd7az+lebn1+1qCuGcXquzyJVOv0l8iUgb9hoNfNfhFZt2FHGsXIYVWWhRLFNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgEinGLZwD3ywAJ4cd6NdQVcp8hyZy5DuoXRFP2PqG8=;
 b=r7nLA0GsXzIa8biQf384k9lMGpyybrl4JyK9lP4iUplBM39zFEkyzYWFfvu2MRUMMZbATrKmyk40D8MNS4BjKJCCAVB3m0tXf8bJxsUs/q5aUHLKZ80BYzjSs3oqE/GKVpfIVDenejC1KokV/CX0dbXlkGMaqQrJUCIHfx6FHNPr44Ak6NSN0iXlbtPjrIhL1eok4X7Dfg4Ye1jzE9QcICz2umAT/xWv3fZUx2nPKWnol/9Nolc3kf5nV4xKdDK+RFWk1ONoMkjZJe1uQbWYu4YjoBR57bwsvq4HRjsWLcDH4Y00dEZ3MeZcXIyPTUWWx9nOt+s29gjfS2XThqyejw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS0PR03MB7280.namprd03.prod.outlook.com (2603:10b6:8:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 05:22:23 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 05:22:23 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH] mtd: nand: cadence: Fix device assignment to avoid warm reset
 issue
Date: Tue, 19 Aug 2025 13:22:04 +0800
Message-Id: <20250819052204.2628-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS0PR03MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: bddccbbe-c6d6-4666-dc88-08dddee06079
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1lYZXpVZk5tbmFLbHJOQWpETzd5R1JvUXFmVlFtWTJmQ0lZNHJhV0ZMUG5T?=
 =?utf-8?B?dkhjVG1WT3NXMU9FbjNYWmVXY1YwNFBLT2h3NW5tOWZQNHA3a0dPODZxNlk0?=
 =?utf-8?B?QnVueG9QZUhyTTRtZmYrbTJveUdKd1hGNUFiVHB2YWFyQkxBbWREdHNPQmtZ?=
 =?utf-8?B?WlNmNDhjd21McnRjMTUxUURKK3hienl4RnBQWlYxTlhhcWlaYjE4N0tXcXl5?=
 =?utf-8?B?Zi9NbEJRSUhGVE4wZjNvRHVKR1RUWkJjbXE4TlF6Y2NHRXVxbWxvQVJidTRN?=
 =?utf-8?B?ODN4cFl0ZW1VUlNITUxEREpOWnBodFJGYVFhVDFqR2ZaaUhBZHRmTVRYVkdL?=
 =?utf-8?B?TDFCY1VESFZEOHZYRGs3NCt5VUNSMzZoQ2VDV2EvdWNkbEdMcmVhQXlVT0Er?=
 =?utf-8?B?YURLaCt0cE9IeEtoM3c0OUlPbGljakh0TzRxSkh4MVhLSXRKcVQvcVVLRlhr?=
 =?utf-8?B?N0h5QWgrak9EUzFyVVM0K2JoLzljcldYbWZ2ejVyMXpyU25yWE8vU2U1aEU1?=
 =?utf-8?B?MjFtcEJiNG5TRFFidDk0ckxJY3ZscVEyNVdoZFlRajNoVzcyS2pYZ3JBdzFa?=
 =?utf-8?B?c3V3c0NWWXRvQ1RWei9GekNmTzRvMTRzQTZWM05ET3VyaFdXUFd4YzJnQ3Ax?=
 =?utf-8?B?dWlRRDVGVEVkWmpZVHNnaS9jN1RIRk9tQnFhcUdVS1puRUcvSEZrL056MWhX?=
 =?utf-8?B?MmxzQXZCV2J2M0RGbkxCSE1ySXJKSy9YSGY4SThGYXluTHY2cmFlUCtDUU5P?=
 =?utf-8?B?ZGtZQXIwYmdqaWQxT3Nqd2l2eWhsWWQzMDVvWTlHZndoTVI2bHYyQVRVRWp4?=
 =?utf-8?B?ZnpLYVdNcHdSY2tJM1NWUVVJMGFIdWthTldXVEdQOGNyeC9SWENZd3k5aDNq?=
 =?utf-8?B?WGFuUXY5OVhrS3NNZHR3ZnYzVGJpQWE3TW0vQUpDQUk0ejJxNThLWnJHeEJZ?=
 =?utf-8?B?N2swMTVvUjR2R0hXeVdPNjQ0cnl1cklPU20zc2VRZzg3UkJxd0tYWUhMeGlx?=
 =?utf-8?B?MER1YXN1ZHJ6TVgyc0NDc2pxb05GWWFmckRVNlJXbi83ek9tTENYL080Witn?=
 =?utf-8?B?VkJrQ283bys0ZFN1a1I4VllFeVFSdWtERWJPOHV1cW1Ja2FOZWlKWE1SZ0pz?=
 =?utf-8?B?SEFHbndQYXl1djVqUDJsR3Z2bWx5Q0MrL1VQeXFNWUp0eXBlU0lxSUREQ2d3?=
 =?utf-8?B?TmQ3OFJQYnpoMEZYSDNjSlJEQUVPUllDSDRLRjRhc0JpK3RSSlhWRWRGdnJ6?=
 =?utf-8?B?bit3a0EvM0RsUFo5amhjZWpyNGdGMmdiaFc1QW5vN3dDdnZpV3JFVmxTNDBH?=
 =?utf-8?B?SVo1SHQ3bXgwbVRESVBQZ3kyK2o0LytYTzlCck5FSWw2MjgxMzc4OEZ5S05F?=
 =?utf-8?B?elFEb1hsb1hTc3NqaWJZMGtXSVozZGVjQmVjaSthSy9CYnpUUHBEN1I2UXF1?=
 =?utf-8?B?YVdQY1dnOTJWRzA2NDBrd3I3WWVUYWtjb1hiZE5CUjYyK3JKZjlWUWltdm5l?=
 =?utf-8?B?NU02V3pyTHZmc2VSSm9GTFFFL2plc2UvSnNkYVdZaTFGZVhCbzJKZkE0cE1M?=
 =?utf-8?B?a05ERlJHZ0lxNmdER2RqODNGVzNWQ1J6T1pySEFodG9QTERwQUJBekFTbmdG?=
 =?utf-8?B?L2w1TFdDVE41SlhGUHRKRm0zeTN2dHVDQVlZWTZaUUpCWktZMU03Z0dld2hq?=
 =?utf-8?B?TDcyWmJFUysrNEEyVGxXZWFwSmJLbWNJYS8ya2NIWGQyZnVkZHloeHN2TjhZ?=
 =?utf-8?B?QUtSSnlNOElFYWhQRXFBYmtCdzhIOFhDZEd0U0FLMDJ4TTdVRURNU2lMdE1Z?=
 =?utf-8?B?WnNaWTFlbC9HcnBORGRMaXJlMkxYRWJ2OUZxR0czbjJ0SFA4T01QRmpwRVAx?=
 =?utf-8?B?WWxkWFJ2d29UcDBqNDZUMWlnUm4xTVZ0eDNKQ2JkdmNDL3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzF2cFFBejRNVkd2OCtBM1E4bG9Mc0I0Yjk5UnJkazlMd0MzUmtPdFZ5L2V6?=
 =?utf-8?B?UUwyeGRHRkZqZjUybUh3UEVzWDVJUnNpSDFyUU1OaFpJRmRrMHpOSkdmOUFR?=
 =?utf-8?B?YUdMMG95cDVlNXc4YUNHcTJ4Y2VycFNCSEkvTFdRWDBHYWI0dWtxYTB3V0Qv?=
 =?utf-8?B?MS82b21HanhtNXlDWTM3bU9ZRmNjMjF6T0sxT1g5WllpRGFtZG9PYm8wZTFJ?=
 =?utf-8?B?WDJuU3puT3lpRnJSdTBYZ1B6bzNweFRpRThKYTdQbWlFemQ2NS96Wkw2QWJi?=
 =?utf-8?B?Q3FuVlFlbTdKY0V0UWdzRE90TkVKdU9tczFwSlhTdzZyOFZ3czZMZlpUVVUw?=
 =?utf-8?B?WEhuWTZYeTVKd2dSL3hXTzdRakNrV2ZpNDFJZGFqbm1US3ViTW1NdjVpRHI0?=
 =?utf-8?B?d1RybGdERnZicVh5akd5c2MyTWFpZFRZbWlhdlVzMFRLa2MvOGR5aldhOS9B?=
 =?utf-8?B?WVUvQkVvN2kzSDFXY0ViaXFtbXNNemZWNTBoc0tncDV1OTZLQVJsaUdBRmpZ?=
 =?utf-8?B?T0ZmSTR5UkE2ek1PZ2U5UEZCZU1vMlgzUmlOcHM4Q0w0RThwbUN0bE9JQ3lH?=
 =?utf-8?B?dVZqbncwS0JRTEdwcTlxMEJnQWVnNmtMNGdKWU9QUFVKckxqUVBXaXFnZmdo?=
 =?utf-8?B?bkJKSGppV3djMnEveWJYcFpiMG5iQ1g5c0g5OWVsMXUvR01LSC9XM0J1OEUx?=
 =?utf-8?B?V2NJelRWNE1xRER1WEY3WDcrUHhUZUQ1QXdacUVVVlVoRDdndmNSdy9kYmdL?=
 =?utf-8?B?Wkk2QUw1QTNBcmx0TC9NakxNZmQzdm9tMk1uOXBXTmdYM1JrTW9vVlhRYlpN?=
 =?utf-8?B?UXpzWGFmMHdDNGN4dnVBRlA2bDFCc1FiTWdDL0RxeWdMcXN6bXB5eGhmU0JR?=
 =?utf-8?B?b3Nva0J0ZEtlK1N2YmszNWRyMkNhdVlobkRLdWxxY0hJRUlCdVdLeFZZZzlL?=
 =?utf-8?B?bXV1L2xnYW9xR2VwMGgvNHlVbFJ2Vy8wK0NqN1NBTkcxeThUK3pxVnpWdkZT?=
 =?utf-8?B?VXVlNFpEQ3ZMbmt3aVFXejZsajVzeXR6S3JOa1BiUlU4NWM1OGxSc1dtSEc4?=
 =?utf-8?B?c0NtZHR3SzlXTTVUKzBqdDVPanVOSEhWeWdNRTBJYTR5ZC9HM0I0RlhEcjZ2?=
 =?utf-8?B?M2FFbVpRQzBHVDZwd1JIdXUrdC9uZzZMVDdNeGpiTGJpQ3lQQzkzS2VmNDZR?=
 =?utf-8?B?LzlXTlFPa3k1bDE3U0s1NDJuRG00dDJUMklwc050Wjh4V1FsQjliRzBiU2RH?=
 =?utf-8?B?cXNqdkJkUkhRaXM5RE5kNlpsSnk0c0xVWHpZME1TRHd6bFQvRmdFQTlheWdN?=
 =?utf-8?B?Y2MwelZSdWxka0NsSEhJT3grUE1zcm5wODlPZ3dhTjV2WkVYbjNxUm9XVHVQ?=
 =?utf-8?B?UHVwdStmMU41UEJXWnZXSEFFUG45N1dVTks0UnRsTHdGRHVTV3RtaGVjVFhH?=
 =?utf-8?B?ZlRxam9KVjkxQ010WWsyZ1dQZkk3UEF0bGlNdkNMNENjaDhyWSs0NlZyaDRZ?=
 =?utf-8?B?RHFXSm5rbCsvNEgxalRaYURLblhGTllqeTNOa0NCQVJMWlNsREVSOVZSazg2?=
 =?utf-8?B?aXJNdjlpNDhyZFR1Nk5TcW03aUZxYXI5NWRkSW9ubXhxUmU4SC9ScjBHbnJk?=
 =?utf-8?B?dWFIYUM4OTJ1V0tQZFJCN3ArcFEvVXRlaEp3ckxNZ3BEVWh2MWhZU2k2WGJr?=
 =?utf-8?B?M3V4dWRXZk9KUCsvRklWa3pJWGZacS9QWEQ1T1VWcC96cDdiN1BlYXNWRkx1?=
 =?utf-8?B?M1g3VE5UemxPQTNHenJCdlRGYTFqYWlrSU8vVEtOTFFYbldKUTMrb3dYSUFq?=
 =?utf-8?B?ZXlFUUNZeUpHU1gyMUNYREtoRmJQNHRoQVJqRnM4R3hNWjBoWWd5SlZjbGZr?=
 =?utf-8?B?ckVIdGNySHk5dlQyWGt3MXVnOGpHM0dMdzFDWTVCZU4zOFppWHlaOTh3bHVk?=
 =?utf-8?B?WEZUSUtML3FSMVNjSXU1SFdDcnNLc240RGdvSGIvbWNoeUkzRmpEKzNsVWlF?=
 =?utf-8?B?clNReE40U1dHYXUvMHpOYy8vQ1d0bUs3NUhpMnQvS2Jub1BreHVmWFl4dUFX?=
 =?utf-8?B?NmJMakpWa0FuK28vMVYrNHNVMTZBdERZcEZTQTdFTnpmOVhoQVM5SEsrVzdL?=
 =?utf-8?B?S3ZUL29ocllvb0pZNGNneFlnMDRKWjd6cFI3U2dJaXQvT2dFU3h5OXFrVUIr?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddccbbe-c6d6-4666-dc88-08dddee06079
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 05:22:23.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ6nh2Ui5adc9W2hiMe94QTBrv9DBEPPugKy7b0QLeLctOm9pouv39/L7ys33WAT3CrN0x0GW2X2xa2MV1Bf2P4MzuCpFPqKiWLmVZ3u/3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7280
X-Mailman-Approved-At: Tue, 19 Aug 2025 09:16:29 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

The driver currently does:
    mtd->dev->parent = cadence->dev;

This works in Linux because `struct mtd_info` embeds a `struct device`,
so `mtd->dev` is always valid and its `.parent` can be set.

In U-Boot, however, `mtd->dev` is only a pointer to a `struct udevice`.
Dereferencing it before assignment is invalid, which breaks the device
hierarchy. As a result, consumers relying on `mtd->dev` (e.g. partition
parser, reset and re-init paths) operate on a dangling pointer. This
leads to failures during warm reset when the NAND device is accessed
again.

Fix by assigning the device pointer directly:
    mtd->dev = cadence->dev;

This matches U-Boot’s device model, preserves a valid hierarchy, and
resolves the warm reset issue on Cadence NAND.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 27aa7f97a45..4771440d1de 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -2196,7 +2196,7 @@ static int cadence_nand_chip_init(struct cadence_nand_info *cadence, ofnode node
 	chip->controller = &cadence->controller;
 	nand_set_flash_node(chip, node);
 	mtd = nand_to_mtd(chip);
-	mtd->dev->parent = cadence->dev;
+	mtd->dev = cadence->dev;
 
 	chip->options |= NAND_BUSWIDTH_AUTO;
 	chip->select_chip = cadence_nand_select_chip;
-- 
2.35.3

