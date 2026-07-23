Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B7FC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE3826089A;
	Thu, 23 Jul 2026 09:39:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aRStauwW7aXd; Thu, 23 Jul 2026 09:39:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE39560816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799540;
	bh=W+QxKErn5OIuMV+E9xILebuOxnypa0BuHDDkLI2AcTE=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=a75XPplPFLu4mqH2NRPc2i6iOFb5TuHkQ9/GTg8+OnYakgXbfvcZJBWHROa+mf+Ni
	 lnQi+fl7aKho1fWK3T6pw3utZTdb5FtWQ1WGUzDkmNrsuNPWeDVrn5JcmD5v8DQle4
	 pqARlKo98hn/Wa8nqhCIJFZlKvl6FaBzbvPZaNKX6LmInX0bq4dAlWHeZI3awQMVLG
	 sJtqCytgRIqTNxuQLo3hIgzhrPICJnWQM7TbGWwhIH07LiUSZRpayUU3kaPK+YQwcP
	 T6cxCO2FEPuz5tsYGjNiTytrMjNLbxK+t9bwWId7UeaOkaJma2eadjmlONkOCEr8l4
	 03IBiX6UhPpvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE39560816;
	Thu, 23 Jul 2026 09:39:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41E7896C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EEC040026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jW-Gt7msiI3s for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5A5C54027D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A5C54027D
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A5C54027D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwFd5oRL1vKCpn66NyutM/bJe12Ta496BXUpZc2Dfv2ElhcW4ZUASrVshbT4O2vFM9m28/4rmgwyCp8PBoBEDboiv2iHxE1Xuv4Ok05LzXr+dPTglp75vaiQ/Xfa8FQn7M/VrEPn95RlFBv+dD/bweqlk6Fp8TzIvvACyQJKaiFruq5hezW0Q73ay2qmHKj6xtHmVTZr2QNzURNWZtMJ/EMqdbe3IMIXx7J7BFge4OHwaQTBLJVD1pPfCYJm0xtIhDEkQRK5or2VRf+XU5L19jrsHNAKADRdUQQgGPwSbfGu9YboIrGvVKREs8UUCeFHkLX3Ebstytrn53nKaaoayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+QxKErn5OIuMV+E9xILebuOxnypa0BuHDDkLI2AcTE=;
 b=RtBdn4HKyHAp0TyUMTc7kw01MJbKyRFCyxRElDLH29ksIogK/95C8u/6p2sQjEGmpEgkDk6+PyB1ha9ujBATalPom88gmq1fI8xaUHAnNrNVc2jiE3vHweoCKVO7av7DrEe3QoDzw7ycqVINGGKmAJP3wzqMoi0B6il5GLALBZJxf1wVCD+oSSXaIPeWjn7a4yCC2CeBDnAe2yJwOvsA1ZXGvA7KJaqmSrQRuFOAUM0yLCVpxTtgMEKa/f9d8A+FCAI9KNSofPDqiJVbHL+JpHCJyP3VtcQ13p0C5ufw1IVzXSSBb9xsZd8QJ+fr2rZCrvQhglg4KyXVAfjUU2V82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:48 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:48 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 7/7] doc: k3.rst: describe use of keyfile and
 distinguished_name binman templates
Date: Thu, 23 Jul 2026 11:38:29 +0200
Message-ID: <20260723093830.3132465-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0012.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5afb2b-d8e0-4860-98a3-08dee89e323b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xHXkvT3hg6Xx0D68ocE8YRcKVkjiyDLoiFzeZV+g9N1KOYTUChapzjiPVBsHH6yRHrOvt8e5SQAtuUD4lqfQ6lO3B4qfkyIJ2JlFidgMVrmwAAcljArpuMLPpAntKjBTDyYhJaeGdLM7RYZJxSV+zr7ok6y1A0/9E3OkAsm6Eww62vvYWqARaIT7HePRhvRNJog27xnMgxqkhfcx9WsP8OkKZ2kzEb2LtlfFDII3/5LgrhYRDd11UH2ETh8fUVppHMFZpTRd4EmQSm6hdIyKUg2pmgQ4JhZIKm6whmUAHiL/DYZuHKp3UviCG3kFFfe2xvRtfs2W+JjWueawCvEGFfedjwlG1dGCe9KyYC/58mUFoAwAvssg/9SjlND5Akbc8ThDQOy+68wfmIvHsFA0a8rExTEQX/bCsakpfy1VYW0dXqal3D6jZxivdPz0QR9fiaMbXpBYhIUDneeCA2iTT3aNMunz9sdbdxGpdB+VYiB2YAjG9e8hfzYdUC5BE2i/QPKN/jIXj5/8yDtxDBBWV/gVy4kgUtvPFHW9I7coHssHwJP/726tNWTj8jNeAvAqt27CFvERY3mFdmuKW2BiAXRJr7Kn/Ebhw0WV49oDEd2WMcQeKJkm5gEFX0XHjJXXHOys3LAuIuwuCq1ypqxlDOkIg6FSXxmbYZ4ONeAWGxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dN+UhY5p44sIDQSemCkZNaoaCcpqdYXhzz8qWBpU453sT638s3AIgF8W3fpw?=
 =?us-ascii?Q?xWli2SH7Xi4AmAoHOME47UsOhb72FsTTCGxb4rRkN5R/k0SLsQNBGJwKJ39j?=
 =?us-ascii?Q?cmPq9BmIfHfGXHAZ6RMLZHe+5myjUrRjpP4fmz/y6LkD5g4dWOLoyg/3bCoL?=
 =?us-ascii?Q?5le/iS6sRBVTu5HnfqGjhLBUVl+rx6LcfHvuxi/uFKvIsMY1udTwEmUHlhMa?=
 =?us-ascii?Q?y/Nhswrt43/vq8TCZ4qK944rDYiGfYaZFd1x5yhJqJDr8GXLXfqOKsC6euoz?=
 =?us-ascii?Q?nI8X+uYx7kAfYWNL90hDvpFYiIDf5tB5oxvUdTG5U1totKdpor9eRzo/pCZL?=
 =?us-ascii?Q?oAeCg4SSLEg+as4UVDOvBJT/FTbJgj0TyEtZTKfdLD4NnZ/89WHzdfNzYQ2X?=
 =?us-ascii?Q?4+AiK3N4nHYTsKFO0SI5zzk03ObgfmixcI90DXo27le1DMcVmIVaglZTjULY?=
 =?us-ascii?Q?aKwjzEivDcx4mGwxrmz19iWDSlRJByNrCGRXnuhmozPIsGHmWiPlDUJDrHB4?=
 =?us-ascii?Q?LetKWeVMNuPMe4Uv1iID2mpm1cavzVMLYtN1trnBCe7Yen+XDvLGu5ZkLfL3?=
 =?us-ascii?Q?nYatLdvao9JMlsDpGcIHzioFk+h4/17ACMKMFyKwJHgvE89+x33khF2DZ7uf?=
 =?us-ascii?Q?1DG8zFq9LsvyrIwlnGi4G7A/4PA94zTW/+0O1ovMxOu7oednhh7NdC+i+A60?=
 =?us-ascii?Q?JAaKz6uvPjN9yzljldSRCx6KXmfzrCiqWumMlwWAxR82Wec0IwLU65X3GH/J?=
 =?us-ascii?Q?7j9D36LA8Mbjrngwdnfdztn67qdj65aedpmcCjFBPDFP93pbknVc/yRqqj4+?=
 =?us-ascii?Q?A7UY1aU8SQa5DpShUCmtC4w1X9BWpXSGZ+bwp/2plCnak/61odhcQw9vXcjY?=
 =?us-ascii?Q?SCbTTpPf+SseFreVNO2QB6fhvbfWKoUZI9XcW1iSaAbCTId1JtgKHnJ2dVTN?=
 =?us-ascii?Q?A6LOLozbf5A4CDVMIJEMa2WMzC3WnyvIdMebC95SnEAQ9LUkR3BsdwRDHJsX?=
 =?us-ascii?Q?Sn1IcK7BleY9ew1ZIQEkW6DhEcu2iG6TD3CHgR0Cin+ghjAfOvHuRCWLRgDs?=
 =?us-ascii?Q?FJBNgQcLCRCNKwSUnvDOtCXBNPVl3Fq9oi1AsyU7yjTXZ7+DQ2GIMEreKO73?=
 =?us-ascii?Q?Cz3A1Q3uYqaVr4xl25nuvulGqz582gDECOxdrpILPdwf3Jxrt2M9qapNA5G1?=
 =?us-ascii?Q?vhBgkuUqr6WrhZXg3AG63ywm9sKJCqjC5a13/8kzrMxwk0nJ7RuFWZPwUbb0?=
 =?us-ascii?Q?raUKdby0AE4kC2PexeqNI5KoGU17Wl9NVMe8KZmoRhRpC4FjA5WX4Eexcge3?=
 =?us-ascii?Q?FvJqymmncQdVg7K4gvNvSFR7RTh2xZCJh4pEXOC1LlEFGepehSnXyuvjq1XP?=
 =?us-ascii?Q?vgHzNwZaQ7YoPccb2YVJuFYDJwPqqevkmtD5rtOT7FQqi53JQyFEpSVErzz7?=
 =?us-ascii?Q?JcLQJdmSlRfXsHhAsvCn1dRFypBoNzvTk4/JWbYCfalPlucUTVbwuowQ/0S2?=
 =?us-ascii?Q?TeJP72RFq1lPB2fes4TW2c42jdKiftRvGua7vffMjIlB1r2Sj0lE6lRHgLRj?=
 =?us-ascii?Q?R26vngWVTVkRBYoRRYusKOeGeIHH2BEmwSKoAcdGL9xt5GUqRznnrAPiSXeh?=
 =?us-ascii?Q?9MycK0oAHkF0Rl84gYceMzTPwOVUGBZJv9xzYhS+jlGnQsReZTkVQkWYR7YD?=
 =?us-ascii?Q?DoOLtKtg72a+N4tZXwm2Fst7YXHoWVG1KgDXyMYUs/UpoLBwsIBCrEQV44Il?=
 =?us-ascii?Q?GCRve/sW7iewjA9KJm39VklqAHNXpHE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5afb2b-d8e0-4860-98a3-08dee89e323b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:48.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTC0lm95mhR58MXcU3bQR5AU5Yu8vd4yWZRUsd+uRx/J2ajpyzhuQw1EeJe7z+y9pG5A5YMjxgoOoOCxq2s62nxbx1NfcmKeDG97IYWG5Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+QxKErn5OIuMV+E9xILebuOxnypa0BuHDDkLI2AcTE=;
 b=I5w5J4JR1dcamjOaLG6QZBvjRNkS9CVc20MulxRcdhg2c6tKOn5FN2pU8voKCs0ari35q12w1r5aHkgDYwo8R2em+ZHt9q2D0AZ2kWdBoSztjorwgBTtKwTsc831grKUcHXDWHdmyAB31Ii+SN+xWe10n5IUEBmIM0scBs7EPrQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=I5w5J4JR
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Document how one can use the keyfile_template to specify one's own key
in a single place, and similarly document the use of the
distinguished_name_template.

Also mention the ability to use a pkcs#11 uri as "keyfile", and that
it requires one to provide a suitable openssl configuration file (via
the OPENSSL_CONF environment variable). Details on how to write such a
file for one's specific provider is out of scope for this document.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/board/ti/k3.rst | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf59909..9f87101217a 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -127,6 +127,54 @@ function as in HS-SE, but as there are no customer keys to verify the
 signatures against, the authentication will pass for certificates signed
 with any key.
 
+In order to direct the build to use your own signing infrastructure
+instead of the custMpk.pem dummy key shipped with the U-Boot sources,
+add something like
+
+.. code-block:: dts
+
+    &keyfile_template {
+        keyfile = "/path/to/your/key.pem";
+    };
+
+to your board's ``-u-boot.dtsi`` file. You can also customize the
+Distinguished Name in the generated certificates by including
+something like
+
+.. code-block:: dts
+
+    &distinguished_name_template {
+        distinguished-name {
+	    C = "DE";
+	    L = "Berlin";
+	    O = "Acme Corporation";
+	    OU = "Cartoon props";
+	};
+    };
+
+Ensure that any ``ti-secure`` or ``ti-secure-rom`` nodes defined in
+your own ``.dts`` files contain
+
+.. code-block:: dts
+
+    insert-template = <&keyfile_template>, <&distinguished_name_template>;
+
+as that will ensure that all certificates use the key and
+Distinguished Name defined in the templates.
+
+If you do not have the private key in a file, but instead use a HSM of
+some sort, it is also possible to set ``keyfile`` to a PKCS#11 URI, e.g.
+
+.. code-block:: dts
+
+    &keyfile_template {
+        keyfile = "pkcs11:object=your-key-identifier";
+    };
+
+For that to work, you must set the ``OPENSSL_CONF`` environment
+variable appropriately when building, pointing it at a configuration
+file matching your pkcs#11 provider.
+
 Chain of trust
 ^^^^^^^^^^^^^^
 
-- 
2.55.0

