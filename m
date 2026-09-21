Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D67DC982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7FDF6072D;
	Mon, 21 Sep 2026 13:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-l_nw_-badA; Mon, 21 Sep 2026 13:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12B3F606F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789996355;
	b=bK2QPYgXo0cqU36F7L64fMSMDM+8ziIoAKah/Kqz2Uw86lrkk22SqZqjvaBGp2bS7cf2
	 AmxccvTAPfsnISCMH2fdCnX2ttbp/y2/UvYW6en3IoO18/MT5SO55AlV45okeLg9OLhQB
	 Gvf8Iib2cLQqX9mBcivZA2IDHpTmZRKEXfy8ouMgkMgxLnLFUTgLAacy4hQMH01AtXyQM
	 0+CBEWwvVPSI+UbrUpGrjai0ZTwvyjXiCe6jpwOvmUfDXij88f3ih4hLbu+aT64+JrR1M
	 XXI0oQdg1G8Q91qGn6wOiyT4ZBHRUTPAaTb1Nmpmy7YovoPB4oUGY7Xd1QKeyYVhp2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789996355;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ttdKBByQEhu0xoxUZJTeYvLJ89b7BlhA+twH5hhi034=;
	b=Gs1V3uDIS4pE2fXHSAMOy/Js1GmZMG0dneIpXHA02aY+yVT/ASWEl1kCkZ37KS0pgDOc
	 L0FdmSbM8CSUzcE13mPHessixdch1MBz7+9KvZVASK9LkPzu1kM+zNh/8QkTKRKDbGP3Y
	 xcwpSIfBI1UJ5tznqSJSYX3lTwmytfheTLGb0tlDhhicYs3+zUkJADL0gy7JNbPCxT8Ny
	 /XhWneWiuzxIUlngiledETm+iF9bx2r/3kHCUEK1EPwTHMGvNDyJ8NSKTMJ89wa4FZyUN
	 r9GfwImNxIrPcjLDGyW9K4y7fZHEqAAyXCLCtcGhTlsN5U2RiigHenqiHI7aaBnnmBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789996355;
	bh=ttdKBByQEhu0xoxUZJTeYvLJ89b7BlhA+twH5hhi034=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HuhvqVaIsQYkl0mXINvHLCC/u4btpbk34ih6LlXapOujJZoYtfz/XVZfVTjc3TI9Q
	 c4qpEHpDetFahG+pAhq2/OC1t7U38fON2epYYHsHttHjX+oNXSm20p7yK5SyjJhWyK
	 ENAh65k1cZmkbRljYLEbOwMoVEKSxfsi0Zbk8ydXT6NRMg6I4CJY7OC1d0cxoLAn4z
	 2aixZT5Q9sZKpiUGAaSAPPQNI7/i6/3fVUflvsZjTSNgmWnEfSpfh1r5GYpHNJCSgG
	 1g9S2K9SC7+5ov8hX2vNmATkWbAEU7TBf4t3aasctBod1JTHxhSCRnOEqvPF7JVSsg
	 FGf9Lnv5gDjpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12B3F606F5;
	Mon, 21 Sep 2026 13:12:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D38FE12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0F2D405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZuo2tBYp77w for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7F9FC404A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789996352;
 b=EzIJHlkw+IEOYwxr/qYbIS3F4E8vpdex7twFFbZ4J7pC5Eo4ZMAUj9ZdpzYFUijUnDj/
 Tf1ZbSNMCWSw8XLRss3j7q4AZ610BqQz00oTGG5cB4HEsXe8j2nQwfKjRo5JAa43KoGX9
 NDUowhCxCq08tdz6KkZtEgDtoue7L/P9hS+hvLjXA/S1pINhzpDXbHyVkrV8dOis7W78P
 ZvWkUKMPIAF/oQFR2HxELgysN5s6HUYT9rSQJfxglEHMh/IBYRok4dNsBB8ZrCmThjkVh
 /mOsR9JinCvwE0QM6bcc4OBsDwsg84GHNMcsLZLgtwsnDF8Xa9iy2DQ3xdelJbKpnBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789996352;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ttdKBByQEhu0xoxUZJTeYvLJ89b7BlhA+twH5hhi034=;
 b=hUf7XzYwmB3PWaUJEE7AQYOHlK2cmbAQ9GQuwKwYOgsi/NocL8/ikT8VS+2dQSCv/xuF
 RpP+jLP1YeDnFh3NexbBIno6+SzdmH5vukb9Aop9OFPlvZ8IATTuWBxm/iqa5ByTmPoqZ
 7SHUe91XciLpjDriesWpBUAnsjBM5p13pJhvNQTtHRFDVsu8ZFg6UakOYCl5rU3C8CqAp
 Eg298NIs0X7YtFonDkgiUpQdSOHqLSQ6pt2W40sitZ99kdD1Ij2h9AQ1rJ3kEEp0iyO/l
 0wEjj/hPXabP+3wlZxo/ExzBdxddoQZ6XBmQnqNTIwEdDNcu6wUHXs9YmWlfH+sVG/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=dB2oxgmd; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=dB2oxgmd
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F9FC404A1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784E61CE0;
 Mon, 21 Sep 2026 06:12:26 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8920A3F86F;
 Mon, 21 Sep 2026 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789996350; bh=aIHaiUmzAEzEmCPji2aMpWc54dHAJcnI/XgqMwhyt5c=;
 h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
 b=dB2oxgmdYlsnGCHIvik+O4AH7Qh1hNvh6rUfAwpg4BCGkPudcij2lt8RQy2a69MRQ
 Go17O5OCZUDl6k69B7RPEYm8OipDgkPBKBDtewzKfNPE4XVkzWVhom2JSwuu7GkA1v
 YkgaxWbWZSIrKi8peoLWdnlTNZHgoxeCOP9OrdZM=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 0/5] efi: ECPT EBBR conformance profiles
Date: Mon, 21 Sep 2026 15:12:16 +0200
Message-Id: <20260921-conform-v2-0-daeb00359af9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2Nyw6CMBBFf4XM2pq+pNaV/2FYQDtITaBkio2G8
 O8CRpcnOffcGRJSwASXYgbCHFKIwwryUIDr6uGOLPiVQXJZcsslc3FoI/VMaeNbq0rpzh5WeyR
 sw2sv3aovp2fzQDdt883oQpoivferLDbvV9X/ahaMM21OjbTalErU15r6o4s9VMuyfAB2culqr
 gAAAA==
X-Change-ID: 20260902-conform-347df9362c8d
In-Reply-To: <20260904-conform-v1-0-475b2947631a@arm.com>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=aIHaiUmzAEzEmCPji2aMpWc54dHAJcnI/XgqMwhyt5c=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqsS08U7qazX+fqQls8m7sg+r5xGamufyZ2rU/J
 NZdceadIceJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarEtPAAKCRDLSfhWdqMG
 lMhzB/4ij7aU2nZ82LzByXVy/7IDBzqR4+abS06oZNHXvmvUFGmoHNsfNKLsk4ozktZg66rHQCj
 L0h/ic/zxm6hU0XXdcRMbUHpBJYXoYTPvyMPtHZhStLob6yHWnRueMf6cf8rqz1VzxarLGZyXLI
 dohbYUSvZqgntvv0BJcrpQAKBZbHF/02ueGJamQDOV7B+ogVgXsROaRRCMHHfin6ykvH7LssHn4
 euqlxs6WWwnmDR/+zqEqAqex5DRfQeKRrkjsWNI2dmK3epmcBE/QbpTKFl9uiMbC6QjfGHBaAoh
 2ThrBvvPmSCRzxqYGfaAyUWzLzVnGOyMDGOPDwYipO0FM5fP
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

The Embedded Base Boot Requirements (EBBR) specification [1] defines a
subset of UEFI, sufficient to boot an OS.

Currently, EBBR defines four UEFI conformance profiles, 2.1 to 2.4, and
U-Boot can advertise that it supports 2.1 in the EFI Conformance
Profiles Table (ECPT).

As U-Boot can in fact support up to 2.4, this patch series does the
following:

1. Refine the conditions for the 2.1 profile and prepare to add more.
2. Add the 2.2, 2.3 & 2.4 profiles.
3. Add the human readable strings to print the new GUIDs.
4. Add unit tests for the new profiles.
5. Update the documentation.

The list of supported profiles are inferred optimistically from U-Boot
configuration by default, and we rely on the system integrator to "opt
out" manually if necessary.

Link: https://github.com/ARM-software/ebbr [1]
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Changes in v2:
- Remove HAVE_EFI_EBBR_2_1 dependency on BOOTMETH_EFILOADER,
  and HAVE_EFI_EBBR_2_3 dependency on BOOTMETH_EFI_BOOTMGR
  (suggested by Ilias)
- Link to v1: https://patch.msgid.link/20260904-conform-v1-0-475b2947631a@arm.com

---
Vincent Stehlé (5):
      efi_loader: adjust EBBR 2.1 ECPT entry
      efi_loader: add EBBR 2.2-2.4 ECPT entries
      lib: uuid: add EBBR 2.2-2.4 conformance profile GUIDs
      test/py: add 2.2-2.4 ECPT tests
      doc: uefi: EBBR conformance profiles

 doc/develop/uefi/uefi.rst        | 18 ++++++---
 include/efi_api.h                | 12 ++++++
 lib/efi_loader/Kconfig           | 86 +++++++++++++++++++++++++++++++++++-----
 lib/efi_loader/efi_conformance.c |  9 +++++
 lib/uuid.c                       | 12 ++++++
 test/py/tests/test_efi_ecpt.py   | 48 ++++++++++++++++++++++
 6 files changed, 171 insertions(+), 14 deletions(-)
---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260902-conform-347df9362c8d

Best regards,
--  
Vincent.

