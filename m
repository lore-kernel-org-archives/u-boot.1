Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD027C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A168710C;
	Sun, 12 Nov 2023 21:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699821116;
	bh=2Wlsv7Qaua7yCCUNzheX5Xy/xRQYmeevFj2Z+y8DuUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTnb28tCoJU5K0NPKK+D7UCoHUV/CTnQ9eVigKDLQq6MjKQmLxwZVHz7PM8sGi7Nz
	 zxATnbzxFUOwbmAVjaM4Khp9Kdl9Jy1bu0CMjecIYyxPGXxC9kosGqW6beuQec9aFC
	 KHiQTcyP6av9sEHb3Q9Wxg4bBCWlV+ncTaqCBHzg8oA6AhD5qpy1KPK0wzDXssrn8G
	 ngdAKp/CvKyHj0G2EkVirBpY0Hxk41MZHtR/8XxscArBAKrpPFZatCsUqLAYz7txkg
	 Ipa1AEH97RyFS2NI6DQoxZ9bVdkBJplDbbiqNJV5h9hhuWbWhzXbfVGFskL0gOOF3I
	 91sUKFurbYhJw==
Received: from crub (p508b605d.dip0.t-ipconnect.de [80.139.96.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8DE0187103;
 Sun, 12 Nov 2023 21:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699821114;
 bh=2Wlsv7Qaua7yCCUNzheX5Xy/xRQYmeevFj2Z+y8DuUk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QU1dNb8d21Xiepp/pZrcx1LfAooComDMFdcjUX/ZMZz23NL6JQl7BsntCO/fXBvZW
 A4Cw1UpBlbm9PCggef26NkjU6InBW08gpwaRo3jTLhd+9mZhWZf+Upezy1exEQ02Ox
 HG5hYxoLjBlyJ4xmOk++gJxIDvrT9OcfTbYfxUGOEYbGDRegp5p/pFEeHqVarvOooi
 I7Ow6w07SyMs/HtpzfgrbKkaZlDHCNqJ0mYklJRX3qCS+52vqCVzl2nOKa30vA7/LQ
 WoVM/V6fAzcwOseS62O8D5WbcaRXDJQQktsI4i2iK5ANnpm4+diBdvbRuTM8fRiYE6
 0SS+zBXAUBxWg==
Date: Sun, 12 Nov 2023 21:31:53 +0100
From: Anatolij Gustschin <agust@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 07/12] video: Correct setting of cursor position
Message-ID: <20231112213153.6158af16@crub>
In-Reply-To: <20231112200255.172351-3-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-3-sjg@chromium.org>
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

On Sun, 12 Nov 2023 13:02:44 -0700
Simon Glass sjg@chromium.org wrote:

> The ANSI codes are not correctly handled at present, in that the
> requested X position is added to the current one.
> 
> Correct this and also call vidconsole_entry_start() to start a new text
> line.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/video/vidconsole-uclass.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
 
Reviewed-by: Anatolij Gustschin <agust@denx.de>
