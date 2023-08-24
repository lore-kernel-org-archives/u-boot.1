Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFFCC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D577386554;
	Thu, 24 Aug 2023 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V9WegvXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF818655F; Thu, 24 Aug 2023 10:00:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5036686547
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq64Ftcmv/zimoBHct6gbDvRDFV9Igmr6v6UKBK4K2IMnsR+wjVAIoyadaLRQr17Ea9ns7u/NxW7tprr7wKJF6aW+JuwlPXc5pbEwX97zrjYjmToQ/glAnAJ6FEazwCTtntgc/ZlSCA84IJFxWhpicd97+SxLJzgDWiRhYhsRT73fSmGda9WQfmX9RGY6YJPNf25kuxH3N0eIpIltY3rLCmeFrxOtsd0F4cqPJtxKOTO6/CKjkJcB3i3IGZgDBN1GNKI1AkZy2huqrATkNynb2rWaLU+FftMuE3od3f5idJbs6RQx6SdihORm27Uc0bsI+UWhVsJ0YNw7gH3HSO5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adXakaOM8iJL0//CqXI3rn1pZrGnUHPJuhGCeZXJtvc=;
 b=oeF7D6qDbx1129dMfi17iXEOu+reoqVbZxtGViESYt8dITMYAaHegmj/fiZeOkWzyka4JJb56Zc6NIuGzyCIgXCe4x2GikVs6zCtNeMPRhm926D3x3WXyIfSqH5Cxa5n2f5fxEQ5P15d0yFZCI3orzq7W0wlZG5On2S+Yn1oG8WmANyJM4jcFnAjIMQo37mJ3jbP+bIw9nZhwyaO/6ncjohksT1QXxXyzxnrjldIhWET8oOzMZNm32TdA8rVDHZTpg/N+QUEZGgjqEwWiun2FFReEpfqjTqly/sa2cFt66PFM1e3/Zr95slMacDTmLFNBJAsIMwvI93EhraCLWYsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adXakaOM8iJL0//CqXI3rn1pZrGnUHPJuhGCeZXJtvc=;
 b=V9WegvXS8x0PY2fNW/w49oBv0YFVrYNmuhfqpx4f20Fvv3Nm0xTenbo9a/R1TEDlFtJTag+FMcoGuPdyx0p3VIwGSOY1rZi8JenV8OdRH4U6T/cf1LASnIj+rUl1+QqDYWd4znto3tijy4ENJMtjELewfHIuovVxE66ywKvd80E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 08:00:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 08:00:44 +0000
Message-ID: <e521645f-97a7-52f9-c7b0-b20c65202cbd@oss.nxp.com>
Date: Thu, 24 Aug 2023 16:00:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] fsl-layerscape: drop support for obsolete PPA secure
 firmware
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 "rajesh.bhagat@nxp.com" <rajesh.bhagat@nxp.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>, Andy Tang <andy.tang@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, "Ashish.Kumar@nxp.com"
 <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, "matt@traverse.com.au"
 <matt@traverse.com.au>, "udit.agarwal@nxp.com" <udit.agarwal@nxp.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 Peng Fan <peng.fan@nxp.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "michael@walle.cc" <michael@walle.cc>,
 Camelia Alexandra Groza <camelia.groza@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20230818134330.12509-1-laurentiu.tudor@nxp.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230818134330.12509-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: c85d104c-d807-4b61-5b17-08dba47837f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+dmBIWIftT1QgehUR80vjn/EHxMD1MGvnRi3EnXAp21vNA4DYJtABSfY9RXyhP8LBl9wBTI52RZnoJSS2CIepnJKO0GjbqNjldHUwH982x/ESxHXxYZnSyXDiSM1hDWbyrJ+stfsrst/RSaHa+n493qpDEOJh1zvyH81Ev/BI2XV4pGy8IjwBPpw0uWU0c06I2h46pYbnwzWwzK9Phj9EIHTbCd/1PTeP+LlhD28di05Rk2ctkZyTHiCLdqJEMSCS4ClyWWQPBceTlkz5ZTJZCEbKYlnZ1qyNgMRuGaFI7MVCnNal+MoMnBzppo/PRSWA77bOONiuR3w4HHWyxcv+fTgvB0xn/E0rmQVRvOvRoEw00Q+HAnyXKASa5nxEC6PZfATc5TIBugjmAc/1sfH45ZLVs405+Mcye7zTCIfN4xuyhMSiKqGVwV+4Q+wbSNBb/8Un67MuT5lmE5P7HAYgLWMACD9Tc6wvQxBSpZNKy5io+iTagIsC5fMk/q7GoIpdXG9ZUBV7UX3nR1wPZo3K6RpTVNZ+BIidPQCVWpoJBHPI6QCxfAWGB6C4dzlp+tSmWeQ/pNXN2WonN/R5NMfyCX6wU80OZxqdiR01dBvimto6f58WnH8GBJS5clneTUa3XwXaJgtb9FwNVe4MPcqou4smW4s5wiAWwfuDjFoDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(186009)(1800799009)(2906002)(4744005)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(44832011)(26005)(31686004)(31696002)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(66556008)(6512007)(316002)(54906003)(66476007)(110136005)(478600001)(921005)(6666004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFKUlpoNk5tS20yRCtEUmh0UnlxcGxVVHlWRm16WndhRXFydEord2RVM2th?=
 =?utf-8?B?TGNkU3Jpc29iVGZFa2IyS0hvV3k0ME5Ibm5JNjVodTVjOFZYWVgwbGViWmQ1?=
 =?utf-8?B?WWp2cXlVTjFueW96WE5nMUFmUGJQT2p0Z3JEQW1nK2x4REZqc3ovUm11OGVM?=
 =?utf-8?B?ZHIwUW5VRXJ4L0MzWEMvWCtZYTdRTmF4aERIcW9YQmpaemV2Rnl1YWMreVVF?=
 =?utf-8?B?WUpxbTFBVzVEZ1Z6d1lqc09KMlcrZGRZMi9ldHcyU21ob0NxOUJ6TkpQSk9D?=
 =?utf-8?B?RWJhNXlabU40NDdmYktRZndMMFpjcTVDelJmUFc3MEcvTmprSUZaclJ1QzJ2?=
 =?utf-8?B?dUpxaE5kTXRSdkdOMTlHdVNjOXU2M2VuWDNBYU1SaDh4Mk5kb2dhLzcwdkFW?=
 =?utf-8?B?NmVYaVJ3TnhEOUthcUJzQjRjalBBL0ZZaVdmakp0RlRyWHU5a0JYT1Y0ZVdt?=
 =?utf-8?B?bTcvZzE2T21pWE9PZFpWbmVzU2Ftd3BmYlJ6dnJtZEhJQXJxNXkrTGFrYXRP?=
 =?utf-8?B?WGN5dmhYdUIzSDVpUGtORXAxSnVjWFQ4bnA2RnZwWGtZMDRQb0FSNkI3ZktH?=
 =?utf-8?B?cTlHRERIeWFGY1R4aXNrSjNreDZLdlpyYllvYm9qUi9PRWV3NFZ1dlVMUks1?=
 =?utf-8?B?eFJSbkloS0prYVd1WG9jdTJzbjZCQ0VXNk9KenFoellXSStkQVU4RTdHa2tx?=
 =?utf-8?B?K051cmVXZ0FzNCtsK1hVakFiOEFuWCt5cldlV0hmd08yZWpPQklMOU92RHpG?=
 =?utf-8?B?Smc1OWhPU2tlL0FMNEVMUmovL2UwUk40OEIwNGRMbDl1Y0RRQXV4MG1Jb3FQ?=
 =?utf-8?B?WmhDTUxCNmF6TFliemg1SDkvTU1IdENHeUpQdXJIVjQzMG5rejhDMmFIM1dF?=
 =?utf-8?B?TzN1ODNaRUhLRm1xM0pGZ2FGTjJ3dzR4UzkrQmxzMllMSjNXVWkwMTV2d1Zy?=
 =?utf-8?B?S0lJRHFsTEcxcy9hVHNkbmRuWmE5aG44aU16K0NwaHNTMmhwVzlCb2JZcmc2?=
 =?utf-8?B?QUV5ekViYVNQajZkeG1wQ0N3OVkrSUVxRVRDTVVPK1NVVk53ZUxVWTBWNkpn?=
 =?utf-8?B?Y01jaURJbVE0bERSMEJHN0RjUndOMU5NQ1hmQnVOSytjeHlkNEI2N0swVThP?=
 =?utf-8?B?b2NCOHdxUElJVFVjbVF3QVJIWnpmOENCUkpDQzI5UDNJY0ZmSTdZL1diTDUz?=
 =?utf-8?B?WGhoUEVNYXl2ekZSYUtDOWJVOXc5N1BzQlhWaGNka1dFWEV3WHVnSy9yNlA0?=
 =?utf-8?B?dDVTRko4OEg1U3k1b3lKLzc3VUVTTElHbzRVN1ZVTENKUmV5cVJRVFRaNHpC?=
 =?utf-8?B?dGE2Uk5oK1VVQTZ5WWZSQTNRZXRZTFBDSm85REs5M3U3T3BVa2VMSXp0U3RE?=
 =?utf-8?B?dkEyaUxyTjk2L2c5bEVyNUZBUXhWdkY1NExRazc3VXJJSGJOVmNOeFlyVm9u?=
 =?utf-8?B?Y3pNbFpNUVhyNmFLRGtUSkpUWDVyZFB0YUNJcGwxU3YxMWRNZnpzR2JzS3Rr?=
 =?utf-8?B?S3ZHcS9pT3owQnFSbTZvYWY2dGtTcStweXJJdmYzNTJJK3Z2bDV0ampiMDZh?=
 =?utf-8?B?Y05sKzFMV09zMi8xZjBTZDFGRnV3Vk9UTjhURzFIMDN6R3M3YlZ6VE1zNlIw?=
 =?utf-8?B?QnNpUXZpZEgyT3FwMEJha2p0L01RUTBBV0g4eXZSZUxDY2ZQN3hYVmJocEhm?=
 =?utf-8?B?Ri9LYjVYWTVhZDNsZFBQcFJJQ2R4MHBxY0xiZ1ZwTWhuY1pTc1NUTzZCQTdn?=
 =?utf-8?B?SGJjdHRTaWIyMmVtZG9WcXBsU2IwaG9KWXhXTS9lZ3gydWFEYmprVnBTM1BZ?=
 =?utf-8?B?ZzN6dnF5L1pCeWpaaTM1MEUvMnVJNk52T2s5bFFFL29tcE43Q01FVGs0QkFW?=
 =?utf-8?B?UjB4VVlsemtRTzJOWUdtVXpnRnNWcWNXTHBvOExqMDRsYUU0K1hXWW42Qko5?=
 =?utf-8?B?MWpBMUxta3dhc3RsSE5PMGpEUjJCT1J0TGs5eEpPNy9aMXdLZGZGUmFFWThQ?=
 =?utf-8?B?OGpqamNxc1c5bk1IdmxmbmViMUlYSkhuNkF5cG50V1luLzNRSWt1dUhPbmFh?=
 =?utf-8?B?Z1RYd3plV3lkVTEya0wwc256MUhEckp6OUFocUt6cGJJSzZ4TUdPUzlDZnZm?=
 =?utf-8?Q?VwlCF2fWUKVENwBDPplrExyKc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85d104c-d807-4b61-5b17-08dba47837f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:00:44.7804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn5M6IXsHE2Tn/1bsN9t+yUZlUozP3fXPgcDiRoRYEUfwOpoTlaUwCXdBqRxRxZUFyNHi2qqWz9SqsgR28r0ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
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



On 8/18/2023 9:43 PM, Laurentiu Tudor wrote:
> From: Laurentiu Tudor<laurentiu.tudor@nxp.com>
> 
> Support for this in-house secure firmware was discontinued long time
> ago so remove it. First patch deletes the defconfigs that use it and
> the second one removes the actual support.
> 
> Laurentiu Tudor (2):
>    configs: layerscape: delete defconfigs using legacy PPA secure FW
>    fsl-layerscape: drop obsolete PPA secure firmware support

Good to see this.

Acked-by: Peng Fan <peng.fan@nxp.com>
