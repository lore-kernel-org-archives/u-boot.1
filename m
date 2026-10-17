Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52F5CC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D40E409D4;
	Sat, 17 Oct 2026 04:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FIXMNlfL41rL; Sat, 17 Oct 2026 04:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F129409D7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211781;
	b=g8W4oH31AWmBVNfo6sP5CyU1asLXcYBraEnew5kyhNDInuYO/F/fVjtxDKbnVqqwIj2p
	 FR74rl3ytepyvq1g/d+kvgWFJ2x3GIYvlYYEf0RWI1FpkyMv0/wvT+RdZW3hMD9BAZElO
	 4qoz9t1TKTMJdHErOAvXtChxHb92kbQQtnHii/N1cEgVQys6RQRJGPSpY5C0LotTGxNh+
	 vhw9RUU48SrpXjdEuQsDxtQfAjKpGbcInYif7aEYBmjfihuGvniHuuMoB0CpVJKSG78cz
	 ji6UE9EO/GfCQXBm9uYSnovHdg8zfnNwQPLldst+1ALygJ4h53/t9LqpcVH/kTJ9hdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
	b=HRCYWRPbL+wIJvAxoWFgEIz5W7uA52swukosDHxowWTXVJ25ZMhryBCMRsHqI2aMFqNZ
	 2gaZjhDhu6Sdd1lbqW231w57me2lMoef8wg6/evfPD3lViMSnxMk4qmuEq2OkddvZOFbO
	 kwWI3RwWCPKqNj+h0n6MdZznlCMsEGm3wkF05WNJ+u/B4ztDqgiKSWSvdrP4W7rUxYXgu
	 2+uFo392x3Rj8ixHGIVtcahlwrwjBmR1PbOmm2lcvaos/gGf3zBDYSrnPvnHbevmETEdt
	 9n8cXMDFoPFKvE4l0180Ea0tsg6j0aSVu+Nm53YhtgBKtdtj/5Y5HFlqjSbf8bs9gjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211781;
	bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tt12DOZRgMZNVQWfHDkifoykvF+ZOd3OZJ1657e+XEQX3yRxGDREIhN+woTlwtEEq
	 /9dV/MyAaLKBKVUIt4ZJv/Xz/H2mnazbEm/P2IBjXYn9y1N9Bfvyx3Ya624ztKGgjN
	 6PFa+4x10hYjBirvVyZVLWunwpAZLaejvGNVpY9PN1ZbEXWzJCVW3nOZfcl+uKryX+
	 YxNU0XlggUt+v3VCxz8cl215Z4ov7vMyVRk01Zt2t7Vmma14jDMXY1ziOibrJ3Y4Tf
	 o9zd5+jH1zdvtIo9O2Tf0KI74YLvO5CEBQFeY9AToxQLNq2Bd02eJPUsz7SVVNvdGd
	 RwWK7FDm0xjLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F129409D7;
	Sat, 17 Oct 2026 04:36:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03A5D105
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9B428165E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m4fV1JUs7xEs for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EB168156F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197335;
 b=CumxVbb4pzM3PSbnPNhUcPsO1GOoHUyitC7B6Wyzo6KkRIcVDa3dzckuy8ruOICO0GII
 Sdu+gQ0vX/bSjxXZKfYcBjTue7825XDU5Fvv8b1SQINJAeeojHX6ddZcFjU5iffxKybWX
 MHxbbou2BJ95m/PHZjTVH0IuDM7VJdvpuJVl22U4mCrek+XQf321guBl8ai3Y9K0iRwhK
 ZYGLFwVa4VRKNP+YERH5dTKC2hwdVFhix5p/0MnH3SXxfQJL4I27JV7QCpiYZhDoIQK8O
 ili6Tlxc4DZMA7ak6ZMnoBwuLs5yU1LgPHpnNfc223KItCRUnFDzkYScbI8SXy7RWQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197335;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=CcyiAiaR0l32buf479cgeZneFa4e80oZHJdMm8fxOuh1ZC7dJr8R9gnya/PBcluKbg0Q
 jMLTI3mpwbfMKTfDMaw3Drttv2qDZOP3G4v9xsaqPXGdyiy5hZ6jGiRHCi0ow77hKhfVg
 qkyks2TTkXuERn/cx2N4BW6VL0wKadqiWg6XD93+bz6xxtA+JYDCr0bZ8g4jEEDLIuDbA
 7koqLFOdcRioVOMM6o8E/dyF089T+d7HnWhBB2p+Ml02RS1Q6tvrV5YEkFvrRT/v+QU4s
 J5+NB1q6VD4eGAFx2Rnwsh5mFcdub81P8d7dNN3O0yMD/+I4iVD9vV3HNERIo5aL2KQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AlH6pQaw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AlH6pQaw
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EB168156F
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:34 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6dd059478dcso317884eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197334; x=1792802134;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=AlH6pQawsKhAqwSSuc7PAEjMJQib70/ppzRlWUTrPuAXIkjzaPB6Ep6SlhI1GHNa33
 e2O/8h+eZO4pPPHgbEjapRQkO9tAyECfTt25XPeyt/XRiO58FJ5SRC1qnTFAQvqOau7K
 mL1X9IYDLreKKcwcA94eIGzsNVRxQDRYWdMYxXuZq5ANDkvHCWVpzZF7R37T0R/frOPW
 RB4GkJmpwB5Y0ZsFBzmbkyqQK0IJmop6MxKJiJ+JLGi64YbusyL4lX/DvQ9V6M5jgYbV
 /S7XnTY8Nad2vRvUimPhUxowZ1aJQdFNbGSJFzuIS5CqQO9VmEhDyitceCJZ6AXFBL33
 ckbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197334; x=1792802134;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=ooXSfbPusSySSLqO5/UFSC9YhiHAag3wTZydmfSrKXyhfJq5TC4PIwZCXj5DskxCGq
 QFQNWUWFWDcRXPswAbX9hHhV5pmSxSDvGL4ZtXsF+GjzTlcB0nr4HesFwHGv3IGRhCXy
 tEHw9lCwI9n08uC8P3uvNhu5jnp1vioc4HONhuQuHg4XU/l2Q8Q+1BU18sKV3t2IjcZ3
 y9NnThP4xpCWghlggasoM+x8vrYRLOSne3Y/JRqCRgHhECFNGGnm4hp4nqev6nwHmKm0
 zYvBUj962KAujUoAsesOqQhwQuhrib/F5KEPDsaxXl2JCkWsgbqiSEgnXUMA3tdm8YJW
 C95Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn3DqhNLsZicMNN5OMZnETRYMJ+5MIn8RptsPs9GBci6dnDzQA91M3P+nm3J57r6UPqdM3Y9s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKiz+A2Q1lbsQ6RI29Y78oT9UI4+cZM2ankjxWwyxloCW+QZf3g
 J/s8462oEVVaqe3abwnkuyKj3pKDu46fyv1ZZvRW7LNCixO2FgEDfHDB
X-Gm-Gg: AYBFou2ZuykPYVGmqJmRrvrAid8KDuuZM2+Hf8MFCUXmD1G9ZC+neYZDvqGN26EzynI
 A03+PuQ03fjE/VShOT0GoHltp0H2CY7s/yjsnngn5UOJ4lCllJoz3Bi9BPK4pPH9gwTgZzQrMfI
 cAMNTseJKEFw49tXWPGsV2T1ovKbKwXoRvLVK2qqgzrRVwGoM4ehek8Hbvv6tZLeF8GeQuZ1jpt
 u3g2x+4WxlJI1DFlbMbZqRxr909cEj9nvjGBxaKlfMLF11PdzULi5gRjTlaa3mE0v8htmEYRHZV
 pYXKza+mAVp0kB8t6PfxguY23VSub3sBDwX3Cvr9w9U4nWfluDRAWxqNjoqEhqFuER/ExLEE7Rw
 9Yf75AhzYweHY4b87tetfUMv4z4U4GuwBRGeLD0/t08E6VK9KT+kVleeSmSXOa9DMfwJwJY4NWs
 xeJ1AK2r8aWJx+yaUVesQR0WAXHFaZxJZeTupIqZUQiTdr5Q/t03YLUE/DxAKnwjPpr++c+cgPv
 hYBLDgOhxG/w1RXvpi8OJwR/UFwo2WxVjPUX80IRK4Fl8nEOa53Eh3bEo1l7anhlaJAUR+bytdb
 V/Nz5tQ9TQ42vQPVkiBXT3iuyB/ou3ZpVQwuSt1+/n633aq1SpGo8wrmhx7mcNvywFZOF7tCL9Z
 2u7Et0RCCgxxRuHqLVEYe7g==
X-Received: by 2002:a05:6820:820:b0:6da:453d:7cd4 with SMTP id
 006d021491bc7-70355c8872cmr917818eaf.23.1792197333621; 
 Fri, 16 Oct 2026 17:35:33 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:15 -0600
Subject: [PATCH v9 01/17] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-1-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
In-Reply-To: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
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

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
  - State that the commands always returned usage
    (suggested by Simon Glass)
  - Add a Fixes tag  (suggested by Simon Glass)
---
 cmd/aes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 3fd83013ffe..edcd87cf11b 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -223,9 +223,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;

-- 
2.53.0

