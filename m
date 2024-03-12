Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E44C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A07187B2A;
	Tue, 12 Mar 2024 21:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="hhZH5NJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B638587C86; Tue, 12 Mar 2024 21:00:29 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A939879A0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9801604792=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CEG5sX018047; Tue, 12 Mar 2024 20:00:21 GMT
Received: from eur02-am0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2233.outbound.protection.outlook.com [104.47.11.233])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wtrnngxhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 20:00:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a///5v0mR0e6GVDjGp3MUCeAv3scAK5svx+yijft03iJmZKwhK2VAVylGF5pgi903RjlEKalyd15gS8anYW6eyiJxJj8EhC8NkeSmuxkxXGVXRMyA2bGw/pHhAbaTiHYKLaSbAwyv4oK5TVW1u+aLZtqcAqm1/RrfnkinBIrlr8556XirEyAT7b0sIHZs2Wwn7hZi/zWorUawpdv78ORPEGPafL2jFfRLTA2oHlILfc4E2tcAL5MSBI4xH6AuSU0aa8jZLxX0f/VnfFG+8Odi9b2Pop4a67DI2+K7L+MgD3X7HDWwVNCBRehBBy7depRwvaU9jL944fCdYh2wzzsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSzplwew+IblskqtmpA75D7hdiEdnxj8yew70Atg1Rg=;
 b=Qxv4ZRkoK2KxvBOfyo+ES+h7rBHtV+GN+qokOggy1SBJ4aq2ya01lF9YdBMOB1XMuY1bKTWzSb0ar+BAlrl4+yHXjQ2XvooVzw5xT06g/hmj1WQ4hmFqEer6vFLVpkVP4Q5Z8IZDvHjvx0GRl07ldL6RirzKo/iQVFJbLTuuGpv+RUSl0ipqH3ZRPWxObX6r02qi2Fr+UAO6hBDrlGUjc96YSaXIC95H8AHXvMLdeEWZHMR0NRTWZ31zJjgVU0qWiFzROB2oXhke8KbVelKqjYHe3+27FjKHGWEWBHY/E1RUuSpLusoTjE02CdaY1MoW2FUlSUaIG1wDB2AoE79VDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSzplwew+IblskqtmpA75D7hdiEdnxj8yew70Atg1Rg=;
 b=hhZH5NJj26gSKN4dABiG0lTQvgRd2auiIXKRhuDBmMuNycC8eb8Jf3+F/GTfSzSpS6dsaEbK7EDm4/wG32JWZZLv7akzeVqi3UTpzOCSNTricbxSJzAKXqDYa7IiaEIM8q+c7+SEbn5DT8Y4CInjG6vwGgq1Tu5hNLfxMf7IJEgPnivW7QLmKDJ/0CkxNRBEOkBmaQCB9JtSdox6euycWdf3Q6hrPK0Ky68LTuIilsEHVrXHHQSDZgqGqLVov6/kVcZQ3FJezOPzVm4wyjZM1vbnZgkAS/g9mZ6kwj829qOfkxYj3ZNBlwRTzfjz1w3wlqlhdoqPb5eO//24nfIruw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU2PR03MB10068.eurprd03.prod.outlook.com
 (2603:10a6:10:49e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:00:18 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 20:00:18 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Sumit Garg <sumit.garg@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/4] clk: qcom: clear div mask before assigning a new
 divider
Thread-Topic: [PATCH v3 2/4] clk: qcom: clear div mask before assigning a new
 divider
Thread-Index: AQHac/vL3GOuVBuOiUq96fqEYfvde7EzxruAgADAIAA=
Date: Tue, 12 Mar 2024 20:00:17 +0000
Message-ID: <87wmq7z0dr.fsf@epam.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
 <20240311213334.3567389-3-volodymyr_babchuk@epam.com>
 <CAFA6WYNTH+GVzm3dqcfUjRd94fAtO6vDj2+8PyjuApmj0_qffg@mail.gmail.com>
In-Reply-To: <CAFA6WYNTH+GVzm3dqcfUjRd94fAtO6vDj2+8PyjuApmj0_qffg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU2PR03MB10068:EE_
x-ms-office365-filtering-correlation-id: 3099a638-2c30-4ca1-41b8-08dc42cf0a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYdzK77wej1/wvdpcDu6Y0qjziNcyfRLbrL1jUppxEK4mfw0QMj4l/B+PbqU1Uo0awg7id1jPg65NkkSpJHQgHmg1dw1XXirhkhWw+zpPylZuYxi4oaKk4OIgLlSbE11Ut+Pq4wHyaLhjMgWlMPatRcDEkbpmWMnvvVuQKw2HJ6YHqOej+ByWAm0Q6u3he1stBHvLcUSDhctj/Y1XksCyw70yf0sJhQYNTtlI+bPt0U+k+vgGs1xfEKxoirhrSS4V7aipC50Y0rBAgXjH8gueB1RW/2NrZWNg4BVpcq159Ns6orwe09JBbMxljSZm3/87TFqywQ4c6ADeq3WPtBJCpGtisSfBiqbtjdD1vSkXW/2L5bdRjW7vds6XsA6LR6E1YSAXhszZCd5u8Mmik+7q8DQsz5cu1dge3KwjOj1ShLhatjflMaGZt+BUG47yw41yQM26ooWJnx+SPq+d0KhqEuV26snzZMEmwxiNcgGoKL81zLDsaKiig5HdMzMBc42DLrkYjaJEhvGTli90qHBd4d9jPbxfUTg8AFbPTr+kTYltMuSpCQLLKqXlH379N5tpreShhn5fCgXdBMg8jZ25HmcmeQcbOHpRrGKrmYMEC0EwBl5ElIH5mlc1GruB8MbszV3S2SRqh6SU+Z4ISvMUFNaJ9SbGq8rpv7kR8Thl/7w/hvTlKxzf2lqBmyadLG+ul/P7pAuCBVLZADNiLrj9du2jsFZBRpMhbzodbpiyfg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/qgT3JDKG21C/hOBFBv3ff53xEVNFq8Lv8Y0u1PAQM/YE/wiFHeapZm4GA?=
 =?iso-8859-1?Q?pcFIzB3IDr3LU6qeeJ5AKQEV2dU5UaNgDkz/TE/k3wGyxI2qvyMJY8Lmju?=
 =?iso-8859-1?Q?i37urxoAIG0p27vXYhaVR+LnrX69tKtavC+YLPmx8oq8zgWWRT9hPMQvtg?=
 =?iso-8859-1?Q?akvfRG4CnQdA+O2lOSb9JoMoB23uABhsd2MkTRvtnOypwQ2KpLui9NECel?=
 =?iso-8859-1?Q?8Qz62QdoXSX6eyooIxkVF2RGk9ZSfiZq8afL9VCUXBJKn7FcIrWGlN2enO?=
 =?iso-8859-1?Q?HMktxeCBQnw7DYtqayz7XM91biDoVEJv2Z0VJCqc6o9yo9MaV1S8a+5AFa?=
 =?iso-8859-1?Q?JQ5MMqtRDRVpW980z0lGxr92GXsu5qUH3hAe+vKng1Utky8bXwkIIPWTcq?=
 =?iso-8859-1?Q?dqnJPsQFXBi/sG948Z5hI2oY+NjaQJioG/7HdfbtCgHTJVDQuOXcS60Im4?=
 =?iso-8859-1?Q?7SpCeeWuJQHvj5JwPZnLpEBGUbyHIfTkx0CwfgDETsPv5HnqxkCvOkWaGQ?=
 =?iso-8859-1?Q?4sfdTAPLIPtHtxmI9d9j3XMsGktyHiEYKz2lspCulHkSz1l7r/uzMDRuC8?=
 =?iso-8859-1?Q?MJahEUXPiXyXBP1AK/jJR7XjLVbtVXlX1VRlkiv6mmfe1171rAgGY78OIs?=
 =?iso-8859-1?Q?PiXSLLvvIKnHW27YlZm5r8EVrc96jKEdtkmOalxO9e3lTMCC06gHAK779j?=
 =?iso-8859-1?Q?X4x37J666O7OgpTEz0TqHGWk4FhI8mapYEkTroqjXWuDVyqBOHQfYdkkie?=
 =?iso-8859-1?Q?38CXFPS54i5dSP+DbjxuP03qMgL6LSGW3o8RgW9enb1EbT9r1Im/hWcPac?=
 =?iso-8859-1?Q?n7BfQ2OKndSKvOToOM2p7m93tm0K3DbIOEDfx9o6PM5GtxAtFkHs7fS8QJ?=
 =?iso-8859-1?Q?kP3HdGhqCv74nFx+ROcCArgVuy2IGZQAf8iciFZbNo/U/tDRrcwFpiefq6?=
 =?iso-8859-1?Q?zcfFzI8Y1rN8seRcxxA9gwL2YfL+PVikcB5THnWX+87sL9OAap/NnPjkVS?=
 =?iso-8859-1?Q?87FK+Qzai+jVCdTTgJnqof5ksCIHJfUno+AAnjcl2lEZUxNCPtH0wpNdPc?=
 =?iso-8859-1?Q?6OLPpU3aO0rabDBUFMyGeB1rkQD6LROe9Waz9Q2BtnUym5qAoFy1LBeGYs?=
 =?iso-8859-1?Q?oa2Kh8gtNjkFGVJKPoNlNGhDYHdYP6wfw46ivo9sAdW7RYgEfGeB0M+Hdc?=
 =?iso-8859-1?Q?SCOKpRP7kESYppU5bF52W+9mckhcaN+axghCNduDr39PPZSAnvaW4eZzK2?=
 =?iso-8859-1?Q?lsf4nXa3ZZrv2noQsHn2HTzb0Fqv3t5QBT2qKvxGl90Q4GMjo7gh2k1E3E?=
 =?iso-8859-1?Q?7Rk1+fh3JDHJH+qAPe8f8a3dg+lS0Ioy9whuyuWP6BFDk5pHtQXdAo+she?=
 =?iso-8859-1?Q?KwMVLhgLenOpxTZXKKka+Z2vqZIVTot8fDtp6sKCIaT2KI7jsu7x6pKeHE?=
 =?iso-8859-1?Q?+HeukSnM1aI8RUsQ+WkII4YvQOKv2aKzGnkHGPWbyRZo8enNTerH3WyFDI?=
 =?iso-8859-1?Q?KPPY4NaVORsrSgEjgi2XwQWt/TL8oiXfSNUnaDwB+Zaah5n/ot5SkOyCgh?=
 =?iso-8859-1?Q?taAVVE6ci+FUds5iz6QkqCMndVQYph5xhUiW/3ye93NrSA/8skHW9qL08D?=
 =?iso-8859-1?Q?x7Qkp6/KpECONzdqch0ebhyCmTYea92nKQIJaQ4gCzq/XIWao48Qylbg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3099a638-2c30-4ca1-41b8-08dc42cf0a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 20:00:17.9315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVLNCOfCmxHD4xwwwYvOua7Ri4tud7Kjlqqam0H2FkMypmatfodqcdTU3kAmEvHqRgfgvfNw8LIUMlNxJfehGjKzM57Bch5PqsbMDP07ekk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB10068
X-Proofpoint-ORIG-GUID: csik9-E30q3TyLvPo74q1_AFN9ltUQOl
X-Proofpoint-GUID: csik9-E30q3TyLvPo74q1_AFN9ltUQOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_12,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=595
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120154
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


Hi Sumit,

Thank you for the review.

Sumit Garg <sumit.garg@linaro.org> writes:

> On Tue, 12 Mar 2024 at 03:03, Volodymyr Babchuk
> <Volodymyr_Babchuk@epam.com> wrote:
>>
>> The current behaviour does a bitwise OR of the previous and new
>> divider values, this is wrong as some bits maybe be set already. We
>
> nit: s/maybe be/maybe/
>

Oops, right. Can this be applied by the committer during the merge
process? I know that committers in other open source project do this
sometimes. Or should I post a new version?

[...]

--=20
WBR, Volodymyr=
