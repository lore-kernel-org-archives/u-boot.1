Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F54C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DC6440DF9;
	Tue, 22 Sep 2026 14:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7qvuxQkdYfS; Tue, 22 Sep 2026 14:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 80FFC40CDA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089130;
	b=PvZ/JnabrKXuyEFzQ5TznskxX2qrN1EkUPXYpBNePjTO1T77AJA/gB1edzx584hMQ8Uh
	 VckEvGwPHAo28s10ogj+Gm234gJrIkxdWkczHim5+As1/0qecIpVKyB7XmOXNzHj06SKs
	 VO3K6W1DzLwj/2ZyvwnAT/BsADWNWgnukWGuE3u/CZKmJSzOWcL8Slx+4d9almSItumgf
	 bk/9hfm6OsiTVMCR32+Ab4hiW/d2FQt5SVdMbzL+w4bG/iXNfZvf4iaLdSENsTn5YCiLG
	 CZ7tBabDa/MCn9PK4B5mapbcnwFuCWLeDUC8yfLYRertoJ1e50C+3pYz6s0Kgo0FtAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790089130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sUz32SvyFEz4r8esr1n/tFgHLf/An0qzwZ6Ll6tLeRs=;
	b=U2q4Un8ctOLopV2MBff5/nnaopOfcd0v5dUZlLNHXpN/DBijKaNev0F9UeUQh1mUKTBn
	 YxwzTeQPnWBymMWPalJoPdMTWdygKM1yki2uVVmdwDBtz4skoN5pXekg3SdRCjFHnwRLy
	 pduG5aBiolYDMX7430T/2MQGzJFcLk9qgGZ/hCftWvUpbkSxaLNTI6C0qQ0byL7QBTrhq
	 DsPc57bXOfNQ9JKpb2g4XdyZy3eoooevSao6oqgfF9fs2TOxCT9DYrZVBIwXNcFjVSULm
	 HodDQZVXmrk7iI2O4p9tCcktb8mMsIeoRdJV36cFqRzgr7lUcAdK/IZfN09h0vmA7Nw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790089130;
	bh=sUz32SvyFEz4r8esr1n/tFgHLf/An0qzwZ6Ll6tLeRs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CREIrA03Zb40jUSVgmpbQ7TvfilyvQzJTfYmyuBlrOXvimU+JneZwjNWcMvhlDKys
	 MuKkzqxCDS6zFhBEDpReXH9jernDotHyCBd49vpxxz9svNaM0rubbDWHV0BURv4enj
	 Qsv2b2MaSLw21L5PhC0iBTBMkq1mZ+DDNNBPSLe7Tf5qNHJtzkCqckCKG1VpxaoK5I
	 Sd/dIRBE3zHwqLUYj/f8tXqCV3po4viRwOQAnFRcm+uFHaxRBuIwCzvme4e+2NBI3m
	 BzBLsob64mrsJ+Hetfxwn3rm7Dzd6x4brPAz86zZr0FoPQ3zw9effP8AenyjO3O6mo
	 DgGCN56K6cuaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80FFC40CDA;
	Tue, 22 Sep 2026 14:58:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E6E43A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E97F6402C3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfMacN1EuseX for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 35FE64002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790089126;
 b=oyYZmnaLyhB0KFDsCOk0e+VsImjf+P0gaP778oL6gsCoW1z4CHGLn4QY479zZQP/ndDU
 R+O89xnU3d3JZWJAnBOyZFjV4kBjybxyjL931ZMMD4numfKkEGaaxdxrpsVxMB1cs17U+
 Dh/7FpoVr+UHm9c2ABhSbPxCE8AAa2+k7eRziUo2svJmUixvPow/BrpTZEj3VRB9cpeIn
 KrKNsmn7A/nKRNyabgdtFvIphMAjyj9Al3fsHK71gKYUWtyXX+RL848GrahWk9NYSHpyG
 ZWgY04U1DZw8yL7u1/rlsq1PJ1YldFqcmqFyyXHLhybuWLLlQKeJUlhfI44cfy3l9Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089126;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=sUz32SvyFEz4r8esr1n/tFgHLf/An0qzwZ6Ll6tLeRs=;
 b=i0Hfuq6OatFOfhC3719RUXxiMSKrfZxOhnSEusq+O7YYTQWIQqDLkpMTz0C3ubtA2+aY
 zpUnRl2MZ+CRSkBcukMY0I4fLGyYtqM9kCcMzGm4JMWxJbRzjZhdIjF62JBbkTlrI+fOp
 0mJy7dMp3R+YShfh8pfu/YtizgK+x+BNC/GmRt5YTfW97BPHKLxCScvaZQCA14+vK6cpA
 2NkNaKC5+xh5+Qq7kFdNUojDMihG6Ik2YD7YOCnDOUdvhG0MV+FfVp5ElXRIw8M+zDphE
 dI/X+2nM6OPZaV77s/EI8hbh94iHzvpjlAhLCUuq3AmnN/CB5RHxV7Sp2+ZsrTQZQIg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=YvMKJZCV; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=YvMKJZCV
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35FE64002B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:58:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B4A1576;
 Tue, 22 Sep 2026 07:58:39 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 080713F632;
 Tue, 22 Sep 2026 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790089123; bh=tUkiajcxlGnLMhrUW2WOBpd+UIMuJXp3Vo8v6la0aIY=;
 h=From:Subject:Date:To:Cc:From;
 b=YvMKJZCV0hP52S9vAIiGM4v+tFF5wHnsVcszDrxdPZ8pw5zRioZm9NvlAM5ueS5Wg
 sTXUrz8gerCfjirWgayiilBHKxxYgtarvTk7vxdPRsPHW8muvgRbhCDmqUKp4Ed8Ht
 ozTWFnbJYvOfpCJLamfSazhf4zcYBShDcB7H/Bmg=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/2] efi: fix and test FMP image info authentication attribute
Date: Tue, 22 Sep 2026 16:58:39 +0200
Message-Id: <20260922-authi-v1-0-e943530349bb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDWpkZC6iljUGDoWSItIGndXL
 L/kfy9CYC8coMkieD4lyLokFHkG5OwysZIhGVBjpQ2issfuRJVoiCprrK4JUrt5HuX6ftrudzj
 6mWl/x3DfD3oujFBpAAAA
X-Change-ID: 20260922-authi-329cc6a9a07c
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=vincent.stehle@arm.com; 
 h=from:subject:message-id;
 bh=tUkiajcxlGnLMhrUW2WOBpd+UIMuJXp3Vo8v6la0aIY=; 
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqspehI+FSjBuGXLk1qBNYV7enfOPyvivfj7jmL
 zWNtjjp/PeJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarKXoQAKCRDLSfhWdqMG
 lI/1CACVq2FPVsWbuhkVxI0HxnXIwc2YW0sUBZxFIvXnlG23CslLhvfdl+uSGeo1Quu6vDauy6b
 MMqTNJ/kIisZEuF0qBRDzcgoUbW7ra0wKlpbndRE8/qh4sprErGhF3yQ3+rbgXoioc5YkGjA7OS
 hWvtTFdS+kEvUj15jDUcl02bSpkBlCQkrZ0HIAjl553DTaheMph1oF4Hl98GTpbU2fKr1GlpKBJ
 hLFagKwDI6SpI8XK61Wo5t7GjMpf8+2Wps3UzrlZNej4PfB/mBUqXYooLHllImMSnOTnJRrlvxh
 HtOO+QQnC7fAJDdfDkNYPXgZYYrGL0gnSLuaYDl/2m9JUZz4
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Here is a couple of patches to:

- Do a small fix in the UEFI Firmware Management Protocol:
  GetImageInfo() returns a correct authentication flag for the first
  image, but not for the subsequent ones.

- Add a minimal FMP selftest, just enough to catch this issue, and which
  should be easy enough to extend in the future.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Vincent Stehlé (2):
      efi_loader: fix image info authentication attribute
      efi_selftest: add minimal fmp test

 lib/efi_loader/efi_firmware.c       |   2 +-
 lib/efi_selftest/Makefile           |   2 +
 lib/efi_selftest/efi_selftest_fmp.c | 135 ++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260922-authi-329cc6a9a07c

Best regards,
--  
Vincent.

