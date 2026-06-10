Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F41CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 07:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173CC80087;
	Wed, 10 Jun 2026 09:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gCjA1AGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A5980433; Wed, 10 Jun 2026 09:21:44 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830E680086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 09:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sahil.malhotra@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd2NLyHmfZ//LTbhJZin//JYiWgB33FstbXJDeGoks/1hTz5nlORORzpcGlyR6v2rtAg8S/neSs75gC9Qg6UKfkwDSZdyMfbOBnBhASlIG+8IKjeCnUu6BSZw4YPH72yzqeQP39V3lQx0r/6yx0Pgofy8TQw901DUNNvY30x5m3XqF8oCj+tgMxvebLodvKpyB52eYtB16J+chx6qNc6IIQvNraoEp3HrT9DfoUSpaURygghBNJlrlOugPs1GfwEMubqU+jjq+rnsYS74SxcEGeEtyJmdvt0Cnk131S3Hl0cx7YmKbp2W+m0BGXL7QeVa0VGDzl/4YXXbweLMRscDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jslESPRvrnMs8QMcDazMemq1frIbOnqLtZxAR27VUGw=;
 b=SGjMWLXSEKrpmWHSaAuJwalqigInR0OC2r7enTIhgdQYveOimv8qgYFifPzCnJogMP1BiOeCpCq7BwCH/Cfo28PTnucxhSNA+arj/Qx+Xw98975e7JpHD+C1VlMgq296WGPGuIErM45iyU2oVw2BLYt+onCvb/2K4wmYlqxDK7p6TUfKwIJkJNEJCkWOCrO6KqWlz/VEWpvPOGbBzwE825j+XIgB3AuOrLED5a0vw0B/ZQ1jB7MyXZoecopUeubwBMlcWfOPmASNlW4VQ5IJLoOcOdsprGUHfZwP9M+vWt3oIHlkdJC7ZZtpL3JwYGAfWy+nRHCSB8WPPbHxHKUEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jslESPRvrnMs8QMcDazMemq1frIbOnqLtZxAR27VUGw=;
 b=gCjA1AGZN9QUvXHt3UP0mUS4oaAc+1xtiUUkyHll/ANbIzOe4FzaLZiTIA5JJi7FLmT3IUIl8bmgPD523wlh0mzaLmAbnpO5JnRpbL5YdeBA+eVyUTfyXV+rc+0YTBG0wMD+Qc75nX0Ct0zfffNepBxmnbO3pADwN7jDvSiFmTc/NIzQoOZ6KBqaybWivNmSXPYEM5tHDFvW6P610xBUblMHz8TfJG4+qrCpLUXapwmNHzKSrpyz8qlP8kGWc8AMOzbnbVqGvUqx3NWaq6nHS2epsxwYWbA2xq7HEN+1mQ76/Il+5MPdtDMZ52i0BYanBXviY3FXtdm3FLTVzngqZg==
Received: from DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17)
 by DB9PR04MB9329.eurprd04.prod.outlook.com (2603:10a6:10:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:21:39 +0000
Received: from DB9PR04MB8139.eurprd04.prod.outlook.com
 ([fe80::97c8:7d82:e34b:3d43]) by DB9PR04MB8139.eurprd04.prod.outlook.com
 ([fe80::97c8:7d82:e34b:3d43%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:21:36 +0000
From: Sahil Malhotra <sahil.malhotra@nxp.com>
To: Richard Weinberger <richard@sigma-star.at>, Sahil Malhotra
 <sahil.malhotra@nxp.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, "upstream+uboot@sigma-star.at"
 <upstream+uboot@sigma-star.at>, Ye Li <ye.li@nxp.com>
Subject: RE: [EXT] Re: TZASC misconfiguration on i.mx8m
Thread-Topic: [EXT] Re: TZASC misconfiguration on i.mx8m
Thread-Index: AQHc+KnFSnxUmkMPEESpZyGiWVZxTA==
Date: Wed, 10 Jun 2026 07:21:36 +0000
Message-ID: <DB9PR04MB81397980C1FC5FE5F74A76BA821A2@DB9PR04MB8139.eurprd04.prod.outlook.com>
References: <3208216.Ym5mLc6kNg@nailgun> <3228430.DofJx8uAJo@nailgun>
 <25db2dd8-e381-4b4f-a90e-7a76a7b31c59@oss.nxp.com>
 <3324321.byNdk4fJJx@nailgun>
In-Reply-To: <3324321.byNdk4fJJx@nailgun>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8139:EE_|DB9PR04MB9329:EE_
x-ms-office365-filtering-correlation-id: 75553735-ae20-474d-f659-08dec6c0e853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|6049299003|366016|19092799006|38070700021|4053099003|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: fPe+XyU0RE4omgTb/VDCCJ9T/zr3jbC0QrOJd1pDcufMHxCcff5AGlh+TxBr+PeKa0I9fkPlmArNP53K4iJoJ0VIwuJGqju6wt8eLufXy8f6q5rAXQEUVH3Z4w+NIhg2PfCqZvsRdZGO5ZCaDXRKA0Tm8GQGW5ey1b3WmRgLo95jrvJBH5mVyLEqZDzxbBi+Dl/4dPUf3bmXAj+HCIXrNFtXi3nmTSBpBufsRQUOJAeu8H0l6byfdyZmtJCPXY7hvr815BjVoHNPS6iuKD+uOP8SIayyB3trppBdov6fjdAmPEq/TyD2oPcD+kitWtv5GgUDUzJvYq2KjO+euWWMaUgAwklORvj6Zf0nolBjmNT9eCuU+5Zq8XPc+cBrctnsMkAiGtpAPE65Z9CKZ+t9paTDynUqEdTFzLKMMXK9KUlUi8FU5RUuAyqSvzXEXmH7QBcKFNEaHqUDphArhyFqvJA132l11QJo79ma/vMLTgSALQp0a/u3Owc7N9Efz9iv1DYjLvHfIMzBSO5sX0xQkVPps9z7JOm/RbYfjVk++IG9wmcqI+PASGjXMZI1Hq+pgbnYpM8Er+CWNGaPEnFnRJBIs0KHYJt7ZW+DG6vQ2vcx5ot2XIbTRtPc8QHNkOUzi9UyrebLGIJzVc1jNAgQWRy8uUuNgnxXm9CC1Ve4sjRFQ4Rgr50DyZDaQY95S4rXcrrQWBZBaXaxPB0doUP1broLA/3oW9SzPW+WTfBC1Q4X/idW/1zUfUe5sOnCD/2KyC0mDBVR11ULI6BaQe1hhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8139.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(6049299003)(366016)(19092799006)(38070700021)(4053099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGplOFVkM3ZYbWtGRm5xR1NiUEdNNmg5MGswMHN0SjBvbFVGREhWc1hWSWJ4?=
 =?utf-8?B?a1ExV3M0NkxTWWlXWkptS3VLVHVTTlZCQkUxMGhhcmJOL0RmMjQvSFgra0VG?=
 =?utf-8?B?TlBYU0pRUXNnWkhZZkNhbFRTZkZwL1R1a2dsVXAxc0pUQnc0SThjVTVGSVRw?=
 =?utf-8?B?dEVsMDZQeFJLUWd1eDBBSkpBbmJWYjlUQTRHZFQ3aGFzMXdEZk9KS2lpdk5B?=
 =?utf-8?B?ZDNxZ0RXVUZ1K0NrSFR1djN6ZWlBQ3lmWXdzclB6V2FQZjI0WFRrRGhMeHJa?=
 =?utf-8?B?Tk5odVFCV1ZlUWw2VkhMNndhM1QrY2EwazAyeHFPbXhsaG5kc3pNaURDb1hE?=
 =?utf-8?B?R29ZSDdBZWZUQXRQVElnclBIb0pqK1o4WG9MR1YyUU5qNWZFTzlNUGpYTEdE?=
 =?utf-8?B?WklFYU1wc0M1S2NHK0pHRys2SllOcjBIOXY4MHBZci8yL09VMEZGUjJNKzZi?=
 =?utf-8?B?NVY5cjcxRFUxdTFJeVY1cEgzRHk5M3pDNkxqd3MyM2lLM1UzTkxmd1VKSUZ0?=
 =?utf-8?B?U0VHTGtEeUdTUU1zN2pWT2xFY3ZBTitldTBHbCtnNDBscDV2Q1VrazdJbW1j?=
 =?utf-8?B?M04wQ1VWYTRWV3YyNTMxVkc4VGk1MHZDY1NVL1FQSWp4bkhTSGZMa1lvczRo?=
 =?utf-8?B?eFhDS1JGaUljdnZ6d1EvdUg3U2pFdGRock9rRFlxNGRxOGNDbkQwdEpGak54?=
 =?utf-8?B?U09SWWtFWHRXRERZZlZ3VzlhVU5yL2hnQVYwcDBnMmNlMXNNL0dhY1J1K0Zv?=
 =?utf-8?B?aHNONmQyemo3dHRyM1ltempjdUlOdENhM3NKYVZ1YWVTWTB0dzBteGNNOWEy?=
 =?utf-8?B?L0V0NDhkejRya2lzWExJZFFQZTRQNTQxRW8valdzODhQVC9rdEdCbTNGdm5C?=
 =?utf-8?B?MFJ1ZE1GeTJyZXNyUUxrN0Y5WXF3ei85TUJyckpmd1hqcGxWTmdiSVVYc0J5?=
 =?utf-8?B?STU0R1dKZ2ZRbnhPZFF1eENuMmRRM0ZYTGdlVkZSUjByZUV3amFMZFJ0aER1?=
 =?utf-8?B?UlNyN1dkYTgxYmx6S2FsWkVWaE5iSGc0Q2dRWFZWUkdkd0s3c2swZ2d2VVdm?=
 =?utf-8?B?dlQ3SnhKc0kwa1FwRm40NnY3R2d5bTBnUGdadVU0cGZ1RFk5MVZBTHJmOFBn?=
 =?utf-8?B?YlBPa0RwL1F3ZHEyMWEyQ2VRNXNDTU8vWG0vRWR3b2F5THZwQjJ1b2w1dXJr?=
 =?utf-8?B?dU5CRVVra29PQjJwOW9tMWQwS0x0K3RxWVZLcGNKSVpuN3pSdllwWGJmak9a?=
 =?utf-8?B?WE5teHo2SlByazJPbDZuM0kyWEZEeWJHMVB1VWlKOHhOUEtubW91Rk44NE1v?=
 =?utf-8?B?Zy8xMnUwRTArTmxvTkV0ZUZ4SEwvUWdkTjZNcVpZSDhTTzEyY2J1M3lHVjRH?=
 =?utf-8?B?WCtPNlltTXB2VTRVR0YxdnpXTzQrS29nTHNJdURiQ3RrbUFhZW9mS3lFTkNw?=
 =?utf-8?B?djFEVk5URnh1MVVIV09QMW1nV3ZjMkxLVXNQZHVSTFdZZGxZWGc4bGpSaStQ?=
 =?utf-8?B?eEt6K0xKZktoTk9mQktqNmp1bEl4Ymw3dHBqSE9HSTZoSWFncXRJNHdTbzF5?=
 =?utf-8?B?Ykp5V1RPeGpoS3lsR21rVjNSQk1zeHhhcGlPQ2dNeEUwQllWU3NXRUNOTlVB?=
 =?utf-8?B?UDJJSGlyaS9jWVA3TWlGbytaeDl6a3JOMURqZWw3d0poTU1HM0hEZWEvaTB5?=
 =?utf-8?B?Y0xDazU0Q1JVM0NGSW5DcThCYXVDUFVpM0NHOFB5V1pEVjB0MExKQVJka0xk?=
 =?utf-8?B?SVR0aFFNaGFBZnlqQVBMQWx2ZWJwOEJXbWd3dXE3a2EwNk5Dd3NFNnpES1pa?=
 =?utf-8?B?L3FUd0JXMlY5Y1E5cUVBdGFNaGRtZERBb0ZoQUVJOWlYVUtVOGFJNGlEM3lE?=
 =?utf-8?B?UjJvRXMzNnVodmRGc2tXb2pMR3VjRkplSkEwT2syM0F5Qkg3R3hhNHlhNWdw?=
 =?utf-8?B?cWlvbEtJRTFKbnIyNHUvaTZmeFlVSE8yLzhZSVdCVHJMRFJuMUJsenFrS2RC?=
 =?utf-8?B?VWlsMVN1eE03d01QSS9ieitXZUd4RXZtK2hnMnpLREN0Tm9SeXN6Tm04aVB6?=
 =?utf-8?B?ckdkbGc0NHY3T3VFbGNiOEk4L1IxZnp6dUxpWE8wNGxPR2FmdTRoMGRDME1K?=
 =?utf-8?B?RU9jV2d5Y2h1eW1BbUJ0MWNWYVM5dkhDZkxDanRTMGJpcTlTc2dQNHN2Wlds?=
 =?utf-8?B?MnBNNFdPMWk2YTJvWkppLzhERUgvYlpCWWIwSFEvU1V5ZXdxRGIzSy8wcFZn?=
 =?utf-8?B?UC8wNzgrSUFNOTZCbXNjSXRGbHZWUUFTeHRONkx0cTN1eFlqQnQ3R0dwbVhG?=
 =?utf-8?B?d3dIOGNoWUVoV0xNRVhKZFVMSk9YdzBhV3M0VW8zU014NWdhMDBnZz09?=
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=SHA1; boundary="----=_NextPart_000_015B_01DCF8D7.DCCFB850"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75553735-ae20-474d-f659-08dec6c0e853
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 07:21:36.6867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNdfoA8ElCUGFQNwp3UszQPsMWgrTIsSaxsitux8NLLZPX4WfeDGWEj9R+q4MHtLbgcn3vng0iMwzv6oqQ8DSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329
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

------=_NextPart_000_015B_01DCF8D7.DCCFB850
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

HI Richard,

A Pull request for marking region0 as secure in OP-TEE is raised here: =
https://github.com/OP-TEE/optee_os/pull/7838

Regards,
Sahil Malhotra

> -----Original Message-----
> From: Richard Weinberger <richard@sigma-star.at>
> Sent: 09 June 2026 15:46
> To: Sahil Malhotra <sahil.malhotra@nxp.com>; Ye Li (OSS)
> <ye.li@oss.nxp.com>
> Cc: U-Boot Mailing List <u-boot@lists.denx.de>; Alice Guo
> <alice.guo@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> upstream+uboot@sigma-star.at; Ye Li <ye.li@nxp.com>
> Subject: [EXT] Re: TZASC misconfiguration on i.mx8m
>=20
> Caution: This is an external email. Please take care when clicking =
links or
> opening attachments. When in doubt, report the message using the =
'Report
> this email' button
>=20
>=20
> On Dienstag, 9. Juni 2026 12:12 Ye Li wrote:
> > >> Why can't this optee patch apply to optee upstream? It is optee
> > >> using secure memory, then it should be optee's responsibility to
> > >> configure trustzone correctly. Optee can't depends on default =
value
> > >> of trustzone, since trustzone is not enabled by optee.
> > >
> > > Sorry for the harsh words, but that's *your* job at NXP to sort =
out.
> > > You seem to ignore upstream.
> > >
> > I'm not working in optee. As I mentioned early, NXP has decided to =
fix
> > it in optee. That's what you find the patch in NXP downstream tree. =
I
> > think Sahil will try to upstream it later.
>=20
> Ok! :)
> Maybe Sahil can shed light on the issue.
> I find it kinda odd that NXP is only focusing on their tree despite =
the upstream
> solution.
>=20
> Thanks,
> //richard
>=20
> --
> =E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | =
Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
> ATU 66964118 | FN: 374287y
>=20


------=_NextPart_000_015B_01DCF8D7.DCCFB850
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImbTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQD5LkFanwXxIroIIglsPu3ltIXx6xtFs2uP/LK9jocFjB6orMCaF+JBc+ejUdJsL9bk
VvswHSZpoku2Jk8oGUzPz0Mid0Xm7vjPly1yJiAB8NMHcT0luDFAyERcF14E3WNhFgJa2fR14kd2
oPAhAClvIpbzdLz7Z86N4fCpDh3UsRIGLl1srk072/9NzkJy9NuSB9/WV+gpOuOT26gRuvLvJwYl
CuFRxCNkcO5sIoFh+tCf9CMZEfUhogv4w9M5MKtg8mriP6KN+gzZX5FuRFclkz8eL6JMOWJLqvLY
xO4pEktrEN2r736MXA30ywO8tfReRpMtHukNUNkNiRZlVcidAgMBAAGjggOVMIIDkTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFG/5AJJ0NqmGczL1seeicOsG5iQ5MEkGA1UdEQRCMECgJgYKKwYBBAGCNxQCA6AYDBZz
YWhpbC5tYWxob3RyYUBueHAuY29tgRZzYWhpbC5tYWxob3RyYUBueHAuY29tMB8GA1UdIwQYMBaA
FOUyevRmwUeWJH/8J4A5WN8rF+K7MIIBSgYDVR0fBIIBQTCCAT0wggE5oIIBNaCCATGGgchsZGFw
Oi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDQsQ049bmxhbXNwa2kwMDA0LENOPUNEUCxD
Tj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERD
PXdiaSxEQz1ueHAsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RD
bGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIYxaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQ
LUVudGVycHJpc2UtQ0E0LmNybIYxaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwvTlhQLUVudGVy
cHJpc2UtQ0E0LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8v
L0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDQsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNl
cnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/
Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYI
KwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E0
LmNlcjA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiFgsB+gY70VYbthTiC65lLmpJWP4TGzVyC
5Y1+AgFkAgFBMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDQYJKoZI
hvcNAQELBQADggEBADtv6vY/EF9jRlcUiuRjuZRT0Mxv8uYyXhSMjTimnK7l2q9JoU36RBgbqWmG
4YpBR8EtKu70TxYbp9cthrGIZnTk3Pe+kEBdEXTNo6XHUoTqw/GuMVvGKwSX58hcW23fZZXnuBjS
+rpmQv/nk03pvJEUJ4EiSsogha4EELUjA5h0yATvS99S+5u1StWQcUyhkSjAIha/xAE1DlQvgcJA
gYfLj9ieFE6Wso0bH7QioEtOKgPcpcpQF3wkeecDqs7pb0/kWR9+fn2MazIUC5KMi2Fd0ZDvUYTI
7HC7ZMLEZaRZnIl/7OfhUoafXlviJN+acLSQTr2nPIS5edQmswhQ4NMwggfzMIIG26ADAgECAhMt
AAxsfgIPlZGW1ZMjAAEADGx+MA0GCSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcNMjQwNjEz
MDgyMTQ4WhcNMjYwNjEzMDgyMTQ4WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYDVQQLEwJJ
TjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8GA1UEAxMI
bnhhMTk3MTMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDda6/e2s+RcZYsmpH9m+Zc
GfCC/TPSYaRA1t/vXCKtgcVlZE9BBV/DRwlDXQf9QDPdaIfIsgBBmW11gGLvY2OWh+qqK7O16uoh
6Mqf0P3H6bjBNku1c4YDGFT4EMlCZeKcA20Od3i9M0s9tdYtA7fBrbbnQPioJ+9MvqQq8T/y8T9b
3RYMu4dTRgGycJDKpwH7QUregV1uyU8h3QuK6b9FrCsqxYW6TzdZvdVjapgQh40db1mXYl6cAJFF
zZWWJYHHOQ25gvHQ+4fLihKPDliaqn2IjAZZqghiM/2CQNZgFal8ITlWnmSx85+4Z+tn1mDADev6
DxgPUWtS49KVTpv9AgMBAAGjggQSMIIEDjA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiFgsB+
gY70VYbthTiC65lLmpJWP4G3gjyD7YcyAgFkAgFCMBMGA1UdJQQMMAoGCCsGAQUFBwMEMA4GA1Ud
DwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUHAwQwgZQG
CSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFlAwQBFjAL
BglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAKBggqhkiG9w0DBzAHBgUrDgMC
BzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMB0GA1UdDgQWBBT/Qpzga+TybvqNgBph
A/pLTskSQzBJBgNVHREEQjBAoCYGCisGAQQBgjcUAgOgGAwWc2FoaWwubWFsaG90cmFAbnhwLmNv
bYEWc2FoaWwubWFsaG90cmFAbnhwLmNvbTAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
WPzYks2h+I85wYfgOdAHut68AOHVbYsbcJfODUzXJeMLrJEnmKrCjzHVa+PWAHAAbGT9om7EbjtG
sQFCtRWrFhU+ATbM/XrYIJamCNbr4UrFwXs5cPH5rxv4jUldgRB8QPz2QbhncdpecDX79NaaYCg8
SLJq44nRy/4I/7KtuydnleiLGlFZ3ejK7r3sCKWN6oWjhNHeA6ooh25loSnqRVXQETpxubR5hlV/
VVC2VR7pxgz+ln8dBGIJwVlfQat3oIy5Iyqh7UkFArBsb+XrFOQFhFRrvB7jopEPUu4MNHxNheLb
O4BsV5paaqNuEeqg2dTDsPllyAXj4UjwJpliQzGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNO
WFAgRW50ZXJwcmlzZSBDQSA0MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNV
BAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3di
aTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwC
Ez8ACCOH5re/fZ6g1kcABQAII4cwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNjEwMDcyMTMyWjAjBgkqhkiG9w0BCQQxFgQUwo13Le+0
OxeKIeGXpqCi/9yqXsIwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsG
AQQBgjcQBDGB0TCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwC
SVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3Jk
LUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJ
kiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAxsfgIPlZGW1ZMjAAEADGx+MIHhBgsqhkiG
9w0BCRACCzGB0aCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwC
SVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3Jk
LUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJ
kiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAxsfgIPlZGW1ZMjAAEADGx+MA0GCSqGSIb3
DQEBAQUABIIBAON64nrsuP1a9/dFq+vfuyVySiah82wyIok8q1xTNDt5CxAl/Gxz5Z+43QBfxeP3
zmDjR0l+kDYevC+TW+b+8VL2VyNWzYdiA4eCoQC3oEyJEnactaivSK7+P6Qqfn3/8AqgdtOZVIql
mdotDqpKwGB41JAOfBRzZ4vc0NLn4jYc4xocnt0Rw3ekYM/8yE2VDIVk2aLj98knsbAYXA5jfeNT
u2sVHH4MHB0emkT10Zmwm5pzM8a04riWm03giBtX5bbDxcjSrT/HfEoAJX0yO9Pk28xXMS/sxHQk
gS1a3YItnH2miDFQwX2LXpSOrIwfMLNXF5UgbRVpviPpUrF5sb8AAAAAAAA=

------=_NextPart_000_015B_01DCF8D7.DCCFB850--
