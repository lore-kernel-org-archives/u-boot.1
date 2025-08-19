Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE830CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156D782F5E;
	Tue, 19 Aug 2025 10:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="qG91TyuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AA382D88; Tue, 19 Aug 2025 10:49:14 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2983082D88
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ad681so7015118a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1755593352; x=1756198152;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=82hIfGXprz86EBoOai8se3DjZ3qyfw7MUvE8JIav8ho=;
 b=qG91TyuDZCCNr0ixO7MLRADX/ysx91g68x2GyTwfKmJCRLAlBDCL7BTQSk7gKeaE0m
 +0klaFVLC9gXFcxhP+eETz3axRnWTKGJ9CnyE2mPjDNpz7APwVwi/7x0DHgMmDaqTlFk
 vJJPiMQCvyhNxyytAY1JQqLQiOBtosD50QjfcGvlSIEht7UD3mI3DtmdxNT2oPJBiZkv
 tmwTNAOROeWEID+0juOF12C0oWeiGqw6N6Pzbxs4me2is+VNa+TCJ5NOuvmNCPElz4iK
 /QvGBBTh6hfKL06NRlxZcOPT+xcwrOeE8CjRIlO4GUOmo6GunELsm4dMz6BBijdVQ1l2
 qFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755593352; x=1756198152;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=82hIfGXprz86EBoOai8se3DjZ3qyfw7MUvE8JIav8ho=;
 b=w2LuGCm4bM3rwlpfjMO+At8bNzvAm03c5goXLElEqEUvaSTAh7Fvl8fQTzjgA190PE
 tBEZ/EhFzBT7fhqnzAwU3jE88TSBbuOWNZcucL/Wa9af+Tx8IyXJIgeX2tyZgQpJEJOr
 4ukABvyNtl23DQhpMLc7X80pyt+MVp+whqzck9A5HTWHQajei7cce6bfYK+29qhlKDhV
 Lx2tZ811puber0Q2HfYlYtEwG+zCutXq7Kof7Hdqy30PQSkk8neN2NAeukZnAV1DiyeH
 fv8dFD8fb8sxaJGedvPRhd/ocJUXXB3G6f5kAbcZTnHYHMm2MIaJrBDC1iO4u8bQvj50
 7SoQ==
X-Gm-Message-State: AOJu0Yy8WqXYBa0xgfihQ94XuV39RYTuJXgWVPpSisZ4i3hn1oMx0tjJ
 EkvzN6RwJHG+YgWsDbuKyckrcNULQNYuHODaeoEmESFlvoeMqcpz/sO00AAauF8C6aiQWc0xnQR
 xbQc5FDvJ
X-Gm-Gg: ASbGnctELgpuT5oyjXOb9tc982lUF/w6JHM5Bq9R9cvNbp7/tdy9CI0e+tsJlzluk3R
 R07aI2Rm4Gs+wDXx6T4ts6BewdqbZhG9ZG0y2r2QgPOuhAT7mxllrazLNdceXZGnyB9cH4x1jhq
 NwJ+47r5loXgrGTrljKu33d77IUP5gXbzuc7FW8n3t14DHVZgYy4XffAALyPEAeblYVIFY7/wfI
 pD077q/COikqxDYyEkpi7sE9CApYJ6YTMjaoSOgSyaa48ZnrTl0bqLHDEBT41p9K6mE+cWWC1vs
 700ZrMjVw4HrhB6eUPxxyNS2gJs2h23AezpLZVjoirroUfHTc3do0npawC4IOmBzQfxmdckq3k8
 +ZGrqySLicYKdDnnDKWD9W6OZ
X-Google-Smtp-Source: AGHT+IF+R9OcOIRmD9pbIY+ZawBAPzq2nj/MSFV3slWfq4a7eQALv+qBJF5dbck/BBUC3sZkfytVNw==
X-Received: by 2002:a17:907:7fa0:b0:af9:7c1c:b4ce with SMTP id
 a640c23a62f3a-afddd0c6a65mr149115566b.39.1755593352268; 
 Tue, 19 Aug 2025 01:49:12 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afcdce53e04sm953825066b.14.2025.08.19.01.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 01:49:11 -0700 (PDT)
Message-ID: <f52d45aa-ed34-4e80-bb8c-30de59e4c9fa@monstr.eu>
Date: Tue, 19 Aug 2025 10:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: zynqmp: Mark zynqmp_clk_ops as const
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Lukasz Majewski <lukma@denx.de>, Padmarao Begari
 <padmarao.begari@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/25/25 14:01, Michal Simek wrote:
> Operations are not changing that's why mark them as const which ensure that
> structure will be moved from .data section to .rodata section.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/clk/clk_zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
> index 4f67c958d0fc..7a433a667a49 100644
> --- a/drivers/clk/clk_zynqmp.c
> +++ b/drivers/clk/clk_zynqmp.c
> @@ -882,7 +882,7 @@ static int zynqmp_clk_enable(struct clk *clk)
>   	return ret;
>   }
>   
> -static struct clk_ops zynqmp_clk_ops = {
> +static const struct clk_ops zynqmp_clk_ops = {
>   	.set_rate = zynqmp_clk_set_rate,
>   	.get_rate = zynqmp_clk_get_rate,
>   	.enable = zynqmp_clk_enable,

Applied all.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

