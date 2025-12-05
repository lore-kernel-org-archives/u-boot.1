Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1083ED339A2
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 17:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208FD84238;
	Fri,  5 Dec 2025 18:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ri/6GHMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6645084239; Fri,  5 Dec 2025 18:32:48 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE7F8421E
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 18:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e33956e76so1269401f8f.3
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764955961; x=1765560761; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UmXADDolv0wfviFWEw4pEc9FtpLqDBTSeZtEfdgaVd8=;
 b=Ri/6GHMXOdDzL10O28uYBFkbxx5wgCdE/Z2Y5a3L1CR6/PI/NpT7KVEsFb+p0f90J8
 MBdXKJabMY8QJEDAYR4zu41Hw96rxTumU2rLR5ixO/t49cen03hK1N/oC0AeR/HwQJ2y
 +3S1+2J7UruG+MJsUUqZ8dRJuY+feUo4d8VojLdC9aTa304PawbNgXpviM5/B9C5qsld
 eWwotwWB9HvoI1ujI/uwCWtBm5UqkPQ3LmZYI0Dr2WmtTCkNy+SeRt6lSUEi4NFgahz4
 31GWYV5mKRTdOVpcXNBOrz2mmFLe7mqrDmZXNUT3p9ew/B4ae37FWi3idLURQI84wmk2
 tvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764955961; x=1765560761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UmXADDolv0wfviFWEw4pEc9FtpLqDBTSeZtEfdgaVd8=;
 b=GDC1TtjwIIhbCsjezY45TyJX/+6uUF1JcaHprUOLit/cViaHCGRgyRs/tA8nvyvS4j
 PWmVTdrGERMevzq/m37pkZs3R21ZfeOAA1OZW68vtM2W1AGeUrfqjr6i81GXFySt0p6u
 27KCZWnGFjWKvADP5q/H6Qe9iaHtzGmYyj03kWv4FsYJLKnE2iFfpsr38ThLqATFDGcv
 q+mYdqhbSqB7emlxDEGKZG7CZy/PxK9m5Umuo2qLfojnKLWMJbE9ykaRnBYZvZgFSWZq
 eQlFIMBpuOjepeVVUkXokpPZBnzooSj8z6wTnissqz+TS5PDdgADOyfGnWnPyTuhvbgY
 UgFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJ/y/hajnVzCc8QaxcXsKAgrvkaiN0/XrsujCRewPyqIGwTgVKtgTlMPM1EJutBMGgWdUOGE=@lists.denx.de
X-Gm-Message-State: AOJu0YxU37sTYId+YL4qSWf16rXpc/7Rf6OTpBryneHifKRLT08uxFx3
 mIovQrPm6S7oJnSOErsJtS9Di+6xPhrs3VlOopsd4J9/qrv2pYKvkrj5x5wgFdrAYZg=
X-Gm-Gg: ASbGncsaFzb9qHu7yJGR0IG2NbBzzCIAKvwmLLTIT1gX/1drGScff/ipLxn1baq2j8c
 p1KednDNhaY8SDgyT3gAknROCT9KMv6zxPPwPrh/S/PYdPcwi6icE/ohcRB5jPxqX7F1J7MgdQn
 7hqQh20jsqHljldjtyKM6yMqjJBXVvSBlmZhhEAKU9po9RHZh/78U0SWJbIYZ4Oeq6FGdab05KY
 vqmquX9PbiPeAk0ai1dxyEKprh8u754kB3MBrOQTLup69B2p079RW9cQqArvE51tlcEcScbvJF/
 vrhQJHhxDW78/swwiYTU3RbR/2VgrHaqrMP/Km7nlPWAXXznE0tXNC2icj3Nl79zD3xB0TlBBmI
 6Mot0KBGWd02EU4W3DhZYlIR14kPnNdyNAYFo+ziygZXM5zbzB5uaic1ud/EJlzCJdbfssBmLJL
 cftfe/H8hRF93CEEfiYO3YLfoLBAZNY+fCQiSKfiMYcoEZkmG3lVr5aJnrj+PzDBdejw==
X-Google-Smtp-Source: AGHT+IFMkndfqTxLWflBxfNO5RbhWb2iC+QPzcXpFOCQjQdUI8d2uCednzn2k/3axDyxtB1nrdxU2A==
X-Received: by 2002:a5d:5d87:0:b0:42b:2b07:8630 with SMTP id
 ffacd0b85a97d-42f731a5541mr11569599f8f.31.1764955960721; 
 Fri, 05 Dec 2025 09:32:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:e36c:4236:70ac:25c6?
 ([2a01:e0a:3cb:7bb0:e36c:4236:70ac:25c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8a7bsm9891103f8f.4.2025.12.05.09.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 09:32:40 -0800 (PST)
Message-ID: <64fc4230-6419-4a44-9814-e4f8b8807edf@linaro.org>
Date: Fri, 5 Dec 2025 18:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: tftp: Fix filename handling
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20251205-lwip_fixes-v1-1-90bbca659923@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251205-lwip_fixes-v1-1-90bbca659923@linaro.org>
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

Hi Andrew,

On 12/5/25 18:28, Andrew Goodbody wrote:
> The code to choose the filename to use does not cope with no name set at
> all. Firstly the test for a name in net_boot_file_name tests the pointer
> rather than the string it points to. Secondly the cleanup on exit in
> this case attempts to free a global variable. Fix both issues.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/lwip/tftp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 94bacf630752d20357cef40775a25cca39d811dc..6c7ffba661e5903b6b3a6349edf2c8b22eb0d36b 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -279,7 +279,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	if (!arg)
>  		arg = net_boot_file_name;
>  
> -	if (arg) {
> +	if (*arg) {
>  		/* Parse [ip:[port:]]fname */
>  		i = 0;
>  		while ((*(words + i) = strsep(&arg, ":")))
> @@ -342,6 +342,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>  		ret = CMD_RET_FAILURE;
>  out:
> -	free(arg);
> +	if (arg != net_boot_file_name)
> +		free(arg);
>  	return ret;
>  }
> 
> ---
> base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
> change-id: 20251205-lwip_fixes-ea4051356612
> 
> Best regards,

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
