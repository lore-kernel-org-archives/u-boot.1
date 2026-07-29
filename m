Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB1BC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08B2840605;
	Wed, 29 Jul 2026 13:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gdKpk-Ph_pP; Wed, 29 Jul 2026 13:41:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 386074065B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332482;
	bh=xI6OZWOzL0YhUt5F34lXTgI/Z1F2MkhG/qg1KxXkaHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lmdKXwlQeiNN0LxMRnoRMbsjtZUGnz5kEiXDwX9x7hRehkbOE15U61gpmtT5xlzkt
	 0Uxy8AWRMuXhLguR4g7J+JqzjlKAyltHfam8gDlGLpwTPPcbQimxrcTrr7tiTOrmdl
	 zUv+Me3iIwuPPyrLDxbEVhKVfHuDtyTL4MydTXJTH+5J0U6NYaBUSC3+B4LjeCh3Yl
	 wv889vvxIJs6vfS/3TTj4TnUFAv/4QYoI3MPKmKoRI8N6ie4pc4iybePHeyaBYeUpM
	 nGFg99HGTP4Ug6BKhsWF47UzwDySXvqAgfXfcPwRLjYTzpHRmjRH6xuRGPh6+t+gsP
	 +B8XLpS/8i/EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 386074065B;
	Wed, 29 Jul 2026 13:41:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73DC7788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65F304065B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sW8bfQmrrD3u for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:41:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3164040605
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3164040605
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3164040605
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:18 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69c7ab350e9so1592323a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332477; cv=none;
 d=google.com; s=arc-20260327;
 b=N9ToOane9LJCK4x483wm9opaDZB2L9jumMadOn4cn9+cusNbSvEhpsRaNDCRL7aD6a
 L3q+yr1KDnF5yQ68UdLyTTyBJO5t8+9nh2FV+UQ0rwXGsmmlKbt+aeFOw7WAvL2WRsCc
 idmJ4YeXM/fYSHC+Jj7ng/b7qciMEX54Gat3MI8+RgGtRLBD3u5oltrdO2erAlsEU6Ce
 cFJXTK3QIpqWHd4jOyfFuaymFgUM/3BLa5Jae8Btee8Cog1cOrqmqLrqJB4lQ+CF7LDB
 8McBQBWoHewGKyaPNP/sDJS5HHY/pxU5zH2d4j+uw24ogIjBbEEC+X8euwDviTuhC6A6
 m0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xI6OZWOzL0YhUt5F34lXTgI/Z1F2MkhG/qg1KxXkaHU=;
 fh=bhgq6KPscqbh6EHd56ocY33CdQ8aU1b9DMUr8ldCx+g=;
 b=Y87x8zpY6OROZ4QkaN1fc83r9bbTzth98DH3UWUFRVUmYbWbp6Bn58+AUFDI0lZfxI
 Wue2kFp2kqECh1kOC3FaIV0fOSE3mkERXLlVYpwwZlZ8LB/Fv2wdSB6cnTKNmjr/6Fk5
 K8s5xWLxlFC2qTt56Ws/fG8PDue3N53Fe5VkQyUQ2V8q3/aNNlerOi0/zaHIAc4/ECkK
 zhf1SJWnrHnzDDD15XrneqeOJT+Aon6uUywP/gCSbzw0l3XJGshptxbq4bd+bB9xXj8X
 eHfT4oKsabLDDjYZmiEHKOprMW9/Sabw7vzf/1K1Ru9n9re1T8cDWcCWFMOY4eb7ngaf
 fdZw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332477; x=1785937277;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xI6OZWOzL0YhUt5F34lXTgI/Z1F2MkhG/qg1KxXkaHU=;
 b=hOFrz3NzQ8cfUihFhQXtNbB1G21z4c1kYA1MrzGFkTkGRQqUwCQXhCu5k8pqCl4S4f
 y1rtALQR4+RR4zWIS2t2YjuGHqmhFGCawYAuni1x2NAbNSIM7LYd9bV2zxyrPvx12eFG
 t7/53T3IFDm2/YewHJIMBpRLUbCjaeR1R6vJcJdn5lxgtD3El5H399HEzYZ3UuZQ+A5e
 KikIDa+ab/T9dwVXHXP3+j+7PgR/UbPz0C/a9dmfBtVysOcRTUDu4dkrGSMIwTeQLs9X
 6Fb7uwPFb9xKd8JFR2tu532bEH7HN56rRlH1Nz8K+fKOe8QXzorMbZHCXjF1BUtH7cQB
 HOAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmniyBLxjF+tpp4VManyG7tZ6vrflauWBjlI4dZa4gOEQmGcKIiCtaDjFMVu5eeopfr8utmko=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyO6b9/VhiOBJBoLVDQU8ezCdgkdxuHO4edZWt8pD60Y8OaaODX
 aJTFcUUuo2aI70QbCrU1oSnd+14cPlUFlYj9zl520iEWQoy1Do8sT0/XQ0G6/PfkLaDSqxHVxKj
 kFxcaBZj+8cmHrXhnlHCDxaiszCU6C7TvZTJeaDSC
X-Gm-Gg: AR+sD1178VFOQiFIzAn7sDj7Wq2Ax89JnIMbChBibwp5WDdXYBOMWFG1VL8jatUuy9v
 WAEW+LUvZBB3JQPFq1fQqfCwqMIXXN+NG46G8CFam71c1nny8xIVKsEHmIuCxNVL44r04QHiHJz
 kZQPnLn+AWKn5Qy0T/mawTMoGQKNvf4vvYTqkESCNvjMDKMsIxkBW1u/bOtPdl7QpbQWsiHNjBB
 hlSvqK8nFSUlBMVIOnCsn9kbKnr5VUGNO/AhBUHP7+NiiQWaAXkm5nM+hPd2gd5i6uRm9lvA5Zz
 i3lHtUfZNcBRQUNJIgvgUaV2xg0I2WalLgQ2fJqTKu8KOt1i5mNeqg==
X-Received: by 2002:a05:6402:a0d6:b0:699:2448:be5a with SMTP id
 4fb4d7f45d1cf-6a034a39618mr3654018a12.26.1785332476451; Wed, 29 Jul 2026
 06:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <b42c2735-b16a-4129-9278-c026243999bf@gmail.com>
In-Reply-To: <b42c2735-b16a-4129-9278-c026243999bf@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:41:02 -0600
X-Gm-Features: AUfX_mwuMXh0XOGc6MhQosYL2STmjPIo5_FLqRtzBJMqSkUy0uGGA9zfz54Lpu0
Message-ID: <CAFLszTj4WdgvhQ+PKh-uvkS2dD9aBed7up0wL8MtK65RwE=duA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] rockchip: doc: add more EMMC program examples
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332477; x=1785937277;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xI6OZWOzL0YhUt5F34lXTgI/Z1F2MkhG/qg1KxXkaHU=;
 b=ZNmem2QV4T1XVOxULr0UdNi/BBZzly81RgP73DIphk6UiTwZ/+JGL4pufqz3eUYKcC
 dacQm/T/XwxyRaj0VB2dEkXG0vqnUfu4c9YQ9Zlwwff0KtQZTgj7qAYsKQCYD3X1ZRJL
 ROaVfLR6ID13aKiOQ2eEvRSdpZ0SqvYpNa3vo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZNmem2QV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add more EMMC program examples

>
> There are more tools that can program a EMMC.
> Add more EMMC program examples.

'a EMMC' should be 'an eMMC', and the rest of the doc uses eMMC rather
than EMMC - please match that in the subject and body.

>
> There are more tools that can program a EMMC.
> Add more EMMC program examples.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -413,13 +413,22 @@ Upon a successful gadget connection the host shows the USB device with:
> +Program example with rkdeveloptool:
> +
> +.. code-block:: bash
> +
> +        rkdeveloptool db rk3308_loader_v1.26.117.bin
> +        rkdeveloptool wl 0x40 idbloader.img
> +        rkdeveloptool wl 0x4000 u-boot.itb
> +        rkdeveloptool rd

Two things. First, this block sits under the fastboot flow ('Launch
fastboot on the target', device running U-Boot), but rkdeveloptool
doesn't use fastboot - 'db' downloads a loader while the SoC is in
MaskROM mode. Please make clear these are two independent flows
(rkdeveloptool operates from MaskROM, not the running U-Boot).

Second, the surrounding text is RK3399-specific (the lsusb line shows
'RK3399 in Mask ROM mode'), but the loader here is
rk3308_loader_v1.26.117.bin for a different SoC. That loader is a
per-SoC downstream blob, so a reader will need the matching one. A
short note to that effect, or a name consistent with the RK3399
example, would avoid confusion. What do you think?

Regards,
Simon
