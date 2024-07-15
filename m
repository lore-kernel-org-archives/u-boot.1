Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C667C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DDF87F9F;
	Mon, 15 Jul 2024 20:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="NjLGzU8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F8188889; Mon, 15 Jul 2024 15:33:28 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA9F88820
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7926f054d7=benjamin.baratte@st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FChwId031567;
 Mon, 15 Jul 2024 15:33:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=STMicroelectronics; bh=U2GhB4QafY78A
 rYjzvXXxI9myWSgpZN/cToOIUu4ufc=; b=NjLGzU8mDg9Vl/7sa7x69O4lrnZNs
 gvZG51rQPJAdITnuXXWGFSztR+afn+/qTnbDkdXY6+za95xTI15r3oE8PKieB388
 puWzdEhjfygJHSgXf2DlDXRuTMmP9SnfczasCpC6ufUTCvIgDEkWfq0GAqWKEmIG
 NNO5JJquTldg/YM94bE0cdSn3cqFLZGFqG49nOPHkVEAhtqbErR9WjvthlJi3HFw
 z1pG9fn12KSb/fHUeeCn9awG0hmRuprCp4zYGEryxAL71SiPbQGiTklDOv5JUWuT
 5vCr56gLyv4Xrp/rX/p1ADd2WhFA0Adi5xUwYgw8VsW5tExDoVzSamoAQ==
Received: from eur05-am6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40c4hhvqc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 15:33:20 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+gCsNjkl2yJVj7GqEJOhM2UHvdp8ISREmi+H1+1TSwYIdrCwrYD0CZegsi8ZNmVJr35ZgmFC8jbyDHe0sZ1wePzqf6WshkzVFBzs8mSON60j3Lw0Z4zhVRuwEs2KOpvIU7VXmZHIaVK14MYRKYZBv/U74TkcGVG/D5/ToKmPYajOD3hOyRnWyCTw1qOEh8pMe1qKR4+8MSE124Ld680o/28yuj5q1MSBqqgvhCpQNEipyfen1EOMliAf4mVabJLHaunbfvyFRh0Qbq2aZH+jLcjGbZaG8tlswYyUi04Vz9z1kErvlEJi4ibEurb/wJyYlInwFbyZAQfZb7oSNbS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2GhB4QafY78ArYjzvXXxI9myWSgpZN/cToOIUu4ufc=;
 b=UmcpeNcUdTvT4gSXbYW2Tay6dyas+DWV/O+fkJ6rg6GndaP4YNehfsJGt2RvdM4MWAWRXhkMqbO/IESphVSJj1399Nf0nf3tRyRBiF21mJPNY8Ffq0VuM9nwd9yYIjpnhT5YJSL/qT0RvGcHnHr9hAIHaYR3qg2rXznBgbP7H/XVw0PlPjPYpnND+F2HIIgcdlDfwZtFR0/v+As0evgLnH9iH8iLS7ppi1Jr8ESBxmU3LaOpfF0OlEdZH5XFzYX0++65HAqGXR7r7cwu8vumbT76gzkaczRhl1zkB+8YqVr48XdPGqUiZ9oh3zm2BRblwmnqLfkiT93M6SHbFB1SCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by DU0PR10MB7120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:33:17 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:33:16 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "eajames@linux.ibm.com" <eajames@linux.ibm.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0 spec
 1.59
Thread-Topic: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
Thread-Index: AdrWuwuPmQIPYxknQiq5ajbKCa7YLA==
Date: Mon, 15 Jul 2024 13:33:16 +0000
Message-ID: <DU0PR10MB52445073A01A8668C66ADAA0E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=6cece400-f5e6-41c2-b6a3-b0dadae244c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2024-07-15T13:27:32Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|DU0PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: 7f0ec479-9692-4dc6-4754-08dca4d2af09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UGLCe0Rl60XG8RfFT/sjVsTiWuSgg09pbQAtyQyOmMO3KQIqNvow2xXkIeWE?=
 =?us-ascii?Q?lwdM5eyXv8AUlu40t1V7GQJzc2op32uoCXi5AQ6zLBp2YYIii1nR7YeYJ/Rp?=
 =?us-ascii?Q?tGYcGDwwj8a/C3tRaPUptTmBJrjR3WZvqyFyGf/b1wBGnZVwH4CxDgIjfpLx?=
 =?us-ascii?Q?DR5toAnHabpSazVKa3EXTqot4A/neWxyppKfUJ22Eu8GymJeHIQa6gpBjN7v?=
 =?us-ascii?Q?tdZpXOD6LPAbUZqCPlELVWv5befhfn2R0gX5DjMkhg9mdkKSDp1SR+m24jgY?=
 =?us-ascii?Q?KXOPvqARwbXIkWNZ+qXaD68aJgt/onWkrVZPWmnGLM2x5TgrtmnUjeHHfZ1Z?=
 =?us-ascii?Q?pEykgd6Pkpzm2b3TnvslDN8tKI+SvcpP5lMN9JiPdD0EEfljX2JnGwGI+G5g?=
 =?us-ascii?Q?3MxN4xU7GGCxGVYiUreM5Pm+/qJyTJBGNGNz3clEZAXdUeroNsgnkU8zB0GT?=
 =?us-ascii?Q?Cu5liuFaAx2X3M7BEebIeiG5YGyO9urXasQP9I24WtYXl5btZdQzLouj8Hex?=
 =?us-ascii?Q?xwK05DvBHRuG3CJA+Z02IS0E80WKb0s8gtRNuzVyedfs/1WPtYYsQgF11Br9?=
 =?us-ascii?Q?wBJQW8VJrqmoIZ8hRdkBT2z4vCIL/RcODnLcJ/tgoZEFWd/mWjwufww47gbf?=
 =?us-ascii?Q?w4RkyKgr82k1nB8E4XfFFcOSRtnn5Oy4c0rcZsoLWy9w/ssD0QjbqAXIFpmh?=
 =?us-ascii?Q?iKCP3lywg6GQ0jreYy2W5c8jIx1RNxlFyxVP0pMcMflj6F1U8UOrJg3ynbfv?=
 =?us-ascii?Q?eobP3SarhVbvZCsBLiIuOWDg76k7E1AxrPMtdnr2N0SJpN+hab9qK6Lr5MqU?=
 =?us-ascii?Q?Xeb0pnSdnsQkUB++NEzJUZvPr33RrrvCqiRI2ZJS+vDsYBDdGcKc+oTh7edy?=
 =?us-ascii?Q?UgIUh7Z19n/DVl3U0CZPUtylqhesMp95NL4959NSMmhuAWTjdtmu6+WoxbPj?=
 =?us-ascii?Q?5FCFz5ODHjzY4+g984RaNg+Zi6oyxKKV1s2gkukXoXlui9GRI7RrHiGb7OC4?=
 =?us-ascii?Q?zJOdFklAzEGQ/d+h0iIoKJm3roJikdthZSokRsUsENQ5a5MQyC29yjRC290D?=
 =?us-ascii?Q?TgJBwgvWc6rQ6EsPfHqF58sGYdHBU1xA4uGIqHJz9FWXVfJgW4FJr/JJTtP/?=
 =?us-ascii?Q?gy+NznN6C0ppPBnUCpcYuVvytCEl5ZXErRKaL4n+Hv8pZuQ6BgxfXMTwdSjt?=
 =?us-ascii?Q?MrK6RjwUCOUvi0EMdT0o/GlpGBJKglnonsbLzDnRCjl/pp9Yg3kCdDDJZ5ov?=
 =?us-ascii?Q?mZboaaSHrFMLVOPIX0LUfqVAfvkVSBarmLjW0iF+YR16mmJqkbJB+iX1T52w?=
 =?us-ascii?Q?YIdjS7hRkldPSoV1sOqjz1ZFMWf3lENkcFMguFLjZNootsmWvIPGAcbcKwA3?=
 =?us-ascii?Q?UGK0Txf73AiHXuy9tV4bX3YDOez1VCuwiBtiLL/49hMcxjpF6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qiGGP5GD1aQlt9Q9YCAeUIxDbKBw1O9kDMIUo82F5eybyBlm0WWnEJs6F9Mk?=
 =?us-ascii?Q?hWC2LUIHPEV9YHzDy/VVt5LMOzPCbafzjbtqETRPYzDSkvkwziIwZudxgsXv?=
 =?us-ascii?Q?bPuSBgFxGNdM0d88AjF0YpbEOjipTcA8QizrKzzcf+AP2GOWNKlyS/PsqfZs?=
 =?us-ascii?Q?zOI7cgccnUBR+fKh2pXajf+DgfCYIlydp0PKk/C7+6QOuZFg/BFHq+pBdRYm?=
 =?us-ascii?Q?td+mSzx0L7HwE45HNpkCb0+EbNC8yxWCmyy9gQ7rx7iMsaNqtxwinzsVffnL?=
 =?us-ascii?Q?DMSBqNG5akqTLdRVIKMQEMiuEDGGi8qFEAXimkdLGySgEatG5+Ri1j8Hq3Jq?=
 =?us-ascii?Q?Ws4A5n8sw5h94W4GsHNhuVZ4nGqTk30sWukk5bVvBSrAKcRsNDE5ohQqrhXK?=
 =?us-ascii?Q?v9jNhS+FwASK9J75P/dH5luFQRhmhwTZxsp9QO5dJiiXxdZ7BF2U7xvyiwqr?=
 =?us-ascii?Q?OTgUJlJUfOW/ld3Ui+GSuEFn4lytFLIQgj6L+Q8DnxviOmFpvUya+aMwUENc?=
 =?us-ascii?Q?mLeVWHcBn6GOBKk/nWh+2ZcQtivEJcwJIm0UhlhJgustL0ENV4rtmD+tp1dh?=
 =?us-ascii?Q?Lnp/2/KQ6z+Ua5hqfdX7753h5YSo/v5MIxCgSCt8APRjKTofgOMCtEE24PWA?=
 =?us-ascii?Q?TdSSlJJGl4DK98CzCJMPqavjN2lj0bawcxcySm9bojrp5JgISo7n4Tw7mSvP?=
 =?us-ascii?Q?wbKi8JE68xDQY4+lMjyeI433E3sSE6q/TbQycZXE5Bni4cOIMOnoaeN1864G?=
 =?us-ascii?Q?CiEX/pORUVagJ+FCzSYcyk4XtuCuoSvsPvFCgec5gTvHGWLksKe3H/wOasbc?=
 =?us-ascii?Q?ks8zbDtk/6BkbJ8CJAQXGqv70WSr9Tk3p6SX6u2ilYM9CoEGz94FH2wqsZZW?=
 =?us-ascii?Q?tDhJlmA0GgZFeWYJ67cWbFEWalL0/lN80JofRKwKPjx0urMeZbDM+6ot3uSi?=
 =?us-ascii?Q?zFRcb1tMZlQLeuHkWV/nFqi/ATW4zH/wvEHNBPxk11NsfXRVXxcCuUG9zvVF?=
 =?us-ascii?Q?Go/C7zDHXtCRbeqwKWMK22RM1mqkXmuaAi0rO+VE+egoAXtSdHL3NnPCtMH9?=
 =?us-ascii?Q?Nf84VZfbHqX5wXVoZs43hzY/HYUKU4cJsOPxd4PG5fSOAocrThxfCzaS1gL8?=
 =?us-ascii?Q?hw/Sfaq9OBXbysRF3y46G7lw9CV1uyXEi1MPUixBnwKrG3wWaGd398OaIqrq?=
 =?us-ascii?Q?SbfQNNxLyvf5iweJGBph8AGuT+IFan9xygK56T5TUY8KbyLArbhLcHr+qKpW?=
 =?us-ascii?Q?utHXrpcjmOk8RvcaSyOTM+Lu12HSO2lPRMAY7nTNZr5+BiRqfCFcuuSKgk0C?=
 =?us-ascii?Q?DOSS+rnQRwHcNU+JnBHo8QsYdQC63yp7cnsBg5kOYUDjN/slUhqtgat+Ro5G?=
 =?us-ascii?Q?FZR26KlBlCf1rFA4Fj/p/DANED8msRKQ07fQNrSkfflDH4RnhbIFcI0bQHAr?=
 =?us-ascii?Q?AlL0PH/KkPauXGjGmDPNXzvYbL8e1OvbudiUWKS4NkNBEKJIVfDajKxyc5nL?=
 =?us-ascii?Q?mbiNkdCOwKEimVUmWcDALN6dvAwIdCiWoUPtog38SxqSvwzveSQxYUYZkx6s?=
 =?us-ascii?Q?hwAczOkpk6Xj0gA1yc2yQVqP20K8h2JkUCo+KP2W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0ec479-9692-4dc6-4754-08dca4d2af09
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 13:33:16.5995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0hKEtS2mOfMnyVjjpCbLOTEtUzOjL825EcTteKWaUdT8aiIF45S/Ecaz/TFw2Rw2dVt3vQ6SDit81eiz/fb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7120
X-Proofpoint-GUID: -zq7xQ25-9O9nXfYAPav2-A-WYi5sOhF
X-Proofpoint-ORIG-GUID: -zq7xQ25-9O9nXfYAPav2-A-WYi5sOhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150107
X-Mailman-Approved-At: Mon, 15 Jul 2024 20:14:57 +0200
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

The hash algorithm structure shall reflect the TCG specification for
TPM2.0
With vesion 1.59, the SHA3 algorithm has been added and shall be
reflected in this structure.
The fact that U-Boot does or does not support SHA3 algo yet is not
relevant for this structure.
It's up to the end user to configure the active PCR bank to supported
hash algorithm by all boot chain component.
Also, by default, TPM2.0 shall support at least SHA256 and SHA384, in
practice dTPM support 2 actives banks with this 2 hash algorithms

Signed-off-by: Benjamin BARATTE mailto:benjamin.baratte@st.com
---

 include/tpm-v2.h | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 4fd19c52fd..9848e1fd10 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -253,6 +253,9 @@ enum tpm2_algorithms {
        TPM2_ALG_SHA512         =3D 0x0D,
        TPM2_ALG_NULL           =3D 0x10,
        TPM2_ALG_SM3_256        =3D 0x12,
+       TPM2_ALG_SHA3_256       =3D 0x27,
+       TPM2_ALG_SHA3_384       =3D 0x28,
+       TPM2_ALG_SHA3_512       =3D 0x29,
 };

 /**
@@ -271,11 +274,15 @@ struct digest_info {
 };

 /* Algorithm Registry */
-#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
-#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
-#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
-#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
-#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
+#define TCG2_BOOT_HASH_ALG_SHA1     0x00000001
+#define TCG2_BOOT_HASH_ALG_SHA256   0x00000002
+#define TCG2_BOOT_HASH_ALG_SHA384   0x00000004
+#define TCG2_BOOT_HASH_ALG_SHA512   0x00000008
+#define TCG2_BOOT_HASH_ALG_SM3_256  0x00000010
+#define TCG2_BOOT_HASH_ALG_SHA3_256 0x00000020
+#define TCG2_BOOT_HASH_ALG_SHA3_384 0x00000040
+#define TCG2_BOOT_HASH_ALG_SHA3_512 0x00000080
+

 static const struct digest_info hash_algo_list[] =3D {
 #if IS_ENABLED(CONFIG_SHA1)
@@ -310,6 +317,24 @@ static const struct digest_info hash_algo_list[] =3D {
                TPM2_SHA512_DIGEST_SIZE,
        },
 #endif
+       {
+               "sha3_256",
+               TPM2_ALG_SHA3_256,
+               TCG2_BOOT_HASH_ALG_SHA3_256,
+               TPM2_SHA256_DIGEST_SIZE,
+       },
+       {
+               "sha3_384",
+               TPM2_ALG_SHA3_384,
+               TCG2_BOOT_HASH_ALG_SHA3_384,
+               TPM2_SHA384_DIGEST_SIZE,
+       },
+       {
+               "sha3_512",
+               TPM2_ALG_SHA3_512,
+               TCG2_BOOT_HASH_ALG_SHA3_512,
+               TPM2_SHA512_DIGEST_SIZE,
+       },
 };

 /* NV index attributes */
--
2.34.1

ST Restricted
