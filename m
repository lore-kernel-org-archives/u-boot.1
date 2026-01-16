Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44076D4899D
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 13:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6951682BF2;
	Fri, 16 Jan 2026 14:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K9UovMFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF75830E4; Fri, 16 Jan 2026 11:50:12 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BDF80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP7e4XDDq3WOBnWdKE2N1AXaOO9E13wHGbbMfMQpPCtu2+mHCFFS5m+/5jcZqsBAxkJa8iD065W/RbZJIOTuwhL+WyUBCiziXV7v+54b7x93Q900IbL2OdOvObgOx5ebA5bI3I3QpATv1rJ+OKNqwR7m8pMYEWa4OLdGAo7ee4i9LZ+GKdJ57LbvyMvnDeaBHk7yus1yAU18eBgbbqmrm9IXofbbuAbMktAKxmQvaoazYqJi3HfT9RBlAx4xvvGnEB1KoGr/tB7H3Wq1oLwvX7v5APO+DX325uKb4jR46HSpEQVsywr2WH8iuLqS29ddyQWt+v1ZmhGesnaQf/Mbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H58cg6wBOmZ385TCw853tCQXR1/oIjvZj0tfe0gnQkg=;
 b=oOK+7RxO21Ff9SpdznQxKJGt7BvSCp6z7MD7auFDFKzfJWOHeRAo43Zz47UqogitjOk688CVsy2qqQDLh7iVI7X6g9wN1PBkR71rIfL+DGsG7y/5eOwbamb77O+ZfIZ4UH781IuKpec6O1N5pycIl/+a6H+O1mD7RNQYnV2U/xA7GvZzDPS7rlhpum9TcCF1Tb8ADZERWXoT8GVulsVLCj0PgcxcZWE7enZdr7AcywfcjIC2g1uPV4AlyZkgmTApRmp5xVmgc/h0EkueYOI18TSoAaYqSRV4EqLqYEUWimIzktGNdYDJsQZCLrLs/3pB/pFf7pf1FtHP8icJ7LeXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H58cg6wBOmZ385TCw853tCQXR1/oIjvZj0tfe0gnQkg=;
 b=K9UovMFnq157IWuDI2/bzmGD2RULuOPucAEZKT9QWLkkQoLyStT3qL4oYf6UiMzWDJwht0U05FaOlFHMQ5m8ZQXp+9oWlJazDjYYSVX0+BWr9eX/9KqNzxeTzp3k1K/KuBbNSFYbV7PW6aCt+OMEPD/g7yPg2F3feF+i2jQ7F0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 16 Jan
 2026 10:50:06 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 10:50:06 +0000
Message-ID: <3b1184ab-f995-4b86-a2f0-65a5163be9c1@cherry.de>
Date: Fri, 16 Jan 2026 11:49:45 +0100
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v4 3/3] rockchip: spl: Add support for booting from UFS
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-3-e8e67649f3f8@gmail.com>
 <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
 <CABjd4Yzf-y05Qp3+5LVFrHeN_MMZu9TOXozrkjnXVU2MJU_WoQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABjd4Yzf-y05Qp3+5LVFrHeN_MMZu9TOXozrkjnXVU2MJU_WoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: eb113b6b-ec38-4709-8725-08de54ed0296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmgyV0l5ZGhQR1ZvODI5eDJ1aU1TN1pPLytQV3B0VkEvKzhUbC9IRG9jbldr?=
 =?utf-8?B?YjBhcUMvajBRR1RhWVdISm9oQVZER29YbE1XKzArQkZSUytRTDZNVFhIeUVV?=
 =?utf-8?B?WkloSmlGblAwYlQxZFMvb3FTRjNLcExoZjZsTW90Mml3VndRaWM5QkhTZVow?=
 =?utf-8?B?ZEQ4ZDd5QlBIVGtaUjlHN3E5WmtlcmFNYnVzTCtIR09ucVZGS1A0b1REOHgr?=
 =?utf-8?B?elJub1BpU1ExVkFDREZyZjlhRnZFcmEwWlo0NWQ5Q1JPVHhVMElGVVdNa3JQ?=
 =?utf-8?B?YjFra28zdk83K0tOd2YzYmRsaFFrdStON2plNCtMQm1McDRaR0J0Zmp6K1dt?=
 =?utf-8?B?M1J0S2IxMzNtMDgzdHhJOXo2aFZzSFRadTBNczNNNGcwMEs5REFaOWMrbElj?=
 =?utf-8?B?WDVhemxnbnBibEFYVlp6WE1CenRldEFQMER4YnJEZEhkb1ZRZEJsSGdOanRi?=
 =?utf-8?B?ZjRwZ3BxNXczRnBXOGhQbkFxempEUFR5czhXS3c0UHo3VUQxK2d4SnlncEJK?=
 =?utf-8?B?Z0dCampvdjBVWHVFcnVBUHRIMDd4a3BlRmNFek8zV3ZxVXp5cU81RCsxQUts?=
 =?utf-8?B?RDArWTU4bWlGdysyYVBCbXN0cmgwWkZ0QlE3NjArc0JWMXNmSm16SDJCRDB3?=
 =?utf-8?B?K0xabHJ3WEVZR0E5WGhKbjJLcmhiN2V5SnBnaWNoMkgvZ0d4ODUzTmpLRVB4?=
 =?utf-8?B?b3IxTVJkS0VWZk9rOHRYSytmSE91ZnVBdXRHYk90WU9ZeHEwa1AyM3pCeVBu?=
 =?utf-8?B?NlZmazFwVFRlY2tNdUY5TTNJTlpyWGdubDU2N2RsWE9WOTdwb3JxRFpYMVhM?=
 =?utf-8?B?MFcyM0QxaG5IS2ptY01UM0NTOWxtTHMrYmdVWlZhL3BZS0NuZWFTdmJuMUg1?=
 =?utf-8?B?YVAzeHBGTmdtdDhaWUlKTldvaytBOEhUczZPemZSVEZuZGpOR1JNVGgzWC93?=
 =?utf-8?B?cnBWc2pEaktLSDkrRWdyUTkrVVFsMmdQWHNVQ1ZlRktiODZHVWIvaUtqSDFw?=
 =?utf-8?B?aGlkaEc2QXFqblo3elhaN3lHaVFwOEpZcGs4SkpuemtFYmcxTTZxTUxtc3pC?=
 =?utf-8?B?YXFWOTIxb1REaWxlUjBnYmtwQWNUa0xWWU9uS2dIMklHbGlObWhIemJuRWpq?=
 =?utf-8?B?TkhYZ1BQRk9yVE1XR1VzZldQTk9jNHV3ZkVTem9YbjZrZ2QyU3NSUkZLMFZj?=
 =?utf-8?B?eVRNbENmSVhXdGRUNDBnR2Jac0dBbThTNE5HNHJHTExGMm1IY0VxR01ZamIv?=
 =?utf-8?B?blBzNWlBR2lwMm12Q3AvK1ZPM0JEVm4waENteWlNMklDOWZQYUlSSC84dHFD?=
 =?utf-8?B?UG1maE1VVFFjRG5wcFFkY1U0djJhd1IzalVwcWhUY1hlMTgxUFMvOWppd3Er?=
 =?utf-8?B?Q2I3TE5sQTVua3k2THo1VVM3cThFVjRxMFdnMzREMkVBR0lneEdsSks5TkVW?=
 =?utf-8?B?OFpIRklVZzRFSjNNOFE3S1RVWHpjU2FyTnpRdkUxSk9SZzN6bjgrZ1lNSFZT?=
 =?utf-8?B?TG50M3FrTS9kY1FuSzZJanlKcDg2QVZ4OVBucEQ1Y2ZSd2pQai9venBBWjk0?=
 =?utf-8?B?WmovQS9UMGJEUjlZS20xb3BDcC92bUY0ODlRaGg4MWY4QWZOYSs2M0EweXpr?=
 =?utf-8?B?NjNISVpxRlFvQ1FPeC9kY0tIbmlrS3pHbDdZQ28wMTd6Vzl5ditubytDcEZj?=
 =?utf-8?B?TkMyR0JDc2RxSEkrYmZFRnU2VWp6Um00RWtnVFphaExwaVd0TFhCbUkwb0tY?=
 =?utf-8?B?WDBZaEV1TGprS1FJaFQ5ZmVESDY4UHNUNlJUYm5UWTB4TGJ3eXBoekZQamkv?=
 =?utf-8?B?ZGx5M1ZBVkZJa0lhVVZGUlhFdEFiVnhPWE9OUEE5MFpaU21DVjFldGV4S1R6?=
 =?utf-8?B?V2d5QllyTnhMV0NsNnpiZ01DdG5EMG0rTWl6cjJZemJZeGYrVjJmMVRyVnlT?=
 =?utf-8?B?ZWNsMS91dVZYSlNBTklja3l6TC9WMG5pMUtPNUFNWWR5VW5yRUFpbVd1Rk9Y?=
 =?utf-8?B?L25SK2dLQ3NpYnJyY1dWT3E5THRUUUcxTm9qdDllQk9NUjkxNzhxTGljZ2Zk?=
 =?utf-8?Q?xGks8G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFnYm9aWndaRVU5anAvYldjaXdkRVl6UzU5TU04d0RFZElRSGpMU0FMUkxZ?=
 =?utf-8?B?ZWxuWXRIVDFhK1pjUnlrTTJHd3pmNGlYclNqZTd5eWJUbDhUOTRTN3Y1eDBs?=
 =?utf-8?B?dnVVWVVCK3ArTHlBM0YycDRUTUhkZC8yOWw2bzZ5L2hJQ1JHREdXSHdGdEFQ?=
 =?utf-8?B?eGJmT2JBRnVDZTFGRXE1c2VKZDYyYTk4MFNCRGp0alFzb1oxTHZCWjY4TkFr?=
 =?utf-8?B?UXpLK3VvdGgxTHFjTVR0SENxNjhlQkYrbk5hQmkrU0d3Mk9nZlhQR3ZzUjZV?=
 =?utf-8?B?alJRckhUNXB4WVkwOWVsYWFxbG5Jb00zRFhEK2gvTW9GY1JpMTB1dCtCSG8v?=
 =?utf-8?B?cjQyYzk5WnZpcmFaOVdFcGx5cTJHRWlZQmJJc29VL3NQV2w5V0NVVVhFR05Y?=
 =?utf-8?B?TGJGSVRnS01xSTk2Qld5M1JUZjZoS0hHWFI4K0tUMXV1cmZjUUZKalVsUkJs?=
 =?utf-8?B?RG4vSysvdnlvNkoxUEtQS1hGclBKR3laN0IyQmlHSHBTeFN5SzlMTFlqanBo?=
 =?utf-8?B?UzZVdmxQTWxKR0FHWU9MTXRmdm5tL0pnN0cxUDJqZGJIREpGZSs3d3cyNHds?=
 =?utf-8?B?SUN0K3R6bmNheEd6dkpXKzEwNWEyZDR3aXM5d0pmSXZHS3psR0JvUmQ4ZkRw?=
 =?utf-8?B?NG1NSnVqK21yY05EaEdzRkJMMnU4a1dSOG1aOWpKUDZxY1orQys1OTZnNk1F?=
 =?utf-8?B?UlBhL1psTmtIeU5McUhnVDBNRnRBanRkb3RvSFZtTUx5OGFmL3dsd3VMYTlN?=
 =?utf-8?B?Nmd4djV2QlA3ekU5Wi85RE5qc3VPbkJLWXN5VDgrNllxMGVQM3JrOUpnUVkv?=
 =?utf-8?B?ZmEvVGkxOGFlVVMxejV2bVJEYnl4eC8zNy9QSGxvM3JSTmVvTS90S3Nwb0o1?=
 =?utf-8?B?ZUxZMVJUUkFyUjZOZENONWtGUndVcUUxdDZHbnh2SkRIQUV3K0Z5Y1NWV2F6?=
 =?utf-8?B?NkdJNGFvRzJCVmNHMHdTRzZxcktMY0V4VW5TM0s2VEszR3htVzBnR3EvMmhD?=
 =?utf-8?B?VUlOaGt5Z0dmSm9uM2RsWEI0b3VUbEtQSXphSkM5KzZXaFdFQ3d3UGRlbUxF?=
 =?utf-8?B?N1A3QlZTQzE0ZXk0TjMzai95VmhDWUNtd254Um1kNXVQMHowNGVEdXhTbTNM?=
 =?utf-8?B?RGFqWnpZYmEyU0hLaUkxUHppR2kvUEYxeFJib1FjSWRwSGNXcWNEbTJlVjda?=
 =?utf-8?B?cDFoVkhXSEZaUGU1Slc1TTVWZTl4RkR1c1hDKzdhNWc0Vy9tUk5maFlEaGFw?=
 =?utf-8?B?MXZUKzUrRG41N29wMVZDY0JiUHBnVnI0NmdSdEw2dkFwS1lReUhRTDZXU1N5?=
 =?utf-8?B?ODYxbUNvdjdjUVF0blhsNzFadmJGdGdJeHIyWkpja0VUWVZyejluQVNEQUVI?=
 =?utf-8?B?MlJHUFlGRTdWaUc5dm5UOHJ0cHgxR2VPOUloSGRXL2ZRU0NXR280aHZrVWdL?=
 =?utf-8?B?cGhnKzJUd000RUV2KzIxSURWWDFiSnZUNkR1c1JrNmhYOTNHSGJ2UHRpRzRL?=
 =?utf-8?B?MXNONExPWTB6MTdBR0tWb2FiL2UwYmpJQ0ZUS2FPQ3J1M042OGhBcThQejI4?=
 =?utf-8?B?OHI4ZFBPdG5zNnZXeWtkdWFYdzJmV1dsNDRIeGw1amNBVnJOc0pORW1PVjha?=
 =?utf-8?B?eXluLzk5RUo1Z0FRdnpCMmNubU0zcTRFV0NqUUIweWtaK3VIZjlKbVRreW5v?=
 =?utf-8?B?Y28yM0tpMWwvcVQ2OTVGekRuNjdnZVd4NHh3TlRoUU9UaUIrRzZ3MzJaN1ZL?=
 =?utf-8?B?WnNVT0RRNTI1dTRYd2dHTHZlSmU2VmExTGs1MkYydTljOXczYUE4aXc5Y3NW?=
 =?utf-8?B?cjBreGlSTERQZmZFQkhBeW9RbGhHNEhaVGQ0YUNIRlFVTjhrbmg5SzBPRmJ3?=
 =?utf-8?B?R0VpYXI1R3ZvWTkzYTd1bHNOY1ZMY1daa01vbExiSU0ra0NjamlnYTR1K2Zj?=
 =?utf-8?B?bzhQeDFRYVVVb0ovdFZVU0trUTVoQjJ2RDJSaW9NSVI5UVk0WDFmOHUybXpO?=
 =?utf-8?B?blgrdlNiTlpuczc1U3FhcU85ZFRzZGhzN2xlNGx1dks0ZXo2dEFjcUdkb2M4?=
 =?utf-8?B?ZGlLdUhsYjdTdzR2aDB6UjFwZXprZGlWTDMzcHRPVUNyWkVuUm9mTW1GRHor?=
 =?utf-8?B?eENCUmdVTGFYeXlpRXdJckphaDlpeGtNN1pyVW0rck5ra3ZmU2xtQlYvY1Nr?=
 =?utf-8?B?Vlp3S1BKWXZyYVkzcWFNV1BlQytFRHYrb1pObkVJUjRkNGZ1RU1pK0FnaDRl?=
 =?utf-8?B?T012RmNjd0FFQ0NZYzg0WjB4ckZBd0I4bnUrNEhUZmZrYmhkalB4ckVmWmQ0?=
 =?utf-8?B?Tmt5YU5GQWM3TS8wWjdNN3k1ODA1dFZQbVlLUkF4eWJUeno4K015Y2l5QVgx?=
 =?utf-8?Q?g023Hoxsod28aGUW+4N+JiZknvjj/o0IfPP6X?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb113b6b-ec38-4709-8725-08de54ed0296
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:50:06.2083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdIIEhvWG9IG8W0jyUUgIrzxouObS1a43IyN5kMUFJfaxvwUNbSq7r4094AEea1z5eyvWuZZXiqnERxH/OpQv5Qmbr1wNJDWl2MLQeeATqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951
X-Mailman-Approved-At: Fri, 16 Jan 2026 14:32:50 +0100
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

Hi Alexey,

On 1/16/26 11:08 AM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Wed, Jan 14, 2026 at 10:05 PM Quentin Schulz
> <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 1/8/26 6:50 PM, Alexey Charkov wrote:
>>> Add the required architecture-specific lookups to enable U-boot SPL to
>>> load images from UFS storage devices on Rockchip RK3576, which has a
>>> boot ROM capable of loading the SPL image from UFS.
>>>
>>> This also requires the DM_RESET framework to be available in SPL, as
>>> the UFS driver uses it.
>>
>> If it is a hard dependency, why is it not specified as such in the
>> symbol directly instead of relying on imply's at the ARCH level? This
>> will also be "painful" once a new Rockchip SoC has UFS support as we'll
>> need to forget not to add those imply.
> 
> Fair enough, will convert it into a "select" under Rockchip UFS,
> thanks for pointing it out!
> 

Watch out for select, it may not be doing what you want, see 
https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html#menu-attributes 
at the notes in the select bullet item.

>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>> ---
>>>    arch/arm/dts/rk3576-u-boot.dtsi              | 13 ++++++++++++-
>>>    arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
>>>    arch/arm/mach-rockchip/Kconfig               |  3 +++
>>>    arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
>>>    arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
>>>    drivers/reset/Kconfig                        |  9 +++++++++
>>>    drivers/reset/Makefile                       |  2 +-
>>>    7 files changed, 41 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
>>> index dc3771b556a3..84d9f39fd407 100644
>>> --- a/arch/arm/dts/rk3576-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
>>> @@ -12,7 +12,7 @@
>>>        };
>>>
>>>        chosen {
>>> -             u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>>> +             u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci, &ufshc;
>>>        };
>>>
>>>        dmc {
>>> @@ -81,6 +81,12 @@
>>>        bootph-some-ram;
>>>    };
>>>
>>> +&gpio4 {
>>> +     /* Used for resetting the UFS device during initialization */
>>> +     bootph-pre-ram;
>>> +     bootph-some-ram;
>>> +};
>>> +
>>
>> Is it always GPIO4 for the reset GPIO for UFS? Seems like something that
>> should probably be put in a board -u-boot.dtsi instead?
> 
> It is in fact always GPIO4 pin D0. It's multiplexed to a

This is probably the typical Rockchip BS :) It is the "same" for SD CD 
or WP pins. They have a hardware-controlled mode for pin A which is 
usually a black box for SW (nothing to do, it "works"). But nothing 
prevents you from using another GPIO for that (just have to be careful 
about the voltage level I guess, here it seems to be 1.2V for the 
domain, which isn't that usual I guess.

> somehow-hardware-controlled pin inconspicuously called UFS_RSTn within
> VCCIO7_IOC_GPIOD_IOMUX_SEL_L, but I couldn't find how it's supposed to
> operate in a hardware-controlled mode (it's not described in the TRM).

I guess it automagically does stuff in the silicon when initializing (or 
doing a controller reset for example, don't know). Your guess is as good 
as mine :)

> Mainline Linux does the same thing as I do here (GPIO mode [1]), while
> Rockchip's own U-boot code switches the pin to the hardware-controlled
> mode [2] and never touches anything about device resets from then on -
> which feels like a potentially fragile black box to me. Hardware

Yes, we've had our share of SD CD signal issues with the 
hardware-controlled one. I actually switched one of our devices to use 
GPIO instead (see 
https://elixir.bootlin.com/linux/v6.18.5/source/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts#L272), 
so I understand not wanting to rely on that ;)

> controlled mode would also deviate from the upstream DT binding, as it
> stipulates a GPIO for device resets [3].
> 

Not asking for this, rather wondering if we should really have this at 
the SoC level rather than the board level. If it can be any GPIO why 
forcing all boards to have GPIO4 bank "enabled" in SPL + U-Boot proper 
before reloc. It isn't the first SoC to have that (also see all SoC 
u-boot.dtsi having the UART controller from the reference design 
"enabled"), and I don't think it's planned for us to have a product on 
it, so... not a blocker from my side :)

> [1] https://github.com/torvalds/linux/blob/master/drivers/ufs/host/ufs-rockchip.c#L220-L231
> [2] https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ufs/ufs-rockchip.c#L222
> [3] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/ufs/rockchip%2Crk3576-ufshc.yaml#L53-L58
> 
>>>    &ioc_grf {
>>>        bootph-all;
>>>    };
>>> @@ -176,6 +182,11 @@
>>>        bootph-pre-ram;
>>>    };
>>>
>>> +&ufshc {
>>> +     bootph-pre-ram;
>>> +     bootph-some-ram;
>>> +};
>>> +
>>>    &xin24m {
>>>        bootph-all;
>>>    };
>>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>> index b15938c021d6..f9ecb6858f04 100644
>>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
>>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>> @@ -51,6 +51,7 @@ enum {
>>>        BROM_BOOTSOURCE_SPINOR = 3,
>>>        BROM_BOOTSOURCE_SPINAND = 4,
>>>        BROM_BOOTSOURCE_SD = 5,
>>> +     BROM_BOOTSOURCE_UFS = 7,
>>
>> Hopefully this will be the same value for all upcoming SoCs with UFS
>> (and not used for something else :) ).
> 
> Well it's hard to guarantee (otherwise Jonas wouldn't have had to add
> a translation function [4] for the IDs that changed in RK3576). Maybe
> at some point we'll have to switch to a lookup table per each SoC
> variant if these keep changing, but thankfully that point is not today
> :)
> 

See 
https://lore.kernel.org/devicetree-spec/ebc08400-c16d-4ed0-b487-9aabe13bbf0f@pengutronix.de/

Cheers,Quentin
