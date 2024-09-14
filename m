Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18613C02180
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 07:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBE688CC8;
	Sat, 14 Sep 2024 09:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ne1BRZuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F5C88D03; Sat, 14 Sep 2024 09:34:52 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3793F88C71
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 09:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.legoll@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-207397d1000so30493865ad.0
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726299289; x=1726904089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oP1D49I8YoHmlyIJt4hXDB6YHInctm/wDwSpasb/MpA=;
 b=ne1BRZuSrrHn/sNVnyfTwzyxH0wKiVjq4Im8pX+lRPSkgOtqjACq7IcHdyF1nbAK8U
 rTNkVmJaT+JVE+SAQWxAIiN1Nl+R5Hkn2Ydw9it1BKQoRR7NFMGk6XnpocBJT0Dg9wmG
 mzCxz6TXP+dLHxhmTh8kHQNIG/9wEX936RnviP2GiXYhRWkby0cqWtYwh6ZE2D7mLP9Z
 rcJUp/plug6lIu6b1zgo1mviSP6A/yG1ZzZosrsdEYh2Lzc73q5ygd+byElVWOEfSvyQ
 egbz2+Sjh/N3Y8/xV9iUXfjcAqy1xBwmQPmAI3nMaWmVrni99S5nxv5ci2VqM3kRSxfj
 oUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726299289; x=1726904089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oP1D49I8YoHmlyIJt4hXDB6YHInctm/wDwSpasb/MpA=;
 b=l5Yhrbokt57I93/DR8EV+M3pe20i5Qn8VEUwDB2G8k+LQWp8z7sVngivytkkhLJ8wX
 s5Wj73sPKWtwP+3ek043ourdCdOoNak7VMPlC/AusVIhbuYJtsLhE8GkCba0ndVMyy1j
 IeBKGVs8cVJJVHLSVGgt9zmN8kKOS44O8UFDqKIlEtpWqxLjOmHr+OfC96uw3aWWifkG
 ulbc0mUptAdmIz9zkKoqODSw6m3SafmWPZK7IyNfvpDfYiYpZtVSxI46s3Aub8c8qZqn
 EHvrPt4EPg6UM6+c1J1FVoST9MC18Yk8Tx8nbZX5tc/ASCPKID7wlLrx9BkP4+JOmRtB
 uSgQ==
X-Gm-Message-State: AOJu0YwJfsNvCnJDdwyP5V/T1eSt/B/7DKKD8GgZxNioDWz+FoRO4NlR
 OIAZF9e6PHSUDnHAGvEyFguK+u8SVpHcD8AOiYHDgvbu2kLMJX19IU57NjXGPgaG7wuC8j++cjZ
 2eJ3NU9SmQC7ZaraM1X78p3PvRhI=
X-Google-Smtp-Source: AGHT+IF/HdTN3pVx12dgkOfyM42qXvFTKsBuck7vjR5wzgKXrcFl5TAx/Ua8D/LAALlgwJkvoXiQECrv9t+dNJDpwJw=
X-Received: by 2002:a17:90b:906:b0:2da:82d4:c63c with SMTP id
 98e67ed59e1d1-2db6717819bmr24544564a91.4.1726299288526; Sat, 14 Sep 2024
 00:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwRq=qZSs9va2ztMQ2t_kfqHFAiMydyUHY13U_-AfKdSuhL-w@mail.gmail.com>
 <CAFLszTjSoLW769CAefgu9wzm5VBVZnvyPp87f2zi9ecUtPB4mg@mail.gmail.com>
 <CAEwRq=q8WT9jPouwu8RMNjgQYkDeRoFzBDhiLOTMgyUXJPNTQA@mail.gmail.com>
In-Reply-To: <CAEwRq=q8WT9jPouwu8RMNjgQYkDeRoFzBDhiLOTMgyUXJPNTQA@mail.gmail.com>
From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Sat, 14 Sep 2024 07:34:37 +0000
Message-ID: <CAEwRq=o86NuhHzbXcAhPXxvE1hK5zJXrphmmCfe=_PuepnPYGQ@mail.gmail.com>
Subject: Re: persistent environment
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hello again,

just after sending the last message I continued testing, and went have
a look at the various CONFIG options I used, especially their help text...

The problem was PEBKAC, I RTFM'ed myself with:

CONFIG_SYS_MMC_ENV_PART:

MMC hardware partition device number on the platform where the
environment is stored.  Note that this is not related to any software
defined partition table but instead if we are in the user area, which is
partition 0 or the first boot partition, which is 1 or some other defined
partition.

I had it set to "3" instead of "0".

I now works.

BTW, I though recent Rasmus series [1] was related, but it also works
without, so I dunno if I actually tested it or not.

Thanks for the hints

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=423625
-- 
Vincent Legoll
