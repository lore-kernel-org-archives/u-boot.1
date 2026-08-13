Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B43C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE0780E05;
	Thu, 13 Aug 2026 20:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJ3oUz9KXhgb; Thu, 13 Aug 2026 20:54:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0260280DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786654456;
	bh=gIveZzqsNsuLpFBIf5kBBNj3WL5rk5xApAy7Lv66aiE=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SE4qogXo2QAlSaL4i7s9XYo1+Hq7CXKn28aKiRMY6st52WRCys/0R6tZO9Hr47Yq/
	 kVu1MILx4LVkyCw5srm2ZxVnnDxdDyX706c1R4y8bg1A6wGvoVuia9QQxHYxLCgwHR
	 4uuwc2BePanCdTc/Rb2aSaQV7XwN2Db0OcrMIBeROQhCukc6cRFy3AKe3Y6uwuXs47
	 SczByQ05UnqDWxWcHbOqOGMY2gHgRt1AuDccbTXZlecZPkzGEDEPJ28Zq2kjKx05f5
	 JbZ3Jyq+R6qS+tWyApqVAfphVReCJ+6ZByuqYkyUz1L5GnE+/hZ4hIx5jTRUBmlGZO
	 f+z/DdtIO2coA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0260280DA9;
	Thu, 13 Aug 2026 20:54:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1654139C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A72EC40CEE
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id if_bR_o39Fjv for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:54:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0DDFA40CEC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DDFA40CEC
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bYkwUejI
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DDFA40CEC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:54:11 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69848c9462aso30338a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786654450; x=1787259250;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gIveZzqsNsuLpFBIf5kBBNj3WL5rk5xApAy7Lv66aiE=;
 b=bYkwUejIEsRDhB4THpbi75JGsv5Or8IBUXVZUfSsVm5Fc1hIdK7FGYisycLlOz7AuT
 eSUpxWIhG7WV889YnNDScZbZ100aC+TsIx3zOV2AJUca1DfIbHgN/RAfvmrIk+7OVrpg
 BcXrCSAbjxhAX40WMk+WvwpO17Ub9/e+bK4x+4JKSD1o72dnBV2+JBhh9G73X+Kru7uD
 QQkXpYFlciNrMC3+WkWP9qWM3RQwFpgZuLFzUEehGYVPEFYoInbEq4dotn/uBiW8RrYy
 X2CT1VC6x+gjyl51zcKITOfU1gkc3VRTDe5KwcDctGMjJuT0Ad60n3Uk61nCMOjHt1Yz
 GbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786654450; x=1787259250;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gIveZzqsNsuLpFBIf5kBBNj3WL5rk5xApAy7Lv66aiE=;
 b=Si8L7NCT3oWilPhw7RFjr60UJjTpaqkbq9ehSdlTOsLuvMTTpLWuf9Abu8cS4mbrrr
 XxeJySE5RV3NDLmRk73Ch3sFJFXP7Ad8c0wR6lA0rquFUBbMkAsCyoEWPPRej85omaI3
 WYlcIjd4wvNtOz4DCz6a62qUadUvWvtRFCl+vmRHje1T1qXBoVLtb6JIJoc3SuvMZB3N
 l+ZQ4e0Bok9JddHGctBrL4jaOo9bOQU3MGPchfr3DTRsWbFp+fRWYJ/i+GD7RRCZIfHP
 3x+PQ6RaB48DiRJzIQgsmxwxRxAJZPOqv0jza2NshLOyMDYqidD1hRbMihC2Ue4pKlqg
 9KPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWye54stQ6Bi+2aKIhcYOCyifbk03s3zMwuySpUHbUkOHUXOSyXhiM42Vms8UzripZdz5vKEY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzPfvRwLZZYmI+m+3Q4YKe5Gff18fw1hzNkBf9Z/2nWCWAviqlE
 psLjLIWscmd810aohKFrpF4vUVs3geP2DDV0U4wZ2rDkWIFmR8J5YDXb
X-Gm-Gg: AR+sD11kRgQHnI/Nm4fiDct97GhrwUv3+NmrptKDgKRHMo2NveoEL6To1oV4dm8k9cB
 mbRrR3aGUn6ZR2IF9VxUWD+FCubASxN6sczHIes9E+Mq5DbvfHlGJTwQJblPBQPKoJThAKG22TU
 QDOPFVyMJAQm38w16t9B1dSv4bl/SfWuupEv4Qpx7MtsxfeLgdwU78Cw62OO6FWPo34zGbGKREI
 HwJ9JMARQ9+FeYYkRQHXJhZSMzPWFyd6tmnI6psWNJrb+QunVrUchN7uKphlUxtjot5nzMpqnP2
 TZgRWv0/kwbNKe84PxarMUkwOe/HV1dHPyf42cB7GCBF/s/FcZVxvKpVBHgPXxNgV2CRkimq/vx
 rrBxEJ0iZ2GdA3tje+Gm0t2n2rd1TCMErdBkZ7a+DMmFAuvH01wiSdWDg/AJrEvuUqY9fNopDF9
 zl1NP7f1YOwq1RIkd9prQvJP+e7fsQrV3eM0apKvf3rjujTGBXKm7x4zxus01umSHyQThmUMhFc
 NlAOLtRkrK/7nzfqUxdzlixcjA=
X-Received: by 2002:a05:6402:2488:b0:6a0:d5f8:9ebd with SMTP id
 4fb4d7f45d1cf-6a38a941dc3mr304198a12.2.1786654449639; 
 Thu, 13 Aug 2026 13:54:09 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f8dc225sm1337539a12.30.2026.08.13.13.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 13:54:07 -0700 (PDT)
Message-ID: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Date: Thu, 13 Aug 2026 22:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 0/6] doc: clean up README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The removal of README.rockchip is long over due.
Prepare and expand rockchip.rst with more info.
Move the still relevant parts from README.rockchip elsewhere.

Johan Jonker (6):
  rockchip: scripts: remove rkmux.py
  rockchip: doc: add mask ROM mode text
  rockchip: doc: remove TODO
  rockchip: doc: remove README.rockchip
  rockchip: doc: add back to ROM section
  rockchip: doc: add notes section

 MAINTAINERS                     |   1 -
 arch/arm/mach-rockchip/Kconfig  |  16 +-
 doc/README.rockchip             | 684 --------------------------------
 doc/README.rockusb              |   1 -
 doc/board/rockchip/rockchip.rst |  53 ++-
 scripts/pylint.base             |   1 -
 tools/rkimage.c                 |   5 +-
 tools/rkmux.py                  | 218 ----------
 tools/rksd.c                    |   2 -
 tools/rkspi.c                   |   2 -
 10 files changed, 53 insertions(+), 930 deletions(-)
 delete mode 100644 doc/README.rockchip
 delete mode 100755 tools/rkmux.py

-- 
2.39.5

