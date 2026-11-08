Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093A606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xX/Euh2y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwhOV2HG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A0984062D;
	Sun,  8 Nov 2026 15:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VB_pPs7TubrW; Sun,  8 Nov 2026 15:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72F8F405DF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794153246;
	b=JmzQYcE/okWRcH1u69JnWIB7s95LlAY5XO3xbhKCBU5wsW/DwHhsrMBmY0QPJNJqAjwR
	 mbl+nlFFgF5UTFQT67TqwU3kVoaRpddlfHKplwXUWSLPOMHYTvgF+qztOMUif5Kefx+JO
	 t9UaNht98WnLhLkXgAYHbEqJ2VGyRTwMffZN4BxWGwWlNRLURwjTIpT352TwTzBaW4AHw
	 kkOUCO6WwkU80LGolvngBXcdhKdA8qm0ZEKbkPENxzcTyX+d1/BTyhcLkSnahJ1jSL/OU
	 bZJ/AtimhNrJMGJVJiXfqFlGXzyRqywxiHZU6hJSMaJPwGGK0eUxI3PWHlwMT+dc44g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IGauAnD6nKco5H+Qf6xIxfqebg0xnPeqj4FhpTjVHow=;
	b=YWrBwgSUELY9QlpN43bvbI1r9UiFKEnimDnv3G9BdebdDxrBnUoWN4RO2ckNAiefIQ8A
	 dH88sd6dq8n6k4CcETqRmubAIuFo24Z4G3jujFqbqoX1AkXYYQaM+lrYy0DsepoVswBa+
	 f1vKeafBpgMpg5uG/wd1xf1Uv3dCa+LuEEyZQS9MNAo68S3l6yHYUwxOTT+8uJq1ApEj1
	 efqX8XLSt1PcQ3sUXuCPbQwx9r/035bbH1tsmcN743UpAlWS8XUnAJCsg6ETI9dj1qlVY
	 367195tSeo6NnLMv4P2cBtGCo3izLOgKrUx+hpmGL51MSBvjNn1MaSVLMQX4kVBanlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794153246;
	bh=IGauAnD6nKco5H+Qf6xIxfqebg0xnPeqj4FhpTjVHow=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xX/Euh2yxVe6hWY2XEcwmHelMJA0MjMgq57F48KD932kEB4ESlDgcv2PLRPI/+3G4
	 vBBcj3u/Q4MJGCB02FfXRtYszv/3GKXYM1+4n6DQAVul7iXbOWa/fRe9FmL2kdEIrS
	 tszubLR7GBT9+fE6q7Xk3+bOHZXSmqqS2F0VVzAsiVO6ULM0SID/3R048EFBSKTzH4
	 0dRESY0L6DFiwtsw1E9NJHncPTbTkBAFtjTy4mja6utL0qsfH0hiDu3gnQRp7JBP6v
	 tE2Tapq8p2ky2650QrOTJDlD4Wp0pSq8RfI/C4wQYNeSReZY2HTjbFlZpHzSm7otUD
	 a54xcZQd8KJMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72F8F405DF;
	Sun,  8 Nov 2026 15:54:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BAAE111
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D6B880C97
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqC6zJY1oOET for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:54:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FA4E80C88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=KwhOV2HG
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FA4E80C88
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:54:02 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b33de9d2b1so543887b3.3
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794153241; x=1794758041;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IGauAnD6nKco5H+Qf6xIxfqebg0xnPeqj4FhpTjVHow=;
 b=KwhOV2HGXWQ/I/vHv9gOfQenLCmGMNyfFKkeHjMDY7ovGe5p77U87+lwhziA215/em
 0gbgLE7UqgN1vzzOqLgQnsyrg0W13bVkAcLh5k61sfuJdCE0j1shyx9glPeFVt4lPbR8
 9F6i9sqqPrRv3/tmR7GeZVCpO52+oqRrlKm1VLwK9bcK/01ZwOTQhv1tYlvQH0lqpHMA
 DJuwmsyQeqXUuM7nPpgfgcrBOgM7nAQRhCT7HmuFYmhABu/usRgZWxOBvKW06BWa59oX
 97dtw1i+Mcq0qHdinANipVdW6myJLUkarQLIuJYKAsnTCSwMOjBSXwL8/chMqTEqTcbN
 q4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794153241; x=1794758041;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IGauAnD6nKco5H+Qf6xIxfqebg0xnPeqj4FhpTjVHow=;
 b=WcyBzXTE/7ptJ4RsV89f5mTlFb2ToLwHHZZwmMkY/fT2gb/uh7stLsPE0Dtk+PdqMF
 eVXh7wD3V/69xkux/3s6E6P4NDK7yZW8x8pTqW6YyGpNydBTLI1vc4MXzZMvb03gamc4
 B9LWsFBcW3nS9SQYcLIZM9axWfc7/6ofju0YZfkjCSgZxXekB2arC8SrZBMFvX4L3Gvy
 lVOpth4MS7sUO1+EH4djpv6w8rnQh3KcRdQgtfoO3ALSuTF4JD/1GWZpXXMumwWix1au
 bR4e9/o0j/+UrdooNJA/QPA2T59o5LrdNVl0ekySlfEFvPVOPoSiG2WY5FuB8Z7EVUct
 b4gg==
X-Forwarded-Encrypted: i=1;
 AL+hErFDUDkjkFPoVl9B/OfDYRwQP6kkrkMLGqi0+HXYFANZnNuPvB93w/HfXNCczWXncA2VX4tX8WI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+oIx9KPVvfUwgMXYf5EKpjtGuTSB3tneNBL9EBeATNuMBSNkcl
 +0UJbLel1GtfedmltYTyc3JEboZbiCl/5MxOSbdJwCLcdq/g+llnm198MFOhpRTz20IkABEFv3Y
 QgknxpaK6y9jVsHcOoDopsYFldEcXO1Q=
X-Gm-Gg: AYBFou0MnnwYrhghR0vQuAEssix3Ou/Rc0+kxWEUyW1tAGNEA0ckSOUxl3qG4PjddOc
 VdPKsm7OiSHleX5nhuypW5Yi6Tvi0ey5CrEllJe7pnIHBgGUGpbJYzg2VG4M4G1cK452GXvTylW
 WZyCSTXwERRT5ah7l1jyDXS+4rI2ZGBx5QkdlHePtoMWpG4NT+OFNg7JvIvxTURc/LiWNv2UPYV
 e8PYYa2vH/SaTVS9yFr6gXnJSEJdn7yS6tzVOJSn682RQAd7zB5Sbgc8ESlAe8RcHeAMmThcPkV
 oLs1D7a/yx0h/6wz377Maci6YGELrnaDQYldNV0vff6AlX9QiYovjKRw/GQjd3sqptO9hK56sCz
 AuatmVIMdTpjd/6YxtROXdeynjNKVWOFJ9VW2/48kpHecDq+0zteq6fKhPVsr2tPg6vp/K2aD
X-Received: by 2002:a05:690c:f8a:b0:8b3:2a74:e0de with SMTP id
 00721157ae682-8b36c855155mr9893537b3.14.1794153240742; Sun, 08 Nov 2026
 07:54:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 8 Nov 2026 23:53:48 +0800
X-Gm-Features: AclHuK-_Ucn96G6Vw8LHzM7A9yF7LgvlJxM4HQuy4BPZV3WS8EcyOJKZOGGTLqs
Message-ID: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
Subject: Please pull u-boot-x86
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Changes for this release:
- Read correct TSC frequency using the right cpuid leaf
- A small cpudid implementation refactor
- Display actual CPU vendor and device id when booting from coreboot

---
The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:

  Merge tag 'u-boot-imx-main-20261107' of
https://git.u-boot-project.org/u-boot/custodians/u-boot-imx
(2026-11-07 12:04:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-x86

for you to fetch changes up to a7f22b345ab311488b7fbc242e408e97eca4e93c:

  x86: tsc: Read the base frequency from CPUID leaf 0x16 (2026-11-08
23:40:13 +0800)

----------------------------------------------------------------
Bin Meng (2):
      x86: cpu: Use native_cpuid() in cpuid_ext()
      x86: cpu: Implement cpuid() through cpuid_ext()

Desapogu Jayaramudu (1):
      x86: cpu: x86_64: Detect CPU vendor and device ID using cpuid

Dmitrii Merkurev (1):
      x86: tsc: Read the base frequency from CPUID leaf 0x16

 arch/x86/cpu/Makefile             |  1 +
 arch/x86/cpu/i386/cpu.c           | 51
++-------------------------------------------------
 arch/x86/cpu/vendor.c             | 52
++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/cpu/x86_64/cpu.c         | 24 +++++++++++++++++++++---
 arch/x86/include/asm/cpu.h        | 63
+++++++++++++++++++++++----------------------------------------
 arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++++++++
 drivers/timer/tsc_timer.c         |  2 +-
 7 files changed, 116 insertions(+), 93 deletions(-)
 create mode 100644 arch/x86/cpu/vendor.c

Regards,
Bin
