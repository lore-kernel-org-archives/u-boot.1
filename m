Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B8606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RC1zESsZ;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eaAtHdoo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 435346075D;
	Tue, 20 Oct 2026 17:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_afKWuW9JGS; Tue, 20 Oct 2026 17:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AA576076C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792518431;
	b=A2MAF20z3Wv07KfPgbT0bJl+irRPjlRY10E+m9hC//+IfrKCtkmcRGiobDqaSFVrDnSQ
	 gM4c2I5WCDLUT+iEvs0g47m72XlSY1r4+yrbf4QN/7+xImZXSm5pROOQ9VblxaJ+pk9Yc
	 pd10EF9H68dU877FpfNsaF4wM1HuPAkVsp0bMLFZ3YB6Lz4kuXZkUyx6lV2dRl+jUFxwp
	 ANshsSn3lZx7UTuEEVBXzJMn2v4Ziju/OHfn1lt1jdf+fDICMOrMeahB1pvdukNUS2SRD
	 pFwzNptrJXZLFIycySWKyIZjWJsUkejMS5RYh8yuT0DqwlHZEjMG+54IIDOOGX5jmmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792518431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dkhYcqN9XZoc63irxDGJcrrntLEgYLBReCRFxhI5j7k=;
	b=XOZNDVJx6eMnf7/VRmypL0TApMWJbtFgmFuFBDyAHMilBMO2ULMfFoZb69oZHO0/JVBb
	 Y9G8B60CGLwUBtX9Y6jYrSCvF9C+Dv1YUbnYnq4tYyFwt10LM8NHFt9oCOKJKyG9gHC+T
	 IXruNn00UUIx8Di/lJ8+GPZgTm+3CZUYyKQmsLQyCYQUpU9hbh8NbcBzku/RKZKAs5FrM
	 etg7AL35OGfaDEJb/FGaPMlBCSl3puIQhj7BOBOa6RkmLigVN4mfBVF+D8UF2R2y72OEu
	 hBLpQfcSOnSk3nQlyr81iklFcmWGzGmEbFRzGdsQRDYouhnv6gYyrkpMRzX4UznUZ1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eaAtHdoo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792518431;
	bh=dkhYcqN9XZoc63irxDGJcrrntLEgYLBReCRFxhI5j7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RC1zESsZkYtsxPHmaLUjzt4spKDKQXFx+8F4uY766jfKYKNRQWjILXVUrzT0M4MpJ
	 sU79PWzfzn0/JyljkIbOLivOO6bzqdjVM2f5svptrsu4K6r5L1/tN1ogvwdpjDJJxU
	 ksTA60AJqNH7qeZGsBeTRUXPnzxnEeoksniFUYY0gEO6vRpzJZZ5ROq4HNwzqEzZOw
	 b0vzO0MfE0ucRsEAMnBcFWnobYD7lmK4OeT5VirAS+eakbhh3w8Y0nwzgmoErrVCzl
	 tClfLwvGDBS71tO2cB6SiReiWgd6JLgFWagmkyk2q7QyxRy+UeywOgx0bq3Lb7PaXS
	 yjmzYt3PUluew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AA576076C;
	Tue, 20 Oct 2026 17:47:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D5AF2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E72226076C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDnyE84mWyLH for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:47:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42CC56075D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792518430;
 b=DV/yrtyrznGjl2KdwthrbiTbERURJ+gp7ATncob1BhJ45eZhzv44VkbV+et9mFuiLWfT
 U55G+BhWrjQZOiMH/8TH3Qiz6pzSqDXOrsNa12/0d5rxtVTsd1PHGuVT4p7/LMf3b3ghR
 QEylHuqOmHvetF4h/KO4UcOTTXOiuT3flrX8fK+Qi573HTT69ZoffYot5/vk1iyiu+wuM
 oIzz5L6T2df/DEQcZdK7jMwx4FEDk8DfWkQniuQXnwWyG4pOV6UyxnslIHWNZRP4fuwie
 +o2iniQu9xomUtxTGFpGCRoC5ABC0H3gEii/y2yBK5RPCOmlWDJ4w1xYuZsPlU3jv5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518430;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=dkhYcqN9XZoc63irxDGJcrrntLEgYLBReCRFxhI5j7k=;
 b=gN4dX18+FJuCUhxqbuaU/fgc6OCSC/NY2Ub4QlNit9Vwf4Zj5WGDh3QUogCPyNYFP4xH
 aLAPkv9jXkF959197OtjB6XyKJoT+/N/aNr0hF4A/5L/ohUJ1fc/K90iIrIXjmawFxboW
 irHwsZCsZsBWvjbPW5OUh2AQZVbSIZWyfzOeqKIU3JkfRWLAQl/35/Ie1ambeoz9T3Rc+
 CuAJzyH80Wp/z9jNoR9IdSX6V8zzP4pZ8ECNZjctQLXIA1z1H0k5y1wYHxhXCk4n4ZnDF
 fcy3ujtTQ8FEop1DkYp/CWUd2gTfOTem5chNdGLIEYs7pHU85j/wICvAIa2R1IUB9GA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=eaAtHdoo; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=118b=il=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=eaAtHdoo
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42CC56075D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792518425;
 bh=dkhYcqN9XZoc63irxDGJcrrntLEgYLBReCRFxhI5j7k=;
 b=eaAtHdooER+HM1a9/InFNSZ0QexrWhk2H5rAJEAOMDVihXyYVLseiLVBpSyUev62gRy9iT5th
 8YfrNauHj+X2ptQlhnsHw+hBurCvfxROj7LwZ2tqvf8WWfKrqYUwBkDHXocp1ORdAm7ZYOvOK+g
 GLZXnm5E5mLraYKlBRjfvffRYXsVXslJlYjb9JU3xvRG+tyQFSRxe4f6KYuGReBwdr2Ia83M+UW
 VOjEIVoQ4xkuU8maymqzq1jFp7yy7g/OIXZQ+soB7y9tFPDG0/qTFXOSR1mwyG2Fu0V9Oky2BYM
 acJf+rNewL5juGvb1g9ZMeKyCAt0VEwA2nxzs1KJGDjw==
X-Forward-Email-ID: 6ad7a913adef5eb3cb994fd0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
Date: Tue, 20 Oct 2026 19:46:56 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Alexey,

On 10/20/2026 6:41 PM, Alexey Charkov wrote:
> No in-tree board picks a compression for U-Boot proper, so CI never
> builds the compressed path of the Rockchip FIT, nor links zstd into an
> arm64 SPL.
> 
> Turn it on for the generic RK3576 image, at the highest level, which
> shrinks the payload from 690KB to 296KB. The image is meant to boot from
> whatever medium the board has, so this suits it, and its SPL heap and
> SYS_LOAD_ADDR already leave the decompressor room to work.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  configs/generic-rk3576_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
> index 5e25653820c2..dec4364876b6 100644
> --- a/configs/generic-rk3576_defconfig
> +++ b/configs/generic-rk3576_defconfig
> @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=0x2AD40000
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_DEBUG_UART=y
>  # CONFIG_BOOTMETH_VBE is not set
> +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=y
> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=19

I do not like this, it breaks consistency with the other RK generic
targets, which are meant to be as lean and bare minimum as possible, not
a playground for testing features, we have sandbox for that ;-)

Please enable this feature on a real target, not a target meant for
basic board bring up and recovery.

Regards,
Jonas

>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-generic.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_SPL_MAX_SIZE=0x40000
> 

