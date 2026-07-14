Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21998C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 05:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3695184B4C;
	Tue, 14 Jul 2026 07:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RpZT78Jb";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f3/cE5Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F3684CBE; Tue, 14 Jul 2026 07:24:45 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30A8A84B49
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 07:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E38idb1087126; Tue, 14 Jul 2026 00:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Tspm0rxkoSkehingBNwWV+U4h5ReOgrdaDK/p2G16
 CU=; b=RpZT78JbL+MfKEfbo881h9DiU5GRniCoySnLi2zXb5NBvFuoopH42W2ca
 fvCY/FgzC6nuPmmNSjfcM9Y7Kszr6R08U5M517yAqXg3SvQ+l3a4WJP+R+Vj0fzW
 UY9XwBVBsLlXtIZdeOk0sDqxFvU8HWdNMKrNfBsuQN3fYAT2tpYIvTbVqw3a8wPJ
 MKejoBCuXrnIkrb2bYKICUs12xKTM6t8B9ToFPzcnUL7kNj/hFjk+PVHli/PP//8
 glu02kGAc3t/3orEz+2N6o1+0a4wXm0QRoYfeRLAkAG04zHCSI3hxEglNb7/ihkR
 dAAOy5lHMbJ3/amEkGk9Nvm7BHOyw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdcwu0gkf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 00:24:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/+lLlD5YGT642sjEdVyM9Sp8XJDrrry0oYVmKKhFHVOufmjB3Lwk9os3YAwc5TnAWC7pKL3pNCBKi9SGjghdQ+9OH5KnxB/9lmEMxzWDy+yPw/uuM4xtesuSsD9rXijAH7d5VJtcP8/CwxAVsseRI8usSbazSlkw0hKwsH5xW1tL/TI6OhO9wagK/Wwh0btouThyUYPycZdUgZfIexeE+MaZsxt5f+QjWVHdqtjX0gbleKRdc5XCkyv6iZlzwwRHluM+DxoU1uHp8HuQ2XzQDjzaouZAKK+SNXtIu8VVGgJLcwHS5PgY1XcnAx3H79+YfACiYoenDk7Zg8xWeaMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tspm0rxkoSkehingBNwWV+U4h5ReOgrdaDK/p2G16CU=;
 b=qXf7VL7YdFot5HkxH9Od9g5B+Q1leCbDwYiY+P3JHVX0gS9rTj2zxHNqDJCofZq6gmlpV3PHIuu8D7Q4jHp+Tb2gzXiOU9gH4O7MKDMN5zUBTK3/+q73mviowqVy3SEGuw6UaAyuU0bEpXHjlIwtRkNdR+Bvy0kWRK2LfV1p+2650l3BN9pOeA3iRJ3Cqj9KggksUmK8aousbLHaWUm0eMqnzrQ0Chj6ItXFwjLvBXVOlk7u8vhmjZ3wwKKwKyQMI3UGyHKo2L19TQb4pW0rSbbL1vedo4DV/f9iyy76F6ec9L5dseYTYAjAd/x+QtUXdt+/9Fhe9xlGwF7KgoqGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tspm0rxkoSkehingBNwWV+U4h5ReOgrdaDK/p2G16CU=;
 b=f3/cE5JqpFNqh5d8tin8YdEWkJ2TpFOdog/oJSrCNtr+HU/9XTrYSm+NYXrkMuMbzm61DscxSwh0WYY2FBhc5nI3v+VCNkkC5IuDq13n9o2eCxjryjg42UgMKr4ePe59YuSshnzgWdtuNdQ7MaEc8TZOmSMWgk7UAPljcXBgiCw=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by DM4PR10MB6134.namprd10.prod.outlook.com (2603:10b6:8:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Tue, 14 Jul
 2026 05:24:36 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::2b) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 05:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 05:24:34 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 00:24:03 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 00:24:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 00:24:03 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66E5O2eP3352316;
 Tue, 14 Jul 2026 00:24:03 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Jul 2026 10:54:02 +0530
Message-ID: <DJY1KP97NN91.2F605W5BR722H@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] tools: binman: fix changes not being written to source.dtb
From: Anshul Dalal <anshuld@ti.com>
To: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
 <CAFLszTg5Qu3stt8AkeBpWibTyYxp1tXAern3aLE6MEHkHmVRyQ@mail.gmail.com>
 <DJXETQLM9PQP.C2LCLMD6LMI@ti.com>
 <CAFLszTg4hhLezFpkvkHY9qK_WQ8xfcRi8AWx2RcVkAeP+RPMvw@mail.gmail.com>
In-Reply-To: <CAFLszTg4hhLezFpkvkHY9qK_WQ8xfcRi8AWx2RcVkAeP+RPMvw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DM4PR10MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d13d71-9911-4fd9-302a-08dee16830d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|6133799003|4143699003|18002099003|17002099007|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: yZ/QNYN+zHDR/u/IUcMLws3ghWuIqIKMq7KuSG2YdkX66h10iIbwYXK60xz8+Besbr09bdzT/sMBPimQ4buWTnHRhCNAkiytOyLSU5gut0OMD8fS1zxukJ9RkhMa7aNuZ6aKa7TWf+Nn+ySn+IFLakSX2t0MyVgGSslGSp1l2F4fqJ7/WcWUZikSNmaxXSHZ3jlBjajMR2zCRLSO1+RW5J8cyDsoHMRR7NXP5tbzjqtoCYAMMT3JkZDGmqLqFF5ny1BYoqFmpZFByaw9PJIY96G7bXK1+MaiTkJCtUbXx8gRJDUjJ+6STlwVpwdjGVwpKgh+eYP+AEDJfXMslwA6JrFLVCD7CntVy8OfH9P4VXpP2HOD9ggBIS4A6QEsQqAxJbww6h/AOVejFVU+93Ka+arS1/lrT5xud1YAEZy8hNj69pQpJFT3GrwdEBhhxq5/k0YUI6CwRpmDTDnKHgxz1OQGo0GLg1ahcD3BSIFtBa1x84b+wQuS0J6lUuZN+5BDRKvYfWp740eJlnPhWfND7MO1vrE5NsnDuNKmvM/aOeAOYYbdqOyIecqfDNLDe8t1CsSPHSAMHE/9NBL2lGZOTC21xXPU15zKzbTd81zaDHog0x4HbEqoBxQeysaMSgon1h85vgfpi//iTHYPb5Hd6/8qsy2S5l4tunZCU6iFeqaYheRpvPcxCCVWBkNu8R+MA8scJV+0ihj+oBQoebl4MQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(6133799003)(4143699003)(18002099003)(17002099007)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nX51sSXpGEj/iwe3wELhKonMV78x01j55GP5my+3Nl0pX6wx32Ktj4GqKV2W52rdICwxcwi8G3eFeapSV03bQo9vVc3FiUPZ987fPdIMZEV7TUfOpCoooFZj+63aRKfd/IVMp5p1nKUv7GBdTvHbbZV1Oc32pWwkdRHvpMdcnzseIW8K7cCxatvQBmGgCFCm6SbRxYpxBJ7sq9MYtkB77o+fqAAbGJ13O366SgVwIbyhHjrfmL8V/623VuzwD6MevHq9ZIwDfO839ZlbpbNUlc8Igovvq9jaO0scfUxXDmsNRxOreTwVN2FgjyFXZunSbbr78DUDcRt0V7+mT0v6HzZkYfDT0MKUolQYAwbXxE3hYeYmWhCFfPfrWKuCsjatp6JdYg899vKMc2LbU3mJ7HQpplbXrWsMbeQj34+ONUeb+17DcNv0JxOTHk3dPla4
X-Exchange-RoutingPolicyChecked: g/A15JouJTnb4D98fLXqDFmoZ5WY/OMac2VE5Mp4APofcCQYiothciroJgUpUQk4YIzmchI+O1uPoFz4U4UkHPVYRw5FKNX8mZFWvmLiC9Mi1AvAA0PT2AhitqNSNSMAscBeG29GDwUbiQTQvaXwRyBQtYTWrxaCsCh21PSy/st2gJjQOIaoqbO6lL+KdGNXaycjJYBJx14zdoIxvJfY/hg93o8aHZyMHhIebSP+mg1rpVdleB74TUQSFL2+m4ME3nMbQkLbxNmXQrtgdguh/6hAeGKva99UvM3somTpy6aLtcKf5RarVqDyjDCRA2wAcZBJ5LjeEb0VsnhuxgMXlA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:24:34.3999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d13d71-9911-4fd9-302a-08dee16830d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6134
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1MyBTYWx0ZWRfX9Gp8krT9ZCiX
 6x0MaPQPY+6TUOljg5ROkw5K+F9sgykxylaWycTE+M+DN40rJnry4n+anMU9HaSTMpJUyaECzp5
 fKkp6WgRR2ljEgClYDU2KaTgXM11MVg=
X-Proofpoint-GUID: pZ9Pz2Icg85EF_BJGB68ezCk_kK-SzAw
X-Proofpoint-ORIG-GUID: pZ9Pz2Icg85EF_BJGB68ezCk_kK-SzAw
X-Authority-Analysis: v=2.4 cv=LvWiDHdc c=1 sm=1 tr=0 ts=6a55c817 cx=c_pps
 a=9qX6K/GtqWsr64T/c6OOlw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=wIc7PlybEO9OI9lC9b4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1MyBTYWx0ZWRfXyU3Bn3UxL0hS
 wma8vq5pvzxSZ4VKR5pKxXpOooFarlp0eWBowzz0cnFIxzvr3VedCyTlCUR0K3zzF58ZCEYLf5w
 yVYYPM8zDVDGHU1P+tKZIdWCaad3fcfbTojwqFNVOFoYuxjAdcD1n/vXDDnKBOOaOHU/VTLvcVO
 gHxoyKLhYZcAR0ou3JuhzVGKzOvu1Tvt64G4skCDs4asGFwWTVIkVLmSWFG4FPpNmmSlLTNPbt/
 iL/IhftjYUyuJ/iYpisPAm22PT1lYYaIeTpJnhmrEU/xwlyPRDN2bcbJjHNIk23DAohJKKbf+k4
 6dEesp+iPLHVOALCsoLJTnJj68EwZxnyS8tzUAzIfrBkhsCaX872Ix+tOBVrAyKlse+sCJdEqxA
 RCO4lj2RtLJ/0cSKvKTEUm7o5dmxVzLnkGT7us8+EMpSFtW5OZtEPujatUGVndsyM4o8Svuofp2
 AAaksfMybJ2UtL7oTjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140053
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

Hi Simon,

On Mon Jul 13, 2026 at 7:43 PM IST, Simon Glass wrote:
> On Mon, 13 Jul 2026 at 05:34, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> On Fri Jul 10, 2026 at 12:44 AM IST, Simon Glass wrote:
>> > Hi Anshul,
>> >
>> > On 2026-07-07T10:44:09, Anshul Dalal <anshuld@ti.com> wrote:
>> >> tools: binman: fix changes not being written to source.dtb
>> >>
>> >> In the current setup the changes done to the dtb by binman such as
>> >> bootph propagation are only made to the intermediary *.dtb.out but no=
t
>> >> the final dtb.
>> >>
>> >> This means the final dtb that's in *-binman.dtsi never gets the requi=
red
>> >> changes applied. Therefore this patch fixes the behaviour by writing =
to
>> >> the supplied dtb before exiting with a modified test to catch any fut=
ure
>> >> regressions.
>> >>
>> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> >>
>> >> tools/binman/control.py |  3 +++
>> >>  tools/binman/ftest.py   | 41 ++++++++++++++++++++++-----------------=
--
>> >>  2 files changed, 25 insertions(+), 19 deletions(-)
>> >
>> > Please can you spell out the concrete symptom? What breaks in a real
>> > build when u-boot.dtb doesn't carry the bootph propagation - which
>> > stage reads it, what does it expect to find, and what goes wrong when
>> > it isn't there? The *-binman.dtsi reference is confusing since a .dtsi
>> > is a source file, not something written to.
>>
>> The actual issue was observed while we were adding support for our a new
>> platform 'AM62l EVM' to U-Boot where the missing bootph properties meant
>> that the parent drivers were not being probed leading to boot failure.
>>
>> >
>> > Also please rewrite in imperative present tense: 'Write the modified
>> > dtb back to dtb_fname so that ...' rather than 'this patch fixes the
>> > behaviour by ...'
>>
>> Yeah, the former is more clear. Will fix in the next revision.
>>
>> >
>> >> diff --git a/tools/binman/control.py b/tools/binman/control.py
>> >> @@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images=
, update_fdt, use_expanded, ind
>> >>          dtb_item.Sync(auto_resize=3DTrue)
>> >>          dtb_item.Pack()
>> >>          dtb_item.Flush()
>> >> +
>> >> +    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb suppli=
ed to binman
>> >> +    tools.write_file(dtb_fname, dtb.GetContents())
>> >
>> > This is updating an input file...really not keen on that! The updated
>> > dtb should already be written into the final image created by Binman.
>>
>> Perhaps it's an issue with how we're using 'u-boot.dtb'. As I see now, a
>> lot of platforms (including TI's) are using 'u-boot.dtb' as the fdt for
>> U-Boot FIT. Do we not expect the final U-Boot FIT produced in those
>> builds to have this propagation logic applied?
>>
>> To test things out, I built the am62x_evm_a53 platform and the fdt
>> extracted out of the built u-boot.img lacks proper bootph propagation
>> without this patch applied:
>>
>>         fdtget -t r build/u-boot.img_unsigned /images/fdt-0/ data > extr=
acted.dtb
>>
>> It makes sense to not modify the input files so then should we change
>> the DTB we use in the u-boot's FIT to 'u-boot.dtb.out' instead of
>> 'u-boot.dtb'?
>
> Possibly, but are you using Binman to create the FIT? If so it should
> use the updated FDT. This might be a hole in how Binman works?
>

Yes, we are using binman for FIT creation here.

I'm not sure what's the correct behaviour here either, in our binman
DTSI for the platform (k3-am625-sk-binman.dtsi) we explicitly set the
fdt-0 for the u-boot node as a blob-ext with "u-boot.dtb" as the
filename.

Since the same file is given as an input to binman and we don't want to
modify the input files we have two options here:

1. If 'u-boot.dtb.out' is known to be the fdt outputted by binman with
all the fixes applied, we could just use that instead as the external
blob in fdt-0.

2. We could have binman detect a node as 'fdt' and apply the required
fixes in-place before spitting out the final 'u-boot.img' FIT.

Regards,
Anshul
