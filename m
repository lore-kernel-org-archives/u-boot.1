Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0567E10F9308
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 22:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438AE83F5B;
	Wed,  1 Apr 2026 00:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HESjPFYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACFF84010; Wed,  1 Apr 2026 00:55:08 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazhn150110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d905::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDE383CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 00:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/yQuRGrSQZc+3mE3vO4IhLroxKqvVJanT6dlZ17zaul+mDlbtwnDnMd+hOqNdahsB20KN8xELLMcyEOXTzrJn10Cu/H7MRjEUwt6rCXPEMy2gxgSAT09YktKchIrfeSHZSW0MkdG0/jbphyfhXTXohM4dzIi/uRVbZ+9C/bmUhO9QMoYxljk8i/am8zNtZUnYU5mls77wzEHVXuih5RNbKg7H6NoOk3WWRK/G8UaOBYs4SHOB3rIoJd9aH2mjNuMyCmprnsAPHKJWzrisqiJYXTnZEJqq8sQQXCBsRudV2c2AGxRx+PvfsZmTea1shueFMS8ZLr/KcKjIzmEWT8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sjATUeo1Kx9FbeKPMLAPWdGzjP46n9AWmjMo3T2NBA=;
 b=nVRN1sXPooA4XDvLTLRxI65Mj/uDfce+EHBX7sWOPOah38jyihODP/4k6kVyCbpIuw6RS1Kc6x8KZ2CVlCBkXHIA80ZI4IL+lxd+1fWBZ35hKy/KS+fULB9qXKAO/tqogYGv+yBOtdQcJnivri+qsZaMYvFiqRIxlQkqJbzxVPIef3Lk/6TkbZcKZN6xUXAzVphKEYc9ql3O0PNd8pCg/rnJ2WKlHbDk/le77+NgatAMazro4cEG/K7mqNsMn460KY+epUiQLsAP9SEe/knDnOuGqLZaGzWQQAlWCqv7kPYnbjPK12XanCAIcmGhHf7RE4jcJC+EvErzNuV0aZYudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sjATUeo1Kx9FbeKPMLAPWdGzjP46n9AWmjMo3T2NBA=;
 b=HESjPFYc0dFWeuWHXJ/L/Co7QW7MCEPVlk1hhADQZBBirVeMboHj+uNQusXey+LCHSo4OQ64KLZuxBc0mpPeKcvuph3TPJU2NCD51WJmiEDll+TkvjwSTzjXwM0DfrylYs9Qs32ZZJ23HDdsbCaYRSyOWOIJHMDrKKvCkA5lXqw=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 22:55:02 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::50) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 22:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 22:55:01 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 17:55:00 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 17:55:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 17:55:00 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62VMsxvv3591603;
 Tue, 31 Mar 2026 17:54:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Mar 2026 17:54:59 -0500
Message-ID: <DHHC66BBMD27.YHGIH43C6XBK@ti.com>
CC: Erik Welsh <Erik.Welsh@octavosystems.com>, Anshul Dalal <anshuld@ti.com>, 
 <bb@ti.com>, <nm@ti.com>, <trini@konsulko.com>, <afd@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
From: Randolph Sapp <rs@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Randolph Sapp <rs@ti.com>, "Ayush
 Singh" <ayush@beagleboard.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com> <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <DHGIV5UK2POR.T98MMILTXQWC@ti.com>
 <CAOCHtYjF2f2UNbwC=ph2GSWZ6ZKWZKiAAXqXOM2RmrGrarRBxA@mail.gmail.com>
In-Reply-To: <CAOCHtYjF2f2UNbwC=ph2GSWZ6ZKWZKiAAXqXOM2RmrGrarRBxA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA3PR10MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f84359-b7dd-44ef-6818-08de8f788a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzRRNGhaZGRUSXVyUXFkS09EZkdBVGt0UFExaWpXVGZ6SlYwbUUyejJWYWxT?=
 =?utf-8?B?ajJFclEzQi9RVEVHdUVvd2lVUTd2eUdUeWVNVHZtMkUvODh2OXlnU1hHNkNN?=
 =?utf-8?B?MU5SNk40SWx2eTJLZ0I4RGRWcDVEKzFxTlJTaUE4NFhoUFdNdHFFeUVMYzlO?=
 =?utf-8?B?SitJbjd3VlhpcFJUWGdMZFgrWnkrYjRjM1ZEQVhnU3psUnVJVWs2Ly9qcjRF?=
 =?utf-8?B?QXdZRU9BZjRlbGZhdVUzZTdhNkZzYVZ5SVc5VGVTWENOdEpBOTFwM0xpZVlC?=
 =?utf-8?B?T1VQOE9EaWlyWWx2b3RrUzRaaVlIWnIvcUF6eEVZc2tQZDJrUXRwaGllYU9q?=
 =?utf-8?B?dnJVRnp1dnUyNzZUb1VnRUVGL2J6WVdMTGNUN1loUXhkakF5Z3J3MGpIR3ZL?=
 =?utf-8?B?dkdSZ0F6M213aXJoUVZwK3F5K1dxNnRlM1F2TDloNjE5dEtlMTROT0x5TWtT?=
 =?utf-8?B?TFlSTHhPSjhEVFE0YXVRbDJzcUpFelFnYnlEVzB3a20zRjMwT29seG5KVjNk?=
 =?utf-8?B?cFlZd2Y0eEZiSm5jYWxVbmFOM3FXOVMyeWY0ZVZpU2tOeXRhcmUwRGlFL1pm?=
 =?utf-8?B?Y2RHZS9lOWxuYUY5aUFCVzYyOWVvNlF4TUFTdnpyV0dXMzlONnNqU29UMWxC?=
 =?utf-8?B?NUYzU2o4cWRZR1JGZlIwUUVLRmVoTitBZm00K2JxdHA0YXFzWnc4UGgrOE03?=
 =?utf-8?B?VGwxV1E2eUV1SEJDVjBINVJJb1UxT0Y1SXpzc000NGhKWkJkazVhZTdsZ1lp?=
 =?utf-8?B?RE1vdHRiQ2s5YTMzRW4zSWVwT3QyaGtKM3UyZzRlYkVYWTI2Q1c4c01NS2J0?=
 =?utf-8?B?SjljSnJlaUxkQnd0Nk9pREJDOE42UHZoZFMxWXp2ZWs4L1BIQVU4ZGt5SDFM?=
 =?utf-8?B?R1VUZjk2MFBSSnErZTBMLzFoaGlzWTFVaFZ4YnlySDVLczNtaCsydjI5ZDFp?=
 =?utf-8?B?R0JiZzJCL1JRb0d2aUlBM3h4S21hYytndk1ZdVVrUnJHN0xIUlNhM0hPakNR?=
 =?utf-8?B?NmRkNG9zVmpmTTdIdTNHb0x5Qkx0NWhmMFRJRnhwNmZOTnBtNnhZSW52RjB4?=
 =?utf-8?B?cG52aWs4d0NYdWR5ZUNhTXIzaUZvaXk5NjFaQmZCTGxoaVgvUERpMTUwZXc2?=
 =?utf-8?B?cGd5eldjZmFTendXeWFERUJKelBiRnQ5NWd2bUlYZkl6b251Und3NE5Tbm5O?=
 =?utf-8?B?cnFrV1J1ZmVFN28xQlJMTDZmbFZFNm9QTVl0alJ2L0t2MWF5MDJhUEdLejNT?=
 =?utf-8?B?V0dCalRrSFcxOHZXa3k3QjF4cjVXdlhpVUZXUnpUZkhaQ2NSMEN0RklQUDR1?=
 =?utf-8?B?TUpSMFhQSHpuT1k5eGhZT0ZoNHBtS3NsdFR2d003NDR0Ym1uTHg5SXVLS2hG?=
 =?utf-8?B?TU9uVnpZNzhQMExBL1NkSlI5ejgwbExSSXpDUjJlcG9hYVNwVE9Fem9CZVcy?=
 =?utf-8?B?Z0dqZnBXankrZlZMWTZrK3Btck44WVU5Q3RWYnlrTTlRT212OFpJNDJINXBJ?=
 =?utf-8?B?SWJxbDQzLzY2WDUvZk10M2RhQy9ieDNPVWx1bks0VmswR21MOHV5VFhqRkln?=
 =?utf-8?B?WHFxaVpSeGF4cHNVN1FBaE9sMXlMdWVGb1RlUDkvMlJVNFp1Y0pTOVk2cnJJ?=
 =?utf-8?B?emVFalhCUURTamZKQlkzcC8rSnpXQUEyTklzd3FucGxlNW1BV0VVZksvME1k?=
 =?utf-8?B?Ujl6cFB4NFBiOTlWMUJZMS9SZ1VTSWt2RlRTZVhuUHVlQ0FyYzBPMWFBNjhW?=
 =?utf-8?B?UWRXbVpiOHRsUzJrRW5SNnkyN3BmaHZQNVlXNGVtOWZDamdmTEVtRDE1ZDY0?=
 =?utf-8?Q?c/nJsqYbQcYBvya72WIxpKwo0IVFXB9lfin48=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:9; SRV:;
 IPV:NLI; SFV:SPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent; CAT:OSPM;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VW2eGiQb4wZm4CBS+12RzOAI1VsNARErNAb/4UMQWN3C2FeuzJ89aHmUOda2bJsw+2fUtN0fVvhkT/z8WfSZJaalmPEKfol9HNdrMWfsfSQStnINvSQTVRNiUV8rXGqyUdTVMoKb6iDFPWFS5XFv4UD/xBFHLLShWFYvY6fcj6BmW/ME8XWQtBPKmMbUOslV40s64odmL8pLmBC3qmWwJOG3Sxo2ZSPLQRLhofLn9rncGIPHIPxRpq8pWDEktGJk2uvAf4DH4lVkKsF7NI3J5eniC3XtVFbfH7kbC0AVeXr8ShSIWqO+J03J5VAvAddUUbTmLhzLXikuGDQgvHTFIN3A1v9lqYZXEBmv7VonoItB0j3oF3o0dOo+zX3WNo0/PhnhsRrtRaEdZZwBkFcusWlrSzZQmDrHIpw1OxDEhhUWrty3eBkD4oNTiP+/sKQfNr0WOXfMxE6LhYFdPm4ZxdwTG63jMaz/E2mN8zo17381GeRId9iyIYRu5voc0GXCE0bGcu4r+DXoObXLQqfaZ/HSoKWrj5RU3zqVGikTPKCInYQGPcFSHuw4PFndzUVyBAryrJEQNvahIjKLVZ9mgA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 22:55:01.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f84359-b7dd-44ef-6818-08de8f788a81
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
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

On Tue Mar 31, 2026 at 11:13 AM CDT, Robert Nelson wrote:
> adding @Ayush Singh   too...
>
> On Mon, Mar 30, 2026 at 6:57=E2=80=AFPM Randolph Sapp <rs@ti.com> wrote:
>>
>> On Thu Mar 26, 2026 at 6:23 PM CDT, Randolph Sapp wrote:
>> > On Wed Mar 25, 2026 at 7:34 PM CDT, Randolph Sapp wrote:
>> >> On Mon Mar 23, 2026 at 2:46 PM CDT, Robert Nelson wrote:
>> >>> On Mon, Mar 23, 2026 at 2:37=E2=80=AFPM Randolph Sapp <rs@ti.com> wr=
ote:
>> >>>> On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
>> >>>> >> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
>> >>>> >> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>> >>>> >> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>> >>>> >> >  CONFIG_NR_DRAM_BANKS=3D1
>> >>>> >> >  CONFIG_SOC_K3_AM625=3Dy
>> >> [snip]
>> >>>> >> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
>> >>>> >> >  CONFIG_EXT4_WRITE=3Dy
>> >>>> >> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>> >>>> >> >  CONFIG_LZO=3Dy
>> >>>> >> > -CONFIG_EFI_SET_TIME=3Dy
>> >>>> >> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
>> >>>> >>
>> >>>> >> Any reason why we are using TOP_HIDE here instead of just moving=
 OPTEE
>> >>>> >> lower in DDR like we do on the 512MiB AM6254atl EVM?
>> >>>> >
>> >>>> > Sorry, that is now a legacy setting before OPTEE finally got move=
d in
>> >>>> > v2026.01, as this had been developed thru v2025 u-boot releases..
>> >>>> >
>> >>>>
>> >>>> Well, it's worth noting that this change was not done in the usual =
way, and
>> >>>> involves user interaction during the build beyond selecting a defco=
nfig.
>> >>>>
>> >>>> https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-=
linux-AM62X/esd/docs/master/linux/Foundational_Components_ATF.html
>> >>>> https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf=
/machine/am62xxsip-evm.conf
>> >>>>
>> >>>> Robert, are you alright with me making the requested changes?
>> >>>
>> >>> I guess as long as we document it. I know the Octavo OSD62-sip @Erik
>> >>> Welsh  will also be building on both am62xxsip and pocketbeagle2 bas=
ed
>> >>> on the 512MB and then larger memory sizes (1G, 2G, etc.).
>> >>>
>> >>> Regards,
>> >>
>> >> Oh boy, adjusting the memory maps kept getting me out of memory error=
s in the
>> >> EFI flow that I knew should not be true. Found something fun: LMB res=
erved
>> >> memory regions do not match EFI reserved memory regions. EFI's
>> >> efi_carve_out_dt_rsv is setting regions to be more strict that LMB's =
base
>> >> requirements. When this occurs and an allocation runs into this discr=
epancy,
>> >> that allocation and all future allocation requests in the EFI flow wi=
ll begin to
>> >> fail as they are repeatedly given the same LMB start address in the u=
napproved
>> >> region.
>> >>
>> >> Randolph
>> >
>> > Alright, looking into the allocation helpers it seems that
>> > EFI_CONVENTIONAL_MEMORY can be remapped in efi_allocate_pages so long =
as LMB
>> > agrees that it's free. This aligns with my understanding of the UEFI s=
pec as
>> > well. I dumped the EFI memory map and noticed there were 2 fragmented =
sections
>> > of EFI_CONVENTIONAL_MEMORY that it could still use.
>> >
>> > Wired up efi_allocate_pages to go to those regions and attempt to allo=
cate from
>> > there in the even an LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ANY start fail=
ing. Seems
>> > to have worked, but now I'm seeing the following reported in the kerne=
l:
>> >
>> > [    0.048167] [Firmware Bug]: Unable to handle paging request in EFI =
runtime service
>> > [    0.048246] ------------[ cut here ]------------
>> > [    0.048249] WARNING: CPU: 0 PID: 1 at /usr/src/kernel/drivers/firmw=
are/efi/runtime-wrappers.c:341 __efi_queue_work+0xd4/0x108
>> > [    0.048270] Modules linked in:
>> > [    0.048285] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        =
  I         6.18.13-ti-00636-g30182cf3ac7d-dirty #1 PREEMPT
>> > [    0.048296] Tainted: [I]=3DFIRMWARE_WORKAROUND
>> > [    0.048299] Hardware name: beagle BeagleBoard.org PocketBeagle2/Bea=
gleBoard.org PocketBeagle2, BIOS 2026.04-rc5-00003-gf1dace477fb8-dirty 04/0=
1/2026
>> > [    0.048305] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
>> > [    0.048312] pc : __efi_queue_work+0xd4/0x108
>> > [    0.048318] lr : __efi_queue_work+0xc0/0x108
>> > [    0.048323] sp : ffff80008003bc80
>> > [    0.048326] x29: ffff80008003bc80 x28: ffffad05b176bad4 x27: ffffad=
05b16b00ac
>> > [    0.048336] x26: ffffad05b1622e60 x25: ffffad05b1953000 x24: ffffad=
05b1749050
>> > [    0.048345] x23: 0000000000000004 x22: ffff80008003bd1e x21: ffff80=
008003bd20
>> > [    0.048353] x20: ffff80008003bd28 x19: ffffad05b19cd5d8 x18: ffffff=
fffffe2f20
>> > [    0.048362] x17: 0000000000007000 x16: ffff000001c065a0 x15: 000000=
0000000000
>> > [    0.048370] x14: 000000000000008a x13: ffff000001cf8090 x12: 000000=
0000000001
>> > [    0.048379] x11: 00000000000000c0 x10: 00000000000009f0 x9 : ffff80=
008003bad0
>> > [    0.048387] x8 : ffff000001cf8a50 x7 : 0000000000000001 x6 : 000000=
0000000001
>> > [    0.048395] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000=
0000000001
>> > [    0.048403] x2 : 0000000000000000 x1 : 8000000000000015 x0 : 800000=
0000000015
>> > [    0.048413] Call trace:
>> > [    0.048417]  __efi_queue_work+0xd4/0x108 (P)
>> > [    0.048426]  virt_efi_get_next_variable+0x5c/0xac
>> > [    0.048434]  efisubsys_init+0x148/0x390
>> > [    0.048444]  do_one_initcall+0x60/0x1d4
>> > [    0.048457]  kernel_init_freeable+0x248/0x2c4
>> > [    0.048468]  kernel_init+0x20/0x140
>> > [    0.048478]  ret_from_fork+0x10/0x20
>> > [    0.048489] ---[ end trace 0000000000000000 ]---
>> >
>> > U-boot itself doesn't report any errors, so I want to assume this is p=
robably a
>> > configuration issue regarding something else I've forgotten to add.
>> >
>> > Anyone got any quick/obvious comments before I start digging through m=
ore of
>> > that? Was my assumption about EFI_CONVENTIONAL_MEMORY incorrect? Is th=
is, as
>> > unlikely as I think it is, actually just a known issue right now?
>>
>> Ugh, that took longer than it should have. Alright, what I did would hav=
e been
>> correct if there weren't a few issues with other things. Primarily, this=
 memory
>> map for the am6254atl. The U-Boot stack overlaps 2 regions we carve out =
in
>> device tree. LMB doesn't actually inform the user of this, and just keep=
s
>> trucking, thinking that the general u-boot reservation will be good enou=
gh.
>>
>> Eventually, when some of the stack can be reclaimed, we will put some us=
eful
>> things in these regions that were never properly reserved.
>>
>> What was driving me crazy was that the efiboot selftest reported that ev=
erything
>> was okay except for the device tree region. Fun, what could have changed=
 that?
>> Well, that's just efi_carve_out_dt_rsv going back and trying to enforce =
things
>> LMB never did.
>>
>> Somehow we got it perfectly where copy_fdt would place the device tree s=
quarely
>> in a region that was reserved by the device tree itself. Anything else w=
ouldn't
>> have been exposed to the user.
>>
>> So, I assume that kernel warning is actually a result of some EFI region=
s being
>> reclaimed by efi_carve_out_dt_rsv and the runtime blowing up because wha=
t it
>> thought was a valid address is now in some reserved region.
>>
>> I've checked and am6254atl is also not able to reserve the
>> wkup_r5fss0_core0_memory_region (0x9db00000) at startup due to the u-boo=
t stack
>> size. A ram top value of 0xa0000000 doesn't work with these reservations=
.
>>
>> Adjusting the CONFIG_STACK_SIZE won't help here, as it u-boot naturally =
extends
>> into the wkup_r5fss0_core0_memory_region on it's own. I was seeing a sta=
ck size
>> of 0x22184c0 locally at the time reservations were being setup.
>
> Ayush is dealing with Zephyr fallout too. I'm wondering if we are
> doing too many dynamic memory moves. Do we need to start hard-coding
> some of these memory regions in device-tree and then load the 512MB or
> 1GB memory settings starting in A53 SPL?
>

Actually it was the opposite here. Chicken and the egg issue. We don't know
about the memory reservations until after we load a device tree, but we can=
't
load a device tree until we've at least carved out some memory for U-Boot a=
nd
it's runtime allocations. U-Boot relocates itself to ram_top, which is too =
close
to our reserved regions.

I just went in and forced it to relocate to a known region between our
reservations and other blob addresses and it worked. Passed all the unit te=
sts
and my own runtime tests with efibootmgr. I did also have to adjust
add_u_boot_and_runtime and lmb_reserve_uboot_region to handle that arbitrar=
y
address and use mon_len instead of just assuming ram_top would be the end.

This does bring an interesting question though. If we aren't going to chang=
e our
r5 and m4 reserved regions then we'll have to make arbitrary gd->relocaddr
values more properly supported for both this device and am6254atl.

I assume since it's part of the global data it should just be part of the b=
oard
config instead of a static Kconfig parameter. Anyone from the community got=
 any
comments on this? I'm just a lowly graphics developer.
