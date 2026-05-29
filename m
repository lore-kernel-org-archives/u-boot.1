Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8F4CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DAA84671;
	Fri, 29 May 2026 11:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C1vsC3nj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31658846A3; Fri, 29 May 2026 11:57:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73D7844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so2356729166b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048617; cv=none;
 d=google.com; s=arc-20240605;
 b=lbe5edH5qlffeLHHLA7OyHMlpij48ftXfeqkbXiSWaXQvbp8+8zKZ/zci6iH56ToOb
 sUMvZx1w1YwmwY/Lz5M/mvVOWzUg3WG0N6P+8iC7EY2t7Rv4rf5wvJqC3q3ysfYfhnhY
 PfeLkqLMO5cbuHs+Z1XRCPWkKAAjy9OUmjw5ipcYWsxdn2TsUXSxEDZJ8Z74990+3my6
 U8BqsICotFGyF6FOH8AHew7o8apBnYbMcSGoAl3z2TLPlGnrqEa32Ru+xaKl6gc0AQl2
 jRci/YDnxqoQHMSFEAWGddLTfIanyXBTaivjMEAdNQ0M1YIuywB7HEWZwCcNmcl9l/Jm
 jWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OP5xx87/8Pa09DmBZebq5ApvxdzlM2a/GhFOkpzxAmA=;
 fh=Pwed0uR+fUcTESmvhLrbsa6n1RHCX2s8IPfo/JJetiI=;
 b=Ir/5HRnLIVvBn6P0m6o9lemKxGFlhFbQkpjfINo+XxDudTrthPk+rAIoK4CZiByDK0
 Wv5vtQY/JbbOsI7DVnK963igc948kDB53k2Er2LINX6GsJJ9hYZhIP0n/ZsHbh4wnfK8
 X1yODQpyYEeSSKBgtkUAfTbghLb6QatDWaZMD2OR9sFXVzkHjaO1GD42Tg99LuvhAxE/
 3xGmOB4GXvScj/ieDKf/EqITaAJl9oLI9S/baSqtrpqJygBzMqYbF9Jlgm2yrKjjTaA+
 e5WJNjwmbKb19zcWlqlw/LSjSws6ahQq91tHO0FcqokCebOnZRrENHfsncPh49y+Rqzn
 YPBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048617; x=1780653417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OP5xx87/8Pa09DmBZebq5ApvxdzlM2a/GhFOkpzxAmA=;
 b=C1vsC3njaJRrRgjHYp68KTG80JmuBEguYSpTWuw2LRP856gLlLHv8NZ69jawp4K6JH
 9yLLXifcLwzvZ/KfnKUcJHEnow3rwlZm7d1ivLSFl6bJD144yOsDPS+4N8QvWUFoVmc+
 S9VwScB+mrfsq5vyu1p9n7c4vH0ZUBEEMqxC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048617; x=1780653417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OP5xx87/8Pa09DmBZebq5ApvxdzlM2a/GhFOkpzxAmA=;
 b=WBL8VaBAEF9QnSL5CLuY53tYXzREH7bL5i7izmrLvCRuzoi71yoEGcg4pvD6BrMI01
 kncPZtygs7agrnoNSYoUwcuy31VEqIlizsGENXyjTtBBGI+b/BZo+nXb7IskOMpli2zj
 V9pow5ttCtnLc4B7TQoAhW6jEu4Z8q7BluITN4lRtSc6KfzThbdID0WXqZOP0yiyMHkz
 fiPiy+OsVHLPXWBdXxxFRGXAC8f08TB33rCCSoWuHMgYF7mUYROusWwTMH2lPwg9Ftys
 BLwNmskzPiFHgC2e9R8MkhWd1JCsIyBL/KqTPBkTgIj0r49zU6FowtSVU/1Gfc5tVjR6
 psWQ==
X-Gm-Message-State: AOJu0Yz1Kw4rVzEUXmgf61u0ruiNNRtjOmhf4Odo4CrWFfaHs4vMhpGD
 U0qvYD5MaCGKYNY1ehkQb5fw5IcZ6a0T32TRP5K32pHgp9Vf+PCeX74EeX2jzKJFpn55W74CzN1
 olErDs+zrhRVJ0KxVBrzqMDb6rI9ZKDNlIRKBYxi/
X-Gm-Gg: Acq92OFO7Qqd4yv/J/LmV+fVBaSMl9BePvW/FSFFD3wIbX2sZlWxw0oHe04KngWot+K
 f+fpR5E2A1Z+Obdk6sUFjYL4bwLpyTpwKCQQwSr2se54HNMatPthXdz+jmi5qR66gZHuEtfIUUb
 HWx6NVmCdNSWr8gmnzLCQ9wfV6/rq0vZz869tcXIlHGNHpSto6jDFpxpgE1sYi4/tv0VURQM3Ws
 z5j38UdH0eFO5QusmSdfdBggCPrUwK3Fpvl5mJNY4q1SncRi704E2cCx4Qity/XiB0QC9i6iG35
 hrcKB6UCI24AYRamv5U=
X-Received: by 2002:a17:907:7843:b0:bea:2fbc:4ef5 with SMTP id
 a640c23a62f3a-bea2fbc59f7mr29714966b.44.1780048616713; Fri, 29 May 2026
 02:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-2-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:56:43 -0500
X-Gm-Features: AVHnY4KgFTATQ_0xF_AnZdXFB8z5X_rrdv8TihoEHyHpDEL7kmHgzz5SmjJbo6w
Message-ID: <CAFLszTh7VqeoO9TLXtwUeomM==WZoL+cdx+7qXGY+ZeGhBoxOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drivers: nvme: Log I/O timeouts
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
> drivers: nvme: Log I/O timeouts
>
> Current code silently swallows any timed-out commands scheduled
> to NVMe. Log those to be able to debug any potential problems with
> the NVMe hardware/firmware.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> drivers/nvme/nvme.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> @@ -179,8 +179,10 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
>               if ((status & 0x01) == phase)
>                       break;
>               if (timeout_us > 0 && (timer_get_us() - start_time)
> -                 >= timeout_us)
> +                 >= timeout_us) {
> +                     pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);
> +                     return -ETIMEDOUT;
> +             }

Reviewed-by: Simon Glass <sjg@chromium.org>

A few suggestions:

- command_id is just an incrementing sequence (see nvme_get_cmd_id()),
so on its own it tells you very little. How about logging
cmd->common.opcode as well - that identifies the command type and is
the useful bit for debugging.

- With multiple NVMe controllers this message won't say which one
stalled. Since nvmeq->dev->udev is to hand, dev_warn() would be more
informative than pr_warn(), and would drop the need for the 'nvme: '
prefix. Or you could use log_warning() and print out what you want

- The new line is ~85 columns; please wrap it.

Regards,
Simon
