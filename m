Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432EDC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED8988A69;
	Wed, 17 Jul 2024 16:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="pIlBqU0J";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="q46FszDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C13A88A69; Wed, 17 Jul 2024 16:29:58 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5343D88A66
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 433601140135;
 Wed, 17 Jul 2024 10:29:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 17 Jul 2024 10:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226595;
 x=1721312995; bh=50KKgB5vLyuJ7iBp3PvauMD87VKx3C0ZBh64OJFoYaU=; b=
 pIlBqU0JqBD+XsIcqc557G5TQYkDbdwKV8fTDqCqIeafWtoiwXAVxMtWrp5mY4oA
 dRXV/BjLX6wW9ikz9rI06XJWLv1onAr7mNb8K9PS5zBe+7NUzWJ9eKGFWROoBlb+
 +UEUfiPTromA1si6hNr87Hl9Ad3LI/AXPT9zzgJSpUma8WQw2uhrV6QHBq0KC03S
 HuV9Q3+HDNKwLV0WGqad6I4jC/Z0aoBUuolFHfZ5IwJ2kxEATcxUvFkDtVUNs5bK
 RqmYNfadV3ofN8TmKfhar8DWKZDkQxEd6+T0jDoaGVr4gs0PcGWz0mFgsFNC4lfO
 7XXOa8BjHKi8FI4zZnAEAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226595; x=
 1721312995; bh=50KKgB5vLyuJ7iBp3PvauMD87VKx3C0ZBh64OJFoYaU=; b=q
 46FszDSjNKzIEQivtEm3xQgYkd54U5Yj8jqFE6eJLEfEDdi18YVuiW4siSP66GLD
 j2LXEu182qOMSOtJbn2y1gkz/1S5VP9+ciXCdce7zbjDfIEuIj4t2Lz6rry6y4Uk
 SpxXgMgmvjPHL6a83fs58NYwzhIbfzuu2Ck1s9zmi3XoMXtWy+HEzYcjxcAkQ2ll
 2tGBAPJhhmIu7kOeTvXTt+mv9k10IHD2uWPVWLG41fVTeAVm+FGKn/3G++ESV2Li
 OubU32LYc7TVbBEadthnYmu3bOoyKPKMUER+EsyZzuVI3uhy+C1L0WohcIpTMd/N
 qUMRHvF23SOht9V6cAelA==
X-ME-Sender: <xms:YtWXZnlw59ixR-hYte2OfDFmyVcmwMCnc8eFpOAme7nc08fEpebqLQ>
 <xme:YtWXZq21GS-S7PlgOV6-D9vVJ55hAi7984GeBmDRqlOfaBkN561_HjmtvCpRjFI_u
 1ARYxhbufHaRgroVPk>
X-ME-Received: <xmr:YtWXZtogCKBAKzl_1lRq6xQafACuA_y1zSjWHtO-R9FYtRIhU6UPPDHYZ8IfPi7nw46P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:YtWXZvlE1QpKqeU53P4xctL_EA41IWF4hHSJjLRt_1YBHte0f--3Sg>
 <xmx:YtWXZl3YlfhSSlWW3BE8uQWT34CO4xVH9a62mdyGCMVjw1QTgUeYXg>
 <xmx:YtWXZutJ0xReucQMd8Rn7GF_oF9Ht04Naf7XBvVbu05vramtG7tSBA>
 <xmx:YtWXZpUsoRP15wqXv4RIOtpwFPMDsCsg05iyDVLsgFUDWU0av02Mug>
 <xmx:Y9WXZikFwE126t04zQIlxJiTDF-NReAtSXjlFipFOaFibKeu57j37s-m>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:51 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:17 +0800
Subject: [PATCH 06/18] tests/test_event_dump: Relax match rule for output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-6-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=L5s0e85Z72YFKH/J2CIma0ZkdfUXo3dRpKW5xkl/bYU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10KbrpWM3o/sZmzavXLB7ejjtbNTw/I1a5s8DOKL
 wvvy07oKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInECzD8zzoWFPLzY9u1l0lr
 gryiPhzzCEiWizVb+53RfJ6ZIOPqNoZ/un90Fkxcr6Sss9FhaT/j4pJ1TRuit/jYxZ/IdnfuT0h
 iBQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

event_dump.py relies on addr2line to obtain source location
information, however newer addr2line is unable to determine
line numbers for some functions.

With addr2line from binutils 2.34 we got:

Event type            Id                              Source location
--------------------  ------------------------------  ------------------------------
EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           :?
EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    :?
EVT_LAST_STAGE_INIT   install_smbios_table            :?
EVT_MISC_INIT_F       sandbox_early_getopt_check      arch/sandbox/cpu/start.c:61
EVT_TEST              h_adder_simple                  :?

Which will fail the test.

Relax the source location regex to .*:.*, this is sufficent to
show that addr2line is being called and returned a possible
line number.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 test/py/tests/test_event_dump.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index e282c67335cd..e87825abcd1a 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -16,9 +16,9 @@ def test_event_dump(u_boot_console):
     out = util.run_and_log(cons, ['scripts/event_dump.py', sandbox])
     expect = '''.*Event type            Id                              Source location
 --------------------  ------------------------------  ------------------------------
-EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
-EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
-EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
-EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
-EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
+EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*:.*
+EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*:.*
+EVT_LAST_STAGE_INIT   install_smbios_table            .*:.*
+EVT_MISC_INIT_F       sandbox_early_getopt_check      .*:.*
+EVT_TEST              h_adder_simple                  .*:'''
     assert re.match(expect, out, re.MULTILINE) is not None

-- 
2.45.2

