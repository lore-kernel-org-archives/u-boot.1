Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27621606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iGJyZAld;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gpt6cTHE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E02A3405C6;
	Wed,  4 Nov 2026 07:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ai4gttNXx5Ea; Wed,  4 Nov 2026 07:48:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2AE67405C9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793778483;
	b=TtxdTmvXHWS7Dc5LDbve9yzZhCEVzbtfCz3u4JX5y0v//3wRvYlVR2M6jdaZJzwtbiyS
	 fv0X1VZ84t8tG0MgyZ0uG7Owjir/LLWRLkxM0rQgCanwQxBkhCg/LYyjTRV0jj0CgyQrl
	 9cRVeHrVGE6+0nHioLRZAHBwWtvSbHhV3SV04QCc3AcMA2qJyKOv+vEyVKs1f9FXRN4x1
	 Fu+O0qZjO/RDEW4B3/7re0dHNo/Xwq8mYWsxqtRhLJXEgqlQ1JienIAyUqnfKKaqmV/P1
	 lrIVTHNswIgVYegALYue2Ll0MJwCfMO5NeQYKBUwG+AV4kmUGl+QPIdOtNidFtlQHAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793778483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IiobQ5JtKQ3Iu0Ih8dKR8unlF3Gz2KZdIEXWX7XcwVc=;
	b=EI58nSSmMDN70Mj3Qn5f92P/b2jC0U5dpc0YNtpuEX8WjBhnUn+QmDyAVqozCWB6AWYx
	 A2JMgzVtyOwruewwGuTTUL9qgZaF4oWxPfY0FkbhiVSB4iHMW8ce8dPavknq9nFgyjU4U
	 Iq/PXClhBDPZ0HRLVeM5tnr7wE6Ms3gUanb7Eg9UEtHQoXc8kDtzWUw3qzX7WZjuXPGhB
	 IJTsgHxGz7Vs2dBSeds6DPbJckaHIrwxFFo9qQIySWwmXfoQmb33E/CPfbuwFNk981F0l
	 HcYweJp4tIk8QJvH5mAma8sNY94JBLABc9M8GRHuwzOu+/30Qrq+rCUfPQwrAbYfmUA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793778483;
	bh=IiobQ5JtKQ3Iu0Ih8dKR8unlF3Gz2KZdIEXWX7XcwVc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iGJyZAldFH1H4Wb2vUqfSxt7veNaSn0aEnR090NYHsLiRPNgAj2sP2vsWo8PgSVf7
	 u/SXrJWcCDNKWJBZ6WspqLNWBZavYhIkmximx4sYqzgXAOjmpmBoU6W+l11zmIQFFA
	 gkKl9nEZ1Mv/nqLTCieaSNtSW+UQWHW+U6ZKEmYZMsHE+K10GAzlEdLpuigVqPj/xe
	 mlpjDKguNmW0LW94Eu5T7+kjL26/5Hg/2IUtyEtRrt7naAFDOWaqkE+9NE9wqoso6T
	 Aj/d4TfJP/B6b6D79LMj2pdmndnkRIVK2JJvLXlUY/YTcenA8iYxUV8xQruJxbIm9E
	 96kFbWU+8Ggwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AE67405C9;
	Wed,  4 Nov 2026 07:48:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAEF4435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABDB380DA2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGP-0A_NrmUX for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20ED380D8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793778481;
 b=IngcQh0QavpnHJCS0cVXosNEqAJxndvM01kR3xcnxei2jbh9xoh0Fr5j+A4AHe2wbraz
 y6AbJhQlmvuLzmMey2TARBBmaqjQmwfMiBORqHmbbjBMfhXILOyEC2D99L74M5ls7ypAl
 7QQuJG30ZM+Vs/gyoYcNATr93WC8jVHSrjkiqr3KN9a6YZaYnfVBIEa96oLPXBVkry8HJ
 58oz1lbX3bMhMwDifnPJfd0bjYMgpxtY8UTyqnQLK6qZ1gj+gnuLuBvfo7PCSjgiEtT4J
 Pn9VVtuy2Tud7GJR1ZPZ6MypagPdj34HAfi2/5XW1Kl17f7c+KMHcLz+ZDJJ/2lyyzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793778481;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
 X-Virus-Scanned:X-Virus-Status;
 bh=IiobQ5JtKQ3Iu0Ih8dKR8unlF3Gz2KZdIEXWX7XcwVc=;
 b=aJFPDGaQ4QFFAot8b0I3tZJ31ZcP4gD5v3FTc6uvZxJ96zlPxVqEMsmkji5B+THkxf8I
 0JN1xgpJvbv32D8Y8/p/3OEtgzGKJhH+vdrY7mG/fGkJn7anxKZJnyy1Nh8M8lDARyiCH
 ByW3aTFdz4TPh6/aLR+XVHPUSP/pgrLapQwVCQ/ykBK6agvA17Hx2LyxAZUlVY2galONk
 oJSTHh4L0yyjMWRz/6dyb7sdvIzLAG6DpMoQ9w3ANm72tiiQhDALt2SybGp4NMBvx9lGE
 LDC2H2JLui66tivOJs/ZpkdHEH5zsjc1YzSGz2OsNkWMWrymxKwmraRX0nfZB21gBNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 spf=fail smtp.mailfrom=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=gpt6cTHE; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=gpt6cTHE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20ED380D8D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:47:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8BB84823; Wed,  4 Nov 2026 08:47:56 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B90783E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 08:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E4A110C917; Wed, 04 Nov 2026 08:47:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793778464;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=IiobQ5JtKQ3Iu0Ih8dKR8unlF3Gz2KZdIEXWX7XcwVc=;
 b=gpt6cTHEGZQ3znr8IWQ8Tw5Zy0ttYinEaMsY7Uis9a+u75gsTpD/OAOXugvQXyVQfw136f
 Yhv/rjtm7pnUdj9CLVWK/QmvlpVSs8pwUbWgQ07OHzDlUOLxmWk7c95gYAI1n1G6Upi0uv
 tj6z8ouGHOJdECU9w0H5EPn8CnHXv2TuaezeLwUMf6xQmBdOUrRYXEk3uguK3X+eURdl8U
 1uU3PeVkuRBGReuVJjrWvnUY2FH+dBHxoiYQDum2JlMWwmI6KODTXy+Qu+okcL951jjFfX
 rnN3wywXWd1cp939KrPnWSlfHPWyvx/3rGUjzkmeKM/gbymKgv91WXENnZBTNw==
Message-ID: <153958ec-abbf-25d7-29d7-9f6549db8a1c@nabladev.com>
Date: Wed, 4 Nov 2026 08:47:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/7] fs: jffs2: improve one-pass reader and add metadata
Content-Language: en-US
To: Wagner Popov dos Santos <wpopov@gmail.com>, u-boot@lists.denx.de
References: <cover.1793724561.git.wpopov@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

please resend this series on the new list:

U-Boot Mailing List <u-boot@lists.u-boot-project.org>

Thanks!

bye,
Heiko

On 03.11.26 17:49, Wagner Popov dos Santos wrote:
> This series improves the robustness of the JFFS2 one-pass reader and
> introduces CONFIG_JFFS2_CACHE_TO_SPEED_UP, an optional directory
> metadata cache designed to reduce repeated flash reads during sorting,
> directory listing, and pathname lookup when loading files.
> 
> With the cache enabled, directory entry names are interned in a
> configurable hash table during both full and summary-based filesystem
> scans. Cached names, inode numbers, and parent inode numbers allow
> lookup and sorting to use in-memory metadata. When fragment sorting
> is enabled, listing can also identify successive versions of the same
> directory entry through interned-name pointer equality before reading
> the selected raw node.
> 
> The optimization trades additional RAM for fewer directory entry reads.
> Names are allocated from 10 KiB pools, and
> CONFIG_JFFS2_CACHE_NAMES_HASH_WIDTH controls the hash table size,
> defaulting to 256 buckets. Cache memory is released with the filesystem
> cache, and raw-node comparisons remain available when names are not
> cached. Listing still reads selected directory entries and inode
> information, and loading still reads file data.
> 
> The preceding fixes address unchecked node reads, missing inode
> fragments, incomplete file loads incorrectly reported as successful,
> unsafe symlink target handling, leaked dirents on comparison errors,
> and incorrect handling of the selected raw dirent during listing.
> These fixes apply independently of the new cache option.
> 
> The final patch corrects the sorting documentation to describe the
> existing post-scan merge sort with O(n log n) comparisons. This series
> does not introduce a new sorting algorithm; its performance focus is
> reducing flash accesses through cached metadata.
> 
> Wagner Popov dos Santos (7):
>    fs: jffs2: check cached-node reads before dereferencing
>    fs: jffs2: reject missing fragments and fail incomplete loads
>    fs: jffs2: resolve symlink targets safely
>    fs: jffs2: release dirents on comparison read errors
>    fs: jffs2: retain the selected raw dirent when listing
>    fs: jffs2: cache directory metadata during one-pass scans
>    fs: jffs2: document post-scan merge sort
> 
>   fs/jffs2/Kconfig         |  29 ++++-
>   fs/jffs2/jffs2_1pass.c   | 261 +++++++++++++++++++++++++++++++++++++--
>   fs/jffs2/jffs2_private.h |  30 +++++
>   3 files changed, 308 insertions(+), 12 deletions(-)
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
