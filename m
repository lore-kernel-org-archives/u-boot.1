Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FD5EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8738186473;
	Wed, 23 Aug 2023 16:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SCWUctrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268DA8645F; Wed, 23 Aug 2023 16:56:37 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 300B2863F9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbgBif8+dScHCOday6sYp/bSyqfrvcybMje18lOff4ZrulavvIxN8g58QOynfsAeKFsAaoR0YxBoXee7lbuslphtwDEPMPZPkQ/Sfp4EtBCb1Vlar7J/WKwZ1WUnBc/m7xRfb7xeUsjHjxWTIkOV2L1Cwa1LuVrjOLVIcJUNDrkdrAJbrxecGY0n9SZurVTsclbrHnGURUC+wU8zXEVvTg+tX+hWG6LyVLfG42S3nQTegDT6dRXHKV3ZXFmz7p6BR71yfCSUnMXIfxg7Lh8HoGeLbzvkOUbPgUsNAbP0mF8D9L2Y/eoXaRgevz5kiPutGmHLUoSvnsruPYPYz2DbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VYqaEjANp4eyX2VGptiG9xUyK1X28l6qXvHPHIfcaU=;
 b=hQo5+pYaY5DTzAVKyh09LSlFRiZnlDBNaBZP3zHENMVR03aMtLtRLeF5CWTgb37CtudcAi/f8iZpzvHHWIUkcpvStJqpH32ioiwVmCJBl+t7+bg4pmZ/khPqkr65AUE73tbaJcXgpYhJPD/P9wb4KERsKDW10zD/srQSLEmIvDx2RbzcVo5fT9iLY1cV8j5ROSmkwLzhCmF6dZTLyeCvAN+eudOwUK7ScXIXn+kPmiJpcXRcX9VxhjJfuUW9DTWg6g7HMX1okp8phnkdlDhssf7Gzti0hEDn34TG4cWKu5hJMU/vTdrf2ouEeMhrOMNlKDj1ciH1xV19tJDKW9yBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VYqaEjANp4eyX2VGptiG9xUyK1X28l6qXvHPHIfcaU=;
 b=SCWUctrUcyIHFO80vTV80KQHOGcyt/flhWrdLiKyIlq59iqKkzYlqZG+5kNhbBCS8AeG5RSoiRbrEu+DLL1ZkZ/bIgBsAZnJOXwo51muB7e9TYv3qN9cLEBScLE+yZZtf5EvGK0SNERbB/9kZ74tJV7dl/g1eD5fw9i/l7WW760=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9382.eurprd04.prod.outlook.com (2603:10a6:20b:4da::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:56:33 +0000
Received: from AS1PR04MB9382.eurprd04.prod.outlook.com
 ([fe80::efa8:cb35:bebd:3d10]) by AS1PR04MB9382.eurprd04.prod.outlook.com
 ([fe80::efa8:cb35:bebd:3d10%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:56:33 +0000
Message-ID: <ca0d1468-1a89-b18a-9a9e-23080788eddd@nxp.com>
Date: Wed, 23 Aug 2023 17:56:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/3] fsl-layerscape: drop support for obsolete PPA
 secure firmware
Content-Language: en-CA
To: Tom Rini <trini@konsulko.com>
Cc: rajesh.bhagat@nxp.com, pramod.kumar_1@nxp.com, andy.tang@nxp.com,
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com,
 wasim.khan@nxp.com, matt@traverse.com.au, udit.agarwal@nxp.com,
 joe.hershberger@ni.com, peng.fan@nxp.com, sjg@chromium.org,
 u-boot@lists.denx.de, michael@walle.cc, camelia.groza@nxp.com,
 ioana.ciornei@nxp.com, vladimir.oltean@nxp.com
References: <20230823132546.6048-1-laurentiu.tudor@nxp.com>
 <20230823144307.GI3953269@bill-the-cat>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20230823144307.GI3953269@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AS1PR04MB9382.eurprd04.prod.outlook.com
 (2603:10a6:20b:4da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9382:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: cb920ad2-d374-474f-318d-08dba3e92408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEcXqfMIkX3bVc276GsJSyMdHCFzwr3gLhbDm1GPefoI1d4Z678+YQ/nmqbZyc+veIe10pcCc9u5/pLxlnjgqugFsLjEemvYxx7bgblx59cUdbnveHz0rd0JjMaJfdrEUVPnclW4epeFrHO/X2q9pxb8gHQWwxyPTzKyRvWni6Hq31Z5PXqQO5dsTsNX6LdyHJnE7BJZyod4tqIJkeCZDt+VTq0qs5u0XdqttMQZYwrH2bjt/Ro0I9IF/IpmeVxB6CWFFrM/x40M2tFu1wOZqb02S4lRhbE+d11xXnNs482TvAGdAwXCkhUOA0pCc2JZ90yTZQkid3Q1SUYEA1eaps15t75P9dZceXg/5lWPXSi2vMp+B0BetyPFTeU4fs646C4ahBWm4qoLziKf1+0rcCUt85iCKFQc8sDGa9GZ984glB9Wse2zGW7rEArBOZp+JyB2ZCmyKGnbLBDmB8ntACSvg3rXNpFwg6P2dJegtgRPWchUv46tsV6gD/fUAnmraUvoZu4vGAm7Z5e3fVLEryXEAorYuFGwrg4I5Pef/eulXOJek9ckutCRY80tG+APEX4vhgb7+PfbWrr5SqeF+ub6E/V34B/c6aJIDJDFX6U5UCAljrrLQ/ilbiLjJ1UfNH29yAu8PRlJduB73XykDSYRvp9M7ApVyU0w47tPSue03ReOvN3MFCr6OY9TpZbt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9382.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(4744005)(38350700002)(52116002)(6506007)(38100700002)(53546011)(55236004)(6486002)(83380400001)(5660300002)(44832011)(26005)(31686004)(31696002)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66556008)(66946007)(6512007)(6916009)(66476007)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9WMjBqSEEzcDJTSVhWME12aE5yWEI3Rm16cUNQeXQycTU4cUM2NkZRVzFI?=
 =?utf-8?B?bXNsOTRCRzN1eGlZb2pjbXE0MW9hWnZmVGVwRU1ZaStBTGtuYXF5K2RydE5H?=
 =?utf-8?B?bzJ1S1ArUzJXOTRKQmUxKzFPN3lpWjdKOUVFUllyQVQxdGxPU2I5UEZNTXNx?=
 =?utf-8?B?MnN5dlFVdU56VkRVeG9wbHFYVm5sRzVkZXU3ajM5VjhWNkJEWE1HbHNVSk9C?=
 =?utf-8?B?SzR0MjViOGEwSDlXdm1COE5aMnpRK2JXWVVWM2d4RitiSmFzOHFFRVBhcGt0?=
 =?utf-8?B?MGozLzV4NFZibVJsNDhJVWNYNm1heEpBU2REbXVaM1BXVWNIYi9NUEt2YUMz?=
 =?utf-8?B?VFZQc0Y3Vk5ueEs1WFRkdU80V2JodlcvcjQ1aXBQcmJFZDBmemhuOHB5Zk9M?=
 =?utf-8?B?Z2E0Znh6ZTRxbTQwei8yR2M5dTFMeG5aaGdzYzBiTWM4NWFoYWNXZUFJaU1u?=
 =?utf-8?B?S2Y5MlBMdS8vVnNyZC90UDVBeXp0RUJDcHRDV3pQNjZhbEtPU0RYVSsyZjE1?=
 =?utf-8?B?MVF4UWNtTkRoNFRtZGJVWHNYV3dVRGZGcDhsOHYwb3Fsc3ZZQjlveEdNWVNy?=
 =?utf-8?B?VWkvci9OSytRUjhXa3BucXdyV1BwQXFFcmhXOFJjNzluTVdoQWFNK0xVNWJK?=
 =?utf-8?B?QVF0cEFVaDdNU2ZyV1Qwa1JUR1BhUDV6RkFadVhvR091K3NXSlVIMVJXYjdB?=
 =?utf-8?B?SWlmZ2hSN0k4K0VXNkxWc2h0cGVWd055TUNZcTdnUkEzK0g1a1VZd29iV0ZJ?=
 =?utf-8?B?NE1oWHRKWGR6VFhDbE5OQWRQYk1jbVVCRmVVSWpXd2RMUFNnLzkwYlFSNlR2?=
 =?utf-8?B?dEJsdjBKdVhsOWFxdUJpdUU4Z1NiMmJ4Syt3Nnk3SlVWY05LM2ZEdmNTV0Ex?=
 =?utf-8?B?b0VDZ2RhMVJJWVIxdlRxbW4reGhQR3dvZlpiNWtlc0R1ZG1mNmVYUmFUc0NR?=
 =?utf-8?B?ZFpkSXA4a0ZMdXpieWxCL2FrbWp3NmwwVEJRTWx4bVNmNzViQmRQV2l1Qm1D?=
 =?utf-8?B?bHZQWFFiQVg5TFhYc0dUOCtTa1doeVlpRzd0RG05dlRCU2tJbTBYaGhVb01M?=
 =?utf-8?B?Qlh3UDV3VEdCbnZuOEN0eVpJZGZCTHNYcGlHK3RxNmNrV2gvQXppUTUrdHdp?=
 =?utf-8?B?c2J2RjFEYWk3SU9Oa2FHbHNyc24zeE1PVDVKRCt2OFhPWHdLTWc1RzBndFFT?=
 =?utf-8?B?RUg1YXdLN0hURDVSZ0JkUU54WEorNi9vaTVSRU9tZ2ozdFRIR2hoREV1UFRZ?=
 =?utf-8?B?cER3UnhnMnRHZFNVUXBPbnh5UUgzcEJ2ZEZXdDAreTZaOStpMGJFSmpGUzRZ?=
 =?utf-8?B?bkY1Z2pxeUhNTGxTSk5CSFpUQ0grSXhmWWVIN2RyTy92K093bkd0bWhMbGYv?=
 =?utf-8?B?ZkdEeEJjbVdrT1hCSFcrWENPVEkyNzZxb1U4RUhmQlVsTWRSZUdNZFdLRVQr?=
 =?utf-8?B?NS80WW85R3p5T2tkRTNIZjNmcVZsZyt0dXoyakR1UmxYSFFqR1RPTXd3N3Nt?=
 =?utf-8?B?dzFYSVhaWHVaczE0elFGMHJLVlMxOTZTUnFqZGVNdG93eWZmb201V21KeHVU?=
 =?utf-8?B?OGpJUml0RWMrWTZCMUh4VXJ4TDJOUGNXTURwZkdXNEpjUFowUHNKclpvZGxD?=
 =?utf-8?B?Y1ViYjhGTjNvTHk4QUlPcHI0aU0wOGZBRlo3SjNRSE9RUVJoNnMwZWN0SVkw?=
 =?utf-8?B?dUUyaEdud3MyWUEzSGVUVjFVbWQwRG1ieHNuTnFpOWE3UE90YjhPRVlTVVh2?=
 =?utf-8?B?Uy8wYVFzL3NSQVBIeG45VkJNZGhTTnR3LzVFa3RiVVBQMHJvVlFQNmJoWkpQ?=
 =?utf-8?B?djRuTUtiRGxJV1gyMEIvTVRyeDFlb2RVL2dXa3I4STlkbmUxYjdvRnFnQnBV?=
 =?utf-8?B?R2tmMHpTdWtHS25nTmVHRW9GcXdiaXlDUktscTNZSFhIQnJRZjBuVG9ibHZz?=
 =?utf-8?B?aGtTaHJQT1JjUElDUWpha2VBQitXYUxjQjdDSVZhV3RZemZLUWxVZXFZUjFu?=
 =?utf-8?B?b2w5OGJrTml0eHFZSHZDaGhremZzdmg1azdUQS8rdnlqaTFxaEtXQUtremx4?=
 =?utf-8?B?U0x3d2dBZG1taGhyTTAxbDZ3QllnaVB4SU9GZ2hiRkMzTG84OXlNeHh2Wmpv?=
 =?utf-8?B?Ty9XdnhzcmtCNU1YMXVkaFBLYlNnNmpVNlYzTWFWcVlKUVVrUU9FOTc2aUxi?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb920ad2-d374-474f-318d-08dba3e92408
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:56:33.1969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 155vcvKYHn82MiMB/hUDTPMNuV0wvqAmlv/NyVxkWD3dnhSvupGDvcVYasXK2ciUwvzpS7ZwEoBvFx2xZQb0EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964
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

Hi Tom,

On 8/23/2023 5:43 PM, Tom Rini wrote:
> On Wed, Aug 23, 2023 at 04:25:43PM +0300, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Support for this in-house secure firmware was discontinued long time
>> ago so remove it. First couple of patches delete the defconfigs that
>> use it (split in two to be <100KB) and the third one removes the
>> actual PPA support.
>>
>> Changes in v3:
>>   - fixed some merge conflicts
>>
>> Changes in v2:
>>   - split the defconfig removal patch in two because it was too big and
>>     was filtered out by the ML
> 
> Note that you don't need to split large patches, they just need to be
> approved before they're sent out to the list, which typically happens
> during normal US business hours (when I'm awake).
> 

That was my bad. I noticed way too late after I've made the split that 
the big patch was in fact approved.

---
Best Regards, Laurentiu
