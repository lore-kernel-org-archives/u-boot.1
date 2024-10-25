Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5C9D10399
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB9088C3D;
	Fri, 25 Oct 2024 17:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hcltech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hcltech.com header.i=@hcltech.com header.b="hmOkCDz6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hcltech.com header.i=@hcltech.com header.b="hmOkCDz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6AE88C3D; Fri, 25 Oct 2024 16:12:42 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CE488FC5
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hcltech.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=santhoshkumar.janar@hcltech.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SHJrqgZeHnPrJTwhYkgzNWvTi+Sm0/0XGZ37eiDAQUz02XPCVOLscA39+591mXiiNiapSzRiYSjQ//eB631gJ6VdtvkqIDc+Rc8AalDwILzVt+zYakHQpsDPJdpfEXeCzH2TsUU+RV2vvi7LXVSeTI7CzBM9zWRYs6qeWIG4yomC8ERb1486WQnUJ7J5p6W3qoMCuwvr/UiPPw86KViWLfWdWbZQ4VPQvHluYk35+QUTH9xBRNuCUT5xXHSp0J6wR2K/2uXWOlfuWei1LO7sHK6SyJdTCye3SR9P3U9vv2NR40+yIQFO4OL2cdOJuXMgJUr7t/uQLaLJtZMH9vINIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blxYNfA/1ER8Ol80n5kT9FIZhsJdcJ78VYken5Y+aRA=;
 b=U9gYR8prV2Z2JVbnF1zZ5puDRziol5Nb2Yhw7dit8/feYZ8GGkYR0CmUtJxu/hzog6GEWvcxDcmy3x1NKkuy58rhyIUgcvHFAwNSFgiGVbKb+giUnBi2gN9C+v/h63/XZ7JdloTRlsuesA3p1co1uqM7npwZrfId2VzpTA5BJEIVqrIdCTP0Hmeq/ss7aOrbpA9TyBucZfrPaL2RO40GFZ8mhoGaE3JO6Jgz6gOMi6qa0wlKMO8JxK4f/jFCvPr5dFKn9F1HuuhFDl0vv0EsPjyawa4MC92v1XXBC/PGanZXs3zIofqLWL+THeByFYG+dYpSXT8QGdUagdIc+i0qMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 144.49.247.23) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=hcltech.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=hcltech.com;
 dkim=pass (signature was verified) header.d=hcltech.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=hcltech.com] dkim=[1,1,header.d=hcltech.com]
 dmarc=[1,1,header.from=hcltech.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcltech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blxYNfA/1ER8Ol80n5kT9FIZhsJdcJ78VYken5Y+aRA=;
 b=hmOkCDz6BGvf0AI83U57LkrV6G9CyxzALOszFJ3nsN/o/dUB3BXpWlsoV++7QpPLaQ2j4zJsESVFJqgWllTmerbz1Jx0nrZd4tCDKpbBYq9LZ1M8+3PM9MflZ2Hc30f+5b1sVKLPLS6GAEFcT3T/vesZtiWKq9/UWvOeK08AUKlmm6dgO4Yqq4zmCBIRJT4d7NqEHsCezvZRIs2c94ffd60X+hv4XqeACmYDI/Lxd/qDbGvEvTal6rJfJ+wSXfietFh9v5vT+Okt5f9dRLM7CGvUk8Q33SUHnq61GPRzfsrNOmD46UdlpUHfCmkKlJsAhedyWwfYJDtTDgmW17qZqA==
Received: from SI1PR02CA0042.apcprd02.prod.outlook.com (2603:1096:4:1f6::17)
 by TYZPR04MB6666.apcprd04.prod.outlook.com (2603:1096:400:337::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:12:24 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::c1) by SI1PR02CA0042.outlook.office365.com
 (2603:1096:4:1f6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Fri, 25 Oct 2024 14:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 144.49.247.23)
 smtp.mailfrom=hcltech.com; dkim=pass (signature was verified)
 header.d=hcltech.com;dmarc=pass action=none header.from=hcltech.com;
Received-SPF: Fail (protection.outlook.com: domain of hcltech.com does not
 designate 144.49.247.23 as permitted sender) receiver=protection.outlook.com; 
 client-ip=144.49.247.23; helo=mail.ds.dlp.protect.symantec.com;
Received: from mail.ds.dlp.protect.symantec.com (144.49.247.23) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:12:22 +0000
X-CFilter-Loop: Reflected
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbskXmwEaYyk1c7lgERyBhfVr8CPRgaZqt3kKiZEOXMvDKFZSqWGFSQTRZCkQJ6RxZdDe4KRYWQhXm9/LPgygzzf4dGQjbSbmRai8NeunS68/2PUsXPMJf+ihHWyQSuDhxULigjLCShbIo1pGaz0qic7+mNIFWGtXtpGN/eyNNfAyb6FMfdBClJVbU/hmxhB0jVGMkuWgR2K0HbwNMZEtVXy+cVvD6ccsdLPjATM5y354dq9LjvAExlbkxEJI7Tjl9DekskSrVXDa5AxurOt7T9h6pbhumXmGI+6Gp1y4Q15t9/Ag++DYGM2Sbu/oZWmxqSQMYVznnraIL4Z8EICOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blxYNfA/1ER8Ol80n5kT9FIZhsJdcJ78VYken5Y+aRA=;
 b=Ck6Jtj1luPBy+sqxobUllpJJ242NPLY/327tJnTCllN4XJDNW3GZh33FH0FgfDO0cHS7ZE2PRH28luRXji2jN/krR+9JhIoQTXjzjannec+m9+vh30Q4ySPSUG3ES5FpGgaTP5Q2C8luGZ805QBC5nNO2tLBnzNgnsneNvOpUGfXjifiicN28IH2j5eCaL4WU4OUXVi7b4U2e3kGaK8Cqh5tfC53tsE6xEQc7C8eWBVC0PBWK3Qyg3mRGaVeovdBWh2gZ/kZbDyrzCRsHuHn3FOrYR6AWxyoCwwrNOpazOZs/b+soWy5QJDV3G4T2VjIYKkFldDSBWlr63KBFfJw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcltech.com; dmarc=pass action=none header.from=hcltech.com;
 dkim=pass header.d=hcltech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcltech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blxYNfA/1ER8Ol80n5kT9FIZhsJdcJ78VYken5Y+aRA=;
 b=hmOkCDz6BGvf0AI83U57LkrV6G9CyxzALOszFJ3nsN/o/dUB3BXpWlsoV++7QpPLaQ2j4zJsESVFJqgWllTmerbz1Jx0nrZd4tCDKpbBYq9LZ1M8+3PM9MflZ2Hc30f+5b1sVKLPLS6GAEFcT3T/vesZtiWKq9/UWvOeK08AUKlmm6dgO4Yqq4zmCBIRJT4d7NqEHsCezvZRIs2c94ffd60X+hv4XqeACmYDI/Lxd/qDbGvEvTal6rJfJ+wSXfietFh9v5vT+Okt5f9dRLM7CGvUk8Q33SUHnq61GPRzfsrNOmD46UdlpUHfCmkKlJsAhedyWwfYJDtTDgmW17qZqA==
Received: from SI6PR04MB8663.apcprd04.prod.outlook.com (2603:1096:4:26f::7) by
 SI6PR04MB8284.apcprd04.prod.outlook.com (2603:1096:4:231::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.32; Fri, 25 Oct 2024 14:12:17 +0000
Received: from SI6PR04MB8663.apcprd04.prod.outlook.com
 ([fe80::783b:7a9a:c07e:8b80]) by SI6PR04MB8663.apcprd04.prod.outlook.com
 ([fe80::783b:7a9a:c07e:8b80%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 14:12:17 +0000
From: Santhosh Kumar Janardhanam <santhoshkumar.janar@hcltech.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Issue in probing QSPI flash in Cyclone V SOC
Thread-Topic: Issue in probing QSPI flash in Cyclone V SOC
Thread-Index: Adsm5bmMGmByuCJQRESjkGpAXXOAVw==
Date: Fri, 25 Oct 2024 14:12:17 +0000
Message-ID: <SI6PR04MB866386533BCFB2811EE892D0E44F2@SI6PR04MB8663.apcprd04.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcltech.com;
x-ms-traffictypediagnostic: SI6PR04MB8663:EE_|SI6PR04MB8284:EE_|SG2PEPF000B66CF:EE_|TYZPR04MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fe5c6e-6e0d-4f43-544f-08dcf4ff0bf1
X-DetectorID-Processed: 7a3ff160-c3d4-11eb-a2f1-967d7d39dbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?d2odFn1cNoLdNydfD7Kz4eGYtKQ8gM/2bUmP9ws0U6ydiG3S4Sf8zbeYInhW?=
 =?us-ascii?Q?MdZlv3WCjlvAhGmzEdYqWH9gT7I+xewzjDC33uJA1oW3dV6dNXW+vBnQFMgL?=
 =?us-ascii?Q?Xo3Yv7voIJ5MnRjP4X//3ptzed5r0sQ+MvicCsGZYb3nbt5aVCVRuh4TmUnc?=
 =?us-ascii?Q?f6fzfW3AMDcX51R0FUsNakIfm7TZZrCMoKocf3u/hcMT/uFPdTCoMEQcqWn+?=
 =?us-ascii?Q?FiQ11cM6eribdHLjagSYuDDBwgCRdy95HtWzWL1KXXZfx/NMSle/EMfV5JlZ?=
 =?us-ascii?Q?bB2ZOZgtcgFxRZGl1HHqTnHcrMt7b9gBwGzUQwAH6SsFOgB1JeUXXATUJhHq?=
 =?us-ascii?Q?+zjcqZBxW0YMcelWODqlYLGa/KXg8xnbMFnc20NeoHOSKhacCMinlJvtYQua?=
 =?us-ascii?Q?5gyi4IcuCm0qDsyMgcEVKskjnp96gd7kIAXJCD2I4l8mIvrJ1M4hVOXBYObn?=
 =?us-ascii?Q?xyFTEiVwwMdQP4AIW+1sqmkU1lXFswg2tKl18dZ0Ri0h2XPqDBA7uCIg/CWl?=
 =?us-ascii?Q?aDvxTMrlE86wPhR+fEANmR/XlohwjQ28+LVm9dD9hoMh4EdDWIZd398lkVK5?=
 =?us-ascii?Q?avRodU9y59ADZZyykRgr/mwbzU4KiBDqIlhaN3mJUdznwBmSmCRyfgt+eOXf?=
 =?us-ascii?Q?LbRL6AR0as0S4gcXSpv8YVvnS1Bcgtb3zo6marZIZm6QO0IKVGaT5sGv7Ear?=
 =?us-ascii?Q?30vnpMwWx/IH6/zqF6Ls2CZZzG/i8X2kv3vaNGCJH0joYhYCxNAdkeVe5TeL?=
 =?us-ascii?Q?3oD6dKcFe3iCFMPh3D1SKXEHll1IjrhFIzAvXXiOfTqXST1FDDRw4rJpx4HO?=
 =?us-ascii?Q?apntPh6qw2xDioQKZE1a7iGuJT6Uqw20aVsSkrM7i9rtEXhL5r1dP3UqS9VE?=
 =?us-ascii?Q?cof26e+EIc6mwd65eCT2x42aWEqlNbbl8XqFWhd3AHciqg6t5Mp9otsBBDY2?=
 =?us-ascii?Q?k+w/kCvpxxUABZxY4rXLcwjdelPVlxK9xEFI0I5sbfZhxOivB9n0JWyyw+P/?=
 =?us-ascii?Q?Dl34sP61LrXrPYWJjf9fUToRXALQhYCMrNPRMA6LJwo3K6QKIg6wJUeu8u6i?=
 =?us-ascii?Q?uH+cb8x7pbsaMxm/IJpqz9pQtjjCZjlY3vhHSjgbUjaK1TlghdkwVVzQN4lt?=
 =?us-ascii?Q?nhFJebaYLBUnWB+F45QfA6UDf0yD5/Y8WWa99+aa712uYKqtijcElV/ngiv1?=
 =?us-ascii?Q?AHXA0LEk0sKEcNx3ZVo7AVCN347PIRp3+692lFC6uTFIdpBD/FIKvtPMcsZf?=
 =?us-ascii?Q?+SCC74V/TBg/34/9fzC2r9YwZ7jHVfHr5ewhATzEkXM2HaHp10z23dBRRohL?=
 =?us-ascii?Q?9+n3ZSyhIQOmw/LbRJGUAK/R+5fOu4XFLwqEZIdFsY/BMQLhvTxo4zmX1aOG?=
 =?us-ascii?Q?TgMUuzs=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:SI6PR04MB8663.apcprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8284
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f5f2d37c-b388-49d0-a884-08dcf4ff082d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|376014|36860700013|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8QKSurrXNvX81qmg7Ak7Wg/5vIomsx5b1dRlv9WWCLTQyzg5msgBwuMem3gl?=
 =?us-ascii?Q?0Gsyon/PlUVpfeNiVwaJQNsKUfsNx27B7Za8e9CVBLyrGvNfNQVF5lb3W6LB?=
 =?us-ascii?Q?QZ9O045EQa1DEo4H43b44VWPXObmgm7naisNwb0L0yPZCKO7SFTD/NdKYu/Q?=
 =?us-ascii?Q?Mg1ykQWzTpGA6MT/QVNVJQvCh7286Zu/i0msJVjT3VKzpgWe2MqrCmLpoXrV?=
 =?us-ascii?Q?hlHPcwzkQsJXJwYrNEoawhC7Gt12ARx+dKic8Zn6irIAE8M+UeSAKilBYgbN?=
 =?us-ascii?Q?3DTHV9FySWg0WqBDHrudACB5OuhauRBETf+YiuuM+637H2JuFODJejkyVgVz?=
 =?us-ascii?Q?pvVMdGCNJiMu35EhAwFLxG9N5cTsE7f4nh4COSQ2Zcpww1z8LN5lrmqPQWBN?=
 =?us-ascii?Q?W+t5IqF6fh8qlRGV0Z6Wv9AWp8foPg2iE0rfVVBR0n6XU/z9/CEILMjG5oca?=
 =?us-ascii?Q?b3/81jTgk4z5rczs2/lXXccmSppWUCbDfEQmS4vBcn5Py4rVsuQVMkwtJb/x?=
 =?us-ascii?Q?8htjZWxXN+2GkRddd3ftVzLz1UWLjINVTiZAGvUmxC7IsTSskkty+Lu4GV0j?=
 =?us-ascii?Q?OHdw7zf+EAiU2V0TvPRrsqs2dCjP6AZ8nYn/l1vOzb0vV6SO/qiTKuv7RNcz?=
 =?us-ascii?Q?eYrkXiRbtH0MMolEnZRWw6cWCZoNp03hzdW37SDIqU4pHUZ9+jFy7WefE6l5?=
 =?us-ascii?Q?uMq6Qfi/Lf0Q5MRA7m7r3oG7X+iAbanYpRSUJJsZ6E3XergTuYTLc0A/WuQ6?=
 =?us-ascii?Q?/2Fexlsmj+nAbq70+hQijki5PfAJ1bbdnJJZQCgj4laFEm6M9tW82QeFPwX+?=
 =?us-ascii?Q?ajQ94CoVmznlwq8/mxHyitvq6QtXqWpLNDia1PdLJSkkScPbUiZF12zCSs1M?=
 =?us-ascii?Q?seCVUlnIN/1PkQ1RScufbIOp5Xkae19uLSSi9rHCxi1w4MsuUilqSAAvGjbb?=
 =?us-ascii?Q?XL7E9v0aPi5PgSjL55ZEv7lbHukYEnSAQZKMhnkygpkCg+0cON78dYY24jJ3?=
 =?us-ascii?Q?6ZwEhsotzW745ud88hKXLSmWhR57WZr6HgjT1jcs+1RsxtKaxdrFxf+QWb2p?=
 =?us-ascii?Q?G2qr0PYrbZeGnH7ANSqtHtSInqm26zBgicghNWDLfNDxfpfU69WkT2z+lRUA?=
 =?us-ascii?Q?U/hWmuun6Dt7fIA95WEwkkZ1KgmZhxS+uYYmCPL58eKhO74v6HUlSrofOip4?=
 =?us-ascii?Q?QVYX+j0rBvs2OHUuEZrjP+uVv2qFVF4CDMW2QtUuBteOr9+XMM39g8Sw+hxC?=
 =?us-ascii?Q?M1e53iRWbhUlVkdQ84HUej7rlGXfylQ1nJhBsn1N8kr+5UpLfMfq8ulbtTND?=
 =?us-ascii?Q?Lks/g5wGVcIrvdA87PY6CrcH6OpU56GrpgSPoQS2XbasM/vEzCKwLxnSnyx8?=
 =?us-ascii?Q?GoUGN4lcxx8zXU0LPB4bIbfK056zzk9U/EelwQGauYYiTTcd+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:144.49.247.23; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.ds.dlp.protect.symantec.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(376014)(36860700013)(1800799024)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: hcltech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:12:22.3658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fe5c6e-6e0d-4f43-544f-08dcf4ff0bf1
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912; Ip=[144.49.247.23];
 Helo=[mail.ds.dlp.protect.symantec.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6666
X-Mailman-Approved-At: Fri, 25 Oct 2024 17:27:53 +0200
Content-Type: text/plain; charset="us-ascii"
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

Hi All,
we are testing QSPI flash in Cyclone V custom board. The QSPI pins used are=
 same like cyclone V sockit board.we are using uboot 2024.01
when we do sf probe, we got the below error. we have verified the pin mux c=
onfiguration and also enabled the clock.

=3D> sf probe 0:0
jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
Failed to initialize SPI flash at 0:0 (error -2)

The DTS file contains the following entries

&qspi {
              status =3D "okay";

              flash: flash@0 {
                             #address-cells =3D <1>;
                             #size-cells =3D <1>;
                             compatible =3D "n25q256a";
                             reg =3D <0>;
                             spi-max-frequency =3D <100000000>;

                             m25p,fast-read;
                             cdns,page-size =3D <256>;
                             cdns,block-size =3D <16>;
                             cdns,read-delay =3D <4>;
                             cdns,tshsl-ns =3D <50>;
                             cdns,tsd2d-ns =3D <50>;
                             cdns,tchsh-ns =3D <4>;
                             cdns,tslch-ns =3D <4>;
              };
};
The flash chip is connected in bus 0 and chipselect 0.
As anyone faced this issue earlier in uboot with cyclone V? can anyone guid=
e what needs to be done to make sf probe working?

Regards,
Santhosh
::DISCLAIMER::
________________________________
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only. E-mail transmission is not guaranteed=
 to be secure or error-free as information could be intercepted, corrupted,=
 lost, destroyed, arrive late or incomplete, or may contain viruses in tran=
smission. The e mail and its contents (with or without referred errors) sha=
ll therefore not attach any liability on the originator or HCL or its affil=
iates. Views or opinions, if any, presented in this email are solely those =
of the author and may not necessarily reflect the views or opinions of HCL =
or its affiliates. Any form of reproduction, dissemination, copying, disclo=
sure, modification, distribution and / or publication of this message witho=
ut the prior written consent of authorized representative of HCL is strictl=
y prohibited. If you have received this email in error please delete it and=
 notify the sender immediately. Before opening any email and/or attachments=
, please check them for viruses and other defects.
________________________________
