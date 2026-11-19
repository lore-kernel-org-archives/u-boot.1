Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A613606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LLCmcGHu;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZzkfirfT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A33840B81;
	Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCsTnrpbnADf; Thu, 19 Nov 2026 13:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1727E40BB5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095212;
	b=pjpFHclDa1ydztYwny7RXO/zEBQ9BEWLhqhWRm0oz5V/+vJCMXxHIzkfsvP/6QoEB+6s
	 6XtZ7jm6/73eAEzy0Umiwv8Yrfxo/B86mzQvvz0BUpYEk5mW5LCm65W2D3e/DHRFQcVL2
	 zvBd/NKrVzdez8E6ejMSnO0DIP8KV0vWFh5Xd6EBzvJCdF3klgrqnsoginLLe11zzlVOW
	 Cc647GThGVhu5a25HBG1MG/g1gsQQv/thS4Y4ju5oRhHJUfagqN8Y0tfrW6UPvqD3NlUS
	 xmpc6CLrTb+qlNbgE/NZnFPL8/sCDMsWH/5g4GCYldkIpViq1dFnK4id+TjPEXPMnTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SkfHuyXekC+bSkYai/ZUlzF4/aHNS/z7SzC++NHGHeI=;
	b=q9VlT8ZS8nRcjTuer7tY7bHqH95/41lLcnM6a8UPvwWyzHQKilUzJPmKa9JNivP4GDha
	 tVyW1P4+I3JZ9MEIlmDAsvfZuGCCzWdxSMAMC+AxvbJCl+5bgeocn5FOOc2qx54LnUjQy
	 Zkg3wATkiOU8d4d5A130Fc7bOdILQ8LqdpfnC80+MlXFEcFGDVwVedh1161m60m3uXxXk
	 3i11+b65ykPtCMUkV8wOHOXu7OI6hJmD8xpeBLxDF5ecQ2RdAkOJz4sDSRCqRFtYronEY
	 GBz1mFApgVsShjmHGlizkQid52LbFeGbWxT/azK8voj/tJ/lOYKZbxHEn85XaZHzR3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095212;
	bh=SkfHuyXekC+bSkYai/ZUlzF4/aHNS/z7SzC++NHGHeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LLCmcGHuOOJVcUSRE28ujZGpPrTX1QbanJGuG5JQsABFBRA4LcCf1XUtFuMvjbJrG
	 NR0JUlyDhnHk0qk4tlGu7woNMLch9mdRnPkI2OTY7NLVrLMRBLUyoctGtW1AAutztF
	 oFSEcCkMXl/V6zOO+qGwS+glbbrCN9t+tNlLdNroXQ6fju7+fQuvKIrLrMSU4n8Kj6
	 +qwLYtDjOV6jryP9a3hNsmsEskG3I7858Ammcn67UAiORF7TAVb9DzRi/p0RJVLka+
	 BFSx5ThnCC4qke/pqZUAoaZNq+YgJRgjfNHAhsYZyEHWHYSUYT38Zvf+6054Yewg0d
	 bYPQdO5r6j1dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1727E40BB5;
	Thu, 19 Nov 2026 13:33:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99F19A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C12540540
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWkiQeB8FTKX for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A372B40527
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZzkfirfT
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A372B40527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:24 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4a33359c1b3so1594096f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095203; x=1795700003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SkfHuyXekC+bSkYai/ZUlzF4/aHNS/z7SzC++NHGHeI=;
 b=ZzkfirfTOLdtMPzCiy6MhqYBAP9ciCdVPr0bmw99UUkje6zAWHlTQTVNzRqbT233QS
 /6Iz7cM8oiTfSpg0vWVuRnwKbyWWsU5VRLH7GDDu9ocSqqnulQSLwDQTxy3cU/5j43Vs
 od4AswF7Lx/mzKQQZFerR6ZIisICLSszrOtGvkvdQf3vsNZgmen3KZ7KOCREcm9IXBKN
 cmgbbjMMQAShjIe0fU16j2pgyezHOaIo/U832CGX7DM5giePc1/hFdLP/JbrZVBW560z
 aqz7iHjmaF47ABSM9vGMcR+RrFXuHUo0lc2U9m05blG8DQEh3MT8DNYDh1gyCF/xZ7ra
 8Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095203; x=1795700003;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SkfHuyXekC+bSkYai/ZUlzF4/aHNS/z7SzC++NHGHeI=;
 b=QPBqCd98uSw1IrmRb7/Hgih3DpHnRLZTYh/5ubHKHQ0fPzROVZRpT9t2H5mnDWzubQ
 U4vWAIRei3Xpd0tYdgENMb0jJXSvEZcu0wx5dyJzLFPY7nFfW7xR7RGgWpV8B31pufJq
 WaHmWE7AbBOnDG2SDiGZRbhWIUmlZYa+7XmLud1mMaMQBELhdjzRekQz1ji8uN8siTOq
 oWtNds3imkUfhdyRBnw+Y/7J5iBErRXgh5NC4ILiVFVqkCIpYlTc7c1QsAc0h+WsvrAh
 n8ld/6avUXRrIwLj6NqKCrcXw0ovIs4BNPFVVlyrC5sGAwrZyy9j3OaK3enzeJ1LvR1d
 o1mA==
X-Gm-Message-State: APuU4Z/J4GTTixPXE0MqR/X8vH1ExeKWShrRRgts5ZWM6yDwOs36a8RT
 mA6yTEiK8fWcRUT7L+xWPkxI8gsjWEJHBewmM/hxzq4iksRTts1OnRx8dPkqr3r3
X-Gm-Gg: AZFdTZfdHlrEi8W3H7rNcpyROd4yGk1dYZ6q1UUAOlay2k/7HjtC9qL4tPEUfohe7Yf
 bOHWF4RdVlTwVpOmXfxajZypfQ5eF/xYCvaSbTyAGxO4dA2wAYnYOZH5cwvrjHvzNzggITG4izA
 +6OohZnL0dQns7294o8GJ47rS77NeoxeeU2aY9HvkMqBjjU285u19oNUXpXgkc4LVw9qC1BxaH4
 4TcaxCo4BVpMIITeNzcNTlsYHF1kDsOL0qYAqbOSQXe1yYf7wMuSOaFaj79VIZZhvrTNZy49Pu/
 J1XeoUpV3QfCSf2uKtSkfKzdBT3yGotIZHd8DwqFKFvdK//q4qFvzQ6Pu0QtTLupC9Yv9VEZQdz
 1JrOMbyMlysepCqDBAWy7oBEnzMHwhVakOzHm1DYXzrrbZE1h/q+NcRum0m44tmla5t2Bn4DqGr
 IziMOT097Wud8jCR9BEkTKF9W3Le9piByebrmdbkdRON9OL024M72YxjXy6/PBNEkxRmvuAevdP
 e1r667txmm6qj21fk8HJ6cguF3NHm5tlPKBOx2WkuFPsZFkznLk75Vvtkhe5idt/rr9et5Tc/L2
 nS6K3l5wrU5hCMTzOLl6XW3GHLpMoROTJuHOBKugOTHh27N9LmbrjQavnf8HvjdRr5gxz2tu6Aw
 +Dsn7Ps11Y/NBdJ5CIC4cMAwd+R0vrKG8gyhKwaR6ry3NehGQDson2FCJGXxOjbf+9eubAwjSPU
 iIstqsn44FoN+9cTMOdEaSwbe7SH/Va2LP4CI8pyjBmc2irwFn1GXT
X-Received: by 2002:a05:6000:2905:b0:4aa:9a7c:71ea with SMTP id
 ffacd0b85a97d-4aa9a7c7626mr2452586f8f.57.1795095203134; 
 Thu, 19 Nov 2026 05:33:23 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:22 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/14] powerpc: mpc85xx: Allow LTO
Date: Thu, 19 Nov 2026 14:33:04 +0100
Message-ID: <20261119133310.22732-9-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select ARCH_SUPPORTS_LTO from MPC85xx, so that boards can set
CONFIG_LTO=y, and name mpc85xx next to ARM in doc/build/gcc.rst. This
does not turn LTO on for any board by itself.

Only mpc85xx is covered: it is the PowerPC family whose linker scripts
discard the LTO keep-syms sections, and the one that was built and
booted with LTO.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
(no changes since v1)
---
 arch/powerpc/Kconfig | 1 +
 doc/build/gcc.rst    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b4883e00458..20716135cd5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -17,6 +17,7 @@ config MPC83xx
 
 config MPC85xx
 	bool "MPC85xx"
+	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select SYS_FSL_DDR
 	select SYS_FSL_DDR_BE
diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 16afe292899..5e81b2e6661 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -196,9 +196,9 @@ Link-time optimisation (LTO)
 U-Boot supports link-time optimisation which can reduce the size of the final
 U-Boot binaries, particularly with SPL.
 
-At present this can be enabled by ARM boards by adding `CONFIG_LTO=y` into the
-defconfig file. Other architectures are not supported. LTO is enabled by default
-for sandbox.
+At present this can be enabled by ARM boards and by PowerPC mpc85xx boards by
+adding `CONFIG_LTO=y` into the defconfig file. Other architectures are not
+supported. LTO is enabled by default for sandbox.
 
 This does incur a link-time penalty of several seconds. For faster incremental
 builds during development, you can disable it by setting `NO_LTO` to `1`.
-- 
2.54.0 (Apple Git-157)

