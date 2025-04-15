Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08811C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 06:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9808212A;
	Tue, 15 Apr 2025 08:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="Mz6+zugb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29DE8214D; Tue, 15 Apr 2025 08:12:06 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517FD820F8
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 08:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeeovioeO4g7nzg3jrXpJeKABL8SHpRFiPRv48h1Wq1VZ43xogvx/pWyIFbQbViEhCn4SK3aVQO/HwRemwci9LCdmperqnNtxQsVbCQ4s7ZWIp4H2rbhiqYrUaCQLrp0/HyP1QBg3YG/bbp46ewbl24a281G1zW7bTJ5cK7W9rW7nrwSC1L0//Y8AvR4lJpMSza+aV71+tNLXREQ5N0zkAp5T+lBHaMvqh65y3MxsqyxexnmQ/POomCtALvUMYkS/zosEdRa3y/VBJT7YUALcI5OzO7J+ssy7LwPQE/LYs03ap9HyGniP+qxmV8pPB5L+mh3hVOlk0MZMXtf5+OzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ber+nPZy887H3waJX9iQNbsHtvaIu9ZS+LxedrG/kNg=;
 b=BNJmZ6Z6gYYeTkmsz7hJnx33JNlJgHcngYt7rdx33UZr1qJVuslsW7/+a9k/i5bTXcywgJTJlYaUV2KdNCb/ncYIf3i2lb6n58dA3Ki1QEaCDEnkny/sB04bCLRm560rwhIA0H/Y4xWJgTljOZzsF65OD3AUczfWHI/1oftMz9kyn3U8tpj6Po7LJ8vLTqNRhJdLbJttw/u14Jq5XCBZ00C3rshj7EQc+GBtkB3wa8YsVa40mSc78S0Wnny4KWrODg6rN7rGHXiKzK4rZGZNoKOpzRgd9iLejQ6uD8JCWeGMPWJVsMdM7CXa3HgQ0ErWe2gyISAfYLViUoT4oUI5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ber+nPZy887H3waJX9iQNbsHtvaIu9ZS+LxedrG/kNg=;
 b=Mz6+zugbLSeYhAffJ88U2c0sFzKsn0MfSHZPsNF52smTCoYKolJzGIi5JhO0y8cf9RvPHWoMJuSDrLVZcZaC7lFJ16P5VUjmzF5wx6Sypl6uZ3S/VHWFGJqb7fk/HK55iSdHH3PvV+2i86Z+jpiwH3dN/CAb1UvX1SgTB6JoxZP04k43yUiufZkb+Y4b7TxB+YrNEG0a6R65Ynxfyebiq1mwiYOw17Pg1H2FnBGK4N/mJUgL38KvKJfyANBCqLDcts/jgj93Vsq5VrOq+21YWSDSPara2/hRwDCNfXriKtY8BCW25nBM2oEElZDyuCGIH8YGJBNt2NSIIhCfMkNCEg==
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com (2603:10a6:10:369::16)
 by PA3PR06MB9838.eurprd06.prod.outlook.com (2603:10a6:102:4ab::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 06:12:02 +0000
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652]) by DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 06:12:02 +0000
From: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
To: Mike Looijmans <mike.looijmans@topic.nl>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: Use CONFIG_IS_ENABLED for
 CONFIG_SPI_FLASH_BAR defines
Thread-Topic: [PATCH] mtd: spi-nor: Use CONFIG_IS_ENABLED for
 CONFIG_SPI_FLASH_BAR defines
Thread-Index: AQHbp7ZYlaA4sJ9dF0OPw58coxDSJbOkSVbF
Date: Tue, 15 Apr 2025 06:12:02 +0000
Message-ID: <DB9PR06MB8559A0DE7DA0234FF87CD9FDD2B22@DB9PR06MB8559.eurprd06.prod.outlook.com>
References: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
 <e7103890-b243-408c-8f38-8fc63cb2d08a@topic.nl>
In-Reply-To: <e7103890-b243-408c-8f38-8fc63cb2d08a@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-04-15T06:12:01.998Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8559:EE_|PA3PR06MB9838:EE_
x-ms-office365-filtering-correlation-id: e85df8d5-e7bf-4c87-3161-08dd7be4704a
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uZkhCYjYwx7hcTsYuo6hM1nmIID4X93FnVn+vdZ4td3zo9/9r+ghdb4pEU?=
 =?iso-8859-1?Q?ZeHmDLlwMf/itH/58IQzXtzldVxn5zBEF+g+AlcNX3KCO3EZfG1rW+KRlQ?=
 =?iso-8859-1?Q?YD6vWlwl/PnSdQmY8ls5MtT6oev/jbnpL5N2N5XFxK2fJVruRWgh1QAsS4?=
 =?iso-8859-1?Q?n4jVWWKdCFD7uyvLtdbnRVZ+izWlsxkWV4DPSyzVpbiUr0TA+uXY/5e+hh?=
 =?iso-8859-1?Q?IIgncBxtNe4+kfTZ4PnWp2fjKvLW6yBm6He7Viu8qBHngJ9rwGtHfqd5RX?=
 =?iso-8859-1?Q?exbguRPgG0yfLy9RUDTx70s5+TzuDen6ZzF5unBeHhs10HEkHM9kh+g3sc?=
 =?iso-8859-1?Q?98OLLtP2dXdtLde8vFk2TUsRTKDCf+dR1tPrhHvjhnG/RB+decomzBaD+K?=
 =?iso-8859-1?Q?aUro9STj8BppdCTSeDfGOBka6qcGr8OWMz7MEn+ERbI4F4/Pvl9gb/5Uv3?=
 =?iso-8859-1?Q?RA2IDRNiXk4AF1stBGOJLOYex7yhOcTrmaXyB6i6s3AeI0DlVDqR7PUpRe?=
 =?iso-8859-1?Q?iz3CbRoHvlk5BA3unKtwgUn5Cme8RHNFoxYSwyTQbVybHffnaN642rBatq?=
 =?iso-8859-1?Q?rm21fkw9G61NZ2HseTwjA5F0hQTyOHQRK77JdIbcPkB4KrbE2/067auQmC?=
 =?iso-8859-1?Q?1BmdS01NUgpAQB9uI12dLckbQL9HP2uQJW9XLuma+VG5sgTgubyYbXDlyd?=
 =?iso-8859-1?Q?9Qv/qzCp6tIj5dldSjI4IaU/BAHIxUONuSKAjVsY1bh/QE+h6+837s3GRu?=
 =?iso-8859-1?Q?WcSqQn5wEwTjUHnlGVMBN0H1OBB70cBRmWLiu2gE9+JPDDpl/9LvFIjRaJ?=
 =?iso-8859-1?Q?5JuxuBdMfkTSOMqe/nMglQ3L92ILcAhiUuMMhLjD4eVCSt3S06W+3ZrSEb?=
 =?iso-8859-1?Q?mG/yumiuILKmsOQrSBD/2lBTv4d7qiCUmtpcO0YnwSWwrLJ7jq8/aFjOny?=
 =?iso-8859-1?Q?Jq92NMnpBESgiaSxRipqe3qyhRHZR6ZGBG5yRpa/2SCH6JNTYS04RhHtT7?=
 =?iso-8859-1?Q?7BXLaEPt6OUAM3x0HDqvJ4Y1e0iwPegCfLlzdin8R6C3tizEUmNLDgHy5a?=
 =?iso-8859-1?Q?PssErGrJjRxdJXI4pozmQ8E3oo9cgi4Bo6Ewq6pKS1Am6fRFpSwDgRzoWE?=
 =?iso-8859-1?Q?byn1DIDqH/lGMwpiYqaUcz7MqL9jSPqj91bWf4g8HDeyS55F6B4P0UYyP4?=
 =?iso-8859-1?Q?oO24HiV4yps9xoLsYF6Ls1g0JHiv5kSbnLvBXitPSAJnCIT+kgTM/KCf/5?=
 =?iso-8859-1?Q?iMginxEAhDWvOUghgL8USSWRECaPm8SbiGodUtsUq3i2YiJ4g3ijqnWaxc?=
 =?iso-8859-1?Q?31wl9lGE8dmLF2Huswi7f8Kd50tuBWl6r3yC93AXQSG7gaAZlvO1NqH9HA?=
 =?iso-8859-1?Q?EuDnnwzqp+WOL5vfZDlCDAVN8tcqsQzHHkY8Dq19NtSvHY6tOdJPRRnVOK?=
 =?iso-8859-1?Q?EyedQ5xmCuqKN49ht+YL4bJF8Q47fI/XGQKnkQVHzUcRocRvKkvtuhc9l1?=
 =?iso-8859-1?Q?SPG/yOxcOOH6dzJxI0eC6Sj9xNBcvVFwxyl50MTLKvhw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8559.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G1KB9CP/oexgeqejOyRhAE9zBp3sQCER51piByUfp4yFEsMcTzy/MkdSGr?=
 =?iso-8859-1?Q?prk+ywgJLuUPtNrZti62RgzmZ9wchclfgj4XrW+sApjGn1r3Ts/x7MvflF?=
 =?iso-8859-1?Q?nrJ1GKYUD4sOKEbhNYXFZSwTgEeDSLFWUlXu8G+2UhhTq61we9o7kLC+Dj?=
 =?iso-8859-1?Q?bwNWgsXaXw0PhdtCfyRj4pAbFDp1wT/SHFDoKywGLUmYryBd/loIBxFF7L?=
 =?iso-8859-1?Q?U04/y/2+dmkcgHPKYlJ8S3dZg5wCruqOfaLhTzSGkwnPuboWpIXN6iYqed?=
 =?iso-8859-1?Q?UMFDqM9Sn5gz5dpGmYQD9nOEqVtbecXx4XH/pHUl44P63NLkXmMXE81KMl?=
 =?iso-8859-1?Q?2oY2k09tZAakidU+4WHggaKPdKQVhWgbQIt1V0D4R6Uv3ax72L/8yELP6x?=
 =?iso-8859-1?Q?FJmr2bRZL+JRVunGD0za9iwjdbuqgE7EURUjBJdEU/vcuedeE55PHx7FnM?=
 =?iso-8859-1?Q?8NGHyEsDzQ+f9DQszkei4BOIpEre2S94rVXT2MIcUNyqb8OJr6bLV7JxwJ?=
 =?iso-8859-1?Q?XgeyynYXXkjWLG4V+tnhPE74PdpsHeqOoQNk70Awu1x+UT9M5FCP8iTLQm?=
 =?iso-8859-1?Q?6meVH8krBcHadMaoI55A7DrQv5+6bqBTN/44HIpqNnAMyeuZQajm88z5+r?=
 =?iso-8859-1?Q?58V6h1w8bK92NuxEeyST4lDTUJ40DALbI5EDGWIdZDZ6dmbb3h6s56MzoK?=
 =?iso-8859-1?Q?i/MEHSa/gHgL0eNo6HOZsf8Lnd80mWdO9oscix6fpHCK8O12aJmZCoNil4?=
 =?iso-8859-1?Q?2RQgx8iOjbLPOZAXfpWK5zX3Pp1OpyTdJ46acfqPPrdOI3gvLsE+8p4ysN?=
 =?iso-8859-1?Q?5nFTQt6KSWLzL5tQGMFxAXisy9S96MXfRL2rSf5LQi8t4U2PPZMbTKjWBC?=
 =?iso-8859-1?Q?888SXpfW3WaWgOCy3vPj/mX8nNh7YFxeXEGea+Uz8iGM1fiA48OwxT/3pZ?=
 =?iso-8859-1?Q?qO3xRnQSJs06BzLsKrblweTzjZCCX5TgmO7otyAjEympaT0THw1uvnveCf?=
 =?iso-8859-1?Q?z4h+jLvnbgGlXvwYUSSCNBYvbowtvr4Pc74sa+nc+AKG8GdpaPN3AdaWUT?=
 =?iso-8859-1?Q?KDrSoSOuiD9d/jya1MapzCiF4qTJqurWCQhtltHZPSoCLGL0JESYi0OJVT?=
 =?iso-8859-1?Q?HOuzeuwYfPr8+LrZAyR2nRWaDPB1iJ3WDHBvOxmD3Bb9sDPOLgu41GqaeG?=
 =?iso-8859-1?Q?MGZwLtlw/LqCglh2Jcr2VkPBGwMPG7dRh6dUKdDMVSCPhx2oHfVBi9y9Vt?=
 =?iso-8859-1?Q?fME3V7ynp3k/EF34SEATLaSZcQ2Bcef6JEnAeCuaDD4XpJh1bt+Yb94veB?=
 =?iso-8859-1?Q?gjxEWBDIDlJq81X4hFeOaJOQ9snKp2d9GAhyYteb8yqX+W0zZHiTtRZoJf?=
 =?iso-8859-1?Q?ViKnjMQodKI/m7OCHOcHscvLbLa4xuzcs4KK0TG++bihhIpAhXAPKkykuC?=
 =?iso-8859-1?Q?6R45zkexK/HJY7AwiLCtZIE0U704ru8bAq8oH6lijAwDY4C8bQRLWVebw9?=
 =?iso-8859-1?Q?MP8wov/WkltcD8OgUN1WmwHhX0D2ATORqyfJZ5B0PLDvc9bMLw3gJnNxss?=
 =?iso-8859-1?Q?c+5ikopWkqI8M4sY7HjKfvkQ/84eR2WZ0r7GkJa0DEvmFHby8LB+FINwfC?=
 =?iso-8859-1?Q?83Rqg2SxSH7koyE/HZG7jhnj5yXt2Wo6sT3FSl0hyLpFexj8QoiQu45ZJq?=
 =?iso-8859-1?Q?OUDQ6EcniZF8KzP9fJs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8559.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85df8d5-e7bf-4c87-3161-08dd7be4704a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 06:12:02.3084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPuHCkvoYfmIMzqgUb4dNWergdJP6KdD9rDiUJlW690+W+KpiyiWFa0Q+EgZOjgLWHOj03GQ543cAZBE4sNISsge8r2O0zNOdX4PmtXeV5eOrydaroRz0MjPSO9aORhtfaRJbwkbsTzB0bSNavSXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR06MB9838
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

> From:=A0Mike Looijmans <mike.looijmans@topic.nl>=0A=
> On 04-04-2025 11:56, Bernhard Messerklinger wrote:=0A=
> > At the moment a mixture of ifdef(CONFIG_IS_ENABLED) and=0A=
> > CONFIG_IS_ENABLED(SPI_FLASH_BAR) is used in the spi-nor framework.=0A=
> > This leads to misbehaviour in the SPL as there is no Kconfig option=0A=
> > CONFIG_SPL_SPI_FLASH_BAR. This commit standardizes the use of=0A=
> > CONFIG_SPI_FLASH to get SPLs that load U-Boot proper from the=0A=
> > SPI flash to work again.=0A=
> >=0A=
> > Fixes: 9bb02f7 (mtd: spi-nor: Fix the spi_nor_read() when config SPI_ST=
ACKED_PARALLEL is enabled)=0A=
> =0A=
> I was hoping this would fix the issues with this commit, but apparently=
=0A=
> not quite. If I add this patch, the Zynq boards still won't boot from=0A=
> QSPI with SPL, though now it simply hangs SPL rather than causing a=0A=
> "panic please reset the board".=0A=
> =0A=
> So far, only reverting commit 9bb02f7 results in a booting system.=0A=
> =0A=
> Mike.=0A=
> =0A=
=0A=
This solves my problem, perhaps there are others.=0A=
Is it possible to provide your defconfig?=0A=
If so, I can try to find out why it is still not working for you.=0A=
=0A=
Regards,=0A=
Bernhard =0A=
=0A=
> =0A=
> > Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automa=
tion.com>=0A=
> > ---=0A=
> >=0A=
> >=A0=A0 drivers/mtd/spi/spi-nor-core.c | 22 +++++++++++-----------=0A=
> >=A0=A0 include/linux/mtd/spi-nor.h=A0=A0=A0 |=A0 2 +-=0A=
> >=A0=A0 2 files changed, 12 insertions(+), 12 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-c=
ore.c=0A=
> > index 6f352c5c0e2..a8865bbd37c 100644=0A=
> > --- a/drivers/mtd/spi/spi-nor-core.c=0A=
> > +++ b/drivers/mtd/spi/spi-nor-core.c=0A=
> > @@ -655,7 +655,7 @@ static struct spi_nor *mtd_to_spi_nor(struct mtd_in=
fo *mtd)=0A=
> >=A0=A0=A0=A0=A0=A0 return mtd->priv;=0A=
> >=A0=A0 }=0A=
> >=0A=
> > -#ifndef CONFIG_SPI_FLASH_BAR=0A=
> > +#if !CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0 static u8 spi_nor_convert_opcode(u8 opcode, const u8 table[][2], =
size_t size)=0A=
> >=A0=A0 {=0A=
> >=A0=A0=A0=A0=A0=A0 size_t i;=0A=
> > @@ -739,7 +739,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_no=
r *nor,=0A=
> >=A0=A0=A0=A0=A0=A0 nor->program_opcode =3D spi_nor_convert_3to4_program(=
nor->program_opcode);=0A=
> >=A0=A0=A0=A0=A0=A0 nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor-=
>erase_opcode);=0A=
> >=A0=A0 }=0A=
> > -#endif /* !CONFIG_SPI_FLASH_BAR */=0A=
> > +#endif /* !CONFIG_IS_ENABLED(SPI_FLASH_BAR) */=0A=
> >=0A=
> >=A0=A0 /* Enable/disable 4-byte addressing mode. */=0A=
> >=A0=A0 static int set_4byte(struct spi_nor *nor, const struct flash_info=
 *info,=0A=
> > @@ -930,7 +930,7 @@ static int spi_nor_erase_chip_wait_till_ready(struc=
t spi_nor *nor, unsigned long=0A=
> >=A0=A0=A0=A0=A0=A0 return spi_nor_wait_till_ready_with_timeout(nor, time=
out);=0A=
> >=A0=A0 }=0A=
> >=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0 /*=0A=
> >=A0=A0=A0 * This "clean_bar" is necessary in a situation when one was ac=
cessing=0A=
> >=A0=A0=A0 * spi flash memory > 16 MiB by using Bank Address Register's B=
A24 bit.=0A=
> > @@ -1141,7 +1141,7 @@ static int spi_nor_erase(struct mtd_info *mtd, st=
ruct erase_info *instr)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nor->spi->flags &=3D ~SPI_XFER_U=
_PAGE;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D write_bar(nor, offset=
);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto =
erase_err;=0A=
> > @@ -1175,7 +1175,7 @@ static int spi_nor_erase(struct mtd_info *mtd, st=
ruct erase_info *instr)=0A=
> >=0A=
> >=A0=A0=A0=A0=A0=A0 addr_known =3D false;=0A=
> >=A0=A0 erase_err:=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0 err =3D clean_bar(nor);=0A=
> >=A0=A0=A0=A0=A0=A0 if (!ret)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D err;=0A=
> > @@ -1630,7 +1630,7 @@ static int spi_nor_read(struct mtd_info *mtd, lof=
f_t from, size_t len,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 offset /=3D 2;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D write_bar(nor, offset=
);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n log_ret(ret);=0A=
> > @@ -1667,7 +1667,7 @@ static int spi_nor_read(struct mtd_info *mtd, lof=
f_t from, size_t len,=0A=
> >=A0=A0=A0=A0=A0=A0 ret =3D 0;=0A=
> >=0A=
> >=A0=A0 read_err:=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0 ret =3D clean_bar(nor);=0A=
> >=A0=A0 #endif=0A=
> >=A0=A0=A0=A0=A0=A0 return ret;=0A=
> > @@ -2016,7 +2016,7 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D write_bar(nor, offset=
);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n ret;=0A=
> > @@ -2090,7 +2090,7 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,=0A=
> >=A0=A0=A0=A0=A0=A0 }=0A=
> >=0A=
> >=A0=A0 write_err:=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0 ret =3D clean_bar(nor);=0A=
> >=A0=A0 #endif=0A=
> >=A0=A0=A0=A0=A0=A0 return ret;=0A=
> > @@ -3791,7 +3791,7 @@ static int s25_s28_setup(struct spi_nor *nor, con=
st struct flash_info *info,=0A=
> >=A0=A0=A0=A0=A0=A0 int ret;=0A=
> >=A0=A0=A0=A0=A0=A0 u8 cr;=0A=
> >=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0 return -ENOTSUPP; /* Bank Address Register is not sup=
ported */=0A=
> >=A0=A0 #endif=0A=
> >=A0=A0=A0=A0=A0=A0 /*=0A=
> > @@ -4577,7 +4577,7 @@ int spi_nor_scan(struct spi_nor *nor)=0A=
> >=A0=A0=A0=A0=A0=A0 if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_ST=
ACKED))=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 shift =3D 1;=0A=
> >=A0=A0=A0=A0=A0=A0 if (nor->addr_width =3D=3D 3 && (mtd->size >> shift) =
> SZ_16M) {=0A=
> > -#ifndef CONFIG_SPI_FLASH_BAR=0A=
> > +#if !CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable 4-byte addressing i=
f the device exceeds 16MiB */=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nor->addr_width =3D 4;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (JEDEC_MFR(info) =3D=3D SN=
OR_MFR_SPANSION ||=0A=
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h=
=0A=
> > index b8b207f7b5c..4eef4ab0488 100644=0A=
> > --- a/include/linux/mtd/spi-nor.h=0A=
> > +++ b/include/linux/mtd/spi-nor.h=0A=
> > @@ -569,7 +569,7 @@ struct spi_nor {=0A=
> >=A0=A0=A0=A0=A0=A0 u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 rdsr_dummy;=0A=
> >=A0=A0=A0=A0=A0=A0 u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 rdsr_addr_nbytes;=0A=
> >=A0=A0=A0=A0=A0=A0 u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 addr_mode_nbytes;=0A=
> > -#ifdef CONFIG_SPI_FLASH_BAR=0A=
> > +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)=0A=
> >=A0=A0=A0=A0=A0=A0 u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 bank_read_cmd;=0A=
> >=A0=A0=A0=A0=A0=A0 u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 bank_write_cmd;=0A=
> >=A0=A0=A0=A0=A0=A0 u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 bank_curr;=0A=
> =0A=
> =0A=
> --=0A=
> Mike Looijmans=0A=
> System Expert=0A=
