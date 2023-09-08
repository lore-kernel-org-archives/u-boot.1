Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9457EE8006
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A6486B27;
	Fri,  8 Sep 2023 16:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="AOvTpz9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C648D86B55; Fri,  8 Sep 2023 16:02:03 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D05AB86B27
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7615c7331c=etienne.carriere@st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3889lq1J026324; Fri, 8 Sep 2023 16:01:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 STMicroelectronics; bh=h63tQ5rUNeer413OTXkZ6yXYD/xi7aIszk3ANMum4
 30=; b=AOvTpz9W3wFNNZXkQn9szhkk09EnA5Bo8TUpWBNWdto7YL9ymnAE4aqft
 //FRVl8cmS4MKZ7uGYKxaAI3J/NRXTKzpDckOWB1+MtSbUUts3V7UJAEaPRCQ4ry
 pPYCsdBkvQpTYwxB7jjltgq37JVuoRPTSLK85vPwajQBLhdB0pKtQs0L77QTdk5+
 X2ddfAJRoRzY80OQMNpkxKIK+6P6o4IRUB9WEmaJAOMbgeonzSVyLDsThQsQMHi3
 IzOdlpma+Lan28bitjP/itSg5iuZFFzvmjXgo59N9ojN+69qOyrD3pm0OXm5Vap9
 G1BWsV0/59sXllexWncvhs9YBoIVg==
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3svem117jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 16:01:54 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZEQ7nKXUZMojfzOs5NtKgJzRa6+kAcCKhPV6jPMXv3E8GAOBy/04lj0wmKUeKXIxXocQt/2hF/RG99gaQz9VzT4O52GhMkE3rrecdZm9fAtbpRl6DnoE3PZfJ8GFefa5Zqmuag6c7hv9G3m2f8yrcQdUYT3dfq56H5sSY73sWft9DWeJa1uQyzuetkwSrM9LznQakHygOa3SLz/NKaEKX+jQm3IRP/85U2l+l3UnxLGDL44A1ZpIoAI8/IDoPqzfFOl6GuHW2qCdLSOKOtWCNaXkY2L/EaXkK6cLJlo7HTcaCMEYIDIyvZ62bc1gab2bjq3iYenBREfNWdOi4SVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h63tQ5rUNeer413OTXkZ6yXYD/xi7aIszk3ANMum430=;
 b=IKsVAy7qxLEwpFE8o+jvb4rJ0DMAB2SW1YXraNn2f+iMS4gzjwbSuhggn7pkfw3C9aIpfT9QErY7bEwPebzrBX4FT4hE8hSNmNqdC4lEKD/udXjvg4dXsiA/aQO5nJaxLH8gGH1DLQ20H+CeFEmOp/Aacw6WPGad+d8XEdf1sdyAPYBXMieLULoKW8wvwvpztsmktC0S0Bni2er2GudhhuVX+qDjNtlRPwwFY18vBi51G15yhXnwD4lKl6pOcUmBuocIDQ/XHQowVACDC1Q+I9+FMsm/ORFKyIA9KHMSR3y74U0iXIw5D1UUfkxZ3Ao0aHTFUi58gF8I37nSLQnCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by AS8PR10MB6269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 14:01:51 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:01:51 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 01/13] scmi: refactor the code to hide a channel from
 devices
Thread-Topic: [PATCH v3 01/13] scmi: refactor the code to hide a channel from
 devices
Thread-Index: AQHZ4f9/+DZYhSFEtUSB7+xCw76j07AQ1SDE
Date: Fri, 8 Sep 2023 14:01:51 +0000
Message-ID: <PAXPR10MB4687A68026790CD1A8AB43ADFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-2-takahiro.akashi@linaro.org>
In-Reply-To: <20230908025138.44405-2-takahiro.akashi@linaro.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2023-09-08T14:01:50.336Z;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified); MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|AS8PR10MB6269:EE_
x-ms-office365-filtering-correlation-id: 08a62e67-61eb-43c2-ad8c-08dbb074268c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlHv/h5yfZ9jW7su8wkjfZhGKxIwndi7FBIbKXm0a+qvs2cHyPJiJxCSJahx36DmYe1Q23vQtwKNVg/pP4tsOsOIwkRXQhkHKRYfqaPUY+uQi/gZM+cDGDUe9auR9zoiuan+vgXGJaOq/NrxxOYBVDordZQzEgwVFFYLARcFMhQhpMmpevS5XmELZlhRMegm+n+fZdOCwU4c19onWvWZ76LcCCLY0WkQXaqXVkr7WXpR1cNP5/Ll/dWQajqqP6OYkyvq7rdxauZSZcgwn9r2TWxp5VrlI6/HVZ6HfufkCeR/gFu2VSOI3uDGDlsEPVU/t5nJQP23/tr4CGbU2tio4eVyucelznl3fONEL/JSc+nTfU258/RYrODavA5IOMijN5PlbWYer92SHCl6240UkyuKx+D26VDRQNKeD1sI1fScy9JliL2f2DgHp579p7cV5Bt3aNpZ6PdDKdhmYvX14tqV8GHa7Y0sAYgQjdWuTDF/Jbo51gAIxqFcEUYZXRB3q1shHHk2VOKBi4zDAi/czJoHN5no/SoO1AlRKA90Iz/TRdlfpuG4IR6Db6xFe99l4VcfF4NYKKMYSfALD4mORjz7CumCc6TsfecSQjplrsUseKXqKsgSjEe5dJWcTQ5Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(52536014)(110136005)(71200400001)(6506007)(7696005)(9686003)(83380400001)(478600001)(30864003)(26005)(2906002)(64756008)(66946007)(5660300002)(4326008)(66476007)(66556008)(66446008)(316002)(8936002)(76116006)(8676002)(41300700001)(86362001)(38070700005)(33656002)(55016003)(38100700002)(122000001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NoNKEpVcioBR52DN9c8ldjQSTA1cnlo/tUo5byv92s6YIQ5E/f6jXbr9xf?=
 =?iso-8859-1?Q?mt280TN1JfwOJ5inH9emxx86F1HE/wi7tLcRlq/wwqETsR8dDUrskdGhod?=
 =?iso-8859-1?Q?BTdwDPMz80oj/WLShz8i52IUg4c+nbpUcOFxEph0tRZVsd+SJ1GkYBhgOu?=
 =?iso-8859-1?Q?Dv4v0uP78SZNjVvMUBwB1nio5SaMsVtyPA7VUC6yT9TwCrn0xsu3dB/sOT?=
 =?iso-8859-1?Q?Qo4tmxVWnvKeKU8KtKpH0tdBg+5+q32wtiGIza6wugy42xSPnhglcIbyWP?=
 =?iso-8859-1?Q?ayu/GffGvNyS8MX3j+ygHBDVaZBzklPR/SGrWungsFB2HxDWv259BQPuC3?=
 =?iso-8859-1?Q?y6nxVxmbiUwODe8AqeNpt5TlCgqCk9c1+Oy5wMu2MqMSTvpnOazV7Y6L1M?=
 =?iso-8859-1?Q?eWG65c6CJdCNaPApr93VC67H6jrePkt79nSYdnV4niR7J7vYt1UUZky85a?=
 =?iso-8859-1?Q?jNZaRay0HrcsI+xGTO9T71D9XcZmkQky0Sqj5evNBrbHMMGKkTvw89W3O8?=
 =?iso-8859-1?Q?ZRlOyEElw5ggBKHyWTbY4+mRfkejzoySs9k9rb8Qef5qq3ucKNRMF+RUjz?=
 =?iso-8859-1?Q?WYyPpt+lh5BMDdiLk0nTdO/Qj9oTJlrhsU9yWv5cwJbSLhiunIzieAuqjV?=
 =?iso-8859-1?Q?s/Rs7FqaSF4xtQuAJtz1NltXvv4YwxOJxHyEDjOdMJMMVHxPkfOTP//AcL?=
 =?iso-8859-1?Q?RRD/d5TFA2r9JQ6h4Z+2C+KDZhY90noovKNw8hyEjhiEZBTTtIR2nISL62?=
 =?iso-8859-1?Q?QxwtH3zXFFGxMcKArm6n7C64USuVivOmEqF0WyNYdMogis996G3m1HQhjs?=
 =?iso-8859-1?Q?SpUWL7LaVqeFkKViJxuPf6FSTvSJPhFH1u8PuerrhJliecFtSLH0QzXv6B?=
 =?iso-8859-1?Q?PtR58lNXo7Tpd/mvvY5i7p0H/gc3o5jletbFaIR1PmIx5UptANXD/TXt+g?=
 =?iso-8859-1?Q?d2TT7bK5/ZwuixeXuKDKO40VxSf8HSSMxBZlT+KywYWy9KR2jD8LtfOpdl?=
 =?iso-8859-1?Q?k7tjx/7v+bBL4XdmkQthTvKEZvmz9wtrji+RfaxY7SNNh+mFo0qM5GTVAY?=
 =?iso-8859-1?Q?24HAY+KhphlrcnGabJ66b0Y8hNuQ1yIf9y7/uZComfapXrBUnY/Cl6DAtE?=
 =?iso-8859-1?Q?LB6Izp89E3dkSNRQd2KMpV3vOIySY0sFkZ0aiYuJ7w9uNVaeMMyTIMlcm1?=
 =?iso-8859-1?Q?aMO4PncFQN3Tl/M1RTeE65t/e4Rh0FGdygx/PZ0l0JjPTexFhXgi4XoR8d?=
 =?iso-8859-1?Q?dNqYFnRYYtn0Z98fDh47S9jNU5b0mETCTa780eIbtZKnJeRioBbT6ZG2yE?=
 =?iso-8859-1?Q?8aMCCvwZpVWWj6zM6MzsMIOxUexxbRzVW3HuPrJEtUcNoqBuuJUxFNd2On?=
 =?iso-8859-1?Q?AvVj0qLDWw+1AzC31aQnnMGAFmdjNFYSv7plPXRKOvNzQux/OVRsB0Qp2o?=
 =?iso-8859-1?Q?QNX6QAiZgZludHjh0D9OV+1Gx5TB7CbOmmiNwlvsTBLqdZ1kNWW3HkkC83?=
 =?iso-8859-1?Q?Es5yXtsCIL7DmZHfTrZ2FfDBHQmTzz3BUk5lXNcDQKHut4mO9NGzPg3vGb?=
 =?iso-8859-1?Q?1CWU+0k7DpePK2aJkoU62rQrTJG+CgccBCqDxGKstDmys/d7HlVITCrRbB?=
 =?iso-8859-1?Q?uXtebtiJcpg7VGa1QaBM3B5Kw8D4OT5Gfj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a62e67-61eb-43c2-ad8c-08dbb074268c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:01:51.1901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKGVVkT/p5hh+mnahA3Ox0NWGghNVQE5kmwQGxdiIWQTd/odHRASfw3I3UectVeH8QZtzkSSjTH6OSgFNaYmRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6269
X-Proofpoint-ORIG-GUID: G0W57aYbBCG0XpuXDnRfLDn-leikTWiw
X-Proofpoint-GUID: G0W57aYbBCG0XpuXDnRfLDn-leikTWiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309080130
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

Hello Akashi-san,=0A=
=0A=
> =0A=
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Sent: Friday, September 8, 2023 04:51=0A=
> =A0=0A=
> The commit 85dc58289238 ("firmware: scmi: prepare uclass to pass channel=
=0A=
> reference") added an explicit parameter, channel, but it seems to make=0A=
> the code complex.=0A=
> =0A=
> Hiding this parameter will allow for adding a generic (protocol-agnostic)=
=0A=
> helper function, i.e. for PROTOCOL_VERSION, in a later patch.=0A=
> =0A=
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Reviewed-by: Simon Glass <sjg@chromium.org>=0A=
> ---=0A=
> v3=0A=
> * fix an issue on ST board (reported by Etienne)=0A=
> =A0 by taking care of cases where probed devices are children of=0A=
> =A0 SCMI protocol device (i.e. clock devices under CCF)=0A=
> =A0 See find_scmi_protocol_device().=0A=
> * move "per_device_plato_auto" to a succeeding right patch=0A=
> v2=0A=
> * new patch=0A=
> ---=0A=
> =A0drivers/clk/clk_scmi.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 27 +---=0A=
> =A0drivers/firmware/scmi/scmi_agent-uclass.c | 160 +++++++++++-----------=
=0A=
> =A0drivers/power/regulator/scmi_regulator.c=A0 |=A0 27 +---=0A=
> =A0drivers/reset/reset-scmi.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 19 +--=0A=
> =A0include/scmi_agent.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 15 +-=0A=
> =A05 files changed, 103 insertions(+), 145 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c=0A=
> index d172fed24c9d..34a49363a51a 100644=0A=
> --- a/drivers/clk/clk_scmi.c=0A=
> +++ b/drivers/clk/clk_scmi.c=0A=
> @@ -13,17 +13,8 @@=0A=
> =A0#include <asm/types.h>=0A=
> =A0#include <linux/clk-provider.h>=0A=
> =A0=0A=
> -/**=0A=
> - * struct scmi_clk_priv - Private data for SCMI clocks=0A=
> - * @channel: Reference to the SCMI channel to use=0A=
> - */=0A=
> -struct scmi_clk_priv {=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_channel *channel;=0A=
> -};=0A=
> -=0A=
> =A0static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clo=
cks)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_clk_priv *priv =3D dev_get_priv(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_clk_protocol_attr_out out;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_msg msg =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .protocol_id =3D SCMI_PR=
OTOCOL_ID_CLOCK,=0A=
> @@ -33,7 +24,7 @@ static int scmi_clk_get_num_clock(struct udevice *dev, =
size_t *num_clocks)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &ms=
g);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -44,7 +35,6 @@ static int scmi_clk_get_num_clock(struct udevice *dev, =
size_t *num_clocks)=0A=
> =A0=0A=
> =A0static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char =
**name)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_clk_priv *priv =3D dev_get_priv(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_clk_attribute_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .clock_id =3D clkid,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -59,7 +49,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, i=
nt clkid, char **name)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &ms=
g);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -70,7 +60,6 @@ static int scmi_clk_get_attibute(struct udevice *dev, i=
nt clkid, char **name)=0A=
> =A0=0A=
> =A0static int scmi_clk_gate(struct clk *clk, int enable)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_clk_priv *priv =3D dev_get_priv(clk->dev)=
;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_clk_state_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .clock_id =3D clk->id,=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .attributes =3D enable,=
=0A=
> @@ -81,7 +70,7 @@ static int scmi_clk_gate(struct clk *clk, int enable)=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(clk->dev, priv->channel=
, &msg);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(clk->dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -100,7 +89,6 @@ static int scmi_clk_disable(struct clk *clk)=0A=
> =A0=0A=
> =A0static ulong scmi_clk_get_rate(struct clk *clk)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_clk_priv *priv =3D dev_get_priv(clk->dev)=
;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_clk_rate_get_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .clock_id =3D clk->id,=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -110,7 +98,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(clk->dev, priv->channel=
, &msg);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(clk->dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -123,7 +111,6 @@ static ulong scmi_clk_get_rate(struct clk *clk)=0A=
> =A0=0A=
> =A0static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_clk_priv *priv =3D dev_get_priv(clk->dev)=
;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_clk_rate_set_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .clock_id =3D clk->id,=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .flags =3D SCMI_CLK_RATE=
_ROUND_CLOSEST,=0A=
> @@ -136,7 +123,7 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong=
 rate)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(clk->dev, priv->channel=
, &msg);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(clk->dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -149,12 +136,11 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulo=
ng rate)=0A=
> =A0=0A=
> =A0static int scmi_clk_probe(struct udevice *dev)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_clk_priv *priv =3D dev_get_priv(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct clk *clk;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 size_t num_clocks, i;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_of_get_channel(dev, &priv->channel)=
;=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_of_get_channel(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -205,5 +191,4 @@ U_BOOT_DRIVER(scmi_clock) =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .id =3D UCLASS_CLK,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .ops =3D &scmi_clk_ops,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .probe =3D scmi_clk_probe,=0A=
> -=A0=A0=A0=A0=A0=A0 .priv_auto =3D sizeof(struct scmi_clk_priv *),=0A=
> =A0};=0A=
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware=
/scmi/scmi_agent-uclass.c=0A=
> index 02de692d66f3..feb31809e715 100644=0A=
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c=0A=
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c=0A=
> @@ -8,6 +8,7 @@=0A=
> =A0#include <common.h>=0A=
> =A0#include <dm.h>=0A=
> =A0#include <errno.h>=0A=
> +#include <scmi_agent.h>=0A=
> =A0#include <scmi_agent-uclass.h>=0A=
> =A0#include <scmi_protocols.h>=0A=
> =A0#include <dm/device_compat.h>=0A=
> @@ -51,77 +52,23 @@ int scmi_to_linux_errno(s32 scmi_code)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return -EPROTO;=0A=
> =A0}=0A=
> =A0=0A=
> -/*=0A=
> - * SCMI agent devices binds devices of various uclasses depeding on=0A=
> - * the FDT description. scmi_bind_protocol() is a generic bind sequence=
=0A=
> - * called by the uclass at bind stage, that is uclass post_bind.=0A=
> - */=0A=
> -static int scmi_bind_protocols(struct udevice *dev)=0A=
=0A=
This patch removes function scmi_bind_protocols() whereas it should=0A=
be removed (actually moved) from patch PATCH v3 03/13=0A=
("firmware: scmi: move scmi_bind_protocols() backward").=0A=
=0A=
=0A=
> +static struct udevice *find_scmi_protocol_device(struct udevice *dev)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 int ret =3D 0;=0A=
> -=A0=A0=A0=A0=A0=A0 ofnode node;=0A=
> -=A0=A0=A0=A0=A0=A0 const char *name;=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0 dev_for_each_subnode(node, dev) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct driver *drv =3D NULL;=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 protocol_id;=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ofnode_is_enabled(node))=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conti=
nue;=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ofnode_read_u32(node, "re=
g", &protocol_id))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conti=
nue;=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *parent =3D NULL, *protocol;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name =3D ofnode_get_name(node=
);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (protocol_id) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_CLOCK:=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (C=
ONFIG_IS_ENABLED(CLK_SCMI))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 drv =3D DM_DRIVER_GET(scmi_clock);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break=
;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_RESET_D=
OMAIN:=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (I=
S_ENABLED(CONFIG_RESET_SCMI))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 drv =3D DM_DRIVER_GET(scmi_reset_domain);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break=
;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_VOLTAGE=
_DOMAIN:=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (I=
S_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 node =3D ofnode_find_subnode(node, "regulators");=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (!ofnode_valid(node)) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "no regulators node=
\n");=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENXIO;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 }=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 drv =3D DM_DRIVER_GET(scmi_voltage_domain);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break=
;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break=
;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!drv) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_d=
bg(dev, "Ignore unsupported SCMI protocol %#x\n",=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 protocol_id);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conti=
nue;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D device_bind(dev, drv,=
 name, NULL, node, NULL);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0 for (protocol =3D dev; protocol; protocol =3D parent)=
 {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 parent =3D dev_get_parent(pro=
tocol);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!parent ||=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_get_uclass=
_id(parent) =3D=3D UCLASS_SCMI_AGENT)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
break;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 return ret;=0A=
> -}=0A=
> -=0A=
> -static struct udevice *find_scmi_transport_device(struct udevice *dev)=
=0A=
> -{=0A=
> -=A0=A0=A0=A0=A0=A0 struct udevice *parent =3D dev;=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0 do {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 parent =3D dev_get_parent(par=
ent);=0A=
> -=A0=A0=A0=A0=A0=A0 } while (parent && device_get_uclass_id(parent) !=3D =
UCLASS_SCMI_AGENT);=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0 if (!parent)=0A=
> +=A0=A0=A0=A0=A0=A0 if (!parent) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Invalid SC=
MI device, agent not found\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 return parent;=0A=
> +=A0=A0=A0=A0=A0=A0 return protocol;=0A=
> =A0}=0A=
> =A0=0A=
> =A0static const struct scmi_agent_ops *transport_dev_ops(struct udevice *=
dev)=0A=
> @@ -129,43 +76,90 @@ static const struct scmi_agent_ops *transport_dev_op=
s(struct udevice *dev)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return (const struct scmi_agent_ops *)dev->drive=
r->ops;=0A=
> =A0}=0A=
> =A0=0A=
> -int devm_scmi_of_get_channel(struct udevice *dev, struct scmi_channel **=
channel)=0A=
> +/**=0A=
> + * scmi_of_get_channel() - Get SCMI channel handle=0A=
> + *=0A=
> + * @dev:=A0=A0=A0=A0=A0=A0 SCMI agent device=0A=
> + * @channel:=A0=A0 Output reference to the SCMI channel upon success=0A=
> + *=0A=
> + * On return, @channel will be set.=0A=
> + * Return=A0=A0=A0=A0=A0 0 on success and a negative errno on failure=0A=
> + */=0A=
> +static int scmi_of_get_channel(struct udevice *dev, struct scmi_channel =
**channel)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct udevice *parent;=0A=
> +=A0=A0=A0=A0=A0=A0 const struct scmi_agent_ops *ops;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 parent =3D find_scmi_transport_device(dev);=0A=
> -=A0=A0=A0=A0=A0=A0 if (!parent)=0A=
> +=A0=A0=A0=A0=A0=A0 ops =3D transport_dev_ops(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ops->of_get_channel)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ops->of_get_channel(de=
v, channel);=0A=
> +=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROTONOSUPPORT;=0A=
> +}=0A=
> +=0A=
> +int devm_scmi_of_get_channel(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *protocol;=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_agent_proto_priv *priv;=0A=
> +=A0=A0=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 protocol =3D find_scmi_protocol_device(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (!protocol)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 if (transport_dev_ops(parent)->of_get_channel)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return transport_dev_ops(pare=
nt)->of_get_channel(parent, channel);=0A=
> +=A0=A0=A0=A0=A0=A0 priv =3D dev_get_parent_priv(protocol);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_of_get_channel(protocol->parent, &priv->=
channel);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret =3D=3D -EPROTONOSUPPORT) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Drivers without a get_chan=
nel operator don't need a channel ref */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->channel =3D NULL;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 /* Drivers without a get_channel operator don't need =
a channel ref */=0A=
> -=A0=A0=A0=A0=A0=A0 *channel =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0}=0A=
> =A0=0A=
> -int devm_scmi_process_msg(struct udevice *dev, struct scmi_channel *chan=
nel,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 struct scmi_msg *msg)=0A=
> +/**=0A=
> + * scmi_process_msg() - Send and process an SCMI message=0A=
> + *=0A=
> + * Send a message to an SCMI server.=0A=
> + * Caller sets scmi_msg::out_msg_sz to the output message buffer size.=
=0A=
> + *=0A=
> + * @dev:=A0=A0=A0=A0=A0=A0 SCMI agent device=0A=
> + * @channel:=A0=A0 Communication channel for the device=0A=
> + * @msg:=A0=A0=A0=A0=A0=A0 Message structure reference=0A=
> + *=0A=
> + * On return, scmi_msg::out_msg_sz stores the response payload size.=0A=
> + * Return:=A0=A0=A0=A0 0 on success and a negative errno on failure=0A=
> + */=0A=
> +static int scmi_process_msg(struct udevice *dev, struct scmi_channel *ch=
annel,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 struct scmi_msg *msg)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 const struct scmi_agent_ops *ops;=0A=
> -=A0=A0=A0=A0=A0=A0 struct udevice *parent;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 parent =3D find_scmi_transport_device(dev);=0A=
> -=A0=A0=A0=A0=A0=A0 if (!parent)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
> +=A0=A0=A0=A0=A0=A0 ops =3D transport_dev_ops(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ops->process_msg)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ops->process_msg(dev, =
channel, msg);=0A=
> +=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROTONOSUPPORT;=0A=
> +}=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ops =3D transport_dev_ops(parent);=0A=
> +int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *protocol;=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_agent_proto_priv *priv;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 if (ops->process_msg)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ops->process_msg(paren=
t, channel, msg);=0A=
> +=A0=A0=A0=A0=A0=A0 protocol =3D find_scmi_protocol_device(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (!protocol)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 priv =3D dev_get_parent_priv(protocol);=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 return -EPROTONOSUPPORT;=0A=
> +=A0=A0=A0=A0=A0=A0 return scmi_process_msg(protocol->parent, priv->chann=
el, msg);=0A=
> =A0}=0A=
> =A0=0A=
> =A0UCLASS_DRIVER(scmi_agent) =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D UCLA=
SS_SCMI_AGENT,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D "scmi_ag=
ent",=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .post_bind=A0=A0=A0=A0=A0 =3D scmi_bind_protocol=
s,=0A=
> +=A0=A0=A0=A0=A0=A0 .per_child_auto =3D sizeof(struct scmi_agent_proto_pr=
iv *),=0A=
> =A0};=0A=
> diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/reg=
ulator/scmi_regulator.c=0A=
> index 801148036ff6..08918b20872c 100644=0A=
> --- a/drivers/power/regulator/scmi_regulator.c=0A=
> +++ b/drivers/power/regulator/scmi_regulator.c=0A=
> @@ -25,18 +25,9 @@ struct scmi_regulator_platdata {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 u32 domain_id;=0A=
> =A0};=0A=
> =A0=0A=
> -/**=0A=
> - * struct scmi_regulator_priv - Private data for SCMI voltage regulator=
=0A=
> - * @channel: Reference to the SCMI channel to use=0A=
> - */=0A=
> -struct scmi_regulator_priv {=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_channel *channel;=0A=
> -};=0A=
> -=0A=
> =A0static int scmi_voltd_set_enable(struct udevice *dev, bool enable)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_regulator_platdata *pdata =3D dev_ge=
t_plat(dev);=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_regulator_priv *priv =3D dev_get_priv(dev=
);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_voltd_config_set_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .domain_id =3D pdata->do=
main_id,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D enable ? SCM=
I_VOLTD_CONFIG_ON : SCMI_VOLTD_CONFIG_OFF,=0A=
> @@ -47,7 +38,7 @@ static int scmi_voltd_set_enable(struct udevice *dev, b=
ool enable)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &ms=
g);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -57,7 +48,6 @@ static int scmi_voltd_set_enable(struct udevice *dev, b=
ool enable)=0A=
> =A0static int scmi_voltd_get_enable(struct udevice *dev)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_regulator_platdata *pdata =3D dev_ge=
t_plat(dev);=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_regulator_priv *priv =3D dev_get_priv(dev=
);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_voltd_config_get_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .domain_id =3D pdata->do=
main_id,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -67,7 +57,7 @@ static int scmi_voltd_get_enable(struct udevice *dev)=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &ms=
g);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -80,7 +70,6 @@ static int scmi_voltd_get_enable(struct udevice *dev)=
=0A=
> =A0=0A=
> =A0static int scmi_voltd_set_voltage_level(struct udevice *dev, int uV)=
=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_regulator_priv *priv =3D dev_get_priv(dev=
);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_regulator_platdata *pdata =3D dev_ge=
t_plat(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_voltd_level_set_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .domain_id =3D pdata->do=
main_id,=0A=
> @@ -92,7 +81,7 @@ static int scmi_voltd_set_voltage_level(struct udevice =
*dev, int uV)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &ms=
g);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -101,7 +90,6 @@ static int scmi_voltd_set_voltage_level(struct udevice=
 *dev, int uV)=0A=
> =A0=0A=
> =A0static int scmi_voltd_get_voltage_level(struct udevice *dev)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_regulator_priv *priv =3D dev_get_priv(dev=
);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_regulator_platdata *pdata =3D dev_ge=
t_plat(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_voltd_level_get_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .domain_id =3D pdata->do=
main_id,=0A=
> @@ -112,7 +100,7 @@ static int scmi_voltd_get_voltage_level(struct udevic=
e *dev)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &ms=
g);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -140,7 +128,6 @@ static int scmi_regulator_of_to_plat(struct udevice *=
dev)=0A=
> =A0static int scmi_regulator_probe(struct udevice *dev)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_regulator_platdata *pdata =3D dev_ge=
t_plat(dev);=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_regulator_priv *priv =3D dev_get_priv(dev=
);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_voltd_attr_in in =3D { 0 };=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_voltd_attr_out out =3D { 0 };=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_msg scmi_msg =3D {=0A=
> @@ -153,14 +140,14 @@ static int scmi_regulator_probe(struct udevice *dev=
)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_of_get_channel(dev->parent, &priv->=
channel);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_of_get_channel(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /* Check voltage domain is known from SCMI serve=
r */=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 in.domain_id =3D pdata->domain_id;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, priv->channel, &sc=
mi_msg);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(dev, &scmi_msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Failed to =
query voltage domain %u: %d\n",=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
pdata->domain_id, ret);=0A=
> @@ -184,7 +171,6 @@ U_BOOT_DRIVER(scmi_regulator) =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .probe =3D scmi_regulator_probe,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .of_to_plat =3D scmi_regulator_of_to_plat,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .plat_auto =3D sizeof(struct scmi_regulator_plat=
data),=0A=
> -=A0=A0=A0=A0=A0=A0 .priv_auto =3D sizeof(struct scmi_regulator_priv *),=
=0A=
> =A0};=0A=
> =A0=0A=
> =A0static int scmi_regulator_bind(struct udevice *dev)=0A=
> @@ -209,4 +195,5 @@ U_BOOT_DRIVER(scmi_voltage_domain) =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "scmi_voltage_domain",=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .id =3D UCLASS_NOP,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .bind =3D scmi_regulator_bind,=0A=
> +=A0=A0=A0=A0=A0=A0 .per_child_auto =3D sizeof(struct scmi_agent_proto_pr=
iv *),=0A=
=0A=
I think this line is not needed. agent protocols private data is allocated=
=0A=
from .per_child_auto field set in scmi_agent-uclass.c above in this patch.=
=0A=
=0A=
=0A=
> =A0};=0A=
> diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c=0A=
> index 122556162ec3..b76711f0a8fb 100644=0A=
> --- a/drivers/reset/reset-scmi.c=0A=
> +++ b/drivers/reset/reset-scmi.c=0A=
> @@ -13,17 +13,8 @@=0A=
> =A0#include <scmi_protocols.h>=0A=
> =A0#include <asm/types.h>=0A=
> =A0=0A=
> -/**=0A=
> - * struct scmi_reset_priv - Private data for SCMI reset controller=0A=
> - * @channel: Reference to the SCMI channel to use=0A=
> - */=0A=
> -struct scmi_reset_priv {=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_channel *channel;=0A=
> -};=0A=
> -=0A=
> =A0static int scmi_reset_set_level(struct reset_ctl *rst, bool assert_not=
_deassert)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_reset_priv *priv =3D dev_get_priv(rst->de=
v);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_rd_reset_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .domain_id =3D rst->id,=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .flags =3D assert_not_de=
assert ? SCMI_RD_RESET_FLAG_ASSERT : 0,=0A=
> @@ -35,7 +26,7 @@ static int scmi_reset_set_level(struct reset_ctl *rst, =
bool assert_not_deassert)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in, out);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(rst->dev, priv->channel=
, &msg);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(rst->dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -54,7 +45,6 @@ static int scmi_reset_deassert(struct reset_ctl *rst)=
=0A=
> =A0=0A=
> =A0static int scmi_reset_request(struct reset_ctl *rst)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_reset_priv *priv =3D dev_get_priv(rst->de=
v);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_rd_attr_in in =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .domain_id =3D rst->id,=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -68,7 +58,7 @@ static int scmi_reset_request(struct reset_ctl *rst)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * We don't really care about the attribute, j=
ust check=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * the reset domain exists.=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(rst->dev, priv->channel=
, &msg);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D devm_scmi_process_msg(rst->dev, &msg);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0=0A=
> @@ -83,9 +73,7 @@ static const struct reset_ops scmi_reset_domain_ops =3D=
 {=0A=
> =A0=0A=
> =A0static int scmi_reset_probe(struct udevice *dev)=0A=
> =A0{=0A=
> -=A0=A0=A0=A0=A0=A0 struct scmi_reset_priv *priv =3D dev_get_priv(dev);=
=0A=
> -=0A=
> -=A0=A0=A0=A0=A0=A0 return devm_scmi_of_get_channel(dev, &priv->channel);=
=0A=
> +=A0=A0=A0=A0=A0=A0 return devm_scmi_of_get_channel(dev);=0A=
> =A0}=0A=
> =A0=0A=
> =A0U_BOOT_DRIVER(scmi_reset_domain) =3D {=0A=
> @@ -93,5 +81,4 @@ U_BOOT_DRIVER(scmi_reset_domain) =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .id =3D UCLASS_RESET,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .ops =3D &scmi_reset_domain_ops,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 .probe =3D scmi_reset_probe,=0A=
> -=A0=A0=A0=A0=A0=A0 .priv_auto =3D sizeof(struct scmi_reset_priv *),=0A=
> =A0};=0A=
> diff --git a/include/scmi_agent.h b/include/scmi_agent.h=0A=
> index ee6286366df7..577892029ff8 100644=0A=
> --- a/include/scmi_agent.h=0A=
> +++ b/include/scmi_agent.h=0A=
> @@ -15,6 +15,14 @@=0A=
> =A0struct udevice;=0A=
> =A0struct scmi_channel;=0A=
> =A0=0A=
> +/**=0A=
> + * struct scmi_agent_proto_priv - Private data in device for SCMI agent=
=0A=
> + * @channel: Reference to the SCMI channel to use=0A=
> + */=0A=
> +struct scmi_agent_proto_priv {=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_channel *channel;=0A=
> +};=0A=
> +=0A=
> =A0/*=0A=
> =A0 * struct scmi_msg - Context of a SCMI message sent and the response r=
eceived=0A=
> =A0 *=0A=
> @@ -49,10 +57,9 @@ struct scmi_msg {=0A=
> =A0 * devm_scmi_of_get_channel() - Get SCMI channel handle from SCMI agen=
t DT node=0A=
> =A0 *=0A=
> =A0 * @dev:=A0=A0=A0=A0=A0=A0 Device requesting a channel=0A=
> - * @channel:=A0=A0 Output reference to the SCMI channel upon success=0A=
> =A0 * @return 0 on success and a negative errno on failure=0A=
> =A0 */=0A=
> -int devm_scmi_of_get_channel(struct udevice *dev, struct scmi_channel **=
channel);=0A=
> +int devm_scmi_of_get_channel(struct udevice *dev);=0A=
> =A0=0A=
> =A0/**=0A=
> =A0 * devm_scmi_process_msg() - Send and process an SCMI message=0A=
> @@ -62,12 +69,10 @@ int devm_scmi_of_get_channel(struct udevice *dev, str=
uct scmi_channel **channel)=0A=
> =A0 * On return, scmi_msg::out_msg_sz stores the response payload size.=
=0A=
> =A0 *=0A=
> =A0 * @dev:=A0=A0=A0=A0=A0=A0 SCMI device=0A=
> - * @channel:=A0=A0 Communication channel for the device=0A=
> =A0 * @msg:=A0=A0=A0=A0=A0=A0 Message structure reference=0A=
> =A0 * Return: 0 on success and a negative errno on failure=0A=
> =A0 */=0A=
> -int devm_scmi_process_msg(struct udevice *dev, struct scmi_channel *chan=
nel,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 struct scmi_msg *msg);=0A=
> +int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg);=0A=
> =A0=0A=
> =A0/**=0A=
> =A0 * scmi_to_linux_errno() - Convert an SCMI error code into a Linux err=
no code=0A=
> -- =0A=
> 2.34.1=0A=
> =0A=
