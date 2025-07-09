Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B2FC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A072283444;
	Wed,  9 Jul 2025 11:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="N/byXPKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF598344E; Wed,  9 Jul 2025 11:28:25 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596F783423
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7EWymoC1UXGD2hgBPEsviKPxYn/tlCt6OsAAs2AK6Smstim/Y+iK/jtayT5EZVPTmgaLyZSFvfDpclQ5jePnpF4DBWQDO0GlaSVHF23vgMh9bgj4IT5t4n1f4q14LMdcGcRSRPr8/MAlUskD+G8BJWeQdM73HrEuejOfhDKgf7lRWYUrfvRkdV8Aq62JzCAyuGFWKP8+LGXRRNTLLmHo4k/D5uTlSW/sXZj3cKdyRyEwyqIh68blNwJC6+VtA/1fFWurlVKQ5LgmFc7QZ+oWtuoXpjBn1KjuQQK365DtiN5i+ldXv6zE3FhIRyP/EcHv1wEi2iLhcxOGssXClbWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz2kRULdgnHmhbxZkpWP8ZlkaRbW39tiT0J45ZEdiaQ=;
 b=GxAT1Li4E8Uz93GqEoXVAr4s+tFgi48FDb1A28+gGbt2AvG4IRUHqQo4XVhQ/4JaqVtEYGjHfsCS5tSPb/2aJcL6ajXdcd71QcGYFJhykGK4pKlyL3QcSQkgEo+1RN4BBitOaCRNmeizAePd/C7ODd+C2nDtsoYu+lLCwAXQzgE1sAUa22qZIFziEMmk2KyYLaIyvVT2TDGvx84+bMBwjpKC33gmcvvz3NhniGUaBkPlJtw+wwms1wIQ1LnJUBnbzuu5qrgX57e43EqG3RmcBYIlT98eCnha4rCKgvL6YbzFh9/j6QtFQpmipBXfey7JWlzva0VyzPpBvIhWRDDLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz2kRULdgnHmhbxZkpWP8ZlkaRbW39tiT0J45ZEdiaQ=;
 b=N/byXPKe5tykEAeML8Lj1R8NqLnLMlv7k8PSp5eq0nLKi3KbZ6bqdO53APX/KtLM2VNUnjaQrQYPl76xZKMw1OBh3kv0d87dl2XpHMz2ljc8EIveO20g181E1Tywxb9uxS5v96YKCtHgSfH+nrAFzjVtmVQaaCUm+xblPC7Zm8oqbUpS9cAvNxfnXDJay8nsCt3HMTXISe+nsZPyYFrGcVSEvgQWs6FxLgBngkWwKqiqzWGTuBh3Lt4WUKeIQI2RrmeSe28DsPQh/Jqv6m3NT+boiyFjNytZUdmdrfVYKqyX8h9Sb8iS4IFF0eRgQH1gEXQWCWxbIONnd0Tv9BhgaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB9732.eurprd08.prod.outlook.com (2603:10a6:10:460::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:28:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 09:28:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v4 0/4] drivers/net/airoha_eth: fixes
Date: Wed,  9 Jul 2025 12:28:06 +0300
Message-ID: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 43430bf1-299e-4b86-938e-08ddbecaf0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SGotbzyGqBik9FmcBofPlECb6kEIuyxEDcge/p8AZhF9ozHHz2jvN+jY+H4Z?=
 =?us-ascii?Q?SH6z+CJxVomDnYJwl5FKVLtKTLuGnf/SE4qNdOL02IyKdoreLcQqnF3CMzpp?=
 =?us-ascii?Q?4DOlq+i5SA515MEABhNaO94yx+KfaeNP9QqIg5hNV6j5vSgtzX4kzMPx023K?=
 =?us-ascii?Q?cqJtBUQ5r1WlNC/iAoxRgHiDFZsmxkTzuO+IwF/+HE8HHOeop+9Pg3+d24vv?=
 =?us-ascii?Q?QcOJdApTUqIBeDthnQkqM81vJkcpHUCjWaoRC/blWmMqumFJhOJtc9fTEgz1?=
 =?us-ascii?Q?9KfcJVh5T78CEbcxSnjaCtrOY/NYU1pCVXfq+d9dxQGVpdvwfMgjPSxFzV/u?=
 =?us-ascii?Q?fVxjSGID/q0P07PW4zPFbRjd7/edpGGPFmOuj6mGjkkl77xfgnEDIhvGUTSg?=
 =?us-ascii?Q?nvmm1bBbfeEXgxyglT4QiiAIHEXx0x2h1aq6Y4GQRl1PY6pQeyQROKpx/6I2?=
 =?us-ascii?Q?/ukaGHjb6sn0zV3MPePrwL0he/ZwGudeJDUzE54vQppxoC8JPw0McU12mAJm?=
 =?us-ascii?Q?8AQs3HjNEJ4qRDDMWNT7RTH9SfqpVDK2anbyjkbQXHXDECh0jTSddwHHJo7G?=
 =?us-ascii?Q?8HgZTxmjZGosZK1NxRZ7fArZ7bdiXkvnipyWJdpzqLv1CZTLk729vACVtlOK?=
 =?us-ascii?Q?qYihTyrAPz5u7OdIi+zEFCvD/l2KMWxX9ekZdaPFVeRqrpT5Lvd+GkO6sigD?=
 =?us-ascii?Q?L5OYyvgLt6Tir3VzMDi7F+aYeIhCI3psPx2D8jeTZ8NL0+crce6/v5Cg9/i7?=
 =?us-ascii?Q?drD1IAs7q+YiTE6HteJmIBPAuJ4cyT16WJtr2BB8lv6ywDj7FwJyku3mUPWY?=
 =?us-ascii?Q?nhT/2chukCqTjbhbRbt9CTaU6LAGz1ZBFePDOXm3NHgosG0lDsDhVdmRIxOi?=
 =?us-ascii?Q?uYWKMndq8xM45yUaWucVCdkAtKptr4P5/vXAGxAPXf3KPYR4SKzt4YZy3Krv?=
 =?us-ascii?Q?COsorH0XchbRan6oM1ObBedeF9bVm7i2fCo5wJx9MQI/SIq06V4wC0WVswa+?=
 =?us-ascii?Q?JGMIEVG/vdQeD7DPj+lX8qca77DxhiYDdUovHpkmiORF5RZB0aCWPWm/kHDR?=
 =?us-ascii?Q?nYFhpvNn7qwmyJAsXnAfhP12eHsroXOmVbrdptcg/Xo55ifLFEBdEiXfxC3s?=
 =?us-ascii?Q?Dq4D5ZHCnEbRMFxbrmETibXDGlgv6bg4XuIvG8TTFA+0+r/jJ3/gMNrBHR8l?=
 =?us-ascii?Q?qPQu5f3Ona5GeumMw4wFklOs9DnAYQNjjlVPEY8+uy7sEMiD3dqbSudDAkWV?=
 =?us-ascii?Q?4s/x7g3WyhnLdFZVMr5b6ndXdPpx3lRvJUKLoLJxqrQilF4Bn48U79g6WZ3I?=
 =?us-ascii?Q?6hG9YStpCBXTkvD2gOyqloPvKfi57PZE45nNfHJ3qpMNuST2ecI/h22Pb/ju?=
 =?us-ascii?Q?Vi+8IerHINgUP/aEIfw1NEZHvh+xnRpL7NFBdUlgLcdmoA3rDAOr3qvaXesQ?=
 =?us-ascii?Q?UqUwMu5G2649qbl/IjW50nM3HCOPsJYeIJgZyiRhPf/0dibcUytdVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNfQgEeYhaI48aOslKJWMcW4WewSmR8Aqb/dOOPt2sKmak7y5fwBNbIvhsI1?=
 =?us-ascii?Q?hghapDJfaa9LGZHWdmlBSlrqtperUScCPIMzelaZbDyV5+w3aQzmRtzNm/fN?=
 =?us-ascii?Q?MV1swvbiQFMViX64KCoH/cKZdus2hbiW/UkEGgqpn6/OiALs8C/gbg8PG0ww?=
 =?us-ascii?Q?vMXmvUbHiZf2k7AELch/EH4QonX14tOIBYADhtYf4FoBvLmQ6ezKooYk9CmE?=
 =?us-ascii?Q?rLxGYq2oGj3tdHmY8GEkSAmUFZWhKshbDGw2zxpbFyc7shxRG7bb8p0cXdHA?=
 =?us-ascii?Q?77KthiXV0MCNnHK39K+c1Q0u3o2E96k6+JjqoChVXoRZzC4u6KTd2pPlLS3d?=
 =?us-ascii?Q?eaTlxQWxca0NKURp8QqbKIlPCvHBIhOWWfF1QewxhTdoDZSIoI/lK6/hLC1U?=
 =?us-ascii?Q?J8zZLCrGKBbN5bfm/57uqDhZTx0xgj2hZ8gLCT+8l3Js8K1gS6+NGIsWBZ+Z?=
 =?us-ascii?Q?yk7rJWYEJeZHg/KRt/pyBBPGT+MpasWy8MuqvxL2JPkuyIdaPbsHRzNhxZiP?=
 =?us-ascii?Q?n0AlHhhjDKM7GFKsVc00NV9hSgkALyjXb5N0p5IyFqNmgW4TOdEmY1lPMlPV?=
 =?us-ascii?Q?di6tHbMCNSAsJNWgYnXGxl+yV8q1MGDtHi0ozoJ4E+x0Xh+C3o0r3rBmbv0O?=
 =?us-ascii?Q?Or3/scq8+0rdV1/st6lIYd710M+4ofd1tRxhBPLH6stmigJ2yfggwCeervs3?=
 =?us-ascii?Q?tUR8gjc409YnT8Aa/slhw/e/2+oZG5nk0grGvtBCZFv2IrMfFQ67H34qGslG?=
 =?us-ascii?Q?K3a9TM5MUs/dQ0w6uPr7mvBukXTKfsjlySeYHcBMJQvWx7Nvlp11fDEdQMg+?=
 =?us-ascii?Q?39FZ4MrdasszmZrYQwXOBFlwREGNTD1PZwPtr2zrqP38J+tAo1UzAHb0M8hg?=
 =?us-ascii?Q?rPrDTBuZKJWsJiBTFG/3qHxuxGW6bjt+kunzeWTPEnEUnuWprZ2ifHxbqC7/?=
 =?us-ascii?Q?yv/vyEMRV1hMUgXKIgkbHK+MVfC0YIIoCCmjbCbeLWKUQnLrs+P8BhriEQg1?=
 =?us-ascii?Q?lPpZr0UFaYbJcRwknxRWpWUnBox+DHgGbMPjlBriYusEjUHHrTvmGp8mB2JH?=
 =?us-ascii?Q?DGZBdKLt9CgheZ0PdjriMzGGXlPud9+TmZBgyl8+QfHqpqSNrlMJ8n9pWV+O?=
 =?us-ascii?Q?BpPaibNZrku2OHoiUJ6S/UnbAENUCSpJ7Enj7q7pU/wUqpVJYStyBtXOgpsl?=
 =?us-ascii?Q?6CkrBYO8ggf82p7sGWdOBFtiibELdyTUgBOXw3dRi6x4Mpp1QUUuKXyy3zjv?=
 =?us-ascii?Q?HP1PMwX5YNEiWwISS9aesZDHYAnCEJJmhgce4GI5ecb/VTJ3t1qoWmymWzV4?=
 =?us-ascii?Q?2ujJdn2SNza26j+IRXdriXsUywDXOm7YQ+RMhYWh37YRar5glJZ74J819p++?=
 =?us-ascii?Q?ff/5X+6TKvImWrzfre0mC2IgpwX0nswpK3ak09fW3iByGjU5Z1wXRfou//+J?=
 =?us-ascii?Q?yCiZXQdMgA/fv9Nw8/24iBcKPjmIJOj5wUPYYdps/Cq4bdt+sMHuKU59dH2D?=
 =?us-ascii?Q?X0n03ROFSZuZ9YuuXCXul1DUK5hRpEdHLbFBPH8pFbjwtUtAMnVIi1bwNr1W?=
 =?us-ascii?Q?UOVvC0KWr3cLMvkiiUVobDxvAredAZV53xoDx0M+mLWqXrVrw/b1bMb+xD+Y?=
 =?us-ascii?Q?nIlsGNzYNeu52GAka4Vj7ew=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43430bf1-299e-4b86-938e-08ddbecaf0d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:28:19.5608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZ5PNd2igtR6Poqq+t6+ZFnPys2t41MaRZSMNv7KmMfkkpd2VAhKU1uYZ7g8a1bl7WUG1k52FAGuskTty5KObtl0xHIXtZDTiz0R5BxzVuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9732
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

several fixes for airoha ethernet driver

Changes v2:
 * update patches description
 * improve formatting a bit

Changes v3:
 * national letters were replaced with the corresponding english letters
 * code was tested on 32-bit and 64-bit airoha boards both

Changes v4:
 * fix transmission of short packets (length < 60)

Mikhail Kshevetskiy (4):
  drivers/net/airoha_eth: add missing terminator for compatible devices
    list
  drivers/net/airoha_eth: fix packet transmission errors
  drivers/net/airoha_eth: fix stalling in package receiving
  drivers/net/airoha_eth: enable hw padding of short tx packets

 drivers/net/airoha_eth.c | 82 +++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 17 deletions(-)

-- 
2.47.2

