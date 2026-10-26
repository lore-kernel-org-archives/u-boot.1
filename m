Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CD606A324
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JlxIJfgG;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aBVOwNF3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59BAA605E7;
	Mon, 26 Oct 2026 14:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q85mFqPndB7V; Mon, 26 Oct 2026 14:44:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9A3F605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793025886;
	b=dgzO/0wjJ8WEqqRMj9mo9CYNKR4JuRqdiSpdlhZHPmBcNXaWxAM1qJnv+uzkX32S58hy
	 nBkjWKZHvDjJGPnf2OMRdYSMHJfOvpziQJm2FxLF0e/dhNYi6BoxFwI3vfbn14ALSLu4k
	 YN/s+zanJfDRKbCm/RymQU3ht8s3GTZvsT6T6xprw9ZfCBO3wM6IDpOzUYZWNx90G95A1
	 yO4kJvw+Rl/jiSm54k70JZC6iYp/F77KDxr/nmmT1FErDGX+9iaLkPmXqtQTfmKnrkNFQ
	 e8e1xB2CCohDN1ufpYTpKjEmP5Awyshphp5iXdpNlYR4iMETjwJd4CIlFpgbrD13C1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793025886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MOmTzh1hgnnWU/IBec9F23Kpl48lWXB2YPFcMS9UVi4=;
	b=CbZ9Hf8MIcz+Z+N6NHvxxiVVt9PqQ21gTL3Hq12xfFv1m9+aiDOzVLk0w3GxRGzdBRJl
	 guBCealCtDBnd31QNpcT6CNMA+bWnoTjixvCtlSlrurI490J6y6JdcKkLcES3TQcdDGZb
	 E8Nrp9jOIolm+T+auBaF42AnkuAKzf/XGweGguEpY/2QBTUnA0XUqBpOCEX418uQOlYPj
	 SiMI5IkJbQAwDLub8dfczjInn8oxxMq5xC6gKuzNReUbWBz7jJc4ynSeTPFeQHZu4/ocq
	 ud1SaCBc1uub5dUxNV+HGSon+THS5hOpKNzjsNixHnu4Ybk+4Jl2PEnGGtTGHIuoebw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793025886;
	bh=MOmTzh1hgnnWU/IBec9F23Kpl48lWXB2YPFcMS9UVi4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JlxIJfgGRcoeiU2mVb60e8VhzuF3WR3IfSV4WPk0HUA+aNwvZiOgwzUBDaUhmhmVL
	 DffEqsBkh2OYQ71bwK8Ssa9mEi2tAFIDQhNyBQMQPbEjRhZHUejMb6KWGs1FCTbbnE
	 VMd0tsHDSMbiU6PPIM3LT2LVU7cflh8orkjPuqX1iKSRNHoYBP5cudy1PeFo7yyLvW
	 bTPFt+jad0zGZekvKUSPKANbaKnsuvv9OamR2zwwWVloguROBPMZf6oaDztFJO9glS
	 YUmJADrTg2tNInwgGEySbc5qplkUNJDWQJ3Rt5ByZNrY+uVOUHTDWmBqT7AO1wRFfC
	 lVRmXqy1kCsPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9A3F605E8;
	Mon, 26 Oct 2026 14:44:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 622922F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 483A4401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8MGgMUHvy0L for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AFC0140062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793025670;
 b=Z6YxfMv+Yz7Br0HtPIgEtv3kZ8ScmZZlQALh5dbp5xz4YsfNT5pDYTX7+8ttq/nwMvVu
 5tX8S7hya/JT6CymrHqXs1XQNjosMJs9pOA8EKWWPc6Ad1biVJrJ3OyB3fc2c9Hl5JK3D
 XgdJlW5wt+ecGipKoTEZs+MmCt90bx19BeaZqqr+SYIvCeirb/cd+hRNHxJgWsQ3fvx02
 ChSq8Rt2ybY6o+yUBcMDBx57zGs6+fp45stQHZiAxbmwOq+AtEdH22k3JDt8/5+2GqHc1
 zssvzCpJZPffptd5oHpiDDczl1o7/63gnSLSFykZiSyj91KXy/R/p11/fUISmMINHOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793025670;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=MOmTzh1hgnnWU/IBec9F23Kpl48lWXB2YPFcMS9UVi4=;
 b=nepm8KJo2r1RrfxXKr+meIoEWF8el1Ig6b6zK7RYWFXUIpLLS+ubASK4D8JcyZHORmAU
 03xbYQZhwMSPCQOXfKUuUNjZb0EgfQrgiwEiaXMKcub7JrrH/AZa8cpHJFbOKRkFiW8u2
 7P/D5mubMO/8H61uZhE2+H7Y1qar/esM8l3Uq7xeUDMf9oZL7M7aFMz9nAinfSHbnrxCi
 gCdqJrXCniA3eBBCJjgxRIznx2nCXu4oOVa3uWLBd8m36Sqh/Wcb66qLc9XMybBNQf9Fg
 HMNjLejx3EiTZ/U3GobmluTAK1eWAma98Us/Tuwd0cUVueEZ3zxZpApZAUM1QkJ3jhQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=aBVOwNF3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aBVOwNF3
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFC0140062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:07 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso19899265e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793025666; x=1793630466;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MOmTzh1hgnnWU/IBec9F23Kpl48lWXB2YPFcMS9UVi4=;
 b=aBVOwNF3cBrhjQmmbPuYIVGNHvDRD3TnVr8cD+o2RZpeieRs+DzXjwchcSW6/ttN3g
 1Dl9vmh5e7Ef6tiRpuANQl/DEmGDTccgcOCzAeqr99xT9QRMzD7Om5Vd/c6SHVdVgaFc
 2C0LZykWxcmgrit9sRdV5fllHwx8NFg5bShsM2iONdNa5UImzJptDO0zcpkzOo7uQaln
 G5lk8/uuG3GztvFBR+RU12PWUh0VrgDI3d3BjWHB62xgXRYNElRQ9Nj6rSHZoKRklXvo
 ur1OCE9jc6MMMlT+bhDDyFeulBSXr7lBK73OFQv3X/jN0tsY5jrn8ks4LM1XWyEz6oIc
 +vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793025666; x=1793630466;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MOmTzh1hgnnWU/IBec9F23Kpl48lWXB2YPFcMS9UVi4=;
 b=fx3P55hOoAEskZDb9G1J1Nrlrjekea5wHWyAam8hJ9UywMtwIzyK2O8+6dIwPVnobH
 O4jE2+0HblDK6qqvV7cyFfVimQom9lRQiup89gXpL0cz+scLP8YGQlITRDhdcv3dIMkL
 75UdRvDRcnpOGK/TPeoXQDb51Ra8or3t1/ZB6KfvJHo2GGuM4eIFLEd7cNDGJTaX4ukO
 KKc1w5TJtiun8SvPymthuxoUtqAsIM4KIPrVb6LebUx+MmnUsWUbSpPlSxGzwSNNjFrO
 rnnHUo4k+p8CcnZYd/JZMISzliXdofxrRHYLHwqhkAnOvv/y+BUIR2EVCSygMM6CNUSB
 qZbg==
X-Gm-Message-State: AFq9FYI6akXMQV1zGB5/EghE3ucOQib6N3eZ/syHo6/vN2XhDIp2VCoD
 70R1V+cvAPMT1JTTReWt9nRn9+traPmRvMBbIuggbtWlHOE5lmKQB7tpv/cQaQG+lwg4VI73wsO
 bS/nr
X-Gm-Gg: AYBFou0uOFpbmbOqo8kxrMEf+RtFjgA0FGlYggWXeW3nDLzo2bfiNPPumC83I0iCO5B
 rpx70h3lkJ2ihYlvgjuG7l8vjI1LX5AYOquw/1dYqFKSdF/pguGiXqqh0SpepyVuzHEomjoo64N
 J3l/ixXx4JkaF526h0UhHilGTB4Vr1CfbpBMv96u6w043ozGSaPrIuCe0PhXtszDNlBR1XXQmOI
 LeS9jafZAdqWtaqdTpGcmOon+4wunS+XCw4jQx4pBau+YmoRPtfxgCCHLbVbsf61razvu7pSjc+
 mAvFjlPjjpSOqsRp3a/NHqokZ2vIu2tf8gkn0TlOEUwoO9AZPBl3s8eWHbBIarbSwSjU2SsnpMx
 ZJJjxgTxyWDghFtQ56xX9Eqr3SjdxVsQdf8CAl86UJ1vcf2Xc+qhkstmM3ecvlpZBoMhc80KIoZ
 iGv6fi4qxABa3hgAI2XjAkRg6vbOG8tJyK3yKC4sEXIoibBPYbUr0CIKCA4v2kKcBTGqxFOET4h
 jNtHZMlifjd9wt4wJMq0Q0mNdaiiTvm8cs+dDWRAmUKuzzwn8fRrYHOpcMzY5U23k9z06G9L7Bk
 JoHUtorAtOQEJFmRDRrAQqcjltxu
X-Received: by 2002:a05:600c:4583:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4a35acc2773mr145750925e9.32.1793025665829; 
 Mon, 26 Oct 2026 07:41:05 -0700 (PDT)
Received: from localhost (2a02-842a-9b20-0d01-a06b-e180-2ea9-f6eb.rev.sfr.net.
 [2a02:842a:9b20:d01:a06b:e180:2ea9:f6eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dd7sm16340610f8f.15.2026.10.26.07.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:41:05 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Subject: [PATCH 0/3] env: flash: Add env erase and enable it on R-Car X5H
 Ironhide
Date: Mon, 26 Oct 2026 15:41:01 +0100
Message-Id: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH1m32oC/yXMwQrCQAyE4VcpORuwq4Tiq4iHNZ1tI2UrGy1C6
 bu72sMcvsP8KzmKwenSrFSwmNucK9pDQzrGPICtr6ZwDNLWsU4Y5pRMGXnhNEUfGSU6+Cx9dwo
 SISpU/8+CZJ9/+3rb7e/7A/r6BWnbvpfCmvJ9AAAA
X-Change-ID: 20261026-clegoffic-env-flash-erase-46d8326ae6c6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Mon, 26 Oct 2026 14:44:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the missing erase operation to the flash environment driver and
enable env erase on both Ironhide U-Boots. Tested on the Ironhide board.

---
Clément Le Goffic (3):
      env: flash: Add an erase operation
      configs: rcar-gen5: Enable env erase on the Ironhide RSIP-M
      configs: rcar-gen5: Enable env erase on the Ironhide Cortex-A U-Boot

 configs/r8a78000_ironhide_cm33_defconfig |  1 +
 configs/r8a78000_ironhide_defconfig      |  1 +
 env/flash.c                              | 61 ++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20261026-clegoffic-env-flash-erase-46d8326ae6c6

Best regards,
--  
Clément Le Goffic <clegoffic@baylibre.com>

