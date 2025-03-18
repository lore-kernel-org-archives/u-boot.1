Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA5C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3BF781101;
	Wed, 19 Mar 2025 00:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ltIB0Xgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136438129F; Wed, 19 Mar 2025 00:21:28 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB4E81026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22622ddcc35so6346395ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742340084; x=1742944884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QANfqb9LSTZrTzJfPLRxvuEGyojRa1iDi/b1F81abL0=;
 b=ltIB0XgwW81N3uBvcGUIQMK20CTMQplSks+b4+ic9EqWXDDF6Hfw0C+LmiHmyNWPj2
 OhSUFsRiFPmP9tl2Wte2W1cSYPsSeUVBp3n0bb47Ly820BhIm1aqmRUXK8EnyyVaIv4W
 4kyrLPlAC5RQvtOXbJ2YIu0WDCvmJE7oiQLI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742340084; x=1742944884;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QANfqb9LSTZrTzJfPLRxvuEGyojRa1iDi/b1F81abL0=;
 b=PKH4wdquU8BcBuXl7v2ow1NVLzC8nAsfU9mIHQoUszHvJzS/WZmL0tiZXSz7bU4Xmr
 9pK2s/G5SWJGNCKni4ZsEtNua4s3EbND5/UHjrFpYutr/rvscXrEzUPZuARdrrHl9s/9
 aCyEv1oLxSsxc7Le9xbc/zfQqkZQPJt3/dKp+me8SAqrmdFuhABNZ70VE9yiSjmdIF9I
 c7ugg0jarSs07JM/5rb8EjMHTDmkPrGHqyd/J/HMmv0/D3XhyNrLp4Qjd/ioVKhSsvPu
 AFbrRJ2OflBEwImYMMgsOzbdd64pdXIg40x2c/McGgM9eqw0kwq2IT6vtgRP0LnHYRmO
 /MRg==
X-Gm-Message-State: AOJu0Yweg+9gIGmM6PhpWakHhfsTNaEov6GaKEGS1/O0rzVX5d1es6Er
 gPd3u+ye89RQ0jyUQulDyThTNC/2FdftEBoYhmtL6Gz6tZn0v8pq5Qi3xmsdmTY=
X-Gm-Gg: ASbGnctmBCfN0d73cyZNeO6jwWSP5D6jWCpeFPF3+HAOuUDCoHWhx5lLKkB+tcPkS5k
 mJP0r6MztRHqjPOOyw2+pMXhsmb7Ai+fabp13zZl+Ul8osaIcNiyf/3U7iuAih5fLRdrP1MPG1U
 7SopsnHObxPrbPYfUQ/vUI+HanfEzrKjieHhvtmxrZW1ODKBPvgfRlzs5z++SRMm1Z9Htl2FaPd
 Qp57TvKZ1e+MLatv7Hhx4fakx9YL8AuLfdAYaq5rYHiNWA8CJKWk4wb1puju8223p38raaFjPqD
 Z/T6G6KO2iSrLXfQGvi6TnVF9/xGRfXj1C0MowEjRY7S
X-Google-Smtp-Source: AGHT+IE5Z20aWl4CTWmqvOp1L0ES1ST/sKsETOqLuRrBcCLbt3PDJMOTlJHa2NmJmoJ+K4NCQzBXGQ==
X-Received: by 2002:a17:902:e892:b0:224:910:23f0 with SMTP id
 d9443c01a7336-22649caaa90mr6731185ad.49.1742340084300; 
 Tue, 18 Mar 2025 16:21:24 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371155934asm10558285b3a.56.2025.03.18.16.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:21:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting
 read_all() in extlinux / PXE
Message-Id: <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 17:21:21 -0600
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

On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:

> This series includes some patches related to allowing read_all() to be
> used with the extlinux / PXE bootmeths.
> 
> These patches were split out from the stb4 series, since it will need to
> have additional patches for LWIP, to avoid breaking PXE booting when
> LWIP is used.
> 
> [...]

Applied to u-boot/next, thanks!

[01/29] x86: Make do_zboot_states() static
        commit: 299d24eddfeb18a7576187b3010d5462317335e9
[02/29] x86: Rename zboot_run() to zboot_run_args()
        commit: 95641f4bf98d3c90bfc4ae94515c98c440ffb2e1
[03/29] x86: Drop duplicate definition of zimage_dump()
        commit: 2de073527bb92b47d49366249cd3fdea5016bcaf
[04/29] x86: Move x86 zboot state into struct bootm_info
        commit: 75e85df7963f57e4bb80b3d805ba2295b1843911
[05/29] x86: Rename state to bmi
        commit: 00cfb598e740d8bad79097e7e069ad71d86bbd5a
[06/29] x86: Move the bootm state for zimage into cmd/
        commit: 4e36b1739b03e81ff395959b58fe33e67c4d2233
[07/29] bootstd: Correct display of kernel version
        commit: 1592ff27d502efdc79992f57c07ff0cf81bc9305
[08/29] x86: Drop the unnecessary base_ptr argument to zboot_dump()
        commit: c73da92304280b229e3d8dfd565fae5a24fe3ce8
[09/29] boot: Use strlcpy() in label_boot()
        commit: 0fd3ed1cd73d6b262c204c27cbe6dc1ad1c09e91
[10/29] boot: Split pxe label_boot() into two parts
        commit: ff9fef41fe4d329a5c76746cc45f9fbf8fdb9b12
[11/29] boot: Split pxe label_run_boot() into two parts
        commit: f6aa262f55b78e3a21dd020e47601320c2edec4e
[12/29] boot: Pass just the FDT argument to label_process_fdt()
        commit: 600bc21da54a300f2825a5e3088719b1ffd5ee53
[13/29] bootm: Allow building bootm.c without CONFIG_SYS_BOOTM_LEN
        commit: 7f10a7fe126dce5644d933af693eda40497d7755
[14/29] boot: Convert IMAGE_FORMAT into an enum
        commit: 3c7b13b075488ebcff2923b0a7b46cc11f39285e
[15/29] boot: arm: riscv: sandbox: Add a format for the booti file
        commit: 098407e67390ed0c369029bab0777a51e5a7bad2
[16/29] boot: Support booti format in bootm
        commit: d6bb0ea535e4384ed1975ee9c755488f5036a79e
[17/29] boot: Support compressed booti images in bootm
        commit: ecd50bb4643c9052e5f8b6171ab6c3905ed0ca70
[18/29] boot: pxe: Use bootm_...() functions where possible
        commit: b13408021d361fbae1c254307f139ad1e6def3d2
[19/29] pxe_utils: Simplify default fdt in label_run_boot()
        commit: feb8d7fd749413e889ba2c396654f473ba32034d
[20/29] boot: pxe: Refactor label_run_boot() to avoid cmdline
        commit: e2e87b840162ddf4ec8df3f235be98a74a964509
[21/29] net: Keep the bootstage functions together
        commit: 2c04afbc957d18e61813315a0694db903754a280
[22/29] net: Tidy up the comments to parse_args()
        commit: 3ccbc10cd9e3b28d67fe5008943a648b870db1e6
[23/29] net: Simplify parse_args()
        commit: f1ece5d86e5577ae9bb3325d65ed7003f3cbaf9e
[24/29] net: Return the load address from parse_args()
        commit: 4b6070e056fc2c11b7621c32151f95f7a045ac01
[25/29] net: Return the address and size from parse_addr_size()
        commit: f60421204816bd0aa40e9e43c18d4bc5861d3521
[26/29] net: Return the size from parse_args()
        commit: 25d51d3c798f6e256daa628bb2a9fcc36fde0382
[27/29] net: Refactor part of netboot_common() into a function
        commit: bfffdfaaf6f492865100197a5b141482799afc09
[28/29] net: Drop #ifdef in parse_args()
        commit: f278f0cb4996398720328ce33e057678f6ea4109
[29/29] net: Provide a function to run network operations
        commit: 0f094b8b146679c3980cd2febde4e902bbc4405d
-- 
Tom


