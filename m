Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD63C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084C2405F2;
	Tue, 25 Aug 2026 16:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZU4FePhxKjSC; Tue, 25 Aug 2026 16:03:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673821;
	bh=ggEW+WH3IuUR0vldkh5wKoAFHQ19jZMNvos87VMpagY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qzp37uUFy12MlEyNKaI6EDk+iTwCgps3oc2PL4+dzpkmMLIKtcBtkH0pW39UBpMgM
	 lnvsgJNkPzTfreTuzZxW3YUhlR9lP5SjsYTreQbzqXGRnP1ESwuy2KYoQLc8iHtG1S
	 hJcSOziu7Q9IgpPDrBNyo3WP4sFk5b1OnQNbOX0ctehridhavmQZ/zEq4SZGOHiXux
	 YXWFI8E76AXyjD28SMuryoP4ryH8fV3JfHM1vJln5UggjWoOOKQURou8/Xw5PZEy21
	 c9kvzb/qWAUE+5i30srLbpo6Bxzj1JqL7P6QZUHMMphiTIpKCVAozqtb4MqLnK0t8I
	 8IyJGYPtZruMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4683C405E2;
	Tue, 25 Aug 2026 16:03:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BC143DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D610606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZ-y59nHDaDK for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rZ6LQWa1
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AC7D60683
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:00 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so2136452f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667598; x=1788272398;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggEW+WH3IuUR0vldkh5wKoAFHQ19jZMNvos87VMpagY=;
 b=rZ6LQWa1URfz0tM5WQ/MZUw83g/hRmYesz5LUlJPfCvzx/B6Nlajshtnsstvihsx+i
 LufcfecmTQangpffGUQkRSIYNsU8ZaXjpBON+jKerIHOsfkwESm9r3DmKruCqOyoRABB
 FhmMdWPyabj6r8uBDhCy6QNToN4gi20vThnNdKPAhvKPD/6Ios9OOD22BvUeeoWgmP5s
 V0qzzMZgbiMceohKJRYSExmIMaV3NbYOgLvrpLeXUtmmMR9OPtyPwoYSe7BGaI3awJB4
 QqgYhxGBjWtWIuwPTgqSAxt7gqt7/v2l/lYxPhpmnINwW3vZbeNcVvyzpJFNLMoqj/Oh
 xL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667598; x=1788272398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ggEW+WH3IuUR0vldkh5wKoAFHQ19jZMNvos87VMpagY=;
 b=UGveX086eQKsN1JLCpe3NjIABOrF9ENdgcKcTHZ9smzSb7p4knS0frlV9lKwr3m66V
 pC28fT8Xx3pVRxhzogqmER3xPP/2faZItecD4TAEF07zB7RSrfdacNJUFwCtmpg8K6JK
 90iTLmjPzKgw6yMd7EzrEcaf9G07wwyx4/PuDuDbzhIdNk+EJSIpgn7UNd5YWp5W1FsN
 ePq56of0TdKRGhTAZDi5HVfHEcrUmwhDTChApgDvwqGn8F5bfUQJRVGUCayEju2V21kL
 cdCAdwdCVutq7yA/yww4opVw2JYuvlPZc2UaBwZ5Z9sivBZ2DYKS4FrQAnPAnStfiWRY
 WUrw==
X-Gm-Message-State: AFuF++k1jXn2GdqFHRQP4XpM0sPCZ6uFjd/ylRl/Kts88j/WHMb1Rl4c
 9plytu5KprsEMbGkemiFv9hi82z2V9pP46AkBa8RxWS0R+R11oWNb5XwbnagP5D++3M=
X-Gm-Gg: AR+sD12gtGSsW8GeUQ6R8xHY+JvZEAQqYLupPcO9MUiYxUjw1BRrNSxIsP0i3IfzheN
 Duu415qP6au08uZcMFM72gvjGP5RX/Q4tU75KtN6XgbObltvg0XGyfDoDCfuhOURE8uAnlIFCZj
 pA7xPiu38xLIYbECvBMQ//9OJL9OK/9n1s7/PHx586YJ6zkCnfuTUPsE3okWbaiQjaUuYudhXOt
 rIegdOb2iqsjJhjHCFpanFkBroLYaIw2jhS1BY224qsMN7MHTztR8HuHn/wYdcgwEUxIdDC3GMF
 7i8P8hxl9Hnwh/xbsUjsJaHfUHJsAOULIJo2tMsRjdhwSqQ/4/xKLMr2U0ijGBKFHjv3Ye0pWH6
 R+TgX1Wo+vESYT4SbpecFHYZux31TGQnZwXMUpPeSVVJVwUHe77kGRhw9FniXEth+7l8pGy4EEm
 iZKqxLbm+iOXvUAbg0n6J3GXy003OwUm9F6eSiQb7Udddib1NzqZXxQzuvynFVCzL2/TJTB7JJq
 0t9cyB/RNEi6LVRjn9OmeGBkKOWoo19wLBdEsMhiwTzHORObTMcGwBR52JvusC+B52r7ef2xJmy
 ASDCL/KwGwT0URYc+b7A91j+
X-Received: by 2002:a05:6000:2412:b0:47f:9ac6:ca60 with SMTP id
 ffacd0b85a97d-482c0b05a84mr45778655f8f.0.1787667597751; 
 Tue, 25 Aug 2026 07:19:57 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69d7dsm11745871f8f.4.2026.08.25.07.19.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Aug 2026 07:19:57 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, philippe.reynes@softathome.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 0/5] fit: cipher: bounds checks on the ciphered image path
Date: Tue, 25 Aug 2026 15:19:48 +0100
Message-ID: <20260825141953.9534-1-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815220754.11724-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 16:03:37 +0000
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

Changes in v2:
- Kept patches 1-3 as separate changes per Simon's request (distinct
  Fixes: targets, easier to back-port independently).
- Patch 2: documented the new -EINVAL return in the kernel-doc block,
  per Simon's review comment.
- Added patch 5: a fit_cipher sandbox test suite covering all three
  defects (non-block-aligned 'data', a truncated
  'data-size-unciphered', and an oversized unciphered size), per
  Simon's request for regression tests since these are security fixes.
- Added patch 4 as a prerequisite for patch 5: <u-boot/aes.h> defines
  the disabled-config cipher stubs with external linkage, so a second
  translation unit including it (the new test file) failed to link
  until those stubs were made static inline. Found while writing the
  test, not previously reported.

Patches 1 and 3 are unchanged from v1 and carry Simon's Reviewed-by.

checkpatch-clean, builds for sandbox (CONFIG_FIT_CIPHER=y) with no new
warnings at W=1, and the new fit_cipher suite plus the existing
lib_test_aes and fit_verity suites pass under `ut`.

Pranav Rajendran (5):
  lib: aes: reject a ciphertext length that is not a whole number of
    blocks
  image-fit: check the length of the data-size-unciphered property
  lib: aes: reject an unciphered size larger than the ciphertext
  include: u-boot: aes: make disabled cipher stubs static inline
  test: boot: add regression tests for the FIT cipher bounds checks

 boot/image-fit.c       |   7 ++-
 include/u-boot/aes.h   |  17 ++++---
 lib/aes/aes-decrypt.c  |  21 +++++++-
 test/boot/Makefile     |   1 +
 test/boot/fit_cipher.c | 113 +++++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c          |   2 +
 6 files changed, 151 insertions(+), 10 deletions(-)
 create mode 100644 test/boot/fit_cipher.c

-- 
2.50.1 (Apple Git-155)

