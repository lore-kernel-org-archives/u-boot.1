Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426EDC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5733287E8D;
	Fri,  9 Feb 2024 13:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="gHpsQTZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA9D87E65; Fri,  9 Feb 2024 11:30:49 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C6B87E50
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rYO9e-0002lR-2L; Fri, 09 Feb 2024 05:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=1JrbikEMvfpEMCFsf0htHmJc3MZDmFFCw0fMeHq0lU4=; b=gHpsQTZWkGU2lAgVmESM
 FJnXAGRBmRPT9lYqgPHQnsHmvk4zK7CZHM1pbWsHlLooDGA51YESzh2BTRAcvOsSacaT9CUPJNkg7
 v1jcT7stgnNkcSxoQhYr05OoehpP2JuUZ4Sd94av2HuY5HGygtbPlTF8Sof8Swx7TqMVPv1lspYq7
 ojDvhb8ULNCesUWIuJcfvddvnQGGd08x31V+ao6Z14+nfZDqo+hGG5/DoPuEGFYphU4v6R/ab/or0
 p7FpTWVnLuBkBRC4B6+zGGoQ8qsC8HNkxXc46VE/fndFEUMlmIiBzXkR+5znr0VmFz3n/UPK5SXv8
 uoyoSl8tQP+0/w==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Peng Fan <peng.fan@nxp.com>,  Shiji Yang
 <yangshiji66@outlook.com>,  Ye Li <ye.li@nxp.com>,  =?utf-8?Q?S=C3=A9bast?=
 =?utf-8?Q?ien?= Szymanski
 <sebastien.szymanski@armadeus.com>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] board: imx93_var_som: Probe ELE MU
In-Reply-To: <CAOMZO5D1sVNMDZ861m8Y9-XVV=rAjLC1LCcfmGtpt4dB=iXZ_w@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 8 Feb 2024 18:27:19 -0300")
References: <20240208094518.391-1-othacehe@gnu.org>
 <20240208094518.391-2-othacehe@gnu.org>
 <CAOMZO5D1sVNMDZ861m8Y9-XVV=rAjLC1LCcfmGtpt4dB=iXZ_w@mail.gmail.com>
Date: Fri, 09 Feb 2024 11:30:42 +0100
Message-ID: <87a5oaylnx.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 09 Feb 2024 13:04:59 +0100
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


Hello,

> Please put this prototype into a header file.
>
> Currently, it appears in 3 imx93 spl.c files.

Fixed in the v2 :)

Thanks,

Mathieu
