Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36778C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE7DB60B0D;
	Thu, 10 Sep 2026 12:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIZEzB2mdFuS; Thu, 10 Sep 2026 12:49:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 14D0160874
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044582;
	b=aLvWTHr43fxcdTYK01Ir5AzOfcdOA5BpzTp1Hwzbbz+rN+6hbc8rTDfp5xzuG4lsixQQ
	 CSg4hza3bNdEExIBLimmuYse/l7F9R9W2JrXTE88T6LtdjI3nJa1RFQyVN1XZdY0j337D
	 mdFh7obS1CCuU8JtZi5tHWHtRYZKBxIEhNi9EdL4jq5bp/JFpHKSDVb1NvHD98gTHCIhB
	 ZoPDkbnPtByE+H0i2PTHKyYETphk+96Eiv4gWKoLjuzNL8ojAUbAop4LiBlD2HAahBEPu
	 AM3Q8482iuf0YAPwclq2TCMsTXmr7h2smkCatYHB89nkia1H6oElsSlxLqBZVm/+wsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044582;
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
	bh=RUs4QoVc9E8lqYZvg0YWNSCrRx6onHwhQdh776aFZU4=;
	b=C066LL/LaZnV6EC1PCMD9Tx7INp9HykUvUBhuBSICawivPohm982i+QmKmbWnFfpzjL8
	 yD/HcO38fG5R+cpCN51QOdGPw6DrOt4PtDWq2cNzv+N1zfUCw11cLA0/bt5wIKc7T04qj
	 0SSjpq0XD8lTaej44vCO2f4kFO07LwJ1SecbD3wZNumgJBKhVvMBDii5jzvZAPnCGvEpC
	 UtvVK36tfeFx86IDuounpBBFdBRpwuzWq1p7IqXXWQsbTpppvIsjGcbNSZdbXShLPW7WC
	 6ZXhIaqihlVknV/ubOLTSqxvSgeskhFfQ8t0Zr+8tTd5Vhm8Zbn6/wlZIN0N7UFaI3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GizXyR7H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044582;
	bh=RUs4QoVc9E8lqYZvg0YWNSCrRx6onHwhQdh776aFZU4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qZ1mqVyk9GKLBnSm0btB5pHhWJID73t5h4WNcMmFkbKXc4fMM3CewetDsrdt3X8Bg
	 5jLsJGPBqNS4WGyceQeCk9JmAT1BUnOKqzkRG0Aa7fr4QYXr8XdTiHLmCOs7cLrfst
	 q+oongvhIcPURlauZOEaOLZQQtfey/36UGcRafVlK58j5CZfNPedUe4BIqTvkERxyT
	 UzIlmdbS1ZuRBerjT+3f57F3ZdhzL9K2dWTXprFazsGDkLZ22rncl+1SPUWRb7bEBY
	 Y2w1rENZ4PGWTn3qyrMN9wZ2rosTXsYxDHyHAfYz8R0JGRjw0RF6tzU66chBWeX5GT
	 VwECNbJDdZWCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14D0160874;
	Thu, 10 Sep 2026 12:49:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34911E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2632160874
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a85FmxxQAG_E for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C94C960608
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044580;
 b=R0kSysC02YAbkg/djY2V83lq460+w9Ng2evo+QOg39kEBpZZK6Gae3HBXXBvMzppzqoA
 9kIF5uNVc2u7rD2YjT49ETZDfKUztPDYMMeeEBhmYxMvbZ5nc+UUhnLPqIdqZcfqDJ+E+
 +UIqNOV6BgpR8hv9+RuG/YLvAtyUoiFc/1Il7a5oUEsNFrt6jn4+StXSnNVsBoyEMI2E5
 Kd0oqWBZc+i3aB97ICSLRFq/fyEGJd7IEU4t5EOm6EGIYxiB2XNhi/iIVl74UFLY5LS/o
 J8mi7nClsk9mZCudSibdojoYYs8Q1Gw/xdhWWIbnqquiw5oU1J9kLsTeBtG49CAa+WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044580;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=RUs4QoVc9E8lqYZvg0YWNSCrRx6onHwhQdh776aFZU4=;
 b=PLlXAcOQ20VvIenVPWsHScc8/ZnAzp0fawNXzx71wjhcKp+PjCXlTGgSJ7z++m5CryXM
 swYUxsRXTRfJ3btK6rHSEu1d05dzUEpuUSYAlPW8Tp2AnGFj1U1kOfQYIXxI0cOpjmR6a
 ibQDTRWJGeeDQljhmK86ggnildsFqk2aUaNhgkm1w/NYe9teKD2QanZFbFN+Pv2qlPPEz
 SEaTFIrUS9RQbVZhXO+zlaVw1wvAZ3Eqzp6c/Afzvv7VwJ/ecXp6wDeQ0GZwpaW2KgpVy
 OmUL70VuQyPDiDIlM/QM2L6ERR+RRhLwcx48bP8zfRGgoX0YGJoAAcIATVLn6xC8Q8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GizXyR7H; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GizXyR7H
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C94C960608
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:49:38 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso5063300f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044577; x=1789649377;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RUs4QoVc9E8lqYZvg0YWNSCrRx6onHwhQdh776aFZU4=;
 b=GizXyR7HE+rx/vxLyLPFYLWtX9BPRGONYE3pUyTrY+DlU9O0S35Cywo0blD3NBrdzd
 +5KGwTqkg6N5d3qXaZNeEBTfpJNzookNNXJOXEq2hvwE7yf0nInsY1Zh6H09UJQ1yTm/
 QTC9CbtNMewycNYj0JUQ0YPvHeP9Q6EU/SZKHKdtyQiLG+bSUmln0rYv7LxCtqtlALxq
 wTzhVbwQEjXRI6CPzqMG2bQSSegfpztiSmhWaIqKPwm3nV0ZSXn6Ozv66IC3Z2+FY3YS
 AJdP9memNofSSX4uQWb+MFdls/pGTYl+CvGAYG3cbp58b1rYAZ/SpPYj8uy/mwGDdJEI
 AGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044577; x=1789649377;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RUs4QoVc9E8lqYZvg0YWNSCrRx6onHwhQdh776aFZU4=;
 b=Yp2kdVPzZPqoGEtkQvn6RQBtghGjWLJLYAtJdnA3dYCRiooLraYC1EeF91kq6T/k5c
 Yt+sPLIhmL+WgX3M/UFts6pUAjVF5C1SVbMwb3cpAhMnG30yhratTkLkWEG1/19SbKQG
 FI5PHMxJWZ5jhFexUmZzLNBEzGOjTqHCQ+LqTY97wTLKjnidCTZEaAend9gMp7k1yocu
 jaUuevJc1dnp7AkzoO8G4YDqdlkDqVQGFf8VWlPRvS8aJppVLEDQO+Lq2BZPsR0CEepK
 LRxa06jXQkQn1W+DTSYfrIizWSVPoc1+NOi0RBCyvI9liToE3x+cbdDPC9wZtXlYqILY
 WOqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnOa3QZJEc+52/PDVTretnqNkphBJ9LqdKwHB5uTRS4J7F04qKEEsydU5iAZv/NoQnNqqzjLg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kGIo4a+EmhVxqFxe/l9zXCqJM6yjAbd0DLAzsISRmUoP/MiBad
 DLDmsiLNR7CGkIYpKY6S19m24TbJJ/fqYx8A1ugftEC+RmNMz7L52sDZUlk9ydeGTZE=
X-Gm-Gg: AYBFou161LxlINtA8mfGnnXWlG5jnWZxxjoFA7M69eZqnFy3pSRk0FU713lz+ZRzqhK
 pCTGuf/iNwDW8/+/OmsUBXZEHpnZyV7LzfI81nYfdruhmPqRqMcnNlgVQkYSdcdh6usH7vhkoE+
 Gs2P03VYDiz4VJ6lQZ5vF+XmFYzxBe3c4J6rxkN8oy6TFtNkyjwp4DskLzI3atTzWJpGUIBnKBh
 QFiqXkrk5WDt0AL2bxOZ4DqjUhogblJw/VJSbnWXHQtZqS7Uf+c4Vi1tNTzeEUdFb7xK4EY5kqj
 y1/EzBO9a0mN9biIG6ZpAfYHpc1RWv8SmBE0c9RQhjv5eWbCIhvhiwNEKFKuzleYmIA7BRaANka
 ou8LMnGGRabHyC8/HBDljT84Ao3ovTD4/M/xKvIqZAFOA4XO8z4QPdrpVjlIlQvrqosJbjQI22f
 G3DigGXbXWSGPhUV8U6L62yZbTMNsFaQGWksYC/qFBLaD1ZJfxXQDSeQkazdZl3xsna+YHjXGzm
 13EXFyyw6OSLOL+qRWDnIH6bXLV90eSYec8ekYru3P9D6i+RCxK+Q==
X-Received: by 2002:adf:e185:0:b0:485:ac0e:9cc5 with SMTP id
 ffacd0b85a97d-485ac0e9ccdmr11227764f8f.9.1789044576680; 
 Thu, 10 Sep 2026 05:49:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm56094951f8f.25.2026.09.10.05.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:49:36 -0700 (PDT)
Message-ID: <637b29ad-dc23-403c-8b2a-d7e032cb02b0@linaro.org>
Date: Thu, 10 Sep 2026 14:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] pci: pcie-rcar-gen4: Switch to devm_*() GPIO and reset
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
 <20260809013431.444164-3-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260809013431.444164-3-marek.vasut+renesas@mailbox.org>
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

On 8/9/26 03:32, Marek Vasut via U-Boot wrote:
> Use device managed GPIO and reset get to automatically free
> those resources up. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/pci/pci-rcar-gen4.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
> index 044bceee6c7..b1d43b2e7aa 100644
> --- a/drivers/pci/pci-rcar-gen4.c
> +++ b/drivers/pci/pci-rcar-gen4.c
> @@ -99,10 +99,10 @@
>   struct rcar_gen4_pcie {
>   	/* Must be first member of the struct */
>   	struct			pcie_dw dw;
> -	struct reset_ctl	pwr_rst;
> +	struct reset_ctl	*pwr_rst;
>   	struct clk		*core_clk;
>   	struct clk		*ref_clk;
> -	struct gpio_desc	pe_rst;
> +	struct gpio_desc	*pe_rst;
>   	void			*app_base;
>   	void			*dbi2_base;
>   	void			*phy_base;
> @@ -313,7 +313,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>   	if (ret)
>   		return ret;
>   
> -	ret = reset_assert(&rcar->pwr_rst);
> +	ret = reset_assert(rcar->pwr_rst);
>   	if (ret)
>   		goto err_unprepare;
>   
> @@ -323,11 +323,11 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>   		     DEVICE_TYPE_RC |
>   		     ((rcar->num_lanes < 4) ? BIFUR_MOD_SET_ON : 0));
>   
> -	ret = reset_deassert(&rcar->pwr_rst);
> +	ret = reset_deassert(rcar->pwr_rst);
>   	if (ret)
>   		goto err_unprepare;
>   
> -	reset_status(&rcar->pwr_rst);
> +	reset_status(rcar->pwr_rst);
>   	mdelay(1);
>   
>   	rcar_gen4_pcie_additional_common_init(rcar);
> @@ -346,7 +346,7 @@ static int rcar_gen4_pcie_host_init(struct udevice *dev)
>   	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
>   	int ret;
>   
> -	dm_gpio_set_value(&rcar->pe_rst, 1);
> +	dm_gpio_set_value(rcar->pe_rst, 1);
>   
>   	ret = rcar_gen4_pcie_common_init(rcar);
>   	if (ret)
> @@ -366,7 +366,7 @@ static int rcar_gen4_pcie_host_init(struct udevice *dev)
>   
>   	mdelay(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
>   
> -	dm_gpio_set_value(&rcar->pe_rst, 0);
> +	dm_gpio_set_value(rcar->pe_rst, 0);
>   
>   	return 0;
>   }
> @@ -428,9 +428,9 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
>   	rcar->dw.first_busno = dev_seq(dev);
>   	rcar->dw.dev = dev;
>   
> -	ret = reset_get_by_name(dev, "pwr", &rcar->pwr_rst);
> -	if (ret)
> -		return ret;
> +	rcar->pwr_rst = devm_reset_control_get(dev, "pwr");
> +	if (IS_ERR(rcar->pwr_rst))
> +		return PTR_ERR(rcar->pwr_rst);
>   
>   	rcar->core_clk = devm_clk_get(dev, "core");
>   	if (IS_ERR(rcar->core_clk))
> @@ -444,10 +444,10 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
>   	if (ret && ret != -ENOSYS)
>   		return ret;
>   
> -	ret = gpio_request_by_name(dev, "reset-gpios", 0, &rcar->pe_rst,
> -				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> -	if (ret)
> -		return ret;
> +	rcar->pe_rst = devm_gpiod_get(dev, "reset",
> +				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +	if (IS_ERR(rcar->pe_rst))
> +		return PTR_ERR(rcar->pe_rst);
>   
>   	ret = rcar_gen4_pcie_host_init(dev);
>   	if (ret)
> @@ -469,8 +469,8 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
>   	if (!rcar_gen4_pcie_link_up(rcar)) {
>   		printf("PCIE-%d: Link down\n", dev_seq(dev));
>   		rcar_gen4_pcie_ltssm_control(rcar, false);
> -		dm_gpio_set_value(&rcar->pe_rst, 1);
> -		reset_assert(&rcar->pwr_rst);
> +		dm_gpio_set_value(rcar->pe_rst, 1);
> +		reset_assert(rcar->pwr_rst);
>   		clk_disable_unprepare(rcar->ref_clk);
>   		return -ENODEV;
>   	}
> @@ -501,8 +501,8 @@ static int rcar_gen4_pcie_remove(struct udevice *dev)
>   	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
>   
>   	rcar_gen4_pcie_ltssm_control(rcar, false);
> -	dm_gpio_set_value(&rcar->pe_rst, 1);
> -	reset_assert(&rcar->pwr_rst);
> +	dm_gpio_set_value(rcar->pe_rst, 1);
> +	reset_assert(rcar->pwr_rst);
>   	clk_disable_unprepare(rcar->ref_clk);
>   
>   	return 0;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
