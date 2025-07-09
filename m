Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2923C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 13:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC13A83443;
	Wed,  9 Jul 2025 15:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="jqxtk2tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344848343B; Wed,  9 Jul 2025 12:20:34 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC41483018
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 12:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Arturs.Artamonovs@analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5699FrrS027897;
 Wed, 9 Jul 2025 06:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=81pHD
 I8TBzccPDdfVUxYWz9gEJyjCU73GwAL6s/vtAM=; b=jqxtk2tnzmhNMs0a/QPfO
 EkTJ0R/oTE64ZnCePROWk56ESUZJSHh2Hr+pr/SLXN76cKWSSfu+6wD6CjP+DqqG
 x7jaK3Zqx0Jp27f0EqX2P4x1O5/h+ypU/CqiedRsFhHbvQk1U/vOqlmUUjLvJKaT
 UTVT8rCMML3+72H0elhWK+tPZC16aJo1wF0r/+05hoBxa1RZFEA1D8JAI0gomHuO
 z5eShR1cjzl7LpPjkrajCFyj8RuxZgtiQgdw0GjszFP8R103EtvgNvpbnA+sMwH2
 1IjtQvutM8UIa74/KPcUCeO1YR02F5mvtnbdWi4h864CqWPK5tXghuXCMIFrsgE2
 w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47satvtqvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 06:20:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnUjfqzegIzy2UdEkn+osndzAYHX4xpKFHELW5r4rdM36vJelJlOgrPjCJcicwZiSeBTq6NxHiVP/PpNhnqsatXjKGTHRw4QhOX6+Q1S+bVCNGDluOdSTvGAOJL/oa/2j/1ywucdB0WCLqE8zJiwZG2/BYpTMqXzef9sAF1H9buoxPMHotyvbLz4+Gr58M2yoaabzaa6XjAzEVNYHAa4c0rfIZdRHRgAjCP7qll+SbDJfLTcjVlfivXCvP3gErE2+8hlpBcsE0vZHY+JRjYWRTNJ1PD7ZYTfjTPnnkwlyTA350ckPf994VMhdfife15bpxAHg1flzV52EI3U1UBixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81pHDI8TBzccPDdfVUxYWz9gEJyjCU73GwAL6s/vtAM=;
 b=nKhZcYSENiLyafkDuwNefHSBeLK8eoA2K0lA+WSnpAnhG1xNIDEojE6umrZbEwCELocjHYoyRRBB0BFfiar5fLjb4c8bPeWzUQDgFx4S1BE0oEBSnWQQ9cuAkKPEritDw4ZiXxMFTDTp11EQ4HjE9HJp25SllgdCHJI0AXWV8apkb4IthAfc3pCo1kbcJBlKYR2lUzg7b3aNDzXE+UhZH4IsjspyjIxnsMVAJBdncjjmf16kp0WKn4pFQrTAzT0R8DW5hclvcV08j1BSWTFe9UQ4WpB+4rj0ymEBAYlZV2r0Z7eVSHvVJ+5/CyJff0Xc/w85UfU+aEnBBcA5AOOoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6469.namprd03.prod.outlook.com (2603:10b6:a03:398::6)
 by CH8PR03MB8201.namprd03.prod.outlook.com (2603:10b6:610:2bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 10:20:25 +0000
Received: from SJ0PR03MB6469.namprd03.prod.outlook.com
 ([fe80::4671:5972:a1b6:3c1e]) by SJ0PR03MB6469.namprd03.prod.outlook.com
 ([fe80::4671:5972:a1b6:3c1e%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:20:25 +0000
From: "Artamonovs, Arturs" <Arturs.Artamonovs@analog.com>
To: Philip Molloy <philip@philipmolloy.com>, Greg Malysa
 <malysagreg@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Linux Factory <adsp-linux@analog.com>, "Bimpikas, Vasileios"
 <Vasileios.Bimpikas@analog.com>,
 "Agarwal, Utsav" <Utsav.Agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Ian Roberts
 <ian.roberts@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom
 Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
Subject: RE: [PATCH 08/10] board: adi: Add support for SC598
Thread-Topic: [PATCH 08/10] board: adi: Add support for SC598
Thread-Index: AQHb8LNIJ3tN5Jt06UmJj9ASQjFIOLQplEMA
Date: Wed, 9 Jul 2025 10:20:25 +0000
Message-ID: <SJ0PR03MB646938EEF886416A835A038C8249A@SJ0PR03MB6469.namprd03.prod.outlook.com>
References: <202e6781b0df0e8bddd2ae9b2bde0ad48f24f7eb.camel@philipmolloy.com>
In-Reply-To: <202e6781b0df0e8bddd2ae9b2bde0ad48f24f7eb.camel@philipmolloy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6469:EE_|CH8PR03MB8201:EE_
x-ms-office365-filtering-correlation-id: d686ef2f-db92-4c61-0eb6-08ddbed23833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M1ppS1BTRVloQk9XaWpwRlRwR2xwZHlwWTgvcG9zWmc3d2pDeTVOOWtjNkpk?=
 =?utf-8?B?NGRSSDdveVlubWdOcHdyT3FFQXk4WnJNbGlvVi9xcmJBOHJyVlBrbTh6WUdY?=
 =?utf-8?B?eWN4U25EUmtidjIzc2FBQnZKbXZndDhFbFhoUnVoa2FDOW5IWDVPTnRJVXFK?=
 =?utf-8?B?UDVNVjlVWE5INjRCRFdHRWo5MVFWaXpZU3hwSVRmWHp4ZGl5RUlhWVVoaGJt?=
 =?utf-8?B?T2ZlVW9renZZeXRVSUw0d3J2WUFDcGZNRXJ3WnFXT0RDZDBxQWdnVzZ5eGZH?=
 =?utf-8?B?OCtQVXB3Vnc2MnlxYnN2czBMSzc4QUJqeGtDa1lPb1kwMGpEMUFqS0dVQStL?=
 =?utf-8?B?U09YQmlRVFRVcUtweTRlVVljMzc5UDd2eFE3UnY2NEFuMFVaSm5BeXlxQ3B6?=
 =?utf-8?B?ell4OFdyc1NyZVlubVBReVlmbnh1dG55VVQ2T1NJbnNJdUgvWndBVXFLWkp6?=
 =?utf-8?B?d094TXZ6SzlmR3dqK09FSVFOaE04NnFSZHlNRGJBdSt6akZxb0VDK2R0Unc1?=
 =?utf-8?B?b0h5ZXZsOGlqTDJlN2Y4S1NicldidFdLVmFTRnp2TFBUbEdjK3p5Y1R1d3gx?=
 =?utf-8?B?aTVKT0RXVTNOMmVBcjJYWUVQYWRiUEhOVmJuOXFsRjlVemdabjY0aUxaV3o2?=
 =?utf-8?B?cXFEQkZ4UXhwOXlQc1o1NWFuVEh0UWNGT1E3RVdqK1FWdVA1emIzOGc0emw2?=
 =?utf-8?B?Wmk5aVAvOTVVZURrTE1hM0VVZlFUUWVQbEo5cmpMZFdEekQwaHp4dEp4Wkph?=
 =?utf-8?B?K3U3WXh3T25FVlR0SE5CT2hFbkROQkltRXNZWTJLbkV3aU1FUm8zeGR4QUF2?=
 =?utf-8?B?Z2JnTFlwWTVSV3htenFTUHgyalFqMGVLZ0twL25BV1hJSTdwaHNqTi9jQzda?=
 =?utf-8?B?d3NvNjZuREJjbmJsUmxJUGF2alRYbmE1OWlHY3NRa0lVcVZkMkVJVWtoVVFL?=
 =?utf-8?B?bGtSbXd6NkF3Q0tMZUR4MldhQkltcm5CUllYanpiOG1nUHJpLyszdWFrWnFm?=
 =?utf-8?B?MS8vUU0wKzVvdmdPVUJMcFV5Y3dGN3crSW5YSVBsRll3UmdLekpoVkhhLzVx?=
 =?utf-8?B?RlZSYWFTRjhWTno3RXpMZWZ3WHJucWw1REt4RjJEN3ErbXEzSGl4VW1rOFVM?=
 =?utf-8?B?MHFYWmM1ekMwVG1RYVdvUTd1NHlFRHZRMnBsRC96RTBqRysycDM1VlJEUUdo?=
 =?utf-8?B?S3ROTDcxTnVlSHpGdjA2NW5NT0E5dEZaaDRjY1lZTXROMEQ0TDU0ekowb21v?=
 =?utf-8?B?MUZHQ2tJcjhENnVyVDh2K2xtbDE1TjVIMnJrYXRGOVVQc0J1OHphbnBSVWtH?=
 =?utf-8?B?NjRGOTVTeCtZTVdJQzhqZ2FQQVJ2dFBiMDIwMHhZYnp3c3l2NXRUUkIxZnNS?=
 =?utf-8?B?UHFDK3ZXajVaejFtWDVxcEZYTE5QS2hrY0tLOFhGN21ua2lja0o0MzlsUmRK?=
 =?utf-8?B?YW14OU9aUTV4b3FzR0d4b2tIVmlxbFlYVDFNa0xGQmxFUm1LNG8wVTNXM0pu?=
 =?utf-8?B?VUpIdUJEckN1S0NTU3NrOUhCMW9Lc1o2RGQ3QnpTMjJCVXF1UHNUaVo0c2R6?=
 =?utf-8?B?d0RRc2NmVDBqWHVmOEI4VWZWVXdjVGFqYzhDd0pFR0tXTFBxbXJ6eldMOHpB?=
 =?utf-8?B?N09jTmIyU2M3OENTek9VWTJuMi9SVk5ZTElHdEozUTR6UE5vSDEwemgzdnpr?=
 =?utf-8?B?NCtRNUttZ3U2VHFYby93ZkJjaVdiUFBEZTByWGFnMlFrT3I0dDU2Yi96bC94?=
 =?utf-8?B?cUdJQjF1NHBsSnRza3h2cDNkNEcwdGtWM0NNaGhhc2JhcnhMaTZ5U2dFeVJ2?=
 =?utf-8?B?Q201UExIMTNtTERFQlF6MStxVG5BWmJBY2NaQkZZKzRsUnNFM0d1L1RkendJ?=
 =?utf-8?B?eGRpS3gxWXF4UlNpS1lXUDNWQm5nYkpDcDJiU21JanZpTFd2N2RrR2F2SUwz?=
 =?utf-8?B?akdEdmVVanl6S0hyMjNBbFJuY3lkQnpFU1ZwZnM5M0dBVjNnWW9rU2x0RDQ0?=
 =?utf-8?B?WUtiSHU0VWhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB6469.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk9DYmpBUWtIbFplL2VJSFhzcDdMdnJJVVd4N21kRDJ2NTkyZm9kRHRVMyt5?=
 =?utf-8?B?YzIzS2w2aGluMlRlMkxGQ0JZZXBHYlZuMVV2MUtjMXc2TTlPR0dCMUNqVmdF?=
 =?utf-8?B?LzFZMFZzbG9PWHozYi9hSjJRTDVLSEZ0aGZBeHNjaG5sVlZsRmZ0RjY1QkdI?=
 =?utf-8?B?ZE92UzhTZ2xYaVV1cjRuS1FzR1BDMkw2ZjRXMG81L2xYN3lVc0ZjNzlUUFdT?=
 =?utf-8?B?bVBhdEFjZ1pzUTFSQS9xLzZUbTRncGI5Tzdpc2tBZm9SREp3V3liejhNb3Fs?=
 =?utf-8?B?OUp6VXovVTJybkNQOFFWWTZzSVZsQjB0b2pHcmhmeGpDNjNjTnk0K1dFZVFo?=
 =?utf-8?B?clFVUnllYmtlNE9nY0k3UVpTcW81S2F1N3VIQ2Q4eFhjOUI5SXI2UHVUYWdz?=
 =?utf-8?B?S3VHWXI0dEwraENRZHFwa1R0Vk9aeVNzZ0RCWE5DR0JadXlnYzcxY2hQekxo?=
 =?utf-8?B?WW9QMzFYUlVGUDdnZW5VRXJUZisvMDY5b2RUdXlSUjRnWVVsWXZzODlZdFFt?=
 =?utf-8?B?bVFidVM1N0N3Y2RGbzJZcDlNcVBsUkpNQ25VY3lVaG5GakRidmttcllVa01v?=
 =?utf-8?B?NFo0UExQTDNKUXRtZVFrUGFrVkM0SGlqYVl1UldtN3BCTVhrcHEzbEtNNUNq?=
 =?utf-8?B?N0hlbEhzRW8xT2htWXJ2TmRJWHBscFpDZTcvM3F3dHU1Tmp3aVlKdFc0UXdm?=
 =?utf-8?B?TE94dzdlUmpIWCs4MVhiLzF3UUVCQS9QaWY4em90YWhWUUhVeklzOGovbmpy?=
 =?utf-8?B?K08xQWYrOFZnWWpmNkZGVy81Yy9pZFkzbXBXbEpkSHdSQ2xQM1dtVzBNUS8v?=
 =?utf-8?B?cVdhU1RqS3c5RFBRT1ZoaFowMU5CbGJrNkZkQzRoOWtqNGtod0ttemRaQ3dS?=
 =?utf-8?B?N0FDa0RqZGpiamp4d2xyQWxlazBlWmxDZHlydVpMK1FKbVlObHZxdWVLd2Z6?=
 =?utf-8?B?ZENkZW5xYjZHeDZ3a0MwM2dJQ0VhcVlLckt1WElGZlVNSS9FRkp6UzFucUww?=
 =?utf-8?B?Rm4wNmZOdG9JYVBkL1RpdW84VXNZelFaUVZKeExDUjQxSnpPSC82UW93VVgy?=
 =?utf-8?B?S3d6TFlyVDRLM1VlaWYzOGQ1RFJWdEMrN0pwbGUvclN5dGNhOWpZTzVUVk52?=
 =?utf-8?B?V2tVZDVMV2RJOTN2dThFd2J3REJqVXlqdlhrcDIzMkNRTVpscGlZM2F3THY0?=
 =?utf-8?B?K0kxSHdKdUpST3d3aG9ocjg0bk5PeVBKMVJndE9HQVpOb3hJWHQrTlZKTmw4?=
 =?utf-8?B?dy9udHdMOGhyRmR1dHUzVmxwK1ZCTGpCdFRXdDlKUzNlMFptZnlxcjhoYmVt?=
 =?utf-8?B?MW03TUo5WklHMUFZY1p2bTlMajl0cTVUUXQ2SWZXa1FmVjdLckRJcFVlSGtM?=
 =?utf-8?B?V1ltaGg0WUdkS0p2YlpmaTVTWkpNY01nZ04vUThZWnVuMUxvYTdWWDUvTnQ1?=
 =?utf-8?B?ZXhHN21LZlRzYmdtM090V2tuanYzOVFpRmJIRFRqOTJYcklSejgxZjZGMlNE?=
 =?utf-8?B?alc5R2FOaCtJWWNPSFU2UE1OQjA3LzhtOTZ6QkNFRVdSRUJJQWo3d2Zockdj?=
 =?utf-8?B?QnRRUXg0ejBDRU1iYzM4MUJvRzgyUTlnODdlZkczNk9Hc1VpcmlFc0c2emMw?=
 =?utf-8?B?NnRIY2NtZmhkb0htRDF2bElWeFVESEtWM1JmKzRCeE1uTkRIbTVjM25UNTJo?=
 =?utf-8?B?WlloUUZmNjZrKzJaYkJyZzRmS2Y1NE1sRG81WnNzSWVwNm9BWWNBL3QwamI5?=
 =?utf-8?B?aXBlWjV0RGFUYUtFMk1CTHJEQ2d4bjVFb0xOTlZFWTI4VzJMTXhFQ3RlbXZa?=
 =?utf-8?B?d0dpSVU0UWlBUXB1WWhGSTdUY0ZPbTd1UkhTVUl3cXROL0krWGtDeGh2d3lZ?=
 =?utf-8?B?M3p4YmJXM3lWMU5pRlQ4cUtHRzV3NTNPeG1WTlhrWFl1WDhYb0pzcHk3Mjls?=
 =?utf-8?B?UEplK1BYUW02MG1RV0xvMzVRb0pXOTBsZnV3SWNaYlE2UG5tazRQeHdjOUtn?=
 =?utf-8?B?a3FneStoTWkvOUZkUHkvUERjKzZVUFhTczdPZ0x3UFdYZjFoQUdqekN1NjdI?=
 =?utf-8?B?cmd0c3lBTWJJNmZ2WlcrZUtwZFJsQ3hCa1R4YXlxbDdOQ0NlVC91LzVIR2pU?=
 =?utf-8?B?VE80S053UlJOSGFiR3BUeG1wcEpjVWRKd08rdVlNMnBtUzdIV1g0ajZNck1y?=
 =?utf-8?B?VHRmTEVFSEFDODJlR1JYd29jekNlUlZyRDlxUnZNREFWWG1lVVNFRmZpb0dT?=
 =?utf-8?B?YWovTmhxeUxOdDNQQlEwOGV0em5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d686ef2f-db92-4c61-0eb6-08ddbed23833
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 10:20:25.1657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7qxYuz2mwUKkHsVUl/fu9IUtF3inFUCLF8xVOLu6UVpBV75DLyq+I+JwTFdOHrydHP17Sb8gwloqmJQM39GQujwdtLGomBhcWH8zbcaxu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8201
X-Proofpoint-GUID: AxZcjZUzUK_XuD3o6JoktOWlG11FUJOg
X-Authority-Analysis: v=2.4 cv=RvHFLDmK c=1 sm=1 tr=0 ts=686e426d cx=c_pps
 a=a8vDHJEVVaJbVsNIiOtgWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=dcqrcwJlAAAA:8
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=QtX7IHQTAAAA:8 a=k-42gJp3AAAA:8
 a=Q1UOY-ay_jMyuHmbUH4A:9 a=QEXdDO2ut3YA:10 a=iv5chyyQoDC2jTzJW-MI:22
 a=iAbFv2jvUoy42RkRxxYv:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA5MiBTYWx0ZWRfX5eXptaLacwUu
 bBArRjnatAbNwTFymagGke1We4bUx06fUxFOoPzykcBUKmLWZ4KmWk1dtiXHcc97oi5vhMF9+kN
 O9RnsvhSYom47hZ090n8AguKr5WZEyoc9VfNY70aHW0ZAgO4Kd8ZFvPvrDyXa2Zh/3L4Ojq4e25
 0XtFRp6EefzeeOq0CjVhdubMupA0k1Z884ZWuTKLVcN1htDWPdd5v+7jzZUSVGOLlnV2I1I20eb
 SLra2qr7qSkm+ptUs/HRjM7cUN7+yy8MX9vfQCXTHlbStgugC9LAS/jcBv5aL2sSgtjspPRwHMy
 10VQ14q+GWNd2hES9d3uoiXr5zpPMsJ9VvDjxM0ZFM+ZXvkUs+Me8WMGcqwhs/mqrRldwc8hPEC
 KL+fvZiaHxDF+Az8PZhKLv7pcAE6fyUjbVL29WXs2bEjpcACwMMYJY2M84kOA01TVsTGwKdn
X-Proofpoint-ORIG-GUID: AxZcjZUzUK_XuD3o6JoktOWlG11FUJOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090092
X-Mailman-Approved-At: Wed, 09 Jul 2025 15:15:19 +0200
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

U1BMIGNvbmZpZyBpcyBmb3IgU1BMDQpUaGUgZmFsY29uIG1vZGUgY29uZmlnIGlzIG5vdCBpbiB0
aGlzIHBhdGNoIHNlcmllcw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFBoaWxpcCBNb2xsb3kgPHBoaWxpcEBwaGlsaXBtb2xsb3kuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgOSwgMjAyNSAxMDoyNCBBTQ0KPiBUbzogR3JlZyBNYWx5c2EgPG1hbHlzYWdyZWdA
Z21haWwuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IExpbnV4IEZhY3RvcnkgPGFk
c3AtbGludXhAYW5hbG9nLmNvbT47IEJpbXBpa2FzLCBWYXNpbGVpb3MNCj4gPFZhc2lsZWlvcy5C
aW1waWthc0BhbmFsb2cuY29tPjsgQWdhcndhbCwgVXRzYXYNCj4gPFV0c2F2LkFnYXJ3YWxAYW5h
bG9nLmNvbT47IEFydGFtb25vdnMsIEFydHVycw0KPiA8QXJ0dXJzLkFydGFtb25vdnNAYW5hbG9n
LmNvbT47IE5hdGhhbiBCYXJyZXR0LU1vcnJpc29uDQo+IDxuYXRoYW4ubW9ycmlzb25AdGltZXN5
cy5jb20+OyBJYW4gUm9iZXJ0cyA8aWFuLnJvYmVydHNAdGltZXN5cy5jb20+Ow0KPiBPbGl2ZXIg
R2Fza2VsbCA8T2xpdmVyLkdhc2tlbGxAYW5hbG9nLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25z
dWxrby5jb20+Ow0KPiBUcmV2b3IgV29lcm5lciA8dHdvZXJuZXJAZ21haWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDA4LzEwXSBib2FyZDogYWRpOiBBZGQgc3VwcG9ydCBmb3IgU0M1OTgN
Cj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIE1vbiwgMjAyNS0wNi0wMiBhdCAxNTo0NCAtMDQw
MCwgR3JlZyBNYWx5c2Egd3JvdGU6DQo+ID4gPiBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIEFu
YWxvZyBEZXZpY2VzIFNDNTk4LVNPTSBhbmQgY29uZmlndXJhdGlvbnMNCj4gPiA+IGZvciB1c2lu
ZyBpdCB3aXRoIGJvdGggdGhlIFNPTUNSUi1FWktJVCBhbmQgU09NQ1JSLUVaTElURS4NCj4gPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBWYXNpbGVpb3MgQmltcGlrYXMgPHZhc2lsZWlvcy5iaW1w
aWthc0BhbmFsb2cuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVXRzYXYgQWdhcndhbCA8dXRz
YXYuYWdhcndhbEBhbmFsb2cuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQXJ0dXJzIEFydGFt
b25vdnMgPGFydHVycy5hcnRhbW9ub3ZzQGFuYWxvZy5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBOYXRoYW4gQmFycmV0dC1Nb3JyaXNvbiA8bmF0aGFuLm1vcnJpc29uQHRpbWVzeXMuY29tPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogR3JlZyBNYWx5c2EgPG1hbHlzYWdyZWdAZ21haWwuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gwqBhcmNoL2FybS9kdHMvc2M1OTgtc29tLWV6a2l0LmR0
c8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTY2ICsrKysrKysrKysrKw0KPiA+ID4gwqBh
cmNoL2FybS9kdHMvc2M1OTgtc29tLWV6bGl0ZS5kdHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDgyICsrKysrKw0KPiA+ID4gwqBhcmNoL2FybS9kdHMvc2M1OTgtc29tLmR0c2nCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMzcNCj4gPiA+ICsrKysrKysrKysrKysr
KysrLQ0KPiA+ID4gwqBhcmNoL2FybS9kdHMvc2M1OXguZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTgzICsrKysrKysrKysrKysrDQo+ID4gPiDCoGFy
Y2gvYXJtL2R0cy9zYzV4eC5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAxMzcgKysrKysrKysrLQ0KPiA+ID4gwqBib2FyZC9hZGkvY29tbW9uLXNjNTk4
LXNvbS9zYzU5OC1zb20uY8KgwqDCoMKgwqDCoMKgIHzCoCAzNCArKysNCj4gPiA+IMKgYm9hcmQv
YWRpL3NjNTk4LXNvbS1lemtpdC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
OCArDQo+ID4gPiDCoGJvYXJkL2FkaS9zYzU5OC1zb20tZXpraXQvc2M1OTgtc29tLWV6a2l0LmVu
diB8wqAgMTggKy0NCj4gPiA+IMKgYm9hcmQvYWRpL3NjNTk4LXNvbS1lemxpdGUvTWFrZWZpbGXC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsNCj4gPiA+IMKgLi4uL2FkaS9zYzU5OC1zb20t
ZXpsaXRlL3NjNTk4LXNvbS1lemxpdGUuZW52IHzCoCAxMiArLQ0KPiA+ID4gwqBjb25maWdzL3Nj
NTk4LXNvbS1lemtpdC1zcGxfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoCB8IDEyMyArKysrKysr
KysNCj4gPiA+IMKgY29uZmlncy9zYzU5OC1zb20tZXpsaXRlLXNwbF9kZWZjb25maWfCoMKgwqDC
oMKgwqDCoCB8IDEyMyArKysrKysrKysNCj4gDQo+IEkgYXNzdW1lIGAtc3BsYCB3YXMgYWRkZWQg
dG8gdGhlIGRlZmNvbmZpZyBuYW1lIHRvIGRpc3Rpbmd1aXNoIGl0IGZyb20gdGhlDQo+IGRlZmNv
bmZpZyBlbmFibGluZyBmYWxjb24gbW9kZT8gU2VlbXMgbGlrZSBpdCBtYWtlcyBzZW5zZSB0byBy
ZW1vdmUgaXQgZm9yDQo+IG1haW5saW5lLg0K
