Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8632AC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 12:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD1D888AA;
	Fri, 23 Aug 2024 14:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="J7ZiMMK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0233888641; Fri, 23 Aug 2024 14:25:33 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF90886E7
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=896554e7b9=benjamin.baratte@st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N6QYRX013690;
 Fri, 23 Aug 2024 14:25:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 STMicroelectronics; bh=s0FIgwKM9xXTX5Ja+EHCMlRp+f/AKv7CO1OtLcWUE
 Fk=; b=J7ZiMMK8rYH+UxRDOT1qV0VHVK5b+YtFXKu0m4dbC3cEz0Sdwmy7ebzu7
 NhE7v8eG5lFs1E3Hc501l73OCVBjGLD8Sn8DjF/Ej/++K7JFn662uQEEFqDpfuDZ
 Rn3z+W4FqwKKROwr/PNHO+1gmEFEgJb2gdk7uPEZGIXi8SgK/soC6PPCl/9Cwbuh
 hJbUbmqtkrmVlshRiAevrGODgtw4ZAFZgrnVN8a19rwG39Wlkazk8l0jNjIVbDcy
 572/qS3Hq4aM0FkPHjN1purzp8qPrnOXXlH8SC3zGmty3cYwr15Iv8LGrPwTc+Ku
 HpNjEMGIegXbfeH1lGViBQK673Oxw==
Received: from eur05-db8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4162vhn64p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Aug 2024 14:25:20 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju5rxFiOr02n0sIYNBb1e8TeLNGs3fncDMnKaBXS4IwkQ/5t4jFkVawfjdw5xllvb+E7gepEn/UdfD2hGFnApntViUxmvys7v0KzENkCdhF/VC/o+oFcmDzzoZAosdJ8tYKtSmpmx/9IQTLw+TIT7gc4gUqZAsMSsxGcMaYrZi6TUra7eD1r9Sa/D3WC6cJuohgPo83GmDzW1JIgwr6ETsr+9JSD+wLwHaJhmQLBxK+KThASzF/PegUP1Ecayqp4u+BuiVLgdf6I0TjIAiC3CML1Mafyu+IOQcPvGZBWwvnqX0BJ01a30CtFAIaBjHKqFuWZYTiFdgyZNBiPHHGaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0FIgwKM9xXTX5Ja+EHCMlRp+f/AKv7CO1OtLcWUEFk=;
 b=DXpz/KGDGgWZdieU+QxCgC53V/uyTAbX3eR9CfZZmMgtIYikrAoFcOgIWlGIKQOrBS61pTKDZpCnzMfghOtdAzDBYEhnFn0ofunlLKfhzdxMD3w9ci41a4IdbSNKD9dabX91pFJjSmCpbtzxaQ5cdp+TFH64dnPhPjuQP1TydPScMDLuboxUtu4HZaW9fMPsDEt2retzP6j2DUL2XM6zXOHVYy8cA3/T7vXU4izVMpPLE9bvkfcMJj97PHRvyhfHwiEhrNxfvq2Ih8JtUdSyArZJdQxndPajemROvvqSfXmyVHUqr6CUPES8Kgft2XvfCEci7GwJPhHKJ9TKP2Kpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by GV1PR10MB9186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 12:25:19 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 12:25:19 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "eajames@linux.ibm.com"
 <eajames@linux.ibm.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
Thread-Topic: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
Thread-Index: AQHa4b8qDWUmkS89M0qqLs3iveArJ7I05xYg
Date: Fri, 23 Aug 2024 12:25:19 +0000
Message-ID: <DU0PR10MB52446E962D0972A948FD376BE1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
References: <DU0PR10MB52445073A01A8668C66ADAA0E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <ZqefQTOIwKSl1YzC@hades>
In-Reply-To: <ZqefQTOIwKSl1YzC@hades>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-Mentions: ilias.apalodimas@linaro.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=c1c2c812-dc4e-4d5c-bd0a-429977adb521;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2024-08-23T12:09:23Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|GV1PR10MB9186:EE_
x-ms-office365-filtering-correlation-id: 15d31760-5981-4617-28c2-08dcc36ea6c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?bU11VHhhVVZjYTJYeXJOaTRLUTRFKy1mRktsQmhPb0llMGplZ2V3SlpBMFQw?=
 =?utf-7?B?T2dBZS9VNDZBOWVsMzJTc3FyaFpYQTU4OHgwQUYwbDRrRmtuNjJYT0k1NzM1?=
 =?utf-7?B?ZEdFUXBCKy1Mdkh2eVBPZXp5VjZKUmJnN3Y1MXhORVJsUGJ3dSstOUhUNmw2?=
 =?utf-7?B?THZKcDExVDNxNzVrYTVmL0xYanYrLTI0bmFOMTFSRGdKaUc5YVVKYXdlUkJP?=
 =?utf-7?B?QUw2ZjIzbUdvR3BBVHVJRistZEhhQ2I0OWwzczZaWjFXRDJvamI4enhnVFhL?=
 =?utf-7?B?WTE0b2U5Ky1DNnAwUHBNNXZzWWtqUU44Ky15VVR3QTJ4NE53QW9tKy0xZ2ZE?=
 =?utf-7?B?dXdvZmRhdFpFWlQyRnAzb1VzUjRJUVpvY3YrLVkvRHdJTzhxbWNEeVRzR3BP?=
 =?utf-7?B?YTFMOUdDbistbFpuTlNCOEdydzhSUHJlM0hnbWZuV2RGRVA3Z0RsM0VVVkE3?=
 =?utf-7?B?Sjg2bU5nQkQ5V2EwbEFsanJGQVhWQkdDQjV3bFRMUm1SckRLclUrLXVHc0ZY?=
 =?utf-7?B?N2h1Q1FrNnozOVUzcmttWlN1ZUJWUXdBcG5iUGRra3VEYy9sbXdkVGlpVXB0?=
 =?utf-7?B?WXV5bzZTZnV4Njh2NHZIbnAvZFg4R2FDSXhJVFh5NEI4Y2kyeFFPSSsta2dv?=
 =?utf-7?B?UDR1U05vMFEvajhzOUxGN00wR04wMCstUDdFeVRzKy0wcistbFlxY3l1c2s=?=
 =?utf-7?B?cUkxKy1Bd3FrKy1sbmNPc0x3WCstdUJhbUx3ZGk0Ky1mbnUvcDdCdkU0Rjcw?=
 =?utf-7?B?TXZSVEFqQkRJbEEvS04xVFA2a2xRZ1BhUGJGN0s2TGhYcldVR3ppUkRaYSst?=
 =?utf-7?B?VENxcjVMTmd3c01QUHR1b1QyRGNPZE8rLU9iTE1UMFI5OExuRXFYWEdOeHJI?=
 =?utf-7?B?M3QzUXVvSjFqOWJRRUtwa3hBdWdERHpmVGV6MDJyY3B1aG1YWXBDSGtTYUcz?=
 =?utf-7?B?aTFsYystOUlQUnd2VE9yUUtGS0RjWjB4OThYNWVTamRXKy03dHdPWWM2RUxu?=
 =?utf-7?B?UE84Ky1zNGRiWERSNndyNDg2R0VaTXkyclVDSWVyZmYxNVY1Y2RyNUt2TVg4?=
 =?utf-7?B?b3B2V2x0UWVkWTZYYkZSc3NJeXZ2ZkNDeDFqLzcwVGVYRXdVZFJ5Ky14bmMx?=
 =?utf-7?B?OGdoRnBjbzRCSlNHZEJoTFFRZXd0TGtPNUpKSi9vUmNKdVhjM295andHQ05W?=
 =?utf-7?B?N1pXRTYrLVY3WDJLdVZrcnc3eTdXRjhRYW1VWXBraHNPY0Y5cXJQdmdFNGNv?=
 =?utf-7?B?RlZPLzNXWjhsakk2L0h1dkFxNzM3NWdXMDF1TDB3ZjdLUU03UlUrLTZKYkd1?=
 =?utf-7?B?Y0lGenpXTHYxaER2VmplWXBDYzUrLXllSElsdnB4cW5IOVRSb3FWV0FlRnk2?=
 =?utf-7?B?dHFQTS8zUnZESG5Sa1IzdlVSdDVnMkhjTUwxRHBVQVdiT3dOd0U4a1V2ayst?=
 =?utf-7?B?WkZ2M0RmdzhUR0c3QWQ5dktRcG4xWkFpM0hZTDk1UjZiVllsTWdlVENXeC8w?=
 =?utf-7?B?NVljSjA3VWhLVGZhcUNEWXN4OHBMV0hWeC90MlF1Y2lXNzVPNnJySlk2T1Zs?=
 =?utf-7?B?Q2EvTzJDcU5CQVA3ZmhIWm5PSWF1NXRHY0hDZkxxeG5WRzF4Y0c0ZXZuY29s?=
 =?utf-7?B?Qmd2Ty9zRUpwY0VGKy1vMXgwYnFhbnRhbXNjcEtzYUFjcVk2eFNhVSstVldK?=
 =?utf-7?B?Z00zNEtBT0E0VDNnRmhIYTZLSFAzSWlBMENrS0RyOWk2M3paYkxFMi9tUUJy?=
 =?utf-7?B?ZE93c2h0YlNabXhNRHdYOFJUT0lLREtRaHJIVFRYcnhZMGtHcGczdmNSckFN?=
 =?utf-7?B?OTB6WUZzZ1ZGek9CNkpzTWZQQTJJNSstaDV6Y1Y0dndjZ1RnTW54aksxWEw1?=
 =?utf-7?B?eHJ0aEJFTDQ3MlJhM3FHMWFUWm5wNWh6N2dVaW9RMWU0TUlRNHNpKy1ZNWc0?=
 =?utf-7?B?ZURRWVNSYnlFbVF0SG5hWUcxdjcyaXJ3K0FEMEFQUS0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?WjAzekI0V29PaFp4WWpnbG92elJlV0gwRm9EdUtzWmMyYmFRTko5TmUvU0Vo?=
 =?utf-7?B?UG43RG5QWWpGREowak9BUU1EQ2lQdjl5TjRMVmJ1eTNxSHJMb0Zvd2p0ek1M?=
 =?utf-7?B?TWtYV2lUZW9wRDRxTFNYaGVyM1poRFlFbW4xZm1pM255bTJFYXpVejVJR1Ix?=
 =?utf-7?B?MzhrTVBUeXhTdFBLbTFvYUQxVm1QekJhcXBPc3BEUlhBRmt1ckRKMWF3Q1VU?=
 =?utf-7?B?VW9Nc1FjZFVQd3VlSGJFMzZnNzFyZUp6dEhqNjY1RzJiS3JiNTRvUzNPa28y?=
 =?utf-7?B?QTFRZ2EyeFBZeXVncSstczBsVnp0ckZXNXVERTVaSlY0Ky1BOUUvRUV1TDdm?=
 =?utf-7?B?RG1xU25LQXZxMDl3b296NENmTGVHRHNFeDd0bFF0ZlR0dkdLWHZINzVYV3p2?=
 =?utf-7?B?U0xzaDNhRlA3ZzhxcG82TlRTZjFSUXJnbHNyekJxMzlWajVEUWJZUnZKMGNq?=
 =?utf-7?B?MFF2Nm5RUmI4WGJsYzdIT2xteVQ3N3VQelVFMTZyWEdBREROeE9rbkJqVHRC?=
 =?utf-7?B?b2tSVUI1eS9MT1R2UklnVEY1SkxNYk50RWcrLWkybHAzSGE5S1RZSk1TY2dt?=
 =?utf-7?B?bnFVZmxWc3F3S3hXdDVsMTlXc1N2N2FYZFluR2tnQzhoRjNEN1hXU3ZzSm1u?=
 =?utf-7?B?VFRNTjZQbCstbFN6VUJEbktydkFEd0Q2dWxZVHA0ZU5kRzA0MHFYMU1mQ1hl?=
 =?utf-7?B?SHpKckVYS1ZLeDZ6V1gxYWFRSnVQOWFwY2dGSWZHdW42b3dmTmZRT0ozZlJK?=
 =?utf-7?B?L3htQ0hzSXVwM0lpSDJTVGZCNVZNM2R1SzQ3R0hyWDZqMDlOVzkzU1k0bks3?=
 =?utf-7?B?dW10SHFHVystZTd5U1lUQllKQTdIRHA2eG9ob2xnL2xzQUZDY1hvTzdpS213?=
 =?utf-7?B?UG13d21hdk5pR3N6WmNuZ1JucWZObTFEaEh6Ky00NnYxVy9uTkthMUdoSmU4?=
 =?utf-7?B?Q25QeWJDR0NGaDBwVEFHcEFVMU5YQlhlV2wrLXM2TlMzakJ4dERrNExXT0pX?=
 =?utf-7?B?T2FVKy0xVkpiQi82RVFsNUZqeDhsVzRrNUg3ZWw2SE5YU1NRaERSRE9WNWRG?=
 =?utf-7?B?cW9QaDJ1d0ZLekJIUU1sWlZ6QzZjejNrSSstMCstdEJkeFdlbHIxQkh3WDZJ?=
 =?utf-7?B?Um5HYUxpQS9NVnljZjYrLWdNOVVTd1JyZE50Yk5qaFR1TVBjWVNrZ3VLODRo?=
 =?utf-7?B?VllsTkZGMkYvZ1o5ZllocnVFekVDS0M1OEFoN1F4dlp2TnhpYkNKWXN6MTN0?=
 =?utf-7?B?Mkg1T2F0L1VZUk4vYXhyalFIR1phZ3Y1QU1aeVpQb2ZmTkViYXBXZWJ6Nyst?=
 =?utf-7?B?bWpVNk1NTmM3VystTFFPZnRXUE1RemJseWczd0MwTHkyY0RWSSstWjJReFo=?=
 =?utf-7?B?Ky12WjdaWmRaSzZUR3F4ZVF2cmhSOHNXZ2J2ZFFKd0Q0WC8vMDJ5VFVKcmpJ?=
 =?utf-7?B?MHlVQzdkMnpDY3FmSzU3Qnd0VmpuVjN1N2FXekY5YmhVd21GdllCOXgvMGlD?=
 =?utf-7?B?c2tNQldweVUrLVFRQk83UFVWcnp1Ky0yQnRlRGJqN3YwYWd2NktlWTh5aXJQ?=
 =?utf-7?B?NUV0MXNHRDVybkRzYjZIMjJydW1CaVRQSGpvNWhzYi8rLTcwYjd0ZDMyQUti?=
 =?utf-7?B?Qk1nS05qbmRabFpLaUNPR3k4dUVxdzFtM3ljc1J2TmswWHNNQmMrLXhoVXJk?=
 =?utf-7?B?TjJ1R1hSa0c1RHhkMk1tUU03YnJ0L29JbzZxTWhkQXBTY0pzU0x4UFM1TTZm?=
 =?utf-7?B?RXQvVEpSVjZxSTdPcHFRUjVoKy1jQjhwV3I5Q1pJMTJhTHNoc1d1MEhoR0lp?=
 =?utf-7?B?T0pNOXFwL2hKU1AwLzh5SXNtWks2cnVCYWJia0t3M2puaFhMR1c1MEUrLUJJ?=
 =?utf-7?B?R1FMRGFURXYyQ0ZsRjBCZmV1ODB3dEtPNmd3NFg1aWlReE1oZjJQTHpISnhW?=
 =?utf-7?B?NmdHOHAwbFZjUzlrVXl2Umc2VDVtbTZZWXhZSElYSXNxT0l5QTV0TWsvMGVa?=
 =?utf-7?B?T0FCNistaHlxKy1Qc3pZaFpTR0N3aUx6blN6SXdnVUlTcmlweWdqR005bTI3?=
 =?utf-7?B?OFdzd2ZtVDAzVmhxZHhGQkpkTkppaXJjSVN0SkczbmpPTTVSSjNDUnVMNmkx?=
 =?utf-7?B?Q2ROQkVZOEsrLWJJelFIUmhjQ0NTVzIzOHZUVlY2SVJsd3owcENVYmlvTVNB?=
 =?utf-7?B?dzJZNVI=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d31760-5981-4617-28c2-08dcc36ea6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 12:25:19.0782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY+JDEpmv28CCIZzRh+juyU6t60g6bZonLtPZHqutBWNLYgntVYVPw2va6SDh4elIiQl/byDzHuWr1tkGS4CDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9186
X-Proofpoint-GUID: Y3gY4fFY7W6_w0qhH0tzaB_IY3VrUtMc
X-Proofpoint-ORIG-GUID: Y3gY4fFY7W6_w0qhH0tzaB_IY3VrUtMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_09,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230090
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

Hi +AEA-Ilias Apalodimas,


ST Restricted
+AD4- -----Original Message-----
+AD4- From: Ilias Apalodimas +ADw-ilias.apalodimas+AEA-linaro.org+AD4-
+AD4- Sent: Monday, July 29, 2024 3:55 PM
+AD4- To: Benjamin BARATTE +ADw-benjamin.baratte+AEA-st.com+AD4-
+AD4- Cc: u-boot+AEA-lists.denx.de+ADs- eajames+AEA-linux.ibm.com+ADs- sjg+=
AEA-chromium.org+ADs-
+AD4- tharvey+AEA-gateworks.com+ADs- trini+AEA-konsulko.com
+AD4- Subject: Re: +AFs-PATCH 1/3+AF0- tpm: update tpm hash algorithm accor=
ding to
+AD4- tpm2.0 spec 1.59
+AD4-
+AD4- Hi Benjamin,
+AD4-
+AD4- Apologies for the late reply, but I wasn't cc'ed in the series. Did y=
ou use
+AD4- get+AF8-maintainer.pl for the recipients?

I have tried but due to the corporate setup, I'm not able to use the script=
 to format and send the message automatically...
+AD4-
+AD4- On Mon, Jul 15, 2024 at 01:33:16PM +-0000, Benjamin BARATTE wrote:
+AD4- +AD4- The hash algorithm structure shall reflect the TCG specificatio=
n for
+AD4- +AD4- TPM2.0
+AD4- +AD4- With vesion 1.59, the SHA3 algorithm has been added and shall b=
e
+AD4- +AD4- reflected in this structure.
+AD4- +AD4- The fact that U-Boot does or does not support SHA3 algo yet is =
not
+AD4- +AD4- relevant for this structure.
+AD4-
+AD4- It's not, but I don't see why we should add more algorithms if we don=
't plan to
+AD4- support them. Any plans of adding actual support for the SHA3 family?
+AD4-

The main issue here is that the new version of hardware TPM are now using d=
efault PCR configuration with SHA256 and SHA384 as per the TCG specificatio=
ns and U-boot can't support them and generate error at boot time.

For the SHA3 family support, they are supported in the Linux Kernel already=
, therefore, this should be supported in the U-boot to ensure consistency i=
n the full boot chain.

Also, TPM API offer hash interface, therefore if the PCR is using SHA3, the=
 hash calculation could be done by the TPM regardless of the software suppo=
rt in U-boot.

Best Regards,

Benjamin

+AD4- Thanks
+AD4- /Ilias
+AD4- +AD4- It's up to the end user to configure the active PCR bank to sup=
ported
+AD4- +AD4- hash algorithm by all boot chain component.
+AD4- +AD4- Also, by default, TPM2.0 shall support at least SHA256 and SHA3=
84, in
+AD4- +AD4- practice dTPM support 2 actives banks with this 2 hash algorith=
ms
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Benjamin BARATTE mailto:benjamin.baratte+AEA-st.=
com
+AD4- +AD4- ---
+AD4- +AD4-
+AD4- +AD4-  include/tpm-v2.h +AHw- 35 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+------
+AD4- +AD4-  1 file changed, 30 insertions(+-), 5 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/include/tpm-v2.h b/include/tpm-v2.h index
+AD4- +AD4- 4fd19c52fd..9848e1fd10 100644
+AD4- +AD4- --- a/include/tpm-v2.h
+AD4- +AD4- +-+-+- b/include/tpm-v2.h
+AD4- +AD4- +AEAAQA- -253,6 +-253,9 +AEAAQA- enum tpm2+AF8-algorithms +AHs-
+AD4- +AD4-         TPM2+AF8-ALG+AF8-SHA512         +AD0- 0x0D,
+AD4- +AD4-         TPM2+AF8-ALG+AF8-NULL           +AD0- 0x10,
+AD4- +AD4-         TPM2+AF8-ALG+AF8-SM3+AF8-256        +AD0- 0x12,
+AD4- +AD4- +-       TPM2+AF8-ALG+AF8-SHA3+AF8-256       +AD0- 0x27,
+AD4- +AD4- +-       TPM2+AF8-ALG+AF8-SHA3+AF8-384       +AD0- 0x28,
+AD4- +AD4- +-       TPM2+AF8-ALG+AF8-SHA3+AF8-512       +AD0- 0x29,
+AD4- +AD4-  +AH0AOw-
+AD4- +AD4-
+AD4- +AD4-  /+ACoAKg-
+AD4- +AD4- +AEAAQA- -271,11 +-274,15 +AEAAQA- struct digest+AF8-info +AHs-=
  +AH0AOw-
+AD4- +AD4-
+AD4- +AD4-  /+ACo- Algorithm Registry +ACo-/
+AD4- +AD4- -+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA1    0x00000=
001
+AD4- +AD4- -+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA256  0x00000=
002 -+ACM-define
+AD4- +AD4- TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA384  0x00000004 -+ACM-def=
ine
+AD4- +AD4- TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA512  0x00000008 -+ACM-def=
ine
+AD4- +AD4- TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SM3+AF8-256 0x00000010
+AD4- +AD4- +-+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA1     0x000=
00001
+AD4- +AD4- +-+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA256   0x000=
00002
+AD4- +AD4- +-+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA384   0x000=
00004
+AD4- +AD4- +-+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA512   0x000=
00008
+AD4- +AD4- +-+ACM-define TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SM3+AF8-256  0=
x00000010 +ACM-define
+AD4- +AD4- +-TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA3+AF8-256 0x00000020 +A=
CM-define
+AD4- +AD4- +-TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA3+AF8-384 0x00000040 +A=
CM-define
+AD4- +AD4- +-TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA3+AF8-512 0x00000080
+AD4- +AD4- +-
+AD4- +AD4-
+AD4- +AD4-  static const struct digest+AF8-info hash+AF8-algo+AF8-list+AFs=
AXQ- +AD0- +AHs-  +ACM-if
+AD4- +AD4- IS+AF8-ENABLED(CONFIG+AF8-SHA1) +AEAAQA- -310,6 +-317,24 +AEAAQ=
A- static const struct
+AD4- +AD4- digest+AF8-info hash+AF8-algo+AF8-list+AFsAXQ- +AD0- +AHs-
+AD4- +AD4-                 TPM2+AF8-SHA512+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4-         +AH0-,
+AD4- +AD4-  +ACM-endif
+AD4- +AD4- +-       +AHs-
+AD4- +AD4- +-               +ACI-sha3+AF8-256+ACI-,
+AD4- +AD4- +-               TPM2+AF8-ALG+AF8-SHA3+AF8-256,
+AD4- +AD4- +-               TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA3+AF8-25=
6,
+AD4- +AD4- +-               TPM2+AF8-SHA256+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4- +-       +AH0-,
+AD4- +AD4- +-       +AHs-
+AD4- +AD4- +-               +ACI-sha3+AF8-384+ACI-,
+AD4- +AD4- +-               TPM2+AF8-ALG+AF8-SHA3+AF8-384,
+AD4- +AD4- +-               TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA3+AF8-38=
4,
+AD4- +AD4- +-               TPM2+AF8-SHA384+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4- +-       +AH0-,
+AD4- +AD4- +-       +AHs-
+AD4- +AD4- +-               +ACI-sha3+AF8-512+ACI-,
+AD4- +AD4- +-               TPM2+AF8-ALG+AF8-SHA3+AF8-512,
+AD4- +AD4- +-               TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA3+AF8-51=
2,
+AD4- +AD4- +-               TPM2+AF8-SHA512+AF8-DIGEST+AF8-SIZE,
+AD4- +AGAAPg- +-       +AH0-,
+AD4- +AD4-  +AH0AOw-
+AD4- +AD4-
+AD4- +AD4-  /+ACo- NV index attributes +ACo-/
+AD4- +AD4- --
+AD4- +AD4- 2.34.1
+AD4- +AD4-
+AD4- +AD4- ST Restricted
