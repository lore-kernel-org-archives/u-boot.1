Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6138BCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 10:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2200381216;
	Fri,  2 Oct 2026 10:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nvFr-EIkOPRn; Fri,  2 Oct 2026 10:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5E2EA811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790935511;
	b=Et1w4iM295NFBiEWfUyBfZG79IMJlaIknUV6Iz/XsxBxyISHKYGmwhLmIh0Z41i6gzVu
	 AdWvgC00QAPO5kHy0K+gPKfTCMQw8gobTlNRQlh16jWdtbVVW3drFM56gOsz3y/blbhGv
	 +O4PGa+FfbHAxA+pMz9LGisiujYPR8ZbaVXrIi6sq9PC5C/4olJUYYexSbvZVDrtuFFuJ
	 TQoLUe/hT4oidxo4YvJmPOev3l5QmdNl//apTrO9VL7lqBh2mkXkVPJ580Di4Ba3QnX/S
	 /0t+3idMz371YG8+V1xwwF+uHLhgGUD4uYH7N5+XCVUsNrfzcKtukpcnDnp7NNP5R6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790935511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1sPKPlQ4ikhkkVFKi5aGQUUN9CVN2ohdEHbJiK8V20Q=;
	b=MZKeiLePpSP/1qZaC2p6Bjq0A9ck+mDE/D6w96/nY3Q44ZKGjTOprogVASh9+619hwl/
	 SlGvrDOUx7rqio84MQ2QdWVGcx+8TMZM6mCqFVAmhIKbxrQhA2FpxFPMdNdDQdbeTrXO9
	 60Np07ZyDmRM4cc8aA5yeAVEqRww9g+/Xm/uCOIKa3aRaxe/4hOSGhGjJimcbFabG5d8i
	 RD/lu+PcfVwEOzIiLYHRgVhgNXJHHAKo0pvN1RuBiiInalnoLq8ACkrxe74iQr1RRNM/3
	 Y7kdPgSnFfY1VWhvc5Ole8UIAKqyTbK1UcYI/TJm/3e/EIwjgMoZrSoEqz4rZu4S0rw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="rhrGpAu/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790935511;
	bh=1sPKPlQ4ikhkkVFKi5aGQUUN9CVN2ohdEHbJiK8V20Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nj/FUkdwKhJBFSAYH+eMqsIA7+s4zB33oUJxbjTNlhnQw911LfAlaFtsKxSHdzuzt
	 2gg0jUcbYdq+AGanwxoPdbZ48mpEtbeNyFJtozN021//N2UPqwjOkTu7CkUN7Hn8db
	 QmR56L8AzIFa5HUJHYuugEVFCUjyx8EGZUl5ZNyg0q+XvD8n6KYDR8IRVEAcwyyMAO
	 oqIIXZR/3JvvYqKEWtCwJjRAJzcQo0Oi2KltZHT3W0pmwpdDsu6pFYrzI+9J38/DP/
	 UFMj+fmT9WkQhoipohbPqUY0R1LKFJfEIG1dsx/aKJXchrXWZhdOrjUQl1PLyCijkZ
	 kQs5n51XlSS2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E2EA811FD;
	Fri,  2 Oct 2026 10:05:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71EA14DA0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 616A4811FD
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49URJDkd1UgY for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 10:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81F0081122
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790935506;
 b=hYKuJIWMiee0ylpzmZWSeeZjamCK2fC5YjqH71faCUkd9Togg3BBp40VuWwk1OPD7/yt
 jrGJm7g6fffa3RmF6BEKxH0mzt9w9t1wruK3Rh4FCDe+/N4SohIO6UgUsxKxNzg2zL4R/
 md48mvceO2juaKA0YKnG3QrTxbtCwAqHshAOh0XIyNo25gwI/4t1+yqPBvTRvht7NciV2
 H/oCUKExVb0h2nB5+90ioz/DXW5Nv2vsj4Ja8RMu+4PqYeYfiHJYNKm7mrUgbBHcCC4t4
 kuJZnmLzxAwU4tVBiuspx77e0EutWnvvyQBgAW9q6Kji4hvdDI2DsbJt2VBNf5DJIlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790935506;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=1sPKPlQ4ikhkkVFKi5aGQUUN9CVN2ohdEHbJiK8V20Q=;
 b=qXGFZ/9CCgZ0JF3BZKsJgv0d32kQvNNojZC9Ir7Rairm9ZoNHuuS+J2B7OyiiZh27QlT
 76/qmGMCZIWtbZ4RmaoQsf48wTXip0K7F1UD1Hz2z6OYgw1FGYXUYCXeF1Fh70bDjUJWF
 1dXwsi9VX7Rqbb2evSAn2FWpsg8iNnXFMrnCMqCAJ2HFrIexrdvt4JiPDFOM+eIcPg3Qp
 wcPxgClhwKZSV4nKz5nO4JVKYOqqiEdHKko5UkKgq5rAfmDEQwWUgKm2JZiM756uSfVb8
 eYffpcDD6/EfIFap0yyZGE1Uc4gY9hzyv+ccoPd6dUrVyR7XVpMlgo1ykkoz/ibbXxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="rhrGpAu/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rhrGpAu/
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81F0081122
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 10:05:06 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so42136855e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790935504; x=1791540304;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1sPKPlQ4ikhkkVFKi5aGQUUN9CVN2ohdEHbJiK8V20Q=;
 b=rhrGpAu/oDcgNFxxrvWdjt24ys6A0xEJlakQt+kc2eBDnwrv4DVznQpAMTOsDUETLD
 rVPYXzoOggJ8RzDR1O0Z8bvlugb9sb/ujY9QGUT5/RJ3QEarMeH3FmnZsHwpsCf7mzyb
 aUeh8nimTlJSKJj8Cr6BIUfsMWu0pJpY+ve7HfYE4/4SV8Ij0rr4OOEHid7Aq3CACe4a
 91DAOfGyeE/Uh0demoS9ckNi6TrX4ieASp/U6t7VxZBZ6Fd98+sNY33RR+IjxI5O0q7Y
 K+IQfPZsKjUALpEfkX9gb/YTrFdoFHJ2iKy/u2VFicED7tmUyJWxkthRzG7Ux40mfgkM
 EZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790935504; x=1791540304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1sPKPlQ4ikhkkVFKi5aGQUUN9CVN2ohdEHbJiK8V20Q=;
 b=cNuvmW7B6RhEDJQYol7v067tivLYANOMwoOtBGnbkxcOHPqycTQC3wHj5LCJK0Im52
 jxznjAOMCmYkBXp8W76kQOiCy58Ib36ktFbJr1MSAUgO6hzQQLuoAOa5D2+dC2YBUc9W
 qod5VLTj7FTqllOomnJW1i3Th0Ds5l5lE8sBOZd5pJeoA3/zNUSAM5xGEkGWFgQ/s7jY
 DBpEC8J8gxNvpl8A5Q63eVinqdnE7dZL6aUZdeRLqrFmACAHgR0foxTNhMrKfyHrLyQ0
 JcLdt/840kEr0PAITE7kxJUx/eCieVHJxToE9kF/QgkF5Pp6gUhBwzbXNMM7/YxL5jaz
 bIBg==
X-Gm-Message-State: AFuF++kgKYdobtBTUh32CbI45tfSB3QNUe2rVzHp8/nWyIoIwKWf8+Zk
 ks0ZIZEenp8WRwGDEs7ncj/n9RugC+jmm9q+06WgeH4IWZkTQuGJQFIl+1BlG0MTNBk=
X-Gm-Gg: AYBFou2hbnq6P999gqU2dtFX1VlkhqyY11CUfTfDiziKb3g83qagKYAMrh3rCNPACo1
 3h/O7RDgPvP8oInpq1XViIb5F9VQw7eTnHqiTc1qYYk808dE+q+Ddc28+17427JVM2iWlOGYHV+
 a6cr/RqnRtGO/v+FOZTnpsaNUquUmoLhNv2P+HVeL4OH7U24mkoJbjCKmXSX8cxTZ64eDY0vkwL
 MpHwoIoJd2WJ38Ztbd9tKj/mFwXHoZ6LedujHyD/RRPghWMOCntkS00SUazqrPj9nImd6bUu9FN
 lIsaflD+Jxk1qGGKyIlRJfniKy4QUluAyCq7aCgSD4EsLi8YmiNwzXhl77HCBmi/oLlrRmpw+jI
 ZONWvAi2HzccTLf84x1VSsgZv6YU1v+FWXBDO0x6ywFRKmgArPGNwOInhUwIK5GScDA7E/YHtoZ
 QrSFwSaa+6pWyxQMmP3LJIVV/xglBn2YHggQwltGR48F/2xxv4yBMnJzTkeJex74/6vkid5ZFz5
 6QgFgvUAuZxEZdMeCPYndxa3m0=
X-Received: by 2002:a05:600c:3103:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a0276b9b77mr36038765e9.33.1790935503852; 
 Fri, 02 Oct 2026 03:05:03 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280ceaf0sm72887985e9.12.2026.10.02.03.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 03:05:03 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 02 Oct 2026 14:04:49 +0400
Subject: [PATCH v2 2/2] rockchip: Declare unaligned access safe in the
 ARM64 SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-unaligned-decomp-v2-2-675466ced78a@flipper.net>
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
In-Reply-To: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=alchark@flipper.net;
 h=from:subject:message-id; bh=bs/Mm5GAx7LLajuMlMIdVsU/2J+ygQm5Nhu7nuHTwTM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtbzy5u45r1e8f9nbHzeZMObDvl4SeT8USXaZtvd/OV
 8e6z49a1jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU38tjZHh+77TRu+hyNY60zJMckjGhl3fMKNTgdHT4wRDPWbLN2pfhf+W5J6/
 6zkzdltJxe5O80FeuVzqHpY0fv1rxvdn50gTXqRwA
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

spl_board_init() enables the MMU from ARM64 SPL, and runs before
boot_from_devices() loads anything, so the decompressors can use
unaligned loads.

Select it under the same condition that code tests before enabling
caches, so the two cannot drift apart. SPL only: U-Boot proper is left
as it is.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..cc108e9679d3 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -631,11 +631,16 @@ config ROCKCHIP_COMMON_BOARD
 config SPL_ROCKCHIP_COMMON_BOARD
 	bool "Rockchip SPL common board file"
 	depends on SPL
+	select SPL_ASSUME_UNALIGNED_ACCESS_OK if ARM64 && !SPL_SYS_DCACHE_OFF
 	help
 	  Rockchip SoCs have similar boot process, SPL is mainly in charge of
 	  load and boot Trust ATF/U-Boot firmware, and DRAM init if there is
 	  no TPL for the board.
 
+	  On ARM64 it enables the MMU from spl_board_init(), which runs before
+	  any image is loaded, hence the SPL_ASSUME_UNALIGNED_ACCESS_OK above
+	  under the same condition that code tests.
+
 config TPL_ROCKCHIP_COMMON_BOARD
 	bool "Rockchip TPL common board file"
 	depends on TPL

-- 
2.55.0

