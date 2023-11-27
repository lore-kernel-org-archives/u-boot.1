Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89033C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 12:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B2787534;
	Mon, 27 Nov 2023 13:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="nhA+K9Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5B387515; Mon, 27 Nov 2023 11:45:15 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912318752E
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Matthias.Winker@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj8PZmu3nn+pbHCWxIHXSKNK6yMcqPp7/FEF01ZXzgQfrBCr5enyPsBXDd1KFwwf2QqKIpN+aBtH3jiO0kJjTdaiINYXRutUKOtBcrbnILCaB7O5/akn1AMyN39z58tTJTPWJgUOVx/yFpbhUdFTz6zqU5uqfHNcenRpyyV3RlG092b9gosZkRHXWMUORoS8z7C37fHa8zNzWw4LsN/r90w9G3HZ1lpQFfFYdYNm40ivjjgObSEz5hWWGuIYQAth60FVt974+PNP3mnSi5OyDjGJSTeE11EkbcwHAVKF2A4py/FagZL6qiqNKm83YcHP4jzXEX3hWny0lNYMDdPT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvAXcbkCJAicwe+p9V4OfDN/TRVyp/fTtU+G7rhIk00=;
 b=l6hYmEWGzkLsc0pk0igQU4y3s1r5avdzM3Q68KEd9coAR7ztO7T4yr9I/7R7kDxvXSSMwLYbtpkaS0TLPWbTfZDcHZ9yMrF6zJN6aNBBsqMOz9ScwD1odJDFtjCTaudG04b9NlRTAbADs2jLo3vPTsgCPrVJDeJeftvqCNiougQTVZITKIUXV610KnqyNTI0B1sa/kpUvWHv+IykNBctDTPtobYb0ZR92MFteCN1Z2rZjIQRY5SUWxzr/OZzTF4PuhaONRDbfEUNcwCAK8+pZg8alFnXPQik4f7XYPo9GIrrOyxla/AiwdwR1ja2OMF3WjigMy4fL/OMyL+VwHJ5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvAXcbkCJAicwe+p9V4OfDN/TRVyp/fTtU+G7rhIk00=;
 b=nhA+K9YrLjfVGNBfdw0TxwEF6DpbEEIMbA0lYVHSsGXg+b3N///YrT2RjXo+8cUGlWEdRYlLgLPC6kmJAgumzR5iudxM94FJIsHezunvwu4kyG2PuU9WYCqY1C6zUGX9R+82GtmxcHM7jNiS7Az12bQt1/sQNpOKFrYKg6RfkcaEAp84g3RUb8Ns5RS5W1jTYL3FvD5kQdNnVzt3s7/l4r3KccPjMtTSwjhkdpYSvWXf+mlMhppogkb8Qqv54o0p27lodGa9MxbtVsxoVXRa5p7TlB62mywwjfVEA1xhTjG2sVSKP2mVfZSfNXOYu4AzJR+j8zUtF674F9vvuYIehw==
Received: from PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:214::13)
 by DB4PR10MB7039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:45:11 +0000
Received: from PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9e6:29d5:b021:6785]) by PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9e6:29d5:b021:6785%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 10:45:10 +0000
From: "Winker Matthias (HC-CW/ENG-PJM)" <Matthias.Winker@de.bosch.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Philip Oberfichtner <pro@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: Re: [PATCH] boards: Disable NET on platforms without NETDEVICES
Thread-Topic: [PATCH] boards: Disable NET on platforms without NETDEVICES
Thread-Index: AQHaH/AUO+MMtwC9vkeXKuDL8h6uorCN/PNd
Date: Mon, 27 Nov 2023 10:45:10 +0000
Message-ID: <PAXPR10MB50858692C89D451A7A18F7E4D2BDA@PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM>
References: <20231117154757.777827-1-trini@konsulko.com>
 <20231125223809.GW2513409@bill-the-cat>
In-Reply-To: <20231125223809.GW2513409@bill-the-cat>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5085:EE_|DB4PR10MB7039:EE_
x-ms-office365-filtering-correlation-id: 9a652018-fc59-4980-38cc-08dbef35ee11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZUScIBHySY+lEKNZ28DnFg05IAcZLelCHwQ3T0OUBtREtOBTHDU7T6sq1aInkroxBfo71vnaR42Tqj029UGL9YyM673ywrGqcbJMinFKfO7csH2GobhBrj6xMzrgpM7Orylj1baLfNrXA1lCNVumeZf2+3Gi46k8yG5CxT5WBbM0z30LyzkXYoTBWzZN9Vwbirn1I/AAjByDKjPIg7+A0TdKDo9tCvqjAdfQD7oryRQQQCE41VNsC5sqF+aPWSnLootZXrAFhOJATFXUnqXLCdN7RMMhw5VKOvWKQw6Tokdy9Q+GIiYmDz6UpYeBYf3VEhE6URbFwU1DeWi5NZ5+9pekXd81OcLPJ0oKSKRejYROlwi7Im7bQN3M0WqltES4IpVeSDjHYzmsmUIXypJtlpXyGzhDDw8hIXxh1ULMyBLLzWNrfp4HpXQwaDHocfCwOClgkPwNxpJITPAHuE9rRRXGTpnWvde9XIwCNZjDN4chG0lA2xUcrJDxI3hQXhultr7147MpRVm71NWiRc6URFLKNysnwbiuRIPMSU8c4w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(38100700002)(99936003)(122000001)(66574015)(4326008)(8936002)(8676002)(52536014)(82960400001)(9686003)(7696005)(6506007)(71200400001)(45080400002)(55016003)(66946007)(76116006)(316002)(66556008)(110136005)(166002)(64756008)(54906003)(66446008)(66476007)(7416002)(86362001)(5660300002)(478600001)(41300700001)(33656002)(2906002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?a3duEEmKNJgUmQjTK9qIATZEz0Z1TttXjPgo7nxIRB7v5KMx9gh8pDnF?=
 =?Windows-1252?Q?MZoRz02oYPFTCnKbKC3BxX9Iot27QXHGGtfwne53urWkggCM8HmRpriS?=
 =?Windows-1252?Q?t1P96bdsn2zA4oSfCE8jQ+RvceVbBHzqfRXo9FpnW/hwNZCHSHI2snmw?=
 =?Windows-1252?Q?k9njpQ/DpeLvrvKPC4LrVEn/qWH2FYAxo70o7/7iYHW+T+XMTbJhwQye?=
 =?Windows-1252?Q?HUd5nwV3loo0Ytxg1/Jwrp/nXFEkLnBFMQ/BsaHrBWl2DbI7CGf/7oEu?=
 =?Windows-1252?Q?GAiBRLyNdjlYw4HaPhtDzQ0hdFD2C3+HxBUCp3QNoNc19GoXwkDqd25C?=
 =?Windows-1252?Q?M1/OWQd1uZfFspNkYjET+cJ+OOtsPbxerlrG2WOITWlFj0QDtR1uDmnO?=
 =?Windows-1252?Q?ucaNfCOS0FFwgwYJVqQIdOgb3GEH7VJjqBp0IRXRdi3fDq/X2G6Qj7ao?=
 =?Windows-1252?Q?Fb8CSahS0zRip1lEVeSgYLgy1x8ixjAe+zETbl3tEOAxoa/tg0lNKWWA?=
 =?Windows-1252?Q?475Q/wfW2F9b/IG1KxOrcHakPrAjGRjBn7J/xq3l5yw59aLlze4m6fcM?=
 =?Windows-1252?Q?6qH2i8/7wEmz/aFPWRsykofREBW4psfzeGaPOWTRSxVIzcr586x/MElX?=
 =?Windows-1252?Q?PuVOaXQ05At7kYJjeckppO+HeE/7psVsfe/WDTUVICsWhZfnILXAOWtU?=
 =?Windows-1252?Q?oZGpnyUKy/zRXdF7UI7frSPXGKO/x7JKtHv5XJLZQl+zO78TVc9s3Vsn?=
 =?Windows-1252?Q?wUfbwdiFIbPLFQ7IoAkLBZfuEAuOtM6utoOR3DjARpLpj/KoefViDxnS?=
 =?Windows-1252?Q?JF4NTL0gYjiQpHyoWd3Nu1MHotjKFhWTrYvPI4m86FsMtq/xz5J3rzZQ?=
 =?Windows-1252?Q?8+6aegP/2pVCaIEGlQnrhPgwU/3g26iG4co14g46wF8o8EXcu61TlJLe?=
 =?Windows-1252?Q?2+52JxYOXTE0PWnGzCIZ0VSn2OcO8gxRt+uN0wqJG1PXgYnB0cjy62B/?=
 =?Windows-1252?Q?V00nfidIv+cpLJk8mRwi4oiCWxCh74Qh8YuFJMZLwM6VtLwH6i0SogpJ?=
 =?Windows-1252?Q?LTaREY/wVs6wpZzehRXFVAqdSrHOL0SoeIp5+1yhDRQpBmBEfLhwWtxi?=
 =?Windows-1252?Q?uEM/2C0D/XSIyhOXEnul7IYSmqyWvWG/U/1i1tYcZ2PkqWNJ24SsXYqy?=
 =?Windows-1252?Q?+4vQGy1G2CHlr7VETHUc8aiaQrPvoKqHXV1bV8ca29Kx7jnSfd1M7DL1?=
 =?Windows-1252?Q?aa0ZXdK8EIz0PuPBkowq9UTfTw6nX2zR3EXYeDecGqF7EPknHhWHMYZy?=
 =?Windows-1252?Q?gp5nQxMmIms/g2fFeZbls4a5SpZpj1PQR1Bs7lQpDiH6kNu93s2smXZ9?=
 =?Windows-1252?Q?zetragA/KQcQ2VWQ5hFUrh2p9hEifR08SsVFSmG6KrQm9X6e0mEJzhLA?=
 =?Windows-1252?Q?Kxzw6X8+sB2kWb0VkGzLJ3X9kaopqxby90uL0Iq4oB6eUVpmMIwJ0Adm?=
 =?Windows-1252?Q?wZppTIFjykBbcB2NwW5dL8GO0FZSw9+SESkcg3lQ/DGk8k7tMYNa96Kv?=
 =?Windows-1252?Q?1mg++ny87Q+C64eRspLbwGCJHFXDgtt/bcBQ0sw63tIBtCqELt+kPEJ7?=
 =?Windows-1252?Q?sgNjhTdgVWZOFqzjkMCZFRApzk1msza8dAFiSXpzqeV0c5zy9ANhpz4L?=
 =?Windows-1252?Q?HvTsEPwq5ZZoBT9vKI1Gb0lBfDTQEn8cdPL29Lo55lxKlE80kcISoFDT?=
 =?Windows-1252?Q?WcVLQWB+/z1IHvULRk74XOFFzSd3i1UbIIDx27ne?=
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg="sha256"; 
 boundary="_00A04803-257F-DE49-922B-869059F01555_"
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a652018-fc59-4980-38cc-08dbef35ee11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 10:45:10.8855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isddq/ye9NsLge68FEQgQWU7wUAEyJi5AR1J7kb9J1Dd8jmEPtsM/myGA1Msg4mEXvTX5b0qQm0musXxCevMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7039
X-Mailman-Approved-At: Mon, 27 Nov 2023 13:25:57 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

--_00A04803-257F-DE49-922B-869059F01555_
Content-type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCGw4w
ggaYMIIFgKADAgECAgRdJqOnMA0GCSqGSIb3DQEBCwUAMFExEzARBgoJkiaJk/IsZAEZFgNjb20x
FTATBgoJkiaJk/IsZAEZFgVCb3NjaDEMMAoGA1UEAxMDUEtJMRUwEwYDVQQDEwxCb3NjaC1DQTEt
REUwHhcNMjIxMjE5MTYxMzU5WhcNMjUwNTEyMTAxODEwWjCBiTETMBEGCgmSJomT8ixkARkWA2Nv
bTEVMBMGCgmSJomT8ixkARkWBWJvc2NoMQwwCgYDVQQDEwNwa2kxDjAMBgNVBAMTBUJPU0NIMQsw
CQYDVQQDEwJERTEKMAgGA1UEAxMBTTEKMAgGA1UEAxMBQTEYMBYGA1UEAxMPTWF0dGhpYXMuV2lu
a2VyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1qgVrsSucu+4hK55nJNvquwECm8K
NRBh/UQdSLYcVEFF2GVgQtnz2DwnwExqZferLByBx8uXtFSH0T2wQpKPdHQLYIQtyrYndfOYOz70
D0gOrHo8udHAA7JDsKQCBHUiKGtjHTH+r7l8wgh5nneb15eW868kvPp1HhrpHvt9ZZqFTxzwlBxH
CNTWdRFl6y52Q+x97Ieh9QI4uDUL4Qpm9iUmEoH8JF3luGg744oAto5om7z/OtEXgY10rklVIIXO
b+cSCJKdzYa9HNmf9Ue91zHaXokJmHXs8EI61LbPu3bvEfbgiiCvgnSOuSU11oNfa7xiqhrXgnPt
3Z7jWWH+jwIDAQABo4IDPTCCAzkwCwYDVR0PBAQDAgUgMB4GA1UdJQQXMBUGCCsGAQUFBwMEBgkr
BgEEAZURBQEwggFGBgNVHSAEggE9MIIBOTCCATUGDSsGAQQBqUaDfQECAQEwggEiMCwGCCsGAQUF
BwIBFiBodHRwOi8vdHJ1c3RjZW50ZXIuYm9zY2guY29tL2NwczCB8QYIKwYBBQUHAgIwgeQageFU
aGUgQm9zY2ggQ2VydGlmaWNhdGlvbiBQcmFjdGljZSBTdGF0ZW1lbnQgKENQUykgYXZhaWxhYmxl
IGF0IGh0dHA6Ly90cnVzdGNlbnRlci5ib3NjaC5jb20vY3BzIGlzIGhlcmVieSBpbmNvcnBvcmF0
ZWQgaW50byB5b3VyIHVzZSBvciByZWxpYW5jZSBvbiB0aGlzIENlcnRpZmljYXRlLiBUaGlzIENQ
UyBjb250YWlucyBsaW1pdGF0aW9ucyBvbiB3YXJyYW50aWVzIGFuZCBsaWFiaWxpdGllcy4wJwYD
VR0RBCAwHoEcTWF0dGhpYXMuV2lua2VyQGRlLmJvc2NoLmNvbTCCAS8GA1UdHwSCASYwggEiMGug
aaBnpGUwYzETMBEGCgmSJomT8ixkARkWA2NvbTEVMBMGCgmSJomT8ixkARkWBUJvc2NoMQwwCgYD
VQQDEwNQS0kxFTATBgNVBAMTDEJvc2NoLUNBMS1ERTEQMA4GA1UEAxMHQ1JMNDAwNDCBsqCBr6CB
rIZmbGRhcDovL2Jvc2NoLmNvbS9jbj1XaW5Db21iaW5lZDIsY249Qm9zY2gtQ0ExLURFLGNuPVBL
SSxkYz1Cb3NjaCxkYz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlhkJodHRwOi8v
dHJ1c3RjZW50ZXIuYm9zY2guY29tL0NSTC9ib3NjaC1jYTEtZGVfcGtpX2NvbV9jcmxmaWxlMi5j
cmwwHwYDVR0jBBgwFoAU3gTizIkI/XWM2KQwMdgQbeWh9JswHQYDVR0OBBYEFPtj6i4keD3sbBzx
49qm2hxh0WD0MAkGA1UdEwQCMAAwGQYJKoZIhvZ9B0EABAwwChsEVjguMgMCBLAwDQYJKoZIhvcN
AQELBQADggEBACnstm2EF7pRSe8jgPhBTrW/VKTbO2opSHBBau5GeTyeBFMTnn9M0qeZT8u+T1Iw
XCptLI7xiheDysmVTpjiE10HJzy2BzuMR4i7penqE5VvI7rw2WSJr8zp/4UwDOz2OzZ/VB8Jrvtn
uhGqaV5hMgg5wOf6VaM8zBXvRmQyppUN3gmN0s/c761igjeTAYcL5Ga4niZbLkFxHy2hmySjytJ4
wpWFoyP7Q2ILpT5NhDJKp6eQAwGxO9KKzLMYx11hjfuJeUFcScCCoG50uElajCVe7VrFPp2mUrnR
EOv5NyJs95Dy2w8KXKxFZxtbH0hsNHcGWoBPYi/VF7tFFUeO9Z4wggaYMIIFgKADAgECAgRdJqOn
MA0GCSqGSIb3DQEBCwUAMFExEzARBgoJkiaJk/IsZAEZFgNjb20xFTATBgoJkiaJk/IsZAEZFgVC
b3NjaDEMMAoGA1UEAxMDUEtJMRUwEwYDVQQDEwxCb3NjaC1DQTEtREUwHhcNMjIxMjE5MTYxMzU5
WhcNMjUwNTEyMTAxODEwWjCBiTETMBEGCgmSJomT8ixkARkWA2NvbTEVMBMGCgmSJomT8ixkARkW
BWJvc2NoMQwwCgYDVQQDEwNwa2kxDjAMBgNVBAMTBUJPU0NIMQswCQYDVQQDEwJERTEKMAgGA1UE
AxMBTTEKMAgGA1UEAxMBQTEYMBYGA1UEAxMPTWF0dGhpYXMuV2lua2VyMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA1qgVrsSucu+4hK55nJNvquwECm8KNRBh/UQdSLYcVEFF2GVgQtnz
2DwnwExqZferLByBx8uXtFSH0T2wQpKPdHQLYIQtyrYndfOYOz70D0gOrHo8udHAA7JDsKQCBHUi
KGtjHTH+r7l8wgh5nneb15eW868kvPp1HhrpHvt9ZZqFTxzwlBxHCNTWdRFl6y52Q+x97Ieh9QI4
uDUL4Qpm9iUmEoH8JF3luGg744oAto5om7z/OtEXgY10rklVIIXOb+cSCJKdzYa9HNmf9Ue91zHa
XokJmHXs8EI61LbPu3bvEfbgiiCvgnSOuSU11oNfa7xiqhrXgnPt3Z7jWWH+jwIDAQABo4IDPTCC
AzkwCwYDVR0PBAQDAgUgMB4GA1UdJQQXMBUGCCsGAQUFBwMEBgkrBgEEAZURBQEwggFGBgNVHSAE
ggE9MIIBOTCCATUGDSsGAQQBqUaDfQECAQEwggEiMCwGCCsGAQUFBwIBFiBodHRwOi8vdHJ1c3Rj
ZW50ZXIuYm9zY2guY29tL2NwczCB8QYIKwYBBQUHAgIwgeQageFUaGUgQm9zY2ggQ2VydGlmaWNh
dGlvbiBQcmFjdGljZSBTdGF0ZW1lbnQgKENQUykgYXZhaWxhYmxlIGF0IGh0dHA6Ly90cnVzdGNl
bnRlci5ib3NjaC5jb20vY3BzIGlzIGhlcmVieSBpbmNvcnBvcmF0ZWQgaW50byB5b3VyIHVzZSBv
ciByZWxpYW5jZSBvbiB0aGlzIENlcnRpZmljYXRlLiBUaGlzIENQUyBjb250YWlucyBsaW1pdGF0
aW9ucyBvbiB3YXJyYW50aWVzIGFuZCBsaWFiaWxpdGllcy4wJwYDVR0RBCAwHoEcTWF0dGhpYXMu
V2lua2VyQGRlLmJvc2NoLmNvbTCCAS8GA1UdHwSCASYwggEiMGugaaBnpGUwYzETMBEGCgmSJomT
8ixkARkWA2NvbTEVMBMGCgmSJomT8ixkARkWBUJvc2NoMQwwCgYDVQQDEwNQS0kxFTATBgNVBAMT
DEJvc2NoLUNBMS1ERTEQMA4GA1UEAxMHQ1JMNDAwNDCBsqCBr6CBrIZmbGRhcDovL2Jvc2NoLmNv
bS9jbj1XaW5Db21iaW5lZDIsY249Qm9zY2gtQ0ExLURFLGNuPVBLSSxkYz1Cb3NjaCxkYz1jb20/
Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlhkJodHRwOi8vdHJ1c3RjZW50ZXIuYm9zY2gu
Y29tL0NSTC9ib3NjaC1jYTEtZGVfcGtpX2NvbV9jcmxmaWxlMi5jcmwwHwYDVR0jBBgwFoAU3gTi
zIkI/XWM2KQwMdgQbeWh9JswHQYDVR0OBBYEFPtj6i4keD3sbBzx49qm2hxh0WD0MAkGA1UdEwQC
MAAwGQYJKoZIhvZ9B0EABAwwChsEVjguMgMCBLAwDQYJKoZIhvcNAQELBQADggEBACnstm2EF7pR
Se8jgPhBTrW/VKTbO2opSHBBau5GeTyeBFMTnn9M0qeZT8u+T1IwXCptLI7xiheDysmVTpjiE10H
Jzy2BzuMR4i7penqE5VvI7rw2WSJr8zp/4UwDOz2OzZ/VB8JrvtnuhGqaV5hMgg5wOf6VaM8zBXv
RmQyppUN3gmN0s/c761igjeTAYcL5Ga4niZbLkFxHy2hmySjytJ4wpWFoyP7Q2ILpT5NhDJKp6eQ
AwGxO9KKzLMYx11hjfuJeUFcScCCoG50uElajCVe7VrFPp2mUrnREOv5NyJs95Dy2w8KXKxFZxtb
H0hsNHcGWoBPYi/VF7tFFUeO9Z4wggbnMIIFz6ADAgECAgRdJqPYMA0GCSqGSIb3DQEBCwUAMFEx
EzARBgoJkiaJk/IsZAEZFgNjb20xFTATBgoJkiaJk/IsZAEZFgVCb3NjaDEMMAoGA1UEAxMDUEtJ
MRUwEwYDVQQDEwxCb3NjaC1DQTEtREUwHhcNMjIxMjE5MjAzMjMyWhcNMjUwNTEyMTAxODEwWjCB
iTETMBEGCgmSJomT8ixkARkWA2NvbTEVMBMGCgmSJomT8ixkARkWBWJvc2NoMQwwCgYDVQQDEwNw
a2kxDjAMBgNVBAMTBUJPU0NIMQswCQYDVQQDEwJERTEKMAgGA1UEAxMBTTEKMAgGA1UEAxMBQTEY
MBYGA1UEAxMPTWF0dGhpYXMuV2lua2VyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
9pvF+LhWtOJ61ltQesPgLuduYYIEXHSVnvIVuQZW/GFWbEE9fUb0ciE7saqrpCVdvj+gAybLCE4V
c65I/1cttbgWTQGGqPzzk4mFz7jBEa6KmRXhwkTbHVmue2npe8A0S9wbgMqIe+I7nTP6PJhXlwvp
U5Mm1XZJcdHyjtaJjiSgOurYyXVodlvOLs+Ta9ZVR7eNYwyWbVRi7zVu1yl2tQdULd7dWNpjlrUk
XZNL2QI4TahxinChm4ZlAdgTMZsrZMFt5LQHKEjGPE7I4QR8tnPXViF0u8PS2kBrUPQn52KkXSUO
7aFmIKbH/kQil11PWVrWoMyl1dhUldOBBybN+wIDAQABo4IDjDCCA4gwCwYDVR0PBAQDAgeAMB0G
A1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDCCAUYGA1UdIASCAT0wggE5MIIBNQYNKwYBBAGp
RoN9AQIBATCCASIwLAYIKwYBBQUHAgEWIGh0dHA6Ly90cnVzdGNlbnRlci5ib3NjaC5jb20vY3Bz
MIHxBggrBgEFBQcCAjCB5BqB4VRoZSBCb3NjaCBDZXJ0aWZpY2F0aW9uIFByYWN0aWNlIFN0YXRl
bWVudCAoQ1BTKSBhdmFpbGFibGUgYXQgaHR0cDovL3RydXN0Y2VudGVyLmJvc2NoLmNvbS9jcHMg
aXMgaGVyZWJ5IGluY29ycG9yYXRlZCBpbnRvIHlvdXIgdXNlIG9yIHJlbGlhbmNlIG9uIHRoaXMg
Q2VydGlmaWNhdGUuIFRoaXMgQ1BTIGNvbnRhaW5zIGxpbWl0YXRpb25zIG9uIHdhcnJhbnRpZXMg
YW5kIGxpYWJpbGl0aWVzLjBKBgNVHREEQzBBgRxNYXR0aGlhcy5XaW5rZXJAZGUuYm9zY2guY29t
oCEGCisGAQQBgjcUAgOgEwwRZXBtMXdhMkBib3NjaC5jb20wggEvBgNVHR8EggEmMIIBIjBroGmg
Z6RlMGMxEzARBgoJkiaJk/IsZAEZFgNjb20xFTATBgoJkiaJk/IsZAEZFgVCb3NjaDEMMAoGA1UE
AxMDUEtJMRUwEwYDVQQDEwxCb3NjaC1DQTEtREUxEDAOBgNVBAMTB0NSTDQwMDQwgbKgga+ggayG
ZmxkYXA6Ly9ib3NjaC5jb20vY249V2luQ29tYmluZWQyLGNuPUJvc2NoLUNBMS1ERSxjbj1QS0ks
ZGM9Qm9zY2gsZGM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYZCaHR0cDovL3Ry
dXN0Y2VudGVyLmJvc2NoLmNvbS9DUkwvYm9zY2gtY2ExLWRlX3BraV9jb21fY3JsZmlsZTIuY3Js
MCsGA1UdEAQkMCKADzIwMjIxMjE5MjAzMjMyWoEPMjAyNTA1MTIxMDE4MTBaMB8GA1UdIwQYMBaA
FN4E4syJCP11jNikMDHYEG3lofSbMB0GA1UdDgQWBBS09WrDvBtK8FlCWK+He7AyUmu51jAJBgNV
HRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjIDAgSwMA0GCSqGSIb3DQEBCwUAA4IBAQCTFiSs
bX+lwTbCORzhsHDpyDzSj+yiBHKitRpBCTzi4GgYt+mcAjL8wTdyFboUYUtXTJnBkicreh/g2wQb
Hjq+pBLG6sJzbOhPf5vcfgGa2ojyPPgQhSNgOI3lMeKv/GBGvDoIyHpGzr2sDuIPpGSbSkZRefDd
AtR8+0Wctz7a/i2cSOSSPfQS2+h0YuiajrGZmSKslRkUQ4B1mM6t7AryqbHmWtiQin2R30P6NKdj
5YxdxItcbdFcd2Iwx5Asg0FKeyjeAfi7GL0j/zUk7F72muCjVaC7VeAb+nuWpOYJlgY/p3eJ5nRU
elCFMEdjDmgZ0EISTPD4yaf+CBN/TQY9MIIG5zCCBc+gAwIBAgIEXSaj2DANBgkqhkiG9w0BAQsF
ADBRMRMwEQYKCZImiZPyLGQBGRYDY29tMRUwEwYKCZImiZPyLGQBGRYFQm9zY2gxDDAKBgNVBAMT
A1BLSTEVMBMGA1UEAxMMQm9zY2gtQ0ExLURFMB4XDTIyMTIxOTIwMzIzMloXDTI1MDUxMjEwMTgx
MFowgYkxEzARBgoJkiaJk/IsZAEZFgNjb20xFTATBgoJkiaJk/IsZAEZFgVib3NjaDEMMAoGA1UE
AxMDcGtpMQ4wDAYDVQQDEwVCT1NDSDELMAkGA1UEAxMCREUxCjAIBgNVBAMTAU0xCjAIBgNVBAMT
AUExGDAWBgNVBAMTD01hdHRoaWFzLldpbmtlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAPabxfi4VrTietZbUHrD4C7nbmGCBFx0lZ7yFbkGVvxhVmxBPX1G9HIhO7Gqq6QlXb4/oAMm
ywhOFXOuSP9XLbW4Fk0Bhqj885OJhc+4wRGuipkV4cJE2x1Zrntp6XvANEvcG4DKiHviO50z+jyY
V5cL6VOTJtV2SXHR8o7WiY4koDrq2Ml1aHZbzi7Pk2vWVUe3jWMMlm1UYu81btcpdrUHVC3e3Vja
Y5a1JF2TS9kCOE2ocYpwoZuGZQHYEzGbK2TBbeS0ByhIxjxOyOEEfLZz11YhdLvD0tpAa1D0J+di
pF0lDu2hZiCmx/5EIpddT1la1qDMpdXYVJXTgQcmzfsCAwEAAaOCA4wwggOIMAsGA1UdDwQEAwIH
gDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwggFGBgNVHSAEggE9MIIBOTCCATUGDSsG
AQQBqUaDfQECAQEwggEiMCwGCCsGAQUFBwIBFiBodHRwOi8vdHJ1c3RjZW50ZXIuYm9zY2guY29t
L2NwczCB8QYIKwYBBQUHAgIwgeQageFUaGUgQm9zY2ggQ2VydGlmaWNhdGlvbiBQcmFjdGljZSBT
dGF0ZW1lbnQgKENQUykgYXZhaWxhYmxlIGF0IGh0dHA6Ly90cnVzdGNlbnRlci5ib3NjaC5jb20v
Y3BzIGlzIGhlcmVieSBpbmNvcnBvcmF0ZWQgaW50byB5b3VyIHVzZSBvciByZWxpYW5jZSBvbiB0
aGlzIENlcnRpZmljYXRlLiBUaGlzIENQUyBjb250YWlucyBsaW1pdGF0aW9ucyBvbiB3YXJyYW50
aWVzIGFuZCBsaWFiaWxpdGllcy4wSgYDVR0RBEMwQYEcTWF0dGhpYXMuV2lua2VyQGRlLmJvc2No
LmNvbaAhBgorBgEEAYI3FAIDoBMMEWVwbTF3YTJAYm9zY2guY29tMIIBLwYDVR0fBIIBJjCCASIw
a6BpoGekZTBjMRMwEQYKCZImiZPyLGQBGRYDY29tMRUwEwYKCZImiZPyLGQBGRYFQm9zY2gxDDAK
BgNVBAMTA1BLSTEVMBMGA1UEAxMMQm9zY2gtQ0ExLURFMRAwDgYDVQQDEwdDUkw0MDA0MIGyoIGv
oIGshmZsZGFwOi8vYm9zY2guY29tL2NuPVdpbkNvbWJpbmVkMixjbj1Cb3NjaC1DQTEtREUsY249
UEtJLGRjPUJvc2NoLGRjPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2WGQmh0dHA6
Ly90cnVzdGNlbnRlci5ib3NjaC5jb20vQ1JML2Jvc2NoLWNhMS1kZV9wa2lfY29tX2NybGZpbGUy
LmNybDArBgNVHRAEJDAigA8yMDIyMTIxOTIwMzIzMlqBDzIwMjUwNTEyMTAxODEwWjAfBgNVHSME
GDAWgBTeBOLMiQj9dYzYpDAx2BBt5aH0mzAdBgNVHQ4EFgQUtPVqw7wbSvBZQlivh3uwMlJrudYw
CQYDVR0TBAIwADAZBgkqhkiG9n0HQQAEDDAKGwRWOC4yAwIEsDANBgkqhkiG9w0BAQsFAAOCAQEA
kxYkrG1/pcE2wjkc4bBw6cg80o/sogRyorUaQQk84uBoGLfpnAIy/ME3chW6FGFLV0yZwZInK3of
4NsEGx46vqQSxurCc2zoT3+b3H4BmtqI8jz4EIUjYDiN5THir/xgRrw6CMh6Rs69rA7iD6Rkm0pG
UXnw3QLUfPtFnLc+2v4tnEjkkj30EtvodGLomo6xmZkirJUZFEOAdZjOrewK8qmx5lrYkIp9kd9D
+jSnY+WMXcSLXG3RXHdiMMeQLINBSnso3gH4uxi9I/81JOxe9prgo1Wgu1XgG/p7lqTmCZYGP6d3
ieZ0VHpQhTBHYw5oGdBCEkzw+Mmn/ggTf00GPTGCAlwwggJYAgEBMFkwUTETMBEGCgmSJomT8ixk
ARkWA2NvbTEVMBMGCgmSJomT8ixkARkWBUJvc2NoMQwwCgYDVQQDEwNQS0kxFTATBgNVBAMTDEJv
c2NoLUNBMS1ERQIEXSaj2DANBglghkgBZQMEAgEFAKCB1TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMzExMjcxMDQ1MDhaMC8GCSqGSIb3DQEJBDEiBCCtOBWyAtSK
+lua/hLK9PXUysJym1mEzI0Q8h19ejp3NjBqBgsqhkiG9w0BCRACCzFboFkwUTETMBEGCgmSJomT
8ixkARkWA2NvbTEVMBMGCgmSJomT8ixkARkWBUJvc2NoMQwwCgYDVQQDEwNQS0kxFTATBgNVBAMT
DEJvc2NoLUNBMS1ERQIEXSajpzANBgkqhkiG9w0BAQEFAASCAQAbiCJm9tkm0rbyvYGUwsPDVAGP
YpvcVXW+pQed9y3LH+jfzPO9zcEmOD22EJzdQ49inDTJqrAQ3yIPS1T49d+ZRh+avaKGDR3HnKyk
3pIglqfP4gAtNwMJyteUnlwNK+ApTsVByY8upmYxaeRGfJz3hBmUBaRyrduoLEM/yAfTS+saNZ3o
JUrSg5BIoQY2V31tKTBS8NwSlrmCcEtulcv0w0NQXmFD18hMQ0leDp+aZi1G+wkmPh8ogiceCeZ5
+P+E0t2TOy+aeGfbAYVftFOjIdIegJ2tBHI4KSIFP+t2MKyDVWtpUYOidI+JLGI42U7daSZzYiQK
RqRKLx9EJP9IAAAAAAAA

--_00A04803-257F-DE49-922B-869059F01555_--
