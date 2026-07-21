Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2517DC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC8BC607E3;
	Tue, 21 Jul 2026 06:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J7hPpMMU4y2I; Tue, 21 Jul 2026 06:31:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4AD6607DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784615473;
	bh=UjR7oTX/KkdksEWDSiZesHFzNkvmeUx44djUiBeN7UM=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DHw2qPalXoXYzMiv0GvvHSQd5hcvzELrA9BfGp7KYgJaubN0kW7PNDBWgmmoLuGTu
	 FWjaF3ewThmTsBzCByXl6FaQcHG6Mts8un9BkjoU0mfu+y/ZXzpbRepIZDxanq9y19
	 uRuAFPpdYllp6Nvkn1Of0efKR2UMCCy4SR+heAo0EO07n/fHtbdWfYWXDIrtmnhcn5
	 VRtGqbETKtV5wSzF2huJpgk8UOpIEbmRMB46411yLNSNzpA4FbkCXqdGrTb/2u/tPR
	 r944uXk03Z9C8eEdOc0cmLEHcNrJDKGY8wVjUg7mW8gkAmlmpWkJjc6Be44LvRDZid
	 5eOTeRhAZgW8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4AD6607DC;
	Tue, 21 Jul 2026 06:31:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB622EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8DCE400DB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UrPHtjoofhmK for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:31:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 87FEC400C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87FEC400C2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87FEC400C2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:31:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8984659; Tue, 21 Jul 2026 08:31:08 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D5E803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:31:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bni2ArBPGA5Y8qwlh6XkALUxdJKDxN8huJ5OcB0MbVbxrPwxKlxfwy46YXf2LCGgHcvE5vLECpgt4KETaUOxabizacXqZiDgIS28I5Bd6lGU2mJ+R0R2n137Q4HZpwwi/k9MJ3T47g5es6ONxDZsXEtJDh5knBqNODvZ5AMCmL24pvSwqWe9nYMVPipM7vHG7JHLbRoOLDN00IGtDFsOrUgbda8jsxlaI9zuwc0woeWvjCXao7ypEBM1fNYvDgby7uKTpCDuiB6DUD9ihOFt0DKXUcms1rYDyxzs6UIV2dyrPYd1VltrtIK+bWMatZreXx3hcq9dJz4mLd8n1H+WWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjR7oTX/KkdksEWDSiZesHFzNkvmeUx44djUiBeN7UM=;
 b=SbjtQB2/WHGXqOBbtCMGMK3RenipvlyEM5SxJWLK396tkhl1PzKzTbJ52Qr7/79TROA+OEvN+qBVX9rPkr/TinYZu+WKehCAaloHxYTfmxCjB5392IaJTjSfEPs1hppwi3juk9pbivQNvDnMYVsO3IU3rkdSXWOcuM0eTLEol9MA93Hj04K+hm7cp2e7KKMBf/YcnlByp62hSbDMmPsgNFKx2UlhuorAYbMYxM3I/WJ+fRKa+h9uP+v/9U6LilA+6DjE58ylAr1jFAxoDeDJYOuYQ7Lqu0rVu2DSwe4tazsCZ4EQJG5giUHN+BHamZRPo/2Upj7ML6nGVVTj9H6a3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BLAPR03MB5508.namprd03.prod.outlook.com (2603:10b6:208:290::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 06:31:02 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:31:02 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2] arm: socfpga: Ensure FPGA in user mode before enabling the
 bridges
Date: Tue, 21 Jul 2026 14:30:50 +0800
Message-Id: <20260721063050.18756-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260304034354.2871-1-dinesh.maniyam@altera.com>
References: <20260304034354.2871-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BLAPR03MB5508:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d310a11-0235-4a94-b9fa-08dee6f1a25d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0doH6kRUiEzy2LZ8z+93lklNjlVDTNs+LYhtIzd6uZENBhE3zUfvqIGdeiBRHY0MM9cq8IN3w3WGQkgQNY5V3hBnNlgK23wygOxF/Kycp2ddqstjoYtwxTyPMpVGbXOPAjTBrDK+qucdMa3vJPNH2mN2JmW/nKhiMdWaz7klUwKUM9rqRY4AAQwjIZ2zIJZiw21SvMEubaX27riusCYtNYqbDjn2ELAoyRWCtjc0QFF7pnkAn6YFh1208BNEAjEAWM4vq2zJqb+jqNafRqi5pl+Cua97WgF9QJKua9f8a+O8f0ld0NjntxxNazUjCasTUPLsDOfKwZlB9ODqfsyaW0nD+KwECDaenmQjvS2T9Pu1XdkfIGybI/TBJsjLLtdhCO9AsDcMDRx2OyC7s/BOavcGTsNJDNSMQ1rxuWhSQvx7JWjPnC2x/RoXJsXTnGbHcMtl4IkMldDsC3UQ3AL3Z2CbdAGUXw+Jg/tkB15yDZGsddrTALO5oNKgl3v7eVQ8ovbIHtgHuloF5YWltRX09Oeup9z8Nhrv9fziVXPOW8VOqQsJV0qJmwtmLbyGiGtxyz0MoWK/ru4S1ipHL6LSINOwPM9fT6K5BSSp1XpAikhREiOdX61V0RXL3OhbYTMyH2g3UuGQMi9OV5db4TeRkNHPMeMYq5sG2xWA3b6jSJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CHzSOimk9zmzmoyXmEdCsrfbNrcKDi/LpZuVKy2wWvksza2ZCYse+VlozBtu?=
 =?us-ascii?Q?SeIg+J1jiANgNdAqCfreUYKmQWG1GF6D8QkHRnU6Md3Ipnv28Ns8BFl5lWm9?=
 =?us-ascii?Q?EdEg/m4On+73gWmVCV/0B+j7I/saFn8QX+mtuwvAdTTtJXQbe3fysB+bGTpg?=
 =?us-ascii?Q?MKniKm093PDStUfvzdomlqk8hf594wkFGgRhcYPW3aGcsByWMn6NwExu3IA2?=
 =?us-ascii?Q?ME4+KOkoBHdv5yZoOvOEEC+i9z4Wc/S8Vygg63+f40aTiwQQ/XSlYKdNX1uu?=
 =?us-ascii?Q?YwkE/6PV/ripkUCXGa//la4haIqiCapACoSURX95wxplZfKMoinirsSm9Xy/?=
 =?us-ascii?Q?fRg3WyQHnRBTe/6zT8EnL9WAotxhErUOTIop1HGCo/T3CNf8f+14ZrgnM4WB?=
 =?us-ascii?Q?WX9YUYSyPUqPei+UYIE5hHAUvBi0Ja9rMuI99UC1PB5erf3Tfwf59rmowjoL?=
 =?us-ascii?Q?YfXraaChe2cKs5psxWqhDzduotWyyh3mN/xKT5SyDTFbJv2m+h9Xr1Hx6WPw?=
 =?us-ascii?Q?GbYPc3CcyygS5IVuaKAvik6bXEYxKsESjvP3z024+0oTexJvb2cs/MZwbQzB?=
 =?us-ascii?Q?gm5tN2S8hHUVfgS55pkWa8DVkVmd62tisbMvGpCyVjMIB0BgfCbua8dMEIJj?=
 =?us-ascii?Q?57Bb8Jtgfx4FsAZSFf3g0W5KluzXfTRgOuENIBGWB7iuad63B9SvQ5F6ryiD?=
 =?us-ascii?Q?IEjCZEXScJLvZaEnck72nWZVs36rCBbyX0hiGaCxHAcaavdgevaXzZ45vHJr?=
 =?us-ascii?Q?KozFxdn6qLtvNhChF3qrPzwqONCjM/yePgI/u8jhEnmVq8XDAvNaeApUlHSt?=
 =?us-ascii?Q?PbLMOofX0fphAPrmVKhNJs4R8b0cPjQN3AORiEtW/nSAFX34bvqvAc/wc/IA?=
 =?us-ascii?Q?QQnUXZtGVu/5E79cu8N2RJUDUU5jc2PHA+RdpMZ06cGzUAAippvRetWCKC/p?=
 =?us-ascii?Q?Q2gY20jgt/kHjIjIhBpoFBQS0dcVKSsmTrk6+ugeCmLh+3rjBBxzhFd5NZ/3?=
 =?us-ascii?Q?IGYbwgbiczCoGsDCsATsqZhHoAlwcuRzAUGqN5Lo8s1ZQpH9r/FmskWEyUwy?=
 =?us-ascii?Q?nHjkChi8bNElqL6CWTOhqiYgYIGz8KItcGMgdylu4LRdR6dV+xH9MYT5zeVw?=
 =?us-ascii?Q?1j0eamkju/orXz8fsU/y1p05H1rLxKYvP14ZrjMAx+IY7t5cxKPa8I52GZ9k?=
 =?us-ascii?Q?6ijfwwbAHKe9foWC3gVk+kI1eW39IIPQU95M+EwtRKEgah3NGM30whg07qUg?=
 =?us-ascii?Q?sC34jMHFpWcwKV5Guz3a2orulcjrJWfYfHFvD38HEf8S2lEFPwugvF96Fpkm?=
 =?us-ascii?Q?qnEn7FSzu3TQWFBCSciUOfKDdZt9We03eB4tWZM1u9s7nVZkkkq2kQCykAiw?=
 =?us-ascii?Q?bnOwcx/XnIE5qlsjM1H/8u5dxmzOlaFmh37fAudU74QFBr7IXDpYZPwkeNc7?=
 =?us-ascii?Q?yqzC64if7+AjFinsH8nqVcQj8z+uVZpDcdXYUTnZD4cX+sJtipPALfwmbRUS?=
 =?us-ascii?Q?5cuvfQvIXBIZJGqSvEDNolEIkYFXgiC/xQTEbXlS0ukLJ62R0ed4XkKLb2Ry?=
 =?us-ascii?Q?sdcY4lZlmbEfqWXkDRhePHTMNW37qt8kQA0ZLSMjboKRFqi14rGNvGYyPiEs?=
 =?us-ascii?Q?51PlT3CUJepOys3DfQ/ziJRdD3nDa510GMpOlUx9hWGjBDf5+PAetj56knnK?=
 =?us-ascii?Q?c/xKGECVCykiHK4gtueE3J/Z8bQL0epg9N6KYOZAOKritNLB9iS42AlboO48?=
 =?us-ascii?Q?zHD7J6IHyA1cxYrhIOsGzjIbMH2XccI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d310a11-0235-4a94-b9fa-08dee6f1a25d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:31:02.1974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jPdfRvpSHTW/B+jop4gDfKxIM1G6+zJENlmwG414DMrWfbGnasuZU4fHUSWF3T0QSLG8GcvAT2owigsXTpkRNUVwd6z1axceFoQclypAqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5508
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjR7oTX/KkdksEWDSiZesHFzNkvmeUx44djUiBeN7UM=;
 b=gcdzElnBJLR8+EEkn0XnSxVH1oPJoDIFfMVrTX4NRqcoBpOr0OvpSK7dWcHE9LDBXr3PUQ+dyLOwj0P7yWq3GNheQi6XnsQUaptZt3Wn+jw3UcmYr4WWTK9Q+ZhCklor+/Ve2BA9P0I7nsDlkGL5nc/b2sSWhwnwnv0+FIhBMdAMaAO8xBiUIoMTbNkOCurq64Mwj29lcR6nFX0bSlzYSFkqpkyff3VU/beUcOv89IuS0T7LEOGZy1Ctt++p3YPdWskWPSk4Hrs27GOLKCj1zpBFNCLiOwSCVk3gU0poc+dm9W227aJDqqqFONMPN9UZGVKxgtNwWbTOnYPIkuonZw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=gcdzElnB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="gcdzElnB"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: dinesh.maniyam@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Unexpected behavior and error can occur if FPGA is accessed in unknown
state. Always checking with FPGA in user mode is required to ensure
system stability.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
Changes in v2:
- Mark unused mask argument __maybe_unused
- Use a single puts() for the error message

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/patch/20260304034354.2871-1-dinesh.maniyam@altera.com/

 arch/arm/mach-socfpga/misc_arria10.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 7e0f3875b7c..4ed727b6c2e 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -13,6 +13,7 @@
 #include <ns16550.h>
 #include <spi_flash.h>
 #include <watchdog.h>
+#include <asm/arch/fpga_manager.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/reset_manager.h>
@@ -124,12 +125,17 @@ int print_cpuinfo(void)
 }
 #endif
 
-void do_bridge_reset(int enable, unsigned int mask)
+void do_bridge_reset(int enable, unsigned int mask __maybe_unused)
 {
-	if (enable)
-		socfpga_reset_deassert_bridges_handoff();
-	else
+	if (enable) {
+		if (is_fpgamgr_user_mode()) {
+			socfpga_reset_deassert_bridges_handoff();
+		} else {
+			puts("Bridges: failed to enable because FPGA is not in user mode\n");
+		}
+	} else {
 		socfpga_bridges_reset();
+	}
 }
 
 /*
-- 
2.43.7

