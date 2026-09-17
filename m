Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56ECC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D0F060B6F;
	Thu, 17 Sep 2026 14:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9GhLAhkrZ-A; Thu, 17 Sep 2026 14:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 32FDA60B0E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653806;
	b=YJSCy1/0jk9WQGdgum7Owlg2i8fqlwY7AqakwOhXm6wnWKg+121bsj/Nv59HebYIDU3Z
	 5WMMnYuih+J/chgcIT55Ytsi6klI4xdkQ2KX5+jVsaDUhyQxUCgWsigPwc+f8Ky5qT1Z7
	 nWZjepBKfPVtKD7hLcQtVgsxpRaKWjXetj6rnlyCzoI92C+/xg1lgVNI0vxvCFauqHfDr
	 k0VqtbGxomBiTUyY0ZP/WPWyj7V0ClJDDDxzbyYwvOju4X0VyVcS0/ANF6U+enTd6avWl
	 dSD/H0NmZBDhWkkyjBa+n4o520IH5Fv/a5OnZy9IObQe42eCxMXmFBlubZkNSQtfYUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
	b=SO71dMK3gUX22SqlIGjvCWloSbNEw4knsE1BoE2gN3+7T42qHEiOBI77bLRq5mSEzycV
	 D23zwKygT8qbtDCxPsga4x7Z3yEMIUcR1cx4DxOooET/82i6YdvRdQQfO1Yj/e/j5Ugh+
	 1pENwf/R0kZeSnp8jTKBqZc4aeXT5qjuukaNG5DMcPBtpXhORt53zTpzKyvxo2fou0NYy
	 yuK5656glEupXQUH8gCf6UpP+L7uGGwLqq1YPk/E6MMEz/H3k8ZMueHJWRGx1jCXExao5
	 pWNuJtQpZUk+JNeeho2qN90K+Q6UkodPdLbkfavuP0GPUnCRQB53uw82UBFuKqxshAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=lUkhBtYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653806;
	bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYt+99QOmsJie5iv5tgjkIhhbCjpN/giUtIJ6iYTn3SK43oEdk+NF7bx99KRyq1na
	 aFqRfO6ubxNUWLfDUjIQDDE1ffXKN2iGbHJtUett/bCsLVGXHRHC5+YBE0a0HYa0GY
	 BUcP7TOpjQT+g/0k9+2YHRgKsECWwnG2bmg5y5pTbkjno1zrEHrTspGVbh69+5rNpY
	 p8FHYFXOfmtYF3GOAJ/5MlPcLnZFrvQB65uzID8uDgcpkESSgZPW3kWXOyR2HuhBe4
	 1qAUlvOdoLquITGqkaW0SGNlxfaEHvqgRe18w3PcGDkhjrXihfGmdKLT7dMMcyJrhw
	 M4KDXKB+DZFAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32FDA60B0E;
	Thu, 17 Sep 2026 14:03:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6310F465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6006760B77
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id piVaPeBzxs-O for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2A7160B6F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653804;
 b=E6aHqCYFRcv/0Vz1IDJ5IWQCvBssyRHerQwGtwLgH0pGlW3/m5O02irqz96ns0gxLZj9
 702oYyA8crAiPQRTo0lG2/aVXuTYWDtS/P0JZRFNLqgrq8nxmEPmYcfMBCeAJPQDoNmVH
 w3eDssFIrOLWit4qxWPaAv2zx2Q4XuIo2ZWsN2i4xNz7uaXyVIumgTvqp1wrofhRe/GVr
 WslqBMcdNskT0Ih2G8w0U1pFawOG7j5NH+FjslEf4TNlvrWXlfraTVprD5+z72PpgowBj
 TIqx2N9gSumjlL2LQRLeQyqaD/5qF7LVkmsDPdwsVfXkn2krdgcYdMJuSuv8gqcPX9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653804;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
 b=PdWYTrn/RaTV/cwx6ImyfFzxhSfmFH3Oz7CQmPldr8O2+M9tAWOKvEL+b8Jqz19G5W+u
 0Q0PoQ5TgfNK1pgE4E8Fnn7v4oFd8ckEhVIeqKml+CqZIsqwjA6/MznfA9Ddzsx1Wt1vb
 jhLYkQIuNYGMCziHKcfD3zK2CNZ2A6WGRFJXQk04AHUTG1k0LX4vYezuHn1uiB8C4jdPa
 uoqOt3eljRTOPMbLPAt9oas+BPPa3dOqWcAXMEQ7dkQGy08hv5hh9A/P+r/b795quVNRq
 DpLIAR21ksV46Pdwnz3v/Y2FMoSV1kko+YduK/fR4VN9S4CloUD5eB2kMNExjK2mdeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lUkhBtYQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=lUkhBtYQ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2A7160B6F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:23 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so633636f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653801; x=1790258601;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
 b=lUkhBtYQXQKlKd+Ahr+RFTOAJgHiG+bA23bocyqCBwlsGeHbalDF4pY8JItiA/qoOd
 x4i1bj0I57R/8X7nuLLqIQ9vhWFed11NE+T3xo8ryMXHNAfiI18c3LdqzA+0ZjuFGny/
 ljk44+lqy0yXgiG9bvNjbUIzTW66lZpPV+A+56bA4b4o3GWiQ3f7EPo81aCGWW5yutjG
 PKbrPu754ufN0iXtVimV1FzM+M6z2pP6gP8MR0Cs94etdXxa07YMprA5hX1l6p9LNsqU
 CfK3FS4o6YzCEVM+ybhHBMH29N0lf2BN4XxOEm2aHHMGAqa0W7U9RsSkNfapW2M5R3/0
 XIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653801; x=1790258601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
 b=eyF53zwAwZjOwc5MztD122Krjm4Y5CDZPKGR0eGPBgoAwYsThxRkaezwrdHCm+znvS
 VKfpPefbK3SsZJEGsxVE5NMY/3qTkENpMLvlKIAW7uY6mmRJ8rthpaavUXq6L1l9YmIx
 51UnT62ZonrZAcIpypsNuNaO25eLj5U6yp8h3QTn3IM0UdKD05zNNn22Sp4kOUvAAQ7N
 GUh/eE72HqiVP6gmvxIv40JGLqOveTwlMYOOUYAfHxTfpH2ed5VTWPaUQk/EqGYv/OWU
 18pBrq9BGy+usCZ/aRLmH2BmgQlfUgY+S+maJP/Gf6bH/3kcZuaX3m4vn+DypT2CcqWe
 NegQ==
X-Gm-Message-State: AFuF++nzhtMtlm7hM0O9IlVrCAvdWZGey7oNywnqpGKjuhYKF8Ki2uuq
 4fW3nGOUmsP8Tzw742GKTVKmdlNklSi3RdypoTl0k7u0wio7ilKg0rNmB3RFGN2GRUc=
X-Gm-Gg: AYBFou1fusjqtayvTuZM/KD29e9Qiihn4ZbqFbOecpkco2jRxEVQ55sYdJ7h52IqG5W
 JOwW2N3/e16bFK+0fpRPFbWmmA8SmervtED9mNpoXo6S8coDGvH5HER5WG3kDckPPl+DQLq3Ukf
 q3nUyn5w6O6g46CXG4M7ZpIsijlvWhIiYHKqzQKr162TYoqFSBlyRLY3Yg9rp0CMgDHF5RG0XBy
 tRL1IKTDNt+84FAnFsczu64GRfdVShRRyVsON1dcMqGYv3oArSMEIT0xOAGC4tO9V3jfEfiH899
 JB192494p1LzQgtwChgb01rmDqKGNYlAXcal6AQXGDV/XpHKbqvpfTdxZWpishjGQDMJ4OV5hU9
 YuNhYgI+xD+wrgNiBrcInwdFPknT2BFEoGMW7ab3OfNl7DKkN2JVy4Vv2DRLPK3gmieQ4YFgr1g
 KV7zq6x6RS0KdyXTvGgEi77pgLQgMzAmBow26ha8cqfngkKhTFpFwR6oyKhWxFPo0AGGS2KXwqP
 QqcpZ/5fzwCPe7LXNoBPO0WKfU75va5Eogo2/todWTuM7rkEYRN
X-Received: by 2002:a05:6000:2990:10b0:485:8542:fee3 with SMTP id
 ffacd0b85a97d-4870cf29d43mr13807631f8f.16.1789653801279; 
 Thu, 17 Sep 2026 07:03:21 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:31 +0400
Subject: [PATCH 10/11] binman: Allow choosing the compression level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-10-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12028; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=yjjDgYmHvXUqSKeo6U2v+4223EpunLKukA4LjXPuoH8=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vT7YuKjk8/exO9ik2Dc2u+ZpdV/UGdteVv+r9QbK
 kv/Jc4W7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq/5Qw/BWblD79yJk445dWj0xuhohlBxnruP4PurxA5F9n2zbGi3WMDNc/cC6
 ay26seDPTbqtV9dTciHW+q7O2Ra4zOLFha9lSFx4A
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

Every compression algorithm binman drives has a level, and the best one
to use depends on what the image is for: a payload sent over USB wants
the smallest it can get, one read from fast storage would rather not
wait for it. Today only the tool's own default is reachable.

Add a 'compress-level' property, passed through as -<level>, which is how
all compressors want it except lzma: the LZMA SDK tool has no such option,
and is controlled by the -lc/-lp/-pb values binman already passes.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/binman/binman.rst                            | 21 +++++++++++++
 tools/binman/bintool.py                            | 10 +++++--
 tools/binman/btool/lz4.py                          |  6 ++--
 tools/binman/btool/lzma_alone.py                   |  6 +++-
 tools/binman/entry.py                              |  6 +++-
 tools/binman/ftest.py                              | 34 ++++++++++++++++++++++
 tools/binman/test/entry/compress_level.dts         | 12 ++++++++
 tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++++++
 tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++++++
 .../test/entry/compress_level_no_compress.dts      | 11 +++++++
 10 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 3a860421a697..d14fbe8e5fd7 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -711,6 +711,11 @@ compress:
     Sets the compression algorithm to use (for blobs only). See the entry
     documentation for details.
 
+compress-level:
+    Sets how hard the compression algorithm should try, as the level number
+    the tool itself uses. Requires 'compress'. See the entry documentation
+    for details.
+
 missing-msg:
     Sets the tag of the message to show if this entry is missing. This is
     used for external blobs. When they are missing it is helpful to show
@@ -1182,6 +1187,22 @@ The entry will then contain the compressed data, using the 'lz4' compression
 algorithm. Currently this is the only one that is supported. The uncompressed
 size is written to the node in an 'uncomp-size' property, if -u is used.
 
+Where an algorithm offers a choice of how hard to try, 'compress-level' passes
+one through::
+
+    blob {
+        filename = "datafile";
+        compress = "zstd";
+        compress-level = <19>;
+    };
+
+The number is the tool's own level, so its meaning and range follow that tool:
+1 to 9 for gzip, bzip2, lzop and xz, 1 to 12 for lz4, 1 to 19 for zstd. Asking
+for more than an algorithm offers usually gets a warning and its maximum
+instead. Leaving the property out uses the tool's default, which is what binman
+has always done. It cannot be used with 'lzma', whose LZMA SDK tool has no such
+option.
+
 Compression is also supported for sections. In that case the entire section is
 compressed in one block, including all its contents. This means that accessing
 an entry from the section requires decompressing the entire section. Also, the
diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 4cf8d5b165bf..caddb9eb8fc8 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -558,11 +558,14 @@ class BintoolPacker(Bintool):
             fetch_package = name
         self.fetch_package = fetch_package
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data
 
         Args:
             indata (bytes): Data to compress
+            level (int): Compression level to use, or None for the tool's own
+                default. Every packer tool spells this as -<level>; one asked
+                for a level it does not have generally warns and clamps it.
 
         Returns:
             bytes: Compressed data
@@ -570,7 +573,10 @@ class BintoolPacker(Bintool):
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
-            args = self.compress_args + ['--stdout', tmp.name]
+            args = self.compress_args[:]
+            if level is not None:
+                args.append(f'-{level}')
+            args += ['--stdout', tmp.name]
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a566..92b3dc7410a7 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -78,11 +78,13 @@ class Bintoollz4(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data with lz4
 
         Args:
             indata (bytes): Data to compress
+            level (int): Compression level (1 to 12), or None for the level
+                binman has always used here
 
         Returns:
             bytes: Compressed data
@@ -90,7 +92,7 @@ class Bintoollz4(bintool.Bintool):
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
-            args = ['--no-frame-crc', '-B4', '-5', '-c', tmp.name]
+            args = ['--no-frame-crc', '-B4', f'-{level or 5}', '-c', tmp.name]
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index 1fda2f68c7b4..d5a7bf3e1495 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -55,15 +55,19 @@ class Bintoollzma_alone(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'lzma_alone compression')
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data with lzma_alone
 
         Args:
             indata (bytes): Data to compress
+            level (int): Must be None: the LZMA SDK tool has no -<level>
+                option, it is steered by the -lc/-lp/-pb/-d values below
 
         Returns:
             bytes: Compressed data
         """
+        if level is not None:
+            raise ValueError("lzma_alone does not support 'compress-level'")
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as inf:
             tools.write_file(inf.name, indata)
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 9b39c7118892..e93b90801113 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -143,6 +143,7 @@ class Entry(object):
         self.image_pos = None
         self.extend_size = False
         self.compress = 'none'
+        self.compress_level = None
         self.missing = False
         self.faked = False
         self.external = False
@@ -325,6 +326,9 @@ class Entry(object):
 
         # This is only supported by blobs and sections at present
         self.compress = fdt_util.GetString(self._node, 'compress', 'none')
+        self.compress_level = fdt_util.GetInt(self._node, 'compress-level')
+        if self.compress_level is not None and self.compress == 'none':
+            self.Raise("'compress-level' requires 'compress'")
         self.offset_from_elf = fdt_util.GetPhandleNameOffset(self._node,
                                                              'offset-from-elf')
 
@@ -1222,7 +1226,7 @@ features to produce new behaviours.
         if self.compress != 'none':
             self.uncomp_size = len(indata)
             if self.comp_bintool.is_present():
-                data = self.comp_bintool.compress(indata)
+                data = self.comp_bintool.compress(indata, self.compress_level)
                 uniq = self.GetUniqueName()
                 fname = tools.get_output_filename(f'comp.{uniq}')
                 tools.write_file(fname, data)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a70..48adacebb6dc 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2168,6 +2168,40 @@ class TestFunctional(unittest.TestCase):
         bintool = self.comp_bintools['lz4']
         return bintool.decompress(data)
 
+    def testCompressLevel(self):
+        """Test that a compression level reaches the tool and round-trips"""
+        self._CheckLz4()
+        data = self._DoReadFile('entry/compress_level.dts', use_real_dtb=True)
+        self.assertEqual(COMPRESS_DATA, self._decompress(data))
+
+        entry = control.images['image'].GetEntries()['blob']
+        self.assertEqual(12, entry.compress_level)
+
+    def testCompressLevelPacker(self):
+        """Test a compression level reaching a tool binman drives generically"""
+        bintool = self.comp_bintools['gzip']
+        self._CheckBintool(bintool)
+        data = self._DoReadFile('entry/compress_level_gzip.dts',
+                                use_real_dtb=True)
+        self.assertEqual(COMPRESS_DATA, bintool.decompress(data))
+
+    def testCompressLevelUnsupported(self):
+        """Test that lzma rejects a level its tool cannot express"""
+        bintool = self.comp_bintools['lzma_alone']
+        self._CheckBintool(bintool)
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_lzma.dts',
+                             use_real_dtb=True)
+        self.assertIn("lzma_alone does not support 'compress-level'",
+                      str(e.exception))
+
+    def testCompressLevelNoCompress(self):
+        """Test that a compression level without an algorithm is rejected"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_no_compress.dts',
+                             use_real_dtb=True)
+        self.assertIn("'compress-level' requires 'compress'", str(e.exception))
+
     def testCompress(self):
         """Test compression of blobs"""
         self._CheckLz4()
diff --git a/tools/binman/test/entry/compress_level.dts b/tools/binman/test/entry/compress_level.dts
new file mode 100644
index 000000000000..78c999590469
--- /dev/null
+++ b/tools/binman/test/entry/compress_level.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lz4";
+			compress-level = <12>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_gzip.dts b/tools/binman/test/entry/compress_level_gzip.dts
new file mode 100644
index 000000000000..d2852fd653dd
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_gzip.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "gzip";
+			compress-level = <9>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_lzma.dts b/tools/binman/test/entry/compress_level_lzma.dts
new file mode 100644
index 000000000000..da52497b11a0
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_lzma.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lzma";
+			compress-level = <5>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_no_compress.dts b/tools/binman/test/entry/compress_level_no_compress.dts
new file mode 100644
index 000000000000..1e58202ce639
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_no_compress.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress-level = <9>;
+		};
+	};
+};

-- 
2.55.0

