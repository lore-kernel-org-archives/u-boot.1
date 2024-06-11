Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F72C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B46887EB;
	Tue, 11 Jun 2024 23:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ycHbdLgu";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCYCdyjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83105887E8; Tue, 11 Jun 2024 23:04:43 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616378839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 4864518000AB;
 Tue, 11 Jun 2024 17:04:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 11 Jun 2024 17:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139878;
 x=1718226278; bh=x8bQhFnil2+u68SPqNO2FTU2CSN8ZdxqxnaO7OMcH/M=; b=
 ycHbdLguja+BD7VE3sAFz98ljpQQY2r+EnP2ZOa+IaClDFBdFn6svPnTPyjPQXdl
 lnwD8sbX3EQfmHYdHZEnue7k4E1jV2SzzYrmasvaA4M+zAoCw5B1g89d65F3v1cU
 JOpy9/UZl7IsAGdqiSIfJnqA6TBiT5GpRw9hstFDrilMNKEkI/D/9RZ65MjM/NPu
 vOhtSb4/R9rGcDFqiGQejrIpM95MBb/RtqWdff4WmoWfOf527s8mf+g4p1z/japB
 EWXATw11VvwS6aH9LN8J1pm3cUS8JA5vO+ZinhGbESFgCu2/hpqSv0yIgDeNfFUD
 wJDG1BvA6alXIfrQII9XkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139878; x=
 1718226278; bh=x8bQhFnil2+u68SPqNO2FTU2CSN8ZdxqxnaO7OMcH/M=; b=U
 CYCdyjFcgoedWx9mSurN4R7iuEzBlSvFly8L7z9pwKH9184qdd8QzSyTOrBkgl35
 7Kn0bnJeBdEIV3oEbhtIEJhM4ZbAAdhlSXEzhd1UExf2VTaOy9QGIE7gNKKayLg2
 QK58Pp5Usg45h3O2Sds4M0tf53fymNmjUNllDAFvUFj1UWBmCN1QCKuh6ZJU0pIS
 QIREarpS46/T1LrrKAQ+TSVwskPcx4duND52ZsBxIyP9JaKL5BB5SjpXVGFcKT0O
 ABGQeqX/yxEW1BPPR9sjMb7n+Uoomeu2YAF/4Anm6J6Dz6My8Wq4BA5VDdlPdNMY
 Wo8koh1S5HEOJmBuGrAIw==
X-ME-Sender: <xms:5rtoZsZ-SbKLMuyA8NK-Mv57VefYApiNbo2M8d14fQxew0FZZHspmQ>
 <xme:5rtoZnb6rssoTCloomhwApVunlj1ZS4vDq0OSbSCPpIMB1BzoitsM_UlSCG66LXbG
 -pQOfEykN5x2hCZvRQ>
X-ME-Received: <xmr:5rtoZm8Arx4gI-JSY3kRHq-dijRrLYQPmlUhaF_pO4RWEVqGunovpDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5rtoZmpVHjiSmLsr9rRCr5uqXMD6jGyGIbAJkOwSyleHeSlPxbFvYA>
 <xmx:5rtoZnpeowsWaJ7UKpgfTlGWaMAWIymjiGiB3KscpT6AiGqXVz8zmg>
 <xmx:5rtoZkRyzyB-vEn1vKfcDchv8FtWsJb9528X2Ixr6lukgDleB04xZQ>
 <xmx:5rtoZnpQShoFCH4Diy50m8u379V8-yrA2Tp3dsnbj0W6Qnuz26eaGg>
 <xmx:5rtoZrfiajJimhXWatZR0QZLkKltxt5Md0a7Drdf-M1Xvszjs2RONZtw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:37 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:09 +0100
Subject: [PATCH 10/20] tests/test_event_dump: Relax match rule for output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-10-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=/YkMccQGLwi/Cz0VLA4AK5k9NIL5ggz9QyuoPJKgkCg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3Wf571doF056tS1P77DogzWzj3uJn4jqeOjeZ/ru7
 6GT787M7yhlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJZOkzMrS/e5YSa+4qcX9D
 XUDqxbqGwrxT/Osi42qPz3PNkdKbwc7IsHpNWtCv7ceCMwstLXnneO2/kOKadOtP6sPzfBam1zm
 P8AIA
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
2.43.0

