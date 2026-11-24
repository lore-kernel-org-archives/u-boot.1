Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6755606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aVi1KPFx;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PR3NllAJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E91080E13;
	Tue, 24 Nov 2026 18:15:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C94FKLHz_-la; Tue, 24 Nov 2026 18:15:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92F6D80E04
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795544143;
	b=My5oxEU8Sr5OrOVPKxQkW2cUV/2kRt1l842zUYY4CAmooevbmUCPUfUqIPt8hQU+CPEy
	 55TWXVLEqIeK5varGqxzpJeep155+oQ63uXH5+tg8Dw32yl71c7UDrzcCND0GgDOY1+2T
	 my5g3UeTKavinRCE/iW1OgIpTfex06ymI6G7dCvxaZpuo7j/Q77P9SCrbvZXBjh4b6nnL
	 o47HiymdlsneTNy2anf90FZZGcekJUmFr0Z5ycb0dfMIEoFttlR1rFfD3CsH/E34X/ZLu
	 nyK/hKAqXX1cWBPf/6Cr1y/24Wk9fTK96EFQxvzuWYbL4LjJpah6fI9QVs0OCxtGEnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795544143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IvvTOuRwT5GyzLykU0nZPEqiCwsR75VyEJ2Q0+8mgrs=;
	b=ApReis9LVEq6kou3aA+iY/nE7xpWTRr/rR6sobRvyM/lh+l9CErS4Qgne4gavhcZjShW
	 BW3ChNO3RL4y9CEH85+K3A+DEAOFqp5QSUMejWmSlGolP+7lT0f+L/O7tIEiayGGD5Cp9
	 7MNPOORfhaAEM1z79xFjvRnBOxJK2XKQZER2yXr221fa68g8UCZqSoibCEFqJsjOqjNb0
	 tFxwmT6bwHXsyk6A0YWMuy28gN94P12TX9mpHjhDY7aZd4zEjPfmnPiyWbkexAEa/GeEK
	 fXj8hmaqkcjRkn/wNTTzMBUwSfDfbPBzAejNL4oP0ZU9PCAUrN7MloOBCILPF1h9rbQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795544143;
	bh=IvvTOuRwT5GyzLykU0nZPEqiCwsR75VyEJ2Q0+8mgrs=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aVi1KPFxlJl4JzHcEj+7m8ycqhiQlMQdwGSRlSlLhUU5vqbzLQ47AUsXYcvqKz9Ng
	 KZxu1CykC9+jsJENwsOvcQjACBPL6U7FhpJpveBUloEE/nbQ/0Ut8ocojNM4ckNFIp
	 eNUJYr6MLEPgNnqlJE/8XXlvssJTPOFAEtjDOK5uPOcpyDvL6N6tECXbEyhHPRrC3K
	 wePesWdkaBopRg4XajOawD9BPBOvN7vQuSItHwBSLEL1RTayZB7lEvwno7z5ONAk64
	 xLanhfBIx8YKaD4WW3OaM5QMCGIZ7k/lKcmS7w9j+xSSokBMQOZkiZ5l3S+Coe9w8+
	 9mEx7NUjNaFGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92F6D80E04;
	Tue, 24 Nov 2026 18:15:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB9D83A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1E2F40565
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jbohwh4AIWjj for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:15:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7110040541
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PR3NllAJ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7110040541
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:15:39 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jYrZw5975zMlJ7;
 Tue, 24 Nov 2026 19:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795544136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvvTOuRwT5GyzLykU0nZPEqiCwsR75VyEJ2Q0+8mgrs=;
 b=PR3NllAJx4DNYdEFk6Xz2FWujAq1mWoilzjaFJ4kXiOhU0J7GXyrP4xTO6g5fFQifprRce
 ceYvWO7toEe9cRSi7jEQ2nu8dFIEIqco2cC7mnQ7ZbMp0NRVQZ2oLoTGd5AMN/DJGoQg4O
 q/8gEEVUHwrbx8VEDcfxc2CzEdETSyh9FnnEmja1Og63s2xut62qodw6zZjejLuNID+8nK
 RSXoSl8XDDOvdKcxCVB+UVt3ZrsZoP+mW6MeNsN3LZAvkgPSFkuzltvMZsm+HsyGnr+jW3
 U2fesUB0iquyeM8NJDOuI1j95I2Qy2pVDjOiS3q5Xh+e8sSiuPnY6RdGsytFzQ==
Message-ID: <3dc6575e-792a-4e51-83fa-fcb64ff880c5@mailbox.org>
Date: Tue, 24 Nov 2026 15:51:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: renesas: Reduce size on Renesas R-Car Gen3
 Salvator-X(S) again
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261124142648.947401-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261124142648.947401-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 207ff23f89beeafbbae
X-MBO-RS-META: oi1w9kek7uy98gqbwy8rg7q4npanzy6f
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 3:26 PM, Tom Rini wrote:
> To save even more space, as it is an issue again, disable the expanded
> help text for commands.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   configs/rcar3_salvator-x_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
> index 50bfa1853241..3a51886fcf2b 100644
> --- a/configs/rcar3_salvator-x_defconfig
> +++ b/configs/rcar3_salvator-x_defconfig
> @@ -31,6 +31,7 @@ CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadadd
>   CONFIG_DEFAULT_FDT_FILE="r8a77951-salvator-x.dtb"
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=10
> +# CONFIG_SYS_LONGHELP is not set
>   CONFIG_CMD_DFU=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y

Where did this show up ?

I don't want to disable longhelp, that is a really bad user-facing change.
