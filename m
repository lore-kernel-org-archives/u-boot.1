Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498CDC982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 18:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0106060DCB;
	Fri, 18 Sep 2026 18:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nYIlt_AFvsB; Fri, 18 Sep 2026 18:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A4D0B60DAD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789756470;
	b=d2kk9I8m7FBkoBoIhh2foMa7lcdaTnG+fg5bn1zdNQ8phi+Kryx20E2QAfhgZ3P/xYNL
	 Jranx04ZzD4Oi6uv9Ldbh5TeO4TaYL5KWtFYwbi8P2QaYDqaTIdhTvnoTJUB4HwTX8UFJ
	 0VIGf9g18KcoxPp6cGeKLP/BSPFSv5IMv/HUJsH8kK+3R1ZVuDXWphVMTzXnMknlQYS9m
	 f+oEnhi4uPWU2+X8rXgjb10aGSLpWTkPi/OFe2HnsD1nh1IuiAUsoKyOy4kKgTym82G8e
	 nh55Q+qlZ25i6UhblI0RQX0rFvvFWn6qjV7eHdH1hj+JDwA2dMiJA8k5okF1zMwR4IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789756470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bIzc1c3K6j+SHlxQzC5wnzPThlMwvHzYPAtbGYq4aR8=;
	b=NFT5RopQsb44qG6rtzqbUUTEa2DDH2MT6YR4L0rtfGrEmLhMSa3Y4hDUEmUUTw2L3+CE
	 Vc+V2Y5pb2/9mbBgwwIt0t/tWYLsifRt1M8P2tlqmEvr7+1CXMYz6ijk5RxB8JU/yg92Q
	 aP9nhoczYLAaYSD5uzg751aPz3AuiBIqfQcOGP8U/N+3bzwZjUEiaA8fR4V6fh+M4u1kz
	 PJS03UnJIFs4tCvX172tKL7mZjHDKSOeKLQ7vER13aeN/iDaTtAQ0GTyfwtC8AtDfwlHC
	 275ZXLdNnEjDjnAZvP2aqmItBD7YwgoTB0izRlHO2mzpAmCj3O05xCenOYoSokppgsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789756470;
	bh=bIzc1c3K6j+SHlxQzC5wnzPThlMwvHzYPAtbGYq4aR8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hMO1xrJ110ZD5ojDb9honHTt07AzjpYI+QBT3kzFKaDUZQ8+8e45Vgkt91+F7jwDi
	 PvTWUKCJlBC3OpGsb4b9sJGCelTi+2nHA9I8XBhSSTR7MQUo3B1TaCTgg1WNKMyJoe
	 /xzCGSK89g+kahXVVTQ15AOwxbHlihdvmk8edzvYTkj0AflocmO6oAo0cPx1KKg9Df
	 Kz9co8TZ+bNp1xtbwZKzQciOFI6Rc9tGeuPPJVaqrIXUvR8izP5d+Av+yKh13/XRLT
	 Iw2zOOkDsL7B6Zy0Ikkxzk6fhLxh8v/fCZwPimAhsj/jFALXXKOjLMXviuid4zDGHt
	 grlk4hT2D0iag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4D0B60DAD;
	Fri, 18 Sep 2026 18:34:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A128A13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92C4A81346
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kb7fj5BscU-5 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 18:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5DC8B81344
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789756468;
 b=BMZ3u+edFZf6OGjdbArZVxgPaA2LzTuQgKwVmwWYlMBTzL1tA588ZVvST1PY7HIHlxoT
 heDnpxn8NkY9EvsnYB70athljCU2UCIw3z3U6V/FZWQ9jHxojbvziZJxtlXzsl5+s82NQ
 L3TaVIPEMqJJ36xIoT6Vr2gcgGh2pPlwuOWOGk1fKDqiXiWWr1LKNUAFuWi+JXyktNjsC
 2bRvgp/pqG6QkHSCNSoFeakhEI72jCW0KhLb5BWz+pDXAdVLAjm4mQXHmFHXqXLwjaogG
 HDkQzL1YhVtCLYYq0aN3iKP6dpzJ94ooeCYPWQRrke3lRcs493Md3voPHzyHt2noFRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789756468;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=bIzc1c3K6j+SHlxQzC5wnzPThlMwvHzYPAtbGYq4aR8=;
 b=ITg7P4EJwg7xnOQo/CfTpMwoRP+yaX15daHnG62Sx2OoGyY2jo4t2rnOGlRwdPpk4+jz
 dVveL+yDezftDxF2C0GyhKyNjw7FkqbbxvbozCkMvvwI0tcGg8L0t14DyrXErc9qw6nav
 gm9nlbk5/OzHx6c90NrCWCD8wQPpgkICNbKgHVJk/uRBx+66O3rtkikd1uv/1eq/Sef7/
 8i8Ul2fZalWOXsVuallzFtH1Y5huTdMcyVTzZSdWe8C571YXfqDrzHpd7+IQARhPvNpf8
 MKVDWrvLh7u1NxTwKAwKf3q9FbW+qd5y9xudC1Lgp4QilpKlo6UkE3AUgL1jg2Nxl6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZdQDJdfb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZdQDJdfb
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DC8B81344
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 18:34:26 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-46accbdfc39so1232034fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789756465; x=1790361265;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bIzc1c3K6j+SHlxQzC5wnzPThlMwvHzYPAtbGYq4aR8=;
 b=ZdQDJdfbRB9Je1GhR5sEbeBz47BkwxdT7JInyurUakMP33hQrDO3yiNp2k2wdw5wPP
 YaKNOjH4r2grKwOtBJ6mXAA1/9Rk7wFHopTzvgQYh4eQxGJBg0PTdaU8clJjXdiXGY6+
 HiOpKQjnxgAuL4HG1mUQygZCaRPrMpHFdng4YmFmmC94rrQNsCdMV+gUok61fH4Nje6x
 LbHoijQJmsKnexoauEOMLplhSxFUYndt45ha6JWTOfVDQ3GUfL1MbtA4ZdAToE2Ygptq
 BOzd4uYOmJrchOhPmDPL1KLAJrwJ0X4k2SNc2okrXSAIFUrz5da7OFl/5k8r5r/uKy15
 i0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756465; x=1790361265;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bIzc1c3K6j+SHlxQzC5wnzPThlMwvHzYPAtbGYq4aR8=;
 b=ZcuAm0XfoDSk+qq11FslSJY1PchF+t8MIbfOH/f2C1ut0sRCQhZWUn9Pc5FwDZjO8F
 kCzhB37l8OY3Rxi/pPKOArwu1rMDLMWJknWTNzZJplUPdpDbWn4+cCtJ4daB3pns2im8
 raAhGQ/qvN7UguS3S5FpjNzOrp3Xw6Pr6EUzrInh775kkLViyi8ofUlTDXS/8lnkURfQ
 XMQuAI+W8ysx/tyRYRE/kwh6i9H3KnQY7dQ5nD4I4EyeLnCf+o7YQaYiwrqrEWXNCl0m
 iP2nyEucHGz3b5PhGKhvggQ9xHbWIMSaiumo3A5Io88W2KHLB6p8+kjwMk9Bdk4baqnQ
 LDnw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQdyOWzS3JGs6OZhNxYYLzDOA09Q7YSE/Is4M5FuTkH9XCnz6zI6keKK0sVbxW3dfq/c6ZrBo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mbk2h0rWXOOk6sqkcoiQb8bfmOgszTZFk7HlLgnxwKqYZHUb9v
 Ug1ypsHhmUrZjJMMCg96AgUGE8OKbwwAjMDywMey2aP3g1dR7glnv8UlHMR4TrrPXUg=
X-Gm-Gg: AYBFou3QT2GLz4KTWAevh5r6o5pECF6AyTVNAd4ek9QffYLs0TpPCWaMJZ/fCZ/m/Kd
 E91jDUqw3tynqDqfqnlKRoo9ZJR3yUckKzHZR2bH1DesjWyAqye3X3ERF8hO2PDybX/+vewyQ6M
 BmEunj0k7UcoPgHa39GKvfveaArQTUt1BZS71iLu2UcQxU8oDnpWBwynWBs/4pZaopIDBvppz1J
 RXgrMILtj53To+axVNMXT1sHbwMCc1DcOPHH+pR8OL+UQ/q4aALdtpj4g/4sbGakRWoybhtk9CP
 69lvtedK22iqvyZtI8MM5764EFiaIQbvBVIhg9GQu19pRBS90ouC6EBhwK3xkYe12Mzl0x9G1cL
 hBFl2j8ZoU8byzHFBx4HEywvAZOsGEa7gv/1l3VZZdB+1Tkri8WNxV27N8juPgZRsM1mbZqbClj
 sFXohcHoKfM6siHePUhWeVUY0UOvHjrGp66qvjdwQfI25BikRKvHTdBM4kj60VLupB147MwyI7m
 F96hOlBk7lRYg==
X-Received: by 2002:a05:6871:3865:b0:41b:e633:baf4 with SMTP id
 586e51a60fabf-486e4bc49dfmr4144267fac.3.1789756465277; 
 Fri, 18 Sep 2026 11:34:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f41d:ad29:ec63:be4f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4881f4d7861sm86549fac.1.2026.09.18.11.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:34:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Sep 2026 13:34:04 -0500
Subject: [PATCH v3] video: panel-startek-kd070fhfid078: new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-mtk-video-panel-startek-078-v3-1-631a63ce255c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PQW7DIBAF0KtYrDutwdgmWfUeVReAx800MSSAU
 aLIdy92uqi6qLpCX4zen7mziIEwsn11ZwEzRfKuhOapYvag3QcCDSUzUYuuVlzClI6QaUAPZ+3
 wBDHpkPAIda+A6502jUK1G3tWhHPAka6b/vb+yHE2n2jTSn5PBLzMpTY9xpjREcH6aaK0r9YyO
 8fkB9LuZcLyrF2jD+DwmtiKHqj8h9t2Qeab8a9lMwcO7aikbnshpbGvRt9OZAI+l/qNzuIHJ7q
 /OVE423aNFKbvVdP+4pZl+QKjs8uabQEAAA==
X-Change-ID: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7
To: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12815;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=bQ3exQJo9Mw+VEtJGQf5bLhVaZw0kWG5vx0X7LP79Z0=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqrYQdd5AfWO1+yss86LwT50d/XC6N9WRqX03kd
 ll7hwm7wQ+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaq2EHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuSUH/R/UgTFS1uQcR3U0R6QWQ1QV8CU7NhAs01RsCo3
 gRaHaoO746/kkyTIXqpqcxKFgmDmfWuVD03BPhvj2++KQm1cmZL4u2qdoSQgPE/N1y+N9ULLN9c
 X+kpuQh/x95AMJyrYEbEzHOI0URKteUJ/dHC/OA47PUd5hvf/Jz2wUtJp6o9eBvzSKVGyvPghDp
 p56of7PYmzApZ8Qq7SD7oAp0GAeprEpB7Qm2xiDKrNm6MRCO/jcQU/6Y1o+F+k6Y5VU153ViQ2s
 Cc+DhlOyoPYFWS2yK68uBkWEt9sztmnuZWhh0fMtk2QlkxD9c0ODqCCzozFI+DxUSpkrGXlBOGs
 682o=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
used on the MediaTek Genio 360 EVK board.

The display mode and DSI mode flags follow the upstream Linux driver
panel-himax-hx8279.c, which is what the "himax,hx8279" fallback
compatible in the device tree binds to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Note: no defconfig enables this driver yet, since there is no MediaTek DSI
host driver in U-Boot at this point. It will be enabled together with the
display pipeline support.
---
Changes in v3:
- Undo mipi_dsi_attach() on the panel power-up error paths.
- Power the panel back down in the same order as the Linux driver.
- Dropped the dead IS_ERR() check on the optional enable-gpios.
- Simplified the return from probe() and reflowed the Kconfig help text.
- Link to v2: https://patch.msgid.link/20260826-mtk-video-panel-startek-078-v2-1-c56342b77835@baylibre.com

Changes in v2:
- Added missing BACKLIGHT and DM_REGULATOR Kconfig dependencies.
- Use the display mode and MIPI_DSI_CLOCK_NON_CONTINUOUS flag from the
  upstream Linux panel-himax-hx8279.c driver instead of the MediaTek
  downstream driver.
- enable-gpios is now optional, matching the binding.
- A missing backlight is now an error instead of a warning.
- Do not request reset/enable GPIOs as active, so they are not asserted
  before the regulators are enabled.
- Use mipi_dsi_dcs_exit_sleep_mode()/mipi_dsi_dcs_set_display_on() instead
  of raw DCS opcodes and check their return values.
- Dropped stale InforceComputing/Linaro copyright and author lines.
- Dropped the unused dev field and the unreachable mode check.
- Link to v1: https://patch.msgid.link/20260814-mtk-video-panel-startek-078-v1-1-5f84a57244bc@baylibre.com
---
 MAINTAINERS                                 |   6 +
 drivers/video/Kconfig                       |  10 +
 drivers/video/Makefile                      |   1 +
 drivers/video/panel-startek-kd070fhfid078.c | 276 ++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fabcb8b2968..b3bf5b1f8c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,6 +1723,12 @@ R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 S:	Maintained
 F:	drivers/video/panel-startek-kd070fhfid015.c
 
+STARTEK KD070FHFID078 PANEL
+M:	David Lechner <dlechner@baylibre.com>
+R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
+S:	Maintained
+F:	drivers/video/panel-startek-kd070fhfid078.c
+
 TARGET_BCMNS3
 M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
 S:	Maintained
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 37ab17f0ab2..93d7adce363 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -330,6 +330,16 @@ config PANEL_STARTEK_KD070FHFID015
 	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
 	  built-in LED backlight and touch controller.
 
+config PANEL_STARTEK_KD070FHFID078
+	bool "STARTEK KD070FHFID078 panel"
+	depends on PANEL && BACKLIGHT && DM_GPIO && DM_REGULATOR
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for STARTEK KD070FHFID078
+	  DSI panel. The panel is a 7-inch TFT LCD display with a resolution of
+	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
+	  built-in LED backlight and touch controller.
+
 config VIDEO_BOCHS
 	bool "Enable Bochs video emulation for QEMU"
 	help
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 7a54f1f290d..7a7b54e6b53 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
 obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) += panel-startek-kd070fhfid015.o
+obj-$(CONFIG_PANEL_STARTEK_KD070FHFID078) += panel-startek-kd070fhfid078.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/panel-startek-kd070fhfid078.c
new file mode 100644
index 00000000000..b86d5197ab4
--- /dev/null
+++ b/drivers/video/panel-startek-kd070fhfid078.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ *
+ * Authors:
+ * - Guillaume La Roque <glaroque@baylibre.com>
+ * - Jitao Shi <jitao.shi@mediatek.com>
+ * - David Lechner <dlechner@baylibre.com>
+ */
+
+#include <asm-generic/gpio.h>
+#include <backlight.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <power/regulator.h>
+
+struct stk078_panel {
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct mipi_dsi_device *dsi;
+	struct udevice *iovcc;
+	struct udevice *vdd;
+	struct udevice *backlight;
+};
+
+static const struct drm_display_mode default_mode = {
+	.clock = 156458,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 50,
+	.hsync_end = 1200 + 50 + 24,
+	.htotal = 1200 + 50 + 24 + 66,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 14,
+	.vsync_end = 1920 + 14 + 2,
+	.vtotal = 1920 + 14 + 2 + 10,
+};
+
+static int stk078_panel_init(struct stk078_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	int ret;
+
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xB3, 0x52);
+	mipi_dsi_generic_write_seq(dsi, 0xB8, 0x7F);
+	mipi_dsi_generic_write_seq(dsi, 0xBC, 0x20);
+	mipi_dsi_generic_write_seq(dsi, 0xD6, 0x7F);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xC1, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xC2, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xC3, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xC4, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0xC5, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0xC6, 0x0A);
+	mipi_dsi_generic_write_seq(dsi, 0xC7, 0x0A);
+	mipi_dsi_generic_write_seq(dsi, 0xC8, 0x0C);
+	mipi_dsi_generic_write_seq(dsi, 0xC9, 0x0C);
+	mipi_dsi_generic_write_seq(dsi, 0xCA, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xCB, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xCC, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xCD, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xCE, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xCF, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xD0, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0xD1, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0xD2, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xD3, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xD4, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xD6, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD7, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD8, 0x07);
+	mipi_dsi_generic_write_seq(dsi, 0xD9, 0x07);
+	mipi_dsi_generic_write_seq(dsi, 0xDA, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xDB, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xDC, 0x0B);
+	mipi_dsi_generic_write_seq(dsi, 0xDD, 0x0B);
+	mipi_dsi_generic_write_seq(dsi, 0xDE, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xDF, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xE0, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xE1, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xE2, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xE3, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xE4, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xE5, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xE6, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xE7, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xBA, 0xF0);
+	mipi_dsi_generic_write_seq(dsi, 0xC8, 0x07);
+	mipi_dsi_generic_write_seq(dsi, 0xC9, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xCA, 0x41);
+	mipi_dsi_generic_write_seq(dsi, 0xD2, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xD3, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD4, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x8A);
+	mipi_dsi_generic_write_seq(dsi, 0xE4, 0xC0);
+	mipi_dsi_generic_write_seq(dsi, 0xE5, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xBF, 0x1F);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x12);
+	mipi_dsi_generic_write_seq(dsi, 0xC2, 0x1E);
+	mipi_dsi_generic_write_seq(dsi, 0xC4, 0x1E);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xB8, 0xA5);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0xA5);
+	mipi_dsi_generic_write_seq(dsi, 0xBC, 0x11);
+	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x48);
+	mipi_dsi_generic_write_seq(dsi, 0xB8, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x00);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0)
+		return ret;
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0)
+		return ret;
+
+	mdelay(20);
+
+	return 0;
+}
+
+static int stk078_panel_enable_backlight(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	stk->dsi = dsi;
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
+		return ret;
+	}
+
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 0);
+	mdelay(10);
+
+	ret = regulator_enable(stk->vdd);
+	if (ret < 0) {
+		dev_err(dev, "enable vdd failed: %d\n", ret);
+		goto out_detach;
+	}
+
+	ret = regulator_enable(stk->iovcc);
+	if (ret < 0) {
+		dev_err(dev, "enable iovcc failed: %d\n", ret);
+		goto out_vdd;
+	}
+
+	mdelay(15);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 1);
+	mdelay(10);
+	dm_gpio_set_value(stk->reset_gpio, 1);
+	mdelay(140);
+
+	ret = stk078_panel_init(stk);
+	if (ret < 0) {
+		dev_err(dev, "panel init sequence failed: %d\n", ret);
+		goto out_iovcc;
+	}
+
+	ret = backlight_enable(stk->backlight);
+	if (ret < 0) {
+		dev_err(dev, "enable backlight failed: %d\n", ret);
+		goto out_iovcc;
+	}
+
+	return 0;
+
+out_iovcc:
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	udelay(100);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 0);
+	regulator_disable(stk->iovcc);
+out_vdd:
+	regulator_disable(stk->vdd);
+out_detach:
+	mipi_dsi_detach(dsi);
+
+	return ret;
+}
+
+static int stk078_panel_add(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "iovcc-supply", &stk->iovcc);
+	if (ret) {
+		dev_err(dev, "Failed to get iovcc regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vdd-supply", &stk->vdd);
+	if (ret) {
+		dev_err(dev, "Failed to get vdd regulator: %d\n", ret);
+		return ret;
+	}
+
+	stk->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_IS_OUT);
+	if (IS_ERR(stk->reset_gpio)) {
+		ret = PTR_ERR(stk->reset_gpio);
+		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		return ret;
+	}
+
+	stk->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_IS_OUT);
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &stk->backlight);
+	if (ret) {
+		dev_err(dev, "failed to get backlight: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stk078_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			   MIPI_DSI_MODE_LPM |
+			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	return stk078_panel_add(dev);
+}
+
+static int stk078_panel_get_modes(struct udevice *dev,
+				  const struct drm_display_mode **modes)
+{
+	*modes = &default_mode;
+
+	return 1;
+}
+
+static const struct panel_ops stk078_panel_ops = {
+	.enable_backlight = stk078_panel_enable_backlight,
+	.get_modes = stk078_panel_get_modes,
+};
+
+static const struct udevice_id stk078_of_match[] = {
+	{ .compatible = "startek,kd070fhfid078" },
+	{ }
+};
+
+U_BOOT_DRIVER(stk078_panel_driver) = {
+	.name		= "panel-startek-kd070fhfid078",
+	.id		= UCLASS_PANEL,
+	.of_match	= stk078_of_match,
+	.ops		= &stk078_panel_ops,
+	.probe		= stk078_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct stk078_panel),
+};

---
base-commit: 938e2774f01674a3a38cc6df5d20401cf09b1401
change-id: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7

Best regards,
--  
David Lechner <dlechner@baylibre.com>

