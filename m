Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A1CC6B02
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C72D66071E;
	Mon, 12 Oct 2026 19:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzFpB5F6YOah; Mon, 12 Oct 2026 19:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1F41606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832586;
	b=fkSl3RiEeiuEkMAMLnQ8On/9TNTh44P+Hg+O8nv6dKyqbXUO4oSRT7Cnb188lk//jR0x
	 CW8l6CtqgaL+qYm1pZ/MlCcCRwmdF5BQy1P/aPF3C6bg2cfFetLWsFC4zzx//dvo8dazN
	 t2nXdAFaRMsdAf1J7ZS3bYWrJWVoDaCsr9y/5wfDgiuDJK+ZxMUnpl4Rl8Iy81Akp7OzA
	 7st/rz8VHyzJG8bQj3/6jRlwdioh8iWIennEqlSgWWUTfLSPnzL4KvJsJBCsKn9ThBlUx
	 5pnZosxY/PKdSaFYKWJVZTw5yzonpQHKduR6RF8GogjABNStuEtZXzrTqWx0fE9Ax+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rfdhPoF0qZVhfzM0qiankjmI4uVW5b1VA6+zZb7yIHA=;
	b=Cpkn1q0Cco1+TPrWxsYLLcFFFNkcpRl41VMXX8aJaMbIfuz+CYLcYplFh5OGyV8S0XmN
	 OXjq4YRN8F/wZUnVW0pyqjWMLaUI+obUcos6/bzvErXgNgQ7FSSdlVEMiz04HrUigaEkd
	 DHNaStJSwjpRACn0NZyQbxXHIV8Aw22Boh+YelGjJQ/xiIdqq9npacg45W6yX8iJouo/7
	 PHNbKBBPw4doPKxDbEClBcozCpyPXPAdeLMjLe7+/xJo9Ec2AJFBL/Yma4dLlXthv9HVP
	 awZgvieXqESn9WRpfORw87dFZsLMFd4nqelvkkks4trZKmxBkTPrBdXTvuuFopvPc6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832586;
	bh=rfdhPoF0qZVhfzM0qiankjmI4uVW5b1VA6+zZb7yIHA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x8ZSKKBs80W7C7UW2HPydFyeEPR9EA4rYrm122JH+TPptestjOboLo/n0aPRjhHH5
	 CrBeGZ5mLjTytTmY2uum2lM5iRk2c/fUrEqtEZpeOGMDad8lecUfUTdngvhNanqn3n
	 FHjd9lV/H+pg0JMcCE1dXW7mzVwFh02sK0osRbcEQC2atyBKWdjVaWDXfmyYN4RnBl
	 m8IyLhCCEKyUyQEMD78QQBXd5Onqwbw7Hm0+G5PSTt5/tmgxVYiF+2jKhB3JMZkbS0
	 70BFX9joE1Oj9umBaMqgHA3ZnkELV06v6c5ujddrhs0TitkuccCZaK4Hx+d53VCA/y
	 8IXpXc3zgEYBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1F41606FD;
	Mon, 12 Oct 2026 19:16:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37A5E362
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D88F4005C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JQzqPWJK8gmS for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 324574002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832583;
 b=pSaDTSiNHoLREv2kBvTklQPXBrLctJO7dofH++KDVv+vakPxElzmAel5bqTnU5rF15zz
 CyKsX0d1Srd83qio0ktemCNX8TsImMxlkcxF/Na2ezexCYSvnel1J4g+GF4fbF5SdduXB
 8ICYar/rgDCPo9UzMy9ZI4ePiJRg0Qsn6oL3P67DbMhyf8V9bjbDQSylxHluo3iL04Lrz
 JJt/KA5EPY98NvTqragmSVBOja1x/YA9aNuf/Nj/AaUbiLkCv4+GxhPJryTJAwGpqAE2K
 C/6JgkMyY9u0BQY/t86Oi8ZO0c32W8GnebpQtKLVlWUhcFKTBlL1Pkp7IDRAf3DiVDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=rfdhPoF0qZVhfzM0qiankjmI4uVW5b1VA6+zZb7yIHA=;
 b=ISWHCEE3Y7u0UmHTAkqmtNMYx6i0sT1b/xCjDZAmc6qLw4PuesmI1QucTzv5oZHD2PMc
 1eGp0kXcINoTaGYsHzpzdeQkFh2yJGmh14UG3Q9MQWUBFK2iBF7+oqIcIteCzaOlPLW0A
 YGdbcVwXLGahftSFPWEH/tIUAZrdFptaO5zvAM+kvWevQTm605EK1YfsMEs92HqPm/C61
 SXdALR2OkRwdTlNaMQCPsptXpG7KWjeyJzAsTgzNvQSeihLYXHp0jVlRc5N9Cj6tkn2HD
 Im/4JxZuksslLBGMrdj5ZbRMHTgdygKWpmhya3+j80FxuqR11l8TFLOclQEMNn/9FxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dBqqN3Oz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dBqqN3Oz
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 324574002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:22 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fab5so933052b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791832581; x=1792437381;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rfdhPoF0qZVhfzM0qiankjmI4uVW5b1VA6+zZb7yIHA=;
 b=dBqqN3Ozy3pweQJYdW+n2GpiE3fLFl7bxkZDeAViNtzjHzygGs1ZAnOLcbgWuaGePj
 UNQjvRrrYlGlzRAnT4X/31n9ZQw2qyks/d2HgykoW3BEnQz1Gp8i8rICq8ySVnavUQgi
 tmw+lw4/aqXwbzUDgLPWFZLnvFiXskvsxI6+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791832581; x=1792437381;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rfdhPoF0qZVhfzM0qiankjmI4uVW5b1VA6+zZb7yIHA=;
 b=Tte4ePTEUIXhJDuAhIeg7356bnXe785f5BurADD2eZ0gdUNcmKTj9g8mAayRUZzSdB
 YLh1ZeTRBnwHOHmLwJ/1M5eWnV8FlLBvNsDCYUBCFGgYMYyPAwbu7nSPb/Dm//syU1Yr
 lSIpbhYvZcQkcusVLR+h7s/4PzIxBrNUhMJo9k6DTCiD2M2rxuJvu1HBhmq69We7+HdL
 HBIy6WAkBT21UWqJ5638I8C3xMub06HLQgwxkCShOr6g3J/75zDbvw/9n2oI6KJ6nLjr
 ABTfnvxOIAi4KTxox09/eGdArs+iQNT94R2NeBy5yG+vDaPwhETAmxPnaauvU9nF/I5p
 VmbA==
X-Gm-Message-State: AFq9FYK6LwGjAmnqflqr1nq7LU1vLDWYKESLu6DfeEEebcSDyZbvHYB0
 WPg0XHtWXv76usxUXIpnVq+H1Z3sJoet7RjIeiz48+7NP4Cz1XN8vAnR0PR8ZBCLkbV4P5/AHHn
 IBnUJp+xFQmokHMs=
X-Gm-Gg: AYBFou2YK3LZUYBgEq41h1WjTopRbIHVif2Y7ZGiKs/slkTsmjz9d1gFmoyQ2WBKYBZ
 keUnb8iq7LkpMBlRqjQm1DJoM33JfCEaO3KUEeRGn0U+4QAzgyPSEMgFcdzPJmVxeYCyR7HjJ6R
 3b0tES4MPWn2yNNQKL3CcMJResCRl3aCm/1x3SJhBEFDtJHGLfN1buxh793+Wj8RYiAggsCLNEa
 15+gmR6UCHuG1yrpg9XlE6gSyu3a1KvApnwg+dRTylFCNgKcgt1/miMWeqyrh8TyIdfCtFAGsDk
 zklxSWQrhdwJ9PV2TI8+1a/NdEPPkbXfeH57rCz67AQ4UBdSftv5tjT7+QpFsMSYh0ixr6x4aEd
 NGLGeDZtqLR0OEgkSpiith8MTiID2MZwVmBUi1Bb9woiSjYavbaTBNAzZTKb6oGAmH5K6RiG3RX
 ONyx81Lakd2WqFzWka62BZKCZhV7gOBIUSHUZwJCz6ptf5+bcm+VCBOzwBMSHCH2Gz2wxVr65wd
 uV23P2ZhVZd5/g4uDOq1fo4XMjlmiS1GcwhUgwAsduECTp0lsp3lPFEABp+kbwqxyxcaQq7g3T/
 M03hFpq2fYtXVSPv4hWEvyabiaQO
X-Received: by 2002:a05:6808:251a:b0:4cb:818f:d56e with SMTP id
 5614622812f47-50c4c7a2fbdmr11280538b6e.22.1791832581646; 
 Mon, 12 Oct 2026 12:16:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c167544b5sm12237824b6e.3.2026.10.12.12.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:16:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261009171404.2628469-1-trini@konsulko.com>
References: <20261009171404.2628469-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab CI: sage: Update for labgrid 26.0 behavior
Message-Id: <179183258074.3787216.6270221571694417628.b4-ty@konsulko.com>
Date: Mon, 12 Oct 2026 13:16:20 -0600
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

On Fri, 09 Oct 2026 11:14:04 -0600, Tom Rini wrote:

> This is the patching part of the u-boot-test-hooks changes done here[1].
> 
> We now have an LG_ENV file per hardware, so we need to point at that
> when talking with a given place. This file now says where the
> coordinator is, so don't set LG_COORDINATOR.
> 
> [1]: https://lore.kernel.org/r/20261009171328.2627684-1-trini@konsulko.com
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Gitlab CI: sage: Update for labgrid 26.0 behavior
      commit: fed92546960a92177d67c0b8d7b22385f50fed29
-- 
Tom


