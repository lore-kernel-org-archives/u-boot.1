Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBBC531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9D7560697;
	Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oLVwq-FLX_x2; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA4B960783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799531;
	bh=a1kij7Nt9E6y8S1/H47M4fFcugEv0AZdyacMLb1CIsw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=vFJaQb4fve+ddJ6yIASN1OlNYq58IrawEWcCjSbXxdaPxvsowlqPwjQMw39HnbFrV
	 jb25C4lMFnwU+wxVyHp5exnjHXDTxQnuloAXOv5a3JcMJEkxez/rKiLq+/XTEaCPpN
	 eFPNwRjeofWq3xnGpEUSjlE4EIQyFdRIETLcllNSj87li08izoEcHjrrRCCqXwkEFG
	 JYdrdMq6ObqHNvLncKeONn3O9FATiVSkWN0Rq3Qk3erY9+86g5AhKdNYlcWSPb4375
	 +jyU3q+dB8Qjv8Q+wMQrtiVVv+xDyh3QJo8pe58nIVmiFXDSTVmPHBVthU5tPbsecf
	 rJVoyXdLBRzqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA4B960783;
	Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DBB5B707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCD784027D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lwp6K8h4Yeiu for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 89C2640026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89C2640026
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89C2640026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrVjSFxXSWTYQnUSJcvd6j+sgzgnSmF/5qKJQ1er2O8swWO0+ULDvNvVgZ7LtAItY+6eAXjbTKK8BbFZgOaxAnOAr5IpEim2ZR2WmsgtLE51DWsOSDXdXuizKWIpBYm9e+aL2d80mntXPrgKit5olEccR7eKTHF+pRbd3Ks6WQqwF5P3LXJ8FMk/6E0H+4+/LvIhEHIe/v1jFGct144Af5JwgWc6wM/JO8mQrtougE8PGzeVdunII/HWcQd6VyrmePx8+hSmZlk4Q/g3vuRWDjviLP1S5OQ0Bq/aTvtD+LQUA7bSlQSsg16u6GvddY1gfuMHS/gNoDSY+949n2La2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1kij7Nt9E6y8S1/H47M4fFcugEv0AZdyacMLb1CIsw=;
 b=k8eLf8yFttomvvNdTJ91mwjZrG394oRg1ZIOnoDmwE/lh7nuoxgswrNtFI/ZqL+63R/rHqtsGlPkjGhl/luqUW7U7MfLa2dovXO/RUMaiyz2bZz69uZwvPzZfpnQkT98oL8e9GBILBYPI88Qmz9tLIPWQMBTTlSuvWuvRDo3nVVOiiNebVb+HM+iIkfwU1vTOJvmg9JPtIMxRZzv/8T4Huy3cXyLnzCy5kOjtq2SU+LPbp17pM8JNPxWlBewDtcEyq7GIJUbhCexucQKvmfV3+uFIGQh3qD/d2EIWVJx2L4fio/j3CPlQdAWn/xYHFiqu6ROy5orgmaysyJFSdkmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:34 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:34 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 0/7] k3-binman ergonomics
Date: Thu, 23 Jul 2026 11:38:22 +0200
Message-ID: <20260723093830.3132465-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0008.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: e2993498-4049-4422-4ce9-08dee89e2a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: IakX3AOmUBd51NKkX4PmNFLwX/1PuBw8au22/m7L39FyEhJMrx3gFaY5e29U5/DUFukAjbk7sXXvSMQj3yo8xzC9zgF28Wz5hJdFbeUIUdnVZ6InIJY7J8OLiiPWx3BPH6ddYHQBNfgCB564BK11teUT17qv1IDPtQgZDyXWwwhhKrIDk4baAN3w7qMZk0Oixw9gryW00Wp0DK2UHanaZN3bdn/qyLHN0i0RB6T5A1vTT2gGPROr5OgKsVTnSMHuszfF/k+DhhbSBvJ9j9Q35LNpxzN3+sSZX1jJ17T6aE06VN7Y+UVf8AwR1/nR4Ok8jk0vB2ufXjgSY2phRWmy4VsflbnxAejfgAQGN6K6QXZNhl6CC5AzBUcZrjo5q200LuoOVEJ95gZkfbyIk9su1qMeRFV9sC9Gf5jqdmKFouRBS3kzgzmsiLAgU3q4TPEeksi/g/dS7In7i2vgWubH5JJ5WRhXXaOy2NVDVFbKi1w++34Z23Ps+yvpxWH+EPy7/URNCeyHohZ9sWoz06bzLKxjhcoJbCHFu+S3bIYCSiDSgse1SKiAdQKkQm6x5pH37QPM0MDvdLdM0lsIwS34Yg9kHgfSBAKmrJJh7BWbLUgzzLGkKE9q+zvMem4YLFNVQp0dndbxfRAmW65FenMkAO03RZMYImc1z+7qUf9X4kE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bedISx5vqoHv0Wkb2L5tYEADHMCZNqixVUJWaT/5R8v52mkBaaDR4iOLyuH7?=
 =?us-ascii?Q?0+e0YtXmhSDiV2HjyiJvalj7rVun2MN8Yba9XsmzsomZaNP5sCkzW7MnScrH?=
 =?us-ascii?Q?Dyg1JBxPY5Z81iz9JnZ9H4w3OJ+EWNDnZumj1dKG02LnicD4JWYSZ7bhFpU1?=
 =?us-ascii?Q?2g+bsu2hdOdH8zbq25qhpS6il44lwiTN3DVTMYrC5I5Uby7EY4Go9QpuHG08?=
 =?us-ascii?Q?dNqTBi2sxBdV7t6GgKqUWdqw7vO2S2g+tf6f55mRl3V3bd7Z/aHhEmsePhJi?=
 =?us-ascii?Q?9adARuZy1Psq2OrgdIPj8D4BOAHkhpYrnaTEMdV4L0Zn1A97dWK7ROvT+itK?=
 =?us-ascii?Q?Q2CGQ71KgvJAvIk0PkptGtpgdn8zjZlyaMsRXdphg/+pC+0Vud10vQOo9BXK?=
 =?us-ascii?Q?JL5pBEiczD4IvWuqLcW7uEehoSJ1r3TJgv0M4ENNt54GAzRt/A039d5CnA91?=
 =?us-ascii?Q?UTNfOiVRYLMBjksiUcE83nm1RWEsLWeR7vwrZ2HdXvI3DyPnTuT+LGoSg3am?=
 =?us-ascii?Q?onRZWdG3gIMOQOouxpbA7wcPrn/DmMun9wPASsxom5payFKBiVMUQ1zMYOCS?=
 =?us-ascii?Q?w0qhCvL/GhnJhzvQ0exTNsK83gDjcROWReLGkMjDd/WVu2DArmlgEFTp+u3d?=
 =?us-ascii?Q?DJ20brgY2qeMf7WbLUcoaMCNRwZkGmVIak4HmNuxL8L1qnMor0fDTrdHwh4n?=
 =?us-ascii?Q?WLQXrAQXlcQQx8PfBde+cGZXVsTnbq4tEaQyavYnfBz4uMLZhXlQoIZApgrK?=
 =?us-ascii?Q?AqoGTxSziNcA00AsXVpUJ9b9yJUODMwD2IoFBNUDqWFyY297sXi4uu+H9kuj?=
 =?us-ascii?Q?CPX7sd/9GKvUqMTZmFHrseDgd+RPdoh07/1in5aqkzdBkv5bdk+o+xwnfWxA?=
 =?us-ascii?Q?02SHMJexMSWWJ6crFI3IvagjKnm8anNSsDdRapIHU03+gRhhujTubtA8d1YC?=
 =?us-ascii?Q?Tlfzv0jYYMG98TONXQ9nGXfWMwckMgTHiIXmuIJcDGvzG73tG2Woa3qOXS2+?=
 =?us-ascii?Q?iITJiFEn4dGT8hJW8NDUO4NxQ2SGJ/QD8tOSA16rHqvMzGQY9skM8wdDxa0E?=
 =?us-ascii?Q?fuT+Bo+bgH92Bk5BYUqw2owwKuwsl3pIgs1BHhTMcwK3KGTp1gUoOEQ73bN0?=
 =?us-ascii?Q?weT1VyqemSyCDYJZGovkIsbN89YVLkwVa3EyoQVz4a+EL5Z19nRhXQpa40i/?=
 =?us-ascii?Q?EAgkTqLXS54F3s9nSgEh9phzOuewdeP1UmQAy/nwJPqp84NKwDNH5V98V0LK?=
 =?us-ascii?Q?ZdExbBSnu/ETpzMMaiuiS4/S4CvKELSjcORbsQAKS20tGw1ef1GRFCHGW9KE?=
 =?us-ascii?Q?7ONFJnENeABLYCUEYESWEQVtw/E+u+1jyP0Myr8VTk+i/xtgZwi3XviEYloV?=
 =?us-ascii?Q?nhNc/TW6fOig2n/2hoX1vmpdEcmYFVEJvN7NMtQuUVQGcPP09wk7HPevlUEE?=
 =?us-ascii?Q?K69ZSs2l4/LeK3G1N+rlvb2b5yDaUIwnED1dsJgO9jqQ1Jx8O9DB1eJCfIAu?=
 =?us-ascii?Q?6FB0uzwTxAzRfDJ2yyk+GqLN+3C3SEHj7CbnDXAbH2QhSgzBQXge1uV4zl5o?=
 =?us-ascii?Q?cLe8AJDYCs0ZtP6DJGFxbpqZF3cjyebVd+dfBzIr7Sh6Q2q172+7d7k+xL57?=
 =?us-ascii?Q?hBbh1OZtlFFyDsbyY10tEAb7dbb1u9uYLisKwVWGN82j96p0BXu/d3cGHA/j?=
 =?us-ascii?Q?ZeQjTILKRixv1q2dlbYZAWP2xSe336u6mMUOAZnOm4fW8Si4wq9VevgmLu8i?=
 =?us-ascii?Q?xZMDTgJlngO2XiJ8PL+xCLLrxf3DFNE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e2993498-4049-4422-4ce9-08dee89e2a1e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:34.4527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2S52JnRusPE3xEB4BuIIF5fB5DYUFh4mKFRzbXrUMzYeaTOdXydgeE48BvkKZDgr3tJqKlGXFBszzULPCqhOnwpPBidbM5CAuMqzIDS3Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1kij7Nt9E6y8S1/H47M4fFcugEv0AZdyacMLb1CIsw=;
 b=Z2CcL3TBPHf3O5+t5JuFt19b66vfLht8Isb8VP4VdLOG79noJS2c75QZysNd5C6lwcCd0irBwm79UM/u4Xz0F9T+L3m9F0zPXpNcFcspuuCPPYquWQt9gaabOwTI6fTMowwyKnRKyth4gjBrhxjpVTHALr+V8UcwICAyrI+6X+o=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=Z2CcL3TB
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

When trying to hook up use of a customer's own signing infrastructure
for some am62x devices, I found it was more difficult than it should
be to point at the right key(s). One has to patch in the keyfile=
property in way too many places, and if you miss just one, the build
succeeds using the generic custMpk.pem for the one you missed, but of
course the resulting artifacts are unbootable.

Use the template mechanism that binman already has to allow one to
only set the keyfile= in a single place. I cannot really imagine any
case where one would not want to use the same key for signing all
artifacts across the r5/a53 cores, but that is of course still
possible, just as any downstreams that have explicit

&{/binman/tiboot3-am62x-hs-evm.bin/ti-secure-rom} {
    keyfile = "foobar.pem";
};

&{/binman/tiboot3-am62x-hs-fs-evm.bin/ti-secure-rom} {
    keyfile = "foobar.pem";
};

will continue to work.

Changes in v3:

- Fix thinko in patch 7 (s/keyname/keyfile/g).

- Add Simon's Reviewed-bys.

Changes in v2:

- Make sure an x509_cert entry (and derived classes) always has _some_
  valid reg_dist_name attribute. openssl not only requires existence
  of a distinguish name section, it also needs to be non-empty.

- Implement the "allow string list a value" for distinguished-name
  properties alluded to in v1, as it might as well be done now and
  doesn't take a lot of code.

- Verify that property values in the distinguished-name node are
  strings or string lists.

- Add documentation, both to the binman entry definitions and a new
  patch with an update of k3.rst's section on Secure Boot.


v2: https://lore.kernel.org/u-boot/20260717135824.2142135-1-ravi@prevas.dk/
v1: https://lore.kernel.org/u-boot/20260710123618.2036728-1-ravi@prevas.dk/

Rasmus Villemoes (7):
  binman: openssl: refactor creation of Distinguished Name section from
    dict
  binman: x509_cert: allow and parse distinguished-name subnode
  binman: x509: fix CN emitted for basic x509 certificates
  k3-binman.dtsi: add keyfile_template node
  k3-binman.dtsi: add empty distinguished_name_template
  k3-binman.dtsi: insert keyfile and distinguished name templates in all
    ti-secure(-rom) nodes
  doc: k3.rst: describe use of keyfile and distinguished_name binman
    templates

 arch/arm/dts/k3-binman.dtsi              | 35 ++++++++----
 doc/board/ti/k3.rst                      | 48 +++++++++++++++++
 tools/binman/btool/openssl.py            | 68 ++++++++++++------------
 tools/binman/etype/ti_secure.py          | 16 +++---
 tools/binman/etype/ti_secure_rom.py      | 16 +++---
 tools/binman/etype/x509_cert.py          | 23 ++++++--
 tools/binman/test/security/x509_cert.dts |  5 +-
 7 files changed, 147 insertions(+), 64 deletions(-)

-- 
2.55.0

