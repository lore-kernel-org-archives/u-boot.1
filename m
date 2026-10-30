Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C18606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GRgKzRgc;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nJ2qswre
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1730F81143;
	Fri, 30 Oct 2026 12:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCneLFfJvBCQ; Fri, 30 Oct 2026 12:28:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 373488111D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363335;
	b=OdNHBQch/AmBRQe+T23uUGMKVxu4pVKQfp4mkUZrMYKpX8uS5kdiHURpwYGbarcw0Yf1
	 iE9MvUiXm0h9RiQLOZckMVeG92hjK4l3QNn8M2bdP6XueYsdWzvhB3HCNy2pgEYxP1iU9
	 eJgfnkzvdahDh9zkjVa9efIVJVyuXd7iX5HBqcBP6YTrpsnQvLR9wXpfDsyM2A4VSXBrM
	 2AsKOqkDgE31OGiVVLZRJE4gd0Z/K5cc61LSF9oJ11PEoWGzFowOjMz3GNzZ0T0CxNtUH
	 sb3hTSZOAMKhrfkMDL00zUG2l1T/Cj5D2jQlGmqMBWxTUlW3RDi0f6Aw0sVPGgvfAuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
	b=iglSOLmzU0s02n3eEfMRn9TTCaX1EBaYxR/wls316baFSW7/cMN78mfJ5jck40j8VEPS
	 2EfvoJL8Tt78nix5PJ2kUbCv+PYzf/2RHDl0kTbXQJRZmAS3itVP3UjBGNO/K/HGlYDEG
	 zyw/BpFAd/m24jfpM/GMAbSikNIDHUR9kUQqReSACFY0SN0+qCqS/nkHXqyglO54CbWbX
	 RoCwzycvg9IgYAGOxo0aFLrhRFbDqNmiUebPHLIrReIaMT9uHxPjdRwF4R/QPZXOMTKa8
	 2sOawKMz/fkmeXpz3zvQKLD8akC6Jxz8Sxc3QYRzhhsSaSn6Ha99/uMdteWovje3Hog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363335;
	bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GRgKzRgcWzCP8NcxiLFKCXB+pS0NylrIgMf1lkiWrRwU3+RQTrZuqo0w2HviNlAxi
	 qXxrTnbS0chZtqV97nFtjxVg5oT6aZw0y8/rIEJ3XDcVPSNJAr2g3oJwnmBVeLRshm
	 DR/YCdGrfI+AW3Xutr6X6ya2jQ4/ddHnHRkQLQfwx5Li9Qwe11sBhm/OQB8nK5/uVY
	 WwXKEjXvCbQS4SHF268ePrEnQLVtmbmicZAFG5qQhCIloIdXR1/A5q4wCG/N42NQpf
	 qXIjuyMVT/mhiSgEThlI4trV1YoAHah60hqcFMC38Ll25eNVtwYUSrtzLOPojOcPNY
	 Xegzpew8wobwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 373488111D;
	Fri, 30 Oct 2026 12:28:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6B9E529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D8034052D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOsBzTKu6sV8 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7EA8B40243
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363331;
 b=Kq+0u4BWJAZaIgNhKoa5QmoAN8CqKiJu6SGacVaQIHG7Da7GxKPMMMSnKN0NRfQsBgTo
 IfZt0H2hg+qbMprbGJj+GGreDyDIjnfb2EmoEpFyMMBy3sOCCrZwm+cHUHyPKQM8fof7e
 EUZ8NsaTwPQ2zHUKNPfGDdcTqz42qrFYr8UzTANa2kIhV6/hNU1joAs8IHWf3GbCoccLc
 cMfV7kjOCXwnKZhoMPpvOAHKwthnF4x72EtrKbLRmlHluzcNdOAofPqKoi3/GZUjA8ZzN
 CsKdR9EKlDLiJV44q12jS4Wbi9ka5QPOKl7p9plPqI7mPll9NatGCctndKPEhds6v6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363331;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
 b=k1dPxaAwjKv7/xr3IjHlU80mp4bs/sxxCsygi0EoG+oTlgheF3mqRoarwIUtjuNhcR1J
 M4MA6/6hdZ7R9kwyzWAUL/QUeyR++ZYWt5twOjHlDJx12o/4F4SxdQBt4rq+hG2DgJ4kp
 YwnXO1D3Jz2UzBcyqdcz2hA4S7iIC5dRCXOfgbyEKqw72a0/uFUQPtEyTEGoCRIwSq44P
 5bF0U5HlUjIOGt2FQBYVywMnpq5OvlDZBsqMgFDg0910XSSXXHFMjWVMmoqwl9petIwi5
 QCo9iaIYIRp6S1I0e+OYq5FAHTBxfsZNtsFZOIn4AOruMeMrNnbIiAx9QKO88kTyjrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nJ2qswre; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nJ2qswre
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EA8B40243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:50 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so1097675a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363329; x=1793968129;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
 b=nJ2qswreGgIrLKhJAf4qDBzERJTmH51vRFjbYdLk9m3QMJVhrIssLVhTBBJK0X0GRb
 JymP8RBeAqaIuNm+VreLqIUGG+q2gpv14fn3NEFQh0MOzO5b72QxkITCrZVChGH47sNI
 3j6vz0SsXZjnweCY9EFr8hVEQ0+4SU9naEuXAHGGwSbH2to4evEXqRwEdFsf9tMWEolC
 HqCO8dZfxdn4N9NaGTjQkZoGTTz+CMs8TflxQu6IkCleKd5UHuF/qkXhu2bI7JfWWTJe
 lmAD726iEA0iSjX/pdEqqvEWZWb73mg3crRpglwfKx1M7Vnm5/rJy+ZjkM6HXxpyVU6r
 kS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363329; x=1793968129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
 b=UkTEKbgv4aFYvPvWyGUl0GJ+S4JXSsDFtQNyfq1AqcDT3GIGpwthdoS8EP8X3Gad6p
 EQAyWuikfFQpxXqCMdvk9qlbFhzAcWwGLwhSrq9cQor3p774bZCR0ADL2Myi4S24Vyx1
 tmsqSBNCWIfDMfjuISUks4dzF1Y2TATGEdhJf9H9KaekMC2j4Y/ZMiCjGPVBAeDTv3Q1
 D1XVU/Bi50QNjhQ7bA9A1/l+erUGeBUguXzxVwOjomYMoiKc7XaedrIY9tvoIYyd8vcQ
 hZwmIl0kFE8PxRYK0/HSlqlgM8OU9KBLnB1XJ5xUJOBzFVqaYOcmF8kUcxwKgvz4WFv7
 EXWg==
X-Gm-Message-State: AFq9FYJ9xW1MN8ZJak/6pD6hQHfBpZSmBp8eEp36U+YJFzYFOdNJ26ac
 EAi5ynWMoO7gmL4XgrLvhhMhFU8g5/hZCnX9J0YUyjEzWzMMD6IW4oD6pPC4ABoApVxM71L+rvp
 ryO7f
X-Gm-Gg: AYBFou0/4xduqir9tLyW4JMVfrMR5jggena+A+4S1IhQ3rikB8D2gmbqE17VlCOAGQQ
 9JB2S07wUwFutO8uMe2PLhp9lIYLu2p7J8/dGfBH5n5vHhxm6rDeRjJR68Pe48rGvlkxA7Kex5V
 YAtwFQfd2Osld1gwDkdvJ4NTb77GfRGXIpbkluUR+A0eTWDgk0bN+vo6PRGFbxAMZQsE8vqqVQl
 ZmNUL0b++X4nznbzXJTE2ApbK4khpC5NXFYlDpFxC5K3RXVcoYtnamRKpLm2G/M0K7ypS6QpMLy
 BbP0pdC62NPG0IlLRcy8TymnLwqlXxjRiBjZtnrYHULOPnjZLuUWTeDPs2h7PYWCA2V/TlrtdG3
 677F5lLG1K91we9cTh7mDaatz7CdZBA7GIg2PYklZNzFTuuQlgjYJwsLJhEv81wbkezSesppmka
 /jc38/sQT+nP87509YzDcfIWqD9X2JiRsGlrKr7ieVw3yXJQ2Sp7x7wOw62pCZWi54Tfkn24Uft
 rwBkbHchZZncVTrM6vH+/Uu5TEqzzsaKxt4vwz3g0ewhMDq8NOuwBNuhyqKQIZ1ReGfL+6zyvmO
 h3scpYRNtrBrNlXA13SgOYqI4+dlKbZkfrEuUTDwo71K5w==
X-Received: by 2002:a05:600c:83c5:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4ac17191074mr39336765e9.5.1793363318597; 
 Fri, 30 Oct 2026 05:28:38 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:38 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 30 Oct 2026 13:27:44 +0100
Subject: [PATCH v3 5/6] arm: mach-k3: am62p5: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-5-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=msp@baylibre.com;
 h=from:subject:message-id; bh=DFUd4bwuuQfTfSWzwLP2HDWtANZ0VPrKxYzwm+RPHh4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvaliFbsWzw6wK2TSNtBc+fFFoZx3bkP15WmnJb189
 sy/vzGvYyILgxgXg6WYIktnYmjaf/mdx5IXLdsMM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 Ahk6RgxcnAIw1baFDP/T39y3e3+X9d5druSq90J5gb1ik8v9k/L6znU47732LHEJI8MU++xY/1l
 ZzlxCC3a+y869/a7aRDQh4p7api371m/SXcEGAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
ctrl_mmr_unlock() before anything got probed.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig              |  1 +
 arch/arm/mach-k3/am62px/am62p5_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 405c5d4fad94..3c567f50b223 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -14,6 +14,7 @@ config SOC_K3_AM62A7
 
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_AM642
 	bool "TI's K3 based AM642 SoC Family Support"
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 599ea7cf2dd8..014f494c8e6c 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -93,6 +94,20 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+/*
+ * Called by spl_early_init() after all devices are bound, but before any of
+ * them are probed. TIFS has to finish its initialization before CTRL_MMR can
+ * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
+ */
+static int k3_spl_dm_post_init_f(void)
+{
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
+
 static __maybe_unused void enable_mcu_esm_reset(void)
 {
 	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
@@ -116,8 +131,6 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)

-- 
2.56.0

