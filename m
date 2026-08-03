Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61213C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 11:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 164FB6075D;
	Mon,  3 Aug 2026 11:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wh8pq7G_9D0p; Mon,  3 Aug 2026 11:18:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F31760745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785755919;
	bh=zGmqeZlia5LA+Wlp9CXcGbXwrLHexys0Gwng8KSlG6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pPXlD/W7j7DFE4qgzdPRbd0OrSfjwnaxqDE8my4rrK2XT7uBbFWvBQ7usfM5BSmDW
	 kjNe1Kt0TU7NJn8rq8C2eitM/ENrmgD4CnxnMJRBwESv0V+bu/ik2D4dGDnjsKj2uy
	 Uu6A/GmUcc3R1N7WzCfcA+Eo2qUFvndZtIBT4PosNhDDtnktRw9AtkEBuzg/YAeRjt
	 z6ZagP2nvKsG+MoTAoJm3PI5i8aDZOnbvvv5br57qeG9GV3fEI6qvE4GdrDgL2nGCx
	 e9rrHcyJxOjoTJZDVFtCeuKHNT5CfPHwrdb0H7PClddSCwQCVkO8xXTcRlZFjpo44/
	 No6bQHIOs5fRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F31760745;
	Mon,  3 Aug 2026 11:18:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5430218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 07:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2A03400A2
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 07:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uE97DBMajLhH for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 07:36:39 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B775940024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B775940024
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B775940024
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 07:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5B5Mu7gW55WYEi45R0rdeUSnjmwQ0qHXcaL42+w4Ota23PpifTUBkYCuwfd9Xo4aLY5RycbeuFSgz+yNdDOcknV0GHkD4ZvlwuLb6Qh+n6Ge2jqxGfycjS6ACf+VSZwOieSJxGVBXXVy89boylZk2+zurcObMjH6mOIS1/iAL0lh3ts3ygHaD0Pmu9NCN4yJL67RX+N6+aIK+aNEDupzpZG4cAP+fv4O64llyujJom/rKoZhrFpCh5bvY4BUS4XcSAmHbE1os3qdbizFClX0bbhIsaKzrfooolkLZyl6l+MxRmNqy7MUGUtjvEEeYCx0Oq3Bv3TL2SXgWZmbTPHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGmqeZlia5LA+Wlp9CXcGbXwrLHexys0Gwng8KSlG6E=;
 b=hkFGi2diuMNdpVe9q9UAbWve5y6iGlY0nR+yWZ0vJIZ/9/z5xux4k+IleP0V8cZnr7iNXh6Fquz+RWfmujqhC7eSuozkK3EfbkKaOga5umF8oIEwm5QBzY8JlWxcg7Ipf+qbYg8T6UNLKlH+LdWxvw2BORIQIQX+iZRWr8XqjEsVy5COC5tuboOXlsbLuXrhoFvzvzv/TqIVcOK0/aS4QNnvHQtph2pqqcYlG+RCcgV3V1Mg4oPXna+gkQPkgo2guftZdnYzjJvRZhEFxz7Ea137xdLTFOL2okFRTTUcYfZBKyqvOfMg/G4matT5EVWn9R4029iiYWEIRMQXFR8R4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by DU4PR04MB10599.eurprd04.prod.outlook.com (2603:10a6:10:593::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 07:36:32 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 07:36:32 +0000
Message-ID: <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
Date: Mon, 3 Aug 2026 15:35:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
 <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
Content-Language: en-US
From: Joseph Guo <qijian.guo@nxp.com>
In-Reply-To: <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|DU4PR04MB10599:EE_
X-MS-Office365-Filtering-Correlation-Id: 99956c04-1fbc-4e61-e748-08def131f05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|19092799006|376014|4143699003|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AacUoveFd7JZXyiMody3v92ie8p2sCvYs8adWi/uDFNadSYhpk6gM4ZzVNdTHXWLsbKx96PX1gwuUQs545j4BNZHYVWCmuiB6U+1bK6xjcO5WAketvcMAWhOj5nrDyqthmTXJjAmSfAQU8t+elRZh3+bMYnC+v4AVoIPi9onpM5hevwmc9vPu9xgqkqi4um0B9+Kv0A222VOOAd98cVZW1i6LYjlVOVBEoJ6Nz0vAeT5U+GrIAF/qfs0UXhAvJIxQ/UsHOfdaa1F8xQnplI9U9thAZ8n2hkCCQhXPa91iPVeco7YulAMLMQfveswfrCNXGNnPPQel8vDREyMlLmMnW2VyO9uWGRSB5J7Nn3GMhgg/7/U/O4ezCEW7G5cjmnhgTgO0+weh0x050EZXwia9vVF684urv2CAT5OwVSdzxfFPdzYFcVagvEyZ4zIQWMEsqci3CZql1zAj33hgY7Y2IKsqH389HFW9cc9RvJShHyoK3K6crZvyO9nyKC0pBs8OzapK45g0N3KoTf3ngK0QDAln8Qhz82jbz0BLOIzcHg4nR9Sjn1gxg+8LqEWrgVGqE5XIrT2t+Xy5t3uQVwW8S00E4XowTK7Jxx9UedptmRKVfCc3d7fFF3TH374niSH7gspJ5YKtov6ZYTfXOjFCSbbFJgnTlJ7vu144MCnqA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(4143699003)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T01qTWVsSkl6YURMOG1vZXVKYzhxdHBaWFdOVmt1YWxLWUhLN2VadmJQeVo4?=
 =?utf-8?B?V3lIWHFwNHAxRXVac3oySlVHdEYvWnlMZ0tudzBnWEwzMHRXdStZdXRkT2RY?=
 =?utf-8?B?S2YzTVpQUlVhV1Y2Q25tNXIwa0p3VUFheDFYOXNSakJEeHZDbGljclBualBz?=
 =?utf-8?B?K01WZ3NrY0RQUldSSUZKdHY1RUdveDk3bE9GZGQzQVB3cTRxTGtNWnRqQXcr?=
 =?utf-8?B?UnpaQzMvZktPRlllc1BNS2J0eDlKOFBSRUFhVElmaGpnN1lWS2xrUDJNa1dT?=
 =?utf-8?B?U1JIZ09OVmtZRTBnRERVNzNxbTBtbHlYaElvV0h6R2tTSC95NHNEanF4QXB1?=
 =?utf-8?B?R0NyRnc1TlNhSXFFTFNOQkNsdlE0WktiKzU5cnJUQ3gxbVNuV0dxTVV6YWZK?=
 =?utf-8?B?NHRqU1Y4c3hFemt5dkdQZ1lyTmRXWDM4U0l1T214aUo5ZXpERHArendNMHlI?=
 =?utf-8?B?UGRuYWt5MGFmdGNVZjRkNW5CLzZxMUhON1ZRSm1ZVC9QSUREWmFocDJENXFF?=
 =?utf-8?B?T1RLSDdvVEtmMGpLR2xwbHZBVEphM0NtZFRVZFc2Z1hicTJ0T0kxRXNxeEhp?=
 =?utf-8?B?RDNyS2cxeml3VDFUdE4rbFA0ZkpCSDk1MFFYYTdaRW9iY0dIMUZ5bFVPYjlZ?=
 =?utf-8?B?WHRhSTBVRC8yRjY3blYxeDNmOGZFb1hrNEQ3L2dXVXNzOVo5Q1RoQkZjaGhp?=
 =?utf-8?B?OXgrVGprTlpZUGNmZzdxN1lhcVRVUEltUTdwS0NOZ0ZoRVFOWk9WOEFWVnBO?=
 =?utf-8?B?MVluRC9kZ2RUbU15MXRVWnFZUW8xbzVYVkdmUHNzVW5PMWpzYmIxYThZSmxo?=
 =?utf-8?B?eWhEc3Rrd0prN3BQZkhsbjhsZWFDYkR4MTdMRlJ4ZWNjd1c4MEVDeE1Qelpm?=
 =?utf-8?B?SWphTUo0MjkvcnNHaFA4czlzR3Evbm9OTHNiNFFkYndrUDdVaktvRGRGdEwy?=
 =?utf-8?B?MnJnT3BNcm0ySnlMTjg4ellCbEJZLzAraEFmNG9aRGtsa0dXSWtHVGpTUy9W?=
 =?utf-8?B?MGlLTVNDRjRnbEVwUTVxU3JVOFpvZGlnT1Fpa1R5RTNLbUJNS0xCb0hqK2FX?=
 =?utf-8?B?QnNwK1hNVWVYNGZyS0tWVVIzZHdlcU5BNnpCbExGOVZEdk9ZQmpsV2dDWTc3?=
 =?utf-8?B?ZTcxYm44Y3RuVjhML2lxWVFSNUwyZUE1dXlmYjEramhVakdRd05SNnN0OVpL?=
 =?utf-8?B?eFZ4dW9xVTJvMitlelBVYW5OcU1CNFdOOW9wc0ZoYVd5SG5MTkt5QTluNkdX?=
 =?utf-8?B?MXV6Y2lWQnc0bHRUcCsyMjBML216SzJGTG9UV0hQSEVESGpkbGpJd09td2lK?=
 =?utf-8?B?RGQ1TnJhQ2V5djFUYU5JL3Jmdmt5OW1nY3JNR2h1akZiRmxvVzIraUJpQmU4?=
 =?utf-8?B?UkxsTk9uQkV0U0plWXdOOXhPSDIxdmtITCtWQTVTb1NneXphczN5bXJvaHN1?=
 =?utf-8?B?Y0JKUDU5Z3NERkgwa25ORlFOZ1ZwN1VpempVUW5Mb1Fha00wSGpvcDk4L2JY?=
 =?utf-8?B?aDZ6YVFxT2hPR1ptMHQ1ZGJmejYzTUZRajRYcTY5K2J2Vm42aUVCeW1VNW80?=
 =?utf-8?B?Q0g1L3c3d281NmxyQ1JKVm5oQXh5SG52UDRNdXArS29DTTBvL3pxL0xtNndN?=
 =?utf-8?B?NjNRSmdKMmVZdTVVZW1iZDJOcmFxTW5zMmdvdlFicEFMRnU3WHZCRTRsckQ0?=
 =?utf-8?B?ZUV5QUovajkrMkV2cjVrdmljNmlpbnd5ckI0VmM2SVVDVFJpWUNUZ1VmanVV?=
 =?utf-8?B?cmNTSVFTNDJuL2JEUmxUSktnV0JlbWpmdDJKU3NXdjFzZXo2bzZ6ZTlNSVls?=
 =?utf-8?B?cjFpMVh6dlJocnRhcmxLb090VklFTCs2ZVV3YlpBVktNQ0Joa2FWdVRaRiti?=
 =?utf-8?B?YUZNR2ppalMrdzdmMWhLU20veFRXbHBBQW5MUkthOGc0SFNDTWhiQ1k3WW5K?=
 =?utf-8?B?Y3haNmNjQy8rZGpML24wOTVkQW11dFBmcmlZemtHZnJ3aDF0SEo3VkJJZ01F?=
 =?utf-8?B?eVFDdTBWV1dyNnQ1SVd1UlBRSjZsYUY3TEoxWEhkOHdPWDFkdWVBb3Q3SXF6?=
 =?utf-8?B?QmVxSHlZNlV2b1VtNGZXMWxRRTNRZXFSSlkvNUV2VU5VT3gyOTFReDBBL2NK?=
 =?utf-8?B?dEpwYVIwTmRPMmszbnpiUjFDcWNTa25JTlJqWlA5QWh6ZFZvMkNVdCt0RTJG?=
 =?utf-8?B?a0E4bm1ieFg0cFpndCtSZVFMNkpDbTk3bHV2TVZMNmdsdks0RElVaERHVnBO?=
 =?utf-8?B?ME55bUsrUVgvS0hVN05SOWhIbk1xc3dsVDIzRDUzR1NxMWtBT2RUZjdYbG9H?=
 =?utf-8?B?SWd2bjVvaEpSdTlUc0pFeEgrZDJUNHJOMHlIYXZ5S0lZMUJwSVI0Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99956c04-1fbc-4e61-e748-08def131f05f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 07:36:32.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0qvL4aEVlT6Cl4+7p+1SJGpUKwt9rbaKmClyvS7s7l011bL7fXHFkWkv7Xt5VcHj0QGw+foULrASqoO4AG9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10599
X-Mailman-Approved-At: Mon, 03 Aug 2026 11:18:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGmqeZlia5LA+Wlp9CXcGbXwrLHexys0Gwng8KSlG6E=;
 b=CZtvH8cQ0MSJHB+Ij8Fl1go8ZQlr4LfGBhpDCKMMmpjXWLVz+hD0XuqYsmFGGBV1YobuMgeRf0ptNZa/FZEddgfVFwb9tkRyf6clSPlTb/GY9Z4VClKOVqD7jSB6L6AuqWFPQQ1OOipI4CSz0oEJQ3tdR0DWGomQj73HhKhQOyN7uH78j10AtmTHZPK/+RIUwaI2hRc5Uytr6+i7clkOGp7O6veSUYpRE1mtx0SYD1oXOEi7Bl1G5i2dEI9DgI3AuEUo9aGXgr9k8nYA3szz/J7duo+HV/o3JNhur5PXYKNtt9ZnXwVuDRTxJ+ZiEbXZmxp+GBpzw4eeBcY5xTmgZw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=nxp.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=CZtvH8cQ
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
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

On 7/28/2026 10:09 PM, Fabio Estevam wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> Hi Joseph,
> 
> On Mon, Jul 27, 2026 at 3:07 AM Joseph Guo <qijian.guo@nxp.com> wrote:
> 
>> Sure I understand the bootph- properties are accepted upstream. I'm happy to upstream them.
>> I prefer to keep the alias into u-boot.dtsi because only u-boot read that alias to assgin the fixed sequence to netc PCI host controller. It is no needed by kernel.
>> Is it okay for you?
> 
> I accept the u-boot.dtsi changes, but please send them upstream.
> 
> The aliases node can also be upstreamed. There is no reason for Linux
> and U-Boot dts to deviate on this area,

Hi Fabio,

On i.MX95, `netc_bus0`/`netc_bus1` are internal pseudo-PCI buses used by the NETC subsystem for register access — they are not real external PCIe root complexes.
Without explicit ordering, `netc_bus0`/`netc_bus1` may be enumerated before or interleaved with the real external PCIe root complex,
making it difficult to predictably identify and target the true PCIe interface (e.g., for NVMe, PCIe Ethernet, or other add-in cards) in boot scripts and environment variables.


The `pci0`/`pci1` aliases fix the enumeration order in U-Boot only. Linux does not use `pci` aliases for bus ordering. In kernel, it use 'linux,pci-domain = <0>;' instead.
I prefer keep the alias in u-boot.dtsi instead of upstream.

-- 
Best Regards,
Joseph
