Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD91090233
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C7B83FC0;
	Thu, 19 Mar 2026 15:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FR2pGdOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B8983DC9; Thu, 19 Mar 2026 14:52:09 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7149383DC9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7e55fdddfso227660a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773928325; x=1774533125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mC5PUZ9xJa25iZqkL7+HvuxsFoS7UZOQqqhfOyVK5+Q=;
 b=FR2pGdOc6gHo98Rcsx+bPeao2RPVEZiXyNS3kk+FrOzwp9eARlfHPPEANOZZkegzaB
 hOGBExL5XDz6BMjnBFrlYgX2/yGSAFQdcc1849NejBygMjypv538+twkclbsK5ugrX+l
 6RAuuL+uZEct1Wxm6qzJz7LImGbwj4tTPm+p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928325; x=1774533125;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mC5PUZ9xJa25iZqkL7+HvuxsFoS7UZOQqqhfOyVK5+Q=;
 b=QS8nKC4ydbyls75tN/sQ7yLWyhrfYlo6IO78mNjV4l1bLlCFFL3+7dE8+wVJTShP1R
 OnWsf1YEIiToyPA8GtWMYlvF+PKhbBG1JKq2nclpfppKvW/MBBxwpJXKqwDdp4E4UU2/
 sPJmdQk4SKqimf7dTX6in6/av6qB/x5fd0cH75Ylo1gyiKop7D5KefDKIuQxLA5U6rtw
 hbdvwFzlJ5BhThEAMGnJti12QJTz33saBe6NO5dyLt0EDrktx32VNOgoc7FTj+3WkMnB
 /0tFsdpBLm7p6h7YDvMd6OdeFDDtUlMFhYGBFXkaaSalaTbBkHBB21gyowQB85aSgUK5
 0QsA==
X-Gm-Message-State: AOJu0YzpplB/5H9yVsG5mD5rvJ2c3p8yFwFoTEXlXgSW0RTPMavgMmhD
 mtlynNRk2TBIqejBRfIJ1TKlFOiGswx7HTU+7QimBXjdGkfURPjPWASEnvHz1ePzJnA=
X-Gm-Gg: ATEYQzzw6Ogr92nx0evFq3WE0Op3hep+kwLqrebuyN5R1AORQEQ0b63Q6MI7lpibUSM
 oUNz9pi+1WIBWNnpDw/4azxvnOVg2bG9pcMKJyx8hxWm9Z+jwrSrHWgNyh81pCYhqLEoCIXazEe
 jnM41eber/fH7NGMcVvN7wB2sYWHqSmo98WQW4BVUgVkatOm1mcqCfMJvkUlfABS060jhCB+0E8
 vesMUZc/EuJwel5nPhmCapa9ud9ZMD3XK7YrzgdCeRQoLx9yM18m4D5VjiFBgOV1zD5vr1G5PLZ
 qDL+nttNd3eYJ2pwjJgUEYN9czkNZ8E8PpxFHIG9p/hVeatGQxUbSVl9msqWgRXoQ7s7twJVlvZ
 4Xs/0w79puinjyzgAj2nrPs1Uf9ozzsrMLGgczeoBLmbedazJog00fXhtPMt8Mr6spZmOiG1J9j
 HjwkP3l8Yy7T9kr7PGih3SxnOD43+eo/vvMqbpuodbM9LTAHcYCpOqY6Cl5HkG3cydtdUz507Zy
 GD7cDA89g4bPIyCw0v3h8J4+T9HLjWhEOaySimKLAHKN+w=
X-Received: by 2002:a05:6830:4986:b0:7d7:da43:387 with SMTP id
 46e09a7af769-7d7da430437mr2941681a34.16.1773928324984; 
 Thu, 19 Mar 2026 06:52:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9952114sm4536778a34.3.2026.03.19.06.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:52:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Angelo Dureghello <angelo@sysam.it>, Aristo Chen <jj251510319013@gmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>, 
 Scott McNutt <smcnutt@psyent.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Thomas Chou <thomas@wytron.com.tw>, 
 Vishnu Singh <v-singh1@ti.com>, Wolfgang Denk <wd@denx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>, 
 uboot-snps-arc@synopsys.com, Michal Simek <michal.simek@amd.com>
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
Subject: Re: [PATCH v4 00/17] bootm: Clean up arch-specific, pre-OS
 clean-up
Message-Id: <177392832249.1606269.9429399152918005381.b4-ty@konsulko.com>
Date: Thu, 19 Mar 2026 07:52:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 19 Mar 2026 15:18:37 +0100
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

On Thu, 05 Mar 2026 19:36:09 -0700, Simon Glass wrote:

> Each arch does something slightly different before booting the OS. Some
> archs even do different things depending on the CPU type.
> 
> It is quite hard to know what actually happens in the final milliseconds
> before the OS boot.
> 
> This series attempts to start cleaning up U-Boot in this area.
> 
> [...]

Applied to u-boot/next, thanks!

[01/17] dm: Move flags_remove() check before child removal
        commit: 714dd2252dacfaabf0a72b31b9b7e22a8d816460
[02/17] dm: Remove children when parent is removed by flags
        commit: 3632b5d63c8099c59c936c3653ece5bd04d8f6c7
[03/17] bootstage: Add some missing dummy functions
        commit: 5cc969caf0ba247d8464af1fd87110e73309e37d
[04/17] bootm: Create bootm_final() for pre-boot cleanup
        commit: 1ec3ee670de6b2f8f96cd7c15f7e22e89a06bb2d
[05/17] x86: Call bootm_final()
        commit: 8240a482290960e49a7c2a537b7100120ef4ec20
[06/17] riscv: Call bootm_final()
        commit: aa5ada5447369849c82310073270ed64df1efd9b
[07/17] bootm: Stash bootstage data in bootm_final()
        commit: 5759155b023e93c24268911a8a40110ec4b13dd9
[08/17] arm: Call bootm_final()
        commit: ba992d3eacd0a3ac72ff83a022a5c545bb609e76
[09/17] arc: Call bootm_final()
        commit: 47545a6411da58eb865561a4d026da55781d60ef
[10/17] microblaze: Call bootm_final()
        commit: b8806785c15fa0c5541f9fded66644fbcbcddfc8
[11/17] mips: Call bootm_final()
        commit: 96216ef50701f8219610d0b0cfdb26624ef13baa
[12/17] powerpc: Call bootm_final()
        commit: 15e58f975aa42ffbc9170ac226cc480962c6df59
[13/17] m68k: Call bootm_final()
        commit: 3b4bd773e093e777d35f2d951d1868de1a3cc2f3
[14/17] nios2: Call bootm_final()
        commit: 81334489c0f3e3982c46e9ff5986097d43adaec9
[15/17] sh: Call bootm_final()
        commit: 7fec6d005bdb55e27f1de3d6784dfe8815691bd4
[16/17] xtensa: Call bootm_final()
        commit: 9c4edbddce767fae54a4ba1519cc15e55dd198ec
[17/17] sandbox: Call bootm_final()
        commit: dc88ac7681084b2aff8c3c4e1bb3e861451489a3
-- 
Tom


