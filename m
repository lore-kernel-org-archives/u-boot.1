Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D90E784B7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0CF87167;
	Mon,  2 Oct 2023 16:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NT6f+P1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5878087173; Mon,  2 Oct 2023 16:52:37 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F4586E03
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=euforiamracademia@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50573e85ee0so3005808e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696258354; x=1696863154; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9Ki3vftgljpXouoVOoSaYEb3MiWmM4xn8ZRH9/Sq9QY=;
 b=NT6f+P1II/LX0b1UHLOzZuAvA+l1sv+JmAMh7zDYoRc1ENYpzGaZPHCrE2n7Zk9O+6
 /okPqBJgTvu8VV9Q1/zE4CNX4r6w8c2gFdLusT1kyl0aSqMJTVp2j97Pda8jgugu9BvK
 huaXv/K7e7zXoKq9ADydYUCsSqEnUvI7ioqS4l9SNDiY8DrKZ+zmWOxf4rY8k60PmVKw
 9oBFcNJqxr4+JwQDaEplJAGbXG7rhua70BOkfvUi29NyfOuvp7XdR1aD36OBepQy/0p4
 LguO83k75UQHoMOS0YToLPjO5AbVmtdoM5IozWLpXxInz1AUKN7LfB76CrowZVoaKQaC
 DQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258354; x=1696863154;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Ki3vftgljpXouoVOoSaYEb3MiWmM4xn8ZRH9/Sq9QY=;
 b=nnhungGTlpl7z0d/n2AJlEp3smjSpqNttPySBIORTrMW/Bw6KxxhQV4HfkZkgBQVnf
 5GAf2DlGQagKLRZq/Be3IrW7OmmqWwQoAe69tQQ+GMZMBNMxeGF2KKQFZFTgxZMGT/HL
 ud+KNYFk7FRg0dNQZnjsnCfCL491wO7Ojce3hAkEb5Z9No3vZ20VhyevIhaV+Atbtz5X
 nXOwx1rp++SjgsP/74k5VKm856E8L5O6QoYeJIQknn21oI+5HnGHtJvhrlnJjbcNkerB
 4d8ZSbrj3qwGOu0ZHmUGlCE77UbPJ3angLYUvN3YDoBFxHhBiuzCUkNvyQv8/TcpvNAa
 5crw==
X-Gm-Message-State: AOJu0Yy2q+5yhaAtXpaFYPglDCLQ+Iljt+KHZ0diu0fAp4GZqdtT57Ng
 EVzsA9L0QzH5J6TeErJs05Vewd3EpDoUlSijgGwav9+B
X-Google-Smtp-Source: AGHT+IEwSogDrWNjDrvsJ9sJzUca+50l8DqwvFkHm8Aj4tT/QxmS1CSZbegmEwBWJeqov0/9RDlA+J1MHguNy2/0mm8=
X-Received: by 2002:a05:6512:3e14:b0:500:c128:66d4 with SMTP id
 i20-20020a0565123e1400b00500c12866d4mr11218673lfv.67.1696258354510; Mon, 02
 Oct 2023 07:52:34 -0700 (PDT)
MIME-Version: 1.0
From: Mr Academia Euforia <euforiamracademia@gmail.com>
Date: Mon, 2 Oct 2023 16:52:23 +0200
Message-ID: <CAK1jQBOFtGmmfTqaBQhCo0SBac16Cpj5qb+bJoNYti_aFgwV1w@mail.gmail.com>
Subject: Help with certain u-boot one-time job
To: u-boot@lists.denx.de
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

Hi there,

I am working on certain project, part of which is small Uboot piece. I'm
currently lacking man power, and I am looking for help with certain
Uboot-related patching job. Of course paid help.
If there's anyone interested, please email me, and I'll explain.

Best regards,
