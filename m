Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4C5E8181F
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F1286B95;
	Tue, 26 Sep 2023 08:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="m5KGzJ2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9E186B95; Tue, 26 Sep 2023 08:25:50 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98B386BEF
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buLQUzWx1SIdji3AM0rOz2s2pHeoWt3TE9SQU0mOH/4nA+REWufLdXjfUC4BDnqcI5jbCdjZYwqRQC0fCmZa+HhPR3GH96SzQjD+xb2zmjmQA23PbTmY94VKtk/yrrT+E48KPAwNfhQUI16yHSGmUGbU56nYYG/1LgmdSHp62IwDp6FiIZJX8dGuDCvARn6QuNiLwZDuC7FS3Nl+L5HHHiNQ2cr8JXup0zfXRrDuze1XAdcqRKF/pPLjRzGYnDnofhgTCiLyYMTs0v6xTnOFvIeG0MvqcU84eElLI886WuvN405WllTEAn/IG/eQ1xEMvOaqxqqVOQlxj5YYuaLWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o1ptiyAfctsqoW69bduaQsDA+Td3UE/YnRry4OrC1g=;
 b=MMUS1eKUMPRTMdG012B37ce1FA0Gm2aFKpJV6pd1z9pZ5/ak8K0X1Bo6KQ7Vm6ShxMdcpmgLQbN9PRh5ZkJu/A/w+ukkBIr5+E7CXT6j9puxas8844ea2I5jcecal3P+IuAccGVB6+n2s8hlvwe0EgtY9DeYZCz75W4C57Q7KLWJYkswv9MvfXpb0U80TuKNsvFODAUfNiE8Xoenpzu8bGaOqJNhAF4GcVlwHM6vyctem4fUfHddGQNj6N5aDj7Q+BHzBhkQ4404cufKFS2IqpQEZk3OgfAMI0jPJN/pUYNRPCE4mJli+ZqG7pgRMFP9zUb087Y0Fj9f/9hbK1oUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o1ptiyAfctsqoW69bduaQsDA+Td3UE/YnRry4OrC1g=;
 b=m5KGzJ2j7s4Gt373oUS4Ccx2++VoQ1uNm0Q2/o+2/JOz4GF3CR5bUQN2VztCI10e9CSc/0PdOjtaqiDjUm2M1uKAil7Bw0o8IhNXYg+t37MGOTZ7Mg4AYC8PQPe48X/ueTZd2M9yQcIeADoivkXiXYWA8bqkL4GQgaUjgyy5Wpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:25:46 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:25:46 +0000
Message-ID: <9f8ea578-1b32-f0f5-02be-ffb267cb6197@prevas.dk>
Date: Tue, 26 Sep 2023 08:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] binman: update documentation for fit,align property
Content-Language: en-US, da
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-5-rasmus.villemoes@prevas.dk>
 <30f28625-865f-8342-95cb-5017c0db4277@kwiboo.se>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <30f28625-865f-8342-95cb-5017c0db4277@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9653f5-e3b3-4edb-4898-08dbbe596b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZSGfyekQ2G0+8l5KFETcaU9dJirRBW1HcWDj270ZOJPHrpiLf/sjRflwyfGJ9du3VdvMXr3CCbdy8oq19tKd9V+5iOHegQFWQw5txEs4nHP2r9X8W/+O1nb4wHBX5Hf63+adPi+nlouePfifo679Ok3kLWnooF4K/Ij/g6GUrFiJnqsMkkJx4gq8LLTvHSWhE5ZgxISG+8lGDAq2shSpjtFXjUPD2PNvdCyBHjlKyE/GJ9jDxcQgnpXb3B++XjgMtSo6z3gClvrMjI43WaNRn/8UmQuBssdg+dCezp9axSDBY5/w/X9qX4E3FqXVae+UOCOHYrk1D0GHhhGVDA1naMWtz1gjy7F+VtqffXr475YL9dlV7VExbuUG0q99278MGJ3NKVSI/kiIZBFn3MRtSER8B7OPqP5Cjz8bb+ZXV6Q5Kn5yzYdzzkWqEHAwzbVbZwo99ynO/ig4WshL0K8gPJDC5oLct4jbzFHvBEluKifOPvH9KwiqcuxpMNi03Yb2jSAGJI5oJkd+Wka9tFxZVzS6DdPgAVICh88Ss3E3V6Z0T8klPoXP8sVNUEkJ/FQDQ5aRCnejzqzk7/VuouMpABnOTQmkbSXQB2Y5z9/Z/5pXPQeuzmZx/WV7xr5IR/ucJA/nqiOEH7VJYR5DgFX2c+Wkdxp2ry0oGKEF5DawBHdenZYbJ6pyh6rdSv9se22
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39850400004)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(26005)(86362001)(31696002)(2616005)(36756003)(83380400001)(2906002)(110136005)(316002)(41300700001)(66946007)(66556008)(54906003)(38350700002)(38100700002)(66476007)(478600001)(6512007)(15650500001)(52116002)(6506007)(8976002)(8936002)(4326008)(8676002)(44832011)(6486002)(5660300002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNaZjdTRzFnbkNJMEdUK09Dem9rTXNQNXJjZS9BZzRITHNoZjhCSytNNGZF?=
 =?utf-8?B?OGtVL1JocS9mby96ejcwcFI0Rld0U0VHd3gvWEZhblN3U2JjS1kvc1o5V0Ey?=
 =?utf-8?B?QzY1Yzc5MmpEUmE0OE0rbjNZMURjKzZDV1ZtNER0ZnA1c1NQdmFVaFdXM21j?=
 =?utf-8?B?czM2eVV6U0RJenY2NTh4aDQ2SEZuRWdacmkxcGYzcTBmS0ZkSVV6SFhnUHdP?=
 =?utf-8?B?aTdIR1BWVnlaMnh3Ty9JZEhGbUdjTWNMa211eWxIaE91dXF3M01OSGJDdXlP?=
 =?utf-8?B?NWJEenRJci92YkFlaDdNOVZ0UGNGSDNQSDdsbkJyU2p5cDUwbnNuMk02RXd1?=
 =?utf-8?B?L1ZFQ09KVGdTamJDYkxLZDg1dmpoaFJMV0lidGpiN1o1N01GeXJ1Y3JMSzZH?=
 =?utf-8?B?REkycUNIanE0Q3FPblhrRnRMQ1cxL0FlRG1VNHZ6RnluRlBrMnFZVEd4MWFQ?=
 =?utf-8?B?Z0lseHltQjVlbVJTUDNyQUZEb1NPaW5GcjBzMjl0YjkzWXVTR0s1NUd3Vk1v?=
 =?utf-8?B?N0VGeHRBOVV2dkE4TWtvU0V4NHhBTS9Nd0VkSTRKTTJNOVlXRmxRbEV0Wm1U?=
 =?utf-8?B?T2tGaWJpVDM5ZmhRNGhzMGE0U2NWZ2FKRUhIK1NsODhxZnJ5LzZyZ1pWZktR?=
 =?utf-8?B?S2kvVEV1WWZwUk9hOUpOYUMwRFE4VFlpeTI1V1MveXNVNEQvY3NseVJiK0JV?=
 =?utf-8?B?ZVIwU2lYM3lDMGcrNGZ4R3JvRXVBU0pnWEJXRjdoTnlHdUR6UEhPZFU1WmZs?=
 =?utf-8?B?Qis3TlgvUnBHeTZ2Vy9vSGNlNm5BQVp0VWwrSHo1d3dWZ0FHbW0ydEFOSUxT?=
 =?utf-8?B?cE5CQUljdU1lTkhnNGdYelVMblRpMjdPZklMUVI5YkJjc3RBOHRwZVhsUGFO?=
 =?utf-8?B?NEc2b3ZTU0kxVjB2VXptSkdOU1ZkUHlWYXF6Q2c5TGt6blU1ekpBTmdBNFZi?=
 =?utf-8?B?eUM2NzRhK05ubHBFdG5GR3RsNUtGWmExZFE4b1pEM1kzY0hPUnBZUERmdWUv?=
 =?utf-8?B?QlBTbzZpTHQzVkJtWGxYVUtKUWdnN0VDTVljSWcwa3ArbThmc3V1eXBQVVFp?=
 =?utf-8?B?NnA5cENwK2xWNlBFelF2TldBQ2FEenBPbUl2ZXpmazFOVmo5bzZQbVJkS2NM?=
 =?utf-8?B?eVlwWFUxVVlrZUVnZk4reDVOcWM3TVU4MWp3c25SLzdJajVjbzR2TkNXM01i?=
 =?utf-8?B?TGJEQzY0S1I2c3ZEdVhuRWhaSElZa0lpT0pPc2NiQ2s5V002YVk0S05RVXF6?=
 =?utf-8?B?TU1BVzFqMnZTOTlFRkExQlljZm4wYW41S0J4YllycmV6SldDWlNKRGFjMmsz?=
 =?utf-8?B?M29BZkd0M09tWElpVFdNZ2NtVWlkeWlSbVhEaXlxWllHOTRoaEdjdHV1QXQ5?=
 =?utf-8?B?OWZBOHN4WjA3SUtZRFFqbGpxYWRjb3JTYUthV2o4eUtEcVp6cDdKd1ZralNm?=
 =?utf-8?B?RHJiU2ZFakZsTFF6bHpEMWhoajJLU3dEYVozV2RXa21zVElBZVpNYUpzbEo0?=
 =?utf-8?B?d0VSSXI1cnNGclAzSlVuZWIvVitXeGdhMFJNeXpWNDlXR3E1UmJBSzBCdGU4?=
 =?utf-8?B?RmJqYlZDNXBKTDZ2U1VwdjI0YzR0QldQVHdsNFVGSm45Yzd0YzhNWmRhWXlZ?=
 =?utf-8?B?MFlyZ0pLNHg2eVlDVVc5Z0tReTUxOFUxajYrTVN1cXFEOVlkSWRxTWJCWlk3?=
 =?utf-8?B?bXJxbVVJWWM1TFRwS2VSRTYzZ1BNUVc5OVNLRnhEZjlNU25mejdILzQ0ekdT?=
 =?utf-8?B?MUExaDNidHlZeWplSDltaHZuM0x3VVFQemlJVitjM0tBcWJPcWhuY3E1bU84?=
 =?utf-8?B?ZG4yY1psMml2aDBMQ3kwSS9lU1p4bEJHS0JiTEs4R29DWlR4Z2E2dWVGclBu?=
 =?utf-8?B?QllZeXhpOWFYRHNITWtWemUrRlErbllCZERqdW1OdmhFQUs3NVNhTUdTcGN2?=
 =?utf-8?B?Mk03Z2VXZHd1Y09ETzloZW1ielM3QkNWY1JFSjN5aDN5c2Nmbm1JUlk3Y00y?=
 =?utf-8?B?KzRIMUd0NnlaTVgyYWNVZ3BYWVpOUXdJN2U1VWh6NEJoZUV6bHpUY2ZlZlVj?=
 =?utf-8?B?TnZRancwMENxUzVwZjVBL1RXTzZFVmtUaE1BNDhnNjJVM0hnUm5BNHRsOVVx?=
 =?utf-8?B?aTgxMDBUa2hncHJtVW8yUkh1TXl3WUxJRGpMMWVWT3pCamZob2JjdjZ3NUVz?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9653f5-e3b3-4edb-4898-08dbbe596b53
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 06:25:46.6337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1TfCQnfgN9Ins44OjSNGG11U8Gkryw3leHCgxfjIRr6rtQp3KCdvMSUWPxbT68zPwTqVLhThgmTE1WEo7G2fTllS3V2+WY8BN8J6eE3FOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7150
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

On 25/09/2023 17.14, Jonas Karlman wrote:

>>      fit,align
>> -        Indicates what alignment to use for the FIT and its external data,
>> -        and provides the alignment to use. This is passed to mkimage via
>> -        the -B flag.
>> +        Indicates what alignment to use for the FIT and, if applicable,
>> +        its external data. This is passed to mkimage via the -B flag.
> 
> This only updates entries.rst, please update tools/binman/etype/fit.py
> and re-generate entries.rst from output of running binman entry-docs.

Ah, I didn't know the .rst was generated.

Simon, want me to resend (this one or the whole series?), or can you
fold in this when applying:

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 2c14b15b03..97d3cedaf5 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -71,9 +71,8 @@ class Entry_fit(Entry_section):
             external offset. This is passed to mkimage via the -E and
-p flags.

         fit,align
-            Indicates what alignment to use for the FIT and its
external data,
-            and provides the alignment to use. This is passed to
mkimage via
-            the -B flag.
+            Indicates what alignment to use for the FIT and, if applicable,
+            its external data. This is passed to mkimage via the -B flag.

         fit,fdt-list
             Indicates the entry argument which provides the list of
device tree

Rasmus

