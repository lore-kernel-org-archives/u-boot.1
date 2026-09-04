Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295C5C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D37F540CD8;
	Fri,  4 Sep 2026 15:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6C2fa0kGJBW; Fri,  4 Sep 2026 15:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E59740C95
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788534126;
	b=Og325so92kpKjvOhS5zH4oLM06Pp1GUJ3jT3IjfQcGmFaLrZprmBOeHOMyaNpRPP1xFt
	 xnC1dvKIQqJc+TtwooUv8l9Yz4SLCeQqpOOfUhuUBdpCDnn0cRed1Emn3H25rume1krB+
	 zF7QOV72Hh0oNmtc6P3j8W8LkD4DPWoKTtIn8CRbRMCGy5KsEAXpqniQZ5LlVqfufla2F
	 +V9eNlXJA6/zVYWHvoXaybKqGBmIAFcUlQLgq5bhLYvojnDixRlBH/8+Jl23d0dvj66Zi
	 yynplPH2K/hCOVf/u8OC/L31MGzCrt2B24lYUMred7EoQuU+Asv6mf7rdg5DM6x7xCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2QS8O7+uuJFtGRn7LRwfL9rHE2q4c85Z4CVKYb/KGmc=;
	b=HZM4608YZehnQHzyRcdB83othQv/H/FLU5k8ZxcexYSe6caoytdib9q05Yacs/FwiZdh
	 6fmzLnJtx7tu3rsk4imGVR6XfI4AvWGPx/4UMmhbfKePHu/i/35rHwZCI2MXaZAG+g/Lv
	 V0740zLygUrAZec8zpnasBtFRmmt6+IT/bbqri3a2SBqkorl9cuKSOMkZy3rTmR55X1rr
	 sJGwI28pBwHIReBEByUUHE6jOtRPAviu+RjjWPmwGQLyphnGEwJMu+YycpcKCdN0ApXFG
	 UDt4m3Nm7PnexehxHIpwqL/YhFCC7t4otjO3v+9RRVYC+LbhJKnlGr35wpUm8tNV41A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788534126;
	bh=2QS8O7+uuJFtGRn7LRwfL9rHE2q4c85Z4CVKYb/KGmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZV9QiR5V5P18cDa9McQ+5j2HpO1hOsW7/eXxQ9tvXUDUREVFnDa0oRq6XukbMI343
	 qjzx46Ib8ZIOJjdkS5/0WZHK/cE4NUbyUl2Qm2+5ERgqUFksl/U60BlLHu7jDiIe75
	 fqrFaaaNekfcSfXMPhIJtlLU1ZlpldAokbK+g+FYmAiww127oDlpkU484l91rhMY7B
	 OwGfN6Ho8L+EvtKQswCbNBj5C14VkHcYyBbrdu5SALn/pXeem0lQm7FmSeOvtV34wI
	 bIha7kfJzcaZDjjjXJyHEZ3Htx1Cm2qZ4kmjmO/pgb+c5DyvTfN3DntYKUgM/uKbV3
	 zAo0ojRJ2W1Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E59740C95;
	Fri,  4 Sep 2026 15:02:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EC3E77F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 147E160BFF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXyyG-cdz2qL for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F7376083C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788534121;
 b=JvohNfiCZMqsYcZLu9YIrsSLfT+qnTvAWve7T8CVXqSe0SA1MPc2dvqEAeXvv1WjRbHW
 dxG5lTVWGw0cp3VPtqxfOjYwfbEG+yFuh702hxvKnv7+P8d4X3INs6qHvPNnXbybEuxb3
 BCt6rfilRO/TZs5cXIMlF+hLUyShfoFezTsHl+mYzAlMqy79I7BskK82OvOu7cFZzzot/
 J2UU8uU7kTLd17frmkZEo+166hiuPx/RwqJcRl+Ypj2FTH0tG24hbvASnuFitvn/StaKK
 G2mLMoRPuEWdUT8TfO0g1E2a2sYfXuUjXqOCZri2oGSOogvXFyMfj564YQhbq3sDZHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534121;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2QS8O7+uuJFtGRn7LRwfL9rHE2q4c85Z4CVKYb/KGmc=;
 b=M9gH0In5LoPskIO+mnHEFyCuVozDkl6n8MAeMLRJWQZzZgekFyCt64Sl7/ovs2wiBlMr
 IMTUNAXi59hsH7Dd2eFJzvqYFs6qQ5SUbXRVvs89zA70N83Bl7v+br7ECV7B0PvP7h6La
 IW8/Vm4w36EkXJJm3qWGnrNO6BVV791fXNDElSVWiOAPnAmyThWB/gjWT0K5WwCBNuhTx
 kFPGXKc9Fo9uLojUcMKdkNCrO5s8So/8g5xiw6vZl9Grt6GkMTngC/JlFe7owSgJ0/e1e
 Z2LDPXjrrd2TJiky/Xnw+ohHvbDM+MDlVu5/GghcACseOyZEK/BVMcTNYvZYRH9TH5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=NTVbes5H; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=NTVbes5H
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F7376083C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:02:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979C8152B;
 Fri,  4 Sep 2026 08:01:56 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C65E3F673;
 Fri,  4 Sep 2026 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788534120; bh=ptEepnh7FErnZ+6NMvzv9Ctc0RzYMMkJQpdmVpHa8Mk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NTVbes5H7CxhudltUyx3tO/bXGrFFAkZqBgrgvazBa/YyOJeZPNVPraTv0NJ9ZIIP
 BNgYwhGaso9bvBQCBKatyVQjI8CjiWa+ILon5LxX4/WXwfNajYCBLGAmjoA4MWV85U
 0apOCcmdtW/mDTgeNJP4/81hQpGLaZr9/jkyg0NQ=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 04 Sep 2026 17:01:41 +0200
Subject: [PATCH 5/5] doc: uefi: EBBR conformance profiles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-conform-v1-5-475b2947631a@arm.com>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-0-475b2947631a@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=ptEepnh7FErnZ+6NMvzv9Ctc0RzYMMkJQpdmVpHa8Mk=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqmt1aJQ2vp6n4u0EwoSu6zekcQKqARfVKE3Xnr
 5eCTaJyyNyJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprdWgAKCRDLSfhWdqMG
 lBEdB/4yVMjsuGPv44+a+SEPULrCz75GshfmQ7XciFXZ1I87Kl37T2kTvht24vUgm362YtXwFBQ
 MjI8ebn0TommyI3CE3RNvzp8OT0acrSg8N4an/QAuKGGkaz1YsrLKpCs/xW7NvRazB7jRtvUk5m
 yduYmOcEXPtTQX7jBlVDTHPyJevAEslMTrqz8x5dDd2Q61/UkRlzb0y/7nmzC5b3NE7AhjiRiuY
 sXl/0jynLNadqxc18NPvOV0WOsmH44KlvWakJXEvfOooNZgvH3kJWeptRskiQc8CYnJypKKM2Or
 MdeD1KpXbvag1iIC6n5K5F6M7CExD/6hvWT4syNG1XEO7FoN
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

U-Boot can support multiple EBBR conformance profiles, and it can advertise
them in the ECPT; therefore, remove the EBBR fixed version 2.1 mention from
the documentation and add a word about the ECPT profiles.

While at it, fix one typo.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 doc/develop/uefi/uefi.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..9dc34495f66 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -14,14 +14,23 @@ Development target
 ------------------
 
 The implementation of UEFI in U-Boot strives to reach the requirements described
-in the "Embedded Base Boot Requirements (EBBR) Specification - Release v2.1.0"
-[2]. The "Server Base Boot Requirements System Software on ARM Platforms" [3]
+in the "Embedded Base Boot Requirements (EBBR) Specification" [2].
+The "Server Base Boot Requirements System Software on ARM Platforms" [3]
 describes a superset of the EBBR specification and may be used as further
 reference.
 
 A full blown UEFI implementation would contradict the U-Boot design principle
 "keep it small".
 
+Conformance profiles
+~~~~~~~~~~~~~~~~~~~~
+
+The EBBR conformance profiles supported by U-Boot are inferred optimistically
+from its configuration and the corresponding GUIDs are advertised in the EFI
+Conformance Profiles Table (ECPT) automatically by default.
+System integrators should review the advertised profiles and override manually
+if necessary.
+
 Building U-Boot for UEFI
 ------------------------
 
@@ -323,7 +332,7 @@ Capsule with firmware version
 
 The UEFI specification does not define the firmware versioning mechanism.
 EDK II reference implementation inserts the FMP Payload Header right before
-the payload. It coutains the fw_version and lowest supported version,
+the payload. It contains the fw_version and lowest supported version,
 EDK II reference implementation uses these information to implement the
 firmware versioning and anti-rollback protection, the firmware version and
 lowest supported version is stored into EFI non-volatile variable.
@@ -1019,8 +1028,7 @@ Links
 -----
 
 * [1] http://uefi.org/specifications - UEFI specifications
-* [2] https://github.com/ARM-software/ebbr/releases/download/v2.1.0/ebbr-v2.1.0.pdf -
-  Embedded Base Boot Requirements (EBBR) Specification - Release v2.1.0
+* [2] https://github.com/ARM-software/ebbr - Embedded Base Boot Requirements (EBBR) Specification
 * [3] https://developer.arm.com/docs/den0044/latest/server-base-boot-requirements-system-software-on-arm-platforms-version-11 -
   Server Base Boot Requirements System Software on ARM Platforms - Version 1.1
 * [4] :doc:`iscsi`

-- 
2.53.0

