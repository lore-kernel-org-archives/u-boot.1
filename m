Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5B4CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A638466F;
	Fri, 15 May 2026 14:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="jywLYPif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4BD838BB; Fri, 15 May 2026 08:05:50 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2A683E81
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBeCjwqL/FBCsseCC1Acm973fqyVkBXrZSfbl/rsFuL5fgHp98WPvoyt8+BwHsiX5tP7b9kP+sVgv7OWe6OYVBcszeek/jQ5jzXEDNSxyJT0GfCenXPUAoqYMUTerhGjkXakK2KZoFNIi9ec6ioJ/bvPkjQQYtE5voWgPaPeYlpHdxMlqy+ztcEIY3NSBzCQR9oIEZeaMRMPQD0cZacImJ4xQPmBJE35XGmdkODu1pWi9NhuyZd7+1UVCOy20H6tdobNCqGQJxfU5G9f0ieucxdS1N76MecCOT2MFzyB1uXkzSnfuRDc0bkv+zBdjMvctUAQmjIJ0gOOzgrY2yvcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBftp7r07qE2w6IZZrmjw+xHv6m9WbH9P7hkaZsKijE=;
 b=FlqXK5Yvb4VgnTi/SnezCebA8fvXTb7tlTfouIoQfD3K0FErJRbcNDQFSpw6nUbirfcfq1pSsksDvtxu3Oj/R9s2OL9npaLeqXGVw9d9IHSDZZQk6dOcXkgCatBuWXS7vEaKevOyjJ5xggEnFMfr30fO+0THD5Rsjasn9108qOzfye6ggxHOrtkZGMq5Q6zSjMa5hBmbh7r4264M4SePLv5KlGpQ2W6YK7b+3NCPwJi9GKiOrRjkgwXEFIFXLRAMttUw3gUbt7h7y6ImvuHUwM8YAtYTj6CGNBok3/ykjFVuRRCank/Pwuvz/3PcmLXzkuMuttHYtB3bxtCVkIYfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBftp7r07qE2w6IZZrmjw+xHv6m9WbH9P7hkaZsKijE=;
 b=jywLYPifcP2rD1zVNvZFKHUglhV+JshOEI8R3cFqcWlASpJ6WTRPaeFynzjI5srLBCXhnWyrDxDoa/2x70ozIpiGBhezND52mN9u9tvWaD0sTyHIqalS3e8hIRH9bzljYbPU9ccAEhvRnytI0fevyJ5EZ75ZNhB5rRbxntfi0xjXMtzU8neswNSfF6YuDuHyW0qM0upsmZwMCkkiYlkhDri3qRduw8h2p8xxjLU6gtdbdUmDbkU4+lKxJzRvH76d7FK8uLNJpWcaD+3al77xbkAXV+EwgfljZe72SmXWxJ8JWwkDZRWLQO/p1nbQfbHzbl/v+g7SocfoRyhMpX/xJA==
Received: from BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::11)
 by SA1PR22MB5271.namprd22.prod.outlook.com (2603:10b6:806:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:05:36 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::d9) by BN9P220CA0006.outlook.office365.com
 (2603:10b6:408:13e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 06:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 06:05:35 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 8B1AA131E4;
 Fri, 15 May 2026 09:05:32 +0300 (EEST)
Date: Fri, 15 May 2026 09:05:32 +0300
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>, lukma@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/7] imx6: clock: allow different clock sources for ldb
Message-ID: <aga3rIW9M49mf-VD@zoo11.fihel.lab.ge-healthcare.net>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260428085117.402523-3-brian.ruley@gehealthcare.com>
 <CAOMZO5De=9ECdSZ=VxvhrAJxRX7vpHu65hCueUn7VChmBnYPxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5De=9ECdSZ=VxvhrAJxRX7vpHu65hCueUn7VChmBnYPxQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SA1PR22MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ebd364-ade9-4637-575a-08deb247fb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|30052699003|13003099007|11063799003|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: bHt57bJaOSq1yMOYIR81v5EfvZ957kXNtyijYyel+EO7mcqI09idPzb6yf7o5Cu8Co8kvRnhIbaHz6iOnpxFVA014rOjKrwaLtBMeypOXuVpGKhDx3sWo0vSxGo+Xt7iYb57En8/HVqFR4/uYjuBH8nqBOo39FULBQ5dkMgIXmq0Ta+BjHu1tCLK/C2kRxOhiLZKusMbEX+eBtmBKq0BqlERL5YqKk9FRXSgtuekjFoWE0VcMrWAA/T0zgGFThJTBDfhlPBVe8hAPRGq1EnF/6964FJ9RR7Idn4WiiuRMrjQS0fsTG/1rWg9ZjGAqUuQ7KHrtkK4fG3cwfGFcvYVTPjnNoFp/HW7YDDYVbx5WCwD5lYFap4aVRaGPTYwBAhTFnt0Lq3Y1jkzM2tO9qXRJ8Zu9UpGuasRsw2dMHSmE4ZVxSAAAMoy8GzP/0FnppKn+RB8oYj5rpPFW3RXa83NKmLLC2wj8SXvf/nc/qz7QTj1edYtWdOKPwamuwjUiyVlWkTvjyQx3Bvj8Bc1pV/z1JdUZM1QG+t3ct2Hne1c/SawNmu9LbCahFXOYVbMAXqCU46nlemT466OBY130OoDuqi6mfZH/LJQdI8Rlj3uX5zNh89jJNWLoHmLBymYks/c5HotBiFmyy3fqaXxOwOad1NNv1fKCJxmtc3G/5J5nwJeRZ7VZDezEVcNdoNYjFAd
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(30052699003)(13003099007)(11063799003)(4143699003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bkmWjGmDs7rQ4Lzt1o4MOyVyBirdyc0fcjkKxgAjgVuyQgTRXalomV7NCm80vmhYCNOQRgzn3lxQUsSnMSbVr8nnTYOp2qvjNlS4YW9OtW09ihP+3NdVRJztI0d+OdQnPa9tD44y8UVG1MiDJB8bJfuVhGPbKi8JdLF85xpPX/TAavBguxkxXZm1b8UrCtff5eVr1mHWpziqU1QfO9ZIlnT/r74I2Bc108gmi/wSd0qyRHHJ56yHmfxDFxlGwiNQOMG/F1A8DtqTp4suiOvDG7PQbSxQpiXtPg/KIjEeblpGFJTVP23Qazjo0QfR/MqSztbALVRzD/gmlebDUvVWRIcwqsEr+e97j4oEl+llEerq2eVKj4/AnkzoFNp8Xuzzh5WaQSdCv9/gVpHdNwCGdbXPK67cn1Mzds9nf34rZI4h8YFwIn64TxiL0PjeOsZB
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:05:35.5023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ebd364-ade9-4637-575a-08deb247fb0a
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5271
X-Mailman-Approved-At: Fri, 15 May 2026 14:27:41 +0200
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

On May 14, Fabio Estevam wrote:
> CAUTION: This email originated from outside of GE HealthCare. Only open links or attachments if you trust the sender. Report suspicious emails using Outlook’s “Report” button.
> 
> On Tue, Apr 28, 2026 at 5:51 AM Brian Ruley
> <brian.ruley@gehealthcare.com> wrote:
> >
> > The LDB clock sources don't have to be the same, so allow DI1 clock to
> > be configured separately.
> >
> > Unlikely to be significant, but the reason will become apparent in the
> > following commit.
> >
> > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> 
> Once again, this series does not pass CI:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1450024
> 
> arm: + kp_imx6q_tpc
> +arm-linux-gnueabi-ld: u-boot-spl section `__u_boot_list' will not fit
> in region `.sram'
> +arm-linux-gnueabi-ld: region `.sram' overflowed by 200 bytes
> +arm-linux-gnueabi-ld: drivers/clk/imx/clk-imx6q.o: in function
> `imx6q_init_ldb_clks':
> +drivers/clk/imx/clk-imx6q.c:271:(.text.imx6q_clk_probe+0x1458):
> undefined reference to `select_ldb_di_clock_source'
> +make[2]: *** [scripts/Makefile.xpl:546: spl/u-boot-spl] Error 1
> +make[1]: *** [Makefile:2440: spl/u-boot-spl] Error 2
> +make: *** [Makefile:189: __sub-make] Error 2
> 
> For v3, please share a URL with a green CI pass; otherwise, I'll need
> to ignore it.

Apologies! 

I honestly did not believe there to be any issues anymore, and at the
time I did not have access to the GitLab CI, so I ran some additional
tests locally.

This was an error of judgement on my part, V3 will have a link to
passed CI.

Best regards,
Brian
