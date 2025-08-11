Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7D3CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EFD832FE;
	Tue, 12 Aug 2025 00:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNiXkKl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6B58329F; Tue, 12 Aug 2025 00:21:02 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA71F83291
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3e53184cf4fso38552645ab.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950859; x=1755555659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+BiJWMqJrclbe52eSJMJGtxipvzmrdP0VN5PU6764vk=;
 b=uNiXkKl/51Zhmcy8b4sPpQT+Wfw3+sJ9E1DlX772m+S4X775oCZLE4XpAYtybrDFuD
 wCPv7bKciIA3F8+oTUZqr1bh2LPDdGdyWft46w5GCEzNdjqKoF6QiPrN1fG8Q1880Ua3
 Cuc91eWQbbwWQpXXGoiIhMmvmfRpD0hn7L+eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950859; x=1755555659;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BiJWMqJrclbe52eSJMJGtxipvzmrdP0VN5PU6764vk=;
 b=SvfZlGczD6hIXNrKM1bfOjYTjc955rehv1QbnUxHztqmLVV7COy2YZouTmvD7vT/X0
 OketORSBXvSWysUxnvmk9BOtZEYojuDG67IyLOKRIYCjOiY/QWYD8vu/Yxi0ZqKe5SmH
 j5tDbpY90A5IwAOChVm09A1JUHY/Szx5bASiHmn7sjhspvBe2LCXfm1iDsbEGK2SKiX9
 OizJdXpUny74t3YI5073ccvTtanhYaipMwvzos6h3N75vbIaQwnz003dztNe+yIR7xeF
 kLUmO0BDFauOgGhPXDFA7ViuwWg2b8sRLhxQmq4r7A/+mXRPDxcfhRRPkZTwZXwCArYn
 gfJA==
X-Gm-Message-State: AOJu0YyQ0HSDPwVUJqW23fDF44tSRKUJ0rK6h/QVk1VtaNAu1q57WMLK
 KsCgGdLhzNSYFUsWaDkXx5AWzyTrS9yje7XMA4eRJUtoM52kh4aJFi8ZmOXrxftUGHbok1xqJ1C
 WFsbR++o=
X-Gm-Gg: ASbGncsz+dqpkcR6QhaMXdQNc7xOHuwt4jkQB8eTe23z5MRwwiSjYEK1VNer3mwk4v7
 V2Gq6AO5lMom3AoyD0QZaL5WW+O7rBA0lyKAMEcKuaZlpXyO3f5+4Q3qeqauWuKNB21GwQaxUW8
 9tKtg5R/vwBeGiTuozUNgvWyxLQtYz2J9LLQtqydz2VIqcyhFJnDozArsQKWw/P+Mj1HFoY0Y1A
 GzYayddhLDxK9aFA8ruavbWMKOQnRFmjltqdgpxt5EjreUYK6jHPLVOJqrhRqazL4axg68Gk7l4
 1cSu7g9kwtCf3WcXF70Xek+fp/6C/JthIktNfgaljezgHHp2XdM6cbXtlJfwDuBJbLpHxPYa585
 OE7PM4ws5kpv13J6iqz7tZiYLIeH/R/eS7dnvuMoNxW2l+rJ0JmAlClc=
X-Google-Smtp-Source: AGHT+IG6fxDgzuS2iykbqXrCCRhEbz2rBZaTRuHEAH71dmqMasoBbLeLmOpijw9473wlNPnIRRwx0A==
X-Received: by 2002:a05:6e02:3c88:b0:3e5:5937:e576 with SMTP id
 e9e14a558f8ab-3e55afb9a09mr18686045ab.13.1754950859488; 
 Mon, 11 Aug 2025 15:20:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:20:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250718011548.1333999-1-trini@konsulko.com>
References: <20250718011548.1333999-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: bcm235xx: Remove this SoC
Message-Id: <175495085868.1657597.682414787909135037.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:20:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 17 Jul 2025 19:15:48 -0600, Tom Rini wrote:

> As there are no platforms for this SoC, remove the code.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: bcm235xx: Remove this SoC
      commit: 26f857f1e37ccb7dfb93d55650ce35b179ed220f
-- 
Tom


