Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E86C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC56580DC9;
	Thu,  6 Aug 2026 11:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yad1f14WZ3P9; Thu,  6 Aug 2026 11:08:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9680D80DB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014531;
	bh=PxUOslIV4IaKLDO+8D4KEdIzygDATI7s3+PcZMRr3AE=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eHIoniZYzkeqpSbMclCuXvuqzLD/MKnjAOcpcJF2voMt3qdURtsEpNp0RDE0GkVR1
	 RqSBsuk7d7eHbqQ6GNj7zf00J2Rd1+pb7UVu3XI32NvDWXQLqqgVlmIfVaUYCfGo2J
	 ERlzVCTioWs2WuUgYaLgxwQ7YWMLgrt8QyoHRWuqCSkxXIkS7/s7Fkv3w77Kxv3bK3
	 7ZSIupa1ZcNH8ml2EiKGqB9utdlOIfPLNliPPcODyZZjdDLZEOsJZfl3Tuu02RRwyK
	 UXgNfZEvnDWtR1RuoUxv6F2cOm2eu7g+2ZOAimqT9ZllGurs2V54zxByVMNUIAc9Q/
	 UJRKoMmMAL7Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9680D80DB5;
	Thu,  6 Aug 2026 11:08:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A90D0282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B7C66070D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JN5Dej_LjIy for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:08:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9A74A606EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A74A606EF
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A74A606EF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:08:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c16036356c1so23143866b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014527; x=1786619327;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PxUOslIV4IaKLDO+8D4KEdIzygDATI7s3+PcZMRr3AE=;
 b=Z7SF91UMIE1UCKOMX4D1YNNTeVX4dWhim8XIBviC++qkFUphU3pSEu595+Dx4/XKPZ
 ifjuIZLf705/bgjanmCCSTwmaby4H5obXsC5PqtN5G2Hy/i+2rfX7a7/eMcockxzaJZy
 bl7ylvXVIKAIMHocCi+1mW1CWs61OfcsinVBEsAzD04SMEZW7U3Hks7gFcvTtXL6RGG6
 fNVqWFOcDmeKejc9XuERkqawCxRUUImJrgvUFrXSD1n56VUbp85asUgn+wikN1pK8n9n
 hT2KnTL8EiBHxVdl40qBeNHTEv037nLygzLiAm/vkQXZADplxDDdEL1GTxwPEsBvrjWP
 HTIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+7FOXA6pH1kRI0zOlhijbyJgQr1OXoaAdbwdL+QKqVeyNTqZHp760Pn33ckW5f+987Zr6ypg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxSSzHOquvEESwbKNafiLmw59/5rwsKinVqKSDMbpdBueY9zXkr
 fHOfKq9AA/vTvnk4ppA+TXQ9TSxkZALuDCcaBXNaulIFjdEFbeMQ6oAa
X-Gm-Gg: AR+sD13zdhLxOU5oeuifgM9gYTHc/7ZRCUlI1WDqf1zfZFLm9cNaK7amzJJMYHLAd+0
 MY7ytkKYbnaUaHL4bU2/ufNrfrqO294t3CU4O7xBaQLDf93JJBNYISdr7CHVe7CZpcg8XgPqrYL
 yOFI2ORnrajVKSfxT0/sJWmpdW/zYV3w6ey8rRGMqiwPg3bREkNBUAtwP2hdlE7Osk0zlcP6AzA
 Q/qBkBbXs6xpBBHMMctDgutpiyWcYXswtVFQD+LKDHBs6hFaHclog1X+oSBnutIvbKCoSqeyyV7
 hk/jTazw0reDcWalLbL6IiHb9cYP8827WzWVAemj9jBa/utI5wPRTM59UgycjV96yapx9Jma6fK
 JT1xy9gdM7EBGzgjhZh7LUDLMY0TbOZehBnYP1/OoxUb/6DtVDW2EEKbBivTmvwCUATgUY8ehe4
 3Lmkl4snaTaFxi+7aEW66EayUb1BgYE9qmfEQjF+uVvwKLRaHMgqV8WkVHIUlMmxL+iBsQz7E1K
 6ZNhoOTi+VStLHsZ53h3DeHiVY=
X-Received: by 2002:a17:907:5c7:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c2039ca6a41mr350689966b.3.1786014526967; 
 Thu, 06 Aug 2026 04:08:46 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2053fbe3ccsm148930866b.16.2026.08.06.04.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:08:46 -0700 (PDT)
Message-ID: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Date: Thu, 6 Aug 2026 13:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 0/9] doc: clean up README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014527; x=1786619327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PxUOslIV4IaKLDO+8D4KEdIzygDATI7s3+PcZMRr3AE=;
 b=NZfHw8aQGzW0aqWknkjJ1NXnaDORJZ4WI28AulFQtMh2HsPh24gjVPrOKoRLvjG9rG
 QOtIV9G/iDeVMoMNwbdW70ZtqQyP5dL5A2804DzDTiT0MFtFr1yEymTGPRvYRPpBaAZn
 iAlB/lZ6+NbkgXbKd3Ita6FNCsmYHupamQDEVCbMqJAvXMZH6FDO/5f3dHKluU7X/Pvt
 YZoCqvhuIeljad8va9XilJ5ziHtV5ToGaBprfkKOf4mKZrkEI2KEggNvDgqM6mwcoM/E
 iyrZ+6vJRPo1GzF/BuJRy3S+Nw6o2Hxrh8XcfueWIdAy0/5mjrhp0dMTpbaYYmjb2yyE
 jv+Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NZfHw8aQ
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
 doc/board/rockchip/rockchip.rst |  60 ++-
 scripts/pylint.base             |   1 -
 tools/rkimage.c                 |   4 +-
 tools/rkmux.py                  | 218 ----------
 tools/rksd.c                    |   2 -
 tools/rkspi.c                   |   2 -
 9 files changed, 54 insertions(+), 919 deletions(-)
 delete mode 100644 doc/README.rockchip
 delete mode 100755 tools/rkmux.py

-- 
2.39.5

