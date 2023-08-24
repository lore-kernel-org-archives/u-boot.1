Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0F0C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6272986517;
	Thu, 24 Aug 2023 02:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XPD4wIL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7593286505; Thu, 24 Aug 2023 02:11:46 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E62C864FA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 02:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bc57401cb9so824082a34.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692835902; x=1693440702;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoB84X7Lng0Zfg+MPJekL65qTm9JzWNhLRGTvZE4p7U=;
 b=XPD4wIL3gYhnyyHScunHtBs3cuuu+1gO8aR1fRhEfi2L2p9Zg3fVj4M19xy1kZW5+s
 dNCfmPKeEqr/2D74gsG9yPgHjF+v7m3bCIm4DS0J6XsWMR2zDedMRchiK/ks528Khjod
 PMk4TLxil9aWLNoaFy3UfZ3SnGqEi7BfJAZHpcE5AsoZbduiTYzz+b+M4RL6jjD2EBLN
 7aUf05EKIX7m2qzfTf0uhhYAqF4NV5RElkaXLuPktrb80S1t45wq6OuScypiUNSsNZrk
 l50v2CQBwtOvfw7iJz04osZX810dstrqO0ciuRKdhNR8I55k9BPSi4nxdMvlbQHwekuH
 SJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835902; x=1693440702;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qoB84X7Lng0Zfg+MPJekL65qTm9JzWNhLRGTvZE4p7U=;
 b=JZLzhi4DX5wDpWG6MEywu1QbgrN7WSYicbrzcl+5W5QT41SqCghPVtmfBaJW4MtaiK
 5SHWNB3dAqg1QgcQDMf9Mn44KG+3nBimTNhnJ84+krRIM7GRZfGmZvj+j0lria183Y/o
 R6pQ+AvGb7Y5cIudnYlXIT3MYuDYBv4GX0vH4u5QrJ+/o+eC/mGkfSd67RzJYt+0sQaB
 Gia+XpOcutTVmjqtSAKokeY1HWiZ2J+E4K+mze5xe9joeJjpJMoNkskzw1hKcD2yHczz
 5RLqq5+brwgXggWYOw1FRFcb3l2NOw9pnSj0hHY8AzIOI9eTHIC5jR0SpYPQEFHJpLFU
 GUrg==
X-Gm-Message-State: AOJu0YxRqcNYLaCUSuqd+t3/VKRzw/wHRVUvVGsTRJzlPypoM1fwGYju
 kVFpo1qIbwiOTp1oFgMtvCzUkQ==
X-Google-Smtp-Source: AGHT+IHjoPJGVpq3E8YlidM8QlKfegrk6Tpk4egLKPH8+U+QXBULHjqxKDajhufAXMddUirVPFu9DQ==
X-Received: by 2002:a05:6359:d27:b0:133:8e:4513 with SMTP id
 gp39-20020a0563590d2700b00133008e4513mr9071186rwb.0.1692835901683; 
 Wed, 23 Aug 2023 17:11:41 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:97b2:8257:1926:eed6])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a63bf45000000b00563826c66eesm9099312pgo.61.2023.08.23.17.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 17:11:41 -0700 (PDT)
Date: Thu, 24 Aug 2023 09:11:38 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] cmd: efidebug: add uri device path
Message-ID: <ZOagOlRLw8cOsFM7@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
 <20230823083721.1318097-2-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823083721.1318097-2-masahisa.kojima@linaro.org>
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

Hi Kojima-san,

On Wed, Aug 23, 2023 at 05:37:19PM +0900, Masahisa Kojima wrote:
> This adds the URI device path option for 'boot add' subcommand.
> User can add the URI load option for downloading ISO image file
> or EFI application through network(e.g. HTTP).
> 
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 0be3af3e76..62f867df2a 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -829,6 +829,44 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>  			argc -= 1;
>  			argv += 1;
>  			break;
> +		case 'u':
> +		{
> +			char *pos;
> +			int uridp_len;
> +			struct efi_device_path_uri *uridp;
> +
> +			if (argc <  3 || lo.label) {
> +				r = CMD_RET_USAGE;
> +				goto out;
> +			}
> +			id = (int)hextoul(argv[1], &endp);
> +			if (*endp != '\0' || id > 0xffff)
> +				return CMD_RET_USAGE;
> +
> +			efi_create_indexed_name(var_name16, sizeof(var_name16),
> +						"Boot", id);
> +
> +			label = efi_convert_string(argv[2]);
> +			if (!label)
> +				return CMD_RET_FAILURE;
> +			lo.label = label;
> +
> +			uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> +			fp_free = efi_alloc(uridp_len + sizeof(END));
> +			uridp = (struct efi_device_path_uri *)fp_free;
> +			uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +			uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> +			uridp->dp.length = uridp_len;
> +			strcpy(uridp->uri, argv[3]);
> +			pos = (char *)uridp + uridp_len;
> +			memcpy(pos, &END, sizeof(END));
> +			fp_size += uridp_len + sizeof(END);
> +			file_path = (struct efi_device_path *)uridp;
> +			argc -= 3;
> +			argv += 3;
> +			break;
> +		}
> +
>  		default:
>  			r = CMD_RET_USAGE;
>  			goto out;
> @@ -1492,6 +1530,7 @@ static char efidebug_help_text[] =
>  	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
>  	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
>  	"  (-b, -i for short form device path)\n"
> +	"  -u <bootid> <label> <uri>\n"

It might be a matter of personal preference, but
since the current syntax of efidebug is already much complex, 
I don't want to add more options unless it's necessary.
How about re-using "-B" option, say
   => efidebug -B 3 debian-netinst uri - https://foo.com/baa

BTW, I think that <bootid> and <label> should have been moved out of "-b|B"
when Ilias introduced this new syntax.

-Takahiro Akashi


>  	"  -s '<optional data>'\n"
>  	"efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
>  	"  - delete UEFI BootXXXX variables\n"
> -- 
> 2.34.1
> 
