Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA339C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0A3A80DCA;
	Sun,  6 Sep 2026 09:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_N2rH9Z-sMk; Sun,  6 Sep 2026 09:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8959180D9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685879;
	b=rMSZohiueUqB6IxHegjSb0AKnLHS/jafYAlRP+9ejOT+mf3CNw5isN20p7YtcgAnhsCo
	 +vNyChdXUttiAFRoOXBKZjXf4GBESZH6PzTWhX1AEXhWZjrtVNBy3Ah/XZUoF46YjFinw
	 pMddrscz2Zf994W6Oq9iDj4qXGG2Zxb/m73QsMI3PnszuaCA+AvN2ieTyRvAAQq89crTg
	 f37cSp9uw4l+dk6cglDA+24mI9uEe0zN0FZQQYCq5ksHP2zZ4odXjk0q2Q1WqkXp0IdSr
	 wgzLgYFXMMVVLy+NDUAEuF7tkq3b+7+qFPe0n1YYg6F+M51HRwfbA/k3n3ourZBV73g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qQEmU1VIXIH8TKa2HqBz49WWPN3NL8cOwPF9qI6C1I0=;
	b=QEPCCz0YRRlwe9+iwU7WsUIcc3EFi+9lq9M8KOScLW7oRKXK8UqHMogrUecHuze8TZAa
	 /64HGEvMhfGoMDPogfs/Id2z6pGzlTVZTdWvBxeUkeBbNVFh0eHvZjHiaVHOjaIrN7L2i
	 yzLIXSmglHK9fVcsMh1wWbK+A0aN1cHzkMCuz7pDXmQTwXwiDdiNJuuLphwcHhCJW+OyW
	 0YACd0wlkhubr/XvjHb0QYucMFY6LZs4VddT/TXp1/+WddshIEhK4L/TGE5qsFPD58+dH
	 5bIvJd9+03xkdrj7gpYdPpQPaKhIiEAanmAMRBcGvJ/rVraWjJ69DtFrS23UWgZAsCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=cItTUZHV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685879;
	bh=qQEmU1VIXIH8TKa2HqBz49WWPN3NL8cOwPF9qI6C1I0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T5MpbXbd47u9rFqlC/3c9Z3hOpTCRqk6omgoUPhWMZGz1HMxOZKU1J0XVevkVxA1O
	 VeK//AWTASMgxf72RzI++HLfUDCzCaMwYnX7m74H4joLCsHAd3J6XZDmloGwm46VHa
	 7JoSFadHWI55XAcgjgkF4XTZR94Vet/vfU0FOAYonGNCp6viCQRGY6FMSyNFZ2PjrW
	 BL+EwYFo/RvbQiVDGcGZPbORjclCAe05UajzlIOCeOQVCxFE6YeE5dhe4gPgN0wejS
	 20YxRBS2bN4imDhzdbay8ZiuTHIbTIzsZvVRxx2y1QvUZaqaP8lhyF2U10jlwFaBb+
	 JwsNRlen3LEgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8959180D9C;
	Sun,  6 Sep 2026 09:11:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5B0C118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6A0980D9C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wd8bD_tuqnG9 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:11:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9B6D780D64
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685876;
 b=bPpwyI4LniqOHZq6IjO76QnzpOFCAhz9MOHlprU0BgihybVsEewq8e4yvgKqD7Jmausa
 IEM3GfUDKqqQshWYp0rDfb8asFt7cHWorPkeusE/zNNpdzGek2/IBhSzzyq/oSHNKXBqQ
 4w89L+OGz380tDUBzRmvO9Wsy+/Efei9d+z7noDnDiKY2s2rcuRQ6JfHZUfVM3Y03rRB+
 a5vEUVQO8ScXarWMQ+X4ml0dc4C+7HdlTTxfYDpHFEZxKok8tzMI8cRvpMNamUZH9zT1q
 ci7pKXPiG7a5iJYTqn8ep+XtoMAsa4cOlNWx6RmVYAg38XWIVIZh3zkaR9/b9JLQwsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685876;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=qQEmU1VIXIH8TKa2HqBz49WWPN3NL8cOwPF9qI6C1I0=;
 b=JmwMoKcAczp82xON4ZeKAbvfYFG43kX+llthf5U+R706ceNsJ4eHPwAdiEbomw1e00Rv
 NlKjp8swxWCS0uq1etu4LHcvKHENgJZggULzyLHPC3woc3Cx+lO7znnhpMi5uALqkk6Fd
 yZaT0FCjpNmjMnrUlk6vsOLWjdlb+437QbGTKL6Pk8Ztn2g4dntd4o0zenKoqGwOjcC+M
 G+FTuw1nDJNIQa1or9E34kfpUnothbmWyCniBmJEMGnjiE5QX077M1oHuZ3Nu/yAjq5cH
 nqhc/gHOWFlQjSohKLu3EgiaYMU0TRCVcZxxnrZYaTj8ZxOrnPzANg4knPziJ29eqSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cItTUZHV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cItTUZHV
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B6D780D64
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:16 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so2321807a91.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685875; x=1789290675;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qQEmU1VIXIH8TKa2HqBz49WWPN3NL8cOwPF9qI6C1I0=;
 b=cItTUZHVsB5TlI87oeKqIzVEkA46o/ZSTX7xeppe9hByKRRdZ/B6u1n5ab0aBAXiWL
 Ne5t80tJNXSvkD3fidMBia/NtjWGPlIa3nRhoU8ArPOgZKnHipXMDTtD5cZtb2a2pd7z
 6MellCXlAaKFnvZa8JEbz81Ru8h3oP5zLLcgU16Cjv0ff6m5T2VY+FvW0xZGiff984G3
 HqEgmbgZN7BoWRgift2hiKotIouPbpyWuzTltOOIePw28hFnfcYlcWN9YpZQiRu3NGdD
 X9Ahy/teznBFoFPvWXErjQhAZ8UzXv9MY3T45EGUmd9gre0LnN0l70qHrEuP/FvPD1dL
 PChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685875; x=1789290675;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qQEmU1VIXIH8TKa2HqBz49WWPN3NL8cOwPF9qI6C1I0=;
 b=bsmStwIdQa0RgY8T+U6pFn206DX1mjAnlFb+LNwmnD+EN3SUL3c/Xmx6HyM6rRVagL
 Af4mFiiCh3Mt+dfms8f+3JVKdl7DmO3cyWWBz9z8wCXoq5tKEd+hW6fV5Amje6GrR4Rl
 OCNpgLJLP3u2iwYZVH+VL/hMcV/+WBtF512jzwe1TzUB9GdOzUUEkfqyEiYw9Rb6Z2GB
 dlyWH/N8cIcQZl4Ih4Dg1wwjeSkXgn6iPuJ2t3tvSzjmGRedllDu3inuvr5ctVk3UZ0+
 stIOFKPbcZefYgh3E9Vw5cASeC4vCTbt3yYGeVhMnCh3i1gBVxPRydZtxVGSzREaH0BP
 gS3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgJIKG52vpb5r+5k5WwT2XyRTJpkFM5A0TcB49KdMsD05r/B6cGYPpvf9/1zfTT9rHTByiYIw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kwVklJ3JJfNKW8fnkX3te8w6NMUCyK3oXvNPrLFii3d55MisCX
 noIejzx/DJ2ZpnZ8GlApgG3qk1yT1fQLu6fzW6QUhSrqBjSUk5RqwBX+1xJPLuzJUSY=
X-Gm-Gg: AYBFou1G9FY8hY5PrTy4yuc7xXVtNnVMs9ZZYu1hSE5fXZPaG++st3jbT5+O/wPSCAN
 o7kd2gDpDhnoA6oTKxus8/5L/DE/BAA5kpc+9ViU/7xWnhoouMhdELMP2biqyf8hIvkV9lZ2mmn
 kigLZvfU3R+PrND6PWYyNAyUuXPuwbwQlV/9lvctbdd6OnaCII9d2bL394tPJF6FfSoL0Tx+4Lk
 d4a4CN7OSCUkEVOvWv8pzrDBARx8cgw/u7Ph91KxrOkx3mWwFlv1RSk5jsUBrtpWe6UFR8c9FLd
 Pja1pTs0+3P33hfMDPTX16k7Tj+I+Lxg9UuhkEr59Bqk0VeTpoTRDXHPEO3XZj6sO7oZfys3Bhk
 D06DzwWNgKUimVsBTnQ5+IDB7wrmTfQJvYftCxugO0sfhvR2g9Tgh2b+UhN2R0kD2h2pnCHRKwr
 nmSpsHkOO0CJT0a1jJoDTVM+PjB3VuIomNW7oL60J/qMj84BlAnmKYV4J1WkQsWEm+ySiYEyTYq
 mo6gRcszTdYPDk5B2qmTUg9b1Vi5QAm1fmrOml1luxUoJQeRmB9AckeTGUkwrn3aNf9IcvBuhG7
 5ilNbJFCrEPi/uV1SCTPToXAZQ==
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-39b261323e0mr26890885a91.11.1788685875514; 
 Sun, 06 Sep 2026 02:11:15 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:11:14 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v12 0/7] spacemit mmc driver
Date: Sun, 06 Sep 2026 17:11:02 +0800
Message-Id: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYunWoC/23RS07EMAwG4KuMsqYoduM0YcU9EIs8HKZI81AzV
 KDR3J2kRZoCWTryZ0e/ryLzNHIWT7urmHge83g6lgLwYSfC3h3fuBtjeRAoUUuNtjuozhqWoMk
 mTl6UxvPEafxcpry8rnX+8O8cLlXWjv2YL6fpa1kzQ+37NXCGTnYOIJmorGaNz9OYQ7646TGcD
 qLOnPG/wqKCDxaC9qaPpqH6uxokLaovipz1YUhIKVBDqa0aFqWKij5KAEPJAjQUbRTioqj+UIG
 zBExAQ0PprVp36aIwkSGtozLBNZS9KwNrGraokp0up+ktettQIDcM1Rq9rHmwdDF44Nh2m5PZn
 xih3gx7YheiVYnlH3e73b4BT2MX1V4CAAA=
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

---
Changes in v12:
- dts: Drop all upstreamed DTS patches since they're merged now.
- Link to v11: https://patch.msgid.link/20260905-m4-v11-0-235eacd94fe0@riscstar.com

Changes in v11:
- spl: Fix the read_boot_mode() that returns both boot mode and boot device.
- Link to v10: https://patch.msgid.link/20260824-m4-v10-0-5e0adcb1edb9@riscstar.com

Changes in v10:
- pinctrl: Move all pinctrl patches into a new patch set.
- Link to v9: https://patch.msgid.link/20260819-m4-v9-0-6e66016392b9@riscstar.com

Changes in v9:
- spl: Enhance detection on booting from SD.
- dts: Synched upstream DTS files for K1.
- doc: Create SD card image from scratch.
- mmc: Avoid to use CMD18 on SD card in SPL.
- pinctrl: Drop "fix drive strength configuration".
- Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@riscstar.com

Changes in v8:
- doc: Remove SD card.
- Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@riscstar.com

Changes in v7:
- env: Drop env support on the mmc series.
- dts: Sync upstream DTS files for spacemit.
- pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
- spl: Fix DTB matching.
- Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@riscstar.com

Changes in v6:
- pinctrl: Fix drive strength configuration.
- pinctrl: Fix pull-up/pull-down configuration.
- pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" instead.
- spacemit: rebase on latest upstream branch.
- Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@riscstar.com

Changes in v5:
- mmc: Split CMD23 support out.
- mmc: Use read_poll_timeout().
- mmc: Set pinctrl state based on selected timing mode.
- mmc: Remove the condition based on quirks.
- pinctrl: Fix power source argument.
- dts: Add missing power source on mmc pins.
- Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@riscstar.com

Changes in v4:
- mmc: Add CMD23 for write.
- mmc: Fix CMD23 only for CMD18.
- mmc: Update bulk release operations on reset and clocks for spacemit
  platform driver.
- MAINTAINER: update the maintainer of Spacemit K1.
- Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com

Changes in v3:
- pinctrl: Fix "fast" by "uhs".
- pinctrl: Add syscon dependency.
- mmc: Fix quick by capability.
- doc: Add SD boot support.
- Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc

Changes in v2:
- cmd: drop patches on eminfo & tlv_eeprom.
- configs: Enable ADMA and SYSCON support.
- dts: Use vmmc-supply as vqmmc-supply on the SD card node.
- mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
  read/write, correct pinctrl state from "fast" to "uhs".
- mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
  transfers.
- pinctrl: k1: Add new IO power domain configuration support for
  dual-voltage GPIO banks.
- spacemit: k1: Use FIELD_GET() to parse boot strap mode.
- Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v1-0-1bd14b8c4f9f@riscstar.com/

To: u-boot-spacemit@groups.io
To: u-boot@lists.u-boot-project.org
To: Yao Zi <me@ziyao.cc>
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Alex Elder <elder@riscstar.com>
Cc: Andre Heider <a.heider@gmail.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Eric Chung (7):
      spacemit: k1: select boot device via config registers
      mmc: k1: add sdhci platform driver
      dts: k1: enable mmc devices in SPL
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      spacemit: k1: fix product name detection and DTB matching in SPL

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 +-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +-----
 board/spacemit/k1/MAINTAINERS             |   5 +-
 board/spacemit/k1/spl.c                   | 148 ++++++-
 configs/spacemit_k1_defconfig             |  22 +
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 271 ++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 684 ++++++++++++++++++++++++++++++
 10 files changed, 1139 insertions(+), 148 deletions(-)
---
base-commit: 8c29b52d168877c3d5c5e3906c7481b21cf14956
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

