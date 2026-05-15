Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E17CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA5384865;
	Fri, 15 May 2026 23:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="uZMopUfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFA784839; Fri, 15 May 2026 22:57:53 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d202::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C860D8480B
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezSlEMEkhQykvZ5pAA9tKZeBwWxi29NVnVil7meslGSLrDixHmFxLska7ySJragZyNC07GHNr1H7f1A/x9u9hpBoKdRermeYkUqL4GQKLqktS8UPV+dLAaRpBkubvG4y9hil60Sf0wXXmYG/50TfOKdlxrpztYEiUZAHyfA7qnoC5JFLZK79jshiDvddXhe66TT01/qMxM3o9OtnOy+KOXtuNSWilp5PRHOoJf6LNqgYSbyHNzh6DZX3fnpAY+g1DsQiiksvHfn1AlcYIXGwB+zFRqJgMThQj4vTYZ2p77gEAlRZCDYVLeOqPkQXZyoAwLYyvpQRNfDagPDUPvlMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnAT/FMTwWi0YLbbR6dQVGaLf2x3+81NpmxL5ZcOrwo=;
 b=JNfMH1GMnh+JQ3lDZOv5Pwhl7lzKSlQF1tKxYyjl57haTZGdxVhwYlJl6MEZLBrG0THjxRF2IzS15uusOQMa6k4n9lqr0FiqL8yL9O0ywaMLBZtAjvXkgLmeSeEBG/NwDjYMAeNA2YoxX/sv67hIeFqkc5g6Md88BDuMGiZsSVaKKPUzws2BM0hyHcxNokfGN1ql7ujb9idBRh5kRJTdbeJmgurFS0vjhd0nl4PFfUHAeK5kTPHTfdDzfcwTggDaReiIoagjPEAl8b16W5EShtviPZRce5EJI+A6Z4Jne8tQSkvcSgF/B4404XpdeqUNAHlfDSUZv4bgtOMZtsNedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnAT/FMTwWi0YLbbR6dQVGaLf2x3+81NpmxL5ZcOrwo=;
 b=uZMopUfiZR4q6/vGzV1ngpEjUB5agkZ5OvHhP9X/puBCseduKb9jLdmVxlX0+cxTZCWjAx5gNWUEZZ+oga1j3w1EXb8JuflDXKKZDT742/yApfrSEoNyqxCCwSjbZXzBWS5SK8GZF8IxHognZUKUUuSIerR3pekxIDahIJTpKksWorTAVDiZsDJLeIPev7VnnFn9Lji9jqSBKct9bIHfQCpGIENarAiIf0+FF8EnIVTWnGiXkuxSClXvoqrHsCFodxpJlGjM8aE05qTr3MmZ+emFpNPbjwJOd/7GxG3yXOlNINOgO/v+lQfcNa8kOFyk0NAZ0Sg7tuai5pry4GmNmw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PAXP194MB1485.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:1ab::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Fri, 15 May 2026 20:57:50 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 20:57:49 +0000
Message-ID: <BESP194MB28052CF65AFFB806C625EE84DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Fri, 15 May 2026 22:57:47 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] boot: cedit: Check ofnode_read_prop return value
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::21) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <1e54f95c-89aa-46d3-aef9-9188313d789e@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PAXP194MB1485:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f5396e-249b-46e7-b8da-08deb2c49fa9
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|24021099003|12121999013|55001999006|37011999003|6090799003|5062599005|8060799015|23021999003|19110799012|15080799012|5072599009|41001999006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0w2NGRWcDVsdG5GOXJFVzFKZCtEZlR3L3ZsRTdrSmhKZTRpRDhwd3loeS9l?=
 =?utf-8?B?dDVXMWM3VzZQSENRVnROU1hMcm1PSlFyemlUQjZyMU9UQ3o3MXJnVkxzR0dR?=
 =?utf-8?B?Q2d6TFdISmprZGUvNzBhemt1UC9KTW1ncFZPd3lxWWJlSzV6R1ZUYXFXRTdz?=
 =?utf-8?B?bStxU3JuRVhuMVlrY2J5Q3cza3FreWlUTkswSHlwSUtlbEJVYmpscUU2ZWxJ?=
 =?utf-8?B?SThDcWU1L1dUUEEvVlg2b2lNcWtCZHNNbEZNZ1FxV0VuQmR5MkhjQUxERzVh?=
 =?utf-8?B?TEFQKys3VGlCczk3N1FqLzVEakZoSnRDNkRxZlVzQXBESldacUhTb2wxZmp6?=
 =?utf-8?B?aGxYY3ZaN1MyL2cxL1NQNU04OFJtVW8veGQxcGFyRXRpeVU0czZnSjlVK2pu?=
 =?utf-8?B?Q3Q1QUJ5SjE4dHFieGNSZTNiRzlIYlhCS0ZEd3lGcmNZbUFvTlNZQ1hBU0l2?=
 =?utf-8?B?ZFluSG5zUmJLenArcjNOTGFHWHZnSTl0TitWNVZpU29OeWJVaDhuSWhFV1M1?=
 =?utf-8?B?bDBRa2FidjVkYmNRL2dTdHRrYTN4Vkl5QVlaaVZEUmgyUDdlWW41YUNrNVZQ?=
 =?utf-8?B?VkE1YXh5STNJREc1MlE4L1JpcXBGUlZSNFZVRnV5TnZ1OW1QNVpsTmNzMFhv?=
 =?utf-8?B?SE05SVdkUEp1UndydlRPSXJpMGFiM2tGWnFuQUdtS3F3ck55S3NoeHFPUElx?=
 =?utf-8?B?S01La0FWMUJNUkFFOHpINkl4TEQxWTROeEZRVGNPTllhR1BQeDIxNUliMmxl?=
 =?utf-8?B?andubU9iMTUwMDlZR00vT2Zid1BLSDV5bW9KUjJnaXptVEd3MUtUSHBhWjVO?=
 =?utf-8?B?NXE4QnAvSTZIbElJMitDd1EwM0FBU1NYMVBubFlYT29GL1lweUVjSWJFQ1JH?=
 =?utf-8?B?dHNQMHpEK1JMdyt1MGpoRFd2WlZKMkl3Yy9YWWdDL0xQTzcweTd2dUVwMDI1?=
 =?utf-8?B?c3FzUW1QU0VDUERhWEkvem9HdDl6eDNmTEU3VGJJdUw0SUc1bzZNeERVbXhN?=
 =?utf-8?B?SktmUmFzTGZ3b3VOQXp3Mng5dElhbzdTRklEeEFSbHVvU2xQQSs3M0FLUDM0?=
 =?utf-8?B?NlFZUUNBU2VVVjlqbFkrU1N3OTFraHltdTAvTFBFR2gyVm11RWJZM3NhTGhq?=
 =?utf-8?B?YXNidm52NzNvM0lldUptajE4dERpWDNXb1lzNEFmbUdCTlVIOWNka2lGTXl6?=
 =?utf-8?B?MlFNNzJpNVBxR2VNc3VmTm9RZHhITDZmSFRUVTRydmlpU1VKVW1wZFNNaUdx?=
 =?utf-8?B?b2d2ZzNqMWNsbXB3eFdPK0k2Mk9yK0ltS2pqZUpJdWczdVdqMVo0NHFRaHBZ?=
 =?utf-8?B?OHRWdWFNNHViVXdFVmVOWnZXaHBNbTNvWWMrVnNTYnVQVXhTbUd6TXNOck5D?=
 =?utf-8?B?L014V1EyY3AxRmtjdWFKeDJ4cE5iUXduTDlJY25VaGllNGJXeGVIR2VNdjRh?=
 =?utf-8?B?N3lyZDlYV1B0OXZ5VEI5RmdnWmJ1SHEvK2Q0YnF1aVg2akRCMmJUbllPazNR?=
 =?utf-8?Q?5AE67SdBTKmwZcuuKKHwEIFFmCs?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZrOTVoVEJURUlVVCtRWDdndlArbWdvejhBSzdKUnpuaEJnK3Y5cmRJTis0?=
 =?utf-8?B?R3dMM0JQVVdnYkxodERYei85THZmbk5HNHFRRm1lY3d5RC9GZnJrZ3NsSDlm?=
 =?utf-8?B?V0Ird2dTb3JrTHBJMGQ4Y242MWVZME1zOHE2dmhUNVhMY1BQYzlEZEs3NEpu?=
 =?utf-8?B?YlFkM1VxTVdTOUhQSVdTcThmTitnbFZRTlE4ZzdWYUlMbmZZQkVEaGdIYnJO?=
 =?utf-8?B?QmxaenhOZTNPa3U3d2FjeGlKb3ByVDRKUzFzSzBqNFM1a1Q1SUJ5cWRYTHhM?=
 =?utf-8?B?ZGYwQ3ZtSzdEYnNabnh2OGR1a05NZ3JmMmxYVEhYOTcwSDNnd1FidlhFVTV3?=
 =?utf-8?B?YkRLbUl0RHIrbm16dVFWbVJjdjk2cXhCV0hQMk5mUXJXdlB5L2pQR2o1VHls?=
 =?utf-8?B?Sm5jWXh5UHJzQlRMOGk1eHVMRUU0cGg1UE0zMXNlN1ZqUTc1MU1RYitPakxo?=
 =?utf-8?B?dG1hZjZsWUFhY1BHdFBiYkpzYlVpcDNWcklTcFZVYnVmWnVjNFhmaFk4QnRv?=
 =?utf-8?B?R25yblBOSkdRYnlIaWh5NXYzVHdiUE5kaDNSSUI1bWN1d2c5OXZaU05RVHBm?=
 =?utf-8?B?aEJVcHoyMGtJemZFTzdYeW5TcUZBcThnRURVcTJ3Y1U4cEtLOXpHSE5HRXhV?=
 =?utf-8?B?SWlvclhCMERHQzF3MXJYUlF1QzM2cTNGZmZUbGNPZ0NXTEJRYzBBTlBPS3Rk?=
 =?utf-8?B?dllwYldxdlNaVWg2OGd1UTJtTVFRbXlUK1NZM2FBYVV0ZjdvYXVES0pHbjFa?=
 =?utf-8?B?bXZwTW14QTRxeStrMWlHSkZERWhJNEMweFU1OXFYckp4TWp2YzlVeEEyNE9V?=
 =?utf-8?B?RzdSZzR6NlhIRll4cWI0Szg3Wnpid3J2cWhEY2JNN3gyNVFQU1NYVkdQNGVO?=
 =?utf-8?B?UHB6REhXR3MrU2M1OUpWVjVTMHE3RmIrUmt6R0tjRzJGbTJndEZIM1Z6R1Rj?=
 =?utf-8?B?bGdXK3ZlQm1pWHpJQ3BCZzEzUWNyRzRFOWlVN2cxdjk3YSszaTV0bmIyV0FR?=
 =?utf-8?B?VU92RitDNVpvcUUrbHJTN1FuRndQZ2tod2hkOEZVblhBNVJ4YUY2ajM0TVl0?=
 =?utf-8?B?ME1mN3kySWtyZy9ZdkVyTTVyM3J5VHlSdkNZY3pJeDVOZkVCTTRXVzBWdlBi?=
 =?utf-8?B?czZJYkpna09XaFE3MkNWRU9aOU5Wa3lGMFNEanVPdHpWeVMrNms4K3VqVGpV?=
 =?utf-8?B?VjdOZGhLcXdVVmJna1BoaTNkVHdNYnhrd2VRU3NRVlVGbUlTWE5LYUZsRGcx?=
 =?utf-8?B?WW53cXVScjViVXM3aFdHQTRhdE8veW03MkNoMXlyWFlxTFFWd1lieXNyR2Rj?=
 =?utf-8?B?Mk83eEEyNWh5aVAxa1YveTROMGZSVEd5WE5OeVV3M0hDbnV1bm1kUmkwTVVs?=
 =?utf-8?B?UEpvRVF1ODRmRVZGL2NtZjVmc29nQWJrazc0d2JIa3hlODZIRVpzSkxKY0xs?=
 =?utf-8?B?ajdLa3F5eXlPTXhQcHo5a3liSEVHLzBmTjQyZGhhVURUMnZ5NDNsVFFYT1RJ?=
 =?utf-8?B?bjVobFFUMkpEQnp6MWdCMzNjSllDcXlpSU9TZHBSb0xjRlhjMWFkeDhmQ3NV?=
 =?utf-8?B?eEdyZlRIN2Q1UDVXOEJJaHdtZEVLRThtVW84L2NXUzZCT1ZnRGUyWWZXcmtn?=
 =?utf-8?B?ZXZvcFlFQU9tTFkvbW1UaW9zL2FMay83TDRWV1JBaC8wOXdaQWdSNUFUaEl4?=
 =?utf-8?B?aVdJN0RDUUI1Q3N1bXVGUTNwam5xYmpubyt3dVZRZVpOUWlSRUFMbGtaOUtZ?=
 =?utf-8?B?YUVCdkQzNnR4L1p6VzFCV0hJc1BQVytxUW9FaXprNmlQQ29TZ3hlVkVmcVFG?=
 =?utf-8?B?dXFOalNxZG0veFlBRGpaUlFzUFFsdXdXV0liRExYL1hNdS9UV2JkS1N1NmJz?=
 =?utf-8?Q?aWUgfOFr/spVx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f5396e-249b-46e7-b8da-08deb2c49fa9
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 20:57:49.7420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP194MB1485
X-Mailman-Approved-At: Fri, 15 May 2026 23:29:57 +0200
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

In h_read_settings, val variable could be NULL due to
ofnode_read_prop returning an error. This variable
would then be used as the src in strcpy.

Add a NULL check after calling ofnode_read_prop.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 boot/cedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/cedit.c b/boot/cedit.c
index 56dc7c6af15..49155b42961 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -500,6 +500,8 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 		tline = (struct scene_obj_textline *)obj;
 
 		val = ofnode_read_prop(node, obj->name, &len);
+		if (!val)
+			return log_msg_ret("tline", -EINVAL);
 		if (len >= tline->max_chars)
 			return log_msg_ret("str", -ENOSPC);
 		strcpy(abuf_data(&tline->buf), val);
-- 
2.43.0
