Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72636C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C645605FC;
	Sun, 27 Sep 2026 15:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PS21W-_JD9Na; Sun, 27 Sep 2026 15:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6A1B960604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521646;
	b=XYjS5oCM9N6JQZJuXV0AFOCIlOXZpsfUPaRMZ/DGkPzEJ0PcorRwpwEnwtipXwuxdNe/
	 cmWrJWmuhef/1l9DjPaZp89wu6n2PBPMs0ZR/Dbppy7io21kTLJNb01vz0y1wQvVksF+U
	 9jWMgUv+QWMl7fcAdhOnU9sQfyHqSfJ88eGWYRa7WDXZjNxGx0OdmCH+bWCsucSTKCZ4Z
	 ug08ekwtDFPOqyMFPIdq7GiSpsYzzspnWHV63TIyd5fEs5fYxzl9ug510N2+MefuybDcP
	 QLnDgswqCSgXL2wAixGlgJI2e58u3ccKLpfufcXWyYd+XjI93aN5hzjs9Ki07Jh4gvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wITckFbedk41n8qWNkHJhHNpe/zfyJKGZnzfV6vyKHU=;
	b=Jmzok8U7Cat/lPgYPJbQCZPAwLY+4A7f8SCZOQqFP6Ql6yO4bMks92/tiMmWb+kDhorO
	 YWlucvE0PlCy0WgUmwauRyMwa8OZTI84/znx2x1c8Mtvz6p9OR6QPrC+TseXEhVB1vEj5
	 mySAhjkYLaTfSy9Sq28PRGMkgHYvZvxM9Z7LxP/ECseGeVeqTm0Diat6Dp+R0+sAGGxMV
	 rZICw//HJlV58ASPPVlSoJc4vYLbYdGqVpYEMPI7JufWTDETKKtRsefslS3MyA2k2gV/M
	 anmM/TGR3H42ndWfB/zkhd1fJQI0fOwHw0J8jV2VYkMlZiKgw+++ulWWCsYsW+EgQ5g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521646;
	bh=wITckFbedk41n8qWNkHJhHNpe/zfyJKGZnzfV6vyKHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lPoJUoa93IyPkgRkR/TawOdFgdCsgPCBosWBAOwx5y/T6OyM4Fp0ov3YDBkhwNoWE
	 jtK/VbKHTSMm+UOKTWAmqx5Ez3SRHM4MbgDc85fE63RW/SY7DccWu+pE1IeYBhfJ5N
	 LYCt4XHIi4FecXeJCnoCJA1VVemw+80OKlfrUsJcJv7EZ+cl0NPqtX4buPEC/nvSVg
	 SzVplHkQwRduTy2o53K+RJlGTcX31HMy6SBFyfJ/7kjM9RnRwn425AkAZZ29TWusi/
	 FOJrvLC49Fmvg0kuioScoC41hBCDmtkLZVl8ROv2AN5lDV7LofuSz6riGKm0O4w+3C
	 p9nhKTn1w+McA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A1B960604;
	Sun, 27 Sep 2026 15:07:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0BB2334
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 926E7400BE
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBgNINbBUTpG for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8063540068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521644;
 b=QrVC9A0uPcHzcs18QQt1etPEaUTiKXGEm+/tkVSMFNFja2smnDnKQRDUnMnZQmgwii2o
 UNd6h428/v0NF9MCURaBCYz6dXB1II1+UaEDTX37Uoj8nS840lx1D/eNFa9aFu0FyZ+kD
 PAGxsmewBI+0sNofo1qDsqIYjYlVrBRKt+WTZtB5Ld5nXnmSIdVuQ/bTGNQOfBCWOlQMB
 j81YLOHRyEeqHkgdzRaxMKh8PdoyHsHMSAAzMb33c/6kfj/KhOLt/OKqMiVxOHgDshpZw
 iLVp5a9e4zzOQ7wVw9CdXfg3r21URkEAs4JaoVZbX/dlweH0IppnIkMW+zPUvNfllzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521644;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=wITckFbedk41n8qWNkHJhHNpe/zfyJKGZnzfV6vyKHU=;
 b=dyC2+PslqrrQH0+l6UvjJhVtYA+/pRdjwZl74E4VxU2gwBaDilVeN+lnwJQxOfr6A1uP
 Rm3x9MpRCEGz6DbIgUL6gIs+DS74KufYeyIyAEZfAWkFAiJvzH9uQK0pGop05L9Of28b7
 AFcRfnnWqzdx8rZLOFdYKIkCztFKVbo2k/NvhBH0cdzoHtpFVlsJ6OlibflQ3ZSZwFhN3
 E9Hnnc2UJwyi9ZHde8jW+USjAKwM+H3y+xm+aUlCM35HJvwblPBlaNXv5knFkL+gLf0na
 BYWnucVh/0qwgpNMRTlGBRX4Q2p2yGnIkuCpAeJZSH18i6Zl5HnCZ9GircKXBxbkmqQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ePUwm816; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ePUwm816
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8063540068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:07:22 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aaf10bf094so2554218a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521641; cv=none;
 d=google.com; s=arc-20260327;
 b=ovpcVGuWuW6A3EuZ6koJ/AANIYX+CWPbwEts4VgwOh7AInxqE6Qu4D3bu2expFb80Y
 AKmAK0TXYiqfCl8WlXLvJkTw8zsX5ID28eKDCHxvFsfHxG7D1qJGlU48migO7a+wdOip
 eSudPSBscrvGZdN/MgZiHdeaXxlDVrOQrFr7whRwuBeK2V9Kw/bvJdcJGOi8FdT69Bwj
 SuAa5tUQafTTwcKHrY8MhKSpKcpMyiDLA0YqR7JsNn4tEsBrMk0vQLHt+yvAqIs0ZGD+
 tuatH3PSaNM92+vDHSsjA43XRNaTCxudNHA4A6+h2PfiqNa390dQfAHpkU1Y3D81qZvs
 JrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wITckFbedk41n8qWNkHJhHNpe/zfyJKGZnzfV6vyKHU=;
 fh=/DqB1u/p2XWic1U/PVmhe5ygcTJqyvhkkwb38WrWUYs=;
 b=Cv8JkFyqowVEN8VxtBLqCXWP1q5ACSlcMv8Ffm5pE06wtlkN9xcR5tt7sRi6oaYIFf
 +fE0iUVBi+XfbIj0YPKxJANyCQ1LdAtttSCojscYJ3sZPGaBHNJ3kxeirh96MrCUEDIC
 ox5mY8MwXSghwrKC309d0M+ightXCQHKe2w2sECBh5NMlUrYj6P5Xr7fEpKFMFgsgy2M
 HUpmkWAOF8HhFXjFV9NuLVQPY+4mp7LUOCsipc5m91S7BfPb19HYib2MYQs7CKMGvw5M
 w0skOO/aPh0wzUZ8+HED2py6Duo7hQD56ns9eLA/TaPiKBcNBNQ1nMqXxAXhNjs/sAhk
 6ERg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521641; x=1791126441;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wITckFbedk41n8qWNkHJhHNpe/zfyJKGZnzfV6vyKHU=;
 b=ePUwm816BvZ/LP7pa9RsKNkrVZwL24EjleUIYLCkjoaBzQ1/CF59w//g5XReUhcPn2
 xNiA+QBFmJLP+401na+qBlQ6qSH0QsZcGZD/1gq3tFLN741bdmUATOTm6ur9kZGOVuiI
 jlGh+bEUimPmZpsUJUGPLF9D7IlCZtd43Sk3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521641; x=1791126441;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wITckFbedk41n8qWNkHJhHNpe/zfyJKGZnzfV6vyKHU=;
 b=iOYh8cHo9eauhTg2j7F/dNbYddV4Y7txn0c7WGHqRHGiHM2pEz+c+NjjLfI58FlKVd
 7IQwCg+oNHZUWb/pPotg5S19re+cGXV8BMvELJAVcThq10RqciPbnXJI0YOoJrCS3A2z
 ofZUFQCmmu6b4nVSqAhYzAYwGRdyssitF6ZmNqmqWY4DGdB6BbwCa0ugA9Pdv7S9AQqm
 IuDploxsc0fJbHfe/wclu7n6UOVaPLyOFMUPW+s5Rr/6QggSsJ5bGszT0JlRdCM8nLPB
 XBwrl9dIf5HO8siyoGaZSC5zGCcPnVwTqP3znahgAkpuqX1/M5Z/MHZ1Xzg/+Hjg5SKG
 C21A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqtEl8FS9nCzlbKBV4fzY8JYFBr0Lntx3tRKnDs6XrCRQXEBPLhjeMSuXbI2hrrSzYAUc84Ug=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKF7O5hxlc06Av6PUjTy/Q9tvhDQr6lJdfJBcHNDfSyDmjp5yF0
 /VNaZBjdPQB5iU/j2Tljd35Qm/9NPyGeYSvK/fw9Bh7X01QbAzjuMjuwg5HFQjEaobprlsguwwg
 Vyfi8WbjdPSYUewF9I4XTHtSdyV7bagXk/A58Oor8
X-Gm-Gg: AYBFou3TvRy/aGiR/haSgxFKjO6X3goqo9/SHL7Nbtalk9IfMnMuuLJtbFs1zO5EA2U
 egq2fyABQShUBeEe+4O8L+X7xfW/TqB20IvrbTfPLxFwXD0kuw1h/IG/aHpnXlbhiTRlGeVB8ey
 cwpzFgwRj+Nsts3aEhzBpyczGOk6CyeMMBuOs57fzRaw6bxoJHjO48ZxAXbscSmUQUWO3U4jay/
 o7LaT6u2WUY3MKvIi8SxBEW35sLwnTcLi/3E/VqGa94bymvbdpZVFOOiEFwTp/DExDHMpS3CBlM
 JPRBCHBVwGQQ2AmBCMqi1XCXEBQxkLN5pWJTA6Ziw5YOg+fvVIF0rQ==
X-Received: by 2002:a05:6402:a290:10b0:6aa:edb3:d687 with SMTP id
 4fb4d7f45d1cf-6aaedb3d8c0mr3360014a12.15.1790521640951; Sun, 27 Sep 2026
 08:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105630.2D9F368D0A@verein.lst.de>
In-Reply-To: <20260925105630.2D9F368D0A@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:07:08 -0600
X-Gm-Features: AclHuK-55lmQjDMhVzsx_GEmkgfg6VW8tBYB6mSuiZ0SzlH_clQM3ChO1QByGZg
Message-ID: <CAFLszTiYJwWD0qh2x5O9J0mA+DgvFDtKQ-wr-RSuP98==gPXkA@mail.gmail.com>
Subject: Re: [PATCH 7/8] board: raspberrypi: use board_late_init to probe RP1
 chip
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> board: raspberrypi: use board_late_init to probe RP1 chip
>
> During device tree parsing, u-boot finds the PCIe root complexes.
> Thereafter, a pci scan finds the RP1 chip, but does not really
> deal with it properly, while the device tree probably holds the
> description for the RP1 "nexus" or similar. Use board_late_init
> to attach any such FDT fragments to the RP1 found.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>
> board/raspberrypi/rpi/rpi.c | 15 +++++++++++++++
>  configs/rpi_arm64_defconfig |  1 +
>  2 files changed, 16 insertions(+)

Please tighten the commit message. 'u-boot' should be 'U-Boot', and
the description is hand-wavy ('probably holds', 'or similar', 'does
not really deal with it properly'). State it concretely: the RP1 has a
DT node with child nodes (clk, gpio, mfd) but because it is discovered
via PCI enumeration the PCI-generic bind path does not walk those
child nodes, so dm_scan_fdt_dev() is used to bind them.

> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> @@ -566,6 +566,21 @@ int board_init(void)
> +int board_late_init(void)
> +{
> +     struct udevice *dev;
> +     int err;
> +
> +     err = dm_pci_find_device(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0,
> +                              0, &dev);
> +     if (err)
> +             printf("RPI: RP1 device not found\n");
> +     else
> +             dm_scan_fdt_dev(dev);
> +
> +     return 0;
> +}

This defconfig covers RPi4 too, doesn't it? So we should gate the
lookup on the actual model (get_board_rev()/rpi_model) or demote the
message to log_debug() / drop it when the device is simply absent.

> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> @@ -566,6 +566,21 @@ int board_init(void)
> +     else
> +             dm_scan_fdt_dev(dev);

The return value from dm_scan_fdt_dev() is ignored; if it fails the
user gets no clue why no RP1 children came up. Please check it and log
something useful / return the error.

> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> @@ -566,6 +566,21 @@ int board_init(void)
> +int board_late_init(void)
> +{
> +     struct udevice *dev;
> +     int err;
> +
> +     err = dm_pci_find_device(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0,
> +                              0, &dev);
> +     if (err)
> +             printf("RPI: RP1 device not found\n");
> +     else
> +             dm_scan_fdt_dev(dev);

More fundamentally, I think this belongs in the rp1 MFD driver rather
than in board code - the driver already binds via
PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0), so calling
dm_scan_fdt_dev(dev) from rp1_probe() (or a post_bind hook) would
achieve the same effect without any board glue and without needing
BOARD_LATE_INIT. Other PCI-attached bridges bind their DT children
from the driver, not from board_late_init(). What do you think?

Regards,
Simon
