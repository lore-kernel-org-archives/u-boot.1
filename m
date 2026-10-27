Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBF606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i4zW/i4N;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YJFm8szJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EBB280F67;
	Tue, 27 Oct 2026 16:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qr5rbFNsC47G; Tue, 27 Oct 2026 16:02:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5088080F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116942;
	b=SdctCLL4eJUIbQy74RGQVRoPX1Cr0YECxZ7f2ipTXbJAwn2ZsXD1i9YbjAkH0pEY6YYA
	 TM21Yxp8ep4hqZM6CYELSNlQQzlsZ/e/Tv8crhb9ELzxIbI9naDtZ1MRRIgwUknhkz24P
	 c8W/Tn2hkooEWN1ZpUM38nU+wmZY368ddnujwDNIii9X1KcIHuLVM7tHI/8uhjNZNhsc+
	 qmXKu2iUjJyz83rxhFroZJtsXTg+4IQvs94wXvGKVW8e0nxDELWBIbDz6wGBK1m606LM8
	 +aoS2Xa1Y7TuO0f/CeWHthTIAbUeus8J6ais4X14KwobUobregyaexzeTr5X5LluU/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U7wQSrAzH5CNgXMIqyE3/jFejcVL6bjOncpgR0FP3g4=;
	b=aRWESyda+gYPNK7SzzgND1kYwNqMRLnJpfl8MrM1q89s9SpcEBk5UTmBNog/r6IswdYx
	 enJgkS0j/rWc+FTy1oNpKNl9fCCd5AI7eMUBjmvE7BDx7VaeYPoqDzVxiyPzD4ABUTfC/
	 mK6NHZrtwR7SjFfkhojHJ5PYCmuThyUrbsDyc6KFVE2pXsXwAGYm0/IJjndViFBVKbNNR
	 0hnDYJXDApx1MKBeDqfl4RhWirwMnpn37f+PhCo0wkn36No2bXecB54GAjnrlEpTTh6qn
	 ywumBZgqqyZvZX+kMraxIHTRaZOibGsD4e4Lh0rqwAL0wNQXEl77NCOcv/J1bOmg40w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YJFm8szJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116942;
	bh=U7wQSrAzH5CNgXMIqyE3/jFejcVL6bjOncpgR0FP3g4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i4zW/i4NIJqQ4xMNLtgQFtPEScY5n1886/hg6M54k78LLw/vpC8nbVjBQxdHEMn6L
	 1hiqB47DIhRlvl+a0hKe2UticsyRW/OZg0us0V5pABb7MsaIeWi+fgiP5+4CiCHtjG
	 PuOBNfE7jZdQ23v1J2Py1vFdW/SDT4IQlmvuOgIvA87DC8SsyJEdR2x1+j3rVPer3k
	 KGjJPCQLEj4nA9IGy2+yJjh7d6DrEXx+dm9kEmcdWYg7nF2A9ykcf953FG8w9BKwNz
	 TFWQqlxikzh3kfpbDZQqwi7SmBTkwTRqmzHURUk4qMfpQNCsGnUEXP9/znRA4U4BhQ
	 90FT+rvbc+cwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5088080F24;
	Tue, 27 Oct 2026 16:02:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EE81B91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40CE080F24
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZvmp7H675QJ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BBDB80EB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793116940;
 b=WMA3FqRntO4Wdhbrwrl6qlVDm8h+cRbCTXOgaqEGma2ooDKjcUp5cargKx0HN0j0iEax
 FWtzPEnzWZffzVEfCZZZXS2adQZbh8dm6yhNNRL5JhPIHZO9XeC+mtOwEMbeS8Rrn0oqX
 skgcVIgcEdIgjLOIlmsdPrv5BU+qEPQzEnFoMMwXZ+JCKnaZxTgTKqQTHNa4U4UWIV/mS
 bMH9Qv4axTSz46GntebUdkPZRO1gbcIJje0/VyJ2rFHo+0u6pRVPPZ1ybRpRFv1jY7pKV
 za72iTgkbZ2t+/5iEDdH8/p1ZFOpI7gpYPTHKxmAu0dezAXvvacOdif96+B0/6ToTHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793116940;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=U7wQSrAzH5CNgXMIqyE3/jFejcVL6bjOncpgR0FP3g4=;
 b=TNRi/GdZ+nKErQYF49o68Po1Un38PlCHSHccP4RgnVDyCaGx/lyT7CUBkmTYRZB2upru
 3/OX5xP+W3qhjS1sFx3z7B9KaP8OPSxObn7/kZwaTuTIkWcdLjD3y0b0W8JWajf5doCz2
 ltGV3aQ4q43tIOwRBb1rywIK9uZrPGhLnrves10PI/MB+kujhsDlwJi0p6hVfGkTWgnTG
 F/IDhwIjTR4X8SS1JVYz+WjC0bUcpQx+I7dvqtaVe8t8iLnI83FbOIyPnOg5DudIXtYd2
 v17xzj6ZxPM49KV+04lEBL6RDv6u4I9SRGW3FRdoWIjvnrfAp0sbhdvRMoHWdr+KW+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YJFm8szJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::a;
 helo=mail-oi2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YJFm8szJ
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BBDB80EB3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:19 +0000 (UTC)
Received: by mail-oi2-x0a.google.com with SMTP id
 5614622812f47-4c3bb46aaf0so11557b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793116939; x=1793721739;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U7wQSrAzH5CNgXMIqyE3/jFejcVL6bjOncpgR0FP3g4=;
 b=YJFm8szJ7orxDiF6eD4JbJtCYpPG2vHsmeTi5jWXWVIY6MnL+LOk3d64dCKIwS2Ifo
 aI5zk4cjtNlt14fjvMPwEkb/jCkF1BHvgM7Vsj5Om8iM7kDCG8Utqv9xzQbF0ggVvNcX
 oLMozFtkGFvH6Cmi9hdXgk0DBTqUY5o/7nJvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116939; x=1793721739;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U7wQSrAzH5CNgXMIqyE3/jFejcVL6bjOncpgR0FP3g4=;
 b=UVja5/+PhnF1Qg8ZqxV1e8p9gOXgKF70hVPMrTZMC9e0BOSG/nIwiywoVFEoZJY1p0
 XD9aisiCFwvB2pxFdo5YpEZH+wh4yIrpe7hbfffr0u22PI9aP41tuuxgHoEjkhCkxaTe
 YS07WKAE0/s3xraOyNPA5fbk95HW/ziUoW5njffonPZwD0Xs2zFkYpIRap3p4/GPoOtn
 LcRWdnuczcwMjGiLF2Qyc2Agl1xyftJyehr3k3zdE8Atmc0dATmVvn4iVwRsCFRjgB+o
 NRcZrWbTK2wTQOnM5ULKeuC9rUyKn2uwrPiRixNVW3L+pzJ5jv7Zs9dcUTEsBXCZBLyo
 W8bg==
X-Gm-Message-State: AFq9FYLlm+xnkssYHH6S5iyhUPwExSLOPmu6cEgUH+D757uhzx95DgKx
 vebaCIpyeNOzRU6QZd9cmrnXLvieYz/6c6r/PZQB3ANsVDeebzHEet1QndL2bqFd0/X6Pc6ATiJ
 uPcIUuGU26uzxxvI=
X-Gm-Gg: AYBFou2avhc5QjLeoHgQq3gvY4HrqLEv0p6VcXSUSqgRGJS81TWKLXXXIzvkFsZwK9V
 mrm+DmS6q++I9A+BF4u77l6UddhErhnNDC01kijv793aQmN/WQR/IHTizACaK2tkNhgCRCZcwui
 hI9ofvvttpvjHvXR7NLebyT+QgXU8UvoA80Ma/IfiRaYsNFGJBmQrCL5SsNU7Nz5wK2a0oLcL1M
 7soF5SpTsyMm8PMnXQwyIHoMJcFAadPp9wdGeqxQnUA3u9adt8E2lOpzq+3nKAyATCS894DhEi3
 Gd1nXvnkAByfSEU68tWEMMlBiY6Pq7X579A1dAGXpS4rMfL5REG6eLTMjy6Sroe46rq3bhmzTb6
 uB6LvA/K6keQskilgCA5NRfZYIFJrK2esqIW6FzbcKiYscE2Z7brxUk5PELdfAW3S2ymhyrxYi3
 1xQeecrtmEDHnNBrzp/6WYrHNSlVH4H5TdXrXwfFOSdJYJT+JXkllWGvbfaFtFe4sL/T+aI502G
 pWLEalsHXaJelYbqtSk8Q8tc9C8Aj2GrBbXImU55zkBKDF+CdM02gWu5NwkWCJQ9MtCY7kasVwU
 l3XQ59W+Ow7+HIfsART7IUA4nwODtyMB3a2nQQm3bCsxwaEhnsCyVpOhwV4GM85DdDdoz0UhuPk
 IYaaM2ae59jH9HMnyaKVWgyBlCBBzlxz5syByzbWY97u06/qsRY0ClWad
X-Received: by 2002:a05:6808:4f2c:b0:55b:f88d:6eb2 with SMTP id
 5614622812f47-55bfff63a6emr6668362b6e.6.1793116938414; 
 Tue, 27 Oct 2026 09:02:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0424973bsm8537548b6e.6.2026.10.27.09.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:02:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261026213254.453482-1-marek.vasut+renesas@mailbox.org>
References: <20261026213254.453482-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <179311693707.2385664.12536799447513842953.b4-ty@konsulko.com>
Date: Tue, 27 Oct 2026 10:02:17 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 22:32:26 +0100, Marek Vasut wrote:

> The following changes since commit 8649a54d301a4d0ac526324c7a7ad2574939ff27:
> 
>   mtd: spinand: winbond: Clarify factory BBM offset in OOB layout (2026-10-24 08:24:15 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


