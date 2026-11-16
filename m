Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D96606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JMcloXVf;
	dkim=pass (2048-bit key, unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b=DiZ/WqnZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A86D4078C;
	Mon, 16 Nov 2026 17:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgpAVrr9Lcnx; Mon, 16 Nov 2026 17:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD71A40768
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850693;
	b=g2BS41hzCMGwwGaIcf7eHpmDtFLUv2atxP6BOzX0QCwYkFfx5qZhZDPbhF0GIMIiXpBA
	 BxB8zXMLjsexw7/DqgIqGsnRXsvtBWDomjPntnouy6/O1l4bQ0vglF2xVHmXnWKpuXHsG
	 pr+yxmRedCQA8armBDkCFMMBXGWZG1xFTIT86n8HIJ4HKlhpl1D6q3HkRsIMSI7HLpXiA
	 k04/qszYM6+K3bPXAtCP1VDvMNsD4C4UDXq28ccPUGxgxzbtrPMC/dspeiDNIzMpSvz5K
	 HIMEKTsxlowfFx9b3U3B9mF3TTkB9OP00anpJ68X51gF3GrRfflPMt1diryMypiLlfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dWrWC3lzaF8CJDmn/jBFTNALT8i6GCyPPmYIVsgcP7Q=;
	b=aVTAx3rhGnv+xfghg60NJ48f2qzfch3BPV3HUPGjE+MEbwljFoOks1VHe8+SIbz2jBGl
	 QUnOZVX5XhC5A2PUikj6mHa4NZ3ZusPW/HyOVbzPFmJe+JT7iklYQu5aULvgsNxVQLXuJ
	 QIBY/4TrhJ2KkKdRZav7tQTS7h+F9+NtbIBaPTkcbG08IpHcGtjbqQsHdXBF8tr9IKWma
	 fxTxjBLWSN/DsqGT+eOOohvz95r6c7SLN5HwECFan/LKQ3Pa//atPTgHs2OWmYXOhFkeY
	 ujLnq/03NGLVm4tMVgDF6sdaLt23NBV35Ypxb6PItzjVKZB/VjbFX66uj4kKfqgziRA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850693;
	bh=dWrWC3lzaF8CJDmn/jBFTNALT8i6GCyPPmYIVsgcP7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JMcloXVfj5BjmmJRH9FwUYKy1w4uW/tcu72A1nLXYPmB6O6OSJDP03N5e1RAhDtTY
	 ApOQKnrj38YfPdQfqjeE+0c4xmdUDZzt7yDrFSfT2mSCKKRzV5HYk6zM3pA9wX5/tf
	 v3ij8NnKAO4ur2lfHt53oR3+owE3lYpbN2vrRucLF0QijMdeDreQ+o4UbAexfkQKtz
	 qu5p1Qw4HUwyYe//j7vhDsH4MCdL8vBMv3LSBc3rlYS6bi94pl/gHXGdqItkyHCOup
	 vZFatGogu2hnkUynSzbaeknXBswEH8RwXiWpqf6PYRdivnjzRJ5sNqGEH0unnYgL0i
	 FlJzpgthQWTlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD71A40768;
	Mon, 16 Nov 2026 17:38:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF8B176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FFC680CA3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4qNzU8cccXd for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:38:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DE5D80C84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=DiZ/WqnZ
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DE5D80C84
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:38:09 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-55c38cdd5b7so32297351cf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1794850688; x=1795455488;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dWrWC3lzaF8CJDmn/jBFTNALT8i6GCyPPmYIVsgcP7Q=;
 b=DiZ/WqnZJCe8bhAQK7mJ5dnHx4RBlTN7csv5Wf8TZPBYPLvpL5efYsoOVr2seh5Y2m
 DFmXJ8HmHoy/FwUbydZ8QEj7Zi3hK5SlOnJPqDxV4HaW633pDe3T/76z18o1TUeGPeL0
 EC2fLoVzUSrID3Z7Qshio0k2C5I55wEMObXsaUKkcNKZvGVjWwOMmt8OdDL1IMuNQv4x
 yMfky4pCBzMLy9leDygo018vkwS39V9aYp+ceMvOvd7nh6OqMGYrvPwNpgmfFXoDtPzD
 xXlHPvWKrvaaoVbFrTMEm6twA3pAV6feZYn1AP7RCxQ6ujCAiff/KnGxRyvatMm46fW4
 CT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850688; x=1795455488;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dWrWC3lzaF8CJDmn/jBFTNALT8i6GCyPPmYIVsgcP7Q=;
 b=DzSxGi6dKFBEk/HnqjKbpH7rIOQz4gfE9jaJyYKNexx0pzj6o3Z1THh7n9jLEPWmI+
 mIbJKYj2wCtjBbfOiNl/ZlyZA1k5gLRN8u+JyHygfY7Hizk6I7g65cGYkDrIfpZI5Ouh
 F4QwwEhIRRxX34qaYGOKpU4bKNK97eJdZndw3bFM/9nqtQB0BIIaZl9pniLGyZrzV2dx
 /ucMUzKgtfGqy8g2TMmcFY7PVjknIPTnNknxIZfw4osKz/OMsSGRQcjRSmuH/6jDGtG0
 kZ6K7B6zqkAtS72DPrITOxy6yBrWzmkhsS0zBQ8oF8K2tW7r5rYOgEwlEp/8Gg0fsZQb
 TBxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFtAPo3XEWTds+U6xmEgZ7QXOC08e51bC3YLI+FlkjkH/3MYh+Je++p7fSCGBoynBngJcf1gA4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+8z8zmGx+ShNwS++O8//cAbZHqwjovJWLgEeDjT2tPYOH1Ki+T
 HpP50AmTT8xJBcBK0siaWOVZtu2i0s1t3WegkjY/SHNaRYF92c3cm0gwo55iqmuClxjRbujbaif
 R3uYeaC0AFh5bAsJfmi4gNaZtaAw8crHWQpYTjMofggqEnqCYER8UJBAp4HFJSco=
X-Gm-Gg: AYBFou1tSNtbkDNlUGWnvSa+FA+46k0sQYFkG/cms3GWtZw2tKb0ECVpKu1XLXuly7O
 pB+6j8VtJQPqaV4PzfJoV5NYE/KeTJF1lUaJ2D2xMIED9mmQhMPRhlZPsTyh8rW8FxpQyVrupBU
 dimM/+e4T1tXOzfpzY8wemlfyTC933M3fqVQ2FZOiNVXPLG6iQWBTzSGfqpmF3/fzFvaqzAY++a
 1nbcqNasddaZEd+3rPG0ueUoxEfs+ra4hVcQ6jkP/LBOC2eO5Tpbebv57O5tPQMxAu8d3xNhXzi
 VWntZIiRC4l+Vqo+4IeIRb2Bdj882Nkt9ASXA1HTpvlopjcfOiRZ+N0wn0YyCH2NB351Z6N+wXv
 VgoU706lXNT46fNMaX1HIEkbIPZM3IKR7gzgPQfIRfN/RHAifluWLNzZXG1JFWnRkwoD5k5gP63
 Z7owBQpMxrTcQklXafsB6rPHqma9GpYD4b+4QhN0awg0cpZUXybdYl6CvjolMLjFEi4NTV9rxlB
 /gy1EJf3uAScJl7n/60U5/xO90ml0P1JaAIRmbN0vPbU8vABJkSnnu12jwPJyi8c4JXHD3M2w+d
 nm32w7agmeXQkREzy1PttiVz3ltPQOZObFS+
X-Received: by 2002:a05:622a:410c:b0:538:684:448b with SMTP id
 d75a77b69052e-55aca76a647mr187231811cf.60.1794850688108; 
 Mon, 16 Nov 2026 09:38:08 -0800 (PST)
Received: from [10.200.233.210] ([71.163.254.246])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d459c6sm91704356d6.14.2026.11.16.09.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 09:38:07 -0800 (PST)
Message-ID: <7beaba3e-14e5-4e6d-bdd4-9f082d261d68@brivo.com>
Date: Mon, 16 Nov 2026 12:38:07 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] clk: meson: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <20261116173546.3487841-7-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <20261116173546.3487841-7-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 11/16/26 12:34 PM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sean Anderson <sanderson@brivo.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot@lists.u-boot-project.org
> ---
>   drivers/clk/meson/a1.c          | 2 +-
>   drivers/clk/meson/axg-ao.c      | 2 +-
>   drivers/clk/meson/axg.c         | 2 +-
>   drivers/clk/meson/clk-measure.c | 2 +-
>   drivers/clk/meson/g12a-ao.c     | 2 +-
>   drivers/clk/meson/g12a.c        | 2 +-
>   drivers/clk/meson/gxbb.c        | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index b6d1887c98a..01f364f8a8e 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -224,7 +224,7 @@ static const struct udevice_id meson_clk_ids[] = {
>   	{ }
>   };
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_clk_disable,
>   	.enable		= meson_clk_enable,
>   	.get_rate	= meson_clk_get_rate,
> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
> index 5f897d89e9b..e72eb839cfe 100644
> --- a/drivers/clk/meson/axg-ao.c
> +++ b/drivers/clk/meson/axg-ao.c
> @@ -60,7 +60,7 @@ static int meson_clk_request(struct clk *clk)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_axg_ao_clk_disable,
>   	.enable		= meson_axg_ao_clk_enable,
>   	.request	= meson_clk_request,
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 3b5f4af9f4c..8aa3d18eb9b 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -300,7 +300,7 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_axg_clk_disable,
>   	.enable		= meson_axg_clk_enable,
>   	.get_rate	= meson_axg_clk_get_rate,
> diff --git a/drivers/clk/meson/clk-measure.c b/drivers/clk/meson/clk-measure.c
> index f653fc63552..743fe6f310b 100644
> --- a/drivers/clk/meson/clk-measure.c
> +++ b/drivers/clk/meson/clk-measure.c
> @@ -591,7 +591,7 @@ static int meson_clk_msr_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_msr_ops = {
> +static const struct clk_ops meson_clk_msr_ops = {
>   	.of_xlate = meson_clk_msr_xlate,
>   	.dump = meson_clk_msr_dump,
>   };
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index d9425f900f3..c0f11ce6928 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -60,7 +60,7 @@ static int meson_clk_request(struct clk *clk)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_g12a_ao_clk_disable,
>   	.enable		= meson_g12a_ao_clk_enable,
>   	.request	= meson_clk_request,
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index b1ba5881904..1ac2b39c417 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -995,7 +995,7 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_g12a_clk_disable,
>   	.enable		= meson_g12a_clk_enable,
>   	.get_rate	= meson_g12a_clk_get_rate,
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 62c1e0eed4f..5c2601e79d5 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -949,7 +949,7 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_gxbb_clk_disable,
>   	.enable		= meson_gxbb_clk_enable,
>   	.get_rate	= meson_gxbb_clk_get_rate,

Reviewed-by: Sean Anderson <sanderson@brivo.com>
