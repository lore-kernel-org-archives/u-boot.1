Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A9CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CD8846A5;
	Fri, 29 May 2026 11:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nqn9qjte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C65D8846B4; Fri, 29 May 2026 11:58:06 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC4CB84671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso1715160466b.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048684; cv=none;
 d=google.com; s=arc-20240605;
 b=EkLLBKExOHoEWeD/lPyDmRfd5JV/rcieGmBynA6b35FSldem8bcr9QtlG1QhWeQKum
 +9k3lclRiucYcCU++Cmyav36Y+GkLdk+HPzbBUXqONIGIZWzD7bhGAvnSC03nVOYeo6g
 4rvtUvabCLfSQLlrOn5h/sxfjtjYuvB5ysXdJwgCSNwMI6zoHwo51qiPvEMaEB3SjIWm
 4IKK0qsozruPWFgFTDynOLDfDW+HvlN7YVsyYzwh3Q6QOoXxPkkP8yVqvyrbfrtoLy40
 9TXaUtoHrKFQKk6oW9Stzfb32Z3CioGvztayd5WAKK3PAcITl8kOr5zxF5dwyDVSq6Y9
 VqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VQy1fsT+B+cPZ/PcY1nbY2siSI3cKosQP/hDTpBa8TU=;
 fh=Pwed0uR+fUcTESmvhLrbsa6n1RHCX2s8IPfo/JJetiI=;
 b=bABInp5yBnYgUwtDiDP/GFz45535LqoPYaLJLYMbuinGYSD/8x86PVxENOIR/hauPQ
 AlXsGDRPc3zJaplY9gVttAGUt5hgH1WBIRoWbJxevuLFjfVp7pNYkCcKfFJxSWu5A1O8
 vlBLyl4C4QBbV/Eg6k4n7Bndbp0JxuQLY7Aat7jCNINRn//STMl8KbZ+1f7LTvCWLWg2
 gCGKXspdFLzXt740xKuM9H4848/S4xdg1avqzjbl7wXiUyZzeGv0EbiXgBX62lVDZ9r/
 sGVpaDsJ96iY4VsvzIqyBVxffA+h4scnpuEyDbQ8e8wDJ4hKXJTPoKkoTWGwbz/n4hMg
 1JJw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048684; x=1780653484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VQy1fsT+B+cPZ/PcY1nbY2siSI3cKosQP/hDTpBa8TU=;
 b=Nqn9qjteaJUHUDesNimyiPzuk34kKvIZ7FQblkJ4OQjjChoTU8yf9YEuihKfWXldYK
 PKUFzUDUFyo8oYsMoqp7nP5IiXJ6OLHGqMo7TfogfuAqkgQKElKxVeDye8sSzWj1hG2T
 5/ITvxbf8KwawmClEmrqFlHUnGdISS+2CqTQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048684; x=1780653484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQy1fsT+B+cPZ/PcY1nbY2siSI3cKosQP/hDTpBa8TU=;
 b=pZEH9W4Z27huxI6i7HDJ++lM97743yvfkJj+yAyuNEEPuobdGqtiKCxs2E3+hQnn1x
 AkADKPJb9u79Do4hWPW2QmYnF3D6bbCePSFrvG+Fk0jQseJCVQS4bEHSiDME2RMdgWfu
 +aacVmoUBMcp9FDAid7G35P4l7t48sopEhmVqIEz2Y93Q9JTlreAHqOi9VXIGITxFrwR
 iuO5dBEfhAwI835/cEygpHkDgSuzD6QO8ljeZYooYHShM6G/ssDSl6jrf+ymnlG1hcR4
 YkICLUWmOwBRzS0a5VnnvS81SjL79UqvNwkkyd42EH3zOpdK0/T/SitkPxg7NoNIBqqu
 bA2g==
X-Gm-Message-State: AOJu0Yz0yECc+oBF9qjeFKZKRh81w12uFKfJfJx9byCg015YULzO0XKD
 RWEF6mKemdSNUDf2wiJMhZ00EeoWB6TSHEZRqFiP0qS9Zx67ozRwDFrvE5Ky+v5niUMoWj9B7mO
 HO3OOatgrcYfVl+Ibe7Y2GqUNWg51pA/1wy0lswrc
X-Gm-Gg: Acq92OEwNhkKF8rhf/J+74W/W9ViJcltyrgjOifmaTs58oOF6u5jrTZIjr04TJyi0xz
 X4cz/jGr6u0tLtDcRihmxwhzLPZVW4Hszot11lAIXpB6Li2c66H0Ud29Q4DEkVVgzXFBLY319Th
 uhFr77otoZDmKvorjnaETXFvLtgr0lIjRy+VvmCCJ6YLzNAQrjKOfHVEykQBuypfOShottLFGFT
 Y+2bfgohQoQHU/5RaukT1Ku1NkIzN3NNVsijDkd3M0X2zmfecGM8xWbFzCaehSQCeI7WS7UkSLJ
 BB5EtVeh8NW9YzzYyK0=
X-Received: by 2002:a17:906:846d:b0:bcf:5de8:567f with SMTP id
 a640c23a62f3a-be9ccd7756fmr96796166b.28.1780048684264; Fri, 29 May 2026
 02:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-5-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-5-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:57:48 -0500
X-Gm-Features: AVHnY4IWRzSC6a_DBAYdyvdDcYn2au7C5dSiYTPUOnuveLS6eh6dNlhYkyy0D9k
Message-ID: <CAFLszTgO6Gbg+TrpSwyTffPVjd5Pv8Pw79eq7RG_gj0W-E2uqg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] cmd: Add flush support for all blk devices
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, sjg@chromium.org, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Denis,

On 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:
> cmd: Add flush support for all blk devices
>
> Introduce flush subcommand for all blk devices to allow committing
> dirty data explicitly to the given block device.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> cmd/blk_common.c | 14 ++++++++++++++
>  cmd/ide.c        |  1 +
>  cmd/nvme.c       |  1 +
>  cmd/pvblock.c    |  1 +
>  cmd/sata.c       |  1 +
>  cmd/scsi.c       |  1 +
>  cmd/usb.c        |  1 +
>  cmd/virtio.c     |  1 +
>  8 files changed, 21 insertions(+)

> diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> @@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
> +             } else if (strncmp(argv[1], 'flush', 5) == 0) {
> +                     struct blk_desc *desc;
> +                     int ret;
> +
> +                     ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
> +                     if (ret)
> +                             return CMD_RET_FAILURE;
> +
> +                     if (blk_dflush(desc)) {
> +                             printf("\nfailed to flush device %s\n", if_name);
> +                             return CMD_RET_FAILURE;
> +                     }
> +
> +                     return CMD_RET_SUCCESS;
> +             }

Please print the return value from blk_dflush() and the device number
in the failure message - otherwise a user can't tell -ENOSYS from a
genuine I/O error. Compare with the erase arm just below which reports
the block count. You can use %dE to get an error string if the board
enables it.

Do you want to print something on success?

It is a bit misleading to suggest that all the commands support
'flush'. But I suppose we can worry about that later.

> diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> @@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
> +             } else if (strncmp(argv[1], 'flush', 5) == 0) {

cmd/blkmap.c also routes through blk_common_cmd(), but dispatches via
U_BOOT_SUBCMD_MKENT() so flush never reaches this function unless you
add a matching subcmd entry. Either add it for consistency or call out
in the commit message that blkmap is intentionally excluded.

Regards,
Simon
