Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987EAC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD4D87DDA;
	Thu,  7 Mar 2024 17:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="XzHn8uym";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="JZ32AkQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA3587D99; Thu,  7 Mar 2024 17:17:52 +0100 (CET)
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com
 [205.220.177.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DCE487B77
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 17:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 427G0hkL010086; Thu, 7 Mar 2024 10:17:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=pps1; bh=NCgZAa65Uk0N
 sUU7LtB5As6RDWHqhsydV+VFqwY9I+0=; b=XzHn8uym0RkmU7kHXB2B/dkGlAbM
 LDTvO0raGn2OsdZm0FRw5ZgNm7ig6okjvy5JySRWrbOulOjgoto4hWE0ptu+PEkO
 GnqzIEhtnf/j4QsIDu/amnVnvEtM5Atjjp+1d8xxDPPDEz7GOSY6KfQdyxiVVcNg
 Iksn2k35wilNpt5VzvusUJAJCIDP8vcVIJE4Vmu3unAl7X0zEQCUsQMAdzhsyMcP
 BzmQ0sn6JiW4F8P3MnpQbTRqLNdHWuB+dR+v8e55IdE8z+GffMwk/wCxChWbKlsO
 CS+VVNrRc6EJ4exJ8d7DUI7lQFAqbEheP2r6lOfW3EKhrecWowYLFRevuw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wqcmesd7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 10:17:46 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0VQRgLpeud0o5UT/6aqVAku8oHXgOA5xDLzkl3knuQMNnCFxEf10CAcMZJAzLrCB7o0GapT8bbBeMNjISYswWemXCBfSNsDDq33+U3aly6+a4CU58rInKThp8JNpjYa78UP8h7FHi/Z+IrwrYgHGWi6ANg6NAwFU/SfsE2Sp0uoQRKVxMpfenucAyjSgyeypNCuwnCYivdnkD+i6HCNSqrGdzNXJEj0lwJnzQfWXdVxNd+CG4RjJ1a/O7+1nX1ZzTud83hji2yHAzY/7hoOqelaCC4ngDk13spMkhBE/Hx82xsermpnFaAljMVTEzU0036zUt73njNTQ16nOvFYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCgZAa65Uk0NsUU7LtB5As6RDWHqhsydV+VFqwY9I+0=;
 b=ZOCiRVkJjcDvm36eYzHwkySdTA6vxzt2ycjdlTjmg1ooWqwoELd/A4MszKoRQEjt2f+XdVStidfiqxGCEFXfat22UL1ZIZqm+XGUnso9Wy6US5NbJBJqaVX0EM52SYmnsmb9sN9tDPOdKCb16WlMOj3mN4NWk5Hx5E8qcWagYIcr/9rc+Gh0bvA1OOnKXo3B2OQHxupvljIBTLrubqsEd9Y+T0rudSJsbro48F2OQs8NmHrTQOs23B2HBirmeb6WN1MgYRS+YzVTCchvx/PjS2l+LVXXmQkvrDHZKk+fV15B7kxQ+GQSLsSevxZdYUjjsfYW9GAGtFADmfdOKluVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCgZAa65Uk0NsUU7LtB5As6RDWHqhsydV+VFqwY9I+0=;
 b=JZ32AkQJMU0ibx25t0fr8Epn0m/U7GbOn/Y/zL0z+cDaZLC0KFnc+N42M8FgmZfF9VTgn4SCHeeZn60vGQqJof2KIknU+ipTePaEUI8xSL7u5Th4m6AwQdDl0bV/ngJXOvHW+j56TDC8zxsIAsdZiJYoo6GY/jQF2L6+D4elGcDmLrBzr3Uin73mOiXixhrRnUrbXPUa633p4QVahmUuAvGowGW8JeytDwGgLi5a8cL3mXO4dL+tZxKcyc9YrXwUQ3H3CE/+KgVz5nX8VtTcwTOCWwOH/dLPK4AWQ0RiHN12eMR4uqiqjpC625GrsFbN0Zsv0EbyzGISIHicwI7PJg==
Received: from MN2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:208:a8::26)
 by BY1PR04MB8678.namprd04.prod.outlook.com (2603:10b6:a03:529::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40; Thu, 7 Mar
 2024 16:17:44 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::51) by MN2PR12CA0013.outlook.office365.com
 (2603:10b6:208:a8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37 via Frontend
 Transport; Thu, 7 Mar 2024 16:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 16:17:43 +0000
Received: from OLAWPA-EXMB11.ad.garmin.com (10.5.144.11) by
 olawpa-edge3.garmin.com (10.60.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Mar 2024 10:17:37 -0600
Received: from kc3wpa-exmb7.ad.garmin.com (10.65.32.87) by
 OLAWPA-EXMB11.ad.garmin.com (10.5.144.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 10:17:42 -0600
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 kc3wpa-exmb7.ad.garmin.com (10.65.32.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 10:17:42 -0600
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.28 via Frontend
 Transport; Thu, 7 Mar 2024 10:17:42 -0600
From: Colin McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin McAllister <colin.mcallister@garmin.com>, <JPEWhacker@gmail.com>,
 <sjg@chromium.org>
Subject: [PATCH 0/2] Fix Android A/B backup 
Date: Thu, 7 Mar 2024 10:17:09 -0600
Message-ID: <20240307161711.3177729-1-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|BY1PR04MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 97341605-d78c-459c-42c8-08dc3ec21e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SROdXGqvitk5jHCdlFcll88bVd/HGI6xWpsTVYulvE5H6NVrIUsaGxtuFFMPMUbc+vza/VB/8qjHBOjOgqrZrbp9jG5ngVuugSWViPr2CaLwsNx+bxOugPK0kxMteP9NN9WJMJR/6a9IeT93HZhBgX7f3SYStFqI+2a08QOohuHRLkdqscsm3PduSC9YZj2B/qZECbvPRc2pOqfrNbf8Jk8lPheVV/JfSYTl+afds6yDViWpb/1M/ENdTW8RWzLv8bkH9x2FTVAY7jctm/0FaDox7E7g8SDzLSjvk7DbGlZiTH31hcAm5Fsy70lTjeyB8clQNua4buT1tgrcQN6IV+ulS9uJ7vkzTnHUI/8AanytpUSFp2z8N28krBCZjavM1YQHDHlQDQIFOEKd6b8R/TZ3E0QzzGfL8JX53sjpSVOmLl15NB5IzKF8CgSnjKaxp2EU+fqYACqBoC6YMoMx7QyeP4lsFx8vAxjLZo+vqqUnjz/CXsEJJu3A5VPImWyqGbASZq9xN8swkRsDMWnSCa1q92RVGpPEVvtdxWA5q29hSYhC/a4u7G44lelNJKvETBGgW8zEwcXd7IiijVE+o50kr3RrDi51woa2juUOSTblcKe8hAGKfB08reDMNa3Zlc96xZnk28GEkiyDIiS0TYU6LKJ0GRiMoHagWzxKmE48KmVAQM+i141tJ7it2en8b6w2ILzZ/RuE3ydB7oXq6HPUktjIR2BSvmtadYZ3Cj1CUQvtZqB+zefWrNebX0JY
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(36860700004)(82310400014)(376005); DIR:OUT; SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:17:43.2090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97341605-d78c-459c-42c8-08dc3ec21e54
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8678
X-Proofpoint-ORIG-GUID: c79RQDMP6TsxSJeB1dFCGwe63ItrG6Nt
X-Proofpoint-GUID: c79RQDMP6TsxSJeB1dFCGwe63ItrG6Nt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070110
X-Mailman-Approved-At: Thu, 07 Mar 2024 17:18:26 +0100
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

- Addresses compiler error due to missing semicolon
- Fixes use of ANDROID_AB_BACKUP_OFFSET in preprocessor macros

Bug was found by noticing a semicolon was missing and not causing a
compiler error when CONFIG_ANDROID_AB_BACKUP_OFFSET was set. I submitted
a patch to fix the semicolon before fixing the #if's. Testing the latter
patch without the former with ANDORID_AB_BACKUP_OFFSET set will cause a
compiler error.

Colin McAllister (2):
  android_ab: Add missing semicolon
  android_ab: Fix ANDROID_AB_BACKUP_OFFSET

 boot/android_ab.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--
2.43.2


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
