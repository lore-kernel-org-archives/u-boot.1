Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6C606A332
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a1YE7boT;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=LLRhxLlK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF902810DE;
	Tue, 17 Nov 2026 09:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ChfiQOtjWUQ; Tue, 17 Nov 2026 09:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32A95810B4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794909245;
	b=s1w82pw4yi9u9oposzb/ief+AO53/mTH/sdPFv2eEYMTKadm2jCVfnLTJg0Tdioam8xZ
	 gCSD/W0o/p6IiBHimsHBMzHaympSGeBjwHIB7geyMwY0/fK7mKn8EDjxKXFcdgRBon9MV
	 ZLkVp6Lx7GHKrtqWaiRI2wM2x0Af3W7kb4pWyxlaLPZP3KCutyfxaJxjpw63dSLwC5NW7
	 B9BySyOSJH+P1fAV4aQ2dbxJBhL9SF1qL6A9o6y+j0wLdVTO3rHJNd7JI6IboakaholYt
	 GrXfFotOqWntrqCzKSEAurL+TkUyaycuwVz10uw/nR40SivDgzLqBQFPyxG33s7Jc/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794909245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
	b=Hi+2ATHcPNMujB8HmIaB8b1Vz5AQlvi8N7FiCml/JPj6ZMchm87Lc6YCtulUE8H2+Ynk
	 SC+WKAGr3yE6NKIUKS+cn1ITuzQm3DigFGNMjxgT0FWhfSqLdEtCFpd8+cEJNW+8Gyhwf
	 3DpQpNo18VeVID3GxiNqbi/9aOD+8NLoJV5MI+CJfG5bxOGoEA1VB7aIO6t4E2ES4JGeQ
	 iTz8o9uUXO7bkkI0ZOm/Pi7llGwzMB2LmOZuzL9QP96FU7L40iN1qwCbwOfuC63fT721E
	 37IhtUFPCWR/RNNLzbU3K2A1S58OC7sxCQi0vAYB4KJE0B911RUNfRSG6HqQxUrLYUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794909245;
	bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a1YE7boTiOeflFTlhsRqUDTfI58mbwZlkQjTjbcCDWUMB9ua7SG1nhsgip4Gl5kXh
	 Dg3cAodwat2352lnJMU2UbRApezIJ+ibkIH/Fde6dioIuFWg4qapbvh1roB3orwjps
	 WP487GNhB5Z24z9Z9C3tI0j7QfBCLWMzTPak9k36Xu5hAc59hs37aZ5C06JliOXx15
	 pY7/0ODj6sYHgwAKj3nH0n5wXQe87909w2ubMJKiqVZ3GZ2YkAmSMdr/HfZK/k+jgH
	 cDNFtAiIGmnjU1nt3LbNLGo/65Yvyz9J3I9iSCtJcjOuqAyDrnNeAHOCR9t9yipyyt
	 aTc6HCylnkaKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32A95810B4;
	Tue, 17 Nov 2026 09:54:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAEC31A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0DA1406B9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIH5i9RjizDj for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:54:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08347406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=LLRhxLlK
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08347406AE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tITnNWal9YLmUtvLbMoC9/y6vft6SQ25HX++ITlPXSE=;
 b=LLRhxLlKwakz91hkfwWngwQidV0QjnNfr2vz9muftU39ugq3FLFcL9dbVSCMKvFL3YQSeP8atAotcq7IsQl844KhDym6VeNwqT9FpMcGizGsbCECASTqQNAW5u9RuD6BK0ze/FlvZRUw+XSAGIAMbFwUNgXt7iGW5X+iQEAxTZIqS+yUPetUQJgcwdsYewWySVVDx5y9KByrJwAeOhji8ZwUGyS5eGGStK3mJIT5k9E4IW0TXFRZXCoy081IvkBncuLhCLq/GUle0J9ElhtYM97m/yMYpLIQ4VFedo7f3RLcwWg8WarTmk0pHg24HAkcDFnlyWHjRIERIDZcrr6dmQ==
Received: from PR1P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::11)
 by MR1P264MB1988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 09:53:52 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e:cafe::99) by PR1P264CA0006.outlook.office365.com
 (2603:10a6:102:19e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 09:53:52 +0000
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
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 09:53:52 +0000
Received: from localhost.localdomain (unknown [192.168.72.185])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5E50A2014F;
 Tue, 17 Nov 2026 10:53:52 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 4/4 RESEND] binman: Add functional test for pre-load HSM
 signing
Date: Tue, 17 Nov 2026 10:53:21 +0100
Message-ID: <20261117095322.16813-5-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117095322.16813-1-yan.wang@softathome.com>
References: <20261117095322.16813-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR1P264MB1988:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5303a12f-7206-4d15-b6a4-08df4490afd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261028144727099003|261026135527099003|261026121527099003|261026140227099003|261102123227099003|261026130827099003|261102130727099003|261021133027099003|261021135927099003|261021130227099003|261021121427099003|261022115727099003|261022075727099003|261021123027099003|261022105027099003|10067099003|261022113327099003|56012099006|5023799004|18002099003|22082099003|17002099007|261009221227099003|261009223027099003|261009221727099003|261009223327099003|261009220027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 3sTa53YV7bZsQiz0TEsmHewCt4Ndcdq9VtxFf2bdQPqz/AsTX3hSYi9r++oTtx9xW34Ii4rCrLD+TE3D4uv1IvZuqMgngYO5nvru2JpGqFhuLHybsWjQOnb0uMnv4LGdrPHxXUuAeWAIRf6ZCbZ4T4rTJXOaCqxTFoP1tZ00pFJ0Y7bp3yrBIllS3NDPWxU1O7okstj95jttkW0Z6RaVjRvrQmZagyF1muKAZNy0r6nGBMLHIFGBGit/5RIG8vYvZh7N4vwenyagu7jqNhXcFRhg1amzkKe4mn8QksKw7dxgL75nvrhiV7zFam0AElgu0STwXP6uvlIS3Kkn7xNXIAgVGzwn7nShf1CsMvgaqFEsYq5JgUuirPnt7Qgka6dftxKIcvvWLM4VB7Xj2tEmDNsDVr4OPykOLdet2yN9KQALi20DxQNvKatqa34OSj3PwdSEmK5aPpg7PZxvNN0R+XWaY4xY844ARl+QYPmP0lHPkwpZJ4NwHEx92U1gZ07zrDTakr26rZ4gH4T/FU4aJkr/K/gaFA9OayVvPC+sdx87J3Hh1GTNVG+jR4zpa0PBtt1nm/rEyYNdDoX7QG7JzZy2uLLeqgjfcXPmWM5rPGMFVTzPbOqVypW+d7Lzi5IQvVqVWDD0xg5t5TuZOfJdqojAElydQIxlBfCimDE+JCteQBd3vWUEC0sZWVwg2bCxbQ+iwK2rXK67mQ8HtH+Zug==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261028144727099003)(261026135527099003)(261026121527099003)(261026140227099003)(261102123227099003)(261026130827099003)(261102130727099003)(261021133027099003)(261021135927099003)(261021130227099003)(261021121427099003)(261022115727099003)(261022075727099003)(261021123027099003)(261022105027099003)(10067099003)(261022113327099003)(56012099006)(5023799004)(18002099003)(22082099003)(17002099007)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009220027099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w6mbNZ6T1IWndAbGrYFBfQ/kDiLiMQBPH+beQbkJaqkdPw8eOdCZrnKBgZRZ3N2QRr8OuncXI6xJyq2YyqaYNPN0K8QZ042GwZVQYEXZCfcgID/uCQ0CPo65o3gL8JqZerXhlyRcDYeCaH0thu2gr6UONEsQF4szCedMgLBQ2MuLz8dpf2XFvrX2H+9jkUjMM4zsFWzE+kEU9Yib0Ml5MOTQVycRbFRQ7N0kW+TJbiA6XfdAXtJmoKsKyLU56ae+Qu0xcJfMqmpnzIekYpestaDRKnsQkbQSFNKzXoedf8iB/4kd2LL4VRb4ooSTgx6ZlB97MLwewShmkduBAd33WxP/VVXPPjAyKqaVC7N6WU94GkKl3pE2PISEd9FEXOs7eaFrnLfl4MTk368i7cqtnKWQPPbWyakHZyWsKP+Thv8BdhCKUFpGPUZzMA8xjbSi
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:53:52.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5303a12f-7206-4d15-b6a4-08df4490afd2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1988
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add end-to-end functional test for HSM-based signing of pre-load
headers. The test verifies that binman can use PKCS#11 libraries
to sign data via hardware security modules and can generate pre-load
headers with HSM signatures.

The tests create a SoftHSM v2 token, generate RSA and ECDSA key pairs
on it with pkcs11-tool, and verify the resulting pre-load header
signatures. RSA signatures are checked with preload_check_sign; ECDSA
signatures are checked with Cryptodome because preload_check_sign needs
the private key.

- Add _MakePreLoadHsmToken() to set up the SoftHSM configuration from
  fit/softhsm2.conf, locate the library through p11-kit, initialise the
  token, generate a key pair and export the public key in DER format.
- Add testPreLoadHsmSign, which generates an RSA-2048 key pair and checks
  the header, for both pkcs-1.5 and PSS padding, with preload_check_sign
  using the public key exported from the token
- Add testPreLoadHsmEcdsaSign, which generates an ECDSA key pair and
  verifies the signatures with Cryptodome, since preload_check_sign needs
  the private key for ECDSA, which an HSM never exposes
- Add testPreLoadHsmModulePath to check that module-path= in the URI sets
  the library.
- Add _GetPreLoadHsmPins() to collect the PIN passed to each sign() call.
- Add PIN tests that check the PIN source order: the pin entry arg, the
  environment variable, the entry arg taking precedence over the
  environment variable, no PIN at all, and a PIN in the device tree
  being ignored.
- Add testPreLoadHsmBadSignatureLength to check that a signature of the
  wrong length is rejected.

Error-path tests, which do not need SoftHSM, cover an invalid padding
scheme, an unsupported hash, an unsupported signature algorithm, an
invalid PKCS#11 URI, a missing pkcs11-tool and a signing failure
reported by pkcs11-tool.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v3:
- Extract _MakePreLoadHsmToken() helper (SoftHSM setup, key generation and
  public-key export) from testPreLoadHsmSign and testPreLoadHsmEcdsaSign,
  removing the duplicated token-setup code
- testPreLoadHsmSign now uses pre_load_hsm.dts (the shared DTS that was
  also used by the error-path tests) instead of a dedicated
  pre_load_hsm_sign.dts; drop pre_load_hsm_sign.dts
- Move the SOFTHSM2_CONF environment mock to wrap only the signing part of
  testPreLoadHsmSign, not the token setup, which already patches the env
  inside _MakePreLoadHsmToken()
- Add _GetPreLoadHsmPins() helper: patches is_present() and sign() and
  returns the list of PIN values received across both sign() calls
- Add five PIN-source tests:
  - testPreLoadHsmPinEntryArg: pre-load-hsm-pin entry arg reaches sign()
  - testPreLoadHsmPinEnvVar: PKCS11_SIGN_PIN is used when there is no arg
  - testPreLoadHsmPinEntryArgWins: entry arg overrides PKCS11_SIGN_PIN
  - testPreLoadHsmNoPin: None is passed when no PIN is configured
  - testPreLoadHsmPinInDtIgnored: a 'pre-load-hsm-pin' DT property is
    never read; the entry arg and env variable still take effect
- Add pre_load_hsm_dt_pin.dts for testPreLoadHsmPinInDtIgnored
- Drop testPreLoadHsmSignDataChecks: _SignHsmData() no longer re-validates
  the algorithm and padding scheme; that validation was moved to ReadNode()
  in the previous patch, so the test would need to bypass ReadNode() to
  reach the error paths and is no longer meaningful
- Drop testPreLoadHsmHeaderSignMissing: the dummy-header path when the
  tool disappears between the two sign() calls is now handled by
  _BuildHeader() returning None, which _CreateHeader() maps to the
  dummy bytes; the case is implicitly covered by testPreLoadHsmMissingTool

 tools/binman/ftest.py                         | 257 ++++++++++++++++++
 tools/binman/test/security/pre_load_hsm.dts   |  21 ++
 .../test/security/pre_load_hsm_dt_pin.dts     |  22 ++
 .../test/security/pre_load_hsm_ecdsa.dts      |  21 ++
 .../security/pre_load_hsm_invalid_algo.dts    |  21 ++
 .../security/pre_load_hsm_invalid_padding.dts |  22 ++
 .../security/pre_load_hsm_invalid_sha.dts     |  21 ++
 .../security/pre_load_hsm_invalid_uri.dts     |  21 ++
 .../security/pre_load_hsm_module_path.dts     |  21 ++
 .../test/security/pre_load_hsm_sign_pss.dts   |  22 ++
 10 files changed, 449 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_hsm.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_dt_pin.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_sha.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_uri.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_module_path.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_sign_pss.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d4522e905e0..0ddc282ac30 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -22,10 +22,15 @@ import unittest
 import unittest.mock
 import urllib.error
 
+from Cryptodome.Hash import SHA256
+from Cryptodome.PublicKey import ECC
+from Cryptodome.Signature import DSS
+
 from binman import bintool
 from binman import cbfs_util
 from binman import cmdline
 from binman import control
+from binman.btool import pkcs11_tool as pkcs11_tool_btool
 from binman import elf
 from binman import elf_test
 from binman import fip_util
@@ -5992,6 +5997,258 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn('key-name is required for file-based signing',
                       str(exc.exception))
 
+    def _MakePreLoadHsmToken(self, prefix, key_type, label):
+        """Create a SoftHSM token holding a new key pair
+
+        Args:
+            prefix (str): Prefix for the files created in the input directory
+            key_type (str): Key type for pkcs11-tool, e.g. 'rsa:2048'
+            label (str): Label of the key pair on the token
+
+        Returns:
+            tuple:
+                str: SOFTHSM2_CONF file to set while using the token
+                str: Path to the SoftHSM2 shared library
+                str: Path to the public key, in DER format
+        """
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+
+        p11_kit = bintool.Bintool.create('p11-kit')
+        self._CheckBintool(p11_kit)
+
+        # Configure SoftHSMv2
+        softhsm2_data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf',
+                                            softhsm2_data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Locate the SoftHSM2 shared library via p11-kit
+        p11_kit_config = configparser.ConfigParser()
+        p11_kit_config.read_string(p11_kit.run_cmd('print-config'))
+        softhsm2_lib = p11_kit_config.get('softhsm2', 'module', fallback=None)
+        self.assertIsNotNone(softhsm2_lib,
+                             'softhsm2 module not found in p11-kit config')
+
+        pubkey_der = os.path.join(self._indir, f'{prefix}pubkey.der')
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            softhsm2_util.run_cmd('--init-token', '--free', '--label',
+                                  'uboot-hsm', '--pin', '1234',
+                                  '--so-pin', '1234')
+            pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                '--keypairgen', '--key-type', key_type,
+                                '--label', label, '--login', '--pin', '1234')
+            pkcs11_tool.run_cmd('--module', softhsm2_lib,
+                                '--read-object', '--type', 'pubkey',
+                                '--label', label, '--login',
+                                '--pin', '1234', '--output-file', pubkey_der)
+        return softhsm2_conf, softhsm2_lib, pubkey_der
+
+    def testPreLoadHsmSign(self):
+        """Test pre-load header signed by SoftHSM via PKCS#11 (pkcs-1.5 and PSS)
+
+        Sets up a SoftHSM v2 token, generates an RSA-2048 key pair on it, and
+        builds two pre-load images (one with pkcs-1.5, one with PSS). Both are
+        verified with preload_check_sign using the public key extracted from the
+        token.
+        """
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+
+        softhsm2_conf, softhsm2_lib, pubkey_der = self._MakePreLoadHsmToken(
+            'testPreLoadHsmSign.', 'rsa:2048', 'uboot-key')
+        pubkey_pem = os.path.join(self._indir, 'pubkey.pem')
+        openssl.run_cmd_result('rsa', '-pubin', '-inform', 'DER',
+                               '-in', pubkey_der, '-out', pubkey_pem)
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            entry_args = {
+                'pre-load-hsm-library': softhsm2_lib,
+                'pre-load-hsm-pin': '1234',
+            }
+
+            # pkcs-1.5 (default padding)
+            data = self._DoReadFileDtb('security/pre_load_hsm.dts',
+                                       entry_args=entry_args)[0]
+            image_fname = tools.get_output_filename('image.bin')
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+            self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+            self.assertEqual(PRE_LOAD_HDR_SIZE,
+                             data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+            self.assertTrue(self._CheckPreload(image_fname, pubkey_pem))
+
+            # PSS padding
+            data = self._DoReadFileDtb('security/pre_load_hsm_sign_pss.dts',
+                                       entry_args=entry_args)[0]
+            image_fname = tools.get_output_filename('image.bin')
+            self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+            self.assertTrue(
+                self._CheckPreload(image_fname, pubkey_pem, padding='pss'))
+
+    def testPreLoadHsmEcdsaSign(self):
+        """Test pre-load header signed by SoftHSM with ECDSA."""
+        softhsm2_conf, softhsm2_lib, pubkey_der = self._MakePreLoadHsmToken(
+            'testPreLoadHsmEcdsaSign.', 'EC:prime256v1', 'uboot-ecdsa')
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
+            args = {'pre-load-hsm-library': softhsm2_lib,
+                    'pre-load-hsm-pin': '1234'}
+            data = self._DoReadFileDtb('security/pre_load_hsm_ecdsa.dts',
+                                       entry_args=args)[0]
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+
+        # preload_check_sign needs the private key for ECDSA, which an HSM
+        # never exports, so verify with the public key read from the token.
+        # Layout: header (64 bytes), header signature (64 bytes), image
+        # signature (64 bytes), then padding up to the 4096-byte header.
+        pub = ECC.import_key(tools.read_file(pubkey_der))
+        first_header = data[:64]
+        hdr_sig = data[64:128]
+        img_sig = data[128:192]
+        image = data[4096:]
+        self.assertEqual(SHA256.new(img_sig).digest(), first_header[32:64])
+        DSS.new(pub, 'fips-186-3').verify(SHA256.new(image), img_sig)
+        DSS.new(pub, 'fips-186-3').verify(SHA256.new(first_header), hdr_sig)
+
+    def testPreLoadHsmInvalidPadding(self):
+        """Test HSM signing with invalid padding-name (validated before tool check)"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_padding.dts')
+        self.assertIn('Unsupported padding scheme', str(exc.exception))
+
+    def testPreLoadHsmMissingTool(self):
+        """Test that binman still produces an image if pkcs11-tool is missing"""
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('security/pre_load_hsm.dts',
+                             force_missing_bintools='pkcs11-tool')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: pkcs11-tool")
+
+    def testPreLoadHsmSignError(self):
+        """Test HSM signing when sign() raises ValueError or RuntimeError"""
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        for exc_type in (ValueError, RuntimeError):
+            with unittest.mock.patch.object(Btool, 'is_present',
+                                            return_value=True), \
+                 unittest.mock.patch.object(Btool, 'sign',
+                                            side_effect=exc_type('Mock HSM error')):
+                with self.assertRaises(ValueError) as exc:
+                    self._DoReadFile('security/pre_load_hsm.dts')
+                self.assertIn('HSM signing failed', str(exc.exception))
+
+    def testPreLoadHsmInvalidUri(self):
+        """Test HSM signing with a hsm-key that is not a PKCS#11 URI"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_uri.dts')
+        self.assertIn('Not a PKCS#11 URI', str(exc.exception))
+
+    def testPreLoadHsmInvalidSha(self):
+        """Test HSM signing with an unsupported hash algorithm"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_sha.dts')
+        self.assertIn('sha1 is not supported', str(exc.exception))
+
+    def testPreLoadHsmInvalidAlgo(self):
+        """Test HSM signing with an unsupported signing algorithm"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_algo.dts')
+        self.assertIn('rsa1234 is not supported', str(exc.exception))
+
+    def testPreLoadHsmModulePath(self):
+        """Test that module-path in the hsm-key URI sets the HSM library"""
+        self._DoTestFile('security/pre_load_hsm_module_path.dts',
+                         force_missing_bintools='pkcs11-tool')
+        entry = control.images['image'].GetEntries()['pre-load']
+        self.assertEqual('/no/lib.so', entry.hsm_library)
+
+    def _GetPreLoadHsmPins(self, entry_args, env,
+                           dts='security/pre_load_hsm.dts'):
+        """Run the pre-load HSM test file and collect the PINs given to sign()
+
+        Args:
+            entry_args (dict or None): Entry args to pass to binman
+            env (dict): Environment to use (PKCS11_SIGN_PIN is cleared first)
+            dts (str): Devicetree file to use
+
+        Returns:
+            list of str: 'pin' argument of each sign() call
+        """
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        pins = []
+
+        def fake_sign(_self, *args, **kwargs):
+            pins.append(kwargs.get('pin'))
+            return bytes(256)
+
+        clean = {k: v for k, v in os.environ.items()
+                 if k != 'PKCS11_SIGN_PIN'}
+        clean.update(env)
+        with unittest.mock.patch.dict(os.environ, clean, clear=True), \
+             unittest.mock.patch.object(Btool, 'is_present',
+                                        return_value=True), \
+             unittest.mock.patch.object(Btool, 'sign', autospec=True,
+                                        side_effect=fake_sign):
+            self._DoReadFileDtb(dts, entry_args=entry_args)
+        return pins
+
+    def testPreLoadHsmPinEntryArg(self):
+        """Test that pre-load-hsm-pin reaches sign() for both signatures"""
+        pins = self._GetPreLoadHsmPins({'pre-load-hsm-pin': '1234'}, {})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual(['1234'] * len(pins), pins)
+
+    def testPreLoadHsmPinEnvVar(self):
+        """Test that PKCS11_SIGN_PIN is used when there is no entry arg"""
+        pins = self._GetPreLoadHsmPins(None, {'PKCS11_SIGN_PIN': 'envpin'})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual(['envpin'] * len(pins), pins)
+
+    def testPreLoadHsmPinEntryArgWins(self):
+        """Test that pre-load-hsm-pin takes priority over PKCS11_SIGN_PIN"""
+        pins = self._GetPreLoadHsmPins({'pre-load-hsm-pin': '1234'},
+                                       {'PKCS11_SIGN_PIN': 'envpin'})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual(['1234'] * len(pins), pins)
+
+    def testPreLoadHsmNoPin(self):
+        """Test that no PIN is passed to sign() when none is configured"""
+        pins = self._GetPreLoadHsmPins(None, {})
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual([None] * len(pins), pins)
+
+    def testPreLoadHsmPinInDtIgnored(self):
+        """Test that a pre-load-hsm-pin property in the DT is never used"""
+        dts = 'security/pre_load_hsm_dt_pin.dts'
+        pins = self._GetPreLoadHsmPins(None, {}, dts)
+        self.assertTrue(pins, 'sign() was never called')
+        self.assertEqual([None] * len(pins), pins)
+
+        # The entry arg and environment variable still take effect
+        pins = self._GetPreLoadHsmPins({'pre-load-hsm-pin': '1234'}, {}, dts)
+        self.assertEqual(['1234'] * len(pins), pins)
+        pins = self._GetPreLoadHsmPins(None, {'PKCS11_SIGN_PIN': 'envpin'},
+                                       dts)
+        self.assertEqual(['envpin'] * len(pins), pins)
+
+    def testPreLoadHsmBadSignatureLength(self):
+        """Test HSM signing when the returned signature has the wrong size"""
+        Btool = pkcs11_tool_btool.Bintoolpkcs11_tool
+        with unittest.mock.patch.object(Btool, 'is_present',
+                                        return_value=True), \
+             unittest.mock.patch.object(Btool, 'sign',
+                                        return_value=b'short'):
+            with self.assertRaises(ValueError) as exc:
+                self._DoReadFile('security/pre_load_hsm.dts')
+        self.assertIn('HSM returned 5-byte signature', str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_hsm.dts b/tools/binman/test/security/pre_load_hsm.dts
new file mode 100644
index 00000000000..5671559c838
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_dt_pin.dts b/tools/binman/test/security/pre_load_hsm_dt_pin.dts
new file mode 100644
index 00000000000..84cdf4291a1
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_dt_pin.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+			pre-load-hsm-pin = "dtpin";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_ecdsa.dts b/tools/binman/test/security/pre_load_hsm_ecdsa.dts
new file mode 100644
index 00000000000..5b00ed8d69d
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_ecdsa.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa256";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-ecdsa";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_algo.dts b/tools/binman/test/security/pre_load_hsm_invalid_algo.dts
new file mode 100644
index 00000000000..49d1c18f478
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_algo.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa1234";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_padding.dts b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
new file mode 100644
index 00000000000..6ef11a59bb1
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "invalid";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_sha.dts b/tools/binman/test/security/pre_load_hsm_invalid_sha.dts
new file mode 100644
index 00000000000..e6c693e4954
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_sha.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha1,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_uri.dts b/tools/binman/test/security/pre_load_hsm_invalid_uri.dts
new file mode 100644
index 00000000000..17838935f61
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_uri.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "http://not-a-pkcs11-uri";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_module_path.dts b/tools/binman/test/security/pre_load_hsm_module_path.dts
new file mode 100644
index 00000000000..ae25d63b53d
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_module_path.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key?module-path=/no/lib.so";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_sign_pss.dts b/tools/binman/test/security/pre_load_hsm_sign_pss.dts
new file mode 100644
index 00000000000..452f9f6d8a6
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_sign_pss.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			padding-name = "pss";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

