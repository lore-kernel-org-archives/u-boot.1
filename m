Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1482DC5DF69
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9E8F60906;
	Fri, 14 Aug 2026 13:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcVpnH6bdJvr; Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6DC4608BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715476;
	bh=f9AF/e9DKIPd2UdVErSk5zddABqf1/ujSscL131EoIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRFPcYBF1XoLPYW9gwX18+S+4Ogxy3T6rcJHHn5ZO71plNi48AcI51Cn+AoCnQapl
	 pYJUQHtxFTKV+zqTkoQwX2XexupV0i4mZvpGWBBMCf5V6Z18dQDh2DuhHF6NtMhhqu
	 +ajCcoEPj7ozPomiHxUqy2HKp4BKHwspy9+2v0epC3kFqaH6QcwcG1C8bqRrT/0IBl
	 RiX47V9qXZaMhO4lR8LEWuHEwg3HlDJd47C0RXUu2fpQ1hg/F4ovt7Io9KvRb8hFpQ
	 dIjr1g8w1HNs1iCACpUEQFiFY5qkgkqT4YQCYKL24fNvNq5Wn0K1VEZHtD6SMt03T0
	 uG90mEodK+6lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6DC4608BA;
	Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F73139B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B988481373
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hKubC8ABDxe for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 09FFB811F1
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09FFB811F1
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aoQqLMe5
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09FFB811F1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:10 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f18c0e03e3so511330a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715470; x=1787320270;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f9AF/e9DKIPd2UdVErSk5zddABqf1/ujSscL131EoIQ=;
 b=aoQqLMe5Sso5BkLRd3BJVfApJdQMRQcdFmX4FyiRD2c+PmeooayQ11z0rVAxxGFhRn
 67fJ1K02ZcNBd+HY1ydOqldh6zeHMJo14D4RjLD5hJ+NwLNxkxIFO5idhP6RiXRYzYOO
 1H1lMJS3yQ8maT9x0yww7esFOP4uYiBpBnHEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715470; x=1787320270;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f9AF/e9DKIPd2UdVErSk5zddABqf1/ujSscL131EoIQ=;
 b=J+gDggFGul5oYH4sBFDCLtKK1UUpQeZEiWIR11XhW0MWx1IL2wL/cXzt7TKMRE7zs8
 HHukNhSEheleaZW+KrBe9VU2l+8NYieaYl7tZXnjDjOz1LtXuYEvabfEo0XrTmKpgnKu
 eoOyykEN11kVH4lCXzMQaeRuepLLVGebqxhN2epo3JisXP6AayZHSUzpa3nedH9pnsTT
 YFKQucGWB4cHYBVxu+OLllOOp3RRu6n2yGklc95OY7DISMNbubz8glBysP7VyROcYCG4
 Uw3ql0HBNYtWuz13CaihI3IQA0HzLgF/PeeOVw3k/30qSkMKqP0U7z7vByetgvvGy95b
 PQ9g==
X-Gm-Message-State: AOJu0Yw4Wmn400yC9QM0gvSYHOr8nvbvQheA9Oj5cgTBr03ybOQzUHIv
 uRVv4YvEsX0vralhvdM6XDfl1ciDRNFhNPp8ETDqMdUQve4qi+yw6kx4mP/V9Uy9X1Zm7hQrKuW
 tPWNZEf8=
X-Gm-Gg: AR+sD13xQo/LalhcajrqHcWQwH3F5isOQWoyQEVhE8mQeMynVg5UexA4rxr1oWWS67B
 XPtVz93gzdDZpM6I0k4pndUUtwgp315PsiGn9TbK3llBIWJD3mr1cDzre9zdYGBfHZ0BPrr3I/3
 nzcQ9/OE3i4X8l335iWY4unhd7aQf6Grx/AqOL2Hnm25kn0BVRVXDjlR8qEwJ1ugOAFR9vOqoW6
 RLlsqO98OD+XVpWK650S51wEge+TLj3d8+x7s3Y352ij77xxB05qsMvITG4TjrBrCbI2b1SjtH+
 KksTL9VwAbf/wwaKO159YmvkgM3RCqx3qb+vr+0OIsc+yFgOVnX0/CMsZ2+i5pnswBHaPcjPPSh
 H4Eg9xulIAtMZS4ku1OhIJ0MFo7wN18sFzs0qaEkJ5hs51Qnx4Gh1G/iWVIdlZJaKv/JuG5mRcZ
 YmBwQSm3Z2o85fJt/pRKQXzDEd6wviqcHaa0L45IP+y24wbGRnBsmhDt2HYilzu2uMAIr/UTitk
 gmhMBumrct9p976dgUJ7OWB3p8Q5EY2LBgJdYiH9NtEApf2Ye/1I+/hL7a+2eSzy6KdfMGgyfEC
 ifY8N/4S
X-Received: by 2002:a05:6830:3748:b0:7e9:e0be:583b with SMTP id
 46e09a7af769-7f3de71d894mr4852311a34.9.1786715470039; 
 Fri, 14 Aug 2026 06:51:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730-b4-binman-docstring-dedent-v1-1-3ca69d1c97f3@flipper.net>
References: <20260730-b4-binman-docstring-dedent-v1-1-3ca69d1c97f3@flipper.net>
Subject: Re: [PATCH] binman: Do not dedent docstrings twice on Python 3.13+
Message-Id: <178671546927.3828101.7968363551381278056.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 30 Jul 2026 15:59:04 +0400, Alexey Charkov wrote:

> WriteDocs() and write_bintool_docs() strip four characters from the start
> of every docstring line but the first, to undo the indentation the source
> file gives them. Since Python 3.13 the compiler already removes the common
> indentation from docstrings [1], so this removes four characters of actual
> text from every line of every entry and bintool description:
> 
>   $ binman entry-docs | head
>   ...
>    that an image node whose only content is an optional entry which was
>    is an example showing ATF, TEE and a device tree all combined::
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] binman: Do not dedent docstrings twice on Python 3.13+
      commit: 7cb377e2492a9f1a7b2f8d3c9387dd5d89c2feb1
-- 
Tom


