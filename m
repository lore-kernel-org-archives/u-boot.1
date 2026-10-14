Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC57CC6B30
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C36C810EC;
	Wed, 14 Oct 2026 20:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82ykKcXVV__c; Wed, 14 Oct 2026 20:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 231FC81135
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008235;
	b=FCQeXmU6tIjViDXTDZqXGTdFe28K7MrOzGjHvtWbtl1L19cIFlaiPToa2Hnlux/zuRfL
	 RvJcYo0P7aKKa1CiYn+MFT5DF1ShaEOqnDNuT+GqnWg04B38S2/4HsFhjzEZFPwq5fuCX
	 +O6pZLyigVyZF4LUvQIUBqlRIh+nuR+HKdrDMQreVm2fCpIN/Fac/nPxuiNvrOcJp4bL1
	 Pd9L1oZeOcLqepHFhRy9FR7G75baUC6a6IMm5eTHqombQV0rdZd6+e9RbDkrzMHV1ttvB
	 uxhoC/O2Qn42wsdHPS2QdqD+2i/SN2FkBlZGlNzTb1iXtAE4fXwalh+uSQARdATlzsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yi+pQQqs7hlqNN4dA1J74NWYGmiWNAEahQCKHwVieIM=;
	b=MVXgrhTdaykAUwZ/99NpazCQrPdoPn6x/KT70kDBctLsLtApJs//2mpz6Nw/CV7dt70M
	 +5PdZn37CPibTRrHaJJz1weDPumZvJiQsSNh5pCNAsAfRgePxX9mDpB++2uYCqicyXp7r
	 f9kCNP01fPOnqzI+m9xao4B0mDvAE2jMoUeKXyv1Lhpl2FyPrtShrQIlCeMd6F0U9x2a9
	 nluJ9y2LAOy49uhIt9IrQrDxwU6eBX4EqFEyws2XSdjsvQK+qaTuHsv/f4tO1CdJTUPZO
	 503Iz3/NwZhxdj5drFTmvnVnYsWOxlfmkry22ZxOCv3QZw53NHTZnOb7LcqC4CJ2ZDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008235;
	bh=yi+pQQqs7hlqNN4dA1J74NWYGmiWNAEahQCKHwVieIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QKRFimgc/nkYFjt/VBkovfqQDLwLZ6J44yu63+k6shC3vG0qD8G/YTvUhVjv94FKG
	 D9FvfJRWG4BEvnHpBTVsskyEltx8nkihArwYZuvHITLx6MXcbpbXHRNJFV2o5vxr9b
	 T73mj301GzT+HzfEEKuC4bqTlX8G8a/CMXGYA63XzQSqYJOMGqpogD/s1maSMNJ86w
	 rSGClKOCfAFrlMK+3KL5IDC6d7E92kcoDtOep4Kij8AD/rOcMaJs8DTTceqBfk4EJt
	 xDsRwAfrt27sRCVGVzECri0MuyArVgPJv0MPwoM2TZ2ULwS3pF384RXndkkSTrPEpB
	 OH2vCv8DMr3HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 231FC81135;
	Wed, 14 Oct 2026 20:03:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DCB72E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3448C407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ZkaS490XIim for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30184407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002221;
 b=gXSzpTArS8AYxntuzvXVlyY6+fSwPIxJ0+mH0yXQ6qtpjCcv5xfXUVMmzs3y4iVwBrpR
 V+5rGjpPAXNMbJwkluVjCZW3GkTNK6nBqbDSE0+3jUvth04C++W+PRG0bjTHL8iRfv2ja
 g58Qf9lTHARBp82NXJDWBu3DQs3r6yvmFP98y0vjeQWcUHxzXI390JqSqvVDVWOo9JIay
 DvQYTUBYYe/CiRpFzf8sQgN2djMY26HEUjDEgaLJlfC26r5IDFAWSN56Q5qkmjDo2fVfQ
 v/B5td8RjVWmMqGrltnIuRLPER6ZaOjt5bUckkmjGK9XWtj0G2r8+6ohh0r7CQyZRAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002221;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yi+pQQqs7hlqNN4dA1J74NWYGmiWNAEahQCKHwVieIM=;
 b=oeUsBW4oMQV7xJy4Lz1Y+Y5B8HooIg519rOVP0egXZIqVWmHTyeviZe4fcWPbCPyKS3C
 0Ft441k1UBudeAkz/BvVzE7WKPug6zPTEvkg/wzofoMvza13+IlIBBWPm001DRK2BpQau
 pfvdiTSSzXiaTzSzljDi66bRGOY8zMkDZhRP+BBJ9YppOdBjFFCy/5YbkDX2LPI4tjGI0
 ETAMZzvQ/+HF14S6SEPpotOZyQAJlz7Oeo4SNmlPlAZF0OchN2/6xdKidGxATojgg73td
 dvbHyuWcyuhxmQiix6JlJI8W3cCUZZX50LQbqY40hymf8A1WYH88lb1gj30bEmn5K5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=K3OTnjnz; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=K3OTnjnz
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30184407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5624B152B;
 Wed, 14 Oct 2026 11:23:37 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52D093F871;
 Wed, 14 Oct 2026 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002220; bh=lO73k4cKDzAIZxU+cTLTSQ59eqgM2dt9dH8kOOAihuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K3OTnjnzQT3T13P9EJovTELzvSWbkgl/cg+bM9kgxDEplC0GFkY5EXBto0if9wnov
 UjiCliepJHH2D9wNUDvRp2TNLRiOlJoJkQCOrpSkq0sc26JNj9zrO/hSgqigXBr6Qe
 vREPd7LxfhLEa8DUb9uohYaCK6cj/krsmnx54UI0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 18/22] corstone1000: enable bootefi selftest
Date: Wed, 14 Oct 2026 19:22:58 +0100
Message-ID: <bac7fa7daaec301825682489b6b82712c18e5acd.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
2.43.0

