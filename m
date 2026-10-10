Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFC0CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F22B1608FB;
	Sat, 10 Oct 2026 13:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QURGnq0V-CRH; Sat, 10 Oct 2026 13:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC4BC60653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637944;
	b=HKquil71AkVKIvPVGDxoi3ic7PVFlI1VUhrb+SRjYiKZsfaoIF6OagOpmmu5/2tZF+jU
	 NRg+ldnjgFTTx/rxaij2zM9AGP7WcEQocswNoG7Aqb+AMTVYBmC5gAYjW3p/eLv238IHX
	 O8ffQv9x7mpOcPYXB0tDQyIPTmDuftU3D5DYHaJW+63JZyitixcwR6s/S9vpYldX5ne32
	 wUHCiG+DN+sTztAZ5K4UMbqrbCUk/8hZjE6IL3aPQ4MmzIKXL49lsR0W21BIrpZwa/NsX
	 PkGVsfmhubp2arH5v/ubNzlLfGhjwZ5kKv4Nn4w+9QVUiqEi200Dh43ixZG1XrEMlEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3R5KCegiJzxwlFt2pt2cAPkwdU8NSfW7b/0aeKL4Fl0=;
	b=bbHWry41phx6hW8vUZo5XXfEauzE3KWhzMjD46x5k5/DQHBGDlPzCTwkkH2ZTABPqh0W
	 uhUNAMfzJ1w8355rHuxbPazNMz7VklIvthY0siCMd94etH2EMANgSTzXAnrnLuvPmmHYq
	 w88+eLnydnmwyVVPTU51U1HoED8cNAjYiHol3t7CM8ULRUPdFT20xGl+QtC8DFTmd/Gay
	 wEyuX7/Ec4wsY3/j1RrsmmfePrk9/N/3k90foTiQpAC26G9LRYd2fA5q7fIec6KmkD/R0
	 VccSJopbvLUZsoEg33sSYFwhQcgpxjmhMYIkGQJYUrgkx7IQGCshNZ2fVjPiu7ZWd5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637944;
	bh=3R5KCegiJzxwlFt2pt2cAPkwdU8NSfW7b/0aeKL4Fl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OorVDcW1o3a2cDgxRCjnxHYudwsEYAM35caRo5SA6z1PoRAXfYnizN2EXsbaYFecU
	 OYIVwuWSNlLSRDHVGgDhp8e/v3oQGYxZCoIa8RP/+k2ECd6RQS+uyuaHIiJkb67MNg
	 O/GH5asofEEOksObZbMAJU1cmACPH2WwB8t/wkequkwEHuOn9DS+3ID92urHwrvtH6
	 Ck6WLvuGqrijwlmCQO3pks+86LRFJson2K6i2fTto4ZQHMhsdxC7HmfrxqIUMoltBa
	 Oo6Pkn4Ycacvrf4OwsEW1RArToSgMF+OUeDXCJ6oP56UggXNgTW03tZZK/mEVbJh+M
	 CTySy1Oiu0UhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC4BC60653;
	Sat, 10 Oct 2026 13:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB3BD317
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD27B4080E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLCc5ci02e2N for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D062B40809
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637936;
 b=Qm8XrN0uHOqq9u/P9TFAulwmFj0W/62AlFpL3bDE4ZhtSA1YEav5rQvtlQmhNVU0FgEw
 3GfVWRoITVGIfhu5ho1shC/L1qfu6EaGEfEOzsCVFhL7jmPnMGlSjEubgvkP3kvunb1ZU
 WlOM8RMrbTB65poIXnj+4kAm6ddfwJLNxkLPnZhARyYWvaVr0qrtTSU/ZFztcfvsXTFxb
 YC3zH2jyCAYjGoWKVl4eV3BRdMsnKprC9ZQ74h77NLa8dI1y+us2ky/13ozGiq/0OKs9W
 Qb51m5pA2nR8OrDziXHoLWkioD3LGvPUvFXQ4u+PtXmfRIrm/G7N7ocn6Qns72a4a4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637936;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=3R5KCegiJzxwlFt2pt2cAPkwdU8NSfW7b/0aeKL4Fl0=;
 b=gvOXhb5/jfbZf848zjcjGJoBq0wIxPj+rxe8CuHszbZLOrCZWe6noeUgB21mu1SH3WIW
 flukeRhGaCK/maI6u5M6E+kuXeS5VU6FiVgh77D4+w5Qu3NVIATMe4FikYtCjVE9V8qA2
 gDpd2Fq2ye78/Fw+6tnF4rJ53lvUfCmVlsGwJZNVkUQyJhPreB95oItQB5Na28DEWdGVX
 1Z+rkLnUDHqRbOlo0EIAsliOZkCaGbl3szzGDybWemejuHbBqjwFAFJOln+dm/5FnGu3W
 0XehZLZvJNd/cFpeuZneXVaszma+uKZPgWl35QaaOT0xsG/6YncSPAlngosg/a4EGdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=0WmJxW66; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=0WmJxW66
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D062B40809
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2e36c3478aso88443066b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637933; x=1792242733;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3R5KCegiJzxwlFt2pt2cAPkwdU8NSfW7b/0aeKL4Fl0=;
 b=0WmJxW66Aoi2sluZhiqhmqC1773MIvrdVHUqiQEIWXmVmEX04DU0hgYkKvYonI/ev3
 TIyYuMOu2AFePy7SkLq7kXyl4Cbn9T+qSmad35kZAcDSGdtJnsDgveRoGA08SewI37um
 /GKfZnt2Lk60gdb47ISwt0E4v846efaugXyCopHsPnBtz+wwfq7wigrKu6Hfr5wESTr+
 LW4WVPw8jSmm9oEETteVY9nyOMAsf1PPc/6CtuxtVnwCbMMbJsvw+IXhTbRaSqpN5al9
 uZ1BmSvAwdM/79JV6GdfihBmIWa6VneuA+CwjyMVVUBUxyA5tYOF9OOU/eiZ4SmuxwgR
 0b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637933; x=1792242733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3R5KCegiJzxwlFt2pt2cAPkwdU8NSfW7b/0aeKL4Fl0=;
 b=Jlof0rmytzVWGf/PQkZvJ/dc/ctGpp1vwriP4DdWMNnqT1ZvWEtk+Rdy708oc/m/Yu
 7yPrTKi693W+UGWRd9SNnXPnNQ1h8yyQXwWdMy3smFVo5hb/cAJoq5DJl+lJi53ux0rH
 UlaLR57yHDTf/GOqQZALbIHheXG9O/2nSk3Gtf+91SCavJyCcglEyq0sV+rSjyyf5ROZ
 +F5aENWYEoC/uE22J25F3OqoOpIRB306fiTwKPbAASFVhTRp1JkGHn/Ud5QDlPOxbis4
 v4CaXTmbqKuBDPgRkyuSeEft9Z5E7yvrHdW6eunIsV/QZMqRhI4Nuw5Dg3/UL+arCnMK
 symA==
X-Gm-Message-State: AFq9FYIrfE8AbvjTZvAKV5lFWYugbGlfsUm9aUNKToxy8aHNe0zzegDh
 bxtV4k3aujgSzni1VxZJ0th020a6yF6+xDvMcXBNEx9WtjI3Y0ddy8O1mtGJMdYV2f4=
X-Gm-Gg: AYBFou12RWKK/Gexq9Q29EeWrgBE3PUMqOG10wRNnjNKZpDHa0lTFFkjeVDMYKIf4HT
 SBPWvhAE0RK3KVmAJD0uM6aGmKtfTQ8btD8kXW1/2cbZZnp/90ZfCVeyYlKQCvXcy1Z1nsmUdV7
 CiZplfatysn7wxiQdZEOISjsUd6vLb3RgFy3NTKydEenxNXpEtZFXuUkHIECS3FbAm4jI1EnOJz
 UzZwZDbRhYtxVmK7SScXbVSL5YnmjNHvYDPIR3L46k96sOBE+curCb8bjtXpeTbFH7bXPecWYgP
 TpajRLfGWOEWSiuVz49Eo2I7/utHw+UY+0Vyg0/TVFxoustE4vEy+1OKIwnbmBFMupMSYTXlN6u
 5aCywogS8999LNkrmxQappTdk5jD/iIB1g/6EHvLMtX/IWrf8LxYk8+OhPVdPylzS9xeFh+1D47
 IHhASdYK+2kvfj9bj0sU32LYLxwcuJpaY6AkKARoV+JD6mqYKsmlt3CmdTNu3XAEEkseURaF39H
 Z0db2eV94xFlwDnPUTM
X-Received: by 2002:a17:907:e109:b0:c31:c767:adfb with SMTP id
 a640c23a62f3a-c31c767b02bmr331693366b.0.1791637933419; 
 Sat, 10 Oct 2026 06:12:13 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:13 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:42 +0400
Subject: [PATCH v3 5/7] configs: malta64: Enable EFI_PARTITION and BLKMAP
 for big-endian tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-5-89fd290f85cb@flipper.net>
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803; i=alchark@flipper.net;
 h=from:subject:message-id; bh=EY3oUMyq0y1sW6A8k+CGlKyeyb5u0rJ6C3VRccyJE0c=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdslykr5xf3JlgtezJ81WXF4hL/z3BV9P65k7U2SWWG
 uW1RqKOHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz12gCGf0ZKFgqz1t9M+9St3f9hS9PZ4k+ZhY5yjvPTy6OTtDJdJjL8L9c9ta1
 +ld23Zf8SXzGy5U2Xfz618OWl1/wb+AokZqpe5AYA
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

disk/part_efi.c has no big-endian coverage in CI, which is how its
little-endian assumptions went unnoticed. The GPT tests in
test/py/tests/test_gpt.py are restricted to sandbox because they rely on
'host bind', and test/dm/part.c is sandbox-only because UT_DM depends on
SANDBOX.

The two tests in test/lib/part_efi.c need neither. One works on a
synthetic descriptor and the other on a memory-backed blkmap device, and
test/lib/ is built for every board that enables CONFIG_UNIT_TEST. malta64
already sets that and already runs the full pytest suite in CI as the
qemu_malta64 job, so enabling EFI_PARTITION and BLKMAP is enough to have
both tests built and executed on a big-endian target. The subtests are
collected from u-boot.sym automatically, so CI needs no change.

Pick malta64 rather than malta because the width matters. hdr_start and
pte_start in gpt_fill_pte() are size_t, so on a 32-bit big-endian target
an unconverted __le64 truncates to zero and the partition overlap check
still happens to reject an overlap. On MIPS64 the same value stays large,
the check accepts a partition that overlaps the entry array, and the test
notices.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/malta64_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index e927be3b38ec..9a5bbe15da92 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -26,7 +26,9 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 # CONFIG_ISO_PARTITION is not set
+CONFIG_EFI_PARTITION=y
 CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_BLKMAP=y
 CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=0

-- 
2.55.0

