Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB181C982E1
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76ED840DFC;
	Sun, 20 Sep 2026 15:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRNCMx50esrz; Sun, 20 Sep 2026 15:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BF66240E32
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919375;
	b=YUcV8QqfRUO/9LvEF+ruS7JDRXVW9IZkMNebfThD70YHjJ2OJcGHk/5txSkZ7p7+kUqW
	 jeuOQU0hwuATiK4tWbVnuQq8wyP7N+1jYNub6NSwhdbcqwe4CH7j+6TBf8JhSEADjA5vm
	 aMdK2+HucV9lkhUifh++I2arxdMt28wWQDtKqV1L2jbCTgCKhhGIy64M8OtY29JQ6WcCa
	 IttoXCVicVHyVSbgnGd7lNKGhzdp3h8Qd+6nSllbgy01VfAyodB80IoT3j5HB2ueO9Wvk
	 z88uW8G3kmPJEx825bxhSlfmilL8441uDlVcoI1r9EHbA8o+4IBcUhNKKLcmPh/BkaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A46keIIw5kisdm817LqsBgoIl4m6nHtcNdy/p9dGlEw=;
	b=C3g+q3xy8JrauG3DQsI7rL3ULIUErHH8rIDDNNPsKuAdqwd01sMBLn2X/511D9wGS+KN
	 eW5Ljy5TdpQ4BDACaN/ib1jGBNBp9Blc/BcoI4HgGKY4FJXqHQBPM0reAE/FOLT3cQM+3
	 i6uuFdRUfccq4yo1g4roH7bw1EK5hHtIFq1SBN9ncxXgg6yYf22G98N9GkMB+LZdc0I+8
	 Ajn41n+rBxbq6b+gSw516gJus6I0MgLcHj66EC5a9JA+z40zLYcV3pfq7VPilDg+ZvXWi
	 Y9rChF+vIMTpoLzMdxHJxI0n5WfZyHjBVBJdRJ2MK8fHwBH94ri3g+ZfdWQ9uh8ESsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K4EYP4aJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919375;
	bh=A46keIIw5kisdm817LqsBgoIl4m6nHtcNdy/p9dGlEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TYZppqqzHr3TsXkTU1gYFr0OZJocUeJnd0IRnHd67ajH0EUtANwElzAMce4TJ1BWt
	 7fGRgz4/N5wubqga5rlag9WtSZIeZ+elW2Hroqh6OLIRJ9oz6yTfWBlwmHFRXQCH65
	 GFYk/7w+RW0xkVJZXgkxoiTjaPZp5wBHc7ZpJ0r2bv9G76pixI16WyCA5EU4JL/dHK
	 jRPmVWQowImhy0BPsoBeBbJ97c1wDGm2Vu/ybNrkzjeyJU2MB6OCQ/mZ4tK8j+dzSo
	 HTVtU9sMppN/cjpfbl73j4SqLzA7BBOMul0BN8jQmqKmzQje1bZ6HWvw1wKuUJVypS
	 jG1+aoJbs/SaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF66240E32;
	Sun, 20 Sep 2026 15:49:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B196225B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AED7540E34
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HeGieyv744dq for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA55E40E32
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913791;
 b=NKJatRqSydIH5wioA/i7EidwNUd1AsphGBU3jQJ35+f+HgKqQp+yTM70/c7UhGU9M7EJ
 R8Aj62LpBRx01yCwmsAX4bsBa5pNToe02h5Yt5bBAO+hvmeCqC0m95clnKNX9Ewbjlmbj
 +xGnww39+W0MwClM6pxHcwGYdmSDjKBDl3FjGc5/91hUMCzXeKpqBIW26V9iXpOAViRfs
 QxcxLsLaWqE67URCdp28ez3asdSW4beOzrfEcoTZViHQRNg/A17/wG/E9KvsNB5iD1G9F
 sKhU6dHfFNs6UL9q2ug3g6TjYhk09qUznI6E4y0kQbQTY7i85CYzRHpa2Zs/YB7NuSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913791;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=A46keIIw5kisdm817LqsBgoIl4m6nHtcNdy/p9dGlEw=;
 b=OfjHooxH4+aWpw1XN+gqF4sMwgfyNBaBQkwhePQg04N3aje2tp2aTm9JNRP5+aIzlx35
 Kz7FTbyTyo8d2dqCOCEes+Cxfc5excrvHWHIxzcbonwrlPLUL6LE6Cy49OPGYi8VN6zXF
 W4hcgsRq+1bPNhLKY/9BN0bJhAhq2O0E2NV5nGudd420SKc3puMpKMhZXBZbuoyWeOwZO
 ODMCu1TTD5aqeTGSM4rhUuWE07AjXJABCz0kNna22ff+oRXeQ+Ou7b6mo5/nFdlNNmxPf
 5wGusxE3xjLjuHZ3I2nWhd2D6wX4DZDuqruWkK6qGycpIGmmo4JpfXF03t2EOL8/Pog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=K4EYP4aJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=K4EYP4aJ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA55E40E32
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:30 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485ac898fa4so1863076f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913788; x=1790518588;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A46keIIw5kisdm817LqsBgoIl4m6nHtcNdy/p9dGlEw=;
 b=K4EYP4aJRd8MUW+ixLlmwbXWi4EzWHDGty0QmKnxFIl9wQIsDrJ6oYpHGUN4JKsOX5
 CyTGJh0UqtI2YVHFIulruYZcVj9+Suq+nDwViWtIKjTfZnD/ftVYs2bJHmMVtZ8M/LPD
 oA69Prhmd+kVhwX/w+fZuYXE4Mvvk90yWaNRVXt4ZB5d5Q7QsbPpBr5eMI5ioRy8vm5M
 DpJ/xio6if5kImRsyaeL4378ZJr6peTWpM+PI4lkB+XK8yNw8PvfETRwKTSMuigkRr/Z
 BpRPVLX2m2FmolTT2sykJqTibACLg1tjJkt4fGexvHRfyYw77M5SXDxScUegeMJNRmXJ
 nQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913788; x=1790518588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A46keIIw5kisdm817LqsBgoIl4m6nHtcNdy/p9dGlEw=;
 b=MnrSmLJslNXm7UKPln/OrYS1IsGSbLXEizBhw4JWYZ9HmtUXkkWFf2RT5xvfjbyWzX
 D9kSJsLDT390afdbxAnreDa/1HUSdLYoU+RVc/xZfsRv7Glb1IsVwOSwaq55k86UcVPu
 soeAqR5uyt6aGt5+QnGbAZhD2XLkY28QFgOMpYLq+cXj1FTAiTnoe4deAm0ZphJ5DJ2f
 vgg0X5SjQiKE2kvgDm0rIfokkEjWQM8yl2pV19AQNHHKwBK7NV3tjCB6nFzkc1fZbIB4
 UDvtEsaMmJhWicEyGEgpEbrkS8mS51FOhSe76N+1SIap7yAz/YHVLLWResNYSrOv5wvk
 BdfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPc2cIcY4WmNJXi2GjnDogZspg6jrLXjWAh5bc0SUBxwdfAPRV/yQdHkYoaZhhuZNVftyOuw8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n5UH5LGrUjaWHBYtA/Aj7SQVzxc2oCWr6T/0Mz3JjLiZt8Fua0
 VLmfaqk+3OeeXJYODRyVARWQd68JTv4o5Lv+RSwCrjU5qpkX0a/WSGtu
X-Gm-Gg: AYBFou3Pp7EsUqOLoVlV/B96zmYrn9/nv9ydgua3I6Y/WAL3cBBfposdBsLwkNtLbb9
 TENhUVIh8CUnlyFxR9HbtOkyao2VztEHr3Vvf6Gta4JeBHXqapDcxbEgBz4aNjQwCpEgFqk6Rji
 1OD2a15k663nRfLzYA0NoG0mEABQvvU/FGRKhes40TnNNwuns2RkE6NHe0feMzx0AitJM+GM5zQ
 HzTOfgJqml/KhbvPQQ5w4yrCVyg9csG5NVKSFBwLZKdGCe9qEbGDUwBOal6azX/+PIVKS+eYouL
 Cm7caY5umId3urbLRY5c+GQTJH75PnJTERF5IalIqJQfZbo9guLE6kg2FnMzbCXHNZVLfb2AfZo
 spdU3mU+l5wrK/HRhXMpn6ry2ef4Wsi5Kjmrg4tQzZPW8Xlbr+Tq444oiht/TzakUJdYo+NhRjA
 T43ljsaZpUgnZF76B7Hi/iVyE/67JSw2kA+HV3WQTFsJcL3r3seRA35noPVb6tiCAZe3gHsi2EG
 kTXVLQ1
X-Received: by 2002:a05:600c:4e4a:b0:49e:6e94:7cae with SMTP id
 5b1f17b1804b1-49fc5741495mr108677355e9.28.1789913787763; 
 Sun, 20 Sep 2026 07:16:27 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:27 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:50 +0200
Subject: [PATCH RFC 06/11] arm: rockchip: unbind cpu-info.c from
 DISPLAY_CPUINFO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-6-42820216369f@gmail.com>
References: <20260920-reset-v1-0-42820216369f@gmail.com>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Except for TPL, always compile cpu-info.c file without guard by
DISPLAY_CPUINFO at Makefile level, to provide at least the weak
implementation of rockchip_get_reset_cause().

In this way, any code using rockchip_get_reset_cause() (weak or not)
will not be broken when deselecting DISPLAY_CPUINFO. Previously, it
was not possible to compile TARGET_ROC_PC_RK3399 with DISPLAY_CPUINFO
deselected.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index d3bc0689f89..a76ef200d65 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 endif
 
 ifeq ($(CONFIG_TPL_BUILD),)
-obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
+obj-y += cpu-info.o
 endif
 
 obj-$(CONFIG_$(PHASE_)RAM) += sdram.o

-- 
2.34.1

