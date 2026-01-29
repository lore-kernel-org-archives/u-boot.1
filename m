Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F4BD358F7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DDD483FA3;
	Thu, 29 Jan 2026 11:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="R2kLDCYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1DA83FA3; Thu, 29 Jan 2026 11:54:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78D083D1A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/Rll38/Em/XWETxSVFAG/n1RabMP6MB7h9FH9FKgPg62USPWNXmq242tioAv2ngjcGGYwKh20+Lnb5Gn6Y2Z0r/eHa4y5heMF50m7aOAJ51M6RIhE1bNFK6//ptERk7eI6cibcJtuugROAZOI/K0BkUKSPD4NtSThUjtgvbcPZV0wXNxii1I/ONT1OTALTEwwcurIcrriIYZOl0EjA0qOyYnK5lqiYHGJTIjsf6CfC1xWSiA86KSClZzasSDb8u47+WUyp3elL8I0BaFEfcaXvBWoYDvoT+FH/9b9gJf7SatEcWF+jQgikQ3zGnw7E/oO1kRDBWdbRQvDYi1MJ+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCzeEhddV24CbHIMBHLdbKIBvMOmQbpatc4Lt3eWJLE=;
 b=U4vsyknUMx7wrWcw9tpK0dz3wjc3JBN3/tsWqleEs3X5JhTNpcSFE7aEih1yHXzQPAbS1H+FFARUVufSbd95dhUYmncrLpQh7ae/+J5XrXObSYdDN7nsHm+nwBpP7TfWIcR/yv/fRY0mtQ9WJ7VBPimrPysOyZKb9lNSLhOWNy1lvsMi68WXk0T/NMbiLQ09gaSpuyCu+wK++PyQAMh4oo05fkDRDI1NtQU7ycKCq/5OOYnlEw3LuBaPc2+pVLiTGcNr8Jpu3KdkLvJUWMDVbN53b9M2pWSRomNdw/DeLV2xHIeMtrYKPDNNAxs8hjAiO908FrAzf3xDBHWG6TQF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCzeEhddV24CbHIMBHLdbKIBvMOmQbpatc4Lt3eWJLE=;
 b=R2kLDCYyce2BfLXLPqx8GUfsE9seHLUXKrCNPp5Ym8gsKhZSVWyFfMH6G+DqwqoWIZWh4/H0zegz+aAtat0lB0PVEOCCk4IoMrulS3J9XFplIpbYIv3j0LdIDRLA/qrOH1ATng6ikTM8OvwVkDx+42et0jK7PyCKVBlu1undx4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:54:40 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:54:40 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/2] doc: am335x: document use of
 CONFIG_SPL_AM33XX_MMCSD_MULTIPLE
Date: Thu, 29 Jan 2026 11:54:33 +0100
Message-ID: <20260129105433.2624686-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129105433.2624686-1-ravi@prevas.dk>
References: <20260129105433.2624686-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0020.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::6)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: cca391a6-8b67-4d68-228c-08de5f24cd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdbEOiQncURha6pk+XuUDcqkbANxP3fdcEY5ZeKJKx8p9Koe3U2/A38e4ppu?=
 =?us-ascii?Q?3jXHR/w7M/FVmhlwB4XAuvrAo7JkWcN9ZZOQ4/l7U8AQvSvI4q8KMKbAqP3y?=
 =?us-ascii?Q?pRlPFEEGEL7lsucDawMqdz/8s4qcrsd6FMe4eYo4+2Es9ykAR+wJegKRL/bg?=
 =?us-ascii?Q?idQJ71HcmXU1LxdtyhQenwbgiYQodsv+0TOc4BC81ra60Fie1tKm9Ar4YB+3?=
 =?us-ascii?Q?w+ezz7Cz6CdHBVaMex9e3gl+ksH0YDr/TZjLxZhRA8mjHCNoQ/VTlc5T28ac?=
 =?us-ascii?Q?nobFkJenBOCTuUO2xaFZ+8SPljOHjWzGyAWYq3hMoYnfXkrGn/eb30u8iAZX?=
 =?us-ascii?Q?EyifJdoHcPEFcPViu7pnCP/eFmdBE5IP9gxiP/Bcr4oGXtcc6qqyaVaQC7NL?=
 =?us-ascii?Q?MYxRNQ9VdT3q/XN1n7M6qFJ64gKIj9KTMhczJyf23BJiT7AYGqRzBbV6vxlM?=
 =?us-ascii?Q?ygE0jBJ6AD/pXW3eIFA3QRnCuP+a/2W4BHBXVlFDW/6ab58pY6uPDFuWT4w/?=
 =?us-ascii?Q?Bl3J0FGIdvTyhvJunwO3h7Fr73ArvrTYlyeJvN8Yl+Kzt6ADa4Oieg0GbzzZ?=
 =?us-ascii?Q?ikzSJF45JcaEV3vJvGtFldtrkFStnMANvsJWvpQDvQt18/fMYU+yqnbmCdpo?=
 =?us-ascii?Q?Trf3FNarMAMoKXvgYSJLJBrqY2Jeft4IQE6g4KnH9KJd2Z8sz44sOdnnlHJN?=
 =?us-ascii?Q?1308PqIAJE57Fk04xflSOuIn9CuJUOwUyn3JJi+qo5/aUpHsGdpmFwj2eMk6?=
 =?us-ascii?Q?bmEOmcFpbYL7k8YiBfNHmB+8pgsw+I9ogt59dlsp/LDXhROAreK15t5E+hGI?=
 =?us-ascii?Q?UTjSrsmSXiuKSBqA3ai9jXZ9EVMViRZXTNUjcYctp78lz31hZfJGD6W1+Wnj?=
 =?us-ascii?Q?tGu2+ErWIjaCP4h5AwHdSF5eJ484DUKOOyqpBYI51ALDlHgUzYtuo7mCYwsr?=
 =?us-ascii?Q?g4UoJXtA0bq8TVfQ/08eK5ZUghk//YTYbnOJEuvncjuGQscONPUzvN9XlqF6?=
 =?us-ascii?Q?9DPMTaRfG/5tBlj+pjOLJhgBqYUcZ0j0hK9rNxwXEsh995rkVaKpWdHjU5xQ?=
 =?us-ascii?Q?mGeH2uSSsOXzQ+oAEdLAplq5vy8NnKQwsDw690R97/khsYbBm12JeoODkFPD?=
 =?us-ascii?Q?NNBgtQVLQZ6nY81//hbLeRxC3UR0jvLXFR7b2Zry1xY2Ba5FqgRGNShlRWMs?=
 =?us-ascii?Q?cMgQe3Ekx6qzLcul63dGIGfiFRcYwxL9MFs2rIVk026DnG8IE/7XXbgec/j5?=
 =?us-ascii?Q?8hp41venV81MGvqQehUJY58QZEx8UKizJoFr+FUHwzDOpbzW3RY5ONvExYlt?=
 =?us-ascii?Q?piT5x+PP2xiiSVhkw/O5T05RbCiuOzwvTYkl2Dx9mmPNexMdKbecTEOMAzjA?=
 =?us-ascii?Q?XEAklCHzdiELMlzc6iwDVECiDZZAsHLLRYjMoHFcNnxd+CStjB3GNM5icRWL?=
 =?us-ascii?Q?fWbG9ke+bRByctQ4FQ5ouIMI97Lrcq6kSyPHDxFU0bLiIghpYe/Kg4KEhoUb?=
 =?us-ascii?Q?mQT8+ykkti/bTzuKVzkQgmHonPsJmOe3KQdUwFSHOTeR5us/7U6dU1Skhc5x?=
 =?us-ascii?Q?3Yuw90k+oTXbwutgU3eDQ5osHszJHmwtyk/iZqUHGMfGeU2S7g/sfsVpTI32?=
 =?us-ascii?Q?d5JJfalC71Nv6Y9cBHtiIbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYvFsFyOj23hM01MX6NThvIJvqGL/fsk2vhnQz5ltZwrhQGGFlfEOcIsnDzz?=
 =?us-ascii?Q?talsRhpiFbHxWbWbfYF6oTH0Ak0HyAKmn9ImItnH0xU1MZXQiRG4kNtkJ3Ot?=
 =?us-ascii?Q?jVFFo2Xeu8fuem8JADMr0N3bdXG/d6aTo8+/XpZlNaI/pZ6h3xI4jn2PRahp?=
 =?us-ascii?Q?ycXD0ziFW1Rft8z+CSutNV6WRlIQjS1bcGVs0nXg4+TJf0o3EqgcifPxIdPc?=
 =?us-ascii?Q?/gNP5QaRoL8+/7PXP/YscKZ7X0+Fd37W8sHxidnY4QeuRhKi1E01VRbZ9gJq?=
 =?us-ascii?Q?8s9P3nciBU9LvGguXznY7sMjS+xoHLOwC66nDQNpBRYFdxL5b3TMLdEO7Qi7?=
 =?us-ascii?Q?r78TU5hJsW4S4QXfgOlqwBqJn4BsYmpfYPV1CZBCt/55VpmZyu+OA7XyZkUz?=
 =?us-ascii?Q?pO2WY2P3lAvth7lsHyc98YsAqLsy7013hw0T/dq3gz8QsmVuJkwmWecM42Ui?=
 =?us-ascii?Q?Jy8TzbS54HClLRo1gzGFpV+Iw3b1038/wm7F6EPUFIoADjqdtgsg76nQh0uc?=
 =?us-ascii?Q?fBH5GXftF9mJsulaFdfbM/1igQx9jknVnfzVr9FoMWU2jg6Tq30nnzP+5bYh?=
 =?us-ascii?Q?w/HnF10ySH//l/wMrAvSgpA05FrM/HDpPOIe/lo5KkWvJba/eFWIno2Khg/e?=
 =?us-ascii?Q?WpfSD6kmVxPfyzUXHXWi6PRmXssAONL9ccpxMrzQgYGhHTzHxK/BVDPAtjBd?=
 =?us-ascii?Q?YIeAQhTJpXN77U9liqSFOBfaDD5xAegQFVPJHYFOP86eXfi8WA3BmUku0N5z?=
 =?us-ascii?Q?sD7DjrTSpC73p3veLtqMkPloK2+Fl09+dSDKMYKGH70lYQyfusMDMej4CdM8?=
 =?us-ascii?Q?1gXprflEOUonDZi3wsVQcHaY6oeDlc4snuSCLIOrwEYabTQrG+qoGDKu1p/K?=
 =?us-ascii?Q?9cs11jjE9qJ2SO/VlCNy8gHQ9z3w3n/bJLW77X4LnSaCXX3b8SHcZfRb3nYz?=
 =?us-ascii?Q?sG/B5DsnneufzFD52cHJ1L1aXwExuVJTPW543WfVno0zBI0NnffLBXEKUeis?=
 =?us-ascii?Q?kwmZMNmthnZBSJGVC+mcCL5KfnyZ+RJeMdJTqQkLb0VvivGF7Im8VYiaY1+d?=
 =?us-ascii?Q?jXmF7a1UU4QhZYeUue65GPKFi4/oYlO9KLLrhe/M6y5nW7M5fqcXLt6WHUe5?=
 =?us-ascii?Q?z1yOA+1C/ArGjvDQyEJIDi/eREnOi0gQANS5O9X5BGOaZd8cOiN+Fs3JHqW1?=
 =?us-ascii?Q?gfJjXDKYMkqp7J4nhtvv7DepDh25BCei+VuyyCBGze2m4pUANAp84psIuAgC?=
 =?us-ascii?Q?nFzThsAAasCtOGhIrT5t8k2+P+nY1qRc39U2VPhZgdNbaAkVdrGiXdifyjkO?=
 =?us-ascii?Q?iEf/aBb0kUB/tdO5rp8HQJp6jdhxufFbCEGUrFPAbDp/O9V3FNaUtU/HSBoa?=
 =?us-ascii?Q?DU9I5NkWaPW6+97M2yK8MXcvqYh/FGG4Uw1j2l3rZVm8aiUsUGFtCdPzY1El?=
 =?us-ascii?Q?YUd2zXrk9LNbdhYSRNaJ4xipm3hJOXRBQjB1F87HRZDov3ByaqbiOCoNL98C?=
 =?us-ascii?Q?NeiVtusSMoVRu0D/9X1+1fUlKHdkBHK6m/BGrT43K5IskKQWQIscELns05vg?=
 =?us-ascii?Q?dbKKLKj/3TI9C3bDLPAjaydvS1swRshqkgpt0Hhxcfx5887waGz1hCEDDh/M?=
 =?us-ascii?Q?SPfLEsJJgWNYhqwZ1/10sHQCnDqtOm6dsnKCkrRFjCeRVMUKehpdugO+MnFz?=
 =?us-ascii?Q?OyVu5SLO19WsT3w3TavX7lvrHwWgESuunFpjk60etsDJF8fV/k1iufA6blwh?=
 =?us-ascii?Q?goXKK4s5nuf4myvgsVD6yOY27yH64ww=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cca391a6-8b67-4d68-228c-08de5f24cd6b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:54:40.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hLU8VNzVIbd3++vDWSkBqjzYSO1j7Q9vuegKkkT6cacC8NN4VfDhV2tr4V+e9IT0dx47Oie2du1kvO7JxpG1hYBp20bPHwJjZT78XOpJSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936
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

Document how one can use the CONFIG_SPL_AM33XX_MMCSD_MULTIPLE option
to implement a scheme for failsafe updating of the whole bootloader on
the am335x.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/board/ti/am335x_evm.rst | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index b14ba41917e..904881b4146 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -481,3 +481,83 @@ bind with it:
   misc          0  [ + ]   ti-musb-wrapper       |   |-- usb@47400000
   usb           0  [   ]   ti-musb-peripheral    |   |   |-- usb@47401000
   usb           0  [   ]   ti-musb-host          |   |   `-- usb@47401800
+
+Failsafe bootloader update
+--------------------------
+
+As indicated above, the ROM code on the AM335x supports loading SPL
+from one of several different locations. It looks at offsets 0,
+128KiB, 256KiB and 384KiB (sectors 0, 0x100, 0x200, 0x300) for a
+sector containing a valid "TOC structure" (see the reference manual
+for details).
+
+This can be used to implement a scheme for updating SPL which is
+robust against power failure or other interruptions: Suppose we store
+copies of SPL (wrapped in the "MLO" image, which is what includes that
+TOC structure) at offsets 128KiB and 256KiB, and let us refer to those
+two locations as slot 1 and slot 2.
+
+The whole procedure maintains the invariant that at any time, at
+least one of the slots contains a complete and valid MLO image. In
+order to update SPL:
+
+(1) Determine a slot X containing a valid image (by having a proper
+    TOC structure in the first sector). Designate the other
+    slot Y. Since the TOC is always the same 512 bytes (see section
+    26.1.11 in the reference manual), checking for a valid image can
+    be done using something like
+
+.. code-block:: bash
+
+   if cmp -s -n 512 MLO /path/to/SPL-1 ; then
+     X=1
+     Y=2
+   elif cmp -s -n 512 MLO /path/to/SPL-2 ; then
+     X=2
+     Y=1
+   else
+     # invariant broken, fatal error, refuse update...
+   fi
+
+(2) Ensure Y will be deemed invalid by the ROM code by writing all
+    zeroes to the first sector of Y, for example using
+
+.. code-block:: bash
+
+   dd if=/dev/zero of=/path/to/SPL-Y bs=512 count=1 conv=fsync
+
+(3) Write everything but the first sector of the MLO image to slot Y:
+
+.. code-block:: bash
+
+   dd if=MLO of=/path/to/SPL-Y bs=512 skip=1 seek=1 conv=fsync
+
+(4) Write the TOC structure to slot Y:
+
+.. code-block:: bash
+
+   dd if=MLO of=/path/to/SPL-Y bs=512 count=1 conv=fsync
+
+(5) Repeat steps (2)--(4) for slot X.
+
+Now, this procedure only accounts for safely updating SPL. If U-Boot
+proper is only stored in a single location, there is no way to update
+that which is safe against powercut during the update. However, by
+selecting the configuration option CONFIG_SPL_AM33XX_MMCSD_MULTIPLE,
+you can tell SPL to load U-Boot proper from a location which depends on
+where SPL itself was loaded from. Hence, one can for example put
+copies of u-boot.img at offsets 512KiB and 1536KiB, and set
+
+::
+
+  CONFIG_SPL_AM33XX_MMCSD_MULTIPLE=y
+  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_128K=0x400
+  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_256K=0xc00
+
+and amend the step (3) above by
+
+   Write U-Boot proper to the location corresponding to slot Y:
+
+.. code-block:: bash
+
+    dd if=u-boot.img of=/path/to/U-BOOT-Y bs=512 conv=fsync
-- 
2.52.0

