Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D7606A322
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AObCcx4K;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OTZqXb0u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D12D80F38;
	Wed, 28 Oct 2026 13:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eCqVBKFWZJCg; Wed, 28 Oct 2026 13:58:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D24580E18
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793195892;
	b=d5tFM84/5yI8ybbPU0xkx4ONHfCfE1vZzGrvZKXqFGDb2mgcGK6w9jYQTcT6Ay8AtsuZ
	 Bf20HP8gliiCv4VuA2THx0qwTWUTZbZVgeUbkhWQ+QKkA+g23ro9kDjhoCntFE4BvwM4W
	 8H6gco4RDa1duPHcj/uib7a8ajaY/hEc4HJ/U0wyrRWovSnxccQBRHLoYOfLRfmsR/stC
	 Q784EcawXE8CVVSGYTQKUFfN7pqHgEQ9iu2YWqSwdPsy+iyZiTIG2nDtEQC+NnXeie5Rq
	 NDPmiVavA67xHtHq1dKYSBuqr21Vdqk60+Wqw19BTbAwozGgdhevL5X0fqdblr94XuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QkIp7q+9iMN+5Bk/WBrp2ka5V8FiGjY4FBJxfsSFWT0=;
	b=Yu7rQuljpe+oPYV7SVFP8pVewrYLKe96PMyyfLQ33EWPbGq826XSX4/NAV++DTtZojQG
	 m35HUVDrBJhx5rnl3Tr1yk/4L3DEhOSqNDFCCXn3y/4Js6sVh+2Jsy5kdFnZbQZFFMq8q
	 StzNYLNd3edlfL2SiayMOMA85XmZJyGV82jK2YA4f8hCxXqIMYEwwOaGB37xeSJAPLTSo
	 XsyE1oLIJgdxpFL2QWvFy1mV1vDGYzPTmvAg5HCEHd6cyFQP8mwjR2XrMAz+h+bVrpzt9
	 0Qu6xvTF422HXBFp9l4E0K8S7WdhyWEbtubdt43sTYA5x0DNuJupq9mPAysu1FDFVYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793195892;
	bh=QkIp7q+9iMN+5Bk/WBrp2ka5V8FiGjY4FBJxfsSFWT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AObCcx4KB11BiAkBR2BRR38iQfYkmumc8PmDBBJyfm3b1xdSLe4UGkXJzFAlTZl49
	 DmigTyDRHfpdkcumaFw22e/rhmo7gbGCC5msTJWlndf59ZSIScCT5EPRYS6CtMHC+L
	 +J2x7TECWQr6fU0u4K14wWwoCEWWRziWcawLTnPX0YEg7NlGNWwwIPytnAr0fK4ItW
	 0ANALeaUUwk1PqGZ76/rjKVaUx0G9RW9kczFqMt1DeEl+WSZZWLuXZjXGF82lMb4J+
	 13h5dMFiEg6sBdsAxi/zZzMh2N94U6Def1GrqWglPQ9o06FrlQuvxhRKdYmHPC6iRR
	 toDQ0c6OaNT5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D24580E18;
	Wed, 28 Oct 2026 13:58:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46171972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C61F6060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iGcWkYAQaDc3 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79936605CE
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793195889;
 b=fJiJWRg4sxyld7p6lK88ENwom+rpU1RqvaGq+xJ4QhAcSKSXyxMYLFvweIdgjkLlyy9t
 EZefgfZ/qWhvFu2RpWMyuMouXMT7GAdKWljKB/VFpSzoL8BzylqHATjxdMqqkwbzphcBE
 vRjHZqNwTGoL6YReSutXiVi5Ve9duJdTPk80dbJgQrPTXW4SHsPT8w68se01YhP6X+mJt
 xH4jKX/ViJExBwQpk9BTsOWStcyaxRiRzJSVNsjGL9BOMfxgXkPQoG/A6/5cMeyTDKP25
 Gt2uqH522HfltQdl69hgyDFZH4TpyPKHvLdIULx/Y/QGc79ItxCqi9PA5as/HfYDXHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793195889;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=QkIp7q+9iMN+5Bk/WBrp2ka5V8FiGjY4FBJxfsSFWT0=;
 b=PDHeF3rREKwdUCRIV1CJIw136SZwbQ4d6fGKkpXdZy39bS6l2lHZ41qwvh9Li+Zv7Dio
 toDOz+C3RBvauwiVdgMVpP7cUj6Yfbw64XvMf2Plq7GHwxJTtI95tg7PN0HKCzBSxuP6B
 Embqhttqx8exjzOhjTW9MoQbcWRg3hlFO03NWVnxFpddimQEXpvl8owT1esLJUIe3rH4g
 LhUifNf0o+yP0jc2iBciyKij+QoqvlCtVbLAXgXwrPMsNjTJZHa3TuRNBadfH13o/PHim
 Tn/3lx7JxHmtBo02VIuvpc6dxIt+eyjgaKlljFIAz0e76VcKeuKgOtPNLTxL48x0eTA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 spf=fail smtp.mailfrom=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OTZqXb0u; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OTZqXb0u
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79936605CE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:58:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D974847F2; Wed, 28 Oct 2026 14:58:06 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D645839DF
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 14:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so8057495e9.0
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793195873; x=1793800673; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QkIp7q+9iMN+5Bk/WBrp2ka5V8FiGjY4FBJxfsSFWT0=;
 b=OTZqXb0uIIrqHwjd56I5X/3DBCJ8r6553KR5I5nBYYjVRhJvIgUj0e8k7z4NYE/19e
 V1Sbf0LHliEAD4l/4Vvz10HLq8W4wS+/rG776/dT8ViZ7n0GKMijC8kn2oKTUGDeUr4B
 GOWlIsRcM746YE9hJri/U8NUOjwBE0DvZu8SNfNIzOvRx0Mm2eVJ/ZQNtCineUjFsyEG
 lEHhSq8f5lPg6U5lZsCYWQiYbpU1dLxSxrViT+piWHndgs4z/H/v27+PdxDB66lM6n3g
 uN+XxOrvQDAZnPLoIFexhCbmHapRXRJ8HTnzO8bX2pbaa73kNc6NOOT+Zd0Pp0u6N2Rv
 To6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195873; x=1793800673;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QkIp7q+9iMN+5Bk/WBrp2ka5V8FiGjY4FBJxfsSFWT0=;
 b=BpS2DzvRfVDajktO95Ze6ZFE5H/vtAdkMHtvcBoqrXndhM+sj1yh+vWWRqdeRpEBgK
 PJ68oyZ20yJQn9meD5xLmOfMZ8UHY0VSNzdTfqz8+PAuszy9lXuNsHXWwLUImtCQv3RY
 7zmU6Tz8J4D3NGH8fTANtPZuK7hneh+MPII0it/y2QKUT9GJB2H1ObtO+fImZhJ8OvEw
 ghxwbNEskRYc5WJ6vsUsRG4okhcwd6KqU4atCmVeqVBWdEhYd5rBABj16YtMPLi57Bfz
 Amk2+0/ITyRAdP0cTzXmQPbW1xXDlbPNcuaUQ2NO/vOD+40RySDVvL37vCmZIJQLIuEn
 KpDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxggxJqYeeRaEqZf2ebXpPv2h0KeR1EpDz8+s3NfrHQReGHKxRF2r62L2L2/KhW76nVxBUUX00=@lists.denx.de
X-Gm-Message-State: AFq9FYLAg2QBaN9OS9QSRExvt38Q8QXz+x+sIo4PbOxEteWYu0H6dpF0
 hFJSCW+DuIRlkGaFlpQ+FK0ixo6M+NaofhEkZ2oTqJUrjGjB9o62DGcL5e0+Tq5tqbM=
X-Gm-Gg: AYBFou0khdjpHVQrJ3mTS6fedWp17FE1gNS7aZBeVQYOIpjhZjM4KtRQPfsvm0bsbvI
 g8pNME9Qmz6QOn1HbQh/h8vr0WFjcmKT5vtg3ufNG0Wh6+pxwmuwkvor4miCeAZrCnjklw7Eewb
 VQ/mudoFT3G2cNUdUdFmqaIA4Wc5FbMVU+oIu8Sj2Z/ogCKDJXa3jVQ25ibPB/iZ+ebxPrv591X
 O9X1KKRWABylPtqtkQncYmUyMbn59AKJ3qcEjCqGFs8ZJougDObsrRyw753vGbqJE0q0TQ7LtTz
 k0eMUum53M2bdJ0Rzcz+G5ZWq8WBHeK0bGkn1MZXB7rkG4PQ1z30WkU6M+7s3820SiYyB9yqJUy
 OdU2ipYUxe14qwE4x8zCo6BpDgn4fNLVd97rL2i8AuSSEB+F4qQr3Nr2NW5Zf7KE6kO+baDNhec
 Zgy1Yz6liP/vx3SrYcDgfrUBoiDj3ACo11rHU5Qy/Ivuz6438AfZALqPjoZQaIM+hOVG9egSneE
 by+lthLfYhqTppFQ4e7Co74+YM9uEzG0r4I6dlydGbGfx4TWbVjTB4gk7Y48SfYPZxb2ehdoHo/
 DKmos5vnVR3uMcmHuwayJeAMzki0EZBnLP6N2Vkja2ZqTSSjqv2kwI/3nnc/XPdgsu4o
X-Received: by 2002:a05:600c:3541:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4a966f20483mr54246175e9.19.1793195872635; 
 Wed, 28 Oct 2026 06:57:52 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a977edc20csm41532615e9.3.2026.10.28.06.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 06:57:51 -0700 (PDT)
Message-ID: <6834cd24-218b-4801-991f-613666c3d4f8@linaro.org>
Date: Wed, 28 Oct 2026 14:57:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
 <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Balaji,

On 07/07/2026 11:52, Balaji Selvanathan wrote:
> Add IRQ status validation to distinguish legitimate UART data from
> electrical noise in the RX FIFO.
> 
> When the UART cable is disconnected, the floating RX line can pick up
> noise that the GENI hardware interprets as valid data and places in
> the FIFO. So, check the RX IRQ status register for RX watermark or last
> flags before reporting pending data.

Went to test this on Lanai and it seems to be broken on sm8650, TX works
but RX never reads. Picking up the other patch.

Please check this and rebase it, you can also drop the fifo_status
intermediate variable.

Thanks,

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - No changes
> ---
>  drivers/serial/serial_msm_geni.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index a580dee8c8a..07d38178759 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -483,15 +483,29 @@ static int msm_serial_getc(struct udevice *dev)
>  static int msm_serial_pending(struct udevice *dev, bool input)
>  {
>  	struct msm_serial_data *priv = dev_get_priv(dev);
> +	u32 fifo_status;
> +	u32 s_irq_status;
> +	int word_count;
>  
> -	if (input)
> -		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
> -			   RX_FIFO_WC_MSK;
> -	else
> -		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
> -			   TX_FIFO_WC_MSK;
> +	if (input) {
> +		fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
> +		word_count = fifo_status & RX_FIFO_WC_MSK;
>  
> -	return 0;
> +		if (word_count > 0) {
> +			/* Validate RX FIFO data with IRQ status */
> +			s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
> +
> +			if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN)))
> +				return 0;
> +		}
> +
> +		return word_count;
> +	} else {
> +		fifo_status = readl(priv->base + SE_GENI_TX_FIFO_STATUS);
> +		word_count = fifo_status & TX_FIFO_WC_MSK;
> +
> +		return word_count;
> +	}
>  }
>  
>  static const struct dm_serial_ops msm_serial_ops = {
> 

-- 
// Casey (she/her)

