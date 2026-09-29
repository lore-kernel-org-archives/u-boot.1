Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4129DCA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CCE380AC5;
	Tue, 29 Sep 2026 15:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKDBPVv4-nc5; Tue, 29 Sep 2026 15:52:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DA82580851
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790697147;
	b=rC5nx27LTbM/XgF+1I+KbVGoCBqP4hT43MfzuxOQ7vlm2xkULS31Tjgby/oS/lR43gF7
	 6EMCWkHo437mAkdXZTgon2qQMcTU/99XKVbN+JaHerTA0Skvmfw2m9rzZLvcSSo/Gtg2B
	 86igCO2M6cn+VxY+FFCO1kIpzk/B00aA0e4F0WKP3/kecKQViyhh3T4oYngJDaRmZQvtt
	 WfGK0ErJfLQns6Y/I2ayg9mP47ezFL4gcQF2VeoqXcTftoSWDFQpm/LFU8rbUZ/2m4bAT
	 rdv5YMlzgA7J5M91an1wuSlcAI7Pgia6Rqw9jXJMEPnzwyewncqwCqUfR/vpBZ4g6aA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790697147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9293zS3Q0K1vWHcoF1MrKPTxBV2rAfEhg3BjEw06wOg=;
	b=GQWokRzfPftw8v2tSQ7yrgOyJWGVIurrivhQIDx8DlqRLgBmK2hQLkGv/zNTv4aUrksL
	 TFC+yASaJT8NmmWR616gfVH5MSc+ItOaSQ4BZa+JyJ+d5PGzWOg9oqpgZ5dNgaV5HfygZ
	 egSC23pQQs+b7qnfxf6cBS8PPsB+CJ5Mzj3p0ydYWc1gSkIGCEpf7QaAs7tix9O0X7FyE
	 BbihipgxVK+C/c0xEQbL5vOAC/FyuDuoD7DLgDoWxZfFY66wbyheCRhLOZGBOAelen8eQ
	 WxzReHwjAtolXPpXTKURom95U6X8r9gEDhgE77xhy/WwjuZKfzSsLbwFkgPe6+1mC+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790697147;
	bh=9293zS3Q0K1vWHcoF1MrKPTxBV2rAfEhg3BjEw06wOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PeeCNn2VMir+lrWaBtibhLFZy0PeXH62wsWiECgj9X3KvB40pl1aMMYYwSMg5EfF0
	 ap0kml5MkgJKF7Jow010++IkMiQdXO3wKMW70AgfBfdgA062kY7Ymt8O+MRSKCU58E
	 F0hY1O/hwmqq2+y9ImxHuvEnaSKdHgpF67rYYJln1vnGSIafsiQAr2b0Oq2vzUllOJ
	 15USMHP/R3ZAxzdHRgQ+zFYwMjjFFsvkkbQg5kvein4PNtDPio8TBG7oJvlIOJcmEU
	 L+4Cfr+aQugSYHqZyPg7fE/ECc598M50P7DFybNjcmb1TmZDPpt35lPOUoYpgwHvHe
	 QlwXcDY4T8byg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA82580851;
	Tue, 29 Sep 2026 15:52:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F20832A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90C264032C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nsZvf1QSTIX for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C108E40331
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::24"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790697144;
 b=mXNyopal+ejZO1PSajCmwx8dhopuv3FKgjiQpoXG31AbaukmDwrGe14rJaDKJ8aJrvQ2
 9qT1d2kZwsUgcTLHzdSRRd3MTxIU84UwihRHb5lFluoVV1PyYrde7dTB6UQV2yi3vrJ88
 AZNHeqafJWkvs7iiSIA803LE1Io2XH2icwCYVnbueCh8Edt2EYqk5RgxlloSwCfLoj9ib
 1pKRIcWIMl9Ae6BK5KZBiPFBUzQs0mI72O+9HTKMy7TF2vhC0KCKnSK+vFZ8uhMH8qnrX
 isgbNwTPa39P23Du9wVhpBrBgBUu9RMpIIXgUXxrOSBfswhx5hlVJf4REBvr9p74mwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790697144;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=9293zS3Q0K1vWHcoF1MrKPTxBV2rAfEhg3BjEw06wOg=;
 b=Mq77fDz8ltd4/zqeL6LaN+/TAthKIRMJvmyVukjKY3kPFvZukZPuCVX89OO6e7drLUYc
 aTlt2hfc50t+gcyi0jjxDU3JTsdA44ZCRt++YslNjjKfxYAxUslMuhXwrqwtDdzkUJ2ti
 wV/F+eg0o6MvJHBDiuuY5DdvR0zlaXllcALjrO410Ek6/ahAlJHgOGr4Dz6S262T+j5GU
 vufidPE8UsjW2w41ailVUAIBQg1oO3PXYM3IJIi4LrUsIpWWDX3tjgMFN00wKFtS50j0s
 aknV7Z2ooCsdad4agYbi2XulNqLJT/f+RtXbDwEfOrV8Vyzoua6gHon+Lpj91AXQbuw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rsaORDSA; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::24"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::24; helo=mail-wr2-x24.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rsaORDSA
Received: from mail-wr2-x24.google.com (mail-wr2-x24.google.com
 [IPv6:2a00:1450:4864:30::24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C108E40331
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:52:23 +0000 (UTC)
Received: by mail-wr2-x24.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so3450312f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790697141; x=1791301941;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9293zS3Q0K1vWHcoF1MrKPTxBV2rAfEhg3BjEw06wOg=;
 b=rsaORDSAuLBxvxAz09fvJXaZ+rBuhOEmPGWr750FrPJDfoidNZ/kLekG6tBc4Ec2Ok
 62jWEDSDoYK1Xj4mhTDkPSdq/dDWy3QVg+cZBTIVNk+Tnu0bRWYo2eIofSjJ5C93dtzG
 /TU1Gfyf1aEsd8gIjV/i7J5ZS0VykThokfyMedEPhgjKBlFDTy1fJPPYzpNlyRtOjfYA
 eK014LMF2WqwEWwwopNTOe2nATj01ZlrY3Vi3epL3dPbW0kAybQhFfvQ9BNXBCmuuBda
 sKZvB/AYmv1fOPro+bTfSQ0JR6qedw0FglQ3k5ImabDZ9UcnqWjoQQhIggs7s4H1sUEQ
 INyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697141; x=1791301941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9293zS3Q0K1vWHcoF1MrKPTxBV2rAfEhg3BjEw06wOg=;
 b=Wvbf1iL/xpQYsSNzzeKPaKDFZGgF38bedUHNzlNAHFxeWuKlmtzWOst0wixeaiagVz
 V8CxVB+MKL9HmPTj48pN+4bx0aFLmqf4riq2vKfiuNsiU7OKw+Nm7lUUHja0C8oLTs4I
 qs2kT6jEr2AAsmsBvCoARfJUOTdUGHhLYSNHpG650Vbe6VurbhZN1bbp9RqQOOewIhpD
 iM1lEdj+VB/A079ICrj5v+yo/KYskZQzmiLjA0qar6tB9umMYQQ4lBs+gwzAbdpQxc5E
 yaXk1+F3VevmBCK0XTEUo+9HmrnodRrCdTRcukwfuMFpDsv3YeDO7k1336uufWW47/7T
 t6nQ==
X-Gm-Message-State: AFq9FYIwVFQhMBR6K7nUlc28idoHG9AGDe3H1V3kPXXihww50W8nKwWX
 xnw/Y2EN6LHIkvC29dla71nVWqIhqEeQkigrZDSJlcnPJE3Q54yi0PNMQqFJHZ4=
X-Gm-Gg: AYBFou1Iwr3U2hmb3KMgTq0jy6+5YnfDNFevnewm/y+JMRIu+B/Xuck9wMDmo1Efs5l
 0JEvHruuxLP24uxIoTUsyNf2ozxsk79QvWFD5ZWLtZyczJ+q8gE9wTHaO0O1CJUcq9nyFmnZWfB
 uuKb0P3wHRSxlSsJgPj7ulc0zz7JD9+us4qWKDdkWUqTafau1wJncFcU+/6z9Fw3kKoMDDowSHM
 l8nWyo6RpvQAAUs94gz8Ss7AzMN9stx0RarCHqjU8YtY6LPl2s/3QeyU8C5ucG70gBPEbUNUYu3
 NZMlOnQyaEp6kCkTkJZDrRUqpDcOLFp5V80ixtGAm/OB7xowW+ZUonSovt+/mRYb/bjMlOZW2bS
 /HYQWi52BY0Yo5V8kaQrIL8XPeou0Hj04jZovshj6InnXv+66BeSaThquDpP+i3jiG88g41loXE
 Bp4cgBwt+jpIpAyg0/NGe7eq1bcK2TLzqcH2CT/f0AiZH6kD8ULj2VkyHnNYOanQ==
X-Received: by 2002:a05:6000:2a0d:b0:488:7df9:3898 with SMTP id
 ffacd0b85a97d-4887df93afbmr18021624f8f.56.1790697141411; 
 Tue, 29 Sep 2026 08:52:21 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af507611csm4716395f8f.22.2026.09.29.08.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:52:21 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ansuelsmth@gmail.com, mikhail.kshevetskiy@iopsys.eu, sughosh.ganu@arm.com,
 xypron.glpk@gmx.de, Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH v2 2/2] configs: an7581_evb: enable the Airoha TRNG
Date: Tue, 29 Sep 2026 18:52:15 +0300
Message-ID: <20260929155215.35169-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929155215.35169-1-sochnev.v.74@gmail.com>
References: <20260928224338.505923-1-sochnev.v.74@gmail.com>
 <20260929155215.35169-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
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

The en7581 dtsi from dts/upstream already has the TRNG node, so only
the driver needs enabling.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 configs/an7581_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a615994cc..3f8656f49 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -77,6 +77,8 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_AIROHA=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
-- 
2.55.0

