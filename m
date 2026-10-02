Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28939CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 10:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73C9740CD5;
	Fri,  2 Oct 2026 10:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DZadlbJv5PpY; Fri,  2 Oct 2026 10:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6626440BA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790935509;
	b=MuX6cicUay2M7qI3v8Z8ohPeQn48yXhhfWe2+6T9p/fTJd+z77PcN+VauF4Zk0jxWqXH
	 tZV08J9p1n+m80Z13QnifioYDpDjzLrzg6M3ZaUeJUbS2Sw6V0yAUo6hPB9JXfyKg+g7l
	 ST38tam/z+Ym27m9u2j+SI/+El+4I+1YnTS8EHqDnQWUKs6QoaXywDpRkw1Ts/7ad/602
	 zhF6SNj32M85PSOFPey9TiM6eHHCKI83BuGGzknZV1K7A5D7/rKoy1Yic3rt0RXVCHbyj
	 S6tw9YknXH4MvLWYMfCHEpSntrwQoenBTrAp1dm+w5fQ7PWg6N1QVYx3QJc+5F8MKaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790935509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Lz2hVSd7ntbxjl/LJHq0xlThok7XiB19zrs/4QUlHro=;
	b=IatElLyY+nJH4FNWvLhbxixmz8q5P/7Ct74ybX0haIVm/7gREEt9Dji+B5tSjWwIUWSY
	 IR9KP56/i7sS+AWP4mYP25f0IoJPhj1cNffAguMRAY0tcfoGvPLuoJdrMaRWzcQXBKjZ/
	 S6Ppf9S8WDFaNS7D5I7crjOJdAx3xQGnS31v0Q1Tq3GKMD//FP/XenWT2E37nk2WwOt3a
	 4HlsJmzD7eJR74iAafiAEtsa3N8hstXbLWji2UtXtf/Dq5uLhiM4ALIvQBLRcgUsdCWwg
	 Kd3DxaVbuM9dBe0Mx3Izl9qhvDtVvsa/U72RZr9i953fLdXEJxh5713N54sJhHj3wBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=yNQ7hv9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790935509;
	bh=Lz2hVSd7ntbxjl/LJHq0xlThok7XiB19zrs/4QUlHro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=COMQ3bklccbRCojC7r4VrktPOI9EKqCQkT/uldkwt82H+zuEypBK4YsPvoV/RnkWe
	 Q8KkvBW/QGLCaoUm3pTY6ot2oIezebzwQsnn1pqYM6FajN62IS9Ipk5UQ64Xpm4oOZ
	 zeZbxb55kgs6HxDtsXyZR1D80MzL855AZ8pX0Dk4Nq1C5IWRKsrWQoPwD3D2rI0q6p
	 b4Eh40UGJhbJq2xLcNvSC/7vCWIh/QGQczk08s5nx+dg4BQUGNpD41K9mlpOzlkN57
	 MzDlZsSN+FsRVTBja35x0YyGGw9pCCJjfllQ2CJJB6hgacV1CEeIipvmlfutyTyi71
	 aQ5eG4ihVLq7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6626440BA0;
	Fri,  2 Oct 2026 10:05:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C2393AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42A3D40BA0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ij2xWpLcLli for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 10:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1EBC740ABA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790935506;
 b=QROc7l49SnB5CcUkvBvI4hCDzlD+cC+bPjYiMKMhdLREpt2u7eOvsdwC6dEUmtGVqstM
 DbRL+orNndoAIkTs+70tcaXrfLbfid2FgwF/pJKCnZUVgI0iPUiFp3BM35M7J+Izd/EJI
 epQImaBT0AKjvQI7DQNLA7zOjlWYGkdUN4jMUGiITJ4ghm7+AVeI2Myy6RMwn50oNdIK4
 EOXICgF9fayk6pos5b2T/C0juJ9L53Oz9I4U8drMHftdwIl76kiK9v+JYHRgd8uV8bfUZ
 sH4vlWrgfEZ+uesSJZ69+1XxdlWPdpYNdHC2E/zfZcgyB7SFdfxXcXqrz3MgkBGJ4Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790935506;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Lz2hVSd7ntbxjl/LJHq0xlThok7XiB19zrs/4QUlHro=;
 b=d1zq8fXwQcA5fwIyVmSRaKZFB5d/A1EJGssGFrPhHPvWvsMdLrKZHAz2vxdR+eKUYkTL
 McKr+DKULvIbYocU4w45nAXR6w2cmEel8YcCXDUKv+uRJh/fnoDjd0fvJXyazp6+M82pG
 t3TtnArtpVo+X8xxWZWWyQZ7W3OpMRsIu0unSYhWX1OYJEXi1JI0zQAEb2oUtzhWbjTp/
 y5m6Tg4BRJ2rnoQOmWbzjt+eGQseGp2LHOV/H28YMgr8g1YkSYnRl0IalM0yh9RNTl0Yb
 cuOYrPg5KCXZJaQyLOI6A8XPxsbLFV5K8U8yvQ6QvRK9UL0Hu7kdVojr3grIUDD77dg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yNQ7hv9w; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=yNQ7hv9w
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EBC740ABA
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:02 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351831so4353988f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790935501; x=1791540301;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lz2hVSd7ntbxjl/LJHq0xlThok7XiB19zrs/4QUlHro=;
 b=yNQ7hv9wWBeoJ+YRfPjDfZsMsHLhzb/ru63p1BphUJLd71EJoR0HhE7L+0z9VqEBtz
 lDJMFbpgB/ODFn8jWaCjayPzd8GGsLEe2yVIrf56RjfQ1jgFBdJNJuIIjIiMSvYR8txv
 TZOMyGIwb3TILVNLoAn9nF38EHTwAGcxt84PGDQCsfaHpLaSwf1cbKxz6+1xxV/A3xyu
 9I+W/YkGoA5Fc0Y+TQ1j/jBDX6slHGGxUjDaM+pdqlH51SnNUJQhCrvtQndsLcw5y4cD
 0Si85KYDnR7laDu53ZcsuO01GWyvEuaAUNrhi68fDTF4B+0UrO7A5vEGmzY4/gaeylOs
 EMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790935501; x=1791540301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lz2hVSd7ntbxjl/LJHq0xlThok7XiB19zrs/4QUlHro=;
 b=x3hYnRX2RsMClwiIFjVMhOyhOoJEL2wYKow3BM2cCP2yVKGp3X4jqal3g6j0YBoYv3
 QMgY6oZZENMQfmgLsef6LD3oYD5DHs7iDFkzCo23C0dXWEum/nxujWdlfu2MNg0QBSMl
 fHdYAa4MzeSYzcc90K675Uk4Y2OcULor0ecueXWZrYDN3pkWo4oYiX6hev/sfl61KxT5
 FO/pira7y6AYjIP5egbWN7oKVp4mbIHxOwmzh+yUY8OqkWHAYKvbeTFZLZN726HJPjCK
 wQ5M/zB3pDCduZTBQCDfN4eKlhKNmTdXN33Xqee0O4/3o4FHRi1OCxOa9TgriShB2UzF
 cOvA==
X-Gm-Message-State: AFuF++mY2s6+1N2zVwtuH6Z3b5DPVTTfvl7hrfUVrAJpBp+hobuhEqUO
 CfyZTpj+gLBQecOdGzTg+60W4MPFGrpAxEZLpwq2EJToIYUxUo7u+eO2Eyqr5wgKnkE=
X-Gm-Gg: AYBFou0CgNp7x8qPn9nefgk/ytVuuTt6VjCKXOkCuzCxJpGiqZmQUo7RD8nac7kUUGY
 QCSaDsqf7UaokKWNkpGHFqW8nV6LmjmGtOkJmHRq0hpm/05qmg+qjeG2DYtNTJcvxbJxbMpPjdE
 NTJI9NclU2T0DSeOAPtiW5+k7LhRCwLh0OpAi4nhqZ32E03MRWlRD7HRdFaE6bhlrvVJWwBTpjQ
 XQFU4lrJ7KtmN2QERAceNQmJ4LLhN1ET3mp1ilbwoFCNmluDz2jvbpQQSkXWzPxgK7p2Wcr1Kcw
 QpzRyVCkPij0qBmuG9rShAvkiMSsOocAatYyIXJX5ilzNT7lGPoQQelZ24CtKBi7TrvdWLMygft
 DMyYXEAuMdFaEowM+iYm/RHYbZ7TE8P9kgMuLAAimEusLMKdaU/obASFn7fdOY1cogni4YWqcHv
 SJdM4JjyS9N9EUSWuAIP4m3uRA5aeB8g+fgg6LeqdfeY7+Hsg32Qlm61M1TvXCXrW8nZTCt4DMd
 vhlSPmnv5Q6zDhP
X-Received: by 2002:a05:600c:8b6a:b0:4a0:2391:6529 with SMTP id
 5b1f17b1804b1-4a02757f1e4mr36023375e9.29.1790935500783; 
 Fri, 02 Oct 2026 03:05:00 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280ceaf0sm72887985e9.12.2026.10.02.03.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 03:04:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 02 Oct 2026 14:04:48 +0400
Subject: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
In-Reply-To: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7273; i=alchark@flipper.net;
 h=from:subject:message-id; bh=mdTzNQvwpGEbiUzzoNtqTiwhs+FWtSxNpkTNOXrdTfc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtbzxRv4+hJC3LfJbhoVN187l38/ltV6+4XO2k9ezZ/
 Yms7ZGvOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqQ48Y/vC5J5w43WTT6FPC8+qfbvif8+8fOS+QyGP85/t0qubbf7wMf+WmzTh
 YEDwpe5XaqSs/mtdJv+qLNd/3YWuni7nY9kn33dkB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everything,
because when the MMU is off any unaligned access there faults. The
compiler then has to assemble every wide unaligned load out of single
bytes: one ldr becomes eight ldrb and seven orr/lsl.

This is especially painful for decompressors which refill their buffer
in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falcon
mode Linux kernel in 1947ms built this way and 596ms without the flag,
and the SPL gets 2.3KiB smaller by cutting down on the byte-wise loads and
ORs. gzip, whose inflate walks its input a byte at a time anyway, gains
6%.

Add ASSUME_UNALIGNED_ACCESS_OK for a platform to state that the MMU is on
by the time it unpacks an image, and let the decompression libraries drop
the flag when it is set. The arch exports the flag it added rather than
lib/ naming it, so this stays correct for anything else which adds one.

No functional change anywhere until the symbol is selected.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/Kconfig                 | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/cpu/armv7/config.mk |  3 +++
 arch/arm/cpu/armv8/config.mk |  3 +++
 lib/Makefile                 |  3 +++
 lib/lzma/Makefile            |  8 ++++++++
 lib/lzo/Makefile             |  8 ++++++++
 lib/zlib/Makefile            |  8 ++++++++
 lib/zstd/Makefile            |  8 ++++++++
 8 files changed, 76 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d63afeb138e..606b9d79ecd8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -27,6 +27,41 @@ config SUPPORT_LITTLE_ENDIAN
 	bool
 	default y if !SUPPORT_BIG_ENDIAN
 
+config ASSUME_UNALIGNED_ACCESS_OK
+	bool
+	help
+	  Assume that an unaligned access cannot fault by the time U-Boot
+	  proper unpacks an image, and build the decompression libraries
+	  without the architecture's strict-alignment flag on that basis.
+
+	  Architectures whose unaligned accesses fault while the MMU is off
+	  pass such a flag to everything, which makes the compiler assemble
+	  each wide unaligned load out of single bytes. That is both slower
+	  and larger, and a decompressor refilling its bit buffer in machine
+	  words can spend up to four times as long for it.
+
+	  The assumption holds only once the MMU is on, which on most
+	  platforms has not happened by the time an image is unpacked, and
+	  nothing checks it. Select it from code which enables the MMU
+	  first, under the same condition that code tests, so that the two
+	  cannot drift apart. It has no prompt because there is no safe way
+	  to answer it by hand.
+
+	  The flag is only dropped from the decompression libraries. Every
+	  other part of U-Boot keeps it, including all of the code which runs
+	  before the MMU comes up.
+
+config SPL_ASSUME_UNALIGNED_ACCESS_OK
+	bool
+	depends on SPL
+	help
+	  The same assumption for SPL, which on most platforms runs with the
+	  MMU off from start to finish and must therefore leave the flag
+	  alone. See ASSUME_UNALIGNED_ACCESS_OK.
+
+	  There is deliberately no TPL or VPL variant: those phases run before
+	  DRAM is up, so the flag always stays.
+
 config SYS_CACHE_SHIFT_4
 	bool
 
diff --git a/arch/arm/cpu/armv7/config.mk b/arch/arm/cpu/armv7/config.mk
index 68036d6fbdaf..a1d1fb40d78e 100644
--- a/arch/arm/cpu/armv7/config.mk
+++ b/arch/arm/cpu/armv7/config.mk
@@ -9,3 +9,6 @@
 # of our decision.
 PF_NO_UNALIGNED := $(call cc-option, -mno-unaligned-access,)
 PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
+# Code which only runs with the MMU on may drop this again; see
+# CONFIG_ASSUME_UNALIGNED_ACCESS_OK.
+export PF_NO_UNALIGNED
diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 4d74b2a533e0..a27d3e3aa8a1 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -6,6 +6,9 @@ PLATFORM_RELFLAGS += $(call cc-option,-mbranch-protection=none)
 
 PF_NO_UNALIGNED := $(call cc-option, -mstrict-align)
 PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
+# Code which only runs with the MMU on may drop this again; see
+# CONFIG_ASSUME_UNALIGNED_ACCESS_OK.
+export PF_NO_UNALIGNED
 
 EFI_LDS := elf_aarch64_efi.lds
 EFI_CRT0 := crt0_aarch64_efi.o
diff --git a/lib/Makefile b/lib/Makefile
index b7272c6f0cba..dd93d41df5d7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -93,6 +93,9 @@ obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
 obj-$(CONFIG_$(PHASE_)LZ4) += lz4_wrapper.o
+ifdef CONFIG_$(PHASE_)ASSUME_UNALIGNED_ACCESS_OK
+CFLAGS_REMOVE_lz4_wrapper.o += $(PF_NO_UNALIGNED)
+endif
 
 obj-$(CONFIG_$(PHASE_)LIB_RATIONAL) += rational.o
 
diff --git a/lib/lzma/Makefile b/lib/lzma/Makefile
index 09380074b3df..1a85b5210386 100644
--- a/lib/lzma/Makefile
+++ b/lib/lzma/Makefile
@@ -10,3 +10,11 @@ ccflags-y += -DZ7_LZMA_PROB32
 ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -DZ7_LZMA_SIZE_OPT
 
 obj-y += LzmaDec.o LzmaTools.o
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)ASSUME_UNALIGNED_ACCESS_OK
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif
diff --git a/lib/lzo/Makefile b/lib/lzo/Makefile
index 45612a83dabc..66b02ede0f19 100644
--- a/lib/lzo/Makefile
+++ b/lib/lzo/Makefile
@@ -4,3 +4,11 @@
 # Stefan Roese, DENX Software Engineering, sr@denx.de.
 
 obj-y += lzo1x_decompress.o
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)ASSUME_UNALIGNED_ACCESS_OK
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif
diff --git a/lib/zlib/Makefile b/lib/zlib/Makefile
index 4a3e985a9494..9ad1c73b3e6c 100644
--- a/lib/zlib/Makefile
+++ b/lib/zlib/Makefile
@@ -4,3 +4,11 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-y += zlib.o
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)ASSUME_UNALIGNED_ACCESS_OK
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index c9a7dfe405b4..76b8a992d7b1 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -35,3 +35,11 @@ zstd_common-y := \
 		common/error_private.o \
 		common/fse_decompress.o \
 		common/zstd_common.o \
+
+# These only run once an image is being unpacked, which on some platforms is
+# late enough that unaligned accesses are safe. Where the platform says so,
+# let the compiler use them: assembling a 64-bit read out of bytes is both
+# slower and larger.
+ifdef CONFIG_$(PHASE_)ASSUME_UNALIGNED_ACCESS_OK
+ccflags-remove-y += $(PF_NO_UNALIGNED)
+endif

-- 
2.55.0

