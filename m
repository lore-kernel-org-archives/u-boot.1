Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6330D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 07:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C603280050;
	Mon, 15 Dec 2025 08:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="O6ZUMSTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A43380433; Mon, 15 Dec 2025 08:38:54 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC2F8003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=44443983bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BF7Jt9X1454561; Mon, 15 Dec 2025 08:38:28 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b1jk5b600-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 08:38:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCTseWs0qIWAg/+l+DqpS1QeAsiGcfWkXCLR9//91+FjVg5XToH+dfFsOoiJDxVFVDuo6jp4zE+qM/f2v2vJnCod8gcYhrUJFezA90jzIW5LhfA6Ft0CDvKWQHuesFa6/+CAEsqBjSwJMOr+0lksicfAMruEdX8rUcbTpuIPiWKR8Y4zDl9LoNWibN/P1KIM+NgJkoTtBwLVm3e1lcdzrIN1ugWhRDbnBdEqLJdxFGYGYpCKkbs23qF3oFWmmdUwCHfPjZShFEjycQyNCZgczcuxr4BToFbIGOOtYs9I6EEV1El+yvOg3M1F7pVRIlfRbshHHGpWCGufmAnD0dXbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCIAYI3AUhbAWxslB9wx9u7N9XEy9dWSHCs1H4+Eaes=;
 b=gVqpgw5lcWh5zhjKITU3RWNfvetuRPWOIIMm1IUeERc+xVnHU1abYtyOYbHqicVjQljSNjZa8Ho+7VQXkTjgtZV0m7qAfwAd1SnPVIXlRmLpEUn/IluZduz+OvLu19RxggxiIT6unRMkDxsaGDmO+rknPT0AHaDeGPS8H80KpEgnhpVp/d3UK+9QkB6uJeaeyfVTgXZ4AztsA2Jcik0FMCFWHJaiQB6taSfU3ifJj0g90ILdAH8vriPXF1on0tLVhUac3XDVfsOIwWXeHTSaDTwIXRff8G15f3qfuqEfrkC16VxRKpuEv99clYU1hNB/jNdCKyfLqszXybLQ5eLlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCIAYI3AUhbAWxslB9wx9u7N9XEy9dWSHCs1H4+Eaes=;
 b=O6ZUMSTjwVpNvnaQCTjtVSFYL846lnhHJw5vXRJ1MYdjJrerRJP1DbJRvGK1fOXuzJsbLJSTbi9BFofXoz3ypJ33CGEp+88mqfMFjhJYLe5CRUW2DSKkijAjGGJisawQJFWfDxivLevwmtIWpS2BaRzehjAhVVowYJy2rtXTZRCfl2wwvhYup4cGFKXZwBiIrPZxHb/6kLijIBqa68i2LJU8r0tJdB9k5B9RHYTRMomEuNs82POB6wpXmkR1njUcYQR+PDakYtbvLmXzH5dzfdLd3aWqk+Ks3oWyH08SfwADbWtZCPWH5NcSn2ENii3UNi75oB0FbiH6i/uIx20UNQ==
Received: from AS4P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::17)
 by DB4PR10MB6118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:38:25 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::aa) by AS4P191CA0026.outlook.office365.com
 (2603:10a6:20b:5d9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 07:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 07:38:25 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:39:11 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:38:24 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 15 Dec 2025 08:38:18 +0100
Subject: [PATCH v2 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251215-sqqs-v2-1-9a15a22072b7@foss.st.com>
References: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
In-Reply-To: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|DB4PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcdf52e-fbf2-45ee-3642-08de3bacee96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWlLcTNSMzBFSGgxb21PSnNQN2lndmVlcERGaitybnNmQ3RGWG9XSmNJVUp6?=
 =?utf-8?B?aFJqTDBOUy9MKzQ5Y0hVVkIyODF4MVd3cVE3V1E0dmNlVURtOEFBZm8zMkYr?=
 =?utf-8?B?amYxODFqanVGVjE3TzRRa2l0R1JHZFA5d29RcXNFcGcvRjlRbUl6akIxdE54?=
 =?utf-8?B?cTJOSk9OQ2JCbkFsUHc2TjJwRHBCK2pWR0ljMFVvandyeVdyYjZRSkdHRnZw?=
 =?utf-8?B?ZTZWNFlMTEdoT1dOOUVZZU9pQ2NBeFNCVjBSd1FXbDV4a255cEdkZGFEb3A5?=
 =?utf-8?B?ZEpYazhiVkNNeVI4NS9zWkhqSTFpUy9JZE5iVUFqZXM4YzYyRExEd3RKUEwv?=
 =?utf-8?B?OHZzby9nN0U2bjkzOW1LU3pndlNIaHU0bzMveENSd3RZZ0J3c1ZISVJObnVR?=
 =?utf-8?B?OHYwWitYL0ZZSjJQR0Rld1VyS3ltQlZPK3NYaTlTdXJKSURyejNKdjNpSXB1?=
 =?utf-8?B?UFZkdWlrczhUUFZpcTJPN25oMnVGREltcFlQY1NScEJ1OUhkaENUbDdRWjdE?=
 =?utf-8?B?YVhTT2dOenRUWFBhUVVoUEJyVnpvWHMvbGlsekU1OWh1ZURMenNEcFlaUkNH?=
 =?utf-8?B?N1NLNENjLzFtTnh1N1o0TmtTMHpYNWM0Mk9DTEFLbjFBckVGeTkyZExXa1U4?=
 =?utf-8?B?Uy9ialB3Z3BYK3Yyd2RwSGJjeUtWV29JVzE0ZDd3aE1GZEZUemVhbFNad3VV?=
 =?utf-8?B?aVpYTDBxR1MwelhLZk1SeFJyM3R0YUNuSHhmYUZwTlBKbnp3dEZtN3R4RmRU?=
 =?utf-8?B?UXpma2RYejJyd0NPZXlrRlF2ODh1N2ZaZEpGVDdpY2tvYVRMeEljQWxwZFFJ?=
 =?utf-8?B?QWJWQTgvQkhhd1BoWnIyRTNJWUtSVTMzN0FNcG5uZk5WOXJrNTlSMUI2WjRM?=
 =?utf-8?B?ckNOL3E0NDBEVi9WU0djREhzZi9JbkdyMjZXV21YNUlMUUlVbEplWUx5MmJV?=
 =?utf-8?B?WjNZenduSFFINkNUUVNuVFgzVU1lUUVJdTJ6SVZxQUFoSWU2V01vcWtrY05j?=
 =?utf-8?B?SXVhaG5WdWM0cmVXNzdNU0dub3Nrbm80ZExuUUtVUXRKeG9EcU5CUHpvOXhz?=
 =?utf-8?B?SitjNTRzVDZsdkhpcTJZckdHNE8rV0NxN0Y1Qk8ybFJxcWRISWZmd2VKR1RT?=
 =?utf-8?B?WGV2ZWRIMTBlYVE0RVo4WmFCK3BaYVVPdTdpTVMwRXJjeSt2QXc5WklEL0li?=
 =?utf-8?B?RHhIdmlKeFdjOVUrSkpuZ3NoOHhJaGQ2dFhMSTA4ZDJpOElTRUFWQnVjRlZm?=
 =?utf-8?B?ejYwSHFnMlJEZjZmaU10ZWhQd1NkcVJ3KzBFUTVOaGJqeThwbTNrR0ZZRGV0?=
 =?utf-8?B?U0xnNSs1U0huY1FGajhuQ21zMk5sR3pGR01DeWNPb3UxVi8rekwxcmdkdU5M?=
 =?utf-8?B?SUVvc2NHdm8zQ3lkaWtldWdqWFJDU1BLbzFpTnpDZVg0ckFKcEl0NWdnRDB2?=
 =?utf-8?B?bFlPTjEyajhTcHltNmxWNWFmalFZcThDVmZVcjFUaE9ZRElCRHgzTThENElF?=
 =?utf-8?B?Zm1KOEJzRzRWbVY1UE4xeHhMUlFWOS9RV0haMmpBU3BrREF5N1QrcGwyRE5U?=
 =?utf-8?B?NTExVnRwWlIxSHJnRVNlTlBheSt1dmFrUVRFWGlQZ3lhL1NLblJnUFlHN2hQ?=
 =?utf-8?B?MjlncU4zVXptNlpmdWRCWlN0K0xWRWNmM2diYkEzOTA5eDRRakJmb0w3cWdy?=
 =?utf-8?B?UjRCdDhVSGtRanFHMXhSMU0wdkVQYU9SS20vblFmYjJRc2RhekEvTGwzNU45?=
 =?utf-8?B?cHBHOVJ4em9HTTZTNWkxQXM0WHRQU1l5REpodzVLdjRzTy8zN1I4SnYvcExR?=
 =?utf-8?B?ZW1rZE1lTlhXOEFSZlZ1VlBhSmRJMGk0Uk8xUWdZbUZ0UWt4VEJFZE1xZ3Ro?=
 =?utf-8?B?N3lzT0ZlMEJ3QWxTTVZWaDZFa0taU3BzRStyTzlSOU9Cc3NkU0xvTnZWZUo5?=
 =?utf-8?B?UUhUazFqVTRTRjhOWWZhZ3l2NnN0cnl2R3dYNlYvUDZhVnNZN3U2anFnME01?=
 =?utf-8?B?TStkeEtSazQ1T1FjVUs5L1d1MmhaSzREcFhlQWR2MHprdTlCWWxUdlpRQnBF?=
 =?utf-8?B?QjBWaHRwUlg4eVJ4bERhNU0zTzJDUFIzSHM5a0NQNWFFbmUwaXJydmtKTFV5?=
 =?utf-8?Q?+1Gc=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:38:25.5568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcdf52e-fbf2-45ee-3642-08de3bacee96
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6118
X-Proofpoint-GUID: KiQGNqdPBppqncybEG-8RruqeZqtzzVo
X-Authority-Analysis: v=2.4 cv=NKvYOk6g c=1 sm=1 tr=0 ts=693fbaf4 cx=c_pps
 a=k8YGkoug2mU4oPBy3kuF0Q==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=b3CbU_ItAAAA:8
 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=PKYdX6cT0oTbK6WKNVIA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA2NCBTYWx0ZWRfXy4+DQgtS/h9p
 sdjU+NAjMGmJgiF6Brb4CCBTTyB1zZ2Y2edz2jkagyq2ORKKnH890igogYeEJFYivHOp3D4dL/6
 PyG6qAb6efh2B6rI6Q3WQ2/dntpXowvdRVPx6svGetuRtiQvbca+mEyzVjEjPTB6AxwOgLUIN4k
 cNz/36yYy3yT9vqFm+VEgw4ORu2Hg3yrsfE1YVFdC/x6Pe1jeTf4gJcCgDmrDZGZhwPCAt761oJ
 5/J4IOJG70zmlV4NxCZlJEwsGZxmd3qYuG8GfwtaVOS5q0GFh01s+NqOD52i0z0gTwFxedoFAJd
 +gtG7la+uzSmOI7wPSxAWcteDr+3eB8W9C+RgkKeXVMOWWxDonwbC87JbSi/bYKnYCwtyFBjcos
 8tMgjGIinOo4SUQnPm5FWvCdHB+Wsg==
X-Proofpoint-ORIG-GUID: KiQGNqdPBppqncybEG-8RruqeZqtzzVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150064
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

%s/scmi_clk_get_attibute/scmi_clk_get_attribute/

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 683ac822a01..f6132178205 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -87,8 +87,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
-				 u32 *attr)
+static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
+				  u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
@@ -183,8 +183,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
 	if (!clkscmi->attrs_resolved) {
 		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
-		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
-					    name, &attributes);
+		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
+					     name, &attributes);
 		if (ret)
 			return ret;
 

-- 
2.43.0

