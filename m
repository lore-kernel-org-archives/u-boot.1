Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19FACD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 14:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580BD87A00;
	Wed, 10 Apr 2024 16:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="o04PHXOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32AB88180; Wed, 10 Apr 2024 16:29:50 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6AB48758B
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 16:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD912148C375; Wed, 10 Apr 2024 16:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1712759384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=CKF7rO+R+1CXTL4mVjKdhkZjb+BgTmWBLGNjYtH/CFg=;
 b=o04PHXOfyJKPV5WixbmdflcP4AAWzICimE+B+Z4FoZfCFdKT1RJ94iGGfa2XvX7EYC21t4
 1VdSIJUAPjmuwn1N/WU/C/oiau1r/fZpBYaC0h96h+Hl0AOiK/FrX7FZBn3KjcpKcXp0aw
 06iUsNqMQ66XEDNrsOvBfMaHtpct/CRsRUtxKDQ71kgBbtatmmkRCII3HYL8G+cS2WSasO
 I3IO8xbKl9seWvpVl9C7D+9hjWtz2ise2OYyklLPhifrDC/+NXyS5YOPxL3UNIi296qQon
 SN9V1iIMaftMwdiljEZs2HDS5ba1xU8zDIP3eIyjGwTwO9e9IMqleXYigmWcBw==
Date: Wed, 10 Apr 2024 16:29:40 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fs: fat: convert change month correctly
Message-ID: <20240410-tropical-overdrawn-c432d0a1d624@thorsis.com>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Heinrich,

Am Tue, Apr 09, 2024 at 08:04:56PM +0200 schrieb Heinrich Schuchardt:
> The month is stored in 5 - 8. We need to shift it by 5 bits.
> 
> Cf. Microsoft FAT Specification, 2005-08-30
> 
> Fixes: 13c11c665320 ("fs: fat: add file attributes to struct fs_dirent")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/fat/fat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 14e53cf2d5a..2dd9d4e72dc 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -1254,7 +1254,7 @@ out:
>  static void __maybe_unused fat2rtc(u16 date, u16 time, struct rtc_time *tm)
>  {
>  	tm->tm_mday = date & 0x1f;
> -	tm->tm_mon = (date & 0x1e0) >> 4;
> +	tm->tm_mon = (date & 0x1e0) >> 5;
>  	tm->tm_year = (date >> 9) + 1980;
>  
>  	tm->tm_sec = (time & 0x1f) << 1;

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

