Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E20AE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 17:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208B987F3B;
	Wed,  4 Dec 2024 18:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="uk49SdJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6355D89421; Wed,  4 Dec 2024 18:54:45 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5089D89433
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  4 Dec 2024 18:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyiRY7qntMYJ4Qt6GO3jnCpbRWfhKsQ5fydf5Y+aEBRnGZirBdjLTf5ekVbMuvYk6Ose9o1c4sh/xshVnxBkDCRtZLA4zWPe7qmyywlIVFmzqMT0iH8hJRvgfGVsIuceLT6zCyvk4o3i6oaxOZQVBlRlQNt1pahmsKyejab+i1sPnjn/8Xluac248wwLR+0voofUcl+kL9aIzLgm2zjVlkQFK4h53ZxiKr8q8nRWROwpLNmkaBlJIdTt+GdBouHJGSs64M0egElelv9TDwWJ05UIry6Zlo+hny5rDfeWAjGMle6KSQkzYObFyUGXRYdR7IRls+ULxQiVlYQKQjWCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UiW9ptqfX/DAED7pCfquVJAFMYRJm+wQhmc+PO9IUs=;
 b=hJHt96ssNkn+rVp/IuQKtdnVFu6BBQ2o1W6al98k2VFVEtlDq7EK8HUV6n0pRw9z+pMf5tY1gX0mbUn29wlrNv4/jIiiT8qpsdi5B3XLF0YPkN9t1/WdcYrAoMbJ9JE8d7+Ktx4gTSJIe2PKgosQqsTIoiIZFuuTKrmjKRU3unHk5gnmrl+7cp2COCVxoUikohp+iL6gqMSYo8PLmmKbR7axHMuh3dUjPlS7wboIuS/H+Rrc7Aeir+m/Q2AxxESZNhHVxsfggtkM1fA/+bfl2pzqlxEAxZq43eM5VFXNzOc/17nID+rZoFkb9xU5Dlmf4G73alq55dlZhbj4VX9kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UiW9ptqfX/DAED7pCfquVJAFMYRJm+wQhmc+PO9IUs=;
 b=uk49SdJnNdioyj6sEKrA7FGUZm592mpnSkE9bP8BWYJI5MtWmYAVVr+AIs/0aP1b6x0AGPQNcWSS6rZASamg6jUw/7nSZrOI9Q9BRlp31T1/IMJYGWG2DK1fT9lMCPw7dbcqRY+3PRGfp7ciiqNwQh2P1edp8SDCU6h7rOs15KxGpnCgWrS0qub/bOggbtnbWgcP4E85YaEBh1AjlywBLpWk2bTfVCpoB/uOv3zvneesxXIaPJJ0SZlvTbFRAC2fnadHceY5T/ps80WBPRDJtp8WRS5XXbfeZS+yQ/GN4lou7UV5gM5LWAv1FfdmR/syvN6EMYdAr0jR1lxqaOg6CQ==
Received: from GV0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::25)
 by MR0P264MB5368.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 17:54:40 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::6) by GV0P278CA0015.outlook.office365.com
 (2603:10a6:710:26::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 17:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:54:40 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.75.209])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6A7C72009E;
 Wed,  4 Dec 2024 18:54:40 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 0/5] add the support of sha256_hmac and sha256_hkdf
Date: Wed,  4 Dec 2024 18:54:32 +0100
Message-Id: <20241204175437.185449-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MR0P264MB5368:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd2bd880-25be-4f24-7f64-08dd148cba0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uWyh9ZW+BelhI1oRM1K7Zxq35IL+VAcmlu823I4LWXcz1VKKyjkWjLtWh2Dj?=
 =?us-ascii?Q?2+I/4meUiUQhGTs2/rElE9Tx4axvxAIusrzKaReU0gdGEu3EMKsOcsor064J?=
 =?us-ascii?Q?8v2woN6ajyg1VDIc4qlbPyT00WPOYSLb8cQrtDYFxjRznAzYxcXC2o9wARC7?=
 =?us-ascii?Q?5a9AeC7c46abj6o/Mr7BYOoO0ABApMUq7YkfcMJ4rNNyvnVqx5npel0ttV/a?=
 =?us-ascii?Q?pNpje96dYlrX6oUMERxOpUJYioYODipVrll50CEFeWhjr2DM2hj0qLgv0uxG?=
 =?us-ascii?Q?wzXmha4pXy0znKEMuLvcLyoHLIuzI9RK5M7LA8CRPJgUgTdXqv/UcdWxCPN2?=
 =?us-ascii?Q?MHyGMbFp3c10labYvcfP3eid3OFfi3q35Up4tUYtDibV7319EXNNPiPA8H13?=
 =?us-ascii?Q?IRZ0DeUmLpupmosP/B7ieTVCrxvr1Gb1sBBC7vjK1II+fREYrFORc8acja9O?=
 =?us-ascii?Q?KIb/VhJdGvUW3NpOunvY5n8PBm3xn9+/+nufmOc/Gkl0A+IDeJAbdylY8Gle?=
 =?us-ascii?Q?pxVsxfNFD1FTKa2dVFjg937ys5bxl3K3kquJ0xu+2/dlewPknX3oBsQ0Y7t+?=
 =?us-ascii?Q?u70xYNGVEevdDzhNBfe0BbHiy1yOn5QpYdCsSGS0jcWBBYIYDXritufT8CWi?=
 =?us-ascii?Q?H7M2mcKz2miP3Y6nDLsxApvFQLx/vQ9tpRSKJ+x7k+vEM9BglBHdFIwhGm0w?=
 =?us-ascii?Q?RGYbUHKE1kf6gp3mCdHE7kzilK2EAolmoT9/fAUDB5GTPWHNNwL/dJvh5Sdd?=
 =?us-ascii?Q?D+JeUKSwB3aOEvx0abJ02ipRcXaHhkZmgzLIAu1fsTzRXtZje/0gGB1xvkTF?=
 =?us-ascii?Q?HZBFcv/bIFD7NDF5p96Q1Gf6zz90bjz/4LSiKp5ZnCWtjcnbm8HPQT6bhZXw?=
 =?us-ascii?Q?vbgUn7QRz/ke+Mvq9uu5ZQEkvTW+qiiA+3HC07cA0Nh7lUtQAln4liKzq/nk?=
 =?us-ascii?Q?rLeye1a6dWNsyPom7JDcVSGthZKy/97lCzGctZxzhbCFnjTQPkaK9ykag6p3?=
 =?us-ascii?Q?EMw/2cO0lKtjJ7n6cqFXpjbOH3AmR6kLxJ0AiyulNm8d76Lf2GfBqT8BlCJ5?=
 =?us-ascii?Q?pzzHBQA0JGdxQzsqA3RzBduecq0lSxVOIkzVYVy/wDA4xGuiv50isOtFZ5hw?=
 =?us-ascii?Q?3aPMSfXCgSXUh/wr75Oti5PjMXujHy19y0nc3fmZ+q8sAaRjKsv3xfFlkhdu?=
 =?us-ascii?Q?ElBYI3j04ideEaBoerrBqsv/o8O9U7gftN+DDP1Gjg397H8lBnmYzzE0cd7k?=
 =?us-ascii?Q?pA1oXTEMHrEDtsYFGN1Ct+TNaCo+3Aet3QfKJxIZc1IlQJ242RbZ0f/6foFE?=
 =?us-ascii?Q?3+Fs68vznLiz/SegKAjK3wuRU6Gx5f+k5KbUDqU4hSQ4E4VhdV0dVhpUGP+O?=
 =?us-ascii?Q?kkbsYN/N3XyU7z6bai9OOe01yYSyXisAyIGB0he0oh3j0k3nMuOcT1KKxL/U?=
 =?us-ascii?Q?RMfePSEJEWpRUl13nvBKtgyRlXYyP8G9?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:54:40.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2bd880-25be-4f24-7f64-08dd148cba0e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5368
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

This serie adds the support of sha256_hmac and sha256_hkdf.
A first version was sent several months ago just before the 
integration of mbedtls. This new version is based on mbedtls.

The first patch of this serie add the support of hkdf
using mbedtls.

Philippe Reynes (5):
  mbedtls: enable support of hkdf
  lib: sha256: add feature sha256_hmac
  test: lib: add test for sha256_hamc
  lib: mbedtls: sha256: add support of key derivation
  test: lib: add test for key derivation

 include/u-boot/sha256.h          |   9 +++
 lib/mbedtls/Kconfig              |  14 ++++
 lib/mbedtls/Makefile             |   2 +
 lib/mbedtls/mbedtls_def_config.h |   4 ++
 lib/mbedtls/sha256.c             |  56 ++++++++++++++++
 test/lib/Makefile                |   2 +
 test/lib/test_sha256_hkdf.c      | 104 +++++++++++++++++++++++++++++
 test/lib/test_sha256_hmac.c      | 108 +++++++++++++++++++++++++++++++
 8 files changed, 299 insertions(+)
 create mode 100644 test/lib/test_sha256_hkdf.c
 create mode 100644 test/lib/test_sha256_hmac.c

-- 
2.25.1

