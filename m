Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC104C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 23:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10E388511;
	Sat, 20 Jul 2024 01:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721432188;
	bh=npaDeiFYpcGQvX42n9/CzgePhFV5cUN/N+GyhNXxyIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lW7MJSIAQiLGJ/BhCx1gXu9r1AkrMzC8fbTwHuGu4n9EC7a+ru6qcEn7EepnnpE4z
	 uZegqtYJrm/egs5VTv+8VQMAAhkdvVCqGKy5erjWqKjRzAgQtxbReyh4of5mKdpSxQ
	 LyZjEf+wRZWDa9pLlsLVWVXIpZ7cYhBgohB+0uPla1AcZxlWYOB7umwKxL1P4IgW6Z
	 mcMMs7luKtPRr/ZRipcCB2kau2bu9IzPxI4nkEgTghjOIR8brCl/9wjdnEB5ShdcxN
	 AUKAiJuajEcSPau2SNzZQl7JiRbOF9KvRO4aMRz/UPDkWy5NX0ntRK+FVLSqrG4+XP
	 qrR5rS8lEzLxA==
Received: from crub (p508b6272.dip0.t-ipconnect.de [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 98C1387ED1;
 Sat, 20 Jul 2024 01:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721432186;
 bh=npaDeiFYpcGQvX42n9/CzgePhFV5cUN/N+GyhNXxyIs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=b6Jtr9Qk1HRqHC3vmn8VPNgCqWlQrjh/J9/SjiZpY1wnfVkVOSpzcEUMCZ0Vp8/2M
 IP9EP4z04ivNw/UMSBuZw5ck24JOzg9/iT2o1rbMnVGH45/FzoKOFmmPo4E9Idh4zk
 6CVu/kicrDbaRpAmsPw9DijXH1CSrIa4Sl/W85v7abREJsNOdnvm0mfAnEHaT8dSgO
 dolSt4rZlVA5mDwWQKtIgDAkiREkGp2Nsn9JMOHO8BEuxpf3sStIb1c1W5cAaFI3fq
 oaaQBneN0NFUT1ZKOZbPpKSeXy+nKIuLRletn6J89ytiGYq01kIZxBWKflabp0bpto
 MAoK1HTM3/97g==
Date: Sat, 20 Jul 2024 01:36:11 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, Holger Brunck
 <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH 11/20] keymile: Remove use of legacy I2C
Message-ID: <20240720013611.5d7408ab@crub>
In-Reply-To: <20240718173611.4014274-12-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
 <20240718173611.4014274-12-sjg@chromium.org>
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

Hi Simon,

On Thu, 18 Jul 2024 18:36:02 +0100
Simon Glass sjg@chromium.org wrote:

> Drop this old code to permit removal of legacy I2C code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  board/keymile/Kconfig         |  3 --
>  board/keymile/common/common.c | 69 -----------------------------------
>  2 files changed, 72 deletions(-)

Please do not remove this i2c deblocking code. I've updated the
DM_I2C conversion patch, it preserves this deblocking code, but
legacy I2C code is removed:

 https://patchwork.ozlabs.org/project/uboot/patch/20240719232422.3403700-1-agust@denx.de/

Thanks,

--
Anatolij
