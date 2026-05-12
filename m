Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B6CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4255E80F0E;
	Tue, 12 May 2026 14:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CBWSW/iQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B50E8341A; Tue, 12 May 2026 14:35:37 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AF480398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49A56115524; Tue, 12 May 2026 14:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778589333;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=jX6A4oUYBRnaqGI4baFcRc62A/JLb79wF8r5erXt1QE=;
 b=CBWSW/iQeMV9KfXHKhSQGdme1pn+ciLR5MPsJbM19+My39oi3rHYGmsS8J0XDtTraCnjdL
 8o1y6koHvn8fKFe3O9vWc+Dhi41HW7msL2frVwVO36RjbLzLBhc7y/DXIkOWATRMmWliVr
 6ipJPm9FNb/YIGOFjJwzRQurBgkb7FJCbhEoPsRMWqTyRyfTzJ1i00C1RSoCyZs4lCj6DG
 p1D9h+KpzTJ0ZnPFJ6Z665DTmqAO5T7zyNNxL/X1CCPp6gcztcY9KwJoMctcnedS2u69KV
 nlfGsPZSIutcv3IO7DsGdxZCdbHe8g6CWThuNmHZOpDl08wQgSnjEwviIihKTg==
Message-ID: <7c381084-d1e1-f5dd-60b4-ccbe610e1c77@nabladev.com>
Date: Tue, 12 May 2026 14:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: fix bugs involving symlinks in ubifs_findfile
Content-Language: en-US
To: Peter Collingbourne <peter@pcc.me.uk>, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, Simon Kagstrom <simon.kagstrom@netinsight.net>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Kyungmin Park <kmpark@infradead.org>
References: <20260505103816.202758-1-peter@pcc.me.uk>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260505103816.202758-1-peter@pcc.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Peter,

On 05.05.26 12:38, Peter Collingbourne wrote:
> When encountering a symlink pointing to an absolute path, ubifs_findfile
> would return the target of the symlink as the result instead of resolving
> any following components in the original path. Fix it by following the
> same code path that is used for relative paths except that we set the
> next inode to the root if we see a leading slash.
> 
> The existing code used memcpy and sprintf to copy the symlink target
> into a fixed size stack buffer and was therefore vulnerable to buffer
> overflows with a sufficiently long symlink target. Fix it by using a
> heap buffer for the temporary path during path resolution.
> 
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> Fixes: 9d7952e4c636 ("ubifs: Add support for looking up directory and relative symlinks")
> ---
>   fs/ubifs/ubifs.c | 70 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 45 insertions(+), 25 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
