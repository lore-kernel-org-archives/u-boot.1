Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C9C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 09:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832E680548;
	Tue, 18 Mar 2025 10:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="bLu+0h8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777FD805D7; Tue, 18 Mar 2025 10:23:58 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504B680107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDBRXBvJ9/gEOmzvCJJMU60lTUGYCbI/XNfSuevZ5O9jVmoicA0yizNJqt0t+1QREqOLHJpmqnc9/rO9tf0A2NZJFQxHBRJMvQUr7ZuOAf9+n7rXacTCfiQjNzHtnOU1t4YGObOjD8WPbw2BVSlKytHBB8L40HzI39p0HMEmbMZebFesteDV1xF0hvjsPLdlocasU+Uql61iVKVjkp1ystAvIL233T3pP8ovTU7bb7tcyPhhM0IBBkzj0LFtyDfI5s1PF19JQLt5U05avxKns5gvHef8Bqh5ztpJCSZwPRQygfecRnHxUBayhcu/zkgPY2gULYHL8EbuSkL9IfaZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIseNOwCwm7+vu5cZpqqlYBAqQ0slzdL4IsdwMMU7Sw=;
 b=u3LcrUNG5DTe+LH6mhgnAZ0Rl83gpt2goHUATM6ynaBDKFYCX1zyGtsm3lCGn8Gc3rK5JE3bxft0Tf6+q5sE29qvddrvcLXJ/kMOMVxyjH5x4Zs6HtL4Zxcve6yWhBNyA9Cb5+5ygmF2LEHiGopzcA8aAXjWBfNgC7gUDUiRPhExmAq8Aclj/phBs9LkIw9TQ6eTC52I1lmpCbawUh1fFCRHHzZP/msH3CQibBml73BIYXR7PII2rQoN2ZJum+2ZliVVSUdOf2+Ez8tb5vzeg6G9SPk8lQzixjD2Wsdhs5XFI5LEwLIZJKgVm7a6USaFTDAhRvVUKNrH54bXSotL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIseNOwCwm7+vu5cZpqqlYBAqQ0slzdL4IsdwMMU7Sw=;
 b=bLu+0h8FOYewKoSgzwoox5G9/NyE3W3QU4pjP8fMNlFR2r3u1grZg5mL41Ok7ensJHR7wamhiIJZM6yaKLdAMr9/2cVU08kbBEj+7LIGX1TTnRNeJSyrxGlye5qCmyeKhcKqPFUrR/zvMngCfw15X/ywxruir+hv9e7DnBdyFksFawOHCTTrOwXLcCXZxqe6nW989kEcSXHKZiYNWS2VqsAsrOZaXEJLAvBW6L6WdKd1YaKU5F36Z0aAJs/VnbuqD77dOeeG+kp1c0xlDiFz7CK76DbrI9E5UPI4Y6Tc2seO6XEnoGd3W2ucSEuqv+XC7W34kHCnCh8yd5HUQmXT+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by DBBP191MB2411.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:23:54 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:23:54 +0000
From: Pawel Kochanowski <pkochanowski@sii.pl>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Pawel Kochanowski <pkochanowski@sii.pl>,
 Gabriel Nesteruk <gnesteruk@sii.pl>
Subject: [PATCH v2] efi: Make FDT extra space configurable
Date: Tue, 18 Mar 2025 10:22:18 +0100
Message-ID: <20250318092327.55203-1-pkochanowski@sii.pl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ea::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P191MB1394:EE_|DBBP191MB2411:EE_
X-MS-Office365-Filtering-Correlation-Id: 483bda90-fe79-4143-a158-08dd65fe9a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?McGOnmaNlElr6FIf0PU+mJIAfA9yxaN6AtVMH46D7BuciFIW9SZ7Cga+VgE7?=
 =?us-ascii?Q?Ig60KfqIpWe5r69KDkz9xkNQK0LvFBS6LHSzvYtpdEYMV3CvR0GzWzLecv8f?=
 =?us-ascii?Q?fSIcc/OoTaTsYIoVtd7o/cCnDEEvlCQ69XRRFM8mGmezCi0nUkk/x34h3h09?=
 =?us-ascii?Q?jD3zvRXH71dVqJLaNE+xl2JkwC5emlA5QcN3JUot6HuWhU2wH24dSKvO1v/+?=
 =?us-ascii?Q?Oo+g+Sq+B4JSOeJKNbEBtbLp41hhNtWdQUjYxSsdJm8XS349B7ATQAwN+ug9?=
 =?us-ascii?Q?RSib9OQ9hrkLIftuHEKos520xiT2kJ7LOflTmjLK/x9jndW7EGOazoiIc10V?=
 =?us-ascii?Q?zHOPFngxksoWmW8gDcEDJFkBfKYfd+1vSv4jTvNg+eh1XRc6pTvJKSbuntCu?=
 =?us-ascii?Q?FJ2jzk6NVKicKFSrBpu+0GB7GaE9hHgVs7mm638+2RboQVNVhSI40mkkYbH4?=
 =?us-ascii?Q?ehXLgYIx3OlRrhqQsd5+Efe4t/pqcYilFKa4V7RlD4QE3rYg8AFagkDqpi0y?=
 =?us-ascii?Q?kf1ANDcSB38EAQVLpPrgb7ok/FxCMRxxOmOmNIFGfp7nu2ueoV4DYs6DZhRJ?=
 =?us-ascii?Q?0/VkjN9e4mFpj8/yE+8wpcASKe19tSpPMwLBMOwtNaTtS6vLZDv4IW09MHi3?=
 =?us-ascii?Q?w9qM4ox/KNDCMqwnntqd9luGm9QyTf7qt5dErwy+Nzd8+dm5SCyGsR3r92mL?=
 =?us-ascii?Q?WuVxzjRzeAcFX8ONaggnugnDTo5aa0v4SmQio3X3y5IEMg+82iFO74Qhgrs5?=
 =?us-ascii?Q?EPow5A6o6GdGdH46IiQ5evdIGWoQLxLJZ+MYQSoCnHAgvDFDsQd0Bh5HnMkt?=
 =?us-ascii?Q?sSp3sQIhLMRJ1iFj2mRrusawmu7h/FjZ1WsSDCz+fR8hmo01UAjJELJm46ov?=
 =?us-ascii?Q?zJ1SwEZBBVJZ+XTcL6yMcmFyOwyiPMcg2ZED+dSToTytFTR+x6/g0ZTUlUps?=
 =?us-ascii?Q?JkEj1Q15k8XA8Q8UJDRgRPGSqA4uCHP5NhWrA/oHxmJQXyhfbcCj4ksatJaT?=
 =?us-ascii?Q?PSoMPXLOhS2+TF4VPoeBA7irpmVR27SRbq8E7nLG7xJIv1wYqm9bFo4UjUjp?=
 =?us-ascii?Q?N7Qh93QpXz/Kp9HYi2XJQKkT8cjUDraoddiT0ijb4WM+sk9BymNfHYMKyHnk?=
 =?us-ascii?Q?8bDulzd1H3ED/Zxi4shTMScBMkPEv5PA9sxBLQkGRVtrUwMFo2WDg9Vvmjhb?=
 =?us-ascii?Q?z0E0k7mHelH3ePQTEa7JHryFDkGB83om8WPWCAYXhOvoKb5n476mqv6LZuwS?=
 =?us-ascii?Q?NTdKFx6wdaYkrHEnzkO4LlA5YCU6dh/HlL/owTYfgjbfxNteXw1m8YUkWOQT?=
 =?us-ascii?Q?Llg2E0q/IbZtiv3OGGjEM/ET5nzM/xz7bMsaUBwEhhvuqKUowf6KUCgb2HL2?=
 =?us-ascii?Q?a/KoPRLypiI93fegAtjWj/MnqPu8T1Quo682D/97vLXjqI/Obk6aUOd7w1ba?=
 =?us-ascii?Q?+Ejyoij0Z08YWavDIjvyTrn0/BBbZ+mS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBwy3RE+EjL+xQT6bmlYRC1z70h0TIG2S78SEVdKbf1SAT5YAIiCDYHt3jcc?=
 =?us-ascii?Q?esK6BvAkz3z2l+WtGkg5LEK+d2TqgoY/heYkXOFzyPdryhPB5MZVwK8Zm52m?=
 =?us-ascii?Q?eg1HUwzfFx02Dt6yXxOpOsh15s3Z6WHySnBmBdRbI1DlGn+bqFO8Da1HkFFz?=
 =?us-ascii?Q?6K7Tor1H7fAN3siJAM+QGKGUacXyCW4CbyM0RoUFt9GMf6NR7v3b9I4StlBt?=
 =?us-ascii?Q?yyzH5PpWHzTLMGXaRMZeYbAZVo0jqm3c2oKyXaqsDbNADtBBeBabHkog0jMA?=
 =?us-ascii?Q?7qq4o3Cq9Dzg6XGV+ehTQ49WOM1P5k5dnMQYYqBTOeT88scdKPcMKmubAWmI?=
 =?us-ascii?Q?qGnOJV3nX76dVe9f7ChzQuQ80Y32S3ATmCqDLlDPBzhNoqbLHPX2LfmdWCoQ?=
 =?us-ascii?Q?COqlA25n/Dllht/DG8ZkV/S/7U2voSw89xqeie+L9OOkHrj7eHmF27sk5dBW?=
 =?us-ascii?Q?XMWcpAsbmjAgrLuK5Q2ym5D0X/KQugw3WJevhs4HaKOrTTeGlXiar8cNfcrs?=
 =?us-ascii?Q?/1WCx33GKE9+DvzQWfkNElogumHkLIZEH7rLCHJeC2j1ry3OmwuOMF6YD3/8?=
 =?us-ascii?Q?K7Q63t7PkMLHAR/ZBY6m4VQ2MCecSiuRx/pbt6+9AGIZLLWKUVATmaY1zeKa?=
 =?us-ascii?Q?nWuICWOvGUZffsRgUKKjV6caiOI1FY63O5NaM5SJGEjIJ3NZf5W3xxzXSlZE?=
 =?us-ascii?Q?HHCn7HDxuZobaWQVoZIqLgyI9nmyvrle6QGgOTRTmtrcwbjLRArQUYtlY8Pc?=
 =?us-ascii?Q?/MCBgFhPV5fgpXs6H/ngA6NQnPMVshtc+/kR+SbI21sX4qEFxk9ZkaG1aAUv?=
 =?us-ascii?Q?sJ/yp06/MR8+Ae/Eqxmygj0F3O9+BaA9ieZ1QZpWIQpfj3Jeg+L+TLUUMHR+?=
 =?us-ascii?Q?/6iUbcba2vd1SqHs/59Jjm+AUdFV6yVRma62xnrar/lrNfPVJRVwqHKTYYmf?=
 =?us-ascii?Q?Sqn2De2ikLlHaK7curhvibqUIxc0F8L9Y//U4WjQOrR/dF3emqq7i+Vsw8Xa?=
 =?us-ascii?Q?EKGQJCbmzQhTsgPtdFmyEQUgQpwWtJi1ZcHPC1X3uRYm+l138C59sYWEYP9X?=
 =?us-ascii?Q?x9o3NHVp5JkEg/JO/7gYuFg2q3JkggBXeVyvxL5bObmAbFBqmyfCYYOsTzkn?=
 =?us-ascii?Q?Xz/JfgYu4R4vaKkumDjv/OGq71D3sop/5O1kgdhzuFvw8dmw+qYlTCfffhHw?=
 =?us-ascii?Q?/aEmIDzO+ssVWn32xdFD/CGZr9w30tOehQtCtdep7MpZN1yR4EBMvtH5oztM?=
 =?us-ascii?Q?4pFqUPcFZkU1CnOOIXq57DKq50Y7PheSA6ITtGKDaf1VxKXe9INAw4oUOq0r?=
 =?us-ascii?Q?Q2h5PZRjnKYDol4ZMv8tx27JqSf1O92euhq/GtN7Eudj102QGxHSTTdcxs3j?=
 =?us-ascii?Q?3HIY4B7k+xYGLdEpDFXOGvAw6oLXcrLXoFEH8puDqcKhjKpKJBVYNusED/fw?=
 =?us-ascii?Q?qeVUgcavo2m5TarGDVxiUU7VrJEtPUBeOAVosy8N6VR9pcTqUAhF8aNxNJ9k?=
 =?us-ascii?Q?n+ZNHclrfuu65GmZ221fozuVu/hI4fm2GTFiK4LbFPWWdse2bEek8bqjQwSQ?=
 =?us-ascii?Q?MhWF6MCnIxtTm0vyZEE6JvvTc1bnvmOiOqoXQEBR?=
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 483bda90-fe79-4143-a158-08dd65fe9a38
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:23:54.1403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwjPQ3vPynSa1OtfNicCMPoqMaxUFuK4FazUjyq9mvB+O9rAIiI/OuOhxp7jYSrnzb4iJ87YdhcS23F0HGNoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP191MB2411
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

U-Boot currently reserves only 0x3000 bytes when copying the FDT
in copy_fdt(), which may not be sufficient if additional nodes
(such as FMAN firmware) are added later.

This patch uses the exisitng SYS_FDT_PAD to reserve space for FDT fixup
instead of hardcoded value.

This change prevents potential corruption when resizing FDT after
EFI boot, especially when firmware like FMAN requires additional
space.

Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
---
Changes since version 1:
- Removed custom CONFIG_FDT_EXTRA_SPACE in favor of already present SYS_FDT_PAD
- Use the define also in efi_dt_fixup.c

 lib/efi_loader/efi_dt_fixup.c | 2 +-
 lib/efi_loader/efi_helper.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 26928cfc454..544e1aa9808 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -168,7 +168,7 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
 		/* Check size */
 		required_size = fdt_off_dt_strings(dtb) +
 				fdt_size_dt_strings(dtb) +
-				0x3000;
+				CONFIG_SYS_FDT_PAD;
 		total_size = fdt_totalsize(dtb);
 		if (required_size < total_size)
 			required_size = total_size;
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 04b2efc4a3b..40e5d31575a 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
 	 * needs to be expanded later.
 	 */
 	fdt = *fdtp;
-	fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
+	fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
 	fdt_size = fdt_pages << EFI_PAGE_SHIFT;
 
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-- 
2.43.0

