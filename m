Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B789EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 16:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C85487484;
	Mon, 30 Oct 2023 17:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="uVttQFN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC50887125; Mon, 30 Oct 2023 17:20:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25CE87484
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 17:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ohAz9TPx1S5lUhmZF93wDs2NJ5aM8bAz57YOJAsp8RT1B9Wy0rjwq3N4iTjOc170C/KHmogML7Qh1/cplfC+wmloZXaOiKxrZXkUsm3x7WMmf0ONc7eJ4XF1iLXk1uXrjlzQCOWVi5trc7Iu6Y0EdjDILPhQwS6Tzq3dRPcUnxCZxqPGNmPiFBkkICQCiLCkSCbn48+BspijBXpzE/Zn2hJ6BsKaar8HMzXyNXCbNv2/loRPagzFcvXTwJOg6UQZ4kp+GL3CqCAI8uM+vehLExMl6W4fdDmVLWPL753Y7RI78O3xchamZdTaNQCkcx5WrE8Q5lKbcw7RlK8lLVDHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXzf1quzOVjts9C2nUFgGwSgdQZ/HibOltAV4L4kkRk=;
 b=eEcf0Ky/3vMgrMYW6jbT9i+cjioxMGGQ0WDxnusOQa0rhUVM8F4xq3sdE7hDEo4rVLT1jBSn8XkNXAdLRaaC5RCeVJhQLemoh9zQplyFdSWHeKLy2TAl7SqOGIzHHd0PDi3WyNJIJ2ckxq/54h8avJkvvN8R3BZZEbIG7/goEmzTzSaqPA08qeDE/0JRT8k+pzsrPIFH3mGnDG9L1cDI2msrQQEivi/qouxnCe9T6pikf5VXFNFn/fmf2MWuOJ2+IlkCqeKTby5xwigpIpdXOGmE/vVLMC1qTPZDTN+ZF9/zHm5pUkMuVFxxVTuRufM6qJEJ/h6O24/T6icZEXdM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXzf1quzOVjts9C2nUFgGwSgdQZ/HibOltAV4L4kkRk=;
 b=uVttQFN35PkUFi4p+/zbM+8xmf8jCycw0mrH94SvaIdDaCIXOffCRQtKERUaCp1F1t2CYL9HrhP0vB5w6e63r6PuRjYmBMCrC8Vi1PGFwEDoOenVF4JxMcab7FUzoWtxTMMTNtg0tttpsecMyKXeyoxXw+7fexYslKXCo2pKsbI9XB2qmdPYAyt+58xSRJRr+5NeMMCPvuinD1UpvOs+Z1F/Z1e8eBZ1XZ0CxmbqHhLXwT3oC3XqW64OYXwCzzpW09tURxYv80oaqjoRx9NT9G/CZAzj5+3BpVqXoBGnQwgY4n7+kxtXp/k2sYnHp9YgGzfbfYmdYci5LJNjChIFyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3636.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 16:20:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 16:20:31 +0000
Message-ID: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
Date: Mon, 30 Oct 2023 17:20:29 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] spi: cadence-quadspi: Fix error message on stuck busy state
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3636:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0b89aa-ae25-4976-3013-08dbd964232c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htjWZBb3MMG0AV0AxgGNTL2ulohl82S2XL6/9icyUbFeZ87HiwL1uMovvs/+XVhizxxOGh7wrMTfPKavPb3AHx5r5bkZF7Aq9vywz6dOZ2R+0ES/1dcfHoxpq9Ip8+R2hY/IOSAM0JvLg1Q2huLIsn8VF+eGOOpp8ZAtfR8cgGJmHMTGAanqwtXZV5uJ2ZhgvhjR2V15jv/3ZKCoDIFTHAF8rJZubp7NhCMxn4tkQPdmweaXK6Xigl9uvdB+qh+Q6xOBkvNfzYPMVKPJGSyPW71V4o7Sd+m1vPZ9Yzwc5jf/3hQwu094qDRZntM9pKrDzV87r5qAP2DySJ929Ye13ho60PNezKeE9oA01/aoWH0sfeezMsCUMJpxxccNe26AmOaxTamboapRwXEZXc6xL5tui5ScpFwj66D6c72V6pNcWCb/Bc3XInUC2MbYq5jeIbZ/WubWZJvBzHJXPM8r203KyTVhCWgdCcaY9MP9xunqgiN1aOZsARD7IDXBWIeeIIpdcsz510g65onTa/xdTPmmf1vgwGeT/kAWnV0zk22hy1Dy4XXjtbKYboWWR/Bt7Kc+GrnEAvOsFotu1jEd5YE7kNZOJWxGI84LBFTQFss9RES7TZPx/x/yN/zPrvgwtoZJpMtraaNuBnzo5uIexA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(316002)(66556008)(66476007)(54906003)(82960400001)(110136005)(38100700002)(478600001)(45080400002)(6486002)(6506007)(83380400001)(66946007)(5660300002)(6512007)(2616005)(26005)(41300700001)(44832011)(15650500001)(4744005)(4326008)(86362001)(8936002)(8676002)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXdTZW9uZlNSRTlleEQ4V09nTFYva2p6Rm8xblYxRTVFYWJ4ZGRjYWpqbkxR?=
 =?utf-8?B?aDdBakgxZFYzaDVHaXMwL0FpckxFckFWTDU0blI1MnlGNXd6T3o3TGNBYXdM?=
 =?utf-8?B?VFgzbkJ2Tnp3eXZaOW9CakdsTTJvbWNWdXY1Yjk3Wll3bzIvWmhBcVA3eVY0?=
 =?utf-8?B?V1NxZGZhRXVTOU9ydmJ6LzZpVWR5K2pEOFVlbXgxc0JYbVM5cnJVWmJMaGJ4?=
 =?utf-8?B?UmQ4cTI4ZC8vbzNhQUlmK1NVdzVZOUJXYnR0MHdFdDZxKzllbiswcEJvYVdi?=
 =?utf-8?B?TzVNalJTSXVnZExiR3NFMUFDTHRRYUhoTDZ0YWpjOWdMeHQyUEVsUk9YaG1D?=
 =?utf-8?B?aFhzVEcvZHdZQlh1Q202aVBJSENKUzVQZEF2dUozY1BKaTJVdGgzZDVjYnJL?=
 =?utf-8?B?TTN0ZlNIVGlVVWJFZXNRTWcranozRmxkaDR6V3RlQytsZ2doNzJNUXlMTGJC?=
 =?utf-8?B?UnREbUVDay9rUjI5dlpLWER3L1pEd0VLSHc2Sis4bGhwVURMeWtLbjlPaUpW?=
 =?utf-8?B?NTNPYzJqSzRpeTB1UXBDQ2FiWWhLZlZ0TGpHUktHM3ZYNGJUVC9CRkFqRi9m?=
 =?utf-8?B?SjMrT0lNMFExT3MvbXgxL05NN3ZMaHhkSkZqRi9OT0piWkliSHIrSXltanpI?=
 =?utf-8?B?TVYxN3RHeG5Qc3prRFZOM1Y4MjA4NGlJdVhVNEJSdmN1aDBKSEZrZGxmREZy?=
 =?utf-8?B?NHh6SjF3dUhydDNsQ0NoYWxYUGZyTTcwSlYvZWg1SzkvMmZ5cDJVaENOcGhi?=
 =?utf-8?B?Q1pnMEVSeUw2SVhFWXRsYjI5eVdNTzljVGcwOGoyMTIzVVlLNkJGYXJhTmxI?=
 =?utf-8?B?ZWM5d1F6M2h5UFBWWDhJazl0alEvOEFsUlF6YmhSRmxNZzZDT0YzUnpqLys2?=
 =?utf-8?B?c3NBU3o3Wmk0bGc0OERMdTBZZUh5VituNDdCbzhwSWIzangrRCtucGhqbXNU?=
 =?utf-8?B?cytzQ0Nud1haVnVWREVEOEgweEY3NHM2dG9HUkVFVHRpT0NaSzgwQVZ1K2tI?=
 =?utf-8?B?WTdsYW9jY3krQWQ1UzlCeGhPenhFSzQyQlJmay9QVzBweUVLckNnN3VKWHp2?=
 =?utf-8?B?VTN2VTFGcmRVZitmaENVSlZKcXJZclBLTllrak42S1p1ZE1lMXlHcE1sZVNM?=
 =?utf-8?B?cGh3eEhyaVpyblZkdk9Fd2YzcWFST3NnTHFDUk5MMUhQdFM5d1NsbFB1c0tl?=
 =?utf-8?B?OWJtejErTDcycEFtYTBMaFh5ZnhrSEx1U2RmeDJtYVB4eHdESEpET1FDbTl4?=
 =?utf-8?B?OTNXVHVoQVBKU21VVTJHV2Vpd1lOOGdDVmh3VExrS3hZSXVPTmZCRXFXb1Bt?=
 =?utf-8?B?T2pVQ1BSU3lzeWVaRUFuWXlMMVYyc1VTdTJIZkVTTnZ1MG9pUkhLYTZHSVF4?=
 =?utf-8?B?T0lrb2Vib0dGeVhQeWhSL0tQaWVPNm1BZXpoUnc2b1liM0NJU29yS1pxK1hK?=
 =?utf-8?B?WmQ5ckFIQTdlR0RKK3RaNDBVZU1GbW9BUHdicTFpTHA5NlRvclFkVEFIRWlo?=
 =?utf-8?B?Vnh5cFQ3Yk1sZTR5aXNGenlHcExxNmhXQ3NtTERYbXRFczgwZWc4ZlMvZHBD?=
 =?utf-8?B?STVJbTl5MkJnNjJTV2pscXJneVlMUmtZKzlpalZOSGhpdUlhMmFHdDF2aGpp?=
 =?utf-8?B?SVdnS2hSeXBCcExUUTBZQStFSHo4UGJXWDc1SUhsV2ZNTGN3OGgxS0dmQmtx?=
 =?utf-8?B?UGdZbmdBc3M4bXdsTytnNWRqMnAvSGJoQ01XSHFlRGRKcG1vV1pXR1JJeFJu?=
 =?utf-8?B?Tks5VnFLek9QejdLa3RpalRMbmNzUlhVS3JZc0IvSkprdGxIUTFQUTBqQUFM?=
 =?utf-8?B?VDBXeVlPMUxqSnU2Rm4vRU8zQ0xhcTZVOTd4WHQ1eTBGVkkxQW12NGQ5YVUw?=
 =?utf-8?B?Vmx4TW93WkhZenM5OGpSZ1ZRRnNhbFBqUUU2Nkl3S1dRdE5tZVFYSkdqN0Zx?=
 =?utf-8?B?b0JpZ0wrbTFFRWRncDhuVUFTNDI3dkVNZ1ByeEdlMjlnYVZucTJqYk4xcGFC?=
 =?utf-8?B?bzdXQUxOcHF3aTBjNzFYN2grcGNpc1A4SHNZVlN3UjVVd3lwcWFPM29TK3Bo?=
 =?utf-8?B?c3gzblBseStiWjMwK1YvMy9sZWhUa1VHczRsZk9ISDRkUGhsRjlpWitML0xs?=
 =?utf-8?Q?u2OmVJzlmzva9YWa+dk6yjBLW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0b89aa-ae25-4976-3013-08dbd964232c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:20:31.4235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuXo0PL2+EHt6Q//ZGHqYnvQhPi331UTWH6sWawqsv2gLDBYLbLyHEkqsqcJwrGoliyvWSuvEnGPaJ0QllW0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3636
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

From: Jan Kiszka <jan.kiszka@siemens.com>

We are not iterating CQSPI_REG_RETRY, we are waiting 'timeout' ms, since
day 1.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

We are unfortunately seeing that message right now, rarely but then 
prominently...

 drivers/spi/cadence_qspi_apb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 9ce2c0f254f..d033184aa46 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -171,8 +171,7 @@ static unsigned int cadence_qspi_wait_idle(void *reg_base)
 	}
 
 	/* Timeout, still in busy mode. */
-	printf("QSPI: QSPI is still busy after poll for %d times.\n",
-	       CQSPI_REG_RETRY);
+	printf("QSPI: QSPI is still busy after poll for %d ms.\n", timeout);
 	return 0;
 }
 
-- 
2.35.3
