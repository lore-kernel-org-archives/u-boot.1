Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9240606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ERMls8vF;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=NOj4+LNG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF69880AC8;
	Tue, 17 Nov 2026 09:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lHJAslGl75d; Tue, 17 Nov 2026 09:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE59880BB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794909230;
	b=Rq72sOMG42XPMnl6p1aqH5bzkkl0iHIN5YqdGL2QaQ55xTWEsNux9uQAfUNoj/ecm5c5
	 Wne6qFsslwbnClDpwDYHlDV5oBV/jIf5Hh1ZXz75m0Xz3Uq2Cyo0SE22eLIHkh0yB4Gcq
	 nhb0s9mSI78po2KJDsMetvN8SZiMF41aPrNu/i5Q9mwSt5MH72hjFfzO8jUP3L/BsA0RE
	 mdVgmCH/ACWuKU9/NWU/15T8cTwBKCiuspgtw9KCIo4k3kpUVUrsFKVja4QBSei8RaQEM
	 3/67lgn5/jY11oKUWj98/Ici9l5URO+6z6P443yQBg1pJrMJVy8tOU70vlG2pbqg4zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794909230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
	b=kA/JATuc5SEGVwymPNfiAg5ZTaaAtjDQ3n0raQqmvx0oxMBn31X3QXDyn5DmhqyhpVOl
	 6MNt8V7XI2iQgUriIxcqNL3zwm/dyyc3ShlA7NartemjPjk9aBbhJHFebKX3m5u3SYyAk
	 jIvkekUJNW2Cl+LvL6r3zGomka76GaVUSeGIgSBbrGJfWQJkisVYtqd+0DPH2KDCGsFWA
	 /gfme27guKZWQ+ZCgsQa2PisIOo+//2DAwEAEwtSTB3O5e1bJJBtCIWLkwIZLZ6ksrKD1
	 RBFu7YIAlA3DXgZE6qG59n+scG2P9uQyNpIhhBhe/I4K6xkxp7IR8OtaPxTmi8LaaNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794909230;
	bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ERMls8vFJf87i1RUUITKVexWrWpKPaakX1G088PEs6fUrV/+yJmiZzFaGjLTN5RMB
	 x9uwdtOqpUriE8NKOtcmU0r4GhLUh3W8ry29//FpRTEeAI+7nf6uw+A1C5uofxmrAP
	 fBDh5mI/cGcH/AlPHgTfiIPth4a9my8yIMzMDSzb8zkxdpujrMLCZn2ZBhokyG5iYn
	 i8dkM0grL+jJob7hNNFV5BGt78UZCW1FyoyrZXfI9eUtJqoGHDo85jxRniOcBq9Vos
	 xZewuPkydHexT4r5FL4T+5ZDtWb1k+OuV568IcZsyIPOJ7AiTyyByX6L6aVa4f5P1m
	 zYDCnmlEEeTtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE59880BB9;
	Tue, 17 Nov 2026 09:53:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F351F1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D98A660841
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRr7UDHfF697 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE9B960774
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=NOj4+LNG
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE9B960774
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVQ7ohCRWXAUa3mAxqqqSb7Yn9DE9sybLrtYur6hPRg=;
 b=NOj4+LNGO10IrK31eWj8b72gvZsRrfVTQ+LlG6BfoMuu9hDBOiVa36EwZatMMsp9S625FeKNgn3IfP85FtZRuhcanKwqYTdQCj6baaVjXYTB5uI4BhEtCWej/s4A3ebFEHgH5GNdkonvsbjN4BZ0m2auIIwmiUVoJ6C5UYqw9h68TDdIDbC+lzA/qv1pesjcFgvVBBSv3XIoBEDQWi7NsCT425KRdT2IP+d3RE9tcp9PQJ6K+16PIoiXOA/KkK5V7x8I94UcTfdbKWuUqi0CkYpMu1t+9tXrOHh36/II7C+eth3UwyebFhrfTkRgHmjm/azF/wGDNF1IiA4IMFIFFQ==
Received: from PR3P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::31)
 by MR0P264MB7247.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 09:53:43 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:54:cafe::6c) by PR3P191CA0026.outlook.office365.com
 (2603:10a6:102:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 09:53:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 09:53:42 +0000
Received: from localhost.localdomain (unknown [192.168.72.185])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8C63C2014F;
 Tue, 17 Nov 2026 10:53:42 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 0/4 RESEND] binman: Add HSM signing support to pre-load
 entry type
Date: Tue, 17 Nov 2026 10:53:17 +0100
Message-ID: <20261117095322.16813-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MR0P264MB7247:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 379d83c8-93a9-43d0-562e-08df4490aa07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021123027099003|261022113327099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: m9FKuZIdIai4gB3NpKx5DtcTw5D+p2J4KR/FDfYoZ3pI7dTedapWis9tJjfWjPhXF5jeN9+/yYptlxoJmaffc5XxcovfDo1hC/mBnP7+JNa6GorgS8pFztag4Topf/Q4UJoZw9Og3WZJhTabO2VHHFbeuYwFPyNqMFSsCQ2o80rQXFC1/qVomeg8Twg9GpeyzJZFCWuwua3Wigo341QhGQS4n9Mj/DIl8s7eRjPDbGm0LfCAe+TWHrFWEb5/wPMAyyvw5HDKqkSBfg8jN7sdtwmq3YWcnTQ2ZE8mqJU56QluQpePWLmoUlNf+hGeTDubEi71e86fXsIesMxVn1Hu5Hj57DkAAgvs3lcTq/IfrCOK2rz6tAiqHcyspn5bEEIAajnMt7LKic4Ch7GzQq3eaoPcwKMhk8UPXpoXHgIqCoqeT3BDx4GmkalLinKV5yiJT1YU8elgcxpOUCc4CIt9DIi1Wz0jpk2hjvnhtaaV9LizZ8YV9LaqKRAbwvopaxSXsq61zq22D+GEtFDlFzfjO1jF76fIuBFfZngGgTwMy98EWxov8/to31DQR+ZhIF+g1Oeei6pKm/OV+YFNfCqHaBB0pBI00nNsc+G08Sb0RSkuw93f03DZbviYF0VWJVjADYGL+dgJHScBVt6QFfdBsibopuguC5UMnyU0L+fsVy4E1pbMCgrR1lcLk9+YAlEAhBvX4ecOQ/JuANHMuTc08Q==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261022113327099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9YJJ1+rWpLLephfmPwIdwWvzk1S/Xeyxnk62IUH/rxHtQm/pEKDh2TjpZhmLBd5M4ENWjzwpm5h4Cgrw+1h1ROa8NKP8qpVI+yQEQIZa6pqVvrj/rEkpuTOVoLWSR/liNfHmTWFZ6eNGObM0zpacakcj8tRSj9GX1ptJcYazdWwGZCtH4ecemBFV40iQqhpK0tWFGWaw/inlzSWUuIYaQlcykr67mxr8WI0kUrNohW0tvT8QlMSA4iphriWd1NEe3yriqZBIjLtIAP+u+1nNxx9wrGVFUIAV6kUvcRaE/LSZlFzCmnJ8TkJDguy9Ia9/A/4i8GMj+odYHmtFKsl04co7M2qkaoZBSIxVYjglwIYH0VWd41J0JPhoHKceOSOyE1JHkTq5fSSDlxC+SaF9IacVzteKRqa6/7MUw6P9GDdDQoPv5yBTAnAQfHNL+LGH
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:53:42.7968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379d83c8-93a9-43d0-562e-08df4490aa07
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7247
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pre-load entry type currently only supports signing with a key
file on disk. This series lets it sign through a Hardware Security
Module (HSM) using PKCS#11, so that the private key never has to
leave the token.

The pkcs11_tool bintool gains a sign() method which drives pkcs11-tool
(RSA with PKCS#1 v1.5 or PSS, and ECDSA). The pre-load entry selects
the HSM with a single hsm-key property holding a PKCS#11 URI (RFC 7512),
as is done for FIT signing, e.g.:

   hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";

The PKCS#11 library and the PIN are not stored in the devicetree. They
are passed with -a pre-load-hsm-library and -a pre-load-hsm-pin (the PIN
may also come from PKCS11_SIGN_PIN). The library can also be given by
the module-path attribute of the URI.

The PIN is forwarded to pkcs11-tool with '--pin env:BINMAN_PKCS11_PIN',
which requires OpenSC 0.15.0 or later. A version check is added to the
bintool and an informative error is raised if an older release is found.

The functional tests use SoftHSM.

Changes in v3:
- Swap the order of patches 2 and 3: HSM signing support (pre_load) now
  comes before the key-name/integer-size fix patch. The HSM patch already
  needs to touch ReadNode() for URI parsing, so grouping the key-name
  check there with the HSM validation (in the following patch) is cleaner
- Add opensc_version() and _check_opensc_version() to pkcs11_tool; refuse
  to sign with OpenSC older than 0.15.0 (the first release that accepts
  'env:' for --pin); older versions would take 'env:BINMAN_PKCS11_PIN'
  literally as the PIN and silently fail or lock the token
- Make output_file a required argument of sign() so the caller controls the
  path; removes the temp-file management from inside the bintool
- When tools.get_env_with_path() returns None, fall back to os.environ so
  PATH is always inherited by the tool subprocess
- Add _BuildHeader(sign) to pre_load.py, a shared helper that takes a sign()
  closure; refactor _CreateHeaderRsa() and _CreateHeaderEcdsa() to use it,
  removing the duplicated struct.pack() and padding logic
- Pre-compute hsm_hash_name, hsm_sign_name, hsm_padding and hsm_sig_size
  in ReadNode() so _SignHsmData() does not re-parse algo_name on every call
- Use state.GetEntryArg() directly for pre-load-hsm-pin to prevent the PIN
  from being silently read from a DT property
- Remove the hsm-library DT property from __init__(); the library path is
  only set by the entry arg or the URI module-path= attribute
- Move the key-name check into the else branch of 'if self.hsm_key_uri:'
  in ReadNode() so it is validated early, consistently with HSM validation
- Extend the bintool unit tests: OpenSC version parsing and refusal, env
  handling in run_cmd_result(), PIN passed only through the environment,
  token serial lookup and resolution

yan wang (4):
  binman: bintool: Add PKCS#11 HSM signing support
  binman: pre_load: Add HSM signing support
  binman: pre_load: Require key-name for file-based signing and fix integer division
  binman: Add functional test for pre-load HSM signing

 tools/binman/bintool.py                       |  10 +-
 tools/binman/bintool_test.py                  | 650 ++++++++++++++++++
 tools/binman/btool/pkcs11_tool.py             | 379 +++++++++-
 tools/binman/etype/pre_load.py                | 323 +++++++--
 tools/binman/ftest.py                         | 268 ++++++++
 tools/binman/test/security/pre_load_hsm.dts   |  21 +
 .../test/security/pre_load_hsm_dt_pin.dts     |  22 +
 .../test/security/pre_load_hsm_ecdsa.dts      |  21 +
 .../security/pre_load_hsm_invalid_algo.dts    |  21 +
 .../security/pre_load_hsm_invalid_padding.dts |  22 +
 .../security/pre_load_hsm_invalid_sha.dts     |  21 +
 .../security/pre_load_hsm_invalid_uri.dts     |  21 +
 .../security/pre_load_hsm_module_path.dts     |  21 +
 .../test/security/pre_load_hsm_sign_pss.dts   |  22 +
 .../security/pre_load_missing_key_name.dts    |  20 +
 15 files changed, 1761 insertions(+), 81 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_hsm.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_dt_pin.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_sha.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_uri.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_module_path.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign_pss.dts
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

-- 
2.43.0

