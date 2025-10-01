Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F8CCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 07:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01983802C1;
	Wed,  1 Oct 2025 09:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="NItR25Cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD24807C0; Wed,  1 Oct 2025 09:45:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82AB800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 09:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UscRzniso/Pl1R1DVbIOsyTftgSWTH80AkYUmQatKZuyNXp2P/SfFVlSEojEXjkEmBwjfNVKdVAGzFahMC+BYUlBCdp3EHqbMytmXA3yR/st+sIuJgQLQKOfxTa8R7SAJLuyHOTbNdQtsz3IwqQqmy4xk+jnEgmlJJX9BMhs3hkKxe6PhX0NTiZtYOWPIYItm0gRUbSOTEZMJCNMXWzIKz/bsdZn6TzL8ky+QKAAG7peI/fa/caisTgvMzO0/W7ZNoN/w24nCyjxgbp2jezSfTN4PMDuVLY56IvHqR1bZKI2p2wEwp7Rutv1BZSzSkM6obsKT1MB4C0BkHwfeKqu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyf/wNqt4/bqhpa5QbBzTArkfl0xMtwM5xZkOSQZaKM=;
 b=dGFe+zqsh7f7CpnsEjykd19Np+TtI9AduoBjYQ2NKmx2x3afpIo1sBPqDdhgSL6++LwvC3kAtKS0cSWdxN2d1sNCarQDu+AigKmc2XQWGlRz2By/I6yAXqLh9JTRVYGuI3OrDul/dJl4mVam7mc6gKDnE6MoxfYh22oY1XE1hORL9T+sZVowwaeNyHoGkANaVkIIF9oydn9TXbqhmoY8eoBTbIKMCKxoiurALsHevnry9CMHwOU8nzxHVauTm4nzCGcXH5d2PxpdXfygtLDif4feQ/c+LClu/kNZqWgPEu3FX9hDKHFgpf+PLx0+vwTb/ROD29MPycm53faY8maRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyf/wNqt4/bqhpa5QbBzTArkfl0xMtwM5xZkOSQZaKM=;
 b=NItR25CuYc0V6nm6B+6Eqkj75DMEbMxIjU82/Fm4znMo9Ip5QpXyO8oWvywVInNZuFzKhs6J8JIE9qqnWai4Znf8ZPbXRbLQh7UbJusqBJ1gpO9wiyGZoIq/yYzy+IC/ELr9s7yZcvmoMzNZUjTHgpwBDHX9n0q4fbq4n4oipLeUZkK5o7DwVko2FUzoWi++a8qnZa6bWFWyfOAgSaIgSnXePTLPVKHUgR5LCA+rpSvbZ1yTfzCVLRgR/Dk0k6rcyn/eJ8ozWHrmPCnppmhClZOvVP7d63lGFOVn9Bz4oMKy0TbJaHXxShcjcXYg7W03LAVVOJhplhgNXPVnF+P/rg==
Received: from AM0PR02CA0114.eurprd02.prod.outlook.com (2603:10a6:20b:28c::11)
 by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 07:44:59 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:20b:28c:cafe::28) by AM0PR02CA0114.outlook.office365.com
 (2603:10a6:20b:28c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 07:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 07:44:59 +0000
Received: from lws-schwan.phytec.de (172.25.32.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 09:44:58 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 1 Oct 2025 09:44:37 +0200
Subject: [PATCH] doc: pytest: Fix inline code and other formatting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251001-fix-doc-pytest-usage-code-v1-1-51256aa7dd0d@phytec.de>
X-B4-Tracking: v=1; b=H4sIAOTb3GgC/x2MQQqEMAwAvyI5G0iLHvQryx4kza652NKo7FL8u
 8HjwMw0MKkqBnPXoMqppnlzCH0HvC7bV1CTM0SKYyAK+NEfpsxY/rvYjoct7nBOglMYiCIPxDG
 B96WKy8/79b6uG49gKMVrAAAA
X-Change-ID: 20251001-fix-doc-pytest-usage-code-914002c40c2d
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|AS4P195MB1456:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f9c37c-40da-447e-5d8f-08de00be6c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTNuYUxCbXAzZTBoQUVPb3NpTW5ia01TUFExZXNqdWZwTFE3Sy85SG5DZVR3?=
 =?utf-8?B?cU5rOWQxWDdMUkJsY2JQZkVhZzZWVUs3ZXRsZDZyQXZuOUFOWStTVHpldmdP?=
 =?utf-8?B?SUJCZWlFSkdlSlJKQ1QwTnlsbDZKcHFUNWdFMEZxVjdzbkxTQ3J3eFkzSUFR?=
 =?utf-8?B?WjRzNHVoRC9sQUI0UjQ5TTRQVmpyeWNSenlLNCtQWmhuRkpRRE82RjRlNlJK?=
 =?utf-8?B?bkhIcXNySlNvMHM0ZVVjZDIzbDN6RStSNExpaDFFR3RiMTdRcXBoQnBOcWpE?=
 =?utf-8?B?NlY2Q2hKQmpZNFNNbE16bVBzc2JGbmNFL2FOckNwdVNWREkvMkQ0K2wwWkxj?=
 =?utf-8?B?MjhEbGVHU2NHVmFGbzN0K2N1Y0RMQlBGMHJIVEc5TlpSVTZyYmxDZ3labjBh?=
 =?utf-8?B?NVBwWlBBOU00VnFsSUdYWE9uNTBTQWFlb0NpSkw5bzRwNlBTem4xRmsrd1FJ?=
 =?utf-8?B?UDhqT2Fudk5KblY2dk5yNENLcnBNeHhPRFlrSjRoUW5aVHFKSW1zN2UyOUZ4?=
 =?utf-8?B?N09kcmtOc2NkemZ1UkJudWgvbWNsWnMyQVVKZGx2WTdhdUhnVTQzQ1N6QkJl?=
 =?utf-8?B?cXY1QTR4c2hLYVZmUE9wbFV1di9peDF6OWVZNklLa1gzdEQ1eVl1cU9SdktG?=
 =?utf-8?B?RXk2OW95MXRJQTRDWlR6T0ppV1ZySTBzSGVjcTNUTTExNURBZjEvS2JOR2xG?=
 =?utf-8?B?Vm03cjdhMCtMTWh4VWg2aFRQa1Rab3FRWGY2MnkrZWEzZXhpd051RmMvK1ho?=
 =?utf-8?B?NGNMWDBuMHlpRXVxRG5wcTB0d1dmUStvc3F5Z2JBQVgrRTUrYXAyRWJvSkNs?=
 =?utf-8?B?c1RkVzVmNTlXbEIvOWJaS0VTZGpvMlRDMmViQnNDZzc5OFhqTk0vYStpSHZp?=
 =?utf-8?B?NFZ1N21KK3RLcmZZdGVvUVdYR29ITnV4bi9pVU1nZDhJYVA2MWNZenhpbldQ?=
 =?utf-8?B?ZlVvRTJOYlFmUytzUEFtQ0pTR2ljM0w0dENmbFI1TnZhT3Z6SVNpZlpuQ2dr?=
 =?utf-8?B?NlNzMktSNVp6Z2xrODFMOW5KVGFldGJEK044RkpQbW5QVXhQdEdpR0NSZ0oy?=
 =?utf-8?B?d3liNWxmNzBYUytia2w0L0pUMmZGNytxdVlMTHpOVWRZdnMyMUxEc3FDc2ZO?=
 =?utf-8?B?cG8rdWlmbFRTa2tVZ2NRZys0c0NVMEZqRmowaERsTzI4N0J2dGEvT1cxZVpq?=
 =?utf-8?B?Q0V4Yzh1aDJxOWVJV2xvNWo3WldMRjRIRzdUcGZ6SnRrempjUDVMZjJtL3R6?=
 =?utf-8?B?T01QTEx6Ni9rUW9KV0FodWJQT1k3eWlRRElmM2V0MnF6VWZteFpoWm12YW1s?=
 =?utf-8?B?dXZXRWhIamFJMFJCd2JXMXZ2K2thU1BZT3J0Rlk2OVprKzl3WHgra0d4YmIr?=
 =?utf-8?B?VWtUS2ZySGRQUm05aUJFNmxnWkwwZ0dWRE5JSThESXMrQmthejFVYUxsaVNr?=
 =?utf-8?B?VS9DWEVWaWJYc091ZFo5cHJsNTRKWTk0Q1A1UlJ3M25yUEJsU0k3Y2dzdnVa?=
 =?utf-8?B?NmI3SkFNTDBmbjhUeEM2ZDdlaEpIRGQyVEh4a2V5d3RIL3hHeHpuSFdncDBx?=
 =?utf-8?B?SElOeFhaZk5UYUcrbEl6NVJpaTFDaUVaWTBYN3k1Zkh3Um0zWVJVRXdHYVpQ?=
 =?utf-8?B?bXNhTklUblZvdDVCOXNMTjRac1lMY25xVWk5anRRMlM3Ym5TSmRJN1FQdDVP?=
 =?utf-8?B?LzF5RnFoNGhST1BpMEFaakJ1em9aSm85OFFPNURyblpqSjU0aWJJclNxV2ho?=
 =?utf-8?B?RVBucDZDU2FESUFWdU5hVzJjQmFQL2I5eEcrNkVSMDU0YlUxc0RPZFdiZ09m?=
 =?utf-8?B?cTRtdnJnMmxoN3pkOVUyRHhja0VXeVRCS0NPNE1tMUhOOVVTaGhmQkdYZjdQ?=
 =?utf-8?B?QnZYMFR4bSsyRENmTldEa05DWmUrMlp1djVKTTQ1V0lrZGFIcnBGY1ZDY296?=
 =?utf-8?B?b2FSMUN3U25XVlJXaHN0d0Y2aThjV2tlall5OFBoaHB5dEdsaWY5NFliTHcr?=
 =?utf-8?B?WUdRRTRUanJPRjR0Qk9RaEpmaHNXUEdvcWtiM2JTK1JUYWVLb1FUcUdEQXNr?=
 =?utf-8?B?T3FVd2JxcGxVLytPWS9zTXRRNkVtWjBITlc4UGhjMFliY0k1RXNRckFXS3pz?=
 =?utf-8?Q?Vw5c=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 07:44:59.0192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9c37c-40da-447e-5d8f-08de00be6c1a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1456
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

Mainly fix inline code and some other formatting mistakes. Inline code
uses double backticks `` in reStructuredText instead of single backticks
as in Markdown.

Also fix some smaller formatting issues, such as excess colons before
literal blocks.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 doc/develop/pytest/usage.rst | 173 ++++++++++++++++++++++---------------------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 779b2dbe24bafd387e3323432ef74a944884177d..596b03973791bd8bbf1b8070af83782c43b25a3a 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -27,8 +27,8 @@ the appropriate time.
 
 In order to run the test suite at a minimum we require that both Python 3 and
 pip for Python 3 are installed. All of the required python modules are
-described in the requirements.txt file in the /test/py/ directory and can be
-installed via the command
+described in the ``requirements.txt`` file in the ``/test/py/`` directory and
+can be installed via the command
 
 .. code-block:: bash
 
@@ -62,18 +62,18 @@ The test script supports either:
   physical board, attach to the board's console stream, and reset the board.
   Further details are described later.
 
-The usage of the command 'sudo' is not allowed in tests. Using elevated
+The usage of the command ``sudo`` is not allowed in tests. Using elevated
 priviledges can lead to security concerns. Furthermore not all users may have
-administrator rights. Therefore the command 'sudo' must not be used in tests.
+administrator rights. Therefore the command ``sudo`` must not be used in tests.
 To create disk images we have helper functions located in
-`test/py/tests/fs_helper.py` which shall be used in any tests that require
+``test/py/tests/fs_helper.py`` which shall be used in any tests that require
 creating disk images.
 
 Using a Python sandbox to provide requirements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The recommended way to run the test suite, in order to ensure reproducibility
-is to use a Python sandbox such as `python -m venv` to set up the necessary
+is to use a Python sandbox such as ``python -m venv`` to set up the necessary
 environment.  This can be done via the following commands:
 
 
@@ -95,19 +95,19 @@ application), simply execute:
 
     ./test/py/test.py --bd sandbox --build
 
-The `--bd` option tells the test suite which board type is being tested. This
+The ``--bd`` option tells the test suite which board type is being tested. This
 lets the test suite know which features the board has, and hence exactly what
 can be tested.
 
-The `--build` option tells U-Boot to compile U-Boot. Alternatively, you may
+The ``--build`` option tells U-Boot to compile U-Boot. Alternatively, you may
 omit this option and build U-Boot yourself, in whatever way you choose, before
 running the test script.
 
 The test script will attach to U-Boot, execute all valid tests for the board,
 then print a summary of the test process. A complete log of the test session
-will be written to `${build_dir}/test-log.html`. This is best viewed in a web
+will be written to ``${build_dir}/test-log.html``. This is best viewed in a web
 browser, but may be read directly as plain text, perhaps with the aid of the
-`html2text` utility.
+``html2text`` utility.
 
 If sandbox crashes (e.g. with a segfault) you will see message like this::
 
@@ -134,23 +134,23 @@ First install support for parallel tests::
 
     sudo apt install python3-pytest-xdist
 
-or:::
+or::
 
     pip3 install pytest-xdist
 
-Then run the tests in parallel using the -n flag::
+Then run the tests in parallel using the ``-n`` flag::
 
     test/py/test.py -B sandbox --build --build-dir /tmp/b/sandbox -q -k \
         'not slow and not bootstd and not spi_flash' -n16
 
-You can also use `make pcheck` to run all tests in parallel. This uses a maximum
-of 16 threads, since the setup time is significant and there are under 1000
-tests.
+You can also use ``make pcheck`` to run all tests in parallel. This uses a
+maximum of 16 threads, since the setup time is significant and there are under
+1000 tests.
 
-Note that the `test-log.html` output does not work correctly at present with
+Note that the ``test-log.html`` output does not work correctly at present with
 parallel testing. All the threads write to it at once, so it is garbled.
 
-Note that the `tools/` tests still run each tool's tests once after the other,
+Note that the ``tools/`` tests still run each tool's tests once after the other,
 although within that, they do run in parallel. So for example, the buildman
 tests run in parallel, then the binman tests run in parallel. There would be a
 significant advantage to running them all in parallel together, but that would
@@ -163,12 +163,12 @@ Testing under a debugger
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 If you need to run sandbox under a debugger, you may pass the command-line
-option `--gdbserver COMM`. This causes two things to happens:
+option ``--gdbserver COMM``. This causes two things to happens:
 
 - Instead of running U-Boot directly, it will be run under gdbserver, with
-  debug communication via the channel `COMM`. You can attach a debugger to the
-  sandbox process in order to debug it. See `man gdbserver` and the example
-  below for details of valid values for `COMM`.
+  debug communication via the channel ``COMM``. You can attach a debugger to the
+  sandbox process in order to debug it. See ``man gdbserver`` and the example
+  below for details of valid values for ``COMM``.
 - All timeouts in tests are disabled, allowing U-Boot an arbitrary amount of
   time to execute commands. This is useful if U-Boot is stopped at a breakpoint
   during debugging.
@@ -187,7 +187,7 @@ Window 2:
 
     gdb ./build-sandbox/u-boot -ex 'target remote localhost:1234'
 
-Alternatively, you could leave off the `-ex` option and type the command
+Alternatively, you could leave off the ``-ex`` option and type the command
 manually into gdb once it starts.
 
 You can use any debugger you wish, as long as it speaks the gdb remote
@@ -196,16 +196,17 @@ protocol, or any graphical wrapper around gdb.
 Some tests deliberately cause the sandbox process to exit, e.g. to test the
 reset command, or sandbox's CTRL-C handling. When this happens, you will need
 to attach the debugger to the new sandbox instance. If these tests are not
-relevant to your debugging session, you can skip them using pytest's -k
+relevant to your debugging session, you can skip them using pytest's ``-k``
 command-line option; see the next section.
 
 Command-line options
 --------------------
 
 --board-type, --bd, -B
-  set the type of the board to be tested. For example, `sandbox` or `seaboard`.
+  set the type of the board to be tested. For example, ``sandbox`` or
+  ``seaboard``.
 
---board-identity`, --id
+--board-identity, --id
   sets the identity of the board to be tested. This allows differentiation
   between multiple instances of the same type of physical board that are
   attached to the same host machine. This parameter is not interpreted by th
@@ -215,15 +216,15 @@ Command-line options
 --build
   indicates that the test script should compile U-Boot itself before running
   the tests. If using this option, make sure that any environment variables
-  required by the build process are already set, such as `$CROSS_COMPILE`.
+  required by the build process are already set, such as ``$CROSS_COMPILE``.
 
 --buildman
-  indicates that `--build` should use buildman to build U-Boot. There is no need
-  to set $CROSS_COMPILE` in this case since buildman handles it.
+  indicates that ``--build`` should use buildman to build U-Boot. There is no
+  need to set ``$CROSS_COMPILE`` in this case since buildman handles it.
 
 --build-dir
   sets the directory containing the compiled U-Boot binaries. If omitted, this
-  is `${source_dir}/build-${board_type}`.
+  is ``${source_dir}/build-${board_type}``.
 
 --result-dir
   sets the directory to write results, such as log files, into.
@@ -266,10 +267,10 @@ Command-line options
        <3.0s :    2.4s  | 1
        <7.5s :    6.1s  | 1
 
-`pytest` also implements a number of its own command-line options. Commonly used
-options are mentioned below. Please see `pytest` documentation for complete
-details. Execute `py.test --version` for a brief summary. Note that U-Boot's
-test.py script passes all command-line arguments directly to `pytest` for
+pytest also implements a number of its own command-line options. Commonly used
+options are mentioned below. Please see pytest documentation for complete
+details. Execute ``py.test --version`` for a brief summary. Note that U-Boot's
+test.py script passes all command-line arguments directly to pytest for
 processing.
 
 -k
@@ -277,13 +278,13 @@ processing.
   option takes a single argument which is used to filter test names. Simple
   logical operators are supported. For example:
 
-  - `'-k ums'` runs only tests with "ums" in their name.
-  - `'-k ut_dm'` runs only tests with "ut_dm" in their name. Note that in this
+  - ``-k ums`` runs only tests with "ums" in their name.
+  - ``-k ut_dm`` runs only tests with "ut_dm" in their name. Note that in this
     case, "ut_dm" is a parameter to a test rather than the test name. The full
     test name is e.g. "test_ut[ut_dm_leak]".
-  - `'-k not reset'` runs everything except tests with "reset" in their name.
-  - `'-k ut or hush'` runs only tests with "ut" or "hush" in their name.
-  - `'-k not (ut or hush)'` runs everything except tests with "ut" or "hush" in
+  - ``-k not reset`` runs everything except tests with "reset" in their name.
+  - ``-k ut or hush`` runs only tests with "ut" or "hush" in their name.
+  - ``-k not (ut or hush)`` runs everything except tests with "ut" or "hush" in
     their name.
 
 -s
@@ -297,7 +298,7 @@ The tools and techniques used to interact with real hardware will vary
 radically between different host and target systems, and the whims of the user.
 For this reason, the test suite does not attempt to directly interact with real
 hardware in any way. Rather, it executes a standardized set of "hook" scripts
-via `$PATH`. These scripts implement certain actions on behalf of the test
+via ``$PATH``. These scripts implement certain actions on behalf of the test
 suite. This keeps the test suite simple and isolated from system variances
 unrelated to U-Boot features.
 
@@ -309,14 +310,14 @@ Environment variables
 
 The following environment variables are set when running hook scripts:
 
-- `UBOOT_BOARD_TYPE` the board type being tested.
-- `UBOOT_BOARD_IDENTITY` the board identity being tested, or `na` if none was
-  specified.
-- `UBOOT_SOURCE_DIR` the U-Boot source directory.
-- `UBOOT_TEST_PY_DIR` the full path to `test/py/` in the source directory.
-- `UBOOT_BUILD_DIR` the U-Boot build directory.
-- `UBOOT_RESULT_DIR` the test result directory.
-- `UBOOT_PERSISTENT_DATA_DIR` the test persistent data directory.
+- ``UBOOT_BOARD_TYPE`` the board type being tested.
+- ``UBOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` if none
+  was specified.
+- ``UBOOT_SOURCE_DIR`` the U-Boot source directory.
+- ``UBOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source directory.
+- ``UBOOT_BUILD_DIR`` the U-Boot build directory.
+- ``UBOOT_RESULT_DIR`` the test result directory.
+- ``UBOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.
 
 u-boot-test-console
 '''''''''''''''''''
@@ -326,15 +327,15 @@ should be connected to the board's console. This process should continue to run
 indefinitely, until killed. The test suite will run this script in parallel
 with all other hooks.
 
-This script may be implemented e.g. by executing `cu`, `kermit`, `conmux`, etc.
-via exec().
+This script may be implemented e.g. by executing ``cu``, ``kermit``, ``conmux``,
+etc. via ``exec()``.
 
 If you are able to run U-Boot under a hardware simulator such as QEMU, then
 you would likely spawn that simulator from this script. However, note that
-`u-boot-test-reset` may be called multiple times per test script run, and must
+``u-boot-test-reset`` may be called multiple times per test script run, and must
 cause U-Boot to start execution from scratch each time. Hopefully your
 simulator includes a virtual reset button! If not, you can launch the
-simulator from `u-boot-test-reset` instead, while arranging for this console
+simulator from ``u-boot-test-reset`` instead, while arranging for this console
 process to always communicate with the current simulator instance.
 
 u-boot-test-flash
@@ -357,7 +358,7 @@ the following cases:
 - The board allows U-Boot to be downloaded directly into RAM, and executed
   from there. Use of this feature will reduce wear on the board's flash, so
   may be preferable if available, and if cold boot testing of U-Boot is not
-  required. If this feature is used, the `u-boot-test-reset` script should
+  required. If this feature is used, the ``u-boot-test-reset`` script should
   perform this download, since the board could conceivably be reset multiple
   times in a single test run.
 
@@ -386,8 +387,8 @@ to flash, pulsing the board's reset signal is likely all this script needs to
 do. However, in some scenarios, this script may perform other actions. For
 example, it may call out to some SoC- or board-specific vendor utility in order
 to download the U-Boot binary directly into RAM and execute it. This would
-avoid the need for `u-boot-test-flash` to actually write U-Boot to flash, thus
-saving wear on the flash chip(s).
+avoid the need for ``u-boot-test-flash1`` to actually write U-Boot to flash,
+thus saving wear on the flash chip(s).
 
 u-boot-test-release
 '''''''''''''''''''
@@ -407,11 +408,11 @@ Board-type-specific configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Each board has a different configuration and behaviour. Many of these
-differences can be automatically detected by parsing the `.config` file in the
+differences can be automatically detected by parsing the ``.config`` file in the
 build directory. However, some differences can't yet be handled automatically.
 
-For each board, an optional Python module `u_boot_board_${board_type}` may exist
-to provide board-specific information to the test script. Any global value
+For each board, an optional Python module ``u_boot_board_${board_type}`` may
+exist to provide board-specific information to the test script. Any global value
 defined in these modules is available for use by any test function. The data
 contained in these scripts must be purely derived from U-Boot source code.
 Hence, these configuration files are part of the U-Boot source tree too.
@@ -425,14 +426,14 @@ U-Boot configuration may support USB device mode and USB Mass Storage, but this
 can only be tested if a USB cable is connected between the board and the host
 machine running the test script.
 
-For each board, optional Python modules `u_boot_boardenv_${board_type}` and
-`u_boot_boardenv_${board_type}_${board_identity}` may exist to provide
+For each board, optional Python modules ``u_boot_boardenv_${board_type}`` and
+``u_boot_boardenv_${board_type}_${board_identity}`` may exist to provide
 board-specific and board-identity-specific information to the test script. Any
 global value defined in these modules is available for use by any test
 function. The data contained in these is specific to a particular user's
 hardware configuration. Hence, these configuration files are not part of the
 U-Boot source tree, and should be installed outside of the source tree. Users
-should set `$PYTHONPATH` prior to running the test script to allow these
+should set ``$PYTHONPATH`` prior to running the test script to allow these
 modules to be loaded.
 
 Board module parameter usage
@@ -443,29 +444,29 @@ module:
 
 - none at present
 
-U-Boot `.config` feature usage
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+U-Boot ``.config`` feature usage
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The test scripts rely on various U-Boot `.config` features, either directly in
+The test scripts rely on various U-Boot ``.config`` features, either directly in
 order to test those features, or indirectly in order to query information from
 the running U-Boot instance in order to test other features.
 
-One example is that testing of the `md` command requires knowledge of a RAM
+One example is that testing of the ``md`` command requires knowledge of a RAM
 address to use for the test. This data is parsed from the output of the
-`bdinfo` command, and hence relies on CONFIG_CMD_BDI being enabled.
+``bdinfo`` command, and hence relies on CONFIG_CMD_BDI being enabled.
 
 For a complete list of dependencies, please search the test scripts for
 instances of:
 
-- `buildconfig.get(...`
-- `@pytest.mark.buildconfigspec(...`
-- `@pytest.mark.notbuildconfigspec(...`
+- ``buildconfig.get(...``
+- ``@pytest.mark.buildconfigspec(...``
+- ``@pytest.mark.notbuildconfigspec(...``
 
 Complete invocation example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Assuming that you have installed the hook scripts into $HOME/ubtest/bin, and
-any required environment configuration Python modules into $HOME/ubtest/py,
+Assuming that you have installed the hook scripts into ``$HOME/ubtest/bin``, and
+any required environment configuration Python modules into ``$HOME/ubtest/py``,
 then you would likely invoke the test script as follows:
 
 If U-Boot has already been built:
@@ -477,7 +478,7 @@ If U-Boot has already been built:
     ./test/py/test.py --bd seaboard
 
 If you want the test script to compile U-Boot for you too, then you likely
-need to set `$CROSS_COMPILE` to allow this, and invoke the test script as
+need to set ``$CROSS_COMPILE`` to allow this, and invoke the test script as
 follows:
 
 .. code-block:: bash
@@ -501,47 +502,47 @@ Writing tests
 Please refer to the pytest documentation for details of writing pytest tests.
 Details specific to the U-Boot test suite are described below.
 
-A test fixture named `ubman` should be used by each test function. This
+A test fixture named ``ubman`` should be used by each test function. This
 provides the means to interact with the U-Boot console, and retrieve board and
 environment configuration information.
 
-The function `ubman.run_command()` executes a shell command on the
+The function ``ubman.run_command()`` executes a shell command on the
 U-Boot console, and returns all output from that command. This allows
 validation or interpretation of the command output. This function validates
 that certain strings are not seen on the U-Boot console. These include shell
 error messages and the U-Boot sign-on message (in order to detect unexpected
-board resets). See the source of `console_base.py` for a complete list of
+board resets). See the source of ``console_base.py`` for a complete list of
 "bad" strings. Some test scenarios are expected to trigger these strings. Use
-`ubman.disable_check()` to temporarily disable checking for specific
-strings. See `test_unknown_cmd.py` for an example.
+``ubman.disable_check()`` to temporarily disable checking for specific
+strings. See ``test_unknown_cmd.py`` for an example.
 
 Board- and board-environment configuration values may be accessed as sub-fields
-of the `ubman.config` object, for example
-`ubman.config.ram_base`.
+of the ``ubman.config`` object, for example
+``ubman.config.ram_base``.
 
-Build configuration values (from `.config`) may be accessed via the dictionary
-`ubman.config.buildconfig`, with keys equal to the Kconfig variable
+Build configuration values (from ``.config``) may be accessed via the dictionary
+``ubman.config.buildconfig``, with keys equal to the Kconfig variable
 names.
 
-A required configuration setting can be defined via a buildconfigspec()
+A required configuration setting can be defined via a ``buildconfigspec()``
 annotation. The name of the configuration option is specified in lower case. The
-following annotation for a test requires CONFIG_EFI_LOADER=y:
+following annotation for a test requires ``CONFIG_EFI_LOADER=y``:
 
 .. code-block:: python
 
     @pytest.mark.buildconfigspec('efi_loader')
 
 Sometimes multiple configuration option supply the same functionality. If
-multiple arguments are passed to buildconfigspec(), only one of the
+multiple arguments are passed to ``buildconfigspec()``, only one of the
 configuration options needs to be set. The following annotation requires that
-either of CONFIG_NET or CONFIG_NET_LWIP is set:
+either of ``CONFIG_NET`` or ``CONFIG_NET_LWIP`` is set:
 
 .. code-block:: python
 
     @pytest.mark.buildconfigspec('net', 'net lwip')
 
-The notbuildconfigspec() annotation can be used to require a configuration
-option not to be set. The following annotation requires CONFIG_RISCV=n:
+The ``notbuildconfigspec()`` annotation can be used to require a configuration
+option not to be set. The following annotation requires ``CONFIG_RISCV=n``:
 
 .. code-block:: python
 

---
base-commit: a239b0b0b6dbe6a168969b8cd6e600cf85db278d
change-id: 20251001-fix-doc-pytest-usage-code-914002c40c2d

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

