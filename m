Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77072606A33A
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QJhlAPRc;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bk92dHI5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5599D81068;
	Thu, 26 Nov 2026 09:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbP53p-VjAkP; Thu, 26 Nov 2026 09:15:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6BB581046
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795684558;
	b=UT2NDuQl42JS8IWSpr6lP2jXH2ouWaZDg/SFHOvjmK9gkdh53I7Szt9HqkQQPbjB/Xq3
	 RnkD/ATTCzx3w1Tm/it6VyJCeysMe1OBrZMsVLwiuakMsM2QfauzeTOumEXj39yiDeNIi
	 zNZ3m+EAsqovblLw4vki9OAld+zPxofv1pPyJPvHW9VZwoEtnjwhlNv9FwJvYmCFgItJo
	 DABx5H9XzLV3e3D0yw9opl1t0s4PWCfrPCW3zR0ywCejcvmhwbMxOj7Xi5Yll+TPzs6Zw
	 Gxid/2+PR5n7GBtjVfn2zgTtcZkPbu+7D0Pi/5nDq6biQyro9n+qEsf5rVamPvPuchA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795684558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q71TTjDkXjBKcW5UABLA41XuDBliE+sW+QxRNbEOppk=;
	b=egpDemnFNYkFxK3GfK+Yz23HOiVCydkkoLASmKj3JO3tMf7FTQjuNYSNy0oLcwSvzB3e
	 RxodkqC5J27K8mUzfLI5qNz3mun/gNxne0Nx4uz8/L2zfzZ7S8aG9RDH0cWMwrLlAM8fn
	 dIWSI02hIXQWqsSlGHM2/qDpaAMGmO1XwlDpeuTaYnrQXX3fTjKgQga3sIhMAeourqExb
	 3zSf8J528/hnXmUH9M6g/luIkMR817qo9BwWA50gmlBDm0qruMMt6qgysYUeCht4d93QK
	 YzEWeL7FxoaiWtkQLKxXrOArYWLyU8uhXi+jSSocwqdAfah6/oCHyms8Y7SoEewxrng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795684558;
	bh=q71TTjDkXjBKcW5UABLA41XuDBliE+sW+QxRNbEOppk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QJhlAPRcC1uKMTqvDj7IsoFSZJqssPC81RQMcsLGtL9qW4xDRCqM/gd1LKP5qYk3k
	 KiD6OIUoGWEYSEGYy019fJ1sOmZ+rM4UGxsB160u0ITiFpomoyp3zrP1Fb4D1UE3/j
	 vopuX66zH/OKHYPEzGoHOhGmw3gNRgyujcn9uNX5G/GBwHMgC4Cm86GEad5C6aymes
	 VuGdndiY/+hwIjbz8dWBleGk3t84I0Of+0U+Oj/nSEWjpYzWZ94B4q4v1Dg5dSlF8g
	 LCcbVv1xf6k7DJV6AgTr/k0grXsEvwPMGmAoK8imm+0LNPy3XShBwfecK0haSz1TkT
	 ce/2GBOw/1xIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6BB581046;
	Thu, 26 Nov 2026 09:15:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8C581AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9CB7608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0BCPGZCV6c8v for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 09:15:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C670C6065F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Bk92dHI5
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C670C6065F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:15:56 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so38822625e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 01:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795684554; x=1796289354;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q71TTjDkXjBKcW5UABLA41XuDBliE+sW+QxRNbEOppk=;
 b=Bk92dHI5wxb+xqaLXMEDdM9utbByFrck8179EIIvlgftoymP3AhqB4aJ1+z3YYriWO
 lbbbWIxgq8U2QmYNGTf01sRh9wnoS1p1YfmJxa3oPUbbjRmTcjR89d8+vLzdqYsjByMj
 kUn03EeOndTTbQ2dqIw9TUenI2xQWGwxjH/b4TxpG728B0Q0k/8FDw2uqaCoJ0XqtsVw
 r8mVX5Jc8mRDfBPwS5jnvWj84cqh2pJ/Dv+2XmOzVMZ/ZOQWWaGWiXbVASEBXAK/niWT
 r0CC2Qgj3jxFyHFb5V+jzyr5ZtSeLd7rLH+v1b2Jmqv6wwOJrXuCIIHF0NFTBCZDu++7
 M6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795684554; x=1796289354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q71TTjDkXjBKcW5UABLA41XuDBliE+sW+QxRNbEOppk=;
 b=wBa9bmRARMnwfnxgSAaED12EXiDVs4G0r74zhcejPMbm975X9ouk1Y4jCxDpg690Rw
 gRIMcpbe5gA5ubJfeuVLjdTwmApAeIvc7dtowI5JjF1P7qC3xBcZ2FwnxHqbyt5Fdg4f
 MNSLxasXzPC0oi6kwF+Q2DXAWlu0AgwmjqSruRqTDZBPQ+0iJgMiU8FXQAPKBdYwpk7s
 Jq/dK35vNd+lKRU3sxHD1rUbcEOx+B/fUp9SWaUOYU9B8imbgVfGBd8qXFHyltzPHIxb
 jdqvTabN0WAcEgkGg63tD90tet1zcAGxAocvacGOjvMgDYSUGz25hufJWqTzxpXp7040
 DGRg==
X-Gm-Message-State: APuU4Z8Hbe0OCxyBM8LMoJ2NfZB4BPmSjqMZEADdKWbmUhpv/595WW/7
 bFSEGy8EJ3lFEAujAHXyH8WYAsuadDtGCaxgR9owRuCljccOAzCFlHb/
X-Gm-Gg: AZFdTZdEsjpkwZ4/uGnRCDDKSbHGI0RsQhekonhekkbtUqAFA1Ai1KiK6/3VsQTxEYX
 4KEdf9WwNVINcxIYK4tfReTklJ4r6Ed6vt3skTeyGN6vpOQJtZxfmVF06AEoj41/UtryN9HByjP
 ZD42OBSxq+sxubPdJIKAmq6wz8AMCjRVb2M9amiQ7nvhn8wlUT/WOo7j7VK48PBwuhV1OCGpr2B
 5NgfPmECLaLbNM+bT1EJ6+qezacCeYC4EQ5eEKCNNStz7KSObPL6AD7B9Jzx+XTPlWmuBb6AVPK
 15qaiTrXu02dRmjZkNL1unwa5LbwSesqMfNeg9flV3aAc2G42xPmpOVFLKrB1K+gjNBPpBpt1sX
 CNccqSNUjctpV9cczDG5VMG5oDfTRXiknDXxCMFVykzHHzRFo3STcdCwR9tYP33Il5aGTcDqTd0
 7RASTxBAbZ2wtjWNJ7LR3CKXUI9BVucwfWyxZ0OgKW/A9/fHiPH3MkLr5xCmvWeuh0d/+IJzx/g
 ypHGG6jrbrTifINZCCju4fNvOgpRRFNtRTiulipHhNwll5uU0MWgct7wPtAYBmTd8ZsptQXxh1O
 xILfmom5u79vTcFZdE+UkTwDWyNDz1/We5JjA3jWLCGxCQEwCr9Ijp2zjuMtkt38YAgKrJ9OCrV
 pdZe4QJItmu5olE1DgV3TcNL3MqgZ7gW+JLvZPeR6BRXrXuKgxbXZG8+ZLzHn63IpqskFQ2U1lr
 J/xoi5c2tKP282h6Svtwv6y2gBf+gK4NNktWZ1GOtfhwSQ1YW3WLvd/w==
X-Received: by 2002:a05:600c:4f50:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4bb888063f3mr512074995e9.16.1795684554127; 
 Thu, 26 Nov 2026 01:15:54 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm834296635e9.11.2026.11.26.01.15.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 01:15:53 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH 5/6] fs: btrfs: Remove the unused dev.c
Date: Thu, 26 Nov 2026 10:15:52 +0100
Message-ID: <20261126091552.76922-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <56a63ebc-1d33-425d-a11f-6d7c73e820be@suse.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
 <20261125124259.95636-6-pepe.schlehofer@gmail.com>
 <56a63ebc-1d33-425d-a11f-6d7c73e820be@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Qu,

On 25. 11. 26 21:14, Qu Wenruo wrote:
> The removal looks fine to me, however since there are only
> __btrfs_devread() callers, it would make more sense to rename
> __btrfs_devread() to btrfs_devread().

Whoa, good catch, I'm not sure at the moment. Happy to leave it as is
for now and do a follow-up once it's merged, or I can send a v2.
Whichever you and Tom prefer.

Josef
