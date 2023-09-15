Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F05EE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 13:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8679C864E8;
	Fri, 15 Sep 2023 15:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ur18bV4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23956864D4; Fri, 15 Sep 2023 15:47:41 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB04C864E8
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 15:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGXN7apbH2aqeEHCXNz+VoAkZ014aRXyhAJAtfqg5B9AaZvYSDUnrAA9gCNnLA1mhjJr+C+dTqIgZq5U5T/ranf654x0wJUTe4rRr8WiPal1qSA4RtYRsAu8Ne9ibDe7Jl2cEloBWJnhW+VYbsqkI5nXJ4R6lRCe8rr1I6TLwD0GP1JFodnyCo1qsk/Y4pvu5hbEzkDJF3cvvfEhg8lAn0OUlvemSavh0BR3cHMoRfzLxP6xcabQAAoh+w2kjRtqQC0eg7UB969TonImGDJsjXO3e4pKEm1C4i2gWVjOD364zShjEbxd6HJfz59CK2ICbgsz5uXlPDA3nAR46mn2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwfXvSrHwvkwfvBztBR7xUpSARwsEOTFeZcUkQzqUPY=;
 b=DVJSB51A4rsy3zpxahzF8DveMrHsm0pmGVgj00cHBKTHrSV4AN0o1tQqoyP2E2qWdqILDzLj39lzi7GtS76lnJJOg7zaUo9CzmJ7H/wBKvGk7R2jCGT1Qmq5wtRVBe8/CQupzoqQqYEglqSbghhscDtxbiQCKgOuCXjQh2CX3gcNLDgkRXChhLAg4IiAbziMvkc2xy602dqmPAwwtn1ymWR2ILgeiaTSFPOrIEB3nH1vmjdaTo6bH+KHiMiTk2U8Q9R2QJiA5s0iJCpIkBwv+GY2IOhyjtKBUCFwNo9OtfRSunmEAucNq2S0W1C/LI2JeXiEQYXzMOEOT8O+lkCYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwfXvSrHwvkwfvBztBR7xUpSARwsEOTFeZcUkQzqUPY=;
 b=Ur18bV4drU/lcbzOp1+3VR1gg2SIMhvEpAopPXwwzbRHJK1ehRueu9ErtnguNIBdIWzdtUOafA2CLVXWWxQC0YMFm2IRH/CS0X+Ah2Kf/UkZK8sbMIMt+vUpsqC4+om/tcCXdfXQb7b72/iebhq0HKZPX2s/Zm2mvDh9awLVaH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB8187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 13:47:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 13:47:36 +0000
Message-ID: <bb43c4d4-8d01-49a7-76b1-2f1a3c78918f@prevas.dk>
Date: Fri, 15 Sep 2023 15:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: USB: error messages on DWC3 gadget endpoint dequeue
Content-Language: en-US, da
To: =?UTF-8?Q?Jo=c3=a3o_Paulo_Silva_Gon=c3=a7alves?=
 <joao.goncalves@toradex.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marex@denx.de" <marex@denx.de>
Cc: "lukma@denx.de" <lukma@denx.de>
References: <6c9901297ce8cda6ec83304187582b3d658a6457.camel@toradex.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <6c9901297ce8cda6ec83304187582b3d658a6457.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 558bb469-bd18-4a67-4bf7-08dbb5f2521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBRPl4LAfWZL7/dEzbM3iY5VreqojV7VngGGccH/OomVYnepvUl/ZhsR6RY2C3eFsz31gtT8wyle3onBRLNIXiAAfz1gq6H4qRGGgAPP7l7ZvhfMq8JUU87Om2Tm/0O+4bVPAtQDGy4mt7A8rjW9Ys8nh6DmmzB30c79mXMUeG3pjHdq2tiQmrFuNmfAerMpBAjf0SJLGb8Uf3HOS4Nhb/ro5UhKSBzSsHmHJE12PFpDCIUxddDPEu9EEU16yR50HInHpUhBZgg6Q9FX5bczyg+GqkduaE+wSzY12xHmWkbNgJPg9Eic4fJ9514e7BbTirq+R9R12Qht4IT3bqxYmuZ/M+bYqTrypQGjhE/aBaslTRh72wopnG8G025lf5WEWpfQoXy3CcE8e1ysKRtMrWjGe/vCcCGaNSWNJiMcHitXUXa82cUJaHL98XExpF5uU1rFv9L5k6mjCzCEg6yLOq+5bM7jdrXQQ6koA3Q60hgKdC/2sV1CfQ6tIcnzSpFdjLDY5pxHGO51CwkHfnfbjIbtEaGbaWysjuqEDlXMT/NHM3odvfUlqsnvky8cTsqZYUIkyNlH7z7vrGLagb7YlDVuBik2NIiTZeq7m+v3DfAvHy1UT+UY6e8Uk4uj0UjpIo9qMUtWMW4CHgIiw9/BgFz/UohNcrVfDTRw0JfmOU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(376002)(396003)(366004)(346002)(451199024)(186009)(1800799009)(31686004)(38350700002)(2906002)(38100700002)(66574015)(2616005)(86362001)(26005)(31696002)(15650500001)(4326008)(8936002)(44832011)(8676002)(8976002)(36756003)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(110136005)(83380400001)(6486002)(6512007)(6506007)(52116002)(478600001)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNkVVhMeHBjU1VSQTk3VytmeXVrYnNxVHV4bHFOcGNhKzd1MTd2WE56MzJr?=
 =?utf-8?B?czJrV2g2QmtuVHJIT3dnTkIrK281U0NWanE3Z1RKdmdZa0pDU3VlU2hQdTQ4?=
 =?utf-8?B?M25DWE5CQkJ0L1l4Y2NaRVYybDF5MHF1dFI4REMwZi95TzRDbFBvT2R4Qkk2?=
 =?utf-8?B?QXp3SzU5K1pZdktOb2RvTEFQaDBwQlBLZGpPVktIWUlvZG1wOE5rUEtJNS9O?=
 =?utf-8?B?Z2Foc2h5Qk9uSXhUUXgyVkJhZFAweUJIK0ZRUGNnMFJoYjI2NnBBSGlpaXhE?=
 =?utf-8?B?WGVVbEJrbXQrMUdWQjd2NzhmdXA5ci8yK0lEVG12SjJJK1BYcGZkY2ppTWtj?=
 =?utf-8?B?Q1dZc3d3Z2JNY2JDSHVlZGZEVVlheGc2OFl0R0wreEU2cVc0aFNDejNRaVJK?=
 =?utf-8?B?MkVjdlR2d1dScUxwUDc0VW5zMS9LZEk0VE1vaVNpcjNkVTNpWWRkaHpYdkRZ?=
 =?utf-8?B?SzdRUHg3cC9Ga3B0MnlIWWRFUkNoWEpLdllzSXVQbDN3UzRmb3VtZjVMd24w?=
 =?utf-8?B?WkxVdjdsRzBOWEhZWXFrS1QrN3pJaVJMdzF1QzA4c3N6Zk40cm5xRjdyWGp2?=
 =?utf-8?B?M0NtVld2VFdvbzhqaEpMYUJFL3F0cGkrSWxWVWZsdmUzQWFMU3BHQkhYbUpo?=
 =?utf-8?B?T2lIbUtzeGQybEVaczJnS1I1UTJWb3ZEeGpkVG51RmRRS1lxSFNGVWd5cDJS?=
 =?utf-8?B?bzdrZVhEL3pJMEI2M1U4WmRqbHQ2cUJlSWdWTHg3Uk9GdEc1cnRFbEpZM2k1?=
 =?utf-8?B?dERKd0FnQmk2eG1zV3dPQ0xIT0Y5UE4zK3hQd05nNXBZaVNRcFVUMWNCSEx2?=
 =?utf-8?B?NmJkQ1FzR0hPc25lT0pFaWRDNEpWYjdvRDVpV3pGR2NZMEFadmF2TVFDNkYz?=
 =?utf-8?B?Tzg1MlVucUFYM3hWTmlpSWhwWGRSRjBpSDJkemdBUHJkTDhseVJEN0hPclFw?=
 =?utf-8?B?YU1laGpFYkM3emphMWx6Nmc0WFc1c3IxZVRKZG1ocmEwTkNLN0pFdkc2NjFO?=
 =?utf-8?B?WFdSNU9OUzBBT3I1SGZLL2dkcXl1N3FBL1BjSUg2QlFzbk1wQmhmdzhjSmUx?=
 =?utf-8?B?c25KZXdyRER4cnIxYmdGT3M0NW9aNGFIdC9kYjZUUURqNG1MWkpYekRTbjBs?=
 =?utf-8?B?R29CZmNQZFd1MHhkU1IxVDNidzdNaUdNbVNud2VLdjFwU3RQRXdCQnFuUlRF?=
 =?utf-8?B?aXRnQW1GeVRYUGZ6Uy85d1hPSWJLTkpRdjJqRVRoc1p2RkMrQllDWDdxNDU0?=
 =?utf-8?B?NTdROGVwMGhENFdiSnFUOU9xeGsxRTJtWEZObE5tTUN4d1lqU3grWW9rcmk2?=
 =?utf-8?B?NnRTMlQ3czBGb29IRmM2SFVOTHBSQ1U3cmVRcG5UZmdDWUIvL3BrdURvT2VF?=
 =?utf-8?B?WUJtVHp6ZGNIU1dGS2ZRL3Z0Y1hzMnFpZmFJdUNFdjFBNC91WjBXL2xudjhw?=
 =?utf-8?B?MlNRNEhoTXZiTUIvTDRpU3B5eGRVMEtYU0xsc29PZkJkVXo1MGw2VlpZOEZJ?=
 =?utf-8?B?Q3NGK1NvT2tWYWR6VVBXb05UbGJnb0czVCtEZVVhVXFDTGQ5TFMzYUpBbGpz?=
 =?utf-8?B?VXh0M2Y3Zy9hWnovNEtZWXVyL1RzczhUTDU3VjdYamxlQTgxL0VLK0xpV2pZ?=
 =?utf-8?B?YWZBakRERXpleWl1V2dqV1YzZ21ZaE56ZkJ6M2ZYNC8rYzVzVjJ6QjFTSXMz?=
 =?utf-8?B?RFNQYUpBeGI3Mi9xUC9Xb1pGWHl3alNDaG1tZ3B5YU5lclhYRzZyRXNlZmZ3?=
 =?utf-8?B?cGhGaGFTZ2l0YmRUUWh5QW5ZejdtRVlnMHJWUFgxK3NjeStVNGRLZGtjYjJI?=
 =?utf-8?B?Ty9xYlphRTdXaytoT090N3p0OERlZElSUlBWZzdCYitIWGo1bytVRTVyaVF6?=
 =?utf-8?B?S2dPTFRZRHc4UlpnZi91R0UrN0xmZlRzaEF4eWxPR0pTMWM3RUUxY0E5Rlhj?=
 =?utf-8?B?MjJUS21zWnBxbFdoRnJiTnNjSVA4RWNncjVCWm1tMkVGZUNxUVpFTHhHWWxM?=
 =?utf-8?B?SVpZYk1YckR2OGYxVHU3YmhDQ3MrQWN5OGYyWUdhVDZjYzhyMVNhUVVNTHFE?=
 =?utf-8?B?bU53UG9ZK1JCWWN6dnpwMkdVUjE0Q2FycjlXQ2lpaGtwcGRBY1loSjlCNFlX?=
 =?utf-8?B?TkN0SWtJQWpqQklobWR5eExncWlVWHZlRHRobmpaeDFTdFAyT3lsZWJyd1d2?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 558bb469-bd18-4a67-4bf7-08dbb5f2521b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:47:36.8594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC18o3YImc/fxEs8JH1M2UpjqA57D94iOZpV2oZ6jXkJHLoh1tAoaieONClQvjkgy6lMn4r9zNBtG2lkILAsc0Pg43S6Sg1dnyMLtvSZUXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8187
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

On 15/09/2023 15.05, João Paulo Silva Gonçalves wrote:
> Hi Marek,
> 
> I was testing fastboot image download over usb for imx8mp (from usb
> recovery patch of verdin-imx8mp) and i am having error messages on
> endpoint request dequeue function of DWC3 gadget controller. However,
> download is working fine, so this message may not be an error. They are
> happening because fastboot tx before sending a new usb request dequeue
> the same request, maybe to be sure it does not send it twice. Can I
> just ignore these messages? Maybe change its log level to dbg instead
> of error? What do you think? The messages I am seeing are below and are
> the ones with "... was not queued to ep1in-bulk". 

We apply this internally (sorry if it's whitespace damaged), but I never
fully understood the problem nor how the referenced kernel thread was
resolved, which is why I haven't sent it upstream yet.

    dwc3: gadget: Handle dequeuing of non queued request gracefully

    Trying to dequeue an request that is currently not queued should be
a no-op
    and be handled gracefully.

    Checking on list/queue empty indicate whether the request is queue
or not.
    Handling this gracefully allows for race condition free synchronization
    between the complete callback being called to to a completed
transfer and
    trying to call usb_ep_dequeue() at the same time.

    Inspired by:
https://patchwork.kernel.org/project/linux-usb/patch/20191106144553.16956-1-alexandru.ardelean@analog.com/

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eb416b832aa..378d19d8e99 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1113,6 +1113,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,

        spin_lock_irqsave(&dwc->lock, flags);

+       if (list_empty(&dep->request_list) && list_empty(&dep->req_queued))
+               goto out0;
+
        list_for_each_entry(r, &dep->request_list, list) {
                if (r == req)
                        break;

Rasmus

