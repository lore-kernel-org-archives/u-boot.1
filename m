Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D223F8FA8C
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C9B84307;
	Tue, 21 Apr 2026 17:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMmVRPtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7231A84307; Tue, 21 Apr 2026 17:16:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9661F839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso48203195e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776784570; x=1777389370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I50FdrjDFneDzcZXMzmKGBuVoCTjgi3mual5bWBxck8=;
 b=fMmVRPtt1+kTZa//jhvg/rycHojLgR9Z2vdVOC9+08J+kqfTTstmVJvFoXNXRo1Ov7
 DkUoD4TllKk8myU6pR1IM72wBuaRyFomiv90gFHobTUztJ4qvTA6cBVq97yNC4fxVFv0
 iE/HtBtRh0oxcH2jRGwEzWMZdQ8ZwOUdNWLrHcGq0mh2vOGgX//GDvHYTpoLIrItUYIp
 mxvUfCdN35I/877Xu2qCLPKqZWHMe2lUhmSMGfsZ4g6w17zS62lxbfQkBjZVs+Qxo9fA
 bnKggrrONILkT8ixytYw884OMO+PTJ8a4Po3yp9jXuKUBSLrtwonJa2+IaDZhi6A6aoy
 sbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784570; x=1777389370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I50FdrjDFneDzcZXMzmKGBuVoCTjgi3mual5bWBxck8=;
 b=JlS9VzT1nt59K8FXP4pDYCIxNK+v98Z/B7fB5kwmLQI6sJ6kzPDpAkL2Kde6U29rue
 GDK9yrgwjXdKCEtTeWXXJEXsKqVqaZ6hKabeknHT0zeOLRBmSVepzSZJUgcxW0hIvhZf
 kVvkyEI3qGiEgDRoqKjLXD2IdQPwPp9py4YasZeE3lz6JIQWJyouterYGw7kfyqKbCQx
 kj+SjJYkdgarW7Bhtehk3CwvMtQCGCJ9IGvuu5ytnWYryXJXCHBg4Zb1i68Z5QczVhtJ
 xJB16RP1erpzldBvBYzxGW66rgPzWQHShmVyoUvrLTFP/sPoaXm8blWFe4p6mZzmv9qs
 X7Wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KmLXxe2l3Tt91RQ1rMoxpbcKskS+I1Eu2EaeWHnPfkLC843FK6n+SFL8Aw+aG1XY3NRkro5A=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2OYtj8pc0P4bxph1TPwfPwclHv8NXHP86AbEX/GbqIZnpic7I
 ievXpt/KnOuD9QEKHGDsulp1F2olFwsxMDEjmn3sxsq/hQXmlEglp858
X-Gm-Gg: AeBDievP2cgGOoV6w7mb3upzGq+mev95IeDct8Jg0YWFv7n79r+U49Pu26Qt7jcVfMm
 pa4dqv16f2enGBjzenBUFQsUwxd38UL9EkbDRZhpVVgYNQhPd59pm3E/6coyxf2FgQHK1R3++43
 RUTPGOOhkh9aU+gvli0zRiI8bZzmsa8J0eTB3dlLQk5u+Z0VOJo5sURlmjrr5FFbm4T9XnhfQod
 gSv3wpaDse09Qy/Fftvu6/iOI1F9K4py6vKewj0Ts3rQv31RjHQ/bzra/wGW9ZicbNnqAZtOe/B
 j7052KRMhAFt/ObhgV9NIWo3FQnTdLW2vCalypURtwW7O2LVmvp41qhxPhHQPx07ShDBJDNZwST
 SYA5d396hnODdBqIhDB9vUjXCT7kb/3vmU3xEUEmWnqM/ZPLtiXfPc0ZftCpIKYb11swo/CGWhl
 AvOFe3pLSBsvpELM50/mlhJbUZNrc5xvAffdPvcgdgX/15lSg0dJuWiVxXR+Acl4lhmAmWTPVyj
 LhcKp5QoA2Jgxe7PBOn3MJUtO2fYTFbyvNT4aAK3G6KO2mIdFKMW/o=
X-Received: by 2002:a05:600c:3055:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-489032bae49mr116341425e9.6.1776784569779; 
 Tue, 21 Apr 2026 08:16:09 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm361416995e9.0.2026.04.21.08.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:16:08 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] board: toradex: aquila-am69: Fix 16GB dual-rank DDR
 cfg and memory size detection
Date: Tue, 21 Apr 2026 17:15:54 +0200
Message-ID: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This patch series:
 - fix an oversight in 16GB dual-rank DDR configuration 
 - fix the memory size setup logic

Emanuele Ghidoli (2):
  board: toradex: aquila-am69: Fix 16GB dual-rank DDR configuration
  board: toradex: aquila-am69: Fix memory size setup logic

 board/toradex/aquila-am69/aquila-am69.c       | 90 +++++++++++--------
 .../aquila-am69/aquila_ddrs_16GB_rank_2.c     |  2 +-
 2 files changed, 55 insertions(+), 37 deletions(-)

-- 
2.43.0

