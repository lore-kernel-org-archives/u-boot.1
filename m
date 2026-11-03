Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC530606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vfIM0QlP;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Xrzqgfkg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E18C7606E1;
	Tue,  3 Nov 2026 21:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMYHJ5mYj-cs; Tue,  3 Nov 2026 21:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBEBD606FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741211;
	b=dQrIqu6+ZwUYNqTgDjsX/dyhhhcDWtk+RuYKZj3SWhp8jSppXlsRu6MVT7RBNZ8+Fyib
	 pVshKBEcr9MmE1T1USMGtF5DKUgMEc1DFfK1WZd2xIyWuEuOQW1cuITkmyaeN651m1JKR
	 jlByf4u6PJJXrhQzZPsEEuOvjFI5btWRQeM0c7bEXLChaK2s4T5mH9ah/fPTJhHI4ny+7
	 69zj6k/sx7XBDkq/QJp86gAAiPnJcOB4cx2SN3xFg6TWbuaQto+S+upzLE6lgMjwvMC9w
	 jBq1O7EQA8PRSfrJJoIK/aAmFRV6IS4yC7Pk3eqCzTcz8QX5a08J0VWrnUDwxfew/fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tdZpCs4p/SMAnjPKx0edKDQumgM9XA+zaw5DQkw+Abs=;
	b=Iu3/cV2x9RIVyan0rQorXiQgX6Nxue3J21ELhLqwpoU/MCutys3Oc0rHEmaWAnzW12/b
	 Ebulq+/Hrf/PWqbMxMppMvGAXKvZUm59TEiUwn8X9ht8rKnkKzkR+9hgNExcYlxVGb4So
	 bHogBaPO9kgWSZJRKR6x/3gzME9YcuMTMG5JBsRaiXBQ1+rqepVF9ejIhV/LmTpRFlvtQ
	 gh5wbclZeOS1yRnjnBL7GgJRTokUhpYU+0JNWd8Vnhi5pzG4SFdpq2h8/UQ/3gAS/T4Ai
	 VqhzQRSNvxtsV1k1pjX9WTwg6DI6UkhPCVUKpSnrSEf9kOGWYEI3oyK1FVDUUa94Qng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Xrzqgfkg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741211;
	bh=tdZpCs4p/SMAnjPKx0edKDQumgM9XA+zaw5DQkw+Abs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vfIM0QlPUO95mSceh7iHOFhFpVwfgkkt6eRoNfcs8DpCeCulf5cj/W0CYl0J8mx10
	 U3W/H3rpQT87AmzHIpu0fjUyL5o/60b8N/2+Hb/ezB5OQf+IcY3Hlk0sEDI3sQ+DIs
	 iPgdMDPLILoLx3AOekShrS0v9ytfMUn+/OYShXPjmKzWw3J7+pI1RclLXvC2HybVzs
	 dL7UxsDviHTkQFc3V5y3KLZmJRn9f4GeenNTQ+Q3c1U5DwUhz2RfK2NaLCL9qKi9uV
	 A+zDUxQbXjnRi9WHL71WIVNOnk/kkSOmle76xM2hiBgkb9ntUNtGMHDCcMdPI2M6j9
	 Dslg1crIe0i/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBEBD606FA;
	Tue,  3 Nov 2026 21:26:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 222042B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F32D60697
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iX6vAt89pj2M for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6479860686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741203;
 b=UwA4mNB2NZqi7NLo/V+2PAf/mv4lq43/zPMC1vVelp5X3wpTQigvhD1UpEV9MOpxfLbI
 wj5A2wPzk3kVwLIk1/CKP9ItWw3tD28NA6PA9YRsXhJWtuoOfmIbHbIe1A0I/8o3ffkvI
 nyX7wxVfoa8xLz5kZeZbZfngKJRC57lbCq6Bwl/1nvYFniwDPsfjKGtBnT2427vgxPQCa
 QUcGyassGxVCIeP+fZpuAazRQlB7KtqPMjr68OEYG2jMJjHkUx+wNqBcPXusiwIZT//cA
 jNjUJ8ob/isOBnt5nLlLG28IhuhOQsGR516RDTHU7VpVXBvGiEQmqGMPS+5Gl1NWc1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=tdZpCs4p/SMAnjPKx0edKDQumgM9XA+zaw5DQkw+Abs=;
 b=fC5aGwg3kZBn0GKSqv5gzvYlEESIe80kGcP+4R17jvmCeFijs+GhAyrlWEiaF9fAawFz
 QK9PqjJEXrOrlqCqM31GRMGWaobu1zb1pBvb+BiN10a+/dvncGVJ7myISBbwDHuRsWyus
 e7zZ/jcBZ1YjXJJ9JYSGGTvJoIpoy8mSbhHyBfznQd21kbcrjU7MHVRiIlqiMWgArqsLi
 RutjG7yoiAjDj45slK3GR6hoSU+QONbw0i1U6+qh6dlP05/YQsNkEHD661Y1V90V+6lg4
 d9GJhelYtUBiy5HiaZkOgVtBO11vD4aa+tqdUM3vW6aEWyYvyYMgojPO94y67c60m6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Xrzqgfkg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Xrzqgfkg
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6479860686
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-825b40f8a26so16448a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741202; x=1794346002;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdZpCs4p/SMAnjPKx0edKDQumgM9XA+zaw5DQkw+Abs=;
 b=Xrzqgfkg+XOlW1P0nbqke/xnYcSLz5Z4gIxxFTFKanLAvNFmOlCRjCtX+thH2gr9Xj
 mE2F8mA+zbwwWodOtHIE3zwyAFvK5S1ItR2mE1lgRvoRzFgpk4rugo5RexEUIJcK5FEk
 oZjCTN8DUGw5zwr4Hlf6JvjO/HxpTAHylhEtlH+Ht3X7N+BHowN+zKDCkBSJwU9Ts8jH
 dAma4k+Qgq0R6+yIC9hohwxPjyKo3NBgoNWduTwHkxh3pf6R43ebLjRwV/rmyUBSfgyV
 K30YaIAy8mVF4ijXA1cqHG7M5Tyr/zqMZsA59cEuPWymO5hjf200zyQkfRFxNVqw2F3P
 RrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741202; x=1794346002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tdZpCs4p/SMAnjPKx0edKDQumgM9XA+zaw5DQkw+Abs=;
 b=CwZi53Mrs/U8KjHvCxq/4CngkP3ix9AGo0ktC58gvGynh1028B6St4vHXziMGr2u4o
 iIb+Pe0PyoTRR/aVNY3NKTJOSbAkgR+GNwABZquHy2a+hCGPtrdaEI24xn8f+6yggDiq
 cDabgBYEcM9oMGYwFbF4ep3yW0rf/dM0xztIkmnE9o9SDXlAX8fLK6ErWrRfSTNiX2jW
 LXeaiWZfa0aNMHRUs+md1sQAVDjVej9mnbMg6uIRjZ0t7hCSIU+OtAnZ5GpTnoHoO3Cb
 fp8LIhygexXHBy93ZDwwfRKP4TJMgUbnRcKk3T8hg2vQLlQad/+MLvhlyKvtRhfultaP
 QAKA==
X-Gm-Message-State: APuU4Z/BsUmhlTvAWo/HHXUhnqcT47wQ4IeW8/1+CXH7QYbb2AOvWtuE
 tT1jjad2GfkzWbxI2nv+/IhqKxaAsTsn7lbmtXtrGAGr8slhKiI5IBJEIIJxZ1GDw5UGV4M5hEN
 A+yLjW4o=
X-Gm-Gg: AYBFou15F8xtoYbSzsUxs+D5feugJsvIbWQNqHNacgUyLGF9tkj1/OCN3nZJmcWf48v
 b1zUiMABmgpPJScbp+/fuVQ6nmw3Z+uV2tSnUp70HYdRD8gZVuzVpor/PEf2LGdmqm4vHd5Xyhj
 cT027B/1e5Mxa4EYu5Wj2C5cGE4Bf8dG8/XuwMEx8d7KNqNyr4uKJQ9RmsD7yJNyXR+J9cqWe9R
 Ov/DvjwKHosMJI0pDUGSwlUEjVp9Dbqbjrb870wBhpHsjWKx1dtNgeHwSxEUgqvrQyNAfCvC0GF
 0ZqcZmCtR3TsnJQ858JLG0M1b00zYT+apCFz2oBHxM756pNedkvu3Rs2AW+rYttvg4Z4aF7KPmg
 NDH5qehTDCNvRMZLbt307gxUdU1B4KTzSHTUrOqNNulGMCEo4X5jsM7Z0CsVNAoi3gTKDgf3UJb
 jjOQr3uaD7mTXmvCStk5suwtWFuah0zLZO7001kRVpOvNJ/v6bR5U81eGUT4gW37c4uUTRfjRQm
 ZxQc5I71SIexMMA/Zyu//QGJu4hoHZWELlExhN16x3ujEfnSL7pcm0X3RYBhJ3oj7yLOmvOdckQ
 BTJrHKDBDLYi9TY96cQ3B4kAcog3nojc
X-Received: by 2002:a05:6830:4120:b0:81e:abb6:749f with SMTP id
 46e09a7af769-85d3651d3b2mr10657994a34.8.1793741202032; 
 Tue, 03 Nov 2026 13:26:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3de203dsm289371a34.6.2026.11.03.13.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:26:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Nov 2026 15:26:02 -0600
Subject: [PATCH 3/4] spl: optionally pass the bloblist to the next phase in
 registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-spl-bloblist-pass-regs-v1-3-bbbbb7e65fdd@baylibre.com>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=yP0MpUnAhrFLmDzdcrn3fVQtIw7WVcKDeM85Am0YcDw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq6lGAkWdzHShIg02KvE6TZG5aVdhrG/hLclRPl
 xZwxMOThUCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaupRgBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AS64IAJxezHqXjrUIf6HUpV3Ce3taaISyEHRrki9U5eg
 vL07wVmbJ2BY1NzyYD0WSkbxduPOPXR+5/1wAg/eL2FXm3ULTSTVi6QEoUOhcOtxLt9Qd4UmLTm
 RrzHPoHrMzlZPu4NtuCibf3XXHAoasH6Ta8YkPRD3k8e/J0ZQ/07k5RuXb3gmxmd0BszOSeeG6g
 MlE/3aGPE8AaqwtoOM9TumEAvWweonrBocjrJPYsKd+o8SfPuumoSq0K1K8HMUq6P5LJ1IgkHHM
 RaIbhKblaneyYaSszURs/Gx85x+n6v3aViUHx2R0NSeEExeGXEU2fUpLYz/gcEH9Rcu9lFDwmhk
 9Ecw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SPL_BLOBLIST_PASS_REGS to make the default jump_to_image() pass the
bloblist to the next phase in registers, with the register conventions
of the Firmware Handoff spec. Without it, or if there is no bloblist to
pass, the next phase is started without arguments as before.

U-Boot proper already looks for a bloblist in its boot registers, but
SPL never puts one there, so the only way to hand the SPL bloblist on is
a fixed address in memory that every phase has to agree on. Memory at a
fixed address can also still hold a bloblist from an earlier boot, for
example after a warm reset. Passing it in registers ties it to the
current boot.

Architectures and boards that provide their own jump_to_image() are not
changed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/Kconfig   | 11 +++++++++++
 common/spl/spl.c | 19 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 92bf31f038b..02eecdb5c98 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1234,6 +1234,17 @@ config SPL_BLOBLIST_ALLOC
 
 endchoice
 
+config SPL_BLOBLIST_PASS_REGS
+	bool "Pass the bloblist to the next phase in registers"
+	depends on ARM
+	help
+	  Pass the bloblist to the next phase, normally U-Boot proper, in
+	  registers with the register conventions of the Firmware Handoff
+	  specification. The next phase then finds the bloblist without relying
+	  on a fixed address in memory.
+
+	  This only affects the default jump_to_image() implementation.
+
 endif # SPL_BLOBLIST
 
 if TPL_BLOBLIST
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..3b8df68eabc 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -401,12 +401,29 @@ int spl_load(struct spl_image_info *spl_image,
 
 __weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
+	typedef void __noreturn (*image_entry_args_t)(ulong, ulong, ulong, ulong);
 	typedef void __noreturn (*image_entry_noargs_t)(void);
 
+	debug("image entry point: 0x%lx\n", spl_image->entry_point);
+
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASS_REGS)) {
+		ulong args[4];
+		int ret;
+
+		ret = xferlist_to_boot_arg(args);
+		if (!ret) {
+			image_entry_args_t image_entry_args =
+				(image_entry_args_t)spl_image->entry_point;
+
+			image_entry_args(args[0], args[1], args[2], args[3]);
+		}
+
+		printf("Warning: Failed to pass bloblist (ret=%d)\n", ret);
+	}
+
 	image_entry_noargs_t image_entry =
 		(image_entry_noargs_t)spl_image->entry_point;
 
-	debug("image entry point: 0x%lx\n", spl_image->entry_point);
 	image_entry();
 }
 

-- 
2.53.0

