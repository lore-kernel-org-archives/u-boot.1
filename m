Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB5ACCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 16:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C93836A3;
	Thu, 16 Oct 2025 18:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=avaya.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=avaya.com header.i=@avaya.com header.b="OIHv1bJy";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=Avaya365.onmicrosoft.com header.i=@Avaya365.onmicrosoft.com header.b="P/7P1rfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B99C83734; Thu, 16 Oct 2025 16:42:36 +0200 (CEST)
Received: from mx0a-00186901.pphosted.com (mx0a-00186901.pphosted.com
 [148.163.133.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69691836D1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=avaya.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=amanea@avaya.com
Received: from pps.filterd (m0173334.ppops.net [127.0.0.1])
 by mx0a-00186901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G9wFel012427;
 Thu, 16 Oct 2025 14:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avaya.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201908; bh=5LIyU032uBHH13UjvLIiuCRKb
 XNmv5qo1/CSwO6rJNI=; b=OIHv1bJyQG2dMe11oxN6y5d68wSc0mPCCLM7J/qhP
 rO2A/uKMm+Ml90HkQCWdWdejLibMwiUXWbuDQ+x/CrZs/j6+nMO0udW42jm6Mych
 Rc1NAODUMAHCMyuslvZnR5db4DN3D+xG3E2SNRop5T55h7+oGUAzBbHOSR/4ThbA
 GmTQJ2yjMCgGJow4csrmdRATBBcS198cApzErbrIqr9hOVMC0tNTh8A7tjjmbxyV
 F2JF/0rE4EneuV/hFhH5rSaSczsS7DMSWXIwC5/kKlPXIggF8t2N/v8K9+R1rmqk
 JjSm7Jx3vUAQpDxHtywgLWLNRsgdhbCdTbN9cLO7t6phQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by mx0a-00186901.pphosted.com (PPS) with ESMTPS id 49t6343hwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 14:42:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBabNlrcrrG4eh9we4MaPdS59zmWuHfc69ZkSRdCa7w7w5CK2KhHZL0ZewqyigVykaU2k+ALlz4Ra5mqLH4UtfaaQ7ixuMYhw8l3YjTmbna0adAoXnCGeZfspfsDrY4nMHnZdCC2kcAADEyEwXoyJbM488c8rYQK5ZVOkH3BbtKzOp+gZmZ55GIYwFvfHtGjadqpcc2QN1r5lnQ2eZk4KJXsFKeMI4LPG5QLHnUq+crC/QY7dlLOXOG1FeHtcngYtR8THjovhXkLozj7ouJVanPmyjw6+7rSg2T58TpAxB+mvk1lFnr7YCIw6u/r2lKZwkfHaaORPgQti+r+Lrorhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIs+OYOSTyLzCnTrc2A9qnOelq/P9XZWoJTtqeWHi18=;
 b=G6BUi0Y70Ub7h4h5imDGtbO2fmbR2O6/OOFb9NJA6GvMMrEHvVO4Ynr+qZ9Ap/A07XC54lRGr+XFlrpRBKyNDPtyzEcg5akBE8kyAMuKq7NgTBqVW+O0FGEll7zKZwo+M5qhU4TETVB9kJ02UpTbaL8BrYVt1opn08y65VPCWfA1w5fpVB1jlDPj3qsRNqRFhGwjTYUpxzEYZtyPFmVGdQwSc8ZWOe2fEDr11KUO8AOtM3AMJRqOckbnA7tAU8IJIDLHzs5xwPPcTSweAIjweLmaZr8ncGMCYonNB7qOyghTGaOqupIkdDxvq+Z1OzcRdeTA6zXNvfZopaWN3eHN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avaya.com; dmarc=pass action=none header.from=avaya.com;
 dkim=pass header.d=avaya.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Avaya365.onmicrosoft.com; s=selector2-Avaya365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIs+OYOSTyLzCnTrc2A9qnOelq/P9XZWoJTtqeWHi18=;
 b=P/7P1rfMUPJF5F3WZUW8ruZBHfXFDodokxcQQZ6sCQwBZNOINMJVPpQF7TglF/3iznk6FgluXuRRwFWXpTl17fdL65VP7YqGdSQSblT7MPborz8B0TgJ6vB8DqoSAQOCw+jdqinWTD1qkzqrCE6HySCKaBGUfPdwKd7NKMfvP+8=
Received: from SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21)
 by DS1PR15MB6576.namprd15.prod.outlook.com (2603:10b6:8:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 14:42:28 +0000
Received: from SJ0PR15MB4758.namprd15.prod.outlook.com
 ([fe80::6b53:e8f:2b48:7c23]) by SJ0PR15MB4758.namprd15.prod.outlook.com
 ([fe80::6b53:e8f:2b48:7c23%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 14:42:28 +0000
From: "Manea, Alexandru (Alexandru)" <amanea@avaya.com>
To: Sinan Akman <sinan@writeme.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [External]Re: Uboot upgrade from 2016 to 2020
Thread-Topic: [External]Re: Uboot upgrade from 2016 to 2020
Thread-Index: Adw88+QOxL+rsyUwSIea/uTt5I12zgBLeRGAAAOGaoAACzVOgAATe+4AAAAOBQA=
Date: Thu, 16 Oct 2025 14:42:28 +0000
Message-ID: <SJ0PR15MB4758865E802D76404B080A98DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
References: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <20251015221933.GW6113@bill-the-cat>
 <5b6c23df-1b90-4ff7-80b9-e68f6e08f242@writeme.com>
 <SJ0PR15MB47583424C26BA0F2290F1532DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <11ae527d-5d5d-4ae7-a3de-024c2edaeaba@writeme.com>
In-Reply-To: <11ae527d-5d5d-4ae7-a3de-024c2edaeaba@writeme.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4758:EE_|DS1PR15MB6576:EE_
x-ms-office365-filtering-correlation-id: 0d0cbc0b-5f60-4a3b-6b51-08de0cc23ad3
x-pp-secret: juy7654fvc87ki.jtred3xepo0.4g2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?eFN0by9pa09iWmRudWNrVjZ4bHBnVm55R2trU28zVTRRSFBFWlIrMVd0UytY?=
 =?utf-8?B?TzRzTG8rZTdvb21oT05VS3pNNFMzdFpPVk92MlBmY2FSbzlPYXdGdEJ5TXVF?=
 =?utf-8?B?MGFoRHRjY1FiY28yMXhTdDFIRWo5aWZmZTZsbkVLTDhmUEVpNmdXL1pvVkdy?=
 =?utf-8?B?aW1xMXFKWEdJWEppYXJPMERrQlNtWUpQOXBmT1FERTNoM2JoYisyOHFGUVJl?=
 =?utf-8?B?ejJHT2cxS0h4V0UrVFBrQmQ1TTVvTTlvMjhPYkdQaCttODJBNDVOL1FPZDhl?=
 =?utf-8?B?VGpHWEkrNHlaN21zMDk2bUpwTXR3Z0xvRE1WMDQ0NkVROTBicGtvd2x0OFh1?=
 =?utf-8?B?UXoyUHVMNzkxdjVhbWdMYVhLeHdkRXgrSGExOEpLNHFibTJPSVVVbG9adTlI?=
 =?utf-8?B?d004YW1NSzM0TnF2UUlETmRHT0Z3bVRvSUlRa2RlNXNLQTNQaFpQOVI1UVhD?=
 =?utf-8?B?eGM3MHZ2VlZpU3hyWFlFTmpoeU12S0Fhdms5WkhpQkNBckpKdWkzaEFKYlUr?=
 =?utf-8?B?ZjRZODVDOTEwbTkxKzVMTWM2aC9CSlF4cUxTNDBvZEt4R1NlL1cvUGFFWjVm?=
 =?utf-8?B?eWpSMjB5d21VTEVFaDB0U1A3bURHMlR4ZXNXVmI4NDNNRThGckRVclk0RllV?=
 =?utf-8?B?VmpyVGx2cnlLdW9BOEVYZndyNnBhL3FxVkFkMC9tK2JUYTZhSWhjK3dSWURK?=
 =?utf-8?B?MFlUbStGa29MSlhSdU5rMmFqMklteC9VVkU3V2lxY1RFYnh2TVV2K0Y4K0Zr?=
 =?utf-8?B?OW1OU21aTjdDZFdFd2Y2bTB0YmhVRFc0T2pZdmozVzRYcGxxUURwTVVDejVJ?=
 =?utf-8?B?ZXE2NkUzREVabEJUdEtNb0Z0bk1hTXgwUGxLVzdHOVovL2VNTE94QW9ZZjRv?=
 =?utf-8?B?d01UMllBLzdFSVNYWWs5Z1pnbUF3YTBHY3RtdHhFbzVTeloxejIzVjkxOFlI?=
 =?utf-8?B?K1VkTWoxOTRuUkgxcWtFNEdyWUdzMlJ6cXFPY0I5SVVUNDNLYXdWVjNGSkcv?=
 =?utf-8?B?SThBQmg2N0Zpb2JmMUh6dzhHOVpFTUhVRTRmT2RYOEdaU0hlVU41T200NVVL?=
 =?utf-8?B?amtOZTJwOVByUTgrZ1l5Rm0wSzI3MnpzK3lacnpYaGRXVW5xZUZ0S1pFOU82?=
 =?utf-8?B?aTNEY3lLei93bmwxNGYxMHhnR1FtMkNtRklLa3kzTDllVE5IWkhXUnpHVHRV?=
 =?utf-8?B?RXc1UHVRdzJiMzN6STFneGpjNHQ0NzBUYWJEMTBFTDYweDNDeCtSMnZXRjhW?=
 =?utf-8?B?QzlSUkdZdm51R0h1SEpramVPSG5YaWJiOGZjbHJlU3VMc3VrNG1kcTBYMUUr?=
 =?utf-8?B?NEo0NC9WN2RHbEFObHA2Z1p6N1R6TVZBdEdOTE5JbUw4VlNTcGxDUlNtTDFX?=
 =?utf-8?B?aW43ZjgvM1V4UHI3Qm8wM0pQaFBMZFdNRnZIbFRkamtsK1dTVy9hRzBGRjJR?=
 =?utf-8?B?L25NNmpYanU5UXVPaEtON1hwNDdId0FHT0lHRVZWRERIQXF1Ukl0YndsSU9G?=
 =?utf-8?B?Z0FMbjNqc2ZVdUp5N0V3b0JSczV0am8wbktmVkIrTHBwWFJncEhyTU9Mency?=
 =?utf-8?B?ckRNWFhJV2pMK1EwbFNIRTJmUmN0ZE9WNXpHQmF0c0locjE4aVpmWXFtNE9X?=
 =?utf-8?B?WG1FSnFVQVRMZ1pEaHRSaVlUdmNrZmREdlQrcTBwU1dZK3pTeStRYTZ1dXBJ?=
 =?utf-8?B?SHdxZlMvaUpiVis3NHlqUWdhSWx4Wk9vTkpFWDNYaVBtUVcrU0ttajNzNGNr?=
 =?utf-8?B?OWhUV0hFOEI1YXlTR3pVZEpGV09xN01GcklUN01JUk9KL01Ed0FzQ3RYYmRI?=
 =?utf-8?B?YjZkQ0VNZm9SREx6a0ZBS2dPaTlSYkViRGFzUU9TQk83S3MvMWp6SSswdGhm?=
 =?utf-8?B?SEhiWHhIWitmS1Y0enZ3dS9WZEUrMEV1NTFzaWFyRUYwODBaK3BNSUl0eXdJ?=
 =?utf-8?B?YXVvZXZyNnNQa2tjNGtpSGI1cTR3b1prZjk5cGM5MTFhbWlUVkdpRVU5eWRk?=
 =?utf-8?B?NEJsM3pDbU4zU0U1bnY4MVNKUFNua0F0dnVuMFVIL042MnozQ3hHVFQ2SVJ2?=
 =?utf-8?Q?pTB3jE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR15MB4758.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJvNVFyQmZ0T0sxemtnVWhHWUtxYlBsNWsvU05rcFFwWVkwdVVxaWt1RU5F?=
 =?utf-8?B?WEt4ZFNCbDdDTEJpOERrbWY5MGliemc0NGlYeHJHZlFVOXBscFd3SVdFT0FX?=
 =?utf-8?B?aGM3OG53aE9XNjZWM0tWWTIvNHdmb0QrRVdtMmg1WXFXUFB2MHVkNUs5Y3Nn?=
 =?utf-8?B?Sm9WQkZpbVdRT3FuRnZrWG9tdXRtVkNlNGxqZTZRRlNuSlBnL2hJUnhQbWo2?=
 =?utf-8?B?SHByTFhwbURyVHVrQVY1ZHRxM0NpK1N3Q1FnOWE3Uk9qd1hUMjNwK0dtcFNw?=
 =?utf-8?B?VmpFcHNDS0l3eTBKdDRjZks3TTJaZXpLc005Y09XUmViZG83RVNvb1htUnIy?=
 =?utf-8?B?QjRwSmhUdUI1SkF0blYvNG5zWXV3Z1hiT1JiOHpQa0dRalN4RzJCa20zd05F?=
 =?utf-8?B?STAyYW5saWFVSGttWEg0Vk9jdTNsVm5iZnVCaWMvdG5pNzlhbHRsTGJyZmdj?=
 =?utf-8?B?Y3VPdjhsRDVPSzVYeVQ5S0ZVeTVtU0VwOXVUVDcreVE0MFdSbkwwWHFrVzdD?=
 =?utf-8?B?K3JyKzNKMW1rTm1ZY3FzSGV0bzdtQmgwUzRNTHAxdjhBWGxBb05wTFZ6N2Fa?=
 =?utf-8?B?Y242V1N4OXhmRDdqYUxyMTZFaTVDVFlOYXhaVDJWbUJqYmZ5c2M2MUVHbXBr?=
 =?utf-8?B?RjFUeUhXc2ZvL0tYeC9YQXRZRGNpL3F0ejF6TFZ4bEs3ZzhQdTZkMUdjamhp?=
 =?utf-8?B?eHdjaVNwcHRGOFlvTHNtSW1BWnZCVWViSGRuOTlFdlRvZHdHZFVmN3FYYW9i?=
 =?utf-8?B?RG0rVFhkbHNwUkoxcjNJVndQNE45eFJFekM3ZTdzSzJ5VUlFaXpONGowRlpm?=
 =?utf-8?B?bXgxSVVZUjk4VWU1V2V2RXB3U3ROSUVMRmlpR3puTXNXVzlPb1JDcHJSc1Zm?=
 =?utf-8?B?ZzNvTnN1ZnFZZTVjTDdvT2prbUxFNjhpMXZTb2FpcmVNenY2cDFRMTYwbENL?=
 =?utf-8?B?SnJSbXYxeUNoNmFmOVgxazREcnIyRTNaNkl0M0RCdFpFVFVuV05NNGtocHk0?=
 =?utf-8?B?Q2xONXRENUdsWjZwRHQ5dWw3eG4zdFlGNlZoTGRXQmhNWmdTaDRydm9HUk9z?=
 =?utf-8?B?UCtYTHhBVURqaHFDT1YrODdFVkhpeUtSTy9CSjRaWVRVMnNJYmdrNkgzWXZs?=
 =?utf-8?B?MGtlYldEbnNjcjloS1ZFbk92NCt5am84WVhLWTlNRzFrelN4eUZwMnR1NmY3?=
 =?utf-8?B?aEp3T0RUSkVZa0pkSW10Qmg5WnFzYjZmNnV1dmI0MDlvMG5hdndHWGFJTUFT?=
 =?utf-8?B?aThhMld4Yjl1UWhyU3F1d3VaZldjK0pvMUpISCtZeUNBMDJJY1dqNHlDWkFR?=
 =?utf-8?B?TVpMWjN1cVZMN1NWaEUvKzhyN2NDOS9rcGl5R0JVc0cwMFcrRE5iZ2ZTV3hT?=
 =?utf-8?B?SGR4KzhtVlEzanFVNHlyS1JSbDJQZzNiYW8xT0V2YjV3VFlmVXRCK3drdGdM?=
 =?utf-8?B?Vmw0ZGc1Q0FYVlB6d3JHNjUreHhCdngrQVMzZUZINHJWSmd0WTA3aS9jMzF1?=
 =?utf-8?B?bTJMSzJwMXd4RVl0RDBOQXExKytqNmpTTlJxVHBzWlpBVFNTQUg2VVZkVmVF?=
 =?utf-8?B?ZTRnbGdqdHE3Y25OeXA5ZzVudFFBOExTWXBrMitqZmwwcjVMQ012dUw2YVN3?=
 =?utf-8?B?dUt0U1YvNFh1cDM4S1RKaGFqeWlhR1Q0bUdnZ3dsc0d5akNMOTNCRmtRN1VH?=
 =?utf-8?B?Zi9lUnhYaCtBVW9URFBEYTRlUHJpdzZPdnhLalJXRkorK0RqNElEMXc3aG82?=
 =?utf-8?B?VVd0WDZUL01jeE9rdmFNM0tVNVJET1FXVmhaWDM2dkt1dVpka1RsQXJtMGtl?=
 =?utf-8?B?aDNmYmg3YlFwOVJIWUREeWRVS0VKME5SdkR2d3hGUGZHODQvNmhkRTVsazho?=
 =?utf-8?B?Sndub0JiWkswSnhSd0hLQU5WQllYOHB2TW9nYnl1K1dIRU9Od2wrU3pPTlRj?=
 =?utf-8?B?cWlFd3Qzd2FDYi9UcnNsMHZrRzJwZjdQQWtpVXhPUSthL0ZqOE5PbjBURDJS?=
 =?utf-8?B?ZGRiS2FpMThUYVlpQ04yYVZSWjlLQThVTjhGbDFrckpNcWtPWFdzWllac2xU?=
 =?utf-8?B?aXduVEJsczdYc25kckV0RmxxOXpEc1NQazR6SnlZeHJPQXZVbWhnWXBnUjAz?=
 =?utf-8?Q?KSSE=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U4p7uYnslfPp+7361KvalUJo9a1ovPGMhTBhoRyxb/2ddLc8KHw92zGfYQYQohrqVyP8XAjJ03wkH0xiC+WXrfb5JRwK/2OKer+8IX34xlAZd+GezIGlQyLynVdn0aNKK6vtOTJ1RKv3Gwwa3IfD1XTtU7B+pxfu0zKsDZ1p+gsZe8zS7ezZwTNKvX76dE0OInZjEpNYjap53jwnpaoW/f+A0/d4IhqZsuLOptrzIQ4vLVGVsSFWT+WsJ7Hdjm6OOpYU95PbFrqzYVorHVd1/AWZ8LrFRClcX5uQgcch8U2SNIyAkixDutBmvT8fAP6JpL/NOTbbvoj4SYzGTXfX1zdp77wfMkpBZ1kgCfzQF0MFg/OAunyC7le6UNK/7fv70PM0W6nwZbesxG+J4FV/YCmnRcxp5l187G/GqaF2FrfnZTpK0pbBFTSncti8QDC/TiFev170JBX8rqks3xBXO8EHFeYZF6TJoyLiA1L0vcNxNUAOd0zeFBet85ZXFPoabUyN/4Xvdedx4RCJZL/I5jS6iSXO2/poh2FDA8t9k04AL71UHua/hlzCI9JjOxYsEQEvZ46ej50TPbJjJsnkppmDN/m1j1JTcHsIq14R4/tpWTMg7pXKFTxw51+siFIt2yapES4HwQLXBc0ViDTNwQ==
X-OriginatorOrg: avaya.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4758.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0cbc0b-5f60-4a3b-6b51-08de0cc23ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 14:42:28.3121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04a2636c-326d-48ff-93f8-709875bd3aa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWAmMf6lQcf2Q6Fx/SJuveKCLyF4io9v5vTyIKmTfSX4mBLjicoVZIhm/SKTiUvH3i3y1AfMqxtd6CnJ3grFuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6576
X-Authority-Analysis: v=2.4 cv=GcwaXAXL c=1 sm=1 tr=0 ts=68f10456 cx=c_pps
 a=QL/sESuk+SKO76CEZ3+3jA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=7_b1JmNPT6gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RpNjiQI2AAAA:8 a=DDUcpTWQAAAA:8
 a=k-42gJp3AAAA:8 a=gEsRDbIwAAAA:8 a=Q6g9bNBVAx5FcieDF_QA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=mtpYKCzodJLwKjil5acA:9
 a=b7rkPB3mQfXVOmve:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10 a=IzUggT93oxiDeI-kYzx2:22 a=uCSXFHLys93vLW5PjgO_:22
 a=9PIBWyluFvSNxe44y-eH:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: MC8hekffGAI31CIVnlo--Tx5hFTB2qgV
X-Proofpoint-ORIG-GUID: MC8hekffGAI31CIVnlo--Tx5hFTB2qgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA0NCBTYWx0ZWRfX3QbkIj61wsAZ
 OQnUr6O4rfaRx8dTGOGMPI3tZiXfyLeOFOc9NKQJjrGTYWlwOBUKAWF5k8o7IAkHXnHuapuBQ6N
 FF5+0f8/PaZ8tbrRBzWss8KfoaGVwL3JMorG1YcHknJUF3ZO6zgqCtMRPXdMGof+O2Ap4kptTmN
 kks0o4wRq0/99oyuxHj+kBi3k8b35LMY3NIudiZ189gRgh9lX4oMQGMgBm/knqQuRMcNkj0Ac+p
 wxeGAK9ArKTKK621RLIzEZFbeMD5rHJznEsIaT3TFjBqmCSWrG/hX+pMmZ6s0ztGG91JKyZT/jB
 XrIDyNojtJg4jFaY54jXTHjU7MM+NJNInTS6yfApa5dvAsjsR5EZlJ/PgJA5i9KFNSthtCxwuuP
 4ErdejcSnQIBZ2KWWdLANteawyqviw==
X-Mailman-Approved-At: Thu, 16 Oct 2025 18:42:11 +0200
Content-Type: text/plain; charset="utf-8"
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

Hi Sinan,

We have a very limited supply of boards, maybe one we have everything ongoi=
ng we could arrange for one.
Is there anything I can provide so you could help me out a bit? I=E2=80=99m=
 stuck with this hanging situation and I=E2=80=99m running out of idea why =
it=E2=80=99s not working=E2=80=A6as it matches most of the old working uboo=
t settings=E2=80=A6

Regards,
Alex

From: Sinan Akman <sinan@writeme.com>
Sent: Thursday, October 16, 2025 5:39 PM
To: Manea, Alexandru (Alexandru) **CTR** <amanea@avaya.com>; Tom Rini <trin=
i@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [External]Re: Uboot upgrade from 2016 to 2020

Hi Alex On 2025-10-16 01:=E2=80=8A26, Manea, Alexandru (Alexandru) wrote: >=
 Hi Sinan, > > First thanks for replying. I do hope you will be able to hel=
p me a bit. > The board is PPCE5500 used for Avaya IP500L platform. > > Wha=
t I noticed


Hi Alex



On 2025-10-16 01:26, Manea, Alexandru (Alexandru) wrote:

> Hi Sinan,

>

> First thanks for replying. I do hope you will be able to help me a bit.

> The board is PPCE5500 used for Avaya IP500L platform.

>

> What I noticed for hanging is that it hangs when setting mtspr    IVPR, r=
0 in start.s although this seems correct: CONFIG_SYS_MONITOR_BASE@h

>

> Regards,

> Alex

>

> From: Sinan Akman <sinan@writeme.com<mailto:sinan@writeme.com>>

> Sent: Thursday, October 16, 2025 3:00 AM

> To: Tom Rini <trini@konsulko.com<mailto:trini@konsulko.com>>; Manea, Alex=
andru (Alexandru) **CTR** <amanea@avaya.com<mailto:amanea@avaya.com>>

> Cc: u-boot@lists.denx.de<mailto:u-boot@lists.denx.de>

> Subject: [External]Re: Uboot upgrade from 2016 to 2020

>

> [External Sender]

> Hi Alexandru On 2025-10-15 18:=E2=80=8A19, Tom Rini wrote: > On Tue, Oct =
14, 2025 at 10:=E2=80=8A21:=E2=80=8A37AM +0000, Manea, Alexandru (Alexandru=
) wrote: > >> Hi, >> >> I have an issue with upgrading our sources to use t=
he 2020.=E2=80=8A04 uboot rather

>

>

> Hi Alexandru

>

>

>

> On 2025-10-15 18:19, Tom Rini wrote:

>

>> On Tue, Oct 14, 2025 at 10:21:37AM +0000, Manea, Alexandru (Alexandru) w=
rote:

>

>>

>

>>> Hi,

>

>>>

>

>>> I have an issue with upgrading our sources to use the 2020.04 uboot rat=
her than the one working now on our system which is 2016.

>

>>> After adding all our board changes, I can see the SPL loading and setti=
ng DDR and TLB entries but once it tries to jump to uboot from mmc_boot() i=
t hangs and I can't get to see anything...has anyone encountered this? Is t=
here something I can do to make sure uboot is actually being jumped to or w=
hy the hang? I've set the offsets to go to the _start_e500: instructions li=
ke the old uboot. I can share the traces I have if needed. Looking forward =
to an answer.

>

>>

>

>> There might have been some issue with certain PowerPC platforms

>

>> introduced after the v2016.xx releases and fixed later than v2020.04,

>

>> and git log might help. Of course, it would be better still if you could

>

>> move to current mainline and then help with PowerPC maintenance, as we

>

>> do need more people helping there. Thanks.

>

>>

>

>

>

>

>

> Which board is this for ?

>





I don't have access to P50x0 or T10x0 boards to test and debug this

but I might try to see if I can get my hands on a T1040RDB or one of

your boards (e.g. IP500L). As Tom mentioned any help you can provide

is definitely very welcome here in this area.



-- sinan
