Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7ACD0D795
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CDB892AB;
	Fri, 11 Oct 2024 16:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="emJ+BqpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8056289313; Fri, 11 Oct 2024 16:27:46 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4FD890FD
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539908f238fso2593897e87.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728656864; x=1729261664;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8tPzDQ3yNf2/u+zHzM87MQYs1WKmKzvXQR/W6TdTyck=;
 b=emJ+BqpH7cUjPboyAf0iF+EwHRYmsps0eZGBB75lHa35mQX6C6bz0pHfXt34IvDhx5
 VT3KClHVeX/uJoXUmsJ0UT5dj0LiKbXnEP/lq4lQMIIzfFzR5LFOqHEuN4IA0mgCbfTK
 q3okWQvZYzGoE77oZfUSBIRRe8whEvDZr7C+ZhPkH4XPD4C5Iq4C3wrrekp2DTcTzTRy
 U695eQZsnFRjpVleagdX0OsGc060pttDFbU3B/HqTD8UZsm+z4jxzLaXki6Jcl1JTITY
 OGtn+VA28Xr1UTfilGQwLJLcjrINSIBdY8nQ4xYD03ZxVBZWl/7ZYrgGUUDIrq5e/I3p
 ikOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728656864; x=1729261664;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tPzDQ3yNf2/u+zHzM87MQYs1WKmKzvXQR/W6TdTyck=;
 b=cMW6HAhot5CdGqEUr3tjU/hfLEf0/T6Atn3MUrvWB7i1co/StayTwfZagq0nGXEQmf
 p752ye4RDPzqDDJ0jgqPM5N+LFTHxH9PAoUvh4EQuyBpthjZ8lvnoIbmuyKj9Ufn3IJ3
 zVs7C04DHm4XceiJ/J1VMZgAIywmVALtysrw26kwC481flFizjGUu2JxUrxoMMeDlD4J
 WX3T3tqjMJqbfXOeF6uTGrOwTaGOJ28dh17NSkkF2aZALK73n1/hqbBFWiMjsNeb3ygz
 2Mnw6ZDQkVvdHur7q9aoOPXkyIf4IeyZCVAAayIMvdr5vDtyymBMTDmdgYPOdKUunV5/
 AxqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1tb8upAVAdQL8HCrGhcYhDrWhPBO4W1+H/3DtaIM/RDTaCClD7A8445yobTJHvKFqBboU0zY=@lists.denx.de
X-Gm-Message-State: AOJu0YxWs6VrmNVaDS0hvWTe2dWt0jnQWPjEqR9CKq3LPEwhyupU5auD
 MLVrx66sGgC7THAC6kMvs3ao9aBv+/kfFMdSHTIL8PxQ3HyXBxRNtfe+aF3EZdc=
X-Google-Smtp-Source: AGHT+IFFI+/ZTHvx3U5CYHLeevarOAuz37XMlFelvxPLJ7T0D3IidMQFF8RieNUT+JY8t9rjjdkIfg==
X-Received: by 2002:a05:6512:4488:b0:539:e0fa:6efa with SMTP id
 2adb3069b0e04-539e0fa6fb9mr1179719e87.44.1728656863606; 
 Fri, 11 Oct 2024 07:27:43 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6a8227sm4075852f8f.17.2024.10.11.07.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:27:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Simon Glass
 <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mark Kettenis
 <kettenis@openbsd.org>, u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] sandbox: add bootmethod EFI boot-manager
In-Reply-To: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
References: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
Date: Fri, 11 Oct 2024 16:27:40 +0200
Message-ID: <875xpyhfz7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heinrich,

Thank you for the patch.

On mer., oct. 09, 2024 at 00:32, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> The EFI boot-manager is the default method to boot EFI binaries.
> We should be able to use it on the Sandbox.
>
> * Enable EFI boot-manager bootmethod on the sandbox.
> * Adjust unit tests to reflect the additional boot method.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  arch/sandbox/dts/test.dts |  4 ++++
>  test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 8412506c17a..1248ed66089 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -119,6 +119,10 @@
>  			compatible = "u-boot,distro-efi";
>  		};
>  
> +		efimgr {
> +			compatible = "u-boot,efi-bootmgr";
> +		};
> +
>  		theme {
>  			font-size = <30>;
>  			menu-inset = <3>;
> diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
> index 518d99c4a27..fe175ccb755 100644
> --- a/test/boot/bootmeth.c
> +++ b/test/boot/bootmeth.c
> @@ -21,11 +21,13 @@ static int bootmeth_cmd_list(struct unit_test_state *uts)
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline("    0    0  extlinux            Extlinux boot from a block device");
>  	ut_assert_nextline("    1    1  efi                 EFI boot from an .efi file");
> -	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
> -		ut_assert_nextline(" glob    2  firmware0           VBE simple");
> +	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
> +		ut_assert_nextline(" glob    2  efimgr              EFI bootmgr flow");
> +		ut_assert_nextline(" glob    3  firmware0           VBE simple");
> +	}
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
> -		 "(3 bootmeths)" : "(2 bootmeths)");
> +		 "(4 bootmeths)" : "(2 bootmeths)");
>  	ut_assert_console_end();
>  
>  	return 0;
> @@ -56,11 +58,13 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline("    0    0  extlinux            Extlinux boot from a block device");
>  	ut_assert_nextline("    -    1  efi                 EFI boot from an .efi file");
> -	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
> -		ut_assert_nextline(" glob    2  firmware0           VBE simple");
> +	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
> +		ut_assert_nextline(" glob    2  efimgr              EFI bootmgr flow");
> +		ut_assert_nextline(" glob    3  firmware0           VBE simple");
> +	}
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
> -		 "(3 bootmeths)" : "(2 bootmeths)");
> +		 "(4 bootmeths)" : "(2 bootmeths)");
>  	ut_assert_console_end();
>  
>  	/* Check the -a flag with the reverse order */
> @@ -71,11 +75,13 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline("    1    0  extlinux            Extlinux boot from a block device");
>  	ut_assert_nextline("    0    1  efi                 EFI boot from an .efi file");
> -	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
> -		ut_assert_nextline(" glob    2  firmware0           VBE simple");
> +	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
> +		ut_assert_nextline(" glob    2  efimgr              EFI bootmgr flow");
> +		ut_assert_nextline(" glob    3  firmware0           VBE simple");
> +	}
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
> -		 "(3 bootmeths)" : "(2 bootmeths)");
> +		 "(4 bootmeths)" : "(2 bootmeths)");
>  	ut_assert_console_end();
>  
>  	/* Now reset the order to empty, which should show all of them again */
> @@ -84,7 +90,7 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
>  	ut_assertnull(env_get("bootmeths"));
>  	ut_assertok(run_command("bootmeth list", 0));
>  	ut_assert_skip_to_line(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
> -		 "(3 bootmeths)" : "(2 bootmeths)");
> +		 "(4 bootmeths)" : "(2 bootmeths)");
>  
>  	/* Try reverse order */
>  	ut_assertok(run_command("bootmeth order \"efi extlinux\"", 0));
> @@ -116,7 +122,7 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
>  	ut_assert_nextline("Order  Seq  Name                Description");
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline("    0    1  efi                 EFI boot from an .efi file");
> -	ut_assert_nextline(" glob    2  firmware0           VBE simple");
> +	ut_assert_nextline(" glob    3  firmware0           VBE simple");
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextline("(2 bootmeths)");
>  	ut_assertnonnull(env_get("bootmeths"));
> -- 
> 2.45.2
