Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1528FC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B54BA40BEA;
	Fri,  4 Sep 2026 15:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9ngnWAgMFxP; Fri,  4 Sep 2026 15:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEB3540BEC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788534114;
	b=Xyv7uMBnYbFs97Jv3dKRmCG7OWTPiY4/ZsOL6YAPf84Y3RI9KxtVXn01VosU0j88hLBa
	 tGmmaPtaYVdHDtQvtJ0kvpTNDtq7OuQ4VtdXO+cper0nVl/Sfae5KURU3ttlHp/3kGXyd
	 hwO/SS3WuUDGtWCarBRve8i54EBLBGqoMWHJI4FE1xaZz1lVW5CMcfI6GsE0sxvtpPybr
	 GYcsDzxSoJDMMHYIykwKNyCEqaKZgFSPQcUpX4BidXOhZnxcXDJ/HMrkJkqwBZJ3XMSrP
	 NsdRIyim04rS/LFGOwiSe9a3Bn6sFA5k5GQsbchVwrdcMKTuTXh5mFLehsXrYPxQdcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a37WM2hU8qv2NX43JZ2Z90XBtzRGvQ9OLRFjaYaNjvc=;
	b=FPy+l+WN6JMjNfkMeUfFmaMij0Q9F59BgAB57aJsE69RWxHv5V+OXhebIzbWWoZWD+HI
	 HcpN8M6RXbPRvwcZApVYnze1cOabbduYRCcT3MZLW4pzusFTsQ7La/zIYR7pK+fBc/NG+
	 Ld7oahZ0zagksajqe20luAAhhEC82hFlTXzKxtOUpl13vLm914B0wK029SAsFBXM3yEsj
	 I7Lsl63EiKvvUXNlIuL4eDClb3hvJxNgwzsJkf2zraml3hkKl/Hasnkm12GbxuP7RF/zY
	 0F1xQSbItgX3MwSrVHZCSX97hcQ+MRjwNBdT7gD79SFyx66zc6V+Nav7vWDRsfksngQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788534114;
	bh=a37WM2hU8qv2NX43JZ2Z90XBtzRGvQ9OLRFjaYaNjvc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eb7a6bWsbasdoesaidl0XL9bXHwEIqF75rtEAZuPqse5TV8gjgzp/HvjY2rNl3+2Z
	 e9gmGnpZxYou8EC1MArh6xXUavCpGXCQUh79mxT6znujgZonP9VF9UPm6Lh2vECFNY
	 QZZT/daM1hHAEXtbJYEe5QGrGnyFTrpsdNR8+dRoisPKxS9/n7aP/Ao7IUHNYehkoF
	 Rle/K2hHfEhdA0446Y3k5jUsJeyTDrQOTh0ofWcbMXbseM//AvhoBx/m6+H7QtlTLj
	 mPTstQBwUb+C2jZY+5P1Omq3CkhnLKoJHORYvFtTZriboZk5XFF6cqTWSOEMwlSjmn
	 CGZMMynwo2WTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEB3540BEC;
	Fri,  4 Sep 2026 15:01:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2C4877F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B91DF404B3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1I9z-6Sd88n for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 957E340376
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788534112;
 b=pY/eyY18vu2sjD/h/IceYa7HEYtdgHWtnpbI7EazQP+RAFmkCmwI+3wNZ4j9xT9aHEfa
 74Ovp1ayZszskoL+4xVrPBzRaI5zL4PEH/VZXiz8VKP3k7lSsW66hgJyQ1lVhldANTd0E
 pwUH3wYlU1w2aQrLB5KVKTAXe5H2jYY6UDFpf/5ZwMafu0ryx5wrzVnqMg7Ci/foqHFgR
 PjTpKsVDpwkDDeY/8eh3XeSF/Vo0Cp1E/If/PATBgS8Dr6Qx+mMeYHUvfhwdL8hPrSoax
 OGH64lNaWRXdTa/Rm1qx/xBSjB99wucWMLTle/zLqEJQxZwPWsbqA2Dj1v9dV/QtoJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534112;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=a37WM2hU8qv2NX43JZ2Z90XBtzRGvQ9OLRFjaYaNjvc=;
 b=jCkn6t4FCLlAeSV1It8bOUSgF9B/AKS13PXtcl22i+BhjXClqTc7bmuHryEOwpTrRUrV
 Mdi6oaKrZIzSMh0u1/hJMgQBXRqhydlqmjgnnyeYEcLh3vqlcnH1g/PJeVMwMrVR2k+UY
 GMH4g5lpsaD1QsDeV3EsqrSmWIXQKRjn1lFpScKM7Dvrguu+NxDjUnp+Y3TAVs9KX1Jp4
 H5nej2rpzpWWlc/O1fDzSL/T7Ffc6Ndu8iyARj+MjmnkhyrY8ptQu3qsQrgbD2/LSFdMd
 m4iwxgMyb9/Jw6Mq26+V6CLP9yFmKCN5prXsDK5uHbdVqEcoBri67yM5pcU4ypiLPvg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="QH7Ucl/b"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=QH7Ucl/b
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 957E340376
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 318B6152B;
 Fri,  4 Sep 2026 08:01:45 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5913F673;
 Fri,  4 Sep 2026 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788534108; bh=TevBy1ffBlHFynrVVDOM2P6zT1RTBdYoOcnelw+5p1A=;
 h=From:Subject:Date:To:Cc:From;
 b=QH7Ucl/bykV4m+uls3vaaDUe2BUbqYPZLI/+vpYDzFba5Ctu64I2xrMki3LBx+F+F
 zZtXFS/Tu0ocLsEuV3+XV8mtMV7UPGQM8Wee/QvNfP1bdnp96CPSB1U4ORdUJzofUZ
 S1blzBKJvPnBAilp4PKPc6EfjANIIrp70lWC2XQ4=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/5] efi: ECPT EBBR conformance profiles
Date: Fri, 04 Sep 2026 17:01:36 +0200
Message-Id: <20260904-conform-v1-0-475b2947631a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMj3eT8vLT8olxdYxPzlDRLYzOjZIsUJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAFER8ERrAAAA
X-Change-ID: 20260902-conform-347df9362c8d
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=TevBy1ffBlHFynrVVDOM2P6zT1RTBdYoOcnelw+5p1A=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqmt1aXx9bkJNZO5yIwj+Z7EoTINQkxmN7rOaM8
 EhGxyzd+uSJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprdWgAKCRDLSfhWdqMG
 lGuKB/4tLAcEwFKGHPEpqCQ5KCzF/6THxy6utvYNv8awbDJwjVq50u6Mg1s6AGbP3GCV++RHtQH
 4Jlu5fn56miL4bQazvF+5ZZSCWo/wB+Z1hbT7atxJD1o7N2lZLJJGYFP6kq+P6qghdT/OxkYszx
 VEtXG09ygJrvFq+WYT5L8nDcfdcfjBYhlp3RH6zmfBapwtoVMold4E2kMpeRWgv1ytdaa0tpjPe
 ifAVJxvQR6aPErOCEQAXGP/40uwM+GWvy6PZkCNuKYnwns/Zz3dVBWILWXljqRVMo+6DRUVtn8b
 uqc2PwZwRq3rWwaqessw51u7AZMOX52hl0XnU0hsrjqn/G3A
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
Vincent Stehlé (5):
      efi_loader: adjust EBBR 2.1 ECPT entry
      efi_loader: add EBBR 2.2-2.4 ECPT entries
      lib: uuid: add EBBR 2.2-2.4 conformance profile GUIDs
      test/py: add 2.2-2.4 ECPT tests
      doc: uefi: EBBR conformance profiles

 doc/develop/uefi/uefi.rst        | 18 +++++---
 include/efi_api.h                | 12 ++++++
 lib/efi_loader/Kconfig           | 88 ++++++++++++++++++++++++++++++++++++----
 lib/efi_loader/efi_conformance.c |  9 ++++
 lib/uuid.c                       | 12 ++++++
 test/py/tests/test_efi_ecpt.py   | 48 ++++++++++++++++++++++
 6 files changed, 173 insertions(+), 14 deletions(-)
---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260902-conform-347df9362c8d

Best regards,
--  
Vincent.

