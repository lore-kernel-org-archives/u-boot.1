Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D91C109C02F
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 15:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6ABA8352B;
	Wed, 25 Mar 2026 16:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Yky1cu1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1670483A1B; Wed, 25 Mar 2026 16:31:05 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F7881E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so56814875e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774452661; x=1775057461; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BjRZ2ZFlY0ICzZ7Wxxc7yd1BsoFOcgXxq9JMteuZ/Dc=;
 b=Yky1cu1Y2rUwg/smR1yzqTvxda2RZLVJD1kbE9Z9ZMWQZKBwFIBfjUB4ByGO0sAT8n
 5svLZOk491mTr0nWAKsabfj7z98RqS5k7wwN/eweuunN+aZRCjFoA+/5bKH6TlLPc2e0
 XWnlqRvOSiKKAsAgzTmN9Zvq9bkVdgMt2xUug4ccA8JlkW/rjZ7THccMTOJAcV9XNdgL
 tpkaAZs0zrRjAcEWW/wrSmJS1TUbQD4/DGHf1Fx+Q4ZqYI3AjkouGqxSLtgRC2zYZQQR
 BPDHLGnLGVOg3jo58IJps8W5pTjXu6F7VXaB5eIShR4siHeYDtUC4SUbXuClR5N1aSjk
 tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452661; x=1775057461;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjRZ2ZFlY0ICzZ7Wxxc7yd1BsoFOcgXxq9JMteuZ/Dc=;
 b=pL4o5iLvgeobc8s7MBb3xMdU9ylRBuRDnUbtPelU085IKzyecGD38HlmwQzNeQMpR5
 Ni0t7EMUKyuPY2PLHwroEr0DlYWF57W3pZq7lUCnA45aYN2a/O5E9q8IpBOiKX4+puLt
 CgVDHnWDw+7SDzN1ym+a4JR6LuMTDSLoPltA4Puozq+icbx8y2uZhTT2wB5tcXJHZWND
 m5iUbEg5RAoyILnersZGd7PspoRfEoogFUJrMmuDZJN7RzMzS2AfzAJRcAES3ABa9Nac
 RLm3f6XB3UyMzxlqFwouFXAPw/SJ2FcC105yEdQeLs9LvuzeSk4lBfbuTT63WeG+o+9H
 e6tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6g2uv/8SM9/Pw9R5+4PbNQFaNj+KPKlPCMHjIHQrA87Qi/cHoDT9BvuV5cueX182UA85Auuc=@lists.denx.de
X-Gm-Message-State: AOJu0YwoYt5acKfNDRFTiXbTfMJ3BKyuDdATJiF9ZaMl29BcRUW81JJd
 pDwoejt5Eis8B9HHac13+G6ibPcs+nFdLEt5/HERW6gJOhL4axUNDSNxmBZwRfAPhw8=
X-Gm-Gg: ATEYQzz09zAlCLOkbnGglwR/dOZF1OvlxqT2DH+SmsUobeFnXtVJs5Nq0TPTPu3LzvO
 /LryFvzDgk221gp7B08c8MYBkG7LWbkVjMVxpeo2i2LKZWOy33oLNZJG23/Gn9LwvHN90e9q41r
 +X12c8TULWTQQmWTAWhlJw7MwnOsIOPfJVr0hcI6i6yMZn8g5qSZIMM/xO3K8Mq/5tEWUFXYRxm
 KuXsTyHJV5IRdEofyPPVDYnouuBa+reK9jncTkKr070WdjjOf0KRuMG73pcHrs2TwGESKxidT9K
 hNsFxa++xh1jsD5oDQHbTKM9J78tS/x6TUtYHrbgdYwAAbuOFPN8u+LrTMcS3LRJdEklN4m0Iq8
 Xp7mihZU6X0uFbzolx6+JgqlMg8ohvWsS8KcNlrrvwkEsgqU30Gi1YyF012jXaX4zob8I6PxVfx
 dJwAYpBVwwQztCkmtkgS8FttQFMvB3XGN6B9tywoqEhYyrW6LzrBOpXrAYIf4Ah1fRazAY2wO29
 Q==
X-Received: by 2002:a05:600c:6089:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-48716008471mr57043615e9.14.1774452660913; 
 Wed, 25 Mar 2026 08:31:00 -0700 (PDT)
Received: from [192.168.2.177] (156.85-85-163.dynamic.clientes.euskaltel.es.
 [85.85.163.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116f1905sm143051655e9.3.2026.03.25.08.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:30:59 -0700 (PDT)
Message-ID: <53a81079-6886-4c37-b3e6-6c8c2ca99f79@suse.com>
Date: Wed, 25 Mar 2026 16:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi: Update the naming for bcm2712 SoC RevD naming
To: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20260313170839.2720191-1-pbrobinson@gmail.com>
 <af790887-96b5-4839-aeb5-6bf6d1d4cf22@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <af790887-96b5-4839-aeb5-6bf6d1d4cf22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 18/03/2026 19:46, Filip Kokosiński wrote:
> Hi Peter!
> 
> I've taken a look at this, and unfortunately - with fdtfile set to
> broadcom/bcm2712-d-rpi-5-b.dtb the kernel panics on pinctrl-related symbols:
> 
> [    0.236580] SError Interrupt on CPU2, code 0x00000000be000011 -- SError
> [    0.236586] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G   M       
>   6.12.47 #1-NixOS
> [    0.236590] Tainted: [M]=MACHINE_CHECK
> [    0.236591] Hardware name: Raspberry Pi 5 Model B Rev 1.1 (DT)
> [    0.236592] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.236595] pc : bcm2712_pull_config_set+0x78/0x120
> [    0.236602] lr : bcm2712_pinconf_set+0x6c/0xe0
> [    0.236605] sp : ffffc00080033ae0
> [    0.236606] x29: ffffc00080033ae0 x28: 0000000000000000 x27: 0000000000000000
> [    0.236609] x26: 0000000000000000 x25: ffffd06fcffb1060 x24: ffff800104c62a98
> [    0.236611] x23: 0000000000000018 x22: 0000000000000000 x21: 0000000000000122
> [    0.236613] x20: 0000000000000000 x19: ffff800104ced480 x18: ffffffffffffffff
> [    0.236616] x17: 00000000105916e2 x16: 00000000acf0c9e7 x15: ffff800101736948
> [    0.236618] x14: ffffc000800337e0 x13: ffff80010173694a x12: 3030306330356437
> [    0.236620] x11: 0000000000000040 x10: ffff800104d13c20 x9 : ffffd06fcebb4ffc
> [    0.236622] x8 : ffff8001024024a8 x7 : 0000000000000000 x6 : 0000000000000000
> [    0.236624] x5 : ffff800102402480 x4 : 0000000000000001 x3 : 0000000000000018
> [    0.236626] x2 : 0000000000000024 x1 : 0000000000000000 x0 : 0000000000000000
> [    0.236628] Kernel panic - not syncing: Asynchronous SError Interrupt
> 
> 
> The `bcm2712d0-rpi-5-b.dts` from downstream kernel seems to change the pinctrl
> node compat to "brcm,bcm2712d0-pinctrl"[1], which then in turn causes the
> pinctrl driver to use a different register layout[2]. There are also other more
> minor differences between these two dtses.
> 
> I haven't had the time to do more thorough digging, but I've managed to get my
> setup working using the following overlay:
> 

There are more changes between bcm2712d0-rpi-5-b.dts and bcm2712-d-rpi-5-b.dts.
But all of them should be fixed when applying overlay: bcm2712d0-overlay.dts

Regards,
Matthias

>      /dts-v1/;
>      /plugin/;
> 
>      / {
>          compatible = "brcm,bcm2712";
> 
>          fragment@0 {
>              target = <&pinctrl>;
>              __overlay__ {
>                    compatible = "brcm,bcm2712d0-pinctrl";
>                reg = <0x7d504100 0x20>;
>              };
>          };
> 
>          fragment@1 {
>              target = <&pinctrl_aon>;
>              __overlay__ {
>                  compatible = "brcm,bcm2712d0-aon-pinctrl";
>                reg = <0x7d510700 0x1c>;
>              };
>          };
> 
>          fragment@2 {
>              target = <&uart10>;
>              __overlay__ {
>                interrupts = <0x0 120 0x4>; /* <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH> /*
>              };
>          };
>      };
> 
> 1: https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/dts/ 
> broadcom/bcm2712d0-rpi-5-b.dts#L80
> 2: https://github.com/raspberrypi/linux/blob/rpi-6.12.y/drivers/pinctrl/bcm/ 
> pinctrl-bcm2712.c#L390
> 
> Best
> FK

