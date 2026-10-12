Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E6CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35A3D40659;
	Mon, 12 Oct 2026 15:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DI9G4c_uubPf; Mon, 12 Oct 2026 15:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F82440651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791820103;
	b=PE26oqTegn0ESFAd8YUlfg05akiZvWoV0e9oHRHRt9leDUZtXzaznaqH1qS1EM327whO
	 GkRMiiMxduRgE311vEYRmwmzgYwkYPaXZtOX22/XcJpng3WeeSDOHfsjtBNQ3NCRm0Mx1
	 /QsU/qekKGSytD5/JCY8eSngOcGY2JkW5ijr5PGn/QOoqCQ6xA7+RTuau+nyf4ldSDXIc
	 vmeBDcb62acfaJbismzkaKltSumCjPaRd2QJwPbeSeEQhIi+bJ1HbHr1i00F/XDA9byOV
	 Va8kF4LqAJMZuPZqvcCaIMJG6KQo1fnpwzr19m+6Fm4lyOmAapRqkg/MigTySm7umIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791820103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:Autocrypt:
	 Organization:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=PgS786/bgLmo832rBrM/TEoTEL6xw03i4l85HaVU0vs=;
	b=iMEjoy23kwW0IOXzZTVMnNjiJFJoA454Rvn50XKsCUgUnZtg5xi9SoHOQaX3RF/6nKxu
	 SIDOaS7nzvUT+zDNoGOI0BnCurvaFZEk3q+ABAWhNr9CYh02PYyeYFBfMFVqHeB6CP1I+
	 c/T7P16kEuynv4tMWpZN8kvhLRR7ZAEFgrrF4eT133ut3s2DE9dyW1gYjYbQFqMHUftYx
	 8gQ0WWnpDVGX9QfF68oUQtjDLB1a2PebmONM4ROc8g6v/9amluZAqSoG8+WuryWeQcmIN
	 YPPgVfM5PdNjYX2/QfoGZeRgqmwQRl2WNUXykGINIHPDcOAb0bvl3NjB4R0JnF5SLwQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791820103;
	bh=PgS786/bgLmo832rBrM/TEoTEL6xw03i4l85HaVU0vs=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Fyptcsco07crWS/+Wj8xfP0Bks8LHVmvY7HF5EOw5Xk0cwKkyEt4g/cICSiLfhpNw
	 7mNQGlXw4R0Fh00AtK/1+opW6uJH+OTx2Q4lTV74gVwe9/Ra/VkUetAUYp6yZyQVcM
	 FjgCTameHeDWc1LrKXJriRB+1pY8nk7NicDGlLuvgJoTtJNzzrijU+4sMYL5jwN6l3
	 9E7N/x8RV2960nkCyiVUPCqc5GhIhSwABl187VfN8088DAmlvsafLsJyIvEj383hg2
	 kFZ2y42CfNiK6Nksu5FFAqzlvEGEkmFJjy09l7qhJn7K/bSmRjHKTHRmClf2XgaiLO
	 qzX/LAtd/ozbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F82440651;
	Mon, 12 Oct 2026 15:48:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C466380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F20C480DCA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0JE_3WAayMd for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:48:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2FB080DC5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791820100;
 b=gy8tGw3cFR6khlrwjNq2BnN3eu6TohqIkp7vUEQ3bG9HLSIOvPe9Yu5j2WbtRycxovI1
 kOuUaflebdY+dkx2Pa7FkM2EqLJ/QZ3FFKCGtPJhdJLD+qaH3jzGtnw7ObwctH7WFWzk5
 vZlKM+blOpsajdff87vV9bqdf2l74etvJVB2RBZ+e9BSWIAu3jPj8H0Ulz9YvIWi5U/6Y
 FXqF1el3D9BQbA+DApdKsw5O63FQHGYq9qTVKbLYaXuTmQkSgGgujbJWIlY6l5UQRLqgz
 1QjSSMZW+irtYi5uG8W6ZR8VGjmYRs8MIHvBNO2tWVHh2LkjxrK/u17Ss4a1E9EQPSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791820100;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
 Content-Language:Autocrypt:Organization:Content-Type:
 Content-Transfer-Encoding;
 bh=PgS786/bgLmo832rBrM/TEoTEL6xw03i4l85HaVU0vs=;
 b=pyPlMzFcTYymkLNds5dxlyLhHCq66G0Exv+pkLkbbp98XvJ3OpZ/KoFJM7lQZ9mI2Wdv
 HV0VwUA5z5IhLnGhkSkDcmGEFl0JOHGINvn0xFuMnW/RTPY69/wwCk67tqqul9fIInvgg
 Eh1E3Nt4h+kku7HrwcUCUFaoJD7+7G6TOmoZ143rs+wpyg1TnJ5nRL4Cd2EotTV2cmAy5
 2bmuiVtkgzyNHH6Bfj6dgkbg3KaRSWQC8b3qp/fWE+GIc9PN9OQ7Oyg7UaEZCyhEwDgMH
 +EW1Cmf71B4GgA3v6NjHazVD71LSmg6L8voRUWZkTUKVhK6MXfnIEg+jMsIAsk1nVgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="zQGo9g/J"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zQGo9g/J
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2FB080DC5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:48:18 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c02782159so1248727f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791820097; x=1792424897;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PgS786/bgLmo832rBrM/TEoTEL6xw03i4l85HaVU0vs=;
 b=zQGo9g/JR+lgK10+cSOY0OAvXulD0132V0L09U4Y6Pi/5Ihh+2qwfA79TxVs07oeaG
 3/qk328qtYFCIOYkWD5dTTElDtBuBMbQWEY+J/PZzZKFwSGmofsGDHpzXqH++p2Q1UUT
 q7qjkEeyF0xTTFA0Jd+Hm6RuZTKsNlDzO6G9ceEtvU7IoXBVtKWMkjKg7JHpbMnAVUJh
 q5Kwfl7BRx7S/dC+VyjnVfV1Ulc7mXj4HXWr9oCNdTI2Ync9z28AsEuvWS+J98/u3s+T
 70FNfraA574JrAkEbhAvwek3VOlOpq1iIRG1NygG4Ae7Oq+qE2axHwBxrpRwyIhWDGCc
 wdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791820097; x=1792424897;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PgS786/bgLmo832rBrM/TEoTEL6xw03i4l85HaVU0vs=;
 b=fz3v/tfLI23NGei2o/EaR14h27XrkcKqngcGzW1K0jX3B1M2YBDhMCa1+nypZknGhA
 9+5qo+iBsCSTcOpAT8A9GVZ2HpRbGNCLNLI0X59Ctd+fEK3QlV1gS72PeqZcCt6B8Bfn
 JHNt74aZMaXIyQGty0vHlzY3QQm41mPEEH4IWQRQCfDKHyorxMqS1XKw5ltonXkf3e3J
 CkaWss75wKFOTrkPSnOSwHNDgtLsbXRB4a84JDt0NsV/mUx6wLfIBs/uEg6k8rKdGZ1A
 0A3WAn8549WPQTvKdSSfdi72WM+YgelWlQbY1k2i/lBb8khiCCpAKRBu2nkg6tdpe43n
 3Nrw==
X-Forwarded-Encrypted: i=1;
 AKwUvByDS0PU81IHC0Vi2Z1/zkjcOcmQp5v8ApP8StVUSrtPo9yIgw6NBIayy1uPGNU1+5TRuoyE/DU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJniujNVPClO4jN9OlULYPsiNU0F0aKR+ND3VbOdrGHjGvUZ/Do
 4CI8GdL4JEJFh7oaLIQEWWSqmSwxPcnX5hCqetkB1tTj9/bvJP9dno5WBhs6u5Ovpmo=
X-Gm-Gg: AYBFou0cHGPWorzODNH/cfvkvd5BP4O1qsCf27G7SN+1VI79pyscMFLMnNPMBEG96gw
 7h05u/VT9if261f+/ZIsRTQoC8HEEmoKkDmyFzgWWm4U7tp/GE4dp7q72dmT9ecyVQ/v5CzC4j0
 zp2WcZKRKGy8COMP0RhFRtHsFBFlKLhAFyNzbB0ObN+FwMgxeJuNH+dC3n8NClB7qQokkXEr0Tm
 0zllc/tdGVJ9oh5L0c68nxZPy18Zk1PrtDrA49jOWTvhyo5jI14CBt+McHvSsJn3KWt3eVtvoDW
 ViGHluL7HTSQmQsA8opOsJdrb3Yt2xGdk4XhQFlb3kkSTC8n6m1I9gP4O2nmtIf3dESM4MAjrmt
 P7tSejOAlX+HxtDxkJXVW/C9D1vL+jhQ6GtzCjxGXw+88cT/KCb7QJhCGk9zv63zhwl+dG4nxM0
 jTkv9uFElfFbpW2NqbJeJlZyiHua7ige8P9dN4Jat1iomj2oQpv4CGVLjeeyTlYZhSe6eSGxak/
 oW+LY0gsJBM62+f8D1UOgyhO4l+A4PZyPlC1g2pe7VVuRY+pkE=
X-Received: by 2002:a05:6000:4594:b0:48d:debc:dc12 with SMTP id
 ffacd0b85a97d-48ddebcdc57mr2001702f8f.23.1791820096421; 
 Mon, 12 Oct 2026 08:48:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:417e:f4c4:5b8:8c48?
 ([2a01:e0a:106d:1080:417e:f4c4:5b8:8c48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc5e0asm115443f8f.50.2026.10.12.08.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:48:16 -0700 (PDT)
Message-ID: <36787fa7-d029-4ecf-9f2c-0432a2a45bde@linaro.org>
Date: Mon, 12 Oct 2026 17:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PULL] Please pull u-boot-interconnect-next-20261012
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

Please pull this into next to support Qualcomm SC7280 & QCS8300 interconnect drivers.

Thanks,
Neil

The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:

   Azure: Switch u-boot-test-hooks to git.u-boot-project.org (2026-10-07 19:35:44 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-interconnect.git tags/u-boot-interconnect-next-20261012

for you to fetch changes up to 9db5fb79c2630e9b4fcb0d17dd8b5f383c783cfb:

   interconnect: qcom: Add QCS8300 interconnect driver (2026-10-08 11:12:04 +0200)

----------------------------------------------------------------
- Qualcomm SC7280 & QCS8300 drivers

----------------------------------------------------------------
Balaji Selvanathan (1):
       interconnect: qcom: add SC7280 interconnect driver

Balaji Selvanathan via U-Boot (1):
       interconnect: qcom: Add QCS8300 interconnect driver

  configs/qcom_defconfig              |    1 +
  drivers/interconnect/qcom/Kconfig   |   12 +
  drivers/interconnect/qcom/Makefile  |    2 +
  drivers/interconnect/qcom/qcs8300.c |  269 +++++
  drivers/interconnect/qcom/qcs8300.h |   24 +
  drivers/interconnect/qcom/sc7280.c  | 1903 +++++++++++++++++++++++++++++++++++
  drivers/interconnect/qcom/sc7280.h  |  154 +++
  7 files changed, 2365 insertions(+)
  create mode 100644 drivers/interconnect/qcom/qcs8300.c
  create mode 100644 drivers/interconnect/qcom/qcs8300.h
  create mode 100644 drivers/interconnect/qcom/sc7280.c
  create mode 100644 drivers/interconnect/qcom/sc7280.h
