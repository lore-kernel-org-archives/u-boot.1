Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E31606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WyI0gfm5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WU0Trwt7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8CFC81024;
	Mon, 16 Nov 2026 16:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AYuhdkK-JFy0; Mon, 16 Nov 2026 16:30:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E75880FA1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846643;
	b=DJMZ5bqF7sUkxFtcZsfLLVk4OqUdVgOio6Fx7YnKn+AmZ93XeSYpiESM42eKpVxKB+3h
	 g+ccXzc0Fu32tB0bd4UUUYBgogW8kifx5Ezs62v7rlR0HcEynFoJHgoDQ/CIjPuPRIc/8
	 qo7dqjZoPzCJ5qhL6RXwlyqya/gaupMAZ4mt46lMmEJV7egu01ZPxXEnXifQaXaf4Cox+
	 kL0HC91JvpmOQSdtmQrfygGSlxzGWN/LSbauxp2gtGF+mCGukuuBx3Hl9j0TZfqz0ew+c
	 c6EdGSxdEgXxub5gF7gFj0gpwZWIhnzYjeCy1DK4hUHuM8L4KuwMmAuF719JzdTG+eQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0TdAdcXtmm/PJpDZ0O07OooLvYKP9ygzDTsTzFqzPy4=;
	b=DSB0Gp8SjHBNM/izx73TEsPJ0c8BGG2xq3xTBARipZYeoreem94BPlGGQ4yvf84Z6rvb
	 yq27f/rZsaVwOsmGpKHfmU/D8/Lq7VDopTKEjyRrSTykf1Ks2rDi3Vuz8/Q7ZeUp+8RrH
	 TGKa89/2CSJJsoE0A7bYwiDeQM5USc1Z+k4JQypD7w7DqCnLW09dWY8Hwx64oVdmPT+4n
	 HtLwe/CMw/aYeJ7u5qXeWLBq7y6InjWElB4nq2fNSyhVdVwZkOZg6yJM8y76vsvTVP4Nb
	 ad2S4X3+dc/iT8TWM2IIW8I56K4OQEij8xHUlJuWhqhrzSEa5na7/IFwTFqBC+jQ8vA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WU0Trwt7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846643;
	bh=0TdAdcXtmm/PJpDZ0O07OooLvYKP9ygzDTsTzFqzPy4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WyI0gfm5nIxNKkmf0Nx3JSnoDCP7+V7jSeOpqlFm7iBT36OEy6LSZ2c8dhCUawcoo
	 S9bMFrnWiFI+P8Da1sI2Fc0Pabe24x0D+yBQX7MGJEwbMXjldv0i9/XPohRMAIQOTw
	 SBZWd2WJWFLZ369KMr1ISXtt8NDioQW3EZo1cRlFPdSbOtP1i8q5Mt4G3EtQBCMfQU
	 Bt+P6Kqf+mquwpRaeisPPsdFZM71wTbE5Hc4retpMNWS5yI/8cJKuWgKCmk5hbEuVS
	 PTXQoGoRgpJUty4kQAftqzHne7q54/bHdkuMPAZlp200toRh1u1UagDycxrg0Q9FEj
	 vwis381qSTAYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E75880FA1;
	Mon, 16 Nov 2026 16:30:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BDE09169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A98B880F19
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYzgeM9EEXuE for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8BC280E48
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=angelo.compagnucci@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WU0Trwt7
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8BC280E48
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:44 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so24247595e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794843462; x=1795448262;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0TdAdcXtmm/PJpDZ0O07OooLvYKP9ygzDTsTzFqzPy4=;
 b=WU0Trwt7pyuP+5yECxS8eNVg4NF/xCRBBr3F0Be6KYuk/x8VLA/L0aDnureEVfbRyj
 HTC7lDQuoyLe16GBVi0xC/vTUi19L70PwKIC12oypbP8EQHl4tEdRmmg6c6SonhZ5WhU
 cIBufhM0VFmo9VLeveMy0fw1rHzGq+emiNTXDHssbXZeMcRjXnNyUqndot5obmW9sXiL
 rx0FAv9jWNDdqG5AGQ90qX7Vi83r1LisjsPRb6oxZ9OfRG/jHG8qTVXJXLZ84uQdYk2o
 Fy8QMpbaMJlC2uLMLSQXBGpWOHIJG+SEiNer2VHhDsDLCo53/QJWjLt4eaeFCH6IjBzQ
 sFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794843462; x=1795448262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0TdAdcXtmm/PJpDZ0O07OooLvYKP9ygzDTsTzFqzPy4=;
 b=Nd/4wIGeSPFGTmpJGLRxYo/UIVjV01NOmWHSju+4IucW+fBmJFHlXX0J4XkcXq2M+T
 2TuKwPCdV2RkjQxS/vx8dOWjP/CdkYFc6zb8jLGtRRTpXCJsgBhPDxMKxSL6iLVvizCT
 BaBPO5QPUUXtOYcPaZ26nc+zKFGfeF48zs9AKNc8LrQtMEw8yybXeAhwdsgkshwTMImM
 AvqEhbbWudbKGdK8kKulCl8Bb1E0IMinGxhzH5zMOHAg1a+8rOsfrF6lMBPZVSvpiF+9
 yXwd1b2yiIJVQkVxQi5bc3hFdMrt19GKHwyEa69zJwigba3DwtIreHum5IDB2Z6KsVxq
 FvBQ==
X-Gm-Message-State: APuU4Z/EYTqi8hnPz3h8YmjtmcxRaGX33BNVjtdqRsirpbUwemtQmEfq
 WciY+XQbIzmmY9ADmD+6LcCbBr1Iz7aL0/7rzAPSsjfnUSOuN5PXAvtbScz2stbI
X-Gm-Gg: AYBFou2lnkvY7JjcZOnSWF51s7fLnvTBu0jy6XK6brePZgQXYYasIHStJyehyD5ZoLg
 IPW+4wrxtR6onGVY/BmhHifyxYp2kUapwCBwDilRtmY28NnFUf3kcWybT1uezNVAyvRvFfi/wJq
 ec4mYgZoLst9B9V+mRilGt30nLuUMVYr5aZagUscdxMXXVN5ooDhBpogDEe/KOGLIoavRV5FrXJ
 LwSFfXb6l280GCOPO/+RJyBjxhT+HxG0sah8sYzKgy82R+3yQQDuONNNVO7J1y1Zr0k9Kq6e44r
 irHFnt7HCMVQxbmkqtcHCPRQnVe+7SWbiLTMMr1nYLlXu7h2g3iQxL8hKM+yU3SbCfyajVAxfTC
 UCR5O3A+9U9cGEH8VJcwDt6yiKUFqQQnRK7JVeZayBDBAzA8w0pakrP5WM9RVbuAVQTGKFfizIC
 wFE/gSSZZ1WmXkepk2CBvc1a10jNEb2HP4WoS9XpDWhBdzVRKI+pqclmHpN8kcjHAvBUEbdz01d
 JdGmbvKl+bsePGkP1lRT61TXIbDbFNJN2Qj8Ow3+IeuyCNlMCBeNOIT3R/GrzGeorLFD8MuwaxW
 ja6+zpZDs5d0vuIBcU1iXZ9mXGAUzKFiIgsRcWtQuK9l+ccJaW0b
X-Received: by 2002:a05:600c:4e8e:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4bb55a8faffmr238792745e9.27.1794843462451; 
 Mon, 16 Nov 2026 07:37:42 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm296939855e9.6.2026.11.16.07.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:37:42 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 0/2] mtd: spinand: add GD5F4GM7UExxG and XT26G04C
Date: Mon, 16 Nov 2026 16:37:37 +0100
Message-ID: <20261116153739.3958623-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:30:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds two 4Gbit 3.3V SPI NAND parts:

- GigaDevice GD5F4GM7UExxG
- XTX XT26G04C

Both have 4096 byte pages, 256 byte OOB and 8-bit on-die ECC. The
GigaDevice part reuses existing code. The XTX part needs a new ECC
status function.

Both parts are tested on STM32MP133 boards: the boards are flashed and
boot from the NAND.

The same entries are sent to Linux.

Angelo Compagnucci (2):
  mtd: spinand: gigadevice: add support for GD5F4GM7UExxG
  mtd: spinand: xtx: add support for XT26G04C

 drivers/mtd/nand/spi/gigadevice.c | 10 ++++++++++
 drivers/mtd/nand/spi/xtx.c        | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)


base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
-- 
2.53.0

