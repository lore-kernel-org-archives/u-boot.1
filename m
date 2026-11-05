Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE70606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rdDi7SLw;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jYc7WimG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4032860888;
	Thu,  5 Nov 2026 19:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnxyoeQ7Azjw; Thu,  5 Nov 2026 19:03:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91DDA60884
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793905407;
	b=U1SBugpjnIxVfTYn1rZRdqkOmNjzOuNvH0/UQgXo920rzIDCodsFBGiKYJ7pv7V1GtMN
	 qDnpH3GLVVoCAJ+dwccuXayZvhuMnBs1AKqj+B04Q0QNDf5MEIXRTDw8hLsbMkGAlyWhR
	 lRNbqKt8nchqUr6cs5xWynbLtkURZrg1ThNFBRwDFxZ6lWGdZmekxSElMPn4yvEZurZxZ
	 EocJ0FEB86mqlnRu5t3MzjP18siMg7Cf5MzJy80nQJlQqgmLo2IrMHKaKgm2/ye/LfHUw
	 3TFeY29zW1/yajDsUglD7LOmJsi6JOuboZtGFCb9b0jOPaoonadH8m3wXM2kez1ySqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793905407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lbL4RmZo9yaoSLA4yBbC7AccDvF0lBUYwbYiBaEQf9U=;
	b=pUq1yl/N7+M7WxbhHtDXZHAWf52tV3UBfpmFDiiPmGt0cX4ndih76cUg9jSWCJhXPIW1
	 G1nuDX3hBIwwqceRtXMb2SyKsy5dctQTcnfVPN+M2WR888n6RrzEHGU3iuwTJojA6hhn7
	 dFxn8JgfdgGKzYcyl3SwgzxSKXdBBE6Eg+RwgBpzWzZm6yLR7d0IOZT7FehQyJ4Xo0qJw
	 06XaGyx2aQf25G1Kum+zJJw0CaQfgusH+1TvCkQtxvx1suC0qxMBJHtJabAZeNGSkwW6N
	 yvPMVQKfhXZWuFGdjLjimUBYQf9j7T5Cgz8z0JZBJvTusL3d7sdlRk3KAR1G6wgIVcA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793905407;
	bh=lbL4RmZo9yaoSLA4yBbC7AccDvF0lBUYwbYiBaEQf9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rdDi7SLwQmCFSFRIgW/JhFOr7rSvjkC0fLemCsuze0xV9O8qAQYASkvgsv2Qc7BeR
	 TeJdTX2ydvU+KcvAP1BEcMi4uzs4gDHdknKNdZjB6dLrOIMW1mjYQQHxtL2Kg15v5l
	 c8QIeM5juCMiQmuA9dWOPRXVwxUCpqJ4rqmFuCbn01oxs05UsZHGaVPmpzCV1ATRnJ
	 6NvAu6srkXzPIh6QHDEQGJKPXnMaplxmUueDc5rOo0gylZYGxjAdHRxXwFVNk4E6H+
	 jIf213pja6p1UyJbZCOBXUl/KATQV2r1jZqRh5Ojrfom+SzpqX5mtL3hzJqIVtvIVv
	 /BTtgHxi3GH7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91DDA60884;
	Thu,  5 Nov 2026 19:03:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7E16235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D81581067
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2jaVi40DO1O for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6F5F81062
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jYc7WimG
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6F5F81062
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:23 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-823b938464fso1541958a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793905402; x=1794510202;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbL4RmZo9yaoSLA4yBbC7AccDvF0lBUYwbYiBaEQf9U=;
 b=jYc7WimGc4kLKdUR0mKKS064ssUklAlD5uyaiGcsY8h8WC6SHL/qp3PMsx90mlV9m+
 H0kXOegwX/y+N+T8Jd49/WI+0cXftoQVZleIJ4W8bVui/jiNgRlgrag3FoWOkJVRI9Kx
 mzFDD2aTmfTAXjkj5idWogmJIvlRjLPEgCcvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905402; x=1794510202;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lbL4RmZo9yaoSLA4yBbC7AccDvF0lBUYwbYiBaEQf9U=;
 b=lKRkujQp+EsgPFiJ3sSdt2yxqHbVTvVN9NQqJwypKS/jgb1ITyTO0ouQfuVskUj63b
 xv86sZDXWHCfwyx7cRBUXhjJXxL5jVMIVSmshtks6ND+zdZW+CLBCj+Hnf3lDlORMMsP
 CdCdUPeC3UjDRXEbDmpmlQgYcyM4mbzNsP+Mb32UByGpnijBoMhXQl7WuPXg3FDmGT3L
 niWRzzlTGqo1k0VwLPTVQw0Bio8K9y6HsoE5l7VNFEd0U3V9CsXLvy//0w/MJ/7Af3d5
 k6D61lji3KDI0K69FcSHFvFwEfIry5baLUmafOetsSBEeDpjp5CAhgZwP7CLY0Mov6N6
 R7lg==
X-Gm-Message-State: APuU4Z/y0Uq+aCaYEsxubP4J3DBMmYdNBOznK0yhaek1pDw66GxCGnWX
 bUipCeGMUvNIvZuSlpj0eUoFc9Q4mgZ3U0kv8vqY4V8kvk5567vnqyt5LUGv3SpK6Z0koSXayCL
 noLvMIQwHXaml
X-Gm-Gg: AYBFou2RpnWKDvaK/ZUuZArEnTFieiFbe0oAfxWXrICLjoTFbbhwK1hAUtpCWyYisRa
 kmmedw7ONnTS1HeXGMkLUYiUzp/j502P7nWlHohD7rXWD0OXyKyHjgDntvjorqZXjoZHk1wjM0Y
 1XuSGUyaHKGRltk0Q18kP4pQq2Dho7OYGpKuRom2QZHyIaismGEAEF4RO5GT7WRsnqqt/7A/e8i
 OyxEuIuOhWQUO0Rq3XBE2AYtu65zIBouMOaw3sO23Sui70QnWSpTes88aaPR9UIJT7FC9zLNThd
 DhPAG4FlsADkCSb2+OQQoX+jkgEt7ptBQNdagnamqOHY7W5oZVn6Z0PvZsmHN/xHStg7KAtAP5e
 N/NziZf99pQDzhN1iW7gpcoXheTWKAgtYs7pxeQd34sVFhUijraOghgXdzsNiPuWLbyazbRcH+o
 n469+96GZjRcJeuFjOJMA9K65YkRw2SU+zCjbng22Mcjh8KTXKpOKKAmtaQGsSHd7ECwQzTjYhi
 8cRy3GVy2W9uL5JnTb3plYkFPI95V9E1nuNwl8uZdw7+szAmdNlb/YP/zOSqkgh9wFmhtMTNyQI
 yyM/SD/VUzA08Bqy7/QqhS8QKqN4Ofks2OpjJfaggN+fEX2JGya6VD76SwUojQx7MHPpMTNDRRb
 NMn+FBqrPMFekaYER0vYxCAQSp1TqRYvk/TXbs5llz2/NScBZyCb7YoHnvZz7ZwuG0UziprXgCe
 fhtNg7TzUCr9mFNMMV+pLl6fGDbJMZUQ==
X-Received: by 2002:a05:6830:3484:b0:81f:da91:c984 with SMTP id
 46e09a7af769-85f1cf8a1bcmr295572a34.11.1793905402330; 
 Thu, 05 Nov 2026 11:03:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd2bbb3sm93385a34.18.2026.11.05.11.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:03:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tycho Kirchner <tkirchner@emlix.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261027160649.371618-1-tkirchner@emlix.com>
References: <20261027160649.371618-1-tkirchner@emlix.com>
Subject: Re: [PATCH 1/1] armv8: sha256_ce: load and store state with
 ld1/st1
Message-Id: <179390540171.1843724.10780146433154369604.b4-ty@konsulko.com>
Date: Thu, 05 Nov 2026 13:03:21 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 17:06:49 +0100, Tycho Kirchner wrote:

> sha256_armv8_ce_process() loads and stores the hash state with
> 
> 	ldp	dga, dgb, [x0]
> 	stp	dga, dgb, [x0]
> 
> This requires the address to be 16-byte aligned when alignment is
> enforced, e.g. when running with the MMU disabled as in SPL, where all
> data accesses are treated as Device memory.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] armv8: sha256_ce: load and store state with ld1/st1
      commit: cc11cd04428845f5f5732093df84678b5702bfcf
-- 
Tom


