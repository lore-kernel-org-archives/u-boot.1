Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47557E82CA5
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 15:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CC386D5A;
	Wed, 27 Sep 2023 17:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Tv4Lhibu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01C786D5F; Wed, 27 Sep 2023 17:41:21 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B1086BE1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdO53NgGxTg9ukoME9TBd4kw3ejRfvPJG/hagwwth/R0EQuWgvRBG9Ac6iWB7F1v2pNi+hUjghfT1Ygl/5/+ShalodNhNpOq7LzGEb0beM6aYULarwQ0CcwM3dA88NvLjPXHEllYIH4MVrzkSNsnyOOjIanDAVKufxkPor7//NyHSeOxxM1VAVMx+ZJFe2hzHb5Hy4KYjQZqlMzjSHLmGnMCQQUkLYnriAjV18vu6HAV1mEbd1fUB48OcuoXik2O81CQWreuilnCmh6qTdbQ4ahmTZ9mWmxNyg5hYOxafKZpSaGh4XNEDBvlZxOR60FDCefTsFJW+5LsHwqKfR/yUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dITsq1/RI4h6YfPjRJPY70zI/yfdkMDz4xU8Z3rqoK4=;
 b=B5B1VWq/vS73BRZO/hxt6YTiKHLKOliI06+jp0hDJdK8QYa4/sLesH7gUVW33NVSK6PAElbSBQimbGyqeq1ztm9Dw0IpAH4RLCOLyltlollfHNLvL69HZXlU2x6xkR/NgR78r6hrY/eJnXBccItuLcRSNPr1pro0oJLXTKn+ZTUFVe+83+NE9eNVt14y9MKAbyrYrqWTg5ZiXTLf7WoQHpAp0fXHtvg09J+G+G7CqHcOoMq5hXvo/PFwqmEePCs+F2gm4qMEZx5JRdGr79E3uyhf/UxCzBsTXwgTAnYd48e97+pdyzDetOw48gGCLbPalZ4W41GZwVT26LpfeULAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dITsq1/RI4h6YfPjRJPY70zI/yfdkMDz4xU8Z3rqoK4=;
 b=Tv4Lhibu5xlHkJVpzeOIx/rDoVubDcMS3siRdItCz+ikzd3xBrvP9ZRNk1Egwq37vkmbC+67aU8pfYD3NpdQlEuUZY7vobTnvGWjFoq6n7JIqw+WK1Q8Kb0HLJBflPz0fPQnTT0cFdSiFAOXu9rKczfp1zfPKej+N6pHlobQeqrKo0DAFjmq/AggUOyhSCQxchCuPV7OmiQ6jcchv150n9nvt5Dl5l2WjitLjBK9ByBa5yF/n/CYBRyAlVXf0/NXOwI9rDy9Eg0zikAvFWqZHE19gPJYbSf+m3RQLO4nBPSZA9dQ7yGR9eWg9TKGEK7UQfvHkNZZtwrebWxyi9T+3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:41:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:41:18 +0000
Message-ID: <98ba4f3f-eea4-4154-9ddb-2ed616651204@siemens.com>
Date: Wed, 27 Sep 2023 17:41:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] tools: iot2050-sign-fw.sh: Make localization of tools dir
 more robust
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 677bfdfd-9590-484a-c68c-08dbbf7030b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaQITRl4uFtcYGpfCLCy7xIsaWWxS7ptxcAOMgkegtPHx19wEB5T9U0dXz2skqSVmVB0Xke7IGyMJLInL4LPWqfNaTzbdifmvlVspShmsbiQhXWM1DEPzYeGhwvmvY066pasvXCQasHpuA8TANhUStOda15N3Z5h7NMNzRGWXAgQ0TwPd9MqPkE7xKpGZ7VSd1F9BSJ/Z83zau8sFHpyK8whEUv134Jbi5Nc6rACizjSDpc0cCG9/zFebv2OWbqUP73ZrqyP/Nt9d1jtFzX1m0efWX5Cb54OP5D2nMDs1OzqTZikUdx3RBkWm8E931CfvTYo3szMnUm+gcRQN78CzpmlcSXQiPh9gOO7c5g/ITBejvDOTpm+U4M4q+tPR6jLonIkg9f45G9ahtuWyyaMvH80jEWX+DW7w5SyXr+oBLq/YiR1GV76GE4WweQy/MBHBuwaeOPi8e3cfMmQNdhw24/V3xAcOSQ9UlvRgMHZRzn+QbgMHaFgOkTdVC0G7XtzW+91egnZQKzBfa+Lq+SMEsZfV0fs/Y13lMMH+VUZsE0WRsMfgW/TI0kRBFJbetCAAB6YF3qphUPqhYwcyKYkKz1NmrfOsK/MDlNodYjf1E1pE2/WLPPrBIIWTW7RP62i0G4I7YBr/BzXrX8tAuiRYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(31696002)(86362001)(36756003)(31686004)(6666004)(5660300002)(6506007)(26005)(6512007)(66476007)(66946007)(44832011)(316002)(2616005)(41300700001)(6916009)(66556008)(8676002)(8936002)(478600001)(2906002)(82960400001)(6486002)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmh4LzVZVUxTK09HVlBEUi91MWJhY2N2SmU5MVZhN08yQ3VCWFRjMzhWY1kv?=
 =?utf-8?B?WGtiSnh2dEx4R3RUeUVkVWpNbFZRRDEzMjJZWkZqY1phQ1E2ckNsUjRGalA1?=
 =?utf-8?B?WlVpd2l5N1QrcEltM3V6bzlFQ3JBNVVCYjBldTlFc2RmME53N2pIbWtIS3h6?=
 =?utf-8?B?QXZUMVpIV2pYWTQ1aXBYYUd1SHhvWWQrZTEyRmdpSkhhS1diblA0U1JJZW16?=
 =?utf-8?B?bjFCTVZRM2EzYzg3RThMTzFxRThuZkRGVnovN0pXbnR2cmtLeVg4UWVEM2NR?=
 =?utf-8?B?ZmM2eE9EWnBMZ09NblJxMjZwaTNYZkkvaGx1KzdFSFVpMTBWOTJrUldJVm1J?=
 =?utf-8?B?VlhxRisxQzJXUms3MXoyK2YycFNGVEROa0sxanRSemVwU3ZJdmZSNVNHNkxn?=
 =?utf-8?B?dTFPeFZOdldITm1PdkJRUjM2Wmluc0J1VVVUTUFiWnBJT2pwN216UTF4SEpw?=
 =?utf-8?B?TGdUUGsrVG5tVXJwWnlMK0M2U3FBcGpreEVFbFRTR3RoeS9qd3poVFJ0RmNX?=
 =?utf-8?B?VVBLZmt1NFNJTzFLSGx4NmtyRThzQVkzV3FuVEpQQXBheGZ3eHUyb2tNQTVw?=
 =?utf-8?B?SDlTRHVmWGo0ai9tbVEwZlgwQk81RFMvT0ZNT2I0VGFHeW45SXpmZkkvS3dk?=
 =?utf-8?B?RGk5R1VEN204dlRZNVNwZUNQKzZJUFk3L3J2djB5UW50NWVmTmtQekZjUlRH?=
 =?utf-8?B?Y0FTVG4yRGdzUWdLSmczWGNUY1BYZUdaci9NK2Q5Z2U5azFvQlJBa0tGclRZ?=
 =?utf-8?B?RlZKK25WbDdqcnUxcW1sZUV1NTZtK0pDZkp2akc5WG5KeVpHT2RsVUw1b0pa?=
 =?utf-8?B?MGdaMlJ2Rjl2emgwcVE4L2hyZmV2eG9kd29DSENWR2o3bm9TVnJsQVZXSGhk?=
 =?utf-8?B?U0NiT0kra3NMN2F0ODdFSkRiMFlsQzhoOVcvSDJUak81RHhudUMxV28zWWJD?=
 =?utf-8?B?VkRwdU54OEk3NGxadTNQRU5xSm1QRGl3Y2h2TVJmUHJDTjM1L0ZVTVk0TG9w?=
 =?utf-8?B?QWY5Ums5eFZhK0JEZW5aMEZrYWxzUTBoNnBVeVhORmJqZnpiVmc4YVZTVis5?=
 =?utf-8?B?OUZNc0g3dHkrZFVPRlQ2UEgwUlEwMEt5bXUyWU9wajNKdmFuZzlRMmVjcWZ5?=
 =?utf-8?B?ZlY1eVNkK28rWFlLSGRFcTF3MUxOSWxzQll6SFJPdnd6TUxUc3V1VllBQjZl?=
 =?utf-8?B?TW84cmJjTXhpV3NZejBEeWZ6cVZpQjlYU2RMbW9oa3NpTCs3eExjdjBuQUxX?=
 =?utf-8?B?U2hSV1N0VWZQZ21DV0wwVFZ3b2NrS3RrcEgrUVF0K2hqdHBQc0dCTS9kbWtx?=
 =?utf-8?B?WVdUbllpY0kwSlFvVW5xN1A1NzBMK3F6eDd6MVFqY0xGSllMTXhoZHBMZW42?=
 =?utf-8?B?WTQwSlJ5VFNvd29kY1licXovR3dPNWZTWE5ON0QzeHltNWxQRFpYUlZsM3Ar?=
 =?utf-8?B?Tkd2K2QrNmFENTU4QjBSWFBmOHJyMjB1TkFqa0NidVl2L25GODdaQkhodDFh?=
 =?utf-8?B?bVIwYjhBTzZJYzRrR0l2cXFOdytyZDRSeFIzUC9ra2dNTWs3K1JNUC83bTYx?=
 =?utf-8?B?K1R0RmdlMGttQzZ0Q05YbEMvQmVWb2NTVzc2TkQ2OFNKMDdGcGlWdEFNTjYy?=
 =?utf-8?B?QXJyemZ2RCtZN3p0ekhVMGhmMEc3Rks5SnRIL3ltWEoyNVh4RFY4R1RVbFo2?=
 =?utf-8?B?NXdmSTBsTjhiOVljaTBoeHZsb016aklBblhQSnRSUTdMUDh6WUV0VUhPdDls?=
 =?utf-8?B?bjlxYlNuMVFTTDUrdFJTUE1zNXQwNE1zREVPOVdCVXJXeVRnRlkzUCtqWE5P?=
 =?utf-8?B?TVlTbmFyZHZJUHNwREd1VXF3NEVBaC9qWVhvNHFGMXErMnd6UFZwWElWQTNt?=
 =?utf-8?B?MUxPR3hUQldMUTlsNFZ3TU5jOEtCWXFBRmxRc21OSDZMRDlmRmhVYWJYdzEx?=
 =?utf-8?B?T2IzTEt3U2R2RkkwQk1RZGZiUFp1b2JmSmNhcU9OZmprQ21EUWEvNTBOYXlk?=
 =?utf-8?B?TDNHci9CN1NoN1lSMWg1WlcwblNMKzZ3UXUxenAwWFBoQWtWNUZBc3FRd1dW?=
 =?utf-8?B?clpNOHRaS1lkY1VMVFNscFg4TjNrVklTaytXN2svYVAweVVOQU5zSHZheFI2?=
 =?utf-8?B?b3QxUDlRS3I2emtUVkJpaWF0QzN1dkl1cGpTZmtCU1E1NW90K1pIRDBYMW43?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677bfdfd-9590-484a-c68c-08dbbf7030b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:41:17.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lb0xscdOBELIEwfmVRj18gOLgEaoT8jnDk19HMlYjMRSMxm25DkS8B+Ihj9GvKiJow5rKa21+qR1KsENMYKNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7398
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

When building in-tree, there is no source link.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tools/iot2050-sign-fw.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/iot2050-sign-fw.sh b/tools/iot2050-sign-fw.sh
index 6b426c854c2..75ffd560823 100755
--- a/tools/iot2050-sign-fw.sh
+++ b/tools/iot2050-sign-fw.sh
@@ -5,6 +5,8 @@ if [ -z "$1" ]; then
 	exit 1
 fi
 
+TOOLS_DIR=$(dirname $0)
+
 TEMP_X509=$(mktemp XXXXXXXX.temp)
 
 REVISION=${2:-0}
@@ -39,10 +41,10 @@ CERT_X509=$(mktemp XXXXXXXX.crt)
 
 openssl req -new -x509 -key $1 -nodes -outform DER -out $CERT_X509 -config $TEMP_X509 -sha512
 cat $CERT_X509 tispl.bin > tispl.bin_signed
-source/tools/binman/binman replace -i flash-pg1.bin -f tispl.bin_signed fit@180000
-source/tools/binman/binman replace -i flash-pg2.bin -f tispl.bin_signed fit@180000
+$TOOLS_DIR/binman/binman replace -i flash-pg1.bin -f tispl.bin_signed fit@180000
+$TOOLS_DIR/binman/binman replace -i flash-pg2.bin -f tispl.bin_signed fit@180000
 
 rm $TEMP_X509 $CERT_X509
 
-source/tools/binman/binman sign -i flash-pg1.bin -k $1 -a sha256,rsa4096 fit@380000
-source/tools/binman/binman sign -i flash-pg2.bin -k $1 -a sha256,rsa4096 fit@380000
+$TOOLS_DIR/binman/binman sign -i flash-pg1.bin -k $1 -a sha256,rsa4096 fit@380000
+$TOOLS_DIR/binman/binman sign -i flash-pg2.bin -k $1 -a sha256,rsa4096 fit@380000
-- 
2.35.3
