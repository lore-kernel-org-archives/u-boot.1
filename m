Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19ED606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SKzGiBZD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKQmlXrl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8942A406ED;
	Thu, 29 Oct 2026 06:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4DUYj_N_r5R; Thu, 29 Oct 2026 06:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93A5B406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793254012;
	b=WiuVPCq15tQA7mOniixeB5pD5UkAyEI5PLsBoRvAyBzgkg7gAptoUfvhEmuDKQR/YstF
	 2Rz7hXX/gSzWObMO1I9BMMg87/C3nbtVVgNgD1u9xvS+QaRTMrMNrYbTa41fAV+xva3E6
	 cfCid59bCwcMuljpXaLigoYband0y2XNuF1HxM0AsCAXqTjiFAmC4Sm/nVjHmPEqDPeAM
	 19eZzUsZ/VDGSbarLNCBY8RcZnavS9vnGA+EJtsm9r4MGXvJBzC14qJpq4dISIQGZcuG2
	 HijFsI+S0wYfSZuT+FNfxeNGOqBClvy+0TlFUWMgD5J+RUGuGBQn0rQsjbLQpcFznoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793254012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=66UcaY8U/9JdN/hFv4nLq7WgihWItCZjG0zGc384Xgg=;
	b=OTB2/w3JhAR0OnNtvIVKXg4vkTHe9ycGhHAa08wxKX4FTJ4qnXzibQBY+aP6LjYZt3pM
	 9zeqqBq7eEQVLXAdMuhsNxp2ewOe8vErGs0Hyq4g45OMauo0ySly9XybiCQ5JSbnFeXmG
	 A86q/rziAhnt24JzNdHRH2a00bfCzfGMcvfcmZrxZziYdYDWSiz3zapSkLvw0mlKO/n8Q
	 xw2kPWy0w0f6LdQolXf3tz0Jo1LzUDOHBjuM/2aZMKVmuQs/eJvVagHg8OG/sE9TqYsS3
	 G5fxycEyoPeEN9hjV5ixbIxzvL+DAUrzdgx/4epfBL3fnSGhf6ykDtjciE/+p00xOhQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793254012;
	bh=66UcaY8U/9JdN/hFv4nLq7WgihWItCZjG0zGc384Xgg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SKzGiBZDsD5HgaLpmiZ9yQPZLhmUEHPHAPSRr5vgFXgu7rdMc44A55ZtghctURz38
	 cobN18TTRMOJyOqpbaa+0CKVTrh66lMldCCbBcVFqMosHEl4nR4h/Rzd2ipToOQqN4
	 oUBuO1wih0NJgpWNf5AmwEGDzvcxXzidqQ4XncH9wHmbZt2v+cccXY5ROhpqoA+hR8
	 lJSRZ74q0/oKDQeM0U/ijW2JsCUHgMTNmtxwLQEt6fgFyr6zWqJKWM9Uj4shjFKWF/
	 1VfIVKXsmMs0T5vzttnovhdZX2gsMgFkuZJRyxD6d8in8nrZMS6wUnvtjKqwjYcJ86
	 AvGMUIQf0ve9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93A5B406C5;
	Thu, 29 Oct 2026 06:06:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E340472
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F6A680E2A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r8bgLY7fTsIi for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 121F480DAB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793254009;
 b=hgbmqs3jvp6Grt//BEgJYFDWYAZWlqa6uPD4hDDeTcAyA7UbzsjGeNiVc8vMNwtaIOcY
 +IZ8MCTjoffm/PdiEPVkokTrtWRlpHqJXDEuCcU+b1TKt2FzeKI+r7NSd2psMr7/z3nUh
 t7iI6ooqQtYNrlej1FIVqEp5TwDiy1O/+KAE3+m9ALxJe5ZyYyDgLWWsyOs2Fo6Nl4t+U
 A2PodejkNA460pEMez4q9dbhOfG0XQTk9O2rsP9sAEuFG/QkoA9Fq/dIDBE/HH9+z/x8R
 vurnxHo9PHTGVADngvJ462h3D5lFMZi3DT07kp8pMEexA+JAh5AA3w5ut4nnYIEAY6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793254009;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID;
 bh=66UcaY8U/9JdN/hFv4nLq7WgihWItCZjG0zGc384Xgg=;
 b=aacXvsQ7zGg6kmak5A4tXb4kbNZFpB3ji1df0E4nb6en6S09PVF+Urdmt7+KWkEM0pOU
 PuE2ckY2jmn7MeObVtWlndWa9CDQQhEiArZJXEDe4jewf/e2ImoYgkT62e8aPO6uZ1YRu
 xXGzTn+rhyKv6xE+hKHlyWTgmpr5uVZmVD1WTiBabyJW84/IhEbNWLxXlwM5hXOZiKc6Z
 JPz0LSwlLhnBztcwLfyoU2kY0+5KXHOK3BESNdOmbG7q8GsfeVaEkqfYLgge1hj3rhw4r
 RuzTCY6APnBb8btQyFJ3FSrrMorai9RxQ+qhGY8Bts2qS0Ajhnn81OWm0vfOXmXt+Ow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bKQmlXrl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bKQmlXrl
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 121F480DAB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:06:46 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso911207f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793254005; x=1793858805;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=66UcaY8U/9JdN/hFv4nLq7WgihWItCZjG0zGc384Xgg=;
 b=bKQmlXrlY2pQoIAWH0W4BgEQU2c21OsxQ90mexTDxxJVqpKrflCKZm+3ZXt6mc1vw3
 bTblReoQMh2PMZ5wrvF64DaSv/15mSDO66dc3pqpT+uprRRzSLy1YdcA2Bqguc7HAvxF
 8teTon5Ba2c0n5GaFUIT+S+RjRPboe3uDbohTjpqerdPIWcmNtKJvDCbfFNc+ldW/2hT
 twauCv5pxIq4eCduVkR6KrIk+vLgYBcp7JCdyyQFhV3N5XPemrsXbz7C00NCguH5IxWf
 yT8K+9SzkDjMmsmIbnodhBJ2MXwjEj5X9mrnu0+PCV0iaf5EM4M1MTX8OzNKS0HDocfu
 fz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793254005; x=1793858805;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=66UcaY8U/9JdN/hFv4nLq7WgihWItCZjG0zGc384Xgg=;
 b=ltIcOkBmBNUDrTZQJEKxhiDJtbHi/nSK3iHKngh2Ss8etR094tqlc5En0q3ymhrlB8
 yl3NY6vusYqErTDcy0ST8+GsHVQTh0qM60dnF6TXMUYV/TdNezN3mDmXCTOPPbgCy05k
 1V3iAkbfDo3JlI6xLDJwo5nSfAzCDX4oL9QUoE33zlZ4Hs6B9chB9l+LnZ5AddWUIN8l
 0HMzxQXntMmBqCiTxOMW5tivkTudXvZvYnm7PY2hi7E+yOgjBkJrTcDoN2JF3lkcs/mm
 YcV92viSaTxwFhnXICGkMk/pHRB5olpj55v28I7de4tpWddUXXOSgBwKHoRsAHhHrGkY
 KF9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxw439W+ANnAoTCFOw/XsyBq0Fp8gvBMb3yN1cdVGXSBCwdHL+9gxQERw1NYPYo0mdCGoAhEjI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLaXD9QwI1ufDaOwchNO9ySlNb1yzprcB3dYuAVdrL9DSr+mgky
 U25/kasz0ZIOwDucg+P+Y4T7LLqVNQFPkNkKkY9UgE7KU5qMCLfklzO2
X-Gm-Gg: AYBFou3qjoYTV015mqyKs3IwOJqIBvQqps3WCAGJi/71+6yqhtl09vDX8b/xVxxR9j3
 q5iQMVJgjgF2pFqA+V6jvlzzOH6UguCWpygjODZtUHqf9iru79wAy3UMeVlxXmWYLZip2cpnrzX
 cgFQgOdlhMKgQvqxIda2MIuQ9q5sm939Y7DfIhu0nXYtZUwFAm+ZCT7BRxK/vsk6ldbAPhv5QUJ
 koiV4wdltz4oAtQ5YWGrQLCZsqOeXMYDINYNsvy9QpBxv4KpfRW1b20/bSezB2vmeLROtIuGnw5
 bTpPBF/16RVvic0Q2ID0rPLekg4U4nDuOhj2568IBoOESulzQcXnNVTifb4tEQ+y7l9FkdCqqhQ
 ORuurA5wfkr7Qo7ssxMQQuIO+BBRYYGNN+M1/5vkvfY2aXtVlRgV0StiJj5tAfJK2OVJYFuRw/9
 QCOATXJKOCqHbNM/a/CiInmze+qL7uH8shqCOXbY1UY8/qXK6tWlVKwuAz+H5eZZSwwaV5FgTZ2
 agoclA8IhHSN18ugHIIZrDVnPhMai5qMNYVxyjuwCgndBCAbjRxpbaNlJY/wX+WZBm83gIytRuy
 Ob1potcDqHZpGPx3yhnWuJF59ZpDCxA=
X-Received: by 2002:a05:6000:438a:b0:48e:5d63:a4e5 with SMTP id
 ffacd0b85a97d-48e5d63a673mr9166882f8f.0.1793254004446; 
 Wed, 28 Oct 2026 23:06:44 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm32582230f8f.25.2026.10.28.23.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:06:44 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Subject: [PATCH RESEND 0/4] usb: eth: Check rx header lengths in r8152,
 asix88179 and lan7x
Date: Thu, 29 Oct 2026 06:06:42 +0000
Message-ID: <f9afa215-645f-400f-8743-eaeca3f6a2f5@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

This is a resend of the series posted on 23 October, now with the
patches inline: the first posting carried them as attachments, which b4
and Patchwork cannot use. The patches are unchanged and still apply to
main.

Tom asked on another of my threads for CI results with each series:
this one ran unchanged in U-Boot's Azure CI through a CI-only pull
request, together with three of my other series (ext4, EFI capsule and
block/disk), and all 91 jobs passed:
https://github.com/u-boot/u-boot/pull/1064
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13698

Three of the USB Ethernet host drivers take the lengths in the headers
the adapter sends with each received frame without checking them against
the transfer that carried them:

- r8152 reads the rx descriptor before checking that one is there, and
  its bound on the packet length wraps when fewer than 28 bytes are left.
- asix88179 bounds neither the number of packet headers nor the packet
  lengths, as Linux ax88179_rx_fixup() has done since 2022.
- lan7x checks the frame length against what follows the first 4 bytes
  of its 10-byte header, and lan7x_free_pkt() steps over only 4 bytes.
  On LAN75xx the length also counts 2 bytes of padding, so every frame
  was handed up 2 bytes too long.

An adapter that sends a short or inconsistent transfer then gets the
driver to hand the network stack a packet that runs past the received
data, and for r8152 past the receive buffer.

Patches 1-3 add the checks, one driver each, following what the Linux
drivers check. Patch 4 adds DM tests that bind each driver without a USB
device behind it and feed its recv() and free_pkt() prepared transfers,
and enables the drivers in sandbox_defconfig so they are built and run
there. Without patches 1-3, seven of the eleven tests fail: the short
and oversized transfers, the lan7x step to the next frame and the
LAN75xx length. The well-formed cases pass on both, as does the r8152
descriptor length below the CRC size, which the old code rejected
through its u16 wrap and which guards the change to int. With the
series all eleven pass, and the rest of "ut dm" under test/py gives the
same results with and without it.

I tested this in sandbox only; I have none of these adapters.

Jonas, your series "usb: eth: asix88179: Use a fixed URB buffer size and
misc cleanup" from January bounds the packet header count in its
ax88179_eth_recv() rewrite as well ([5/6]). Patch 2 here keeps to the
checks alone, so either should rebase easily on top of the other.

Ana Bobillo (4):
  usb: eth: r8152: Check the rx descriptor fits in the transfer
  usb: eth: asix88179: Bound the rx packet headers and packets
  usb: eth: lan7x: Account for the whole rx command header
  test: dm: Add tests for the USB Ethernet rx header checks

 configs/sandbox_defconfig   |   5 +
 drivers/usb/eth/asix88179.c |  13 +-
 drivers/usb/eth/lan7x.c     |  31 +--
 drivers/usb/eth/lan7x.h     |   4 +
 drivers/usb/eth/r8152.c     |  13 +-
 test/dm/Makefile            |   1 +
 test/dm/usb_eth.c           | 375 ++++++++++++++++++++++++++++++++++++
 7 files changed, 426 insertions(+), 16 deletions(-)
 create mode 100644 test/dm/usb_eth.c


base-commit: acc808479730e13e74199119eb9b2b9113999244
