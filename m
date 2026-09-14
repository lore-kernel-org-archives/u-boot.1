Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABDDC982C1
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 23:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 406B540555;
	Mon, 14 Sep 2026 23:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkyFVJD8o32a; Mon, 14 Sep 2026 23:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7666C40557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789427773;
	b=VZOzxutI2gTnB5ToEwbdz1I1vNAZPSxewXy21/XCS734wThH5gJYEqOP+PH2CYjYucTm
	 w91TUyR5CeLtMg6clofPtYbGIssABbNEDRbWl7y4dY0SjpD2PHnEkwQxhOCXkBk07q1ba
	 3WMy4Kp9LM2axEi+evRL+hflTuU5T+jijTE43E/pUO9MTG2Sm46n5WuCWOlJLqZiSuy65
	 monsVJ9SCUKoq9mmc/ICMIeg0U5vMX9jJ+SpLvJlxqx7lKttTeV16zbZoQ/lxpUplD2en
	 zhFE8ZR2CowLpTQ/6u92Jk8zzZ6lFQ5/81bukv7/us5GxSycvbXObgXUOOOokBwc5gQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789427773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GOIeeMGkq9+jfIAmQp6de2n6F5YNx2F4vqtECYvfffQ=;
	b=moKf+Zq/orTtARObNk0sUoLnsogwL1qNpw5MgNX3+ubzon4gpEy4E/ybEsu4hXP31qAs
	 CE1kox+Jxu5RJowyLQv/aVtNMo+w4WgGSqIHXDA4H/H2F0ZuBNhDJ4c71dfekqqeOHQkU
	 xCzYoyqDujXrBKW1MUg5fvbcdTURc/tKkPE2M5RD7xR7zxjIte/ZKAbAkMleg/VfA1pzg
	 dcbAuDfZwQHPZ7PXrL7JAwmCKCzqqGX7AwsWrt7UuwEw2JxtTGsYco8a2n7M00s+Z8lP9
	 VAyihn4iH5xYeG7sKzcdCsSpfhfKHmkXbsIT9rOyCkKpIgMgDXqypKj3hpROH2GAC9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789427773;
	bh=GOIeeMGkq9+jfIAmQp6de2n6F5YNx2F4vqtECYvfffQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dt9mqPhrravvcVs2WKrPi41XPKZ4Qq54RznG6HO1fjwK8lWBcG9z4V9+3sTuBu7uo
	 8SuVvRdNdH6DRJfRZ1/8MVHsA6LDaGa2YAQrJtvNFQB5FR4TcEEj0vPaVgK4nQJbmk
	 9I0LMeOLoHMOlhatdJyvn1Fnlbu4eJbKq4tXInRhXrUp1jrMETgtNvxCeL29vteWNl
	 /8g5v/YzZyzlbVRFICOISe5FvuG+aaPWuVzP5LXcPyWSPl2CAYHGiAVXqftiohYaFG
	 7NyTdD9tOS996XdVgrVMcpkovzeTMlBXecGZNB5w+Yobd1713IMgwNFte+LrUbXQSY
	 jYiwSWy9HIYrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7666C40557;
	Mon, 14 Sep 2026 23:16:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3364362
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0CF5401E9
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsGfuta8zan4 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 23:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 05EE940076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789427770;
 b=ksIf7xDLkZBy7ecIo1U3KmMu7SNhXbwQ1Mh/DD33t6t9cU4ygT3Y4/S1R/hifT+TEgSC
 MBBP4LIbK8Ve17KzytmI9Coyr1G74Cbb0KxG7GQbbRBvvIgU3Yf3TGuEdqQUpPZhw8wVV
 0GRLBmfTSqZztAsUoFv45uSBZ5ZNMGh0hIpwE5boRtSufMLeQqp627sy90EeW63L+0Au+
 V4NL7Vqj05Qj92UIDt7xAiF7dgTBmXpQw5JL4JUp4xW32oifIZGJ6AsIVJOR1+Pmfar+X
 Q2NbPjt0mjp55CSmZa9aEaEOZ6ZqaGxZYTClHeZKildsuPytm07dJiF/F9eWRBrqSfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789427770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=GOIeeMGkq9+jfIAmQp6de2n6F5YNx2F4vqtECYvfffQ=;
 b=Dy00cZNwJhylfkQMXGHs4v+a/oUbHJhXuorWO2Z8HpFVGc2XFOAW4qM9cqdEMHqJI2e1
 QwwNIo9uygLNNyqCLt+t4k9I9RYwikvGu2jKOvmuuO9YyB0xMJMxN5FzVUjpsatYWbSFw
 4nz/7VwbCHJZbHQoPy+tLTUOBNcIpOiiG/4i3LkNnhnc7O58Is7qY7TWhfgn1WP9HDryA
 u7MtrSIjvXO9v11Jp+e++g1LBPrBA0JPNrxsKpaRSoFtGI6xUED1GYsDyrxWE6bRMipYq
 1o7XvePXAzO6BHxwjcRLsAOoU2NeLy1BBXQEIkieaLh3mPFy5j8P8aVomI4nPysF4TQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b8NexuDM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b8NexuDM
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05EE940076
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:09 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c13f2685f2so1767162b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789427768; x=1790032568;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOIeeMGkq9+jfIAmQp6de2n6F5YNx2F4vqtECYvfffQ=;
 b=b8NexuDMdYhnRHGCWtbcLrgfZ54GxItnLEYCLvo9sX9HXFSOBm+SLtRD2hoMthGWMy
 oSVAvyg0B7Lcs/Sy/cKyAP4dFB6W88RhGz3DzC4qHjf2aYom54b7xKabYleFzahobnnn
 NPWx5NMq0nzy1p6NzEtc2QXS4arUIffdtWpfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427768; x=1790032568;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GOIeeMGkq9+jfIAmQp6de2n6F5YNx2F4vqtECYvfffQ=;
 b=W0LMwW3HyxlciQTDLVQohbnnyYREDRQzzDykkfxZgQqmiqHAN1KmdoIHPbatJ6chO3
 rBDt0q+ZTmRXEcZ/W1f3FkfqdNqC8eH/Qiz/1z8U1wnqt7ITGI/gyO0Z72q0tcsYpi8C
 9WLas/RnhimoodLulBo7zvAcVMFzDrlviWJ5zRTmgvgaEQUECSVau+XbfBaw5BD93qGG
 U8gsYWG1q49g/BJ26ya7yADCn7AZb+UGV9fWunJPqfXt+O8aq71lQRgvG/46pvACwULa
 HiUDzxf5H2+UrkvMizvNRQZbEjKJwVB74fatas86A1VuHnCKAjs5M2pXibdQ3dCQnTOB
 0L5Q==
X-Gm-Message-State: AFuF++lbTB0Q1HYgKNlnjWsEJ415Dcp3S741boWNN/zp7OhkwkC2axMQ
 HSV10G4ZV1ZVTdgMbFlRTjPMb8NkWuM/qkBKwtFOqSezd0whsrEblFSRu3V4wCdoN4FK2+FN1xZ
 3vBZp13D2aB+P
X-Gm-Gg: AYBFou0RrhXBedsDlkHiQgjGflVuPq19nCYPh6W/5h++K4GyxEMg2JdX9wn43ndj3G5
 T+NOYQNuYY2SrpRAjN+zYNCLl059PjH3ncROYN0yJH17LDW4T0C8PR2tqsNbRz1SsBW78zuM7I/
 S+vaWuQMPyF8FHO+zXiTefxT4qIRAwN8YMH3lIxDFZ4lsq60fDoa2gCrTnEpUVo49qVyf/uqVnm
 rKQN4XAiSp3YzuA7cJQvIDO0tdTbUSI0K2y6+TGiDpEPlrZaIEwGR9S0mP3Hf1kBi892ysE0kIH
 pKBXC0Mh18slelqwupjlwt3T1g9wbOgpCitDzldUt9w3Ra3dzino6s4Hl9rerrWpb4OivNFHrwL
 WlIlZ4nbkPCJr0TER0VVyPpVEKCZmsdDnH0DxSy8TtlLc5EHJdAhM398VHfPR/kRKo5/mUD0v5G
 F4hlixOqbBVEP3Ow3VsPJmJ9lTibSv9S9SWoRitV5ylQIJFsPoBvp2C9NzhummRMiuOOcBgHEbG
 KZOqVCYBcVvnet2yCCoCRZY2h233+68AxsRCRwBiWQIv502if8zq+vbbRPaTTlaYOaQdV7Vjhsj
 opNaKoocMY64jfnX+WA=
X-Received: by 2002:a05:6808:1829:b0:4bc:2295:1687 with SMTP id
 5614622812f47-4c7b6463e6cmr3622096b6e.40.1789427768437; 
 Mon, 14 Sep 2026 16:16:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3314b17d0sm11811299b6e.8.2026.09.14.16.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:16:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, u-boot@lists.u-boot-project.org, 
 Lucas Martins Alves <lucas.alves@lumal21.com.br>
In-Reply-To: <20260826124754.25813-1-lucas.alves@lumal21.com.br>
References: <20260826124754.25813-1-lucas.alves@lumal21.com.br>
Subject: Re: [PATCH] fs: jffs2: set part->jffs2_priv to NULL after freeing
 cache
Message-Id: <178942776789.665895.15973593074756132285.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 17:16:07 -0600
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

On Wed, 26 Aug 2026 12:48:01 +0000, Lucas Martins Alves wrote:

> When jffs2_free_cache() releases the memory allocated for pL (the JFFS2
> private list structure), part->jffs2_priv was not cleared. This left
> part->jffs2_priv as a dangling pointer to freed memory, which could lead
> to use-after-free or double-free issues if jffs2_free_cache() or other
> JFFS2 functions were subsequently called on the same partition.
> 
> Set part->jffs2_priv to NULL after freeing pL to ensure clean state.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fs: jffs2: set part->jffs2_priv to NULL after freeing cache
      commit: 52673196da5751457ee48415fbd7626a4bfdadfc
-- 
Tom


