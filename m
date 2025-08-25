Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC8ECA0EED
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 17:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9219E82DA1;
	Mon, 25 Aug 2025 19:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SXpJqejm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3F783020; Mon, 25 Aug 2025 19:44:47 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4527082C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 19:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6G0PsbvwAPxv6w1m/P0HY8zl9QRqwimkhp/0IH2WS4aLBzVhWcUAp19tCvD6ArPO8WJO/d+xnteNEFbuwCZ3UPyYTGPS4v9nV+QdhSGefHUGOz0b9jwBtC1+cNbt7XVVw9pQ5ofbLnPzu2rsze1SAqGTk288zWYLol8mdTJM3c+THVDLV7fcvzjSr7YzzUgUFGnaY3ElVyVTvQBD/m3LibXxljn8kmRRfPSQhdHcQ/aovtzvqEsdFpDaLs/sVjVYElVtjMBLDMhMQYpJLNKpb/zZkUzZK6pQ+wszi87chSsHBsnZ+WzgjXLLad7CySH/93zKBbQoeN8P/UWSQMW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cRmswlMRC5PSU/IB45oKcGqBo8z5Fs4cSfCi4VVxA8=;
 b=w/IWbNOM4CsYwM166lXruz2pqoKpEyy0poydRb7WmW7of1hgdtrdSzUTxWj+zJ8QES6WpwGEOh8ER0HX12dxIx1U6pTYeQCNRC+c+oR9d6qILsuBfAUuBJoLDxoEhlVCOZKFOnVtCHLLffhOb1hB1TFhn3qzlcmwRy7davoUr5KXV8YOng6joLb39eg6eNtmGZI66dliNfScGSDg4RYAluHaTw6vZ2bvUMyRc0eYDO0rBp95hD8aFatjLPKOVUY9vtGG9G8fkG2DExPe3u0fCQSkOFwAatdOhNeu58qLQLRWN2StIiRyCPry5iu1GxjZJ1i1opVEhF+fQW+ykxhxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cRmswlMRC5PSU/IB45oKcGqBo8z5Fs4cSfCi4VVxA8=;
 b=SXpJqejmtKtVxp+4YKJ3gNjl5GOPrdp3MUYGyIyIJHdQmG1PDAPlzQOt4FNxw+tMck1T4LrUo4iGJXeQVUckJLXWjjzf8T926TkhQio6gSPG/41/B3L6efJQ9E+aKuWYA7v9GiAvF0iazvfyUjIoTiCVLGRT9MyQey7QLl9EGyauk4td+FkBa/Eb6VX1RS1yi4vEjEpfp0QRdMUSz5886JOnaRUKlMIiiOeZC1c7gByggcawehUsEAFDyhNBWqk8x1CF9sJ4ZcRob/Fuoo48TSqO/j22H65JX1E7NPrke8AL6MyR/WqQfCVBL6e8gudEaz+JVpvs85HKg86Sou8HkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DS7PR03MB5592.namprd03.prod.outlook.com (2603:10b6:5:2c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 17:44:42 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 17:44:41 +0000
Message-ID: <e63533c9-2fd6-4eef-bbdc-324742a3c455@altera.com>
Date: Mon, 25 Aug 2025 23:14:27 +0530
User-Agent: Mozilla Thunderbird
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
References: <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
 <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
 <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
 <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
 <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
 <6935fd0b-8027-48a0-b9ec-076535d929b9@mailbox.org>
 <9879ace5-88e0-40be-8b49-4e3baee5c1ec@altera.com>
 <20250825135914.GR124814@bill-the-cat>
 <DS7PR03MB5542E8B85D8091B5C53A14D8BC3EA@DS7PR03MB5542.namprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <DS7PR03MB5542E8B85D8091B5C53A14D8BC3EA@DS7PR03MB5542.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::12) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DS7PR03MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c80c4d-c2a7-4dc7-7509-08dde3ff11da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzBCNlVLK25QcWNKMDVzRUZOSS9tSWF3YXRCSjNpNmtaY0xRbDBpQjRMQktD?=
 =?utf-8?B?VTRiSG9YdEl0cjQyYUxrcktPM2crK2ZLbE9zWkZLOVNlUUFVVERYM3o2VkR0?=
 =?utf-8?B?OW9JcS9FT29ncUplRmNWOGp2N1FvMDgwR2Z3b2dVVk1IR1d0c1RlUDJvQ1Vp?=
 =?utf-8?B?Y01pV2xEYjQzdVE2QXoyZGhLb2d6Rld4Y2FMc2QyS0FldE45a2ZQOHNRQTZj?=
 =?utf-8?B?MDRmbFJMTnVqZDl6QmZwbkN0bHBuN0pnU1ZDVUZoS2JpVmpGQU0wZ1lOK0p2?=
 =?utf-8?B?amFjeEhiZGhSbmM1S0hsM1pXdHdWYU9SSGswR2ZoRlBkZWc2ODhDdjhpZGFU?=
 =?utf-8?B?QktRcVQ1YXdCdHE3RktkREtVdFBoUWxYWktrK0p3dUxCRG5YMUYraU5haEti?=
 =?utf-8?B?cHdNMDI3SFdldUpWUUFRK1A5cXNPRDNTWWJFL0dSNHV5em1DSlpZQy85UUxo?=
 =?utf-8?B?Y29MSWM0SXhtN1UwdWRxN29tZ3RnaldQWTdVaEFkSjIwSHJuckJBSGhCZVFu?=
 =?utf-8?B?Q3FhS2pWOXgrSCsxam01aGxUcDN2UmZhTGluSkYrekcxMTE1bWpNWVhBczVQ?=
 =?utf-8?B?UTIyR0sxR1NjTnBKSHJMOVVmNDBJNDd4MVFxUmVVaHBXMnYzbGFOSlNuWS9z?=
 =?utf-8?B?Uk5zRHR3dlBFdTU3VTYxM1ZIeUtEa000RmlrMSs3SlQ2VnJjdi9wTkVTK09v?=
 =?utf-8?B?L3hnUXFab1ViZXk0NUxkVWEraVNxNGhjb2JISExMQkRWYlF1bEg4RjhSM0F0?=
 =?utf-8?B?b2JyRm9Sd0ZTQWVzdXBOdkZQQXk3enZMREMweVVWZzJ0eVI5N2FibjQwSXFw?=
 =?utf-8?B?QU9aQXhpTHFEMytNcnlxVm52eXI2STRkcHJ4N0wyOHd6bU82aHhsQmdROW1w?=
 =?utf-8?B?b1FrdWJJZS9CRmVqcWp5b0wrVHg5S1dYbTFEaWxyRXF4Q1ZKUXM3QWdrNjdu?=
 =?utf-8?B?SHN6bTVlWU8waG1FTUM1Qkw5WmVoZnlBM0ZWMmppUFlWNUNuWEdEVmRacUd5?=
 =?utf-8?B?RFkxQW41ZW5rVXZTdElWeTdmYzYzckR3b0czaGRQaFVMR1VlUU4rcXBGL1pi?=
 =?utf-8?B?QmVXRVZjdnA3aWFEbmQ0bkNxWThzdHNFZERScy9FblA4T2hPOFpjWU9BUUNO?=
 =?utf-8?B?eXdHbkpIcEt6UkRERnFjYVNrcXl0RjRXS0ZqZVhOdGxMaTNpeVpsOXFHZHBC?=
 =?utf-8?B?ZE1UTkl1V1lmSWEzM1VZcTdJTUlVOUZEczk5ZktYSnAwWGZlVTJPbHJPSjNY?=
 =?utf-8?B?cDM2WElyemhQZG0vWkYyUCtlZ01HRkFhb0ZqQ2lvSWdkMWlUTzdlWXJuZGdF?=
 =?utf-8?B?RDc3Q2plU01iRmFCUlZTYWc4RG1Qcm9WMGtkMGpYOUN6Rks2dCthTmR4NDlt?=
 =?utf-8?B?RGNoZ1VaNStKRDJZZDYvRHBFZmNoNmRJY2FJb0xkcjUvUWdNeXVqVGUyNHh6?=
 =?utf-8?B?QmhUTVB3TUlhc1BGZWlEMkhsUTBnTnBJM1NCU3JjZjNlaVhkQWg1SHlVK0Ix?=
 =?utf-8?B?cDRvMUVuZnB4Sm5vMWZGT283Wlo2WHBxa3FENmVXb01hUXdUUjVaM085RjFB?=
 =?utf-8?B?WTBuOTh5Y1JCQmxXVkwvMHp3NG10a1FXTk9QR29tOG9TM3N1clFCWDN5ejdo?=
 =?utf-8?B?T0l6eWxxamdhTGJVVS9Sa1FzdWpPRy90eVZmeWVNTi8rZWpKK3hBWEFCTlNV?=
 =?utf-8?B?VEx6YTFyNjBLYzhxKzgxbGo3dXViKzFhZXh5bmhwbHcrcmJxVjBNbmpQd0tD?=
 =?utf-8?B?S0drYXBOcG9QejlLYStlQ2VFU0RRenlxL2RMSjZSV3BDT25DQ1RXMTZSekpi?=
 =?utf-8?B?RWN4VnJzU3psV0tBclc2UnJGSmRZTkVRSittSlBlRFlSVnA3NUhncGtoMHlv?=
 =?utf-8?B?TlEvUUk4UnFzQXpNTE0ya2kxNnV0SXowQXFtV1ZFK2hoK0ZMRjd2VS9DdEo5?=
 =?utf-8?Q?azDBA/4AboA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRTRHpSTS9UUTJ4Z2wzTnVSMGdndUxOaURMSmtyaW9IdURCYTRnMHRwVGtT?=
 =?utf-8?B?TzhpcklwcjRmMEFtQ1BnUU4reUNSRFFjVnhPOElVbWExRWVxcW9XV3RFRTkz?=
 =?utf-8?B?VXYvNXNjSFpRZTU2UCtnVk4wNnlSSWs2amZRbllRZGZwR0tXM1BSS2tsYmVm?=
 =?utf-8?B?RFJSaUF1YjFRZDl6TjNob1dFU0ovZExzVVRKQXVaZytPbjVSRC9GTXpMNFM3?=
 =?utf-8?B?QkFtWnJMMkg4b1VUVDYwaW1nNWdRMmdDUzByZEcxc1ArcDNXL24zVGEzdnBW?=
 =?utf-8?B?LzFsYlIvTjJYc0lMN2ZVOWIwcGJMaGpQVjBTMEkxS0VDQTBFQVlwVkJlZXcr?=
 =?utf-8?B?RkRhNUo3c0djL21hSVg0L0ViMjE4M3pXM0hqZXhGMURKdW1RZTJwWVU5Qk9S?=
 =?utf-8?B?WHNJT2ltTUlOdXdPTXN6YThmV2x1Q2xkano5bTNKdE9BYjJHenREYnhoNkEr?=
 =?utf-8?B?WDFCMWNuTTFuY2RaVXA4YnlldEl3eFVqUG92MWNoc21kMmtlU3lOL1pBbE1u?=
 =?utf-8?B?R3p1RFJES3JYOEhoQ2FwV3RUd0duTHhFRWl2TU9ySUg2aCtiM3ZXYmNzZU5a?=
 =?utf-8?B?THAzVUJXU0MraTdUL3ZHMlBzUFJYaEZFL2c0U0lIamNEd05HSjdDdy9Ca21C?=
 =?utf-8?B?K1c4dGhaNEpmUW1Ib25iQWJETittM0djQ0IrdnhPbXJ0cDRWM2tGTGFnVWEw?=
 =?utf-8?B?ODdPZ0RpWWt1SStrS0g2LzhQUGlab3QxNWNzTC9NMFcyV2ppTnlGMjVJUElK?=
 =?utf-8?B?REZNeWhxdkV1OWsxNFhrRk5sSkFpcnVRaXZLblhDZkVwWS9qa29RSlF0dHBq?=
 =?utf-8?B?SnZLMVRSSTJxa3dCeS9uS0lXNExDeENYZnR1bWd4c1RpMTNVVk5hOC8xaThY?=
 =?utf-8?B?YW9PbktMc1hzbEIvMERhOHBmNlN5c3hMcmYrNE1sRmFWRjdnZDhqeGlaQ2dP?=
 =?utf-8?B?U0tFS05PYlRDdXR6K3lvUXR6SWk5bSsyQ3BZeTZaT0trZlZwZUVmSU5NVHBj?=
 =?utf-8?B?dG5uODNHVUQ1Y2lFK01oOFJMU3NKbWZzU0E1NVRZWENxeWRZSzg0MVRqUjVK?=
 =?utf-8?B?a1EvMkdhVHl3MEJWVmRGYmlldWllTUM4SXVCTVZxZUlBRm5QQXRvdFhKZ1B2?=
 =?utf-8?B?M05laUZqc0JBVlZQaDRDQ3VkRDFPTU5hcHVqMHBuanZrWGVBZnBJbTRjcjUz?=
 =?utf-8?B?ZXhVaWJhWWZVTUJrZjJTaU93dWx1RWtUQ2F4RXpvdGt3QWdPUmhYcHcrZ3oy?=
 =?utf-8?B?NDVUUEJLTjZVVzBNUTkrYlJLUm42S2w2SktwYVhlRXkrTUN5Tk9hYWQ3QjRh?=
 =?utf-8?B?Qy9xc3dUcUZHdkdPSFVyb1d1RWxWRkp2MFZBdzZCODFiQkZLbWJXUlg1ZEw3?=
 =?utf-8?B?OXkrR1ZEUG00TUdLcXBnMDFJcGhGQWRSRjF3eGN4QnYwNVhCV2tMb293ZUx1?=
 =?utf-8?B?K0g5UFBLZUFMWVhpZjRXcjZ6ZGhidERjbXBHNDZnZDU4WHNDVThUUjV0VzVS?=
 =?utf-8?B?UlNnNFRsMlZScllvTTNoSFl2V1V5Mi9sSUdIRU5Wd25scGFoRjlXMkNKMFp4?=
 =?utf-8?B?QWJ6cm1yY2E0a25hWU9DdWR2OW1ua2Q0Q21xOGcxaE1GaUtzdzAwazR6cDJ4?=
 =?utf-8?B?S1BENWN3TllJbDhsWFF6UFVIVG9HL3FRbjlLc2pRWWhMcktmWWlkMCtIQ0xH?=
 =?utf-8?B?QTFTWTZKU09rZEFPMFY3blJDamNZeUpEUXNsT29ieWZJWkZONmVkMyswam95?=
 =?utf-8?B?Q2ozQzRBS05LRStucWh0YVEzYUI5cGJqVncvZ2h3bW9wZUp2RzB3QTFueDBz?=
 =?utf-8?B?N2tQeFFXS1FDdDBncm5Da3R0ejJXVHB1eEJqSWp2a25YMTZycjQ3bjFja2NX?=
 =?utf-8?B?dU9mTDRQRHhJaDhhdStGb05NektQdFZoa0pDNEVWMTBqMk1rOUtZbFNXdnRJ?=
 =?utf-8?B?Sysya2VXM2RHc3NaM2NrenUwcVRtSklCbjVqV0pjTFc4YlVsOG9iN0llRVVK?=
 =?utf-8?B?QjdXdjNUdmNVaHo4SUFFdWoybVIxNSs5QTBDd0dSWHZXTmJ4TnVuL2JyMW9o?=
 =?utf-8?B?TllHYU9NS0IraWV3RWwvRlZiSDJUUUwvNTJNZUt2cVBIaXo4SW04aTNYd3Fa?=
 =?utf-8?B?d0J2QVZ6MDBTam83OW1lczNqNXVUZmxnZWJYUzh2SE5qb2NSYlU3Vm9hMFhQ?=
 =?utf-8?Q?mgYXWQM9wEMAK5LBIvHBiP4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c80c4d-c2a7-4dc7-7509-08dde3ff11da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:44:41.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mEWpO1af8rPsI0xHIMEYTvxa1sDjH4pnGjTL2gHxQBV9X9aQpwf8qwSz09JdusNekw7fVkGepnmyeHoIsqWuca2QEKpOKLREcd6Cn7lsQyhZD8fUR/8LWv4p2xr9NI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5592
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



On 25-Aug-25 11:08 PM, Tom wrote:
> 
> Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
> 
> On Mon, Aug 25, 2025 at 01:14:59PM +0530, Ravulapalli, Naresh Kumar wrote:
>> Hi Marek
>>
>> On 21-Aug-25 5:33 PM, Marek Vasut wrote:
>>>
>>> On 8/21/25 12:26 PM, Ravulapalli, Naresh Kumar wrote:
>>>
>>> [...]
>>>
>>>>> How big is the file ? crc32 is weak . Why not use e.g. fitImage
>>>>> for this ?
>>>>>
>>>>> If this raw loading should be available to users, it should come
>>>>> with a BIG WARNING about data integrity.
>>>>
>>>> User can use CRC32 and if they require SHA256/512, they can use
>>>> that as well or any other algorithm as desired.
>>>>
>>>> RAW partition support is helpful for flash constraint devices
>>>> especially in a use case where we need to store data as RAW during
>>>> run-time and if data integrity is required, user has the
>>>> flexibility to choose respective algorithms like CRC/SHA etc. The
>>>> whole objective of this patch is to provide that flexibility to the user.
>>>>
>>>> I don't think we need the BIG WARNING, as RAW data by definition
>>>> will not have any built-in integrity features and users should
>>>> exercise caution if data integrity is required. It is mentioned in
>>>> the enum definition that choosing "DATA_RAW" flag will store data as RAW.
>>>
>>> It is not a good idea to use RAW data in the first place, because it
>>> gives the user false sense of safety, but in reality it can lead to
>>> silent data corruption. Hence, please add big warning.
>>>
>>> Also, how big are your payloads ? You did not answer that question .
>>
>> Is adding "log_warning()" be sufficient, like "log_warning("%s: Chosen
>> RAW data type DOESN'T have built-in data integrity support\n", __func__);" ?
>>
>> Our typical payloads are of 3 KB size.
> 
> I feel like documenting a reminder about this in the option help text should be enough.
> 

Thanks Tom, will add the help text in fs_loader.txt in addition to the 
log_warning() and the same being explicitly stated during enum definition.

Kind Regards
Naresh

