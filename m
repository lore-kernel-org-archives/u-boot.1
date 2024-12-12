Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8488E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61186801B6;
	Thu, 12 Dec 2024 14:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SQLeI2oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1A9801BD; Thu, 12 Dec 2024 14:59:14 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C618018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so521427a91.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734011950; x=1734616750; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v5SAWn5Q2Rire0EQWZuHA+5+sd2hiJrom3EHzX8ymdE=;
 b=SQLeI2oaMftNoaLRa7uXdOA35yhEmLlb9jm8X0ofqyRj+b7f1NRAEyGSjZTtYjf/pk
 febV4kqeGNCEK/a7gy21B2IMPVNRd/MmVPUoYLGbK7/WXoen2XBkq+jufHq8f+7BaVW1
 4t40wOtsMlntaaLn8D4y2w+9d4veLod8uDPbihwrvMZUzgqJM8jbPLCBd41ZekuDQdks
 F0TFfW7zXdE+WNCqdW4noiYMkKPgwsjXipumi1Ccdr52AaLO6i01LhYf1A2KDVu4Bn7a
 NkiK1sJ6xs45HBDqv0muEdjHFezqNJ0A2U2dbgr0JPf20niIpdfOgTcuGuOVP4ZsBkli
 CGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734011950; x=1734616750;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v5SAWn5Q2Rire0EQWZuHA+5+sd2hiJrom3EHzX8ymdE=;
 b=UGQod1vgk4NoEafzk1R5LmjMuNAxlez64UOzEj0xY6TCDgoVR1xYSLEW6PvSJbNWzF
 H/XdLzGWfrvwoo0w8Uom0rwfSAQCaMZiaAOgvnVu8+wyC8YQQTcdOZiJSgJuSc+wEh8n
 kLjP87fnwjyWAebgSfUZrcfduynmFb7sHBMfBKoM5Q+PEifQ3LOQxcGRgq6COZM/5PXu
 OIRZcvLIan8+tWMlr5NA9k4qZ/Ww6hsCjZ1jqu3fJVq4wnIqT+3qTSAGcOY8g9sS4l6r
 gf82WkNWBufBzLJE+wD+oDDJfaVIbinovfuC9rf/Q5eADkyWr1rC7Q+0xHUbP2yZGKl5
 aeLQ==
X-Gm-Message-State: AOJu0Yz9gfCsYWNg8KaaxVEy0nRxT4batIG88dwMZ9eC25/D0Ei5Usc9
 ojDYg4ot5Edi9KLK7HpavdTfXMHI6VPy0rPPW0rs3HOuWcKxypyZ0+fC+WNqhhzhoe7pbaHveN7
 w1DqqG8H5Gyrr+kMrFKxSySBPW95j4mKC
X-Gm-Gg: ASbGncvtHZllQqledz7baXdRw5vh5nUr+MUCaOBOvTMkeSlRmXNnVY8QPobi5COTP2F
 2jshiZ92VYJrVqhYE466BtFuqzgVL9xuX8eu+
X-Google-Smtp-Source: AGHT+IFttGYuYRktaihAHyLLEOV907QmGocF44xpnW9PJ2H4UM/neaRJoFItlr49XPaS1SY1E4V8ottsRnanD42rS8g=
X-Received: by 2002:a17:90b:4b01:b0:2ee:863e:9fff with SMTP id
 98e67ed59e1d1-2f127fa5c8emr11522753a91.10.1734011949670; Thu, 12 Dec 2024
 05:59:09 -0800 (PST)
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Thu, 12 Dec 2024 14:58:58 +0100
Message-ID: <CA+DkFDaAR22_yD8cHOYMY1-gjdYBh2ZPfg77B_oDH2f8cUyUaQ@mail.gmail.com>
Subject: Using EFI variables in boot scr
To: u-boot@lists.denx.de
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

Hi,
Suppose I would like to utilize the possibility of combining the
OPTEE, EKD2 StandaloneMM, and U-BOOT efivars and RPMB drivers to store
my env variables securely in RPMB of eMMC device. However I would
still like to be able to use the boot script to call the bootm command
to boot my non-uefi kernel image stored in fitImage. One of the efi
variables could e.g. act as a rootfs selection (would be used as a
value for root= passed as a kernel cmdline in A/B scenario) or could
e.g indicate which configuration from fit image should be used. In
other words - I would like to use the efi variables and the fact that
they are stored on RPMB but not use the rest of UEFI implementation in
u-boot.
The problem is that, apparently there is no easy way to get the value
of efi variable from boot script other than printing it and somehow
parsing (I'm not sure if this is even possible without some nasty
workarounds).
Does it even make sense? If not, then I would be grateful for even a
short explanation why, and perhaps showing an alternative way.

Best regards
Patryk
