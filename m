Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF88C54E4A
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 22:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7184C87DE5;
	Thu,  7 Mar 2024 23:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="W3MDiIeV";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="BG2pxQv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F7887DE5; Thu,  7 Mar 2024 23:11:07 +0100 (CET)
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com
 [205.220.177.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1083587811
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 23:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 427LlZLT022579; Thu, 7 Mar 2024 16:11:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=zPsfOOcYrXSValBfLyQV8x1XwdV/bHwPPX883NGzow8=; b=W3MDiIeVedun
 S4CLcuTXSo5qhI6PTgHS0DCz/NxlsxB+AJXAZTPfb0HdA9zC5Mv5DLfFuHlYdC9W
 2M0f83QbDGttbz3lg1Poq1IIteTgz4xY6WWI53OgWbBZP6NbUP1dAKU3GVnG1krX
 rhzMKMEspgy2NAL7qfeJHD7th3yP7A1mpBl0Evj9tKjNxAm8nJuxy2ShT1ElotFH
 +aipVLslCm2ovyKw0mfU+baJrhEFWMTtODugOnt8XSoKgfnntc7xvQ2Vof8yK5cc
 4etCvt0qqxuBe03qpqSc4UMF+97oVDR57+LwxD76QVaAHB0cYHI3fmlFdEY/yN/0
 7mG4yoLbFw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wqcmet265-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 16:10:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTisjOX3aUlKMZ3UiX0ZugdFISQ4cxQq0rC2LxGU//tXR6w8Jdy3P1clylMO5VhR2ZjqNoPp5+UbWkYm67emSj3U7vXT+QmYrdggzAHOmCxHqiXlWey8JFuW3OVWKOYONEOIXDj37v54kl+o8cHFHKUd8gU2tzsDusPGJw0wiMCXxN+IHE6mWJjRaOSqMeDzwVpSzDnVMjTOzG7UoqxO5AvIP4QGURovAOQ/TDa4YXAXV0gFEsNxry0YXSWIZp3ABeQo9hqzMm4HSykMT5tNUsYF92JgxK7zJnT91jg+21ZK5VcVuWovV/J9kdqgw/m9V0uAWabKWJ1ejLnbJJ3xlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPsfOOcYrXSValBfLyQV8x1XwdV/bHwPPX883NGzow8=;
 b=UQG47JhC0sM6KuVuXzyJ0HJ7e3hl0u0rBcKLqcNS+d8xBnx3jVhBJkUPmOnN0kMtMIfvZ+B+gsMQEx/ydVWF9kQewmqAUFz5fyvTgif3lo8ElB7j32/Er580oJXXrQY3sZfumYNFL7kBSwZu8UQ02yLi62fRuKX2V1b/h7Wtnp+uaTOt2yyuFQZMIsrB6szMyq5li1QK9ihc8OzVcKM/eDhyFKHr57wVrsB9rbzrOFao/9XhRzUkrgMuwe2qrAf9Jyn+ReLG4A46f8nKNTwzbveEXEmA6I+Fhvo3r8hHroXWLIrVJiWn0qjFzIWDzkAMqVbzkZ4Q0c77hnOgaHD7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPsfOOcYrXSValBfLyQV8x1XwdV/bHwPPX883NGzow8=;
 b=BG2pxQv+PE6w4wAQTdnWDesch7BeeJG0jyv666jOXFeVzqgSStJqg0FPj64ORFFBsdiHD8CGb6E2HlkEAUcH1ES1/eS7qyqTqwj4BX2YiS9eox9hVeRNqwOUdaog/DRVFSgnECvgi1ZJXeDD0SJIq/9BhOpKdy90BC2g3IpPAVznSCRVpBfjO4wybhABXb9cjFQjDIh3nRPYb6Gb+G/XKvB3nGCHAjcKUyaPc4g8QFKeKsQjKrCL6/59+rvafDP4XDMaNwFYPBSnTAUasA6kvVC4Urt5uQ7gRuP15xccvj4pHz2A5F7N+nt2fXstFONcMk0UIoAaylSdO/q74dIVRA==
Received: from CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::7)
 by DM8PR04MB7926.namprd04.prod.outlook.com (2603:10b6:8:4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Thu, 7 Mar 2024 22:10:57 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::49) by CH5P222CA0012.outlook.office365.com
 (2603:10b6:610:1ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 22:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 22:10:57 +0000
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Mar 2024 16:10:39 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 16:10:45 -0600
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 16:10:45 -0600
From: Colin McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin McAllister <colin.mcallister@garmin.com>, <JPEWhacker@gmail.com>,
 <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>, "Mattijs
 Korpershoek" <mkorpershoek@baylibre.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: [PATCH v2 0/2] Fix Android A/B backup
Date: Thu, 7 Mar 2024 16:10:27 -0600
Message-ID: <20240307221030.3685767-1-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307161711.3177729-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM8PR04MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: fde1f99a-b939-4ba3-3b31-08dc3ef37718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b92WBsHBxlc/T6M54ej2QSrsVxVmhy/hn+iqfp9NlOWL0x3FwGiZH05C1f2Y5oIpAiETPUk2KqKQpx7vYayzUyMdTMYWVJjLpgfjpvhDHXLmNpUO/npFCFZ72F3iGrp3noUepIpyRJZPnsKOPlwaKMLf4JvuBqmOXaggvsmjmQsy75desA/xEg7TLHL3irtKAgIo2Jg+EKaI9W4Iwd0wxOZYSMdVwcksRvxs3uks41v7URds18Lhriz0uiVZJKTErUMburBQ4F7tXgDqLSN22B0OgAA0EjEqp7FzorWTieD6D+EGcBHW/ROBTL2N9qyC5oNTry7qsnHs925njN+z0qWrpG58asZJnde2GFDkL6iefbxS/oftRtiILomPr0aovfwcAiCdkE8WHEXKuJ4nQ/FrFve0NlboEyzL+TpCe2cJ/TVZR+/OCAvwAZC4Sn6KWltKBt3A2N4QFcJDdlQOja05WTSigIiPMAUvRTf51jEhnwJmavqYx3EgUO0egJN/jaEdbozzRk4SbSFaiRCO6pSW2vPS0N4zIQnB5q5eGrVB3pE3Phm5hNt68Ci9m33HHMcktosXssYm/VGomkk1ZHWE16iVxBOF09F2lIxlBmH5SPoYXlNVPgW/fpH7EpkqkniOhU6yFVMeZXqE2Wioa7MN0UvWf48zY5w4BIUCcvVZCLVnB2w1q7B/ZmXy2RVlDVBlp/NP7KLNWezLDwIIZuKvhmrT1s4bh9sTVhl20M4db+hQMzqRYFNco+RmQ0a
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:10:57.4725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde1f99a-b939-4ba3-3b31-08dc3ef37718
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7926
X-Proofpoint-ORIG-GUID: Cl4lIr1wtU0bKgVuiEo1lshlReBsair5
X-Proofpoint-GUID: Cl4lIr1wtU0bKgVuiEo1lshlReBsair5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_16,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070159
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
