Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1B7EF586E
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 14:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B2380B98;
	Sun, 15 Feb 2026 15:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hspNIWxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491A080FA1; Sun, 15 Feb 2026 15:26:00 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC989802C1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 15:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGayxLrej0uFWCNCZHI/uNT7e1pSNAO3QOb8r2WtbHYf8buLJ8jWMGZ/hePw/z04usgGKIMzR44BDcM5U1bDhN69+etdux6zHcJpqR6jIDUemYuRwLvmgsmipcFh1pS0tOPheIn0KNIcUshekxovIoFFRsuSixPFPHIq5AEG/mU90WSKKW5TwnlnkcFdl51s9N14BZYf140vUHoPZc2Am71dvqNnWA3NTcANSRTcAhTCZy7zkKf6GApmGTysovmkyb2Lg3fAcfQgjSVu47psbzY0FYZjmPH2a3NjXSblSru4GysiJrUXc30DcIowj7bFb1Yng/ylqDAQuHIRoNf2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYo18UdBPMq9VQ+EroVnn3I/Dz1onXq9shaYPsp7YC8=;
 b=Bh+v8nt24688mfdyj0cULdVichL4jPwmelwJKN6rs1BwpLmPT9YpumQpRv5NsIER6dOjGQa7EYkBlKfJJj3DrMV1mCax2QMLjRlCSnwVIi6NUWmf92aQcJS1Wzgk1ttdJ+OpU6OIgTff8PDZskpjrifXY3FYEEdurRxXaSgLhUyVzTZ0i2bGLSPJzb6/evxzw1HwRe+Jp/ArelN0A9PW9+9N2CbNAJLYn7jRmFtVV7J0ZV/JGTuVqcTc6vXqB1sDNfxGdmxFbT6GMrDixFBjWuh8H9Ck2bJunh7Y/2rxfTxlt0JbxTUb0Q0bxTlHO+5CuK1wzcoLdMyhXhA3lmp07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYo18UdBPMq9VQ+EroVnn3I/Dz1onXq9shaYPsp7YC8=;
 b=hspNIWxAdpaYcDcynYZ4GKtsKuuLx/yH6PfzhNa2nwcnuS++5tTFGBj5JQTjXyyM5Hsrkp4e7QEIElTI5+00VWL3S39EiYzRhfoOqFZA27CRv8CHqm2IICgL6qLZfWTwcq6aMtmanYYM7UbCvx6lXO/dqUgb19nOad5VoDnldbE=
Received: from CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 14:25:45 +0000
Received: from CY8PR12MB7416.namprd12.prod.outlook.com
 ([fe80::2ac:136d:2028:1c92]) by CY8PR12MB7416.namprd12.prod.outlook.com
 ([fe80::2ac:136d:2028:1c92%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 14:25:45 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "git (AMD-Xilinx)" <git@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>
Subject: RE: [PATCH] spi: cadence_qspi: reset OSPI controller
Thread-Topic: [PATCH] spi: cadence_qspi: reset OSPI controller
Thread-Index: AQHckI27UaWzGqdwik+y61Jb55BeirV7xHSAgAglkAA=
Date: Sun, 15 Feb 2026 14:25:45 +0000
Message-ID: <CY8PR12MB74168A279F72E5EBEAEF68B9EC6FA@CY8PR12MB7416.namprd12.prod.outlook.com>
References: <20260128193819.1177944-1-padmarao.begari@amd.com>
 <43354441-515a-4f29-9bd7-623f6c9da21f@amd.com>
In-Reply-To: <43354441-515a-4f29-9bd7-623f6c9da21f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-15T14:20:45.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7416:EE_|PH7PR12MB6883:EE_
x-ms-office365-filtering-correlation-id: 42f55fd1-cebe-425a-7fbf-08de6c9e1b68
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?WWhyV2FRUjNXOHNhTE5QRG0yZ3dwOTQrcVFuOHJUL011Wk5vRzlZOWR2OGpJ?=
 =?utf-8?B?cUNpU0FJQlplSEZwblZEU2xYRmtGNXRtdlJva2ZiQy91MDBoZ01rMkZrbTFR?=
 =?utf-8?B?UzUwcGM2VnNQRVA1VHJRRG9GKzhVanRYWllhTE5uQjYzNXdQRjNOYkZ6WkEx?=
 =?utf-8?B?WFhsZnY3dTlBOWtUbGxOclAvZWpnK3dGSEUwVEJ3c01sb2lOSXN4UldxK3hx?=
 =?utf-8?B?bE9xVnZxeHgxNnlPL2c3SmdyeWdnalFKbVhTV3lQcTNURTZnQ2lsTFYrS1NT?=
 =?utf-8?B?N3pRVHdvbkVZWjROTjN3WStYOFBhdmVDU0lPMitMazE3L0FlY0tCTG14TmJq?=
 =?utf-8?B?TjB2RHc4aW1LMlgvZ092TkpoeWZQNm9EQUphUVczakl0SzA2T095YWs4N3Fp?=
 =?utf-8?B?MWs2b0lwZ0lzdGIyTG1oUTRhbFNrOUlJUks3d1VxRlB1SU03TlZTYTkvRmpz?=
 =?utf-8?B?clRiZ0xOVVp0NFljL2l0eFNudDBYZHRNNXhJZEgwMlBUcjBPY1Nhc0ZOMDVL?=
 =?utf-8?B?ODJEVUNrVHBBRXFrQjFBWXRIclJGSDQxYVV3WjAySnV2eUVUWEtwR3pnRnZV?=
 =?utf-8?B?N25Id3QvYlE4amNYbjlyMWxDM0ZBemg0bTBMaDdCSUpSZzJ4NS9kZ0N1SnRF?=
 =?utf-8?B?WkdudzU1aDVOYVB0a3dUSTQ3eVIrNEg4OFR5ZTBROVBZUTB0cUtEMlU5akFk?=
 =?utf-8?B?QVNyRlVLN0wwSTBaM3MxOVU4Ynk1bi9ndmQrTFpaalBGOSs2UUVQb3k3RUEv?=
 =?utf-8?B?TGdqT1F4eXd5V3lCL0VaNzhLMHYyeHBFZk1OSVRLdWgxZThQSDRtZS83b0pZ?=
 =?utf-8?B?SmNQYlFia2NTN0haSkFKUXQ3ZngxeE9pYTJzTDZXdGVtaG1LejhJc0lBWkhG?=
 =?utf-8?B?NnlsMjBDTjVOa0hrWXNvY3BpdGFQaHp2L0tiMjFsd0lRU2U2TS9GaW5MN29I?=
 =?utf-8?B?VWc5YjFyVm5kckNSZkNpUnhpZXdDOXVkcWs1UVVIN3Q5bFdHOTBVMkZXV0cv?=
 =?utf-8?B?cE1zdkU0N3hsbFRaWGZRRTlmVkdwbThvbHl5VDBacEJRUjhLQUZoVmkycEUz?=
 =?utf-8?B?SURycXQvS3U1aXZ4TW44ZmNQeGQwSHBTZDUwUWxpQ2x1OThlcWcveDlhaXFz?=
 =?utf-8?B?Z1JLem5PL3B3UmpMQmc0WVFWTWg0dGFBQTM2OGp6RGFRaUdlSmtsbmxSMWZt?=
 =?utf-8?B?TzVoUmNXeWVwbkJqNTF1dURtdDROa0FKWHZnMGE5ZkJqN0tQYllsdlE2ZTRp?=
 =?utf-8?B?SG9vT3oxRlZPNllyMGtoaFpqZ244Skk4ajc0RVBjQjBMUVZrVlh0dmZZaDJW?=
 =?utf-8?B?ZzNjS3NFakxTbGdjOFNhR0pBNjVXc1Fxd01DNmpheEdrZU1tQ3JjVGxaNmk5?=
 =?utf-8?B?OFpZeFBVZ0xFTkRhNUlXUkFjNXBXYUxBYk5zdGdDUk1uckExeHVBQnlKRU4r?=
 =?utf-8?B?dzBHTUV1eUFNM2ZoTlRZb1Q1MWwwTXlLSFd1T1pYbURTOXRYMUYrUmcwL2xW?=
 =?utf-8?B?UnNMdXBMOXM0dkNqNU9sbFg5ODRrY2xNZVQ1aEsyQ2d0Ry9ZTXZ3TXVsT1J6?=
 =?utf-8?B?bysxTm9NcFJrSXFPa2I4RFA2STY0c3BuZ1lmU2hPdmNIZ2U5VWdtRjc1djRk?=
 =?utf-8?B?VHdIYnJPdVpLbFZncGhPaFhEcmR3TGtEbVkyTXdaeGttamVLMTZkMXY2b3pR?=
 =?utf-8?B?TjZNWTdrdFFEQnAxVk9BNlR0ZTBBMDhQWlZnMGRMbHFqZno5Ky82L0J5Y3N3?=
 =?utf-8?B?Zi92ZXNyK0tXVXBsSWF3Q3BrRkV0eStZbTh2S0NQUE5PWkNlQnl6TUxweHlW?=
 =?utf-8?B?ZTgvVUFPaDVkcDlrYldxcFlRN25WSjBLUWo5RXNBU1krOTBYM0VtYzdWTkFE?=
 =?utf-8?B?UWluU2ZBZmNLMEpDZmNuSkd3eVozQ2lXcGdQaEVzK3MxSXJpU3RiM2pIdXBw?=
 =?utf-8?B?SFc3Q2E3aTlLNmpRdEF2TjJXa01WbngzSmczSE1sNGFrNVJwSmtiSVluQUJI?=
 =?utf-8?B?d3hUUlhzTkVsQlNwZ1dlRzBhNFRFV1h5VzAxako2dzA0dy9NbnJVOUp0WTRI?=
 =?utf-8?B?Nll1TUpvcHBtSDAzM3hOWnl1ZkUrSXJaMTk2Nlo3ZUhjY2JaeFZnTjVKckZM?=
 =?utf-8?B?OGhwV05GQUEydmMrK3FrS0dkOWEvajhrQW1DUmJoTktXMUd4Q0owWTZneHJH?=
 =?utf-8?Q?U/4lupbcsmPfZwEBE5vyQYU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lRamhMYU8zMHBxaFpmTWN1ZHRoY2NSYmFZVS9xU0FBdGRrdlFELzJudStG?=
 =?utf-8?B?MHdyRTlRSlhCd2VwektBZHBpYVVEWkgvcjF4d0JLd0JYSkFqS0djOXRpbG9S?=
 =?utf-8?B?MEZOanRyMzM0cWxOREwzVzR0bnRVZTYyWEM4ZkpSWHFiKzhBODFZeklwSXR0?=
 =?utf-8?B?a1dMZ0hhWTk2eTZtRXhHR3hsNXowQWhZREVJT21PSnB2VUhuTVpEQ0R6cW1h?=
 =?utf-8?B?RDBWbUs1OGJlSld4WkRFMG1DYjBGanY2Wjl3bnBpaXM0bmxKb2xCUml5d0xn?=
 =?utf-8?B?ZFcyY3pCMG05ejdyNElIZVY0bW1kZVdvSW12K1RrNlJqMzUrM1pLUTc3Z1ZV?=
 =?utf-8?B?L1llOGdKTENVUC9mZitBOTNoNkJQMG5DdUhnNU1UOTFDdC92OW9uREQ1Q3Nm?=
 =?utf-8?B?MFVUQ21GZkJ2ZFFySk5yOUVoT0RTZnBza0R0TU8zWFNsZm5tMDBQeXFLbkVD?=
 =?utf-8?B?Nzcva1RzdHJLS3VBL25MYVQxNVVLeTEvUkgxbEdCTXVDOUdTVXBhSndNaExk?=
 =?utf-8?B?VVVLYTFCRjZOSW9LL3oxMUtoWWR5WnVLbWlFTEQ1dGtvQkdWZ2x0YXAvZ3FU?=
 =?utf-8?B?MGpzdlA1aERUVER5NlQ5T1lwTldVM1lhWXozRnh1VmxWczdwZWNzVzZET3kz?=
 =?utf-8?B?RjRmVGE5Q3A2aWJXNUNPeGYwSyt5OHE4eEhqa3hhbW51aHY5aGFuamdVR1Qz?=
 =?utf-8?B?MHBjS2o0N2JoMDl4eUtYVkJ2RlBidUtQeDZXbWV5blY3UFVSS1ZOVU10Yk9N?=
 =?utf-8?B?aEVjMkFFbzhNRXRBbXgzeE42NUxpMUtnd1g3Z1pYNld0aXIreW50dGVZWVlW?=
 =?utf-8?B?biswaHlUU0MyRWNiUjN1WTcreGxxOTNEbzc1TUNtREl6WUtGemk0cjNiTU5O?=
 =?utf-8?B?T1VEdHhySVZqYWhYS0c0NDZCNW5sSFRKckwvMHUwR05oNTVpTGxiTm5sbFlV?=
 =?utf-8?B?NmtwMkVrcWNmZVZpVXg4b1ZQVHpxR1JyTldWdjk5VFI1ZTJzcTc4bmtjSzJw?=
 =?utf-8?B?a2wrM0YrbHE5ayt4eHIwdER6VXNVdy82dWlSNVRxNHNSTlJBRG9VMy9XWm1R?=
 =?utf-8?B?TUdBSGFUN2hZYjd2Uy9HK0dqR2Fuc3F4ZmxqMFBNbE1qVFl4RzFxZWRmVlpP?=
 =?utf-8?B?Ukg1NUtJRklGa2FubHJyellRRzl1OXduNHVFUk5UR28xSU1JZXcrSDRzVE5C?=
 =?utf-8?B?TDdyc3pIS3JtQTIybkNOM1p4S1Mzck1nbldDbWl3SlhlTTNOc0J1Nk1jUWo1?=
 =?utf-8?B?cldQN0FuTkRya3FZaTE5aXVhbThSTFpBbDdkWlhTb0JyRzJVd0tRaWJNUWhU?=
 =?utf-8?B?S2ZiZnA2YWdxK1FzVDVVNitIVjRETEU2WjB2SHJ6UEpXbENjd29yandvN1pC?=
 =?utf-8?B?Q0I2bkJmdjIxcDFtVTJVUHZvUTZvdHg4TUQ5Mis3bit2ZWtZS0xGb09Da2hW?=
 =?utf-8?B?MElMQXFtYm1mdEJHdWpLOURsdFRkNGQrdk9lMmYwcU9IZGFEcDRGLzUzYURj?=
 =?utf-8?B?R2dqaEIrSE5EMjZiR2NTMmdPMUNTRXFWWkFJUTRUelNPYVJWUzNCeW5MeVFh?=
 =?utf-8?B?NytkeXN4aU9ULzJ5VkVtSUM1cGZ5NDZWSTRjRzNhaHJoeS9ZL3pwK3BUclFD?=
 =?utf-8?B?M3R0cHF3YzN5MjQ3WGVURlo0ZzBHOHhmVDdSaldGbXI2U0h1VVExS1ZpbE85?=
 =?utf-8?B?SzZ2NGsvak16d3VLN1VWK2FxeVBwMEltTGhOUkJHbDVvOGR6Q1hidDl6anJY?=
 =?utf-8?B?Qk1pQm1HZVVwMWdXVE9xTHA3anlaZi9XSnBHMVNzWld0UGlqZ2V6UnRMOHlY?=
 =?utf-8?B?L3FheWVaelpkQlVJazJ5YjlIUWx1aTNQM0pmZCtBNjc3MHZPQVdyTG9SNStk?=
 =?utf-8?B?MlZ2cll2eU1ib0FTenUzQkZ3UjVrcE5GdVplM0xKaGl1em95cVl4dTFBWnlP?=
 =?utf-8?B?T0NldWVSdm9GTFl5WTdPUStMQ1JicWNsVWdxYUJQN1FrMWw2d1AyODhSN3NM?=
 =?utf-8?B?WmozUGNtZGdpQnNWR3UvNnpvYjZRVE1DVzlxeHdYQTd4OW14RVRycXI2RERO?=
 =?utf-8?B?QjJ3bTBTTkplWnp3ekJmQ2pLN1lwUURnNXBQcjhNclBoNllnbk9naEc3Rk9T?=
 =?utf-8?B?QitlMFAxczJRcm9USDdxTjh4bnFwMFdLczdwTTNyYldUcXJIclIvVmVsSlEv?=
 =?utf-8?B?aVh2RFNOL1BQdGNkNzk1UVYwVkVoUjAvbi9WNUlUdjlkVlhXVUQ5MzFzS25a?=
 =?utf-8?B?OWpROEhlUWZTR21xY1dFME5qa1Y3RWhReC9xVDFRWEovUG1JOURMZm54Umk3?=
 =?utf-8?Q?hJ4+59LxarJKMtmoZt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f55fd1-cebe-425a-7fbf-08de6c9e1b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2026 14:25:45.3522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPisrBtgdoksrPU2l+SH/ffKn1kXnvJINQoeFjNXD6YeLp90sQywohcynzYURyRG3ki+HLtc8kGFxd0a2LP87w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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

W1B1YmxpY10NCg0KSGkgTWljaGFsLA0KDQo+IEZyb206IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5z
aW1la0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxMCwgMjAyNiAzOjIxIFBN
DQo+IFRvOiBCZWdhcmksIFBhZG1hcmFvIDxQYWRtYXJhby5CZWdhcmlAYW1kLmNvbT47IHUtYm9v
dEBsaXN0cy5kZW54LmRlDQo+IENjOiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IGph
Z2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNwaTogY2Fk
ZW5jZV9xc3BpOiByZXNldCBPU1BJIGNvbnRyb2xsZXINCj4NCj4NCj4NCj4gT24gMS8yOC8yNiAy
MDozOCwgUGFkbWFyYW8gQmVnYXJpIHdyb3RlOg0KPiA+IER1cmluZyBwcm9iZSwgdG9nZ2xlIHRo
ZSBPU1BJIGNvbnRyb2xsZXIgcmVzZXQgaWYNCj4gPiBDT05GSUdfWllOUU1QX0ZJUk1XQVJFIGlz
IGVuYWJsZWQgdG8gZ3VhcmFudGVlIHRoZSBibG9jayBzdGFydHMgZnJvbSBhDQo+ID4gY2xlYW4g
c3RhdGUuIEFkZCB0aGUgc21hbGwgZGVsYXkgYW5kIGVycm9yIGhhbmRsaW5nIGFyb3VuZCByZXNl
dA0KPiA+IGFzc2VydC9kZWFzc2VydC4gVGhpcyBlbnN1cmVzIHRoZSBPU1BJIGNvbnRyb2xsZXIg
aXMgcmVsaWFibHkgcmVzZXQNCj4gPiBkdXJpbmcgcHJvYmUgb24gQU1EIEZQR0EgcGxhdGZvcm1z
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGFkbWFyYW8gQmVnYXJpIDxwYWRtYXJhby5iZWdh
cmlAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc3BpL2NhZGVuY2VfcXNwaS5jIHwg
MTkgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9jYWRlbmNlX3FzcGkuYyBi
L2RyaXZlcnMvc3BpL2NhZGVuY2VfcXNwaS5jDQo+ID4gaW5kZXggZDE0MDRlMTM4MTAuLmEyOWFj
Zjc1YWJkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL2NhZGVuY2VfcXNwaS5jDQo+ID4g
KysrIGIvZHJpdmVycy9zcGkvY2FkZW5jZV9xc3BpLmMNCj4gPiBAQCAtMTMsNiArMTMsNyBAQA0K
PiA+ICAgI2luY2x1ZGUgPHNwaS5oPg0KPiA+ICAgI2luY2x1ZGUgPHNwaS1tZW0uaD4NCj4gPiAg
ICNpbmNsdWRlIDxkbS9kZXZpY2VfY29tcGF0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxh
eS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4
L2Vycm5vLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiBAQCAtMjU3LDYgKzI1
OCwyNCBAQCBzdGF0aWMgaW50IGNhZGVuY2Vfc3BpX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpidXMp
DQo+ID4gICAgIGlmIChwcml2LT5yZXNldHMpDQo+ID4gICAgICAgICAgICAgcmVzZXRfZGVhc3Nl
cnRfYnVsayhwcml2LT5yZXNldHMpOw0KPiA+DQo+ID4gKyAgIGlmIChJU19FTkFCTEVEKENPTkZJ
R19aWU5RTVBfRklSTVdBUkUpICYmIHByaXYtPnJlc2V0cykgew0KPiA+ICsgICAgICAgICAgIC8q
IEFzc2VydCBvc3BpIGNvbnRyb2xsZXIgKi8NCj4gPiArICAgICAgICAgICByZXQgPSByZXNldF9h
c3NlcnQocHJpdi0+cmVzZXRzLT5yZXNldHMpOw0KPiA+ICsgICAgICAgICAgIGlmIChyZXQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYnVzLCAiRmFpbGVkIHRvIGFzc2VydCBP
U1BJIHJlc2V0OiAlZFxuIiwgcmV0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4gKyAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICB1ZGVsYXkoMTAp
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAvKiBEZWFzc2VydCBvc3BpIGNvbnRyb2xsZXIgKi8N
Cj4gPiArICAgICAgICAgICByZXQgPSByZXNldF9kZWFzc2VydChwcml2LT5yZXNldHMtPnJlc2V0
cyk7DQo+ID4gKyAgICAgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ZGV2X2VycihidXMsICJGYWlsZWQgdG8gZGVhc3NlcnQgT1NQSSByZXNldDogJWRcbiIsIHJldCk7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgIH0N
Cj4gPiArICAgfQ0KPiA+ICsNCj4gPiAgICAgaWYgKCFwcml2LT5xc3BpX2lzX2luaXQpIHsNCj4g
PiAgICAgICAgICAgICBjYWRlbmNlX3FzcGlfYXBiX2NvbnRyb2xsZXJfaW5pdChwcml2KTsNCj4g
PiAgICAgICAgICAgICBwcml2LT5xc3BpX2lzX2luaXQgPSAxOw0KPg0KPg0KPiBJc24ndCB0aGlz
IGNvdmVyIGJ5IHRoaXMgY29kZSBhbHJlYWR5Pw0KPiAgICAgICAgICBwcml2LT5yZXNldHMgPSBk
ZXZtX3Jlc2V0X2J1bGtfZ2V0X29wdGlvbmFsKGJ1cyk7DQo+ICAgICAgICAgIGlmIChwcml2LT5y
ZXNldHMpDQo+ICAgICAgICAgICAgICAgICAgcmVzZXRfZGVhc3NlcnRfYnVsayhwcml2LT5yZXNl
dHMpOw0KPg0KSXQncyBub3QgY292ZXJlZCBhc3NlcnQNCg0KPiBJZiB5b3UgbmVlZCB0byBjYWxs
IGFzc2VydCwgZGVsYXkgYW5kIGRlYXNzZXJ0IHRoYW4geW91IHNob3VsZCBleHRlbmQgZXhpc3Rp
bmcgY29kZS4NClllcywgd2lsbCB1cGRhdGUgaW4gdjINCg0KLSAgICAgICBpZiAocHJpdi0+cmVz
ZXRzKQ0KLSAgICAgICAgICAgICAgIHJlc2V0X2RlYXNzZXJ0X2J1bGsocHJpdi0+cmVzZXRzKTsN
CisgICAgICAgaWYgKHByaXYtPnJlc2V0cykgew0KKyAgICAgICAgICAgICAgIHJldCA9IHJlc2V0
X2Fzc2VydF9idWxrKHByaXYtPnJlc2V0cyk7DQorICAgICAgICAgICAgICAgaWYgKHJldCkgew0K
KyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihidXMsICJGYWlsZWQgdG8gYXNzZXJ0IE9T
UEkgcmVzZXQ6ICVkXG4iLCByZXQpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCisgICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAgICAgdWRlbGF5KDEwKTsNCisN
CisgICAgICAgICAgICAgICAvKiBEZWFzc2VydCBhbGwgT1NQSSByZXNldCBsaW5lcyAqLw0KKyAg
ICAgICAgICAgICAgIHJldCA9IHJlc2V0X2RlYXNzZXJ0X2J1bGsocHJpdi0+cmVzZXRzKTsNCisg
ICAgICAgICAgICAgICBpZiAocmV0KSB7DQorICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJy
KGJ1cywgIkZhaWxlZCB0byBkZWFzc2VydCBPU1BJIHJlc2V0OiAlZFxuIiwgcmV0KTsNCisgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorICAgICAgICAgICAgICAgfQ0KKyAgICAg
ICB9DQoNClJlZ2FyZHMNClBhZG1hcmFvDQoNCj4NCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==
