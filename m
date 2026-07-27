Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C301C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 19:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D95B40758;
	Mon, 27 Jul 2026 19:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qpty6CaFLVSB; Mon, 27 Jul 2026 19:55:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 107DD4071C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785182133;
	bh=DTPmH1NIDWXUO9xXgqAdKiWruw2Wkihj7XEVygjA0Gk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYwBnFuWT1Z4iNgosgyXuK2J48PpMca8EKDKOj4+BsdkwirzLYLlBoi0BZUw3FLQw
	 onbwHikdaZaVqCYjk2j0HMJSViusZCuxSRAL6jssYMs4YVqjNjqRKvilnYZD+dtVRj
	 NORuO3QsU6xFOWmYKQx+QiHua2u76HibYXR5kFs14KF/Udg41zbuEF5P8OnJQ1cntx
	 I28rKTD0K69s1Z9IJuXB4eI2CBTvHljXimwatAKZbhtq3/2iotM5onKs8IKAjeHQ+w
	 viBut+CgHjad+j2D+3xAxu3O0/BMVgYVV2tbGskIhREMax2+Fk+5Lxx7RMM37cSidL
	 Bl+aGikUcDBxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107DD4071C;
	Mon, 27 Jul 2026 19:55:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EFA83B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 221C84071B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CBuvpmbd0ULI for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 19:55:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8A6534074C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A6534074C
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A6534074C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:30 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-497d6c2d000so1782874b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785182129; x=1785786929;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DTPmH1NIDWXUO9xXgqAdKiWruw2Wkihj7XEVygjA0Gk=;
 b=hPfh52ghLw2OFNq0FiCQpMRpfZr27VzwjQyGfBV618oIbrazwyB82SNpV8ba6PpNFX
 QutdUDb7GURVZtfKX3kCT8FyLGlxXo+22nsKwM8vTAPqIgnAIe6m5r2sXLWL2646x6RM
 Z/DByS37h27XJmDlFZPJBfl0HAYzqahglhZdxCU60SGL1Lo6tkSs6UgvNY3dmWhamwIB
 O7FWVFvhOBE7dsC8iI6q6insUXkPJbqdERAE9AcpuRpLuJLQScmKJ2cmpPXzKo1C+5Ii
 D9uTXAnuH0y5vr8SQ6eBOftxKwkGLWvE5jUtrBpFClC6IjlCrbfdh6CIPXEnEXo3ggWT
 f3kA==
X-Gm-Message-State: AOJu0YwOV4U4tP9dqWW1ehExr7D4vZAiIe8XPOfG/GK1jlEYIcy16pFd
 pH8Xa/SO4Iu3b3TSvdi7ezuUoJQaL+kzHzYegp/k2jTocDSEUTVBnnmC0ego+cdqfeE=
X-Gm-Gg: AR+sD10sGAWTPTbZLe1SUoGNokbcf46IMAi6l5bjUvjBZQGWiIFaiwJ3STcU4JptOMm
 xJqe5184rimJmZFXIHRqhaDsWXB0W67jeIPYn7zmbEnuVE2oCPWXDpHsbinwfVmraPFhl1AhXGr
 BD3uPsc2p0VUioQbqoAkiMvooApF5RAOnVvfPHFj6yYeBlqHbIRfY1hEwRMuA2xxWrzRzASZMQz
 qOw0Uo5P/nVavW4EbsLZRLW/tMTCx5L0Y7jRD2pEebbeV7huZnC6X0Hh677Zhqx4GJTgeLT0z9b
 nwqaAcRQ+iCDlZGHSk8566EPnjmhRwuw8M2ziasng7j1tdhgBfVm8C4RvuCXJkgiOKGEyhJYW3n
 NRHmRvGvwAyC8tPHHARsWjpxYmUfFXG7xUe9V2wpSyqZp6k7O2XUtrBRhsVUSduaARqnL8LEbm1
 3U8kK0kQ5hnqqQnsQBM/tz4KkNSdMfDaVYHTgVPFoagEaSfR30RIInRjE3ALgFL9VYdvX6XfofN
 6ATOWR+GQ+IdGm9dj7O0eelsQ==
X-Received: by 2002:a05:6808:1811:b0:494:92ec:3525 with SMTP id
 5614622812f47-4ad55c447a6mr767959b6e.36.1785182129359; 
 Mon, 27 Jul 2026 12:55:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab3b21331esm9633640b6e.14.2026.07.27.12.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:55:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <sean.anderson@linux.dev>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260715165735.3207801-1-vjardin@free.fr>
References: <20260715165735.3207801-1-vjardin@free.fr>
Subject: Re: [PATCH v5 0/3] fs: regression-safe load <iface> for
 null_dev_desc_ok fstypes
Message-Id: <178518212828.4187572.938157450574042128.b4-ty@konsulko.com>
Date: Mon, 27 Jul 2026 13:55:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785182129; x=1785786929;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DTPmH1NIDWXUO9xXgqAdKiWruw2Wkihj7XEVygjA0Gk=;
 b=qoiYBJkDs/UxYSq/a1Jf0Alq+tqg5xPbUrO5kyJYSRm0dmAGkH9gmFOj10PTTQ8Npg
 k+QEw6aXt233pxRYvlsyyL7o5ZsMXbs1q2PgBkSHrVo3z5W9+fsPr9Mc9LW1sfn5E/dF
 bPsOADb74xqwzALBgIeD8b7vbZxLDd0fDk1Fc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qoiYBJkD
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

On Wed, 15 Jul 2026 18:57:14 +0200, Vincent Jardin wrote:

> 3 commits providing documentation of impacts and testing the dispatch
> for null_dev_desc_ok fstypes (semihosting, ubifs, sandbox) in the
> generic `load <iface> ...` command.
> 
> The test does not cover ubifs, I could not make it work with
> qemu. Since the code logic is there and testing with semihost
> is done, it should cover the needed cases.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] fs: dispatch null_dev_desc_ok filesystems before lookup
      commit: 5b1dac9ee2029c6aa9fe4f8554f2250b94b89da2
[2/3] doc: usage: cmd: load: null-block-device
      commit: c23eeeadfc4a2f351f056bc1d12b210a5fb9c3e9
[3/3] test: py: load: check null_dev_desc_ok dispatch
      commit: 0ccf0193a58120f7a898a4379434b481be41b9f6
-- 
Tom


