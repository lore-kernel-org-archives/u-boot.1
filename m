Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559C2CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A08683B99;
	Tue, 18 Nov 2025 14:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=flex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Flex.com header.i=@Flex.com header.b="h9CRO8Qa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Flex.com header.i=@Flex.com header.b="h9CRO8Qa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Flex.com header.i=@Flex.com header.b="w0YD8vbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B21983CB9; Tue, 18 Nov 2025 12:25:58 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C83E83BD2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 12:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=flex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manuel.Rota@flex.com
ARC-Seal: i=4; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AJy89osN5rAz8PvU637unJmpe2ZV5nKplCqalOewSxogqD1ReDA3iWP8l6QTJfa5XfeYj9mEY2FclWYaRUgNUItnkty7d+NGYoWq0KSAOQ5Uz1j7SD668AOZlVelbQ2EeJczQONqoY7hpZBpZbavX2bNO7zknNVc4OePSqvqP4idfOaunv69ZXNa0eGDTo0+qo7ihLEENfEOqSufisTY1nwL1OdiDbP15sFDy1UIldigWjFZYGXUXkUrNhalNqe3cz+Mj8Y3qTAxcsAjCZj2Klx9jkfIRkC4z60PPoUCjBSMVsK6otGknbGJ/Vfxzpe27xhf1kp+MQ4k8RwuQoA6KA==
ARC-Message-Signature: i=4; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdYyxAJQvf+hhcGatBIUA/dJQcjIxj/UJS6e1MgM7DI=;
 b=wwbZ0bfzNUfYJnebURYdrGhVd3eUx6CZc1U0GVZnJHldNMG83ALSKaL7f8aqIYV1WA2Ztp/Ev2VR4Sa2WfLzIUViD0TvB9hPJwnLvwUyPiPEx6AW1/x+W5m+lGju8xwhR1EwSY62KP7sPLoGLAILbUa+B9ewrbaaCM6gtg/ofjIOobxk+2ib17NdivDBHBOR1t4O396b8xP4w6Ppf/RfOcheILXxtvTTPw6omSKMKI17sT4PaAHGag7PKXDhvDXPiKPGxTNdUmUObe2M9ZepHIh+K0ZTAr/fk8H9IctQFqINUIsN82IEj39k9Plx8ALwNcbshvSG2bHo562yxoErVA==
ARC-Authentication-Results: i=4; mx.microsoft.com 1; spf=pass (sender ip is
 144.49.247.11) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=flex.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=flex.com;
 dkim=pass (signature was verified) header.d=flex.com; dkim=fail (body hash
 did not verify) header.d=flex.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,3,smtp.mailfrom=flex.com] dkim=[1,3,header.d=flex.com]
 dmarc=[1,3,header.from=flex.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Flex.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdYyxAJQvf+hhcGatBIUA/dJQcjIxj/UJS6e1MgM7DI=;
 b=h9CRO8QaJsiUhgaF0VlRvMFzGhHSK8k+DH2qNKaPrzxeVcZ7rbweidzrEsUuHpObYlsHc3eCcIbZ3w4+uJU13PPNpxLKoKZwa0zT2yPVUxI3DBqNrSNDnwOiRssMKlLF/ZCz/YbMhO6tUZAIybCTeyL/cTJzkDLXhMcI9ombNOU=
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by DM8PR08MB7509.namprd08.prod.outlook.com (2603:10b6:8:f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Tue, 18 Nov 2025 11:25:50 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::40) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 11:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 144.49.247.11)
 smtp.mailfrom=flex.com; dkim=pass (signature was verified)
 header.d=Flex.com;dkim=fail (body hash did not verify)
 header.d=Flex.com;dmarc=pass action=none header.from=flex.com;
Received-SPF: Pass (protection.outlook.com: domain of flex.com designates
 144.49.247.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=144.49.247.11;
 helo=smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com; pr=C
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (144.49.247.11) by CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.9 via Frontend
 Transport; Tue, 18 Nov 2025 11:25:49 +0000
X-CFilter-Loop: Reflected
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hk/SyCFIMPsz/0/enoEKSKGIHg/NJr899iWiyhhEj3IEJTahzButFiB9oPuWBQ/lqWdlluQSHZARTCMLmcEKIQQCcDyPfSNqMT8V1WXfueUyd/kL3InZBBS5IJND6rXIwFVlrL5RSQ6QD/q9KQrTiAeP8iOJ2HdayI+37sDA1ZTse6KpvAKZ9jGnEE6S1ScIgLs0euG6R0GaaspIJBfCP9TqfwyVVfDkTpYfabbVbBhpgMpdbgTXUD5XDGA54n/Y5czTqVJX3BQYDzGnjJm4oTnfblvISTbnYkNWcs5flhcl2PIWPaQxNQf0Y43FeyvdW/fvb4FWjowgEOZ/42ksWw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdYyxAJQvf+hhcGatBIUA/dJQcjIxj/UJS6e1MgM7DI=;
 b=JbcwQFpPe0A2lI8gVEk8YzmuiBO+ooWXjvpqGnKyRmkk7H6agTdKKmtqV2QK7n4M0UQp5E3o3BJeV2beJj1H7j8WEzOUp/XClVZjGhj1wnVQabyKBmzqt58jwJgXPd/PFwJHdU6ebpQOlAX8r5uaeRyv1zX+76VvBxhJUDP7TuH5k1OssLpayNpE/lMAKQpnjBEVs+Nb5Xb6xRtMr5hJkwGiBx53zbbiZJdqY0N7nAhHnmd7zKgfLb6PM+r0Lgx2NbSFydPSxnPEoPQyPEVP++7D4F7hCX1FHvXhrxZEAq0cudcqZCHeSguFP0iwIZCSjnNfm/3zMe1eOYgCjQr8ww==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 3.214.204.181) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=flex.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=flex.com;
 dkim=pass (signature was verified) header.d=flex.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=flex.com] dkim=[1,1,header.d=flex.com]
 dmarc=[1,1,header.from=flex.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Flex.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdYyxAJQvf+hhcGatBIUA/dJQcjIxj/UJS6e1MgM7DI=;
 b=h9CRO8QaJsiUhgaF0VlRvMFzGhHSK8k+DH2qNKaPrzxeVcZ7rbweidzrEsUuHpObYlsHc3eCcIbZ3w4+uJU13PPNpxLKoKZwa0zT2yPVUxI3DBqNrSNDnwOiRssMKlLF/ZCz/YbMhO6tUZAIybCTeyL/cTJzkDLXhMcI9ombNOU=
Received: from SJ0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:2c0::28)
 by CH0PR08MB7305.namprd08.prod.outlook.com (2603:10b6:610:112::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 11:25:44 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a) by SJ0PR13CA0023.outlook.office365.com
 (2603:10b6:a03:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 11:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.214.204.181)
 smtp.mailfrom=flex.com; dkim=pass (signature was verified)
 header.d=Flex.com;dmarc=pass action=none header.from=flex.com;
Received-SPF: Pass (protection.outlook.com: domain of flex.com designates
 3.214.204.181 as permitted sender) receiver=protection.outlook.com;
 client-ip=3.214.204.181; helo=us-dlp.cloud-sec-av.com; pr=C
Received: from us-dlp.cloud-sec-av.com (3.214.204.181) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Tue, 18 Nov 2025 11:25:42 +0000
Received: from emails-8039042-23-mt-prod-cp-us-2.checkpointcloudsec.com
 (ip-10-10-152-138.ec2.internal [10.10.152.138])
 by mta-outgoing-dlp-982-mt-prod-cp-us-2.checkpointcloudsec.com (Postfix) with
 ESMTPS id 50B4780497
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:25:41 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1763465141; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=3kTo9HGo8AgUobSngR2+BbpFrFKiUyFdp6l+G6VFRGo=;
 b=e6pJG4jJxVqrQWCIuDkzmaBbl7LjadTkK9G3xf11ARSnSy/J5G5yMdEbHytvbhEtdG2IB
 HO1H7SuehkkPEkqzThqBbyOb2XhD24Q9gjrNY6FZYhkDJINt4F/f+mHjovkDWAmppVF1r2G
 M9U8CMk40h1EycQdXe4KsvbGEzVU9VQ=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1763465141;
 b=V1MvMl6RKYyWQruKQKbGLlKmS8wbYQqLw0sMQZf/NjiUpVDdCHhi5AElYHy4wR7TIuVbT
 XEDTKAcQ8QXuWQRtI9WH2SZ8F2iAwa+x2wyEuP/x0SLW8VNcBlKlbA8aibU0HirtISVnJbN
 4G8zntLVg1fyacmW3TL3kqyVzB2EKm0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZKrt67e+liv2kzSZZ4oOhXPjcw5KQM+o7SjIkyOxWm27wt2T8FaVWs58S7eRK77ErqsTQL+v3yiFq/MZ6XZwBpNgMD/xkmctlqd42clGMrtgwRdNelEpNY77cAGpbUk0HM9fcgvx4KNtdKXkPjG3HEUI7gNkoukt9n5vEU45JV/UE65yOw69eoHVmOoRpxujVGmwUaHV3QGOmbel32b6q3yb9T6i9aIhM7kWLqV0dVIFKktGrPED8Satxcr0dJ8liRXqkJA4BsoKDIrKyW6ZsA8q+LpwI0Pt5dyc0BO5gtvpMeWxn+ToHCB3I0VlD6cN7ygf2GENMli6DXisFmEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kTo9HGo8AgUobSngR2+BbpFrFKiUyFdp6l+G6VFRGo=;
 b=AfZk4P1HrDQowP+Gqm/FM8Td3hzkdvGQ9j1Twk0I924HGCBVGq4lwKlxeVQSu+pzgB0bZXjnqJt0kJ5VdKb8oLxrP41Xj7BbMvtxDWzDcjzm4NO30rv9OCjOYWzMINVy0L0kMIzBaqq9ta2nY6IQUhVHbIp5MCw1soY6G5hUD1oXanqADHTUPSf++kgu4SFnA6lkfpIUZCch+L/dYvSnhxFCcMCKdtYZcaBGel5cZSI4tGC/CnYOMe8KNjr7bNgIlEqC0Q33etX5bBGJickDd3LzJxhtLNVtY4FRxZGtp02tHM4LmcXL1LQYV1baFHRDPMIvIeYLMdcKRi15vRf40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=flex.com; dmarc=pass action=none header.from=flex.com;
 dkim=pass header.d=flex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Flex.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kTo9HGo8AgUobSngR2+BbpFrFKiUyFdp6l+G6VFRGo=;
 b=w0YD8vbXm45YfVIgaAheoSuMZNZCfQpAMRHwWeKb3vNIPoz22xlkdmSGZBVMP+oMjxnOHB4vVH2yuRiX/VqP9PUrrS9yrp9s/vczQQG8WDd8aCthKVe4x83Rf+7ZXo4R1uf+9W+ki4MKl/KbMTSjky/QQ/BMzmplgdpikPtxOlA=
Received: from SN6PR08MB4797.namprd08.prod.outlook.com (2603:10b6:805:77::28)
 by CO6PR08MB7706.namprd08.prod.outlook.com (2603:10b6:303:141::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 11:25:32 +0000
Received: from SN6PR08MB4797.namprd08.prod.outlook.com
 ([fe80::668a:dc61:9766:4fb1]) by SN6PR08MB4797.namprd08.prod.outlook.com
 ([fe80::668a:dc61:9766:4fb1%4]) with mapi id 15.20.9343.008; Tue, 18 Nov 2025
 11:25:32 +0000
From: Manuel Rota <Manuel.Rota@flex.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: booti command fdt argument
Thread-Topic: booti command fdt argument
Thread-Index: AQHcWHwnWzHP6D3C50macUxq0/OQew==
Date: Tue, 18 Nov 2025 11:25:31 +0000
Message-ID: <SN6PR08MB47976387EAB57812414A99649AD6A@SN6PR08MB4797.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-traffictypediagnostic: SN6PR08MB4797:EE_|CO6PR08MB7706:EE_|SJ1PEPF000023CC:EE_|CH0PR08MB7305:EE_|CO1PEPF000066E7:EE_|DM8PR08MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: abe341a5-76dd-48f9-0d31-08de269539f8
x-cloud-sec-av-info: flextronicsflexcom,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?b/+3zG8Qag46lgDdEFfaccKi2rsbucnagui6DTz9vtZwX0Qp/XvcOdVvX91h?=
 =?us-ascii?Q?AL9LVDHA42gLOGaIUn/XOAsH2WTQ2GLXSxNY2drkccFl/lijCNwK9KSwTuVJ?=
 =?us-ascii?Q?arJfWBNoZyp+iBy2/4h/q9JxWdsdueXjKvdaBPki/y7u8U8/Xevqc6/qeHMv?=
 =?us-ascii?Q?ycN8wcqUQwQFcXdndBAcIXq9v0OuDD0Ls4HQlQMybnAQi6amBiUz9GL4HZhk?=
 =?us-ascii?Q?CF9ZmeezHYNyJSoxByw4FpItIq+3KXueA51GoCVSnAi3Wk0i+EHIXFO5NWYb?=
 =?us-ascii?Q?ZY5TkByStVDFGB2BcGEoqzHJatf3MMQKbxVOnE/M4z1r8nE7y0za3cy8wuYA?=
 =?us-ascii?Q?Okgotr4gkS/Qe03AqD+AzboLnDRyPO9h2GXkP0nr9WTt4GPNbz836cRqlthl?=
 =?us-ascii?Q?5RpTSbARD5EAWDV8VXw3rTJEoVPW8/BKBCiEnLu/svYnXK2Vfjq3JLr2w+AQ?=
 =?us-ascii?Q?ZWYGY9OtWH2k5P0eS7IvVrsZ0WCAILz7DqPG6Wk7U5Ncb1/j5Dol077j1g8s?=
 =?us-ascii?Q?gqJvACG9tAQxs7rVDECn9CRC+iOI4efmZuvdOiQKmMH8lCimV5edOTuCYfPr?=
 =?us-ascii?Q?TMcnifdIhosA+kz/M8SIMIilrXzTYqkLv6Sfpe4Zy2NAk+CxUOy0Vw4FRzVY?=
 =?us-ascii?Q?e9svIBzFT/Xv2BAWXSXlPnhKuXcE+MmDCn/K6VP1HsTHI6K64qVyNLZIFChw?=
 =?us-ascii?Q?8k/ZH304nJ+uTCNm8wbqICkazkNngmbvtpKmbd6uE1P1T6JUerqpbpbLHpmH?=
 =?us-ascii?Q?C5uIhmyY6h2D5eoM6Gvp42BZVuWg3Z5cOUldzczf4LMXtopCAh25WN0e2qBK?=
 =?us-ascii?Q?D2xgd/EH8/Y2OEUz8cxqUvtH6o/uae0E7IIX1rqdu08Fzio4B4ItQ0QuAi4Z?=
 =?us-ascii?Q?6tdhIgVpmomtkB44RUQ5/mMVy4iJ1tPYRcikk5Z26CE7aI6C8QtbmYQeaxap?=
 =?us-ascii?Q?nZkKxbzsYKVFqP3vJwSeNyFTGa5dNefjFqW5gAqAwjZqzkHI6Mv1WVUubdIT?=
 =?us-ascii?Q?pgxvIjZpNlD/XppwtQYKcjz2wPemHbCLRGrOC9a9ePbTdjm4A3P1VO8kfe8h?=
 =?us-ascii?Q?w/cduttIjySaKSRnPlETfQPIkzeAaQk8xlWDQUhVj3zOPQxXREZ9bfbH+OQv?=
 =?us-ascii?Q?r2LZAbg0jX42pcZXurgad7qmako7zdciX2k+MlrN+Ivl8EuPQfEDmVXd3zCn?=
 =?us-ascii?Q?BBPAipYK2RRJwcndQA4UJSEByRHWw0+BtpDxuU5v8dObFvSNyQ3RGAR0dOg9?=
 =?us-ascii?Q?aJ9KBlarTY6B8qCQizEdPu93ZEirNCdIT+7G2gTbjncMadL/ulpzmKQ2+yCu?=
 =?us-ascii?Q?Xc8sMTfB1sbbDeIMvZHbpcrLNXzat646JsrnSpiqX8yunbO40LcXRxE1pXmC?=
 =?us-ascii?Q?CmQev1nQ7yYBjqy5Olx2Pc0OVU/2d/takjc/3suXZ4tuPUaXp4cmvjriYgp3?=
 =?us-ascii?Q?I6VLKzd0lxZhwSI5OaOnFF5rlvtldNDEDiht6Gg/HRe4Q/bnGpTi9vAp+DPJ?=
 =?us-ascii?Q?23j1rii4RY4IR+Ku2w0w6rcUx/UWAxyUQNJR?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:SN6PR08MB4797.namprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR08MB7706
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-us-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 270f5c57786c4aa28cb4446d6d6150fc:flextronicsflexcom,
 office365_emails, sent, inline:e25eed2429a39d2a9dbcd88ffc89d42b
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a5e4753-5b0c-4fb0-f93c-08de26952f61
X-DetectorID-Processed: db4f4c5a-5dd2-4f21-956c-7ab15d947193
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|82310400026|14060799003|35042699022|36860700013|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?ZxFX81Tt7H77r4QwuRyBwMnvPIa4UtRYvbX9NeK7QQz8z6cmDBM+CSBtaUYx?=
 =?us-ascii?Q?Xt7PrGtbmYOZmkh2JTGXfhq3jzS8lIN9gOB5+UU2BeJ5eXnfZzFU45XYC7pV?=
 =?us-ascii?Q?IJqcmVVYkao17/Jzo9jJQ8n7ypJGbVjFBNVgXG5ulHbQ8Jyu+aQ2ZZGM/jV9?=
 =?us-ascii?Q?WkQWRIRbIBGEFc0vgPLPRVqNgHA+8swjuLq5ewOH5JARgsXZVlwxJJ/qJeYi?=
 =?us-ascii?Q?GijhPM4V2QjeCfU8aWyELDj9HHOxRZ997A+6QrUYmkw1yrzVWxREDdecQ3cp?=
 =?us-ascii?Q?UpTcD7rVf1p+0RPigqqEbXXK67AkP1OQbkrs/iuluSCIzpI2fcp5hHqfnkqd?=
 =?us-ascii?Q?K3RpweS38P/hg/6/BdL9hfcKm2Ph1z27X1/cYtu73C7QP7oLy3tr+Z+v1D2C?=
 =?us-ascii?Q?dzm/pnMK+nUr/EClSmR3fpHi+dOwKpWnHEwjJ6NGNQhppjia8Vvc2nJeyk1s?=
 =?us-ascii?Q?gDby+KiAzG0Y3ZUN2WjHattj9uMgNRzEF2GrCZTBKhDTNL5H5At0KBDHQ3OT?=
 =?us-ascii?Q?2PNyou3BEYqVIA90Lo6JOBijGhq38XlpUev27bsEVXcqsTLkHBGZBTyxd7zH?=
 =?us-ascii?Q?ESAuuuQcFZZYDHssBjdvsddbcZrjIDJlhvfv7NAIEI00E5ruAhwmucmfm0Y3?=
 =?us-ascii?Q?4r0Ogab0VbGnyzT1yx0a3gHCSjgVhuvG1AB9vB6NFkHruM0QB/uR7uKbtfCt?=
 =?us-ascii?Q?d31iY1AYhpPxrIxMu8L/iCsjKaghGoaiJRufChCKssNAYrcPnqI5v91mBqsS?=
 =?us-ascii?Q?+IJvzdwKmRTFAi2IUMhxHbWP+BTYQ4ojycGF/nqejDEZFq7HbMNJsUcs+qgU?=
 =?us-ascii?Q?Cs953sJmJnnJzT5eQY55w2SMrveu6O1DNVYOrILOxn0khB20HlLm0ZQ6+eIK?=
 =?us-ascii?Q?05pR9+jnupoVZ1GQc/MLW25UP2GTw49qG/vg2CaLF9xdWaq5ShQQ0H7d58NO?=
 =?us-ascii?Q?XZwEp4WPt80fnuQdwG9I9RTT3OyzjhX5Z47eBPaOcsueM/QV1wCINQNfOyuO?=
 =?us-ascii?Q?PyrBgJWAReILlZaLLGeKDnrD9o+/eo1dES+5dk1NBwc7FqFj5CCJ5QvwbXVQ?=
 =?us-ascii?Q?W5ONnImgMtP6doI0ZbpApZ1HGKSlDoslhH4NK73qisWesf8ATunBkwU1jlrT?=
 =?us-ascii?Q?P2+9pXFqlOpdSFzt3h5H+TDD82pOCQWM/WYfXjd/7gh2ELU+I2nW4dy74FB0?=
 =?us-ascii?Q?l9zLmeuvU9a/9+zNgeFRcEAApODyCRD8bd6B84BbHyasUXJ8DU3W7/GLvYf6?=
 =?us-ascii?Q?m4494t/F+avSKsk6EuwCswPReNAWK349k9YlFFxc6IKRQTG1YryFbpkbMWGW?=
 =?us-ascii?Q?kXeFjo3yP1ixtDbRvEK9v+y+ThEL+TWfVg8UznW77i/2qJlnkchA/q7WKZW0?=
 =?us-ascii?Q?5e7JKPupsa0sTrZJeu1Kfr6gmrE+a1OBQbpdZykf13eVkTQeqNQ8WJv/rQt7?=
 =?us-ascii?Q?RsrWfp6TXX04SnVpwPQFS0LqFYTZzkskiEsHKU08OFKE1jqO20YX/vsUeQiN?=
 =?us-ascii?Q?Vh6E3UJzYdVIoOj8dicnVcmLVYMgOszBbNJ0oVHb0KbJl42X2ZL+1v2J1pdk?=
 =?us-ascii?Q?c7U/78oueYNLkuPuK/Y=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:3.214.204.181; CTRY:US; LANG:en;
 SCL:1; SRV:; IPV:CAL; SFV:NSPM; H:us-dlp.cloud-sec-av.com;
 PTR:us-dlp.cloud-sec-av.com; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(35042699022)(36860700013)(376014)(1800799024)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB7305
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 71885f39-75d4-4964-e948-08de26953583
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|376014|1800799024|36860700013|8096899003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wtgN9ZK4St8psE8Rv94uYGUpVcDUrPeleG7STgxwgA3d39CqirsxFzVlaA?=
 =?iso-8859-1?Q?UTxi8cuFcOVDPbF28EQ5EnuFkBGh90uUOXsyEbdh6821B2gPqePuzasGA3?=
 =?iso-8859-1?Q?/DC3PyHuHFaXEPQ6mokVY1fOh35I3Uf5lvGhB9RE7OdVgvt66Xa82W7kbT?=
 =?iso-8859-1?Q?MBKYAbyYsZmlmwSB/LjleWH9g4kFBP1PTlRvqXmeoP7S8ySDHo6OZttDl3?=
 =?iso-8859-1?Q?rzKpJF+m8HdHkdvVTHWulV7Bh6FpopInmIly9vtRmUY3CkWCo304SPIIqg?=
 =?iso-8859-1?Q?Dq9J/peJRhcQAwM1fQsUJnPouitxLOvdQnrqT6WehNAz3TxU0y4Wzkgs23?=
 =?iso-8859-1?Q?Sqr7ndRTbLR0ljWdOnvZffmHRznhvZuuojno9ctggnZCzPWDKjGGj1/tLd?=
 =?iso-8859-1?Q?xaMBr7xwTVqTJrXQHqElWHm+IAzqb5//z6XdKnifleb6CwRmtietnN5Ouv?=
 =?iso-8859-1?Q?iD4/1tSC9+Ryxz7E91Oqcn1/tOQAdWZ+p4KxkIlHZhol9tZdioF4rb20Ud?=
 =?iso-8859-1?Q?66O/D0ULQTEEt8EH6DiDD6Bl+gt0Q3JwnaDbVizQlpvwsSRVsSmotjPbyB?=
 =?iso-8859-1?Q?T1EpAlf1a5C1lEVgCHkzUm7YtdeSYzsJqeKcLVh8N7wJ3BHgzKtfNcS6Cz?=
 =?iso-8859-1?Q?dooAPLDcupSRe09L03qn1KosTRsktDbpeTwMQTOmrO+0E6KXiLw6JxjfOS?=
 =?iso-8859-1?Q?NfhkaB6XvIPPSmuVdYCW5RO1RKTgLcEKmqt1T++02R7aEayVV9N0SNk/Kq?=
 =?iso-8859-1?Q?bTGf6Lz9QdxDPGi42Gh6zbSGPF0vMEnj9/x6H5i94ElQrsr971DfUn/wXC?=
 =?iso-8859-1?Q?yiI41CIw/HxaqLjAH/trJjCjeqIBlkQe0e5GpFYqA8td2MgjlGghfLTzqK?=
 =?iso-8859-1?Q?OiVyPQQnjuigY1OFpZVo0PfommbCpvBANbz9QCquBJ3uzvNzOjIhbK+PXO?=
 =?iso-8859-1?Q?douh+alu3SiSD05MSnX7htuAGsNGUDTpOZ7BJAolNzFPlBUHAI8LhF3AGY?=
 =?iso-8859-1?Q?cTZSf2cSQLEriGrmWtyT4uJl3sd4zdigYOKbGOBQk94m7yP62hoIb54+EW?=
 =?iso-8859-1?Q?fr9Gvo2ZMYAmKJmoPku4n4YENRsQ/UER7ZJ/neFJAe1s+kfzTGKGZkFyWj?=
 =?iso-8859-1?Q?q+lRekCAOehM4SkqnAy48Fav/2z/aRCzTNAr7NLWZM09O2LSuJCIo4glST?=
 =?iso-8859-1?Q?DUhPP8wwY0qG5HkrtYbTZX0MLms+RttcVXLk3bE8yKM8he60FJUkj+sEW9?=
 =?iso-8859-1?Q?Q/4T1q9ZPaRBI+lRPJ6/73X+27vUXC/gmCk1BccFYVJr29oaZvqUouJxXH?=
 =?iso-8859-1?Q?62ePA7NVHGw8QBaISZGKIf3q4UsNOrazfhQpOCLGKf3wbLvZV8zv3GBnW2?=
 =?iso-8859-1?Q?+pBBHY08rllhDi3PBUasWlQyhK5LKTKukzwY4/OBOoaFX8fYeLgOOkV+kX?=
 =?iso-8859-1?Q?2lJx/TuGFaYgIXkDFKWGgFhvV06egpTJRt0X1DsCUIqnSJ6xtbD+dt5HcA?=
 =?iso-8859-1?Q?9BpYHN098z/3MP+udBg3LOUQHxXTEhpMiFUhbGR1Ni9wC5g9AmaRAi2XC5?=
 =?iso-8859-1?Q?b6bfTefTAypFLemr+D5fo+5ijzrpyjDcTo5iutYXOgA8N8AtqeC4HqFwmw?=
 =?iso-8859-1?Q?Dqjt7G7/6APaM=3D?=
X-Forefront-Antispam-Report: CIP:144.49.247.11; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com;
 PTR:address-144-49-247-11.dlp.protect.broadcom.com; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(376014)(1800799024)(36860700013)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: flex.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:25:49.4006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe341a5-76dd-48f9-0d31-08de269539f8
X-MS-Exchange-CrossTenant-Id: 3f0e69e0-eb38-4eb2-b4ee-52919719d31e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3f0e69e0-eb38-4eb2-b4ee-52919719d31e; Ip=[144.49.247.11];
 Helo=[smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR08MB7509
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,

I am using u-boot to boot a custom OS kernel image (in compressed Image for=
mat), instead of Linux.
This is currently done using the booti command using a dummy dtb file as th=
e fdt argument, since the kernel already contains an hardcoded dtb.

The initrd argument already allows the usage of "-" to leave it unspecified=
, so I tried to pass "-" also as the fdt argument, but then u-boot crashes =
since this case is not correctly handled and interprets it as a pointer to =
some memory.

I was wondering if there was any reason why the fdt parameter is required, =
and maybe if what I'm trying to do makes any sense.


Thank you,
Manuel Rota
Legal Disclaimer :---------------------------------------------------------=
------------ The information contained in this message may be privileged an=
d confidential. It is intended to be read only by the individual or entity =
to whom it is addressed or by their designee. If the reader of this message=
 is not the intended recipient, you are on notice that any distribution of =
this message, in any form, is strictly prohibited. If you have received thi=
s message in error, please immediately notify the sender and delete or dest=
roy any copy of this message!
