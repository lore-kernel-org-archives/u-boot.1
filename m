Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954A6C54E41
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 12:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92E087CC1;
	Sat,  9 Mar 2024 13:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="bFtmLewu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E851986F67; Sat,  9 Mar 2024 13:27:16 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2442887CC1
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 13:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONH+G9tUWIX3pGM+froT9eE8wn4AzO6y1LwX0fah5/AOl4Dwv7y9UA3N+Vm2i09fROcuU+SW+/nKPZ8BK8QOiQhXDUSOTBs69qowr6i9xmqx2twpziTbGY4sTHlPmqCF3t7Yl9U8MAtGRruJM3rQQWBmkBBLcPE65BVzQSQR9Fh0/h0HdxXqrYGtutg6SSUnd7V9cVz9QLQM46Qr7fkqtZRyohERGkA8MmofQ2ZqMDfKgUZ+R/Ot19MGCA7k9ltLSrRMkj8RHATZZI+/CqyeoRfeYj2YeiS/jmTF0FLh16UZnPyoQ3urT4RH9mk4YUNlGzw2oJqJXlc9ZAXt7nsw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfVpxhwnvQSG9jhuCTs3VkxYcRAPAZO5sITnIbYrWws=;
 b=QdLeScLY9gESE+8kx7OmfsTKULBrJmizgWM5LIUkOZsze1DvHWDnjU8K5V9q61Em8GXmB4a5gA166RuagnBanySNUYSpKsjWOFhCHklZ/sEcKVeh+QpvjgT1iojWh1mEFoZgKsWtfJK5razLR21UaBg6QatBDKFMSidLu/PzAnWxjkEOVGf6z7Uc1bKFFFU7g3BXWNZ1q18cZAGT4VaHHu+VX56s++qN2I4xscc52laIoGSeu2SevnvtZ+S3bLqWS1WU7SFa++q8drLOScAWGhCZnPwjorOJLC/eK8jjYm47y6W26fHLMx5X14tEL5Va/AiMF1HL11dkflyc37DvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfVpxhwnvQSG9jhuCTs3VkxYcRAPAZO5sITnIbYrWws=;
 b=bFtmLewu9tSKRHic1ReiPfVgJevjKIEJoAnApsiNHDclMW5re2IkjKx203GwjLo1hcf3jvLO4o7lAxdXh+wVHrcA6B1/wBGgKPXNuAsDXQnbpucTbP3AK8CDMb0I6ETq2DlBJycjaZR52fmhM7HSfSGuS4TKHOISAwHj3gpSIg8HXVDk8SJd13zcV/UuzMCfJ6s0JCOKi6T240bSAqwrc+E1bwkArgyZ9gNVlAKFba2EI27g1EM15EJPyaQBS5Ofl+MI9UQT0zAB/WmMBEMnfw2Dku6nnAU/FwCNCBvhLMFLB0WxjH6HfwGRTlsjK4qwMaGpGuz9QE247ErMF1twkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7826.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 12:27:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 12:27:11 +0000
Message-ID: <e654ed23-1fbb-4458-83d3-2348ec7ef1de@siemens.com>
Date: Sat, 9 Mar 2024 13:27:09 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] clk: Fix error message in clk_get_bulk
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: ed920a7a-6091-4fdc-328b-08dc40343e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6/N2uUuFmylDa/6338QjOz+u7GR3ov9SjZ7EiryANVWCj9Jy8hN6hGOaH9ZJQWYb14f/uDu10xqX4R7/ha8ByvUd5Ms0gp2hWCs8dKHoI5uXqHZoB909yfxC2D+6M24TCOURBU8U0+5q3dqzh1XA79MIkmTkVsPPp/AFR+1NrZTGgzTjL/vdRf6YMOmsUdj9Ca+Df/8RMU56doWpAKY5rr4c4F3xki+WDULjlHc4VkB3xCqG9nTVt9x4GVvE7D6u6HQPBGb7QEy5mf4XIheJmzZDwDlquh7f9h0MGCRnt2AIso9L16Vt9DyHcR1PzXbj+na3Jm3Di5rBwwqyYy0BrqS7Qw/8zK9520/hMfHJVvUn/tk/xlvNZVIe2T3s4tQaAbXnt+Ifhwq/SwiPwthWiG1tzYinNAvm6q2egsF73B/NWuH5hcE0T2z1hUgFT7gdHoBlSZFG6toc6aDaWA/W8vAS+tXR7/bmCh2sYhffMes9M0ywBuM/fkQ9m63DjPYDrUjODpSvhr6erKYUlMYtqrxTGjX62sCEyNsBOIb8ceaKvhwjIvB72JQuzGSPnK3TdnWKa7HwY30sdLJ2DoEokUeUhulEES7/hmkJX4OAqQP/vsjjq6mNgAF30PHUzjM1K0JQz04hH3psYmfvh+Pjgu/GdR+AN57xsy0mIuhgbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVENThRZFEwWEhRbkZ5ZTZ6N3FWUHFwTjhlaml2STMyc2pjNmVRZmNFYllI?=
 =?utf-8?B?aElwcnBTd3lIei9CT0d5eEw3alZIb01Eb1JyY3liOWJ1WjVmc0lvK2hGVnBs?=
 =?utf-8?B?eEIwZkxWdGlCSklhS0lRUVNlZVZOMVBFK3plaGR1eGZRYzZCb1BUejVCY3M3?=
 =?utf-8?B?OWJKR3RRVDFxak9Fb2RVRnZSdmFlbzRxeU1JWFBMcEpUVTFOSVdjaXkzd21N?=
 =?utf-8?B?aFR3ejZjN3BRM2ZtQzAvdUE1NEJFNkVpWlRoYmo5NktXejhNbDE3VDE1ZWw1?=
 =?utf-8?B?eFBtUDF1VEE3dC9wTm85YzA5L2FvRnhwS0ZHOVd1MXVXL0xyTXdSR1BSb3Ri?=
 =?utf-8?B?VnN2OXQ1MlBpMzVQNjRHNFI5U01paHlRZ1hVUFF5RDdvVnBQZFVlSkpCUkFr?=
 =?utf-8?B?czAvOTc3YU5yRnlBUjF2eHY5bE5EN1pGL0c2V3hNQjVtK09QVmZlTDFwTVdZ?=
 =?utf-8?B?VHRnNGRsUUtzRG9Ka3hCeElLUnZRTTVxQkVkRUpmdk9Kc2p3SDNMK0JVU1Z0?=
 =?utf-8?B?cHU0TEU2NEJMcys4NmgzUUxIZkJhYzcyMm4yYU1jN1kxZS9FT0ZLcll4dG9W?=
 =?utf-8?B?YzdGMlJUSlJUUXU4dHJHUXhKQ2xLSjJWRVdldXJITktmMGhpQi9FenRqUXpp?=
 =?utf-8?B?ZmVFZTFqS3E1RVAvV0U4ell4d3MwbVZxVUZJN3RNQ0Zud29tSGpweDArd0NT?=
 =?utf-8?B?Nmora2lYSkpjNXBOcGVHMnlqSmo5M3F1b2UwQjRPR01IRTNSWm1DUEQ0RDJr?=
 =?utf-8?B?eGlYL1VMdGZyK3RzZDVBbVBCRXdyNW5ZUTYxU2U2TDNKdk90ZXU1S0VpeGhx?=
 =?utf-8?B?MFRLT1lCWVV1MGNKc1hFc2VMRHhTS3hqeFdBUys2T25RUHh1KzkvTnV4VnJV?=
 =?utf-8?B?VTBhcGM3K25yQXc5UWI2TVgzeWZrRnpsWHlMVHRRcjNxSEpONTFoRTBzMlNr?=
 =?utf-8?B?VndjRXZIOGtvcHB4OWMxOElQUUJEcmVwdzQyeFMvNzEyZUtPTkhvN01vZkZU?=
 =?utf-8?B?dTBSaWJEdzlkSmNkdFJXdFYxVFVEcTdJejFPTXNKeHZNakNxVFUxTnNrcGgy?=
 =?utf-8?B?ZFF2TlA4c1grZWsxbk9qblA0NzY1UGNkQmpPdjBGc1dRTG92cEl6NjJpVmVh?=
 =?utf-8?B?UHJxL3VzTkZ1bFREV29tK21oblFqa09NZlB0L3VxUUg4TzhSK0c0andUd091?=
 =?utf-8?B?cHNQRUlaV1BmcURjWVZUcmk3Mk11VjJQMG9UUzd5bEc5MTlyampFb0haWUdJ?=
 =?utf-8?B?VXpzT2NzeGJyS1BTdHlnRmxPR25vSW0vaHlYVW4zREgyUGc5c0taTk83RkpX?=
 =?utf-8?B?THVlampNYjd6NGxUVmlPekZGNm1JMFdDTHBXVXhMRWQ0TnRVUUJpVEZhZjBE?=
 =?utf-8?B?WVRveVlWVzU2WWlZdnJ3TGtMYVJmenFtVEJWR09IQUh2Vm14eXdRTnZvOCt3?=
 =?utf-8?B?dW02bk1LaVh5VkJ6WXFCL3BvNG94eGZ0UlBZczNOVDNLSWwrcHlSaTZXUE9L?=
 =?utf-8?B?SXYrTHRiNzh3aEdLUTU5QytkYzFiT1JVS0tVZldYazdYUXYzNWN5Ky9rdGxn?=
 =?utf-8?B?OEttSlFPZVFVcWhTb2pwcVBGaFRVUStuUlVYR1htTXEyZkJ2QlgxbVhmNXg2?=
 =?utf-8?B?Q3lGK3ZKd0NqNThCbEFkbTNBMXlIYnBYOWR3dkxjU25QdXV6dEVLZUtMSVhP?=
 =?utf-8?B?R2Ivc1kyU3VSb2dDVGpvU1JaSDZ2WEhnSFJUaGEzVXExSStxeTFjR0REV1pr?=
 =?utf-8?B?MDJxbE9uelNrUXI0cGJhbFNuZkdqMWhKbUpGbEdFVGRqam1wSW9Xd2NDekVo?=
 =?utf-8?B?SGkzSkE5WjZ5TWZOR2ZDcndiSGNWM0hKSktCK1FvOTVDYjVqWXVjcHkyRjd0?=
 =?utf-8?B?RThSY1J0VTRNNGlBSXR6c1FrNEN4M2JjU1N2QmVkNnQ1Tm5TNFVKc29QaGhF?=
 =?utf-8?B?ZVRpT0QzeDl2bnB0dkdvTU1Cd3JaUTdKemFXWW5jbC9hZVg0S3FWRHl6VThh?=
 =?utf-8?B?ME9oRnFjdi9SRmlJbWFuRDZUM1o4SUtyK3lZMlh0RmFoVnFFNUdCb3E0SHoz?=
 =?utf-8?B?VEdjVloxL1lMWVlOOGFGVkg2bFdEdXRKQXRWRVRtYVQxanovQllid3V0Y3RF?=
 =?utf-8?B?Qkp5N3VTMzcvSDFJUHVQU0tQQXF4N1VkbCt5ZFlkdFZkQjVQZjVwaDhmZXJN?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed920a7a-6091-4fdc-328b-08dc40343e6d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 12:27:11.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpFqfJvAlla/GKErGDWMPff9T028bxQ+9qmTfwfEOXPUw5UluHQ5a+g6hK77x2NBxCgH7ScLDJ7toB8YR2vHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7826
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

Fix a logical inversion of the printed text.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index ed6e60bc484..78d8ea94c65 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -180,7 +180,7 @@ int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
 bulk_get_err:
 	err = clk_release_all(bulk->clks, bulk->count);
 	if (err)
-		debug("%s: could release all clocks for %p\n",
+		debug("%s: could not release all clocks for %p\n",
 		      __func__, dev);
 
 	return ret;
-- 
2.35.3
