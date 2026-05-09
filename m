Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A6DCD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3E884D3A;
	Sat,  9 May 2026 17:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dBySp/fT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC7F84D66; Sat,  9 May 2026 17:29:06 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7148484D31
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso5262566a12.0
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778340544; cv=none;
 d=google.com; s=arc-20240605;
 b=R3OXiB2TyhArKXQgpgoJZA8FDl+YFz1cBJkhPfL6u1NsmvH7tPlccWwYCuBh462Z6r
 nrxvfH5G0/gTCnsbg51ry06bSdJeD/sEOmfyiH3hBzpK5VY9Oc6Axbx1RqNxJWhjmIpv
 7rAy9T2MNIfySSMqgt4PQmO0YOeY9+mE9XzzlThpceDer14W2r6GpMfznXzF6h5/dy0F
 ZvKp0fPgqnGD3zOHj4TCnYtqMv+6RwIn++DlHuz98KXHuQUQ1HwxbYCTnHKBcEG4Q3q0
 0kXi/4caAUMH9ft5BOymKqtTbQOmmF/PGTWU1GZByiqrfyowLS2uD6Q8CeVMs1Wijs7A
 n+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=93tNbaLh2S+7JWH3jOUx0vbdzOeCxJYRa7Rnopt9sG8=;
 fh=htjQbP2lD6GOT1Am/KTDz2aa032ZcpU+hC1nZGPJ2M8=;
 b=V37SWcU3gXalO+LakJ1Nk26hKSzGpvqdUlzkLSY+w8N6cxr0YVlL+Lv98Ym/BRPhVj
 B6Tp47/jrMD0gYE7ndMSI4zHue2Z/3f3l1DKffxmabopERq9gLk4+4+ERxSko/RU92DY
 7+oTPjATb9lup8LVW7y13zLK0YjVX5ndDYt91CVMArVnJa/gi8m8EmAhpcp8ephGJndA
 n5+YsROzScW3Pzn1AgEpNdHfJc/XeiLJj356iZmVcwHjxRJkc1+DIUpCsMUW9koiXA40
 m4xkszoo+kIzjcVmTgksJ0G6Op1+iLh4eNWoPBnrcKbwBoCcv+aeiiW2cyrbUS/2id6S
 RK+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778340544; x=1778945344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=93tNbaLh2S+7JWH3jOUx0vbdzOeCxJYRa7Rnopt9sG8=;
 b=dBySp/fTWKqG+4K4uFl2a19/Pf8EyCrYjjVionDL2B8vp306UqPGKR5MSPPwT+k9va
 AQFSFtZ89MkZg4ZpHI42oJDRWpuuO206v8aRZsAZP3fDw0EMRHlu6kAULAYhGrFVD0u9
 xhJ6a8Md2Wja4b4ZV0Y+E7/tGWCFVqZATiWM2nmZ05aTRj8AN5k/RiguasWXMbnNilTa
 LIYxCX52EgeGXw9Kv0po9yduCalQ7RuXaqAOJXtOw7ECB+OxqO8dkaq3ajCXxgsEUESv
 HfQr82nl8V84WigaIeY1sJUn/t74Xl96GrLL+9Lm7Z9AYViiMLsnEUAn/+kaemHmurLI
 p2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340544; x=1778945344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93tNbaLh2S+7JWH3jOUx0vbdzOeCxJYRa7Rnopt9sG8=;
 b=lfV9eylUUvpFQWkDvAAvaTmUJk6/WGGcmWC3pr6eZHf/Fq+9f6Cla02FPpaNh1KSfg
 ixFtd9jQCvM7lWiJXn3OikljzfZiU24F2IGQyAGhR3w46TyDHEEiREKZu7Gi16ZhhfY9
 4gThMNlrHK1r+i8C8UrIeC1FfB+AKgzQjeFH6uPR25yAxgYBPEgV/kft+0694DzJCOe3
 NxHk5QQumAtEmGfMW6WBqArojjI3y4ymBDjPpL8sxFTvwn4ZXYzWbBgbDyffmon5RkVA
 Bo2ASeoFPzkSa50WbCLv4gy6TeV1U8A9bkGjRmckK4lCjLNp7JG+npfxZQfBLn+rVxCx
 lomQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l4n8899DJn0JBKY4pUfEQRk94Ni2bZC72H67wrc87ue+c+yQhlGE3cvM5SVNzoVm1gP1ygaU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk/7x9L4sXYp9AT/wPc2Egh4TpxD8COPEkrV+iKlUOf0lGpwdG
 MVVShK2tGuT8Pnc1o+yMiZ5+ge5A/l+nLkkzDa+lsZ1R66GpO3dOgkGtn56ChLDUfTWyiHYqc3d
 MUdzWLYO7Kvc+zd5rClC+Vmsph+l+aOs=
X-Gm-Gg: Acq92OG88fpFpZ8ymkr3V0k9bcExM7tSIjGujFfRCD0WjtWjvtq3KfVFNRaJYaCJNpk
 s2wzPkA4fihu7qigD+9qvw6XyjuWhauItD1pKD4WsXvrnqpJPT0XgVoPQQj+OzoFxDGgJuCd98r
 GU0CS8/F0H6DIj8tPjUGgODXpeNfWH3ERzte/juQAJYvmfq5CuT1yiga6xa5AYcGdh5IcxzD1B7
 Z+ir9UboAcVDN++MW7ouw8Tsz291TOpZU2vLS/YPFyso6mBEgBInmpkWYCkS9S4bK5LqekD26Iq
 +ltqsdqHwEMTNv4zY9chR6NvbReq7lxVoyV+LhFC9fOeto8PCEONseckYTqqAATIlRsWYl3lA+f
 SWV/0TXwvwzvfqIpzcaH1pqsUKYhOIiH+4JMi73/D/PrTM5N8oBvC1jlNRkjPvgrnpVxk+6yHLs
 1p
X-Received: by 2002:a05:6402:5214:b0:670:8b48:182a with SMTP id
 4fb4d7f45d1cf-67d63d7ef22mr8828010a12.4.1778340543504; Sat, 09 May 2026
 08:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154245.0E24868BFE@verein.lst.de>
In-Reply-To: <20260508154245.0E24868BFE@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 9 May 2026 16:28:52 +0100
X-Gm-Features: AVHnY4KmugzfEIh6ZEq70c2axScYmf5_dlRXvoFMUln7XaLNYY-P_dQCpS1CKyY
Message-ID: <CALeDE9N6Gi+Jmr9DhtfQA_m-e3t-i-QDK4nuGeW-0Hs0RDXGyA@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: Fix missing address translation for PCIe
 inbound access
To: Torsten Duwe <duwe@lst.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 u-boot@lists.denx.de
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

On Fri, 8 May 2026 at 16:42, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Torsten Duwe <duwe@suse.de>
>
> U-Boot currently does not account for PCIe bridges with a non-zero
> inbound access offset when talking NVMe, it only works on platforms
> where this offset happens to be zero.
>
> This patch enhances the NVMe driver with the ability to also handle
> these cases.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

>
> ---
>  drivers/nvme/nvme.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2b14437f69c..99a47bf25f2 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -12,6 +12,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <memalign.h>
> +#include <phys2bus.h>
>  #include <time.h>
>  #include <dm/device-internal.h>
>  #include <linux/compat.h>
> @@ -27,6 +28,13 @@
>  #define IO_TIMEOUT             30
>  #define MAX_PRP_POOL           512
>
> +/*
> + * Convert a memory address to the value needed by the PCI device to
> + * access the given location, taking into account inbound window
> + * translations of PCI bridges:
> + */
> +#define DEV_ADDR(a)            dev_phys_to_bus(dev->udev, (a))
> +
>  static int nvme_wait_csts(struct nvme_dev *dev, u32 mask, u32 val)
>  {
>         int timeout;
> @@ -91,12 +99,12 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
>         i = 0;
>         while (nprps) {
>                 if ((i == (prps_per_page - 1)) && nprps > 1) {
> -                       *(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
> -                                       page_size);
> +                       *(prp_pool + i) = cpu_to_le64(DEV_ADDR((ulong)prp_pool +
> +                                                               page_size));
>                         i = 0;
>                         prp_pool += page_size;
>                 }
> -               *(prp_pool + i++) = cpu_to_le64(dma_addr);
> +               *(prp_pool + i++) = cpu_to_le64(DEV_ADDR(dma_addr));
>                 dma_addr += page_size;
>                 nprps--;
>         }
> @@ -393,8 +401,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>         dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>
>         writel(aqa, &dev->bar->aqa);
> -       nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
> -       nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
> +       nvme_writeq(DEV_ADDR((ulong)nvmeq->sq_cmds), &dev->bar->asq);
> +       nvme_writeq(DEV_ADDR((ulong)nvmeq->cqes), &dev->bar->acq);
>
>         result = nvme_enable_ctrl(dev);
>         if (result)
> @@ -420,7 +428,7 @@ static int nvme_alloc_cq(struct nvme_dev *dev, u16 qid,
>
>         memset(&c, 0, sizeof(c));
>         c.create_cq.opcode = nvme_admin_create_cq;
> -       c.create_cq.prp1 = cpu_to_le64((ulong)nvmeq->cqes);
> +       c.create_cq.prp1 = cpu_to_le64(DEV_ADDR((ulong)nvmeq->cqes));
>         c.create_cq.cqid = cpu_to_le16(qid);
>         c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>         c.create_cq.cq_flags = cpu_to_le16(flags);
> @@ -437,7 +445,7 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
>
>         memset(&c, 0, sizeof(c));
>         c.create_sq.opcode = nvme_admin_create_sq;
> -       c.create_sq.prp1 = cpu_to_le64((ulong)nvmeq->sq_cmds);
> +       c.create_sq.prp1 = cpu_to_le64(DEV_ADDR((ulong)nvmeq->sq_cmds));
>         c.create_sq.sqid = cpu_to_le16(qid);
>         c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
>         c.create_sq.sq_flags = cpu_to_le16(flags);
> @@ -458,14 +466,14 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
>         memset(&c, 0, sizeof(c));
>         c.identify.opcode = nvme_admin_identify;
>         c.identify.nsid = cpu_to_le32(nsid);
> -       c.identify.prp1 = cpu_to_le64(dma_addr);
> +       c.identify.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>
>         length -= (page_size - offset);
>         if (length <= 0) {
>                 c.identify.prp2 = 0;
>         } else {
>                 dma_addr += (page_size - offset);
> -               c.identify.prp2 = cpu_to_le64(dma_addr);
> +               c.identify.prp2 = cpu_to_le64(DEV_ADDR(dma_addr));
>         }
>
>         c.identify.cns = cpu_to_le32(cns);
> @@ -490,7 +498,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
>         memset(&c, 0, sizeof(c));
>         c.features.opcode = nvme_admin_get_features;
>         c.features.nsid = cpu_to_le32(nsid);
> -       c.features.prp1 = cpu_to_le64(dma_addr);
> +       c.features.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>         c.features.fid = cpu_to_le32(fid);
>
>         ret = nvme_submit_admin_cmd(dev, &c, result);
> @@ -516,7 +524,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
>
>         memset(&c, 0, sizeof(c));
>         c.features.opcode = nvme_admin_set_features;
> -       c.features.prp1 = cpu_to_le64(dma_addr);
> +       c.features.prp1 = cpu_to_le64(DEV_ADDR(dma_addr));
>         c.features.fid = cpu_to_le32(fid);
>         c.features.dword11 = cpu_to_le32(dword11);
>
> @@ -785,8 +793,8 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
>                 c.rw.slba = cpu_to_le64(slba);
>                 slba += lbas;
>                 c.rw.length = cpu_to_le16(lbas - 1);
> -               c.rw.prp1 = cpu_to_le64(temp_buffer);
> -               c.rw.prp2 = cpu_to_le64(prp2);
> +               c.rw.prp1 = cpu_to_le64(DEV_ADDR(temp_buffer));
> +               c.rw.prp2 = cpu_to_le64(DEV_ADDR(prp2));
>                 status = nvme_submit_sync_cmd(dev->queues[NVME_IO_Q],
>                                 &c, NULL, IO_TIMEOUT);
>                 if (status)
> --
> 2.54.0
>
