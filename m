Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB5DE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E511683E4C;
	Thu, 19 Feb 2026 14:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="MqMa34IN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6637D83D8A; Thu, 19 Feb 2026 14:26:17 +0100 (CET)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3128D83AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MylSCPQKbYfpDJAnQy8quJI24PTuKvdLPIDFr90HbgyF1f6D6cBzi4jCSpvJiIZeLU44hHUyjX/RrqnVtz8dQhMM8WEMcLzSvtEdi8LAO/ywF/TDcdSfH9gbbPMhX8b/joK0nl0GYzNNodgoigRAu9lmgVuJCgA/zk0gQv51MN05nu7uh6kFxb5Z01OG1i7Ej5c3rnIc6RVLtIr4BX9tcjqv90taX4WqKuNN12AXkX2VpS/MT750XKLf6S3UT37f1lrzMaUmaRRlW1NiLUq/vCXc79ZFpbcVx06D1o0Dv6HYz5eypK5amuIZevjsZ2+WEnHvJYtF2McwM77FBAy1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtuXBYZg27CnibUJk258efxBw/pTExGW8KW5cLkQ5s8=;
 b=ZZwqqb74Mpw2ZbF4iQ2QoOk2xlk1wVWA7f8WPK/UFY+jE8OxRdRaDsIIpSd6ZhUFLIF5yf2JCzEAjaXZ/5tSBoiNsGgTf4wtRF6B/2I7622SiYNNoHWOl1OPiiGN6RS0VSWZa/gQFhZ0T4uHIuTswV78YqDvsoNKr4hOLKR/wMjwNpD58XhpQiioxcprKWcBELERKxMMMrlUuc2lDQra4MUnrNrfDr6ilhv3+Nbz8CjPOrr6YOF4FrvB1ENLelWJpjU7K0eWveHz3WwJUAgW/rMWBEbnFsdYr9cpGvjHGQbx9+qixkyV3MXyLwn2qZy2bhJoNKXVFujxmKWx/M9R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtuXBYZg27CnibUJk258efxBw/pTExGW8KW5cLkQ5s8=;
 b=MqMa34INwLJO8rPLXFHDvLRyE2VVzwHMJ5miA4S6cf5URmQA0ktfnjyNOj0vWNMSr/mN5qlN7IK7xbL5WxZ9VChfDaGXSvQ8TcmgmQE0GE/S/Fd8m/Blx8mszufJSWeyRlEwiyIDdO3001oQQfUk4oReJwWb8svm223+JrWpjcs0nwXv4PppUEvvlwMFb3kgCetucrrF4ly8vW09eammUWJejK1EdRCnVOiuTLWK94aCBcWtmwjl8y94pZmSPks3iEbd9C9QNbvdcWJjSVA7SUSIqs2jtBaXju8/D7HgYndKbs2Z1fGtRki1gWHw3t8z9DryFjPRP9PqdbAGgEcnuQ==
Received: from PAZP264CA0206.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::30)
 by MR1P264MB1843.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 13:26:11 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237:cafe::36) by PAZP264CA0206.outlook.office365.com
 (2603:10a6:102:237::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 50EDA20143;
 Thu, 19 Feb 2026 14:26:10 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 9/9] test: vboot: add test for ecdsa
Date: Thu, 19 Feb 2026 14:25:52 +0100
Message-ID: <20260219132552.1499698-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR1P264MB1843:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5df6c553-50d8-4cf0-0d06-08de6fba7240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3WdZsBx08knqryu9/OUlIrpDQ9shTzMkN+C08JYLwjOuglKKG7vXuJC8+6A8?=
 =?us-ascii?Q?pCMBmg0Lh/+VnH7QUXWFwWdgxN1BrCqUChETsfPBQDEptLc+HAKlnzMU6BnJ?=
 =?us-ascii?Q?3lo6UpwIdCx6YzYv3NVOHtG4glPzv1IEROGVYRGTF+p+CJfNi5nkcVrpxlz2?=
 =?us-ascii?Q?AplsWDlinS/UjiZwDcoqNCkH5Afiq4uTL7kEQ89HMBiaWbW33ZOXkiqMn/C1?=
 =?us-ascii?Q?gDbvd8meHu/GWJlAXAePc4RsujFn0HZE0/zet2Rw/LSAd+aXJf7UIuH7sQPw?=
 =?us-ascii?Q?wwn4QQzCgtIu7FGHc/wnXoTwygwf7cccaWCI+bdjRIUsWD/lg46fAfvUDoi3?=
 =?us-ascii?Q?PrgXt6OoGckRIe53FL4ieKShZzgkBcxw2yHmw/VgnY6kuzLHsxdQ2ury2aDG?=
 =?us-ascii?Q?PFDoK34MJU38Gkd/W2HfnZDqdY1nyVuBSo9bciO0rAjrPbffheUXOwchaJPN?=
 =?us-ascii?Q?sDAe4lgO5MKeHVVSZjfBMfk4njbplSRul9VvJvRIv1++h1B+/BlrMmqz/0qb?=
 =?us-ascii?Q?u00GmA8Dv6SzYyqBSQwqrk/I/008uLMrk17LmWiA7x4G9xyp+SBi3dqeFogc?=
 =?us-ascii?Q?W+icWE6Ts5MF3sD019yqXPI0rGepDsu8MANSDE0JNKRMVyAVXjtR8qzCMtqK?=
 =?us-ascii?Q?Ie5AZv2t0P2dB+7T7R+u4Uu6FImSD6UqZGTiGlWxkYeJh7iipzBhujGtWL1X?=
 =?us-ascii?Q?LTB53zSBxKc5LHURCp0KroPZ/pr055yjDZwZ3weK5e+xTA1oZCajgIwkHsS5?=
 =?us-ascii?Q?oxi5j+q5aAt6O0OBBuNY+m/dDAz6O5dxPvFeX7tE+r5E31pa43txQrD0cLJe?=
 =?us-ascii?Q?NU4gShE5UvksPEyymdopmqNc9lvXfiTBzRbrEOq6ovR35+K96mv0+Tx/23nh?=
 =?us-ascii?Q?t/apfZqY1yNqBoaUYzUMzXSpE/1Pu+4FTFkxeoQOZ24f3gLFIIt4ipdkVnNt?=
 =?us-ascii?Q?Q30lYAajWS2I90oVcN67qxnRSeM5uTcFy2cGzcWsfsQQ2OTk+li7BDxEBOZT?=
 =?us-ascii?Q?ugnMh3fwxRnb8KGRKKCRXc8kFl7LJk7HhNmYAOfAz8JVHWyJeLrGEz/mbN4t?=
 =?us-ascii?Q?Recbp+lbEFXSj1S0GT3lmLGauEZTPZlcDBoPsZMKOhSZAJCHxQ8dg/kLLwS5?=
 =?us-ascii?Q?9Lbs4kONbcg1miTr5/ZRSMIZWR4UjRlYEszf5C538Nf1L6+1k8QQrs9t/wD4?=
 =?us-ascii?Q?StcrzzK+ARzFl00NogJyYYdTxYcDa32Z3mOLUE4PWZnq+Ty0xSaj96078z2Z?=
 =?us-ascii?Q?9ojwmQGGi4EQTOT2co+gtEMs8hsyjZEyyoNu3gH0dSVhQHV4ouNT+cTZf3U+?=
 =?us-ascii?Q?D1sLD9H/HAXJD8QvtDRL1AT4SOIG5GFUJijRyNKTCeRcXT14i1hXt1v9acVS?=
 =?us-ascii?Q?Gjz4wY0jtlLcJMgFrpOEDP6a4FcTpRug//tl8CD9WShS00Z0AuxbmjUR4fiE?=
 =?us-ascii?Q?8e5Sz3f0ljYNsm4/YcIw6CcSIY59j582XZGJoOoRKv/9TAskz9OQ9fGXWDXn?=
 =?us-ascii?Q?NX+2fY0la6WYIR+QJSO7x4fkqal1R3/tU1FmBuVD65V7dLvT/pynzjcT9hJ2?=
 =?us-ascii?Q?pAjtIXrkgItAXWTu/tPOA9g/bwR+2aeydNDvHREel23vbNep4rjUOhwMfuPC?=
 =?us-ascii?Q?aIi8FoTwKEoiNbTWFMxLn2rejiSBEAM/7506wG2LsyMYqroMF+KhnlSjxMdP?=
 =?us-ascii?Q?D6Dk9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: paq2P+nPfukOb4kjc86bA6TfKbB2Ir0i3MCTf+4UCL6SIb8IOIlEEvA6G7fR6jnn1rnkjv9Gd4udfBobTdGxv4Q3wEYPajOEzo5jSlFuZ1X1/NVolYWQX4iC51bTaEL3vISiHFCZ377byLmhYNL18W+Nl8NSJBR8HuNbZizFUAuHtWWfwYYwsavG6L/MADF0u6GL9Q5M75CgpYRjJ8sl4cX+ShpehrD56I9yq+e6PmADRh2XnIVbLDxQQPDFr8jkIdK/qNhIX2rlm5XpXJDytE+mEz5ldOX+gDKzIbhyuCaay5Pge8I8YmXt+n2mtsmUiiWnE5z0aIDA+25YKYHiBvfWGzpJtmWrlHQ8qjew4TE0v6ogh2dcH8bNdRu+LMzQ3w5giT1DbqONqLyf722fhg+2u0bctqe8sykQ65jxcCEjqOOntxeh2WN3gGPURpFk
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:10.4504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df6c553-50d8-4cf0-0d06-08de6fba7240
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1843
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

This commit adds test case for ecdsa on fit, but not (yet) for
the global image signature (preload).

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version

 test/py/tests/test_vboot.py                   | 29 ++++++++++++
 .../vboot/sign-configs-sha256-ecdsa256.its    | 45 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa384.its    | 45 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa521.its    | 45 +++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa256.its     | 42 +++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa384.its     | 42 +++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa521.its     | 42 +++++++++++++++++
 7 files changed, 290 insertions(+)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index fd1bf6eb8aa..d2eeda816e2 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -94,6 +94,9 @@ TESTDATA_IN = [
     ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
     ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
     ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, False, False, False],
     ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
     ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
     ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
@@ -287,6 +290,29 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
+    def create_ecdsa_pair(name):
+        """Generate a new ECDSA key pair
+
+        Args:
+            name: Name of of the key (e.g. 'dev')
+        """
+
+        if sig_algo == "-ecdsa256":
+            curve_name = "secp256r1"
+        elif sig_algo == "-ecdsa384":
+            curve_name = "secp384r1"
+        elif sig_algo == "-ecdsa521":
+            curve_name = "secp521r1"
+        else:
+            curve_name = "unknownCurve"
+
+        utils.run_and_log(ubman, 'openssl ecparam -name %s -genkey -noout -out %s%s.pem' %
+                     (curve_name, tmpdir, name))
+
+        # Create a certificate containing the public key
+        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.pem '
+                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
+
     def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
@@ -523,6 +549,9 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
         create_rsa_pair('dev')
         create_rsa_pair('prod')
+    elif sig_algo == "-ecdsa256" or sig_algo == "-ecdsa384" or sig_algo == "-ecdsa521":
+        create_ecdsa_pair('dev')
+        create_ecdsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
new file mode 100644
index 00000000000..4d0ef903a78
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+				sign-images = "fdt", "kernel";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
new file mode 100644
index 00000000000..10427b43659
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+				sign-images = "fdt", "kernel";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
new file mode 100644
index 00000000000..a65593ec64b
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+				sign-images = "fdt", "kernel";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa256.its b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
new file mode 100644
index 00000000000..009003bb601
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa384.its b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
new file mode 100644
index 00000000000..567de687a06
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa521.its b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
new file mode 100644
index 00000000000..74ed45b21b8
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
-- 
2.43.0

