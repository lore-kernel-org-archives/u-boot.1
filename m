Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41D5C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A37D760648;
	Mon,  3 Aug 2026 19:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxO6UQXqqil3; Mon,  3 Aug 2026 19:09:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89F616066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784168;
	bh=6SBxh6IR+bKWxkny/iu0/3dpz0UdlzvJaM0AjbAfO2U=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xwuhFsDYgwNafKs0lDt0Kntg3Q0IKjUV1oFrkmn088aAmt6ROxZhG4j+Gszxt3wSM
	 JyKqqb6Cmlqicbe9D0kcf5W0sf3uApsGnT6Bb/6/8UxdwruRm6ciVDqGPjxeUCVSQU
	 HwE2oBBiDUcQip0ag0y8kzHo8YkzPrBo+wcs0GxcfRXWJzvna0EX+thzM+HCiTKC2I
	 rW4PTdYfQisFYgzozRS3n74gdJWk00wZ0aEYKhrvFQziYIeqTUfaXwVkgvFeQJmrhG
	 DqTOsWs6MPqhoZgneLKLPKvemqvGlYeZDWAqLDk2MYRAQklRlfbaBWMCXtT/XeBHRK
	 aJRT+FT1mUTlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89F616066F;
	Mon,  3 Aug 2026 19:09:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69E15296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 473374015A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MTylUM-1swn4 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:09:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 59E884005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59E884005A
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59E884005A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:26 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69af1bc780bso647277a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784164; x=1786388964;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6SBxh6IR+bKWxkny/iu0/3dpz0UdlzvJaM0AjbAfO2U=;
 b=GukCdCb0IomEwqUnxWfZeHy+gv3bc2JWo9DBCurzGQ8WXIIET2m2aiayYeUom7sBoJ
 AWXifw4sF4tRnZQtYRIj15jCj+o3bGAKx/lVbPqeeDww/JYGX5ifgH/TLI/YqlLxWTLR
 N3C6SdcWMgmKNJz1UISeHGQNXMttVl6Mq4CRLks2IgsLJLcgoNwYVYsWZ6F7pLGSCQjt
 KnZzHWediKNOgAQn5+iLqr/sAygKuLdeVnr06T+YBIJg3G9uXVI4E6inUNsidU8zynN5
 xGmnrHI7fjKBddNObM5oQhY9f43J4Ch89pPqeAWqsY9hdetfweIsidgn3yB5jQdKzM6Z
 w4DA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvwU095GgLXaqZXCIeuiqMLwZVb10IWXK5WGYYsjReAU3bmi96JjcPOVm28oAeKcaYYlkqTgM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx0wzL8oQtuTNLmLc6CudnSJjjANGwH7BL/nuJPyEVngf2Hp+ro
 N4n5SSJAn+59Loe13fY+reVhZyAtQPMEwSZfuC1UXcwY3KVHNUUItD32xJgHOg==
X-Gm-Gg: AR+sD10DQW40vwySIuhDHwymJQIbSR+awNv0Ns03mhp5o9jl5pH4GJN4nyiAZRKzwOy
 Yw1j5jNUHspo5eGDFerD/qwElryGYwsQFaCnHUA0RcGwfB1bCxSO560P8JZEjgyCItYi1M8MUxr
 +wu01MxfF7yuIa3IB1XVL9NlunHw9xLOrxCIYmrqPAMn9ZQ7Y5Rd0IMhx5SkJmQNIGPcSY7VHS4
 Ah8ZsQJshd0AYnJfnrxEUAkgsGNdW3n7aGOhlusTOPenRU2cw5t9Oybsgo3G6ZJ+Ve4lgVu2cuF
 7v2aXmX18wToiXFMwfsJ5UQ+A/eO4oIhhhMZgp19e8DmjC85OpUX/lyQXnJ7HwJmu5EnRhH7yjL
 hwvN+i4+WUad4TUBM4yLRBiLECEdgcN0Sf/X9etFfv+/L3qQPL7sYaugcEVgRtrVdvsgvNVPLo+
 U5i50pYzn3uk7EDU6xHu7d0oxnCjDzWCfUzlS2xyH30zRIVaenNDx07m/QyVOkqjniNSVMNZc0/
 Sklcf2G0/RiXIwhr756JgcEE88=
X-Received: by 2002:a05:6402:4487:b0:6a0:f1d5:deb8 with SMTP id
 4fb4d7f45d1cf-6a0f1d5e1e4mr2791985a12.0.1785784163931; 
 Mon, 03 Aug 2026 12:09:23 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd4537702sm600132766b.53.2026.08.03.12.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:09:23 -0700 (PDT)
Message-ID: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Date: Mon, 3 Aug 2026 21:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 0/9] doc: clean up README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784164; x=1786388964;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6SBxh6IR+bKWxkny/iu0/3dpz0UdlzvJaM0AjbAfO2U=;
 b=MoD4tNuUkAx5P9ijB1EWNoYDbnyoCgXwug/jASrTxCduJbBJlQvNkItSO/R+tFSyKb
 EQqtR/uTEkespFJNPCPXppbTLSFOo4kFGI/HLMV6e/s7sMQnRQccIm7GtzwgEqUeVXVE
 f9EAa+bTH/IALgV3cjd2yyEXdCjrEr/4GFnPTikHVO6DqDAJ9Di2t69Ce0C6MMy7YgxA
 8mnC3/nZF2LxzftOa8sXHBdbmICL5Z1bziKQFk9cWzuGqKFsNSJRDvcxaqOzKP/K5wTm
 vkJXGgxiHPkQi7v6cTuNuFnINhBH1CG/vHSGJXMuowhmkaOEzifLKkwp9K+wpHRgVO9i
 cypw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MoD4tNuU
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

Johan Jonker (9):
  rockchip: scripts: remove rkmux.py
  rockchip: doc: add mask ROM mode text
  rockchip: doc: remove TODO
  rockchip: doc: add more building instructions
  rockchip: tools: rksd: remove reference to README.rockchip
  rockchip: tools: rkspi: remove reference to README.rockchip
  rockchip: tools: add comment section to rkimage.c
  rockchip: doc: rockusb: remove reference to README.rockchip
  rockchip: doc: remove README.rockchip

 MAINTAINERS                     |   1 -
 doc/README.rockchip             | 684 --------------------------------
 doc/README.rockusb              |   1 -
 doc/board/rockchip/rockchip.rst |  61 ++-
 scripts/pylint.base             |   1 -
 tools/rkimage.c                 |   4 +-
 tools/rkmux.py                  | 218 ----------
 tools/rksd.c                    |   2 -
 tools/rkspi.c                   |   2 -
 9 files changed, 55 insertions(+), 919 deletions(-)
 delete mode 100644 doc/README.rockchip
 delete mode 100755 tools/rkmux.py

-- 
2.39.5

