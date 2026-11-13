Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A30607C34F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A82brJXW;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=YmAE7Y0Y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BF4A40DA7;
	Fri, 13 Nov 2026 17:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJ-MKcbt2GkF; Fri, 13 Nov 2026 17:25:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5CB740DAC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590759;
	b=ezTidaOegjvniD9fZAAtErD1XIHipQWj9xkgy7f/kd472xLu+EDm9yt9fJ9gEex68JZP
	 45Bt557ilngRjEbfccL9Aqy572GTvGA5PVlkr5fiKy0guGq4oH/E7If3xnM3iJJG1LnN7
	 bXb3zXddXSgp33v/HAFYYo/jXN8B8d0MPb4+1GB1Q7mWaRXX2LxFhLSQ2IE81GNur6XuJ
	 uWcmaA8K6VVP9BGkoOncW5Vrg6a37PoiXqsHErr/m/E9+rTRzHzjq5111EOENEi/9Znee
	 m6ybkjGGMsdA+5Bjj47mH7Hx17QLNNcHGiPdxoqJ5GCEsYyowMOWwIjj+xbran8qlbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4Y6Sgs9OgfgIOkzhnNLI2t7BGVSqRG2SmPShzyre8CE=;
	b=SGZJb4GLgW2iuH08yGRd3Ud6J++Qycs6wdmi+tLzPe4m8/GbrFpJB69tMuPRwSBEPwUe
	 RzkUDszJAiWoFsg8mtOrKq4CMC7QtsqzQ3qiiEkjPMmm8/I322dbw77Oah8rObdg5zRc3
	 93ojep1HisJSNXVEkPNrUVK4kbWMGkRnswF/dSJkB2PAKWiLAo5Yal/zlGJrMJ83beQ5m
	 XwaAM4mi3v+FgdogdD+P/fHcREoAMMZLbWVCfTudH/wvU0asCIJhqvelRr7OWZz6HBGIw
	 ZPPTGzzh34GRTV6XEaXAuOqxGnBZDUN1ZIGWFTKmdCssYJIgNASLFsdnWdk5d+iVJ+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590758;
	bh=4Y6Sgs9OgfgIOkzhnNLI2t7BGVSqRG2SmPShzyre8CE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A82brJXWvJ9hFHcP3UEgegjEcBN8Uqi5Aa5PJu2JUZiHsveIQV4qmrf8J9yP7hkuL
	 j8lt+lsRbQkx5NTQkBrOGL5A+WVYulQ5YX94s+McKKHjp5M2xxzHTQlJdxnOE4BKFg
	 LD2h0rO68HYkRCEWgT3s9bKSQjviRXTSnPljQ0LUnFJ/k7Ix2OlebDA7QRo7ZFBPCi
	 oYagtdQcatuNLQTzEZX/2YCwADOF5tVH22E3B7je5mGizQgy9Xq4cqlp4DwpkUtZ36
	 Ur1bX0OC2Z/kauNNKcCD62zH7hslcbbPNky/0nu5vWEyN/YKZwLblApOOsPiP6Ymi7
	 fbcxy1nvN4Mow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5CB740DAC;
	Fri, 13 Nov 2026 17:25:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A079F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B77660733
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpHAC6V2cY8I for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:25:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 471CE6066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=YmAE7Y0Y
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 471CE6066D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:25:55 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1758762f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794590754; x=1795195554;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Y6Sgs9OgfgIOkzhnNLI2t7BGVSqRG2SmPShzyre8CE=;
 b=YmAE7Y0YP3rLjiZpGaP+sPN+nTMfGEP75lrCuhojL0SmuNbaUH8vn+b3R2jqY41t8m
 18N7k+mAfsbxKey/xfT8Wx/lMMT//cGpbcW7aS85Qi1HYI58ioC3Sg9OFxrFgXME42TQ
 lhHOOTj5AO4jdPI0N6rdLjDiKfuTtjIZYJ4Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794590754; x=1795195554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Y6Sgs9OgfgIOkzhnNLI2t7BGVSqRG2SmPShzyre8CE=;
 b=bdQcU3fCgbkk4KXD5Wxi2cxwaE5K9zJ4z8ywj3esU5Sq3BzX595kCwfLlPFBSyNnVo
 ZMBBwp9RtnGBfFSNm7TLnPJNLaffHjemgY0ip0eKN5jWmsj0PVuD1Qj+yHOjYuxYdnqN
 jVWigR8x/brfuFMZgk3lFSUBsFzHRC0VO8vAj/zvZeKXp8HMgi5w73WmFSP/weom018T
 9wXYl9BBLeMKl5GjkND5v0PKh7Wmm2z5z1kBdhXLjgJGLrrxXYo0DUI2vEWWto2WaAj0
 EHs63woCzOOj6OgyX4RrKStg6DKiHjHcO/CMFVMfQQBm/ehTa4ym7oOvaOEHk51HUeJv
 DFhg==
X-Forwarded-Encrypted: i=1;
 AL+hErEoRcVg17nEYSSnP8TziL0M+NeaHkdb74jK8u4TCfWRXh0KknxsOlcS7aQRptA2i79rYrePfkA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9hA2338Wi/r6HtuOwrh3Arht3ustQBKSOhV/gD4r+mgAzV9CsN
 vZMnMWWfJJqwOYO4mWWX6qTk5nzYiQ0KIp0vnzhV0pYSQ84YA3SI3azNfoRyRpQgpuU=
X-Gm-Gg: AYBFou04okD4f6rp1PbiIHG4eweehBWnM6SFkuesbf541d7Pk1BSvM+PLRwieNzz2bO
 bwNkJIswP6mMcyHEOCAI86sGW1/6ipcd5UhZN3P7gRRs/j8zYc4kOWih87hymk8iwm7AMMPH/H1
 r3+wTtMPNxCUFliTyk786DQlppYQrAByPwljEiJXQXdvey7NBDJUV4YsPL+e+42M15bE/JsS8u7
 yEsYdBVf2IEjNI9uXqNNqYr4FOTlnWVpPLuFkiD5Ok2cZB60eJsjuYEjv9obZ6fW4ayc/4kDjIs
 J1MptKyJadAR/c6RGiZWPZ7slnforFIT8zdMwj6wYVPllx6XfpbCFPjgpbGXyemORTKNIk+Cu+O
 bTGhUNuU4PEtgoZmSRj9+aytE4A3ByJJvSEenklKINam1u6MXL4Jw2eMKl84DCZ9E8AVBY+P6ce
 J4oNB6K/kucCb6aah9crtLrgkFJjDHkhtTDUAZO/7yupKJ4h7jsQgutIzJHFwJef5mWCH/EBrv4
 BAlZuDZ6gV/A/XyuM3Pi2DYjFRX7KlWU0iTeRpPWg19P+0Cnffs86dqBvb0jDmRG06swtEXDjS4
 iqqu/0XwEgJhXvUnlJ63Qmg6KzSr3nlfaYUEUJqIsRLW5A2EXPi0APhiMmTGpMIrpNMdxlsVheu
 7mnGJPyPFHqKvO/dy8LdmxyFctb4AvzJvj8s5AXJvaB8EqfYDtFJ7IGzDhSJpiMJKVcGR2+Ma5k
 eVDy32tBmfNmE8pYAiRKvI/QTMIQ==
X-Received: by 2002:a05:6000:188c:b0:48e:2448:ea23 with SMTP id
 ffacd0b85a97d-49c720279f1mr6836156f8f.55.1794590753700; 
 Fri, 13 Nov 2026 09:25:53 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm7312526f8f.0.2026.11.13.09.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:25:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/2] Enable the display of the STM32MP257F-EV1
Date: Fri, 13 Nov 2026 18:24:59 +0100
Message-ID: <20261113172541.473641-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables the LVDS panel of the STM32MP257F-EV1 and shows
the STMicroelectronics logo as splash screen on the STM32MP25 boards,
as already done on the STM32MP15 ones.

Tested on the STM32MP257F-EV1.


Dario Binacchi (2):
  configs: stm32mp25: enable the LVDS panel of the STM32MP257F-EV1
  board: stm32mp25: add splash screen with stmicroelectronics logo

 MAINTAINERS                           |   1 +
 configs/stm32mp25_defconfig           |  10 ++++++++++
 include/configs/stm32mp25_st_common.h |   4 +++-
 tools/logos/stm32mp2.bmp              | Bin 0 -> 7802 bytes
 4 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 tools/logos/stm32mp2.bmp

---
base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
branch: stm32mp2-splash-screen

-- 
2.43.0

