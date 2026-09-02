Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E0C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 07:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3057580ED8;
	Wed,  2 Sep 2026 07:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZVNqkavYavsV; Wed,  2 Sep 2026 07:30:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788334213;
	bh=+z2qolB8iuBAKZZ5BJsGsgfUrc4rG+IO6wBrBRX4ewc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pQtp9ScuzzLwWkzJ5AM42xoL8xFSNQFW+FzEp1o+rYURqRotrnxgTHXVp7XvGmGNM
	 5klNDR3i5jNenZZKKYuleySoy77Ni1F35wph32+O1poom3wrowgyqyZgOEA9l5LB1d
	 98E4zDca67EbX3xqXS9SAcanrLNZ06wVF2Tqw92tzn/TvEOVRoFEvR6V66aWFabr8B
	 Z65xJn/dCurfVErHQgou0Qu3vlDXNdshb2MOFW9WK7ULDml7rkksv75ZjxoTuFzrz/
	 NGadSxo+Uuvt5UgAa6A0lAO/IsZKplee4NW8ZVj1dFou7mNa9W5YJR7hBVv2Jkq8CE
	 0MD630Gd3c/Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 079C880EA9;
	Wed,  2 Sep 2026 07:30:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F595230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5584580EA9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6AJOEWuCijIc for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 07:30:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monstr-eu.20251104.gappssmtp.com
 header.i=@monstr-eu.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=uM4ZWB5m
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CFD880E4A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 07:30:10 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c25366c9b42so72048866b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1788334208; x=1788939008;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+z2qolB8iuBAKZZ5BJsGsgfUrc4rG+IO6wBrBRX4ewc=;
 b=uM4ZWB5mwFdYUoTdcx4DkMa/PsyKfQRDUaHVMKNOlGx/NO+ion9tbOZAKINu5WRdE6
 k9zaStv83HXIZm34qWI3ucMD04fkSMYvqFbBigi/qg9Jfl50zNDubD3xadBKEVUJI/bg
 jpQV7/YdW/oGBhzOdCym0r6hBzdJb8tlwgrZM0y9YlUeHxIPHxj5BHvuWxceIqIj4oeg
 J1NbrddLC7rVo01RqKnmEY2LTIAgYcK1O8SqZgI15eVg6y8YYQwf/H8bsZokKV7KNzGt
 Px+0GZiYdvA/VBLLBr3ZbAZ3zwDWZ0bY92vnBZ6MaXhqnEyx2vgNAq0L05HV6+7MY0a/
 pCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788334208; x=1788939008;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+z2qolB8iuBAKZZ5BJsGsgfUrc4rG+IO6wBrBRX4ewc=;
 b=M4EC+ozBb7lZwamHQ2iuz33xZcu58GulpYiyLvXxr7BAY1Ja58n4+DoAykOhUHhzr2
 zDLot9V1gs5gQpxvQFvRd/+md6L1yy6Y0dD9LYVxpJGUZDC5ga/XC/lUHugVXCzYANEp
 1f9rucD4muzJ0hu94Fw5Wbm3q21bfSv4SlVWLQNCmtXeuZmuzyfh3IFgVO1m7+tSJsa0
 oc68GsNWauY4UrWsjrPRVHot/3iPvkc9rUgLtqI3cGppPDE1LctXYNaBWMSVKHcd3QBB
 KxBzQFriT54OKFUoQIlPLHcCzHx3B+cYyV65nAKdy43QfNP4UhC9JG6UgM8L+m/l2v7j
 lORQ==
X-Gm-Message-State: AFuF++kTbnrJmHeLPRk6CISRJZErMGnS5qBJ/IzW6CXjMnWJyercPO1n
 VpFzUlcKtoJ7BY56sOaclSGgLtNrfa91vllINnd0ORKpMLsfrSjVoEVxHfHOgnXjKurzDYeGSVy
 y2PufMCZL
X-Gm-Gg: AYBFou1MlRJMtbcrWa7nFyeVIg2smAHf+oqQo+4Gd5fiLGJ5BKViiNm2jEsCddIehKm
 i+RxnJlT+vsqxabKx1wFuKDG2x6geZW1bruQd6MAzz5/nZTgY9T3b/YH5iwsnkSwMRXVPdjKtxb
 G+gGQic+YyO1DCJaqQGiOfKuDMFwuASdmcyc+0LxuLDtRwoL31IY1HDinb4KCjg+8b0MmPkogik
 xDdg1Hu0/rBfJVZbNpYz+V50NJCIc+AjBtSLq2g8RV1RFsTprSUh1r6FS4OYloH8nzu2UgC+qcg
 i9Z6QG55kDW/ckBHnx1dOO5+X14FTtQaFJvnnpEUxKdpgNLHx35PELQwX42wXsfZkU+xUIjfKsJ
 2znV93WSv8ZqgqZTPGTBNOjkSJDOq1HWUCbNLAwrMBqLPZTfjWk2vYSj+LO4rfans+0OWcCS1XO
 3l0mRtLeIDVLUDrePUkusSQYBz9M6OffCiL1DEYRKE044ptZld9ohfSKkXv2cJMpSlrkbY25yrv
 saMY9krK/B9ES2L5UbxZ1KrWZEV2D5FgynYMezXAhYW0M+uCEA5SAm8
X-Received: by 2002:a17:907:7b82:b0:c24:d6f0:2071 with SMTP id
 a640c23a62f3a-c25d5560851mr118719266b.12.1788334207875; 
 Wed, 02 Sep 2026 00:30:07 -0700 (PDT)
Received: from [10.0.0.13] (89-24-185-125.customers.tmcz.cz. [89.24.185.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d039d2e5sm81102466b.38.2026.09.02.00.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 00:30:07 -0700 (PDT)
Message-ID: <200cac59-2218-4369-9afb-14117f92888e@monstr.eu>
Date: Wed, 2 Sep 2026 09:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: amd: versal2: move
 platform_id/platform_version to .data
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
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
In-Reply-To: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 8/26/26 14:04, Michal Simek wrote:
> platform_id and platform_version are plain uninitialized statics,
> placing them in .bss. U-Boot's linker script overlays .bss at the
> same address as .rela.dyn (the relocation table), which is safe only
> if nothing writes to .bss before relocation completes.
> 
> soc_detection() writes these variables during early board_init_f(),
> well before relocation, corrupting live .rela.dyn entries. When
> relocate_code() later reads the corrupted entry, it writes to an
> invalid, unaligned address. QEMU 8.x tolerated this silently, QEMU
> 10.x enforces alignment checks and traps it, causing U-Boot to hang
> right after printing "DRAM:  2 GiB", never reaching the console
> prompt.
> 
> Move both variables to .data via __section(".data") so they no longer
> share an address with the relocation table.
> 
> Fixes: 40f5046c221a ("arm64: versal2: Add support for AMD Versal Gen 2")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
> index d72f66f4fbac..19baa1331bdd 100644
> --- a/arch/arm/mach-versal2/cpu.c
> +++ b/arch/arm/mach-versal2/cpu.c
> @@ -241,7 +241,8 @@ void versal2_timer_setup(void)
>   	debug("timer 0x%llx\n", get_ticks());
>   }
>   
> -static u32 platform_id, platform_version;
> +static u32 platform_id __section(".data");
> +static u32 platform_version __section(".data");
>   
>   char *soc_name_decode(void)
>   {
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> branch: xnext/data_section
> 

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

