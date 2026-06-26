Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E673CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 09:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CBD8494B;
	Fri, 26 Jun 2026 11:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nAK9VzMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FACC8404D; Fri, 26 Jun 2026 11:18:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C268404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F41F060098;
 Fri, 26 Jun 2026 09:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5DA1F000E9;
 Fri, 26 Jun 2026 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782465525;
 bh=f122euai1SC2hduPMzxl6uteebk+oYzAbbUFa+aD2xU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=nAK9VzMuNqNMzPbkTbzhZZI9o8V+fqflTxOLUj+tKwuzZYz2beiohQx8rLXcGOcgl
 ws4f9z/tFjnH4KGOtVJvExVGSSrv1AdCOyFCOOxhO86wfVgLk+z/ZgtL0KXDUNnxfO
 H9UwVLzDaQWho9Y5sR3FP2xtCOHxyt+pk7V1XrTKCX/caNlcpg5QPGEfow0ltml8x2
 fkaN0fnM7p0LtfL/dr+wiOgXGLVSeVv7ojLBZ9TXIs248sH4yQkvKxEdESf0OVbsLs
 Lu8FpxxTe7HdfPjasa1cwKrOqAAijC05O6GFGnmjWNelUFd9RyzVhiIwkBp8HAo/7t
 8IwJpDOKwhBpA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: lukma@denx.de, festevam@gmail.com, u-boot@lists.denx.de, 
 peng.fan@nxp.com, Ye Li <ye.li@nxp.com>
Cc: uboot-imx@nxp.com, ye.li@oss.nxp.com
In-Reply-To: <20260522072705.1156220-1-ye.li@nxp.com>
References: <20260522072705.1156220-1-ye.li@nxp.com>
Subject: Re: [PATCH] usb: f_sdp: handle the spl load function failure
Message-Id: <178246552252.1113926.9759070219745699591.b4-ty@b4>
Date: Fri, 26 Jun 2026 11:18:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

Hi,

On Fri, 22 May 2026 15:27:05 +0800, Ye Li wrote:
> Current implementation does not check the return value of spl load
> function. If the spl load is failed, SPL may meet crash due to
> spl_image variable is not initialized. Add the failure check,
> so SPL can print and stop with error.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: f_sdp: handle the spl load function failure
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/eec819b98439c50f8ea38ac078ff6a862ea03038

--
Mattijs
