Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28640CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D588F4052A;
	Tue, 13 Oct 2026 08:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gue8DHTGMJTW; Tue, 13 Oct 2026 08:02:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35E0240536
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878556;
	b=dmsM6a/EodDD4bBKbztwOs4WAo1H4m+4GnZIaojUTj48+2HCNpveeLRuA53gYWFgGlr6
	 DhQnT3lk5XmC74QWNxnEaa0Qiqli7kQh/Lx1an8v7Wd72SJj8bj+Z3g8srO4FdAKfU6J7
	 pwKnv7NTo7R9/gSl91huafLezwwO0NRK+FOIhSaulblXh+2hrFR990qp+Htp4UAUbEyMx
	 Ng8YMFxmRg8nezFY25pF7ufKo4bZwEF8ey9BUK03gg1Vr7XPnq65yrvW9eDUiGBtf12vM
	 3QlUmh4PSX32EYWli9SwtJ33JTfK8cctn0LUUrt+9rBOTQB45NYU8YgIvgNXjqkrS8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B+zMqiHEKScMSuxSQnpTLKUoQJXaqoi41+YI7tEUwmk=;
	b=IrABJasfPgs4jauH7/9F3vb53VoDllN13X6gn8Qg7ztNdl1usl3gig6Akhg8Xa6RHCR2
	 4cRAvDDWIO6q4WhtdJN0a+iuPSQbkY1pA9EW7R4HVBsGm2Djpa3QB1rLOWgU46K9Vtss6
	 FSfqPdhY1o4TvwMepEcgk++vMCLrx/9ipF19DGLGhTxUn6+hjFRoQyIRsuHgY38clPhoX
	 jbLxDjgY+RFi8U+gMgaphPEacor2onVZooTXGiqZ2rJVmDXcOMgpIJaB2+p1Z17S6hem/
	 a0dP1zl0GxmLB6fmEpOOlM5jR365JcRESxqXNYxTAZhDZXqTOo6ckJg3gri5WplKQmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878556;
	bh=B+zMqiHEKScMSuxSQnpTLKUoQJXaqoi41+YI7tEUwmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mf072i2++k90sspp1UKp6npZ11Ys56TMjy2csxXYwRUPC+xuWBqPcRnQ+qHMWgFi0
	 7O0zWaamZBWyVduD3uoaA21T2qsrMKaf1wcEY3a/lU82uLcgg3dr1KytPdCWtX+ma1
	 S+p7CBkBS/8xOjwgrgSikfQsySGlM1kMl32QRiumDJflXuNlIx8eUZYYAIUSVloiGh
	 3OOv8HfKzv3fDY2SAbnl8iBtoib8IXi/rGY34bwkI9JyrChnvussxso69FwgvJVFBp
	 nBvXf8ylCAZZvX64Sr+q2zBTIjmthEgsgeoAnINOxF/adm1rK9noLyZJsb2uoFC4OB
	 08nzkGM0dx4rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35E0240536;
	Tue, 13 Oct 2026 08:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86B181E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7866840068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63VJcKdknSyi for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DB8AA4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878555;
 b=IXdG3vNF+/obS2TsIPGnfdiyGBydQLzXB4QnzSHT0ZYJeJ25MFvKQjJbi71yXdfoqIAq
 lLR9zfe5o/8VKREoLwDomeh79JGaV54R3nGFnQrGnud1Zz++LSfbqji+ib4ikTOBHBbiK
 OFGbTgpnBnN9AJznYowlh9Nta1pTv24UAMcTpvNqKbwPUXyXD64aByRL4eVnhtnH44Y9N
 zM0E+upkAYUTF/22vVZFLXQWa68VtH/9CnMem7nfv+P5ZHU4sKSmVtQ7IAHK2kyTKLzM6
 xteSYx1HywtfMxky7ZyNToDa1Mtt/4StUqxEcafSjDtujG706VFS2DmBv4Snhnhh0zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878555;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=B+zMqiHEKScMSuxSQnpTLKUoQJXaqoi41+YI7tEUwmk=;
 b=i8RKHAE+nqNNa+1zihoWOgz6E0r5BWVEIZoee5d3eM/d3msLm88oWBOygQSyndSjYoT7
 8YILQjSVLkigvgYwL0embBFLbgJyhVT+5XH9uHV7Ak71viZsRqKZEek33DfhRF1p+nw+g
 Qg3V6uGgKN/fXGKjIo6rGXpbh+c019b4H5akscWfpDRPM9477atZOuetPVXUR4XDky3NM
 FoWNu0AHNouYVvtBvs0ZG08y9QD9CBSgrcclT0GQ3dLY8hIVYf+SCSriZYa7CXcuK/Yq7
 f2ARlSNsVyJc14vjxB5miY2NUUzsyH3QHSxcRk7WvSczd35JIBfEQbVAtI636luMZWA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bJtYDU6Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bJtYDU6Q
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB8AA4005F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:34 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cd5d2dafeccso949098a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878554; x=1792483354;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B+zMqiHEKScMSuxSQnpTLKUoQJXaqoi41+YI7tEUwmk=;
 b=bJtYDU6QcSrWjiVGZ/M9pwQQw+gWYCeYUyOtyshdgGq1Q/TA26lOZyohY6S9YbDt1V
 QyCN6PWlGOGdxWbAEvH2nSRsNVBLxCjLxaReXbUh4POmCVjixHapnIBeVBFPdNI4n1iH
 OMgCishjh6eCoXqA4QdrRYJGqpHcedh/EEO6EqvbFhCc+sbKi/T5A9ucp5+6kyetmaQw
 qwnZmPeJQcdh593Krro8LCJpeLfgRNjJ1uZlUc0pApVFsa1JTQQ02W1v6SIO/98AaAVZ
 LysvOxycnD5aWiZrjsMrJGyOY+ju0nQuWW6Pmu6L3mDviQFtrTMwaPc5kfYWHcC2kouF
 29Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878554; x=1792483354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B+zMqiHEKScMSuxSQnpTLKUoQJXaqoi41+YI7tEUwmk=;
 b=ymHQNAqVThB0/JOn6tqnMr38B5Bfty0TFB8V00X2OWJavcLCwxEQNEWI2g9fh4KQus
 4V85iomtC+12YBXZa3KCJ0N8WGMNb5j1h1FCfqlIAXopm+r4y1+Wx5qpcpqyzthbIatV
 jJ9nVtF3YBeMAFbOK2rGNSOY0h02hpauZDG1IF/A7iYnFKoHHDcDiP7AKdm/P5dn/HqH
 MHmDWyhBYbeWyxF61zBDg1rLCeZxJNpbZcIkyUI+jLP6D19KCYpYKnvl6RrxB2JTZ3we
 EGfjXk8JGdJeriih9BwZy4FcftjkpX7JLqc6NSLIoFlg0bQoG7LQjXWMSgMAlnt47Qc/
 OKhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+9/XTZD6UJLjU84vG1bBprOdthWK5gr36HzjcsVUgKgxauS6GbcC3v1JOIbGOC7oE2CTixDQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIDfhaSVX77v16WBxtKUw5YNGZdT8zmNEW3h0dhFLG0OsUR2o0Q
 JE97aIO0AYzTtdrjY3ZPSK4E3QNzl/xji8/T8KiPwKbdxyw1ZE/5Je/+
X-Gm-Gg: AYBFou0YVLNeqkNaErtJKjJHKaYJvNVOAI/OKb4ksq0OUFK34DAI4xMt9+Cf9mKVWrt
 SQLouhmjW/79IUXpbofBdAwZaQZWUi2DW4qn8liW3FzSPdKkUb1Rfh2PP+yYJRW5mmLeVxpmlNa
 AEkgiF8hLyqrlDhyll6m/EAQ6FHk1lGsUooQAD2ARUvavg50FRp4c86sM0v+DqvHolg7uEVN0Rh
 uZDIR6lAHiZpaAN/0aX7idvzRTpysiPmK5DJG4x1Eo81DO/cE+08xdoOGoMRXRGLEmxsLT/jQh5
 2qSuSwLnju6gOhgBzPE6vxMJMrR3CS6GhB/0ywsTkvPDX3/a/CXOTwcI7lfksq204yaFPfgoFu+
 /pb7jgop0fqpkYSiWYosVQEGRurnexz28DJKJG0HEztVy1biIrAVKir8spUHfb2uYPRTAf5RacZ
 byjXMXAq6uVczUxuZY4f6t6XXDo3vVpb5Q++Mevlkf5rAPnMJh4szJ2ycgenGQqGSyUUzGhzj0h
 PUzjpKgxQ==
X-Received: by 2002:a17:90a:ec87:b0:3ac:5ca:c7a8 with SMTP id
 98e67ed59e1d1-3ac05cac819mr3162517a91.60.1791878553660; 
 Tue, 13 Oct 2026 01:02:33 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:33 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v3 1/6] board: nuvoton: arbel: fix incorrect ram size
Date: Tue, 13 Oct 2026 16:01:49 +0800
Message-Id: <20261013080154.1942483-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix incorrect ram size of 4GB dram with ECC enabled.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 68d516c7db8..17728f8435a 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -78,16 +78,21 @@ int dram_init_banksize(void)
 		gd->dram[1].start = DRAM_4GB_SIZE;
 		gd->dram[1].size = DRAM_2GB_SIZE -
 			(DRAM_4GB_SIZE - DRAM_4GB_ECC_SIZE);
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	case DRAM_4GB_SIZE:
 		gd->dram[0].size = DRAM_2GB_SIZE;
 		gd->dram[1].start = DRAM_4GB_SIZE;
 		gd->dram[1].size = DRAM_2GB_SIZE;
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	default:
 		gd->dram[0].size = DRAM_1GB_SIZE;
 		gd->dram[1].start = 0;
 		gd->dram[1].size = 0;
+		gd->ram_size = DRAM_1GB_SIZE;
 		break;
 	}
 
-- 
2.34.1

