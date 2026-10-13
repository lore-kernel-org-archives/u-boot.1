Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21370CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 07:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4CEA4058E;
	Tue, 13 Oct 2026 07:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5J0QgwAm6LuR; Tue, 13 Oct 2026 07:43:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE29E4061F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791877402;
	b=FM/QoBs7f/h6zUNTF5FfNLIY4SGRznlbn6p2H0S+Ronpu+rYf7Lw5wU93+W6zUjh2i6a
	 o97kFyfTXf24eD7udET5QjCMGqV43OkhIR2puLoOj7BG2nG3uH2XCdaa2UiMuHteLdOiR
	 hrz/Yn9kPVuv+CMaFJb2R5rAV3XbneogPyDICRTjjFObyJCao3StINyux+luJAc08dZFx
	 sAPYsr5vILqobDaNPPzvVyRkBcmUSrlQk7VLtd7Ng/g7hZ/vJzyXJ7GM4x6JAMv9dCaeu
	 kf3uJ1eE+pZETeOHZ6XtvzYaSKHTqr4+YVOZebIFyLDnOYkwsm71aj7VaopHf0NFbcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791877402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LWMowPEwh2G6htx+PupZpFTDZ22CLtG0Jtbui7pS++c=;
	b=LwFG3YK6K1qiozNd9U9dg0zEAC/gVkhX7la+wItg5cMOKTPOPm27VPNpdQv+inn7KjER
	 HygG1wwEth73weyiVjHoFgdTllI1b29wMjnwWh9ln7U/H99tl+Dgqi9MGA1ba1YJrPIcO
	 Q/tZ6B83KrO9VnztLPaIrJ8+N7fTEuIgGQCy4LQp9iuK+Ze9YxT63gwwdjBgJHu31cIXt
	 8GRX5un1mZ2B1aIkl3aUy7Fff9WwD7gtUoCY1dNQHIIy5Ag4C4x6xmtEW4V8lY5Gz6zFR
	 l2AQ9Y6HuApJH+X1QNPPoyfZ1GceXz6g41vl77teS0p/aqbtEDq+ZJ/5LqtN0TH0A+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QVpmp1C6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791877402;
	bh=LWMowPEwh2G6htx+PupZpFTDZ22CLtG0Jtbui7pS++c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=paZgyDVMZzkrHO0FfalCPpYKtymPN+RNtR5gfh4pTCNeV62uGbkoMoZFQzu0yMRt6
	 e7AG84ivESb860D41YwlmWKXDtc22R2PUC2aH/RVz3glIPoBQb1XNmnR/BMSv7bs8T
	 m+ccTlb9Hpj/SJVgXzDDDssshubIfNfB5FA51vFm/M8WhevmAX1/HL5Joa/JRusnsZ
	 P6v9U63E1xs3u4oSsP8dUMqzOmJAuiP4HHPSl4QtdTzmo1Sopt+KIoBOD9Za0m+tDc
	 AxGvVKEQ0jDLwUpmOog0HSlz+jLbNpzlIoC+AAQB7QgUDiovcXKLSWCwZRmbrO9zxY
	 j5lcQNYIu2UAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE29E4061F;
	Tue, 13 Oct 2026 07:43:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1DE1105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4E114050E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSbK5-OySkMx for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 07:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 849EC40507
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791877399;
 b=DVp5OQUixV8SmbIWy+Ntdxkh3cWdKjgXLFh/dc+W4V4zptg5CjNpPmYAQ6gZAwUFpRkl
 ahx9kIliY3XJPtxQazVefA/AT/s5s5mdLYqRo5VrRvhpBUXd3RWMjVBviTLqxL3XUAtlW
 Qt8WmXkdOtDnTU9G7fkwt+kU9eWjmyo3cUo1r8U25lPbfq6u6R4wAEKGPXgmBTLHuwgtb
 TP2N1YOlwVRtnWZIuOLq4gX7ksX+FKfbRSjBiSNlmmtmgbdEE1pAWzlPUVG161Fo2+d6Z
 XJu9hf4dPmf5yHS0nvpP3pAVDS8wLO8X8g4f5vgmUqmIyAS/Zxb4VohHE2pNhN3U6dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791877399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=LWMowPEwh2G6htx+PupZpFTDZ22CLtG0Jtbui7pS++c=;
 b=FqjQdtS3hjiWLZiu9eTcglC0o/BJqNyOnoCLW+oLRtJ+bJtkvdPavYQFCd6IYUgFSzC4
 m++i9+YndjrTY8+zMjs7TWv4m6svCwmdAGz7fFCujCdGAjlwfcnPMm322e45Grc5IH5nZ
 RlLswQUT3NjecYBPHZQR9KjxdQ++LQkyMaL+mPQFnTIEXAoRSlvk8ZtIhFGWCRdPPJyTP
 Tn6deQ/PIXfeJ/oNbctdZ7lDMYEvlpbd+/djEbHZqfWATBZ0kaM4NASr4mSn/0D1VzmBT
 Ofdm+riIXl1fzI8HaSMoGXPEPfypca5h6NHEz6dYMEVXa3Tlu0C3GbsoYE4HrkZoqZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QVpmp1C6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QVpmp1C6
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 849EC40507
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:18 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so2519328f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791877397; x=1792482197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LWMowPEwh2G6htx+PupZpFTDZ22CLtG0Jtbui7pS++c=;
 b=QVpmp1C6wW2/COOcu+L6a0vRdIHBSnHKs1Saz67xuvbgNo6va7Gt3qg4GhRvDjhzHg
 IJuQrVi+Ab6M7oFJxThEDFAjwpO1konqlVaiicc8sQnW4965RULLkvMnng24EJF/yF10
 XKKa+1uGBry9NsnllXR3Jc+NjcHTTC/6Yaz+MIZ9QAOYDAiE4/ohP6BMKcuWJGq/pknw
 RGZJXpZQC0WR2yzKME3norg8x1+sqySQ1cDxpkIy4BMffTiWP9Gf8w7X8P+wfAGH8hIx
 w1QK+qHHcaoQ23cOC1c+bHOWp7xfzg/wqkUtmWEFZbQMFDwlsCUb49cmpxne4NdW6QLu
 gocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791877397; x=1792482197;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LWMowPEwh2G6htx+PupZpFTDZ22CLtG0Jtbui7pS++c=;
 b=qVGBJZ5WNHHErPWgT1CtnkOZ2rO3Dhs5mfGdK/uA8KpOQA18Wxo5rI+Vr7SQWz0oIO
 BSiAKmpywG6ylpOX2eIyZLPK2tn/jmWz6zX47es5/50G/5cHfUjHxvp8EnlYqA3HAnhA
 Zr41ZSeJHNOfBVWQtCVfyeQP3DrYM/L8MKLguG09M7ajMr1qtb69NmM1JyAgqYzDr+2B
 fUeYXl3QAcelYiSMiNwgybttDwKmZEyxuQl9iRZTNW6lSG/pDw4GGx5xnwNtVp2NL3Aj
 zecS9EJsxxzxJmLgW+m4GZ2ywiADoHeUOMhH/HZ3MefFj7heBx/D5gS988TZWp/lzYba
 3r6w==
X-Gm-Message-State: AFq9FYLHxeBGrIgApCzXzAfPxKqGWbhlH76BdA9hARSf7N3MwXkbHEwI
 3+aSw5viFuRq9EiA3mN7enNW+UwiLuUBui0dJ0gbTsq6Gpt5+Lhg6xtQHlxs6dSf
X-Gm-Gg: AYBFou1BXBk/WJzFNO+oRrBMFaXkI1wOzwr9i0WM5QZR78CVt4OtkcTWrv1rvKAt6Gg
 YudFtDT3gzBu+6JRrZXt2R3sORC6Hy45xvIZcos22D0sITrOymZcM2qIggwRQyCMviq3xqTryDa
 HCWEZd4+vAuE/wuuXNWLoitTFxrg0qk2/AqQgFAvv9wtAmmfHFjdalcdWXrcVB555Xny620Yprr
 gHxq0BR+86nvTpJf4ROurOISBtgBs2S+W1b8gm4JTzNzeoUJZsHAUjhUCK9U6ZqUQOySqfi29Ef
 JWy07sX43I8GejSL6eHYTT12cotIEjRsgZcM1vScMmvl8NmOer4rBhRX6nS3I5wwVX8awP0r3KW
 690dBrpesahTU4nWUpLHFv9RNH4RzVmx5OtwdTCcdmeny61MBctn4+yuUAPoFpfbbf2l2B5WYAS
 cafM/KO3d50xUI/PuWl9vJAOUgVVvpjiphNBaFfDrRlA8a/OlXHZScfI8yRIfNduVxGgtGLrYxf
 7drENVcCkvBFywKDzM4JH7FjRk4SkHI7iNG4gbcCqAMJ5lKAt1siPWjksoVoa2pRSbvyjueirUJ
 WSnQzK2XST0rdIoslzdMdT1Ne/5qOOPjdakSEjInOSYnC05/t/tMlbJd4LI1G41tV+v09Lgdfzv
 0nCct2LSXwHVFt1JgCRU4e7pVI03eMhPujA==
X-Received: by 2002:a5d:5846:0:b0:48d:b9ad:e48c with SMTP id
 ffacd0b85a97d-48dbace3fc5mr21114886f8f.46.1791877396747; 
 Tue, 13 Oct 2026 00:43:16 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-303e-2074-f3ca-cf21.ipv6.o2.cz.
 [2a00:1028:c000:ddf:303e:2074:f3ca:cf21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac3970sm3466527f8f.37.2026.10.13.00.43.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 00:43:16 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2] Makefile: Skip undefined symbols in keep-syms-lto.c
Date: Tue, 13 Oct 2026 09:43:13 +0200
Message-ID: <20261013074313.84961-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The generated keep-syms-lto.c gets an __ADDRESSABLE() entry for every
linker list symbol that nm prints, including symbols that the input
objects only reference and nothing defines. keep-syms-lto.c is compiled
without LTO, so such an entry becomes a reference that the link cannot
resolve unless .discard.addressable is dropped.

Pass --defined-only to nm in the U-Boot and the xPL rule, so that only
symbols defined by the scanned objects reach the generator.

Fixes: c1094987d1dc ("build: support building with Link Time Optimizations")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
Changes in v2:
- send it on its own, outside the mpc85xx LTO series
- move the turris_1x example below

With Debian's GCC 14.2 and the mpc85xx LTO series, turris_1x_sdcard
shows both cases. _u_boot_list_2_driver_2_atsha204 is defined by the
ATSHA204 driver and referenced by board/CZ.NIC/turris_atsha_otp.o in
U-Boot proper, where its entry stays. The SPL only references it, as
the driver is not part of the SPL, and there its entry goes away. The
images do not change. Without this patch and without the /DISCARD/
rule that the series adds, the SPL link fails:

  keep-syms-lto.c:5:(.discard.addressable+0xc):
    undefined reference to `_u_boot_list_2_driver_2_atsha204'

On main, this changes no image of the ARM LTO defconfigs or of sandbox.

The option goes to the two callers rather than into the script, as the
script runs the command it is given, which can start with a wrapper
such as the ccache that buildman can put in front of the toolchain.

v1: https://lore.kernel.org/u-boot/20260928110434.70686-2-pepe.schlehofer@gmail.com/
---
 Makefile             | 2 +-
 scripts/Makefile.xpl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6303a0cca6a..0d284d49989 100644
--- a/Makefile
+++ b/Makefile
@@ -2076,7 +2076,7 @@ u-boot-keep-syms-lto_c := $(patsubst %.o,%.c,$(u-boot-keep-syms-lto))
 
 quiet_cmd_keep_syms_lto = KSL     $@
       cmd_keep_syms_lto = \
-	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) $^ > $@
+	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) --defined-only $^ > $@
 
 quiet_cmd_keep_syms_lto_cc = KSLCC   $@
       cmd_keep_syms_lto_cc = \
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index a3fd3e1375f..53522ced84b 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -491,7 +491,7 @@ u-boot-spl-keep-syms-lto_c := \
 
 quiet_cmd_keep_syms_lto = KSL     $@
       cmd_keep_syms_lto = \
-	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) $^ > $@
+	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) --defined-only $^ > $@
 
 quiet_cmd_keep_syms_lto_cc = KSLCC   $@
       cmd_keep_syms_lto_cc = \

base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
-- 
2.54.0 (Apple Git-157)

