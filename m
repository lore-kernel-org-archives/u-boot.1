Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955C6EE8000
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D854486A5D;
	Fri,  8 Sep 2023 16:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="AV62GwoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC4F86A61; Fri,  8 Sep 2023 16:27:22 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE7586A4F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7615c7331c=etienne.carriere@st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 388ABbYj031291; Fri, 8 Sep 2023 16:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 STMicroelectronics; bh=6ATMEhDYzUQDN/lS7XEzCib1DMSTSs0UtbUgn2apv
 nE=; b=AV62GwoFQyPLC6ddOHeNOv6lQ3RipOehy6Dmq2pO6xSiJVPCNyfz2iAEV
 RA3ftHSHE+CUxbtdxmoVvBe9luhHMq5XAZrlgLgJr6BgXPlduDswQ3WuSS3MhD8M
 3dey3aKNYCTGrHAEPZAHXKocRb/BhqpO0kxoGp0asILzfSXrL0KHnM19sX4I6wCL
 zrmR1OYv6D0+eGQ11xLMg0Pwjkw0vDAg7HHBUa/Pt062Q/e5Qn2nPdIVDZFX/uah
 sBAlKzM02siJglnVmIt21VboNLE2lrxQoSnsSm5yBuVlmxq351OYR1UFsSZVwTDy
 FjclIKabVLRN0DeKrI18/5MFdG62w==
Received: from eur02-db5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2109.outbound.protection.outlook.com [104.47.11.109])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suvd13bgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 16:27:17 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPFskGcROn0P/iii8A6fADtIYU7BMn+KwXyxSLrQgVV31OAoBTonipTwNktTKXB0W1787O24N41ZNZ2UTQ0x+aJ6I/WECsTrjxp8rj5Rm8bNl+fZDTo45PamdJlDOAfxwFnE1nK9qwLU8+/hJfAgz4HzV6y9daoHEfyD17tqFpj2vf+FD0fn2PRp7Dlo0TLn7vcYcG/NULbB14QjKkFAuGTPU40qlXPswnsOs/36Pyw/3X2+1IJG11CAi6CcV92OCFBfN39vSkaPqMQL6vjEuEhY8WIUqZHHGT04T3vPdVYuWEidbYqKV5o0M4O0sckGBs7gOVHFpDqlrc6kA658fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ATMEhDYzUQDN/lS7XEzCib1DMSTSs0UtbUgn2apvnE=;
 b=QEeKZicAqciM2gk61dbCBwJtiw6lA60USyPWylVwWFwbjoujbb+srvbKJGZSAJs59RtI2nOL1TR/6aTBa33GpaWf3FZwtOVBW2BXCtNKYGktBO6s/uzFrxR3ZIduXIqdQju1/8rZmi2FI01v1aqYeLpcE7NKUFh3NcaRSXeIBdgNyaK+makoD6/C20Xbx1ll5kbP2VAzhFPOWXX1yTmDenvPzl9HP9LZFSSVRWF1TScxcaXAuRaqBKWvz1pYUTBRolaS+AT1RvzF3TVfjdQlqmjW04CN2u0EA5DYPD0XdusOrC5FgMf2LnxfnkU0Q0Fcurq5/H1rSm4fvnJ2UcXFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by AM7PR10MB3575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 14:27:15 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e5:8821:2b8b:6d5f%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:27:15 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Etienne CARRIERE - foss
 <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 13/13] test: dm: add scmi command test
Thread-Topic: [PATCH v3 13/13] test: dm: add scmi command test
Thread-Index: AQHZ4f+M9LKzvjusWEO794SS5aF3NbAQ+vYE
Date: Fri, 8 Sep 2023 14:27:15 +0000
Message-ID: <PAXPR10MB4687E186E8A0810CF1784121FDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-14-takahiro.akashi@linaro.org>
In-Reply-To: <20230908025138.44405-14-takahiro.akashi@linaro.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2023-09-08T14:27:14.667Z;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified); MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|AM7PR10MB3575:EE_
x-ms-office365-filtering-correlation-id: 04ea495e-2c76-44cd-f53d-08dbb077b2e9
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HG0+Ft1eBa4K1ymODyD0mvYU5Z7Ti2ihMm/FrPpM+qk5uUSavQXmnVHgdkWMlvJturG7Aur7/GTV8TqSDIAs/2J3ejKdR0YbS3zqLw5zwPW+j5NuA9rScfHBrAcVhPB4DwQfTfIvDewp4WPBDp+usqIUrvNjhAg0s2pVAc5ZPDEcqhn9kH01t9wwutHDq0P+AA+dqscCsDcnW9C9sYrUcOxa1JDuq7m2RZ6bMhXwlYf6g6k2IHNjRKmogtbDqn8dXCcDoVopTGH2QZJVfld+ySz7ZcycdZeKQKT9aCEfOBNA472BMDHSRdfHHYPiiMsHc2uh03X06fKF144UzSSB7Jh4fZbqUd6t+1CqVS9+bCucBkysAAzHLdP2KKRZon3KT7YVG0cl+cfXc3r/EdsaSgrW9R1lSPDLfJn2sMAaxB8PvxmbaWyW9B9T8ZjrIjlBjFp+CeQETrdpiEH3DfowpdCn/YdSn+uM0I7Lr95Gk1zoN0sf5djyYdRkNLJhvqhsgB/2U+G3rM0BEpp6JrwFVfmLJzuycvG5vjvq25uXqUczpq/nYmKqWoRSbyzliN0F8lFuUIGZqqsKrQ7gYuS8ZAAvOTLfrPTSLbncRXz/aLGlr3N5+yKUs6EWvIYoJf7N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(71200400001)(6506007)(7696005)(83380400001)(478600001)(9686003)(110136005)(2906002)(26005)(41300700001)(66446008)(66476007)(66556008)(54906003)(316002)(66946007)(64756008)(8676002)(5660300002)(4326008)(52536014)(8936002)(33656002)(38070700005)(86362001)(55016003)(38100700002)(76116006)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?00W73vBkxIgYHW+QRpfgn/+wmy0aCsaa4/5h1Y2qp3SMBdSr1RTsZ54DXO?=
 =?iso-8859-1?Q?YfUWRWuElHINxmCc70vD5Qk9ekGe6eON1tkhhyCeAOfnQUI6c0D+4gZi25?=
 =?iso-8859-1?Q?Nv3WJrVsKNTWxZfAu6AsMn3kEjzqnFI0o8jeEPp/f9mNh+Hxwdv9aI85GT?=
 =?iso-8859-1?Q?qyWPq0jf4UiFDYYCA2VdeMG6PL+Nt7YWd+5Arhmg7htZLvjclVXuVk7F5Z?=
 =?iso-8859-1?Q?Mb2jXRyrbCPQGUrf2wEjDy6teJQx78fnGxss46gyGh0skK/dCW/246bn7a?=
 =?iso-8859-1?Q?Gjv99PWQ27i0fP5hF1eOrw342wFnAaAHSpwYgLQ2Vr1QYY9EknzfZM0aF8?=
 =?iso-8859-1?Q?9UCFxi70p47o3kwYU6O8xrJqwCe6jAG76IUCoYRPqzbkyitJ33Wn8TvN3+?=
 =?iso-8859-1?Q?mnOF8wwvnW87WC5ZsCBiaHaSmzflf9vGdTAyrUbx7GY9SLTgrfeZJZJ6ER?=
 =?iso-8859-1?Q?3WlPyWio74QzAaPMhcvGbCJ3i7Bj8eQJh1NaWa6IXypJMj7VlzeoRbkbKp?=
 =?iso-8859-1?Q?eo9I7MN6GThsRiBkXo7ZP3R4ult7TyO35NBMbuxVzv2icybamzJoz1F8RM?=
 =?iso-8859-1?Q?kOco1ksd7FpjD0Ml4dB4KHcLDJJdJqxyP8JNOHAmcUkoCzv27fFakjhD8q?=
 =?iso-8859-1?Q?0bK5FmpZHTYYaTH8P+J/mdGC7ADQ+AVsfqLa3OOXULie/VeZbNuA5rbwry?=
 =?iso-8859-1?Q?wS5lZ/cULiuUfn+HHjzK0YrP8YpmeFFjGRbQwNG7uGc2QOzgAGX1+KA0jz?=
 =?iso-8859-1?Q?gJaFYzMZ/v1xOkDW747yUYCETiS2K7lGiNxkmfQFkDqZdVJsJt0OJbNhj2?=
 =?iso-8859-1?Q?Qu4TLZkfkGc4eyBtLhDS3JvL5FSnvrE3bN4F15b51YXx+sY7yNzj6vd8Nw?=
 =?iso-8859-1?Q?LARBMWcurLGfG5F+AWCp//Czzs92jRT9xRjAfAXdamuNElw2nL7UNG4/GO?=
 =?iso-8859-1?Q?F5JIO6RoSUV6RCy5Jr3yyXef7GocI+Yss0BdriqUc9vb+qzkAox8/UxrYV?=
 =?iso-8859-1?Q?rp5sX1qu2rhCVEU1OSHiTc33RnTXCNQp0Ob7QkFG7HShcOe5ZH/pNGuyhf?=
 =?iso-8859-1?Q?p+iKZQLog4QhKQErUHU1GtBKzPWWk1+MfLoDODK+V0IeZKXt3NASdXdbhU?=
 =?iso-8859-1?Q?VYWs5AzLDRY/2COa+hHzfqWADtYIihRndGm4CG4NC7RVSE3qFf3yG8Im6W?=
 =?iso-8859-1?Q?LSiBS2hcW1KLp2XjhEOr+jq/zBbTN9gaUiRN5t+6SflXpl1KrGHT+IMOCA?=
 =?iso-8859-1?Q?04b3PCQKF6O5DbWW4ArQHwP7mXeeYFx/EZJ+VUjxk4T5YXfRyUMM7US01O?=
 =?iso-8859-1?Q?LgawPFMLQ+CAPqWsUfXlXi9WpBJD/25Evm2o4M0EsafKYocwrYmRCBMwCO?=
 =?iso-8859-1?Q?fqvHnGvo0Xt8+S9maufK4ewfJ6xmfKYpQgOduno7+d035a92LDbsCwKYyE?=
 =?iso-8859-1?Q?pElDiiLXpFBRp/lyXibTotT78Ebm/SQnwxVTd7O3JOkuyKLJPaVEvEopoF?=
 =?iso-8859-1?Q?M1g3MFtJv9wbzKJqG49dM2iJtfnMHafB6CXqT1ZZhgizbfhUX3RHVW7a2I?=
 =?iso-8859-1?Q?F2lH2FpTpbJJyekDFcw7Sn/F7TIsiEu09z5gQvsLQ2pPL6qljNZ8L+u+2G?=
 =?iso-8859-1?Q?06/yN6PUb34/i13V29IaCh0pi/vX/w8AVM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ea495e-2c76-44cd-f53d-08dbb077b2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:27:15.2157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LG6z6nkW+D7gg8CLgC9rGT5SBLPaW+oiYp5pE7NET7v6GLXRv0dKcAL+kU7fDSFgNbcGQlh0A4cuA6roLpeTAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3575
X-Proofpoint-ORIG-GUID: 3jAxrX-ExOG3--zcmSojwDZ4O9uC881f
X-Proofpoint-GUID: 3jAxrX-ExOG3--zcmSojwDZ4O9uC881f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309080134
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

> From: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Sent: Friday, September 8, 2023 04:51=0A=
> =A0=0A=
> In this test, "scmi" command is tested against different sub-commands.=0A=
> Please note that scmi command is for debug purpose and is not intended=0A=
> in production system.=0A=
> =0A=
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>=0A=
> Reviewed-by: Simon Glass <sjg@chromium.org>=0A=
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>=0A=
> ---=0A=
> v3=0A=
> * change char to u8 in vendor/agent names=0A=
> v2=0A=
> * use helper functions, removing direct uses of ops=0A=
> ---=0A=
=0A=
This change breaks pytest ut_dm_dm_test_scmi_cmd.=0A=
CONFIG_CMD_SCMI=3Dy is missing in sandbox_defconfig.=0A=
=0A=
=0A=
> =A0test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++----=
=0A=
> =A01 file changed, 57 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/test/dm/scmi.c b/test/dm/scmi.c=0A=
> index 0785948186f0..423b6ef70b29 100644=0A=
> --- a/test/dm/scmi.c=0A=
> +++ b/test/dm/scmi.c=0A=
> @@ -104,8 +104,7 @@ static int dm_test_scmi_base(struct unit_test_state *=
uts)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct scmi_agent_priv *priv;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 u32 version, num_agents, num_protocols, impl_ver=
sion;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 u32 attributes, agent_id;=0A=
> -=A0=A0=A0=A0=A0=A0 char *vendor, *agent_name;=0A=
> -=A0=A0=A0=A0=A0=A0 u8 *protocols;=0A=
> +=A0=A0=A0=A0=A0=A0 u8 *vendor, *agent_name, *protocols;=0A=
=0A=
Could you squash these fixups into patch 10/13=0A=
("test: dm: add SCMI base protocol test") unlesswhat that patch =0A=
makes sandbox test build to fail.=0A=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /* preparation */=0A=
> @@ -134,9 +133,9 @@ static int dm_test_scmi_base(struct unit_test_state *=
uts)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 free(vendor);=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /* message attributes */=0A=
> -=A0=A0=A0=A0=A0=A0 ret =3D scmi_protocol_message_attrs(base,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCMI_BASE_DISCOVER_SUB_VEN=
DOR,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &attributes);=0A=
> +=A0=A0=A0=A0=A0=A0 ret =3D scmi_base_protocol_message_attrs(base,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCMI_BASE_D=
ISCOVER_SUB_VENDOR,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &attributes=
);=0A=
=0A=
Same here.=0A=
=0A=
BR,=0A=
etienne=0A=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 ut_assertok(ret);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 ut_assertok(attributes);=0A=
> =A0=0A=
> @@ -207,6 +206,59 @@ static int dm_test_scmi_base(struct unit_test_state =
*uts)=0A=
> =A0=0A=
> =A0DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);=0A=
> =A0=0A=
> +static int dm_test_scmi_cmd(struct unit_test_state *uts)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 struct udevice *agent_dev;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* preparation */=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGE=
NT, "scmi",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &agent_dev));=
=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assertnonnull(agent_dev);=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* scmi info */=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assertok(run_command("scmi info", 0));=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("SCMI device: scmi");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0 protocol version: 0x20000");=
=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0 # of agents: 2");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0=A0=A0=A0=A0 0: platform");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0=A0=A0 > 1: OSPM");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0 # of protocols: 3");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0=A0=A0=A0=A0 Clock management"=
);=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0=A0=A0=A0=A0 Reset domain mana=
gement");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0=A0=A0=A0=A0 Voltage domain ma=
nagement");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0 vendor: U-Boot");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0 sub vendor: Sandbox");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("=A0 impl version: 0x1");=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_console_end();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* scmi perm_dev */=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assertok(run_command("scmi perm_dev 1 0 1", 0));=
=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_console_end();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert(run_command("scmi perm_dev 1 0 0", 0));=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("Denying access to device:0 failed=
 (-13)");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_console_end();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* scmi perm_proto */=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assertok(run_command("scmi perm_proto 1 0 14 1", 0=
));=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_console_end();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert(run_command("scmi perm_proto 1 0 14 0", 0))=
;=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("Denying access to protocol:0x14 o=
n device:0 failed (-13)");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_console_end();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 /* scmi reset */=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert(run_command("scmi reset 1 1", 0));=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_nextline("Reset failed (-13)");=0A=
> +=A0=A0=A0=A0=A0=A0 ut_assert_console_end();=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +DM_TEST(dm_test_scmi_cmd, UT_TESTF_SCAN_FDT);=0A=
> +=0A=
> =A0static int dm_test_scmi_clocks(struct unit_test_state *uts)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 struct sandbox_scmi_agent *agent;=0A=
> -- =0A=
> 2.34.1=0A=
> =0A=
