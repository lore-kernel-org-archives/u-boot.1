Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED8C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 12:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51AC188665;
	Tue, 11 Jun 2024 14:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVVOKjWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6199B8863B; Tue, 11 Jun 2024 13:02:25 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76896882F6
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtLV3bUZ1MeOXY51whE2NMtDhFcXb5RzjQc9cMg65sjhG1UWikXMkwlXmWZtq0tTUfSSVq8quOcH62JneSxqmPEyoBYTLAyU6IqGVNROs5snUB7mGjIbPL/eg1ZBmad612jR1h648fW0UDxmqhcRhXVC/oBPN7kpLVjv+9PUppRTpqBQMt2SjwS2G6f+6ChfgJGsRpQTOcY4pAx9jQ+tW190Guqz7phj3y+iEYRzjB2WwdqPhThkpEhpj80VEZfTi+8kkwAw/0xP+MKIkp7Pm9IHkR3ODtOSdLAda4fAgAHRKmyQ/BSO0RU5aJ5EfeE+mtC55vaq1ab16WDN9NLV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IfACoD4+UKsBy6DDnEfRPffrcVFYhaC2M4cmeoXfxw=;
 b=fJVVD6XPDo2rrh3/PEt1IQM8+mIyhFVeyCgiwbocOLj7uNcCzaJfXtrOE60R0CHW/5nS9BVJ3jKdjZgnWb+9f8r/DkabRCVnZPLag0a8ShfiS05MlrSqBr5JLtHDaFaCstzZA7Rd8RGapA6aBw9ozLEWCqTpAmafoFc2xa1oyMDUDxNWRhBJ2GOUaRqmKPG+RDxTUkoh6fZQdPule9WQLUA0C6bWXIu1Xws+Y9JKNP+kZaLxRhEFG9gCccWImn6T6uORrXM3A/87tMKVfn5vmH7HVN4QPtUE3QQOj/Ehfs3xEngQyriLXnKc9oj2XkNzjfC2BVUkCjsgTIUGSU21zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IfACoD4+UKsBy6DDnEfRPffrcVFYhaC2M4cmeoXfxw=;
 b=TVVOKjWbieIliKSSJJqqj1IjispnQRRmGHYILrYNJzpvaUO5xQ4iK9s2JJyEI45GuQ/Qu+Cr2sfhOzJNEWbYPd/Pgn02y7SGD9WsSS7TDnMenRoR4ka4dgYMIwnHIt0+CQNzs4pG1yw+qooz+BxPIt4hFW5Z51BXK/7HdR2m2VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 11:02:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:02:19 +0000
Message-ID: <3487a965-6c2f-42f5-ab83-3b2a0a1ecdc5@amd.com>
Date: Tue, 11 Jun 2024 13:01:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: versal2: Add support for new AMD Versal Gen 2
 SoC
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Fabio Estevam
 <festevam@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Igor Prusov <IVPrusov@sberdevices.ru>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
References: <cover.1716994063.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1716994063.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0138.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: dc30b775-9584-4522-c85e-08dc8a05f616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU91ZVByeXRVSHE1dnBKZGJmMlJjUDR2VHJzdkQ2Tkg3YXVDV0gxYW91S0Y1?=
 =?utf-8?B?ek9WQkNlRkxIZmxnWWVwU0NSRFlxamZDZ0swMmxydkp0QVFCU2ZxenlGM05m?=
 =?utf-8?B?cklYY3lXamRET1FUMnplYTNjSWMyakZ5UXBMVWZuOU03NGg5MC80QkxlbnhX?=
 =?utf-8?B?TXVKNS9KaERMQlRwWHdVTDI2Ym9jN3NtOXVEbDFiQnkwSVkyQW1kUGZ2UWpL?=
 =?utf-8?B?L0dkWXNUa1h6NGxiUWN1UzVzMXB1UjhUalM2SjlmWSs0ZmVoRG81Ymg1SnBQ?=
 =?utf-8?B?dnYvVlBhV3Q2Sy85QzRXR0g0MXEyM01sQ3ZLQjYxQUNiSk5LMDBsdnhPZGc5?=
 =?utf-8?B?TFY0OTYxOWQ2bzYreG94c3JqbVhDd1habGtlK0JMcXJBTTVxL2xlZUo4S2Z1?=
 =?utf-8?B?TFJTNm84T1dlSUhDRVY4eDV5WDZib0lpMW5CZU1ubWk2dGV5b3hheXVPRU5q?=
 =?utf-8?B?TzdRNFVEWXVOQ0tUM20xdnRJa0RvVW9CZ1Jrd3EzcjVUSlFpekJPUE5scDU1?=
 =?utf-8?B?QkRPeUtVZFk3ekZzZFJ2c2QyNFhBbnh3Y2VtQ1cxT05kaEFkb0h4VkhmVkxW?=
 =?utf-8?B?SS9neUgrcS9RMHFTVE4yQXNjOXFKRTNYcnU2SGROR0lIUGVQU2FidkFiOXVp?=
 =?utf-8?B?YVh6RnZvZVNkTE92T1BJVmVjTkJnbzNFcm1VWFFES1M4MmNFUmFlTnJYbFZG?=
 =?utf-8?B?Y3YrN2hXYis3bjNMZCt4ZmxjM1h6d0txdFk3ZDgrNjRaYkVxOGlqWTZtcE04?=
 =?utf-8?B?SG9acFQ0ZFRYWDJpVjlrbmlVZGtEUzJNUUdPVXJMZkhMUzZqVzh0SktERjVQ?=
 =?utf-8?B?TGV1ZW10RVJQMHhRSjRKcjBtUllTMHhNblpIR1VyQVZJUHRLNVRHRzk2TStS?=
 =?utf-8?B?dlY2NVNYenBJR09WWktYZ0NPRjBkZnVubTFNK3BKRVl5NWVzU3VJenI0TDM1?=
 =?utf-8?B?NXc2UUhCeEF0VmRoV0t6MjRnQW1TRm1hNkhybkxTQVVETjdJTlhOaGNUZ2N4?=
 =?utf-8?B?NE1NZ3lqcjVqa3B6WEdvVkFHdVkzd2RDQjlENnVEY3lWd2VxeTFKVFl4S2Fq?=
 =?utf-8?B?Q2VRcFpkYkVxOHRlNncrd21LdTg2ZGlLY0d2RzNLV2oxTjdoR25CSDFHUEc4?=
 =?utf-8?B?NGErMWkxY2VyUWlJZnZEeEkyRGw4MDc1RG81aFRvcW8zTTNlbm0wclZIM1NM?=
 =?utf-8?B?VElNVkthVm9CNGZWQUJjRjArV0srTGJGL2NZemZaSk1LcHdKSlUyYXBTWkFi?=
 =?utf-8?B?aU5NUTBTdnZrSVdjZUUyRUpOK0Q2QVZOUzdNdnhoSitPaDczYUcxTVVmOVkr?=
 =?utf-8?B?RndYeTVFbWRDWUhaZjJGQURrL1hWR2ZWd1haM1FQeTNlM3JjV2VyakJlcWVi?=
 =?utf-8?B?Nmo0c3oyUitTamxkT1Q1bS9RMGhZN1Brd09OMGg0YUFvanpDd3pXN2lpMUtr?=
 =?utf-8?B?UGJXVW1lR2xKMGg4ODBRUG5zMFQ5aTlXQlBZOUlEZXZaSDJHOGwyQTRkdXZG?=
 =?utf-8?B?aHM0OVZWUlNOUGRtbnFnMGJTakhiSzBKb0UvZ2RiZDRsV0RGK2o5VGxFQ3BH?=
 =?utf-8?B?U0xwaUR3cVlLZGZFNkowKzFLWVhNeW1yY0FkcFhFeTNMY0VIVzl3dXRvNmNS?=
 =?utf-8?B?MW9tQTBiUkc1WDRTK25XTFFOQ3BPRkhxMDRSY21HQm11NVVGbjJEREt6UTdH?=
 =?utf-8?B?YXFZb2RCbE55VVc0RDJmWHpraDlZOFpQQThTTjNoVUxxSlpSdGJhY0VLWEZm?=
 =?utf-8?Q?ZEHWYtrpoDRfcuoJVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1orKzNGVHBuZjVhT1BXMHdaY01ERGxjOVRjOXNZaG5lVFVrbVFrTTRpZnAv?=
 =?utf-8?B?YXFST0xsTzhIQzlZMUZ1OEhPbW8xQXpQYnZIMFRLL1JNb1Z2aW1hNGNzYTJG?=
 =?utf-8?B?OVpqVTJCU1ozcjZvTjQ1ZHZSMWtxZzlrMWxaSzBQNGc5THBpVVIxaTZhNWV6?=
 =?utf-8?B?SVY0M01HOXBKTzJWR295NkhDcVBVaUNPMWgwSGdSbFp5YjhnSVQ3YWluSUlE?=
 =?utf-8?B?dHlwWVBzbEdBSks5SHpSRmZWWEsvRE1IYmIzbnluQ0pmVkNMNHZEVG9qRFhR?=
 =?utf-8?B?aG04RDRZYUlvZWZVclR3ejhUWlFSOFAyTGgxRzlJWXZ5ZGJWbWd5YzArcUpS?=
 =?utf-8?B?QWJ1K3N0VXFwdFMxMjlyL3FZcko5TjdJdTdUbzEvYUZLdjlTQm14MzRTdk40?=
 =?utf-8?B?bXVvMTZOc252ZFpFRjNXcjBYZGl4WU9qcnJhSnM0YSt4VnYzeitGWDhtNkxU?=
 =?utf-8?B?ZXRZYWJGbnZiQmZnQU9YYVhndGV4SnlwTUxyMjVkVnpjNHZvd3FBZjlDMzc5?=
 =?utf-8?B?eklwbzloY0loWStSWjRrcTBkTVRvMXJvTHMrRkg3ZVBGRkwwL0R5bm5GRXBF?=
 =?utf-8?B?Yjd3S2kxTU9Hb1FuVVZtL3hqallESUl5TFc3RmRqUzAyL1ZIZ3o3QmpLbm1P?=
 =?utf-8?B?WW1qZk5BTHBMb2RNcmxpRGVjUFpFdW9BQzBtMlltTzBNUnM3VjFYV2NOL3VR?=
 =?utf-8?B?bGRYNWpvTFRkNnhnM2RYR3FONEJ5RDZOTVJSdnhzTXdiVFpyK1RoczYyM1Va?=
 =?utf-8?B?YjU3c0RnUTNtQnJ4eXZVbXVhcStjcTJLcGJObkdjcEZYTWl3blorZEg2VDR1?=
 =?utf-8?B?cENNZkEyWTBLVE1IQkU5bFAzQkJTN1dDNEgzMndEa1FLbEtZdUtUbWd5SlAz?=
 =?utf-8?B?VVdYM0JIc2p6VGdvU1EzVEtiQlBFSERhUDF1eU85czdacVk0RlZyMVVIWUZu?=
 =?utf-8?B?a2h5Uk9wUzNkRUdFRjAvWlQ1b0lGNFZlTXo5S0V0ZVNLaUdhbjVHMlc4cHBz?=
 =?utf-8?B?c0syR0hlVk1jS3FrR1RocUxYUTVVNnZMU2FoZVhhTjhCUHdaRHNjOGJyNmgx?=
 =?utf-8?B?Y3IzM25rZGZnVG9XMWwyUnFhc0ZUNEowQVhJckpwajJiWnpvR1NwUE1VRHQr?=
 =?utf-8?B?eDErSE5vcWdVQ28xbWNMVzUzNVk1YUQxMTRKRFVYdG9yYzdUdjcvTDBsZ0dJ?=
 =?utf-8?B?VHlzeVdKNllNc2lZQXRKaWJ1Vy9Ya2g2YWpMZjJ5YVpwc0x2NENRandmdjg0?=
 =?utf-8?B?OWFxRnRwNCsxcTNUL0l2c2tpWlpweURyTVpxOW14ZjBYNWJvZzJ3UldKaGtN?=
 =?utf-8?B?NFdFMVVxZ292Mk9VUHhqSldPZ1VCZGp3ODNyS2QwRTNYM2VScjdtajhIVFFY?=
 =?utf-8?B?ekxOaUs4QTk2WW84dVd5a0tvRmIrSkErK3N3U0pwdHFseUoweDd0RjVUN0tj?=
 =?utf-8?B?cncybjhVVUpUZnZ6TXB4ZW9nZWJhckdmdzdHa1ZrZUc2R3kyenpqMktucXow?=
 =?utf-8?B?Qk1MZndsNEhNVkM0ZzJCUVY0MWphUmlMSEUyWCtETnk3RFN3WjFBUWtqcFF6?=
 =?utf-8?B?WWhiOE5JN1htYk81M3QzQ2VXcWsxM1N5RWRwbU1xWGhyQzFFYXNOeStwN3NF?=
 =?utf-8?B?bE00akZmUEZUbjFTNDU1aTFwMXNIV0wxZjhQcXdiTjU2Q2ZDN0VDanpwWUxO?=
 =?utf-8?B?dGZpY1d5VWhyaTJIY2NkYnFnZXFWUHJySzNOR1paYS9qTEM3aXhJL0cxMW5w?=
 =?utf-8?B?RDZnU0MxMnB1L05DTnZxV0VONDkxQnJkOVYzMHl4c3FqV25CZlZ0NVdybWFa?=
 =?utf-8?B?aVFpeWx1bkNmZndYZS9peFpOU3kxMUhOYk1XY0pxMFNsaXU5V2ZsS1p0NmpC?=
 =?utf-8?B?UkhLQWpya29kM0lNR0gxcEt4RTh6YWVyZ1RhSVp1UktkZW1scWplZ2VrSWhQ?=
 =?utf-8?B?NDByZUtiN0poQTBxUjhoL2hiVlJ1M2VGNnk1Mkx0MVFvU3lURTlFekJHLzlk?=
 =?utf-8?B?NGsxbmFaQWlKbzBHcjE0ZnI2K0I5cG1WNXdnRkdRT2lOU2lvNklUejRWMGNK?=
 =?utf-8?B?bGE5VFlLSkExb1BmQ2hvelR2cGFEMENMY0RVT09pWlMvcllCNHpJMTlSZDBi?=
 =?utf-8?Q?ey6keowVsmPE9VWStuSdqmQ+2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc30b775-9584-4522-c85e-08dc8a05f616
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:02:19.0746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3psI9q64ZPEMaZvh7ppV2xkIeEjP5h4NXPR5G251ABk5V5Y+5szGDqnqTU6aBJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
X-Mailman-Approved-At: Tue, 11 Jun 2024 14:37:22 +0200
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



On 5/29/24 16:47, Michal Simek wrote:
> Hi,
> 
> I am sending patches for adding initial support for new AMD Versal Gen 2
> SoC. If you want to find out more information please take a look at this
> page:
> https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (4):
>    arm64: versal2: Add support for AMD Versal Gen 2
>    soc: versal2: Add SoC driver for AMD Versal Gen 2
>    mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
>    spi: versal2: Enable spi drivers for Versal Gen 2
> 
>   arch/arm/Kconfig                              |  14 +
>   arch/arm/Makefile                             |   1 +
>   arch/arm/dts/Makefile                         |   2 +
>   arch/arm/dts/amd-versal2-virt.dts             |  11 +
>   arch/arm/mach-versal2/Kconfig                 |  55 +++
>   arch/arm/mach-versal2/Makefile                |  10 +
>   arch/arm/mach-versal2/clk.c                   |  34 ++
>   arch/arm/mach-versal2/cpu.c                   |  93 +++++
>   arch/arm/mach-versal2/include/mach/hardware.h |  97 +++++
>   .../arm/mach-versal2/include/mach/sys_proto.h |   9 +
>   board/amd/common                              |   1 +
>   board/amd/versal2/Kconfig                     |  16 +
>   board/amd/versal2/MAINTAINERS                 |   7 +
>   board/amd/versal2/Makefile                    |  11 +
>   board/amd/versal2/board.c                     | 343 ++++++++++++++++++
>   board/amd/versal2/cmds.c                      |  81 +++++
>   board/xilinx/Kconfig                          |   6 +-
>   configs/amd_versal2_virt_defconfig            | 150 ++++++++
>   drivers/gpio/Kconfig                          |   2 +-
>   drivers/mailbox/Kconfig                       |   2 +-
>   drivers/mmc/zynq_sdhci.c                      |  22 +-
>   drivers/soc/Kconfig                           |   8 +
>   drivers/soc/Makefile                          |   1 +
>   drivers/soc/soc_amd_versal2.c                 |  77 ++++
>   drivers/spi/Kconfig                           |   2 +-
>   drivers/spi/cadence_qspi.c                    |   3 +-
>   drivers/spi/zynqmp_gqspi.c                    |   6 +-
>   env/Kconfig                                   |   6 +-
>   include/configs/amd_versal2.h                 | 143 ++++++++
>   29 files changed, 1193 insertions(+), 20 deletions(-)
>   create mode 100644 arch/arm/dts/amd-versal2-virt.dts
>   create mode 100644 arch/arm/mach-versal2/Kconfig
>   create mode 100644 arch/arm/mach-versal2/Makefile
>   create mode 100644 arch/arm/mach-versal2/clk.c
>   create mode 100644 arch/arm/mach-versal2/cpu.c
>   create mode 100644 arch/arm/mach-versal2/include/mach/hardware.h
>   create mode 100644 arch/arm/mach-versal2/include/mach/sys_proto.h
>   create mode 120000 board/amd/common
>   create mode 100644 board/amd/versal2/Kconfig
>   create mode 100644 board/amd/versal2/MAINTAINERS
>   create mode 100644 board/amd/versal2/Makefile
>   create mode 100644 board/amd/versal2/board.c
>   create mode 100644 board/amd/versal2/cmds.c
>   create mode 100644 configs/amd_versal2_virt_defconfig
>   create mode 100644 drivers/soc/soc_amd_versal2.c
>   create mode 100644 include/configs/amd_versal2.h
> 

Applied.
M
