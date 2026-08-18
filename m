Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8108CC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3302F80FFF;
	Tue, 18 Aug 2026 13:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wDXr8CVMlKze; Tue, 18 Aug 2026 13:06:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E6C681066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058394;
	bh=/eAyBjZYZsfD8XY72qgDmkK0RyxnZ+MuLDwpWA/We2w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=efyfwqWhz2scCRI+XUl2cZ0D5YNWnEXKHHQqmeKhr8rx01PAGSfzqpqi0aluTo8Ja
	 HUXFXDdJVN3qBViw0U7zt1Ao7Mc6k7y3kC8l5V4tjZR37QBmqYxRth5KW7PNvzShja
	 j1y7s6BUcyN6c+0KDep96A1KqUoW1zOJ/fC6ClzkmsGoDMSaLQDTbvhOFWEGULwJDl
	 qHmc8t4DEnqGTEYfuCS0/8izBlddS0vLBE7zUQ/fOO4/3UyoNz1ziP/W12KyeilRI1
	 JLTEX/0Ji8hqJhZc8y955oLM/JH2zR+M0HdYGeJ+qixw/y6v6BJ7E61YlEWfaHXPXf
	 Rh9vsdwKS10/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E6C681066;
	Tue, 18 Aug 2026 13:06:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CAD3A2B2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B10F6608AC
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKMSbwgrthK7 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 12:48:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BAD7260612
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pa.msu.edu
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAD7260612
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=T5F7/rcN
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAD7260612
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDSI1heXUGobs1Okd2NrD7KKG1Wdie9ISbQ3D8QiI01n+LDxZxl7qQWwlhN6G6h9Ilv1ACKMZc2lXa/MFAcZKMmOHJUF9v/M+69gDRXEAObuSO4BAsP6fJHawk7/G+5ftCt9FwrteseVXYaenbsRfqdGrOG11WGb5oytmyKzbsfAdDjyg83erQfbuWTFMcgN0CRaIGYmwY/7CZ5w1K36OTBRJL23uLtcIlMczvgj9v4Yziqqrvg2fSJCs8bECq0byENw15IIj93s2FWpRUc/nMAy9NBt8PvfpXPyrnv+N+qiExK4yAEagNAuKG357GqdPd5NYOHireYmAEwIGihKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eAyBjZYZsfD8XY72qgDmkK0RyxnZ+MuLDwpWA/We2w=;
 b=gfjkGoAXHERLcJWUZORss7HgJEwZKxMZqob9VA48u/ATkAhOFrktAosYwAv++Q2SwqH/WB8B5pALyW4QzLiymw4tX0Z4b5J1QDn9u9z8MD7+vcPxUHnh3YiW0sv936gLf0EkofxSVIN9UQRw/R65+uzh3poH75FSppSmp3g8VavZplPjz547znoy3fj1Kgr/DdRO+O+epgk4nWQe+DZy4hmgM5fN1r6fH90kj7R8x4b9U8gj56D850L7kOVvlVxbKLf9Q7N5uGCJA4EJo+zz+8OFY9PUhHuN8EyEGY2n3XRCaIStKxDaAVJk8BopR1/5REgYtgYkhQW3/xyhgz2S4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eAyBjZYZsfD8XY72qgDmkK0RyxnZ+MuLDwpWA/We2w=;
 b=T5F7/rcNmgd4uaNqEbqmhksxtG52sbBxQN5UcPw11opU9D9XqjvtofTi4s7tVYnxVILwHgiShWz9t2KI/VJBvmyDZ4xIP/puAt1o/3fYALXVLbfV3XZCmW+x/YwHQNkkI5XFOgon+FMhFCmsN9fJkwM4qB2KzT4hKUAjLoSip9tR0chDANDmu6HT3FWPhuGISnT6sM8Wulq5flci+90jzuzp8YhFHuDesRTmDwggz1gQxja5LVoftRkwDsYSPNqt1x4u2xoGoNNCuW+UuB/G2cD62p0oQXmymXDYfwH6KbG2LssDaCJwQUBo4IVkw+IWKaIXsNkMwcN2rlz5R7r4iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 18 Aug
 2026 12:48:37 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Tue, 18 Aug 2026
 12:48:37 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: u-boot@lists.u-boot-project.org
Cc: tim609@andestech.com, Jamie.Gibbons@microchip.com,
 Conor.Dooley@microchip.com, Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH v2] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
Date: Tue, 18 Aug 2026 08:48:15 -0400
Message-ID: <20260818124815.24470-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::27) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 477cbc46-b7a0-4c94-2cb5-08defd2705ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|23010399003|1800799024|376014|10070799003|366016|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: h3hKZ5AtLirD8PzPXQEpeipLE0UEM5yKFAKZGI4os92LzY1+N7BzuAt+HdD8yDsI6HfuLwYcivvuvuSOn+Fsienm9yHbgA2TBn5JINhym4hlkBSTHmfVnmYUdrzOdjNUswp2PvJXpSDgQY0yKN3a4cWVqlqzBxJ1QcQt7akAXoc3rDSu8LTjYO0whpdVP+Sf28gQRR0TAAjATFwQeKuY4P5LuidalIqQan/nJLOfVwY8XJ6SrV0g035bnb22YMJ/lNuiG1IEcQl6u4fBMK4BwVR740K5AlYwJr6ZhxZVL8LmfsOI8hGFJ7m4ep8PEIKv29KqXZama+IsEXNeASFBjjBhLJHRRfWcpeKllCcZcTE4Vvf4mt77hI6Ho8it90wTIEi5gksqL3Oh6F9fEo5Utr2PI++fA/wygontEPzksI+4wxMPiF6Kp6W5or9xbPmWzc8LxTIZU6wvjhl53dp9CliF6QAyWTrreeogKzJ9gjQAteI9UCnCus7HI5TyLfKT3LYfqZBsMHpoWqzAzu2ZdVCGC35ctghdBu3MQe1u5PNj5nv73xZ4Etw8M2XXwkhtjo9eCiMWvDVXHKrA3Z/OvfEFSySgylfCLdYIS+IjN+UybNYFlSuHFevu5GXSwWxYeLwyBU7hgvqXkwa4YZbvJZ3SGuYY/Uch6J/nhm1yDFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(23010399003)(1800799024)(376014)(10070799003)(366016)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5ZwNSHkFBp4F1sq1FlMgtQ9Bld1SMR7/hKTC6StSTwNQq7S9XYldPtB+NjI?=
 =?us-ascii?Q?CKkq1TUaT8P13Xju2cS27ZGt9gpOSN6JwJ7Y+lfV0xGdn0tjnG84rBWeb21R?=
 =?us-ascii?Q?rlTiP00sgFcPVp3895O/v/JiN/LiVYe6LS2mE3B4PdN49mFDSct7+jGNVpI9?=
 =?us-ascii?Q?zLui5+L0FOPn0E/f/G4tXm5P5qVTPno5YUVdMobhsLmSJj641wriaao/A4Fh?=
 =?us-ascii?Q?ZuPUJyC4p8lO3e5GylmYPF0d1dxo1ULK4edBBSPKutp4u2c1z0vWUBg3JFM5?=
 =?us-ascii?Q?17MiXNYL2OyzKhlz7tEeCHGYxeELjrdi/fJfOaMO6QHNnBltm/DIZ1nUg3TR?=
 =?us-ascii?Q?SfDHF0Jl74TaDEaE8KHISF/jA9LcTC9kyfbxDKXdL41ejAVGVJWcuvpb/RAp?=
 =?us-ascii?Q?ZrnrvQ7ZxblyEmup0VRdhgPNWXR4ojhba8IXHHH6SbnB52DQhFZguyGJBMEX?=
 =?us-ascii?Q?JFp/Dc1caCUTJ8Fye2zd1sbfoClkhCFqJDmOcPHVuv7To3aUOnV8Yertuwya?=
 =?us-ascii?Q?fChFLOjItiv4f00irl3WoW8LicsIc4ZeP/j3k4DBwk1ZCxfSReKeUdtVOudC?=
 =?us-ascii?Q?U0DPoCg3Qf3DdMFaREWiDS16LvouNX/cE4ZP9OOznweQDMeVZqv3NT6pVA+j?=
 =?us-ascii?Q?d4lk1oacpQZ6jJYz5dzPN9PsqrfNR44URO35OYC2ibmXEejrJ28hGjqtKbr3?=
 =?us-ascii?Q?qqARTmzJo/lu6ls3WDtxdQD9Wu2WJPDjuN6ab5Djux4cC3Mo080TwaC0D5vs?=
 =?us-ascii?Q?GiVYx4PQsoqwIl/3u3AZiezQD0I2cX3ClSBnDB0hsnRzRPN8SxQZWGstKVDi?=
 =?us-ascii?Q?WymnWrh1r9XL+jE6aBIgsEAeXqJHYfe56P0SYT2yzZa92DunwZ2Z+1OlfsPK?=
 =?us-ascii?Q?KL+NsT6HofOKoG+gPoK0hU5qYJ1JqkteHh++cUIcJC6hYAPP1nY5KCynP/tl?=
 =?us-ascii?Q?9GaLNT4hYQ0biDzDyyFEfzgR/hkM9C44QxQxFgEHxhegCqXjfYME2mXUDioI?=
 =?us-ascii?Q?NxOOyBvYdT9Ca/5r7I1O5q/8s9vXIPzWtP1MUmoK5aThoiyawzzofL6t/V2L?=
 =?us-ascii?Q?p2U/52qmUigbRKaR+kZbxTPS4edlXGaM5Uj2G3shJ4Oi5AwSJUqjtwn+W0z2?=
 =?us-ascii?Q?XphVgUiwLp6vWPoLJN+2xU/EmYjBCrl6ireDcMo15KT+Fe7i1BVtkTsCxwo9?=
 =?us-ascii?Q?F3bPyFquWtwaaaDRO6rWh+hl+ed3vrsN8TUwWnYAu5kvv5ZreCsnj1ZZSkzx?=
 =?us-ascii?Q?V+HNVTn+TnPVXBOVcFOedRT/KSJ9f6ywPBpI8S6UNSKkD9Jlm6HZmBNd1ZUi?=
 =?us-ascii?Q?T3haiHCfAs2Rwo8iNSlLDqIVaomjwYgYf5hJacv3p4hiTvnAeA1elb4exSnT?=
 =?us-ascii?Q?CKOgjkGxo0e/h1yJZFb4aFQR3PM/aAlJSZdhtePD7UekI8QBHqF5bNI9uw4Q?=
 =?us-ascii?Q?ajZ0LaI2KZ0SsiPc16jQAAXPZW0ZJZth/Uaae6IvhOiKnAM3M8DZTih2pcoc?=
 =?us-ascii?Q?I2Lg01fScMhm2sfVdHxk/KYoU/81pFgxnHVRdyP2eKhe0xfRHbIen22vIAlh?=
 =?us-ascii?Q?eRGeMcAFknNokZNdXwTFgHqivJiEmPP5OIZ3OYxLoN0V4sXlB/FYHOiKkVk/?=
 =?us-ascii?Q?6oAcx9vnsd2431Y2jTZQpuY4K/cCz3FYVxSQ3e4LVb5gkXpP9tJyY91v93Y2?=
 =?us-ascii?Q?r/8t3z4099Il9FmjVieH2LlW16UG8E+iblVOUvNRhcZtUFzZBFOvQcTqRx4y?=
 =?us-ascii?Q?mqz7g/dz6g=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 477cbc46-b7a0-4c94-2cb5-08defd2705ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:48:37.7770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb4ebBlVmk9nzIjcCCIZc6q8uYKkabyFlSz950P9PDjoLRfmE52SMWhxaPanGarv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When working with systems with multiple FPGA firmwares, it is sometimes
useful to be able to use the same U-Boot and script conditional behavior
based on the FPGA firmware ID and version number. This, allows, for
example, flashing new FPGA images without flashing the bootloader and
letting U-Boot and the Linux kernel adapt appropriately.

This does two things with the information:
1. Prints the FPGA design ID and version to the console as part of U-Boot
   startup, which is helpful to a human working with the board.
2. Stores the same information, plus the already-acquired FPGA serial
   number, in a new set of environment variables (serial_number,
   design_id, design_ver [the version], and design_backlevel
   [minimum-version backlevel]). These can be used in a U-Boot script to
   load different kernels, device trees, etc. depending on the currently
   installed firmware, which allows U-Boot and the kernel to adapt
   cleanly to FPGA firmware updates that change accessible peripherals
   etc.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
---
Changes for v2:
- Rename environment variables to remove the pf_ prefix
- Remove portions of the patch that added properties to the device tree
- Style changes
- Rebase after a5f93037f28624c612288e2d97604d73e03af5a3

Thanks to Conor Dooley and Tim Ouyang for helpful suggestions.

 board/microchip/mpfs_generic/mpfs_generic.c | 26 ++++++++++
 drivers/misc/mpfs_syscontroller.c           | 54 +++++++++++++++++++++
 include/mpfs-mailbox.h                      |  2 +
 3 files changed, 82 insertions(+)

diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
index f57f5f4046b..4423dd1e38c 100644
--- a/board/microchip/mpfs_generic/mpfs_generic.c
+++ b/board/microchip/mpfs_generic/mpfs_generic.c
@@ -114,7 +114,10 @@ int board_late_init(void)
 {
 	u32 ret;
 	int node;
+	int idx;
 	u8 device_serial_number[16] = {0};
+	char serialstring[33], designid[33];
+	u16 designver, designbacklevel;
 	void *blob = (void *)gd->fdt_blob;
 	struct udevice *dev;
 	struct mpfs_sys_serv *sys_serv_priv;
@@ -144,6 +147,29 @@ int board_late_init(void)
 		return -EINVAL;
 	}
 
+	/* Store design info and serial number in environment */
+	memset(designid, 0, sizeof(designid));
+	memset(serialstring, 0, sizeof(serialstring));
+
+	ret = mpfs_syscontroller_read_design_info(sys_serv_priv, designid,
+			&designver, &designbacklevel);
+	if (ret) {
+		printf("Cannot read device design information\n");
+		return -EINVAL;
+	}
+	for (idx = 0; idx < 16; idx++)
+		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
+
+	env_set("serial_number", serialstring);
+	env_set("design_id", designid);
+	env_set_ulong("design_ver", designver);
+	env_set_ulong("design_backlevel", designbacklevel);
+
+	printf("FPGA Design name: %s\n", designid);
+	printf("FPGA Serial: %s\n", serialstring);
+	printf("Design version number %d (backlevel %d)\n", designver,
+			designbacklevel);
+
 	/* Update MAC address with device serial number */
 	mac_addr[0] = 0x00;
 	mac_addr[1] = 0x04;
diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index b9aea7e1181..07a788db76e 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -152,6 +152,60 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
 }
 EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
 
+/**
+ * mpfs_syscontroller_read_design_info() - Use system service to read FPGA design info
+ * @sys_serv_priv:	system service private data
+ * @designid:		30-byte string name of top module in FPGA logic design
+ * 			NB: null termination is not guaranteed
+ * @designver:		version number of the FPGA design
+ * @backlevel:		programmed minimum allowed FPGA design version
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv,
+		u8 *designid, u16 *designver, u16 *backlevel)
+{
+	unsigned long timeoutsecs = 300;
+	u8 data[36];
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)data,
+		.resp_size = sizeof(data)};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = 2,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET};
+
+	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort\n", ret);
+		return ret;
+	}
+
+	/* Receive the response */
+	ret = mpfs_syscontroller_recv_response(sys_serv_priv->sys_controller, &msg, timeoutsecs);
+	if (ret)
+		return ret;
+
+	debug("%s: Read successful %s\n",
+	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
+
+	if (designid != NULL)
+		memcpy(designid, &data[2], 30);
+	if (designver != NULL)
+		memcpy(designver, &data[32], 2);
+	if (backlevel != NULL)
+		memcpy(backlevel, &data[34], 2);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
+
 static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
 {
 	int ret;
diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
index 39c998e4c8d..bb9a162fb20 100644
--- a/include/mpfs-mailbox.h
+++ b/include/mpfs-mailbox.h
@@ -61,6 +61,8 @@ int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controlle
 int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv
 	*sys_controller, struct mpfs_mss_msg *msg, unsigned long timeout_ms);
 int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
+int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv,
+		u8 *designid, u16 *designver, u16 *backlevel);
 void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
 struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
 
-- 
2.43.0

