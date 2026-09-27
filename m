Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1440EC9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 19:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AF896060C;
	Sun, 27 Sep 2026 19:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9C32mgOfPyHx; Sun, 27 Sep 2026 19:08:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 763DE6060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790536139;
	b=T4njH/rwGVfkxoKo8CRlUVnlM94FgFgQfpmczhT73dfLz6s2YUJWxGIrTzN1S8+xuVHd
	 XaW77EbAmcCiVjVETewe6VV1V5V41mWI6dqD2Ru/qV3W8ns+X8X8tELqN2d+W6JPoDht5
	 onOh32wgORYM/vqjS+/KPWnMBkfMFPu8r5mCIpBHtZHbcHRoTC+/Sck9fWWVYmYa6zFf8
	 zTs9JEBzfjEUWJgB2jv6660bwK22jAE2sp6pDIEbxjJAMRQFClTnbnuwAfQWcnzPZS30y
	 c5gCM+soaXNYNiLq4L/o/QW4YAtP3JPMr1o7/EAD6G2OCiCIewKROL7t7Mb6ghma5iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790536139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MtOEWvCCpZuS7Li0yMgyapMkwuAtkXtuYNyArIaSqsM=;
	b=EIsdu2VQUt20UEumiy3LUpGHk3l+m3/Hw/ZPe7xNQI9Eq4IvaKbg/k9ETFsanKTeYWqC
	 1fS7/JZsIpfobjx8z/E8iJpMS70Om8nf8oDeuzd5sFOg1+uI9E+nLjO1+V20ddv5Qg9We
	 5xfpUDBxYAhN9ExT3XaZL6GJhC7fBY3Oiwjnz5olyx1eAPn1hsTC2wgo8cult8CrXB5MF
	 xYCdq5IPINFeV0W9OeHKXeHUdb9feReqEkztwyJy0apjioLeMUe8BuurSbZmNESfb3IiZ
	 mrzErU/gbJ19GxwA00DEDGrsQhsrBsd2xFOI6oiUq+4lLrjiruzkBwd1/F7yvHPbXSg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790536139;
	bh=MtOEWvCCpZuS7Li0yMgyapMkwuAtkXtuYNyArIaSqsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UyVAII0w71lwOCUPdnKJN8tv/vEbxDkp0sXWtK4nNbJ0A5Ytnts7D6Fr2DfwTGJZT
	 MjM8JodUA5SaId358rg+X0P2Vxloe1RdI5cAE62DnSL3yazFw5GniIW3MC+5YwYCj/
	 ajZkgqh7h3JHl051X0rHNsnBTi3/bnwHJ9eVuebA+GHf36hmhMb6KCHCFgUJe2dzGP
	 B89sjmvZCz1kjxhLB6IiymqRDNtcKBXSZAErLRJAxFfD4UqiymCB854xKDRlTiB/ag
	 TkOBLJsMz8HELqDxQPoy+PSKTNDteRs1wp1VOJ3ITmdskIhdFscJhpYuQwaMjySwWP
	 ijCi+rvwbkUZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 763DE6060E;
	Sun, 27 Sep 2026 19:08:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 82B76194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68F08400C8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6L5gcv-TOid for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 19:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 985B740050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790536134;
 b=kd2TYrPv57Zm0Fh6mNipXBwTVvm9rmLjq0b986Ql8lX4TXSrBHL3dkIQTLkXVIL81cQ8
 yeMTE8LPuRbOkl2XqipyW0N8TIZbYO3vjriij7tblP1JIxhhYVp4uNdqSDJGUR/OXB/iL
 x/k/M+z3ATwk4uq0ks4ScwT9c5rRUn8DrLW5iAumkFzFAMCq1DKM+8Lx2F7Yhhf2rjEKP
 3JC8UCgGhN9+cmkoU1obSirxeGicTQaVs2u3kj4DaGyrdn/DMD/uUhIilYKzE1uH/jL9M
 XpcNpy3xCPywZvMrTvSjypvyT+oLR8llNzV+TFepLl3MBIU5mrP221PrsbujjEqaFSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790536134;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=MtOEWvCCpZuS7Li0yMgyapMkwuAtkXtuYNyArIaSqsM=;
 b=ONvDAF1QxICxBIAH/vMvesXzsDAdwx/+7+xvXVvNxgkjeBjqEqseXCnVSz9mi7nly9ZK
 XnWyfKvSVMyiqPcamHD39YYdp3L/1TjNnZDtk/7UQ5Leigd7TdMu85+Wd4bzc7/D0Tt3y
 j0D1kgk1V8jEyitQn5lWWz1X08VppYNp0wceVMvhsrK/L6O8+PLe8nzXVW731As2N39UL
 DPcyiDB9FpLUOtE8uXJtWxnzI/bNM2iyOZlP2P3EftdODK4SskvuPkoXa8yqND49/Uafb
 nlcvOYPiIYjhYd8FqegVhBFJVqm8fXqgfYI/ZxPbN+jvg9qbho40ohrCoIqWS8h2YTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=B0o+LRT5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=B0o+LRT5
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 985B740050
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:54 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-81b3cea0cddso277082a34.1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790536133; x=1791140933;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MtOEWvCCpZuS7Li0yMgyapMkwuAtkXtuYNyArIaSqsM=;
 b=B0o+LRT51jeaUSYs8WG69DBuXVJLmR+YoKOmwAc7zDz0izk71Mn91/iiJG6MVoK8nw
 mIUFRtMKJg91teQRnO3DDV1w1+wwTdtItJQub34eXTW4rMmVPx0xCBDMCZu931Bpqf6/
 B/7+9fIko0zwPs0dp3cDDvMnnfA1Gfpjma0Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790536133; x=1791140933;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MtOEWvCCpZuS7Li0yMgyapMkwuAtkXtuYNyArIaSqsM=;
 b=r9+oxLy9JtIWAi7uUtk/yCTaxuNMw78GtPhSJ99jjIDnRs5WNbQpjnJre6IR+Os9Qn
 6Qe/ZCpoz4zOAcFZQoPtXp/VAqvtuKhuZcMrBP9OwT3G4RWAvInNzqCpRb6GaxEUE3rf
 4BGTu5HFy5PZRws4MkUbYY3LDeXtnKr61xh1zoL2sFSxkh5xaxLabE47Nc3nKnsc9E/O
 9qWGJMu6aYwcVysAFGqXfrkmj8quRyjkNydyhT2nbVsc53W/BWuCf0a1gzX2Hc0rc8Nd
 jpWwIssQG6EFJG5qSdohtjV+oh6EYUrNM+YgtgHc9xzEJRbAjVN3FjE8c5Ut/dbJk3tj
 BU3g==
X-Gm-Message-State: AFuF++mi4NB/oWr9Dq15J9kNBfGFHN8fqTzCDa6nvBb1LjbiEJU9jtim
 3RK+XJaI0WAnRnRtIAoFgw4Aj3veN4Xm6EdQF4W4Ai40S3NxKchQbny9e5vcO7QaFPUAYJdACY9
 SKb8z4hVUSwm2tw8=
X-Gm-Gg: AYBFou2i3M9tuDP8h0Amz8a1eBd/kKKz2nCO4HWFcuP9k/npJS07ZrNoIAe52/dKqs8
 KaXgNBrjefBXgxab9Mc5xXSVf5v/K6yTgv2SDfcHqUnql39ZBSsMS9K3DOIWPCsifuyTj7X3p8n
 11jnDhnyK7DP9745H1bebF5K0suogwO6lQj0s3w7xXSbTwdRR/Ok5MrkB0MV2BCxqTB+HlrBtrx
 ogbCludKYUL2I1aN0Dh7YRNNbtD9zMOUMUYgkUfMWS6ININhLiQkIPDTaZKPLJ2+gNwR5zUnyVk
 wJGeQqJe9u6jae//ze7pj0Sgj9WEJk+7hKVf98c358AA+EnN2JjdtTH8iD5zXYARMGQ7n5ejW4T
 M7LU81q1bqoglSWIy5lkMZ9V68Lmku594/4JHpZnDBxol4SuXzp79pxwlWdMZmj4CHH4blDmi+Y
 9u+ZcmcLDKoIE2o6cGieQUEaj3zNg63IQuUADjZIjgppIqME0GELBtP19HM7IAlQogvUGf8GEyF
 Itjt0QKBe0NpceuJKpPCMwHnFhvzXtbBoPkTWGNbSfTIMuGFBRUDQ21f6EduGh0dFXzAoCxrDrc
 +gEsG0jvDffcI36DMg==
X-Received: by 2002:a05:6808:14cf:b0:4d6:92b3:5c82 with SMTP id
 5614622812f47-4dc69d1b360mr7694850b6e.63.1790536133540; 
 Sun, 27 Sep 2026 12:08:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4dbf849c0b0sm7300032b6e.11.2026.09.27.12.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 12:08:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, primoz.fiser@norik.com, 
 siddharth.menon@machinesoul.in, Tom.Hsieh@advantech.com, ye.li@nxp.com
In-Reply-To: <20260926214640.34726-1-festevam@gmail.com>
References: <20260926214640.34726-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260926
Message-Id: <179053613243.2206597.7127951976571789424.b4-ty@konsulko.com>
Date: Sun, 27 Sep 2026 13:08:52 -0600
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

On Sat, 26 Sep 2026 18:46:39 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 9e002445cd0d47d3965312f12e97a18e1ed8bd53:
> 
>   Merge tag 'u-boot-stm32-20260922' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-22 08:59:41 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


