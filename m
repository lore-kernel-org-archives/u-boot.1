Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB5AC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B334E87DB3;
	Fri,  8 Mar 2024 18:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="J9kDivjz";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="NBwj+7kX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE4487DB3; Fri,  8 Mar 2024 18:00:09 +0100 (CET)
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com
 [205.220.177.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E555C83333
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428DWI6o007657; Fri, 8 Mar 2024 11:00:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=p71bh9z3BjYEYZNMnJU8lIT2g04x0MFgkCm7JKLXhB8=; b=J9kDivjzScEv
 vTY+tTeDeOxGvuY0Ww1aGUNVaESt/oGfi4nn7hD1pkwzjYVpbhD5pv+8bVGswKwv
 FHVbnmP+DJWF/8wbkdKaO5s/iAqA47rMju92cqyzaCchOdC/nHeESaEKEumAr4+G
 q19F5vJ1uTHVy+qg7i5A5sZd+YgtENyp/AYqubLSTHWNvWv1GCxlddXfkN8mVeEb
 OeR59z3BLgpuaHdc2iSVv62PaUx4Gy+MFv5FJtAV9eQuRVFsRPxDPNYVFrj7m7tT
 jncceophTkJFoyDSabxB5mgHGyXWLU+noyvaIxEpPP9K5sqUIEoHpEoxO1HArCQ/
 SG8jFM6gWQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wr0hys71y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 10:59:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLq9sWjb2A8anTj3H7MWOWAnhs0CoPt4K/RCZEP/cATfNygKjhUD/7uKiTZiCkMrcoBD+dzcO7GPwmeL1CL1in8j3D8EXoIVCMpbu7RDzA1JHlMU87meAq/twjtfXXLTFr2qzUvUPslrJmpvJFp0y1fLXty9UUw4au8vc1AZUtskE+Fnt1Yeq1gravbBo+UhWQY/EK0m6tyxvfZpc85InwauAi2TB60hcvmne4wiNPP1MENOT8g7Be0snSqMTwTpEF7rQWwqh0/ALJXe35fRa/HU1vVfwFD9vPeg5WawbX2s+LmxQ+Jp5f4wTrMV/TcBc7ZXrOqTwqW6HER1e0j9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p71bh9z3BjYEYZNMnJU8lIT2g04x0MFgkCm7JKLXhB8=;
 b=XfgmR33BQaCXUdtpgL4Mv1g2GZDWnEaMIwKexpWbFvd13BnGqFPn+WE8IANMJCk7dFDaNb6EU4z2+LdA94gxX4f9m69eR2pDKNAEpusyUOimjcQJnlrTcGr1JKIvbC/7gyTJ0qYGXZDqqoQH7eJWXP00+EQjlq3Kt0s7X0qRt4JJtUKNLFTbd5FNX+ZkuJtZIeS9/QcB3s8XiC+XpGcoCgBJ+hTlLSTOXAzCJzFSdt13Uo6G7cCut1DvLE3T297BPZ9sroqfxRaamb/hhuiECVw2O6Cj6pUF9bl/4bUn8I1vk22AOq+mPD4zXm3i3i9xAlKafqFzURr5UzgSF3XNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p71bh9z3BjYEYZNMnJU8lIT2g04x0MFgkCm7JKLXhB8=;
 b=NBwj+7kX5N4KbZFQWB9wyF6qNG/LutOvRAwHFvJnZnJGOSu5juJHx3Zj0wg3aPOuAeo7a5qc0TLi4QMMWNFgccD3wXmFhOoLrF2QWOeLCHeSyjiIK5uX1p6RlvH8RKp1/64kiy26TfwWJPqd0URPdPZlen8ZppHWn7UBZ2e5Yu6jzaa76NTi+sWylTaftKGaH0NpJUscvtkx5RGIRUqRc4dFWTzVq+WP0urt1T/WmdrcSYwhMUmcUgWU6q9WyMdcGjClNGsHy4NGApZg0c/P0KqJljiEgMwfrqZJ/0g2cB1e3T6uL55qPsbtcTx2W+Y/NkTYoHFRLPSYPzwWLy1JoQ==
Received: from BYAPR21CA0027.namprd21.prod.outlook.com (2603:10b6:a03:114::37)
 by BN0PR04MB8077.namprd04.prod.outlook.com (2603:10b6:408:15c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 16:59:57 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::38) by BYAPR21CA0027.outlook.office365.com
 (2603:10b6:a03:114::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.10 via Frontend
 Transport; Fri, 8 Mar 2024 16:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 16:59:56 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Mar 2024 10:59:53 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 10:59:55 -0600
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Mar 2024 10:59:55 -0600
From: Colin McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin McAllister <colin.mcallister@garmin.com>, <JPEWhacker@gmail.com>,
 <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>, "Mattijs
 Korpershoek" <mkorpershoek@baylibre.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: [PATCH v3 0/2] Fix Android A/B backup
Date: Fri, 8 Mar 2024 10:59:35 -0600
Message-ID: <20240308165937.270499-1-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307161711.3177729-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BN0PR04MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 045d5b60-814f-4168-e3a1-08dc3f912eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDSHt+1BP0HuSlIltqjN8qvvmnR/gaX0xpCFzeMF2owxa7PgDjjLUr7yAK+MTOh/bMnn1SL2DjQP+hIN8rxOVntCqXvQ6ECXWWlhipdyxOoO594qlPLkyBN7/2PsoOm9TdGijd61SqiE0f/e0Cms+EQgwACCTv1REHqy7A9aeTJn+o7IU8vGmTHsHrVLAKbqRWDhjAGtissqGUcq+LVFui8DtA2k5qjL+unVhqbjGjtJuUg1jGgbeXwGLgvYRMc0BuCzcdxjBheIf5QYedeA0zOqDW4+i+y26atBD24/UfEZZnrq57bbjF06DFCvrAPlfChLr37Otk0I2J005Lf+rkCtFIa3uFC/2ktk3ZIk55hOoPQ3vmkOFF6flEqT2uHCLA6HNOPKo3lqxOxwxh0jct9dvcxNbcndTT20uNbE1/NeVVL1IKxCFiu588JDkhFJMR2u+U5SX6OcmRD1Pz8s14B16azXree7+CmLnXtPEUHgTBNUqO6UfCLiWq7nxYcma+EYYbjFHYq4KicjcMwljw/lcgkkTbA9LTgNWiG8ZjI5Dz2IIA3oQpeyUWaK2wP9kTWNBk0y1X0n3Szqr/hiALzofl/5W45/xxcb83NvvPPNcWnhwOZwHQxYodfUSH9viduQRSkadnIBS8wyVagaHz9DwhQGBSObQl2sgAxuYgHn0TkGlv28cPnLiBFhGqCtCr+piM9qw3/XQq0Ah4PvKac2QVbCT+tZauR4NAXjDFbtRnAooH6icSQpbI6vRi8n
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:59:56.8577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045d5b60-814f-4168-e3a1-08dc3f912eee
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8077
X-Proofpoint-GUID: vIGzYh7DcVXY_6M-E8QV2zQ3QlCMLdbT
X-Proofpoint-ORIG-GUID: vIGzYh7DcVXY_6M-E8QV2zQ3QlCMLdbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080134
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
- Removes use of preprocessor macros with ANDROID_AB_BACKUP_OFFSET

Bug was found by noticing a semicolon was missing and not causing a
compiler error when CONFIG_ANDROID_AB_BACKUP_OFFSET was set. I submitted
a patch to fix the semicolon before fixing the #if's. Testing the latter
patch without the former with ANDORID_AB_BACKUP_OFFSET set will cause a
compiler error.

What's changed in V2?
---------------------

The second verison of changes removes the #if preprocessor macros to use
C conditionals instead. There was some minor refactoring required to get
this to work, so I did more thourough testing to ensure the backup data
works as expected.

I also realized that CONFIG_VAL is not needed because there's no reason
for the SPL or TPL to have different values for the backup address. I
opted to just use CONFIG_ANDROID_AB_BACKUP_OFFSET directly.

What's changed in V3?
---------------------

Added "Fixes:" tag to patches. Performed additonal testing as described
in the second paragraph in the testing notes below.

I opted to not use CONFIG_IS_ENABLED because that macro appears to only
be intended for y/n configurations. See note at top of linux/kconfig.h:

"Note that these only work with boolean and tristate options."

How was this patch series tested?
---------------------------------

I built for my target with CONFIG_ANDROID_AB_BACKUP_OFFSET set to
0x1000. I first verified that the device can normally boot. I then ran
dd before rebooting to corrupt the primary data. I confirmed that the
backup was used to properly restore the primary. I then corrupted both
the primary and backup data and confirmed that the primary and backup
were both reinitialized to default values. Lastly, I corrupted the
backup data and not the primary data and confirmed that the backup was
restored the primary data.

Addtionally, I disabled CONFIG_ANDROID_AB_BACKUP_OFFSET for my device
and confirmed that after I corrupt the primary data, no backup is used.
When the primary data is not corrupt, the device boots normally. This is
what I would expect, because CONFIG_ANDROID_AB_BACKUP_OFFSET's default
value is 0x0, which would evaluate to false for all C if conditions.

Colin McAllister (2):
  android_ab: Add missing semicolon
  android_ab: Fix ANDROID_AB_BACKUP_OFFSET

 boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

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
