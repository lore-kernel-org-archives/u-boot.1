Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E975EE8009
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEE286B3B;
	Fri,  8 Sep 2023 16:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="bxA0q9Z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FA286B35; Fri,  8 Sep 2023 16:02:00 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E2886B01
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7615c7331c=etienne.carriere@st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3889lq1K026324; Fri, 8 Sep 2023 16:01:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 STMicroelectronics; bh=NWUOTn7N6w3iIrqskUpGjAP7+dS7xYoKeUS7UlmQG
 5Q=; b=bxA0q9Z8lokG2uI+g2Q0nHd6BbAFEVYsAsqidbH0XxgZt5WcG7a2vA5nJ
 V7pwgq1UHnj1QrpmuXGh4hNQ/IPzSzbXAx/i/YQ/zDoq01wP5vW9F5i1tTMwTdaV
 B8L1xB9irvu6zkvLNDLkfh4IHgOr0P41d+dp+Q44yGSd9ZZ8i7OivFb9TMOTGFDZ
 uJ18hxJfb/vaN58gUtsgpC5vlwxwEtx0RDE8WBUzXFl/Oxb06V5s1LDsuGSWVAWy
 1BIGLuj+EF32NefQ3yl3eGoH1QK8D6V1+GXKxnUr+C1EtLRsu6448RH0EHwTVC0B
 KaYKIlHb+nnhzjQVv4lMsyoO0gkAg==
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3svem117jm-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 16:01:54 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KroWMFHChy296/CooWtuRI8i/XkYNTLKZ7MXU+NNTviLGM9pB92Uue/2ovKTbBla9zu+PjMHdkds3x98CqWOTvXrmEz4EkyB/S+OWQUFSFGhoBx41N9NDSkt86/sG9W9lRJJJPI1ednGAkPgzPTxYOD8d1AhMmJ8zmzQJegz5uElpjpfV0TegiJ/AxfYv4rDRST4coa8EPNu/34VrgWo+eOTcd5xEbXduTuv31h/LXaly95QeG/c6IGHmQ6ldhpaoMGQxcUVMSg3PThpfXuwhXL/o58kM0COx0K44nx9KoEotu3s2P7LoZcxQxftRcZmKdKOyrSC5bGKNf0FTWrfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWUOTn7N6w3iIrqskUpGjAP7+dS7xYoKeUS7UlmQG5Q=;
 b=Ow6aZtQEmldtVQcvSw1MYIR+7JsAujn4jHKW1fYS7aFNwZ9/rYAu3x+4rnFs9lHwqMchB/lOw6ixl4P3UBAENoOvq+u5cAL9zO7+dr1JoQU6qDt/oEhWo+QuDbnrOPpfsfGV6DQbn8o7ifH4hLmSwoBtqXKjwLnJm3T/1g65ppZFOTn9WGfQzcpVBogRBu6xaBfVH85iAcPDywlgEtG9Iu/bfLslIXWsYW0doyH8Z+skVIE5JHJvXtBde0iqrxdmIjN7Koly1u3o6YnVLH8wKaF1Zjuy9c9k1h49z5nfJXOlFcum/QHcSdhdebg49ci+bDGO1pG0q/xXtxoQyquPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by AS8PR10MB6269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 14:01:53 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:01:53 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Etienne CARRIERE - foss
 <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 04/13] firmware: scmi: framework for installing
 additional protocols
Thread-Topic: [PATCH v3 04/13] firmware: scmi: framework for installing
 additional protocols
Thread-Index: AQHZ4f+EFPyTFpmVG0y7H0eLf1MAkrAQ2o2v
Date: Fri, 8 Sep 2023 14:01:52 +0000
Message-ID: <PAXPR10MB4687A7E0331B9FD9206F1E8AFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-5-takahiro.akashi@linaro.org>
In-Reply-To: <20230908025138.44405-5-takahiro.akashi@linaro.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2023-09-08T14:01:52.481Z;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified); MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|AS8PR10MB6269:EE_
x-ms-office365-filtering-correlation-id: 61c5e7ec-30db-411c-a637-08dbb0742797
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uc6yxojiBj+HOMQLLH9Q6ObZQ/Kwv1QhDSuvQGg4TTpvJcKXN+X8aEkNoe5bvuaG9ilGI9jZi/Y4VkuzZD2ZnOuTxRylY0kx7cmrk9aWPSqmRgY2qggn2zf0Ba2MCNBoyL+f+91gChreBGcCPwmxuBJBKkDSbe5yjhp2DGdvaA1ax0mCC2R2fuBdGA8lYpC5Tr8DVcbIfmB2EQfbhlGw+J9MRO78u/ZnMsFjqqajynIL3IRsrq3LSeBCOec58hiasxFvgtXleqX0mPzcyr6JQFCllr87GCfLzHGWLKnlpNkXvpxJYlAD721qe24507OxslAHp+5j4/MleV/JNMv/VsBMAg1tK/YR6FpgJG+ocL8n5jvJDZWFfqxNd0kBuXnQKxHXmoeOIp6uOpw7IEB7HRfCyfzt6tBCHGnKVHFnOFz2gOxNL/aCBfrCihr/Pu64dho5RowMJkrZePzuB14Ers30rSYVTvxNiO3pMqkq5BKbA9GKyAEaXuXWaT7eJ9qpfLGQm78fCZ3JfO/hCXKW5KWJ3qxDZE65p4063k9w6gCi17SszLP3/oAkeG6sxlm7tea3UgL9C8PnbaunxQx9gH5EuTlbDYf+gVvjhIvHFOvVhECxQpnvTSFQwptb3xVK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(52536014)(110136005)(71200400001)(6506007)(7696005)(9686003)(83380400001)(478600001)(26005)(2906002)(64756008)(66946007)(5660300002)(4326008)(66476007)(66556008)(54906003)(66446008)(316002)(8936002)(76116006)(8676002)(41300700001)(86362001)(38070700005)(33656002)(55016003)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xv/B33rGuu4h1DtvlZo4HQT3cCRByNqXPLNoyPw7lVSTrKw+dREwm1Vikh?=
 =?iso-8859-1?Q?+g0DgTzgrux8wexnU8eO5EX+fyXSqx2kvkWI3APyA03pxO+HeUuEGEI2GC?=
 =?iso-8859-1?Q?jcme7n6UqS8iVAUCs+x47nZfUDErbEZO/oSLJn4gl2SfOG6wYtDui6O0hx?=
 =?iso-8859-1?Q?JBRemJOG7T1JXDjjkvqnUXSMyesXhk2x8VnrcsJdXt4VRk6p3FLL2trdGm?=
 =?iso-8859-1?Q?UH3zy/fKX0qD5Fgu88HqT6kNW3LXblyHQGhrNKbQupytk2KU23PnhHqjdK?=
 =?iso-8859-1?Q?+x/VQJrtNT4DVKemDaLtjnbHaa4vKgGkCAD+ggi5k+j2Qit2bori1pvMl4?=
 =?iso-8859-1?Q?svJMY7KxdKgS4heRjal2+3WqyyidWAnpaZbHvFWkshPssjCcZ25AYa+MXA?=
 =?iso-8859-1?Q?v1gBcP3IR+KduN5rU1MDHIWugtEDJrky8RRa4nX5yXPcEsbD5+s1vTMHHI?=
 =?iso-8859-1?Q?Fayd5HGHAs3jApynaceGp/oYUkAtUuzmz6HZYv0TqMfOgSFYgNMe72Yyv/?=
 =?iso-8859-1?Q?LG6daos4y0obrqkKgNaDApdS41SgAfep6bSHVb9BYm12thWkL4luaIGODm?=
 =?iso-8859-1?Q?47O/2x9y8weW+QR35KBogGlUR93wz0vEGZdcakvwcUP+iudyx1xGF/AB8w?=
 =?iso-8859-1?Q?jxU8CwdPtO7S8ne4034vt26mOgcfenykCLknAVWXOw9ea/zmjFZnIQVq+9?=
 =?iso-8859-1?Q?iLQeCMuWp5cJ5ROqxGwdUWZSZPCv36fsBOMDnawPttvjqAOOLqEgxp5n6O?=
 =?iso-8859-1?Q?p7eVNtPFPK5O/GC0hmHURJPQvgfNPQQf9HQUPvKdNN1rlqOyOBK8kI//Oo?=
 =?iso-8859-1?Q?BqIW/Cf7v8SrOkHly5WWeHdP7bUwAC0KqavSjSktUAW6c49V+a79oZ6PTv?=
 =?iso-8859-1?Q?f14V+azCaEQeS0JAzfGZRgpZpUnN/ZHn2cD6dVrkgimYbSbynzEypazXYq?=
 =?iso-8859-1?Q?1cbZ40r3B0AUnYC4SwRzjr2mlr1dOpXJmy9PlWmfIFIfBjQua7j8MOAqz5?=
 =?iso-8859-1?Q?syeTB5QOqiySDCG8WO/O0rJWn1HpQzMSkgziPsL5nTF1LFL2g3lQjBR1k5?=
 =?iso-8859-1?Q?+74hBrQMiQH+PdUlwhUAoktbKBvxMnD2+rUrnXzIpLFEKhxWcJ6nXMqwz2?=
 =?iso-8859-1?Q?zU2MZ5iMmQsIJCd64DuIf8H1K4THPU21KGjhaPUmoVAV39ggOBkbwCGo8D?=
 =?iso-8859-1?Q?TtKOZ8r9UMEwt1PQj/g1C5Ivw3v/VBYoojHZ+KfThbm7mkB545hfGMUCCu?=
 =?iso-8859-1?Q?0AIATK4O6rb5imse59j+bS43nvmdvAL1rvDfBPPkCZXTXgJuUx0taijmsy?=
 =?iso-8859-1?Q?cxcCbg9rJN9EZv355Sjx1i5iiWojokc2kK2UibDwuOnbPRXT6d1yuJAX1Y?=
 =?iso-8859-1?Q?BTZP9b6gDmX3k/eodXUqYeMM+7Ghw9ihh+42s1OvQNWst04kG5ZXXf2vR7?=
 =?iso-8859-1?Q?j/pXnyIvZ2pOZUIcXBpUPczhBY+eGljABgpkXt3cJ2Ju81RYWn/CLiN3nN?=
 =?iso-8859-1?Q?tlHcuqOrcd+VKgAL+WA8s9FLXqkiae+rhjbCyk8R99dGwkMWjvXSV3g5lq?=
 =?iso-8859-1?Q?8+YTqv13qI70JlaInlSpGtTRV0XfhnyrFTj5IRVYbLY13hjg11RAUT0GWH?=
 =?iso-8859-1?Q?TtFaNBf1Swkf1tCxtCCgpMX53gYchSFKx/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c5e7ec-30db-411c-a637-08dbb0742797
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:01:52.9931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgZDM3KwanFG324mVwOW/dJHWOmnC/9Av5koH1SONA1nyX6jAL6vWSlT2aN2Ix/XA+M++FqdMTyms/LoZjx2Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6269
X-Proofpoint-ORIG-GUID: sywO6f8X53ot0RWpbzrX6f590V-HuevE
X-Proofpoint-GUID: sywO6f8X53ot0RWpbzrX6f590V-HuevE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
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

=0A=
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Sent: Friday, September 8, 2023 04:51=0A=
> =A0=0A=
> This framework allows SCMI protocols to be installed and bound to the age=
nt=0A=
> so that the agent can manage and utilize them later.=0A=
> =0A=
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Reviewed-by: Simon Glass <sjg@chromium.org>=0A=
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>=0A=
> ---=0A=
> v3=0A=
> * move "per_device_plat_auto" from a earlier patch=0A=
> * fix comments in "scmi_agent_priv"=0A=
> * modify an order of include files in scmi_agent.h=0A=
> v2=0A=
> * check for availability of protocols=0A=
> ---=0A=
> =A0drivers/firmware/scmi/scmi_agent-uclass.c | 101 +++++++++++++++++++++-=
=0A=
> =A0include/scmi_agent-uclass.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 15 +++-=0A=
> =A0include/scmi_agent.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 14 +++=0A=
> =A03 files changed, 126 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware=
/scmi/scmi_agent-uclass.c=0A=
> index 94e54eeb066b..e823d105a3eb 100644=0A=
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c=0A=
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c=0A=
> @@ -38,6 +38,86 @@ static const struct error_code scmi_linux_errmap[] =3D=
 {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 { .scmi =3D SCMI_PROTOCOL_ERROR, .errno =3D -EPR=
OTO, },=0A=
> =A0};=0A=
> =A0=0A=
> +/*=0A=
> + * NOTE: The only one instance should exist according to=0A=
> + * the current specification and device tree bindings.=0A=
> + */=0A=
> +struct udevice *scmi_agent;=0A=
> +=0A=
> +struct udevice *scmi_get_protocol(struct udevice *dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 enum scmi_std_protocol id)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_agent_priv *priv;=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *proto;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 priv =3D dev_get_uclass_plat(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (!priv) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "No priv data fo=
und\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 switch (id) {=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_CLOCK:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto =3D priv->clock_dev;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_RESET_DOMAIN:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto =3D priv->resetdom_dev;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto =3D priv->voltagedom_de=
v;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Protocol not su=
pported\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 if (proto && device_probe(proto))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Probe failed\n"=
);=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 return proto;=0A=
> +}=0A=
> +=0A=
> +/**=0A=
> + * scmi_add_protocol - add protocol to agent=0A=
> + * @dev:=A0=A0=A0=A0=A0=A0 SCMI agent device=0A=
> + * @proto_id:=A0 SCMI protocol ID=0A=
> + * @proto:=A0=A0=A0=A0 SCMI protocol device=0A=
> + *=0A=
> + * Associate the protocol instance, @proto, to the agent, @dev,=0A=
> + * for later use.=0A=
> + *=0A=
> + * Return:=A0=A0=A0=A0 0 on success, error code otherwise=0A=
> + */=0A=
> +static int scmi_add_protocol(struct udevice *dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 enum scmi_std_protocol proto_id,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct udevice *proto)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_agent_priv *priv;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 priv =3D dev_get_uclass_plat(dev);=0A=
> +=A0=A0=A0=A0=A0=A0 if (!priv) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "No priv data fo=
und\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 switch (proto_id) {=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_CLOCK:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->clock_dev =3D proto;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_RESET_DOMAIN:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->resetdom_dev =3D proto;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->voltagedom_dev =3D prot=
o;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Protocol not su=
pported\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROTO;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> =A0int scmi_to_linux_errno(s32 scmi_code)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int n;=0A=
> @@ -164,12 +244,14 @@ int devm_scmi_process_msg(struct udevice *dev, stru=
ct scmi_msg *msg)=0A=
> =A0 */=0A=
> =A0static int scmi_bind_protocols(struct udevice *dev)=0A=
> =A0{=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *agent;=0A=
=0A=
nit: my build reported 'agent' here is not used in the scope of this patch.=
=0A=
Strictly speaking, it should be brought by patch v3 05/13.=0A=
("firmware: scmi: install base protocol to SCMI agent")=0A=
=0A=
BR,=0A=
etienne=0A=
=0A=
> (snip)=0A=
