Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D91C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FCE80079;
	Fri, 16 May 2025 13:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747395573;
	bh=T//UCVQNFMa0OlGh7AxSz1Qf1IWtyYCUM8mn4s5+eAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yMP1hIVxpeq5sGTY3OPzmjUYQOEwB89VK9M+afZydF/51qMiCUwNcuh1eU86IFyIL
	 O26D2C2LamDov1BaT/CJgwvXmGaNhIuQ/qFr7ZzjWb3qP+h4eHBZpWXdwwiks/yzpt
	 h8EKuB4SnTsFDZkMVO0PJafu72ExRe0pl3FgGf9vkMKbWDtTf9lQeR/j4gdyp518mi
	 4ac8aiY5clB1aTfA6QsGpqfcPddokXV6TDGtsz4XvZhaCMMs96ySvwMu85ArAkgmWb
	 L+lFKJPug9Id4hJ78rH+9agfxku0jcy2KGz2uEzZOOVTz1u6xeFPKoF2zfFRMP0x+v
	 VT98xqFNWeYLw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8C580107; Fri, 16 May 2025 13:39:32 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AC98006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZzQ8w3svGz9tMB;
 Fri, 16 May 2025 13:39:28 +0200 (CEST)
Message-ID: <c319b4ca-d439-4687-8cd7-c3153b68b48d@denx.de>
Date: Fri, 16 May 2025 13:39:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: tlv_eeprom: return after successful read from EEPROM
To: Martin Schiller <ms@dev.tdt.de>, u-boot@lists.denx.de
Cc: trini@konsulko.com, josua@solid-run.com
References: <20250416061316.1348271-1-ms@dev.tdt.de>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250416061316.1348271-1-ms@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZzQ8w3svGz9tMB
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

On 16.04.25 08:13, Martin Schiller wrote:
> Commit f6eff35b8c19 ("cmd: tlv_eeprom: handle -ENODEV error from
> read_eeprom function") removed the needed 'return 0' after a successful
> read. As a result, the usage message is shown when 'tlv_eeprom read' is
> successfully called.
> 
> Let's fix it by adding the needed 'return 0'.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   cmd/tlv_eeprom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
> index 0aec7521770..d7c229e5441 100644
> --- a/cmd/tlv_eeprom.c
> +++ b/cmd/tlv_eeprom.c
> @@ -476,6 +476,7 @@ int do_tlv_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   
>   		printf("EEPROM data loaded from device to memory.\n");
>   		has_been_read = 1;
> +		return 0;
>   	}
>   
>   	// Subsequent commands require that the EEPROM has already been read.

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

