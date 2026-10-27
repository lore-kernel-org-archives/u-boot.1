Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06256606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jNB6KFLZ;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=FO6PPpBS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC2C24058A;
	Tue, 27 Oct 2026 07:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_Fl-Pi8SZJQ; Tue, 27 Oct 2026 07:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF35E40550
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793086274;
	b=mMgcrHdPLLwiqCZ7a6qyHtwMVuP0bFgpv+dZF0MXqZ/SjPoZX1/M3nUhd49+uOpPCvGW
	 jVEg7zMvw3CZJLosOrWGbCi1zq4fHjB+1q1r2FBPcT4k8RX+yuwFGft695+zf+ow3Vr2k
	 hay8HonbDAZPYm8Kf+t+xCR6xiWfh/MHiwQ835ST7dsvz/krXRHFMQIV2n19EbhTD+RJi
	 2H3R8hBFvd7TH12Oq1057NtH0ogEbJqtn+8sGrWh8nUDNsYbvyKluCaKVKB/IkRyg+df+
	 xGbgGavaYvBUh9z1twUq4lRSh46dJ9W+IDJs8aemsxjiNMMFQx2qpcV3ReXmojjxvNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793086274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S9SS5GYyaxa1X4edl11t3XqYIKwGvFMqPu4Z0YJtCU8=;
	b=Hujo9CI98aB3atjNjPHUXHUV6lZYIUFrHhRiNcNpt4xG2LUNgPFZzdlvPAMwQaotkUA5
	 2FzDzYkTsxMRuPfUCfBNKUNQTZl+6zo7r/3MEoSsbrIpA6lmekwhCdamES1Sa9s9JkYp8
	 EpXiaZpBYPnlmC5Ym64Xy6IIIGkoqGQLXzmKifJE9cmj89tbe7A7DQaXl0lda00kSI9pt
	 rwpSC+NKj5gT7y21C4B6eCOVNAO6ICWjREwg5gbR4jizRh1ogCDWbl7WJZ0+vmsj8qLL4
	 so/iVF1sN+pYlCYpCUfZlNsbOHh1LWFPqJbe3NNp0LEkRqpqKMYaJSxjNqSkdh0rUXw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=FO6PPpBS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793086274;
	bh=S9SS5GYyaxa1X4edl11t3XqYIKwGvFMqPu4Z0YJtCU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNB6KFLZRhaLXR+ttxuzwd8Rwx39ps2PgNdTVprpv1QGxG2Kgyz8B5MWgWmO3UBV4
	 nc3HFoJTB6O3EUS4FWRpOd0iKN9XDHnx0tl0urPMPUtPG/ucH8InmlXGkxoLQFq7rQ
	 HqBAMlyFG7kSYYMw1hSsdzx5gk+DjmwvXywMkZleMCH2Dav/XANVpLcgxt2h61aTGF
	 e1kjdhvLWtlvBAgUKvSMjc/J4og6q0Jn96ppEhYHpnhcsFswIQwsxjTYdyelni35pE
	 l91bXAoOiiJlHkpKxs6JJSiIo9bgZCg1B04fCIvHyFXrVEtYcx05TfahURJTtPx+cp
	 1OJwqzagQ6Byw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF35E40550;
	Tue, 27 Oct 2026 07:31:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12A814D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDA3640587
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEfkZTEX8aVz for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4BB7F40550
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793086272;
 b=WmhHHkuBkbveWOq/B9DzxVg9t/GYjzBzzgOIvZVFw0VBF3RX9h4nU2MrHd67oFd5R/bF
 cgRTWBxNYv7elVZBI2u4Ls1iNc+ab/F8E6PoclXrzZpTh+9BTGuUXfnhDumzmhHD9fMEz
 7H0WJFFNaGpg9zrw4Z63ZGsxfsGcQBYl9kHy/RWwkqcvLnPcxmXMuvl3GlHlAnifzmb2s
 /q8RphQzIM7hugn1Lq+/Z1b6/czypgX7CFzqtO/ebnrO42ha+ptPrKunzldnT+tsS/sCe
 kAllyJMPlsNnimx82LfJ4LsAPY3FEpHJCiligvXB/ur7LPd/zh5KkzHZrt2DeMTw0iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793086272;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=S9SS5GYyaxa1X4edl11t3XqYIKwGvFMqPu4Z0YJtCU8=;
 b=X1iTONHURPdS4MF7Pml7c6FfdgisgwQQVZ9E1BePIWqVOVKjnYp88sVDVmee8hIoUrSS
 trW3pX3tmZjmFmGFNcRI1qIiG/ntP1Xa0OYS33Zqi+piO1bCZfmJ7TxUMNTL3tlP4oBFz
 Fvn7OirLgU3Fs54hcDSye3yA7wrvvOLBvkjLXcJKCR0fOkXxjDk/W4lp+r90hJ6/r6RxL
 8aCegCOc4rzU80aGlOEJQH8zhMjdRIw6dFssQNgf5Xw/+dIwGw8u+Lx1wCT2ItRtXvdqT
 Y/431HVG1JJJDH6sgznCEbk1HU4trgWqpjGoMrdLlaNnBPz7/QlobFcHuzO6GuI4NPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FO6PPpBS; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FO6PPpBS
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BB7F40550
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:31:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F0E0F10B833; Tue, 27 Oct 2026 08:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793086264;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=S9SS5GYyaxa1X4edl11t3XqYIKwGvFMqPu4Z0YJtCU8=;
 b=FO6PPpBSkDBK6JL0u3Xl2aCP7Xt/aIMz7mcL7z7WZbW8JkSbVXl5AXAzmNtauZ9dQtQHdT
 tJe/2OH1Gim3x6uiD036SlusVKN7hlQiQxPryYrroH8j9irhIXK6GDQ4P+SNO4Kbk8RR4m
 BcU6hEO3Rpw2xmoBTrEUefQc3L0HMVsoNrprcO5KvuCTjzvSJYe+2MFATkp8f3SpooLeRY
 jUAL0lJwBjcXryaHTU4mmEPCRQotdFljO/1XuAsi+xYs02dWCj1l9oADdLpsQ3FoK/CzC/
 AYLP24ZpuzsdG4B2kI5tNjiuO54nIUBB6RPxIm8xjqho8B7wUYiX90ocyAy3xw==
Message-ID: <26062bf8-55f8-835d-e7df-883c763088a8@nabladev.com>
Date: Tue, 27 Oct 2026 08:30:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: resolve "." path components
Content-Language: en-US
To: Altair Bueno Calvente <abueno@airzonecontrol.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <DB9PR10MB79301375ACA9877030AF8D87A4802@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <d0dbe72c-7531-9556-2ec0-f147d6c3160f@nabladev.com>
 <DB9PR10MB793033E1A2F0E254B4C53235A4612@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <695a45c7-c3e0-d18c-5dff-15c798d31a06@nabladev.com>
 <20261026145409.GC624796@bill-the-cat>
 <DB9PR10MB7930A525CD2941E7F4C2E609A4602@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <DB9PR10MB7930A525CD2941E7F4C2E609A4602@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Altair,

Your [Patch] tag should be now [Patch v3] ...

On 27.10.26 08:18, Altair Bueno Calvente wrote:
> ubifs_findfile() resolves each path component with ubifs_finddir(),
> which only matches directory entries stored on flash. UBIFS stores no
> "." entries, so any path with a "." component fails to resolve. Such
> paths are reached through relative symlinks to the current directory,
> e.g. OSTree's "boot -> ." at the root of a separate /boot volume, which
> it creates so that its hardcoded /boot/... paths in uEnv.txt resolve:
> loading /boot/loader/uEnv.txt then fails with "file not found".
> 
> Treat a "." component as the current directory without a lookup.
> 
> Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

I could not find Toms Reviewed-by tag in an email, did I miss?

bye,
Heiko
> ---
> 
> Changes in v3:
> - Drop the Assisted-by trailer (Tom)
> - Collect Reviewed-by from Tom
> 
> Changes in v2:
> - Send with a From: name that matches Signed-off-by (Heiko)
> - Collect Reviewed-by from Heiko
> - No code changes
> 
>   fs/ubifs/ubifs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> index 6121fb0b1..fe6d0cd7a 100644
> --- a/fs/ubifs/ubifs.c
> +++ b/fs/ubifs/ubifs.c
> @@ -543,6 +543,16 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>                    while (*next == '/')
>                          *(next++) = '\0';
>              }
> +
> +           if (!strcmp(name, ".")) {
> +                 if (!next || *next == '\0') {
> +                       kfree(buf);
> +                       return root_inum;
> +                 }
> +                 name = next;
> +                 continue;
> +           }
> +
>              ret = ubifs_finddir(sb, name, root_inum, &inum);
>              if (ret <= 0) {
>                    kfree(buf);
> -- 
> 2.43.0
> 
> 
> 
> Morphing_Logo_Airzone_v2.gif
> 
> 	
> 
> *Altair*
> 
> *Bueno Calvente*
> 
> *Ingeniero de Desarrollo*
> 
> _abueno@airzonecontrol.com_
> 
> _+34 952 028 575_
> 
> _airzonecontrol.com_ <https://airzonecontrol.com/>
> 
> 
> ♻️Este mensaje y los ficheros adjuntos que puede incluir, son propiedad de Corporación Empresarial 
> Altra y contienen información que no puede ser reproducida total o parcialmente, mostrada a terceras 
> partes ni utilizadas para propósitos distintos a los que han originado su emisión, sin la previa 
> autorización escrita de Corporación Empresarial Altra. Si recibe este mensaje por error, le rogamos 
> lo destruya sin copiarlo ni distribuirlo y lo comunique con el emisor del mismo.
> 
> 
> ----------------------------------------------------------------------------------------------------
> *De:* Tom Rini <trini@konsulko.com>
> *Enviado:* lunes, 26 de octubre de 2026 15:54
> *Para:* Heiko Schocher <hs@nabladev.com>
> *Cc:* Altair Bueno Calvente <abueno@airzonecontrol.com>; u-boot@lists.u-boot-project.org 
> <u-boot@lists.u-boot-project.org>
> *Asunto:* Re: [PATCH] fs: ubifs: resolve "." path components
> Caution: This email is external to Altra. Pay special attention if you don't know the sender. Check 
> that the content is safe.
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
