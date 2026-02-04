Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA2EA7942
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3927983A5A;
	Wed,  4 Feb 2026 19:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m0vvWa3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FD083A8E; Wed,  4 Feb 2026 19:41:48 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA21D8063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-662f9b82a36so49791eaf.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770230505; x=1770835305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=74zJg8HmkZsL7/sxvdWIoGeclkPaJdfnSG/jk0YVE1g=;
 b=m0vvWa3qAS6bFwhK+R04wbV7icHB4q0sJkynVS7db/Mcl8c7SqUYP/sL6oBao7gUBf
 4GOzp85Dat+OjSsY+Ij3JsodEoIJQi/79uffaqf6gpuWrEezbvjbRlBIaAQVc/oH1NDW
 O6qZ7/ez9+0BM4mTdj84x3GWNC8X9gOysPWgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230505; x=1770835305;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=74zJg8HmkZsL7/sxvdWIoGeclkPaJdfnSG/jk0YVE1g=;
 b=Wn4wxo1n8AxsEBwJW7uZ0EkEmuMxag8gFHuthgFlTDqVKhVkepDOy7tmoIjrvWPs6e
 gNx7n22a+H3abqas+cFlLdxKDpWsG/MyreY/SBeiy/iTZHSHRbmuSvlbvm8uEBKfB/08
 Ql8dh53bN6xhiPxzbk2jXNDrt2jLFwmh5d8+3QeJw5dWKk6+I1JnurVIYkOVI+4Tn610
 dG2gcU9EQYfi5657U8INM5/qPCDzXVLkZOl7oAOER+fp4TnzLlIfQW70U4t9ul89OOOx
 sPJZXMPr/k+bwN/z7I98Ay+/bxu8DMZpkIjSVclzZ8GRFku7LLgAcc3wgauF8QWk+EXd
 ZyCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkTQuWW/kKMDE+lSULwHJgBiwRtitc6xTI1Bz1+hTLgO+FZY1OnYoLF9hMNZsuSxVL4RbPyTM=@lists.denx.de
X-Gm-Message-State: AOJu0YyYIT08yzksq8YPDhsLTlA00bokuzyYwk1cIJR093Ctgb5bafTq
 SfpvFwy1hG+rbvRtEGYPbjB4YxpVrpNlaladK/gKW1nht8LF2RmIVmHBhm/Orjwb4K09PoGLR9t
 /Qqk1DX4=
X-Gm-Gg: AZuq6aLUqPnRYHl1hl14/WeiXLUJlC2fJuWBHFepYPb8P9SVE1r0+dKo87iZAm3aTi0
 pVT3+vZhpOk21Nh2/HEy+VJcP2/yf47hfphqDdjjRkOymldLA9mqymr/+fTBSLdlmn5Z9MCdvrH
 oEaRELI/0GCDH86tuw5RqGKfEl6hcLmEnWTN5KXtS1nV8RVJUxW32oP6MvJpBjNljDB75wHhFPD
 EsbLwZcRTnl32tEwCpZiQVNwuimwAnqgBmHGdwpxWYhMR/67MjOF1Nc9vGNOrkFx0YP1fgy7ZTV
 IBw+Pa5eB88Ois0KfWXvEhP/ereO3kzfAKvI4EtRoO1NMktxLD5xFNv+0DqzJMbSHEzooWGDX5H
 jg1eGTkRvhdnmXmlTdUR8grLYpy/C917w8LQ/9v2MjZhX+QhaYAduDM4KlN6LJgHWMts3zpyznm
 vTaYXOgRanhwFj/CNdk4WjdeCFdbKfCyV17rbRkEvAtqiMNNSCDuuf1rwimkrBWqvNjcnlxendb
 ycecLscJL0W0N6UmzB7oC/L2o8kg+KIG5skWQ==
X-Received: by 2002:a05:6820:1621:b0:663:7a1:8930 with SMTP id
 006d021491bc7-66a23a02a8fmr1777617eaf.71.1770230504807; 
 Wed, 04 Feb 2026 10:41:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a32bb1049sm1785776eaf.2.2026.02.04.10.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 10:41:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Corneliu Doban <cdoban@broadcom.com>, 
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v3 0/3] part: fix partition searching
Message-Id: <177023050305.1801114.9341513322484894339.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 12:41:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 20 Jan 2026 01:33:02 +0300, Mikhail Kshevetskiy wrote:

> It was noted that a GPT partition with the maximum available partition
> number (ex: /dev/mmcblk128) can't be read/write from U-Boot using
> read/write commands. Futher investigation shows that the problem is
> deeper.
> 
> This set of patches fixes uncovered issues.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] disk: part: fix partition search boundaries
      commit: 0ced9ef07361980d1418eab33ee1f41274d1e0e2
[2/3] cmd: gpt: fix partition search boundaries
      commit: 6a1f8c897375d1f673699efdb3664b96f5af8c1c
[3/3] mtd: mtdpart: fix partitions searching
      commit: b06a1785b2bbe489a634e3158f82f93491a84328
-- 
Tom


