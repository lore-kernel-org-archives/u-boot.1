Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61286C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2400460B8A;
	Fri, 31 Jul 2026 12:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQoTTafnVqmM; Fri, 31 Jul 2026 12:40:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 043BB60B9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501655;
	bh=xV2roVVohpsL8wasM2Xgppt+xb+gKnR0wMyqXttb5nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YHFokUawtxM3XLdn5zJmBXj21erg7YgBe6Z73D+I3ig2EYMmiDMfDiQvikMeT0FiC
	 Dq3kH2eqjsaeXJYVdDSWLuE1vOT41v4uoh8DB6F9iIF+c91iE93CrLs6FgzuYbWn5K
	 vJRjyxsD+l/pngfCIgcBEwWWggIXcPyeKPlWHIHXIfBjxWzn53qG5+LO9bAjkAOaN+
	 WkqW3uhxOi46RUX7IjjdctqBqnyLQSmvVsnDZPU2XDtmgteZke8o8VRDTJ0MGuqFZG
	 q18ncdOK4lfkIcShnovUsCHW1oz9/ndyucln/AIFL3reyq33C9YyxXoERSgcwcv86/
	 a01jk934exyWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 043BB60B9C;
	Fri, 31 Jul 2026 12:40:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B35E869
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5A0A4047C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5En53OGeN16 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 06E1B40471
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06E1B40471
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06E1B40471
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:52 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1254789f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501651; x=1786106451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xV2roVVohpsL8wasM2Xgppt+xb+gKnR0wMyqXttb5nw=;
 b=D/flWa8XLOMObQVWKWcepPUB2ekPMPSW75EMgYwT5gnvRcNA6KURXsoKOmiTCwHIUh
 qtyR6JwELby3kcm06VrxF1/7mbCa9jqvAC8ts5mjEEKx40Xs/uBEJ+e4T9jFwNXig76i
 3dfIj63kxSvozgDGE/bSVwP4qIN9ZoZAuXqQJIZT87Xmlr4dMoaggEPJf0HRqOjRD4bb
 xJQqWtajyJDfPs1ndoJuTEufmrrqs6jRkFGrfLDwdzfp0b1Y9Z6vO7/iI8UWILWVgLOy
 oOSjlAXYvqewebO7hYJcMW27vEWi9lBrNDk4uot/4gVnBD06XoaA7hlStIe8D6/ww/xw
 OClA==
X-Gm-Message-State: AOJu0YwNV3+vXH7CCsrcq0+YM4WJJp6xOd5rwQzk1RdN/wSzQOLzxMer
 MyNq49HRA8nPpA6FlDzS/LilCWgqw95FK5BJ/5Bx/t4zDBDc8g3gVQzeCRet2IJiN+M=
X-Gm-Gg: AR+sD11/8kLxTxhmUnjCYamga0wcHt0lD3fRhuZVSAXAh+l3Mrh7hFK7DhWykiSibv1
 1t/mVBGjncOsB5XegdXeFOWOSr/UNN8oMz3JVBBslgEMfwqRFG60WPGat2GD3UcOjnfJWudNmWR
 E2b4l/717qDZsZcYdPW0l6XP0FS9BPnsoZRaRV08A0pV2wPdDaRs/K+Fzh4etrBN3xgbTXnjPKO
 m+PVBC8dT6Hadez350va5MOyalOB43iZ9SparYrHY/7JXFX8NwiHrGt6tBM6Nt99utf6AzWZA8l
 peghs86Nnc/WfCEDEY4MSuz4h1gLLlhcPHjTzis8ZfpKxh/LxHG1QMM5/u7QwDtz3zC8oVwq3a7
 OXKMCnObAnj2E0UkdEMAp5OWwniHbu4K+v+vvjKvNXvA+tfONMR8Z8HBwk6WYC+GK21IUYM88eI
 FspHuSdD6+njCwWxuCh7M60WnvTAoz7g/pGW/r9qJbwvPpAUn+VLoZ93B2tvhHn0R98yQrEkOqN
 4Hol+PdjE33buOWPAYrz5shlxzUF6L/xIbswu9ygQ==
X-Received: by 2002:a5d:5f09:0:b0:47f:97e9:fe55 with SMTP id
 ffacd0b85a97d-47fd32ea399mr4078287f8f.22.1785501651004; 
 Fri, 31 Jul 2026 05:40:51 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 16:40:04 +0400
Subject: [PATCH 5/6] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=alchark@flipper.net;
 h=from:subject:message-id; bh=PZUtlWXRyiuEsxR5pdkYFXK5h6GMV3P4iv+OK5PvBW8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN/NaLf/+vMfnXXudzTOHFq5VpW1+W/MEYuPZxryz
 r3+5pfS2jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUT8hl+Geg6hK4OazA2ij1n7hoa/cNibPHw/bP3ltq/tO6/tjsP88Z/umdf/g
 45ff+0xF/19x9P2eXkO+Dlnf14fdmVIhyfD6UOpsbAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501651; x=1786106451;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xV2roVVohpsL8wasM2Xgppt+xb+gKnR0wMyqXttb5nw=;
 b=aI5/9uN0H8YvUAYOu6aLgm9P5F2IEXlFBF2PWczWGJ+J+zA4ueiCoZGm+e2rZIHZ/O
 g7XIy8N8zwTsWZ64FpdH0yoRZdMDvMrouHT1OKFAPyNsSv9wK+Q1wEbvmzqJDMUZ96Bq
 KeYCQdltnb/XJbMZ3CK2yAbyoWnvBIOAaQuQceBlDe0yEBUq6U9dvqTc9J6tmh43h2Ig
 Lj7us80Diur9NoJ2aKbuLjsoaDexmGebLNwvUr1vm8yd5z8p7z2O6/jh/SfNHNOPcJr9
 VzXcPYJ31qQTrS/IFrGBD+kDUkCB42Af5scNMdwK+JU9+RBIGgNerxikd8qBjYfnxy0y
 nlbg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=aI5/9uN0
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Unlike every other test in this file, test_gpt_write_part_type() never
binds the disk image it operates on. It has worked since it was added
only because some test that ran before it left host 0 bound to the
image this fixture provides.

That breaks as soon as a test which binds something else is added
above it, and it means the test silently depends on collection order
rather than on its own fixture. Bind the image like the other tests do.

Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/py/tests/test_gpt.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index e6d8792ac1fc..fb4c8ba67d48 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -338,6 +338,7 @@ def test_gpt_write(state_disk_image, ubman):
 def test_gpt_write_part_type(state_disk_image, ubman):
     """Test the gpt command with part type uuid."""
 
+    ubman.run_command('host bind 0 ' + state_disk_image.path)
     output = ubman.run_command('gpt write host 0 "name=part1,type=data,size=1M;name=part2,size=512K,type=system;name=part3,size=65536,type=u-boot-env;name=part4,size=65536,type=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=part5,size=-,type=linux"')
     assert 'Writing GPT: success!' in output
     output = ubman.run_command('part list host 0')

-- 
2.54.0

