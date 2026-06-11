Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0592DCD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 16:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73ECF83FF5;
	Thu, 11 Jun 2026 18:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="l0wWsUMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0825583FEC; Thu, 11 Jun 2026 18:21:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF76C83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNde88WUCgMVKgzPmD6/q43jCiuka+R3TR+kuGm8e731qxbbGHr73KWPuNLPq1tC5VnVIyYhoH9+I0yblfDfCgi0KWKlNa8JJ+toKQdiUnLHS1hfFMdjpv2fEvsA6GqBNUOfnPu+4U7AgKD3naqTIObx9iWanRKaZBmX4BwySfwNmRAZ9a76VBw/FK0Uv/c1AK+CNqborAFcdRRuN5TPuMibPcrxUqrdIK1ldGhM7cNl+C/7W+JUdJK2itHD0h9Y9NoyhJXl2jTU5UlXeo+CC7RSCg+hMgb9ZSzHiGLhkTVodQphN/lkFva7H39Mu5mrJS40rzOZWscW9bZCugNLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtzyOv33tlOriZFRFwGaAChIJYyzR2+Y5PLiz2RFfNY=;
 b=H9tz0J1FOjc3idKcauDF2PvW3hcdc3PV4qEF8K0FCzOGkMiUFpr5jgf2VHWKCVKXPf1Pvq5O9raoP+5nhcwyhEZc80Py76alMVuvAf1Q45uZnWHwIW97ZFkORpjMbUpVFngnGHjICAFuHT1GVDikXp6GFf5VqTu9pkRCGwz9tS3O74aRGGeU9Qx1s6QFSLBSN0F1GVkZFuzkkvW+/bxwJaRAZn40QCGNOBhyzFOvlQBfDtxLTeSYIqLP3bEdhoCQ08RmjFC9WuvzzOyX4WrzoFSg9P4GOLA0o927uvWCvV5itx8AezAJN+jrQhrVYm3mFKikm3uVd5nKURBGa+9Dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtzyOv33tlOriZFRFwGaAChIJYyzR2+Y5PLiz2RFfNY=;
 b=l0wWsUMvoDQrl+93PDaWS8qbrOrY75aLPnokpUhus8N585B4fpvmvmJHm9LGGanocb7VTqb6UTGmEqXTx/43/g2PVoSZi6m65Rj9a1zZfmhr8j8mhmo13rPLXVDGyZ1WZrMr1+/kpewstU14p6YJLtTX2CDQ4i8XOnllKk8qU+iea1U9XOja5cWmh5IZoiVYSISEh8tF/0wpY7mDLg6EJN1gBU36isouZicYYj7TeAtDSrbU7u2E/TIjCXrlUdISxS70tp70HXGFJCnToGRJUYemBfPZXZlfub5XIRwwwU/AStYZVGbrpy4u/0T9Cto1OPresAkW2Bdln5jeO1awyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:209::10)
 by DU0PR10MB6385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 16:20:58 +0000
Received: from PAXPR10MB5012.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9db0:5df3:4c9a:63a2]) by PAXPR10MB5012.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9db0:5df3:4c9a:63a2%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 16:20:58 +0000
Message-ID: <500e420f-ccad-4b61-b7f9-e4cb3ed8ac86@siemens.com>
Date: Thu, 11 Jun 2026 18:20:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To PAXPR10MB5012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:209::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5012:EE_|DU0PR10MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a42edd-a916-43fd-005a-08dec7d56b72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|4143699003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: rzevJCSrFuXnstZuVyydpGN2fvBpM1YTSqWIIwUjqFnJlVKObcWhg0KBah9RmcGdAppPPg2jN7lpiex0b58d3aOeunN0QpS4NKWvwYsdmPawsHQOGmxRVnDZ4pPd8bi/+WZ65gBDS8IwczmEVdcG1T/FNyFdMTRmzcfCDJYKQpFRfF6UYm0T6eM9dL0by8X1qzs3MKAt7cKaWGyz0fVHePooPUVI4mYzlr8w47RZTxQSfLjwxajLwrgJyY6MIpJE4D4molU4k+ZBpRH8dY+70V4ZxxKAwAjFTCqa1xwIjmuP7ojtuhADlxhfLfNwXlUIOY4PsgQDWK2GvqzH+giGsnDgcsubNrsqmKomjJ+LVVSrKUzG+MFDlL3QdoN2LD4YR7OT0JORSqvUDAsfSceyOfAknBa1wg7L/77LWjphLE5WgU54Yej8B7ZYFxyZrfqRQ8NIe34Ee0PyIMsxeyyV7GXVyn4Ho7JcUQ8EFaN78T+DPdu/IA1XjbfxgB+htw3MxBT6iykVilTl1kKYGpBOl7fY/NsxWDselCBJygUcSLEoA9/XuPH+TjGilBgSAgxFs1c7Gk9EqrDSQo7CKbYKBkId/UXTS5J7j5L8EEwhOE0gTDCmMJsOaio2Cfctz2CREkUP7W0RwI4VfOPaleWNmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB5012.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UERFMVh4c21QVHk2dS80M1VKU3J6bVhOaHp1bUFTU2d0by93SUR2ZTJuM3dU?=
 =?utf-8?B?bC9ZY3BDejhFRVBLR2R1QU8xWXg5WWpzWmtORE9sNTNaQmVPMjgxL0lxRmtI?=
 =?utf-8?B?MjRDWVp6M0JmbCs4amVUMjk5RlR0WTBTS25IaXFONjhBUHRCY2puZng5VHBX?=
 =?utf-8?B?b01FZk9DTTNiUXEvbGJPNW9tclpQNE51UUR6OCt3VW4yeUlaWUJnZGZObGhh?=
 =?utf-8?B?VmExNlkvcmlpeUpqU0o2aTlqYU9pWXNjWlhHQzUyTjZraWNONlBZbmJxQjRC?=
 =?utf-8?B?SWIrV25kb01KNU9NbHp6QTljVG9IQ3VQR1lwZ3p2NUhXZ0RWNG9QY29wekY2?=
 =?utf-8?B?MUpkT3FpU2F1Q1V5MWdDVVZqZ0JJRUsrb2NZanBIR0JNWkRKUi9rSjV5YkJZ?=
 =?utf-8?B?RllGWVpDU2QvZ2d3UHVvYWtXb05FZkRMeW5DVjNnNjlaS0ZORUJuR0JxY3VB?=
 =?utf-8?B?UlYzWUpnMHgybTRCVjFlTWh4ZTdlS3MxeUpHbHZDMFVMemJlR21oTUt3TXla?=
 =?utf-8?B?dlZnZHhIbkdrSW5RYmhONlpsbDN6VzZKUDhxSnNsVzZQdHVtS3psTkRMazlp?=
 =?utf-8?B?c1dReUp6Zk9wRWpyd3NjZ1VhSDhBVms1ZHRPT3daWERqK09EYjJYV1lrOGhX?=
 =?utf-8?B?bWVNZjV6anYxc1dQVU5nZFIrb0dOQTJHZUJkcFhlSWF6YnZFQW5oYlJJd0FV?=
 =?utf-8?B?eGFqQnFDWGd1dml1ZUJsOVUzczFmS2pxeHo4Q3RyOWlqN0NMemRtMjJtdTFK?=
 =?utf-8?B?K2NuTjZzWkpEdG1ldC9MSDBmeGQ0Q2tQcDBqcHZVd1dCRWh1eFkrbDZEMFk0?=
 =?utf-8?B?VDJpQzJQMGxrVXljdjRpUmVub1ZocjlvWHVYQkJ5Y1lNU1hXVWNNbi9BMmJu?=
 =?utf-8?B?d29LWkFVblhLVDlPKy9BY1VJNDFCQmpIQXl3WVAxM0I5V2FhVmlyR2lleDIr?=
 =?utf-8?B?ejUxbmtMMHZ4dndTcXh0NFp5Wkw0WE9WUENSUnoybEJRc2Q5dnExL1hmZ2dn?=
 =?utf-8?B?dUN0WHJrVjNScmNuSERNMlNiZ0xOSjl5ZEs1TmpDNDZVS0UyWGF6aGxYem13?=
 =?utf-8?B?d2RqZFBBV0JNNU9BNk1EZk5MekdhS01ibFVNZGtmQjI5TngxdUJEOFBkZk9Q?=
 =?utf-8?B?MWJxOEVXa2taVXlBQUtqdC9PanRicHpTb3RkWjZTblEwNmVlWmpZWnhFcFlQ?=
 =?utf-8?B?Q0YzS3VtOEZrS1E4VDkybGxvL29nUzJ1TUttN0lXVVA0TjRhdkdWdERVK25X?=
 =?utf-8?B?ZkRxYjdIekZpT0FrQTJINUs2K2JJYXlsQ2xQelg3QXdBREZwMk4xTU95NkIr?=
 =?utf-8?B?TEJpV3RUWkp3TVhURjBCVmNPN0RhZjNUZVhoTVNmK3licURDazltd21rYmpN?=
 =?utf-8?B?eCs1eUFlSk1WRXFlY1NNM2hjbDRhU0xtd201SGo4OVFQQ0V5aFJ5bnYrNmVS?=
 =?utf-8?B?eUJCMjRuTmVEQXJyRXZqKzdFdE5sUHl5N0tHYmlWTlN3QnJPK3F1UVJ0QWNR?=
 =?utf-8?B?THJqNFJMOEpsdjZrTitTY2J1WEg0Nm5DU2F4NkdjS3ZnS0FVckhmOE5uek1l?=
 =?utf-8?B?M3NLZTB5VXB6NmxxUjFUK3hNaGE4Z1EvTSs3VzZnL3lxQTZTU1ZWMktRelhs?=
 =?utf-8?B?bE40VFJTSmtZRTByV3pWbVpJSktUTTNCaGhSUm9OWVFGUkpBZnFFME9aci9H?=
 =?utf-8?B?UXhISlk3b05CeCtvZHU3Z0VWSTJBZWh5L1NWMmR3eTk5WHJPWWRzZkxGUHdE?=
 =?utf-8?B?SEFPWTFlUDdUUFhRNnJvK1BVM0FPR05VNjdVcHNDV0YzQW1saC9yblJZZjlO?=
 =?utf-8?B?L0FxMFRTN2F3cWMrVkU0UzlwS09vUXAyanBWNGdjWjNwOWdaY2ptWTVGaEYw?=
 =?utf-8?B?NHprd0NmdXZSeEQ5TGovUkd6ZCs4NjFkRmd3NVZTOEp6VGVlRG4wbEJKUUIy?=
 =?utf-8?B?V3ROTjJHcWttMjQra05lc2FXMmdLRkJ3OCtiTEtUK2NSOVA5RUhVK0kzY2s3?=
 =?utf-8?B?b0V1VjZvL1VodVVQYmY5aGVMZW1NWE5xTFBCWjZ4SWpVRDh2QXFIWnBjYStj?=
 =?utf-8?B?OTVaYXVZdHBITnFzSHo4S2REYmRiekdFSnRlZXJUUUIrcU9HMmVXRDNDOW16?=
 =?utf-8?B?RHpqKzdTQ3FXTW5BMTBxbytFVHBBb0JzQjZicU9qb1JESGFjczdPM1p2WmJq?=
 =?utf-8?B?Q3dQa0JiNHEvSm9KK1lzVUlWWFN0ZjUweHUxdzhmd2J5YUM2MXBackRVWHhF?=
 =?utf-8?B?aUxiWlF3aU5qZjFKWFloQUhHc08rbmU3eE5oQzBjOE43UC9qb1NNMGxFNVF6?=
 =?utf-8?B?VlhoZkdnaExZeGZmanhnTWI1SVRhbmJTVmZqT2JNZitSQXROcVJyYm92SktQ?=
 =?utf-8?Q?2XY6kqvnnMDkTtuA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a42edd-a916-43fd-005a-08dec7d56b72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5012.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:20:58.0168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5bXwV820BiXo1Eb+fl6kicJWJ1O9+3jy449UDmPLAE5Q1YcoLMFUjRS9PqTOfh5+OZ5uunEF3UJUQAp9vdm3mUnHx/ZgiZWQWWh1oElfb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6385
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

On 6/11/26 11:57, Ilias Apalodimas wrote:
> The CI [0] fails with this attached. You can run it in github by
> opening a PR before v3. Also can you update the description and add
> the use case you mention in the cover letter?

Done. The hardware tests are still pending but I've fixed the qemu 
failures: https://github.com/u-boot/u-boot/pull/985

Is it advisable to file a pr in general before submitting patches?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
