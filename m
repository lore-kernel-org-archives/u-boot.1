Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD0BD1F9AE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2935983C19;
	Thu,  4 Dec 2025 11:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZH8m4TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E05283FA7; Thu,  4 Dec 2025 11:37:17 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D7083C19
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUuoAsy4ZvqjfFiRQDU3T934sXgS+cSq2Eaxb6dTqDIC4U9RJ1CFv0x6MAWtlMoTbBM7gyZNJ60Y0YBcwMZYUcmZAUV9CHYM5+/19QaTd4vWB5s3dM9EzSUyWPV7SE/JGr0ZhpotEk5JuHz06hibyBL81DtZsmfC4Y6MglUMaJeEeKMgirhNlXu4ftjgzJAG9c+TwONQfoJNeGewnUJhM51MiJiHuKSoqri2LWJwBH3WS96kVd3Oc82g2v5G4FjhuZw96PlngKmMu5ffFgEG4J95ZEBC/WFUYcq4xydHwJX1ISp5HKY9KQ0NIOY9c1RTWA9L7rJHuCBb/DLoljGUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aH8Xhpv+qvViI/s9Mq9ddfK9/oaqdMRfON2RH7VfKc=;
 b=AoQRlNP21lrT1KiQE2vQiCXkYt/d0MxLrsRFdvfTc8OGluGEhZNKM9lhFf15iLuy3R6RPIIdTGh05/WJCnLSGtYHtQwP05WyN2jUPtJ7lnSyaof74KQ2/gTdnUqgduFFXUHEfIx4TI9ZNROaFZ75kvxC79TvQ+umFBqs8HplTMCXxjHreDwCGmumhCTygqu6IvoBw4SRrYYABLtks/hcl2xxoojCQ1jqUM9/ljySY40LfAsKSSeOkedFbnpYrYgu3hGYTaKmjKavqmSN+BJN/shYbjn/xegBAF+pGe2vw0TcFX2B9Pwwy4CsmsatIWzGlJ1yM/K40F5z7eXNR+ABDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aH8Xhpv+qvViI/s9Mq9ddfK9/oaqdMRfON2RH7VfKc=;
 b=dZH8m4TOT+Veq62ph6TBbaSxa+BgJw2tuaVQtq5ooOZqhVD2xaHbTaajqPTvhWH0N+3WCarG3w/3ll+abtT1gz7SSqYyfOWHpeXWKGhFKzcR/s+YoeTJfcTSXbO0XMU9BQdYvIwbD7iQDqlL12uD8XnMxwQTIVSARV6LZs1hehM=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:37:10 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::5f77:799a:c1c8:cd04]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::5f77:799a:c1c8:cd04%6]) with mapi id 15.20.9366.009; Thu, 4 Dec 2025
 10:37:09 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Toomey, John" <john.toomey@amd.com>
Subject: RE: [RFC PATCH] efi_loader: disk: Add print to show ESP device
Thread-Topic: [RFC PATCH] efi_loader: disk: Add print to show ESP device
Thread-Index: AQHcZQMmAA0ZcmDSdkyz3pYj7XYE47URP82AgAAHGgA=
Date: Thu, 4 Dec 2025 10:37:09 +0000
Message-ID: <CH0PR12MB5266A55AA6ED3D7B462232FFECA6A@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20251204094758.2800428-1-padmarao.begari@amd.com>
 <7f6afc17-ccc2-4d7a-b8e4-a5a4c1cf0945@amd.com>
In-Reply-To: <7f6afc17-ccc2-4d7a-b8e4-a5a4c1cf0945@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-04T10:26:34.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|MW6PR12MB8898:EE_
x-ms-office365-filtering-correlation-id: 1efccfe0-c403-408a-bb27-08de33211418
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SVR3R29CbDNoV2lOdk1VSnJQWGxkRkdTeVlUQTY2TWRtamZFYTFKN0Vjd3ln?=
 =?utf-8?B?ZERsR2Eyc0tRYVZqUzVzSm9nbVdzZnpHeHk4emJKUEZkSHZGc2pQSTYxaC9J?=
 =?utf-8?B?TEtSUDdjMWx3RDNVckVoWDZLUzRobndkUVJRWVZTN3J2dlkyOHcxVUdTSG5K?=
 =?utf-8?B?cjl6NnNpR0lSZDhIM3hjSyt4VERrRERGa2ZFYlg5TlJ4L3dwa3MvRWI5cnJP?=
 =?utf-8?B?VjBDaUVYNlVhZ0NoQWJlcXBtamtZVHpyMS9oREF2RWtEdnVVYlVJWkZLa3Z1?=
 =?utf-8?B?a2ZwMmF3TTNzOTE5bUhQUkVCRVArbHJ5KzlvUDZtUXhsSkxuek1uWTI4cW1Y?=
 =?utf-8?B?UDdSRlh6N3EwVWY5bmNaMEVkeUc5Z3ZzNGlrRVlrRisrN3M0YlVXYWZrZUx6?=
 =?utf-8?B?NXZOLzFBN3diUnlocDdWVFFMd0FWcEZVQ0xoVDlZTkZsMHE1Q21iUWdLU0Vp?=
 =?utf-8?B?K3BSTXEzWE4yR2dFa0pORUs1QUh3dTk3c0VUSkdkVTJVWllMN2cydnliZ3hC?=
 =?utf-8?B?WUF1b1BZekt4SEliZ093VFRCUkwxRHFWeVhNd0kyVkIvQ1Rob2VHWG5sbkFi?=
 =?utf-8?B?K1JVWk9ZYUl6L2h5emVFbXJheVM1cGtpOGF0WS84T2NFQkpxdEhNdVVyWGtN?=
 =?utf-8?B?MUxmK1F6MUlkajlLY0oyKy9rMTF6ZHA3N09sdUNVQ29BR0RHNERTeGZJODFC?=
 =?utf-8?B?SjNqc0FOd01TRkJhMU0vbCs0MGYybUlzNGdBK2xlOVRuZm8vYndLblNNN0lp?=
 =?utf-8?B?N0gyZDNzRDZPeVllK3FEYkxtZkJBei80bGpZK0tOQXdMWjlRL0V5dUZXUTRa?=
 =?utf-8?B?K0NpNlNpRHRvZlJpZE5JQ2l1SEp4UjlmTVlwRXNWcDhQL2I4QjEvN2cvaGlx?=
 =?utf-8?B?RlFkWjNpWU54SVJtVUF6VHJ4blpMN0s2cXJlUHRIY0ZENmh6bVZ4QTZ2Y1cr?=
 =?utf-8?B?TzZncDVod3dUTkRXcS9LT3JVUXFiaWJEUFpJQzdJcmduN3ViSVZURTNnRFJy?=
 =?utf-8?B?ZlNxTlZqam1lRDc0enZUUGdsa2NGTlllS3Z1Y21oTzdNbGhhZEhjMzNSVnNh?=
 =?utf-8?B?dlVyNlRqdFo4R2pyZ3hFZktxZ0hQek5WUmtRaVFHR2hNaFRDekNBaUVYVHNL?=
 =?utf-8?B?cDlBTFhSTHJmcjFsWFdtcVk0QVlYZmYyUUl5VkJBdWtwSkRhRGIySzVhRkNB?=
 =?utf-8?B?cDl1d2Y1bVpTRHVuajlmeTZsdGpqdi96bDk2V0ZacU5FZHU1aGVoVnJ6Ymwr?=
 =?utf-8?B?Y0NYUWxlOGtaY1VlMkQvR3RaaERyMEdLNllGblN6SXVoTUR6UFRCUFVrTUtL?=
 =?utf-8?B?RlZVditKRzg1ME1wOWYxQmZnUUpIaXlucjk0Vk5zL2I3RGM2Y1ExSTFvNk5w?=
 =?utf-8?B?ZlRDZWhiOFhweUFPbklHT1UzWXpFUWI0dUZuZUhaeXJEbmNLaGFzb1p0Tm1R?=
 =?utf-8?B?c2RQTnJtWVFIVHpYYXM5RlRmZzd0TlhUSEtldEx6WFRZdmpRd1JFWkdOb0NC?=
 =?utf-8?B?dUhPZFJzWUEzcm9MOS9ORFliKzFXczJrMyszaGRvVlplczdFanQxYU1rR0tt?=
 =?utf-8?B?YVgyQ0V6SGtWb2Jod3lwbzZ3S0FzZjVCKzNwekY0OW1EYlQyVmZtQWhRUndn?=
 =?utf-8?B?NzdLSGVueW4xNXVvQU0xSEtxMElYa3FZdmN2REFERjlXWThvaVhCcDRhc0th?=
 =?utf-8?B?a09uTEtCZjh3WVU3OFJlRUViOHI0WDRLS3Rsc1ZtQzkwZ1ByU1B0M0NtWEph?=
 =?utf-8?B?VUJuN0VsTGJnRWdySHZQUEZKait1REZBbVlwRDdXQk5ZWS9jK2YzQ0Qyalho?=
 =?utf-8?B?Umk0ajZwVWNzZ214MzI1TWtha0IrRWFFWEVrd0hSMHBQMzFtbFZQZnQ2STA0?=
 =?utf-8?B?M2JHQitzaXN3NkRZbDVId3lBalFGRXBoL0hnb1dKY1EreEtnaWNZaldqNERt?=
 =?utf-8?B?OS84eTJIdENDTDlwNHZKWjNsNHZTMWY5b2N5MnlZc09RYlA0STBVUDVHWmQ1?=
 =?utf-8?B?NHNRZ2dqQnF5bWJKMVROcWVDU3p2azdSWHBkcmJLMWNKaDV4Q1JSVjFGTzdL?=
 =?utf-8?Q?vkk+7Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVgwOXl0T0lENnh4MEFTZ3dzYjM1WS9sUG8wQUdKM29WNFdEeVpadjdhRWRm?=
 =?utf-8?B?VjlZdjJwL2UyS1p2Rm9nclBnUExHSHUrd3d2N0t6dGM3ZGowSXNaMW1BYlF6?=
 =?utf-8?B?Tk9lN2twcnFKU0hwc3UzanNMZ2x4Qi9nUXBjUXBuUExncm9tSVN0aW9aWDFL?=
 =?utf-8?B?RkNnQkFZSndCTHFZMUJ0aDcyZy8rNzFkQUJPSWI3TE03MklZaXZ3aVV5QzJz?=
 =?utf-8?B?eTRWaEdUT1dMRXRaaUgvMytubDVSWHkzNm0yejNIZkhnNE9xOHhRdTFzbFhB?=
 =?utf-8?B?ZGlHcFBNdjFXSTNCdEdvK2c3U21OazNrVXBsQnpLMmlRQzFkQVFQSTFVcWo1?=
 =?utf-8?B?NTFRWW9WZTI1UlAwM1lpbGo3bnpLQVhOUlRMMlNyQjFyQmprNHZsYzhUTFNl?=
 =?utf-8?B?aGRpb2llVTdSVm9qa05xRE1icnJZZEdWZm9NaDhDMDhlMlMxWG40eHhiTWIv?=
 =?utf-8?B?ZDAxbld5My9kNjlmZ3ZzNGQ5SHZCeU5UMU4rN212WUdicCtFcDRLczZmSm45?=
 =?utf-8?B?MjFGKzQ4UmIxbUpYd2FFNXF4L3ZwdlhWMU1sR25HYStGa1dLSCttVTRtWHhP?=
 =?utf-8?B?TzRZQ2pIZE5NblB0RXV3R1FseEw5ZklnZWhmeFYvZzJ2VDg3TElCSkUyTy84?=
 =?utf-8?B?K3pNUDNYV2cwVDVMUGJJUE5vRnMrNEd1R0twZ2I3NUhoVUc3QWF4RVNmSG9R?=
 =?utf-8?B?VGUzV3dIYUFJYjVKQ3NBdFNGazNpei9pNEgyTXpHR054eHJuMVJaM0s0VWJF?=
 =?utf-8?B?NEI2anREVnROdjQxV3ZyRU1ObE5KcG9CZ1E2RFJXaHVGM3QrNTZYUnlCNVVk?=
 =?utf-8?B?QmtDRUJaT09LeVVBQUZlNkU4ZHVDMmU1UHFaNElocVRDbkxxem51d3lYMEMz?=
 =?utf-8?B?UGJIdUNrcFRMNXMwVDhjN3F5VE45MklLb0hYeFN1RTZBbThldXVPNGJ5OGpY?=
 =?utf-8?B?eDdlYWowSjdOMnRBekFtUnc0VGhNcHBYenQ2SVFlekpYZ3dBa1JqQldyYWFV?=
 =?utf-8?B?WjdERWtEUmx3MVZiTVpKdkUvN2U5NFlUYVZNZjJHeldNVlRPRFM2LzBVS0hC?=
 =?utf-8?B?QzZFWko0Z2dvMFlNdjEydHhYL3ZLaUhJY1FkSXhza0Jrc2FiajhOQURnSmpN?=
 =?utf-8?B?NkxFZk9zYjZpdnFVYkdEWXRTekkzOWU0UlUvRnRKMDBtQzdHOTR6L0tiRXJO?=
 =?utf-8?B?N3VOMWx1dGlWREpkUnBnS3lIMmY2bUd0OG1vMU1ESktrbkpEdldQWTZNUmtH?=
 =?utf-8?B?d0JScGF2WlloWEJ6ZWVXU3BJUTFNb2x2emNZU0N5WDJTaGoyaUJoOEVPbVkw?=
 =?utf-8?B?SHc3dnl5dFNIWlBDUGdhaU1IcGNTOTRyNXFHdk4yUUY5RXh1cGVzVVVsNFU1?=
 =?utf-8?B?MWtqZFZ4UStnU3NVVXBsdzcxSzdWalZnUmZ3UWRDLyswK01ZMDFGUHFyZEIz?=
 =?utf-8?B?ZmJWa25PaDV0SWoydHVBR0hjZDRkRHJadmk1bTdKeWJRbzlUbU9SZ2lIVHJS?=
 =?utf-8?B?MktFZVBoUFVQR0w1RjhQVjNqQmVhNnNGUDhPRzNWeUJmek5BSkZFMU9TTllT?=
 =?utf-8?B?elNPZElWYW84bDg4UVhCaUlFMHp0SmhRdE9xR3R3aE5MTGYxcWx0ZFBKSUE1?=
 =?utf-8?B?MWZhOHlKOGowK2dZQjJtL0xwWndUOE9wN1JBQXJlMU9mLy9EZ1NJWVdTVElz?=
 =?utf-8?B?VlZiLzRhR0tNYlAwZmVwK0I2Z2Q5Z3FKTktRcEdFc1NHVm5ZcjVKRkxTVzRR?=
 =?utf-8?B?Ry9PQ3NYaE02eFlhS29YZUoya0N3SEJsc0pYUkp6UGpOTVdGbGdwZVdNeFQ0?=
 =?utf-8?B?cDUvWWMweldKdmxYaGhFUWFPYU5WOCtsM01BVUZqb1JaSzNZVHNNODJkUExo?=
 =?utf-8?B?SlZGSHZiQWh0cVpTMSswS0gxUFBPY3hXQU10U2pleEdadmU1a096THZDbjRn?=
 =?utf-8?B?M2lwak1WbHBlN2NHSU1GN2JHMGpQaHNnaXliMEpQU1ZuSExIaGs0VTgzZ3FI?=
 =?utf-8?B?ejFLczAzb2I3SzV3cXNQSnpiWkRhNk1TSWZwWE9DWW1jNnp5eE1FMk84T09T?=
 =?utf-8?B?N0NjYjNWSnhCZmRKWlkveHkxaStIWFFLdnR3UitNeTJYWlg5T1JFRmtwWFM3?=
 =?utf-8?Q?Gn3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efccfe0-c403-408a-bb27-08de33211418
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 10:37:09.6932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdpKhXtBUOaHt06irQVkcXc/O7SZ/soydYowsZiI1RYYOVaMLOvBAsfYoX3p0sDNopLho1/B7EjejfWX+lwW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiBGcm9tOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIERlY2VtYmVyIDQsIDIwMjUgMzozMSBQTQ0KPiBUbzogQmVnYXJpLCBQYWRtYXJh
byA8UGFkbWFyYW8uQmVnYXJpQGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gaWxp
YXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnDQo+IENjOiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1k
LmNvbT47IFRvb21leSwgSm9obiA8am9obi50b29tZXlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0hdIGVmaV9sb2FkZXI6IGRpc2s6IEFkZCBwcmludCB0byBzaG93IEVTUCBkZXZp
Y2UNCj4NCj4NCj4NCj4gT24gMTIvNC8yNSAxMDo0NywgUGFkbWFyYW8gQmVnYXJpIHdyb3RlOg0K
PiA+IFByaW50IGEgbWVzc2FnZSBmb3IgZGVidWcgcHVycG9zZXMgd2hlbiBhbiBFRkkgU3lzdGVt
IFBhcnRpdGlvbg0KPiA+IChFU1ApIGlzIGRldGVjdGVkIG9uIHRoZSBkZXZpY2UgdG8gaW5kaWNh
dGUgaG93IG1hbnkgZGV2aWNlcyBhcmUNCj4gPiBkZXRlY3RlZC4gT25seSBvbmUgRVNQIGRldmlj
ZSBpcyB1c2VkIGZvciBjYXBzdWxlIHVwZGF0ZTsgaWYgbXVsdGlwbGUNCj4gPiBFU1AgZGV2aWNl
cyBhcmUgZm91bmQsIGl0IG1heSBpbmRpY2F0ZSBjb3JydXB0aW9uIGluIFVFRkkgdmFyaWFibGVz
Lg0KPiA+IFRoaXMgaXMgZm9yIGluZm9ybWF0aW9uYWwgcHVycG9zZXMgb25seSwgYXMgdGhlIG51
bWJlciBvZiByZW1vdmFibGUNCj4gPiBtZWRpYSBjb25uZWN0ZWQgdG8gYSBnaXZlbiBib2FyZCBj
YW5ub3QgYmUgY29udHJvbGxlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhZG1hcmFvIEJl
Z2FyaSA8cGFkbWFyYW8uYmVnYXJpQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBsaWIvZWZpX2xv
YWRlci9lZmlfZGlzay5jIHwgNSArKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9lZmlfbG9hZGVyL2VmaV9kaXNrLmMg
Yi9saWIvZWZpX2xvYWRlci9lZmlfZGlzay5jDQo+ID4gaW5kZXggMTMwYzRkYjk2MDYuLjgzOTFk
ZTE1MjdjIDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9lZmlfbG9hZGVyL2VmaV9kaXNrLmMNCj4gPiAr
KysgYi9saWIvZWZpX2xvYWRlci9lZmlfZGlzay5jDQo+ID4gQEAgLTU2NSw2ICs1NjUsMTEgQEAg
c3RhdGljIGVmaV9zdGF0dXNfdCBlZmlfZGlza19hZGRfZGV2KA0KPiA+ICAgICAgICAgICAgICAg
ZGlza29iai0+bWVkaWEucmVtb3ZhYmxlX21lZGlhLA0KPiA+ICAgICAgICAgICAgICAgZGlza29i
ai0+bWVkaWEubGFzdF9ibG9jayk7DQo+ID4NCj4gPiArICAgaWYgKHBhcnRfaW5mbyAmJiBwYXJ0
X2luZm8tPmJvb3RhYmxlICYgUEFSVF9FRklfU1lTVEVNX1BBUlRJVElPTikNCj4gPiArICAgICAg
ICAgICBwcmludGYoIkVGSSBzeXN0ZW0gcGFydGl0aW9uOiAlcyAleDoleFxuIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgYmxrX2dldF91Y2xhc3NfbmFtZShkZXNjLT51Y2xhc3NfaWQpLA0KPiA+
ICsgICAgICAgICAgICAgICAgICBkZXNjLT5kZXZudW0sIHBhcnQpOw0KPiA+ICsNCj4gPiAgICAg
LyogU3RvcmUgZmlyc3QgRUZJIHN5c3RlbSBwYXJ0aXRpb24gKi8NCj4gPiAgICAgaWYgKHBhcnQg
JiYgZWZpX3N5c3RlbV9wYXJ0aXRpb24udWNsYXNzX2lkID09IFVDTEFTU19JTlZBTElEKSB7DQo+
ID4gICAgICAgICAgICAgaWYgKHBhcnRfaW5mbyAmJg0KPg0KPiBob3cgZG9lcyB0aGUgb3V0cHV0
IGxvb2sgbGlrZT8NCj4NClUtQm9vdCBpcyBzaG93aW5nIGxpa2UgYmVsb3cgZm9yIFNEIG92ZXIg
VVNCIGFuZCBVRlMgZGV2aWNlIGlmIGJvdGggaGF2ZSBFU1ANCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkluOiAgICBzZXJpYWxAZjE5MzAwMDANCk91dDogICBzZXJpYWxAZjE5MzAwMDANCkVycjog
ICBzZXJpYWxAZjE5MzAwMDANCkJ1cyB1c2JAZjFjMDAwMDA6IFJlZ2lzdGVyIDEwMDA0NDAgTmJy
UG9ydHMgMQ0KU3RhcnRpbmcgdGhlIGNvbnRyb2xsZXINClVTQiBYSENJIDEuMTANCnNjYW5uaW5n
IGJ1cyB1c2JAZjFjMDAwMDAgZm9yIGRldmljZXMuLi4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkVGSSBzeXN0ZW0gcGFydGl0aW9uOiB1
c2IgMDoxICAgICAgICAgICAgLS0tLT4gdGhpcyBpcyBmb3IgU0Qgb3ZlciBVU0INCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjQgVVNCIERl
dmljZShzKSBmb3VuZA0KICAgICAgIHNjYW5uaW5nIHVzYiBmb3Igc3RvcmFnZSBkZXZpY2VzLi4u
IDIgU3RvcmFnZSBEZXZpY2UocykgZm91bmQNCnVmcy12ZXJzYWwyLXBsdGZtIHVmc0BmMTBiMDAw
MDogW1JYLCBUWF06IGdlYXI9WzQsIDRdLCBsYW5lWzIsIDJdLCBwd3JbRkFTVCBNT0RFLCBGQVNU
IE1PREVdLCByYXRlID0gMg0Kc2Nhbm5pbmcgYnVzIGZvciBkZXZpY2VzLi4uDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkVGSSBzeXN0ZW0gcGFydGl0aW9uOiBz
Y3NpIDA6MSAgIC0tLS0+IHRoaXMgaXMgZm9yIFVGUw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQogIERldmljZSAwOiAoMDowKSBWZW5kb3I6IE1JQ1JPTiBQcm9k
LjogTVQwNjRHQkNBVjFVMzFBQSBSZXY6IDAzMDINCiAgICAgICAgICAgIFR5cGU6IEhhcmQgRGlz
aw0KICAgICAgICAgICAgQ2FwYWNpdHk6IDIwNDgwLjAgTUIgPSAyMC4wIEdCICg1MjQyODgwIHgg
NDA5NikNCiAgRGV2aWNlIDE6ICgwOjEpIFZlbmRvcjogTUlDUk9OIFByb2QuOiBNVDA2NEdCQ0FW
MVUzMUFBIFJldjogMDMwMg0KICAgICAgICAgICAgVHlwZTogSGFyZCBEaXNrDQogICAgICAgICAg
ICBDYXBhY2l0eTogMTAyNC4wIE1CID0gMS4wIEdCICgyNjIxNDQgeCA0MDk2KQ0KICBEZXZpY2Ug
MjogKDA6MikgVmVuZG9yOiBNSUNST04gUHJvZC46IE1UMDY0R0JDQVYxVTMxQUEgUmV2OiAwMzAy
DQogICAgICAgICAgICBUeXBlOiBIYXJkIERpc2sNCiAgICAgICAgICAgIENhcGFjaXR5OiA0MDk2
LjAgTUIgPSA0LjAgR0IgKDEwNDg1NzYgeCA0MDk2KQ0KQm9vdG1vZGU6IEpUQUdfTU9ERQ0KTmV0
Og0KWllOUSBHRU06IGYxYTYwMDAwLCBtZGlvIGJ1cyBmMWE2MDAwMCwgcGh5YWRkciAxLCBpbnRl
cmZhY2UgcmdtaWktaWQNCg0KV2FybmluZzogZXRoZXJuZXRAZjFhNjAwMDAgKGV0aDApIHVzaW5n
IHJhbmRvbSBNQUMgYWRkcmVzcyAtIDhlOmQxOjQ5OjRjOjNhOjkzDQpldGgwOiBldGhlcm5ldEBm
MWE2MDAwMA0KWllOUSBHRU06IGVkOTIwMDAwLCBtZGlvIGJ1cyBlZDkyMDAwMCwgcGh5YWRkciAw
LCBpbnRlcmZhY2UgMTBnYmFzZS1yDQoNCldhcm5pbmc6IGV0aGVybmV0QGVkOTIwMDAwIChldGgx
KSB1c2luZyByYW5kb20gTUFDIGFkZHJlc3MgLSAwMjozYzoxMDo5OTpiYzoxOA0KLCBldGgxOiBl
dGhlcm5ldEBlZDkyMDAwMA0KSGl0IGFueSBrZXkgdG8gc3RvcCBhdXRvYm9vdDogIDANCnZlcnNh
bDI+DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCj4gTQ0K
