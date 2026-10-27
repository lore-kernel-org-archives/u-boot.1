Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A77606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wJtpfkwz;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t4wb7Hh4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AB7B80E0D;
	Tue, 27 Oct 2026 14:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5oTY-ztAo8ID; Tue, 27 Oct 2026 14:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46F1380DFD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793112193;
	b=I7HWTUjPSfeyTySCzOnJjfm/ZDRuwHEF+p864fwBYAJnh/oPOXwSyMQh1Eh8AZWwrZBP
	 DIRzCKRYl4TO9L/1riQpsHS2chiEzLLWylI/5nOsWRNCCv5UerHgKiVXV3YqDfjOiZdkV
	 GsUdJC/r21Fu3hJ0ORpSyPhwzUd5azXCpzmpmksiXdIRIerNaGSn804eg+2SIZ87ng8BE
	 HwyQ3c7a/UASGFzlaTrxVnlJWLL9NrxzMchNk+Jn+f2+gQ0yhFXvsOZUkewghR4ARVE/m
	 3b2xZdYRxXN0huegHFzK+zihj2QASstfB74xWvmiKiiEXKxHb7nvGN2b2x/qII1uIAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793112193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wfuy9lYEhrEjHoqPjO56M/Devhl/M2LOooNKRA1DIiA=;
	b=B9yIZZZBQ+/l4dsj1qLZeDUtmAkQqlxarJWhjVPtDSRiN/NNwU4b7NprffaMP2u8J/2s
	 5CAQpoFPfp7ZFtksas75RLqPEPoU8JOjxOstl/0xRWCa8zm4Ww22C4XtPRoFmMLa/ZX4g
	 kNjA9OTvEcmM3ajQnPIlwYzAEcvzL9If3D8lFOupFWaXu10qClPIX6Z4JXAZ8fh4ClyCA
	 ImZNi1sbiN9edMyOL3LhKNZiaw+OYifKyLh7narfdEVLR/pMpvNooS9NuiGwa43fuA0SG
	 oLech3I32+SKIf/pJZe2XCf+dIpfod8ZTrA50jHOnt0RIJcZsIyOAmqFIwtlmLteGxw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t4wb7Hh4;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793112193;
	bh=wfuy9lYEhrEjHoqPjO56M/Devhl/M2LOooNKRA1DIiA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wJtpfkwz4qsGbyREBHB5e6DSEBmXa8kwCgsNj/siiLM9ekIW6YQogf3Voan6E/FvY
	 hwUC6QetRT2t4nQEXS9uHVAzpFTClXoDL6caQ1aApQTTPnXJmmGyDKbkAYllgzyK3u
	 rnfWoQVuIMG1D/JS1mukV9q/YV1AaIzvXP8UCvbwH8gG9lp5a5yfbAdVeMSOFOXshD
	 woDm6xo8AbMxsVy8i8ZIebvIbbg1Ww84gCLZPOGsi1VuPeSyw5U1aIabIArfz7X4le
	 3f/l6JW/zpueJjgkAVT9fCEe519WDOMXjjo0UMbeJjdo/+2d9T9A/V2SraszakzkG+
	 NYVBFKJ7HnXyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46F1380DFD;
	Tue, 27 Oct 2026 14:43:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B91A279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 313DA80DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKDiy8HR6b3c for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4869E80DE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112190;
 b=IXjm94izzQRzkOJJlcxuBURfp80k8IFIlcl/INaC9xx6R2vXXBVt4yHpxFKACyWpYE/w
 7GIH9HSgL4nMVq3FTuCQkh/PttaemDzCBKt+q+15Qt+1NlyYlzhwddBgdnxh7Yd3ui8b1
 Gp6raW6Si1gd4kqZudSWf4zBxXw57xyv6b6yygENkxlh3magwUk2vi9h8pvofv/SPjpyo
 dzHo+8Gl/9KKgcUXlleHGGGptUkNr8PPQ8SsPdSCeXB71DZIe5SBNA2iMWUYTnWZNxOPK
 caL2DcGyt2e3ByUazunUir+AgNAnfmH+HOmHy5RMNhfFH/uY7KOEQbZ3bc4i7M41PTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793112190;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=wfuy9lYEhrEjHoqPjO56M/Devhl/M2LOooNKRA1DIiA=;
 b=BrzYnV1SrcR+ImN7xJHJnKtOVrcQ691LQrtbxX9MIf/X2RWv+qWIYdIvwEuM7RHDZlfg
 kCK8ybS0FPXkcdy65PIeR+9SzfG+HWjwcccz3kjNQcmM/UOnj32GOBTX+n31rmgUB6sfd
 x14qM0W4ysHxVre7ez7BFa/jS3NfuT8OW1V60PRNcHpWWydYdrVWd46JUW3HZlzYwXlSm
 hoc1AztogZuAbalQ/x6XQWeoJk8p+sa0f6WUcX/clH56X+gnorm4OD8mBnBYZayFUqSTq
 4W1UiqCu8HdVv803znE6i+95DxaMM78/ml/+Kl89ZRDVB/Fhn73+x/HL21EQ0o44/CA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t4wb7Hh4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t4wb7Hh4
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4869E80DE9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz7W/datw02+7VRa2dpHqO5zjSUl3+D7GaBsyrTF8gTYFFOTh1uZfXEX3nlkF80uOkIN4UBlxmlhE6Ha6hMdYKB63XHWXyVJIgQh7RF00/MkwWmgGR4hNkqsMjHOVAiecuQkYkoAbRlbdFEvzuI7IAEck8LKKYQfE0KsvrHPuPZYUvJNx/rtzNa63XBUsgsyWmG+saH0oWka7Ni6o4fXIiTN8nmEPTLhjTZNCkSL60foNoHlfY98MnF2zRHR5U3WfU0xqt+2UlFyjqzL8nB9jeURRP+W6pVj7rUXYCRHFaRE13dN11sj8zXga6HJ4YsdbZEwCIj8VsWYCuYyZNh+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfuy9lYEhrEjHoqPjO56M/Devhl/M2LOooNKRA1DIiA=;
 b=Vbr7qYAau3xEF3ubjlQDvM4cEbOAlr1BvOeZnjQdeskWVUb/bRZjb9F8lw6BYRehQVb4UHx775nMM0ueU7MmYvHIdQtngeaWc5FCz8Efl6RFxPcrgxp3F2iCqu4yxmzuEvvG6T/3CDF3jHuQUxc7QGunCCiBGp+TBAp1ft6NIeEDv44JOMIum0dmINnL2oTEhVo1P+SUhVzRkGzMxwHvZH6BfWZJSTOFmv3dabiNH8GSNa47bdvMePRtdkpDNLkZkg5mSo5W8mFd+1vPE9Qsoiff+ptr66qCzzMKPAwX4mhfChwfhdFXvJf72CXmyhgu/GNxPOaH4AiAtRm+YPHEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfuy9lYEhrEjHoqPjO56M/Devhl/M2LOooNKRA1DIiA=;
 b=t4wb7Hh4ww/GOiXvf90hR8qjmKKb5n2Zt0hKNxjYcLro4ag3DxhbB1CihknpLOOIKSyvo7INxlQHJ4zYjskcIuIiHQ0urE9TaBipOaPo13IkjjukdfgAMv2KnOKpIqh6vZkcfQ9spYwNlbaOQoreEqT3O1epy5KJy6fINbxccnM=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:42:34 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:42:34 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 2/4] mtd: Add virtual concat support via device tree
Thread-Topic: [PATCH 2/4] mtd: Add virtual concat support via device tree
Thread-Index: AQHdYi186zlGExD+L0ejRbZk48bVMrcMQRaAgAUjFHA=
Date: Tue, 27 Oct 2026 14:42:34 +0000
Message-ID: <PH0PR12MB74709EC92E48B1AB5187BAFAEC602@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-3-padmarao.begari@amd.com>
 <CAFLszTjH=dFNR418iH4Je-QB2rb_zap5+eEA7Ljka3mKzkOxaA@mail.gmail.com>
In-Reply-To: <CAFLszTjH=dFNR418iH4Je-QB2rb_zap5+eEA7Ljka3mKzkOxaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T13:08:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|DS7PR12MB9503:EE_
x-ms-office365-filtering-correlation-id: 451c9f10-6a44-45e4-70a9-08df343889b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261026140227099003|38070700021|4143699003|56012099006|5023799004|11063799006|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|261026121527099003|6133799003;
x-microsoft-antispam-message-info: XGxS4Rb1f1kGCweJCkreFErtSJx+fiw7zGwgBW5uOdA36aO2mmHwEZ8BACOWUNMmehMP12c7TabTJLMSReL0QPQnCT8GydzlVg0D4hf6Inpgtpzrx9l2bB3RubDlCW2mC6WZGN56P4rtL5g1n8NO41V69wThjYp5kfU9UTd5793Z8SX2fpt2zTXLOjfaQZCZNYLgtgEcvx7f1RY18HMqKHWARpALR/c39Y8U1d5HGVyViczYIFrEpOBjVVLSGS1gqGQInyy3ozdpIRZM2CjFiA7U/amgws0E1E9D8AonB2vIBTPBgVEAllNcpK4MZUIbr6WEq0oDzG+i2cnnrVzp/hD/PDuiHQVFS8PHVXSraytWhrGc0kriL1s4ZV8IRKKuIdxd1Nbd/0AgJhccgTb5bUTUAMEBOScO5G/7ye6H0+Ac3YF44dUlgTsvK6p5wt3aMK62OFDGWsw3oM9eQR5gx3sN4nzS2e6i0K4D7ZZPW93Bbf4YibcmMDrQqQALXf/2KSsIg7Kptd7bLDzE4H20eLN9sZITk8Nmen9YuqrPQjVlxojhJOuxqUdTBftRw8ucXT/++N4O3jF5gRb/YadFx3yKYOtLsgqIDvQa2VPmhVcHoOQnJOjgPKNabTrapsQFK0ybaO9kwkYK7QyxXxHwhXYcjY7eQbHSrQ7bbtDaKGE4+mjoppozaNyfPn/mWv5sbVa0Sh7w/o1Yup26Pze6tuq+ljrk2CU9TZqK+ki87OQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261026140227099003)(38070700021)(4143699003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LglSMSN7FCpA/mUY4bmos4R0TYwW2l7Xo5o4gJtbeK27KwBa1LBYyykhTEcC?=
 =?us-ascii?Q?PWNtywmUS3ahFYg4/wnif6huf7sXIJ2pkoU6yOuyM7KHnFKouKn8jRRa/Eld?=
 =?us-ascii?Q?aIGwIFQ/u2OLS/25f89luKfq9dGt/+l2twZxPh1oimDfBt3xOBFzran+zQda?=
 =?us-ascii?Q?KO+Zjws2ylgOUKRVkJrHh0smRJKcL5t/TxnZZfQY8D1VaE2Se2CTKCRT7acc?=
 =?us-ascii?Q?YacoR+eGb0rNOz+X0RnEvxrZamGZl7a2tk9RJBY4rS386mNzLbINJK1EnpzF?=
 =?us-ascii?Q?20nu+XjAtupUuSBQi7aacGArNpYY5/Nz5pL67sbP7QEKJqKzeY/fjUjbX5Rv?=
 =?us-ascii?Q?TkN6YfQIQbr2lZcF4yULTINpi2WkDIz/+tIVQxnnJbq2RZfdjkVaHVWkMZVX?=
 =?us-ascii?Q?BuMBDiW//5L/PTcX9Th2NriSeyxEMHrw26/zw9nr9qT/OgZLw3yHx41noush?=
 =?us-ascii?Q?rmFjGu1j7cLWVBm+9RfabaooZX+lKB3ND+/2WSbiJmg1S4cNgDK1v+ooMZvq?=
 =?us-ascii?Q?hUS1QBJH45b9cTOQ38lMr9yF9SJD2uwyar/UB7APGA64UZeXpIX6nkU1j/dz?=
 =?us-ascii?Q?W1pk104kxiZTiQrt0hRyuM/Owjn2qrVa9iGiwHzG7dNCwt52Eveb6hdUZuV6?=
 =?us-ascii?Q?c9Xhj17+QsXvwLgdYtE2hX5ZuJoxdiyGLkZ3Cdlbexz+O6qNlItPoImKcMjx?=
 =?us-ascii?Q?GXNMZBDlwFcsP1R+dXFSkj+EpF17Oz9ejQRgBsRqqQ2q3+0HKR+ZcAAKOBbc?=
 =?us-ascii?Q?FQkX2QoE3MFZmyUSSubPXccoozH/c9Ky/3HbUAA0DTFBLrIV5io/ASYE83Q+?=
 =?us-ascii?Q?EaWkAYL0e7b44aCHFNm669Vj+cuqs0gIj6P6e4tWj/hAL0Ug0cgl3D8Cv0k1?=
 =?us-ascii?Q?zpuEu6X86fEqKm3lUYcTFVe+CorvPzQi5TTWK6iUuGwxLEE+5XO7J9fJ4q0I?=
 =?us-ascii?Q?NXaS9N14oirrUFuTyenYwPRyY+6cDpj8bDSD+I8HiLv8dcpd840BXjkFwp7H?=
 =?us-ascii?Q?6CA7SiVbpL4t97iNzpKtqvOMh3RAZVWcv7UyY1k1sVKzrIanJ39WMGkJfeki?=
 =?us-ascii?Q?UbGdLwDdIV3EbM2qW070lmD9rbdfiqa5TzAd+snm36+n0vMFOw4XekDt4K5r?=
 =?us-ascii?Q?xZekN4YM26/8j71qV+0m7QhTFcENYXMKTXUStcQoTJdDYc1W9K1nvXX1Vf4V?=
 =?us-ascii?Q?7GqP1Mr3iixYnIk2yv1KlJKIL/xzw1iDAIN7nu8FqUchSh+KTVJ6qXlyDAAz?=
 =?us-ascii?Q?fOj3DvS1ZZly8rZW3CorEUbfHx+8tZVccsF+JRulU4+g35o5aiygIjZhD3ar?=
 =?us-ascii?Q?QTpk7Nh3TPzZb0T9fHTiXMbc1su7std/I5QOgZzD/beZ+Ki6EKq/rXDjDxW2?=
 =?us-ascii?Q?h1tyEw1EWrG2sROg6RWN412yyU4H7d7Kn2ICUgdLhDV9w2g568b5xaC1oqqr?=
 =?us-ascii?Q?0v8OUpBPL/oBO0GO/0D6uORIjaDY+tUdsjaBDNeJVeo3b7W6kMyI6+3beWUS?=
 =?us-ascii?Q?2GUYheo3nBSIivK6i/W1YGo2u/qDqW5CfJUTftCT6jIddrr30+kgt504FZSG?=
 =?us-ascii?Q?MM/e4B0wy4yFIdGaJNLlA/+UfOfrqqlJgC1K1Ynwy7f7YNcycZ4pMkTtAdMb?=
 =?us-ascii?Q?cno/MAvQI+4fPtzcBHFug7p0sS5lDvDSQk/wcg4IPr/+7AoFi5RodTS5IjS3?=
 =?us-ascii?Q?kCtXqHs6hIhKtAaatGxmXhH3qQWyVQfA0kz56FkOnPqR+1Ol?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c9f10-6a44-45e4-70a9-08df343889b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 14:42:34.2614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbEFHkvn6sbISIARpHulceUNnrBn3rO35FkDLE8WmUg9xPK2HKiNarmXZjwWieSfLGbSXJPoLATAp/rIm0hQyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi Simon,

Thanks for the detailed review.

> From: Simon Glass <sjg@chromium.org>
> Sent: Saturday, October 24, 2026 12:12 PM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>
> Cc: u-boot@lists.u-boot-project.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 2/4] mtd: Add virtual concat support via device tree
>
> Hi Padmarao,
>
> On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> > mtd: Add virtual concat support via device tree
> >
> > Introduce CONFIG_MTD_VIRT_CONCAT to separate the legacy flow from the
> > new approach, where only the concatenated partition is registered as
> > an MTD device, while the individual partitions that form it are not
> > registered independently, as they are typically not required by the
> > user. CONFIG_MTD_VIRT_CONCAT is a boolean configuration option that
> > depends on CONFIG_MTD_CONCAT. When enabled, partitions declared with
> > the "part-concat-next" device tree property are transparently joined
> > into a single concatenated MTD device and not registered individually.
> >
> > The solution focuses on fixed-partitions description only as it
> > depends on device boundaries. It supports multiple sets of
> > concatenated devices, each comprising two or more partitions.
> > The "part-concat-next" property is set on the first partition of a
> > group and lists the phandles of the other partitions of the group, as
> > described in dts/upstream/Bindings/mtd/partitions/partition.yaml.
> > The partitions are joined into a single concatenated MTD device named
> > by joining their labels with '-' and appending '-concat' (e.g.
> > [...]
> >
> >  MAINTAINERS                   |   7 +
> >  drivers/mtd/Kconfig           |  14 ++
> >  drivers/mtd/Makefile          |   1 +
> >  drivers/mtd/mtd_uboot.c       |  13 ++
> >  drivers/mtd/mtd_virt_concat.c | 502
> ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/mtd/mtdcore.c         |   8 +
> >  drivers/mtd/mtdpart.c         |  12 +
> >  include/linux/mtd/concat.h    |  57 ++++-
> >  8 files changed, 613 insertions(+), 1 deletion(-)
>
> > diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig @@ -32,6 +32,20
> > @@ config MTD_CONCAT
> > +config MTD_VIRT_CONCAT
> > +   bool "Virtual MTD concatenation via Device Tree"
> > +   depends on MTD_CONCAT && DM && OF_CONTROL
>
> The hooks are in add_mtd_partitions_of() and the MTD_PARTITIONS version o=
f
> mtd_probe_devices(), so without MTD_PARTITIONS this code is built but nev=
er
> called. Please can you add MTD_PARTITIONS to the dependencies? Since the
> option depends on DM, the
> IS_ENABLED(CONFIG_DM) check in mtd_get_node() is also not needed.

Ok will add MTD_PARTITIONS and drop the IS_ENABLED(CONFIG_DM)

>
> > diff --git a/drivers/mtd/mtd_virt_concat.c
> > b/drivers/mtd/mtd_virt_concat.c @@ -0,0 +1,502 @@
> > +   mtd_node =3D mtd_get_node(mtd);
> > +   if (!ofnode_valid(mtd_node))
> > +           return 0;
> > +
> > +   list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
> > +           is_mtd_found =3D false;
> > +
> > +           /* Find the concat item that holds the mtd device */
> > +           for (idx =3D 0; idx < item->count; idx++) {
> > +                   if (ofnode_equal(item->nodes[idx], mtd_node)) {
>
> One thing I'd like to check here. This is called from mtd_device_unregist=
er(master),
> so mtd_node is the flash node (e.g.
> flash@0, via mtd_get_ofnode()), but item->nodes[] holds the partition nod=
es under
> flash@0/partitions. I don't see how this can ever match.
> If it can't, unregistering the master (e.g. from spinand_remove()) leaves=
 the concat
> registered, with subdevs whose parent has been freed. If it did match, th=
e children
> are re-registered with
> add_mtd_device() but never put back on the master's partitions list, so
> del_mtd_partitions() would not clean them up. Has this path been tested?
>

You are right, it never matches. This path was not tested, the same compari=
son is in the Linux driver, which is where it came from. The only caller of=
 mtd_device_unregister() is spinand_remove(), and SPI-NOR removal calls del=
_mtd_device() directly, so it is never reached on the QSPI/OSPI boards I te=
sted.

will check the members' parent instead, destroy the concat and free its mem=
bers, and not re-register them here. The next rescan will add the remaining=
 partitions back normally. I will also cover this path in the sandbox test.

> > diff --git a/drivers/mtd/mtd_virt_concat.c
> > b/drivers/mtd/mtd_virt_concat.c @@ -0,0 +1,502 @@
> > +           /* Destroy the concat */
> > +           del_mtd_device(item->mtd);
> > +           kfree(item->mtd->name);
> > +           mtd_virt_concat_put_mtd_devices(concat);
> > +           mtd_concat_destroy(item->mtd);
>
> This teardown sequence appears in mtd_virt_concat_destroy(),
> mtd_virt_concat_destroy_items() and twice in mtd_virt_concat_create_join(=
), so
> should be in a helper. The err_rollback loop in mtd_virt_concat_create_jo=
in() also
> duplicates
> mtd_virt_concat_destroy_items() and could just call it.
>
> The sequence also leaks memory. put_mtd_device() only drops the use count=
 and
> mtd_concat_destroy() frees only the concat struct. The slaves came from
> allocate_partition() but are not on any partitions list, so nothing frees=
 them or their
> names. Every mtdparts/mtdids change re-runs mtd_virt_concat_node_create()=
,
> which leaks these and allocates a fresh set. The return value of del_mtd_=
device() is
> also ignored, so if the concat is still in use (e.g. UBI attached), the s=
truct is freed
> while still registered.

Agreed, will add one helper that is used in all these places and err_rollba=
ck will just call mtd_virt_concat_destroy_items(). The helper will check th=
e return value of del_mtd_device() and leave the concat alone if it is busy=
 and will also free the member partitions and their names.

>
> > diff --git a/drivers/mtd/mtd_virt_concat.c
> > b/drivers/mtd/mtd_virt_concat.c @@ -0,0 +1,502 @@
> > +   /* Check if any target node is already part of another concat */
> > +   for (i =3D 0; i < count - 1; i++) {
> > +           node =3D ofnode_parse_phandle(parts, CONCAT_PROP, i);
> > +           if (!ofnode_valid(node) || mtd_is_part_concat(node))
> > +                   return 0;
> > +   }
>
> This silently ignores a bad DT (invalid phandle or overlapping groups). P=
lease add a
> log_warn() so the user can tell why the concat device is missing. Also, s=
ince this
> loop already rejects invalid phandles, the -EINVAL path in the second loo=
p below
> can't be reached.
Ok, will add a log_warn() and drop the -EINVAL path.

>
> > diff --git a/drivers/mtd/mtd_uboot.c b/drivers/mtd/mtd_uboot.c @@
> > -366,6 +374,11 @@ int mtd_probe_devices(void)
> > +   if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT) && !ret) {
> > +           if (mtd_virt_concat_create_join() < 0)
> > +                   log_err("Failed creating concat MTD devices\n");
> > +   }
>
> Groups that are still incomplete here (count !=3D num_subdev) are left al=
one, so their
> intercepted partitions are neither registered nor freed. Unlike Linux, U-=
Boot has
> probed everything by this point, so nothing will complete them later. For=
 example, if
> flash@1 is disabled or fails to probe, if a target partition has status =
=3D 'disabled', or if
> mtdparts is set for one of the flashes, 'rootfs_a' just disappears.
> I suspect it would be better to register those partitions individually he=
re and print a
> warning. What do you think?

Agreed, that is better. incomplete groups will print a warning, and their p=
artitions will be registered as normal partitions.

>
> > diff --git a/drivers/mtd/mtd_virt_concat.c
> > b/drivers/mtd/mtd_virt_concat.c @@ -0,0 +1,502 @@
> > +/**
> > + * ofnode_find_node_with_property - Find a node with a given property
> > + * @from: starting ofnode (use ofnode_null() to start from root)
> > + * @prop_name: property name to search for
>
> ofnode_dfs_next() and ofnode_find_node_with_property() are generic helper=
s, so
> please can you move them to drivers/core/ofnode.c, with declarations in
> include/dm/ofnode.h and a test in test/dm/ofnode.c? An ofnode_ prefix on =
static
> functions in an MTD driver is confusing.

OK, will move them in a separate patch with a test.

>
> > diff --git a/drivers/mtd/mtd_virt_concat.c
> > b/drivers/mtd/mtd_virt_concat.c @@ -0,0 +1,502 @@
> > +/* Forward declaration - destroy path calls this before its
> > +definition */ static void mtd_virt_concat_release_subdevs(struct
> > +mtd_virt_concat_node *item);
>
> Please can you move the function up instead of adding a forward declarati=
on?

Will do

>
> > diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
> > @@ -33,4 +33,59 @@ struct mtd_info *mtd_concat_create(
> > +#else
> > +
> > +static inline int mtd_virt_concat_node_create(void) { return 0; }
> > +static inline bool mtd_virt_concat_add(struct mtd_info *mtd) { return
> > +false; }
>
> All the callers already use IS_ENABLED(CONFIG_MTD_VIRT_CONCAT), so you
> can drop either these stubs or the IS_ENABLED() checks.

Ok, will keep the stubs and drop the IS_ENABLED() checks


Regards
Padmarao.
>
> Regards,
> Simon
