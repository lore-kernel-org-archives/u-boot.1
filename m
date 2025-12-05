Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0856D3398D
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 16:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5929A84203;
	Fri,  5 Dec 2025 17:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0XnYNX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 054D284227; Fri,  5 Dec 2025 17:27:08 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33B58404A
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 17:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3ec47e4c20eso1625536fac.1
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764952024; x=1765556824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tu8WqrA9hym8RSWqd25gDN9sJChnCFO2kQFpcGYNM8o=;
 b=t0XnYNX+hYo0s2XTquaQYiH0HIk72lk1xdRL2sakF2Cb5bnEcLkqhjLidGk/uiXmXS
 uiM0DZMYHsfp/TooLqpB1yk8EuWgqJspHRd06Kt7oqIt5FiGaNeEW4itL2Y2kdN4qQU5
 Zw0UnlXChGMo62D+glxsNW7sCKwd52Y6W2UXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952024; x=1765556824;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tu8WqrA9hym8RSWqd25gDN9sJChnCFO2kQFpcGYNM8o=;
 b=cX3XUQTvq2b3jxtLzDC1N6yrptBRTGNRFwGHJ8hk+D5JJdw/MjMrtvrK2xgx2TL+ef
 5AI6+XWwkDx5YeTLSJbQ9y2kKV6kI4D9WfRKu95yTbG4a4RRJYeVWDXJb2BUYhhfeiX0
 kDHsBymc9LJKMJfW1raYYeZNxGJGlU+SGgXNjKT1RRaA3G5whocK92bP5e+2ckU/m0rW
 Lv/YbtVEYn2Yfx8XI0xmwHuOEo4XA5Tvp8se0D9osz7yVkyriXNtH3KBoXxV/OVkkRD5
 giVU6krRgep+BoPxVRPgfzS/bBQeh2JcfdUwSr1+DTeHA2HyCPvqr5OFje3ILTHswMfH
 Mvug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtV4ErmIlF1pKWfwQXx7RQiehTn77d6BorjMFWmam3DG1PKdTF+3IS2hIz1r4xBG/DU6QJeSo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyibm30W+qQy5PvUC2EH3Cb6zr/XOUK3YZNY0rLVU5pJmxTT5JI
 Y4jyaRLP3mksNOvRMmj44YUsjwJ95cyQFvWemRZElMZeNns3MBWxhnppSpmr5HwhN5g=
X-Gm-Gg: ASbGnctnECgP2tFoScREjavdzjuYV6Y5QjzQ8f4JfyJnc0VQINHGXbalQEwlNgFHeR3
 5RAIGKFCYgqVNA8H0KKpibi0Vc6gQM2bT344SZvdgHKuxTGzNqdsqCDDsfR9YTtPCXJtKESfOAx
 KMjqdIj9zcYM6I4VZaiQtXVCayHXvuf9hcXxswIXqkkxoZBygxzGYwcjfNlEljxtist+gGij1aM
 adak2Cmf3Shn4g19BIBKmXNO727AuF9U3izlXEzzzgWBvlvcCBDTr3yWwrpgFNN4lLuuQs2k9Bb
 WJj4VoVPd3JJ+DnRgBkLPZ+yCVQJmRWPHcpx7cgR0s3Au+DzkhSxjz8rcL++zYQxLKTWQkEyWwH
 RbNvF4kRivF4oObnGy6g8Vu64iHi77irVCXWSVk3tCmFP7PpFF+cKSExwL8h+ExY6w9CjYLeQXu
 zp0wmVA2BvJmiaE1ABFpT8iAVQKDHm4Lfs74FUeydCd0JvlW3O
X-Google-Smtp-Source: AGHT+IG+Dup+PsTnXQI2ARZfbIpfOrbB+EnELl6DzUSJsrN2Hh9eMJrlqHUUn0u478fdjHR8ota/eA==
X-Received: by 2002:a05:6870:c18c:b0:3d2:c24:30fc with SMTP id
 586e51a60fabf-3f169451704mr6836728fac.48.1764952024442; 
 Fri, 05 Dec 2025 08:27:04 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aaa0fdasm3636773fac.9.2025.12.05.08.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:27:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>, 
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Richard Weinberger <richard@nod.at>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 00/19] test: let UNIT_TEST imply CONSOLE_RECORD
Message-Id: <176495202271.2280840.16157063354156916683.b4-ty@konsulko.com>
Date: Fri, 05 Dec 2025 10:27:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 23 Nov 2025 23:56:52 +0100, Heinrich Schuchardt wrote:

> Many C unit tests are not executed if CONFIG_CONSOLE_RECORD is not set.
> Hence Tom suggested to let UNIT_TEST imply CONSOLE_RECORD.
> 
> The first patch makes the skipped C unit tests visible.
> 
> The rest of the series deals with hidden bugs in our tests.
> 
> [...]

Applied to u-boot/next, thanks!

[01/19] test: Let pytest indicate skipped C unit tests
        commit: c448c933b9c2f55c6eff996fcd281c40e65d6eda
[02/19] test: cmd/bdinfo: consider ARM architecture specific info
        commit: 3144be7f405879964d7a300d869e726ea0426fc5
[03/19] test: print_display_buffer must consider 64bit support
        commit: ae7bcf6067113c3fcb46ad918517f7fb677e74f2
[04/19] test: don't test for CONFIG_UNIT_TEST twice
        commit: 3f8cefc0d4e80aa7bcfb06549f7df6926790a3f7
[05/19] test: print_do_hex_dump test depends on HEXDUMP
        commit: a63bd541d6136d24f5af22830289b57841b6d086
[06/19] test: bdinfo: correct expected X86 arch info
        commit: 728c717268278b6288a46d6016a2836681bbab1f
[07/19] test: cmd_exit_test depends on CONFIG_HUSH_PARSER
        commit: 1acf7ebf501d492c35606e473b2194f793498585
[08/19] test: do not assume memory size 256 MiB in cmd_test_meminfo
        commit: 85713aee969c63a3418f95dad4b47cb6f88b11f4
[09/19] ppce500: increase SYS_MALLOC_F_LEN to 0x800
        commit: 24bf56f36d00bd7c2b46a6dd7e9e7cef5fc15fbd
[10/19] test: the cmd/font test requires the sandbox
        commit: 061cdb247cb41decbc598d301cbb20131948f06b
[11/19] test: correct comments in test/cmd/font.c
        commit: 0978f3287c1b43ebac6f5f1e49fdf07182d55a60
[12/19] test: fix bdinfo_test_all boot_params expectation
        commit: 7dbcc4d806cce156dd9c00f535fb9cb0020b6e87
[13/19] malta: increase SYS_MALLOC_F_LEN and SYS_MALLOC_LEN
        commit: ad7f706ec79628bf20f4511cb803b99b0e1751c3
[14/19] test: consider endianness in print_display_buffer
        commit: 44217491465d95124bd5b11e4b3a781348b47fe8
[15/19] test: fix cmt/msr test
        commit: 6b0997c98c0e7c46e25ff3fc8a7d1142ce71bcbb
[16/19] test: relax cread_test time constraint
        commit: 3338e2e463793425c23acf859438238670a10a11
[17/19] test: cmd/bdinfo: consider PPC architecture specific info
        commit: c2ee1e3c4a7924c621f2852713ece0f17495eb08
[18/19] cmd: fix 'fdt get value'
        commit: 21fbda84b39a64fe74c1e34e4ff6e070a9ba200e
[19/19] test: let UNIT_TEST imply CONSOLE_RECORD
        commit: e3d4ab528693419f809a9dcbbb697a7cd3be7086
-- 
Tom


