Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F84606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f9+mxJeF;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UAIQ9dR4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0997040E5A;
	Fri, 13 Nov 2026 18:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ilATSMMf4li; Fri, 13 Nov 2026 18:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B3FD40E1D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794595756;
	b=b9eyzcXdprE3hJqeO3fdYu6zDeAA24pMaxNH3ZBLnhvtg8PTY3ZR+weSBtLzgDfR8Zdw
	 yTuH6deNcaycH39xnQjSMMGrpWqnpAkMjzmdXLhHSQG0sCcVP35A1jJLed9sEGTxO6ayY
	 UZUUpAqBYuTo47GOi6vo9E6MzfixBWunQT1KflaOPtxP1NptaimJ/CbjNWl2pYZmoOKyv
	 qpUKwM26bxejzrIGKtTU3q2v4R5mfNIuH4/bNMdzVZ7M81XWAXZ5bOai5+9ZjiQU8qMFm
	 3Z0xw+pcPd8FzJzyyemuTnyT4GqvI/dQtSArk6KFAV1KhbrS+fWg2GaTunh9kvGHU9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794595756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/xrwbkEj2FSCoA5ROsBk1WBUdSNVIYXFl6M1ly1eQQQ=;
	b=ALN8MZ2F98yLIDtYw1ZuV2r+1IsVYyAQ9jsH3ATwy1BFy9jV7/XA/yGgOq8QsTGDlJL8
	 ub90b9r2fACOFj3ZmAPeR8Xi1BK5VRSN+B0VzIProLjgCZU+Qfycatczu0Lep9GLzZvst
	 yTlD2mGLgbsWaCq/wIxFlQkmaxdvsBuycbHqMAzxZbrGuaiiV9zjvfBzEebzfJgOPE9+i
	 1uiuvzEIvuy67JijxcU7tBcv7Vi7GvC+u82xIrLInOqr4AODa/Tx/rP5baGeoNCcn2w5O
	 Bph1UAKnc8W4TrhAXRYwak1GmPWkgE2boGAGNGWiQeoiasyx+PupsviFSfX4iSyEbkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794595756;
	bh=/xrwbkEj2FSCoA5ROsBk1WBUdSNVIYXFl6M1ly1eQQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f9+mxJeFiGuUDZ+CQI8ZI4Aa1SKHBvJTg63I5SBRrvHhcxovGj829jbWwRH5XnIgE
	 sHwXMnZazorrK2KI8aZ+22ByJMrwyOG8b/ml8M6M/+ONLjZa8JfWX7yVtWaSqIcE0a
	 y0s8r9gYzEbgiLXia/OgjOnKL8UpiLH3MXSguHtoYr+OPiTKFBtY7SZ2W06OgRji8S
	 RiSBLis6H4CSilakloKUW1xQYxvwGnUCk8vpx7tFp0nQzLv2w7VBMP9kcJoabtpieu
	 yn8bopsXVI2XFOw56irhZTMnFmUHC31f0y+HgfA+YbV62YwduWQbpbpE9GF6/hCtk9
	 MKQCwXIaZpouA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B3FD40E1D;
	Fri, 13 Nov 2026 18:49:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2501D2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E961401D1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMsCiiSDzUXP for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:49:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5924F400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UAIQ9dR4
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5924F400AE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:49:11 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-53a448f86e0so1689623b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794595751; x=1795200551;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/xrwbkEj2FSCoA5ROsBk1WBUdSNVIYXFl6M1ly1eQQQ=;
 b=UAIQ9dR4pe/8zz491hpuNzuilvudDKXs9Qh/Ta6VbwU+A6eOAd9LNV2cDtcKVGWCSw
 mABGcfSAUNx7h5LLbffVv8jN5TSan6QKIqpBZMMnzBKx3UyJcnHwoIegMAlkZA2NsyiC
 SAZDtcZbiUd4yuNVOIBFx9sdOFtPrUg7K0ZIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794595751; x=1795200551;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/xrwbkEj2FSCoA5ROsBk1WBUdSNVIYXFl6M1ly1eQQQ=;
 b=XhC0tW90w43/dwEFAo1HTUQjmS5R1NVRFgqwzFTJYgTk5Cv20xmIx/QNhWxxn57RFs
 Ie8mB5bj1kq5eHZK1mKYcqW4XU71Hn4i/YpP/KVglJnc/Yi+FJknQKvVuB9pAzZ4d3A5
 iW1mJj44i8Nt+gLzIz9suw/oxQThehueBSonxppjJy6JAcZPFw3SQDAEArqsWuXhhXtX
 6fI74pucbEyGianwFcdtqOfs8RNx5j3hFtYu6KWGtpwpZoffQA1cRo4pKgrXBI32c5tU
 usz5e+BwzzNIJ/38a/pZtOW5XU/VFP2s3l9nC7DyGLpXxuQnGYn0Ld28GbFVxSvVlWnT
 0cNQ==
X-Gm-Message-State: APuU4Z9fen8HKL0hU9DfvchehVfJckRCi3tI9E8gHCJXUNXpA2YFI0rX
 bdz7B3/MLc7MuCVoZe8A1b4xrUrB28Q9g643JP+i0iDzwAbHksSc5SGLa9MfQRIo6q98g9eW5Cu
 71A1xbj+4qg==
X-Gm-Gg: AYBFou1upG1zjiTBDCFHc0bfgwIeGNdw6T1JhpukxzuioqukmolOigyODAUKVeQ27Vb
 5bLodvwJoBGZFEY8IdJJqR8b3aBeeAXEYJrp3Q9xmMwrOt7OVyFh5544X+5UVVHnyt2Xm3bFVeV
 /c+WL8ArxQRQoiV9470H/9VR5nkTsAFNCcMqSEKT5VbvHjEAU5+bNK59Lws6b18M21IDU13OBSC
 tbVC1IvQfiaSY7rVTVjEc+11GI/1RmfUxbguTmNVtlO5/HlIUyEIYSYyA1qCdDKc2n5qUxLjtW7
 D0i173pwJ2U1pP1RdwxJVW4D/b0sKczB6AABt2PJWMiwWHaY9cdZgYDbP87cYhkK6a2jjETbXeT
 comQR48X3aCBP/EbKuOxOlrSFTYzDS1BcKHzIzXhirk4SPby37J208xHy4DRB9lF5RkMgjPmN8Q
 UIK0Y/wYwPndpk5cZCnKHW70xnxiwgbpDLejqK/Wkwtjf8CrUGLfB2oHYaQp2o3u/Qk0NDz0HPE
 fL1/I+kAs00gBLSLuMbxOMaNKN/lGQbnMq/sgw6QFLVYJM3w0WwayRyUsxKdM6KykU0fzJX5m0h
 Xeh5q1TcgzRjljBmWuqvkfXFl4Yf3QRasNIPNMvxtlrmJumakVadEvsCNS/0jA1c73Q6WbvryBg
 L+pnKlNBiHQ3UNvYB76dT9mD/ET2m+oN1ByXCBoru319gOO7yNcyHMeIckin+n+IKY446ZJRKyl
 qkQOL/1+oq7g2vIo+d+VwSTdEsJ6DS8F2JttfwKmDhLKw+DLsrzOc=
X-Received: by 2002:a05:6808:e88:b0:564:3fe1:2f95 with SMTP id
 5614622812f47-56e66063859mr2669277b6e.56.1794595750793; 
 Fri, 13 Nov 2026 10:49:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e7094aafcsm2747435b6e.12.2026.11.13.10.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:49:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <foss+uboot@0leil.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261112-sjg-lab-removal-v1-1-4473fe34c2cb@cherry.de>
References: <20261112-sjg-lab-removal-v1-1-4473fe34c2cb@cherry.de>
Subject: Re: [PATCH] .gitlab-ci.yml: remove Simon's lab from CI
Message-Id: <179459574992.1254556.12877360021997664796.b4-ty@konsulko.com>
Date: Fri, 13 Nov 2026 12:49:09 -0600
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 16:05:04 +0100, Quentin Schulz wrote:

> It wasn't migrated to the new GitLab infra, and won't due to Simon's
> departure.
> 
> Stop creating manual jobs that can never work.
> 
> 

Applied to u-boot/main, thanks!

[1/1] .gitlab-ci.yml: remove Simon's lab from CI
      commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
-- 
Tom


