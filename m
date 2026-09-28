Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C4AC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4752980AED;
	Mon, 28 Sep 2026 13:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmLn4t0UWcSo; Mon, 28 Sep 2026 13:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2633F80ECE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602940;
	b=A5fYGl7bHlMl66miWnfNM7iSjyM/nMg8fQCPoFembHKZbBEp7bEw9qCHUN2dJkLOmN3C
	 gTyyeS7CaDJUI9f7SsOJ/ha2b91YihB2tPIWangL8yGnnnMx2vryqwkHdU//4GjyM/n9d
	 ByE6370p+yZQ28xHpAUpuLjEdd9LOiBnPL2kqsRK8mR/0n/KlIqtQ1wsw9RwzUE1SZ+YD
	 +3hLRGi4cbLOUVb3mFDoIf5+If55Y0QdnPOEoY6VJwuBTDbf1tSLOsyL6ux43MF+EUfOe
	 WJWl/ufRCHKLAt+moTZByCP6jzA2Kusl561uCq+0hTuong+5TnRQyVMoiatrnUUGSSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K7S3oybsbr8/sYbiRJ4j6Xi0yz63drB3uk5QT9RTwuk=;
	b=HEAnDD9T4T3/GY/3R04ZmceNSa79jMy/sz5PHGWR5AgWwZb9UwTPd6wovurWE/mmm7m3
	 iAk76a3LhsZqhoSRIN/wPwYu3sXizqx2v8IHav0jhuvLO4+kwoutMXmpQE0sxG/VOaF4Q
	 xtxBYX9RMkxXgY1z+7yrpSSMIspfUEe3VlpzxXrnfgZKZFAl8MJ1s5smBuGXpr+0tO23m
	 YapDJAUZ+ZKyt22tbMeGC6vLJ9+4wtGXHnBuSeYCHSMPHeDGPitlsbMrhs/de7LKyUs/D
	 xhk7xinHsZkq1xxcp81cs/pCx991VxYTOfpg0kTvCKw1gXNXc/jmf5n8FcfSONMeEUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602940;
	bh=K7S3oybsbr8/sYbiRJ4j6Xi0yz63drB3uk5QT9RTwuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nxAQHKDCW88fhBnWI0Sst13uO6NFsj+4pOSfQs81I/qZ+8lv8nZ/eXePA1K8NwODF
	 DpJDFv4VO5eXmz1FOd/zsGKP30aa0ysSTK256sNMqDTj+Z78Wn3nlQshyREgCPxBMj
	 fSmb7JyvcVjjCpbt9Tbt3b+VJ9Bug0N60eAcse8Fe+Y6WKaT1H2mIzrtLibbwxl4dl
	 NHS9Nj45YDvoKty0sR65YGXeK3XXZjKoub2EQbuNnO+CEV36WZjlwoKXLGfvR5oXVn
	 JvPhWO9YRBFbRY7t5sG1Mb4HpF67AlXCFWmr/hJJvaDqn0X5QlT7bZpLBFCcmktRKW
	 mDis0wt5CRKUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2633F80ECE;
	Mon, 28 Sep 2026 13:42:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E0A7361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6040C4019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lezj_KCqvSQP for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 74C7140063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593498;
 b=d3//OwYyRKY4IbkboUThvXNqkCrruX7CVC7MQlAMKl+SqoKTR4JYLQnpmaA5CSYLt0c+
 wDXU0+L5wjnYrA2v/9hYgVV6/KCFJBnS7HntcKw5VWRPiMIN4uo5BSbK4Bzt/KACVY5ee
 7gCOKxkRXrmSoRJCgo/Gk8iobE9kze5RW+zvTXLCI1KuVmiBxZQ+qeD1pAa+ZoXa20mfh
 4C9Ve/DsDUk3FbcRRpthOSMhW64hv4ONV3kBasscAbtYHT3rTSEdpdgHOZIGo02Bwi245
 fUqVuhJywOrAvPsllzIXNgidDdwBDf5NaivqfJvLM7JnI8qPzCmmykm9jwv3QulK3pQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593498;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=K7S3oybsbr8/sYbiRJ4j6Xi0yz63drB3uk5QT9RTwuk=;
 b=rUGskO6YwsNz2CI57DsW+Wwon89/6xrWdLggvJp5qRHUnO8aDWF60LZK2eOshUJ0/J4F
 a9mOXjbHJiL1IspPppoepH/iNLEzj6nivgr/tTVBfTLbMcqGYMqHPbYR7fCuXgtoNkqj2
 UXghzNlCaFjD33y/YWjhUrrS7e47dpBWN4oQw0ul6bZDmookCt3rc7QCJLqIH5Q1h1y38
 5FJHpRrbB5cwZ0q39OEryw0Y7624Xx0nM8qolIm8G4Y9U3b3U9vOdRI2VsBvE24Orm8Pw
 RHq9RBX8IIoKKB5XMQaft5nnbHNxdfbTkc6pSJv2cLsYvHAkxdVa7m2+0pgQ5/yk4bg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j85vLMqe; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=j85vLMqe
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74C7140063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:58 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso21525635e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593496; x=1791198296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K7S3oybsbr8/sYbiRJ4j6Xi0yz63drB3uk5QT9RTwuk=;
 b=j85vLMqeiXedHs3ZdzFZLRRJTb07yopW9iasvXZFfu7Ee1yEwyD0U7ijmLfDflZ8Is
 f6bZ5p9UAQxxGkNUj/6Wf02vh2eluTFtWLn2w/3/QlkyAS9W28Pc3/lx+wVq96RZXq9T
 qtfQhMMCWalchm4BzI5wadh8/18X9XSXJf+xEuGOMHOj5BG0F29yoSa6Iw+q7M8LfSj1
 /HOwrjDb5RWnEBuIouWpJeOLglfO7IjylXgJpzexMx7G8QE2vmrVo0rcocJkBbZU/lLC
 p018yNZq8038baRtErQFa0jWibsYJ/JSFdKc8Bp4M+q1NXNWpbf/v1UH63gULbmcDQmo
 oOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593496; x=1791198296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K7S3oybsbr8/sYbiRJ4j6Xi0yz63drB3uk5QT9RTwuk=;
 b=HUoXezWtmNBY3OXs3vMQzGp3fWtHPZYZ22JMjw3YFl3TciwoTtvcpnT6QapO1LpwQ6
 nJsRBlhZmclinM67RqEXnhlSiCtzrMyABuWXGi0bndylL31JnnV9lS+cuOod9g3rspAF
 TVdhKLY9LCl089XT9lBwL7/2GAPLYmBpONMWCu5gJzSrTc6ICM+YcqZ65VOlMs5YN6V1
 jT+Ms412IKP9sS7t5LT58Dgr0SRnaBGlV6dqHhBBSsXcSYNMU7s4G4iBIpZVp1XmTCSZ
 8fyh0DYWY/8PO3TIAU5gQgSjAqiurX1JzqabUAw2vBd4WP4Rfy0vtFhzaQ7HObmDvIAZ
 YoVw==
X-Gm-Message-State: AFuF++kx0W1lZFUQ20LOZh0D+4y+mdWyo1szBJslPzr3Pqatgq1WqW8r
 ejrkf1+H7rVBJFZGRnXq0Y2Y+JWujdCLeMc+2t/42eDIdmR9Zh3R8RksvtKfNjyqPzk=
X-Gm-Gg: AYBFou0thye+1n1JPBwZ0o03TJahFMEwPXk8PSOTkEajlyJM6PrD3LY4MC8Yk0fF39b
 nl6NyklavvwJ6sF8v6w5L1PlzQCZgCx+ekCmfgUWIzuejil5C2tdzGfB43Am51+bK3z40BW7+AU
 tjA2VTx/AVXI4gqkrCqi3F5quLenm5zXkszipyZR1qiVsy4edFV3ohK+rXTlhP651uSbhHDDdjP
 /Tz5X2jDcfCyUq/rjCq/flusF8PaB8KZL1XcouLo6d0kjmnTHt1DDVZK9Mh/zky5ybnmGUZrpfc
 EcNSXgdZapORGBhv/sB78jM9XrePQlZDh9bj40OkIuPyxjB2x8fljVOt2YtqWL9uWXX/pYeVxcW
 jAugjLLV8ZWVuFdSKFFRgjPXA9QqLtykhdWq5SXu+iB4FZUvF+wh48BW+1UPyHt+IIyApL8nth3
 wjNe8eJ6CHwutOZwMsp1a9wI1qc4AZ/NVGSe/lV7b+B26jic24sHRQ9AOXLK9Is2hZKLj36OLag
 3Jn+iYV2QM+IM6gSzSeRizLSGPGBjs5HtdlRvu1VDcp+KfMrmqCuFywuMPskf6FfLxX1V3Jeq0m
 DWplBNozQK4JX/EgE9kB7lZMlixM9eRamCxMt/Ak3g==
X-Received: by 2002:a05:600c:1d99:b0:49e:6c27:d093 with SMTP id
 5b1f17b1804b1-49fe7b739f4mr209718735e9.15.1790593496189; 
 Mon, 28 Sep 2026 04:04:56 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.04.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:04:55 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 03/13] Makefile: Pass -static to the LTO link
Date: Mon, 28 Sep 2026 13:04:24 +0200
Message-ID: <20260928110434.70686-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

The LTO link runs through the compiler driver. On a toolchain
configured with --enable-default-pie, such as Debian's GCC, the driver
adds -pie, and links that are not PIE without LTO, such as the SPLs,
then get dynamic sections that the non-LTO link does not create. With
Debian's GCC 14.2 they make some ARM LTO boards exceed their SPL or
image size limits, and turris_1x_nor with CONFIG_LTO=y, which mpc85xx
allows later in this series, fails to link:

  ld: section .bootpg LMA [effff000,effff4c7] overlaps section
      .rela.dyn LMA [effe8048,efffff03]

Pass -static, which keeps the driver from adding -pie. ARM still links
U-Boot proper with -pie, which the LTO link passes to the linker as
-Wl,-pie, and u-boot.bin of the ARM LTO boards does not change.

Fixes: c1094987d1dc ("build: support building with Link Time Optimizations")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
With Debian's GCC 14.2, imx6dl_mamoj and phycore-rk3288 exceed their
SPL size limits and turris_omnia its u-boot-with-spl.kwb limit without
this patch; the cover letter has the build results.
---
 Makefile             | 2 +-
 scripts/Makefile.xpl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ca18c3b32c9..d9f53e20b9a 100644
--- a/Makefile
+++ b/Makefile
@@ -2112,7 +2112,7 @@ quiet_cmd_u-boot__ ?= LTO     $@
 			$(u-boot-keep-syms-lto)					\
 			$(LTO_LIBS_WHOLE)					\
 		-Wl,--no-whole-archive						\
-		$(LTO_LIBS_AFTER)						\
+		$(LTO_LIBS_AFTER) -static					\
 		-Wl,-Map,u-boot.map;						\
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 else
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 221ef7f29b3..69b35d6ffb6 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -527,7 +527,7 @@ quiet_cmd_u-boot-spl ?= LTO     $@
 			$(patsubst $(obj)/%,%,$(u-boot-spl-keep-syms-lto))	\
 			$(LTO_LIBS_WHOLE)					\
 		-Wl,--no-whole-archive						\
-		$(LTO_LIBS_AFTER)						\
+		$(LTO_LIBS_AFTER) -static					\
 		-Wl,-Map,$(SPL_BIN).map -o $(SPL_BIN)				\
 	)
 else
-- 
2.54.0 (Apple Git-157)

