Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DA606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WLht+JnK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KxTi82zh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7778360681;
	Mon, 23 Nov 2026 19:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SaBJywk5P1pu; Mon, 23 Nov 2026 19:54:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F6D160608
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795463641;
	b=riYyqyITxiPNAk+Vq4RhF8EIdkoTxL8Yv54hIoHj053dzpXHgVDZCe5SWeOyTyhj5eLV
	 qpvC7o3T9v9VlZFVgW/xxSwklU0Fbtc/3i1VUmGKeeNGODKvUgN9WrvIm5GzPBHQHnDob
	 8vCfYVWKcWmVPx0ofGhECQcsAqxPnSNNpTB7xMxoAKhIPvltXd/4n2VBtFp4bzATZMsNy
	 hDWxccd0t8ohYkfRVEU642znJFClL99BjRlnq/2pvSu2Q2ka+eYCpQCslPaXTu+USf7+M
	 GRjd84d0iTOHT2IweggsczF9FgqxPTW4GyhonEyX4kamgAVBsEELh+UhzctIxzinZrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795463641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SCom6nZiy/AwTEHs37vDSVzjaI008FIIiEi2c5WiA8E=;
	b=chSO10EcSKlBhwUDAgYvMocKNkA5F8AWSodaa5wLHnoROb587QnJpfdPtqMWBLLL2RPL
	 2+Nck+wJsYLvhfda5csHOilf6HhovB6dlObtBTPGMvnatcGJKp0Bl0JspO2SPlYEFHrJn
	 s2hrQsHs3MKHZY1Gh64lM+M0695Nm5SrvdLkHyO0raUQfYmvqRZsetLzbq/SuTUO09ySn
	 iXRCFjOPl47NX2BBF7qbEceoZDHmHvMidvdzSe+IwGnRrl9mujsFsEjLwBy+PziInUTCY
	 9Yz/AIvrMa52IYY5Tg37tcZIdAzCzwjlOhpX+Ro2xNqcyv3Z4WvhICUUI2PMSYA1UUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795463641;
	bh=SCom6nZiy/AwTEHs37vDSVzjaI008FIIiEi2c5WiA8E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WLht+JnKuQiLplQq48glxzyFWi3cBYSavdRKgvkVPXPmaFfYMwDWLLf5aBd/mNI87
	 H9nYeIy+rLZ0LHSyjFn5dRusjAaloK59GgoTLCjYGA2TrT91v/zrinqrxfu4qp2ucz
	 i3jcjVw+/hD4OXDJOtHosBM+p/B3FBphj1J1Et70Bf6M9mlEWaxVfUp3lg/D5M7tlP
	 kv+n0edLez+qT4ZwPsUoaVRWBs94aoCquriw1Cxy8GEoRGPeSEB/GzqWHpgDa5f6tX
	 y9Tj6bWfNXo5K2NHj7x9fSZoqTC4teBJJv0XgEcskWHABMoSmriZTw6fW8FJmOq16l
	 kHX6uYGNd23Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F6D160608;
	Mon, 23 Nov 2026 19:54:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23EF33A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 000D140093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxLa4BuZBonL for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:53:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0C88240081
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=KxTi82zh
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C88240081
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:53:58 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-862d919fb1cso1751285a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795463637; x=1796068437;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCom6nZiy/AwTEHs37vDSVzjaI008FIIiEi2c5WiA8E=;
 b=KxTi82zhXBV9UOErrlPD0xFj0H4OZpiuUkztp0sEy9ziqXR6x+gx1TFDxkWnOpxYmG
 76fJbabLS3FISuviYkUroLuuXLdouvAeVVqej1IuXBbcMoWfHXJACtzwCp7FK/rc6ucI
 2hMbtj6nkxU49NHz8eoO0jyjV37zWU77WNuCl3/9tpmamv5H1zF5MR3HTI2pQMeVcRGE
 SQGmqb2xl019eerXxO5BOhg0WhfxQ1xArvIN1KGHTaAkh4iKKLMVONl7xJiKmzVdzeCp
 KwlMpk4IypieXv2NEWv2qc3JxnXvo2UssCF9iahwojih+PMpx/y7ujOsw/wiW31xanVc
 8Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795463637; x=1796068437;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SCom6nZiy/AwTEHs37vDSVzjaI008FIIiEi2c5WiA8E=;
 b=rowlXqYrVsKMHJSmG5rX0iwyoAGmWJgWkx/BEMthWlSgoMs9Uwx59FGcXplLd8fZ6d
 zCfo+Oo+JgoVVMUpMMD3ktMfUpIZqovl6kcgAx0zyoVl1OlZxoE8gmDs9wJqa2NFuq7x
 0bDluVutQcB/NGJI4fdi9hlGGhb3Cy40rw1CMGcHJJud0+3jjk+Gglo2ZveMzL8cUMBA
 KzGuFJM6cIazGLt4rqf0sgPwS+jl6jPAtGQa9KvRu4ZRsIDQpyFQvfYuQM85rMKpAcnp
 9zZSIKNp37jnw/SIWPjhw/DU3nhGkwiwCgkdocSkgaPA5QfPPbfVV4MFm1h+xUDPdZFT
 Qnew==
X-Forwarded-Encrypted: i=1;
 AL+hErGjxAOOumi3bKQIyiMQQaGbV/4plQUdQh2u/5yLvwOFvYiS7TeaJLw3i7Ta0L9T88OQ9aYBhzE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+RtS9JT9U12NzhaRg02tTX8PN4IykJAEU1KikX0nNaCT9kHJz1
 IjavmqxJdQcoWukuSmrdOlq/vKzaBvab++cTrI09NQF6oPmwnaN0U1TW
X-Gm-Gg: AZFdTZf84QR4DkrBMD6E8ZrVLTghQKK+qZnyx+7IDQ5SwlTysLkMAj879M9mioqRXWg
 Z7DcK+s0XBFgKxU8lIo8PQCITF1Al1zq4ANDML7A4vxwgmKfTiuEHzQCAtdRk+lF6BunXT4Uayk
 5iKrdnOhEPWaK/xf3Iz7yEy+jNLriG+GXymZBACwrQdlPDSOS2gycPSoNXNaB0fnbg0s48Ov/HW
 nv3RCFn7LqqIxTnZR+GV3QyJ238kT+Kg5kC8A6IlE3+I47tl7UuJFRw5I4hbbtdoHBqLLmrw0ub
 R7spLj3JPfOmy4SbLoUpMFRhJnzlB4nkF7ao3MJJ5gcpeEmFwIn5I1KDza1bt6/cAKwWOd2MRr8
 SgcQezy6qJ5/JEDQvN4yPRjW1oVp6RydenCRhdshS8IMEPe6nrxQ8xUKDSr+xkyUPIQW7wMiyPt
 DCQ4pHww9yBR8ODFploW24QjE9CRHvH4NTjJjyuOmQ9d4/w4ojVVpe+4s50cUi/K/AHWCfta5oP
 Xci2AMkzjke3HW4pTB4kGpZKdlxm5LhnEod4NO2FlLtDqFZCwuUakeqX50VyaQLhnCdP18g15l9
 c+mUudq8qu6A1ZTYwT1SCWz8PNDOZ0mG51N/2WpqZoroLiUs+BgUhOpXtaXuWaBfllNHz/mCDvG
 POxaPiYmiAq+bcUYHJLzINbZri7p9p6ucjznNlW/uNZes19o+/myzxfF9FGBvrrxS5PIuXblmgj
 q2TVa0rs89cPtEREXodQIRHUiWrY42m77i3MPpYUSL51+3Le74O4JQ
X-Received: by 2002:a05:6808:1a0c:b0:4f4:fc4e:77e9 with SMTP id
 5614622812f47-57a09c0ade2mr13795955b6e.42.1795463636947; 
 Mon, 23 Nov 2026 11:53:56 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm10307575b6e.3.2026.11.23.11.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:53:56 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/2] net: ftgmac100: enable Ethernet with lwIP
Date: Mon, 23 Nov 2026 12:53:52 -0700
Message-Id: <20261123-submit-lwip-ftgmac100-v1-v1-0-6b34bebaa2de@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB3IJLGgVykuNB11ilpJ4g+Id
 29al9/ivRMCe+EAVXaC502CfOYEyjNwQzP3jPJKBq30g0gbDGs7ScRxlwW72E+NI6VwI7SmtIW
 hwtq2hJQvnjs5/utnfTu1b3bx94Pr+gIiihFpfAAAAA==
X-Change-ID: 20261123-submit-lwip-ftgmac100-v1-4394531544b9
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Macpaul Lin <macpaul@andestech.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow boards with an FTGMAC100 and an MDIO PHY to use lwIP. First give
the driver its own padding for short Ethernet frames, since the network
stack may provide only the bytes that belong to the packet.

Then make the MAC driver available with either network stack and select
NC-SI from the device tree before probing the interface.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (2):
      net: ftgmac100: zero-pad short transmit frames
      net: ftgmac100: allow conventional PHYs with lwIP

 drivers/net/Kconfig     |  1 -
 drivers/net/ftgmac100.c | 24 +++++++++++++++++++-----
 include/phy_interface.h |  4 ----
 3 files changed, 19 insertions(+), 10 deletions(-)
---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-ftgmac100-v1-4394531544b9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

