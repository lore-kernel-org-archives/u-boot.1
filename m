Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990FECCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1853583E2B;
	Fri,  7 Nov 2025 17:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DC8wu7i7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A7083D62; Fri,  7 Nov 2025 16:44:10 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F9483D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b7272012d30so156053466b.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762530247; x=1763135047; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ecxijmDyxa/CXHebPkqChrPPTafvouQv2krgGa0jbxs=;
 b=DC8wu7i7y+JWWl8yO7Z1Y6cODZ8gZYztMfxaFDV58OxKn4dHGrKhWdah813TuEeE/l
 GdxtvntW+ye7jXszOudh0wZmPy0NyputjGTGUNjx7RI9tU+Ku/YZgftxSCXSnwKIyEVr
 zkP71UqCiVUqKICkAmbIpxeqwPQjxX6Ii9kBkN5VkT1Jr3cLGuqVDR1OCOBJIMZY6LNQ
 3Pe4iNXZ8EGW7nNZ4ms83LI0XICTUTsr3xRaqsr9PTybm5/fkS/tANr6+/WNEMoQQUnK
 NK8gB7sDaJhQQQIOIQb0uafe1BDfJ0aWw7zD4zo5guaXjeStqgqKHqGTI7d2/ChOl1Bb
 pabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762530247; x=1763135047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecxijmDyxa/CXHebPkqChrPPTafvouQv2krgGa0jbxs=;
 b=rQwKeHsLkn1laLs1ykwFES0LJ4+QOCkHSwSdNFKsR+IaHmgZBKzFVE+kPut87rjdr+
 rPwdEphnpZVCDwRg3/CSvuqzIsi+tsaskM9aheyZjh7LUBxHj0IsAgyGiH36QTw5ROB9
 +NJPZ+fmeBGhj0BxnXA0Yuy6vVmn6EGq6tvM/TWKaAngMHzG0u6+Fkx2AM6l9Ef5CoQY
 eiwluC+YcDUrpwhaDerF8au6VPyhL+ZufDXLbYOCSU1hzGBLfndk+qza7746SpfIEacZ
 5RHDoruGLwQB1wnN0KwJg/AbHQQ1toq5n2jDHz4F+V7ekHyVugMb/jbjKyIhnbrbekSu
 OQ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi3ieSlaD+6itvpWZjeW7morlL2wV5nu6Y/ZaYfmtg9z1MkGtVGQKJZVnm0pN/ui/WqgFMavw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0hr3vk19zBTAXf/vmqBtByzmApXbWcczJWXYTlyWkFYocp3mJ
 ZML0rk+f1/qEPs+5lEnpdMwS9H48eJQyQChjduIobJnEGhwIvDUiTc1o
X-Gm-Gg: ASbGncsqoB5Rh6RPshCVDRKzZmtCZFsrr1FBWHnbmfsSFpznsigeibb6PJN/XXW/gzk
 KH2GtVfUEhHLuVLnVbJfqx9jKQELyQZ8NIo1gr0Dui3PihMD+72hnga0t6L2Q+vCed4dcFZy2Fi
 +d9m8C/sIFXM16CJV90YiF/tsv25OYJsCC0FhACXrFLkj1lt0Ub7ZqTsdFIAwUYrqEEyIKD8yE8
 k7ZMa8dM5d3etleMaM7ji4TyG+M7vTs1PSyRZYq3H6m2rfJuS+LQT5NLzK9E5BSMlAFPwQDPULC
 tBRgv0v7vGKG+YHmfo5nZndgw+R847h+ggCB0VN24Iz4oIAxpaf1V1poibOPS0CedcMx/KyiQCe
 TSyh5w9uRgHri6s9jQGtaFT1tOoMAE7Yln6giHxQtVxjUs6Bvyyn1f7lT9RuK5LdAlgXxLAN8pZ
 ApYoHsV1dvMTrAt9kdOXo2yOiMEnjpcms/wXp9it5ONd7zGyuhdlSyKx/LCiL8pfwGZAFi37O8
X-Google-Smtp-Source: AGHT+IGyrQlOQeOWtOpYw9smKuKdFeb9/gz0e8+CXedusJLfrrp7FIqvF2XvWH6xoeeLDSvZTuKAVg==
X-Received: by 2002:a17:907:9305:b0:b70:b700:df98 with SMTP id
 a640c23a62f3a-b72c09334e1mr368761366b.5.1762530247210; 
 Fri, 07 Nov 2025 07:44:07 -0800 (PST)
Received: from franzs-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbc9656sm277966366b.7.2025.11.07.07.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:44:06 -0800 (PST)
Date: Fri, 7 Nov 2025 16:44:05 +0100
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, s-k6@ti.com, bb@ti.com, m-chawdhry@ti.com, 
 u-boot@lists.denx.de, u-kumar1@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR
 config tool
Message-ID: <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103071035.674604-6-n-francis@ti.com>
X-Mailman-Approved-At: Fri, 07 Nov 2025 17:57:52 +0100
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

Hi Neha,

On Mon, Nov 03, 2025 at 12:40:33PM +0530, Neha Malcom Francis wrote:
> +#define DDRSS0_CTL_178_DATA 0x35000000
> +#define DDRSS0_CTL_186_DATA 0x00353500
> +#define DDRSS0_PI_275_DATA 0x00F30084
> +#define DDRSS0_PI_281_DATA 0x00F30084
> +#define DDRSS0_PI_287_DATA 0x00F30084
> +#define DDRSS0_PI_293_DATA 0x00F30084
> ....
> +#define DDRSS1_CTL_178_DATA 0x35000000
> +#define DDRSS1_CTL_186_DATA 0x00353500
> +#define DDRSS1_PI_275_DATA 0x00F30084
> +#define DDRSS1_PI_281_DATA 0x00F30084
> +#define DDRSS1_PI_287_DATA 0x00F30084
> +#define DDRSS1_PI_293_DATA 0x00F30084
> ....
> +#define DDRSS2_CTL_178_DATA 0x35000000
> +#define DDRSS2_CTL_186_DATA 0x00353500
> +#define DDRSS2_PI_275_DATA 0x00F30084
> +#define DDRSS2_PI_281_DATA 0x00F30084
> +#define DDRSS2_PI_287_DATA 0x00F30084
> +#define DDRSS2_PI_293_DATA 0x00F30084
> ....
> +#define DDRSS3_CTL_178_DATA 0x35350000
> +#define DDRSS3_CTL_186_DATA 0x00353535
> +#define DDRSS3_PI_275_DATA 0x35F30084
> +#define DDRSS3_PI_281_DATA 0x35F30084
> +#define DDRSS3_PI_287_DATA 0x35F30084
> +#define DDRSS3_PI_293_DATA 0x35F30084

When I compare the updated configuration to the one for our Aquila AM69
board, I can observe that you have set an on-die termination at boot
frequency only for DRAM3. DRAM, DRAM1 and DRAM2 do not seem to have any
termination enabled. Is this a mistake or is it intentional?

kind regards,

Franz

