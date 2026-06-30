Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4C5C43327
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 07:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A1D84A35;
	Tue, 30 Jun 2026 09:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ekGe0DgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E16884A48; Tue, 30 Jun 2026 09:18:42 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1844B84979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 09:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4704d652e9cso1982215f8f.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782803919; x=1783408719; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytMZBF2dZ/FuvtFJUW2TaFJRtSNDcjPAr8rjU9iDfLk=;
 b=ekGe0DgCcOeOvkkpKfTRpxP82K6G3Y3Y2qvZaFOJECCYDoG4RjRWAcViQHkstR/A5Y
 nWMf2vA0Qv1xHocQxDOmheKNrx3Tpp7X+C/hKnsqPrSMWOfgu8qtvzVqw5hmfmnsyPfX
 +sE7qGGELioyK9Pdt8q6MBTorMOl7nSnWyD0bVr/8MO3wu0RBBcIAwbJ4Q3eYg1SmPc+
 gkwfUsBUeSBGNwro3A5P8S3GNPQAm6UcNkykO0+BuEwOXyeX6Um6mT7sGgyf+vIsp7DD
 ZGFjUVEqxEAcd85eKoq0ryK4bGF51uYDXzpPZpO2K1PAXiNNhjuEF8W9lWRFjK04SahG
 imsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782803919; x=1783408719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytMZBF2dZ/FuvtFJUW2TaFJRtSNDcjPAr8rjU9iDfLk=;
 b=CiwHBmYZBT6y9geFfrhN8X4hANN7T73PnJpK6qyihTfiHtoeNKeslPfst5JVbo1joF
 ziF/i069pJfWLyV2fQuzQDWpqHSywM7VaE0gFFb10WNFNImRMRGTkP/GcNyzfExgBqhR
 Z82C0E9VbowRNDlR4iNgIJhkF+zWWkUmagZHgut1fy7mgH80Ki83aeRKeMEsa7n7+XNi
 5Mb3ki/7mbRlXXmmhb9VCWaEE6Zu3j98d8LPElH9Ulrxrf1DXvwXUUKSgDAtL2gJxOiV
 94TwhHQPrHEiR5SCChf72LyK5PGnGNdr+MuzGTTq9S/dAEWyIEsaQE7PRwzzv0xTcg4S
 zulg==
X-Gm-Message-State: AOJu0Yz/kk+r5y8MZsEd6J6XzSDACzQs/94nXytSpcdQdiZlCJEn6CeJ
 sX8uCwzSARtH4oaaIDQ0Bbif3D73FwoRU4vKeULqVvSCvHqCBaw0mZ0H0b9TCIq6uN4=
X-Gm-Gg: AfdE7clIasWm7xixpUGTIbY8zYTBQH7H8IRb3EWgWdz95tqXGyOkabJ/Xfb6FEqwJf+
 d2wN54R9Yu+xeq33WF3H3FHQTDQPh+LWIWNGnLDJfkzS7qXzh6+z5AR45MMm8C/U64DB5ov/PMT
 GbQycXroPPPF3nPKmfcsMf9hHaQiWaC6Ag+lH5OonVmV8vCv8G91fMnrh1+o4l3aeI+xAXGdtSB
 uj52UJCoep/ksgKIPVCAWyjRSqM8tuY1/95kEe4rto5aHNFHxxwHgcF/1eEtBWwULZI0AhBfrHv
 s7OdUEGY+QGecZ4gXp75rmULgiimhglC4WqykZCqRgx00Ko06ZD9JuWnCmTWLdO4cX9tsCG+tjR
 bZ7voTdozbKsju/Yf5sK6WG/0LVhaPH6MQ0Xe5Yz+3SRb4sqnW6RVbE149sdqChTpX/h/EvYshO
 maVuaDOpIyR+ZK9DKZ+tW13ymyeQLgpMr3Kd0L0Zda8ZVdIKOZ9IPTfGU5tE0=
X-Received: by 2002:a05:6000:27db:10b0:46d:d693:88cb with SMTP id
 ffacd0b85a97d-47552d4954cmr2134817f8f.46.1782803919332; 
 Tue, 30 Jun 2026 00:18:39 -0700 (PDT)
Received: from [172.20.10.2] (ip-109-42-118-167.web.vodafone.de.
 [109.42.118.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d19573sm4858320f8f.4.2026.06.30.00.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 00:18:38 -0700 (PDT)
Message-ID: <e3511960-44fe-4faa-8da5-aed28a677ca9@linaro.org>
Date: Tue, 30 Jun 2026 09:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] get_maintainer: ignore Tingting Meng
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260616131133.2143136-1-casey.connolly@linaro.org>
 <20260616143649.GH382693@bill-the-cat>
 <151e43ad-d1d8-4c14-a541-0824abb7186c@linaro.org>
 <20260617172654.GR382693@bill-the-cat>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260617172654.GR382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 6/17/26 19:26, Tom Rini wrote:
> On Wed, Jun 17, 2026 at 05:03:52PM +0200, Casey Connolly wrote:
>> Hi Tom,
>>
>> On 16/06/2026 16:36, Tom Rini wrote:
>>> On Tue, Jun 16, 2026 at 03:11:26PM +0200, Casey Connolly wrote:
>>>
>>>> Their email is no longer valid and bounces, ensure we don't include it
>>>> in get_maintainer.pl output.
>>>>
>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>> ---
>>>>   .get_maintainer.ignore | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
>>>> index 899a1469b2ae..5b7d84646f62 100644
>>>> --- a/.get_maintainer.ignore
>>>> +++ b/.get_maintainer.ignore
>>>> @@ -1 +1,2 @@
>>>>   "Pali Rohár" <pali@kernel.org>
>>>> +Tingting Meng <tingting.meng@altera.com>
>>>
>>> The .get_maintainer.ignore file is a heavy-handed measure for things
>>> more serious than just bouncing email. It looks like Tingting Meng just
>>> comes up via git history and so will roll out of emails in a few months
>>> now, so I don't want to go this path.
>>
>> Ok, that makes sense. I have found bouncing emails and excessively long
>> CC lists to be a bit of a recurring email when using b4 prep
>> --auto-to-cc, do you have any ideas on how we can improve this?
>>
>> Maybe we could tighten the timeline and/or contribution weight a bit?
> 
> It's hard because we've had contributors at both ends of the spectrum
> speak up before. I think what Marek has been doing to use "N" to get
> more files covered by maintainers directly helps so that more things
> will always have someone else see them and in the future maybe we can
> try and lower the git range.

Hmm I see. I've been getting some feedback from folks who have 
contributed to Qualcomm support that they are being CC'd in too many 
patches as well.

If we will keep --git for then perhaps we could try and tune things a 
bit to be less aggressive? Maybe something like:

--git-min-percent 15 --git-since 4-months-ago --git-max-maintainers 2

Still less than ideal for defconfigs and such but at least it would 
reduce the huge CC lists that "b4" currently makes. I think 4 months is 
more reasonable than 1 year so things will cycle through faster and 
folks will still be notified about changes up to the next release.

That being said, if folks are speaking up about not being CC'd in 
patches that touch code they care about they really ought to add 
themselves to MAINTAINERS... We have board/qualcomm/MAINTAINERS for 
exactly this purpose.

The --git flags will never be perfect imho, but would you be ok with the 
changes above? Or any subset of those flags?

Thanks,

> 

