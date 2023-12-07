Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81B3C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 12:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C358749E;
	Thu,  7 Dec 2023 13:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=zoetis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=zoetis.com header.i=@zoetis.com header.b="YfuzBXum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD9D87209; Thu,  7 Dec 2023 12:00:12 +0100 (CET)
Received: from mx0a-004d2801.pphosted.com (mx0a-004d2801.pphosted.com
 [205.220.165.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD46870F6
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 12:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoetis.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrien.hernot@zoetis.com
Received: from pps.filterd (m0246506.ppops.net [127.0.0.1])
 by mx0a-004d2801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B71m4vi001900
 for <u-boot@lists.denx.de>; Thu, 7 Dec 2023 06:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoetis.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=z1; bh=l9IMg6Fr8iusD4jbUt6JezIIUrsp1x4Ja5eSmB32gTo=;
 b=YfuzBXumtWtsmkeL13vngpG3W6ABMe7VS6Y9D8DZhRM1InrEGoqcK7M+HkcDQBPU4PkR
 6rI52992YBekjWSxlUIEE+qUowOet/rS4GoBbFfgmrLoXRsqj5r04iLpVBqtrFL4R9Rv
 0SyXPdkj4lmM2y9+ix+N4dUh69GUCTwN3Mnvha5GyDm3tCYBhr5nQpJoZ2Py9gRqpiAj
 PvXW/A+X3aQFeG+tZFGhYWghq1cmHR5KLWiSoAqt0EFORqBkv7vVqUcZ0MqBNgcJejYX
 HynBntwWNKWJMvsqLKm1v69/x5CB6tnYElQHGjwFsYbwKp0m4rW1+H5mu0bTYvbcF8hV dw== 
Received: from azrclsmtpvm03.corp.zoetis.com ([52.253.67.248])
 by mx0a-004d2801.pphosted.com (PPS) with ESMTPS id 3utx0mm5k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 06:00:07 -0500
Received: from azrclsmtpvm01.corp.zoetis.com (unknown [172.17.248.18])
 by azrclsmtpvm03.corp.zoetis.com (Postfix) with ESMTP id DAFAE4BA590
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 06:00:06 -0500 (EST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (azrppalovm05-trusted.corp.zoetis.com [172.17.214.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by azrclsmtpvm01.corp.zoetis.com (Postfix) with ESMTPS id BDE4B40225C
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 06:00:06 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsHmZTy/OlroR6ZZDoACt3BIg1Cjd1pKVeaZ7HS6IFMqrTu4yreadHg0XV7DO5MMedj8MyTfGDduHVH7Q8E3xupgr29bApoMP/mSzndOHbgyO0CSvi3vimh7aDaE0+amxUgafKqHKgsPoua4Fec1waHRJZA4h154/2SSbD6EDb6/bIwPb9odvu1SgEkg7bWBgBOxRgukM0SWgYw3l1V+J+IRJBRGtZ8bnS7wSiKQq/htPU5rGaJPMM3sSoLHct98Qi/7KQgvUpYo9+6LPDMH/iYF2HfGDzEv9na9V0FVJukRbr7kZkDfUbJdS9kFc6FQ//sWmMS2FH50FGDWTGhy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9IMg6Fr8iusD4jbUt6JezIIUrsp1x4Ja5eSmB32gTo=;
 b=nQhDBLxpTQVk82c/liW0QeVhAYOimAXnDB8zhxnFk9rAHKtAtI1Ebq0s/nnXqni1kxX1lfsWz+cVDUImZpAI45qJjpIAY99rQyUtUkRKk1TyEeHoT/OYpIXXEau9KqSvSNmid/ID7EKZPL+byomFmlBQCkttdu0+v8eRGZbLE8xEZQMOMIqKVDo2+zSG4CPo0v1XR2+6Noj8dX4WKS+eO1Wc9cLPzNMLZrymjKRUtBxZFZuz9XoLqCbkuywy53+iM/NIY3Gwiohtb2DydC4Czq5TPVUeix5DUFc7PKmsOEXAI/yahPCXj+CYYwmaF6NGBU+mtDhR0hhcXXPdgApZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zoetis.com; dmarc=pass action=none header.from=zoetis.com;
 dkim=pass header.d=zoetis.com; arc=none
Received: from BYAPR15MB2551.namprd15.prod.outlook.com (2603:10b6:a03:14e::20)
 by DM4PR15MB5477.namprd15.prod.outlook.com (2603:10b6:8:b6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.27; Thu, 7 Dec 2023 11:00:05 +0000
Received: from BYAPR15MB2551.namprd15.prod.outlook.com
 ([fe80::9174:d9c0:7a19:938e]) by BYAPR15MB2551.namprd15.prod.outlook.com
 ([fe80::9174:d9c0:7a19:938e%6]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:00:04 +0000
From: "Hernot, Adrien" <adrien.hernot@zoetis.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Fw: Upgrade u-boot to use a redundant environment
Thread-Topic: Upgrade u-boot to use a redundant environment
Thread-Index: AQHaI24qkAd1TL4r0ky0BnaXzydlSrCdsiGh
Date: Thu, 7 Dec 2023 11:00:04 +0000
Message-ID: <BYAPR15MB255153EBB2B6240B31E1E5849A8BA@BYAPR15MB2551.namprd15.prod.outlook.com>
References: <BYAPR15MB25515376B1F7B285D2DFD39B9A82A@BYAPR15MB2551.namprd15.prod.outlook.com>
In-Reply-To: <BYAPR15MB25515376B1F7B285D2DFD39B9A82A@BYAPR15MB2551.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR15MB2551:EE_|DM4PR15MB5477:EE_
x-ms-office365-filtering-correlation-id: 4c298889-f7c0-400b-1012-08dbf713ab0a
x-route-check: yes
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESObl4jxWXs8/Qtzq3KtfdPSzUJ8h8mIIfQpcxw+COQULBsRVc1bdXB4DMkwBP4+Eu4igKnF8+jf7nK73zycnA/4FFV0NGinLmRG5O6Hn6taKLBZ3omndwqjKXHGWbS8+0/GaHPILIGp0skLqkmWwFNYrdd7f8zsRcTlWCEym2QxBwdbExAb4HsPwucxUve0mr/q4PauVLaqOklDmmTRdHVV7GeHbNXo+1gcxMVkcDIP165Zx0ib6J5yPjCDf4ylq1b9p5PQtSHZZDfN+P69/jCHV5xk4VJOv40iIeDIp75X5kFn5bZG+bSB2sM/JQptgtB3k8QeFJkl/P1lDew5MXscMSyieXfQNFKNkRnAXq4UN3rdX8gTY+BsVJCu2L8tQuBTrjPPguPhl0FnBw1chJ6h9MkBdn+86XILUAJiIk4hFEf3ZL4X6aGV2O4EvXtnoDJbKJYFdSOD0Ww/qysTwd0IidAbcHCmkdmqxIHAcR6+q+w1NjAX/y8YQ7yegC/C2CrTlP26wlaDGtEPaGdy/h+x/rG+NCGQulUWweeH5oEnGTnPhdspC81PrVoGsHDVs/uVM3IDGiCIxxvV/v3JVGtFR0mhTim6PwAcDra67UglSnSrjeZmUzw5wVh8LAFe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2551.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(9686003)(41300700001)(478600001)(19627405001)(38100700002)(7696005)(6506007)(71200400001)(33656002)(38070700009)(26005)(83380400001)(122000001)(66446008)(64756008)(66556008)(91956017)(6916009)(66476007)(76116006)(66946007)(52536014)(316002)(2906002)(5660300002)(4744005)(66899024)(86362001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5bvWNt2RAP6S/T2kF16Q9dQElW49yevkdPKvwYAqD0K0Ye4DPGxQ8fhPtL?=
 =?iso-8859-1?Q?gt+ECR1BZRUpCZiPMDgchuLSGqy9F//jGnIsTeFsF4x60ofFQmoCyVDGk6?=
 =?iso-8859-1?Q?omK8mcmdwnsV1bu8jP9bt4hsFS7wCgOgPQSvlodI71PmOzhKfWut2Fg+jg?=
 =?iso-8859-1?Q?wedfySpvDmE5YaqWlUCCSDx10BRS+5YNcB6D8FJJPW0djtB2c4nRXq0odp?=
 =?iso-8859-1?Q?RA2xW1NpN064Owhb5QOajXX6Y3DYtiqKP5HgSbjINSZSdNrd8waI7MqMRs?=
 =?iso-8859-1?Q?0XVJqs0JLgn0nOPIADtflIdgEzYMBNFgDwhW5TCG0PlACpZHjc1zM6hLaP?=
 =?iso-8859-1?Q?ACOzfsRVi2RrNPQ8FeFrwLipVSlq3QAuuozMJLMYMLHGAYvgc6mo3/QQXJ?=
 =?iso-8859-1?Q?TKDkX9fs5b9AnaTklvthtTFo9wkIS+TZRrxJ41W0RHKMV2n5SNwwNwIn7l?=
 =?iso-8859-1?Q?Q8NjSL0jgXfUJzDjoQSZ7XMF2TR+Yh9NCpKHayAugxWmoeGERL0QU0Bi/V?=
 =?iso-8859-1?Q?wl00FpqLa374+w08dReUtltIU7TorRBlFtNwGmfgoCnJejNynDs38Ho5fm?=
 =?iso-8859-1?Q?qc++epwSIVx2GrYQz0q+Gj7Ivd508k/WbO+Xuo0mGBUNywx4ARAeROusVX?=
 =?iso-8859-1?Q?IABC6fJtADg/PhOoyubocnLeaqNEF2poJkOqQAdlyfXeSEiJnl1LWje/k3?=
 =?iso-8859-1?Q?JRJa3ADZoOkEgjEprPTiYBB49OuuBrIvBv7NCjFcp+Fc/reHW30nQdI3P1?=
 =?iso-8859-1?Q?1Swlvz7vO33H1Nsw+IYQCMcQynsrFVlZFZiqtMhlK2Ezg/E5B0FwXTTsto?=
 =?iso-8859-1?Q?74/H+goQmshLA1Q8oURBGZFXWbHChuLbtJRx6AbqmKUNdW4yBwCpn3oNOi?=
 =?iso-8859-1?Q?YBA/rC8a2Yv0g2WduM/OqNWGxK4rAjXMfxFAH+kyKDSwkzi2vPZEF48tAN?=
 =?iso-8859-1?Q?HNfREzbtIIWC/e6O3xLCjx6XynH9qB8HCWiR5B2ulqSDfMZKE5Udkts4nc?=
 =?iso-8859-1?Q?lO22nk1hP74kflwgf1dBeAav2CPd4kkRshV7x8pM5OVtvEw0Q0tY6dZClI?=
 =?iso-8859-1?Q?DbYhNy67G4MJPGVYKwBdyAmQC1uXzAY1Uu8lebZpk6WjZlOxTCpB899QSw?=
 =?iso-8859-1?Q?0W6P959VdwQf02UzINsFIplME8xX3qb5x9nKkMzrkoggbhGylE5rc9Jh7G?=
 =?iso-8859-1?Q?Bl9oH3yfVQpNYuJHgmCFMMooHFtxvlWoZGu7CsLJh1AioxrpClflW5V7Rj?=
 =?iso-8859-1?Q?Hvx+wKDfxlEAm2lly0cJbE4s+wmzZzPubgJHrojHYJTP7hlWsIdB45vExF?=
 =?iso-8859-1?Q?MNfAygR6+rk3kZDG2aO9MEac8YSj03kn7BBwcxBIJLPEKH9k+VAGjVk1+Z?=
 =?iso-8859-1?Q?BDd62kxCQjQL/W+XWbZBKTmpC6Wnf43ApKAgE7T8Lu5qbMbzyv3r2QKunf?=
 =?iso-8859-1?Q?vSClM147gtuZA3m/BpFmUFco4Z8HwYnicvcY0DBPT62lKen/qAxcgIejbn?=
 =?iso-8859-1?Q?HGcTu6FPPrhDGNawMjyI7NehDtcEUjseljvk8JXtH9sYSmtFaViCDbUEzr?=
 =?iso-8859-1?Q?FOr6Fl2Uc0ilhmjVZkapSyIzWiaSQXjGGhFqINOQxOFHy1ak8uD6L4MIY6?=
 =?iso-8859-1?Q?NZvPGXjtkkmeHf1avhCm3A8AThG28okzYL?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zX/BFvdwWlCuvOfsihVmzCwqOtgZG3bfvK3+uNHYq8O6AUP/s1GSjb8Hk94v1Eqo5nkyDjJ1Ql4QFVCplnCans2Hs24B7NTEDWVz2Go3Xmett/buahEuTE7NyF/085vns9jDz3fVKba3P9Y7EUOuLhlWhw0sjxVMoicpTCN7q4v+FyFnJZIiZSWfy9VIYz1vRFU4GKMfHFM4l1PvsjRjysjv9laC8f5W9hR0VCsJMgKPjKxXapW0X1CPhBC2txxwni/FSObR5ObEcS+GOR3/lWXITuclJfIGWh0veB2K63LLrszWpCpTQgGWAqriSuG+OOS+/QKEW60jhzDPMt4UIucZUcMHkBhyfn52EYj11EZoMsxLmrZk7euqRxzlNXwtNOmc5GQfKTCkQadBVdlAeq7u75zEPzbTa1v8w5qyFeTKeYFZlwJE3OUq+Mhi8csW1Yj8KaVc1d1lc+pMeH91D2S07xRoHMI4+YRd1MvYoFjOBieFKqzZviK26pC8UEcI1P/+BXDYUvawVf0Guv74qwWE80VxQ695hHFh1Tu1w1bMW1wrWX7y7scIMJpVMZdBvMdrnJNxDuP76MbtCwELvRia2kpPMU+9/QYBOtDThqfCte5loTqO7IFO9xwt2nYYFTx8vDEbR0+YU3hL6NjDxY0zx13KGPk870vvDG1yx5JBDOloxXX1j3tS6i5D+X8nz5j2sTfGBS2UKCbrgwkMCDlPhvTOxfEw6IXw4CRIAqUrRX4IybhGirKome3mO6eMUETL01nAmAZYUbd6F1K/aQ==
X-OriginatorOrg: zoetis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2551.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c298889-f7c0-400b-1012-08dbf713ab0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 11:00:04.8661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a10ba484-6331-40ee-b0ab-cb737ca60a80
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5ih0Xzay1LQQmyDec1+x0RAx+M5ZEF9Exnn2sRL8csSU3u5seNPR6bGmWdY/PakPyJwA2PaJVhpOCytCrhx86PI+PoopT903aLifXPe2I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5477
X-CFilter-Loop: Reflected
X-Proofpoint-ORIG-GUID: bfyck7oY36fu0tYibzgT4X4mIyXTLMh_
X-Proofpoint-GUID: bfyck7oY36fu0tYibzgT4X4mIyXTLMh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=711
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070090
X-Mailman-Approved-At: Thu, 07 Dec 2023 13:53:10 +0100
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
