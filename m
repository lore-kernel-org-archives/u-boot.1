Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9ACCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 21:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181C7841EF;
	Thu,  9 Oct 2025 23:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hH+jTNrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCB584205; Thu,  9 Oct 2025 23:29:24 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142B8841EE
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 23:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cce872d9cso998945fac.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760045361; x=1760650161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iogqB3T8SYJ0sPWdsHP+GrKQRQ7OV7cC6JotJVcwuc=;
 b=hH+jTNrOFuJ5nU6Mcukb0U5GM4aIZQwJ3/uRXuZ+pB8ijWwuvIEA3WV3Qvx9nFwDM7
 uMtg9iWhxtTXCn/8hcQzMbFMz9GSUggFD4x8/w/UxlEmMQwFtAb1j0Tf+6ja3JHzlIeO
 gT0trwClz/+dfqWUY9t8m8ye8nHc6q8o8OcmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045361; x=1760650161;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iogqB3T8SYJ0sPWdsHP+GrKQRQ7OV7cC6JotJVcwuc=;
 b=lp07/xcRxdPsHuoJGVcQyl+qHTLmqpdxGl5VdII/rx6HNk+YpHv+J6ReNOGBJWOVDw
 mdJaef45k2XGjFTIgc1A/V9i1LwvCQUgdfYL+uRmrxZ//sXgSma4X/DSytp+Ij7jviyk
 xAtpTnWgH90pa82WT35eWX3iNT04y69XOtnZJdIFusE34S9h8wm/IW/QIncfz9zl2POU
 29SudJmLWjY/h9V11MiTG1Vvz2Quc3feupmv1nFwsmnCxOhnv6/PqLqdeblMJilCmeop
 4o1KYbtRzPBIYxxrmffthmu5k2BsEI0wVgeVAXXUckvZP9oYz1VLApI0oCmPsLyRs3+Q
 O1tQ==
X-Gm-Message-State: AOJu0YxwsFXQB/I3LStUSPbRbBmXnfX4nzeM0abTZHRrqgMKUINRkVu3
 hgmOQkR1khCjTqLvTrglEKdkqHIBgJgYhVnFgtkj8/w7bgNWs7ub1lnEGi+In3860+I=
X-Gm-Gg: ASbGncvFspOK2zpu/xtJGbDIILI2rIFHf3IAaemFpBCWDyi1Yog7GQHY9aEesbw3vdx
 Oon1Fxu8ghJf21+XFTqNQvfjiiww51qyg93zTzrjkb6PC8pjg+21KkWRboh0ul5cJJ88ZolG3xI
 lggxhxyZ2JjEi91szWwdXviFKqY+RjVdnl6VYl1WFxoDJATU8mOD6gPuwWc22RJ04himsMePtXY
 CT4/bmM/z/ZJDMfTCfggbQ7kf+eSjSIZAiB5VjhG3ALQpCRqDdfND3+C1AaBsel4mBSKBP8v94v
 i/7ijfEKsY1P5655nJJzdjNM4hsW+G6IJFrecULqaMurL8CTmj9QfselUFoo8YXh5Yuc47SMDtT
 v2rEvfX9A3wSCN29aHoc0+QNN6oNH2WtWxXn/sAF+s0km05E9pnNJWeCXmTDjlMKnYk/+7dMgM0
 sq7wERmJDm
X-Google-Smtp-Source: AGHT+IEGcWu1PNFzxyXMU4gJf+4QpZqfPJZ/d6CcheoEvTS6ZjJk5vlpholpFUDCP/K0VL87y0vCXA==
X-Received: by 2002:a05:6871:807:b0:31d:8e95:2f0d with SMTP id
 586e51a60fabf-3c0f62f8497mr4411828fac.2.1760045360765; 
 Thu, 09 Oct 2025 14:29:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8cc4d3f55sm76479fac.3.2025.10.09.14.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 14:29:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20250922114926.51984-1-marek.vasut+renesas@mailbox.org>
References: <20250922114926.51984-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] fw_loader: Split from fs_loader into separate
 library file
Message-Id: <176004535929.1002224.15767748603250054968.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 15:29:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 22 Sep 2025 13:48:27 +0200, Marek Vasut wrote:

> The script based firmware loader does not use anything from the
> fs_loader implementation. Separate it into its own library source
> file and convert the mediatek PHY to use this separate code. This
> should reduce the amount of code that is pulled in alongside the
> firmware loader, as the FS loader is no longer included.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] fw_loader: Split from fs_loader into separate library file
      commit: 8aa57934e52f254064338cfb2a445af9a1f592f9
[2/2] fw_loader: Prefix the FW loader variables with the script prefix
      commit: 50fc92938623be4a1cf1993c703812643afc9cdd
-- 
Tom


