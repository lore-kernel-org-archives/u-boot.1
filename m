Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D3C021A6
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 18:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC8480805;
	Fri, 14 Feb 2025 19:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="a2WQ3xQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A1B80C7E; Fri, 14 Feb 2025 19:41:59 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A42F80756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E3F9325B06;
 Fri, 14 Feb 2025 19:41:56 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ejf03sRGsKAo; Fri, 14 Feb 2025 19:41:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1739558512; bh=ZUStR0PLB/G7P+n4Emxdd6wdDZKwb+2M+I1z0e65hlw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a2WQ3xQg+CPbQcVg4QQfaiJPsJE8mqILOLoaz5Edz0cTmf95slTsMkG1ravk34dZO
 fMjtYl+fyuUL8moLz0yOC5hYy9wDPQYZOAnTwXVlT7Qxr81svHdRCqt1nZgGCOUq/Q
 fVz87BL2zT8pwBSIE+AH+V5K4WM6Cr1hPzH9ekt5OydjV8MGP6USeE0eZiNE7lf5qM
 +s0JAmy7fMkGK2Mo/rB8KiBb1Ng2dQc72d5+sAJSw9k9zYnF47zz1R60M2iA+Fw1vS
 UmXhg8B6U0DTteoHG69+Fy/0P/sQyY45dGnsdwtet4O4ut9dIWoomRH6EesNe6iUoA
 pdweeq1JTwDZQ==
Date: Fri, 14 Feb 2025 18:41:34 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: Re: [RFC PATCH 10/10] test: lib: add uthread test
Message-ID: <Z6-OXlI53Mt0q1Gy@pie.lan>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-11-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214140031.484344-11-jerome.forissier@linaro.org>
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

On Fri, Feb 14, 2025 at 03:00:25PM +0100, Jerome Forissier wrote:
> Test uthread scheduling.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  lib/uthread.c      |  3 ++-
>  test/lib/Makefile  |  1 +
>  test/lib/uthread.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 1 deletion(-)
>  create mode 100644 test/lib/uthread.c
> 
> diff --git a/lib/uthread.c b/lib/uthread.c
> index bb132001fb6..1f8e6d0fa80 100644
> --- a/lib/uthread.c
> +++ b/lib/uthread.c
> @@ -76,10 +76,11 @@ err:
>  
>  void uthread_free_all(void)
>  {
> +	struct uthread *main = &main_thread;
>  	struct uthread *next;
>  	struct uthread *tmp;
>  
> -	list_for_each_entry_safe(next, tmp, &current->list, list) {
> +	list_for_each_entry_safe(next, tmp, &main->list, list) {
>  		list_del(&next->list);
>  		uthread_free(next);
>  	}

I think this should belong to the sixth patch.

> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index bf04685dae1..c991dff1c63 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> ...

Best regards,
Yao Zi
