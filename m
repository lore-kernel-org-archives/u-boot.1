Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D03DC55160
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0973760894;
	Wed, 29 Jul 2026 21:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocNNcx9SCGH5; Wed, 29 Jul 2026 21:52:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B7D86080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361948;
	bh=BJ7rlf9wC83Q2/WwT84LcwjAw5wSYeZ08ar4ECdYtYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Si2iiKOiGwGaot+9ZJa08RguFMoiCYQhpyyc+dLLFY7fqua8MyMf0RDHDXOT4PDF6
	 yireMzDsSESdIv7XwoOPaM9aJ0FbCntFQ5X/AyBRIEAeendFJ5iR2oy4xJ52+IBiRc
	 g0O2acqxrqzg88rXo/NHbIo4ymPr8jZ4DtKcAv8Z8rENXuV5MDhPxagA/rs3AQpU83
	 tMy2dIWUHLtSMirI5LQkVyNLiusYxumenpQobqrAYhqy7K46rMeNBIEc3l15u1h5XT
	 snle+ZPJJ4f3JuqWBTjVue7aVEtDQVagBxtRGRPLTvbEDLceOgdAefy6tBQe5F9dOv
	 mgjQIMuNkEgLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B7D86080B;
	Wed, 29 Jul 2026 21:52:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 011EA27C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC8906071B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pEd169YIuLr for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 18:25:44 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57D8E606EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57D8E606EF
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57D8E606EF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:44 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso10930f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785349542; x=1785954342;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJ7rlf9wC83Q2/WwT84LcwjAw5wSYeZ08ar4ECdYtYM=;
 b=U7H2VRXKLJTZUqJSHuWt5Pwa9XOfQ6CsRh3wa+91RN2LvaDtludaRvOcH+8sxSPS4M
 AM9uGevQ++UjR2D7n/9Lvs6oa+sxsqoPWbm1Dmg7pXcKSnYfq7EsI/MA21sOy9ak5ES0
 EhExH2qHjEONWVrDtbqUAzFr1TEXNtZ8pZgsxi12Ectie6mJuWqpXznn2tSub+tBUDkF
 ji+9Rd+pqOngDp9BbG3z3jpJjIL5OFjmQQ+B8FveikZ0fyaYMDiGUxUdinsEyzTKitQg
 EJLjgbKihEYseH4GONcQNDfVHm7aw5viLgUdhMQiyeTLhnoVTJw+4ikjpv+NjdZvQazl
 X45g==
X-Gm-Message-State: AOJu0Yy0eQlnNm4DO3HZBAQPB7w8mr7CoAAB4yNUOEaUPznUbsfj4iBD
 umPTcg/PXLFIgvtPXTb3V+gKdPkl/T47oyvz4cd3GnzO1V3BEAhopF6k+HkASbMS1JQ=
X-Gm-Gg: AR+sD12ggRuN77b7vtzmNSVUVVszVQ3094BdNUsgGUOGNE/gIOh7uHW9BCu0r0SdrMp
 3HGo3vlUdoa/xlQJB7xqiOz9JTqhuGBM+gOm8EH3chFEAyoT6wToQKccw9YHjwWdZnjLF+mihyt
 yWnrIX5IKyQTrjhnq6nvNdlNNicrCLCFWL6411iH1tT/ICyM1GeMAHsojGjqTbmQwwDkPwYGept
 8mKzLPhnjI55uth90aJfbuTAFd4I/ajDIHEaoHGAy+rq9Z4bfrLARGKdW7PvdfHTcEDn17SGkv8
 nW4kJKpvtZgFnmPU6vCwvSMLeo0N69ELJRotAsY0BGqwpCy2TYIpcKSJq+R+WLFm+ANp2k+oGKe
 uTxIz/IbUGut2SQaU/gYEuUg3qsLF+DgbQ2olajHd/QTZ7XZxkwRHwsgJDZxnX3EQnGy05yKyqi
 WHwVusH5GZ/OOiktyAxJ8N7SGcx1d8kqierBBghq4tqdrgPJTDDNKPazH3wIHTK6KmTmYcyD5hf
 RPsgrQRn3C1G97S3v4BlcytIdGIBV9aOi0y2KRew06mT8TOgdt/1xZny/qR2lH9ofy3NH7HyOCY
 cH9eZy6JkFykoYNC0nJ7GVNyEAhL5NErPFjkfsGpeMNRq5gLlKD6TePsJhtOAnNcTAai
X-Received: by 2002:a05:6000:41f0:b0:47f:8b0f:7172 with SMTP id
 ffacd0b85a97d-47fbabca828mr4341533f8f.6.1785349542146; 
 Wed, 29 Jul 2026 11:25:42 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:4cb1:53a4:7b38:3d18?
 (p200300ff0f038f004cb153a47b383d18.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:4cb1:53a4:7b38:3d18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3935sm10483086f8f.4.2026.07.29.11.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 11:25:41 -0700 (PDT)
Message-ID: <09661e0b-b97e-4aa0-ad1b-05115b27e986@byteray.co.uk>
Date: Wed, 29 Jul 2026 20:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tpm: bounds-check the device-controlled response
 length
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Che-Liang Chiou <clchiou@chromium.org>, Dirk Eibach <dirk.eibach@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
 <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
 <CAFLszTjxT3gfjQ2Gx4OuNEc9BLzHj3jKP8irNfgCrLvJWq7bKw@mail.gmail.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <CAFLszTjxT3gfjQ2Gx4OuNEc9BLzHj3jKP8irNfgCrLvJWq7bKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785349542; x=1785954342;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BJ7rlf9wC83Q2/WwT84LcwjAw5wSYeZ08ar4ECdYtYM=;
 b=IRWG2+okVnSHBD4+LN2r4e0SzJFvYoYMEHH+C+gGjWXNszaq4k+XqE/doQukS5kzCU
 tu8/gsqyXHC/fcHjmFR4qhNZXUcUNCbfi4i60cvz+SJrK43ROdt95JcJ5MDWlln+A9l0
 nTfWZsHvoZcFQNZ5Zp0lkPxC+USwXb4rWJKCxq74HQoObfmM4PF56YXnKtz2uZxtE5In
 BEOnBbAxEvqh9w+rcfE/OHfgmeky9iAe9sjiZhWp7yCcsFXecaLZxWcW1uC67ZRk5I86
 jMkBgqzzD8dEYvVSN2J50fT/vj8GVZnAHokihXqwS0eTVrbKi0E72Vxvz7cuoNnkGGM3
 5ZfQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IRWG2+ok
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Simon,

On 28.07.26 20:41, Simon Glass wrote:
> This bounds the copy against a size derived from prop_count, not against
> the real size of buf, which the function is never told. It is safe today
> only because every caller happens to pass a buffer of at least
> sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property) bytes. The
> kerneldoc does not spell that out - it describes @prop_count only as
> 'Size of output buffer', which reads as a byte count rather than a
> property count:
>
>      @prop_count Size of output buffer
>
> So the memcpy() safety rests on an undocumented contract. Since you are
> hardening this path, please can you pass the caller's actual buffer
> length and bound the copy against that, and document what @prop_count
> means? That also sidesteps what the bound should be for capabilities
> other than TPM2_CAP_TPM_PROPERTIES, where the copy is still unbounded.
> What do you think?
>
> Regards,
> Simon

Right, v4 gives tpm2_get_capability() a buf_size argument and bounds the 
copy against it for every capability, the TPM2_CAP_TPM_PROPERTIES 
special-case is gone.

Thanks,
Shah


