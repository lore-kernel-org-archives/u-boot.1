Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C59EE8009
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6247086AEE;
	Fri,  8 Sep 2023 16:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="t2i6H4dC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59CF686B34; Fri,  8 Sep 2023 16:02:31 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9486786B01
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7615c7331c=etienne.carriere@st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 388AGFxc012508; Fri, 8 Sep 2023 16:02:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 STMicroelectronics; bh=El8CTugtx+/fApoQobp2B5oM4qdE0ZcYb1xfpqkHO
 IE=; b=t2i6H4dCwc51yjVFaSVC+UaxUA3cYZmqNInMIm8oy0ARxcujC228y6Rwo
 Mgs5ZaXJCBQ1zWkqfDwPML2ovyRLxXQoccHNrG5tNfU/lAS67/Ps5WXzaH4VRsOT
 mB5bcGXlhCE48NG1OqLtpiW1V8VSjAARIQS7Nvt2vryO9Hl9w0GJHduZp3YyHxBj
 0gFM9DHlnIdgzccXqBJjYQCsw5vfpnnMEClcTvnYa8nEnMBWxoQg1F901obLD/xf
 2RzwENtH5ZXHk6B/kfeGFTBp75eopsi02nWMhS0ACHv5DZPeghxEwL7LiEIDCEor
 xuM46UnsRNNfvW8PtrqgLZ3zNROMQ==
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suuxcmnyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 16:02:24 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwDCnLfKMqoSttYa7dEH5LER3iOnizBBXBUz9VAGGK3GhbqjUn0GjJRh/uldxyJFCGq3uvOEscUvxFdqTycFwMAigEv0w5J85gjsGs8LGuRaqiC+tKfNpe1rRmQwswITWtZEhx3pY0+YGAc/422+7l9OIG6GDmEePdqw85jx0IdeS4nMkdHZPOq6RNtN4Qa4BpVnPk8DV1hEtfEbPS9V+k+T+l/HC1asbTHssdbTSrpjkiQST4vRckoS773OkAwLqs1/iDkqJuRYeMJIOzbcTb3gQ/Y694qA/lpbqla/7Hv6vwyyPcgFVma78R85eeCUhbEu93a1g29ftw8ycDlIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El8CTugtx+/fApoQobp2B5oM4qdE0ZcYb1xfpqkHOIE=;
 b=MTj+eXRgLERxYhRMv2Ts5uOSlBzleekISiz+54Q7UI6qXKEsenbzaQppMCp3e9H26RB0ABg1CSfPCdbEyMA1ApSSPkfhyDGwx9BiQf77lHkvtdGAOPVn4b4c1rBXNzB44fxDsU2KGChcfqncFngZhyFWxXNpYonlw9Vk1shwuvhHAJwBhWjEEkmQxNq1FdJ9BN4NWjUKKiJLMYXMWjUUkRxEw5UGBGgBEa1edFZIIIvS2wm/B4pS4AxXhiE08OsGfdF4fPfVredK/BV9QFyG98WBJgkDPwDPTnJG0e64dcO1Sj2D6Ltci3wJLIQrI0KampJUGywdQMXwdsrqAtW+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by AS8PR10MB6269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 14:02:22 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:02:22 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Etienne CARRIERE - foss
 <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 05/13] firmware: scmi: install base protocol to SCMI
 agent
Thread-Topic: [PATCH v3 05/13] firmware: scmi: install base protocol to SCMI
 agent
Thread-Index: AQHZ4f+DYoGAuQbczU+RUr3gLvvllrAQ6koy
Date: Fri, 8 Sep 2023 14:02:22 +0000
Message-ID: <PAXPR10MB46873CBB983139900CB8B016FDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-6-takahiro.akashi@linaro.org>
In-Reply-To: <20230908025138.44405-6-takahiro.akashi@linaro.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2023-09-08T14:02:21.563Z;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified); MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|AS8PR10MB6269:EE_
x-ms-office365-filtering-correlation-id: 04c5cd11-5b3e-4335-ee53-08dbb07438f2
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4UcQ9uMgAslZ5VPinj5GHj3eNzuxGbNvadBC6OUwXD99J4ZUhMlX8C06Zjac4e5or/EAizmIrt61Z/GufMgpBhEwCkrZ441PkuJYrREd59Q320cYLT1A/FJjMNi76zrMUz0Jh/4kBe/s9FqzCo72XuthY87/E0Q/EbqJmAD3IAaO6RY47XWJn+ClbOP6pXOg7r57YJtCod3xqBTGdWJJbTJYHmdpcPdnCaEVr64bnxSK8YGagqf+AjVxImEBEdnqfjcGotcfqbJGi5zd/vcayHkltioJXc/7pJMlXuRi5i1NxU+uoYJ6jhaDI3f92mvdY1rNSwNL86ND6s0l7e6exVrvN259j8S5DZhWgW//PSEl9geqv4ZKlzNi+PmPtOGmvoB1B/m8EvClvs07kKwPJ/A8co0cj0VMvra7qXwg3dy699plcCQmDL0t9iSkIQPBVFmrPry6BdN1c/AOgzDXUEqNYDnkEHeJdod8su570n4Tjx1iUzYteYKyJ3zz4bV9OlZ/uX0wP7oLMgjJudoiQcthRMK1wVhipV/p9/U9ZjLN5VLtX3ycyn1llgJzgOPo8FaTYypprqMXUUBdAeuhcnuQkYPJaiNolWj5AQmaAgRagIZTPnkrdLx0U94nCx5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(52536014)(110136005)(71200400001)(6506007)(7696005)(9686003)(83380400001)(478600001)(26005)(2906002)(64756008)(66946007)(5660300002)(4326008)(66476007)(66556008)(54906003)(66446008)(316002)(8936002)(76116006)(8676002)(41300700001)(86362001)(38070700005)(33656002)(55016003)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w3vMx659EL/veYwMawfBkkY27Y0sXyytqK7TwECJMLiv2M6yyAIENWuq4S?=
 =?iso-8859-1?Q?Q3z2fUSlaUW1SYymEz/EvuqxP3OCQ1JdvAjwv89p+JwwAlv2pzsS+6wR/g?=
 =?iso-8859-1?Q?ifrLC8O5R6KjOiaKWyRAp5GHm3SYnllJp8XvLXVuvIypu0RUxI9dcY9rJ8?=
 =?iso-8859-1?Q?FMftFEACIB3xnX3ebZQXot3PbsQuonU9lO6WrcvXdCUYXIgPdZd4+A4Ks3?=
 =?iso-8859-1?Q?4myIclAO2s6fxOKoROxtGF98emNBMNDEnTDIuu50SJi98I6LFr9L6TTvDr?=
 =?iso-8859-1?Q?9XBnDZ+9pu5vnjbVMWbBk2Yx6dXO2AM+OCu3X2o8LZ51Hh4Nnnt0h8Ehlu?=
 =?iso-8859-1?Q?RsKF2M3sSn5qjmBn5YyGyY/sajYaT5CERjxi2khmHtjmJfU1IEWdHV7REz?=
 =?iso-8859-1?Q?njo3yrijsI9DSLR3l/b4uTvpDxXxKjZJjWxhXMWeb+KqFBURBs0gssy4xB?=
 =?iso-8859-1?Q?kLMlmkMe3finwpJEze/XTiZcBxpLqZNYZo6Jbt2RGuH4MX+mGranD8cLtV?=
 =?iso-8859-1?Q?jig7jF7DFf6thAOlz0mkBjSjGwZkT1VORGWYDyj2ZRTQh+hV0Jx0Rbzo3l?=
 =?iso-8859-1?Q?ayBDW1DKN9s24rye5NEk9ebVoFVHBzjX7ujUvH/cV8YQKALnEKo4fT7CzX?=
 =?iso-8859-1?Q?j1RiY2ZGFLYuEEuPf7Ip4gcUO1JKnFbOfzTHBcg8x4WWJ6i/g8coTzavog?=
 =?iso-8859-1?Q?wuE17Uv7Zqu4FmmQpL/FnIEL5IpGl51CufyHWJn+grksq1ednk+KwM61BK?=
 =?iso-8859-1?Q?qevYnJF/zJbFYJO3ZyevskNzC0TRbIBEE+K/d4XdP0o+wb+LGRCbUWzD1z?=
 =?iso-8859-1?Q?0sIEyvDtBV9X7a2TN9fJTZgywsTKVU9//cammnTrbHSA06rTRAIxD4ZHeu?=
 =?iso-8859-1?Q?woq59C51zHsnbgqozULwT7e6/WNBZ/0o9CAy9+g1zCZYB+ResG+D47oIZL?=
 =?iso-8859-1?Q?EhEuMW0gYhHRzSDs60tfqVe9AJuvybx6I+tRTtpbW/9pC7hu0MDVacFBI+?=
 =?iso-8859-1?Q?YeHnj+nGWtWOsHSkct4rlpUYqCimgDBdwbaKKwgHYBNWQ/FdoktHAznxlR?=
 =?iso-8859-1?Q?BYZTFs+R3jPy/lmGuUo3v7fUrv7A0jearedx5EipvKLDO2ZWE2zsEU5JlU?=
 =?iso-8859-1?Q?5EemRInI44fxvQbZHE49q/vNbHck9WOmxmbwad/7EftlZXh+2+VttS2QHI?=
 =?iso-8859-1?Q?GF/p5x8d3CIFdBFhS0ic2lmAr0G0uboF64hiw+DFg0hT3rbGXlY9zbS/th?=
 =?iso-8859-1?Q?MxexF+PXesrf716Do/LQz+UvKgq2foVQTbLSUE7ZYL0joYRlDzv9XZnuoP?=
 =?iso-8859-1?Q?zkf0qhQglhOcVg8/hOdSh5So99VdhKW7yK5pBjV9xQouP3mlCQsz9apK5+?=
 =?iso-8859-1?Q?GmOm+EI+13L1PM7pxcc9N8lKrHccJIJX7g9aqkkRfwoT6tPV/D7ScxC1hM?=
 =?iso-8859-1?Q?m0SsVb1w2dAQzNzYxp4e4xouTXlqQVsFkXDbGTaTuI/tYkuOCuiwz6VJ0P?=
 =?iso-8859-1?Q?EEYI4f2vhcoQ/XWvjQmKUkxOP5CKsapKiHVtz0vZCTVZkK7/SztZwFWSSE?=
 =?iso-8859-1?Q?zTIeIH8obozOoFYHMPnIT2hJwqZW5chr2uH3AEZXE1swU2iwUv+hd5LtIb?=
 =?iso-8859-1?Q?EA/yc7fN/i/YHIYBKNBQ2NHcC7Z8h5jXq+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c5cd11-5b3e-4335-ee53-08dbb07438f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:02:22.0767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aW4DWQodwgErCB2eMqtHV4fdSc/x6AMDTkA3tv4N7bDETpB+sn1rFbVv0n7cw7IpBeMV5zqWZXJ21vbD1+Y6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6269
X-Proofpoint-GUID: 3Nupt3Dqp7MH9dmCQ5ccldmUVn3ZbgR8
X-Proofpoint-ORIG-GUID: 3Nupt3Dqp7MH9dmCQ5ccldmUVn3ZbgR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309080130
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
Some minor comments.=0A=
=0A=
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Sent: Friday, September 8, 2023 04:51=0A=
> =0A=
> SCMI base protocol is mandatory, and once SCMI node is found in a device=
=0A=
> tree, the protocol handle (udevice) is unconditionally installed to=0A=
> the agent. Then basic information will be retrieved from SCMI server via=
=0A=
> the protocol and saved into the agent instance's local storage.=0A=
> =0A=
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Reviewed-by: Simon Glass <sjg@chromium.org>=0A=
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>=0A=
> ---=0A=
> v3=0A=
> * typo fix: add '@' for argument name in function description=0A=
> * eliminate dev_get_uclass_plat()'s repeated in inline=0A=
> * modify the code for dynamically allocated sub-vendor/agent names=0A=
> v2=0A=
> * use helper functions, removing direct uses of ops=0A=
> ---=0A=
> =A0drivers/firmware/scmi/scmi_agent-uclass.c | 116 ++++++++++++++++++++++=
=0A=
> =A0include/scmi_agent-uclass.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 66 ++++++++++++=0A=
> =A02 files changed, 182 insertions(+)=0A=
> =0A=
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware=
/scmi/scmi_agent-uclass.c=0A=
> index e823d105a3eb..87a667d60124 100644=0A=
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c=0A=
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c=0A=
> @@ -57,6 +57,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 switch (id) {=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_BASE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto =3D priv->base_dev;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_CLOCK:=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto =3D priv->clock_de=
v;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> @@ -101,6 +104,9 @@ static int scmi_add_protocol(struct udevice *dev,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 switch (proto_id) {=0A=
> +=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_BASE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->base_dev =3D proto;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 case SCMI_PROTOCOL_ID_CLOCK:=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->clock_dev =3D prot=
o;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> @@ -237,6 +243,83 @@ int devm_scmi_process_msg(struct udevice *dev, struc=
t scmi_msg *msg)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return scmi_process_msg(protocol->parent, priv->=
channel, msg);=0A=
> =A0}=0A=
> =A0=0A=
> +/**=0A=
> + * scmi_fill_base_info - get base information about SCMI server=0A=
> + * @agent:=A0=A0=A0=A0 SCMI agent device=0A=
> + * @dev:=A0=A0=A0=A0=A0=A0 SCMI protocol device=0A=
> + *=0A=
> + * By using Base protocol commands, collect the base information=0A=
> + * about SCMI server.=0A=
> + *=0A=
> + * Return: 0 on success, error code otherwise=0A=
> + */=0A=
> +static int scmi_fill_base_info(struct udevice *agent, struct udevice *de=
v)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct scmi_agent_priv *priv =3D dev_get_uclass_plat(=
agent);=0A=
> +=A0=A0=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_protocol_version(dev, &priv->versio=
n);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "protocol_versio=
n() failed (%d)\n", ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 /* check for required version */=0A=
> +=A0=A0=A0=A0=A0=A0 if (priv->version < SCMI_BASE_PROTOCOL_VERSION) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "base protocol v=
ersion (%d) lower than expected\n",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv-=
>version);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROTO;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_protocol_attrs(dev, &priv->num_agen=
ts,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &priv->num_protocols);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "protocol_attrs(=
) failed (%d)\n", ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_discover_vendor(dev, &priv->vendor)=
;=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "base_discover_v=
endor() failed (%d)\n", ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_discover_sub_vendor(dev, &priv->sub=
_vendor);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret !=3D -EOPNOTSUPP) {=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_e=
rr(dev, "base_discover_sub_vendor() failed (%d)\n",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n ret;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->sub_vendor =3D "NA";=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_discover_impl_version(dev, &priv->i=
mpl_version);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "base_discover_i=
mpl_version() failed (%d)\n",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret);=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 priv->agent_id =3D 0xffffffff; /* to avoid false clai=
m */=0A=
=0A=
I think this line should move in below instruction block, next to=0A=
priv->agent_name =3D "NA", for consistency,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_discover_agent(dev, 0xffffffff,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &priv->agent_id, &priv->agent_name)=
;=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret !=3D -EOPNOTSUPP) {=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_e=
rr(dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 "base_discover_agent() failed for myself (%d)\n",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n ret;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->agent_name =3D "NA";=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_discover_list_protocols(dev, &priv-=
>protocols);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret !=3D priv->num_protocols) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "base_discover_l=
ist_protocols() failed (%d)\n",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret);=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
Value of ret here is not really relevant. I suggest to force to -EPROTO.=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> =A0/*=0A=
> =A0 * SCMI agent devices binds devices of various uclasses depeding on=0A=
> =A0 * the FDT description. scmi_bind_protocol() is a generic bind sequenc=
e=0A=
> @@ -251,6 +334,39 @@ static int scmi_bind_protocols(struct udevice *dev)=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct driver *drv;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct udevice *proto;=0A=
> =A0=0A=
> +=A0=A0=A0=A0=A0=A0 if (!uclass_get_device(UCLASS_SCMI_AGENT, 1, &agent))=
 {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* This is a second SCMI agen=
t */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "Cannot have mor=
e than one SCMI agent\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EEXIST;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* initialize the device from device tree */=0A=
> +=A0=A0=A0=A0=A0=A0 drv =3D DM_DRIVER_GET(scmi_base_drv);=0A=
> +=A0=A0=A0=A0=A0=A0 name =3D "scmi-base.0";=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D device_bind(dev, drv, name, NULL, ofnode_null=
(), &proto);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to bind =
base protocol\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_add_protocol(dev, SCMI_PROTOCOL_ID_BASE,=
 proto);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to add p=
rotocol: %s, ret: %d\n",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 proto=
->name, ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D device_probe(proto);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to probe=
 base protocol\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_fill_base_info(dev, proto);=0A=
> +=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "failed to get b=
ase information\n");=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
> +=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 dev_for_each_subnode(node, dev) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 protocol_id;=0A=
> =A0=0A=
> diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h=0A=
> index 3358c2b2d804..6fd6d54d6a5a 100644=0A=
> --- a/include/scmi_agent-uclass.h=0A=
> +++ b/include/scmi_agent-uclass.h=0A=
> @@ -5,6 +5,7 @@=0A=
> =A0#ifndef _SCMI_AGENT_UCLASS_H=0A=
> =A0#define _SCMI_AGENT_UCLASS_H=0A=
> =A0=0A=
> +#include <scmi_protocols.h>=0A=
> =A0#include <dm/device.h>=0A=
> =A0=0A=
> =A0struct scmi_msg;=0A=
> @@ -12,16 +13,81 @@ struct scmi_channel;=0A=
> =A0=0A=
> =A0/**=0A=
> =A0 * struct scmi_agent_priv - private data maintained by agent instance=
=0A=
> + * @version:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Version=0A=
> + * @num_agents:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of a=
gents=0A=
> + * @num_protocols:=A0=A0=A0=A0 Number of protocols=0A=
> + * @impl_version:=A0=A0=A0=A0=A0 Implementation version=0A=
> + * @protocols:=A0=A0=A0=A0=A0=A0=A0=A0 Array of protocol IDs=0A=
> + * @vendor:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Vendor name=0A=
> + * @sub_vendor:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Sub-vendor =
name=0A=
> + * @agent_name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Agent name=
=0A=
> + * agent_id:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier of agent=0A=
=0A=
nitpicking: s/agent_id/@agent_id/=0A=
=0A=
> + * @base_dev:=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCMI base protocol device=0A=
> =A0 * @clock_dev:=A0=A0=A0=A0=A0=A0=A0=A0 SCMI clock protocol device=0A=
> =A0 * @resetdom_dev:=A0=A0=A0=A0=A0 SCMI reset domain protocol device=0A=
> =A0 * @voltagedom_dev:=A0=A0=A0 SCMI voltage domain protocol device=0A=
> =A0 */=0A=
> =A0struct scmi_agent_priv {=0A=
> +=A0=A0=A0=A0=A0=A0 u32 version;=0A=
> +=A0=A0=A0=A0=A0=A0 u32 num_agents;=0A=
> +=A0=A0=A0=A0=A0=A0 u32 num_protocols;=0A=
> +=A0=A0=A0=A0=A0=A0 u32 impl_version;=0A=
> +=A0=A0=A0=A0=A0=A0 u8 *protocols;=0A=
> +=A0=A0=A0=A0=A0=A0 u8 *vendor;=0A=
> +=A0=A0=A0=A0=A0=A0 u8 *sub_vendor;=0A=
> +=A0=A0=A0=A0=A0=A0 u8 *agent_name;=0A=
> +=A0=A0=A0=A0=A0=A0 u32 agent_id;=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *base_dev;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct udevice *clock_dev;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct udevice *resetdom_dev;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct udevice *voltagedom_dev;=0A=
> =A0};=0A=
> =A0=0A=
> +static inline u32 scmi_version(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->version;=0A=
> +}=0A=
> +=0A=
> +static inline u32 scmi_num_agents(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->num_agents;=0A=
> +}=0A=
> +=0A=
> +static inline u32 scmi_num_protocols(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->num_protocols;=0A=
> +}=0A=
> +=0A=
> +static inline u32 scmi_impl_version(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->impl_version;=0A=
> +}=0A=
> +=0A=
> +static inline u8 *scmi_protocols(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->protocols;=0A=
> +}=0A=
> +=0A=
> +static inline u8 *scmi_vendor(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->vendor;=0A=
> +}=0A=
> +=0A=
> +static inline u8 *scmi_sub_vendor(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->sub_vendor;=0A=
> +}=0A=
> +=0A=
> +static inline u8 *scmi_agent_name(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->agent_name;=0A=
> +}=0A=
> +=0A=
> +static inline u32 scmi_agent_id(struct udevice *dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 return ((struct scmi_agent_priv *)dev_get_uclass_plat=
(dev))->agent_id;=0A=
> +}=0A=
> +=0A=
> =A0/**=0A=
> =A0 * struct scmi_transport_ops - The functions that a SCMI transport lay=
er must implement.=0A=
> =A0 */=0A=
> -- =0A=
> 2.34.1=0A=
> =0A=
