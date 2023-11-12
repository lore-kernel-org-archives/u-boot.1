Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85EAC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590998745A;
	Sun, 12 Nov 2023 21:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699821271;
	bh=wsnK8QtWObMx2pVbF0elVLu1pkkCGMM/SmjGU+jDYG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TPY9bvakCT9BEVO3bewSFGnWQoTA9llK5wPWlNippvftkXdHotkU5Ycuu13seuqGw
	 PFzny6JXjuJlva2PRLJsVXnr22OjUsqJlm8+uASgz54Vd0nk4kR3vgpnU5ijwjdXS2
	 aNK7F/87w9k1WyBQkr2raNDyJo8hefQ8ZaCTpVAuQ9RPFtOLjBRYiNE75TnXi//V06
	 5uTHDWzdJiYOr35XlZMg5+COmjB6okHu9C9hiYqtoOU+M4wKer4CINw27m7pi4urdL
	 oPon5BEJTYKuXgqBRjsCozoaCPvWxJA5LxrepVgnLSxtdNPExazNyvZBY4jsKw7uhn
	 6Ui9QEIecaWQA==
Received: from crub (p508b605d.dip0.t-ipconnect.de [80.139.96.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 69FA587103;
 Sun, 12 Nov 2023 21:34:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699821253;
 bh=wsnK8QtWObMx2pVbF0elVLu1pkkCGMM/SmjGU+jDYG4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WNdpKWblgSBpLKuD2VMG2uDGAi8w/qaf1KJnXa/3Tp1C9L5+a2NbqE6YjWK34SILX
 Ws+LsleDHuCyEk4OXar5/Y0RfPuSkRsUVryuNf8NSQGFd8MGdHNZJJTpaWk30ZS3ET
 KCpIBZkNw3AvfQC0CkI9hWmf+igPhapHCeCxuur4I5a00UaZjSxDJFU4VrF46Ox624
 xyK7fTbHyC23GB7BOpoAhrYhvf8n0Rdw1pF9vx0fZETN2OAL1lTnzjuuUBJRNb9XSS
 NHq4JJ26YeyLqFEJK5nK3Fqn0e9CNsZvKQFiE/lXqB3Pk4u7X15WLg67eVlds2WmZs
 2JXiWZhnGsQpA==
Date: Sun, 12 Nov 2023 21:34:10 +0100
From: Anatolij Gustschin <agust@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v4 08/12] video: Drop unnecessary truetype operations
 from SPL
Message-ID: <20231112213410.62150bf5@crub>
In-Reply-To: <20231112200255.172351-4-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 12 Nov 2023 13:02:45 -0700
Simon Glass sjg@chromium.org wrote:

> Saving and restoring entries is used for expo and for the command line,
> which we don't use in SPL. Drop these methods.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add new patch to drop unnecessary truetype operations from SPL
> 
>  drivers/video/console_truetype.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Anatolij Gustschin <agust@denx.de>
