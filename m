Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8E0C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493BB870D4;
	Tue, 24 Oct 2023 09:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="jEw/SoxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6347887108; Tue, 24 Oct 2023 09:15:30 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D156686FCF
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEg/O5c6NjRT/GtNLFuLYjfLeJB24TVMkwsQzVq3D3Ii3NOJxVtgbry/ElKsHDRpPCpC4jpUlLwpTkvFTLBOkWJVYQW4E6yo/uKqrBMjsM9Eqrwa7RBHGECr6c+7zYKD8pjhSK3z/z+4ZZHJCg6v9OlVKoRjGnyMobrhaqJL9b5/KKekJMB2hLveL/tmOvQpVLEe7JumzDHnJXGKs4bzyNnNNcrO2v38eUKf3cHuzvuR/FgaYFXRRzxTLzb6FH5kOMZkFSEb8dx9IiSJJCbyHa4nSdaYpEDMgRknpnQ+DaENrBWYONbCb2OxwirD+9/nIkfH+qp6zOLmSCHMLNUg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4t3HXwxhEJUbBSBfIPrEhuiecroPx/IF7qFCwDwv/s=;
 b=ezKNz8FvioUTetWoiLaNOOrIKgtgUvVl9J66Ns2JaH3XHjEDX85Yd2VRMsm3tXpRqQ5xK9xHBhNOY0y1viPgFDUW4+IXB0LLJUqImd+7ykDY9/FE9hF01cITV4s49+Vh5rJXfAtxm9Avg0oZQnqvR4tUtwSrtGAq7QQbbyFrHn/Rk5cg/E/Q0RMe5Tp/6ygpib0qZL6TJ7w4NWLd84f1YtIoBdJ5D6TaB6l/FNwNoZLALTPGgl1XpxLWha/FDVRE/vCePvvPA4AJHLVEQu3rhk9ujneguGpZPQ2HYzff4mHcO0R0jrQp9amjGBqWSs9UoADO9bjZEM1he3Vz6Xvr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4t3HXwxhEJUbBSBfIPrEhuiecroPx/IF7qFCwDwv/s=;
 b=jEw/SoxVPh/YcDMw6Mx82Xvy5OOZ3iVRSgSWinXsvmGWxpFHJyl5GQrDF66jIaPJsXsOK7qbVlDezv3idrRW9dVTSbCaQXi5w8m9tvUhCKT2kWvCveuNHwLCJv6/Y6wJFfi07449oApffwZOXShSUOSIaNoD0fLAqHXTohq22GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB5412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 24 Oct
 2023 07:15:26 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 07:15:26 +0000
Message-ID: <49c6580f-1e7a-4eeb-ad8f-fdefbb99ad8e@kontron.de>
Date: Tue, 24 Oct 2023 09:15:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mtd: spinand: add support for ESMT F50x1G41LB
Content-Language: en-US, de-DE
To: Igor Prusov <ivprusov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, u-boot@lists.denx.de
References: <20231017192926.54397-1-ivprusov@salutedevices.com>
 <20231017192926.54397-2-ivprusov@salutedevices.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231017192926.54397-2-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec2dc00-5a61-4a92-1c42-08dbd460fede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIAc+bb3UaXKk30tFQcdpYYTKvP6z9kiBdjpYIp8j0JrRBY50hi0fkTuPFixm3jqAXBBuqouxSq8ZiVXHgp29N3DgqJUez4+1seYgCtN5QSboYOX9z+6juRhtHZfoTRndLAmF9LiomrvSnMUzKCgnKpDeDOGKT0OcJuugQXWyLHZ7dkdJg533Nw5rV2yL8nFj/74Jw8RIGw1THtjIxFfnpx0itlgFoezDY9u+noRHVqtEg9/SXMr4Vo1P2H1o+cGTb8JMFL0InW/qq79Zr8XUbi4dIRLiMysmx8peOgI1Q2KICMizhsooq4Q51OUDezY99QUjru8s1TYXuNCzd9Ho/XHHw0Rifwt7LVpfnuf43YkZAdhKjzM3FryMfH9X34Ix6UAVUg8c209VK0j7LPsixyj/0VPs2FWBRgVh/ZsRJLGaCAegu0FuJYDEkSC8UNB5t7Ki5Q2o7PiMtYFI4BcsRJuzL0aJpnvnv8snWlWCr4XM0aLX7GcwneMySxT95wjktxrZgnW0lGUIrGBprkEFUiUNUeOTmupKAnb17SX6N8YsoO6YvQCBYOQjMWVX1Z/gSwEOYkUh239JO8vlCfz9Y0V5K9cvnqN/txSVJz45AvpB0HT88MlDnDZwPsWRUufGylqm7qAYiAwOPaHMQMvlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(966005)(316002)(6486002)(2616005)(44832011)(31696002)(110136005)(2906002)(54906003)(8676002)(26005)(478600001)(5660300002)(41300700001)(8936002)(4326008)(4744005)(6512007)(86362001)(66556008)(6506007)(38100700002)(36756003)(66476007)(66946007)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEY2c1UzYkxCZmF0K3hoWUFqd1AyZEE3RzBxeWFxblU3QmZVZVhudjVSQW1K?=
 =?utf-8?B?MmtnUXlHL2haRWl0NUZ1RitsQURJQXBHVHlPaFRueks2V0xRai9kYlpPWkJh?=
 =?utf-8?B?M3dnTmxMY1pVQWxqUUN2SjRIYmJlb1hzMkl1Mk1IRU1WUCttcUtzbDBzRFVr?=
 =?utf-8?B?VmFyekJRZ1h6N2phMlVHamh3anN2cTREK2RQbDExQXBIdGU2d1ZuVEkxUEM5?=
 =?utf-8?B?bGRmdUpLMlYxcVM2QlB6SEY4UVd6TlM0ZHZHUlBETXU0QXNHay9LQmdBbERN?=
 =?utf-8?B?bHlpeFJ5aUZEYStuL1JFeW5GOXdFSnYrLzBqeWZ3YUNiaGJ3NElLdHZPZHc5?=
 =?utf-8?B?bWVhaFZCRmhjQTBZVkV6OUNoOTBya1hCYndPNDZoV0h6Skp6em5QN2JaaEk4?=
 =?utf-8?B?UitMbVR2dkE5MFVSZ2dERWRuc3NSUUN5ampRQWlPeXZhcG9LSUlISnRLVzlD?=
 =?utf-8?B?Z2gxM0N2RjFwQjgzM3NvT2EzSEVyM3VGdTR2bGp6L01hOHJqS3p0ZnVoOVRS?=
 =?utf-8?B?TjlVNUkzYjRnZ1NvOGVXQ05vSTYxd1Z3TytVU1BBNExyYWV6NUVvSVM4Y0dQ?=
 =?utf-8?B?THFDdTlTaTU4Ym9rWEpybWh0cVM3cktwb3FPSDlRNnJuMGpCNTBPREg0NUNQ?=
 =?utf-8?B?RzM3bEZ0TnRiRm5hbHNaQlBwY0dydExNWEJlbHp1SEZablRNN2tQSW9GaXcz?=
 =?utf-8?B?NmRXYjFvV3JYVUVub1E3ZzQySkZHMlB5Mkd2a3g0SDdZcENETGRZb1ducEIr?=
 =?utf-8?B?bHpzSHZ5S25GU2hubVFsRUVEKzlYWXYreHl3QmdCdHBYeUk3eERaRkFiOFBx?=
 =?utf-8?B?QVcyVzRNR0o4RVY5bmhya2ZMMzROS1RKeDZsclNsMlF5YzhlQ21zNE5FWnhx?=
 =?utf-8?B?NHNLRW5NOGlvTkpmQlN6bVk2TGVEckxGR05CeFErQ0Ezd3oyV2ViNXJRbTVW?=
 =?utf-8?B?d0xKMk5sK3g0bEhNUFNEN0ZZVTUyZGhzYUd4OUlWZHhBVWRLRDNQeS9mY3VO?=
 =?utf-8?B?WDRuenVmUjlNKy9QUUdobm5ia2MvVlErN1NkUUJLY1RvTlQ3Qk9KY255aVNP?=
 =?utf-8?B?S1pySVZteFVwdHNBTG9TUEk2Rk43TjcreG1MYkJSU1ZMK0ZCRVp4cmFWdkVr?=
 =?utf-8?B?bE1MWUVIbzNoUlFBTDFlK2ovOUUySUs5Z09HMWRsdVkwdHpMV2RIaHRGcXhz?=
 =?utf-8?B?ZUM0NTluTXpqODVWM2RjSndvU0ZBU2hMQnRNc0QxV1ZiWkhLdjRGR2k0V1A4?=
 =?utf-8?B?NG5GN1BaN1o2a0xIQTRDS0JlZzVqdjFGb3hPWGFkVElDaE03UVV2azNHYkg4?=
 =?utf-8?B?WVpDZCtKalVMcDBGNnQ4UnJ4RlM4NWMzT3hESjlYVXJxN2owMDFiMS9GUk1F?=
 =?utf-8?B?MnU4dzBDNVRnOE5FL2t0RzV3V1FGWW5jQitKY1VKamJwWXcxSFQvT2lnZGdm?=
 =?utf-8?B?NHZRNzJCSmYzdllTZmJOSUV6SlpmUnVHWEp3NndQU0x6cFd3SmQ0MmFKUlQx?=
 =?utf-8?B?SWRRTVpHNWJvQStsZzgvN0J4bUJYbzcwZWNhcTMwU29Wd0xxSFRlUjdhb3ZJ?=
 =?utf-8?B?bEl3UWxjL1lPSEhOUEVBSEovOHgzQ1dJaXQwTzdYazFTSENvcHM1YkJxU2tk?=
 =?utf-8?B?VlFnTUpENFZLbTRQVmNnWEJhZ0NQSDljV3pwbmZ4VGFjd1dtdTAwZmZZWDBG?=
 =?utf-8?B?cko2aEJSUThGRk1EY3BXc1NOdGZ5SzZRYUVISno1eGpUcDlUbU54K3pTZkNw?=
 =?utf-8?B?eDRIa20rTld4NytTWGdRZUNENUhlWXFqM0ZuTjJabFB6bURKblArdmo4UGlQ?=
 =?utf-8?B?aU5EeDBUYlVDQzg4QTNqV1dGOTlIRkJXL3dkdEY2b1hsZDdTclpiSm1KUTNw?=
 =?utf-8?B?UWV1TlU0cEUvVzlvVktTbVIxQjVIVFFGZDhyTHIwTWFxakV5bSsvWkh1MXVB?=
 =?utf-8?B?czJVRmZWRDF4VVBCQjE5b1JQRjUzRzZXdFltMURtMkpka3pveGh5T0hCd1d6?=
 =?utf-8?B?a2ZGbTc5dTZkRGJFM2d6SGxwNkdITFVRRnRGZ1dzSmlmV0krTDdoQlpWZld1?=
 =?utf-8?B?T0wyYlh0MjR2WU9WWjhBUDNoVFBTaG8wMVgwZ0xrTStKYU51WHRvYWlYUkNK?=
 =?utf-8?B?cmtsSHlFa3hyQ2lkMFZJMlRLWTVHQnFOc2hJYkttTkwyYUdhOXd2VHRDSWNz?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec2dc00-5a61-4a92-1c42-08dbd460fede
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 07:15:26.3146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXqL9ik1PWCgtUD/imdPLy9EXJxnM/+w6YTpqn/8FL+OYH9/fzik+4DhEWb2WT0r1ZyIs0/6ilVzsyGSMdUWNLZhPhZnj3Yuw+b7raivw54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5412
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

On 17.10.23 21:29, Igor Prusov wrote:
> Adaptation of Linux commit d74c36480a67
> 
> This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
> It seems that ESMT likes to use random JEDEC ID from other vendors.
> Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
> Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
> JEDEC ID in variable name.
> 
> Datasheets:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Tested-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
