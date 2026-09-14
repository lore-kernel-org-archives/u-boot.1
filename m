Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65D9C88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BAC6606E5;
	Mon, 14 Sep 2026 14:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3XsKrEeo8K3; Mon, 14 Sep 2026 14:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A9C48606F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395455;
	b=TeZGIbZvQJX53z3BiKZGYl/eISf8axO1xWllILSijGJ4zo8qZJZUYQFH6T5wXYpBDkt9
	 K+tv6mdwJFwRaztGkMADCrWNFRgZ6Tlp3YzirbDbvUTAiKKeC3fuQJ9huY8U+kMxE7lxV
	 ZKJBnzsi3Zp++Z/FoDakv1VyBC71tGDHiYl5RY6x/PyPFQPvTsgrjsbSkzvHNL8gQdgx8
	 /QnzUJ40aNJhyWwyFxU/2qivj4dEZGE6OYg8Kb9qU5qXdB1XvhpwnsE2UoSaXARZgwnmF
	 ck8d5GUPm2k8tOYbRamzP/KpIpwgKGB5CfZIx5aYNV3Dt1z60wyBFbvzAZRMhr7iV0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xVhKKPRdVi5WkQn9qpXHrZdnZfGFjKehlSfgniBx2as=;
	b=XqerWvuN5QlyrTYB42ATtAgqYbM74CzuB9klPKsHF4mHfrBqor5qjkcxh4OaQG2RLESO
	 fl4/5Pnhkg3YHHmfYidf0iaIch7AtiMFc8W15qWKK/Zh+JvWCVqAaXbcCiQTE3yUV7jd+
	 lIG77PWK36xrWSOpC7zoO3qTEx5maSkoZp5hnUs3EOZCgniYeLQIN/LC0kAFKccT/JDsD
	 NSpab9nODc5oQLvZ01ypB9+LcKsgOnICwamvdyfudNCS8RHaXsaSThumhkXdKKgjrIVFk
	 W8EbbopvSk3dCnqi74EARCLKL8tOkRLHcaVl+X72dfZWIPUL4RtrXi8EldqKRipfd1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ErBFTCNX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395455;
	bh=xVhKKPRdVi5WkQn9qpXHrZdnZfGFjKehlSfgniBx2as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jLLImac6OijPIfwUgHwAMs6nbEtEpmiVtCQhwKu80yqxFVLPCbaM24fhxwIz8n3GF
	 ZFbaRyoqOHk591/zDUb1XMi3I1QPYHBIKRzwqnN8dp7iXYxhkyNdb660ZMrQYo4OoH
	 vlbsxp07Y4r+9cgUypliuNvSdV47tsaLK6JRxvAuCYVQZVVFp3fct1fZ8jLdaUJwXg
	 S3s+zHsFblayE6W4R1+InmGswPT7z/Nuzcy+Ti+Wc+51zg9LnjNvdnmvu3W6Zm1Aax
	 Gc2iLxQpk2h50hrlVRTkrEZFU+jC8tvdLpWA1/AlHnvtuuL/5WvfsTKPbkSHSt4D7D
	 SAFdMm8IVBgqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9C48606F4;
	Mon, 14 Sep 2026 14:17:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C02582D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B218D606A0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDKytE9fXvM2 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 08C4B605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=au3pGBNPAgqqTliLXb/nlRLYvpq1Z+adzvu6e4ed/+qXWD411dUCH9I3kARhc7t4A/ae
 3OypkyPozW8cssd/T2xJRQnmEgKPgqmZtzIWI14OjjA5vAl4qn3HDs6xF1qn/KW/7ART3
 ECU703AKa5M9AX+rV7xuojgosXlrPeOrc2jnmYWGWa9gYPJLNfw8MofbGlLpic5kxshO7
 0xDUxk7ox3aG88XgRghrM5pLLC4733vnFfuaPv8/7ZqPZ1hg2eTdBXlJVt1H6MzdZRy31
 78U/7lUTRPUteb108xV/vS3l9FOWnm4a/v6z0SfDfv4ZGJ0s1kEA2tBJuM5/35gDK2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xVhKKPRdVi5WkQn9qpXHrZdnZfGFjKehlSfgniBx2as=;
 b=ppfADY0K4wqtQV2xM55ldudvb0B5rMRbJFdVtVXt7+Wgvfls8ZO1oasy2od2IeIzWhjE
 1zrX9JgOAcY8eDD9GaJnKGZr2Gz42yWCbuNzETdaSUSzCSiIlxG8V7MFo4322HS2L8WPS
 4/EIknPHd65gfJb82M0jfYtvcxuliBs8HQIICg9Pt2BARTyXB+8VjnAQH0ZsRAG93pooM
 Y17pfKCgYWDAAMNPE7iYttfsZq1G0K2deFAE3pNl1DiiU6Fp9iyN2H4utAmqkr3A6tSdq
 5lToRahsbs47zCv8QELqI6U/3P92f+XyRLLI17i5GN0eQwk1Ym4VBea5VpeAWU+PR+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ErBFTCNX; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=ErBFTCNX
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08C4B605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67DB202C;
 Mon, 14 Sep 2026 04:01:55 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67923F86F;
 Mon, 14 Sep 2026 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383719; bh=xllZb7r25rYdP2tV7ZGW3r2Ed8vCwjBEHlfE1YpWp6g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ErBFTCNXQAaM8Oe+ovyA2XaDwBWb+LLf8sYmLWPHgyq9Yt1rqISBT43iXYx6oUFYy
 1TT8ZnzWlfWVmud88kI8PNYmj06oQgNDjroRU4mmARH7gZVcF8IXb3k970X6nEIXEl
 JwyyRWW24wbtyTTOWCKPSaTpyB21BRoi9W5g8uLU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 18/22] corstone1000: enable bootefi selftest
Date: Mon, 14 Sep 2026 12:01:02 +0100
Message-Id: <20260914110106.1974894-19-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

Enable `CMD_BOOTEFI_SELFTEST` in `corstone1000_defconfig` so the later
runtime-variable selftest patch in this series can be exercised on
Corstone-1000.

Keep `CMD_BOOTEFI_HELLO` and `CMD_POWEROFF` explicitly disabled.
Enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
`CMD_BOOTEFI_HELLO` default to `y` and pull in `CMD_POWEROFF` on this
PSCI-based defconfig. The intent here is to enable the selftest command
without broadening the rest of the board command set.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Reword the commit message around `CMD_BOOTEFI_SELFTEST` and explain why
  the selftest enable is needed on Corstone-1000
- Clarify in commit message that `is not set` lines are intentional
---
 configs/corstone1000_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 876b915b6a4..e16b13043ac 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
 # CONFIG_CMD_CONSOLE is not set
 CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
+# CONFIG_CMD_BOOTEFI_HELLO is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_GPT=y
 CONFIG_CMD_LOADM=y
@@ -62,6 +64,7 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# CONFIG_CMD_POWEROFF is not set
 CONFIG_USB=y
 CONFIG_USB_ISP1760=y
 # CONFIG_RANDOM_UUID is not set
-- 
2.34.1

