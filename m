Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C671FC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B8180F6B;
	Tue, 22 Apr 2025 17:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="cs1o8dgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04B9B80FA8; Tue, 22 Apr 2025 17:18:00 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB28280F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel.holland@sifive.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d80bbf3aefso14074145ab.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745335076; x=1745939876; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wPNdG/TmMJiZA5LpNxPq4mQSrVvq8+nIYg3pRZ+CaOs=;
 b=cs1o8dgToWIQkapqeKSnx9trDg4g3j3iCSeUCloZ0mit3TMyqJ+U+Z8rJpoUKxNCB2
 HVtpM/tjsUWsxMRSFc/2HyxZNcHDtqBhSpGqhhKJRkgBnfM8g9EV+9/7zpF12wfvdU8d
 1ZpbZJKDZ1i5pvi9T2bwxihsAksTWqyyArl0xGJGb5BT36RTCmU+sunlRDobAzJfmxIY
 fUt8ME6djmrJX7U3daf/2dAqxk7zYppubU09REM2Y5TcDQe4j+Zk38hblMxVPzbJcXxw
 x5f2iyiyCxx2aFRYx4jFhFk9vtc62SPZ0amhar0TEMLcv0lgQYkNM3j7w8OwduZYO7Oo
 5zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335076; x=1745939876;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPNdG/TmMJiZA5LpNxPq4mQSrVvq8+nIYg3pRZ+CaOs=;
 b=sQynWGL09/1pzTOp0CQe146MOTWmYjsOgQZInbYPBPGiFqc1eF9ic1cXGJllPX/xY+
 iAMIpZMx0oq0iqkz9SWrvjdGNxA9gCGpXJoKV9hT07nfMx6qsSqbiY+MNSn7U/OENtI8
 S6B9tSE1WwRn/TBLzhCOscqI74wAGuKm8/Yw30Ng9VsL9wx4Fe2ieadDMlMxGVwLR9Eo
 MpSw/V6cIG51vHwtHGRL3BAwc8Pf6YDe9WOgzfyclbeIC/qegsQah5GZsYuSwpDQwmM+
 YGKnW49GqI90Bu52cT0z1ZPw6ffplEWIeZwtAxmvJ3S/XBvMjeNEoXJUZgRUyJJhNrSg
 0OQA==
X-Gm-Message-State: AOJu0Yx1NedUWDRdINX1hLRl7p+zXpUmQDLZpz3hhLp1D0sl5+dJo9Ja
 SOJd48AReSByIXHo6R7uq5AWxqKTa7ODu67KIj3Nj3ntyoyOOT0hrCpqcK44eCU=
X-Gm-Gg: ASbGncvaO+qbYwpV20+nIB5XHsIJwvg80rGNNaONDBbpuI5tannaO5PjCwWwbu0DhFX
 zAAZ6BxwytBXkQlSfSqAcrA+tnlSJoOpUPJSuPPVdZ/JRwBVX1uqj4A/37A9nhZwVoIxucIfn70
 V03MD7YC2l0tA1GYTu0HJbhzvwpPIksKCy/e3FPPszDiO2OuiXDY2VV3K1eYicYiOOZVKW/odnj
 +bU4oj4aihHJ7kOLu5oXb3Bwgr43OYEJyetNeBTe0KU8gXNR7Uld4H6/R6t1XTIIjXYvBuV2sKP
 SGcAnpa16dm5/m97NZuTGzxia9yDUAOII6eCUm5hRajznIyWWcSSic7iBQ==
X-Google-Smtp-Source: AGHT+IH8d5Up5I3Oi5obS1Yj3LB/bGpH6V9o6VCt3LQ8DdFlFFRB1AfNxo0oPvNTklIARhGSoWk9mA==
X-Received: by 2002:a05:6e02:2683:b0:3d8:1ea5:26d1 with SMTP id
 e9e14a558f8ab-3d89417e663mr175514815ab.18.1745335071323; 
 Tue, 22 Apr 2025 08:17:51 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb971sm2365049173.29.2025.04.22.08.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:17:51 -0700 (PDT)
Message-ID: <9ac45fe6-70f2-409e-9c63-124e3987220a@sifive.com>
Date: Tue, 22 Apr 2025 10:17:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] board: starfive: visionfive2: Drop setting of
 $fdtfile
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
References: <20250422064541.635210-1-e@freeshell.de>
 <20250422064541.635210-3-e@freeshell.de>
 <e909b829-e7da-4059-9f65-b83e097929bf@freeshell.de>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <e909b829-e7da-4059-9f65-b83e097929bf@freeshell.de>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 2025-04-22 5:07 AM, E Shattow wrote:
> Oops should have compiled before sending.
> 
> On 4/21/25 23:45, E Shattow wrote:
>> Remove board detection logic from main payload that is duplicated from SPL
>> and do not set convenience data into $fdtfile environment variable. U-Boot
>> "starfive visionfive2" board target(s) now boot on recent upstream Linux
>> Kernel releases without this manipulation since the JH7110 OF_UPSTREAM
>> migration. Changes to $fdtfile by users (i.e. following newer or older Linux
>> Kernel releases) should follow the advice in general U-Boot documentation.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  .../visionfive2/starfive_visionfive2.c        | 61 -------------------
>>  1 file changed, 61 deletions(-)
>>
>> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
>> index b8cd509bc89..039a32f1874 100644
>> --- a/board/starfive/visionfive2/starfive_visionfive2.c
>> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
>> @@ -17,14 +17,6 @@
>>  DECLARE_GLOBAL_DATA_PTR;
>>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
>> -#define FDTFILE_MILK_V_MARS \
>> -	"starfive/jh7110-milkv-mars.dtb"
>> -#define FDTFILE_VISIONFIVE2_1_2A \
>> -	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>> -#define FDTFILE_VISIONFIVE2_1_3B \
>> -	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
>> -#define FDTFILE_PINE64_STAR64 \
>> -	"starfive/jh7110-pine64-star64.dtb"
>>  
>>  /* enable U74-mc hart1~hart4 prefetcher */
>>  static void enable_prefetcher(void)
>> @@ -45,51 +37,6 @@ static void enable_prefetcher(void)
>>  	}
>>  }
>>  
>> -/**
>> - * set_fdtfile() - set the $fdtfile variable based on the board revision
>> - */
>> -static void set_fdtfile(void)
>> -{
>> -	u8 version;
>> -	const char *fdtfile;
>> -	const char *product_id;
>> -
>> -	fdtfile = env_get("fdtfile");
>> -	if (fdtfile)
>> -		return;
>> -
>> -	product_id = get_product_id_from_eeprom();
>> -	if (!product_id) {
>> -		log_err("Can't read EEPROM\n");
>> -		return;
>> -	}
>> -	if (!strncmp(product_id, "MARS", 4)) {
>> -		fdtfile = FDTFILE_MILK_V_MARS;
>> -	} else if (!strncmp(product_id, "VF7110", 6)) {
>> -		version = get_pcb_revision_from_eeprom();
>> -
>> -		switch (version) {
>> -		case 'a':
>> -		case 'A':
>> -			fdtfile = FDTFILE_VISIONFIVE2_1_2A;
>> -			break;
>> -
>> -		case 'b':
>> -		case 'B':
>> -		default:
>> -			fdtfile = FDTFILE_VISIONFIVE2_1_3B;
>> -			break;
>> -		}
>> -	} else if (!strncmp(product_id, "STAR64", 6)) {
>> -		fdtfile = FDTFILE_PINE64_STAR64;
>> -	} else {
>> -		log_err("Unknown product\n");
>> -		return;
>> -	}
>> -
>> -	env_set("fdtfile", fdtfile);
>> -}
>> -
>>  int board_init(void)
>>  {
>>  	enable_caches();
>> @@ -98,14 +45,6 @@ int board_init(void)
>>  	return 0;
>>  }
>>  
> 
>> -int board_late_init(void)
>> -{
>> -	if (CONFIG_IS_ENABLED(ID_EEPROM))
>> -		set_fdtfile();
>> -
>> -	return 0;
>> -}
>> -
> 
> 
> Need to keep board_late_init() or compile fails. Will fix in v2.

Alternatively you can drop the "select BOARD_LATE_INIT" from arch/riscv/Kconfig.

Regards,
Samuel

>>  int board_fdt_blob_setup(void **fdtp)
>>  {
>>  	if (gd->arch.firmware_fdt_addr) {
> 
> -E

