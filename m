Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F47C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 08:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED2C8830D;
	Wed,  8 May 2024 10:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMbfV2fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD03388322; Wed,  8 May 2024 10:57:16 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A73FD88306
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 10:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ec41d82b8bso38145215ad.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715158633; x=1715763433; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vwd/t84s4QygNANU/VJnE11Ydm7t4JFwxtMjzLPhqyU=;
 b=fMbfV2fpxSNcphf1P7cB8mHZc7DRLH2vGr8ZQW4AICBQaUeIE4lom8+KUX1gqpsTwl
 g397BaFKk7p4JCui1MoYkaTdzAMURJDSw1FXOl1NtCq1DqRRy/xlYamgM7P7+SJz1z39
 zq7nMTxnGxh6tMyYOoHDgKQzoi/t0LDIxjY5/8goUoKcgLVsCYIpvvXzkOBO7MYwuAxI
 73uaj4PI6ApOLwRJQqVaWdwQ5Rx5fQG9VBh1A4GRb+mUIED4CbyomZkMkFvVkKj4975o
 5+rLMOPcJCBsA5I+kYi8vJ4WTH3mQODJy2BtYqpLRqbFUnUhLwPSx3U90uSMGnQRj7AF
 S26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715158633; x=1715763433;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vwd/t84s4QygNANU/VJnE11Ydm7t4JFwxtMjzLPhqyU=;
 b=F5n3QjQ459b6oVwPjkpEmQxqYdsjilpqYs97B8DyLlw+ryW5t17yvqx0+uS+lyRKDV
 dOxGWqHbENFyKqmGnQZaffqnfZkbEwiNwiigzdeU9C1LiwpiYJ4RaB8XE3LTLEBKaep2
 3e73DEtR7YWZm7rfaJLQVUkP4vyRxMtTtlcqPzFy1MHf2YD0DIQ04pJGNz2zlA51Xywi
 Dg3eUusyK1l4OZGVzIJLFqKjzH+KQaBu7D5A8tRWAFBkZaQAZ6/iVc0dM84i3ZliftRj
 g+0gpr/jKeCxxk62BGorHzWr0+uRqv8OmF/VufMwy/++Emi7P6RB4lV9aMPFMURWp+j7
 rtNw==
X-Gm-Message-State: AOJu0YxJJ1ZiSq/5db4GTPYCoCWp3DoeRB9Nclh+vEG4exQv+b8VhwE3
 7WZiVLtMSAOqPC4PvjutjwKQMA3JbfGZW9vRdryLgN9Nev1AOVrlpE/x8vEl5OQw2wFdqrwi9b8
 JheIpFVDJg4mZWo9thFsUzzyaj+h8qA==
X-Google-Smtp-Source: AGHT+IGrkM8PT1XqoBmVsCvrfVu/Z2iyW4JMXwSZLIsp18cbG3Q5Ir36PzUU21N10hw38SMjK9Lcb2NgTBwPnPnM/EQ=
X-Received: by 2002:a17:903:2451:b0:1eb:d914:64e4 with SMTP id
 d9443c01a7336-1eeb03a3a90mr24211505ad.32.1715158632772; Wed, 08 May 2024
 01:57:12 -0700 (PDT)
MIME-Version: 1.0
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Wed, 8 May 2024 10:57:02 +0200
Message-ID: <CAHseuWCExW0TpJE+wcASX5Q5gcYzisD+JfCazTjzx5n4m-jCEQ@mail.gmail.com>
Subject: Does u-boot support USB CCID communication?
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

Hello,

I wanted to know if u-boot can communicate with CCID compliant smartcards
or not (with a USB-HSM device). I couldn't find any documents related to
this online. USB support seems to be limited within u-boot.

Can anyone please let me know if they have experimented with this?

Thanks in advance
