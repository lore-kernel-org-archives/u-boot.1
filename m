Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59383C5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 06:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4548488B;
	Tue,  2 Jun 2026 08:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="cTdqTeLQ";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="EdWa2LDU";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="G3MD9pk8";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="UTPRQ6pV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E150B848A5; Tue,  2 Jun 2026 08:33:52 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B75884884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 08:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6524HMQb1821858
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 06:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=W2w79yflb2/TkZQHtkySDcDnRTY
 lRpSlfjBkcivIU2Y=; b=cTdqTeLQC2+gx+EE3rQasBprDq3EDj76NHKOY1g0Ucr
 O/9YzR+N44bYS1KSBDgGuuEZTSqIzExYLZWMjYMzyHMmiRpXQJBmAezWJN/sVsRY
 5mcLjasXfFH+OIfmTu3R0MX4TZSl8AbFmEmnM/DgqCmDBRXhhYceSsjVkiU/fY7i
 3m2k6xitYkh72sLpJowo9o1rAvEYqCJFc0nool5BdGxuTrMvlsKuwg+VTIzokhFC
 yBkMfcc9joO0VlLqkszpkhzu4YubrNtBOe9DHBxQOM7ob9mCWHAJYXr2b7/ffTKx
 DVXfMjtJ6uhg+2CjilhbqAK9nZRXQqq8DE/oT8omXvw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ehr120mdj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 06:33:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VswlgB1TktiBWTXeV4YbpyPiwF/92czB7/MYKC1wI+D1bd1z6KD6qMFdz2O87qx2rsO2AlfvHFmjx2m3blshsiMmw8ywvQhgzqRhtWW0uTk303v/kapAKL/+mQn8b+4RnxaSyhVfTyS41xVfVWKVbWfH84VcsTyvCjuBibaS7itXPB9msTlsc2CB0xlUwq53zVkpCRA1h5luZvOvFFb6hkNCHcFV8Ble8XjZbRgkZaFLmEFxwuN2rumRUs4Gwy7JGMsMOFvNYqbR3aF0vIyw3OCpT2hnSTpjqSlI7H4ajXUDSRSm/jvphINla4Uy2OMoXRJ2YZBlt+xgSZ4U81f7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2w79yflb2/TkZQHtkySDcDnRTYlRpSlfjBkcivIU2Y=;
 b=p7vJt60vLNsCTeA+JSDQZrKTAI0LQvroaX33MLkIAwpO8SU8Wab/zzx8FBiqnAhyZstacX6mFsTlHakOX8d43JZBS4KMP8JmSUZR51B9t8us4z5DX7eVcz2YnM0rFIWVIiiMdBanLCFaiGX8ekfzYJs9Iy9IGR+C3e038SuIIGqCKV4nvlDZUCcTIHd3wiAq83Kj2AY4+rgtzwvmZICwXErTVOrHDk1AwiuQQpN96ZrbdpBiztHLwF0+o4OTUsRM76OskftE8WkJosSEB2CDoxhFoa40T+gUhKXk5oEvjWrpUlkeWzRCv1RkRCSEhn2//0eOp8Ttg7onEbWTxXJJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2w79yflb2/TkZQHtkySDcDnRTYlRpSlfjBkcivIU2Y=;
 b=EdWa2LDUFHdckZpiGnLsap32q8ZsI8GpaR9Yra1n+t2PrFJU8yN2zAX9+iwBHgH9HSUnpzWwEVkCG0jrPvRg81purrt213DESKX0SFFrZq4PDC/OKLU0dHDaOyHusNXlzHVpmzhsN/YS0A2te7xFUohejz8DDB4WWiRY1+2KVDo=
Received: from BY3PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:217::29)
 by SA0PR16MB3917.namprd16.prod.outlook.com (2603:10b6:806:8a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 2 Jun 2026
 06:33:45 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::4d) by BY3PR04CA0024.outlook.office365.com
 (2603:10b6:a03:217::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 06:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:33:44 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65262OlZ096620
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 02:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=W2w79yflb2/TkZQHtkySDcDnRTYlRpSlfjBkcivIU2Y=; b=G3MD9pk8Tet/
 cX+rk08mIY3HLUbrcy6gTd6ZPzkT47UODnropRqD4unOJALy7je2oHcFzLJNT6JD
 O9L4vTsKuAvRpbDyUhzwlR3KFAmfAa9UBUc2a3O/rmiP5mscBPUlcabrEAK92yak
 2aZxmjF5wvvaRUi5wbpqshNrFsBE+6E7bu4k9uoqYuoM9ZGaqcV2lGvN+O9vzfJt
 hNgsDL897PqXhERMEOWmqFmLf7dy3UmtOd08QJGiRSPm8PKIt080Or5S7fUsyPlG
 e0zR+pVt9pA8Mta6MCzCmbsDs5W6amqTBlsHO+lKzoX8Kz3rBaEy6xCnKFHXLGF5
 eL2rfJr2Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=W2w79yflb2/TkZQHtkyS
 DcDnRTYlRpSlfjBkcivIU2Y=; b=UTPRQ6pVDreymosn+XtdcLZleB3+fpdmqjGx
 9Z1NdqtWBURj07n6gWIe7RTLvESZQEVR6Cab2yu+gfJyXIsurgN87rarwi9UNxeo
 v7vBiSjcDGDVW3VLraPmUCjha7ubjsWwURvXww8RvUxCHghyZhXQMTe64Jot75qq
 6EJEOenN1NHvRRO9vN2mm7WB0DkEsZNd2kfmu4B9utg7INr3E1jBtS9dNV2u0m9z
 Qua+uGKs6JMaJZJZqdDL5Lr40YDerYJwbmz7uR0HvhnbIKf1eZJOX5t3OLKodooY
 R/ezmDPgRFkp7zUPGX7VbyDlYD34Qaq8wfT+DLGHG5okHQ6fMg==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egeh8b3fp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 02:33:43 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id UIh3w6nHCEF2CUIh4wFTVW; Tue, 02 Jun 2026 06:33:43 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UIh3w6nHCEF2CUIh4wFTVW
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Mon, 1 Jun 2026 23:33:41 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v3 4/6] reset: x86: Use cpu_hlt() in
 pch_sysreset_power_off()
Message-ID: <ah55RWb/w2VGwH55@kraken>
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-5-dmukhin@ford.com>
 <CAFLszTgub5tR06FAO01gbdD7mnUADGWyVZrLOgkpz+hXnDnKAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgub5tR06FAO01gbdD7mnUADGWyVZrLOgkpz+hXnDnKAg@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020058
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SA0PR16MB3917:EE_
X-MS-Office365-Filtering-Correlation-Id: 60355968-1b33-4ae1-01b3-08dec070e518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qjwQhxtQW/Hh2FU6psYO+9ohjPJNN3cijBDDvebadBEnI6m0FIEBv22CNMZzwOd9SF/KjyH1XTDWB56JWy71wMjqe/9khx42cDl5QzlkhBSmhQ7nlsD+z+IrnyU8pa7HP04WCDr9IQ2mK4erVaezM5ieAJbrqFC3oETFreGsIxwB6X8jnvPOhqx4yE4t2HWmSJvfDw4pSYsRTBKDaMLcYuj7ivet08YA9h3ZrF5JsZ3KLRvdV/QKjdODSfx/vmszS8CWeZWVzwUWOv9fJC6YNyNt28vt66otI4ZSmJhPJ7aW/iTClaGMSzHONxm8lHgv6dB8hTvpsRqr2HXGorWbjDEYMBoySTsKJRGr/KlT0G0cZXFpSP7UZjexFdIsaij8wQiyqyO/kpTXH4nazGsSUIl3KK4T8q+OGlL/Mutndh/YqkDNW2lyGzfR+9f4uaQ0m57zVcc46BPg+RFmu8050wNTjq3H4106a/y/BCDcjrQAmzQ6FeAMfPxmkEPEt9Ox3FOXM0fRw/VMbrEYnVXqwtxAvanr87rxgHXrBETG4vzUmPfXaoI0tjwKfgU3RhsU99Bmea9I9OkaOfiTpoFcl7809nKjUQXyKZB6KPL9AagFjZIVckov9imAjVU+E/+h27nQ2op5RZuiCg8WdS7RyQLtNeQGVJqNA8BYOmiWSuibnFgZWFuDszv94+UuZUOP76Hx0KaCSDM1LJ69jrr8ZCLeBX8uiJyTNRiMVVF0USg=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2U7bVS/ghsqRC7jWkEh5GHPmwzgOLQg20Kv2qr8G+K6RgoglzzJMayiPLDuM3jhb/kdfI81L1BMlhkNNEwtX8JNZWLPmlTrHEdRCsuPqSwuk9BCr/+Pa+orJOX7RllTy5AK7Q43+E6AcLKPrSu2JMwlLSg7OIBX6j3FVx/rpW+sqyvqDPvJJR3hNGvAI7ULkWeH4Y/Tqjmk6shaE51NpTHv2fXLQu97AbR6Oq6JhtI3JzT6D0Six/5BB4TzybiAf7C9Mq3WiSBDvBYa7oF0DmZbZth/z3YDr5qnRKQX6rX6IzR41yASRIvs5/xQcrU/+LpnKTfju/FMpj4wyZsQwOoY4DmP42lL5amTs/Yh0e2/sMTKuaWknzdPFJ5Kj+oOTXPy2Der9MrTcTVf96Usg4ZLfLTqPfcoi9XgZdDyO34sTeC9rzYrP7CZVthwaUyS7
X-Exchange-RoutingPolicyChecked: bvwVQMfzWo7U1OI0FAynhpsT6l9JAnu/7luB9RH+OsPsFJxvhT+F/K9bddaBOnGaIOkoZDErCExmyzaMjwX4G7T7ZtjNjnVzQBP+zxcec0aOXGckYCuGdaRIA83rBMKy/42TUIKXoFDB8px+/c2qYRsaCAttiVKIpP+zHa07Vah3rTGbOc1y0hJ0OaiWg+IxSu6B1xUYX7FsXUisvOLZ1D1xfkHcn1d0LFKy36trcA/DzZoPg0hUOfzbItmPEDBmAfC5dNU0PuzhtaxJ3NQ05OkiwnK0ytzgmHhlcJHDNkoaI9MEmpLR/uAYGo9wKZWxOfts2ZOSn9H3RDLiAHFUng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pw8Jmdvw17zZ3o7ZWMyz9rGBC24snmbNI+TQ3fB0b5W5Gs2Lb8CsJF4IJeN378hQjQpse3KFmWc9CXnVaTKFsOa3ADi9UxNLCOBYaaJWM/0ussODkJ/9YQ6bg6riNdB1l8DMKwQDFSi2qlT6wokoaxeCirqoIR1yBRWLUsHkXW/qSW/5WKKTCTrXQcBbGJo1zyKxBgbV/QbxAGT9NlY8/HVkGNL8WbiV9CzDuxvSD6TGf7S5MODGLXuzoRYHEY5ilaRJtUev4woRLO5s/fAaihnpZ7OCM0Hs7yD9CPTJUlMZ11D7lUmxte4nNabJaJoL6/ag9cjW3/qy9PTmYblqWfF7PJPxiQEXvbrQk8mBfGCu5NQ7Cj0KkBtnXsSRrHMfVwu0Qtcb/NCx8loofKQu1bpMd9pjrbjDLyKGu2Qe6/1WjTtPxTU6xRK0FEf5WjbeOd90VcZsZk0kzE/Ne8TJxt029h69yQmbHP49cvbLoLVuWCWhXxjQe9c7JjKcSt+uauhbBpG8xqKgg24h8FtvsYdhGTdo+EqqX1UBR/8n8lZ9VxGPDsLU0Wdwlcu/2zPDryr/7e/iFi1HKqxxUHpdAofWz9Lg2NrYa69ViSzImmph6U1T7dOIJ/0FMQLcGLYx
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:33:44.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60355968-1b33-4ae1-01b3-08dec070e518
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3917
X-Proofpoint-GUID: A4eN3JYCLTA9G1OZZfGnY9Plmb6mmcHH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OSBTYWx0ZWRfXyje4gicaCq2y
 jNvBinZ0K2uytLpAaBfRA07ZhMkZMim2/hsHbQf35IDjQu0yK2i+YfkJ+mQli47PaYAwO/Dck4M
 icJX56doVrS5pptTAlpUmMB+03w07SyL0o9gLzt86I0UjnLY30VMKMC8nXQh9LoIMe0ILotsGkg
 A4LCFwUhJEy/w+xwndHiIIxi5c9OHotjjnBuewUf7OYUiCxaXbS35qGnnoHacUnL8nUnLvlZGMR
 Ti443Tn7oIPOv0QvD1jJw8AVn2nHME/nySnGMvcffQ3wVQTK5sX8jh2smm4rbVn+R0Sh+G2xksz
 pQmNUwbf6KBLuCD8z/k/rqtADax4Y13LVQc91eY2VSqHgpGjRKy+DtK+Yzj3qQF59hotGQ0gOGa
 jGbJwRWjOhlRwv6NdQOGuOjD3QkVQm+MgTnSiwxzILHFVI1WB7MHq3LP3vA14hrFl9zNvp0ViPx
 la9G0z+AN/B7DLw7X1A==
X-Authority-Analysis: v=2.4 cv=K7MS2SWI c=1 sm=1 tr=0 ts=6a1e794b cx=c_pps
 a=kGaFF29v6S4cQQ60M6zgkw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22
 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=lzUjVqHphMvoRWYANscA:9 a=CjuIK1q_8ugA:10
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-ORIG-GUID: A4eN3JYCLTA9G1OZZfGnY9Plmb6mmcHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020059
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

On Mon, Jun 01, 2026 at 08:54:48AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> > reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
> >
> > Use cpu_hlt() instead of open-coded 'hlt' in pch_sysreset_power_off().
> >
> > Also, replace the open-coded busy loop in efi_reset_system() and use
> > cpu_hlt().
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > drivers/sysreset/sysreset_x86.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> > @@ -120,7 +120,8 @@ void __efi_runtime EFIAPI efi_reset_system(
> >
> >       /* TODO EFI_RESET_SHUTDOWN */
> >
> > -     while (1) { }
> > +     for (;;)
> > +             cpu_hlt();
> >  }
> 
> Just to check - this is an __efi_runtime function, so the body must
> not call outside the runtime section after SetVirtualAddressMap().
> cpu_hlt() is static inline __always_inline in asm/processor.h so it
> expands to a bare hlt here, which is fine. Worth mentioning in the
> commit message so the runtime-safety is explicit.

I think I will move that efi_reset_system() fixup to a separate patch
with a proper description.

> 
> Regards,
> Simon
