Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD2606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rmbB5opF;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Nv7pxS0u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBD1D608AF;
	Wed, 25 Nov 2026 11:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zldWaS4JL2p; Wed, 25 Nov 2026 11:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14C1F6089A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606260;
	b=bSnGkgmgkgZySt8tthnL8AYO1v8KKWtptIubyivXkycR3J4HAolUQl6+RW/aIC/Yu/YS
	 uqYnj29TDtuAqkdyG/QG0sE+CDpWvkS+kwJYnlMsYlj8gOOM6AwyGgT1cgpefXiqAYelM
	 OJS31MCEvfzoO8shjgRidcxyVKSU4/Oj7hKl/1CdQxhGWDJKFKpJkrYs3waDYWGBG5/NC
	 rT4a0yNiTuofZEDOAxaAfCMY2hdMf9PBrFa9Mu7PO7EBCDXVK6WMU3u3fPxPlxA6WhmRc
	 HFQO7WaS4NfRQ56oo3igrfq8Syt2x5oiG5gJI3VaJyMwDfvMH/JL0y5TOk00+YBG5dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8KJrD0rZ6UKIYgTyASe1DQZ8t0ErxWgZcVsJ/oSSn7U=;
	b=REwPPNOGMDQYWsP0DVOGezNSCrd2cLy7ogQzLT1v/zpjpNvMvt1oqVKVykxDr8pDRcul
	 ctEi/SF8b0SFKk9qutfeoHz5t4NaBYUNRTtS8jLSTmaxocLWXQfs21qSNKhJhZZLuLZH8
	 K82pw+LrQrrVcpPAUgeSYY8LLtgK8FqBRkaRjR+8SsS+DTMHawJG2EwUU7Q1STYsVjFHr
	 QIRymvyUR6ZSTEHXDMEo86tpY4UMyd6zmosyrxQT2pape+HzpspzzmbPP0NOaQyT4X3xs
	 sOIWcpR2oi8cOp8Xp9F02hevbXE06ZlYzhJ9k5X0ibU7GYcTYHFPARGrC04+MWokt/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606260;
	bh=8KJrD0rZ6UKIYgTyASe1DQZ8t0ErxWgZcVsJ/oSSn7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rmbB5opF+U4keKMWTyRafreHPxw+xIe39RMnB/dmWbNxdPhqdJWtUmD1Eu89H7SgH
	 ygllvOTO5ipdj0y/jiDT3JAMlwdJ1/YhLY78ZXSnPrf9QnF5eu6yD4NOYnYPazQJQq
	 e52V7S8DxBOGO5GITOSsKMeA9/4RNBqUWNjjnsitqSVxt6gcgAtUNCi65V5ByhOYNR
	 /oOZLYv9w+zLkNfTlmKqedYlcu2FNf1wyX5GdM02KK0T3xmppYzGyqU9Wy6BJlZDCY
	 NzOvvGMqAHkZvpsCKGzoJepl8zEz/rGFzTZIReD53ptxvnopuMAy2vYPQq8MdMlgVc
	 0hk3oQdsqr9dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14C1F6089A;
	Wed, 25 Nov 2026 11:31:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D411325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E620807F8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82hA6O_IFiFX for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A24180CAF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Nv7pxS0u
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A24180CAF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:52 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so3202516f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606251; x=1796211051;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8KJrD0rZ6UKIYgTyASe1DQZ8t0ErxWgZcVsJ/oSSn7U=;
 b=Nv7pxS0uCkOHlP//k/TuCmwesiHUmJziZmzW5lGXlTPHYqxvFOTy5xFrxy9BlJenA2
 RBlqGRg2jVBCjTRrMVld+e8/wRUae/wJafS7gAwaoF9ORlbfcGd/HWTn/9TV/CAA4ubP
 /JsjKjUSdJRUdccECzFrWfMlxC/0O93pC+lV1SoVXP8e97SHVXWpOjGVC539xivW0a5z
 2CHpBWtusXVMnQ/uVxex8eLlYVrm2pDvFNhCIqUj60SVmT90plV/2LHM8eRDvtK+N9Gj
 ndbfEJIuksdaQ6rLI6A7FvGr1nPRbhukeYN8eFFouUcm+8vvyfS+A6DmN0Z+I/D8rXef
 KXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606251; x=1796211051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8KJrD0rZ6UKIYgTyASe1DQZ8t0ErxWgZcVsJ/oSSn7U=;
 b=ZzCNoyGzpIFnHYoYK6+2o5E6LeBKbFFXKjRTyk0DCzfi+YZvAY7SiJPAaNl2IYI/pv
 vQx2YLlgZYFzTwWot9RSiAxeL6KaYKEcSqv9EfUhm78yOD76Qbp9aBPGyK66lr1e37bg
 T6VOYV3HliOhMfpl+GBcGjy2Eh2OPoiea7rnB6+m2YvUgVAVSD7c+Y5SnPs3Pmf8WmvO
 +SirIlm57+if2Py0rF/XWN7Is/WK3kgmVSz1aLRtC50DFXXAPN+HoqfJaWfN0Wb0liub
 FUwzlPJTo/GySC7EDazXj2q78jpUjzf8hl5qd+JIrZ4vlR+TIR9hLlb/4kfeLdZr4oVL
 t1qQ==
X-Gm-Message-State: APuU4Z8nyVRRhoLmxCnneCNLXhb3czi2fyEEnEfiXmHi5ZtFLBLqfqvE
 cCUtSdDHa/BeX9gvkKELykvHuWOPGZ0BEeXyALoEa63CSbfJDDdFftRcHgL6w/PUIUs=
X-Gm-Gg: AZFdTZfPb9nqz79fg4ZhO8AzVjwcH2LxJuEIcviibqUjrroIT0ktOqVmvTgiR60M6a8
 smmP+nsNRI0HyTYWHk+0GrvVtvHaJkgnJZUgElg/KsuVhaVgHFxh1icNemN0pH/XBwqnjS7fKVV
 rBnzS/LePJ1ilLR2aq7vsK2+5A348uKIuYe3GirBqD6FRGirvmGTslYTqv5p4Bvo3otESrX/fHD
 ll+m1qE6fniGdFI4AuX/R7l5UvPghyqlmU+u6sqL29ROAJoSIVwIZBqqt+GzUo9NJ9bTmZZKPZ5
 7INODpGNjdh7psQKqNtvUv2MzBrZ63Xv2iX5BD+rqxI8HnlmcePQXJ3/7IwiHtCcT2P+pPcXPDs
 EAnO/D/LyIV9+u8LAsPT6OOqILev+5hx+iNawAwHfSBFuz1L6IyrlKz7Qf9uwFIbAyO6Vk7ubqX
 tjU43LSVyEv/CLDo4XKPAesrHweoP4B0ln9PIll++ZwiLN6OP8+7+6xRelFGeebd0DQHrvs3iYb
 hXMko6eDMy+DTcCrBp0HiDdDGHVgIcAtGZWyKMaHoQzeZV52VXs0k74E+aeqoynvFW/Eaum+fDQ
 1ZRu1H1qcYFf+0cVbUwJoF0YkVAG/uSpFW5NjoZ71gVfMH8JxsmUCjWJxRK66z9ZmW4LrBVyXNJ
 pmmsXaKUWChq9u4d5
X-Received: by 2002:a5d:4b51:0:b0:49a:fbfd:92c4 with SMTP id
 ffacd0b85a97d-4abb3a4d650mr25682549f8f.29.1795606250897; 
 Wed, 25 Nov 2026 03:30:50 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:50 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Date: Wed, 25 Nov 2026 12:30:30 +0100
Subject: [PATCH v3 3/7] arm: dts: am4372-u-boot.dtsi: Add tick-timer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-3-7f5c72c1116b@baylibre.com>
References: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
In-Reply-To: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 "Julien Panis (TI)" <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Andrew F. Davis" <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=593;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=RpMbITgSj85jLTt+n42rSnGoT3FUGsHqwheWF/hXCtw=;
 b=bZsNQYavlPNsOX51cE+mWUhRJOt7lMVmFhbjcI9d/LpXttiKuK7LRSa9mvJ8YQNRGgzEkB1pt
 YbBCtoMSU5ZA3K20iT2zj7Fd1Kjaf3rro6+x9NwwIAzSIiqtv0wFq+m
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
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

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

Add the tick-timer for all am4372 boards.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
 arch/arm/dts/am4372-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 06e7380adf64..67a1b5ebd6e2 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -4,6 +4,10 @@
  */
 
 /{
+	chosen {
+		tick-timer = &timer2;
+	};
+
 	aliases {
 		usb0 = &usb1;
 		usb1 = &usb2;

-- 
2.43.0

