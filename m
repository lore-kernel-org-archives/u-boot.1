Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29CBC5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 04:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E239407C3;
	Tue, 18 Aug 2026 04:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7ikegmhNRpN; Tue, 18 Aug 2026 04:04:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81A904077E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787025893;
	bh=eclOGQxZ6gSdBjUJoM61oYDNHE/hXhaQ8UfVx63dSSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xjXLfuWHRN6M0b6esMHYnNfPCiGwvspMPiFuuzneaHgXpqgZZulSKM2X/fORJA8q9
	 7c8U6wu+aznix0/OP39cJ2CT3I8sakIi39yoU/3RbjBl5qzvZr7Mp7RMHMxlS6JjBx
	 Drjcp9ZA38cVhOc8ACIyAsefobXtkvjITA65xyVNas3w0GAeCUVtTGt7uYS2HVyuws
	 Cn9letnSm81DwJlKoDFRrG7Mi8M9Wo71Kpn4ggdAw4tKwwDeU8z0Kx8+rqCNQvX4TF
	 Wn1DsrBoznwHEUW/BDaCwcYV2k2aLDU27zyMu/88rtCtXvIkEwzLUp/9Qmi8yfu0w/
	 VUtmbvcI3IdGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81A904077E;
	Tue, 18 Aug 2026 04:04:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2A20322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 04:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4AAF6066C
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 04:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQmafz7Rfkil for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 04:04:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CE09F60652
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE09F60652
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=W9nlQry4
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE09F60652
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 04:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmUkg0EjoK4R+ZdFEON6i9gsDvEC5BEh9oZEoNd08z7znOB84wvdtRHJVLhDy66dPIgo3Z1ZG3Y3oBdRNx201y1AQHKvJQBPA8ZoM0B21K8dBjBg1M7W/ALeuwILaxoFFyPSl+ouUSTM7fffQhdqz/irVuPQtGW5qChFXCaDhYxTVIENmgmTtKvCTb556k3WsrqSDRLO0Tt3KBdSxEeLQvYclXidYQ8zjieRw743vFqxxiGZeRSUzBVkJMQKD/adw9Zv+gkyL9W2CgzGvrTNMWZvvBWgWUVx/KxHt9E4MF8mz+Se9dMsVLSD8iazBsueq9RUw56bgOjDozPmPtQAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eclOGQxZ6gSdBjUJoM61oYDNHE/hXhaQ8UfVx63dSSM=;
 b=Eu4CBRzZ5pD4RTByXqdPwMMp/gog4yRoX6ccAcMYUxWUgpmCSEEcnSmR4YldVFBDU6HvDCstVqafEluoqdO/8H5Ky/DuJXzCKXPuHRkm2CXHk2rrblAJL0dpd+80IqRpw3Dlm5ss8//cUquLgCmQSc9TDfBS776MBPYrDcCTabt2d/VBPwhHTaUiEo09J30UNTHtolfAk89nHQoWU4Ru5LIN8OgYo8gKC2BpgilBg78xg8nFpOfNkTOFEFDJYqxo4BKrsW6ds2/6IYEWExaJLrbxlZK48fVVJFEiB2EuMUY0YM2UjvsionKkYDaK4AdAJc/rT2f6yXWbSSwTNEdyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eclOGQxZ6gSdBjUJoM61oYDNHE/hXhaQ8UfVx63dSSM=;
 b=W9nlQry4JReCfwhDBVPDQVccCnK8hM5di9kTRF5uGbUwLoOdhPOngIFNfprZA+95eOeU9s1mWb9kx9gcDBsUHz011+yEmRk+KfYQGje8vX8AL0dZSh7Xxb/WE8Ljxr/iFgrK7d6bje7ao4F90kZvt1tU8ueaCPdDX+Dj15YXDDPWOW7s0WAjhwOAagF2cc9xqLiHjEWFpXoLXV1COM9WNEVNlpdSGmFWlIkA8bYV7uPuIjon/K+wnZVPDGMakOjA64Be7WPb8b1A/87K0I3nfy11SnGZSkXpW1c6wtP7MvVq2pZshnW0BaW4OSk1m0rmpnyrxs1338AAJquY7iE+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by SA3PR03MB7233.namprd03.prod.outlook.com (2603:10b6:806:2f5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 04:04:46 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%7]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 04:04:46 +0000
Message-ID: <e29102bb-10bd-48d7-ad6b-24fa5d430ebb@altera.com>
Date: Tue, 18 Aug 2026 12:04:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, Brian Sune <briansune@gmail.com>,
 Tze Yee Ng <tzeyee.ng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
 <20260817182735.GQ3297518@bill-the-cat>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260817182735.GQ3297518@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|SA3PR03MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a030872-7acd-4560-d476-08defcddd721
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|55112099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5r48fbMnALg4r8QtF4HXmNlt0XYAVekjwHMIr3OzHeKVmE+5QoQWDISOv713+UFb26xnnWNSWFNIx7OQer5AzkrQFWO3lissTWb0+SOlDe9kdcuOcjApPHItTWBs9IxJIQuibyKEQnnxahRhd5IF+FdxbT2PqFtRB8x/b4HGcnnYibwULrMlIvllANzNkSD/YVoV48Sq5Zrrj6yJM2g4E8iw4L1X4QHyUNuCmimxgdIiMcp0ty4Tt+hJFajcjoa6Dpa2PwJRcWQCu45VOhiVgrUTi24+A5T7sLPrqSb+SfbqZJ6IkdJzzzFMsiQxgFqYC0qbr6c6hD5Dd+rq4z/csi+QkixuvKuhDpk55KLyM5yJLsj647koHAiCiq5Sg3IKQZwNmPHUFlfKmBLhJF0TALLJ5ppQOb0bYIK+b7IoT6/9v+aTrOneGkDDm/5r4o5QvDFPCghoqYzcKc467bKao4eDyUvTfri/3Gapj0CnXA1EQs4LxE+K6d1I1va5jmyJn5gtDqC+UqNdJM4NQXvDeEQqRgL5i+hCoRkcWWEoustWBQX8tlJ4r+fFG4faMA8d1s3uu4hSpViXPT7SFV9GttFL9LKuo2268+dfPlUxPrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnMrejNTRFJ4UWhybEZSdDlJUExsaFFVZTFSclpLRGtCeEZaejg5dml2ZXVm?=
 =?utf-8?B?SWdqMEZBOHNKMkZOeXpGdUNtZ0pSWjU1em9HT0hQR2NCeGtvOGcxODU5UG9J?=
 =?utf-8?B?Qk9nYSs5clo1TXlyRVR2Vi9CSzZobGd3UmVhS3hIZWFhbisxd0hyS2w1V0cr?=
 =?utf-8?B?RmpwVFpBbVZQZVlxanV4QVpYZGF3bDVoRkIzdXhNTW1Rd1pVSGthN0xsMWVN?=
 =?utf-8?B?L2xlOUcyTEJxZytnT0w0WFdMUExzMndmVDRNOGs5VGpycmE2MGJOWDMwakQz?=
 =?utf-8?B?S0swbmhIU1RMTE5udkxnU1NSZW0xOUNoZ0hjQk9WUjltZThEYlU2U2d5aVNP?=
 =?utf-8?B?MEZHM29aY2JpcFA4L250Z0xka3dUc2pXTWlXV1c4R2hQSk01VVZId1J5bE96?=
 =?utf-8?B?bGpjNTRTcjg3OXBlN0xSb1p5Rlh2aEI1YnE2cjVVb0pNQVd6a0Nob2h3Vndk?=
 =?utf-8?B?RWFGTHpybERFcU40MVBTVGxQcTRrcU9IUTFaOW40bldkeUVmZVhTY2oyVlRE?=
 =?utf-8?B?alB3TDZLKzhSUDg4cHNkZnI5Mjg3NzNmYXdka3k4OFZMK2RqeERVS0hjU1ZH?=
 =?utf-8?B?d3VtWmx1dlozQVNzbFRvRkM2RGhtWmJ6Y3I5NWxWbldDcFBUYnI2REd3TjZL?=
 =?utf-8?B?bkRGbnVFOG9jcml0dVpMWEt6T0k3anB6em1HK3ZSWlJJYlJsRktKRzlOVHNG?=
 =?utf-8?B?UC9jdVoyYXQ3R2p2K2NPcUZDY1Y4MXNKZy9tOFNyNkZrczdZdmYxTnJsYm1p?=
 =?utf-8?B?VjFYektrZ3g1cWhybGpnK3NtYlV5c1BYYVYrMFdKVGxha1VYQ0dKOUxxNDY1?=
 =?utf-8?B?TmgrQW9aTlRPWG1wSVpweFdXaThmeVFyOGZYbEd1SnRPUU1jbXdzSTlpN2NO?=
 =?utf-8?B?a1AyWmZodzc0NFdJb2hjQnRmaUUrR3JSOUlxaVVzTVl6Um0rRXlWeExpQkpB?=
 =?utf-8?B?WHNQQjgvWUpRMk41am83SFpUMFl3RW5odXdnVHEyV1g2c0FkL0VDSm9jZlNs?=
 =?utf-8?B?L21hdzd5VXBXcFFGWGErYndia28zMEtoRkt3K3k5dEZua0Vrc1MvU29iM1Zy?=
 =?utf-8?B?bWlOSFpyQUZVY2RqOS82b1Jpa0VrZ0JrSVZGOXBOS09QMHROdWNIREJZcmZx?=
 =?utf-8?B?alE3UU5ueisxc0s2cG95RlZqYkVWRWdmZElUY2hsRmRBODBPUXhDcjJSTCty?=
 =?utf-8?B?Nk5lMEFtenBYZndlQlBNUTQxWnF0OElWOTVvaG1hYy9nZDcxT3hiaHk4L2xY?=
 =?utf-8?B?dy94Y1ZiZVJYalhVdzlOS0tWY3B6WlR4bGV4c21mN0FWTE9BSlBLeWI2aytZ?=
 =?utf-8?B?MUJ0NHp3eC80NTN1Sko1dUQxRFBaK1NyT3hrWmg1VXRURTEzaTM3V2pJMnFl?=
 =?utf-8?B?bkFaOE54L2FtcTZHTWFlTmRuT2w0aXZjajU5UzNFSEliNkc0YlpteHoybUpP?=
 =?utf-8?B?SUdHT01sRVh5dU5rS25zU0poc0RsbVlmbWd5VmhaV0tiRithMmZnc1NhMU5v?=
 =?utf-8?B?VEJnOGdaZnBmb2I3cEcwR282cHU3VEJhRHNuT2hjZnMzN1NJZEduMkVjTmJC?=
 =?utf-8?B?MHlLaVEvK0h2RUJ6Y2NPN1FUUkYwUm9BVmdMK2xSeGN0cVdXVSswUjBFNkpy?=
 =?utf-8?B?SHhlZTYrOWRTTGcxQ0EySnhaZ05iZ01PWStDemRGZUJqY0lCbjlzZ0E4SVZs?=
 =?utf-8?B?SXdIZ21lcXFvRWNYczdlKzJ5dGZtb2toYXRtUDVGVzNENzBWOVBQSzdyV0Ra?=
 =?utf-8?B?YmlGeE1FSHQvZ3hJSGkrSTQ2RTFvc2wzLytsVTk3dnlpb1krZ1RTTzArOE1a?=
 =?utf-8?B?S21DcVVTWFFTN1ptbDBpY2FQTXZ3a3NtSStpaGRyK3VlZmg1eEhlcnN4T2RV?=
 =?utf-8?B?THdPRW5uV21VWWhvd2c5bkpxT1NEa0JHSmpNQXVUZlY4dVdaZEV3VmE2SkpG?=
 =?utf-8?B?SkpwRHRkMis3dDFGeW1DeG1HaDEreDNlT2F1TTNVQ1NFUnNwcTJxRE1ycGMv?=
 =?utf-8?B?WllpNHlnK1dCMFN3bS9HWjcrcnY4aDQ3VW5LVGVMWWNGRHNiK1ZzVzhWaWlO?=
 =?utf-8?B?NVYxTDJGVEhsZk9UMmVsYzFRNW1FUlAvQ3JaL3NVaDhWSkkyYTAzQ0pPVkQ0?=
 =?utf-8?B?YktKQ2kzd1JrY2lBVW1FZ29pMk90dkV4Q0xUcy8zN2NnNy9VT0NMT2xtSitx?=
 =?utf-8?B?cVlyZnA2d0luMUt1VTlkaDVDUjIxN3pQbnVIUjV3akRjZXdDYlppdUJyc01G?=
 =?utf-8?B?dHprS2YyTjlCN3FycjBBWExSR0hCSEdvbWpPaXN2RFVwY09jSkpqNmxMd1Na?=
 =?utf-8?B?T1pjNTloYUZNa2xmY1lUZ2JneXJibHhpalNmOEFJVFRFV0lDWlhHamlWTE5H?=
 =?utf-8?Q?Y79+bTIpEknibqLs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a030872-7acd-4560-d476-08defcddd721
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 04:04:46.3265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXiqQNlGUllFuljwBpEH4LE0OOLYHGSrEuCl31fdgWMqOZ2hEFhggGzXW7RgZThOPtlTSEz7c7FKCO55rbnFvp880GwVV62PxQoMnVAocXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7233
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

On 18/8/2026 2:27 am, Tom Rini wrote:
> On Mon, Aug 17, 2026 at 11:29:50AM +0800, Chee, Tien Fong wrote:
>> Hi Tom,
>>
>> Please pull the following SoCFPGA updates for next.
>>
>> The following changes since commit 527115ef6783cec49e5610c523c124b399011361:
>>
>>    pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026-08-13
>> 10:12:41 -0600)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
>> tags/u-boot-socfpga-next-20260817
> Can you please put this on git.u-boot-project.org? The denx gitlab is
> unresponsive at this point for me, thanks.


Could you please approve my access/login for git.u-boot-project.org?

I need access to help publish/pull the SoCFPGA updates, and I'm 
currently unable to proceed.

Thanks,

Tien Fong

