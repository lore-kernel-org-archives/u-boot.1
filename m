Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C3606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HIFlMyJb;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Db+nCmui
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1641880A7B;
	Thu, 29 Oct 2026 16:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXfIxjNSkvKA; Thu, 29 Oct 2026 16:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53ABA80A83
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793289924;
	b=jfkTXiZgKyUyiB4Z/JMgMB9U35JBX25MvJGDsMBN8kgnjh+HlOygBYW9Uo91V/SAB+UO
	 nkb/C2snB8jjN/caZ0EoQ+nTYbHnNZArw7WP9FKzT+/mKjQ6dLXoY9uzhlCjusKu0wdRk
	 N478fDYIMzJmhUMwxkOBiib3N2vA5S+7v8su0NFyfbc/SjiDAsO0ycphO6UIS0BcpAxir
	 xv0u0OXoSkLBO97VgM8k09sHWr2q4TpXGRJ+iCkwDXokdNwiGNwoHy7Up+Zvi1NVdF4je
	 +QeU9t8UzFu6j5nBnQhcMzGwXdFHa3m1bNfVlsu07OAdCijj3HKi2QB/SWfko+6LcGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793289924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RvLm5Bvl+OlF/aMgZSZmEan847IxVTZEFojJR3gTKBU=;
	b=eYijz/cucR5rtx9YFhHtfezV6aMmyI9exAvyWQnVAxkNcYnUFZw4SiWlIkUEY5jSMpr5
	 ACZ3IPwKzZnpjGqTLkfFJvMl8Tq5KZ5tWKHmmFyTVw+7xeclT2zs80ziBEIkoblnXTGPu
	 6gYuE+nd8k1ohjjRMbwM5Lvw2Y7fX+puUz+XzkjuvAbit4LUxAYXTwXPErGKGzC6r0hdf
	 PtSE8TlFQEiw2183vvpMsK75mIkEI3u2bnlHlwzFdo2Wra+ORoNvhyTwM5plcr3ERierw
	 QpMA8cb1C3+dC/4aFst1Lng4fvjRDIwcDc6Nz528hVHxW1F5BJLNiR3RLHvtuLlOPDQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793289924;
	bh=RvLm5Bvl+OlF/aMgZSZmEan847IxVTZEFojJR3gTKBU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HIFlMyJbYN4LlNRSwT++ne6LGtNEzSBr5QJec10l9LPnS2/Te435sMYp5nBjcuCox
	 WMspuueobNiTN4I1QK51LZYVk2TJoN7PF7JD3k+8HWWHLzuOji3pS5lYCrlCA1YvWc
	 rMHPAEa9c7CZaEe4U/wUyQweGXWqKuosYd+1x89RwCt2Nfi871g0fsI1f1xmOfPzBD
	 es9vgjqt/Jvft8ETN4uzr57sZXT6VYV1zfTePwGrAm+hkWWE7N2Se1wI4Xg16o59LK
	 r+xAH8v1Tu1DiLf/9IsKTS31+KdiSOnUZG9L6wrKhbHyujg186T5YUhQdB2KUA4mEF
	 aziOXMmD9ePEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53ABA80A83;
	Thu, 29 Oct 2026 16:05:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3554D380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26AA040062
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oz2tB_72p_ZX for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE95E40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793289922;
 b=o1Kniwz2F5PmQhFpY/oEhaIxNMSDSKVXPTCg6JWDP2IWzfRcveiFdRyLTK28oyqpRwaM
 /8A3GZNN5ayMzMlyRPH16cgrrfvK4EoqOKzN5J7uffm4Ehm3PYO1ZlPmWMDozDIP1etZ0
 YqtfjqJFYncEgpINwIKUBBrZi2XWgm6SS8KMK/vYeoqgrblS7e1RJOA8soFNmFbdfseHv
 FsDtVDa8fwlkaDzZU+OfIbDjWVVmwWStFA/njCjnFl6n9KMzziNhs2UW1asDrH4JZsEFW
 Gn6FyqMfTNwKXtlePQv71xa0a7/GP/0aHIaDQIM3MfDlKf3gkyR+WCbZ3f3fO0yiC7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793289922;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=RvLm5Bvl+OlF/aMgZSZmEan847IxVTZEFojJR3gTKBU=;
 b=ahS7U4ysslG2sBY0YmzcMK/Q/BfpHhqsRugzu90f0VW2tRD7wEwUxWe0dUuRrmFsq0n6
 Q69QQ6QcxynnYVCcxwrq+6FteiMVlw/KRv3TQ+q3kZlhOFUDEujNO3HKNJgKr83O8t1Zl
 CBXPOMi38JNc+k8eTc8isFcs9frR+eUc6zSItL8pqICUKFiH5eZ4XkkheV8PcfVn4oIhV
 TBD8UoaZn2aV+ECi3L2P6S9CAJ+DdoYJl4MQu7BhyCL6NEtPP8+DJeqZJOugqY9jvPDqj
 gAeyrwG1Jg3HF33tYK8L3NOatf+t2id3+G8DiyOyB95RdZlVp0jaqRvHoBWOQsNu0mw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Db+nCmui; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Db+nCmui
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE95E40012
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:05:21 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so15473305e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793289919; x=1793894719;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RvLm5Bvl+OlF/aMgZSZmEan847IxVTZEFojJR3gTKBU=;
 b=Db+nCmuifLPHZ/8Q2Zj+Bixc8DZZnRC6BXIzH0VoVCbf/BLJMDBNLWFZQKvMfgv18H
 uyJVkJ1tqgXQc9Kl10v8wBkpCHZ1N07KQzYamiL8at3Mq5WDJrBihl3vl0S0+7KU/0d/
 SkeZfeUZogM2EbTD/zVlrWCfw69gyFhCbC5+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793289919; x=1793894719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RvLm5Bvl+OlF/aMgZSZmEan847IxVTZEFojJR3gTKBU=;
 b=kP6AxDos8N4YGzNJ5LiAD89S9P9vXaX1H0/K8Zzq04YbOKVRkwwzwqqBkXQez6VKcC
 CegpYfgQJdNzLutUxJfUYnLxv2uicS68guuCAeD7d63hIsvKzmTIGGEyMz8/JOjDxK01
 Z7HytHA+fBEL/Ali/F8+6ti9QM5JPyO5+/KoUybFr/Yf1Hh/3K6S4pgy7UtfptVbnoPt
 MzixWJxEKNF6d0os04eHJm47Cu83IM/vqjItWw/SmJIQWsYtyxVxnhCk8xprdE68HPrT
 1Fgj6M7AxN5pwmYBBEJj3oL9T8+kMR7hHXLHNPemC434pJCgGPTYP0NDOXt5HKKp6S5X
 5u/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6a4NCk35OXgaEEb2fWSnJ69vZzL4CWNBQErTAig5yPRUJoEZU0HJVhPHSnab3UXZfgal+/nk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI0E1D5fiSLsMPjzbotjGncsvsYggTVmauP6Y3Dj9rL2UMjvMpq
 Uy655wolq2nQjtMNqe1nrWnqskrVAtRX7F/IncTShua9e0CDiWHqkjKFQeQy8Zra4pM=
X-Gm-Gg: AYBFou2PAxGz+3qf+FsOn8ZDSiR9O8oe2VsVm3tXxykJapCccS5Eb/7GqbZl7mkdQ73
 Ed3IRDxopVZ++QmDElNWVGyXp0PUFZncHmLTdqt991nCqu7tMYQaGQqxXLjwycL78P46exZ0MVU
 mzS5k4SvKujVDOMm/g2skhoyf/bsSWUZC/4MexWYKzhSveb2ZbYL7GQtbhUcFoAFGGX6dH4wSv/
 hG9j9FhGTnNcBWFlZrb4kQPQvCyGHN2IssYRWN5Yu35SJrMbX5dKGOjro0r/gOcl+U6PKJTqGVp
 55WvN14I4V6wvbF42PRQlmipS1hDeCep2fn62+kvtdP+7KhSpn11ZRR+bvRNUtH1e/Bho/dqcBB
 AWOCT9PM5Cn75+lZ7nnoK13dQ4AkVe5pNbvl61hU60wxxSR60IesTb4I5sloi0LV74ytwgOh5Mv
 jLzbbzW6j0l7FxOuDsnWM80QsyMgRhAUzAsgSlRLMv8WBpu8Mde15ZfIUFgme1dHbv7F8WWwmS9
 u4WX4rlsEzczrykmxDRU66WpdIdMBdHFDR1vqLXkMBZPE52cSYUprmwVSdP5gqbg1vcHbyDagoO
 v9NDbPodODEnbCo0ibQqpz6CvZmnpRkK+1ausYEnymwitMgD39XMPdoqBMhaecn6upoSPB1kdOa
 uRwr5DznAZll8whTnJFLaruEoHq6TMYG2+Sm716Hb5kRBc6MsuqzwdXA+hf/2AXKAaS2T9AjNqI
 mIBI0HfhVjcsAFzf2bvJzexMXjcw==
X-Received: by 2002:a05:600c:6095:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4a9643d51aamr128478565e9.2.1793289919349; 
 Thu, 29 Oct 2026 09:05:19 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df1e543sm104692f8f.4.2026.10.29.09.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:05:18 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] ddr: imx: keep ddrmix_initialized out of .bss
Date: Thu, 29 Oct 2026 17:05:11 +0100
Message-ID: <20261029160513.666555-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ddr_init() is called from board_init_f(), before .bss is cleared, so
ddrmix_initialized may already be non-zero on the first call. The DDRMIX
cold reset is then run on a DDRMIX that has never been initialized and
the SPL hangs (with DEBUG enabled in ddr_init.c):

  DDRINFO: start DRAM init
  DDRINFO: cold reset the DDRMIX

Move ddrmix_initialized to .data, so that it is zero on the first call.

Fixes: ae03528affd3 ("ddr: imx: Recreate the power-on state before repeating ddr_init()")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/ddr/imx/imx8m/ddr_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index b2873ab439d7..154e9d887465 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -48,7 +48,7 @@
 #define CCGR_DDRMIX			CCGR_DDR1
 #endif
 
-static bool ddrmix_initialized;
+static bool ddrmix_initialized __section(".data");
 
 static unsigned int g_cdd_rr_max[4];
 static unsigned int g_cdd_rw_max[4];
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
branch: imx8m-ddrmix-initialized-data

-- 
2.43.0

