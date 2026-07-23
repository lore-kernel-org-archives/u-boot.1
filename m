Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED79C531D0
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 21:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7992281024;
	Thu, 23 Jul 2026 21:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYYE41alWcP9; Thu, 23 Jul 2026 21:04:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86EA28109F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784840697;
	bh=8GdUPQrLJxusW7bn9UlVtWDWI+I99rUl02tb3rMjsfs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1b2Q/Jp6Zqf9gAsQmB0+gXKqUtGlO34P95G2w+XvGBTs8bwlEDFwYAqqUuiZ3otZ
	 5E00dBnxVG4gtW1aEMkbf2/bpYdKUSfFWvH/yxeeVVxWIHQaz29IsInhigSyNiFT84
	 /4CwNCvFc1ab8zZHBZ+ClnQJEYYWvGtkfCeW7xMyW9LHxSuNveg+Z6uIWVm7f1RrQT
	 yoOKceHRfvfOY/w4TgKM8dvjY52qzU3Dlj/1fQ8+Qiklr1WYVJzpMJmC7SRbYqUOVz
	 NmggBFq0v6XHQCJRS6qaBPzPyPs9NHaWkpWAQkLPZfniwk0fqai+z8TzaYJJhHCvO8
	 RgImispy9/7gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86EA28109F;
	Thu, 23 Jul 2026 21:04:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CBC6642A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AECDC60AD4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ozpsIN5bEPbm for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 20:41:15 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=thinh.nguyen@synopsys.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E42A460AA5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E42A460AA5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E42A460AA5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:41:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A337E80287; Thu, 23 Jul 2026 22:41:10 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D67A800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 22:41:06 +0200 (CEST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIoSeU892208; Thu, 23 Jul 2026 13:40:53 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4fkdt0xd3g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2026 13:40:52 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 87608401AA;
 Thu, 23 Jul 2026 20:40:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com
 [10.202.1.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 04048A0070;
 Thu, 23 Jul 2026 20:40:50 +0000 (UTC)
Received: from BL0PR07CU001.outbound.protection.outlook.com
 (mail-bl0pr07cu00100.outbound.protection.outlook.com [40.93.4.0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert SHA2 Secure Server CA" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 200E240081;
 Thu, 23 Jul 2026 20:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIINg/2rxK7Yz+7pp1A9ONK1lg0Jb/bkXkpCwKSspX6sqr08xfhh18HCu40ZdjHLkISueygqfN6Elu8VMPswXkTpm23xzAzhdpHS5PuCuOor4iA/nb9JJyZj0BFAPZr33BGbs/6aCDhCdZU5v249B76VTXW9kJZwPvRl8TMz++PYT+6f4HRMHqF6A4QsefiHheadwi4mX6Osegp8C5LoZSX5lLxLRoO82UdxOkPI0Q60JMClSX66IhGYvKJKhZcVV0fTYGQ8MkbpakaRrEs1LAmlAApA1o83kau+70hFEYZeWI3N9QufGPNrzEX4K7cP5AMksK9MvthyH77NH69qyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GdUPQrLJxusW7bn9UlVtWDWI+I99rUl02tb3rMjsfs=;
 b=jIpPn3VEJ7fYAW7jw1QxnwpMujz3ZpSd66G3DGyPRer9Jhv4k1yQs8FF9E92isBthAsfSlSZRlDmh/kmAe9cjaxVdf5p1HK2WPTXf4kXnFmqtjrQmRnR0MZt5V2BcrW2qN587jV1cYHPd/tNzqEQEXGDO89KAfRtEifFelkacZNCCeq8oCUTOpOsch7QDJWBqn2JnvJw8LHtPm1vaD0oS6XoB1G/PTZAnMeG8iVi41OvOwWJ2pr/cp0yHneAzQNrpEfkuGhvsLKAvJiC0xmEFAFqwzco3aBxt5Bame1ANXi9ZPV1s61n5zIMYQwy7WhUfz8ez+aHEvlDJrkKz/L4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:40:43 +0000
Received: from SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7]) by SJ0PR12MB7473.namprd12.prod.outlook.com
 ([fe80::fd38:a665:ba4:95d7%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 20:40:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
Thread-Topic: [PATCH v2 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
Thread-Index: AQHdD898FKL42/ZQgU2wYMxfQiq8drZ7HfCAgACJfwA=
Date: Thu, 23 Jul 2026 20:40:43 +0000
Message-ID: <amJwynjvYTMyL5dA@vbox>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
 <3f9ff728be6806066dd5d5e69d4e177666b46252.1783620779.git.Thinh.Nguyen@synopsys.com>
 <87h5lp99fw.fsf@kernel.org>
In-Reply-To: <87h5lp99fw.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB7473:EE_|DM4PR12MB8572:EE_
x-ms-office365-filtering-correlation-id: 9e2dfe12-d9d5-43d0-e83b-08dee8faaac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|38070700021|10067099003|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: eTfeHpXizQacfFZmV351jMrmPxUENbZUwhS5J4m2UMpADTVqi2LdK2f4zxZy3UCWF1bz7Lwwg/xN41hx2hT2sg6UFlh4y0KzJcuLcc77glaKtQ0QR18k+aAPqVvFjkB2Z4Vyey/di9QqKh2VDLGlRKbgkXxC2ZnB+RZa+t1TbKV4YufFltCS/EZQprxNjxfdwEt25hnx6xLCSSkEDuh3z0p6vjm0gSXomtPK4Vn1sLBhBjh4nNdv2YN1T2LLldOJ9RphvKcHELpU++Dbx5E82fl1w4fWfB3b7PDTEsnE4gG/CyV4ocCmgYXuPAVxIwthXDTRGjPQAPV+iEDxfjbjW/6CoaJFMlIYM90ZuXxk3oO1XzKuTSVDP//xe46UawMkFCKrHaRu9SN7LKJrfVVNa+1EX1hXkWITjH7/8tDUQJPIsfSVoth7lNYQ2HCOcQ9befscQlIItVL4dNZuO34p08sXD6BMb8Lj9x25nC4QPebVsxKw6Fmjx3jHbpQdRQLdo0t2wugtMsgALMqXZbNvMIHnrpBqv+yVz2nGHV+RjxC3q67Au4jC+1HyIcSXYQUyO4/WNSY5fhn21ECBqe8/b6ci2CVE3N10t1aZ2LCO/Y3I3ZJQFhXvdbcYygvHLqq4JDFB9ye9eQYy+7QrV14rhvbJ6wAsm62VNS64l9Pso+26X402Dogkv6ywawnuIRS+/vynhigcHTppi2sxBkDGJwr3SGhXBXuWnnoK7XxegTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzJqTEtrTVBVczVjVWp2ZUc5Sy8wVjJLNkJEdU50SE8xR29LeUs4dWpVOVNm?=
 =?utf-8?B?Vk92dXdqYVRaZGNwendzVi9vc0R2RDdUUHQrSGJYQ1JScGNaN2dqYlpTOVNV?=
 =?utf-8?B?V1l0Zy9IeDcxMEY1bUNweG5icWhvMXBES09mb3liR1JvMk1KZGFsZ3Y0NnRH?=
 =?utf-8?B?ZXhvMkV2OEtrUXZsZGcwUk8xRGtIb3IzaTM1d09YNlE0blVWWWdmUW1SVGdF?=
 =?utf-8?B?bCsvQnJrK3VnNSt1TS9JdlU4c3hNSEU3bTI2RGhwWUR4VS8xWkdLNTNJSGN6?=
 =?utf-8?B?ejV0LzFjS0xudjZWTzB6eHhLNVkzRkljcmN0NCtSU0RtLy9veGhBYkdZbjln?=
 =?utf-8?B?U2tzVWJwZTNwbi9qM0FDbnJOQWhLM2tnc202Mm9OOUlHSVU0Y1JPSFRrQW43?=
 =?utf-8?B?NmFhSHdaeFY0NW1YQWtxUHFWZHROSFA5NlJBNWZKVkVQUVloaEZQYjZ4ZXp4?=
 =?utf-8?B?N2o0YlIvZVE0QVNXdUVvdmJ0b1JhS0prL3hqdEJPRW0raExGOEtoUDh5bDdS?=
 =?utf-8?B?TFBwc0FOV2VTeE9JcHptQ25DMjUrQ2FHWlcvKzk5anlsWVMyYk1ib0ZaRnNt?=
 =?utf-8?B?K1JwSTArUWUrazBlbzhyUlZlK1FHODdFSXBwMzVyN3VPeXdxY29KZldGWm1R?=
 =?utf-8?B?Zlk2UHNVb3d1T0dPRE5UeE11b3dWS2VIVERacSs0Vkt5ZEQ2emZJV0NaMjNT?=
 =?utf-8?B?MmVqS3VVNTlCWG1EUEh0elpxVklJRUdLVlFwWHh3VkRHT0p6M1FkYll5Z1Z5?=
 =?utf-8?B?c1BnckhDMUdNd004M0VjRmhPUVlCTkZ3RXpoc1hNTlhySTJkbXYySExxVWhE?=
 =?utf-8?B?WHFWWGZhNXVQMnpoVjhKeXh4eWFXTERURkxsbkp3N1pudzFqYW1zVUhXaGpr?=
 =?utf-8?B?TDdwemdQSWlTV0YrN21GYmN2NjdoT2lIcW9kZ2dQdlJ6akdmcUs1Mk9FeU5Y?=
 =?utf-8?B?eTRUMXBvNWRZWlBWMGhOZGlEK0V0ZGY3U2I1cURjYnFDa3ExK1p3K3FnajF5?=
 =?utf-8?B?dkRmc3VkN1psNTNHY2ZEZDlxT0puNXdiQXZwQjF6cXlGUkI3b2JLc3FoY2J6?=
 =?utf-8?B?VVZjN1VZanBQWnY0dTgvU1RZUFFCZ0VqRThzc2c1U1I2S1pzQ2t6UE9ORXFN?=
 =?utf-8?B?QkNOM1QxdzdTeWxuWXhhbUhTWXgyR0tvVEdIMlRiUGZUNW5SUzNiYkgvemRP?=
 =?utf-8?B?aTNGTGY2alRIWVF5MDNEMDJJcTZCYlFKajVzeTZwSndYenRGa25LVVUyNVRB?=
 =?utf-8?B?VjZBZTkrV3pDZjlvYjBscVllb21pM0FpeHp1aHlJdmpEaDFEakNwMnpieW1Q?=
 =?utf-8?B?VHRKV1dEb2dXNlFFU0NCVkdaY2RJSER5S2lCT0lrMXhERm53S2lZdHM3MjM5?=
 =?utf-8?B?aSthTkJxZDRYck1MRGg3c2xYbXFIUnZNZjJIQm81T3dwbXpZZm82eUNGM3RU?=
 =?utf-8?B?SFk4T2hCTjZnVGJMWmJyRjFFY0hDT1FDVC93ei9aVklVbXRsQUJXai9XRFlO?=
 =?utf-8?B?dDBiVGRGaDZCM3hMeng0OFdkTHBzejJmZ1F1WGNxVEg4OHUvZ1IxQjE3Uksr?=
 =?utf-8?B?VHo4QzFML0ovY1BmbDFZakx6QUJuNlpIMFN3TnlqYWcvVi9zeStDN1JjWlM1?=
 =?utf-8?B?Q2xlV1lNcUwrN0tyTUMrZHFoUEFhZ2VkNzFvaWhuS3p6enZVMm9RanJrNjQ4?=
 =?utf-8?B?YUVaWmFKc0dWY2pPdWw4aE9GQ3Jwa1NidTBtcGdHRlp3SitTSmNENE1mYVhT?=
 =?utf-8?B?R3FTb3ZuUHpqWmdoaHpnUnBxM3V4NFA0aDd3em1RVmZRRnV2dXpEbEZsbkQx?=
 =?utf-8?B?TDFPcWgxK0Y1M1R2Uzd1bjVYQXVoWEh5dDZvbktWUFBUT29MRURlMUpIdzEx?=
 =?utf-8?B?SU1VeDIxci96Z1Fod3lsUnRjVFk4dG1WVFNwVFM1QW9tN1d5STZILytCQ3dH?=
 =?utf-8?B?Zm5jb0JwVGwyVVRjSm9IZUVVLzA1U1hlM0hWNUJ3U0h5RW5iemtMclJXUG85?=
 =?utf-8?B?V3NOb2o1Z2hOdkpMSmtMejAvUzJWeXFYYTlkOVdGWUcwNkg2dm1vVlJndlVj?=
 =?utf-8?B?a3VORUIzd3N1TGpGQWFzYjFiTnBaV1ZHSjh0Q1AxRVlZRDlCUE1xZ3RROUFw?=
 =?utf-8?B?V1hVaWRnMnU4eE5EOVVFVzE1QTdtRVZYN0lWUzdyYW1PQW9QbUV4SFF2L0xo?=
 =?utf-8?B?Skl1QnFRbGQrbXVYZXY2dTgwbDMwUmlIZzZGcmdNaGdLbVY0OTJ2R1V6eVJn?=
 =?utf-8?B?MHJqTWZGR1lkbGRxRkFZaUlaYVhXRnh1TUQyaGF4UE91d1pwNDd6elZLR04v?=
 =?utf-8?B?bXd3RE1yMGFHSnc2OU5CMTRRR2NKcjZmNjZNTi84THVzcWNNanFZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60BD4A12B3A6DE479B2DCF289A7F79E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JZ2X0mlOUqEVozcuAAZZ2gTg97s/75nkmgoEv7DlJkd6I8OsQXreNRlj5g/VaIzhiiHYNpd2xRIAAppIAdE+/4Wcdz3eP/nlN0If+o7dkeCV3DYxWLutIgk5yRAvFr7E3Ho0OBQruU48lF2PTyvqHIgmGpqIsZtBZIiudsNH2JYIwtBfGdypQpjVeoCryJHpadybf1Zuo7/4+m5gtMeXMR1YyVW/U42JcO7tikdKUPSs+DYemjLivBY9W7d6cdwQ60OZlM7EeEF3CgB4KRYUyGFfiZ0Tbzgt7tMwyC8nvcJ7oxOYpcqKefXhaRKJQKzIBrDLsY24I008UBH0E5xFjQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L1wea9+Vs8OGODjS99VQLwRgHHKwcThPlgV5MkR9kUgysyjCmK6HO/vSdcMZhGUwoPcIAf2+EiIS6x2knj2YMIIj+PbnzGCxRHy8qTyhHlfYxPvpY6pn+B4DCvxlXt0cB5bUQLgg3cwtSqqKhmqob+XSRsCcCmorNTVHRqAISZ55tUe0GGMpaKRSt4WOzMSZggYl6jgHZPShCcMz9S5C/+JcEjzAEVeRgYD0GH3W9J0Yr9mpRQ7dSAXXHF0+1kVxl8I9E+hoslnfLARP4IRU6XMV3FSZeG/CuvJ11pyU8oyAcPmEDVETdGd0z+WbSROCLJ3K5ym020ZdjKgbU6e4z12pQWytiBwv548QTBPpm/J2BZu/ylrZeWh3Olw2UwvyP2Zk+0cYPRfzlercjFo99osXqTMfGmXA+LZQMjV6tbhzn46CHzKe1w9Lg1NB21sTzMt+Uu8rXJ61n6zn97MpMKOr+K0+AkJLUHC9DZp2Vb1PqSsoWE6WjHT0L8k65pVFKHqDJRbdEpBxCeyhdofvKoGtVv+EmdH0W9jOU5hXznzm/C2L9qPWCSxu0NELiKGXWjskrie8gLuvI8kRS8oVMindP6qgCkfIacEY1UVT2FH8x5lZvzZEgbQ4WIJYXpZrclfJAOvS09sLE/K9hOjGRw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2dfe12-d9d5-43d0-e83b-08dee8faaac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 20:40:43.7358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEU9zyGdejF6H6RXqc9Xt7c7clevSFeiPx/LAhlTQN2y+Ob4qtoUgKfuliWZj1CsDZcJILR8BRmxwVudKSkf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
X-Proofpoint-ORIG-GUID: QWp32Es38vtG-hwWDxpb08k390BxrlMy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIwMSBTYWx0ZWRfX0h7Y/lcA3P9Q
 zildT0uMVnyBavYmCMvOJz4V3UrmeM5hJ6q1ktrVE2q4Chpav7ZqBOouK7D10I9xz/x8r/Gt5vb
 s4ojvEVg4CgiyycsZd3d0bEoVCDXiGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIwMSBTYWx0ZWRfXxOrSu+dkrtCc
 aHaK7ibpU1ws0Bq53F86dxHcsUS8OH8EjZMu34JVhTUwEbxmGA/oCes+XHiz6F0JrwJDuHlnkEk
 AAe7gxplCrfcExba4MIR9SzQCQj9egUC5wlPFmiXn7HBLWzAXAxIY4fjBBugAEzTi/TwYNmSJ8M
 FgJ8jiwsifNYHCoQr7PRJgqOzG4uD54RnKqWYNAvtew3fy4CcfD+1pV9ENJFe13K9gz2R9cNAf9
 MIYz5avcQw5WxEFSe77QUN0qOLjPNPADME6duxWjrmw+AGgIHkjQWO//oanMqooX1YDfYsgWMxQ
 yAgljT1JVzgaitfXsoVmxqNjafwt5k+YpQaX4ENtJcO1EVAnqZG7utonoHkQ8+qx/nNwpuLn+xS
 T2oVQWzlK4N8vbKhhJPx8tERKJJThWOVEmA1zq0d8bMvPiYZEYF/MkSpjMznCRchaq7ptLP6GwA
 CxCltn+QSmzpu6t1Jwg==
X-Authority-Analysis: v=2.4 cv=Q8DiJY2a c=1 sm=1 tr=0 ts=6a627c55 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=jIQo8A4GAAAA:8 a=agCaE0cTs6h6CVaSmKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QWp32Es38vtG-hwWDxpb08k390BxrlMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607230201
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 21:04:56 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pfptdkimsnps; bh=8GdUPQrLJxusW7bn9UlVtWDWI+I99rUl02tb3rMjsfs=; b=
 L0lkauRUXr0OHBcsffvJ2y8shJfalmFNk5ZCB/5MeSX9JmkrvJGsEwQ1hPOdC/ta
 EZZV2Mag3d6YYcktzMkbmL45arOr66IMCeR1D7RdzT99pxjm5+5AwyghK+X0Qvni
 kC+stoQtWAcTuOn4IuJDpWYFNAM2+TpAaEeBuU2hSNJRbjYCHXE4EBIt60i60emk
 nLVa1M3OPfEhN12vh6Qu1WZVeVMjlAqI/vOkj1CkIfF6j0opByOxfqK+q7Q1PX78
 UJQvc/o9BY1frSEXZlh1bOYyUBLNoN7cClyvr9GWQqY5n+gTeiOSJ9mdgoXNF5Pz
 d2mwhAiceIXDSb4w3j9uIg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=synopsys.com; s=mail; 
 t=1784839252; bh=8GdUPQrLJxusW7bn9UlVtWDWI+I99rUl02tb3rMjsfs=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=Ip9yLaCIscG5LosvLFl7KG4cc07fDu+VygjkM2i8OHONAXsd/R1Kkh8Yw69LHEmaK
 f21udSwRpWBh5AJai5+dPi0s3tecgY4lbHvDaf1fH0DMYpd9bWNcMTYrbqoxfBTGqx
 acDdyWIau2NynN+KMkIZXMd/S8cBH0ULS+zGYyn/iGFadsikrAFJY/NrfQRfAy9E+y
 KuAuvmt15IsINurIQUywWA+EOa3pWRH6FeQhIurB0v49S7XbMFKK6px0JAcsuVsz3U
 Zn9Zvwi4ED2hVA6QZcoVZuwnpImZJOQYgRtgezQdxV8Oq97kYlXz50QFPFZxCMegEl
 xRm/kpoXv2jbA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GdUPQrLJxusW7bn9UlVtWDWI+I99rUl02tb3rMjsfs=;
 b=wVHkuKLChmpYfQpaXUp9v+WEg2CPNMNc/LECFPcEln+iWaFuLCZaSYuSqzYMDs6f70nTa/JBb2zP9wvjWV9O/ypIpdBifOy2FFHu83ieCstwFh2BjFeUkWY2IDBhFsON8hBWq4m5OGeq0UpOwLPx+ZzWcTDVuN2mLKtUD+2Sc1c=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=L0lkauRU; 
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=Ip9yLaCI; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=wVHkuKLC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thinh.Nguyen@synopsys.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="L0lkauRU";
 dkim=pass (2048-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Ip9yLaCI";
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wVHkuKLC";
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none)
 header.from=synopsys.com
X-Mailman-Original-Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
X-Mailman-Original-Authentication-Results: o365relay-in.synopsys.com;
 dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=wVHkuKLC; 
 dkim-atps=neutral
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SGkgTWF0dGlqcywNCg0KT24gVGh1LCBKdWwgMjMsIDIwMjYsIE1hdHRpanMgS29ycGVyc2hvZWsg
d3JvdGU6DQo+IEhpIFRoaW5oLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+IA0K
PiBPbiBUaHUsIEp1bCAwOSwgMjAyNiBhdCAxODoxOSwgVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogRGFuIFRyYW4gPHRyYW5kYW5A
c3lub3BzeXMuY29tPg0KPiA+DQo+ID4gQWRkIFNTIGJ1bGsgZW5kcG9pbnQgZGVzY3JpcHRvcnMg
KDEwMjQtYnl0ZSBNUFMsIGJNYXhCdXJzdD0xNSkgdG8NCj4gPiBzdG9yYWdlX2NvbW1vbi5jIHRv
IHN1cHBvcnQgU3VwZXJTcGVlZCBjb25uZWN0aW9ucy4gRXh0ZW5kIGZzZ19lcF9kZXNjKCkNCj4g
PiB0byBzZWxlY3QgdGhlbSB3aGVuIG9wZXJhdGluZyBhdCBTdXBlclNwZWVkLCBhbmQgd2lyZSB1
cCBzc19kZXNjcmlwdG9ycw0KPiA+IGluIGZzZ19iaW5kKCkuIEZyZWUgc3NfZGVzY3JpcHRvcnMg
aW4gZnNnX3VuYmluZCgpIHRvIG1hdGNoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIFRy
YW4gPHRyYW5kYW5Ac3lub3BzeXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiAtLS0NCj4gPiAgQ2hhbmdlcyBpbiB2
MjoNCj4gPiAgLSBSZW1vdmVkIGludGVybmFsIFJldmlld2VkLWJ5IHRhZ3MNCj4gPg0KPiA+DQo+
ID4gIGRyaXZlcnMvdXNiL2dhZGdldC9mX21hc3Nfc3RvcmFnZS5jIHwgMjUgKysrKysrKysrKysr
LS0NCj4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0L3N0b3JhZ2VfY29tbW9uLmMgfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2ZfbWFzc19zdG9yYWdlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZl9tYXNzX3N0b3Jh
Z2UuYw0KPiA+IGluZGV4IDg3ZWQyNWU4YmIzYS4uYTJmMzRjMTAwNDgyIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mX21hc3Nfc3RvcmFnZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZ2FkZ2V0L2ZfbWFzc19zdG9yYWdlLmMNCj4gPiBAQCAtMjIyNSwxNCArMjIyNSwxNiBA
QCByZXNldDoNCj4gPiAgDQo+ID4gIAkvKiBFbmFibGUgdGhlIGVuZHBvaW50cyAqLw0KPiA+ICAJ
ZCA9IGZzZ19lcF9kZXNjKGNvbW1vbi0+Z2FkZ2V0LA0KPiA+IC0JCQkmZnNnX2ZzX2J1bGtfaW5f
ZGVzYywgJmZzZ19oc19idWxrX2luX2Rlc2MpOw0KPiA+ICsJCQkmZnNnX2ZzX2J1bGtfaW5fZGVz
YywgJmZzZ19oc19idWxrX2luX2Rlc2MsDQo+ID4gKwkJCSZmc2dfc3NfYnVsa19pbl9kZXNjKTsN
Cj4gPiAgCXJjID0gZW5hYmxlX2VuZHBvaW50KGNvbW1vbiwgZnNnLT5idWxrX2luLCBkKTsNCj4g
PiAgCWlmIChyYykNCj4gPiAgCQlnb3RvIHJlc2V0Ow0KPiA+ICAJZnNnLT5idWxrX2luX2VuYWJs
ZWQgPSAxOw0KPiA+ICANCj4gPiAgCWQgPSBmc2dfZXBfZGVzYyhjb21tb24tPmdhZGdldCwNCj4g
PiAtCQkJJmZzZ19mc19idWxrX291dF9kZXNjLCAmZnNnX2hzX2J1bGtfb3V0X2Rlc2MpOw0KPiA+
ICsJCQkmZnNnX2ZzX2J1bGtfb3V0X2Rlc2MsICZmc2dfaHNfYnVsa19vdXRfZGVzYywNCj4gPiAr
CQkJJmZzZ19zc19idWxrX291dF9kZXNjKTsNCj4gPiAgCXJjID0gZW5hYmxlX2VuZHBvaW50KGNv
bW1vbiwgZnNnLT5idWxrX291dCwgZCk7DQo+ID4gIAlpZiAocmMpDQo+ID4gIAkJZ290byByZXNl
dDsNCj4gPiBAQCAtMjY1Myw2ICsyNjU1LDcgQEAgc3RhdGljIHZvaWQgZnNnX3VuYmluZChzdHJ1
Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMsIHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gIAlm
c2dfY29tbW9uX3JlbGVhc2UoZnNnLT5jb21tb24pOw0KPiA+ICAJZnJlZShmc2ctPmZ1bmN0aW9u
LmRlc2NyaXB0b3JzKTsNCj4gPiAgCWZyZWUoZnNnLT5mdW5jdGlvbi5oc19kZXNjcmlwdG9ycyk7
DQo+ID4gKwlmcmVlKGZzZy0+ZnVuY3Rpb24uc3NfZGVzY3JpcHRvcnMpOw0KPiA+ICAJa2ZyZWUo
ZnNnKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiBAQCAtMjcwMSw2ICsyNzA0LDI0IEBAIHN0YXRpYyBp
bnQgZnNnX2JpbmQoc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjLCBzdHJ1Y3QgdXNiX2Z1bmN0
aW9uICpmKQ0KPiA+ICAJCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4g
Kw0KPiA+ICsJaWYgKGdhZGdldF9pc19zdXBlcnNwZWVkKGdhZGdldCkpIHsNCj4gPiArCQl1bnNp
Z25lZCBpbnQgbWF4X2J1cnN0ID0gbWluX3QodW5zaWduZWQgaW50LCBGU0dfQlVGTEVOIC8gMTAy
NCwgMTUpOw0KPiANCj4gSSBjYW4gc2VlIHRoYXQgdGhpcyBsb29rcyBzaW1pbGFyIHRvIHdoYXQg
d2UgaGF2ZSBpbiBMaW51eCB3aXRoDQo+IGNvbW1pdCA0YmI5OWI3YzgyYmEgKCJ1c2I6IGdhZGdl
dDogc3RvcmFnZTogYWRkIHN1cGVyc3BlZWQgc3VwcG9ydCIpDQo+IA0KPiBIb3dldmVyLCB0aGUg
TGludXggcGF0Y2ggYWRkZWQgYSBjb21tZW50IGFzIHdlbGw6DQo+IA0KPiArICAgICAgICAgICAg
ICAgLyogQ2FsY3VsYXRlIGJNYXhCdXJzdCwgd2Uga25vdyBwYWNrZXQgc2l6ZSBpcyAxMDI0ICov
DQo+ICsgICAgICAgICAgICAgICBtYXhfYnVyc3QgPSBtaW5fdCh1bnNpZ25lZCwgRlNHX0JVRkxF
TiAvIDEwMjQsIDE1KTsNCj4gDQo+IFdoeSBjYW4ndCB3ZSBkbyB0aGUgc2FtZSBoZXJlPw0KDQpU
aGUgY29tbWVudCBkb2Vzbid0IGFkZCBtdWNoIGJleW9uZCB3aGF0IHRoZSBjb2RlIGFscmVhZHkg
ZXhwcmVzc2VzLiBUaGUNCnZhcmlhYmxlIG5hbWUgbWF4X2J1cnN0IGFuZCB0aGUgZGl2aXNpb24g
YnkgMTAyNCBtYWtlIHRoZSBpbnRlbnQgY2xlYXIuDQoNClRoYXQgc2FpZCwgdGhlIExpbnV4IGNv
bW1lbnQgYWxzbyBoYXMgYSBtaW5vciBpbmFjY3VyYWN5OiBpdCBzYXlzDQoicGFja2V0IHNpemUi
IHdoZW4gaXQgc2hvdWxkIHNheSAibWF4IHBhY2tldCBzaXplIi4gSWYgYSBjb21tZW50IGlzDQp3
YXJyYW50ZWQsIEknZCBwcmVmZXIgdG8gYWRkIGEgY29ycmVjdGVkIG9uZS4gV2UgY2FuIGFkZCBp
dCBpZiB5b3UNCnJlYWxseSB0aGluayBpdCBoZWxwcyB3aXRoIHJlYWRhYmlsaXR5Lg0KDQo+IA0K
PiA+ICsNCj4gPiArCQlmc2dfc3NfYnVsa19pbl9kZXNjLmJFbmRwb2ludEFkZHJlc3MgPQ0KPiA+
ICsJCQlmc2dfZnNfYnVsa19pbl9kZXNjLmJFbmRwb2ludEFkZHJlc3M7DQo+ID4gKwkJZnNnX3Nz
X2J1bGtfaW5fY29tcF9kZXNjLmJNYXhCdXJzdCA9IG1heF9idXJzdDsNCj4gPiArCQlmc2dfc3Nf
YnVsa19vdXRfZGVzYy5iRW5kcG9pbnRBZGRyZXNzID0NCj4gPiArCQkJZnNnX2ZzX2J1bGtfb3V0
X2Rlc2MuYkVuZHBvaW50QWRkcmVzczsNCj4gPiArCQlmc2dfc3NfYnVsa19vdXRfY29tcF9kZXNj
LmJNYXhCdXJzdCA9IG1heF9idXJzdDsNCj4gPiArCQlmLT5zc19kZXNjcmlwdG9ycyA9IHVzYl9j
b3B5X2Rlc2NyaXB0b3JzKGZzZ19zc19mdW5jdGlvbik7DQo+ID4gKwkJaWYgKHVubGlrZWx5KCFm
LT5zc19kZXNjcmlwdG9ycykpIHsNCj4gPiArCQkJZnJlZShmLT5oc19kZXNjcmlwdG9ycyk7DQo+
ID4gKwkJCWZyZWUoZi0+ZGVzY3JpcHRvcnMpOw0KPiA+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4g
PiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIA0KPiA+ICBhdXRv
Y29uZl9mYWlsOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvc3RvcmFnZV9j
b21tb24uYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9zdG9yYWdlX2NvbW1vbi5jDQo+ID4gaW5kZXgg
N2U0YjU0MmY3Y2U1Li5kNzQ1NjQ5ZWFkYjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L3N0b3JhZ2VfY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvc3Rv
cmFnZV9jb21tb24uYw0KPiA+IEBAIC01MzEsMTEgKzUzMSw2MSBAQCBzdGF0aWMgc3RydWN0IHVz
Yl9kZXNjcmlwdG9yX2hlYWRlciAqZnNnX2hzX2Z1bmN0aW9uW10gPSB7DQo+ID4gIAlOVUxMLA0K
PiA+ICB9Ow0KPiA+ICANCj4gPiArLyoNCj4gPiArICogVVNCIDMuMCByZXF1aXJlcyBTdXBlclNw
ZWVkIGRlc2NyaXB0b3JzDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgc3RydWN0IHVzYl9lbmRwb2lu
dF9kZXNjcmlwdG9yDQo+ID4gK2ZzZ19zc19idWxrX2luX2Rlc2MgPSB7DQo+ID4gKwkuYkxlbmd0
aCA9CQlVU0JfRFRfRU5EUE9JTlRfU0laRSwNCj4gPiArCS5iRGVzY3JpcHRvclR5cGUgPQlVU0Jf
RFRfRU5EUE9JTlQsDQo+ID4gKw0KPiA+ICsJLyogYkVuZHBvaW50QWRkcmVzcyBjb3BpZWQgZnJv
bSBmc19idWxrX2luX2Rlc2MgZHVyaW5nIGZzZ19iaW5kKCkgKi8NCj4gPiArCS5ibUF0dHJpYnV0
ZXMgPQkJVVNCX0VORFBPSU5UX1hGRVJfQlVMSywNCj4gPiArCS53TWF4UGFja2V0U2l6ZSA9CWNw
dV90b19sZTE2KDEwMjQpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCB1c2Jf
c3NfZXBfY29tcF9kZXNjcmlwdG9yIGZzZ19zc19idWxrX2luX2NvbXBfZGVzYyA9IHsNCj4gPiAr
CS5iTGVuZ3RoID0JCXNpemVvZihmc2dfc3NfYnVsa19pbl9jb21wX2Rlc2MpLA0KPiA+ICsJLmJE
ZXNjcmlwdG9yVHlwZSA9CVVTQl9EVF9TU19FTkRQT0lOVF9DT01QLA0KPiA+ICsJLyogYk1heEJ1
cnN0IHNldCBkdXJpbmcgZnNnX2JpbmQoKSAqLw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGlj
IHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3JpcHRvcg0KPiA+ICtmc2dfc3NfYnVsa19vdXRfZGVz
YyA9IHsNCj4gPiArCS5iTGVuZ3RoID0JCVVTQl9EVF9FTkRQT0lOVF9TSVpFLA0KPiA+ICsJLmJE
ZXNjcmlwdG9yVHlwZSA9CVVTQl9EVF9FTkRQT0lOVCwNCj4gPiArDQo+ID4gKwkvKiBiRW5kcG9p
bnRBZGRyZXNzIGNvcGllZCBmcm9tIGZzX2J1bGtfb3V0X2Rlc2MgZHVyaW5nIGZzZ19iaW5kKCkg
Ki8NCj4gPiArCS5ibUF0dHJpYnV0ZXMgPQkJVVNCX0VORFBPSU5UX1hGRVJfQlVMSywNCj4gPiAr
CS53TWF4UGFja2V0U2l6ZSA9CWNwdV90b19sZTE2KDEwMjQpLA0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiArc3RhdGljIHN0cnVjdCB1c2Jfc3NfZXBfY29tcF9kZXNjcmlwdG9yIGZzZ19zc19idWxrX291
dF9jb21wX2Rlc2MgPSB7DQo+ID4gKwkuYkxlbmd0aCA9CQlzaXplb2YoZnNnX3NzX2J1bGtfb3V0
X2NvbXBfZGVzYyksDQo+ID4gKwkuYkRlc2NyaXB0b3JUeXBlID0JVVNCX0RUX1NTX0VORFBPSU5U
X0NPTVAsDQo+ID4gKwkvKiBiTWF4QnVyc3Qgc2V0IGR1cmluZyBmc2dfYmluZCgpICovDQo+ID4g
K307DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqZnNn
X3NzX2Z1bmN0aW9uW10gPSB7DQo+ID4gKyNpZm5kZWYgRlNHX05PX09URw0KPiA+ICsJKHN0cnVj
dCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikmZnNnX290Z19kZXNjLA0KPiA+ICsjZW5kaWYNCj4g
PiArCShzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopJmZzZ19pbnRmX2Rlc2MsDQo+ID4g
Kwkoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSZmc2dfc3NfYnVsa19pbl9kZXNjLA0K
PiA+ICsJKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikmZnNnX3NzX2J1bGtfaW5fY29t
cF9kZXNjLA0KPiA+ICsJKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikmZnNnX3NzX2J1
bGtfb3V0X2Rlc2MsDQo+ID4gKwkoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSZmc2df
c3NfYnVsa19vdXRfY29tcF9kZXNjLA0KPiA+ICsJTlVMTCwNCj4gPiArfTsNCj4gPiArDQo+ID4g
IC8qIE1heHBhY2tldCBhbmQgb3RoZXIgdHJhbnNmZXIgY2hhcmFjdGVyaXN0aWNzIHZhcnkgYnkg
c3BlZWQuICovDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3IgKg0K
PiA+ICBmc2dfZXBfZGVzYyhzdHJ1Y3QgdXNiX2dhZGdldCAqZywgc3RydWN0IHVzYl9lbmRwb2lu
dF9kZXNjcmlwdG9yICpmcywNCj4gPiAtCQlzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3Ig
KmhzKQ0KPiA+ICsJCXN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3JpcHRvciAqaHMsDQo+ID4gKwkJ
c3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlwdG9yICpzcykNCj4gPiAgew0KPiA+ICsJaWYgKGct
PnNwZWVkID49IFVTQl9TUEVFRF9TVVBFUikNCj4gPiArCQlyZXR1cm4gc3M7DQo+IA0KPiBJIGNh
biBzZWUgdGhhdCB0aGlzIGxvb2tzIHNpbWlsYXIgdG8gd2hhdCB3ZSBoYXZlIGluIExpbnV4IHdp
dGgNCj4gY29tbWl0IDRiYjk5YjdjODJiYSAoInVzYjogZ2FkZ2V0OiBzdG9yYWdlOiBhZGQgc3Vw
ZXJzcGVlZCBzdXBwb3J0IikNCj4gDQo+IEhvd2V2ZXIsIExpbnV4IHVzZXMgdGhlIGZvbGxvd2lu
ZyBkaWZmIGluc3RlYWQ6DQo+ICsgICAgICAgaWYgKGdhZGdldF9pc19zdXBlcnNwZWVkKGcpICYm
IGctPnNwZWVkID09IFVTQl9TUEVFRF9TVVBFUikNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBz
czsNCj4gDQo+IElzIHRoZXJlIGEgcmVhc29uIGZvciBub3QgZG9pbmcgdGhlIHNhbWUgaGVyZT8N
Cg0KVGhlIGdhZGdldF9pc19zdXBlcnNwZWVkKCkgaXMgYSBoYXJkd2FyZSBjYXBhYmlsaXR5IGNo
ZWNrLiBJdCdzDQpyZWR1bmRhbnQgd2hlbiB3ZSdyZSBhbHJlYWR5IGNoZWNraW5nIGctPnNwZWVk
IGZvciBjb25uZWN0ZWQgc3BlZWQuDQoNCkJSLA0KVGhpbmgNCg0KPiANCj4gPiAgCWlmIChnYWRn
ZXRfaXNfZHVhbHNwZWVkKGcpICYmIGctPnNwZWVkID09IFVTQl9TUEVFRF9ISUdIKQ0KPiA+ICAJ
CXJldHVybiBoczsNCj4gPiAgCXJldHVybiBmczsNCj4gPiAtLSANCj4gPiAyLjUzLjA=
