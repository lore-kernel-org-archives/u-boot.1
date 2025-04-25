Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E1EC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5CF826AD;
	Fri, 25 Apr 2025 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nmrnoaam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC88F809D4; Fri, 25 Apr 2025 09:39:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3746810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 09:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.t.freeman16@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so12979055e9.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745566742; x=1746171542; darn=lists.denx.de;
 h=to:subject:content-language:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MCpfJEuyMH0OG6/xRgjHS5bfsWS3b3GTd/67K0lMYIY=;
 b=nmrnoaamZake8HQ7RlFUpoldi+GPIj2qx+GUPKQPgZ+pjOwVnWDQRAf62sxtmZzCDL
 ltILps37xi/DNl3Dgzw3kLoICYG5pPm9OyzMBozREH1O26GDHLfX1BfS9YA+T9LcQIXF
 0T0016jfQnpaP6TVB5zw3wCh2mfQezOClw7SMF2kFzZ7R6Cae6e2vAb2QsdZEX62KQRG
 9BaQRcvfKM67LuznWLwdN5kHIzHb2MN4+JCGExdNsVzIaa6v2DEYr4eXrr9tl2bYlv2o
 xMJCUvg8Gi8risoWxobQzz2rfEa8CIcVCjRbNJdz3m8i7GgkzzSvcnUvAui9efr8Mpwb
 +67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745566742; x=1746171542;
 h=to:subject:content-language:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MCpfJEuyMH0OG6/xRgjHS5bfsWS3b3GTd/67K0lMYIY=;
 b=EbDd+iT5HQm0nScdlcOqJteKTakkWa/sS4zxASkL7aoFYT5vB1fffeYLvqiDaKf1Kh
 Z75g54CZJcu9NRwWbxMscbtTdVX9MsQuF7mfHNxXKEpxlgTGdLJGcTNGPsNgsZlPfcdJ
 GYWfxU44Cw0sVd/qFq5s0nVmzpmZkhi4JzpVFLiV2FEK+2fFUVgwTxjGuNid9KQ+aSFb
 2GMyWDrKwbRPJyVsgr51QHgmmx65m14kPf2OSDzylB/wALboWTwwAsGoOijHDdAezy6b
 MgEz9/fWvNWCPD7Jf7uoxCLvGI1Z4RhWbx0uRUuM4US/pyXH0cV1R9MT7xe/8QCTAr4f
 rTTg==
X-Gm-Message-State: AOJu0YwL3YebolGs3unTcTtYLzVy6JghuToCuNJmzBmoK+U0g0ksj9z5
 6dpuCwvqb/0YX1BN9P7MnKbpkUG8Kjf9nt7FinDvlYkYNvZdYGMaD8tf4A==
X-Gm-Gg: ASbGncv4tVfnbUavldcqelflczDwhMU1g5hQtzwEDhaw+VUHIBRxYCNCQ93NEpUHBxT
 UW1cb73Rr7GT2Xu76UO4P772hHb2eHr4OC2wHfKfWMQo/cKPAxVUEzWrvDY6LSm+1jLYeIOj8Hd
 HbUlqa+4YQg9MBhBgmV81AV2jru/LppoGuY/qN9oMlY5aKnfcnPiwcJAxJOnlBTzh0BQRuHPglj
 L6Nh9+nVR8FT1Lu56lE77yqzt71Ha7OlGoHG1P24xv9PghIU7DGjw1V6Ousq0gwsKJf65NN34d8
 zn3HrgwSNPq2+OC9d08xmKiSBTnxxYL3mHf4uZd9yloIFcmR00DrhG1T5tAxCS3Rzp61Rg3XjY0
 U0+jw0+SnUugXLZFAYZVQ
X-Google-Smtp-Source: AGHT+IFy4yK8iYoUqKpHTrzzUv2umr5vx2XwLY+/b/bfRQmwQ5qsQu5Of0sntQ6TlXkc8MUeZQzEkg==
X-Received: by 2002:a05:600c:4754:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-440a6614543mr10054285e9.15.1745566741794; 
 Fri, 25 Apr 2025 00:39:01 -0700 (PDT)
Received: from ?IPV6:2a01:cb1a:4058:758b:56e0:a3ab:588c:216e?
 ([2a01:cb1a:4058:758b:56e0:a3ab:588c:216e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e460b2sm1509169f8f.70.2025.04.25.00.39.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 00:39:01 -0700 (PDT)
Message-ID: <6f4dda08-7944-45f5-b454-3880f8af4d29@gmail.com>
Date: Fri, 25 Apr 2025 09:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benjamin Freeman <b.t.freeman16@gmail.com>
Content-Language: en-US
Subject: Flashing U-boot on a Google Nexus 7 2012 (grouper)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 25 Apr 2025 16:09:21 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

I'm trying to flash U-boot on a Nexus 7. I've followed the instruction 
from this page of the Read the Docs 
<https://docs.u-boot.org/en/v2025.04/board/asus/grouper.html#u-boot-for-the-asus-google-nexus-7-2012> 
but I'm stuck at the "Flashing with the NV3P protocol" part. I can't 
figure out where should I get the android_bootloader.bin file mentioned 
in the command: $ 
./run_bootloader.sh-sT30-t./bct/grouper.bct-bandroid_bootloader.bin

Does anyone have an idea?

Thank you in advance,

Benjamin Freeman

