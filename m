Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19356C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 22:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645578144A;
	Sun, 27 Aug 2023 00:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O6oUmX22";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rx2T7u/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9797482BBF; Sun, 27 Aug 2023 00:29:15 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8D381420
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 00:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RYBLw5tBfz9t6W;
 Sun, 27 Aug 2023 00:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbAl92T++5LtEvWFLmPPgKRNZkOrHPgjI3sHqq++TWU=;
 b=O6oUmX22fIaPAvlZyV+UsmstdRoYn+ptrr5ERzroxlbVLd/R5YImAjLpXOZxhLAIqHsv8k
 dds0ejA6SdkUPcJlbD+qwdi+WOsuD0ccens/kjz2dZWGD7R1KflreUUn4/LUC2NXzzskuk
 pcwp7hLczlRSwkkFOYM1d7XjlOHowFHFYG2iiH+hxVwX+yV60G2AmMi47Em4KsFVJE05/A
 ydESWuju65iPUAcqqn4nSA3u5sgeeW8xsCXPAxzC1BO4rr5V93eV1Np0+6iQR3sUxnISFq
 ui/ftV0G4jvSC8UKe6An1BqgzF1tncstO8YZm3xt0MOzMyl98CFLZyY0Jkx00w==
Message-ID: <8eb81e26-acfa-db20-2a23-ca95b9f3d4c3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbAl92T++5LtEvWFLmPPgKRNZkOrHPgjI3sHqq++TWU=;
 b=Rx2T7u/ktC9RlLUOotUlqVCazJNjZnQRg8/PYMOKUKVyRfZGBKmg4KfSjlyk1i5YnLWG8C
 B0Nwtblvhb8++ZKqugK5g8UJpCp+s0QUzPXdhw0Da/u4KAmrlSCPqrkvPbU343xKiCcUA3
 +UmktMt3m/5uByOUi9nIexQwzmLgKrxSOECXIVsw3sw73WWiGtb5Ngwoxc6K1K80cbfrqN
 IUC/0/jnNQhdZW3ZxElkIv+UJR5C5jU6+avnwDOZNzPMuUcrshm9IIExEW2Zg62R3CyZ9V
 TNsE1pyNprGBlpnEaloZ2SAbeIthy4MfpCrXr6nsqKHAN/DSfGJM91nr6c8eaw==
Date: Sun, 27 Aug 2023 00:29:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] tools: relocate-rela: Add M68K support
Content-Language: en-US
To: Angelo Dureghello <angelo@kernel-space.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angelo Durgehello <angelo.dureghello@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Simon Glass <sjg@chromium.org>,
 Zong Li <zong.li@sifive.com>
References: <20230730222051.227660-1-marek.vasut+renesas@mailbox.org>
 <7413294c-068f-f0ea-8247-8b8ea414a6c5@kernel-space.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7413294c-068f-f0ea-8247-8b8ea414a6c5@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11ff38a9ca2d5a68f6b
X-MBO-RS-META: its51rzo913ap8of68sdxa3sixxhy7re
X-Rspamd-Queue-Id: 4RYBLw5tBfz9t6W
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

On 8/26/23 09:44, Angelo Dureghello wrote:
> Hi Marek,
> 
> thanks a lot for the job i should have done.
> 
> Tested on real hw:
> 
> m5282evb   worked out of the box
> mcf54415   not working,
> had a lot of unsupported relocation type for R_68K_JMP_SLOT
> mcf5307    need to fix the hw, will do in short
> 
> i had to add this fix:
> 
> diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
> index 2d008c7f60..9722a6291a 100644
> --- a/tools/relocate-rela.c
> +++ b/tools/relocate-rela.c
> @@ -40,6 +40,10 @@
>   #define R_68K_GLOB_DAT         20
>   #endif
> 
> +#ifndef R_68K_JMP_SLOT
> +#define R_68K_JMP_SLOT          21
> +#endif
> +
>   #ifndef R_68K_RELATIVE
>   #define R_68K_RELATIVE         22
>   #endif
> @@ -531,6 +535,9 @@ static bool supported_rela32(Elf32_Rela *rela, 
> uint32_t *type)
>                  case R_68K_RELATIVE:
>                          debug("R_68K_RELATIVE\n");
>                          return true;
> +               case R_68K_JMP_SLOT:
> +                        debug("R_68K_JMP_SLOT\n");
> +                        return true;
>                  }
>          } else {
>                  switch (*type) {
> @@ -631,8 +638,9 @@ static int rela_elf32(char **argv, FILE *f)
>                                  return 4;
>                          }
>                  } else if ((machine == EM_M68K &&
> -                           (type == R_68K_32 || type == 
> R_68K_GLOB_DAT)) ||
> -                          (machine == EM_MICROBLAZE &&
> +                           (type == R_68K_32 || type == R_68K_GLOB_DAT ||
> +                            type == R_68K_JMP_SLOT)) ||
> +                           (machine == EM_MICROBLAZE &&
>                              (type == R_MICROBLAZE_32 ||
>                               type == R_MICROBLAZE_GLOB_DAT))) {
>                          /* global symbols read it and add reloc offset */

Wrapped into V2, thanks
