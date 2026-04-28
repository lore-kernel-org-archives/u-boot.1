Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E9FF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 05:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202B784106;
	Tue, 28 Apr 2026 07:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pAjR3PGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5126E84150; Tue, 28 Apr 2026 07:16:07 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD1983BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so3930853fac.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 22:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777353364; cv=none;
 d=google.com; s=arc-20240605;
 b=RrEcvOihSfU6eCZlqOYR1khxe3DKKOcfh2C4O9KbUAvtfGYTM4RiGuIZSeWEDu+HvD
 BYScSyPOKCYqWUW8cUubYqSQeTWfkZIORr2XfvyBeC7DtyceXPdWh/klDbDSV4H0LbLe
 LHH1OdAr90mjCrtozRpRUd/4Wv/rPmaNslvjFlLn1du3BVgKZFnJeB9N6cMIW29XyXUx
 PTdBWJsANX7DOvFew6PysnKmveMEE+nracbZm3CECjNhq9tbxFv3lMUO6ER3/VhpxWmU
 LXCujVE7pu0mJium0ELSI7eaW7haWSo+qw/llaXjMqUpeXfFgaUD47mcXClLlXXSmML2
 hx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ojATx/eUP5fuiKZeOuUTTcXBj8c5IZqTJVfzQrd69+o=;
 fh=QMZdvVsxvWCHNNEpcAbJd4pzxODbhoOY9yjXiTqL0Z0=;
 b=T5Wft8xzugctZgzTIDadBBZ8iJXegio3bTEDTD7J1i2jJzk9QRAsvWphwUAfJpKv3L
 +n7mBcqv34/MVjAV0Epo9CrIzidVI5C4CtgP3b/MJqhFdVTfUtMBkmO/2ZxbU3nGd4dW
 kDI/EPR/G+cmP9q0zYPL2mExP1BpX8Zv2etW8nv6dzIBIkL45ETkwni2/nr1hO53UPrt
 hBJYKiv2HMwsLYHEgLQSpK/kaxb4AaSgmUYNPDxsCkghZf3DUGdgm1xoymwD+QhghAIT
 cw5A3TEhyCOfZ3GgSqu+sZ+XkxCYYc9v+wlGKpR6pnku7R9IQkIzcJzYm6IJmVGqiYGI
 I0xA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777353364; x=1777958164; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojATx/eUP5fuiKZeOuUTTcXBj8c5IZqTJVfzQrd69+o=;
 b=pAjR3PGT3gPtiQ1c+UqGjk/Hy39RuH/+RPBgZmeqyRadfLZptQ9QLelw8p1sTJ1Nwp
 +mOvaiA/tNtW5AQ74gs6HbaA3ktGsxLmCLDcbr5ZS1w7rxTgGCnWd9HkRfr4QD9yfny3
 APPKz2h8TdTXbLwrQzzzy5dWds5fM16nuSsK35ZTmYzXza5hu/H+H/X9qXmPl16j6ZUS
 xx1OEH5clQcTdFvIibqKj3xI08DhDVWpNf0nQKpi0byiaEy/CYXgl1lzuRxpAG2/ZQ8s
 KJPzd9moxNseCC6/zLakwQNKgkJ23gLrUJuQPwALwVzMHtMOFraeX/aHMvv1X+WnpYek
 uDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777353364; x=1777958164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ojATx/eUP5fuiKZeOuUTTcXBj8c5IZqTJVfzQrd69+o=;
 b=lq1uYEwV7bxCoXStM3ys+GVzEI5Cd8ss798yhbEYPwU85bTLLl+Svv8+fGkmvYYJoY
 9bB7Uj4pdoc863CyvxJ2HT40ve2LGoHtS1bXEstBe06LxuFeTfm4iu12E1dzKqVTM9om
 TNC1qScukGy7KsS+9fPBwbdKVFx+hcsXjP/XyXgUt/l6I6sbu9gfTzzhOQFy/1UlI76i
 Y1fHgHGxLMDpA0D92AJ/MyjH+4EIcIIIRQIdHnQ94nwp1/9K09omUwRFBcEEziDdcxpP
 YKsBWZQAWZ8KmX4ojQLboI/TgtB6mXb7pBXkJhdEqHMojcpk3M0BTbCEabLTn5RpdLt3
 WUJA==
X-Gm-Message-State: AOJu0YyYakoN6TwefbPZ45v3ziy12qGndUJHtKYKySEgnnCCHYle4p68
 S35kdFBV/kb1uO7L6XeM3YTIq50O4c9K9z5u5QEhdqr68wxsOcNX0MFPJn56R2Wq/M8XeI19fg5
 rDWS0LEBzThV8E0pk4m78ocib4V5uJvM=
X-Gm-Gg: AeBDiet1T2EzTFIU72Gh160mF7WUsbA45SCOiUR3sMRF4L81NBSzFpXtT09DT01Ub8m
 1tw3YvJRdDxdKcmdQgSP5OIWA3YCOYQM3lxnjDZJ2Fhry4YCbDOsqq5TSJYQYwB96iiyWtwiLPc
 LrKR7ucgBRy3v48YckIqEhQKPLwOJgA5mb96a5jEMXoFQMlADtLLvwFaAgW9VIAFMgXVDCmTegT
 3X+YEGCb9i2CpDxt6T7Uc6d9ilpHauIG9gH2w3BstQfRf3KbYLForel/BC0EQ3MDDW4z+wO/Wxv
 Yk/QiT0cqcVDfcnHxlk=
X-Received: by 2002:a05:6871:50cb:b0:42c:dea:d370 with SMTP id
 586e51a60fabf-433f38dd398mr635722fac.12.1777353363890; Mon, 27 Apr 2026
 22:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-3-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260428033230.7777-3-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 28 Apr 2026 13:15:52 +0800
X-Gm-Features: AVHnY4LkBR7It9pKgpOjOK0yibMW8QD7s8q6VcwMBO1EIYHOYERGKXqXPvXNowc
Message-ID: <CAN7C2SBfT34ZZ28rv4c1Uh2mkM6+_ed6944X8-BVg76jdmFxmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ddr: altera: gen5: Add DRAM size checking
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 28, 2026 at 11:32=E2=80=AFAM <alif.zakuan.yuslaimi@altera.com> =
wrote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>
> Trigger hang if DRAM size from device tree is greater than actual hardwar=
e.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>
> get_ram_size() uses size from device tree. So, it has consistency with
> other device families.
>
> New Kconfig is introduced to enable this implementation only on the defau=
lt
> CycloneV board as this will increase the SPL size which will exceed some
> Gen5 devices' SPL size limit.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/Kconfig   |  9 +++++++++
>  drivers/ddr/altera/sdram_gen5.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

For GEN5 cyclone V:
Custom board
512x16 DDR3 die x 3
ECC supported to max Cyclone V allowed
No boot issue on soft / hard reset

log:
U-Boot SPL 2026.07-rc1-dirty (Apr 28 2026 - 13:09:08 +0800)
DDRCAL: Scrubbing ECC RAM (2048 MiB).
DDRCAL: SDRAM-ECC initialized success with 1057 ms
Trying to boot from MMC1


U-Boot 2026.07-rc1-dirty (Apr 28 2026 - 13:09:08 +0800)

Tested-by: Brian Sune <briansune@gmail.com>
