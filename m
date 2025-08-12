Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81808C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD43831C5;
	Tue, 12 Aug 2025 12:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pdP6vVtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAD283290; Tue, 12 Aug 2025 12:13:53 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6032E8317B
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-458bf6d69e4so48438595e9.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754993631; x=1755598431; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Weve+gPXZxaHahsWHsEymZzGE19OKDErumTE3tbm5zU=;
 b=pdP6vVtjC90iNu3ONQvuyF+4Z+X2svyoBy8drmYHJnRLcOGU3AXWjoIBA+rCbYx6rL
 i7qsgBoX0A63ChjRart/1xSKkZtqC+OVuPekCUpgYoJmD4KBm1rbSQL9Y6ejoiLFQc41
 y4J6nHdFXCWszlabRXbd9DND7pghsWrDYV/WCJpE86nmmQDO7L31s7CsgGIBlGIrF8Ob
 OJ5a6SdYmiqM7PjEzr2RyqH6+eDucanM3hBv0Pgss5BKs61tPCtC3Hd0gg/1B3EMIuV3
 fmUSYCKzts1hpci5v6kh7N59uMdQ58Dh8Dp6J7MJun+JPCzrqQK9WT05zSUvSfCSedUB
 BYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754993631; x=1755598431;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Weve+gPXZxaHahsWHsEymZzGE19OKDErumTE3tbm5zU=;
 b=UGsIIzn8mYDcfaKFbrGc1/xhA+G0pCyKOzi1G4TWmUss81ApgIJAFz/RIHGXwYQeoy
 FaZQVv3x9RBAtRLJQTMXxz7TDh9kU+AW+ko3zp7q2xJmoOyJh4YIWTXQlwyK3SYDhM1O
 n1phsn73e8j9b5P3xuIVVcH4z80OSqqP60hBInM+A8FaX7PeNvVPEzzYmsPHjXyRRL/O
 9thIQSDPTnMMAwOOEHjuiy/uy6i+LSwK025HV3k6uEzVI8l65Pmg/LlwS89iAEYSnUis
 L/YgtEnCsC+I0sI78KTkbcjDAy5U1OCyKNGQLmpbVGWPsFVel+PG56NNf6PBBmD5MXJp
 eRUg==
X-Gm-Message-State: AOJu0Ywht+bUqMlf9egD1oN11+TK41iGkc4RV1QM4jPeuVKtPrq+9k9R
 JGs9iewk32VlEEBIzidqGYNLOycXRiIMswcgEYJ6jH1bjFl0swIa/7ht3ZO27ac0QQwU3brPg3X
 zugB1
X-Gm-Gg: ASbGncuJveMfaXQcO49gZsOYEOTLnX8NhioY1C4w6pviGc5iEYVVzGAiDXunKYO6oIs
 dFuT1QKq52PV6InmU6dlEtfdKavgczOYTGOl12abFUEdejL/YCIWDAxOrGiycEyCmhGtE0n9mkS
 GfjtyTJXOpz1qxgBNNV4DnqAqefPUHEu1tbyTe/8xY//4fxattHBE26D9A5srRNDMmZHjz6rOID
 kRXcYH2hHb8P87+Hi5KvpLk/QhfHnCcCU6IvyF1rRpNRRriGNqDeiPXjJLI9wREwnuTdvq9IPci
 6rie7i/i/16wKeqJRNtguQC0DQlfZAVdTlIe6uZ3BV/1eXaq+8MhKZf96z3m3HbeATNxDqG6Rnu
 OvdRRoEgX5vOwhewSecClddytcxVP8cvmTnoazdPzps+QSPUuIeE=
X-Google-Smtp-Source: AGHT+IEZvJTV28h/15OxIcWCMdZJ0TWSqCV1qMgyRSQ3G6msnazgU483bUqS+OD+p7CIQThN8e8qFA==
X-Received: by 2002:a05:600c:548f:b0:456:1a69:950b with SMTP id
 5b1f17b1804b1-459f4f9b23cmr127219925e9.22.1754993630613; 
 Tue, 12 Aug 2025 03:13:50 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm44090808f8f.44.2025.08.12.03.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 03:13:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] soc: ti: k3-navss-ringacc: Fix Smatch reported issues
Date: Tue, 12 Aug 2025 11:13:48 +0100
Message-Id: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwTm2gC/x2N0QqDMAxFf0XyvECNHcp+Zeyh1VSDEEczRCj+u
 3WP53Iup4BxFjZ4NQUy72KyaYX20cC4BJ0ZZaoM5OjphpZw7VDDboa9m1LqiPzgI1Q9BmOMOei
 43Afl43fP38xJjn/h/TnPC6TZa7pxAAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Smatch reported issues including a derference of a pointer before its
NULL check and the use of an uninitialised variable.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      soc: ti: k3-navss-ringacc: NULL check before dereference
      soc: ti: k3-navss-ringacc: Do not use uninitialised variable

 drivers/soc/ti/k3-navss-ringacc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-k3-navss-70dff322484b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

