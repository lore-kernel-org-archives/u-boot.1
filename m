Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF49CA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311C36064C;
	Sat, 10 Oct 2026 13:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id amlIw-j2xvT0; Sat, 10 Oct 2026 13:14:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F296260603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638084;
	b=Y44+6av4K8rpbNySPJV9CrJWNkVBRIS6BsWZ3bsZNmVFzCknQU+IayNY+uRcHrGNiwpA
	 yEnmtXZ8KVZnTBePY9Jogb6/Oq9b75kLUkNPSohmyKniQ9ocwLzI2kzxPAJKCq25IvS8F
	 sJCjzGjL+riru6MP/+vZ6oNZk0Tx21HYSjF8X9QqnmcsGxm89MxGSai707G4GgSGhpTIF
	 rpyESC2Q4xXyzTaJAg4OYRs6uvvctjT/d3voS9z9RqTg+mRuMtyY7CWy9SnJkfyp/KIdQ
	 LmV/B3Wfc3DN4/L813Kris68qzqTQLIxllP+BcofDYl2l8tO84iF5DtLO8gosH26e/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jh5AJMBeHMfUqWhGlQprkmb4niSgBesI5JlUNVXlW5Q=;
	b=mfgLN9n9pVnzJQO0ZN89uZQ0IcEVUz7PNje7oDqlFyQcMKlZeAixuFzkvFt717C1Um63
	 TV8s/g6aeiF/BL6DV+pG3x/xkGFcydvgxeXlFC1j0wDJzEYWujX4wUGvPbvFp4eXvw64K
	 HKk7Plvzfq/B+xIiKXBCAFSAjsGK9RBFPTNNokQxRxUmei3EXx4rQRrea8t2WLY2FU+jr
	 VH2+KX+wsVtLymf5WqjzbLN+T7RVZtby2JFPIU0qH4QvifWq2aWC+8gjFBSPKZVP96jJP
	 8IZs4rCgW1LMxySipi+RCsRk+6FHzVaBIA+HQa3YMKQWYFsJMUufPpQPgH38JnH/qrw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638084;
	bh=jh5AJMBeHMfUqWhGlQprkmb4niSgBesI5JlUNVXlW5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYuoXzbgwmAVlCUe5Xy7UBWTo8sNozwoZCwtcO4s9Iy9IHtm0hQS/iIPeIyTL5ZA+
	 yGljkxmDtNtuQCyZR3OHaBlzAjOMIncCK/Fd8RwMDLnkObdWzvNWnHBLdON9FHQyod
	 82o9Oegls6RqNQXuwWnsSf0gspZJmPjtnUtIklrhSMkyI8fBiG0xbvCTqNwRPsdiW1
	 kK4LwzXBfggY8zX+dpkkS45j/AaDi3evD0FhOoHAGcgSSPhOu8S27cvDi7b0oK5Yro
	 HFYN8S79SWVTkBtCGDos/m/C/9iFnWglqdbYiwWTmsGxpiVAxe1GZGnP64S435LDpB
	 DbzMACJ6Eh9JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F296260603;
	Sat, 10 Oct 2026 13:14:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA1E71DE
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFBB8400CC
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cnC8jO65j1xM for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 06:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 700FD40004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791613032;
 b=O0lYBp/kERpi1uxixBxSULt8pYcvcS1OXjxY134CpKQgF0wCBl/wHyQsxQqQu/4gOzqc
 aCBtD/UxKhBMk2sTqYJdbc0Zx5oH/iITkJD1b0seDWe/cj08nfzFIFy26C8jPyyk/jI6+
 +ClsaQvWkFT9jPP9Q2wE0a3noDdYKGZzI4k9RTbjNz0LuLpcgL/luwl007w0TLeNkLb22
 AdoJIUbxFyVzbnNlEHsGWbalA5poWfI2eN8p8FkYkBFdMM3LCVPn8o3+QCxDzE18bRuzB
 oT8JEzdSZKyss6DjZxGIxWIFH3ahfyWOfd3N6R4HvQG4TDZACjMxmcu+sxDMUNJV1zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791613032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=jh5AJMBeHMfUqWhGlQprkmb4niSgBesI5JlUNVXlW5Q=;
 b=SXlliOGwSjEX1t1Qq9mYFqXkfm717Yqfk4y+h8cVINdWLu2lA5EPsgxAJNDbn8IsV6tX
 NA/ZNj6aW5FnMo72pFrNo9ybA+ay42wLWWQ88JEHni79VVwtt9yalqWMWtBtTwqj2awar
 VU8SiyGpcaekc2P+9ia4onwX8R+QXx6WnVpmiTkn3CQNCApR4kGi0v96ghqLwjkYmv3QX
 NR3lPNg/oimS5cYOEAKEffLgwWCNuyjm4MW1H/42Gqoy2TrqNaAwxv3HgP4hF4I+VXy6B
 n2ICiZei138w5XZz0JDdJz1S1rHtLJKOauRTby4zYE/CkMlXHcpr3SEQyLRAPc4xuPA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sgA5oDol; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sgA5oDol
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 700FD40004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:17:11 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-891d19d00ceso90591b3a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791613031; x=1792217831;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jh5AJMBeHMfUqWhGlQprkmb4niSgBesI5JlUNVXlW5Q=;
 b=sgA5oDolTZbCvWsPuH0dQyUzXpz8li4PDhXaEDUnj+vdw6IXq+DLfAPgci8zo/rGFI
 PHoiBEy3syL7jQTOyv8hSif0cWeLtAuMCyH0aL8kkG261dhgL0IejQ5BwGUmPVfz9TAm
 sWlmByRtHdSYAU0enNcd3quohIADfThR/uqrh0oAO5XJBnNZzkLHb+MaRcjzD4hZFG2T
 B3W6liWN0I4ua+CTYMiNPl2D6O7N0xhtbEH28KBNgBL7/VFbGB3hCU9r892vLPG33UGr
 /Qf7I8xtIUbW/jjpdnbbJAVUd3YkPMiDtFLHX9ko9IB1/STwXeQJcg8pfuWoDnzBhQla
 l2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791613031; x=1792217831;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jh5AJMBeHMfUqWhGlQprkmb4niSgBesI5JlUNVXlW5Q=;
 b=2rtWiUXyl2BCoF/5uzdIN6wgT1w9y8agE8Lo16JPVZPrioMUrSD7IHpUJMSMK0FrP8
 u2Xcr9OfIshNKWgyG1QEDSNWD/c8NzvhRFVUMvYcw3BT27jotmDq+OmQ4Oxgw8yfnk72
 Yb4jh2L7DRwAWax7VqC7EOuNiYPUOB9DeJtNAo6rl9KrRnZFSs6AXue7s19lcA3W57Sn
 TdJhMQHCTLi3xjupP25aVun6Sx4aQMdg0i5ckyeKyPu6xoaPu0VgkPYR52/l5SqVA33q
 K0JkRb5dVZCCnCVKcCH7YiegWlnRn+KvVLndd/RhoSmclnAOulROt2BMtu+wJLJ7sg5A
 xzOQ==
X-Gm-Message-State: AFq9FYJZSaf/T3Q38UjLXD2zxwVnJqOHJo57pKojt4/fm4p4PnoExaS1
 jWm4hZ/sG+ljZmLtF1Y/WcIuVESNcsayWlwXAYSCalrbM64YTgBjpX+n
X-Gm-Gg: AYBFou37Xwf2ydfE74hdoXxJfDgEhgt08zS3MVMxqc4lGwBsslHBCk8C4HvisL8tTag
 I5hxutf5D/OIQnnNPyWz9UJdgMg5i1aKCf0x/2WlquhBnJ2SRmm/MHvMbgu54MpB3YcKn7cy/Hg
 2VFm5G/XyK/W+/GBtCZzDHVhcrRn8Qrr92KmkOR5gpe78Ae6SNJZmG1p2srZGSjdWebu+qPh7Na
 exOR3jVoo6qPXGem8SBEsQRi4ZtwCxV0tQSz0pSF8SIF0HL9NbwTFJvvZuxk4VUvtfmVmYKe8IM
 Fxe/uv9+RwEvcepUsCZs6FGRiPgnCTjiso6XwTzH1Y7zVCS7a+XOA5BPoFAPzrTtSywom+ozuWX
 dpXW53LmUWfp+ztT2ZXx2r7u0u07Xxy0XEXT7u05R8h3zDD4Rmq+8lWbwtyd+AqH3P63QNHDFd6
 HdMc7cKDnyHZOfAeZRXLNPvn2DoWl3x2Qnz2hXBA3+u7SYrCQh58S4ijJWJJ0HV5iH+ZZ0kHQHK
 0KobdcwTg==
X-Received: by 2002:a05:6a20:a10a:b0:3e0:e46f:7bab with SMTP id
 adf61e73a8af0-3e16be08710mr3273695637.32.1791613031200; 
 Fri, 09 Oct 2026 23:17:11 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3ecb01dsm1926639b3a.36.2026.10.09.23.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 23:17:10 -0700 (PDT)
Message-ID: <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
Date: Sat, 10 Oct 2026 14:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

Hi, Dave:

On 2026/10/6 02:01, Dave Klotz wrote:
> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
> separate commands. The controller handles multi-block PIO reads in the
> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them through
> the v2026.07 and v2026.10 trees.
>
> Drop the limit and use the host's b_max.
>
> The merged v13 cover retains the v9 changelog entry choosing single-
> block SD reads in SPL. This reverses that deliberate policy for the
> recorded RV2 SPL boot use case; no general multi-card reliability claim
> is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
> CMD12 after a multi-block read rather than requiring CMD23. Additional
> card models, cold boots and transfer-error recovery remain required.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
> Validation: unchanged executable change from v1; exact-base source
> replay and checkpatch pass. The corrected combined integration, with
> separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
> automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial. This is
> an integration result, not an isolated test of this patch.
>
>   drivers/mmc/spacemit_sdhci.c | 11 -----------
>   1 file changed, 0 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index 6488ae0fdb..4284553177 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -324,16 +324,6 @@
>   	return 0;
>   }
>   
> -static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
> -				    lbaint_t blkcnt)
> -{
> -	struct mmc *mmc = mmc_get_mmc_dev(dev);
> -
> -	if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
> -		return 1;
> -	return mmc->cfg->b_max;
> -}
> -
>   static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
>   {
>   	struct mmc *mmc = host->mmc;
> @@ -574,7 +564,6 @@
>   
>   	spacemit_mmc_ops = sdhci_ops;
>   	spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
> -	spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
>   
>   	ret = clk_get_bulk(dev, &plat->clks);
>   	if (ret) {
Using the current version of the next branch u-boot (ed869863c7),
with your MMC patch series applied.
Since the SPI controller is not enabled by default on the BananaPi-F3,
I also applied another patch series:
Link: 
https://lore.kernel.org/u-boot/cover.1790976767.git.DaveWK225@protonmail.com/ 


I tested u-boot SPL with three SD cards on a BananaPi-F3 and found
a reproducible issue, the specific error I encountered is spl: partition 
error (Error: -38)
At the meantime, when i was revert the commit:
mmc: k1: let the SPL read SD cards more than one block at a time
the error has gone. Same SD card, same operation steps.
Maybe BananaPi-F3 do not support read SD cards more than one block at a 
time?

The issue logs are as follows:

⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ↑ git log --oneline 
origin/next..HEAD
6b4af8b1dd8 (HEAD -> k1-dave-mmc) mmc: k1: do not release the shared AXI 
clock and reset on probe failure
4114764d716 mmc: k1: let the SPL read SD cards more than one block at a 
time
6676ce89521 mmc: k1: handle a missing max-frequency and clk_set_rate()'s 
return value
6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller in SPL
⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ↑ export 
CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv
                                               export 
DDR=/home/hack/k1/spacemit-firmware/k1/v0.2/ddr_fw.bin
                                               export 
SBI=/home/hack/k1/opensbi/build/platform/generic/firmware/fw_dynamic.bin
⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ↑ make O=build-fix 
spacemit_k1_defconfig
                                               make O=build-fix 
DDR_FW_FILE=$DDR OPENSBI=$SBI DEVICE_TREE=spacemit/k1-bananapi-f3 
-j"$(nproc)"
   GEN     Makefile
#
# configuration written to .config
#
   GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
   CFG     u-boot.cfg
   GEN     include/autoconf.mk.dep
   CFG     spl/u-boot.cfg
   GEN     include/autoconf.mk
   GEN     spl/include/autoconf.mk
   GEN     Makefile
   UPD     include/generated/timestamp_autogenerated.h
   ENVC    include/generated/env.txt
   Using .. as source for U-Boot
   ENVP    include/generated/env.in
   ENVT    include/generated/environment.h
   PYMOD   rebuild
   LDS     u-boot.lds
   CC      common/version.o
   AR      common/built-in.a
   CC      env/common.o
   AR      env/built-in.a
   LD      u-boot
   OBJCOPY u-boot.srec
   OBJCOPY u-boot-nodtb.bin
   SYM     u-boot.sym
   MKIMAGE fit-dtb.blob
   MKIMAGE u-boot.img
   CC      spl/common/spl/spl.o
   MKIMAGE u-boot-dtb.img
   CAT     u-boot-fit-dtb.bin
   COPY    u-boot.bin
   AR      spl/common/spl/built-in.a
   LD      spl/u-boot-spl
   OBJCOPY spl/u-boot-spl-nodtb.bin
   SYM     spl/u-boot-spl.sym
   CAT     spl/u-boot-spl-dtb.bin
   COPY    spl/u-boot-spl.bin
   BINMAN  .binman_stamp
   OFCHK   .config
⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ↑ cd ~/k1/uboot-2022.10/
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ cat mainline-fsbl.sh
SPL=$1
FSBL=$2
cd /home/hack/k1/uboot-2022.10
cp "$SPL" board/spacemit/k1-x/
python3 tools/build_binary_file.py \
     -c board/spacemit/k1-x/configs/fsbl_ddr.json \
     -o "$FSBL"
rm -f board/spacemit/k1-x/u-boot-spl-ddr.bin
echo "Mainline SPL is included in $FSBL"
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ bash 
mainline-fsbl.sh /home/hack/k1/u-boot/build-fix/u-boot-spl-ddr.bin 
/home/hack/k1/uboot-2022.10/mainline-spl/FSBL-dave.bin
(2026-10-09 21:37:10,279) arch : RISCV64
(2026-10-09 21:37:10,279) description : spacemit k1x fsbl image
writing RSA key
writing RSA key
Mainline SPL is included in 
/home/hack/k1/uboot-2022.10/mainline-spl/FSBL-dave.bin
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ lsblk /dev/mmcblk0
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
mmcblk0     179:0    0 29.7G  0 disk
├─mmcblk0p1 179:1    0  256K  0 part
├─mmcblk0p2 179:2    0   64K  0 part
├─mmcblk0p3 179:3    0    1M  0 part
├─mmcblk0p4 179:4    0    2M  0 part
├─mmcblk0p5 179:5    0  256M  0 part
└─mmcblk0p6 179:6    0 29.5G  0 part
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ sudo dd 
if=/home/hack/k1/flash-dir/factory/bootinfo_sd.bin of=/dev/mmcblk0 
bs=512 seek=0 count=1 conv=notrunc status=progress
0+1 records in
0+1 records out
80 bytes copied, 0.685238 s, 0.1 kB/s
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ sudo dd 
if=/home/hack/k1/uboot-2022.10/mainline-spl/FSBL-dave.bin 
of=/dev/mmcblk0 bs=512 seek=256 conv=notrunc status=progress
304+1 records in
304+1 records out
156128 bytes (156 kB, 152 KiB) copied, 0.72263 s, 216 kB/s
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ sudo dd 
if=/home/hack/k1/u-boot/build-fix/u-boot.itb of=/dev/mmcblk0 bs=512 
seek=4096 conv=notrunc status=progress
1953+1 records in
1953+1 records out
1000145 bytes (1.0 MB, 977 KiB) copied, 0.818001 s, 1.2 MB/s
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ sync
⋊> hack@morise ⋊> ~/k/uboot-2022.10 on k1-bl-v2.2.y ◦ picocom -b 115200 
/dev/ttyUSB1
picocom v3.1

port is        : /dev/ttyUSB1
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
stopbits are   : 1
escape is      : C-a
local echo is  : no
noinit is      : no
noreset is     : no
hangup is      : no
nolock is      : no
send_cmd is    : sz -vv
receive_cmd is : rz -vv -E
imap is        :
omap is        :
emap is        : crcrlf,delbs,
logfile is     : none
initstring     : none
exit_after is  : not set
exit is        : no

Type [C-a] [C-h] to see available commands
Terminal ready
sys: 0x0
try sd...
bm:3
j...

<debug_uart>

U-Boot SPL 2026.10-rc5-00639-g6b4af8b1dd89 (Oct 09 2026 - 21:36:48 +0800)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:1800000
DDR firmware: [0xc081d340]:0xf0227179, size:0x8d98
DDR is ready
No SPI controller (-19)
Trying to boot from MMC2
spl: partition error
Error: -38
SPL: Unsupported Boot Device!
Trying to boot from MMC1
alloc space exhausted ptr 104380 limit 100000
Aligned buffer alloc failed
spl: could not find mmc device 0. error: -19
Error: -19
SPL: Unsupported Boot Device!
Trying to boot from SPI
Invalid bus 0 (err=-19)
SPI probe failed.
Error: -19
SPL: Unsupported Boot Device!
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices

### ERROR ### Please RESET the board ###

Reported-by: Zixian Zeng <sycamoremoon376@gmail.com>
