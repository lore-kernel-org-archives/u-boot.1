Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A129C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 15:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDAE888410;
	Tue, 16 Apr 2024 17:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kxl6KgN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A53D88410; Tue, 16 Apr 2024 17:14:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64B787D40
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=xiang@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 83FB56119D;
 Tue, 16 Apr 2024 15:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECEBC113CE;
 Tue, 16 Apr 2024 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713280489;
 bh=hay8TyvAejLuqRNPwkp2IBUbd+/60xM1k4IlF1iPK0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kxl6KgN427zN/n9KgKWvMQgFdLxxWNFB1i6mEwDTz5lrJWeTwcE/H7V6U+DmvERFI
 8Rqfni8AsmsWODAII2xtctntQrj+my6vqWFOAbxeZf+qrJJ8n+nFMU5hWhrE7OnMge
 FbEyEX9yBJaNvp4O92RnFgXCB/gqR35fmO7DRBT+l54+aWngPgX7X/XtVuupQyRF2T
 MzRYmIr1MTO01HRdqGnAJs85n8sB8U25Oz+dS0pBW/WWhoykJD/8G7JrKFTbIs5CFx
 fB3hP/HP5WGgGmwPMIAyG0kfiBBJtMB1+vrJWB3C1GrlWwhE96B2tnBn85C3pwuROD
 ZDrcyYCu6Nj6g==
Date: Tue, 16 Apr 2024 23:14:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jianan Huang <jnhuang95@gmail.com>
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] fs/erofs: add DEFLATE algorithm support
Message-ID: <Zh6V51/K3NME8Fxc@debian>
Mail-Followup-To: Jianan Huang <jnhuang95@gmail.com>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
References: <20240414150414.231027-1-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240414150414.231027-1-jnhuang95@gmail.com>
X-Mailman-Approved-At: Tue, 16 Apr 2024 17:16:38 +0200
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

Hi Jianan,

On Sun, Apr 14, 2024 at 11:04:14PM +0800, Jianan Huang wrote:
> This patch adds DEFLATE compression algorithm support. It's a good choice
> to trade off between compression ratios and performance compared to LZ4.
> Alternatively, DEFLATE could be used for some specific files since EROFS
> supports multiple compression algorithms in one image.
> 
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
