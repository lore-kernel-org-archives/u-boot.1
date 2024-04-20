Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED8C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B60B88263;
	Sun, 21 Apr 2024 01:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713655012;
	bh=frQNQJrpWtqC7KmSr1GPgG76g23vghaB9Y3IAAC0qj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l7LimLCNmvT4zjLLpiNWrBOLEwQ/wlQfUicMfAw7ZxDOvWgP5I1uSN+h6pVBuAMNr
	 1doyT645gxa7Ef4F9WdZUWL3cUGy3ui0R/sTXzPYeVdEQUmEDyUWxehGLGVGl3f8+U
	 bpuGJ+ruA7GKgtmhdvtWoejIa+TN6o6zRDaSneblbpS0gz8QDClQ5t3tR6uiTwszzS
	 gl/GJdgpjQKu2N5RtsqvcGbiCNeDyjnls/YfWdtN2muohOxhOS0SU3wzsY5LioGTZU
	 43yA9C8wIuE9mtlgz/f+fxh8/AIZrek05aVG1E/G8gI4M5vlsRanP3O38bsp8qy/UB
	 3TeEsVbfA5pYQ==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6755A881FB;
 Sun, 21 Apr 2024 01:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713655011;
 bh=frQNQJrpWtqC7KmSr1GPgG76g23vghaB9Y3IAAC0qj0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=i+uSr6wHaB6MCTotd95aCq+OXx2hSQH7MOmhSr6R/sOT+DpRejVDRFG4xvLJame7n
 gn9IuGbTf4JCNbJvZg0kiMr409eeAZlSrYXdgAPhBW+EV7I0mWU5Kfm7u+yHzLKnLC
 V5KFyL1XKPtoGFC9v9Te7pueS3/KlwZfcVpy8n0V3Kl5hwxgqeKpoB9ChPMjT3iyh5
 iP56PJsvU0bhg24YZr9bVxYKMrJvX0p9GELEkHZXMKFQTb74pR3M6qMWtr5dvQgJNp
 lioQB48sXBzLlds97oTU4qM5GYrtF3umreIyY83MsB4b2YY+tl4XBueuLX1PZp+WOW
 TS7RM+ixBeE6w==
Date: Sun, 21 Apr 2024 01:16:30 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Khem Raj <raj.khem@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] video: dw_hdmi: Fix compiler warnings with gcc-14
Message-ID: <20240421011630.0516e371@crub>
In-Reply-To: <20240127225459.3064283-1-raj.khem@gmail.com>
References: <20240127225459.3064283-1-raj.khem@gmail.com>
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

On Sat, 27 Jan 2024 14:54:59 -0800
Khem Raj raj.khem@gmail.com wrote:

> GCC-14 find more warnings like
> "make pointer from integer without a cast"
> fix them by adding a type cast.
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  drivers/video/dw_hdmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

applied to u-boot-video.

--
Anatolij
