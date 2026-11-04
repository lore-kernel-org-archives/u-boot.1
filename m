Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC39606A32D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y/PDa7aT;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=p1D70SL2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B9BD606DE;
	Wed,  4 Nov 2026 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gt6BibZ6-n8c; Wed,  4 Nov 2026 14:10:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2C9160642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793801420;
	b=U4roKxl28oTSch2IYCu7V9VRfMlf460UUMFL+EWebxLKAmlc51sklyksJvhlqJn7c5GW
	 aVlw4MQrhis4QbExecbHFihOwTvB60oBktZP/pJoZWFHhNGZVxozJcvBY6i9giqueIxDB
	 0WVEFMtcfdfZYXfEijAUfXHt7vqCb7C3jHF7AktWotyqKF6a4tZJ5AmDxJ2y8DK0ktN09
	 Ca2Gm72E11Jks2WglBmHhFaeMp8XnbZmvig1FZxt+Tg3VQ32xQGgYPIt13IaXgIKtozOp
	 HzsKNhha1eDxv1EAHjcaOj/vOMYZpYNtLhmgF4ShJbuV7nOlilL8puC6i8+3ID4DxeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793801420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=seRWl3qk+wxZV/weNKMU0/jrq9U3Gm3xjSoF7mFv9kE=;
	b=FO3PZFQPf7J4k9OmJCQtD9qu4qtHJPWVDIWJUnwt+1GDAXVbW5Sk728zXWUHDz6Qkdvk
	 kl8gOESxPOP8uLiLf20QieWNmI0vhZ21LmEN/oU/XHOQ2ryrIdocNSKF5QHqddvWHNlBt
	 nH03pWmJZ+FnTwb/DAtWUNz57LeRSZ3nHyDxVmAWhIimR7WKDLP0W6hhPOdMGPS+++++6
	 A7CqcRRabbHPPq9NfN7GX2P4ILWgcfjHCvOkzflOLNySQGC9SaqGNXspZsd4qzEsNDce4
	 cT8Bt5CtLVd/WJ55n/cx6BNG9ZhzTsNniqrOtp49J2pOK4ARZEWSvIKzhk3qWJcY2Gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793801420;
	bh=seRWl3qk+wxZV/weNKMU0/jrq9U3Gm3xjSoF7mFv9kE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y/PDa7aT8+GNHq1499WVO5Fd8ueut1M2EO/ly2GAGJ9SJolL7F8vaK8Dc10JOA1rA
	 VsBYBMZWJP+cUDXkVC3gxe00ugUbkANlQ3HGqXfdWHcBB/KnQExJghBr7Ky2nbqJfU
	 8H5qNPT7iuErSd2xE2+lmTsTPrQJNBiv9z8GMlzCqYmdAVmBVl5l/TxaWofBDZ792m
	 T8A1FuQ/DHGiKlcm5nzy7XaoZCun+QPhuk058cL58qua0vGJ9kVKDLhbd7Log+GjXk
	 8spFEJeohKJvh6zAqIi4Fq2Ts5RdrhFlVD8FL0prONyyFSjZpDe+Ph73GpMEQbpaCY
	 yHkV0MagW7A0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2C9160642;
	Wed,  4 Nov 2026 14:10:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7A1F34D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95D6240517
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZ2B6PZnAsBg for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E6FBA40515
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793801416;
 b=fnx7LgBUtC9bp/CjRl4JqoWM+J2um33yjNNOht6RXqlCUew/bVC/K2OFidRd5OqYvIGf
 XiJzie7i3YDvzWLwyNomBx5meKa8CD6SmyRDuy+iqFb7MO3YwMIkwyNUP88XPADG1dUn6
 WLaenwqSLyBDLmfRTOnAM0OrhLmvCaYAsvQf4JwZGlykGSKQa57gDflCIR6g/UDYMH7T+
 LXqFJ3/TXGEHTVsq7tlSbZWVHZxsuyx7WkI3zFbCpPIMIwTiH1s1qd5fuBGQBigfjTaLy
 Ss6ashx+rd+XdHVxt1xyY8kon3P0rgPZVkUJ6RBiUkiZQVt0AeM3CPcQsFZPPQp7gFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793801416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=seRWl3qk+wxZV/weNKMU0/jrq9U3Gm3xjSoF7mFv9kE=;
 b=klevq3MV4mil2CrZvlhKsT8rX5eTAs2cSqPAbWQQ7DEjJ+hTWZqhbl5himO2X2n6pZNm
 oEQd3hGy+30Ir436S0Jeb0S7QMqS9TMjiXC+6C2uH1+71tGLBzRQZ8vBE0uUEMb3GFNu2
 mwLNs60BXXsKfN2mKAQm4+SeA3euedUOER3k/8i2rXtiLE7TkL8HwqBq2XHVsL7SIzVrv
 VMRt5W+7DG1YC7h1HpRdMrfdaPV8Npvz/546+QgOg5Xt09B3hTW/mdgV5iXRTohL5Givo
 fuum/1MeqChkLja5zmsIFE0zrruFTQbv0+67fHZZ9NKYL5HQsv3sSy2ipPxm4xRFI4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=p1D70SL2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=p1D70SL2
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6FBA40515
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:10:15 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b28d7c729fso508812b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793801414; x=1794406214;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=seRWl3qk+wxZV/weNKMU0/jrq9U3Gm3xjSoF7mFv9kE=;
 b=p1D70SL2Qk/parz8LrRQ0432g55dvNgtmAwzP7FIgAkOtCV4sQUpxf73+h7vB3/8nB
 D17gWgH9e3sPUFiUovaqx+hFsXDUBVbERjmfWwROEDjwHSfyHqOwwfMGqkgt1uqIH1T4
 KgSYzq6SdjdZ/q8MuzaskFxLYQsQzHA4kZPGQbj3ELlJowMZckR+jgUO1gtewTiN21yk
 xW34mH9o69yhtbk0NipdeTnxMuvYpAcCRBg81JU+znnpkuOk1cXN7apofBQHOM0Z1mxA
 jSP7RgWgm4rxe0GEPNV8W0R1ZlfJJkkTY7/55WFhP2MZQXd5LjnO7Hhh31extbTf8nFi
 iqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793801414; x=1794406214;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=seRWl3qk+wxZV/weNKMU0/jrq9U3Gm3xjSoF7mFv9kE=;
 b=ugyovFgNz4CVecXLemtUsfu4rETjesQIRVMLlP0V5hHAesZmNcAv4wwGZeenHWtv+K
 fm+3hft16dGH+SrW0iDDGKr0BIdjSZvLoJ6AeVFKkvz0VLrNC4Ex8+0GLVj7qQXj+9x8
 TrCmqTan5Atis9b3YckcIEb30zKmxo3PnGd0Bmlwb9WtPYtiIyIIw1WFn339DBRfmzll
 xFEBDtTBzonAcisRXxuv+pF6NMq6i53tE77SES+mu1BT8ej47hz1sralOwo1l+UHAY0F
 c0AIKD8nJqDAsv8ah+4cnWzMrsOSE6gOOqt61NCW5vqpUQYyLbdKyYT1/mqDf+darONC
 SuEA==
X-Gm-Message-State: APuU4Z/a/WCGHxpzkq0gIPciyn2CQjlGSu7+e9VzlioWu50umZxT5ouD
 u8gEzc/NjO+MNepNSATYlpX3PO7GDkvKmHege3ECC7dLup7os3YaVGMFVzRHklnjQck=
X-Gm-Gg: AYBFou14EHZNJmT3yBMLLQ26Gu+a4RGTP7KIez6fq742Heh0RpEgTafqMXmXZBimhgP
 NPmc3eSXH5ezGk/xbHAeeq8E3A2FvsTWU6gJEVstpjjimPodpl9I0rn8UnOsvL5h5nLHv/52fvx
 MHHeiA4XCfJzNSwuARJPlPoG24uOTS2YkdaBNxoR8NRoJgHqx1wgDQPAv7tqdKN5yt9bZ1JS5Yu
 CAmkMjW3LXsVq0FJJS7PeqXJYs2QawCgqze5EAUa38WSqjSyhYvwlgPKtAHe0z9LDdruqMu9Vk8
 /tHx5ILsahaXq/+xBMPh0VtrFlh+ksl1WleETGKvdovakOKxvWhLwKxds8XuQC09wE+b2nvxXwm
 NtH3BcYF4TNOjbu3VcemadauJgrw6HdxNpPpJnCqUGYq+/kx3dZuM622cAEvzK50vRRZzSHtZCD
 MoC9l7WkTp4Zf53MGojyWJktYc3VRnLbaEMxqmZdeeVK1l69SVaVDMVgtHILWQNIB+520n0Mpnr
 vNgz9p0ugO9kgt1u7h06sLXbNFayfRMsIsllaRnhWx+8B6rToHLPS6vjVkIoh4CyPDGs8FIYrz8
 xQoLhl3JzuObA/Jj+WetArTboAFntGo4pzuvYZpBrQbjrvvfQAE/Tkcg2n0tQlXVtQiE2ftDGB0
 =
X-Received: by 2002:a05:6808:178b:b0:4f7:1e2:e79d with SMTP id
 5614622812f47-5640de01a1dmr11272563b6e.40.1793801414347; 
 Wed, 04 Nov 2026 06:10:14 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:f563:d5d:661c:51ed?
 ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9fdc42dsm1739132b6e.14.2026.11.04.06.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 06:10:12 -0800 (PST)
Message-ID: <775e6c08-ff3f-405d-bc5e-6b26ba66e044@baylibre.com>
Date: Wed, 4 Nov 2026 08:10:11 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from the
 bloblist
To: Steffen Dirkwinkel <lists@steffen.cc>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <fa976a04821fac42c0a937305e621c4da20fc04a.camel@dirkwinkel.cc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <fa976a04821fac42c0a937305e621c4da20fc04a.camel@dirkwinkel.cc>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 3:06 AM, Steffen Dirkwinkel wrote:
> Hi David,
> 
> On Fri, 2026-10-23 at 17:32 -0500, David Lechner wrote:
>> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
>> reserved for the DRAM controller depend on the DRAM fitted to the board.
>> The devicetree built into U-Boot can't describe them, but the boot stage
>> which initializes the DRAM has this information.
> 
> I also looked into this a while ago and found some code in coreboot reading
> EMI_CONA/EMI_CONH on mediatek socs [1]. I adapted it to mt8188 and tested with
> some memory sizes (at least 2GB, 4GB and 8GB work).
> 
> If you're not set on passing it from TF-A I would send a patch for this (only
> tested on mt8188 so far, see rough patch below).

I was hoping we could avoid this since the earlier stages have already
figured this out and there is a standard way to pass info from the earlier
stages. In the case MT8189, there could also be reserved regions that I'm
not sure we could get this way, so I'm not sure this would be a universal
solution for other chips. And would prefer to use the same solution to get
the info on all genio series chips.

> 
> [1]https://github.com/coreboot/coreboot/blob/main/src/vendorcode/mediatek/mt8195/dramc/emi.c#L670
> 
> +#define MT8188_EMI_BASE                        0x10219000
> +#define MT8188_SUB_EMI_BASE            0x1021d000
> +
> +#define EMI_CONA                       0x000
> +#define EMI_CONA_CHANNELS              GENMASK(9, 8)
> +#define EMI_CONA_DUAL_RANK             GENMASK(17, 16)
> +#define EMI_CONH                       0x038
> +#define EMI_CONH_RANK_SIZE_SHIFT(ch, rank)     (16 + (ch) * 8 + (rank) * 4)
> +#define EMI_CONH_RANK_SIZE_MASK                GENMASK(3, 0)
> +#define EMI_RANK_SIZE_UNIT             SZ_256M
> +
> +static phys_size_t mt8188_emi_dram_size(void)
> +{
> +       u32 cona = readl(MT8188_EMI_BASE + EMI_CONA);
> +       u32 conh = readl(MT8188_EMI_BASE + EMI_CONH);
> +       int channels = 1 << FIELD_GET(EMI_CONA_CHANNELS, cona);
> +       int ranks = (cona & EMI_CONA_DUAL_RANK) ? 2 : 1;
> +       int quad_ch_ratio;
> +       phys_size_t size = 0;
> +       int ch, rank;
> +
> +       if (readl(MT8188_SUB_EMI_BASE + EMI_CONA))
> +               channels *= 2;
> +       quad_ch_ratio = channels == 4 ? 2 : 1;
> +
> +       for (ch = 0; ch < min(channels, 2); ch++) {
> +               for (rank = 0; rank < ranks; rank++) {
> +                       u32 nibble = conh >> EMI_CONH_RANK_SIZE_SHIFT(ch, rank);
> +
> +                       size += (phys_size_t)(nibble & EMI_CONH_RANK_SIZE_MASK)
> *
> +                               quad_ch_ratio * EMI_RANK_SIZE_UNIT;
> +               }
> +       }
> +
> +       log_debug("DRAM: EMI_CONA %08x EMI_CONH %08x: %d channels, %d ranks,
> %llu MiB\n",
> +                 cona, conh, channels, ranks, (u64)size >> 20);
> +
> +       return size;
> +}
> 
> 
> Best regards,
> Steffen Dirkwinkel
> 
> 
