Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC3606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kQ8ePwHA;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpQayatJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 563CD40A55;
	Sat, 28 Nov 2026 07:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQrCwvlZ-RHs; Sat, 28 Nov 2026 07:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7889940A20
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795852727;
	b=kbusTTn3R74TL+15UktuQU6w8jq0ZjBPOUVRvxjN5zzTnOj922vqCZZ9OUY/RDLt7eWl
	 NGZJ+t/Te7PW9IC7e9pyiGw2Jru5tc/FrlG6yAb3mi6Vh0j88qR6T0MmAk+btquzKX/Lc
	 zCAPSM2WojHRxhVUWeitULXUwpSWFFIEnp0x121fKrH7nJJ7gv+qQi4Ubz5iTqozGuJrx
	 lv8rTyA5IJWPRYb8ELfWO1emGYxMixDnzzXHOSub+NMhaBTZ+jjZk8oOdKGXuJfZ/9XRH
	 Rl0XTVk/aGvI+Dw2fbaQSbyXhC0e5c6EHUUk/kz9Q5wpcz5c2iKNU8x2jm6VhmWCCBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795852727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gyV2q9CFWJePWjpwXmDBM63/eMJRqz65wXTYCIUa2Q4=;
	b=UrX5pWLCOBu2ZKGBkyEqCxzUKcSi4IHzxBgjhaXu6LVN/TvzcH2C1QP9siXAW4mcWJio
	 lpZlb4KiRaGKrg0okaKV/U4p5UNwE67HctSUe8q/X7dGH7UclAthK04B8/NMKurZGeypw
	 6hKCW+yFsKbHYP8VMuBi6OFNkSuP4oMGGABBE1dcr5VoD1QnZM+oeAZjEAcelJAHz7k4t
	 nvMKcN58BCgQMThNqQJ1B3yijT/LQ6jrCcXQBhZNBQ+SaZ23nh/9+VCZ+A/azFjS9XuYm
	 kMCBGdXhmHXy2pGM+2c62AMxwdE18A1S3bUmKarw4XmVnRpyZeTQ+9UjeF4TniLc9ew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795852727;
	bh=gyV2q9CFWJePWjpwXmDBM63/eMJRqz65wXTYCIUa2Q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQ8ePwHAncEvwhdXrsxIChICIStkkAIthfuAplsyfp6ap6O0pcu+Lw0l1TSKkfBCH
	 nfcbYzNFmDT58GHqpZv1XtZZIgcvxNohd3SoC3Oga5CFu9g07gAxi0A9nviiArYMjM
	 clMEjh/bkyTGnbGNN53/g8rLBo4D3nIkw8oqRohtebrDvAEsCWJicHyCkS9O3dfa5p
	 E1HssDaBbLM3NcX4kEvNxViXbZUPNtvtIi9KrStHmg2Pbjvdi1fV917VZB4pKmeJhE
	 0/uP1iThCR6HMdi1xvGjAYwfa/afC3NrP3pHi2dISOQTMe3dlOA8uAQiSUg9xGKiTi
	 KJ+bouvPsz4tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7889940A20;
	Sat, 28 Nov 2026 07:58:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23EC22BD
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 219B080AE6
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gs5C_A5xW5yc for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:58:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B9AF809D3
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=chleroy@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lpQayatJ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B9AF809D3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:58:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B85B34110D;
 Sat, 28 Nov 2026 07:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE91F00897;
 Sat, 28 Nov 2026 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795852723;
 bh=gyV2q9CFWJePWjpwXmDBM63/eMJRqz65wXTYCIUa2Q4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lpQayatJa9+r/AC22WiG0NiPF7nfdQeBIP+9YOLGWHQaj6jfieUH9TJC8sRdM5Eyc
 d7bFlFqS9azz2vz2+hYJ1Jm85TMWYx363T4LdTvSdJn6VET5iTQ+f3BErMQjCDVimc
 9t4VoIMfGSSdzlVll+ii3fEF9bhCrTGeEHAXjdbDfp/8N8D8BSCkkbQssOAVo3qB0m
 34Rkdy3beBVaSvKnW8H/KESWEsuhWjL/kqxJOiq2oVbWKpJogGUDmvasLjGny7N8bo
 vMRN67eYZfaNoU1GVr+qNlFeYSrBzQbcX3ymg/YjX5mJ7TOkLfXbyPyMnr4ke9Ohzd
 OoNI+Agnj1rNg==
Message-ID: <4f21c935-d892-49a7-97c5-79ff1863949b@kernel.org>
Date: Sat, 28 Nov 2026 08:58:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: mpc8xx: cap SMC receive buffer length
To: Jaeyeong Lee <lee@jaeyeong.cc>, Bradley Morgan <bradley.morgan@linux.dev>
Cc: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
References: <179024275173.70674.16356876476594066413@proton.me>
 <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
 <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
 <179582176494.3807001.3645437772294577275.u-boot-v2@jaeyeong.cc>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <179582176494.3807001.3645437772294577275.u-boot-v2@jaeyeong.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 28/11/2026 à 00:22, Jaeyeong Lee a écrit :
> [Vous ne recevez pas souvent de courriers de lee@jaeyeong.cc. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The MPC8xx serial object starts at DPRAM offset 0x800 while the SPI
> receive descriptor starts at 0x840. The serial receive buffer begins
> after two buffer descriptors and an index, and is followed by the
> transmit byte.
> 
> Cap SYS_SMC_RXBUFLEN at 32 for all configurations. This keeps the
> complete serial object below the SPI descriptor area without coupling
> the serial configuration to the SPI driver. Document the constraint
> next to the DPRAM layout.
> 
> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F179024275173.70674.16356876476594066413%40proton.me%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2d5b319bd5914182870c08df4cdd659c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639314185942705112%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=omHx0MG55AZhTdYuPm02i%2FExRbhgXMDawNlMkBZP5u8%3D&reserved=0
> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Changes in v2:
> - Cap SYS_SMC_RXBUFLEN at 32 regardless of whether SPI is enabled.
> - Drop the static assertion and document the limit near CPM_SPI_BASE.
> 
>   arch/powerpc/include/asm/cpm_8xx.h | 1 +
>   drivers/serial/Kconfig             | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/cpm_8xx.h b/arch/powerpc/include/asm/cpm_8xx.h
> index 98476cdf304..1bb44c9ab34 100644
> --- a/arch/powerpc/include/asm/cpm_8xx.h
> +++ b/arch/powerpc/include/asm/cpm_8xx.h
> @@ -53,6 +53,7 @@
>    */
>   #define CPM_SERIAL_BASE                0x0800
>   #define CPM_I2C_BASE           0x0820

We might have the same problem with CPM_I2C_BASE. But CPM_I2C_BASE is 
nowhere used, last user was removed by commit 7ffce4f17fdb ("i2c: 
powerpc: Remove use of CONFIG_HARD_I2C").

So I suggest you to send another patch to remove CPM_I2C_BASE and also 
BD_IIC_START which hasn't been used since commit d6b11fd1f0ef ("powerpc: 
remove MBX and MBX860T boards support")

> +/* SYS_SMC_RXBUFLEN is limited so the serial buffer stays below this. */
>   #define CPM_SPI_BASE           0x0840
>   #define CPM_FEC_BASE           0x0860
>   #define CPM_SERIAL2_BASE       0x08E0
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ebc251d891..d4cf6f87c9e 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1201,6 +1201,7 @@ config SYS_SMC_RXBUFLEN
>          int "Console Rx buffer length"
>          depends on MPC8XX_CONS
>          default 1
> +       range 1 32
>          help
>            With CONFIG_SYS_SMC_RXBUFLEN it is possible to define
>            the maximum receive buffer length for the SMC.
> --
> 2.43.0
> 
> 

