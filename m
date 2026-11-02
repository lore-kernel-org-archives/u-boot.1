Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584F606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RTDS8yrm;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kyN3AHeW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3EB060642;
	Mon,  2 Nov 2026 22:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uC8hSYdKxXr5; Mon,  2 Nov 2026 22:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB956605B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658542;
	b=AVveof7pC8k/V7c9Ur24X84yxT2/rgSZ8Y5hpPiCevMAwAxi9uOdC0w9PDHwCcp6swJ3
	 lVVJWgBUclsJIpFFpvnW2+h+7abfIH5hmFElg3cpnahqQnTBNJBd4wTBdJ0YFZ/WZSUBU
	 TcpSvCX6eV9sxUSRT4QdB54lzCto4ss+qRfvcmC7N+1t/JxN+q7iDdue30gifzW8wzw8c
	 Mt+cVfxrfyUDYeDl63d9Ad9d14nHdSdnq5Jv0POgX5DZ8pv4tA1IhXu2IAKYGF17vkIpY
	 5Mn51/MtX4Kq5cumg5dDMArc0P8AH+0q91/oT5I4DBOtD/fDT/Dy16oh6duUO1yz6/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wP6mSo2wTy+MDjRBvQtcRD0lfCZr7DpOR6/ZnXSVtmU=;
	b=jKlNG8YL4gObhPjy0FP0ZA4vAyBzyT+jrbGIiY8URy/RYPXVwtZDOGJXz5XF1IumzBNE
	 76STZyXRVS9Gfz6sJ20AY5LKuqSFIuIbugaxqMU8UuIMtzMC8DThhJ0/RAWw/MpsXjT0W
	 KrNGai4vkGl1G1rW+MZIfZ37Xa8spQzRJCglB3JZhLjZZCLw/tY6GVRVtn4RfaZtTS3yM
	 p8x90alEO5bUGhVH/EbtFUkqTT6gDtS9lnezujYYN6LI3RaFcRIpBqZEFK7hL5jxzIN2S
	 v3XCYicuInVQMbrhXI9c4WK4NMc6PBU6bJHjwo5DofqskdvpGgllljE2m2HB5QDuHMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kyN3AHeW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793658542;
	bh=wP6mSo2wTy+MDjRBvQtcRD0lfCZr7DpOR6/ZnXSVtmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RTDS8yrm/CV12CIIhsJu7JCOX1793Qtpk/x6UDxiCRVnfpKjfDrKGw0rC7hB6Q0UY
	 PtpgzbP/+w1/2Yj8uoMBJ0Uz/djRWF7gWsdQ6W7T2KqnM1pdmOkFfFlQ0rZQY32/iE
	 np/B30af4Ih8e3ET3hC9recsPvtSwUFnKvt7UXIPT4KNDnY9aJ7CD3EW2oPE8F1QeW
	 O9Ihv3RdAcXWBW433e30OkFDr39Qq7TpiINoVTLKLkqaD929E6Zn997Nj7WhoaWF6d
	 lUEFd+QH21B5z4EtxLgp3lZdB4QDv/Szw9XoQs6WoLeyjK77QYMg1v5peWsmuNMMI4
	 UJS6c18uMIH4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB956605B7;
	Mon,  2 Nov 2026 22:29:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73DC94BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 657FE605B7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:29:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67ErkO43Szqs for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:28:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01963605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793658539;
 b=cm8SffCWaO2dlOZ10u70DkaFry33NN+aZUXTbBtZlxHS41tHzvOyW4quijoUw3968juK
 L3bnka5gZe6WbZ1VUjq62+2lx8jjjri50sS9JYQKCFN57LbJTw2VkjdfZULogVuo9yT3f
 /BwEYc3gFErZPXj3ScaVm7wFVH1K9lR6Biaq2VgVt1Frrk5GtRsRP+Hqcz0+hjVShA8dK
 pjYuAJwBarLOL5yixfJw+57Dvf0RykkPftPXczkYGTz6DMb24nxBdAvuGL+DhaGVfKVXQ
 V/b5G8SXIwBcL+f38YBIDrerJZQG2aC3u/5bsdYJ5Dy/P4mBbpD+h7gcc3AM+7w5MkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793658539;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=wP6mSo2wTy+MDjRBvQtcRD0lfCZr7DpOR6/ZnXSVtmU=;
 b=PI41GVi2svl05rylUxJ4M0Xbqj2kg5GdrbKfkkGfnpNdTGmoNNP1emzvUSubYMqMyKYy
 WNmtdi9gGLQ3E6fDaJWbPvOtszv9gtrqQhIHoqLedSEE9FmAEDQX+pFAqH2kZ0QoJrPSS
 KrWUqx4tpLc4p5ftTpeag1VcY15AHJwLRJO59/jkWT9P2a1fEyr1IVItZ7/A3lo7l6+Ke
 4NVzh4zL+RB0r++7gf6T5dPWaE/AfuKu0HW0Sqsh82QztKHjxwbqwqYp8v1gMaCfbPhg/
 PwCbaG43fBMkcbBFDBpzFPC0wfvcnvJKEvYcLNbeDXLm5CMZc31v+ANlr7XlSxdyclA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kyN3AHeW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kyN3AHeW
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01963605E9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:28:58 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-71528ede7b1so771703eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793658537; x=1794263337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wP6mSo2wTy+MDjRBvQtcRD0lfCZr7DpOR6/ZnXSVtmU=;
 b=kyN3AHeWARCEj2g8HAtyLl709q5WplDHvm3fVyrPf2Ui64kXuhmr7i0iDftb+qYN4b
 KBR8YFOTm8YErQxu/qtqztEZh0mxNJmdIbzWOvV+jIBJnIkuhYommO7l8mRES1b0RCK0
 By8s4ofU5M1tGrKq67xqaCs6eUjjbBxyseE5kXbyemOt/RubJD8cSTkMPtvMWJELdLi8
 XL9qWWQpGD+vuHiqhnpHNfZ60c/SzDfVP5ym2vfRkGKohRox3AUCm2XAPK9WKMLmtO8S
 hIeAMv9Eib59dVh4//amcK945gqKGzyLw1rMVBJRw9Q5+BDyGjLmV+rE7JGgvN8KHNL7
 2crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793658537; x=1794263337;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wP6mSo2wTy+MDjRBvQtcRD0lfCZr7DpOR6/ZnXSVtmU=;
 b=eu7WOpXWy6QHFo/yinu2Sqh2JxT6du3AfOocnuAeTIT0dMOgJdcqrnPr6ZPI9NPaSf
 pe1xH6USn25/kNm8YQwi3vi7gBjKNv4P/VgBYa2rwP/PBHJb42tse8iD0NMFbWUv1Epi
 V07QHSU8SJoDVDHtOVWXBlDeWDghNR/Mrr/Oy/YpaS3Yp9vwaGb+id8ldi+9DPGTQ9mk
 y+eabJMoyKNHk37zsZ5ZWWvqu6Hwyv9IeeHHn8p/rrKuCQLkPuW62GRKIxn4UJutXofB
 9PQXhbZorFlIGdkCPSTm981G+LWyRyIgB+en9RHRxTR/Yhyxaz98RIRaxnbhAz4Qk3Fq
 etrw==
X-Forwarded-Encrypted: i=1;
 AKwUvByXcd1Z/TZ69UH4/D/PZ47awwDZI6gGrzv8TcbjzKgm9NAPJgbZS0Bp/cfMNUACT59aCvPL4Sc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI44IjvO9NCF2fgF2YFPImD7zQrvRtI2pjYRCNxgH9wcL2Q2jdv
 +6oPj5KCEA4/wxAtJQ4JUn64Hz+8FbNLxeboldiBvsy+Al52qoMZg34kbD9IyDB49WtU1PGp/sD
 zjIeuKS4=
X-Gm-Gg: AYBFou2lM4inNOZM239Ec2iLDMJWYQjOl1iP51wgsJRTa+brQBdXCTB2vEH0eIzTBi/
 ETR+gyJWzssh30wArdm5dVl65Qh29dV3ez1Z0ECJ+2IrcaOj/FiUD42KZauTSPzcx0lVgdsCU8/
 nozBp7s7hgUbua8pEQVFRFUA/oOG5Epx7Lq0cdkSI6Nhi01NJ7/ouEhnLxcQcg7Lj29Tgh3OZdL
 yFRjflEnx4odENmnBdbCx6dkRQeY496BHbFkmiMsvdKaKM2lzjSV8/CZGLz6m2/3pInCVRV6kMv
 XOCWHtbRQlMFYw3m4pbLN9iB4tF+XKpvzyb7j1gnpEdwQKlXLV03Iq+XcyetoBE5oox3Te6E+hd
 U9R7rLv88h9g9x8wZHllN7T6Ro0uxJ1Qn9s/fNHOEOzJbPTsOYSDx1P1ARDfmKHWXip4LIj9QAW
 vh/elye7FC8lDdjrTqjW2GhZ+416Ja37GcPQD33tg9Rzt7dDHz7clDkYPLlaje7GbuogGJCbtWk
 XsEGWQiqyVd47uYs98kPpUquc2gHPskmGoTOqWUSUqoEavFEMyDDVE7uGXJRlj3LC620jiBp6NW
 jCEMmD20hxtOPl4DQf8+tuY09SMFAwBImZnqTlR4LUPFY9Iz7TXy7KmroQOtLF+2HTjqTzPAQfX
 VA4n/tbAdt1XJZ5Xn/BDal/0=
X-Received: by 2002:a05:6820:1504:b0:715:24e6:9529 with SMTP id
 006d021491bc7-71524e6aa16mr2285172eaf.86.1793658537371; 
 Mon, 02 Nov 2026 14:28:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f?
 ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354efebesm10355117a34.19.2026.11.02.14.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 14:28:56 -0800 (PST)
Message-ID: <fc38ac09-7f0a-4301-b78f-954dff0b475c@baylibre.com>
Date: Mon, 2 Nov 2026 16:28:55 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] spl: atf: optionally pass the bloblist to BL33
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org,
 Carlo Caione <ccaione@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
 <20261026154825.GB646438@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261026154825.GB646438@bill-the-cat>
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

On 10/26/26 10:48 AM, Tom Rini wrote:
> On Fri, Oct 23, 2026 at 07:09:09PM -0500, David Lechner wrote:
> 
>> Add SPL_ATF_BL33_BLOBLIST to pass the bloblist of SPL to BL33 with the
>> register convention of the Firmware Handoff specification, through the
>> BL33 entry point arguments that SPL gives to BL31. Without it, BL33
>> still gets the primary CPU MPID in x0.
>>
>> U-Boot proper already looks for a bloblist in its boot registers, but
>> when SPL starts it through BL31, the only other way for it to find the
>> bloblist is a fixed address in memory. Memory at a fixed address can
>> still hold a bloblist from an earlier boot, for example after a warm
>> reset, when an earlier stage did not write a new one. Passing it in
>> registers ties it to the current boot.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  common/spl/Kconfig   | 13 +++++++++++++
>>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
>>  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> Why are the existing BLOBLIST and HANDOFF options not enough? I mean
> that genuinely because it might be the case we didn't end up plumbing in
> something here, for the not fixed address case. But I would be expecting
> something like SPL_HANDOFF being added and maybe touching some more
> common code path too.
> 

HANDOFF would need quite a bit more work, from what I can tell.

We are passing two kinds of information, the DRAM size and some reserved
regions. struct spl_handoff has a field for the RAM size, but neither
struct spl_handoff nor the ARM struct arch_spl_handoff has anything for
reserved regions.

Also, the same info reaches U-Boot proper either through SPL (when a DDR
loader starts SPL) or directly from TF-A BL2 (no SPL), so it seemed
simpler to keep it in the same form for both. HANDOFF is only meant for
U-Boot to U-Boot. To use it, we would either have to teach the non-U-Boot
BL2 about U-Boot's struct and keep it in sync. Or we would have to have
add more code in U-Boot proper to apply the same info a second way so it
could handle either case.

Instead, we chose to hand off the same bloblist containing a devicetree
overlay everywhere, since there is already code to apply overlays, so
everything just works without much effort.

Also, HANDOFF currently requires BLOBLIST_FIXED, which means all of the
parts of the firmware have to agree on the same fixed address. To avoid
that, we would need a new option and the plumbing you mentioned, i.e.
passing the bloblist in registers from the default jump_to_image() as well
as the TF-A path from this patch.

So I could replace SPL_ATF_BL33_BLOBLIST with a more generic option and
implement the jump_to_image() part, but it would have no users currently.



