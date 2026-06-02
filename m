Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F4ECD6E5D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 23:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3427084837;
	Wed,  3 Jun 2026 01:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KektobGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B0384867; Wed,  3 Jun 2026 01:30:55 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D9583FEC
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 01:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-486560db81cso467981b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780443052; x=1781047852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fXgpmSg60RfX2ULQOpGi8Y+zPmBDPSsj/lW2On7pWdo=;
 b=KektobGhjUpn4et8lAVlAW2YR79PuT+AU72zGEhG43I4gL2PQfGB9TPnPxSnuWqplA
 eSf1mFk8ZMdfrXrjvfs7me1UtemCwG1Yodh/bGUtRIS7HNhRntAKXZ19bYpyYvU5mn8f
 l5OrLu762cwHX0gzKRG34E2uo+kfFY9gxkB7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780443052; x=1781047852;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fXgpmSg60RfX2ULQOpGi8Y+zPmBDPSsj/lW2On7pWdo=;
 b=QYKc3ClWQsgENDdhj4FFZKeULRs4ftPhp8RdLMoNQArddPx7mFcurt7GpkGGAJcw0a
 Ga0Z39gmaxZ5pAjigusQWGOZMPo7knEIxig4j7JdfAdXNThdrM/5PMjp0I1I3QO728Si
 bDTSzGvIrOMawO23MjB0JmYQe8b9fEYhbANsf0qy9XuMSsCK3gqFvdcveqxpTvqoAsYq
 OWLEmhQ0LP05tRbToafyZCUEfCkD3wwtvgv04qB0sW3Mg+T4MkTa9ztiS+gtKImzlwSb
 HG9IY9uR0zCyGDPZon9HHaRIeGlGSgspCB7R+R462pWRECGBmVRBdUSFa+A984sxRZTR
 w2fw==
X-Gm-Message-State: AOJu0YyygA1gXBgiZwwKkclpyv7Yw1T0KMRThVK5/4EHavcwMag5TsqA
 so2l5391NNlvpUpPCiwINuvAYqbab/RZi49LOZQ0BsV+kLlZskpWoAcXlX1aVDhN0YX9iPxBhye
 cHIwtz2I=
X-Gm-Gg: Acq92OF4Z9spG/dzYNe6kqsKWUbvzZnvmd9SuDvnmk7B+1Y2Ecd7yLwCtutCIGUysLh
 rurAIRRv2xHiJ3+XNNCgEXVIa5jD9Q8Pj0Zoqze6tiYh4NB40S9j0rxxUNzhLs7Iob0hKqXAgpL
 dQf1z7mZGz2f1vjoKbqhTgVgIRsF6DQpCgB08WSKV/L3U9RvtA4UYS1llfSqs6WediB9iz4c6be
 MCfHMolIsLB08mo1/AxNzAhBVejU+UWdnEdXAhwswIkAEJQonJTr6Z6gnXmx8cyrfFDfeQ6twcp
 zAjgSzEtjNSn7Rl2/MEBJmTBcHE2Qe8myOq/ww9KD2IxhfrTt/O2Y2rAEXirEGC8tMjJoSSA9nc
 lN6XvRXw04QmTw3fEo6RDFcB2+aLJxrwZ/u3LbN003yn4bwdTqeL9Mgmsfm07NZQONLA3x/RXZn
 eh6ks5TG/TrIT0NLgItrq1sJD72zO4VfXV4rBKcf4tDfsoMJbmJqfG5tkNGMDDeNE6S/GzBqgnI
 FgvExXjrfzMvsu+YvfaxCQwz9bm+kDSFujMUQ5DLJZ823+AaxfAm3eiEqko
X-Received: by 2002:a05:6808:4491:b0:485:467f:a30a with SMTP id
 5614622812f47-4865ac24010mr664594b6e.43.1780443051932; 
 Tue, 02 Jun 2026 16:30:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b745773sm513804b6e.6.2026.06.02.16.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 16:30:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB2805F890F3079CBD868672C0DA002@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805F890F3079CBD868672C0DA002@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] timer: sp804: Fix dev_read_addr error check
Message-Id: <178044305099.1983368.13076604831081664669.b4-ty@konsulko.com>
Date: Tue, 02 Jun 2026 17:30:50 -0600
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

On Tue, 19 May 2026 11:41:54 +0200, Francois Berder wrote:

> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
> 
> 

Applied to u-boot/next, thanks!

[1/1] timer: sp804: Fix dev_read_addr error check
      commit: 9c04852e59699a1653bffad40044eb87387950a5
-- 
Tom


