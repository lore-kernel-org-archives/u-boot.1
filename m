Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663EEC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 21:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E888059A;
	Wed, 23 Apr 2025 23:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AplxkJlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED528059D; Wed, 23 Apr 2025 22:45:01 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1318056A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 22:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3feaedb39e9so91639b6e.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745441097; x=1746045897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJ4kQm62sRcxGFKqRRt2cS1ris+q+1ODzcxFAglbwg0=;
 b=AplxkJlLwZPm5eHcTGRGgcXdWpsxDqhXw8dTLmHrf1zHskkScy+iH8Dq+rT6lnhPgS
 q5HwYbsS2QE2yGyGQ1sw39YgyHFqsQvgtA6kx2BMQVJbSiIqKOzmUFGkGUrMouqwIGHt
 2AWujYzhftUgulnDw3+ajzLLVHfhkF36vAznM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745441097; x=1746045897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJ4kQm62sRcxGFKqRRt2cS1ris+q+1ODzcxFAglbwg0=;
 b=Gf1kwBluzi+pIc4YmT8y3JkNZXPw3dPOGgfkQAFkyGvkRNkRFu+5IQ9nX+CDmH4zhx
 NrAjI4Y26hckSirnEX2OlqByzk3b08dtBkwv++/5Ko75ZH7jIz1OajBtfKZpwGWqbVk6
 2FtTVbTaZxyMlevWNxnOHvXg+XZTvsu98BuXkFqoerjVDrR2MTnChsrpbYkt9xI243xI
 JQO5hN4lowYM4UlUiIknOYiujTdP2eviinOwbKrQaVsPTsXPigWGcXteM4ITWs8ncRwA
 jJzYyQ9yIjKNBHasAKZSVgf3SGcjovWqvBFbxOMNvL8Uwtk69uNKxgI31zM/KlSIxG0p
 yKIw==
X-Gm-Message-State: AOJu0YwUPYiBXDlHVOGi/vU5MLX1TbGlMabiwkr9z7WtgfmFRYhtj8/Y
 cjofGdfIR1YjOmgvWNxajLkAbSy+t98C9D58p34NP6aGMaS9WvidQ1PkK5DIGnA=
X-Gm-Gg: ASbGncvIxRlJfcJtq6jqdA4wrjQi+aakiNMxiEAe0UNuZ7+2SQaAzSPHJOVQakcGay3
 ZuwVbs/AWl5c3xGmYx2pAE0XTW2laItTo2vC0L97NwIdD4+nj5EHOqZK7uMqVCz66V5+6PxnOoZ
 7VaGVREwa79vGfObFQUC5JvV2OE8sJKcOCVOOoPZuFnmjgUP8FVHSOGWSv6gTKve4xoyeDVUZz+
 BQwOYsYabi0GQ9ZFkZeFNLx0fj7S6uBEQve2NrX4ojNMJCHafcG5QvOC7W+eJS+ZdiCWXpsbieP
 YH29i3SFSmANtjLcUFTORJD47uQ8IR9m03owPzFNPyv8i6JWmL7JlqUMpNBOM+hoTFcMKtgh62T
 x
X-Google-Smtp-Source: AGHT+IGV5zp45KUQanYWroRgNtzmCPiFfM8ln24Lm56v77wtop/DtAnwJNteKGbfmDTMX2IqeIdf3A==
X-Received: by 2002:a05:6808:201f:b0:3f6:8c64:8bc8 with SMTP id
 5614622812f47-401eb3b88fcmr205726b6e.38.1745441097428; 
 Wed, 23 Apr 2025 13:44:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beee7540sm2759273b6e.19.2025.04.23.13.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 13:44:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Julius Lehmann <lehmanju@devpi.de>, 
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thomas Chou <thomas@wytron.com.tw>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, Wolfgang Denk <wd@denx.de>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v6 00/17] Uthreads
Message-Id: <174544109416.3953260.846176995816223024.b4-ty@konsulko.com>
Date: Wed, 23 Apr 2025 14:44:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 23 Apr 2025 23:55:09 +0200
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

On Fri, 18 Apr 2025 16:09:28 +0200, Jerome Forissier wrote:

> This series introduces threads and uses them to improve the performance
> of the USB bus scanning code and to implement background jobs in the
> shell via two new commands: 'spawn' and 'wait'.
> 
> The threading framework is called 'uthread' and is inspired from the
> barebox threads [2]. setjmp() and longjmp() are used to save and
> restore contexts, as well as a non-standard extension called initjmp().
> This new function is added in several patches, one for each
> architecture that supports HAVE_SETJMP. A new symbol is defined:
> HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
> scheduling, are added to the lib suite.
> 
> [...]

Applied to u-boot/master, thanks!

[01/17] arch: introduce initjmp() and Kconfig symbol HAVE_INITJMP
        commit: 1c8e166fb5eb5c58b79a09e80660a7ebfc7c94fa
[02/17] arm: add initjmp()
        commit: 0245d2ab7d08cd360d44f131b20aa817799a4394
[03/17] riscv: add initjmp()
        commit: 3691328ef69555148962654e7f834fd0b5273fcb
[04/17] sandbox: add initjmp()
        commit: a27844cc9443341ffe1314ccc4c384a54ad1ae32
[05/17] test: lib: add initjmp() test
        commit: b989f9ed9fe13be2cb168d2d45c235f011104f38
[06/17] uthread: add cooperative multi-tasking interface
        commit: f9384796179abcc7e5796815c79b2137f5f83b12
[07/17] uthread: add uthread_mutex
        commit: b01735b448bfdd39bb0b0f8f28db149d8a088e55
[08/17] cyclic: invoke uthread_schedule() from schedule()
        commit: e831370af5102d8059d4f20d3317e2c39565e9af
[09/17] lib: time: hook uthread_schedule() into udelay()
        commit: 2325621fff219ee3b80641f714545f8b33013c0c
[10/17] test: lib: add uthread test
        commit: 67b1b1ae197f6ab12e2bcf7ab0b995f671779745
[11/17] test: lib: add uthread_mutex test
        commit: dbb22f541a0a34d0e5889a03db180414aac90f9f
[12/17] dm: usb: move bus initialization into new static function usb_init_bus()
        commit: 4634346e3eb8f3f4ea0505f4f0a14182b2ad60f3
[13/17] dm: usb: initialize and scan multiple buses simultaneously with uthread
        commit: 1c0f6999b5589315201ebb5aa659eb6658079b8e
[14/17] cmd: add spawn and wait commands
        commit: ec89a4f7a3cbdfe601a45c110b375e925190f095
[15/17] test: cmd: add test for spawn and wait commands
        commit: 82bbd95fa92e4f3d75c9dbced3e1b07b11241e48
[16/17] MAINTAINERS: add UTHREAD
        commit: 10536ca4f6eb7cb8968001142b2598e03f72f723
[17/17] configs: qemu: enable UTHREAD and CMD_SPAWN in various defconfigs
        commit: 1717f46a1da7f15e749405da2178944c3a76fac0
-- 
Tom


