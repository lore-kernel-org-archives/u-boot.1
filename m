Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95548C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E57B8107D;
	Thu, 10 Sep 2026 14:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tONcbZMgSo9I; Thu, 10 Sep 2026 14:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6022F810A5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789051607;
	b=eUupABUu3rTET0DPsid+M1abhibrL+bw3oS8PQEpOy05cuV9q+ThRAI7gEMH4z4we4/1
	 cX1v4mxOtwKaxLrqgMG+zJ7IMwn6OXP2ZGO9kwHJO3KTutpDp6l1bUrKbjGDH4/TKBzJw
	 cCMDnhEJY7M9HjOJiRLPvVYc2YTvW6+CmVaWlOrFfkOPVUF1f+2Vl5xj3538+ynbRhCVp
	 KPJarM+FiDBv58lCcb8CrCZY9Kf0fPqtAVAb+Bl+DyXW+Aqke5vD1m6EHLfj2NIHB7DNX
	 XzHUf9r4zhfQrwkuYBlLF/AG24dE6qsSSrc3hw5sX2sOng99jiKFehQQ1hcqLl0bylw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789051607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YZz8Fb1LtmGCSjjXGiEwwbSBEkW6VhYX2r3d6HTDXxY=;
	b=HumBT76932S6kQ5pHbum7GDEVzt6+3bn4l97C1viwS7G6hZLBuF1Pfj0A0XQcE/EM9KT
	 Ocw6MUqRnm3wq+MjLGMPAkBWaXJq+NAR58mc5UGbpAhdEV8vE/Bqq2PVgIuMY9CXDIblH
	 QMM8IETjFYvj2bj4fkqgekHbP4nVDo8Qgfg6m1xCJFzDzfmR63Xm4IzINB8fssg5Fq3TJ
	 jNaUznFgCQHsX50XwYgEsSMWoThHoFCqI7/VDWEcl2YMBAzQIWNqHAAzoTolBpolP0BH8
	 +vbQHJm8vH381kLEK1NBn3GUPB/kGANnaiwMiFfM/HbExe1Z8jPI57ruJs7YJqXc97w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cf8IpQ+i;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cWRUoRUV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789051607;
	bh=YZz8Fb1LtmGCSjjXGiEwwbSBEkW6VhYX2r3d6HTDXxY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b4jcuIS0iPoGcZEIz7rhKehBZRMYbUtWwJn/AHvt5aDyLF+Td/t0fN5NZjWZG2pZR
	 unAS8yQ79kYuYWpj5GT416fdm87cLsMNMSi3E6fF4+t5yERn9Z4BroEu9y9b5msA3i
	 4x+VIx3fE5A0XiXkNiwyEU+pFdEHabGihP+sZfmuktDqx+lmGO2CCyrEqR4yfw3R5z
	 FDXg9udTSy9FJjlKNjxrPMfs1Sxr+u0n7qXlMLV3P87z4GVcGm3BpWak0Z5SsvdECn
	 VcGBm+YUYAGooFuWmPtJJ5uokAyr+rka65w0Fkch34Y8xzffAeeVwVADq2GOzJXlZT
	 VFxunchibM19A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6022F810A5;
	Thu, 10 Sep 2026 14:46:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C6C943F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E1B1810A5
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0wfSwiHv-Ge for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5134F8107D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789051605;
 b=sKrwbZIUMqSvz8MynSBVoRBjd/vSlWarvyAlsFEhxtSCzBEb0fS+QuHQ2DwrhhGWUgdz
 8nSIo5K/jl0sUfkQs3bAcagPCb0yiGNh7IcTGsS7L2GiY8mvUoUk+BDmxkM+rqpICr7C1
 LJgtnwf5iQws0biPxFeKtlytVlR1+rslFlsH6hDWH/1Uif4qQCTosoImTL0N8GPylNsCg
 ShFE/OPqw95QnhSD5mYcr9fYYr+YBjy9K43prTVWO5rFfXfHl2WXyt4yZgiKWBOt9wwQe
 VEt8AnsA6zBbzdNp6NfBrY+490VTcHBJ1lOchCIB2K647vv9flitc7hDm6NGlf81YMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789051605;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=YZz8Fb1LtmGCSjjXGiEwwbSBEkW6VhYX2r3d6HTDXxY=;
 b=Dud4dT2Z4C0Chutwlp+oIDCyxmTW6SJ6vsgefcMOdGURmSJg2keKbqdiYfQIy/CSxP5U
 8B9B9NxbzpuOWqNtAvoVmUdFuGAdMhBsvNi1qxqjUTLenOXSF30vUnkjBUc9W0a25Fuwk
 aKKRrq8aSQh/T61O7nTJC7K1YA9KXhsYuuCmUZgUhCxlXNyw/SdzCxLegMCUJicwBCLd9
 4vPhxDGLMTnZLHUClWLaMOl6XqmMWvZODC2z0T8jagXJIypc299Pejn3oWgThskiJM0B9
 vjBpaXmEL10pCkxR7naJW2stKEqCLiRIHlcUgTbsQMyLFJxArY8H0rIXqHUB9l+5APw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cf8IpQ+i; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cWRUoRUV; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cf8IpQ+i; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cWRUoRUV
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5134F8107D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:46:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hggVV2vwVz8v1q;
 Thu, 10 Sep 2026 16:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789051602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YZz8Fb1LtmGCSjjXGiEwwbSBEkW6VhYX2r3d6HTDXxY=;
 b=cf8IpQ+iNT1Pp97OrmfA3nYlSYjgpP+DqhQ4wEWx6dIhwQe4dRDwz4cmjtUnPiJtmdNuP9
 6bwbaxhOS/KLn6/zw/I5A6/E6vtzXSep7HUXRuTRw40PXz2T6IifNPPzjdC8CQNYMMVJo3
 pG3RB19gX7XP3NUU4mdoFaNrwgWBGxA/BD2pUaOh4uZbjZB2CCfPyeNobn7Or07H0MDQ+y
 +xlzvZWEO7SH5b4OWJ4bPw4DeZNYZ7W21t0D1koipRHqmtMrnmUxwUx9VSavphpjaDUkv2
 5doKEshVWjcMYeVtOpUEi9LOdBnPojhj+NQ8KT4ji4znLG9x9NGLikrm0Tn4aw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cWRUoRUV;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789051601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YZz8Fb1LtmGCSjjXGiEwwbSBEkW6VhYX2r3d6HTDXxY=;
 b=cWRUoRUVadJ0LHj7d563WmK0QnEJ6sz4lTixb8bwaMZaHEgCJ8RLLmxxn9Q8xa8vRNcWt1
 +61xuUSZ/jW4SwkD+r9VCz554JCDXXaMjHG/b5wh9Em6I0GeVxbLV5zSZtrktyDeRuSR7g
 x7qF1iwYaGz40+tdVbqL0WXHTV4HPzlNnggs2OYE3wGVWmRzDzfT3aY17XObmLAMb7PlLb
 zqzYavyMqKHm/eGQEUfGoqbn+OdHv7Wi14u8alL6S7BthoL/tSnAWsWCX9EEm1ThpnNmdJ
 aPBzFHNehtN8CHzTTcmFyUUAXfMCMXyaZvkyUR3v+9iGTUxmNqPeL6Ol62R3Cw==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] env: Update description of single to redundant environment
 upgrade path
Date: Thu, 10 Sep 2026 16:46:15 +0200
Message-ID: <20260910144638.9642-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tnkqx5usr9eg6xxotbpwswzfgjb4qg7h
X-MBO-RS-ID: df13fdaaa19576ba7b3
X-Rspamd-Queue-Id: 4hggVV2vwVz8v1q
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

Slightly rephrase the Kconfig symbol description. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: David Lechner <dlechner@baylibre.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
NOTE: This is a leftover feedback from the original
      env: Add single to redundant environment upgrade path
      which was applied, but this was missed.
---
 env/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index bbd657682d7..c6df09a3349 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -536,10 +536,10 @@ config ENV_REDUNDANT_UPGRADE
 	help
 	  Normally, redundant environment is expected to always operate on
 	  two copies of the environment. However, hardware that may have
-	  originally shipped with single-copy environment can be upgraded
-	  to redundant environment without loss of existing environment
-	  content by correctly configuring the location of the redundant
-	  environment copy and by enabling this option.
+	  originally shipped with a single-copy environment that can be
+	  upgraded to redundant environment without loss of existing
+	  environment content by correctly configuring the location of
+	  the redundant environment copy and by enabling this option.
 
 config ENV_FAT_INTERFACE
 	string "Name of the block device for the environment"
-- 
2.53.0

