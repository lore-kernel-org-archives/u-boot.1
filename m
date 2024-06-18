Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36A3C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A8F884DD;
	Tue, 18 Jun 2024 09:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LoMPp6NN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325C4884E5; Tue, 18 Jun 2024 09:46:09 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18091884CA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 933BDCE1729;
 Tue, 18 Jun 2024 07:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD666C4AF1C;
 Tue, 18 Jun 2024 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718696763;
 bh=DV/ppMnM6w8D0EGHl0Ut2LmtyIDeugCMfIX0OdMygug=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LoMPp6NNZ9RuM4LmdjUwzEY0Z6psA6rX12DXI7L/Pk3RFmLoIa1MFG5VlH3XU41M2
 Nx0l1fZaCQgejq15bBrb33Bb5/cSgLuxO1HT3f9ewuwklX9bRhp0cFWTwxYmJWDwNt
 BCtOrimcfMf6tjVBjnExUwCIUPD/cpyS3BNbepMFfa8h8bW6pvFhFZ54G5RX6g0INn
 pinqg/DWIiJioIYw+vrCTqJOnQL2VW4SxZoBXCfWPraBk8FOT+ZS89IpPUFxKsQ5lN
 p4t7IAMexaNN12mFnZpHgztRB+6a5TVshXVbpYdD55qvPgoNTUi+CwOBpeTX7SAC6t
 MxFAEVtko+mMg==
Date: Tue, 18 Jun 2024 09:45:53 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, Qu
 Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
Message-ID: <20240618094553.68a79daf@dellmb>
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>
References: <20240617194947.1928008-1-alexthreed@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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

On Mon, 17 Jun 2024 22:49:47 +0300
Alex Shumsky <alexthreed@gmail.com> wrote:

> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
> 
>  fs/btrfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..b51f578b49 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>  	extent_type = btrfs_file_extent_type(leaf, fi);
>  	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>  		ret = btrfs_read_extent_inline(path, fi, buf);
> -		memcpy(dest, buf + page_off, min(page_len, ret));
> +		memcpy(dest, buf + page_off, min(min(page_len, ret), len));

Use min3() instead of min(min())
