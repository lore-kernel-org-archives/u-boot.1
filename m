Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9FFC54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 22:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A0E877EC;
	Fri,  8 Mar 2024 23:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s7bVboAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD2B87AEC; Fri,  8 Mar 2024 23:57:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638FA8723E
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 23:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B95654070C
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709938634;
 bh=EgObmRBDWA0Aq+Qi1NlVLnXezzbPnzjmPCmn3/MrqUs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=s7bVboAq34FUV8pMuIzFBvpb9WGJkzkDbf30AKtXuxt84XaZX9X3cgwUsWEvNaXwx
 47a6SQl7o5LBh91ArHc+KUb6fm3+P9tLaph9JIfG8+XkWC4Jf24VtwvpFLal8Qs7AY
 yj+5jyI9Jy8IzIUfa9KdO/JaSmoDbbe5TSCnsmubwV/JYwg+SCU+MqvnD5HEX0WrJ5
 a6tw/U3J72kUAz3YYoUCfJVH3AWRj/cg9yfduXaoB/rAVm5WKlNuzX6+9vQMduq69N
 MFP9UvUktaSvjtQv9uOiX987PnJiW+8oV/mHYBS957frZvfatD77aM0u/OZHCAJRPs
 Okr4z/ZLfanlw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d30a3d6f8so1004936f8f.3
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 14:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709938634; x=1710543434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EgObmRBDWA0Aq+Qi1NlVLnXezzbPnzjmPCmn3/MrqUs=;
 b=GBxxgYP8sLrEvuGxSZiyiv9ChDWwtm3u26eTJwio48tjj1OtpzTpC1Y+g3TzJOUjf7
 w8yOZ1VSHQh6kq9M5BQ56ZvKrgKEr7nt+hbOXzi0sz6oCVOWOg8Gu381naqg6oaF7iWJ
 7QD1IFhVa30Ct/+wMVH8QjBvPQVXj7R9JdKzXIMIsgp/CgYGpOmDmav4Qd2xro40s9hu
 gbjbFY4owc/l0HL/LG/tkTe5OOmumsTu6HiJDzp25+BMiG6DlAabVr74RFU6aTYIYwdt
 mHjQU//svfnQZGoHIjBL695ikQEWZ3LtNI7zb1nHiIMg/9v8T/9Ilx3FNlo/2joyDxiV
 OfGA==
X-Gm-Message-State: AOJu0YzBYYLAfn9+0HE6SIPO3n7mUW/N7PkH2J4DAAubhm2FOAnN+mry
 ulSGiOxBZV97/VMhXJvVdb1HIA6UxCtjybkc/CXEbC8/9v4pA4Tk1phVfnccmJTYgCeNmXKLb2p
 jT0Zg4w1extNEklrMw6l4JrGolG+mWUJzYXJ9Ae/azSAQAGWwOSTJU1J087KtPTyc9W8=
X-Received: by 2002:a5d:51cd:0:b0:33e:1a98:7135 with SMTP id
 n13-20020a5d51cd000000b0033e1a987135mr300380wrv.38.1709938634303; 
 Fri, 08 Mar 2024 14:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOMnLeipTxQpLrfMstd0OdKlUjmTXZvZWF8kKzzWNXjELbInblEbphO4Gz2dzVec7NsFKHDA==
X-Received: by 2002:a5d:51cd:0:b0:33e:1a98:7135 with SMTP id
 n13-20020a5d51cd000000b0033e1a987135mr300374wrv.38.1709938633908; 
 Fri, 08 Mar 2024 14:57:13 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:9c69:8137:bdc0:ae98?
 ([2a00:20:9:393f:9c69:8137:bdc0:ae98])
 by smtp.gmail.com with ESMTPSA id
 x7-20020adfffc7000000b0033e75d41e7bsm479345wrs.25.2024.03.08.14.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 14:57:13 -0800 (PST)
Message-ID: <071b1819-ecfe-4ac3-8e86-e9f3dc920b3c@canonical.com>
Date: Fri, 8 Mar 2024 23:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] riscv: set fdtfile on Milk-V Mars
Content-Language: en-US
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-3-heinrich.schuchardt@canonical.com>
 <CANV2PTNbhB1D32pK9nVKi0MNA=G-ooP=qcJBcsaEGMNzaxo97g@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTNbhB1D32pK9nVKi0MNA=G-ooP=qcJBcsaEGMNzaxo97g@mail.gmail.com>
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

On 3/8/24 23:37, E Shattow wrote:
> Sharing the info from Mars CM Lite 4GB:
> --------EEPROM INFO--------
> Vendor : MILK-V
> Product full SN: MARC-V10-2340-D004E016-000006DF
> data version: 0x2
> PCB revision: 0xc1
> BOM revision: A
> Ethernet MAC0 address: 6c:cf:39:00:83:11
> Ethernet MAC1 address: 6c:cf:39:00:83:12
> --------EEPROM INFO--------
> 
> I do not like this practice of force setting fdtfile environment 
> variable. If I set fdtfile from u-boot prompt and saveenv, I expect that 
> my action as the user will persist over a reboot but instead it gets 
> ignored and overwritten by this strategy. Is this necessary to happen 
> before the boot scripts?

We could check if $fdtfile is already set before the update.

This would require that the default environment does not include it. Cf.

include/configs/starfive-visionfive2.h:51:
	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \

Best regards

Heinrich

> 
> On Sun, Mar 3, 2024 at 5:02 AM Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     Set environment variable fdtfile to the correct value for the Milk-V
>     Mars
>     board.
> 
>     Signed-off-by: Heinrich Schuchardt
>     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>       .../visionfive2/starfive_visionfive2.c        | 43 +++++++++++++------
>       1 file changed, 30 insertions(+), 13 deletions(-)
> 
>     diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
>     b/board/starfive/visionfive2/starfive_visionfive2.c
>     index 78e118d5a05..9970e309690 100644
>     --- a/board/starfive/visionfive2/starfive_visionfive2.c
>     +++ b/board/starfive/visionfive2/starfive_visionfive2.c
>     @@ -9,6 +9,7 @@
>       #include <dm.h>
>       #include <fdt_support.h>
>       #include <env.h>
>     +#include <log.h>
>       #include <asm/arch/eeprom.h>
>       #include <asm/io.h>
>       #include <asm/sections.h>
>     @@ -17,6 +18,8 @@
>       DECLARE_GLOBAL_DATA_PTR;
>       #define JH7110_L2_PREFETCHER_BASE_ADDR         0x2030000
>       #define JH7110_L2_PREFETCHER_HART_OFFSET       0x2000
>     +#define FDTFILE_MILK_V_MARS \
>     +       "starfive/jh7110-milkv-mars.dtb"
>       #define FDTFILE_VISIONFIVE2_1_2A \
>              "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>       #define FDTFILE_VISIONFIVE2_1_3B \
>     @@ -48,20 +51,34 @@ static void set_fdtfile(void)
>       {
>              u8 version;
>              const char *fdtfile;
>     +       const char *product_id;
> 
>     -       version = get_pcb_revision_from_eeprom();
>     -       switch (version) {
>     -       case 'a':
>     -       case 'A':
>     -               fdtfile = FDTFILE_VISIONFIVE2_1_2A;
>     -               break;
>     -
>     -       case 'b':
>     -       case 'B':
>     -       default:
>     -               fdtfile = FDTFILE_VISIONFIVE2_1_3B;
>     -               break;
>     -       };
>     +       product_id = get_product_id_from_eeprom();
>     +       if (!product_id) {
>     +               log_err("Can't read EEPROM\n");
>     +               return;
>     +       }
>     +       if (!strncmp(product_id, "MARS", 4)) {
>     +               fdtfile = FDTFILE_MILK_V_MARS;
>     +       } else if (!strncmp(product_id, "VF7110", 6)) {
>     +               version = get_pcb_revision_from_eeprom();
>     +
>     +               switch (version) {
>     +               case 'a':
>     +               case 'A':
>     +                       fdtfile = FDTFILE_VISIONFIVE2_1_2A;
>     +                       break;
>     +
>     +               case 'b':
>     +               case 'B':
>     +               default:
>     +                       fdtfile = FDTFILE_VISIONFIVE2_1_3B;
>     +                       break;
>     +               }
>     +       } else {
>     +               log_err("Unknown product\n");
>     +               return;
>     +       }
> 
>              env_set("fdtfile", fdtfile);
>       }
>     -- 
>     2.43.0
> 

