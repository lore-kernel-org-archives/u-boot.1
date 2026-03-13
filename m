Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C776105F781
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 09:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A1F84221;
	Fri, 13 Mar 2026 09:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZ3Q6H4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9426F84227; Fri, 13 Mar 2026 09:59:58 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E65F8420D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 008496012B;
 Fri, 13 Mar 2026 08:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBE2C19421;
 Fri, 13 Mar 2026 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773392394;
 bh=0FcBJ02fSRFeLYvpekvt4G6ydM/BwWShe/BIYfjPsnQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FZ3Q6H4sBxkzNLUXheou9BV1evKiMSBepw7MxwltYgVYTXkZKoETX7TF1rrjRzJ2V
 VNJh+mTKCeyfU22zBFKMT5InZKmsx2iioqD/4PoOUlgv+d+etLDrYBRMTTvxGSY5yv
 LahVkmiwue9iopl9RSqzieTA5bjnunJncHLfEKEEd1q5LHc7FDoGA0I0NCqTYmtZe7
 7tiRA1bV0edW5kEpYxUhyWSsQDxW8P2srpM4XVpagZfEfyARc0c+jy5KRXSKl1qHe8
 J/KAGRk3xq2XEAtUaBJS5qBTxo7yMjEO3JShpxpeNuDFLRXn442S5Mx5Kz8WIRgtYt
 LLyjiV8QZEBYQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dfu: Make the DFU_WRITE_ALT symbol available outside of
 DFU
In-Reply-To: <20260312225819.GC502704@bill-the-cat>
References: <20260310162621.1163932-1-trini@konsulko.com>
 <875x71mn0x.fsf@kernel.org> <20260312225819.GC502704@bill-the-cat>
Date: Fri, 13 Mar 2026 09:59:51 +0100
Message-ID: <87zf4cksu0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

On Thu, Mar 12, 2026 at 16:58, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Mar 12, 2026 at 10:10:06AM +0100, Mattijs Korpershoek wrote:
>> Hi Tom,
>>
>> Thank you for the patch.
>>
>> On Tue, Mar 10, 2026 at 10:26, Tom Rini <trini@konsulko.com> wrote:
>>
>> > The DFU_WRITE_ALT symbol is used both directly and indirectly (via
>> > UPDATE_COMMON) for EFI capsule updates (FIT or raw), but does not depend
>> > on DFU itself. Move this symbol outside of "if DFU" to remove a Kconfig
>> > dependency problem.
>>
>> Looking at drivers/dfu/dfu_alt.c both dfu_write_by_name() and
>> dfu_write_by_alt() seem to rely on functions from drivers/dfu/dfu.c such
>> as dfu_init_env_entities(), dfu_get_entity() and more.
>>
>> Looking at UPDATE_COMMON, I see:
>> config UPDATE_COMMON
>> 	bool
>> 	select DFU_WRITE_ALT
>> 	imply CMD_TFTPBOOT
>>
>> And if we check the code in common/update.c, we can see that
>> dfu_write_by_name() is called.
>>
>> So fit_update() calls
>>    dfu_write_by_name() which calls
>>        dfu_init_env_entities() which might no longer be defined when
>>                                applying this patch.
>>
>> I'm not sure how is this supposed to work. Do we have to stub
>> dfu_init_env_entities() ?
>
> So, to me the challenge is that DFU_TFTP, UPDATE_FIT and UPDATE_TFTP all
> are the three users of UPDATE_COMMON and so DFU_WRITE_ALT. The first two
> depend on DFU, but the latter does not. And there's nothing in-tree
> using it, either (but it does compile I believe, or allyesconfig would
> have failed).

I see, thank you for explaining. I've done some testing on sandbox with
the following diff:

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 280f9c9cfe77..5bc114bad064 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -16,9 +16,6 @@ CONFIG_EFI_SECURE_BOOT=y
 CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_EFI_CAPSULE_AUTHENTICATE=y
-CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_CIPHER=y
@@ -50,6 +47,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_STACKPROTECTOR=y
+CONFIG_UPDATE_TFTP=y
 CONFIG_ANDROID_AB=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_UFETCH=y
@@ -201,7 +199,6 @@ CONFIG_AES_SOFTWARE=y
 CONFIG_DM_DEMO=y
 CONFIG_DM_DEMO_SIMPLE=y
 CONFIG_DM_DEMO_SHAPE=y
-CONFIG_DFU_SF=y
 CONFIG_DMA=y
 CONFIG_DMA_CHANNELS=y
 CONFIG_SANDBOX_DMA=y
@@ -362,7 +359,6 @@ CONFIG_CONSOLE_ROTATION=y
 CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_I2C_EDID=y
-CONFIG_VIDEO_SANDBOX_SDL=y
 CONFIG_VIDEO_BRIDGE=y
 CONFIG_VIDEO_BRIDGE_LVDS_CODEC=y
 CONFIG_VIDEO_DSI_HOST_SANDBOX=y

We indeed have:

$ grep -e CONFIG_DFU -e DFU_TFTP -e UPDATE_FIT -e UPDATE_TFTP .config
CONFIG_UPDATE_TFTP=y
CONFIG_UPDATE_TFTP_CNT_MAX=0
CONFIG_UPDATE_TFTP_MSEC_MAX=100
CONFIG_DFU_WRITE_ALT=y

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> --
> Tom
