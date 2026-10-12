Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26EBCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F68040508;
	Mon, 12 Oct 2026 14:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHFPss35SNs4; Mon, 12 Oct 2026 14:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 996524061A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813916;
	b=StLxMvVLygrVT969/aXe+dcDgcJO0pWtXVhDZtiGpPNGF/WlWheX63mW0nNCvqYCRc4E
	 LXxzS0Z9eocUjOkkyYzpyYmwwnqyWU+SV2Dt948RoKDobGQK6DNHedILCm0f+HAotn049
	 SBXPb7K+Mrl1qGzB0AmdSdCjt4Vt+EPlUHraE8TZWrJ49EANwAYfCERy+Yd6SHiYQ2VVr
	 arWLi3OqQSiyS/fXfV3+q8DiaRAfvlk3R0rp4zOZtbwrqsLmqUS4/tfoFciAUX++fNCct
	 XWYVNeYCE5vox45yhZV1VL8PReEg2LWRQV7xtI2mXOeU6F8RlQhFLtBp7clYjKvqykw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=D9B7Muw5QGy6yKePnm08OGw2JZs875+DbCN735BI+lk=;
	b=UHpWuUam0aQsbiYGWzlUflDt/pHGcyHOvuZFHFYlyTrkxm5gzYL+Qi69vtSF4cZmvxTI
	 SNshROseZ0SM9PbyxRWefgqBH0vfKxWq0J00GAYLamp9xWWV7WuIJNeUawfFoT/ATFGA/
	 4O8VlxSzYs92+KzocTift0Q5GDLpaat9nIdYTX/iJz5Yi6F0eu7lJEWxfFWkZsqSmjR0a
	 /HHjaXiK3cuu1HKnkMs275ME0LFS0S2YyE2abmnkcNpEnzyQI90l8CHz6LMfUON9rPM5d
	 5uyNmn8/n5aitc45WpFuEFxOlLMPxpLSVc2QihhB5nesWLO1o0Xqjoub+zpUaKprXbQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813916;
	bh=D9B7Muw5QGy6yKePnm08OGw2JZs875+DbCN735BI+lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFpmeh/9cYsG4VBCG7MfRV1RrqqXk8vEqYR6jIP6hR5etGqRT/cZuisVTez7gdsO4
	 w3WV2vGCQUECQAm7EJqA2BiZrUlzupXe0CzgVNwpqtCeFEBrFRIWfLxOpIyvm7s9vG
	 2wtzwEScRq6RFe/aBVrvmrWkwRX4nHc7IzQAwOf9MUb9QHmQHCF4GDIW1ZQdixRqxf
	 929VtL3nY3jBpRMlHcFVnsXfHX64T/7ZVN6wCY/J85A9p+D6Tgl1bhADjno1+v8NBk
	 74hPm/yFTATWywuYRmArK/e9w97AtycPqYotjwxoWFpvmfjSD0H4jIpp6vq8DkIqrH
	 aRivdzvrIhnew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 996524061A;
	Mon, 12 Oct 2026 14:05:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7257F179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 583ED60665
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJ3t2nEsooF0 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50EAE60664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813913;
 b=jIbWaNjCwwE5F3OM/u6GHODRtjgrodU5nx4OhJsXHXsYdsRQ5s2fpV8ARa94G7ugL+NX
 RDZlmIrDCtz0GfbEVVqsN6wtZB55Yr2Sl1/Ha9HYdNI1ZWzlkeAIh7VW+dnrdi7lCmiGE
 xXx1O6H637W+zPThlB61/q2yXpu9eQ/LzCTrzGZL5tb9TMOwMCOxP3Uhza0eKb5eFj1OE
 jK2ndHem7r7qdf4PQkYQwuLSPYvejeLoqgOVVUvVJgQr1HWjYXtXHIHCsNtu+72XZ+YcB
 31ycEj95Q2qifNj1xJehf7Yho//+jOKydsoTcckK4FZOPVICX//tVAJpFrHmWtPWHzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813913;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=D9B7Muw5QGy6yKePnm08OGw2JZs875+DbCN735BI+lk=;
 b=W8PFSfSU1Gd8Hu2mwSmzbF25htX/hth4kzkOIK+b2cHzjBA4Zazjjeu+mKShbaYirSlG
 KAbuDcTaxvnXGGmGrfb5mqnbIHZOepAwRu4ec3XaiN46hIS1Ie7Ca2hZ1c2Xe8n69/I1o
 Zo9DuLnMnUdhWhG+FZZ7i+bb/LyZYKUCaR+yTZZ0qw/h3scbwV3157LVGRmAwD/TBprvy
 vQns5ZociRVSEh5xYCTNlak2CUzVR2QbjCXlK4XpB0zLfpvNXloF8mF9nYNb49Ejaw+0i
 VxJePe0lD+zqb0QMZsHyI0wTwFl4SGQIl63zlLRqxS7u9cqy9RyHPAT4/2dC+VwM/Tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SRSnscEe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SRSnscEe
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50EAE60664
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:05:12 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso4074577a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813911; cv=none;
 d=google.com; s=arc-20260327;
 b=UlDbb5Gw1qq9PYmnQLdwt/rHqoFVfGKSLAH/YdGo8ynr7wftAoPbwd57uEyIg9+/TV
 pGsgOcu2MiW+0qjkuOSFoGj+7XLtcTWdfUGtNwo0UXRV6DFQmYhPND5cWrauRPgjd47U
 nKkAd55Jta3Ymfb29AyE6i45qAbc/oc3MId44xb8Zmu8GwaRMTvp963EzkHDIvK8bZED
 2ZYKUi18CxDqoNoBn6sGDW+8Rholms6N20qUeT+J5mjcdz1Zv+xgevvBvCa+ZK4oB7ST
 n+FXGb66Rp9ExjsoQWuW5wFfSUCxxDD85LcX5edFPa13byBdUBjemwZ66JtLMzriwhNJ
 /S+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D9B7Muw5QGy6yKePnm08OGw2JZs875+DbCN735BI+lk=;
 fh=94mLggegBjl9Y6DYb3CN7EIVbXQMsAAMr4LWwzyiHXg=;
 b=WdmrS5hPyvaap+pJbqf0E16konuVT6KsRGWROegvUgHcCnX+rylxTRGz+6DS6tG5AF
 dF8FvSWnER+4PqUNS6Ivb+omsWzC49K6OvvbSgnpd02uttq4SG7diby8AbekV8hfqosl
 sbYhjk7cNbYBycmOEcAx+DwmfxeOAQ7BAJRDKK9c1rD8PT4sSfaTNl8AXQCPjJw5ubnc
 pFIcNjX80fROXlc20Oaj2Pndro3cZk0g7/usx+K+a4psoaUrBE+OXsffkf+EVGbYnTW4
 TvP138RaJwOWxk3+G8232WERBn1l54GhvJ8VY5xTH9oLkX9Vni1J+Qfk4sNHEiTm67ba
 sSlQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813911; x=1792418711;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D9B7Muw5QGy6yKePnm08OGw2JZs875+DbCN735BI+lk=;
 b=SRSnscEeptdTA6Nr4NHAW++zudnlPGv2XnioDVSxMBMxvI+eBwiXnpg6P+smwLLmcy
 CeDwwaDQzT7Tjk0r/TA2gjpgDzn/vddE5mpzik3WtXOapiGr90VG7cP4drUCGsQnblfH
 V22F76ICw4VZqRpy/2gM+Q5UIEsbisfAlFHJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813911; x=1792418711;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D9B7Muw5QGy6yKePnm08OGw2JZs875+DbCN735BI+lk=;
 b=iVJOkXmFKtd16J1Po6IPwFdfDHpSc0uRodVhLfZZA3O5l5afzziJ8wLRMQT0JK9uWm
 i4gpXiJMISgf9/PHBbd9jgkbi/F/+6mPE9N6+8/Ejdls7g4q9R9n9BnjnYwZo6/Fduxe
 QvKEiLS9A9cb0Us8PucDCwQ5Afb8f2RqA/51qTIJkudTsQWSdAp8IFtepGiJaBC30c6V
 sxbhFauiRxxZNSc3SXdaFoTaaSKFM4QpBZKOBVArvfnDq1TNvWK0EAFsqQmqALDG1Jpg
 RIBwZ2VF9gbJ5itXqKNZrK/D/6DdlsRQxYYKGB6mkDUSRyANj1pH2tZT90JhUwvDT1ud
 Yh1g==
X-Forwarded-Encrypted: i=1;
 AKwUvByX8Dud/WFA0sIClrm/COfW9n0URLHhe+h8RT/PTQIEDkTUeJsVG9r1mwwAtiUgQEZCk++nHDA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIgMoEPV8vXWxfgN2ynAAknBVFje/pKv2EfmANi54aME3AS//Bq
 +i7DTB1Fi/6M0WJnX9jpO8rHtN6/pG8gVGXhjh+NWFsXK3zeUwGRn4mb0O7YYUn/FyGMxaGeQwB
 xjMtdF87FkPuNVXgiaFHr/ZHP9J4voh7IdZwLuOba
X-Gm-Gg: AYBFou1Kgk/PNRQudD9aJNYX2vhQ1LcR8BTWmcwb+E5453yamLrUE5l6pe5jZCgUkVj
 QXCRIucvCP/kU/TJwutby/IiOcNRJ+wvazKPBk3ALe2FHY72BpuiHoXlt9ROBrrEzJ1mAM6HZP0
 +yDxIq3PqgRIs1VgW6zNR+SkyrPF/ChhQQAHIeW22LvZFbXJDkiNO56AdIMibVfGZ6KNraeIjCd
 BNe0liLsSpvhFyPTm9dTCINGx3ldpU+4li+BxSrg144MbLjo71yQMVx36zIn6yn8W0oYCVvPQv4
 zQpxDgS/PLmcQXD8oZuTrZrnEatN1i1d103F2/gAXwYF7nY7QPec6rM=
X-Received: by 2002:aa7:cf16:0:b0:6a9:9a0e:e05f with SMTP id
 4fb4d7f45d1cf-6b17ae26000mr5619661a12.2.1791813910809; Mon, 12 Oct 2026
 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261007185042.10718-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261007185042.10718-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:04:57 +0100
X-Gm-Features: AclHuK9qzIoyhHq3WwEV_hVyIcfwREpg1KX61IshQfsUaTRtqo5dDU9_A5Ar80E
Message-ID: <CAFLszTjSK7ELPRyooR8rhcew8oa_4U+B2soTT_z9gb1ktZQMRQ@mail.gmail.com>
Subject: Re: [PATCH] lib/rsa: require the modulus size to be multiple of 32
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-10-07T18:50:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> lib/rsa: require the modulus size to be multiple of 32
>
> In multiple places our RSA code assumes that the key size is a multiple
> of 32 bit.

>
> E.g in rsa_gen_key_prop() and rsa_mod_exp_sw() we allocate uint32_t[]
> buffers for the modulus based on this assumption.

Please can you say what goes wrong today with such a key? As I
understand it, the 'key.len /= 32' in rsa_mod_exp_sw() truncates, so
the modulus and rr buffers end up a word short, and the memcpy() into
buf[sig_len / sizeof(uint32_t)] can overflow when sig_len is not a
multiple of 4. The patch also adds a second rule, that the top bit of
the modulus must be set, which the message doesn't mention. Also 'E.g'
should be 'E.g.' and 'bit' should be 'bits'.

>
> E.g in rsa_gen_key_prop() and rsa_mod_exp_sw() we allocate uint32_t[]
> buffers for the modulus based on this assumption.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/rsa/rsa-keyprop.c | 11 +++++++++++
>  lib/rsa/rsa-mod-exp.c | 10 ++++++++++
>  2 files changed, 21 insertions(+)

> diff --git a/lib/rsa/rsa-mod-exp.c b/lib/rsa/rsa-mod-exp.c
> @@ -283,6 +283,16 @@ int rsa_mod_exp_sw(const uint8_t *sig, uint32_t sig_len,
> +     /*
> +      * Our code cannot handle key sizes that are not a multiple of 32.
> +      * NIST FIPS 186-5, appendix A 1.3 requires the topmost bit to be set.
> +      * Reject all other key sizes.
> +      */
> +     if (key.len % (sizeof(uint32_t) * 8)) {

This comment is copied from rsa_gen_key_prop(), but nothing here
checks the top bit. In this path num_bits comes from the
'rsa,num-bits' devicetree property. Please can you drop the FIPS
sentence here, or add the check?

BTW, since num_bits is now always a multiple of 32, the 'sig_len !=
num_bits / 8' check in rsa_verify_key() also ensures sig_len is a
multiple of 4, which covers the buf[] sizing further down. It might be
worth saying so in the commit message.

> diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
> @@ -679,6 +679,17 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
> +     if (i >= rsa_key.n_sz ||
> +         (rsa_key.n_sz - i) % sizeof(uint32_t) ||
> +         !(rsa_key.n[i] & 0x80)) {
> +             ret = -EINVAL;
> +             goto out;
> +     }

The logic looks right and the error path frees everything correctly.
If it isn't to hard to set up, could you add a test with an unaligned
modulus (e.g. a 2047-bit key) so this doesn't regress?

Regards,
Simon
