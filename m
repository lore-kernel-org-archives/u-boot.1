Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64262C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9997A808E6;
	Fri,  7 Feb 2025 15:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="QeRvDktU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8BE801DE; Fri,  7 Feb 2025 14:06:50 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10C380207
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHtLE8MaDCKNTgxWI3yKKtk1W564uErNN9mWv638S7R5V+ltDcnc+bkll89bAY5133+DA8+1+9/7kgeJKo8MdN4Z2U81PdKZOF3qJxZkmHNg1jfcI0/U4lKczP+C4D4YlhpcJNwp1DOQ74lbbgLqIPtqDFmI8JRt6jxclVZb/3345hJF+7gB0y4Sc3y+1x+1e3l58YJva21QVGEm/O0cbONAaFKGZEQJguNhMF8OO1m6ssDUs2XEfQBSzAE54xixCHqt19ZmHvZiCk6dJtN7kp+jy1pCf7PidRDEzyYpBNFZfddcV3ugJGfxK1BKwIW6vWTSbj7rpJTofluPHJauHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed83YOafRHU3y6JKlQlrsqhBrArkypsBG3kKNy0K048=;
 b=iiBJapwRa22n1SaOOhWeoXiN5mVaN7M+CFSU2XtjYr+AduJPqymSG2r2yM2vDUZjTbgX56itrKnLdQE7O5Jm1RHvk4bLqV+X5nl9B/lTkLNxZWQbgnqryWVlX0Evw+OQvglcr798dIvF+kh/HsvG2VMoBwVqf1hCIbIO8iO0Mdm5psDPoqwBdV4nlqlIFyBO3uhBgEcy21EZCZvjC+Dgp3BimD0H1FFeQeZqZa44gnYtYFHT3c8ruzBlOIr1tfzAbKy3/Eum+swYG5xZZehLjD7ZwkKNO8A64qRJCtwgOEmgJLT1sZu2xJr3ra4jk8jGa9MkWZRGnSvaWWJ25Jnmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed83YOafRHU3y6JKlQlrsqhBrArkypsBG3kKNy0K048=;
 b=QeRvDktUIpaIN2av0XPkTLGTBzKEwzrnEnNbgfeViPILLzRouYCwP7wuDNk3PQwsGzzje/IinRc/urB5D9rYZyXk/3bGbh1NhFc+VWZ+zPTNz197QtDOGT7mtI6J/Rtr02eBbzH/QzZzFrPeZblAgFtAorTf1S593CMk+94rGJl4bUv/s1Tr18olRAddY3+BedKYtsEiVKDJIxxYfEORih4xDeaUT+/sbDgWvX9DsBgW5Jzjg+iVTJ3XGohAKm7MVAe9eZBK9U3pfvRrY7Wq2VST/iQT0oEPaJ39Q9gSy0L+fP1c58sRNn6fYkB0QlGDFJQHCuVvy8sj+K8pdL2n+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:06:43 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:06:43 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/6] efi_loader: Support for file renaming
Date: Fri,  7 Feb 2025 13:45:19 +0100
Message-Id: <20250207124523.85026-3-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124523.85026-1-Daniel.Venzin@mt.com>
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fa19f3-3076-409e-9717-08dd477844c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eUTyl98oQRZ4E8ZK9xTa8VX09uSozKJUC4QXeqtFgupTf7yoJWfWoSXf8ZIV?=
 =?us-ascii?Q?VFTUG6JI0hsSJlMFEe4xzrut5tTTVCwDbJHm82qUOQ9W4ztE5DCiQ9nqY5QN?=
 =?us-ascii?Q?g1fjnMu0YYaJ+L74BxSsUqyJ9voelYlk/JzlT4iEbzlb++rgNPPU3MJ5rE3l?=
 =?us-ascii?Q?SA25kTe9H7mx39LfUEMqTuf8MfDUgo51VXE6qkaMw6XGUuW8zYftXN8nTRNv?=
 =?us-ascii?Q?r5/fO8cN9T1hXAJHt6clCQRfbHZ4TGYcqQyDPpWrXc4nQUc4QDI2aBca3dPE?=
 =?us-ascii?Q?z2+7hRqyVskyN8t7YQnICCVc6c7NGVeNHndbuAnoyD1CvUfGi/PY0zlgRwBz?=
 =?us-ascii?Q?Y/yH2v57OO3DRgFr1/76DBWrrMo2KGXaOqMJ4/C/P7F7DCotOgUeeerRBOoY?=
 =?us-ascii?Q?UiblReCKRalSsJvPbmAtIspJ6Z0uoutw5f8zp/h9dlJLAqcm2bn2OMflsE+c?=
 =?us-ascii?Q?ZZvFVlZPEUk3PYHwN/PrA0OgLKfkmmVdblFE3tVKGrffZCXK49eeV0g6ezRd?=
 =?us-ascii?Q?8+s6ngxtoXs5dqBmahLTnYh+i4mkJQFafZkFI6nTAGCOpgOKpAh4NmIFNtf+?=
 =?us-ascii?Q?VZyXuj66BcUvH1JetUP7k3Kz7RGBjm5CCC0U8k2BfbwDaO7vheYfmX6O4qaz?=
 =?us-ascii?Q?Ef4dQVT3XQH/mkAoJQYnTuK94KgTsJ3xRAaVcXzHaHxehdncYqyCzlTBYN16?=
 =?us-ascii?Q?O4SUm+COwyaY3J67bRTDH4BVCRD3Oy31Prpm8oIUfdx+K3KU+xWHad+wA5uO?=
 =?us-ascii?Q?Gl8l0uDepyRoO8szvDTHii2TnC6pgQiLC1Ik/hAwFKNQv7FW+XdF8s00gmUU?=
 =?us-ascii?Q?xgpW6I5r+Vma/7RfaRWMmU9WbMPZ/a7eg9mq453nTraVHO/RxFv69iXE9bMd?=
 =?us-ascii?Q?jZQeGypQRiaIKscMZRwh0DUqQv9UfahUPF1cIf6dfwTMGaz9TNvvZ8vtjoMc?=
 =?us-ascii?Q?4YNm9fQxkyekRjch9fjdRLJeM97o6A26gmbj2et44eVQR+I7jPFMoIhpW08T?=
 =?us-ascii?Q?/hKc7y3QyDq7It2ShcSOIsLioMukamhm9tmE69tyI4aswNQW3MYBvVfQ/1no?=
 =?us-ascii?Q?eYbchiQ4s44ECRtJmNBifQvEbCqm0O9JbO8PRQ4swx1T3vw+5aP+4K6IvzP+?=
 =?us-ascii?Q?5SEZYN2v7WwqdroR0IDC0mlChGRppktRRUbmafrZPinQWLk1mxvu1airjC/A?=
 =?us-ascii?Q?0ZHDsMjbwIZQKIx9Ppeavkr63qtFVTV3zKib8jfuVKoXDQ7RgZH2rOI02fxN?=
 =?us-ascii?Q?ZQ127MJU/AYjQ8UzT+Qd4bmwVcAlopvAw8if/PLCtHGE/ppPqq88ysiB//J7?=
 =?us-ascii?Q?YDRoxU0qSNT8daBex1Nab8Z5RHZu5z0kQfdPlsewxa5gka3jAtI/3Dbq/Y84?=
 =?us-ascii?Q?2QjRzyx8Ey94Q0U6nGog93RqQd3LgwSPqFww3vki6qXx9aSZ7TFa1TOiqNX8?=
 =?us-ascii?Q?ifGgwTeVkX1uP0fDqNb1GBVR8ShLwj57?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZg31UsbTtxarMXLOrrfMIMH0TlRQhU7NpTIwuBU8xRd8v/Ur5jftakPIeHo?=
 =?us-ascii?Q?iXGSTj7VyPhYo5yyp1zdyn40ogw0SU+eFHX9rYOoUPk+DU9Ohp6dC/0L5OnP?=
 =?us-ascii?Q?2M47Aup/t7kZ+DKnRrM7pUt9ZFe0GBuPb3MLj/6rRq2kOIeBsqqmCmNETObX?=
 =?us-ascii?Q?2zU4fEJFDKy1gZV40/c9dgdhulIJL+/XmBZ1FPs2pJFTZdscI12SdwZDYOdu?=
 =?us-ascii?Q?xQpzXmlIiNrJmT9yXGDMdFnvb6DDVXSRBVGYZ+vAaq68X9xhuGHKOPmHjjK/?=
 =?us-ascii?Q?54x9Wx3g3qxEty3ZFc6l2VOVZQ7oU/TOc2GC6HFSWiUd/nZV6nBQ2hVOQ1Gz?=
 =?us-ascii?Q?jcvCnvR7cneWc1fpkMaYenQM3Lt/cTOMCKiX/s5dCr890KT+r0Q6PInwYs7m?=
 =?us-ascii?Q?fDLfuace+MGWydczDMFbpfagcHV5vSKcbrH6ec2rLjPGt4GrPEENXMtfEv9x?=
 =?us-ascii?Q?KJ2jGscMKuwOwQMa7FnrqeXCdc9aWNhq1hNlDE2cN9a+Wdk539A68HKZV29L?=
 =?us-ascii?Q?saDowbMkA610ViVZ+lIDACjoQE6q0qbcshhUTtSIwTgHPYayjJDVZ6cdZYNX?=
 =?us-ascii?Q?gT1okK41XShqY2RrVFDRL2ynxFYApZbeac5jCMItTwwmdF58EcQOspgn9Pva?=
 =?us-ascii?Q?JciA4zIZEjTTc7geN9OC+nXVWNlLRPvzmrrO2zaQ6slaXF7IQ8cRZLXfwKQq?=
 =?us-ascii?Q?rQ85pmVw8j8XNHfLPh/ndjyvRH7Mt5F7TaUwscxG/ccGre6o+J4QDfLWGYzV?=
 =?us-ascii?Q?54HNTcU56SulvdB2iX1Tso6mCOzacy2igUHeqKqIUoX5dMSZ6mYN1efkq6EC?=
 =?us-ascii?Q?n0uemMu7Od30gMO9843C0KMePOddwoj36jfu/gF32564sbRGnV6ZKtPpZJ+Z?=
 =?us-ascii?Q?p/HTEnXy+HfcC+n+2JbOdHJjtxvpTNWF4I6hw5hVtfQmE5WcSNN9TwUBhrcq?=
 =?us-ascii?Q?WYCNU5EdxfO3PW+Q0w7hXENwsRh+ijXLWculWGSaNCHDoSXDbDNkZw7gTgvu?=
 =?us-ascii?Q?8EPZOx+Hml76Qwow3KN7/kro+MbliTW8iV/zuOnyZC+qhqjaONA2mRNsuajx?=
 =?us-ascii?Q?1RmCQAasd1An9JvJWFjtD3P2SGbHuLKBg3q6QlxNe6fWnJBmGRp7giRIY7Ve?=
 =?us-ascii?Q?hh6+Mnd3510rx9VV2F2sX3Uql6DeqXw1FD0M5uRyg/uzT6Fsa4BqVqMlsY/+?=
 =?us-ascii?Q?8HW5pDsqbEZz0ZqCl99awtbE0jdRuH6k0BcI+A64rKC/OVTXpqQ2Y1cX5RpY?=
 =?us-ascii?Q?KtQxAtbvrykkeMdmXvHGLIDRIR37Sui+rhSFAeNU8dPH4AQ+E4B9kEOXgjl7?=
 =?us-ascii?Q?hYWTU15Ulypagt9Lw+3+bqVTdZq+QKaHnUoUyQO5Fcv2NMTx+wmsLPDa6mZs?=
 =?us-ascii?Q?pYWnuB1pB9T6yL/BpP65oqAO6J/oEyOAFZR2eJAVwA/GFhy2e/zZa/HxyjtK?=
 =?us-ascii?Q?sb7eCuKub8OwzePrLgu2mFbsI3PdNxEF25yMUtrLxyy5Wzfah7nUAzTPm6Ro?=
 =?us-ascii?Q?R3NM6Xj+H8hpHzajNATBB77Hx6+jKFlGrLyRlx6WUptu+XEkyC/CrYjoEj6D?=
 =?us-ascii?Q?xE+VORqRTYqkXeiYk/X8P20yhlqV6g6HKS2HYAzm?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fa19f3-3076-409e-9717-08dd477844c7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:43.3536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbpAkRlwVjC0MA42Uvvf9mvhYl0jNvpYbHpvGogxmZeodkM8SsVKCcXLg6Dr0kC6HXaL5o4ms8U58C5KQ++TGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

File renaming is necessary for features like systemd-boot
bootcounting.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

(no changes since v2)

Changes in v2:
- Use EFI_ACCESS_DENIED for unsuccessful renames
- Avoid using of "== 0"
- Move the call to set_blk_dev earlier in the sequence

 lib/efi_loader/efi_file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 201fa5f8f3c..9a5a345bfc0 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -969,6 +969,10 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 			ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
+		if (set_blk_dev(fh)) {
+			ret = EFI_DEVICE_ERROR;
+			goto out;
+		}
 		/* Check for renaming */
 		new_file_name = malloc(utf16_utf8_strlen(info->file_name) + 1);
 		if (!new_file_name) {
@@ -978,10 +982,11 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 		pos = new_file_name;
 		utf16_utf8_strcpy(&pos, info->file_name);
 		if (strcmp(new_file_name, filename)) {
-			/* TODO: we do not support renaming */
-			EFI_PRINT("Renaming not supported\n");
+			if (fs_rename(fh->path, new_file_name) != 0)
+				ret = EFI_ACCESS_DENIED;
+			else
+				ret = EFI_SUCCESS;
 			free(new_file_name);
-			ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
 		free(new_file_name);
-- 
2.39.5

