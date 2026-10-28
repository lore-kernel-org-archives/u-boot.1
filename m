Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A598606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A+5vDT/I;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FiCdhgKK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F947810E5;
	Wed, 28 Oct 2026 14:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6n8x_wpWp7U; Wed, 28 Oct 2026 14:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 707CB81115
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199309;
	b=EURGdfNufHt7/MlBLdwGKUikUS0F3meWAqenfF3v79Yh/h2W0gcKQD36R655EcwlKtwh
	 tGucLaRkV5cBF+vb3pmEQnw3VoDM8scA2mlPVz5nUulh94JPJ40FvS4z8avc5jEEtz6I7
	 qoExtCPxASt8aoCwcGuPpRw+BKW5qBA36p8UTQdBIQ0e84SNaCceWL0Rxl5dK+2+duPt6
	 4TYeawbxoBjHPtTjVJYgFmhvYq/skNLjTT8rQ6UXLsN/9bokHp+pDAW1ReNU4m7Twq2OE
	 Knp1Ey2k/Qglk44iT97XHQDp4uQ10a8DrKtcfBrBpa24Ot/vHtC/GG3k/b2p91AV2Yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HEhqt58Ruyp/q9Cv9qEulFxq4ifqgtKmMYh0IfFTznc=;
	b=m8bnXLr0Xd6UDG1cHMX/Z/d9O6dXmyye1AeCo0mLDLjp0d9g/BM6F7L7UxCqRbLcSGYq
	 Mj/D7ZGHtMUpiVErshkf93XeoeK+U7H7EvQH9jp5ivIqoyQMVdC4dumP2km98NxAU+pay
	 fm7X4Ijh7bjAZGMfiirTx8ZLIZGTC9e5i3u1nkdGCjNxXgQC4GZ50qeGR0YbfwfRiFRdT
	 phFLEl2xDhTyTL7rYK+6WQ2P51wEVEq3tzZMJpUoEcd/XLelOBiiUWL0XcKmUsFU+jAFf
	 K/V36tlyeQMauRZOVMQ6Gd/fssbUEV3CHJliKnOC89CA8oY1zaw7s+2YihrSa8LLh3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199309;
	bh=HEhqt58Ruyp/q9Cv9qEulFxq4ifqgtKmMYh0IfFTznc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A+5vDT/IK8J3io1gCB0PoYN0s1va7IFLJR4bO7P7mUb5Qz7qsVFciDHk3VOK5w5K+
	 LqlR+1fM/PTjrRclsjBmhoihE4gbHYGBVDVhaVibZWwRzOUtM49lVgCVJi6pqjdsWV
	 3KBPbiK4R0OeYP8NcvNnW/bVGsT6iq/K+yEIfeVKHSB/mtwvQa9AUX/mA14TDGLuWR
	 tRsYVvpb9cAobkGpofyR1Iil84BDXgbVQyIZQ3E6Y9knYENCekrNdnJoKP3dna6nbB
	 m/Vo4ZsF71akwdrXF7zHANPr52KvoT/ITsNzgTSTq46jSPbxKx/IODfx6UJTxHjgLJ
	 VXiK+FFD1uuvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 707CB81115;
	Wed, 28 Oct 2026 14:55:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 813A54D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A34DC40119
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tyw2c1KOUNtv for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F40CE400DC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199284;
 b=kwv0IFJgfRUBu4Jx0a1DgqtdrI3ZT557sRwuEYW/iKcE+cYWBw14UHCaP3DnfEVTE13J
 tsT0rhtprOiP2fGTeEE1vEuZwbfYN9Uq/WtHHCBQt13GeD0Y00gOoWDFh7ZEA8LhcFI2f
 vqmJLnlypC12HpJcTlKrKYk9sd0KuigBttOxEDqDO/acZPcOC8sg12z/+bVvGZmlWCU1b
 c2jTszUZBBhFA97QiEJBi+W/hqeA+0U93WpTAM2f0C/lTKHd0E81Rbgwo1ED48Z0ugtJN
 dTKuhZwQVpD+3psIZRwIeIRp+/fNlzH5z/8NW0Ut34G9KVAYYuUB0I+aAF5e4oVEVmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199284;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=HEhqt58Ruyp/q9Cv9qEulFxq4ifqgtKmMYh0IfFTznc=;
 b=VwCJhwN47EFNoDnq6i8iQUwGafJ34Xi0lVB1Lvgs5m7IarTxuViN9o1dPWcYtuNDfm4K
 RajTUlWTMifKmXBukWgNK1aIob4ojraD2De+UKrVZsVWklC1wtgrLas0RNWsEzbiVRrAd
 +IwiYbmlWx0t9wkhPI/NXNKbdKWdQK71PypxxFS84nzjlxET+sS8OQO+lr+fKT6pfxCAb
 T6WVnEA2/l4+dBDdVl30mzL9CGON7Vr/qI6Q5vNoTKvl6pR6e9JgkuelBzESLcuBcih7V
 yHShGBqjknx+4fORQn6glbkAbvcqKKygUQI1r7bx6KFU+yf1nXj8NbA7EyN+l+VudtQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FiCdhgKK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FiCdhgKK
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F40CE400DC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:43 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-84d5e56f876so755022a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793199282; x=1793804082;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEhqt58Ruyp/q9Cv9qEulFxq4ifqgtKmMYh0IfFTznc=;
 b=FiCdhgKKUDdcP36MmNayU8HBxrSN9MwGSvLL6H6d+EENHNN/AlMUVc07AyhhOx8cex
 8ZWc9aXmfsdK5K2jwiemVwe/sGrgavLnyFQ7qkUq8gDHAsyPNOq+nBHokB/jCc7pi1CQ
 CUElGaRlTREgTQJEZr+8Hh+Tjv0RfgIZMbosM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199282; x=1793804082;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEhqt58Ruyp/q9Cv9qEulFxq4ifqgtKmMYh0IfFTznc=;
 b=qMdMidhmh2qFospD64yQJB1XGwf2yaHLYOnr3dJSXLfGwuaVb2SXDwaIqaui6UvH48
 dWCEUt8tynpBgZnXXrBX2KhSiwrxIT9XiVcNTnOtYD8z/rD6RN+qSDUcRgeC289JL46R
 5ka/7cRKutSICKOyQb/EiR6ajhOOi4hSEe7BQUS5PbcgYrFGIoJu6gCqOHTkysMLjokd
 K7yMJYMqRZY0PD4WsraKHdLu4LR+sLr8VZi6866EIfMf55H4i9HUZYprkEnAJlzl+rIB
 Pv6HYTFvQrdXeK9X/ykZ1wLhXGAI2bH3naCTi8s94Hy+tYxrRUF4xar+1l7mO1Zz/6Y0
 ockw==
X-Gm-Message-State: AFq9FYItG8Y3MWhpN5y2idcOfqz5pkiT9wOzCJf4iA43e7zWwx7qW8BC
 mnFQps0xR0V18WjVNM0c63wVFJ/bSJV/dDgzl53Au+J2zmUa/3dpAIQGkbZZs6tQbqg=
X-Gm-Gg: AYBFou2BnWoZXgo2kvuIBCnHquHHQb0BZTv7EKoQEF8Z4ZplU6fJr8VLwStlU6q9v6H
 4JQJgWZ2PwbVNdHNRsa3Capqr5w7KXSLUKdZ9BIHZBB0E+w5TgqB9Sf/MArJKGFx5Fumi1TRICt
 PjjpEtIJzWbm9s5sAJmkKDkkLMX9wAnoV6UcY0g/1FRYGa7XfI2bBNlOkFjlSuYcePaL2P8fYy4
 +j1oJBi3X1NZ09VJtAJRFlTHxemq/hP5fjA1Skx+mZSDzvRaF/jqWieXabinNSCbB0lsp8XrC7z
 tTeqnwCVsFr2S+xLzkCtHxaJOE+3lLMQ8rCmDiREOya1pxbIEMgwJA2Zr2YT7aQoKTeY9fCsCSt
 iCtNnUrBCJr8WG6+gLcVqBu/DH4N/6bDIrii+KLqHt2AkDZ36GPX4PbXFqUx/U7eUZWWhRyAY31
 hei6FIVwvu34Q0sI81qSjTbYlliLJlZlX8c9reYZofrXIqNLggmp3C7R7m5ugdxDOEhDIiZdcZJ
 zacUTBcRjVOxkkEO/1kDtJ7IJUvNv2N/Crw+abYaefem1Ntk8ShBZuTaDMKEmZtcCiIDvQXA8vW
 6mVEgL0FfJpNGHToYhyCT6xOd6nr5Qn510q30k1zoFvRSmnLfliUattTA7DKGGwRDGUuPn82PMN
 RI8cD4OA/6Iz8BrsxfBzXipGczEbOiNWnDauPn7oT5EWDH/rLSATY3TuBi2CnSe6n9+5FS/6fg7
 gGK7ECYAq+XUgy3HvkelICXDVKdgNeQQ==
X-Received: by 2002:a05:6830:2705:b0:81d:c548:292f with SMTP id
 46e09a7af769-85abff3f02amr2414093a34.12.1793199282514; 
 Wed, 28 Oct 2026 07:54:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20217c77sm1871528a34.21.2026.10.28.07.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:54:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Randolph Sapp <rs@ti.com>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
References: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
Subject: Re: [PATCH 0/2] boot: image-fdt: fix reservation errors above ram_top
Message-Id: <179319928154.2677777.15379841966426479571.b4-ty@konsulko.com>
Date: Wed, 28 Oct 2026 08:54:41 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 17:00:38 -0500, David Lechner wrote:

> With LMB_LIMIT_DMA_BELOW_RAM_TOP, LMB reserves the memory above ram_top
> itself, so reserving a reserved-memory region there fails with -EEXIST
> and prints an error on every boot. A region that crosses ram_top fails
> the same way and leaves its lower part unreserved.
> 
> For example, on the MediaTek Genio 520 EVK, ram_top is limited to 4 GiB
> (MMC_MTK implies LMB_LIMIT_DMA_BELOW_RAM_TOP) and DRAM initialization
> reserves a page at the top of the second rank, which is above 4 GiB:
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] boot: image-fdt: skip reserved memory above ram_top
      commit: c49704fc5530d4cd62cda7912fc34e942c237bc9
[2/2] test: boot: image_fdt: test reservations above ram_top
      commit: 3ec4470f39ee64dff7422fe345538939a1ce1d36
-- 
Tom


