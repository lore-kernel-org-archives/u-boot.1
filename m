Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F211EC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0561787677;
	Thu, 30 Nov 2023 15:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=zoetis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=zoetis.com header.i=@zoetis.com header.b="h4AYszSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2201486E2F; Thu, 30 Nov 2023 10:22:52 +0100 (CET)
Received: from mx0a-004d2801.pphosted.com (mx0a-004d2801.pphosted.com
 [205.220.165.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61DA8641F
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 10:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoetis.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrien.hernot@zoetis.com
Received: from pps.filterd (m0246506.ppops.net [127.0.0.1])
 by mx0a-004d2801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AU3sQar014759
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 04:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoetis.com;
 h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=z1;
 bh=22wNlTD19HtvXPoxxsxZ0fYO3SqNJPLRNaxj0CsVoEo=;
 b=h4AYszSdAwV5+yG1SbiAeKMtmCp+ekNPc7ePUoyv1FLaONl7Z9RD6XxQ6uEdqW0bgxKZ
 1jawuJYVrW4HsU49QBicDZ7vfPUmg/23OtjYOQoIbR9qBlZClYO0cbVFuJ4UEPk64vOR
 aKX4rOamkTmcMbc/k+CId30ao+V2RS3jFpc8S9/Bl3IbXCVs3GKL6XkA+sDXN0O04Wdl
 ULzDpNoSoEHTuoYTer/tMdDCS8Z4iU6VksUBAkwKnyl3Ikovq90c0X65adS3zN0rVed0
 dpx9/wP0sDuONkFHGrB7RB3P9ktWQ7tbGJHdWsGLXi/JDV9sm3wewtyRBHMVQmafaLQK PQ== 
Received: from azrclsmtpvm04.corp.zoetis.com ([52.253.70.235])
 by mx0a-004d2801.pphosted.com (PPS) with ESMTPS id 3up8ggd8yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 04:22:47 -0500
Received: from azrclsmtpvm02.corp.zoetis.com (unknown [172.17.248.26])
 by azrclsmtpvm04.corp.zoetis.com (Postfix) with ESMTP id 89F8D84ACCC
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 04:22:46 -0500 (EST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (azrppalovm05-trusted.corp.zoetis.com [172.17.214.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by azrclsmtpvm02.corp.zoetis.com (Postfix) with ESMTPS id 7536A84B193
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 04:22:46 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTO7PWjSc8dZNLduHzpXJNRKtncSpCf2AoEVZ7eiZ4TPum2QWe/Kv0/+FKP+jb6xfMiyDKYUUV/tR1UcIJ8+MDwN0HmuGVCUa3UIm2cPKNgMnQSXeyleyMJIE3CIRgLjWR8uFUz4HJdqckb/+o1V1RDHSx0d2Tpr7WRrQfsJJBss2jN4HLLgtVp4FRh0S+hvc/Cprk4SJDwy3BM4KbWGeEiFmkl2Hzdgql0+QScnG8hbjKT2AbXeCyfUOrrdfngPKLQS2lyCkYUYhkyzHsEmNczQ/f5mCxwnAi6jnysdhZo61qUw8b5PUk7fIotSqSI89JIoB5447rTSKX9HTXIlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22wNlTD19HtvXPoxxsxZ0fYO3SqNJPLRNaxj0CsVoEo=;
 b=XQD1jqGdBYVIj9K3raGid6PknGU3A4Cs0bQYXV6nomr2N3BlX/hgPAkQ+uHL0tr+ccfaDLYt/GJTS3NhmK5EkUCEuQFmVHH+qaUx0J5biYZJ8AwITMMLIZtV48zyRjNEwVBHDcCKqmcLYmi3mc42gkvG/GSPmLVSeHCz0cz2FFdOYlUjhkZv4jkgHYWossjzqb4xLiO/DJ7P0eqPTdkyjp5xlqgFuUKiK3sXlDTVciPhv4lBw5UZ+2QEWwx0HY/9BwRFsT9UZm2BcYsK70J2WPwOHqhqSurmtIe+0GGADDaSTsSf25z8sKbualQygi077pl7KvERWFNTuxeJDUu+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zoetis.com; dmarc=pass action=none header.from=zoetis.com;
 dkim=pass header.d=zoetis.com; arc=none
Received: from BYAPR15MB2551.namprd15.prod.outlook.com (2603:10b6:a03:14e::20)
 by DM4PR15MB5504.namprd15.prod.outlook.com (2603:10b6:8:88::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.21; Thu, 30 Nov 2023 09:22:44 +0000
Received: from BYAPR15MB2551.namprd15.prod.outlook.com
 ([fe80::e3d2:27db:5e49:7be4]) by BYAPR15MB2551.namprd15.prod.outlook.com
 ([fe80::e3d2:27db:5e49:7be4%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 09:22:44 +0000
From: "Hernot, Adrien" <adrien.hernot@zoetis.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Hernot, Adrien" <adrien.hernot@zoetis.com>
Subject: Upgrade u-boot to use a redundant environment
Thread-Topic: Upgrade u-boot to use a redundant environment
Thread-Index: AQHaI24qkAd1TL4r0ky0BnaXzydlSg==
Date: Thu, 30 Nov 2023 09:22:44 +0000
Message-ID: <BYAPR15MB25515376B1F7B285D2DFD39B9A82A@BYAPR15MB2551.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR15MB2551:EE_|DM4PR15MB5504:EE_
x-ms-office365-filtering-correlation-id: 20a7dbaa-b641-432e-6b05-08dbf185e935
x-route-check: yes
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLg9UEfw3jP8ADW5YuGUFEybhNyDVOSd7H0YqAZjAKT26uAzdX9tB3KghZcupbtqvxzmPH18UyHRj1Mg3+oNjEwiDXCWVHd4glu9RAOpnpraZ7uh933gMVYksh+9YEWQjse2Loxa/6gJ4GaOOLOOVbXHg89a1BlfG3KfW2ZXkPjfAWRNjZxniaht2zjcOB+qpNJF3JUxugnvtXW3EJ8WmLmpIJUBFle0CZsRJ/WEUEmE/rtSg8b5ar1Jqc/a2cuV5fhhHOZpgYvwkM3prjslWu861OOXRGPLF6hFi2DXBb8RxZL3yxYwB/VRo76/jGErQsgu+2fq39PGOa5bcg0M7I3j/z0VtouJt7dZfRNc/Ucif+cIg6BUg6W5/2qsCN5hXkWi0wWh4G980UC/SX7w5551X6iBkk/RnNExPUvpzCxMMQVuZ3fqRGr5/C91rgD1hwLQTXv2YTzE5Bqx8GKSj2+OXikXyMRl0w0rb29NSzlS1XieAMuMDdwQaZtU74OHFEm9/63PmKDGF5cUpZdbc6eneAQTDOPozFrPVSx9F/5iajkOcW3ZK8e2VVnNkDySaft2aFvn0Zr98Fg5W2EHSFEL9N0u0Eqjf98cdz6mjlIn2ujx201JdsJ50RTYUgQYXZZh4hO1qNylgqR+1zfdPkmnrwGtaRlN9I/LARB9Aek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2551.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4744005)(33656002)(2906002)(4326008)(5660300002)(19627405001)(52536014)(8936002)(41300700001)(6916009)(316002)(64756008)(76116006)(55016003)(66446008)(91956017)(66556008)(66476007)(66946007)(8676002)(478600001)(7696005)(9686003)(86362001)(71200400001)(6506007)(202311291699003)(26005)(107886003)(66899024)(122000001)(83380400001)(38070700009)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tj5UzZUo+oKsDbMSG8DRMRoXk8k+Qv4atRZ8fWJxmHsf8ilCTi798y2Jb9?=
 =?iso-8859-1?Q?fRadZLcZqeTKFT882G704fmU/cTtaQxRyWbRXZ+UcAGz6QsCSn5LB5WHOe?=
 =?iso-8859-1?Q?kqDaR00fRccnaPHvecPvaFAxoqNRv0kcsV3H76xI8FpE1ZU7/SbVLbOAd0?=
 =?iso-8859-1?Q?upjGtJny/loALubRkuqY/61nn1osAQBX48Y6oIVbSelq/UNuPelq9zHaqf?=
 =?iso-8859-1?Q?zq5ks6iZ6Eeq5RSp54fTkurMQLX/ZnSFRNWN5hxKJwoQeI0BcTbIU7rkay?=
 =?iso-8859-1?Q?6F02LcOCkdTQwpBagrxKNbhNV5SEPJMCk0td/g0wAOWsb8T4gVQMrMDgkg?=
 =?iso-8859-1?Q?UoLwJ5gPVi7PvUeB9eEenKHnt18OND4DIPVQmjueY+YQwJ83+baQewW4zK?=
 =?iso-8859-1?Q?bV0reDfyfyXSY2TWdo/uByFJouTHJ8wbjF5A5Q8dpf8XOv8z6Qgjb6oSiO?=
 =?iso-8859-1?Q?rtZfCpBghcMtjVB+XhANts84eyy1jtL3gCvN238dVRmih74rmeObseEvZp?=
 =?iso-8859-1?Q?wLIv5Cdk8l91ygiqiqPRlbP1WDWlCtZ/GoBKS0YaVWfbIqCAHqPfXdnDq1?=
 =?iso-8859-1?Q?Dbg2LzgmrhTXI0a9dLtimw4A0okXDpsqYQD7WBPn0oiwjDOD/iadruW024?=
 =?iso-8859-1?Q?fmw7FsMXAHv7PRi6NHewk2by7tK5dMahpnwcohE9USqigabOvzsjWfXk0p?=
 =?iso-8859-1?Q?zu05oYBG10CcMpJLRq7olVmKOJM2Du01m9u13XlETatzol3sg9SCCH1jUc?=
 =?iso-8859-1?Q?hycwIhEEFKtKTtU0yZu9H/ZvO0+eJVa57zEpehKdWJBkTp79W7QKXgYVMf?=
 =?iso-8859-1?Q?5AnSIG20/0DVu+uHvxGtcZtWegn2qhoRKkwl8L+tziGT3I673atbyoUtwC?=
 =?iso-8859-1?Q?KwrZnPAAYnOaHyzbuKRcUvc8e6UEvdAKv0VskmTTfB7lDJ2a+NvSrqpkp/?=
 =?iso-8859-1?Q?cglydcgKW46rx7wo7ve0AzJChFGUinomgowkxq1nWFHzgxvlaUolawJwFT?=
 =?iso-8859-1?Q?0lvhcAMZq+eOWivXfRSL2J6RC6Ivk76voFHaQ7BzXjNweqwRN4KRPd6Xs8?=
 =?iso-8859-1?Q?jI/rnYSo5v6pLZUV6R0tsRJ8LqUqgBRhU/AztXQknuCGHsk2J+ctkfRXUL?=
 =?iso-8859-1?Q?WhngGmzr2BLpE2osw7a5JMPDshK2gIsTjCKkEAP127mmDFiGTLSb+D9tr1?=
 =?iso-8859-1?Q?ReZvpSvKko3ESWSY/Nx5ePndFwJT6jqLj0mE/e6tlNBPY3R04zPS/wwv1b?=
 =?iso-8859-1?Q?XQY0PDb/pT5mtMQ7sOisGGbSdvECnmmw84fB76JqUvHvwpIeR6icUf4jao?=
 =?iso-8859-1?Q?vQbmnvdllaW1n+NeDIjNUTyCkuy8vBhncewl4fs0LKH9LcGHmJKVRT/tfc?=
 =?iso-8859-1?Q?oqOlrtD92ALs9B3DiCzNc1mGuuwQ1PnTlSx5JdHlsMAB9Bg+dJRv2bJdXy?=
 =?iso-8859-1?Q?Rc310ofgCSNL2e9Y0cmfp84kJFTPbwRL5TgygOFaKDedeNt1EBKh3Nfti+?=
 =?iso-8859-1?Q?RDRBEpIBDPUij7uoy0pSgGSUUxroNCe9PAtJ5AY0LP6Bo1JRHesDT6srRv?=
 =?iso-8859-1?Q?Sq3J/KOf/BNkKgTNFtKFpEZKUOcTXCOxAXd8dqvcgvlWy8pI37OVpVlfoo?=
 =?iso-8859-1?Q?YSaPUYQoFJQ/5y2kxgjqOYZkmx1lXN8l28?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e+C+xtnq2zZrFn9PVb7mQ1/I9NaclIFD0B2An/AW1o1m7k6kvSlKy81RNTSaJllrFX+O1O27m2r4LaSMHQaDdTwNsNfGqAO4LMZ/ygNFpbn2zs0rT2+L1mPm1ua5G1t+hph+EHqrcB8FNzQTdOuxdyIt6BfekzsUx8c//4KDEPWPqZ7je9HumrQyjKC1nwA57qyCmotRLhfBMXQe1sulsm11B8IsMFiuO6ltP2dwlUn+FGuD1dNbczbmESfLb+0ER2CObcuw/U4NBY/nk20DopiraqycqLMQP0HUQZz9Nv3vdt1qrP20S1WuxYArTpx2OxNQuPu5XbHYLMEYX4LEiglL5kziYLFl1w+Rl+NutGcuqKA5YLnz0zXJiPlPeemvbqT1qg9oXQ6JUiEu/s1fTwzNb9pHdUY11zTeEIP/lPc5dJsW/WXrpHshrvDQPbesnkbIR5tZQROkJaou3HLUYQjvw8k1DVF6rri218vTTHvLXwOkty03vUmllYxRba25Vnl+Od/Nkoz5sCfQ/VLrCI7niqgG6Ho3Di+iTMjYGbc9IDWaGGrNXt1T1CZaWylVdg6YNFoAdxOJjVacm331dAY70W95KE+Fj6yDegx/BTBHPl0ibBEuArs9eUaLsp2jkIeVQqdlFQgqDjTNnGiUzrPCOsZO7EMFkp2WfegGqCpiNWQwjiPdVvMOAgjbGq4Zzlh7EJZVneaZjIDOXQaRXZ/KQA+C5FgbOHio8YtIWXheYX2P0MxqrAtigK+2oyqKeyaDZNc4RcsGLmvW/rxx4A==
X-OriginatorOrg: zoetis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2551.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a7dbaa-b641-432e-6b05-08dbf185e935
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 09:22:44.8162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a10ba484-6331-40ee-b0ab-cb737ca60a80
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9qCMBEr7kvb1vtaKcHeSoJjNv6LcB1+E8R7KhWOFZv3BFqX8le75vVcY+Rv6UKlEiBWNzKnBNIXgq8Gwn0WFAhctnrj22AazexrAQKE1qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5504
X-CFilter-Loop: Reflected
X-Proofpoint-ORIG-GUID: dG5ijJDoty1j7eIHlyTEY2xu7SnDXHMH
X-Proofpoint-GUID: dG5ijJDoty1j7eIHlyTEY2xu7SnDXHMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_07,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=580 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311300069
X-Mailman-Approved-At: Thu, 30 Nov 2023 15:10:20 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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


Hi,

We are using u-boot and until now we are using a single env storage on the =
eMMC.

We want to change to using a redundant environment, and the way to do that =
is well documented (thanks for that).

The problem we are facing is transitioning from one single to redundant, as=
 the format of the env storage is different (redund has one byte flags righ=
t ater the 4 bytes CRC, at offset 4).
After the updating the u-boot binary and restarting the machine, u-boot CRC=
 check will fail and all environment will be lost, due to the format change=
.

What is the ussual way to deal with this?
Is there a tool to upgrade the environment blob format?

Best regards,
Adrien
