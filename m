Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2239C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 13:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2108D60B01;
	Thu, 10 Sep 2026 13:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoP2ED4KtNxW; Thu, 10 Sep 2026 13:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2618460869
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789045764;
	b=Q+/TYxEDnlHmNtwBnD72gmLqRfeGV9MXWW3N/4hqTLSgNtRDpkaYLdSTLVCLvF7jhzcZ
	 LDwZT0RaBTn8I0hSG5RnZ4Qrhhotyi0oTa4p6aWxQaSmcWG7xvFTaX1vlCsKMNXIgYuui
	 3ZKE6vRNHNo7KWfIdGc/HVVz8aDA3drX9UHGMnaJnizPrP7hp+o9FM/X1jG+PN9RhpsRx
	 7c73YmC4toY4JdHHE5iye/bsNb0JDcAOEI6nk7yWmz7nT/WJnJnsdudyZWhf8+R6x3CHu
	 VYPz4beR+DvOt8YtchOOVbEmlLKPQbLORUriqJIeYdGaAxUYfh8Y0GspMFB82VU1qOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789045764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=UKPsNfm2pCGUrOTsuEI5APGBdFsRc+K2O8rS/bJhRaM=;
	b=VrJF2s1m+aoN6ECqI0WTSrzyiYlVI1WwjH5vfTNszrsLMDWhpBd6mYg7cuZwdi+o3QUn
	 rRu6DChkZ4MZTED8/wSiReVRH1JKIcOkX7vGriIc/Vwi03dEZ3BFEgHIeFwBdYD7Dd1C6
	 iHCqCP0VNpGyVeQdtqhpn68S+a6wXpipIBAjy0DddykVkLzZON2hSCCGIbIeMgZveiBDq
	 SG9D8FET6k4VJx+FuHkf1ZoXVOh2bkwiH3s5ngI1HMl6a/I9HEqKaG6TA69nVSpIj1pst
	 bT/9Ho4vNETUvE/i3gYCkH+510qt4eM1S5DCzS/x+0PmKIMvj+9ofMXh/0bMmWRbTgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789045764;
	bh=UKPsNfm2pCGUrOTsuEI5APGBdFsRc+K2O8rS/bJhRaM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=L7CGMoCL+neYHJea49EL5xRxQaHtsJ6LorWHLiEWou/GdGKH6CAOquSUfo6Sbcu6e
	 7kUCUC92xTo9gSNDGzkX6AiJj4MmBFcuj4pqLe1UBz/YFg338F5LHJc+4xt+GaylxJ
	 4TYpfvnImtznmw3V8Jl4jYAt76+aBeWXP7WljcPW3gukHDA3lNTMXtHOHByml7GU5Y
	 J1s0mCiIuayv4An/8hoUn4GYqWA9JSfn/Eol1avYIC3s7y1aFlWjBuF+hcKgi91IuO
	 hV4JLi0kfYFNu2KFvSrHcWA19a3WW3b4674BA9AFmDvqSGDOTOEW3K5m65JHBBZrTn
	 ziiuixEoWJCDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2618460869;
	Thu, 10 Sep 2026 13:09:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2544362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0E8580FC1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:09:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tr6EuKzAKGlf for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 13:09:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A936680F81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789045761;
 b=n4xfttXSWWuMip7NNZcf7k33GDe6ykcRms+yIiaNssh8lDbUs7U0ru4xao5h/iCo7+0y
 /57ZEvs2g51eQw1Vn7SzoWOQZhYStCwJUHc+FpIgNWjudVX5Rs4GslqzaaGEXsU5K0VRC
 JiftjXaUwdMrpr2srsy7jaHCLyg4TVxwkklhbqJsVe3vHuX1ua+DDPGWyaNPO8VyDTOSt
 OFrpjVkI5xTbE5UjHzyEFV+M9rZxGTxuw3TlwKlBfA2z5qbK65erhrttOmleaKQT6pGHc
 G3FO79EK2vyxAT3lnMz77Vqr7bLggb/FqKFfiXjcmjmRM9ThRznrYBIkAP8FiG2loQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789045761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=UKPsNfm2pCGUrOTsuEI5APGBdFsRc+K2O8rS/bJhRaM=;
 b=NNfL58CVxFzFEBEUWNmS/29ew6Ta2G8M3JfJ67M42v4D4KgkKJoImZjDxmYcmq5qmCIX
 lRBkBSJxqMvAeNGlpipCbV7vi5KEPHIjMv83xeWjq/iKdvqjtn/+Zck3j552Ig28XhITF
 80/GlT6n225jCLp9gxVGudxzjMmb5ebUiZUtNS5fI3WfT3xYtG4TYEmDaeRaSpXRjnGvb
 7ffRfs4IW3u9ldmEPrR6bcYa6UsqUkD4n+3opCKgNxqOZxnXQdjTzurK+az1iXPVTynlt
 PlMh/9QH4rONfxYuJNROTQ5ZvOLn2IboZPYIJUMxlr+OGYMZVFPTDfiqt0tNMejuEBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JWFYLdcg; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JWFYLdcg
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A936680F81
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:09:19 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so12331075e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789045757; x=1789650557;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKPsNfm2pCGUrOTsuEI5APGBdFsRc+K2O8rS/bJhRaM=;
 b=JWFYLdcgvJMl4p5Be4yFfImDXxhqijNOB1sFWV+oqn6cJ2y4qqQpEKePFJ3mb1q5kq
 EkKp6xwLhzBDFKlUtFBpTohgJNlR2AFoF7IDXF9FhBDjDi6Nxpx+czG2M45bu/NpPVdK
 27riWHhgB5aXRgzNS00cOzCdT1hqNqjqbpQP3AfRbbp7MXi76Gg/ln39ok0tgRyYeOYg
 0Rd3cgC9svDIqANG8XHm+yxRfpo3ZMt3K2whsvYxJGuYaxIfKEqexmk8TQKOR+0+N4U6
 9C/Tk+XUQKtr1XZW6P1iA92pGH5BS9lvoQGGTzoR1vFHixz7RL41o8+HSQABLOx3Xt5K
 +Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789045757; x=1789650557;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UKPsNfm2pCGUrOTsuEI5APGBdFsRc+K2O8rS/bJhRaM=;
 b=mCn7rDRDTuf0AO5Ucy+D1cJ1Mnzb4fN6LI52QvBq0+L+Bp1aX4Tx9Awh8Ky9uK2XPy
 XQYxiaFo3Lf3El/XNzYXXFSpMDN9ntvpLgEREQyCwg6FMk4skJqCx+CSgHCqx9xQaUgQ
 /n3w8h0HYT54Kj21rh12Mw5inSThXLd5XaMfkh7OxKNdP57vTu0wjLEjvpCjZooKsJV2
 tBNaXnZwlUWeVq6gZ3iUjomEbSNca1ZP4jQbkfBek85ajhKiOZ/qSBxAqlV9/+eVUA3s
 Tu8v+XzvPVQQhOQz5kTDx9fPgTWwtGdoQYSS7cDFm0JpsV2c0bDKh6gxnHyKQfR1591o
 Hg4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9Ddk1QNG/IVsWY0l3y+s9Ian9SwqBvVn9okQa5msUmYRW7g7tp9B5DVMX8WAtnHDOt2NVlBk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhlxPs6WHnPu4NGiZaXcdwaPY/AnzGebf+okxjXYI8bDNcSNUD
 eFHCg9acyvUqFNkCjlZ0iFFeHonZ8NCBx9bSdSIG7IxaV7Vglih6YwVoWUOPFi6WeEM=
X-Gm-Gg: AYBFou107vg/YtLVF3o6eMby/Nbu7Pdl7Fs3iKdgJS7Hm7DhpVUniIFOoh1wUpObizL
 EowKNaiklX0izsZNj6fDwBJ4RvQcH+iy9THGeSHQYk9lLQ6ZS7NrzHqeWZvbtAk0sHBeHv4cxAF
 9NZX2dZKSD4XrjHFhHVK+OTQURjgCDCWXkhpArY9CZH2XnTwc4s3+mDzfiXYxX/Rx/64QNeWfV5
 JU0+Ff0BIcsZKDUYmCdEfGGQI6CzZ1fHGB8FlzSpAyEqa9/hOWdyUm7KGRBw/f5hNIeBgq/GEFU
 sy8mKc5LTk+8oHcLWZQwLOu9Ls3THk3cLTg3tRsa7RjK+3HCmlNrHXG1O/pXfIspONA4p9STZ9+
 pd13RQ8eTrR/W77D8CiP2YazHdhz8VTOjCoz6sto0aEkDlvXw6AvBUZf/Z6+vBxDKhzol60O1HS
 /Rbdf8oRDRQ34dWn/j/FF9w6roVqJBJNuHvVKe4IXaLXGI7/C0l8TsRL2aco0bVF2GDwjj86awy
 qQS4Ovm/sldNlnuhgicuP8T90EBzvWng5MpQeiKEvIBgqSbzHtCE/8=
X-Received: by 2002:a05:600c:83cd:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-49d1f21ae99mr180609425e9.3.1789045756886; 
 Thu, 10 Sep 2026 06:09:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm43429876f8f.20.2026.09.10.06.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 06:09:16 -0700 (PDT)
Message-ID: <b9670245-7414-41bc-b2bc-ce477e879bdc@linaro.org>
Date: Thu, 10 Sep 2026 15:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: rcar-gen5: Switch from FASTAUTO mode to FAST mode
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260802222614.194571-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260802222614.194571-1-marek.vasut+renesas@mailbox.org>
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

On 8/3/26 00:25, Marek Vasut wrote:
> From: Tuyen Dang <tuyen.dang.xa@renesas.com>
> 
> Switch from FASTAUTO to FAST mode and lane 2 to achieve
> higher throughput. Drop the 64bit address quirk.
> 
> Signed-off-by: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>   drivers/ufs/ufs-renesas-rcar-gen5.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
> index a9473cd60b1..c6e436fe197 100644
> --- a/drivers/ufs/ufs-renesas-rcar-gen5.c
> +++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
> @@ -72,7 +72,7 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
>   	if (ret)
>   		return ret;
>   
> -	writew(0x0000, priv->phy_base + 0x20000);
> +	clrbits_le16(priv->phy_base + 0x20000, BIT(0));
>   
>   	ufshcd_writel(hba, BIT(0), REG_CONTROLLER_ENABLE);
>   
> @@ -88,6 +88,9 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
>   	if (ret)
>   		return ret;
>   
> +	ufshcd_rmwl(hba, 0xe000, 0, 0xc0);
> +	ufshcd_rmwl(hba, 0x5000, 0x5000, 0xc0);
> +
>   	/* Skip IE because we cannot handle interrupts here */
>   	ufs_dme_command(hba, 0x00000002, 0x81010000, 0x00000000, 0x00000005);
>   	ufs_dme_command(hba, 0x00000002, 0x81150000, 0x00000000, 0x00000001);
> @@ -133,6 +136,10 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
>   	if (ret)
>   		return ret;
>   
> +	clrbits_le16(priv->phy_base + 0x20000, BIT(0));
> +
> +	ufs_dme_command(hba, 0x00000002, 0xd0890000, 0x00000000, 0x00000001);
> +
>   	priv->initialized = true;
>   
>   	return 0;
> @@ -140,8 +147,7 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
>   
>   static int ufs_renesas_init(struct ufs_hba *hba)
>   {
> -	hba->quirks |= UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS | UFSHCD_QUIRK_HIBERN_FASTAUTO |
> -		       UFSHCD_QUIRK_BROKEN_LCC;
> +	hba->quirks |= UFSHCD_QUIRK_HIBERN_FASTAUTO | UFSHCD_QUIRK_BROKEN_LCC;
>   
>   	return 0;
>   }
> @@ -180,12 +186,12 @@ static int ufs_renesas_get_max_pwr_mode(struct ufs_hba *hba,
>   {
>   	max_pwr_info->info.gear_rx = UFS_HS_G5;
>   	max_pwr_info->info.gear_tx = UFS_HS_G5;
> -	max_pwr_info->info.pwr_tx = FASTAUTO_MODE;
> -	max_pwr_info->info.pwr_rx = FASTAUTO_MODE;
> -	max_pwr_info->info.hs_rate = PA_HS_MODE_A;
> +	max_pwr_info->info.pwr_tx = FAST_MODE;
> +	max_pwr_info->info.pwr_rx = FAST_MODE;
> +	max_pwr_info->info.hs_rate = PA_HS_MODE_B;
>   
> -	max_pwr_info->info.lane_rx = 1;
> -	max_pwr_info->info.lane_tx = 1;
> +	max_pwr_info->info.lane_rx = 2;
> +	max_pwr_info->info.lane_tx = 2;
>   
>   	dev_info(hba->dev, "Max HS Gear: %d\n", max_pwr_info->info.gear_rx);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
