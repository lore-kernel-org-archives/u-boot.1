Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2FEC624D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 18:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC28F406E1;
	Tue,  1 Sep 2026 18:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZuXsvUvoQCj; Tue,  1 Sep 2026 18:00:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788285633;
	bh=ZvZE82DBN6ELFHcLJPt2QxfM2gP/ndTq53Ftn1P19Rs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pwMd6lszamv4CB/6dxD4Xm0LPLt0cpnqTxb2V8Z6Lpw92QWtsX032lEvPJQNwqrZV
	 4mRSJePZzXw+VCOWX0vSOcgSS/F5Jmid8heSezhwd7syu43yejoXUpSg7h0VZJDGsS
	 soHw73W7F3OZu6X7sljlAzmuNjrB8hUp9IWXcVp480VTpOjluM+gW3Qm4uwfbWZwGq
	 MNZjcZnAnME47LfLYGVGKC5Og6jyg06saZU8JkQWgDwNBAvGkHtuhqf4bmN0/dsnxn
	 PUqeYv9X50L0rE4TNPjwuqqlkxdASv26WXqzpZdGh+AzpKH92ACdQJ+CrIuShHmXYZ
	 1NGVK4ChTcwXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E67B406EE;
	Tue,  1 Sep 2026 18:00:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA84B2FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D07F1406EE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSkAHJdSn7Na for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 18:00:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::5;
 helo=mail-oo2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OEQZSYV3
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0325406E1
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:00:30 +0000 (UTC)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-7f748fe2947so11346a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788285629; x=1788890429;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvZE82DBN6ELFHcLJPt2QxfM2gP/ndTq53Ftn1P19Rs=;
 b=OEQZSYV3ao3xZANkdywQqgHWFj1Z+Q3gRZ6+FrW03DvhUbyw3+vAcFus3HJWPHzhKD
 yDiv+oNC4gXkSqyn25+icEimBakFp0WMLFsZ8hTTn0NyIxTgOCHGPrKiNdiwjpIb8A6u
 lwjvWO9fDiIvVQk2iNRdWCA2gJYLocFBqneC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788285629; x=1788890429;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZvZE82DBN6ELFHcLJPt2QxfM2gP/ndTq53Ftn1P19Rs=;
 b=pH75cM2/eD6RTTYUtOnRZSZ9OKkgQObGnB3IRTu/IVkN3g9yXLYHYKSdT6MAuflYtS
 KQWaJ2WT63dhtnluhlgAc6Nbv2E8nqxrraUnb+urd3kPsHrTXjvnwEd4ZwPe3do2LqgL
 v9XQnAj2lhV05NnQmkS0qyq7slqtir4mJ2wjdtnvh0DQo9TFx1JbRDYdCxmyUmmpVwH3
 B2FMGpVV7Owv50FrYTGHI6Y6ZPq/91hu9eszzqfhC9H+r9FCz9+MFScehfje/UqC6abV
 qobIbRt8nFnPHM3v8BGR0ykcp3MZ8S0UKNfc9GJe3VFGylPm4RLy1+JWP1oSFP+oSTA8
 llmQ==
X-Gm-Message-State: AFuF++nNN4OnJ7e3Sg7mltgOgT2p5KWN2ddbnrV61DHlmVMKUXiBsF4e
 ydPAk4449E3nspeaquBsIb6pRkGMQPKec6hwOdlHakEQy2rOcar3Q8ff6j7CoJgG0LdbQEBYJ6D
 Uk0DC6KzhVQxeBVM=
X-Gm-Gg: AR+sD117UsMSktraYNF0ypQmwa80uI4nNkWg3Y/3idaMdBeRnEXATUkPBHHfSPogzJJ
 yiElZz+YpfY3HMAQh7kI1djn0aPLxzf8FidJFmxUhDNrPJd4Uv1g09MiD+OHHKodlEaqnw6BRts
 bUX6QyVaBGGN2kTlWXla5TzqVdDXrkcsZIBrSOfIZjxE7TmJ9qxEJ7XCpPaEusPFXrOXkDTjQ0r
 M8DzoRYX5+Dv3UwzMNGz6IZa7Ts3t2hWcur/KcGDfoLAJcZsF4vNw6mJ+5Bh7IfvRGZuPfZwCgf
 WVsYj64hOB2VItrumDK2DRGFmP0m53NPvrmbVG7AFmP1MbfX9TeU38XQcCKy27hRiO26WD1h9oB
 AAfDDntLYnmlE6o+dB5DCShIZdYBAZR1zHC2QlJxjOFFtUSBoGulx/i4X/G0uQ8M2fTtvB/92DA
 ynKM6evWyMnuKOeEtNXGmhcspEDpyz0RIeuP2lPeUBv4GLKE1C5XVbXGjUm4/B7221NPgpi1hGO
 ypDTEzbJsRq15uwH9AcgzoY1ZoDw/rgqasGckGaDh6qmI10XzpH/izt2h/JdbGgPUYMOnxEnK+m
 4Ht3FT8X15hl/qbm4Tc=
X-Received: by 2002:a05:6830:6519:b0:7e9:e8ae:7049 with SMTP id
 46e09a7af769-7f4f22c9710mr41421630a34.7.1788285629594; 
 Tue, 01 Sep 2026 11:00:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74d2a7763sm133691a34.12.2026.09.01.11.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:00:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: ngotra2710 <ngotra27101996@gmail.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <2a8e01f4-9346-471d-90db-5f51b04f21b3@foss.st.com>
References: <2a8e01f4-9346-471d-90db-5f51b04f21b3@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.10 =
 u-boot-stm32_20260831
Message-Id: <178828562799.1481980.10714974688851349937.b4-ty@konsulko.com>
Date: Tue, 01 Sep 2026 12:00:27 -0600
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

On Tue, 1 Sep 2026 08:32:42 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/master, v2026.10: u-boot-stm32_20260831
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1132
> 
> Thanks
> 
> The following changes since commit 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


