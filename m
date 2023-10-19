Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FD8CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCC3871F7;
	Thu, 19 Oct 2023 12:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ws0Qbdkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05AA871E2; Thu, 19 Oct 2023 12:29:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787AA87204
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlYCkWbkVV5brI+8MZJerD4vvw6ONIAoS0887bi6YKwGcy1BckdHYDOMAFaFJTHEAbJ08wX25B8Cwt+qQgV9LtlHlcEu10/YXj1oRBlnGk+j/iGVaQkSVy3iD0YbqUqZGVHUaz/MtJVZICGVBWVFWWjYbXuPie5ABwLEeHnExVVwIsLtNOitfp3CNtMlmVgXU2QcBvlRRvWWCDefM031iSiiFy0DEIBI1MiMTIifRp8PgtpPVDwcssP4SaR2Jb6ia5XhUpPiOrlwJd6Ok6uPR+42d8JVK6nnswrACOkuzohvcfqUbQhfWmPy6Jq+EBuEQuidsHss1WV8m4pEcTo0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcmUbEEgy8sY8zVLqGlaZSx7WDoGi0kFo7P7uaOjZ2A=;
 b=HUpmy1UoJxUt3r0vfyOx0a4RizqHfaje0QbkYWb9JPF0a59+76aaSBydMKNZqS9ylNOQBrr2ES1jyY3dMf37/701SpI9kDumAab3FzauE9Z7qe6hxhJ+BSM68/SsO3niltUFiYD8pHYmWjHV+RFvd7DgB+4hTcedbjlbW1mRhxJDe55S+Be1BsdSoboSeCsQNTakIX6V9JXlQzhQfOYqOL76QScZKpITD/1lhCTaE9UAqI5XZKpyZcDluHNvYmHwqYU9/qC0Us91Ahly2vJAJi68Nf/zRerhJUmU2hG2bCngufbr0UszWPIrqmuTJbbC3/JJUziB62LVh1YpUBoPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcmUbEEgy8sY8zVLqGlaZSx7WDoGi0kFo7P7uaOjZ2A=;
 b=ws0Qbdkbrftcj4pw4OT8M+yVgtnnVaYLzQtn86MFjZmoCCZtAxQ+3NLHyGjUp3nC4lMEhHW1Y0MSqlzJjDeFavnhET5bAoRiROIL3el7zFsIgEkW9MSYOrb0WMyERQtWfQkfZNjHCp/f9k+COl/AwB9taSIXf/MD//gWu5GY8a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:29:39 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:29:39 +0000
Message-ID: <88df7960-979f-48ab-bc7f-78ab6f012ba8@amd.com>
Date: Thu, 19 Oct 2023 12:29:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] arm64: xilinx: DT sync
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <cover.1697115523.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1697115523.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc081d9-16a5-40c6-796a-08dbd08e4c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZHkPhnR/7CfIZ8Y+ME6muu5JVXiVGASZAXHdYPB0joc6yKr1FdUpw5PzY6nsWN3uhf3rhX0mXQFp7a1kChkYj/J4RPiRQGkSPqCLtGIVSAsXlMzsCZbDe7g03lmX6fKzMRLx3sKeZ0YMNi17FWJdTNsGzYB//bQmQaHWWbvkpyNTvWGONnGD06MdvZFEWXni28yHgGdbuUmzVpfcPBPZrhyTFOokCa5D/sApB1R/Z0QedXf1AoopEt1Wzwoih4rKKPzXEoefbu03V+PYkl08iu666ZMfEUxYFpZxWnud3pPLNet2EW8aV0AdzQte9jZkkE3b0sPLVaG41TAoH+enwCBDJxCjDI06VBioJnoqdsqDyBdKWWy4TjxFBkennpITCqxzisdaB4jjcfq+InZyGe8upk3DGAG+F86IPndrf7/uJUH+Wi9YGpnwztHlp1yayzGW6ekMVRCiwl/9fUmEQH0paNl9LtroiR+YWTLDdqsVGDLh+2dHAeaEN5TeulAcLfOz4I982SipVBKEnZD80+GVkXTKMiFnPaAaalnh7v3W5scmo6p8psI8gsv7TOY/FpQplyl+onaevRP0g6yI1aOg4x/5NN+jAIxPM+NSZ4Xr+C9Bkkj6Z6Ob1+9h3tHYgV1AFxwY9rOmrYkB0KBiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4744005)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(54906003)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhQSTBRSzU0aHUrTFBrb1ZsYW9HK3Naa1VuQ2MyOFhmNlVpeXNsVlJobzNZ?=
 =?utf-8?B?UzA2SE1RblJHdEVySlJuWmM5MHM2d0trcklGRUJKYW5TM3lIVDhmeUxSOUls?=
 =?utf-8?B?TDJUUWR5eVh5ZUdDZUpDdWkrK00xMldkYlpTWldueldIRkdIdG05R1RlZFVB?=
 =?utf-8?B?V1dJSFlLMHp0RFdJcG9QN0NxaTV2VXg1dHZYSUhZWTJwOCtNeFdnM1RVQ3JZ?=
 =?utf-8?B?SzZZWUxLdFJKREI2aTg1aU9FNjFiYldZNUJoVVpoVUtLZndaNml2VFRESWpM?=
 =?utf-8?B?cEp3elpTRGphdGhzUStyTldjMlZCT3VmbGtJUW52Z05ITG5WVng3TGdBdytp?=
 =?utf-8?B?aklTVnB4djNkMlhSaE0xanoyU1J4eFpicktvS1pMNk45RGsxSW90RjhKc3d3?=
 =?utf-8?B?WG12V1ZzbWhQcmNaNXNlRk42cGRGNnhxcWNmRzMzdkh6WUMwenR4SEJHZjc4?=
 =?utf-8?B?dHhic1VpZTlFTFBIaS9rTmI1MzBhR3N0eUcwaGttL0VaVjUrc1k3cC9Ick9L?=
 =?utf-8?B?dTlrdzQ0UEZqdzNxWUpKajBPaWZJbmlWQVgyUEZPaU4zR0sxOGhZNFpNd3pR?=
 =?utf-8?B?UDAzU0RWZVoyMzBtVWRncWtHZkZsMFI4VEVaZ0JNL3NINTQzdFd4cG5KS0g0?=
 =?utf-8?B?VFl1SU50OGpFQlZFY2owRUxLS1RnbzNHZTJtUlJDZFp6M3ZtSVJ2TUxVbGpr?=
 =?utf-8?B?YjZnN2FXLzBERHlFblJCWThFVkcyNXlJQ05WVjQ0cm9ZZE1OUkIrTCt6Zkph?=
 =?utf-8?B?dnJNVVJaY01WSUtNRXJJUWk3RWdFS0MwMUx3aTdLUW1zbFhGSlVoMnJOWnFO?=
 =?utf-8?B?UnZYWnI1MkZ1MTlYd01iRjlBQjN2R2wzUnhydVVTU2g5dElxS2VBcjllMUFo?=
 =?utf-8?B?WkppNlR2dlA3NlVNQzBYbEZYaCtTbFROL1JTTEVxa3FPSUJ4cVk0OWVHR2pw?=
 =?utf-8?B?ZHBKUDNYS05SdHJ3dzBSc0NmU0tpTGgrNXczeGZJZzFOeHdzRnlVamlza1pr?=
 =?utf-8?B?cXhaNHdOWTZxNEQ0NjB4d0FEeldsQ2o2WGV6Y2s5dVQwT0ZoNzhPZ0lWeG1s?=
 =?utf-8?B?NW9STjIrMXBUUnpMM1BkWlc1NGJwVTdDOTZMbHhTUjZFSGpLVWFmbVp6aFNT?=
 =?utf-8?B?cWlQcWZ6c1VpK0Z6ajhxZnBFaUNTUXJ4Zklic2wwcTFycVlmYUhkQ1piYUZE?=
 =?utf-8?B?V1RTNHhBbXZWaVcwMENnMFNMVDA1QmRCQ1E5d2h0UURDWmNKM1RCMFJwaUhl?=
 =?utf-8?B?U3FGei84TmpLTVc5M3NBbWRBQmJxTXd1eXlOYklIcnpRaWJpbEtiUjY5NzNx?=
 =?utf-8?B?dEtjR1RoSUswTkQyVDhaWmdjUjBsdDNPeFhMRWxROThPeC9xbWdsZHkvendh?=
 =?utf-8?B?dUo3RU0yOHZQVklNZ0VlZnVBTW85OXdoMGRjMGZOd1JkUTk5elc3ZVV2aW9r?=
 =?utf-8?B?SEFWKzlQR1VtVTM0b1RzS2ZrYmNCSmxySHRaRVl2cmtZc2tTS3UrWkxEZjgx?=
 =?utf-8?B?UldRZGZnbFhHeGlEc3dQemlxL3Fmb1FYYXAxV01BWHZhQmM2aHBwditUeVB1?=
 =?utf-8?B?eFljeko3bFVHS01PMDFkcm9kVWRHeG1jVzIwZno5c1hDTVloVjc0YTBzYWI4?=
 =?utf-8?B?TGRGQnFmY1FzbTZQTHFkQVhRdHZRajMrU01KL3U2U2JBRnJHZHFZTWw2MXpX?=
 =?utf-8?B?TmlRUHZSMVhuRnJEYnIxNE5Pa3hTTkZLR0tlOWpiMDNMelNNRUtMeG5SU3Fx?=
 =?utf-8?B?V0NOdTl0SU8rYk1hY2xxRWlyYUMzSTZ1NzA2V3BUWWRiSWEyZzVYQTBmSjlB?=
 =?utf-8?B?em1mZmM1RE1XdXJvNzZTSTdFRWpkd0lTMStYald1dnNMckd2UEYveXRmUHRy?=
 =?utf-8?B?cTY2TWNQREZ5S3BIY3JCTHRiRVozNStmbHZIL3dYb1dxbnUralZGMDJHSDlk?=
 =?utf-8?B?ZkZiNEJlQTVQSndzWk9kdnFZajFLWnFFSS80Q1Nxa2NEZllNUnNDODlIdVd4?=
 =?utf-8?B?aWxUNVl6RGJhRk94eXpxVWN2YWJwZ1p5SmlucjZBcFVkK3Rxd0pSdnBjV1pS?=
 =?utf-8?B?RG5rSk5mR0ZnM0hTUXIyYXI4enI4SDJEWitMT3IvUExObGZGZnI4TEc2VnZ0?=
 =?utf-8?Q?5jOp83oQQYdYZEu2kdRyIl1Gt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc081d9-16a5-40c6-796a-08dbd08e4c68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:29:39.0290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhXyFb0W/cC52YimCrS+WutBlfFsn6tN7hnSEj+Hh3kn6I+CQzW+wKIB6Zg9CXKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/12/23 14:58, Michal Simek wrote:
> Hi,
> 
> I have found 5 more patches internally which should be also upstreamed to
> get DT in sync and descrease amount of differences.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (4):
>    arm64: zynqmp: Use mdio node by vp-x-a2785-00-revA and vpk120-revA
>    arm64: zynqmp: Remove xlnx,zynqmp-aes node
>    Revert "arm64: zynqmp: Add power domain description for PL"
>    arm64: zynqmp: Remove address/size-cells from ams node
> 
> Piyush Mehta (1):
>    arm64: zynqmp: remove snps,xhci-stream-quirk property for usb
> 
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 10 +++++++---
>   arch/arm/dts/zynqmp-vpk120-revA.dts        | 10 +++++++---
>   arch/arm/dts/zynqmp.dtsi                   |  9 ---------
>   3 files changed, 14 insertions(+), 15 deletions(-)
> 

Applied.
M
