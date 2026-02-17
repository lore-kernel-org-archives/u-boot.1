Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DE5E68176
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25A0183C61;
	Tue, 17 Feb 2026 12:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="CR5KzrrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8619F83AA9; Tue, 17 Feb 2026 12:53:42 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF8483AA9
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcnkvnQaYQyUo+iI1k36oGMFn6cYZEjjutrwTaH+1tC002bIm8JwfB+7sBCBChABvuR2HHI1b8YG4hMXIyhT6lZVNOd6sST3dpsTYhiWD7hUUA3egBEVCTYfVivAFX8ZI9pDXX9BgxbLORf6aCO7b4BfhoupkLfaY2Hc30N9pHawbJTddX9UCBIdGgaqJusxQ0omw+9Zm754rzwBDf4+/y6RxmoRNqCdKcTnbY89yPfkICSmN+O8pjABJJcasnVRgmwbsTw61usWt6x1NWYxcOBjIjOPQtjCmFD0bH3OVC2ry0J5LCaiVnipLuBCtzkJktsN0xCmyIBDFg2A4eSE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZcgDlMtHqaxl/bk1Yi/RUlXoB1ciBC+cqmNTXoOsr0=;
 b=Z6/PoTlP3HDtWJwaixIpqHSDDQaYuxsjoHLJFIKCK7VeHGIRczSHb9vGZiEJEnVU1IEGIHkpqZTb5RUz2r3mTEFwrCOQLN3+tnOcnRMqQUdHkrDlzDLOf1+qGN6Ztda1aC6ZOXO0IztqMHLW3EhB5UH9y4Syjw2IyX3AZ2Vpp1LhKQsmj7NmwnzxiC5kxT6yeQgJyWitHscfZDGJ7Zekk8ktk+ROIaC37wEpeEEkE31suT2D5WhHAEiiRN/LhB2JTNwgZ9dSnI3tnjdtQ9VSZU9Izbe6kecgITqZ8mOKHNlAGXKMQmxfs40EhejmzQcx83GzpDig9rSQR27jGqGmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZcgDlMtHqaxl/bk1Yi/RUlXoB1ciBC+cqmNTXoOsr0=;
 b=CR5KzrrU1UxIz+/P0ohOzELLQRgoCzJ5TX3kGHGxAiVFG5MXTz2jM98mNowofjJbI37NB2/m2fmgAxnZLiEgEmRB1B6fwzAcJJcBiStAqxAzJ7lmq3Q7EFJAOIfKY3PEd1YoVbPSA14TQe3mkpK4dsNC67/HxJKMWz35UH2BQN9T/7+0ZGYRe/9a9QfXHRe9QP+hmS12EbXQ7LyiAYFvzUeVHiziMgGR+qEYKYmkwldZNYNFkkMkl63wN/wTOGbLEH8dzhN8EpjlS0WzTwRv2UrjgX1s/g9sqLsp8bIdD67e/x25jhpdzkY147H0np3DYv4Yrap2nfN81oBURJJTww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:36 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:36 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 0/6] UEFI Capsule - PKCS11 Support
Date: Tue, 17 Feb 2026 12:53:26 +0100
Message-ID: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd06320-485a-41c3-e5bd-08de6e1b2ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8DjShDEjkATVKG7bGuTduIXEhbog43tVQOvT+5iUYJICt6txZcl7nzD51oZl?=
 =?us-ascii?Q?shuhdw9CnP3gESqSmZ9/3y/+WpIjwoMsmJ+U/N8vUhy1MRkpH5qV2STh+lEt?=
 =?us-ascii?Q?MwwzVUua+zrgD4T6cjqB8HaSuDpSPDF79q2DQCB0lgDE2H+xirP9cfffvGCN?=
 =?us-ascii?Q?auFkpQcCphWn5SDEBn/X/MUkI60FzXiATWOt5sAtoRvM3TrOn67C70LHWHSJ?=
 =?us-ascii?Q?ifESpuZ29faP7XtXOXQ+a/1/HDt6qk2A5PLMox5DCEZMsrMJYPz9aGqtfsQx?=
 =?us-ascii?Q?BCHv3AOBLxiaydN1XR+YyZYw5A0EbA/y7btBptSSv8soc/sR3tArVcoVqFkr?=
 =?us-ascii?Q?FdaRs4nkp/hUmmQjIRDCmWezF2Bfu58PNYp9HbSFkJ3Z0gzkTPvXjecnMUJL?=
 =?us-ascii?Q?nCd8V25XV/4ddZhyx6JBUgmVGvpt08zI4MZjfXGtHny4S0sE1JwJ0A5Ri3BW?=
 =?us-ascii?Q?K4b9ccEbK4yfr9duRxuFl5H+36H21TIlOLrqjGmNcfqLepqxv3EJ5dHARrgQ?=
 =?us-ascii?Q?BM+zq9oNaoHzuk8Z1hltS9jll3MayPkltqbtGPGYE4li3yZA6RhZlGbKjZrL?=
 =?us-ascii?Q?YbnLl3tW7uHKc63ol/1LTkfxiBVxu4Eg86XPbs96g85C18N60BtvbwHMWdq7?=
 =?us-ascii?Q?yp1BCyUR1T4DOKDuNJgNrP+qyw+eVeruYkmBW3kd+pkJypJTQupF5vF2AFMx?=
 =?us-ascii?Q?ek3WS+UoeBnscdenI+TL3icMXoh7WrgEU+16UP68R33runblM16j4w+D7ys0?=
 =?us-ascii?Q?WSCD4bKx7Fzu0SE2Gqx2NMAFAi1Dm8koVUkeVdBNCf7F5kzMnP1w0dLhq9Fu?=
 =?us-ascii?Q?7NNMoX6cZI1aOcgwhLhkr3dkGqzc2RWwQgCU5KfyfC8yIOCPsDoe7L1gT9sk?=
 =?us-ascii?Q?nArTvw/BFmf05BRjuxxpjGmWe7EsJ/slgkB74HFy9KHxwqWdraAtZuMfOQsX?=
 =?us-ascii?Q?zMuzyiGxDqgcCh0wy8k6XIRJLC9WAKlHZLCXgXdQIPw1ZiV96za/nFkDVLvF?=
 =?us-ascii?Q?umzR+Sf0pcSyeSitQUEpIOyJrblvILWQSSB0brtOI4iHLKUgoubvhViSLT9X?=
 =?us-ascii?Q?kzmxuHVm+EYXO8AR0gIvxaUFCFNog7n0RjFvZIhhrKSSeAZaSEgcOTmitXUl?=
 =?us-ascii?Q?hShVLWFpDwtIrydrpy6cAi4jw2bgYBpJP4Swg7OO4fALoQCU+oOBEEg6/XfU?=
 =?us-ascii?Q?0ap91ZUNP+yBFKPTvZwa13Il+IpJy2pHeFuSEtIetLCGWug2w4qDMRlSbZ2o?=
 =?us-ascii?Q?O8X3NnIIoOu24EAO+OXcw2zufJCw1wtq3aVptQxytRlapS8lywiEx5tJdlWg?=
 =?us-ascii?Q?P8d77usn0cPldS6DR2e9w3FGM5sKA/Qlb1d/2HJlfYLRlmUhNCKXIAqDB3jI?=
 =?us-ascii?Q?I2La7FM6TNtyZ8iIUatYMqtqKuaHOUcgsWv6hPPIT6vEBmFKT+WVNhMvHhEe?=
 =?us-ascii?Q?IJl12M9MRFtHIWXRlnmPHVR6ZC+BdJqwatfUwRqHU57M0CmaDImrettZOcln?=
 =?us-ascii?Q?WjzRf50DBu42YrHKaMs7DI3VjMILNFUZTKLJ+drdzBQIIE1E3a8kUAiZJ3FV?=
 =?us-ascii?Q?f194Jioeu9pzBm9zm41bkFV0ZDqf0TzqWLxe2Kr5VGfOKVocNqiIJF34jlJj?=
 =?us-ascii?Q?Jvtyqi4U/jdfjiqOSAE2kCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zg6ljDQc9SYbtbjXrjfRHZbNfLXHj4bQ8ibp8Im2Q5HKvprXqEccZFWT+nS4?=
 =?us-ascii?Q?SVlbs5c+ZJcN/06NS0dwF6Wc7yikaCPaJHeOXxrE42Ie1VaHSlAdHYYFf7Fa?=
 =?us-ascii?Q?okk3yyfAoQoRRQxYxAvQnQh7xcKG8NCuGm6yuSictZCjRKTvhIQT+xC1o+zP?=
 =?us-ascii?Q?Wu/SojcMNsuxCogn8vJtlCXyOqrwqy2Np/wNnieQHUlSXjErLZvPhEtEKhoS?=
 =?us-ascii?Q?/p4YX+GXPGzZE5hKrv8/p4e2j9+Bs3IsWg4A29jfAuvbMzO1v6KZXaDJxIln?=
 =?us-ascii?Q?bs6StPDvQ68CThngqVvRWxlE03zMyjSESUBTgg8sUKM2rwzrPyf9zbSv83VN?=
 =?us-ascii?Q?+B0fRGAY5NlkVXI2e9uKM9I2kGSgs+rZXteoxXxPYuUmol1UGJUsnlFXckmQ?=
 =?us-ascii?Q?7hkdNzZY8kwpaPryJ2fux+3TYHy5CPanV9b7GimQQy2XS8VaQlVgC/WOW+s2?=
 =?us-ascii?Q?YMPW5wT8bzmG82L8rID0hZ6jZd8YDXK0QJA/hLJDs36L/NZn5fJfyuY7lRKx?=
 =?us-ascii?Q?ciA64WOCMmEIEXXxpHmTITldJ3JgTETorQ5xnMuDyQUv3TGRLsQ+P2geUmQL?=
 =?us-ascii?Q?L8+sBpmkMV5KE6LzUZazrvHGJa9GDqspws3Zg8pdKtilJeH7UgT2arDplvn7?=
 =?us-ascii?Q?2Er87PImJLO1bkjjeriHeaBMB5fl/FUqroJAl8h6EDSuLvvanBxHdkgH9hpH?=
 =?us-ascii?Q?L3Jw78nqa/+BDQ3EL4kI3CrT0crgyG5hakfKnoHQIQn1n9aYiIbzdJuamO3p?=
 =?us-ascii?Q?qg47eVWiwsDZB6JQrvHCtZBSQWb95v6xz+uBxznF9yokWRa10ej6OqRmk0Jv?=
 =?us-ascii?Q?AiqgMTiiSnUM1WwHog+08nnRcvyb1cPV/6nrTg0YJTlMEEwWYmuuE0N8m4ob?=
 =?us-ascii?Q?Lvnnqwrx62uczXLzDU+iE+PIDRzVkDUsY1I6Bfmn8PmOA0UpOQIFvybcL3rX?=
 =?us-ascii?Q?gTfXSHDmfwMocNC76ZjK/2w/avC/RxWQP5jKEbO3pXTOKdaAhKM+aadcdM8L?=
 =?us-ascii?Q?UGna5EoUxH4u5mi/LtbEZrqaPBZIRQ4UeasJ88mtsLSPfYgHznX3ezBoqMvD?=
 =?us-ascii?Q?vGLMSgatGvHdvsv7m2ekAfeNIsK5oeCU0c9JoiIHc/RL281fkTsUdVCKO9KM?=
 =?us-ascii?Q?6/y9NSbIqnxkL5Fs2hBqdgkmxv9B5DcUOBheM8T5QGRyqdJn6QqRg8hYV2xE?=
 =?us-ascii?Q?hQWyhUdPwGjr01ba0PGrW3LaKWdmqhyBK/117szcmHGmjI4KyT5/gfkJhGve?=
 =?us-ascii?Q?vgwiDL/v/YhxYY8cGE3iWmswTBoiEFcfZLVPQpS8z03f10rLQBGawCbq7kHa?=
 =?us-ascii?Q?VmCGZRelDOD6QPYbIxmvDPkRk9Vf+YEIK9jNuPOP+gCE+uONYYOMuvD6rZkg?=
 =?us-ascii?Q?TWTSTkW5L/ZJNArh6+6t89daO7tcfFNP17crM35OJAvLGZgNuxnCn+XeSepK?=
 =?us-ascii?Q?3pIFznFnMQIteDB2UcoppspTz0fHFcJI/blcEcbGshC2anPhyWJHRxVaHOS9?=
 =?us-ascii?Q?kLz7cEqjlzXJv2P8wVK8sEvjDEahXxsyGtOOQhRgiYljxs6FBe9gL/lc6coL?=
 =?us-ascii?Q?L6vfK4a72Y7YXBZBqFetYMmzF2hEPVp4sE1bEgnczL6XyXlIqfinOHv3wS8g?=
 =?us-ascii?Q?+pTqgF772kLhU7Zx6i+ObXrtPNIm04emR0pa5hszAPwUacAqR2b4I0QXBV78?=
 =?us-ascii?Q?IY1uIR8ws1bkT1aaB6/7P30cEIxbd6s3HxKrS3N61+JoT4v4LJ094QTVahjI?=
 =?us-ascii?Q?/aHg4rw4kQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd06320-485a-41c3-e5bd-08de6e1b2ea2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:36.0095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onRU+jbngttoM/+B547FagIiJhw5RlNKx43dBk8HiRXrpMqZPNQN2KD2MLugTIrqk8zHtt24EczMQqwsRLLlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6761
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

Add support for pkcs11 URI's when generating UEFI capsules and
accept URI's for certificate in dts capsule nodes.
Example:
export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v6:
* mkeficapsule: use strlen instead of hardcoded values
Changes in v5:
* add bin wrappers in test for all external tools
* improve error handling in python test
* fix data types in python
* standardize option name in mkeficapsule
* fix typos
Changes in v4:
* adapt mkeficapsule python support to dump detached signature
  for authenticated capsules
* verify detached capsule signature with openssl after generation
* use p11-kit to figure out location of softhsm2 library
* fix missing long option for dumping signatures in mkeficapsule
Changes in v3:
* fix write file encoding, env setting and extra line in binman test
  after review
Changes in v2:
* allow mixed file/pkcs11 URI as key specification in mkeficapsule
* fix logic for accepting pkcs11 URI in binman device tree sections
* add binman test for UEFI capsule signature where private key comes
  from softHSM
---
Wojciech Dubowik (6):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates
  tools: mkeficapsule: Fix dump signature long option
  binman: Add dump signature option to mkeficapsule
  binman: DTS: Add dump-signature option for capsules
  test: binman: Add test for pkcs11 signed capsule

 doc/mkeficapsule.1                            |   4 +-
 tools/binman/btool/mkeficapsule.py            |   8 +-
 tools/binman/btool/p11_kit.py                 |  21 ++++
 tools/binman/entries.rst                      |   4 +
 tools/binman/etype/efi_capsule.py             |  17 ++-
 tools/binman/ftest.py                         |  66 ++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
 tools/mkeficapsule.c                          | 113 +++++++++++++-----
 8 files changed, 221 insertions(+), 34 deletions(-)
 create mode 100644 tools/binman/btool/p11_kit.py
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

-- 
2.47.3

