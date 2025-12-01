Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC961D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9DC83D7A;
	Mon,  1 Dec 2025 19:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aSdYzrMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B94983D03; Mon,  1 Dec 2025 19:40:12 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFBF83C64
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=xiang@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 347C84421A;
 Mon,  1 Dec 2025 18:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1241C116C6;
 Mon,  1 Dec 2025 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764614408;
 bh=awuzrblDLjQ8G2RXx3tBRkosGcvI5oQ+V4R6UCJNq6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aSdYzrMDAXrEfFfSi3eTUzT9MIed7KCADWO8eiS/EydW79YGW4B3vn6tYVPqm2RYD
 2N/0EZrvUZ7fNjNa+fnN60ah2veajyhvw3JAS4HR7CUlg2HxejnMUG/Z/WUvsMugdB
 SAtjM2x4PaZEpkNk14BR+SHbJ9KqULacYv5CcQX13f5uK45sFBzgk20hFnSEgEpwoz
 X5W74sXhICQ9n1nvHf5hAgd5LLnFFQsbOo0WjjyOB5Mid95V2yWq/I7Yc1QVaNBOKv
 JrT1GfiZDW2yUwpJ09r+i9iJ4WRxaWVzWlirqAm1HwJcWxEBxJZUElaXjdmERjI/xm
 DT05DoDw+tzGA==
Date: Tue, 2 Dec 2025 02:40:03 +0800
From: Gao Xiang <xiang@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de,
 Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: Fix realloc error handling
Message-ID: <aS3hA3i+6k+xOHdb@debian>
References: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <20251118213359.GA630712@bill-the-cat>
 <BESP194MB28057D1468C08C867A8D8D76DADDA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <20251201165502.GJ303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201165502.GJ303283@bill-the-cat>
X-Mailman-Approved-At: Mon, 01 Dec 2025 19:43:29 +0100
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

On Mon, Dec 01, 2025 at 10:55:02AM -0600, Tom Rini wrote:
> On Sat, Nov 29, 2025 at 12:12:23PM +0100, Francois Berder wrote:
> > Hello Tom,
> > 
> > On 11/18/25 22:33, Tom Rini wrote:
> > > On Tue, Nov 11, 2025 at 01:49:30PM +0100, Francois Berder wrote:
> > > 
> > >> If realloc failed, raw was not freed and thus memory
> > >> was leaked.
> > >>
> > >> Signed-off-by: Francois Berder <fberder@outlook.fr>
> > >> ---
> > >>  fs/erofs/data.c | 7 +++++--
> > >>  1 file changed, 5 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > >> index 95b609d8ea8..b58ec6fcc66 100644
> > >> --- a/fs/erofs/data.c
> > >> +++ b/fs/erofs/data.c
> > >> @@ -319,12 +319,15 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> > >>  		}
> > >>  
> > >>  		if (map.m_plen > bufsize) {
> > >> +			char *tmp;
> > >> +
> > >>  			bufsize = map.m_plen;
> > >> -			raw = realloc(raw, bufsize);
> > >> -			if (!raw) {
> > >> +			tmp = realloc(raw, bufsize);
> > >> +			if (!tmp) {
> > >>  				ret = -ENOMEM;
> > >>  				break;
> > >>  			}
> > >> +			raw = tmp;
> > >>  		}
> > >>  
> > >>  		ret = z_erofs_read_one_data(inode, &map, raw,
> > > 
> > > I'm not sure how this changes anything? The function is currently
> > > (snipped for clarity):
> > > static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> > > 			     erofs_off_t size, erofs_off_t offset)
> > > {
> > > [snip]
> > > 	char *raw = NULL;
> > > [snip]
> > > 		if (map.m_plen > bufsize) {
> > > 			bufsize = map.m_plen;
> > > 			raw = realloc(raw, bufsize);
> > > 			if (!raw) {
> > > 				ret = -ENOMEM;
> > > 				break;
> > > 			}
> > > 		}
> > > 
> > > 		ret = z_erofs_read_one_data(inode, &map, raw,
> > > 					    buffer + end - offset, skip, length,
> > > 					    trimmed);
> > > 		if (ret < 0)
> > > 			break;
> > > 	}
> > > 	if (raw)
> > > 		free(raw);
> > > 	return ret < 0 ? ret : 0;
> > > }
> > > 
> > > And per include/malloc.h, calling realloc with a null pointer is the
> > > same as calling malloc. So we had nothing previously allocated to free
> > > later when this failed. How did you find this particular issue? Thanks.
> > > 
> > 
> > I found this issue (and most bug fixes I submitted recently) by running
> > cppcheck and scan-build against u-boot source code and triaging warnings reported by these tools.
> > 
> > I think my fix should still be applied. Looking at z_erofs_map_blocks_iter and z_erofs_do_map_blocks, I cannot guarantee that map.m_plen does not increase during the loop execution. Hence, realloc could be called several times and we need to properly handle realloc failure.
> 
> Thanks for explaining more. Yes, the loop part was what I missed on my
> earlier look over the code.
> 

Just saw this, actually this issue has been fixed in erofs-utils
commit a3a75f7af7b2 ("erofs-utils: misc: Fix potential memory leak
in realloc failure path")

I think it's fine to merge this fix now, and the mid-term plan is to
sync the erofs-utils codebase again for recent features and bugfixes.

Thanks,
Gao Xiang

> -- 
> Tom


