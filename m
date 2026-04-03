Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226E3E88D70
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6FCD8413A;
	Sat,  4 Apr 2026 07:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dOVBQLXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0228F8407E; Sat,  4 Apr 2026 07:09:51 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39AA84132
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fnkDC26fxz9tX0;
 Sat,  4 Apr 2026 07:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775279387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPGAvpYZ1ey5sjQmjz571eAzmqr6l3Jc0Pi6vo8oB34=;
 b=dOVBQLXQOY0MLAqeWPGAn6Bj+EwdReEHd0LcGmJx54h7dW++SgprM+l7Zv+SmXgT8JR1+a
 fMKNQ4Qy1NKHK2aBpIpivYONJUcvwgvp4MwE5CauP5H7HJRzCEC9/WliJP6XEb+25pa34/
 f85OxOLsoW0MWlT1K2Gsd2Cs74hkEnKFH6Bu+oT5Unki70G9ETX2MgitM5oVoVcJoeJMd8
 UVf/JBBC/YZkgqV2c3ES3K83QI7RqdD9RVq7O8YT69DIeSiAaj+/+inFWtRnJPKP4ljZS3
 FPSxRWQXY3xT5jnaRezs25IPOEHdb0WoNxJuh1/cEQCWpndLBMtLREiEJ+at5A==
Message-ID: <de47282c-8fbf-477f-8ad0-24a3967479fe@mailbox.org>
Date: Sat, 4 Apr 2026 01:18:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/6] configs: imx9{43, 5}: Enable SPI SFDP support
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, viorel.suman@nxp.com,
 simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <a711f4dd7adfcb7f08fd679c85ca42a93e39bb04.1775121078.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a711f4dd7adfcb7f08fd679c85ca42a93e39bb04.1775121078.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8c4k67wouhphhjgxcpupy17ucn1py4mq
X-MBO-RS-ID: 1059dc6381a87fbe9a8
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

On 4/2/26 11:40 AM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> In the context of saving Quickboot data to SPI
> NOR, this option needs to be enabled so that the
> erase size is parsed correctly.
> 
> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
This really has nothing to do with quickboot, this is a generic fix, so 
please send this separately with updated commit message, so it can go in 
quickly.
