Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05454C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A666260821;
	Tue, 28 Jul 2026 06:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7AYuz7w14FX; Tue, 28 Jul 2026 06:51:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D45936081C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221507;
	bh=E2kw3zVbHhw3StQMpU+vpiKGVev9dpBiDmw0KUGlYAw=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LlNz35l7U+YypvqLs+DUyLPBlDeun1EZs5+xuVBFJtnqhr/gWR/2gjUxDro+4xWpW
	 55uEqyGSKd74AOEJbJQDkPwjeIVJz+lGreU8/HykhDsn1tBRE4UO38lCuHkrBMWsqo
	 3Z6WKKwJmErmMt3s3I9oNfXNgcu/SugkJvICfbPATfhx7XdXE2OAiJp6b3rB66bv0v
	 /np4rUKaYsFfIw4kWov1mVaN4dP5iFcY0BfnOzuvKfYso3Qvs8bw+/IsHsSJvcH1sc
	 SrJBeHua09o/+g8fpIt+O8aS7mX+46lx17ztdfxYpU0Tx6ohsK8rQXVGsQiN7ozTGx
	 FS1AtEhWO1Dxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D45936081C;
	Tue, 28 Jul 2026 06:51:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D4CD26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3387E40245
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ov2bMHYs0If for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:51:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0722B40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0722B40042
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0722B40042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:51:44 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so104783a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221503; x=1785826303;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E2kw3zVbHhw3StQMpU+vpiKGVev9dpBiDmw0KUGlYAw=;
 b=ON/b/5F2ixD60PVVkXucJATWObfRbhvP6eSoRYMqij3nPK9ETY8DIO1i/1G6Hkmc2M
 eggf946bVmVB4oNGxgYWdckCNt88pwZqUDH+6KMDjmZw8XLYVnfLFSUy9HF3JkPgSGnt
 UFsFsN1VG15xj2LrG4c36UExSKozn4NOQgicVKbkqhODKlROEp5XrSRI/5nVWKqB2QJQ
 XS4Kd5KqZXCUgXb2w5DB1tN7hw0EO8sSXT15qjs/3eAt2jFaN8BoIQjkRz7rEC98+El/
 vSpUK1Cr7Fqdoe9XPNBojaHizQahZGLZnNAX8FXJ+y8B++jfjyyQ1E2n2bkjx9zPmZTE
 EvTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL4u9SSkoR9ZZxjGuaGSemZ84R0KwjD4ExaoZf6X022SbrEnhUXLZc09RGBFCfG/K266pwPss=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKVBjclXA0sK8wZZXvaqf0WJMkPMswlOGeMyS8HcnGNVe/D7jV
 oeEaDdpjt4ebAjUhlbJFEgoH5UNXsz9tItaeFRIOhaxPMPwTwBHuPW3W
X-Gm-Gg: AR+sD13+kjlJah5BOT2CKuc81kX+zkBkuaxNTq7lY+oYdvjVvQQ9JyqnLsdePpF1nXy
 CGnWEkI9GeU71vuiZo9pDAUrsPFRodb31DETr9noXdCyaVAhTws7Jd+b8MVJ3eBpkGKoHv2fBVK
 OTVTGZipZJULwUpQIaIMbsGah5bjKqH43teOYFj6sxWNokv8wQrv4mtWjSP7UppOOs2IoMa5vZx
 yjcCxbvNPfU557OQ+1bBVRupPQAk04P0chNV+vZqCW2W/nc0ZIXi4ICuTGERf0Xx62AZJCP3ETL
 RZ8sHqJAZvM6FaXkn+hrHMULg2R91zFsJ4ZGrpclzrz9hdYAF/5u8ttbZPfccC5ytOxJHNHGhnw
 7b40UOxMuqe8CN7OghuDh5wRto+LZgoayRjdTaHkd/OWh8sqq2wHU7OdXnj/+vHTBXpdJBm2JFN
 LkW18TY9LKVFmpBDR8kyKggBMi+11yYbWVJhEGHxPC
X-Received: by 2002:a05:6402:448c:b0:69f:ce9a:89 with SMTP id
 4fb4d7f45d1cf-6a0349ea9b4mr468254a12.1.1785221502470; 
 Mon, 27 Jul 2026 23:51:42 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb52d6ebdsm3632915a12.13.2026.07.27.23.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:51:40 -0700 (PDT)
Message-ID: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Date: Tue, 28 Jul 2026 08:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 00/11] doc: clean up README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221503; x=1785826303;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E2kw3zVbHhw3StQMpU+vpiKGVev9dpBiDmw0KUGlYAw=;
 b=m4N6lTvEdDG3EC1Xj1EtkTiibCBz8MYb14+F0M3NW36TDsSzuAtgddHPLaPOv4+j9p
 ygzGkhjHw+c6xMn9qeGwVo2+7M6yysoYKSFFOvyJEEO/QhDk7psRDnDGsQWjXJt555BL
 bpAqO9iiDjN3lnbopRkNaGKjAbe43qmQfAFD1sDcedL0ZuffV0co7a0aXB9te2vSSAis
 tr9nT5Lo2ZYHNUvq/yE1Xriyk30PWggkM+7oRFhXQFfNsltP9AF/g+5rwT7rytYmgZW+
 511GZuKnVDBNAzU2gSBMH3YdU9Oxw+pATJK/dMEM57z+n+QztDyO0Z4S2bez38GP43lj
 Xb/g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m4N6lTvE
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

Johan Jonker (11):
  rockchip: scripts: remove rkmux.py
  rockchip: doc: change TPL phrase
  rockchip: doc: add BootROM/MaskROM mode text
  rockchip: doc: remove TODO
  rockchip: doc: remove copyright lines
  rockchip: doc: add more building instructions
  rockchip: doc: add more EMMC program examples
  rockchip: doc: add boot medium layout text
  rockchip: tools: add comment section to rksd.c
  rockchip: tools: add comment section to rkspi.c
  rockchip: doc: remove README.rockchip

 MAINTAINERS                     |   1 -
 doc/README.rockchip             | 684 --------------------------------
 doc/board/rockchip/rockchip.rst |  99 ++++-
 scripts/pylint.base             |   1 -
 tools/rkmux.py                  | 218 ----------
 tools/rksd.c                    |  21 +-
 tools/rkspi.c                   |   6 +-
 7 files changed, 108 insertions(+), 922 deletions(-)
 delete mode 100644 doc/README.rockchip
 delete mode 100755 tools/rkmux.py

--
2.39.5

