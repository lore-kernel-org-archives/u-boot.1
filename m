Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87132C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31E2380FFD;
	Mon, 17 Aug 2026 16:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SF0m8sEZEnte; Mon, 17 Aug 2026 16:23:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6012380FF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786983787;
	bh=hP/5kVurS5TvVMy0VRVxLNhyDy0PuviyrnKnyL/w3ho=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvHQuxKlJ9e8w7tIpU+ZxzXGTpEeEm8w2yf93BxqCPLuHSZDF3FpKuNRGVu+6qmHn
	 nVvGZ3G8nOxR60olpm+rRbcDTBTO7XtM5XcjHkyf0GGujlra4jK32Ax9xO49glRcAq
	 LhdOKQYLaBPsW5MES45ub9NoMlbgZ9znHmTkjg+dOdEFS1taPMfo0H2hl+QkCMn9Lq
	 s0PuuKlhFRNHGlrRdxrUkJMEnK3Z8IwVYQvTv5M1vlw5E45YLZEquta/6X7nS3clpt
	 hWQWQPRTVK2//T0EZhjaoMPBJpPrfjMn5PpnV/8NsQ9Z0yRmO8LPOn3A84ZBksFJOQ
	 EjlatlkjmQjEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6012380FF2;
	Mon, 17 Aug 2026 16:23:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 114E3194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 034E4401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ah9BvMnid0ua for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:23:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=conor.dooley@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9651440130
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9651440130
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=selector1 header.b=MXvYvYCk
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9651440130
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWq4vvrEmcP38/DvI3Kz850TRFNgDkeAzGD6qzqpbiodKwQS3Mk0lC8fVDjuIFV8OVX1fjM9IaCWogz4pfF7N5scEHW8PlaOPJA91PZZQjLA+FjeHbXMrWa8k+WjtP2VPwpHnFjA0A3WuBrFS+O7d/t4CKjVR6sdkGB6M9Co4df+yVDqP0Ohh8pNBNa2kgscFB3XjEHa7ZC/HR2Gd/BziJSgiAeA3I8bfIamtwp/Llzfs1DwV2etyLp2yIaaDgOjkyVmxAZB8F8mD1IZtrL+cKGktWB6epFg6DJ1VC7QSOQahOzAiQfrHzlkV9EBq34ni78IJS5DzvLA4J7ggOOWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP/5kVurS5TvVMy0VRVxLNhyDy0PuviyrnKnyL/w3ho=;
 b=qE7kMkic/lu07JL+XN4Yam5P7WR1oHSjtEBSl43edjIRLGP7hCflrP134LHywPbZ6OOw9KGlneAUpcb/Ufh1HwUXlvh9d5SMONB9TfR0tjo575LIVYz0w0uOPxj+mAgleu271hl6+vIvPRDgfzYsvuvrtYGet50S/pTbisYTSI98arlprkC1RIAwC8260RNGDE4DI9g6gfmdZjZvQAKvrYeq69oAp/yMKXL9LsreDH2o3NN7Ivo0GCBoW2GTly850Eq4tM+gAFjMQ5E34NWUfIVk9+0N8mLbbqbmkodDbUzXarHmsu2H1u8PKzsvK2mirxHSjNCfFqxvOp0vveYJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP/5kVurS5TvVMy0VRVxLNhyDy0PuviyrnKnyL/w3ho=;
 b=MXvYvYCkMD77FyJqjI/Xj9gVvirlA8zkiaiRdLShEwJNmGa0DPmw3uFUcNe6xDGLPmwTok6ZyiIPqu9MswAZEZoxpf5UJTsOxhyV2MmRmhwuzUifM/8TbdGFrj36407tGfU2h1LeL6AC30EJbm5xIkHTIS6KnoaRPdIpkvICHJBnd3DqdrcNX8tEz65/L6YQ1rbx+RWz2uemtQdBYGgyBO4rVz55xGlL6xBmzw/ze8yn2puz7DWZbfSVZ/VpXW4QmynMOKP0gadUrXczeu6mC8KMTnT1AR0MV5JB59QvdZALaOvYLH5GXP6d68VT9TF+5ZVG6dyOQ+nK2k+uVX7M6w==
Received: from DM8PR11MB5590.namprd11.prod.outlook.com (2603:10b6:8:32::8) by
 PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 16:22:55 +0000
Received: from DM8PR11MB5590.namprd11.prod.outlook.com
 ([fe80::238d:9dcf:c2c7:75e6]) by DM8PR11MB5590.namprd11.prod.outlook.com
 ([fe80::238d:9dcf:c2c7:75e6%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:22:55 +0000
From: <Conor.Dooley@microchip.com>
To: <nwhitehorn@pa.msu.edu>, <tim609@andestech.com>
CC: <u-boot@lists.u-boot-project.org>, <Jamie.Gibbons@microchip.com>
Subject: Re: [PATCH] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
Thread-Topic: [PATCH] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
Thread-Index: AQHdG5LoIcywm7uClkW6lIiJfLwlWLagm/IAgAHXdoCAAB7CAA==
Date: Mon, 17 Aug 2026 16:22:55 +0000
Message-ID: <a332c1d0-5228-41c1-9228-5e22338f0109@microchip.com>
References: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
 <2ityfs2bulvplo6klwvv3jqb7iybjt7225xj7nmmbp7tofsv3m@jsbyw2shn2ss>
 <1f83d1e5-bced-4fe2-8afd-1ad5e215ad1b@pa.msu.edu>
In-Reply-To: <1f83d1e5-bced-4fe2-8afd-1ad5e215ad1b@pa.msu.edu>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5590:EE_|PH3PPF632600ADB:EE_
x-ms-office365-filtering-correlation-id: 29f49407-7e1f-4ef3-15d7-08defc7bcb1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10070799003|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: lCUypp1ZDkeKOvmR6mGIlKG2VI46euLNKFdF9ZNmhVb0fpITU3ochTXmf/y1fcI7WiCD43MWEJBYdxgjbq476Qgvh8UOJCMxorfXAxd5veaZ7baaYbObBt3P5VMKlRBWStWZBVfm9JIwNHxWaCmV+eKx9RsvoaI9piS+TL96/gZ5gUQxN1JHSWg/vsilhKPcuJgfZ48WPsBtbUKB5SJMhDK4MDyHXmzFUeHeGbFUpSv6alEtqtGh8WFtO9P91T4kvFrikz5SIgPGKB5YtGx04EiG49YHngH1WNcbN1TUNRLLKo/i03Ik8Ycda9GcZ23GSYGjRaw0WGDf2gTpYpoer24J+oaGw1vKwWlxct64TulsAihB55T0XT7j45qQ9B9wLgULwysMG+bRDbLTwiTrzdYwS4muvODsOKzkjrNeRRjvj+r1zJux5NDvamTcdU7DAgCAHbBlXwuKhassezfUCEgqDTVnG5sbit5jqsLtrj1vgEUhW63lr4hZ9d53QA6VKb2eXvCKeiZ0Yt6w1l+CRY/rSZMgbqn8BzyCSxm5smPL/UAucYlnNdAHiZDyTEHEjJ8aJEuQO+y6GQBG/wes5LYy4H6IMYR7SHEtZBi9rVKGGzYs3ep+0vlO5dXV3Linom0lk/Eu4QpodrJ1O8E/DmYWs7gG4dTNva0PI6153X80SamR8XESqzMwcIedxeWwe2GMhP3YLC3B1JpAkqB0JQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5590.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c25Ec3VnSk9hb3hIU1JHRFo4MGVkUWhHN25zVHNBVHo3bkREUHNKUE9MVU1R?=
 =?utf-8?B?eEdnZ1o2dVZTSlBFaUh6YWdpaVJQNXZtTWE3L2MydVljTnBIbkF2STR3K0My?=
 =?utf-8?B?eEdVQWJzU2NGYzU2Tks3RnUvbTB1MXdpRHpqVi81aEp2TEpESWxwTExZU2Vr?=
 =?utf-8?B?b0NFSEdTZGRQMXE3OU1pVStpVFNBMytZanlTOUp1bXRqeENsS3dGVmFmM3dz?=
 =?utf-8?B?TjRmaHlUbWg0MTFWZnpwZ2kwMVUwMitkVmNsdkFDRkNyekZoK0JsejZpcnhO?=
 =?utf-8?B?MlVLdTh1dDQvOFhjR3dhTFhCNUJLWmcyeStJbDk3SFF3YXdBYTVjT2sreWQ3?=
 =?utf-8?B?MDZoMjUzT3Z2cnVYMUt5U1ZtYUNSOFl2aDhCQ29oUEJudnNzR2FlazlsTnA5?=
 =?utf-8?B?M1JLQXJSNkFkWUxvU2p0cGlRVzY1NlFIMHl5bTBGS1MybCtwUWkvdVRLRzdI?=
 =?utf-8?B?YUJmWGFVZmxJcVJSUWp0WUs5NWJzYTJkTEljSHpjSjFhYkpTRXQ2eFl4ZG1q?=
 =?utf-8?B?YzhJL0ZjUmthWEhINlZSZ2s3SGJoZDloeEd1a1k4alVDc0YranRaN0hsK2JX?=
 =?utf-8?B?NDhRRjRKOVp3aG1iZzBrd29NeUdZbmQ4RmtwZ003UmlLcXpIYmxvZW9ycy82?=
 =?utf-8?B?MmcrU0F6NnQ0V1crWStJQ08rS3JtYm1FK29DS3lZcWN3SWtVaURVSE91YUQ5?=
 =?utf-8?B?ZU84V0NDMStKTWN2eElOVzQ1VDNuYVE2TDRJMFBZK284QnJxWGZyc0wwTm5k?=
 =?utf-8?B?d25Za2VDWGFidEhwZnRqQWhzRHEzRWVHTDgyb21kY0w5M3BsQTAvS1d1MjFL?=
 =?utf-8?B?YVdnaktPdTRuVCtHUkhRSkRvUzdSa0dqanpvS2pNQjIrZkIrZzZ3RFVZU09U?=
 =?utf-8?B?Lzc0Vk9DM1U2aEJaTUs1KzJ0ZldwWTRocWRnWUlGZ2FrRVJtWVd0RjRPU3hQ?=
 =?utf-8?B?dG41RU5RNUdMaFlqWmFqMWNQR3g4K3Z3eTdhbkRlOUdNbkE1aUEyYmlmT0Rq?=
 =?utf-8?B?NVI2SmEwY1FZSXV4VjBYM3Fmam44MVBGZmxMd1Q4NjFJdmFGUzk0ZXpSZVpm?=
 =?utf-8?B?VXRHbXk4c1pXUWgvci9jOUhjeFBHV080UTFaa0dCeVFLZTljSCtRYk5xZUNE?=
 =?utf-8?B?V1BJa29EOVh3a3lLa2ZKSDNnRG84Zk1FamtBUHdhNXhGTGlJQmJScjgwQktN?=
 =?utf-8?B?ckpZYVlyd0ZKOG9jNUFaMTY4ZjRtVnVwT3Ura1U0QjhPQ1RxcENtcUFGdFJS?=
 =?utf-8?B?bUpXdGRkNGt6WThPckNxbmk4QjhvS1paUm1tQURYWi9kNGNQbHhyMHFrN3lR?=
 =?utf-8?B?K09iME92anZ6eTFnUlhvdlVaTmZGV2VLZk4yeGx6aWZIOXgzKzB6NW9xMVVz?=
 =?utf-8?B?dllhZ05SUFlQL2c3UWk1dUdkOHpySmVnUVBLSS82cmtqVkk2MXQ3T25mTjE3?=
 =?utf-8?B?emJHM1B3YXBSNVIyOHNuVDFQdzRhRzljWHZLOGZ5UDk5Qm9FRk5CSUJvWWh5?=
 =?utf-8?B?NGZJRGdnQ2tCVTVZSWtYYVhCdGJLaW1XWGJPSDJCdkZseXZjTU45cCtjNEgr?=
 =?utf-8?B?TDFKc2xCODY3K0Zhb0dEMjlaL2pjMVMrSDhISldjcmNiV1NpYTNwL2xOQWhW?=
 =?utf-8?B?STBnbWtDdHNMajhaV3NzT1BlMzFielhsOVM2bFRCZlRzb0c5RTdQUXJCazhI?=
 =?utf-8?B?NXNKTzl0VXpuL0J2UWtWV3NQMlpueW40ZjB3WGFaM2ZqOVZEVDJueVFwQXg1?=
 =?utf-8?B?Q1hQZ251U2tIVUZLMkRwYTJpQ3AxRkJuMExxSkxLSTBkV204d1k5c3NlaEV4?=
 =?utf-8?B?MFMwQ3dxLzVuMGxUNXNYdW14QnV3MjM3bDZFc1VlOVZMS3FpaStTSDRqQTR0?=
 =?utf-8?B?bkNGTUVnMUNYM0VjK1dxWkY2enZzVU0rd3JPUHZ3SGsrRjVPeUFZWlh6WElz?=
 =?utf-8?B?K0hZYU8vNHhRZ2ZWMXVVMHFjVWVXNlZ2V1o2b2R2cUpnSTRlNkY2eEhJTllx?=
 =?utf-8?B?WDNWVXphZWF5TlRIS3AreHFDalA4ZGFxMyt5bVFub3hQczQ5cDg5WFc2cXNa?=
 =?utf-8?B?SUpEbWlBaHBVRjl6cjNhSlBRb2MvKzI5QUMxU3hmaEppeDBJeFhlQWlvdXdB?=
 =?utf-8?B?ZDRtdW5zaXFQUE5hOTczZzZHK2R1d1EvV2k4UERPWEFmSy9lMkFSZ3RoRzBB?=
 =?utf-8?B?dmZyS3ZPTWM4cmV1TU1sWWw5Q1pFRmE3ZldDRkJuL3NoY3VmalpoRU5uM1Vm?=
 =?utf-8?B?YUs5RzBnK08rZUtNbWFjOC9WSHNVWEppekt5VHJSeXdla1htU0xhNVVIVisw?=
 =?utf-8?B?VXRqNElFSHN3SjlGTGdSYWUyb2pOVkZobmFGTXhSU2J5Z2JQNENma25kc0Nx?=
 =?utf-8?Q?X4D06vD8C5fBK++3/t8veZRCYme77BSquujhF8tt4u5jI?=
x-ms-exchange-antispam-messagedata-1: /w+Bt/Ej4Blthw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E03AB2F52343504FB78014E3366D0B40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f49407-7e1f-4ef3-15d7-08defc7bcb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 16:22:55.1559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9d7YH7nXG/sbbcqg3/TnDMvRydsoexC8FSizus4ZaJvb9ZEYnv+FrgxR1KlYIiScYP+bMIUgMbhgEvNw+oOFQvCb9EtZEDzj7Pf/YEZcPqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
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

T24gMTcvMDgvMjAyNiAxNTozMiwgTmF0aGFuIFdoaXRlaG9ybiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA4LzE2LzI2IDA2OjI1LCBUaW0gT3V5
YW5nIHdyb3RlOg0KPj4gT24gRnJpLCBKdWwgMjQsIDIwMjYgYXQgMDE6MzM6NTBQTSAtMDQwMCwg
TmF0aGFuIFdoaXRlaG9ybiB3cm90ZToNCj4+PiArwqDCoMKgIGRlc2lnbmlkWzMyXSA9IDA7DQo+
Pj4gK8KgwqDCoCBmb3IgKGlkeCA9IDA7IGlkeCA8IDE2OyBpZHgrKykNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzcHJpbnRmKCZzZXJpYWxzdHJpbmdbMippZHhdLCAiJTAyeCIsIGRldmlj
ZV9zZXJpYWxfbnVtYmVyW2lkeF0pOw0KPj4gVGhlIHZhcmlhYmxlIHNlcmlhbHN0cmluZyBtYXkg
bm90IGJlIHByb3Blcmx5IG51bGzigJF0ZXJtaW5hdGVkLg0KPj4NCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoZW52X2dldCgicGZfZGVzaWduX3ZlciIpICE9IE5VTEwpDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZkdF9zZXRwcm9wKGJsb2IsIG5v
ZGUsICJmcGdhLWRlc2lnbi12ZXJzaW9uIiwgZW52X2dldCgicGZfZGVzaWduX3ZlciIpLCBzdHJs
ZW4oZW52X2dldCgicGZfZGVzaWduX2lkIikpICsgMSk7DQo+PiBJIHRoaW5rIGl0IHNob3VsZCBi
ZSBzdHJsZW4oZW52X2dldCgicGZfZGVzaWduX3ZlciIpKSBoZXJlLg0KPj4gUGxlYXNlIGVuc3Vy
ZSBhbnkgbG9uZyBsaW5lcyBhcmUgd3JhcHBlZCBwcm9wZXJseSBhbHNvLg0KPiANCj4gVGhhbmsg
eW91IGZvciB0aGUgcmV2aWV3IGFuZCBmb3Igc3BvdHRpbmcgdGhvc2UgZnJhbmtseSBlbWJhcmFz
c2luZw0KPiBidWdzLiBJIHdpbGwgc2VuZCBhIHYyIHNob3J0bHksIGluY2x1ZGluZyB0aGUgc3R5
bGUgY2hhbmdlcy4NCj4gDQo+IE9uZSBxdWVzdGlvbiBJIHdhbnRlZCB0byBhc2sgYmVmb3JlIHNl
bmRpbmcgdjI6IEkgc29tZXdoYXQgYXJiaXRyYXJpbHkNCj4gbmFtZWQgdGhlIGNyZWF0ZWQgZW52
aXJvbm1lbnQgdmFyaWFibGVzICJwZl8qIiBmb3IgIlBvbGFyZmlyZV8iLiBXb3VsZA0KPiB5b3Ug
cHJlZmVyIHRoZXkgYmUgIm1wZnNfKiIgaW5zdGVhZD8NCg0KUGxlYXNlLg0KDQpGV0lXLCBJIG1p
c3NlZCB0aGlzIHNlcmllcyBvcmlnaW5hbGx5IGFuZCB3aWxsIGhvcGVmdWxseSBnZXQgYSBjaGFu
Y2UNCnRvIHRha2UgYSBsb29rIGF0IGl0IHRvbW9ycm93Lg0KDQpDaGVlcnMsDQpDb25vci4NCg0K
DQo+IA0KDQo=
