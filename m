Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C072BE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB44801FB;
	Tue, 17 Dec 2024 22:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="MADEaiWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4B08021D; Tue, 17 Dec 2024 22:39:53 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD4C80107
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTEU+KF0pQK8lyX4r9uZ8akzw9dPaTA825sqenMpBfnPENcK6ngWhdTRLMRmwhicMRCZiEn6hkoEVzHcp+tuZCW+yYHTm43/YoV+h1WqR6x0pYybE6m1Q+O7GCw7gXA43FQ10u74gdaZDOyPs71X+Ojq06nl8HuLM+oOWaBEYqaoFhBEeZCMtjGzE+ISXYZshKn29JQVRH9Ll5Ugz434gzc+R2sznCVYkj8F+uh/8KwmzjackIK27y4XQuqTkjhjGbBStZOYyqNar08GL2kVD4XhBVq76bfh1uN1EsxZ1QyzQKCIVPpIRfwaY5GxOhnyaT0PVTHdXMLlHP2vY3ZNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPGDFZ1EBvtNj1S2FgRhe7XNnw0ZEciZ8IDZOzKWesw=;
 b=nRamsTJG2q1AFJiSGD8+n+NTZjA/VIQsDcJjrq+sNMy/BjOx4Ve5REJuOk2lZfjqR5BSFo/VgXPjxz3NhgWygqI4BXn/g4kT6L7+tb9DO7zzWJPbafAArIFEpMC+OV1Eirprs48TtYeQTmApLJYPOwmzrl5cEa4Pz5Yzgm/59NBvTh8Hpx1wIdcEVWpsHigaBqWS0k5PdZBRJA7S3TW4JOj8QtVDIlNdxMlZjw8qdsjXsRKbIoStrk8BKNcwvlxq1Bwxqi3XTlOParm5hpG4z/HztOuTZ+sO1ZKF/bRZHSJGIt4cLu3gumwIymyNwi87mExPTt+vMhspaLm8eNrcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPGDFZ1EBvtNj1S2FgRhe7XNnw0ZEciZ8IDZOzKWesw=;
 b=MADEaiWZnLps0lOLRtE8R37e46Cfi2+jl/bYy6IJ6lqYjcUHbpfJYQhTFORXBNc/PQCXnxb93rRHofe2dY6yz+6oI8LaFbAkQMoFm/obRwnflwoO5PZtB28mVyLynAIwO8mm+8LLNdDe6ayf17ahqWX5BCG/AJ9+ffdVEr/C+4hc51JrB2xiKrDervJoCGVYWtZzHedrTzIVK8yu+HBPgs8jTw1Bw1lfixFCok2zEu+SNjuuyLZjxPcmmZpTYBgun/i5oIw+Tp5cvhn3e4nlYCB5hPpku0rYefMF+v9uTbrGFq7JoHQJg+Smi+wiOIyWedV7axI2eipVEd/+lXcAvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR1P264MB3445.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 21:39:50 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:39:50 +0000
Message-ID: <1d6adfbe-7692-465f-aad6-cdddf0647f08@softathome.com>
Date: Tue, 17 Dec 2024 22:39:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] test: lib: add test for key derivation
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
 <20241217083212.70330-9-philippe.reynes@softathome.com>
 <CAEfUkULiQhQN1aRfZUVNaevwh61YapJ_3avhz0uaxiDw7djtAQ@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkULiQhQN1aRfZUVNaevwh61YapJ_3avhz0uaxiDw7djtAQ@mail.gmail.com>
X-ClientProxiedBy: PR0P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::19) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR1P264MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d11e6ec-02d1-4b5f-ce7d-08dd1ee3559d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlV2blR5cStITmZtMFdPNG9ITWkvaXIvbXRxZ09vL1gxZ1hxK0FqN0xGdjdG?=
 =?utf-8?B?WjVPNit6bTFaOEpQbWw1b2lDeTlvdlZiaUl5MUoxYXpUdnRjRVU1WUJEbTYy?=
 =?utf-8?B?aCtzL3dsYVFKL1NObzlmcDBkaUgrUkhrQWpqZ3UyN1Z4UHZLZjFIL0x3bjYw?=
 =?utf-8?B?a0MxbjV5Z0RFYklCd05BTkJXZHBHVVhMMm92aHdpam43bjdTKzlvOUt5ejAr?=
 =?utf-8?B?ckhDV2xjaHNNUzc3ZG1xLytuU1RKVmhEQjlrYk92MHg1TS9vSFV4Y2s2SUl0?=
 =?utf-8?B?Yk9nM0lGYS9obFhRSlVLQm5RdzdGZUtzOFQ3Y01wWEhrN2JzalhydjFTRit6?=
 =?utf-8?B?ZUo2MWJMS3JFdS94UlZFRVFLUXQ4ZzdiTDJEYUhqanB1c1V4b1YvWGh6TFNF?=
 =?utf-8?B?eXE4ZTRSNWUycmhmb1R3clZJYngyNHJSUm03RElxSWhxL2trbEtmMlVoa2cv?=
 =?utf-8?B?OE43MHBIaWpnRkovZDVHcFdqaFBmSi9Lc2poM2hrKzRPQnMzWEVmTXhqR0da?=
 =?utf-8?B?c3Ird2luMTEyZnAwL29FRm5tL0pxbkJJbG8yVm1xdUxLNjdFNWxBYWUrRG4v?=
 =?utf-8?B?dzdJdno5TkpyUWsxOUYrZVVTbjB2emxaOUpOSEdNUXI1aHpQNEVtMWxDN21k?=
 =?utf-8?B?SzVXYUVqTnRhOUhPNk1sRVZrSWlQNldpd2lkVkQ2N3dCRHNpa3JZU1lleTlY?=
 =?utf-8?B?TkhxNHhibkwzN1kzMmRweGtsWXR1djBFOEpNWjFtS0pyVnNwVjhCUW5FVkly?=
 =?utf-8?B?U0lneTlGY2FKZ2QwQktmRmdRaHU0WjlveEtrSGVSKzhHS2xEMXFnUnRLdDZK?=
 =?utf-8?B?TTFUSUhGUXI4a29nWThiUktVSHdRTzQ0ckpoMzByTC92RFJDQTJqN1FVTkZu?=
 =?utf-8?B?WWxXT0V3NEQ2aWxxOW9zSlFBR3JTK09VMUpYN0JGMk9rS0dVREdlSkhsMmJp?=
 =?utf-8?B?ZVJhaXJsd1B2NWlzSjZHdnFUMGZESkk4MFJ2czJaN2QxT1FSb3ROK2p1NjJY?=
 =?utf-8?B?YjZzQXRKSnNTUTJoaXhuR2RKQ3YwSHZDWmZsUzQ1U3FwQnoyWXlnMEtWc3ZN?=
 =?utf-8?B?dFc2QmNZL1NpaUZ6WkJlWTBOY2pxbTZHaE9GMlB5U20wSVFoSzl2b0pweEZQ?=
 =?utf-8?B?MUdNYnQzZ2hFZUZsc2V2eFFvYThScXBFZC9ZVG5aL0RFZG5MM1lVd0Vtck9O?=
 =?utf-8?B?a2hZZE1uZVRvak5ra0NJaVo4d0FDdTNDWmJBZ0RxL3ZHRy9Db2I5S2g2ME9J?=
 =?utf-8?B?SXFaZkFaMG1FUU02SGo3ZjlMbDNxaEVKTEVEUmxmbEVoTTJOQU9FdFl3ZEVv?=
 =?utf-8?B?VzR3eWFxU3ZkZmdGRGMyK25UYVhvSGhWUzlMY09OekFneW9tUXdGYUo2d2Jx?=
 =?utf-8?B?T0ZNTWJaMXJ1ZldnZzAzMUk4SmJtRENwelo0UlV1RHQ3VkN4THlQK3JxV0lk?=
 =?utf-8?B?bXloeGUvRFhrUDBPR2lRY2dRYkVLYko1dklaa2huM0hkakUrQzdDTEc3aWZm?=
 =?utf-8?B?eEtSMVJmcDdKc01QTWRuTmtmbVpEN3p0YVpvbGwrcXZSalhqR2Rmd0RNSUVO?=
 =?utf-8?B?Z3ROU2Z6WncrODQvcVVOYys4a0xjbzNZNzlSVHJ6SkVxa3NndUJ0Vit6OHJ5?=
 =?utf-8?B?S2JPNEwyamxsOXZuYXlxcmI1V0NTT2xiOVh6M0FDcTRhVDNka1AyZi9SRnBW?=
 =?utf-8?B?ZmpsODhBeFVVOHltOHBtTGpWT0tPK2xoMUVrVUFzbXhveXRaLzFnb1lSVE9X?=
 =?utf-8?B?aVgrd2NhTWZiQldwZzBkWkl3azJBdmdoMmNKcW9WRWxzL3Foem9mdlB4WE5m?=
 =?utf-8?B?YUdSOGZmQ2Y2TXhkZ1JXejNEUE02a1gxNkNZVXBMSUNBY3BIWFNnQzg4Q0JO?=
 =?utf-8?Q?jB6zVo1urx4kG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9QaE1YRFZDQ29DeVdua2tsUU9PS2hDR2JPYlA2dHBHSnB0bkhXazVRTTNr?=
 =?utf-8?B?S0Y4Zy9meHhGSHZGRnVEa1BsZEdGdzFJbmxIUUh1OVRWVjUrSDFuUE1XL1Bv?=
 =?utf-8?B?bk41UnN4aS85L0ZFcUhFWWRWVWtvNkhTUGVvU0poOHJFVFZwQzlJcUpCUVRo?=
 =?utf-8?B?c2RoMVB0d0RoenNTdnNDMFc5dkJmUDZRaVczZXJkdXhqVGwrMmcxRFhVTHor?=
 =?utf-8?B?VzFNTlNzdEhmeE4ybk9zWGxJM3JsdkU5NU5LbWxkM1JmT1hWVVNDTHFNaTgv?=
 =?utf-8?B?eWJUalFETkEydDRxMjRhdUl1T3V4bGQzdVNZS0E1aWNYamR4UnpkSkpUdDBW?=
 =?utf-8?B?RXJsSFlUQmgvOENtZUV4dW5hV0hqblk5OWVmQnJyKzVRTWdock15VW05RWpo?=
 =?utf-8?B?S0tIOFNpMXlPM0orNVBxTTdycENGdXVYc2ViTWZ3TUNPZTl6U3NOY0QxbWdu?=
 =?utf-8?B?YUVlVEo0bjVUOVdkdFM1QllqaFk3ZGFWYVJaZDRicXJzZjAxVjJNV3ZjZzNO?=
 =?utf-8?B?UFBEWS9mdEY2T2NjaGZZYUhOTXNZdEJVNmxtUDIyWnZ3cmU2ZFFxTHBPZHBh?=
 =?utf-8?B?ZG9qQjdzRDdURkorZUdiRkFXbXhYWVBtaUthRkM3QVhvWnpJSGk1UkZaTEVq?=
 =?utf-8?B?QUpMMGlSbWRnYml6UTI5M291UVFGZFM2MzZZTnZoVFRGZzVFcmIvb01vaFox?=
 =?utf-8?B?emFyL1F6NXdBRXNZMi85czIwQUlidHpySC9GeDd5MW9WVUNTUE8yYUY0Uy9y?=
 =?utf-8?B?eFJpb3oyU1FCWENLcVdiYUd3d05nUUg5aEM5OU5XcGc5bTA1Umk2ZXBKTVZW?=
 =?utf-8?B?azVoeGFieHV4K2R6eXJiNUNxZnFhUklEWXBYYnNoZ1YybTdyOStNWnVuMDl5?=
 =?utf-8?B?bWVJT0dzV05LbG4ycUxhZWxyQ2lId1hWUTRGRW5KMlZaTDdnUmxxZUZteUJB?=
 =?utf-8?B?M2tyaFBSenF6b1NHRCtvWnZMR01aanlma0VHTU1kUll5NVJBdE9zUmlzN0o4?=
 =?utf-8?B?bkdlaExMdkVObHRnWXZrSlcvTXpudDUyY2M2dUR6bWIydDlBQmE0UlNLZkd1?=
 =?utf-8?B?MC9oSUlYcHZZZU5lbEF2NUJxcUozaXY5Uko1L1Uvc2ZEYWorcHdJd2pMbU9x?=
 =?utf-8?B?NGs1UGg1aGZGYWV3NzdsUGxSNUs4N0t4bTIrclJoTWlxaDA3MDFDL3pWeHlL?=
 =?utf-8?B?bkFtTVZ3MW92YUh0bXA0MWg4MWxOM2Y5STVLMVVRYWlvSDBRZlB4L05KdGhO?=
 =?utf-8?B?aEkxQWVuRXdYZVZnejZOUWF5UnlsL0FsczlUMlU0WVo4bVhWUldycGtlSFIv?=
 =?utf-8?B?bDQ0MDAvTVZ2eDgyVzV6L1YxbXhIMjFoSzVnRzR5T1N6RHIxVGR3Rm9uQkY3?=
 =?utf-8?B?c1hMQnFjc3dsaVRoQWM3Ykh1Q3NiRkJjMlUyRy9URSs0bWRTbWx4K0V5OVVH?=
 =?utf-8?B?cGhLNGgxZDIxbGJwUEhEK28weU05WEVyNFhkTWM5UHlOTlY5NnRETjlJZmZm?=
 =?utf-8?B?S3JoT20ySFZkL0E1Wk1OSkxmOHdsOWwzRUhia3VCdGtjRWpjUlRRK0JYUUFw?=
 =?utf-8?B?Zk1FKzZhdlVuRHlKTFp1Y09nTGtzTUNmN21zUWFXc2dmdUJIMHNoczROdGR1?=
 =?utf-8?B?QnJMeTZMT0J0TFJUaG05RWRrQSs3S2o2aE8wTlBEZjl5cTdwZVlhdVYyZk9S?=
 =?utf-8?B?cFpvc3phelExbDdZUm54TGtnOEx0dEw0dWNXS2xLdGNNam0yRjJTbnNlbWt3?=
 =?utf-8?B?TVBzZ29Nd25FK29UaUkxb0dqbXI4eGlvQVhEalN3SHJaNGhoVHdrMUd5eDlt?=
 =?utf-8?B?TnRuZTVzVGluSE1tRVFiZ05TVFJNSWlVZjVqODlBUXc0eEN1dXRON2g2bVZ3?=
 =?utf-8?B?ZHBIMVpQdVEycmtnZHdRT3dMbU9IWDM4b21GdWlkcVplc2pvWmxvT1RIVnlY?=
 =?utf-8?B?eW0vVW90cEszTFRiYlRUeG1yeEZOM1lFSG9wcUwwT3VGLzhzM0gwakYzcHlu?=
 =?utf-8?B?TURKYTQwMURESDFWYm45ZjN0cFZPY3FKa2xpRU12VVYyRGhwcTJyc0hxcEVa?=
 =?utf-8?B?QXV3Y3NrN1J4bTNITHpEYlQwTWRMSEhMSndWYXNVL1dLcm1QZGtBaTJEVk4w?=
 =?utf-8?B?dDdOYVlXWkpzZUNnMXlWWGFNTHBleVd5b2h0eGRyMEtLci9aRTVCRUhDS3Y4?=
 =?utf-8?B?dUJpMVIzdmNJUUROVkJUR1NWSGhMd0oyQ2lQYzBGalFkV3BBaGpSZVFxblFn?=
 =?utf-8?Q?6dxpasPZwwmJ2wXiTHXyeVOgT4LL1P7qganfnH22dw=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d11e6ec-02d1-4b5f-ce7d-08dd1ee3559d
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:39:50.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efLnwcXAuyTIDNMuKtgio1lgb6ALF/lxcE9ZNFllboqzIIe+J2XgVwMF1OGQNqX5XXK5ikNpJAMUTuduiu39pea0S/2bdnNRSDRQLvVFkyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3445
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 17/12/2024 à 16:22, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Tue, 17 Dec 2024 at 03:32, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hkdf.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hkdf.c | 197
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 198 insertions(+)
>      create mode 100644 test/lib/test_sha256_hkdf.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index 4c0abcba81a..24ce6ed8f00 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -25,6 +25,7 @@ obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>      obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>     +obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hkdf.c b/test/lib/test_sha256_hkdf.c
>     new file mode 100644
>     index 00000000000..6d43ac32186
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hkdf.c
>     @@ -0,0 +1,197 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hkdf functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hkdf_s {
>     +       unsigned char *salt;
>     +       int saltlen;
>     +       unsigned char *ikm;
>     +       int ikmlen;
>     +       unsigned char *info;
>     +       int infolen;
>     +       unsigned char *expected;
>     +       int expectedlen;
>     +};
>     +
>     +/*
>     + * data comes from:
>     + * https://www.rfc-editor.org/rfc/rfc5869
>     <https://www.rfc-editor.org/rfc/rfc5869>
>     + */
>     +static unsigned char salt_test1[] = {
>     +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
>     +       0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
>     +
>     +static unsigned char ikm_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     0x0b, 0x0b
>     +};
>     +
>     +static unsigned char info_test1[] = {
>     +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9
>     +};
>     +
>     +static unsigned char expected_test1[] = {
>     +       0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
>     +       0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
>     +       0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
>     +       0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
>     +       0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
>     +       0x58, 0x65
>     +};
>     +
>     +static unsigned char salt_test2[] = {
>     +       0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
>     +       0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
>     +       0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
>     +       0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
>     +       0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
>     +       0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
>     +       0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
>     +       0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
>     +       0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
>     +       0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
>     +};
>     +
>     +static unsigned char ikm_test2[] = {
>     +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>     +       0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
>     +       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
>     +       0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
>     +       0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
>     +       0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
>     +       0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
>     +       0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
>     +       0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
>     +       0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
>     +};
>     +
>     +static unsigned char info_test2[] = {
>     +       0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
>     +       0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
>     +       0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
>     +       0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
>     +       0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
>     +       0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
>     +       0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
>     +       0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
>     +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
>     +       0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
>     +};
>     +
>     +static unsigned char expected_test2[] = {
>     +       0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1,
>     +       0xc8, 0xe7, 0xf7, 0x8c, 0x59, 0x6a, 0x49, 0x34,
>     +       0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
>     +       0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c,
>     +       0x59, 0x04, 0x5a, 0x99, 0xca, 0xc7, 0x82, 0x72,
>     +       0x71, 0xcb, 0x41, 0xc6, 0x5e, 0x59, 0x0e, 0x09,
>     +       0xda, 0x32, 0x75, 0x60, 0x0c, 0x2f, 0x09, 0xb8,
>     +       0x36, 0x77, 0x93, 0xa9, 0xac, 0xa3, 0xdb, 0x71,
>     +       0xcc, 0x30, 0xc5, 0x81, 0x79, 0xec, 0x3e, 0x87,
>     +       0xc1, 0x4c, 0x01, 0xd5, 0xc1, 0xf3, 0x43, 0x4f,
>     +       0x1d, 0x87,
>     +};
>     +
>     +static unsigned char salt_test3[] = {
>     +};
>     +
>     +static unsigned char ikm_test3[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +};
>     +
>     +static unsigned char info_test3[] = {
>     +};
>     +
>     +static unsigned char expected_test3[] = {
>     +       0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f,
>     +       0x71, 0x5f, 0x80, 0x2a, 0x06, 0x3c, 0x5a, 0x31,
>     +       0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1, 0x87, 0x9e,
>     +       0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d,
>     +       0x9d, 0x20, 0x13, 0x95, 0xfa, 0xa4, 0xb6, 0x1a,
>     +       0x96, 0xc8,
>     +};
>     +
>     +static struct test_sha256_hkdf_s test_sha256_hkdf[] = {
>     +       {
>     +               .salt = salt_test1,
>     +               .saltlen = sizeof(salt_test1),
>     +               .ikm = ikm_test1,
>     +               .ikmlen = sizeof(ikm_test1),
>     +               .info = info_test1,
>     +               .infolen = sizeof(info_test1),
>     +               .expected = expected_test1,
>     +               .expectedlen = sizeof(expected_test1),
>     +       },
>     +       {
>     +               .salt = salt_test2,
>     +               .saltlen = sizeof(salt_test2),
>     +               .ikm = ikm_test2,
>     +               .ikmlen = sizeof(ikm_test2),
>     +               .info = info_test2,
>     +               .infolen = sizeof(info_test2),
>     +               .expected = expected_test2,
>     +               .expectedlen = sizeof(expected_test2),
>     +       },
>     +       {
>     +               .salt = salt_test3,
>     +               .saltlen = sizeof(salt_test3),
>     +               .ikm = ikm_test3,
>     +               .ikmlen = sizeof(ikm_test3),
>     +               .info = info_test3,
>     +               .infolen = sizeof(info_test3),
>     +               .expected = expected_test3,
>     +               .expectedlen = sizeof(expected_test3),
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
>     +                                    unsigned char *salt, int saltlen,
>     +                                    unsigned char *ikm, int ikmlen,
>     +                                    unsigned char *info, int infolen,
>     +                                    unsigned char *expected, int
>     expectedlen)
>
>
> Should use 'const unsigned char *', and same for the structure 
> 'test_sha256_hkdf_s'.


Ok, I have added a const for all data.


>     +{
>     +       unsigned char output[256];
>     +       int ret;
>     +
>     +       ut_assert(expectedlen <= sizeof(output));
>     +       ret = sha256_hkdf(salt, saltlen, ikm, ikmlen, info,
>     infolen, output, expectedlen);
>     +       ut_assert(!ret);
>     +       ut_asserteq_mem(expected, output, expectedlen);
>     +
>     +       return 0;
>     +}
>     +
>     +static int lib_test_sha256_hkdf_run(struct unit_test_state *uts,
>     +                                   struct test_sha256_hkdf_s *test)
>     +{
>     +       return _lib_test_sha256_hkdf_run(uts, test->salt,
>     test->saltlen,
>     +                                        test->ikm, test->ikmlen,
>     +                                        test->info, test->infolen,
>     + test->expected, test->expectedlen);
>     +}
>     +
>     +static int lib_test_sha256_hkdf(struct unit_test_state *uts)
>     +{
>     +       int i, ret = 0;
>     +
>     +       for (i = 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
>     +               ret = lib_test_sha256_hkdf_run(uts,
>     &test_sha256_hkdf[i]);
>     +               if (ret)
>     +                       return ret;
>     +       }
>     +
>     +       return 0;
>     +}
>     +
>     +LIB_TEST(lib_test_sha256_hkdf, 0);
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


Regards,

Philippe

