Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B35C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 11:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E2F8402B1;
	Mon, 28 Sep 2026 11:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-qJ9lmAnIwT; Mon, 28 Sep 2026 11:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 87C4B405E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790594728;
	b=qdxcnV37GFek5XswvZxde7HXOhJkW5aP3DdLgHBpAx/RQ0lUuDPXkiDIFi3WMMBOouvX
	 YCOuu55ic1PMMqruQVAlPayp5w2toxbZaVeYueE/xllR7AHSbbxRJ16eI7ln7OvaV77og
	 m5AUg1oAZu00M4WSKk2sPFryqW5sVcrqb8X3SIR4mZEY9Qtx75P2YvznQHTaDGwSmjVQ4
	 naTVgnjKxPouGLdpgQ7i4AnNCFjfUmPw4iz80F/iiXamJqENGRtf515JJRzzknmB197To
	 HwQ8iPxrKomgGbMmxl4VlhmOTN+jf1HO61VtgTINLsox7fNUY20XeQPJegqoDqbsnKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790594728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0mbSI/+kA1LmOFESwoReINDdb1wccoIYrm8t1QlT6Ok=;
	b=MbSucsiOqt0EY+rmwrdx8oAucTeJq75zWACBtqozrW2AjSXhngs3VgOPDZY9ubLoggYx
	 UgwJr5DW2yg+vtafoOqnTc3yuCRGNDYXQ5ggZdqV7USBpBayKovH0MFyAuyMUDl6USk2U
	 fj17PGUUJPbiZj9HAf558JJ+2goiM85NFD1AlLmuJQJ1YExtZwT1bDCENGkE8XNQoKTK7
	 sbr8pHa2cztvnnFkpbNgj8dGiWOVc8UqvZBTpYGqTjgYXmI1xKMniRLYgCWw3EON/fcuL
	 gld5ggjj2UauRDSAoNdYenY1CPAj7eYWXpkTCO8pS9eGNYYnyqIKnc1a3qJjuNp+lgg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790594728;
	bh=0mbSI/+kA1LmOFESwoReINDdb1wccoIYrm8t1QlT6Ok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z/ECr2NKZasn2rCpl0DSgp/qzGZo/ZqWVcSgOJKhA8W8Q503RXR0nKF1PtruyWGIX
	 srVoeZNBR5OfM1JynZbrqYKXhkuRmJuRohOTaPX1liawijdrwNTO61HueGOfaYNdsQ
	 qNPvbs+M4nJ09ndodEwqjqUVgOSH7LLUpf6rl9EHVewzpB8lZbMMrEq8I1tWeeTYcL
	 VpU5cjSnC5Sc6GUPDZdGTKnx0sY0KrUTTJ12CC4U8pesXVPklU+4eduXNe5zgWBan5
	 /8Rtk9Ulwu3YUNpc0u8o3Fd0nxEPDNoHPq56n+F6xQ27grdkqjKhOzqPQ+6hUHQjWB
	 XXX2RhzdjkJAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87C4B405E0;
	Mon, 28 Sep 2026 11:25:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D3232F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 062A340063
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:25:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jq5-t9kbV9vT for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:25:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 216B8400DB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.157.188.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790594725;
 b=ov6yt2g7tBONzU21jCRL6pY2218XmTowXM4/WQ7GI456s+sy/6em2j03r3pPRlp4XUth
 TmkLMhAkLH/GICvztADEF4CWQbJuP/AS1rnsgA3xjVptd9HT4f4P4OBDjlytCxr1jGu/h
 6X4TJ42Mhg7AT1tCCz/16BpIXCGVc84OCne/9IMQGhqbEkdwkDqiCwDHmXLBwxpP2Q79P
 st8ptyDT0aFidHDhn6lXIi2E+/yComtRdt3cOzHamT/7yipjK/VlzLSq8fqC1LnH99Ykl
 Kh7qm/5BzuELaFY49tQnIDPSJ+6kqpOXCorvUTkCxmdV35/Ih1XIuj09i8jwlBDsz0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790594725;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=0mbSI/+kA1LmOFESwoReINDdb1wccoIYrm8t1QlT6Ok=;
 b=jWjukJ/9MyD72z3EVGQi8XztJQHt9Kj3pRVrrpukVN22MmWIVekjSJHcJAyr2JsoI+jV
 Lgzg+7FFKBS10O8a0bqymcgSBIe2VRmVvDlBW7xCRvM/syZS2gBM5l6/8C7zrzYjSknPl
 kajGGOIhTSo2NlzuPxoxtXvG2ntxDXLhm7UMvTOS2ixRYOl/kupGw1GORxIzTNOM2VbIt
 CkTHcX+dsR/dfirxR968UtFTTpm/Do1poyOsaVFQCpaCKsYpqna3YXs1GzJMroJj93A1f
 jMwnp6vGvuiBV4/ma4avbXOyhpwA78+r6I2bcULHC2nt7jxMcFyamVbrfO5cHzoQ+yA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Jri5rh0l; 
 arc=none smtp.remote-ip=45.157.188.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.12;
 helo=smtp-bc0c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Jri5rh0l
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 216B8400DB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:25:24 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4htdlH0jxgzT7l;
 Mon, 28 Sep 2026 13:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790593546;
 bh=0mbSI/+kA1LmOFESwoReINDdb1wccoIYrm8t1QlT6Ok=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Jri5rh0lIbHR+VS1du7R+vUhchQ+tj40ccIKQeXDx6CFU8Crz/y3ur6xXHxlkKkXM
 +RzZOHSb5f4TYYBdF9ahxoJi0bgVgXp/kvnR8q7iunLPimqJcqdJ0kagXegHXH4W2B
 eSem/+pgcKQpPyAGWgsMsx5xo7+r8DFgrYxVwUS/rpAH/3erNghiPxAJgL2ogwq9x7
 4PTHj6I5KUnJlggpE5eGiS8UWstOpXmnl/3E+NCLpm0xi0jz6J+mTD+jUwTMrCa3iy
 mGX8OP/bCFCijjeRTh0i1b+XT62JJHl43BInrWvA77WvJa6nR5hUY2Y91orxgi+96n
 1MAEjF8RBr1iQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4htdlF2ylrzMhW; Mon, 28 Sep 2026 13:05:45 +0200 (CEST)
Message-ID: <e06f10c2-88f3-42a4-932f-53a0ddc8389f@0leil.net>
Date: Mon, 28 Sep 2026 13:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Milivoje Legenovic <m.legenovic@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymondmaoca@gmail.com>
References: <20260926005853.1727-1-m.legenovic@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260926005853.1727-1-m.legenovic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Milivoje,

On 9/26/26 2:58 AM, Milivoje Legenovic wrote:
> After upgrading u-boot in Armbian for the Odroid M2 board from
> version v2025.10 to a higher version (it doesn’t matter which one),
> the board does boot, but the boot process halts for 60 seconds,
> and only continues once this time has elapsed. Debugging via a
> UART cable showed that u-boot hands control over to the kernel,
> and then freezes there. The only difference compared to v2025.10
> was the SMBIOS table. After disabling this configuration option
> everything worked perfectly.
> 

OK, but *why*. Without more information, we cannot fix the actual issue 
(whether it's in U-Boot or in Armbian's kernel) and it's bound to come 
back later, or people asking to reenable this because it broke their setup.

Adding Raymond in Cc, since they worked on this most recently, maybe 
they can help debug this.

Milivoje, can you maybe bisect U-Boot to figure out which commit(s) 
broke this? CONFIG_GENERATE_SMBIOS_TABLE is enabled in v2025.10 for this 
board, so something broke since and it would be best to know what.

Cheers,
Quentin

> Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> ---
>   configs/odroid-m2-rk3588s_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
> index e71e61ddb0b..fc8adc7d047 100644
> --- a/configs/odroid-m2-rk3588s_defconfig
> +++ b/configs/odroid-m2-rk3588s_defconfig
> @@ -79,6 +79,7 @@ CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
> +# CONFIG_GENERATE_SMBIOS_TABLE is not set
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y

