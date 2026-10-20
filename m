Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB8606A321
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=locd/89+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=T4ZXBZ5l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54588407E5;
	Tue, 20 Oct 2026 18:47:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vDA4e5xLtQN; Tue, 20 Oct 2026 18:47:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89DE040809
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792522033;
	b=gYFHUuoiXt5PZuU2obUi8Xs2NWA/f0lIuJI41FlwjpmV7yy8GPYqirM6O6ezL9g0tac/
	 tNvM3y3ngUKmVoHy1Z7ny6qOWGkx48Rtr18XZkGkDZgqjs8mGtU1pLwEjvJLu+ZTATazj
	 Q4fv9bvH6WW/wME7gusFNyieneNGI7hRq4uSC3AquKD9Vum3i424FYo+vGw9pk2pYQiY0
	 D6NGF7vpA90xxsgh59Mb7PEznR2/ob9fzGptTo4I5roK5XObHS4vqmAI9yLF8dz7UbiTD
	 ov4zpYgkC85JMVuqRoIevi5QaEgIylBpcte9nr0OntZCDw/mijMxvcxY2e5c4+450ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792522033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BxyKUBs7OgU2vDeBNDEUzR0CMAJz4iZWBBxjrL8Wp/s=;
	b=Pj/j37YL51WqkOHPudowpl20GEW/e1Gcd6X6RAPhMpuU1qOEi8uJekqWUEmtKJT/Bjkh
	 CLaUjMo8UUtry2dDuHlBn2uxPz1/Q/iyNUxgNfIPTcJ4uevoB1N746rza253y292TAbYS
	 eP1LPK723FfFlzbMQy0oSvSV2ScRc3sH572g+SUyZqpbO2rrEjKZXXCBfsNOSC+XTjlv4
	 iEKDpENPpz8KC919cuc7zwXpfsF9D5Qq7nujbMsLQtOvGn9YtYM3gWGFKzn/TF0Dw10uD
	 WKN3GWMve6TyjvTQb0d2XRUQLWhZMkk0OiWvPVQN9GLLnff2cf8WLhABVM0w3nX2gMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=T4ZXBZ5l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792522033;
	bh=BxyKUBs7OgU2vDeBNDEUzR0CMAJz4iZWBBxjrL8Wp/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=locd/89+kZ8fO/IZZHAi/qji8m5dKvP2p7nTjheuruL2qDkQscRcE4KS0xoZ3/XBa
	 SmADqu9n1FoScdriYa0Yp1nk42TCP0mTiBxx0iKFXh3zTuIkeGHGWR19q7PAkOqCAM
	 BamcJZO23A+fd0CgCFLinuxbYuXcri4UblHKLx6odPsSEv7qO35hrRsTdOYezU+mEA
	 lcviNk6edBguWBhiBr2EvJ4Nt3aD6R1CmJLJ7gSKe/QiIJc5W2KXUiqaPdne3y7iXb
	 8mBWpPCTCTTYWIi/RIDTxr1fGuYteSF+GZZHVQj3KeeE5J7Hbf6ZZXU3swmq5BEuZE
	 Y1iATpxDe1ecw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89DE040809;
	Tue, 20 Oct 2026 18:47:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A68C380
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 304AB407E5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X73hbojrb0XJ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 18:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BCC9407E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792522031;
 b=q4kTd8Hvi4YU0WA4Gw9flMnjgo9tLQ8EB9I1Y2t0jdpmVZo+UDg2n8jsF/YrapqB0ALY
 5IUDF5hj8rFnva4i/+QQm42bdfM16dDV/JhoTyyYVNOZxZ9GG8Z1cE7Lsz/L9+qPRPujd
 UGZXyayohWZ/pBhI6YQ8IE0Cnnn3YY1wrvwHfAqz5fZJ1Oye2yD8CL+y519EfIMfHKAUa
 IPEypz8LF0UsPRvPj/fm+BwkQoKgf4aTHPEVGgT1DF8VWul66s585DbQ/KfbRoeNwfGld
 /i9QLRfvbtayFJIDrRIWerqbM8aUbOzh2Fmc/G1naLJ5/WQWkfYQCeCEtdw44ChvC1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792522031;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=BxyKUBs7OgU2vDeBNDEUzR0CMAJz4iZWBBxjrL8Wp/s=;
 b=R+nl+67b+zZNUagNvqgYnDhtqrB4+XUuB9qKvT/kOPORAOxU2fMFBAtR0S3U998uiFB1
 YCMCqusfVFQyXDqQxyRWa/Botukl/d2QT1A2IRq8w4ZO4rA1VqX400NlgJSZKmsupm5b9
 jHKzZe2w2fhTHGKyVLZ7TOPK04ZlFpteg5o41gTWJ1uX6NXuPyzpqV7l+pLwgPo7qsW+0
 YksSGKvJY0W+tUjjhW37XD4tOPc2dOY2QshLlwBUTi+6lItzd3KCZxcGqHKgclOXE2a41
 cTL6CKzdChXW3fHQH0l2zDTmlyBPtGnnUhEqfZ0VKWnXWAt8EkHgdaFsHerQJJQLGbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=T4ZXBZ5l; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=T4ZXBZ5l
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BCC9407E8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:47:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j8LxQ0d6mzMlLb;
 Tue, 20 Oct 2026 20:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792522026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxyKUBs7OgU2vDeBNDEUzR0CMAJz4iZWBBxjrL8Wp/s=;
 b=T4ZXBZ5lagF/tJYPIxTnEEFmUBHIIWATgSV9BVbSN+xjUNu0iN0baJpC2WG9yQJtDv7aG9
 dCo6JmAlkhQxbI374itvO/Q3MJLyv/vewdADDJSgGIww7xawOkZjsCe7u5aIIoXwP5Il9y
 2NLlsqN/am2veJconsf6cXh/7mj/Q7svoDC8ulgfzK1Ew6ZMnwO8yqJaZAs9lhZvgTg4eF
 T4/KYT1mNkeuJrjT/QiOQCnJgawGpscp80U9iFejkEugQLmts0RJX6ljyNdiZB1ECXNXo2
 YxbzOK0L/SiQh9ZnIy9KqbvFaNg5pAHWzz93MRSuuYiElYFk57utqV62DhJQkw==
Message-ID: <df378c9c-7609-4fe3-aed9-1967ea137b6b@mailbox.org>
Date: Tue, 20 Oct 2026 20:47:03 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] configs: socfpga_de10_standard: Fix raw partition
 booting from SDMMC
To: Nimesh Acharya <nimeshacharya197@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Humberto Naves <hsnaves@gmail.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
References: <20261020174629.24277-1-nimeshacharya197@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020174629.24277-1-nimeshacharya197@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5e38e12e017be6c9fff
X-MBO-RS-META: 1jjgq9kk7cp8dupsjaxjjudmfanmxfzo
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 7:46 PM, Nimesh Acharya wrote:
> When using the default meta-intel-fpga configuration in Yocto
> 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> U-Boot from the raw a2 partition on the SDMMC device.

This ^ is not relevant for upstream.

Please retest with build outside of OE and with plain
$ make socfpga_de10_standard_defconfig ; make

Does that also lead to the same issue , and does this patch fix it ?

[...]
