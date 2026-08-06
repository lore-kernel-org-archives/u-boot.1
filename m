Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA53C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88580809F6;
	Thu,  6 Aug 2026 11:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wI8OPe_FSXPT; Thu,  6 Aug 2026 11:11:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C318080A82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014715;
	bh=WNspZQAyoDvxoF8Kks5uDmmzshNe1GpchsB421BYxrQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=awf4drU8vyLniM2fXt/WRxSTAQVka0+BZFidh4MeoEwxP5/GMEkVX1qIQ/zcWCfK0
	 EGtb1iGLOpTpS6jgcgPszjqMbvpL16ac7XiY2V4HwPNDCCQbmHTlKnHbAiMNXctI+j
	 zkbeFxMrmY2WQQBEgz/K3OAAESt6XkJyr+Z0J08y4exO0B0k1XFoVsIrfvHBJpRkSM
	 SeNEaiPv2LyoO74vV0UZVHLuhfNPrXeorxb1NLLhrlK0nEJZiV7hZEwrY9+tm6vuis
	 VvhlPecfoaRco0cH9cogrqMGQuvrbNmNCqINhrtMZDfKYMNO/y38Xy+tESyDk37NqZ
	 a2RJL3w2IB07g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C318080A82;
	Thu,  6 Aug 2026 11:11:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DC813F9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FB93809F6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgTAIKvFRUwN for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:11:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 725E980A95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 725E980A95
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 725E980A95
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:53 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a18af264f9so269232a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014711; x=1786619511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WNspZQAyoDvxoF8Kks5uDmmzshNe1GpchsB421BYxrQ=;
 b=XsN5cTME6usNtWhtBbLe7HSAh9s64FZJ9Z6gTBsf/2PveJcCRBEkGnKqRIJA0vExJX
 Y64ghDZNERle2pTpgIEGjzmMksdqpUnTLNaWWb5Jmg5DDD0C0IxI1/4W8cn9XwA6SMPm
 KFZOfR30epvNA2RJgUA8Eto6yTugnrLSWSOf9D5zFNh2REx81JJKbOoUmHoJwfQjeHHJ
 Lim1eof5hhdkE7Eq19HDg4Kv13Wkyj3o4ULPE95SETZsgYoTLHpr8i4llYdELGKxPu8b
 YkgoT6dATG8T0Fk7qml8MLiuSk+kZy81ybTHwpXGQQPVvD7FMQZq3GoL1aHMLue7osdv
 eDvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3pONfSFuquupIiBm8WZwIyLNRC9VxZV9IxL6BvO8mtqwhmwpaMvGjyWJefS5bc5qauKK5ljQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzyGv3a3kas84n6+m59jjYvwOjrR6OMFxSZdrOag4GANGXZlTcj
 GKmIgaa+OeIzqfbDHquh0PLhAqLOF+qw447XrAq6TB7A8yZeJn8YogJc
X-Gm-Gg: AR+sD13d7LAA4STmltTJPLbRIPa+TEf7tM8YOsQslELeJbT/4pwl8pk4MQr0josp8M/
 pnfqsde6nuYEVGYOEmOYzqHZg2biKbHOi96qjl2mKKqF+NvCKlJoT8KcUadCrfO3i3Jz4CDMiEy
 3LElOH/1fJ6X0OwScblPkydyth2PpVD1VkkorffE3hkV7QkOq71sJDlNuJ0Nvlvs4fd0ozhtCwB
 oDhlB8D2Cfwyh44h4i5DrvtrYkbWuFCNgIjW7jd9rbDGhu6IT/4LQWlFdhQMaePe8jc1GWPHESP
 OPlcqvAIzAp3aacziTG2z3yQ0MH7PqRzVqTEPAarULH1VQqc8WhBQzXG42IOpS3Nn/LFL5yCqHy
 Hyzum9sxyYlzX9tI5JzRAFbpHGCwNxeQUpgaOMkS5Nu+/wOZDk1ZpigjBPITJKM8Ila7lA+0Oep
 Sofmyy1voFfJ3YC4RXtFY6zITvsgp47CqQ1eu3uzCAv9Jg1QfzTWvwjF5A9S2spZ5kKAPHxurUL
 +eJpt6kwDzb/PBIId+NZoc2ff2wfg9Ao6kd4A==
X-Received: by 2002:a17:907:a88b:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c2039824c4cmr375858866b.0.1786014711185; 
 Thu, 06 Aug 2026 04:11:51 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20363e7638sm238732766b.30.2026.08.06.04.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:11:50 -0700 (PDT)
Message-ID: <2c6b1838-4386-49e6-9a2f-2728fa7594e5@gmail.com>
Date: Thu, 6 Aug 2026 13:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 6/9] rockchip: tools: rkspi: remove reference to
 README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014711; x=1786619511;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WNspZQAyoDvxoF8Kks5uDmmzshNe1GpchsB421BYxrQ=;
 b=ldgTAtqqGhsEFewoef1SO6r+2EPewf0k0dd3MqOL/ZjlXr9pQQHhY1Y9NvvAjp6uXu
 elJyI8Jtv6kYvTp2LNwdmjYxUUE5CIGqUmI6UTt+sR6qZNb1NifSI10r5D3BXYfMBcsa
 cDgvXnEgHLWnGdgS56EaU7t9ftqP4mD9G4c0C2osZMYV3mFULO90wn2XI4EbtXovaFOk
 VNUok3yyQiO/uQdEAxcAIV+ygH9GI5G1WhhL0FrbTmysj7rCEGXXJ0gWgoYdRsGW2dYY
 X/aO82V7yxHRjOn2hzYu4vne7tSoc5ng2NtD8Fz6vqtGXOEb3Un8RvKta4IpERupDrD1
 AqaA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ldgTAtqq
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

README.rockchip must be removed.
Remove the reference to README.rockchip in rkspi.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/rkspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/rkspi.c b/tools/rkspi.c
index f2530f7bde34..63770b61effb 100644
--- a/tools/rkspi.c
+++ b/tools/rkspi.c
@@ -2,8 +2,6 @@
 /*
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
- *
- * See README.rockchip for details of the rkspi format
  */
 
 #include "imagetool.h"
-- 
2.39.5

