Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A300CC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 749B740A8B;
	Thu, 10 Sep 2026 12:52:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CIpcigU9Q6nm; Thu, 10 Sep 2026 12:52:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C508C40A9A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044761;
	b=gdbRS57HtBRy1naG7JeD2wU8CaLMcReA/HIl9cVRMP9NWdrrT0ezhDNx62S1O1megWZ3
	 V+ttBcwCSmN3+mi02eBrnRYavxtnUMR0YiyM7k8bBbc0qn2Q4qDlxnL2ImJdphE98Y2/z
	 CVx3uTkD+LNhl3sLzdMh7Zp8C3Hix8TwI6o2SQmjaUGbcX3mhNOlHDtH03GD92aas2SXO
	 PMrisKkFtNinTNnVSWvfVqf2UFxPQEZ0ejpvN7Pw5zvRkjylhDs8aGvN+KMj0hZ1nJyOG
	 rT9Ps2qmlnqnR2EKpN7v7HoPrQnXRMD61/2hOLflwOmzxOj7ivkJehIzc81pOmUX56Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044761;
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
	bh=8m4gYnk63aCOwNOZLBD2vL8hVDHYQGKUYlMREekWU/k=;
	b=aRKGBMA+m/HGVrKHPwxBAKE+ZDrST0wb5vBU9LomK+FKLl1viSOJ2hZffid4NJMB3vAQ
	 GoatZmk6bik7S+Hfce2grP+Udu2KqrZ8gLwaN5mKtfGHzYyQKX+TXjR1TNTkr/N2NliO+
	 sAZIyRxgowdmhW5FGrUSoFE1/XEX4sKuYemkUVzGvoKzB9GVi1PhSj0/tNho2Pa/Wodvn
	 5TJbVNsO5eFjJuYy9l44dO/ECPnA0mbmti4Nndtl3vbOt6h3EWg9MFtUFr5BKul45t9Jo
	 FgPQ+9p0nhsN5yhhYE2Ch1ZLCBQ2nFhf0G92ZzV8ACSgI6pJhr5AVb77YdpJaAti6Ng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YJMwbAtz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044761;
	bh=8m4gYnk63aCOwNOZLBD2vL8hVDHYQGKUYlMREekWU/k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mUeWKMF5Xy4iL1Iwb75OjFmP6dTHW377e+mWa5LRQJS2UZM+ZXpAaqgs/Xuwn2uCb
	 Uc6s2hcnEl3Do2gGTd4T69Z/j/ZR5hfknZt2pl8AGSa1QQ3PI176yOQXI0quGR+JZo
	 muvB6hOodD7vLMTx2h3lDujatKRINve5BrrbCIa8ZN2S3DLmRv2AAnpSq2X1pFjsPR
	 zpomkTby5WeX9+VljIsIiXJQfB0CRV0ZojNyvLjYPPQuWpLuxkSKejV+o9K+KDD1kT
	 89zpfgFqxaRrvXgnYl4KCP+R+ETW0uClOlSA441GULjylxpiR4+9CWGvWtbckBY1x4
	 PYYtj9Y6ph/ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C508C40A9A;
	Thu, 10 Sep 2026 12:52:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3713B49D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D31840A9A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDQjc3vDD7k5 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 294A840A8B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044759;
 b=JNVrGkiDFcydW2qABWwvAdWYJR9udbAP3/OcYnvdiFHHoFpFl/47CF4CMDdXpf96Hz5F
 y++GJWqkS20htTkifdM/QwCdnZqHG84Km68sYMK4nXCTllnyCGSei/w21IJW9melkkApP
 Ce3ePNJi+c57n5A5/RvevOTgVAy3mdgngDmdkbyzFBLzrKIVkXt61EsWikCem1Ngn9/6E
 HfkzchXu5ilxGVX3cgM6k5si6BZHWYZ7EN3uQK7tsT5cX1WPS8HTdO05PS9llrMkrNwil
 kmv5AxPH1hg9nIl/N8g+C0fK9HxojnhbWno0cQC2yJGLYvQW1lrAgBJBwOJqX5nYG1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=8m4gYnk63aCOwNOZLBD2vL8hVDHYQGKUYlMREekWU/k=;
 b=lBfiSMXCVFRn0Ylo3BPuKmD6oCT38NUDKNgUndm9Xdg3/Bxjm+oBeyS/4uF3BuXHcUDe
 60VDHaOifwhp0USfHPpw/xuwAJkMplNqY8JWKblpqSKJ0+ObUNVGY1epd/oWNPFTbLZD6
 FDvwTVjf2LZ894vXG4zjW7XASK4z03Ux3BQYmaHhq7HPdNzggGIHTFZXNfBx4EhGC3NyI
 FWGhqnA8KKaQCFtFfoEde8YIiTzLSp3PFWjjoFd2QPDBuGA7c4qAjGbq0U0+OOAPBFWSi
 gS4/IO8aj462y6zuzO8+NdISf6hSNn/MbZgbJyDoZCBd7FrHv+JwaZU/4ZkvpJUNGJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YJMwbAtz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YJMwbAtz
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 294A840A8B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:52:38 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so31022065e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044756; x=1789649556;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8m4gYnk63aCOwNOZLBD2vL8hVDHYQGKUYlMREekWU/k=;
 b=YJMwbAtze63CmJXXQXaqI/+6XxBDApbPDDGh6l2Ile/J4XrOW7wTe3ziQ16x56Ol46
 0VPTKLQEgDWyRT70es0iLI1DG5wBSuKKUIBGVYYhNSjNOUjIl1Ly0P/2mfYKKWYk/QnW
 e+XMhxRzUFHcEfNYlVp0Sklb8bOwpz39fNvGxDtwjp5UMng4X4pEqReaddZPijZgF7l0
 FVZKSPqz/GMcM1JeXMQRTT75yRuehEogLrskmbQXw0VrEDWsLstPHY9oWYPiSz1p6XS4
 QCLE/QCa2deD/NU7qk+DD/2Bgwq2ptvDnTeG2lVTiXEyNdNDHa5ZsTGInJzZZILGRjBx
 2KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044756; x=1789649556;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8m4gYnk63aCOwNOZLBD2vL8hVDHYQGKUYlMREekWU/k=;
 b=g6vHHVBkot4vua5tUbo2EDA2xV4czv+xfBq71OQRdqUOl+atDKUY1DiIxydRSF9r/u
 rA08YLOgqzSgmq2gCI954b8qFnYdv36s7jWDHPkcyCgHq3v+5tuRTp1ghnSkroqrGbJr
 d1sp+FoBBiBo1+FG2LUiZBKSXvpDShuJr4yDmmuJg4IuH1APd7GvzI16XqbcRFnNThIw
 Vf5LVkqcyfsd/6ruOxSuBu5wWMq3TAwBg9QjSYxEQSqHAnZdoZAbWVNEL/YwAaFPagBy
 iNO3iwSCrExk15hOJ1hu88uDU1fqFeyicbuo3jPL9zsINARwnB57Jk/Uo2B/heuqRs4P
 hgcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFO4l/1IDDf6aAoOfyIcWQZKvPtwp9A3zIzxqaZVVlc7ZCRhDmqTGvUBgJvGX69Uj8XH0El0w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lpv6btElMdxJbkcYbf0vP39xChVRg4sa6vEpeWOIAursLSJaCq
 Sq1d4HgWKKRC75i6hNExH9fd4cKeyQYEHKCAGDN/JxEQZgZFpxUG2typPWLLUMKvlOc=
X-Gm-Gg: AYBFou21hrvTCFMLkjbX/u8lNkT8f6YzwMtAxEdxWf6edOYefONSfoYgTMkT7KT2oYO
 cBZdQr2/C+P0Gkq4OTRKvBfa3dhQEWb0ISOEywb6o47MHaWB6u4U4zMXrRfGmu5vVQc67pSrvsw
 dsnWdtC8C2dyKV0jlJvjwR/6n96M0ltmQysU7ZC5eOtMQ+1v/sWv0mYzQb+bk+LkBVXVgQPNG+E
 tOnGPnly3JxgEjzSbU8MM1HK8mUL75Sc6btPKU7GtyUXpi9EATnRM2/DgAjhs/maQFjoIRGrhrN
 ehHBRM+LM2K2WZbirZSpr5p1sA9scE+MR9cGjxQ2O0jp9hchzMu/WnEJmXIapZjpWAgPqytP3Ek
 ESaGzLuNrY6ZHYDbyGU0k0bWBbeMxGIC3CwO8tWeYItFLzIRIeKuB6Rev3awL8UvuiNHQCM8X+f
 hnrLnfnbBbtZnMkwnc/OrQCv3EZs3oza5J4jPZBezYtM0FibEhnRixHcgScG2v+TuCnUBGQB6t9
 HYu8AA9onLC/X3GtERNcdu+SO7NKdqMIhhgNR7Qii3+CvW8khEmpNq6NKPkHJlW
X-Received: by 2002:a05:600c:34ca:b0:49c:ee36:10fc with SMTP id
 5b1f17b1804b1-49cf820e13bmr393684265e9.8.1789044756418; 
 Thu, 10 Sep 2026 05:52:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm45524687f8f.9.2026.09.10.05.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:52:29 -0700 (PDT)
Message-ID: <b851170d-7541-4e0b-b98a-a92803f6bc98@linaro.org>
Date: Thu, 10 Sep 2026 14:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: Iterate over busses using uclass_foreach_dev_probe
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
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

On 8/9/26 03:31, Marek Vasut wrote:
> Iterate over busses using uclass_foreach_dev_probe() instead of ad-hoc
> loop. The uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0 in
> the ad-hoc loop would break on first controller that does not link up
> in its .probe() function, which is undesired, as it prevents listing
> of PCIe devices on other controllers. Using uclass_get_device_by_seq()
> mitigates that problem, and, at the same time, simplifies the code.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>   cmd/pci.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/cmd/pci.c b/cmd/pci.c
> index 3c0aed50cae..d2a10aec41a 100644
> --- a/cmd/pci.c
> +++ b/cmd/pci.c
> @@ -550,14 +550,10 @@ static int do_pci(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   		}
>   		if (busnum == -1) {
>   			if (cmd != 'r') {
> -				for (busnum = 0;
> -				     uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0;
> -				     busnum++)
> +				uclass_foreach_dev_probe(UCLASS_PCI, bus)
>   					pciinfo(bus, value, true);
>   			} else {
> -				for (busnum = 0;
> -				     uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0;
> -				     busnum++) {
> +				uclass_foreach_dev_probe(UCLASS_PCI, bus) {
>   					/* Regions are controller specific so skip non-root buses */
>   					if (device_is_on_pci_bus(bus))
>   						continue;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
