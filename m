Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034F606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JyL1UpqQ;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=HZxTAAms
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D7EE60621;
	Fri, 27 Nov 2026 16:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSHzWM0Jg2bb; Fri, 27 Nov 2026 16:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6439C60748
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796149;
	b=fuOcGziWEdtvAyhf+H/5BO4BsWp2ep0OPGCvcXco/UuJ0FPhGB8irEpBrmLz5Uz3MGhW
	 /ODBq3gf3G3FVBlPEDRsGODAtD3AUNbi0OG1NJtUTRO6SwGODk9PEtxQ7CLfmq+Eky5Lm
	 4Jfmdm5p7GX7lN2b1TmGOMhcGr2CyYobdYs8C8N1Vz7b2M5UFnOaB83yKR5qyVOD7dQF6
	 z9wtNaV+cjfPBNUphXjMue8iCF25x7dYBhXPl6rouZvffS5Cr1Jo207FEG/T03ZQjdt8p
	 T/ZvoRYRlM6syDsqm66fuuuOHODG7fejwxAdfjmABAxTELzrizakkxYuMtBY7QEFs1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q80pejnEQK581D33WdPcZxMUUsHFxVXVWysYKnJZXWw=;
	b=iG7aMO6Ss80kZCdlSasfyIUBM0a/EhwD+KoNuosdHTEl93bH6n2DbwQNuSN/WQZrbRam
	 rrbpwK74Ue+l6C+xTDPPqatWPBhqDM0b6ZwA/dqAhUuEGkhJ7qBOGBdDgGW+y8G+93CAi
	 7EBmvy9FtJMjtxxcwvDZszPhy2e0+/arFbD+tTxMPWut0E4z0GQZjlbDpa+bQigERl0ap
	 e+kVgltAkunYZjsqiW3m8cHBpnjAviFp/1wRtnELm4Bixg+fPJCqYHhZLgXFXlprjWDcX
	 ncSCgK8LKflz92ed5/o1BgFgXe1TG0TfHi1FEl4onDv/uKs1fA/+2bZCii4WlL4um2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=HZxTAAms;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796149;
	bh=Q80pejnEQK581D33WdPcZxMUUsHFxVXVWysYKnJZXWw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JyL1UpqQSCPi767P3nU+Exj18isoeOFq71IuRTGMw9iEbmIFwVtpM8zWrEyU9Ts9K
	 7MVOZFdfSTGttaBGqaFfYNFvk6IUhxJG0AGByNfK9iJ3dU5aBQsyTkg7fSlgEYeC+f
	 fe5nSzhH70DLiZ0BumlcbfRyM6LXe1njK8qGPxRgDU2R8ZVVXb7qbsXQbUd7o0AMfq
	 P77j0O8GgameB/dTfNKLzbTGR9/cVhzo4dh0nMHHseUhdpQotch7uFbAMaiIYD9lGq
	 C4dZcSsUl/jGmZ/Qoi50erALH5HgX38Bo9Eo4i4ezK8gde57vmUFHBWxTFuvyVE3aE
	 KVqMIQRWv99Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6439C60748;
	Fri, 27 Nov 2026 16:15:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5CC5311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9779560748
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36wjYtUQl4fa for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:15:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7945F60621
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=HZxTAAms
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7945F60621
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:15:47 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so5752414f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795796145; x=1796400945;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q80pejnEQK581D33WdPcZxMUUsHFxVXVWysYKnJZXWw=;
 b=HZxTAAmsNElaMlmU9ZbdNCDacN5lPDUI2yx+p6jZIFgqEGclEUZ9s8sHs1tw+IoTeR
 y6X5IPiZf/BT9uxnampyCUX7fn/tjMBD5ZQ1nxme76PIaDwgwCJpvcbMn8HTZI+nE6Lm
 hQveGRei232H+HfoPZJzrjEUEBQRThbnBovsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796145; x=1796400945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q80pejnEQK581D33WdPcZxMUUsHFxVXVWysYKnJZXWw=;
 b=ycKmjmRjGNVdcysnFjDRWrtSL+7WoItv67hPWWr9IWxNDxoPMtJuQoMXz3z+JMPsLq
 rdKRdl2yjbHmr13okgjtqLF1YhRxdVW1oAlMgdiqBhh7hJDxuxMC61idaw9pvKp9M2AZ
 k5sfPI8sfiw8zhG2jPBoRpLlElt9e/MCfZyUcSxZpErBgLa9tJgQm8ZQTy32DczSYOaD
 fc+5RDpduG2+yMmGvvip96dO4zkYHJ/HtjOJRAWklm6OB05gjKrPzD5o5hSCTt7v5WEf
 PJ/1Ulx45UH6jr9+QOFCHd9DpYnO7cSkC7fm/XSRDX9OQu3tA4XNIAUqcawb6O0oILGt
 QWEA==
X-Forwarded-Encrypted: i=1;
 AL+hErGbkb58LGtf32JdQDyolgzmJuuqRYoSERaStEfGov8g0xOpjcL0nEb0OF6swL+dbCBkTwV+mZQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/ZxMyNvBFyjOj/43yVsd3z5vxI1rU0XK5V3rGux9hYvLjR+jW
 /xNFZFWuxuybvsx0V4DB5MhRj0N1+x2gGOdqC6HvvsjwhRnXyBA3X1yGvVAkq8S4zsDEi/GiigM
 c6Fmj
X-Gm-Gg: AZFdTZdA2RMqolSQOT1WM+MwhXToYTHecRE41FGINTai8ynoebP1V5Wzf4ZSnFwgPo9
 YKVb/YAU8Qs+URs5GDnrse6RxNQoVzDa+fxt5AG3ARJHZVh26xgRQUxSONO9Q/X+XdSRFh+Rgjc
 w5CfJ+MjCSHJhyrl6pTo9gpDHfNhxYtkxa22InL53otcVZXwnR6+r6rU7zmUfH75mAwkTGMxZyH
 QbvL6aKNZrKNyvEwiZIIKlTTSrsix08igH3mBEWQ6Vb9/LUJwpNGHiVziZWURBLj6EeUUbP5b4Z
 weAmoYmqzv/41DfrvcPsB/EdjAeYkv8Dk3ChCRPCWzrYQdAQYYg2HrHbEg7zmMKn4RO+HG4gASI
 szvdZ4m2FuZw4fX+dW/MY8GlmL6jOvqbdivEcxWB/Z0c5vN/7wjbYMSM+MRf0eyZHUB/GMy2ACV
 t9lSwRJvKbVI5Pui+Qb9qEznd1PX0i35+XqNkuoF/hHWHSMYmWUJWPdWp8iuJCBzyaAPRXlvtqM
 bkJLQwxKc/QUhxvGgugF+MyOusRTqQTEwW9H8zCd2pch8YA6WHYA6Yjr4dTkJbaq1QoWSAD5z7R
 GBzNW5zDFKQRYUG1r41+cdBSACZ0tn3rci7WE0uFBrHEeGMc0w3eT2oz4RweNsO9Mixvccuj1/C
 FOMmic6aNrMdU4vo59JVYyVmVQ6BiA91AK3CsRcgwCUcQzUw1tI+hzmHiqPdfY0BzfCBvBcHtMI
 FO17xUiYlR2XFINlpSVOuQsTUaStP43KhOqBMyGpW7Fo/HOQ0=
X-Received: by 2002:a05:6000:240c:b0:4bf:2fa1:3c44 with SMTP id
 ffacd0b85a97d-4bf2fa13dd8mr5548592f8f.14.1795796145080; 
 Fri, 27 Nov 2026 08:15:45 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm50338987f8f.29.2026.11.27.08.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:15:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com,
 Yannick Fertre <yannick.fertre@foss.st.com>, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 0/2] Enable the display of the STM32MP257F-EV1
Date: Fri, 27 Nov 2026 17:15:18 +0100
Message-ID: <20261127161542.1907090-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables the LVDS panel of the STM32MP257F-EV1 and shows
the STMicroelectronics logo as splash screen on the STM32MP25 boards,
as already done on the STM32MP15 ones.

Tested on the STM32MP257F-EV1.

Changes in v3:
- Set the maximum framebuffer resolution to 1920x1080
- Add Reviewed-by tag

Changes in v2:
- Drop the redundant MAINTAINERS entry

Dario Binacchi (2):
  configs: stm32mp25: enable the LVDS panel of the STM32MP257F-EV1
  board: stm32mp25: add splash screen with stmicroelectronics logo

 configs/stm32mp25_defconfig           |  10 ++++++++++
 include/configs/stm32mp25_st_common.h |   4 +++-
 tools/logos/stm32mp2.bmp              | Bin 0 -> 7802 bytes
 3 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/logos/stm32mp2.bmp

---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
branch: stm32mp2-splash-screen

-- 
2.43.0

