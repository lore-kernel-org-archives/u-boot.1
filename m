Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58643CD3423
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 19:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB4E88D82;
	Sat, 31 Aug 2024 21:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="duG/ymTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF1088D83; Sat, 31 Aug 2024 21:54:12 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8450288D65
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 21:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.belisko@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f4f24263acso45145671fa.0
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725134048; x=1725738848; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j0mK5VWk2htFkd5vNZ/RwaaIypeEKv5ZWQJb+846L1U=;
 b=duG/ymTZPbFpCaSbMwYSXhaz0fyIYDUeLSKmGDjb1q6f5iQOpMePX+LDIPh20X5kgN
 cSm9FANaKxnTnTtNSEKQSdvxHtqgoAEqR3vlvS5QorbdLEm8fScg3RvMiSxQHOHauANH
 OC2JfoA9NGIpaOMkC5+yXxi5K2zqmB07LB9CySry0hOjNKKcSaU9ypvPkgRihJVDFuoW
 Cju4V+6cpZ1AmqcpTre5tDYco/tzotKfbKdbH/C/YJJ+e8rk5pYen/daawpHrsg91m2y
 +IAoYXn7rHYto8b9zsnogea6aG5QnQd6CsH0ddmo8ppn4nAJ22OvVairadrNWHv+qulf
 m9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725134048; x=1725738848;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0mK5VWk2htFkd5vNZ/RwaaIypeEKv5ZWQJb+846L1U=;
 b=JBpIsWK740JVC3R3mtET917w2PSdQvULp4ybiync697F9OdTTpeta6ggdERkp+1EzX
 t9lOMEQlbelclcUCLiYFdb/OoqjsMPO8i9E/W8hEMTHqi058SSkSXX82E/mVxtNnZ3U1
 yn6HVzxubBYeuWZtjuiIMprAHkyAG38miGA57LbTVgVsjf/4q7Ue34Lbu3cobg5/P4vy
 nmyzu42yK47cq61PWSFfpswofgH8g5feMIWefshuuacWiY2T3k699sMYvdj0P+HP0AAt
 K64x/BlFcS9wfXydP+HEWUlVLJippSNRP0jVVnd3rB/rBsKLnxp6ltZXxVQ3Folwsha4
 x/8w==
X-Gm-Message-State: AOJu0YwkE+ziWGGvMCiZSWn9rtvXZd2ZMQoVGtlCvQK8lqF3q4+y980i
 vtQP+yIRsmk5bC28Ck8w71aqJsyqvWd2ZKd8q5l5CNsLIs8RdAOV88g9Ee/hbe8NHeNvKQJL1CX
 rvA8S55nheeMHPBRFN6ZprzcM57SD12e1vNY=
X-Google-Smtp-Source: AGHT+IGgelMhpR/bwCV6h6Zh+7HtBntLcyonoObkv+tz5ZkairnsbDU/yv7duoZ9Vak/FObAlmnMVTobuqQVekkjCFM=
X-Received: by 2002:a2e:be2c:0:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2f6105c47e0mr92246341fa.3.1725134047592; Sat, 31 Aug 2024
 12:54:07 -0700 (PDT)
MIME-Version: 1.0
From: Belisko Marek <marek.belisko@gmail.com>
Date: Sat, 31 Aug 2024 21:53:56 +0200
Message-ID: <CAAfyv35tGSQHb7BxXGL3+KkQOu+XhGWEwe6fKoQmaNDXd5R+mQ@mail.gmail.com>
Subject: imx93 accessing MCU_BOOTROM_BASE_ADDR
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

I'm trying to access the MCU_BOOTROM_BASE_ADDR register to preserve some
value between SPL and u-boot (regarding DRAM memory size). Such a hack was
used for imx8 and works perfectly fine, while reading MCU_BOOTROM_BASE_ADDR
in SPL leads to the crash. Is there any peripheral which needs to be
enabled to have MCU_BOOTROM_BASE_ADDR available? Thanks for any hints.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
