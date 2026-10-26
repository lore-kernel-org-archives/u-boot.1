Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C1606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UGO/Vp16;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=I1DC90Ug;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=kRHlSLKa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6EE260706;
	Mon, 26 Oct 2026 22:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VzjFFjQRQkip; Mon, 26 Oct 2026 22:55:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C73C60603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055315;
	b=BWfJqJL2YZ2RiyFtdlhnc2XxQtMGyxln3rsFGmUXR3NLPG2ZqQkhmWK/dhbjYHxtt7z0
	 +1tUoSH6aLZOvM4hgcmx7FGZ1nJqCGnh3fzVCAY4JYh/AfVVwWLxBDkGvrKOtkNtHyxcW
	 +CmXwRYwDFuthUM+kVZkIvjPOWrJ4hopinNC+eRpcGkqRxUuoC4ZDiFjAoOTdHuQzpZ5P
	 y3fxvE4T+A9n5UJWptJ0u2YD8/ZKLRPMkecv9f+c3NUZMFsVo5hq5RglaNHKXjM4SSzjv
	 UjXM/ZrvzKu1Hu0ttRjiXV5marXESuzfXEO74c9ij4TxWv2wPBtk5vsnABQdFj93A8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VgrEvc4A7n3qISnkiDDeGmSL4tgWD94oR0iLLKDIjX0=;
	b=QMcez/p6uiiKfShyFgnlfAu+PsNhShhCs7XJmnsq8GRPPF+tJ+HAUMjb2leiWFzv0rol
	 I7TTCr2cfGSF7t4+3cicPEgsQIDPKUzSSdY+lZ5907rHqAkBvA7jWIh8dPD67ynMtUkE8
	 vh4Ou2bSA6Dsznjt5otshhIsxsr5+H2xM4E6QGEHJMyNGKtarNttMp83i1vDmvuAKnz7Z
	 DmNGRpUUGY3lvazDlQeXsJ4xR1ZbxRqx6pBSlkZGM5QMjOpJymHFm3AWQMOif3wYaniol
	 ltSeKc3Vgf+LOTvQ6Utw6dNa0DCNT3H26FnV3unITPXP/LMsPZd3Tppi+Ch+gNawLMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=I1DC90Ug;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=kRHlSLKa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055315;
	bh=VgrEvc4A7n3qISnkiDDeGmSL4tgWD94oR0iLLKDIjX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGO/Vp165+vnckl/ta/KnsIvHiE8m074X+AxJVi9sr4a13fFmsqdAZiLUERWaBi9i
	 rlvV+w+qbpHfs3CxN7nt0KiGLN8WDzz9pjHoolJbj8mjQ0W02y2dcYo7LKw03YZh4l
	 6GyVKPvgTybWwB4FtMA6MMi8RW33nq3g1gqfj3sFBctOr0vqMNjgz3O3CPRik1pQ0u
	 Jm+sfwB1dvNUjs2ThZcvl6Wz3lI2pQSthBTgFdJIkMqvjDheUyHxGivihqlLBOuOuG
	 y3fh04obU5WQNCvZiMUnnlAsSr0713XuZ7FLbF7rnERO6+GIBGC7//NwlhpJqrSfx6
	 +Z7iaAGTq39hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C73C60603;
	Mon, 26 Oct 2026 22:55:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7541120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACDA660603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKUbce-oa7zq for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1B90605CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=69.169.224.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055308;
 b=NWHCh9NpSvxH3xB5TYZHs4zNsNru+ppqiRhKcZQ+i13NkE54xIYC2xeNPd7UJyob5hAH
 vsK0iWHM0In/nhvzD/z3J5v3yCta85q0pul6ZUC7Eew/N70znVEsmNh2wwUbDCladmAad
 mv2r460BPIL5YXjEHKs0lnrcTJMqv550DuIIxjxRXLoUVamfDRGd0hztzuitGNFz+FdXX
 I+tOYqBk698/V51/oAcf7aRWJp3lBEjf8gYvgu6TfYYjVnqjMJ/tZdMn7Slv6lJRbFp8m
 nC5V/c0W1FCcjYJh6D5hUqgKr0gRxuA+O1DNgKtsS48QQU9hRpEHmmH6P+QNTH5CsUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055308;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=VgrEvc4A7n3qISnkiDDeGmSL4tgWD94oR0iLLKDIjX0=;
 b=ir5Cio34GeI8pwc+VW2vcjfYJgvZzoPRZWTHLvQ7FJFVQCFWbIYXQdgU7ZBobW9i/lBy
 L+XyitMWZGbLaTTMujVd8hIYw89N4IU7DnPXuIlGyeBgv/7J1kGfHEoQc2JWUD21kLnm4
 MCXi2oKW+gdNiY8NmblGPCN8O0RdwvJxGOl7Vtp8S2hT+fauEi3wXQZww0ruZX4LIByXM
 74ydWGc9VF3J/oU4XLNoGa+tPYKepuZ9UHoRD57IHaKIClN/eAMQzKqQ08cA3gSWB4M84
 gFxy7j7JQ2+MpgQtEkl4B+pJsWuM+PgPZtSeN2kes3mxQBycT5V1myS3NDkpYabMe/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=I1DC90Ug; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=kRHlSLKa; 
 arc=none smtp.remote-ip=69.169.224.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.10;
 helo=b224-10.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cae4e-403750e7-2448-4b7e-adb4-65bfeec8b0c1-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=I1DC90Ug; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=kRHlSLKa
Received: from b224-10.smtp-out.eu-central-1.amazonses.com
 (b224-10.smtp-out.eu-central-1.amazonses.com [69.169.224.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1B90605CF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055305;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=JF4HltkmtlQ3TNcbmP/LTBol7Y4BScVySv020U5xSOE=;
 b=I1DC90Ug5Edptw+cvjvZq/7FvJeOXOhK/I2fCFhXh1ZljAewIo3Jq+6wc4GaKaI6
 FIjBlsSfrLpGiLD3JVG7JPjBfE7uv4GjdrEzdxV7qEjdAEWlBmxIZT4JhVdmM/Vpb8Z
 OTTlK/n7IsB5/ItMKvYn+MpCHcKb6u7Sgz2syBP1Qk1SiGOBwvlgfqAUAnfmLEYoO/6
 I21NMSoT14Kaqh+7H6qHC6VS6Z0Enl74TeZriVuqdCqu0pqYOs0EnK6a97SM67wsgY7
 ZyNZoSJpKzEw2P93XkpxUwnw8g/5+EbnZQX6iC6StBy8oX6Exb77tiXqEIsKQu39MM4
 JCOkqehZ+Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055305;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=JF4HltkmtlQ3TNcbmP/LTBol7Y4BScVySv020U5xSOE=;
 b=kRHlSLKa5thcFg+N+wsBkPN/bhcUMR9326vXS92QMm/7NQLAfhu5g7YZPtXt6O7b
 xHZ+iI2KIsKvw8bu4cA14wwmWfI0PppOGzb1eNPDAWESmfne3LZ8fXEt6/FuuKH+A0Y
 OYwxc3wT3FGJqE2wnMt4SzCeqJZpx1Jn01RCLm3U=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:05 +0000
Subject: [PATCH v2 04/14] Make CPU_ARM1176 and CPU_ARM920T dependencies of
 POSITION_INDEPENDENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cae4e-403750e7-2448-4b7e-adb4-65bfeec8b0c1-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=747;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=JF4HltkmtlQ3TNcbmP/LTBol7Y4BScVySv020U5xSOE=;
 b=eHU2T33OSzPYBsNqCdDTQ8WYKVNl1/Rndc2GrmLMnLkiuUk1r3gS5OS/Tx+WmG7CK3AcESe1V
 nZbFNufliRnDNJ2InW12ecW2juPX03g+Li4XrgNJGPuYLBuoOVl4s8P
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.10
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows enabling POSITION_INDEPENDENT for these CPU types too.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..cfeec2a98cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -42,7 +42,7 @@ config COUNTER_FREQUENCY
 
 config POSITION_INDEPENDENT
 	bool "Generate position-independent pre-relocation code"
-	depends on ARM64 || CPU_V7A
+	depends on ARM64 || CPU_V7A || CPU_ARM1176 || CPU_ARM920T
 	help
 	  U-Boot expects to be linked to a specific hard-coded address, and to
 	  be loaded to and run from that address. This option lifts that

-- 
Git-157)

