Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF12FCED24D
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 01:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FE788D38;
	Tue,  8 Oct 2024 03:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PomVR+jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2B588D3A; Tue,  8 Oct 2024 03:20:02 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37FA988C37
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 03:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKorfXJhWbCC2KZFiAv9LxJGL2my31UjcHWNWcledqAfOveM7FeRxPyBvhhcO0lmXXeBC93oF6enaO1q9UWMYiafIlDWd0iiHcKzb+mdrdYoXy/1dFVrz261MNR+2lQpg7UszsR8A6mT12ufqDHYE//co9nO2WP1nkjPEPEcUFIpCfmfy0GbvytJ1YXRD6o8ruJRpIv2pstduGT/nzv5hFdryMbrhOCVYt2vqljbm6Ri8RLysF+aHR+txO7/YcUKFZwWKc774rkfC1JoLrIFbUXg5eO98B9aaZMFOxJYpXZy3+dg2wRwliieTsqKpyMICe72rI1tzieibrl+cgBn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+4zbjMOnbJHHdFzUStsvTqQ04mugobe095DM/Oda5w=;
 b=a51ubXJvPqEXv+EKQovzx2PuGPXxVlKyGnBngThJQTwepDK//Vu6PoCXmT8/fJmz9OcxP+hz3KS7xws1LhR6qAaoeyk54AwSXXdADXgU4a0Sqbrdf+h3Tjw6SCIUulv/AXjVJ8Ex7eCeeDBRm7/XAB2WkZlg/5cHL+rDTSWKCoex3RdjdRv3ftqrTqW//rR5l8QJsWLWbtGSYp43qlcsiaAoDfmpdxnUNjHRu1hoIJD8v5jbDNCqD2yl+ObQEa0Hqc1f9JJHorqHZiGNDkMbW8S5hjmtwj6/mCCIEQ4auKykNPAweEVuU+6LiXHgUvfCgOXjkkp0ngy6P5/0HR5P7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+4zbjMOnbJHHdFzUStsvTqQ04mugobe095DM/Oda5w=;
 b=PomVR+jmAeSVdb5dO6+SHzLhi1CcLM1XahYQWD4yteZRCq/IlgBwzNv+pY7HyAp21fXKkVnnCr6a1VEyOllmO2CvZg/L0jjRTEdIOSMCzzvohqb/ZJcbt08TsaTit4nDfSGeejGxHm2I8EmPWWWI/XvC7gv2sXKLoK3ocmFNI8DCHItrOXbZ8W17RwcfUqH+KKuOGROkemYf1GulWCjSYio7riwbgEF990mNRXnMPmEW9Stlj2BAYjAP3EfOg/ux/8auupTTSKNcUOLXuj/7D0Gae9ns9yLL9pw6GMCqFhHDqQtIQYX0663DCuvrLQkwMoHP6WrRw3//XN00tflnlw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8305.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 01:19:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 01:19:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, Sam
 Protsenko <semen.protsenko@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] mmc: dw_mmc: Fix FIFO data transfer timeout
Thread-Topic: [PATCH] mmc: dw_mmc: Fix FIFO data transfer timeout
Thread-Index: AQHbGRnzzSjh/3gBdk68KSCEXdO1U7J8DgsA
Date: Tue, 8 Oct 2024 01:19:58 +0000
Message-ID: <PAXPR04MB8459C3B35ECF12A0707132E8887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241008003503.1914718-1-jonas@kwiboo.se>
In-Reply-To: <20241008003503.1914718-1-jonas@kwiboo.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8305:EE_
x-ms-office365-filtering-correlation-id: 5f700ed3-428e-4336-882c-08dce7375345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?az594szDR98Po7wCP9bERhWJ4O7vQC2C3pmTMTNnfDBA9PE7XW7042vYBQxg?=
 =?us-ascii?Q?6LxWBZDDu9nvcwCiqAGXVJfEgMACeVjRa4hhm94MN3KV5CHLuFsWawKjrrZ8?=
 =?us-ascii?Q?xh3nwzYjMGq+idIxNmRZKJITY4ze1MpBD9jJJqn1bvOC9AKCQuXAP648I0gr?=
 =?us-ascii?Q?xa2eMwfiUPG1ftaGx1xgfSN50gRYqn7f6aBPsy03FtJhqBe2j9T9K/tZVyNx?=
 =?us-ascii?Q?9WbbkgML/8qrC907MCfy6Hs04KIUff9AA22bjBWVZVKCk7H9dSso3n/gEn/Y?=
 =?us-ascii?Q?eUSrND1ZgsAWiJVXwX9ae4X4Gcpy7HEQCHWjDqSCyK2m3zKqZb6khAjAcuxp?=
 =?us-ascii?Q?BHSRvGsH4qsRgBDDR9gAK+Q+4vbUiK+JK5VjDYdummI7LHMbyc7ffgTiR+G5?=
 =?us-ascii?Q?NPTy75Z/kIrxmhXCxdkgl8CvqPte6T98NcvWD7RNZu4T42MEmTMAIzciR1T+?=
 =?us-ascii?Q?KBSEuEWUcny0peMZb92NEAPx6ZL2Zes1NMCrBB/lX0N3CzZXc3uTtxTc8HlH?=
 =?us-ascii?Q?quoGBpDHmVl07su9ylcZjrJe9HvpZutndFXBKIYE0XylRF7TEh5byB5LP/pq?=
 =?us-ascii?Q?niEZN4B16xL6ZPzHaaek1p1k4S26s3YE9p6kI77fiX7eZAXI5QE+j7iFIgTf?=
 =?us-ascii?Q?x2/vmgfNPStcC9dd36OqIqjbF5+1ilrrFHMpskSyaAfInwgF8NduXu9mAz9C?=
 =?us-ascii?Q?axdj7vl0mkFW0K8sn6pElZDFl8L52bn14yKQlVLjDVYGHmpQTLjVkp47IUMy?=
 =?us-ascii?Q?5Fu0SGDk/hgl42IujxH3yOeaCnskM+nUt570E8RBcfr6e+/f5LQv/aNorq6a?=
 =?us-ascii?Q?9FMEY7rsJgOGwHvgQqUH9q7uY3LbfZdG3W4Z5IsXar0tQMcqZJxWDP2UPLO+?=
 =?us-ascii?Q?PV4VVd7SQvr9B5t2wgSkxLNEuq+moZyWM56kWOHB8Kij+//1t9hfLXzoejNT?=
 =?us-ascii?Q?IuNHLpmoqE1CRqaxFDx+VUaHRAS8ecIkL1Ox/i4F6jA/MhiHqcqwWJ03eVMX?=
 =?us-ascii?Q?AnCpQ9XczWquraEB72c817cRsTxhP1kBGJBxC10NXGqTo7Ve1Af32RcZKIBA?=
 =?us-ascii?Q?wWucC4tjlglFhScd/CAbofW4QwhfcW1scsHxBIj8Qy46PMjouxt8z2+D14ve?=
 =?us-ascii?Q?MN+tZFy2HEwWIl6UAuuqphYX6YWr9OrSUja6H9rniZioIX3WA3x9xNNrLMWh?=
 =?us-ascii?Q?gxXpjxEVzVpYZOE1lLf0CbtvsSJp2pdK2bCNQgWmbqer6evp5/MwfmzlX+Bw?=
 =?us-ascii?Q?pD7nANnARwfoOcBBXZjQcK5g02AjSSMnyV8L5ttacLWTVn7+mWAk8zS9F95b?=
 =?us-ascii?Q?n/7ZdVNK42R9pP8vG/vdT5aBdIRA4I+gmZ4hg89fGHtkvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RBALyOmeRJVXo0NUDutNt0ptV7IpPQRXiwJZmRcbGo5ikMc/dDOXtg2l9Evc?=
 =?us-ascii?Q?hOFtpJ3BJHWasMpwuVy0AZSMRnSSM7h1cYKX2cx/AY3BAo6BNqiI6FtvBv5C?=
 =?us-ascii?Q?iJivECcc4g0t7BByCUiz6CtXCk1pHnG5dYA8mQxpmK//YbqzlIu6dDooL18s?=
 =?us-ascii?Q?vWNLTZ26Cdnd7IwObBwjyZEXUVBiLtdlrR75YJCIyJ3pDdW6cbs+qvp1RaA3?=
 =?us-ascii?Q?TeXkWplgVSxjj/y2yYozyyWDiMSWTn+GLe0R2xNt/kPzzvfCqwKRkjA2SHu0?=
 =?us-ascii?Q?zNsmfe7Ys58G7mv8zIUO+93jY4LPS8k998CVhPlA8NfyYH2JXHZTDzVsDZ5O?=
 =?us-ascii?Q?MndYpE+PB4s5TQlzAp5bwtqpwTLP8cXF3A+VMY26ETqvV3EeknzJc4VtdpgI?=
 =?us-ascii?Q?zQuhMsVcz3kpbFn/tKni5t6s51hfJqe6hsV+VcmV6exMP5PnnlYPqnaN34II?=
 =?us-ascii?Q?JiDAOm5kQvRLaoIXkgtvesL03LnmOohzfWDLKDe6d9NfaigA90qT3kl18Pxh?=
 =?us-ascii?Q?+NyK39cMh2kUZknQTQd34MGe8+eSIOYmCE8qb6ADglnyerzs8SiZyZd6R8qJ?=
 =?us-ascii?Q?yE90LyQr0M6VwAoHQ3SjjWDI50sZKEMGnyXd3F6blcd5Rs1s8iDBxLquF52w?=
 =?us-ascii?Q?DmIvb30Q/994JDcRJN0lXXW5NWO0vqPfwE4tshFxr6yQpywLM+V4mddZLHmI?=
 =?us-ascii?Q?XOFePVfV6dB63sP7kGNlR6CUF8Vnk1Po9kJZdRHxqD99ei1im1ZCwr3x9v7A?=
 =?us-ascii?Q?gWe7TGxQF1NPhLrQUE70gZhkS8oHoYGNYVJqqTU6az0lt8DCOHo+RmO9jjn/?=
 =?us-ascii?Q?x5FeGBf55GVDvZ+7NX3ELyJVLhNbUiexiRFwz9AM7pu93mXhuD+ORoAvn0eZ?=
 =?us-ascii?Q?fpUptBOCD/RfsMnyHwrk/sGXAwZPolexmjyXlEZ6DpsmH7T8mAaaQjQTjwJy?=
 =?us-ascii?Q?dWAB4H46Bd3qbi0ZNQLoc600RfYyp7NvSwfkGBSikR+QxlGcLrf1nfCu3HFZ?=
 =?us-ascii?Q?UhnydWgv5bTcjCfehv7AGfQn1umGLVCskRmZ42ZlNxT4e1nQQsiep8Jdn2S0?=
 =?us-ascii?Q?CG247W+BmzOPuaNadbrv6Ddl9ct/kzxiEkSYRyWRm/NwJwhm3mDJ1Tv9xZUc?=
 =?us-ascii?Q?4fe/Tas+OZNyHVJmIhF2jG2aVP41neloDNCCX5g7oCQXP016Eu2CEe19de9y?=
 =?us-ascii?Q?cjDsSOvyaDsZk7rlYMU2scYiy0M4RG2WIMlm+jxtWtSNmpVxu6lEisVuE201?=
 =?us-ascii?Q?Q5vNQH2YXRXurpMX6tIbj2wKP4GH1QRP79xZo5qWtLchybR6DUCq1z612CeM?=
 =?us-ascii?Q?aQF/P29uuWSoFFuWunD9xwyjIEyiN+afXhNTuXaL3/O5YjWlsQrD82dSUvld?=
 =?us-ascii?Q?TDFnYceqwpcpflDEbrNHnR2ITCmI42FQ71PgE4kk2qWktI4iIszFzGzJi7Ya?=
 =?us-ascii?Q?FPj++Ibz3ATkrNNwVUEYW61+RatsRIWh7pR3uO5XM6AJR1nKPxVuFDbx4RgS?=
 =?us-ascii?Q?bIIwtoDmaMw7q9Qc+Na1Vnayjr1mFCUnt9vKivyoAEKx8XgNCLasssht4Kie?=
 =?us-ascii?Q?Lm4O4Vn/1711hoHYW1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f700ed3-428e-4336-882c-08dce7375345
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 01:19:58.5548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovCpJUoTfUDEGNQ8tZoL+USQOPlwcwOX3SyXiXhmhZtvyhTD8m9/w5BSArlndwKt9HqPLHuDUAWDz69uqnI2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8305
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

> Subject: [PATCH] mmc: dw_mmc: Fix FIFO data transfer timeout
>=20
> The commit 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data
> transfer into a separate routine") unintentionally changed behavior of
> the FIFO data transfer routine.
>=20
> When data is read and size reaches 0 the original loop would wait on
> DWMCI_INTMSK_DTO or timeout. The remaining size to read is no
> longer tracked across dwmci_data_transfer_fifo() calls and because of
> this an extra call to fifo() and dwmci_fifo_ready() may now trigger a
> FIFO underflow timeout.
>=20
>   Buswidth =3D 4, clock: 50000000
>   Sending CMD16
>   Sending CMD17
>   dwmci_fifo_ready: FIFO underflow timeout
>   Sending CMD16
>   Sending CMD18
>   dwmci_fifo_ready: FIFO underflow timeout
>   Sending CMD12
>   ## Checking hash(es) for config config-1 ... OK
>=20
> Restore old behavior and track remaining size to read across calls to fix
> this.
>=20
> Fixes: 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into
> a separate routine")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

LGTM: Reviewed-by: Peng Fan <peng.fan@nxp.com>
