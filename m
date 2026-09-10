Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15577C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CBD740A9A;
	Thu, 10 Sep 2026 12:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXaXP6-6Eld2; Thu, 10 Sep 2026 12:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 363E040A85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044492;
	b=Ulml3zI6MSYu5/2ywa1AjZt1n0DInTOKIyytOg0LTb2LFEWd2v5XUVAbQxuVMcqwA3sC
	 nWgNCXOTlqZBh2VWp2Rfr+RWN4aXb7LvChL+QRJvjTyXiOwh27PO5H+KM42WGhGYyAvnG
	 RAEwoqFPyedidQ6RYtwSLj2w154yC383AtQbCTihIEIr9xnGhbfB49XKnXhTk7RYk6WrW
	 /PvB052fhl0uPCxrNpu8cz+z8wNUWlkNoxwmU1Zx5sX5wb87nbvpsuqqUH/O1HpFE+T5s
	 C7PBMoqGAnl5mZvK6Gp0lKg3jRlBan3P4QH+wS5zKHJuH8w6ZcPPWZQI8uf1u45Musw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044492;
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
	bh=EDv69OAGzkqBQ7RSRp2WxCOhPHkMcQF8QxqhLpFfkxc=;
	b=a8XyP7LGKm0QR5pd7Yf1YdemsBeoQmR1cedjdsclSolB6GTwR1KBNZkQsx6BAivv/68l
	 OmKAkQ8Touth3aR94SNo92MhivyfkyLPM6iqO+6dDJUaAm1jUyF3JuIedo7cKAGJdH+4M
	 5mccM5L9zIAT1zWtAtzbplGG1ctq8HcSMjLqYeRDEQLHV1GcxVUQ11fXyarn2unRc0Euu
	 h4RSL9VSLGcZsdgtBECMWIMI6h+KykLboIrxxc0G+W0tEd45DF5CHQHj6zdJTtx588GiR
	 NifSEdoRRu0maAF/Mu5RxSrs0XGR0fmbttVQkITU7SDc+5TwbGeGIAF5KYTsYq7eBPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044492;
	bh=EDv69OAGzkqBQ7RSRp2WxCOhPHkMcQF8QxqhLpFfkxc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QdJ/uHzhWU4WwOtssZlZj6aDCzHuzkxQc6kLUaSCWlLiRc6Q7Q/7/TYnAh5Jl+TWO
	 N7KlPPTC1JqJbzOlCEO1XFbp75z8AC+UbJ3hXWn7m+MCus0DuUUJDEi+CW30L29A9Y
	 QZFhQNdEFYTEuIdRpRi7g+qvEvaVXnbbF8FPo1dk2ptuzl3JQS4KzVa9QFqaVXjgWr
	 ZTqKUxwQI6ELpBCGqy26YnQwI5QOxl9BY5XgEOPQ3X0KKRnhxECAdH6JYl4EkS/95a
	 BS8SkWM5JdZ/PPqutzVBwi0qL4t781DfyDEtywNdDE4sZlF3+6i+JiWDIRfBE91oJ8
	 TG9FGb2552dPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 363E040A85;
	Thu, 10 Sep 2026 12:48:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 983B9E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E524400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLOJ2k_YZ8mv for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4BE1140090
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044489;
 b=Et7Yu27VT9+jUyDlhQOMePQa0sZZjxtRMi9Khhpz7KIwi8Ap6b9sGoBCmE5CYZjDqqEq
 2EVxRd2lzC2TBbNpQ/84Slueyydgp4P/mezA1dmePkDfuQnorf+/GoPi60taAmvIubgbk
 7MYqH1GlxnPqsrTXlquP4YlVIrUCWTPhnw6M5MEKouU2i3fuwIBxZcFNjYGqcagaUS83I
 SOSJP6P+i1PZAHjVA9HNoQIlfdHRMmZSGybIXc74hw41u9wIMR2SmsGddVW8udvbQCinp
 qvbauD+CTFZmpu75yP3jyPf6SaajT1lFPyivmmMvYgHG5kGIZoJbDihTB8CxZEfVuaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044489;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=EDv69OAGzkqBQ7RSRp2WxCOhPHkMcQF8QxqhLpFfkxc=;
 b=XVLweCl9JEwEY/iQxy4bYxCp/Upe7FQOwRovBywLkvH5N9MiGyCg8EfGuSa+XGJoPeOR
 9gcGX39DRHthTAOC8bJQnegHhSrQrXLZSEw83TyukLhk8gbyktOpIzwnQYc4V5GTnXiWe
 f42nOukOOIYwWIbzNNmsWIHQtzPvzHhnWkvZVZQGx/Iq5dXvFxiM0Kb+GLrfB47PGuoiP
 pL5AQbIn9kQ/Efkyt6RuqFBHJ1NJvocyg031g2dR5po+zDcAPn7FoHp33D0l7ebGymreU
 YxpT+UhjjQslycOcNL/ivborXEw+BVNwBxvDjDbPGc9k79nhNZbGwzbMvy2FeRe5Vuw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IpmEA4Qm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IpmEA4Qm
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BE1140090
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:48:08 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-486e39e007bso275006f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044486; x=1789649286;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EDv69OAGzkqBQ7RSRp2WxCOhPHkMcQF8QxqhLpFfkxc=;
 b=IpmEA4QmfuN/0vPlRVhNPQfmDhfVTeJj9GgxFn7bhcJjRDMPTy9M7UrgoR8C3QeWaU
 3qhh8mjmy2SwMDP//ejh1Nn7aVBjuKEJKrusGyfWPrmeaVcM14D7D1kWjUHuU6uycfwC
 CyvBreHOX0MXPnVAnvCXq9bCFojA9MmaVrGsPQ6+gtRpRx9eTfhl9hW5EnZWuqtzSiG2
 k7Kd1Ucil5412ImCm84xfZTg+etpilz6bB2dIMy1TAz2zB7ywXmnInHvXSr9/Ki1QdVK
 m/vdNcB2oO2h4OoE+ddkzXCOxYx5877N7Fs9rv0+J1K15tYPXU97lOZhe3kexYNk0/jL
 bhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044486; x=1789649286;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EDv69OAGzkqBQ7RSRp2WxCOhPHkMcQF8QxqhLpFfkxc=;
 b=DbfReOs0DQhmnApB6wQcQP+N5nhYPWGUhBcToVSiGNJC1l9e1c0rOuQXhDgMae4geF
 GzQAzAohzkG/PgBVp3tIzMk6ltO0xl3w5U0Vb9lm8PRUYi4kENxyWOuf9B9d72T3gtC+
 +1dsadFGsMEzQmx2oGw0nYJxhfG5BT81B3C+6sZ40jWhkiS/Qc82LhB7FoO1PcGTMYr6
 zW1zjarUBLPN6O1cgMWbi8jXbOKz8lxkKujteYlzkIHXXZuy8hKLxxR4S7iHKzvuEUAV
 wAHXYRCUskcCFrc/HxQfGoIQ1MiCWzmvAbOaFPQo6xRdPt7qqEhZgo7cdY0myGBxWyOT
 IY+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHqK94T/Wom2ZsgsBGBopEFueW7XejWZmPI5kzDOZ4m2ikPWhFDL5d45eXGIH3wcVQXMMvUAE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++muyIATMvun9hKYOJbzf/cYZ8C55AZo94BQjRmF06Vm375iFFzL
 33Re4xs3e4ssZ+mY9eH/XQ2vlIYd5dJJACJBcWETouwYgo0G8/q4HOX8YvXdycOnhGsj/W/8nWG
 aFj1E
X-Gm-Gg: AYBFou31COv9Guxz7kQl9NJDfh5gWBJXnnZJQuA9x+7yjcwFuxNi9rSgriT6wafptNu
 UUnPdxqL5kouHKl4cO2/ZRmqkF7QrHbd4mdsMVomydaiHIObkItwUmxXv5AVm94pd39X2UeSCIj
 TArA47hTfW5s/lOXbBsp7EYEuAV00x2N/rKEFPNOV1jV//JuafUFhevBdZvYhP9z+GVQmgbaW+9
 g6Mj2O4s77Zt/uEWOUpdZ4IZYqNU6NkpTf8JXhooRu2vzXNUC4LlHryyDtRYgYykbTg1pl1uEnD
 iuvSx/zqmFofpRrsyruRUZoDj5rzkFUACDW9g3XYUeUqwlGJ/I/Z+QtMmavFBLBZBm3NVs21JAb
 GqTB0Hbx/a+JCqVS/6OE1lsBaywqc1KGq7iUxkIWHAr0wuNTkoTwirgO7Jq2mGyFus1YNQHHy+H
 3tNACgV8ox6yYQff8QN22VI2FHGhc+w6YShWDZiBmeDeB5KSG9D9cJt1L3CJrn9l5IbtJcUybwa
 DvoJPdrUgv0zLWRR6dc8OA6nvYBDpfMzOQyROJzl1iXami+waIKkg==
X-Received: by 2002:a5d:64e7:0:b0:486:e557:32eb with SMTP id
 ffacd0b85a97d-486e5573615mr2801617f8f.9.1789044485471; 
 Thu, 10 Sep 2026 05:48:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be1c1sm49713828f8f.32.2026.09.10.05.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:48:03 -0700 (PDT)
Message-ID: <bc8285d8-80eb-4f66-a417-48ad0115ad0e@linaro.org>
Date: Thu, 10 Sep 2026 14:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] pci: pcie-rcar-gen4: Switch to generic firmware loader
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
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
> Use generic request_firmware_into_buf_via_script() instead of local
> implementation of similar functionality. This reduces code duplication.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/pci/Kconfig         |  1 +
>   drivers/pci/pci-rcar-gen4.c | 67 ++++++++++++-------------------------
>   2 files changed, 23 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9ffccc3a80b..2b2ccdf4745 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -396,6 +396,7 @@ config PCI_RCAR_GEN4
>   	depends on RCAR_GEN4
>   	select DM_RESET
>   	select DM_GPIO
> +	select FW_LOADER
>   	select PCIE_DW_COMMON
>   	help
>   	  Say Y here if you want to enable PCIe controller support on
> diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
> index 8c5c8095c73..34561406641 100644
> --- a/drivers/pci/pci-rcar-gen4.c
> +++ b/drivers/pci/pci-rcar-gen4.c
> @@ -19,6 +19,7 @@
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <env.h>
> +#include <fw_loader.h>
>   #include <log.h>
>   #include <reset.h>
>   
> @@ -75,6 +76,7 @@
>   
>   #define RCAR_GEN4_PCIE_FIRMWARE_NAME		"rcar_gen4_pcie.bin"
>   #define RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR	0xc000
> +#define RCAR_GEN4_PCIE_FIRMWARE_SIZE		0x8000
>   
>   #define PCIE_T_PVPERL_MS			100
>   
> @@ -107,7 +109,7 @@ struct rcar_gen4_pcie {
>   	u32			max_link_speed;
>   	u32			num_lanes;
>   	u16			*firmware;
> -	u32			firmware_size;
> +	size_t			firmware_size;
>   };
>   
>   /* Common */
> @@ -362,56 +364,31 @@ static int rcar_gen4_pcie_host_init(struct udevice *dev)
>   
>   static int rcar_gen4_pcie_load_firmware(struct rcar_gen4_pcie *rcar)
>   {
> -	ulong addr, size;
>   	int ret;
>   
> -	/*
> -	 * Run user specified firmware loading script, which loads the
> -	 * firmware from whichever location the user decides it should
> -	 * load the firmware from, by whatever means the user decides.
> -	 */
> -	ret = run_command_list("run renesas_rcar_gen4_load_firmware", -1, 0);
> -	if (ret) {
> -		printf("Firmware loading script 'renesas_rcar_gen4_load_firmware' not defined or failed.\n");
> -		goto fail;
> -	}
> -
> -	/* Find out where the firmware got loaded and how long it is. */
> -	addr = env_get_hex("renesas_rcar_gen4_load_firmware_addr", 0);
> -	size = env_get_hex("renesas_rcar_gen4_load_firmware_size", 0);
> -
> -	/*
> -	 * Clear the variables set by the firmware loading script, as
> -	 * their content would become stale once this function exits.
> -	 */
> -	env_set("renesas_rcar_gen4_load_firmware_addr", NULL);
> -	env_set("renesas_rcar_gen4_load_firmware_size", NULL);
> -
> -	if (!addr || !size) {
> -		printf("Firmware address (%lx) or size (%lx) are invalid.\n", addr, size);
> -		goto fail;
> -	}
> -
> -	/* Create local copy of the loaded firmware. */
> -	rcar->firmware = (u16 *)memdup((void *)addr, size);
> +	rcar->firmware = calloc(1, RCAR_GEN4_PCIE_FIRMWARE_SIZE);
>   	if (!rcar->firmware)
>   		return -ENOMEM;
>   
> -	rcar->firmware_size = size;
> -
> -	return 0;
> +	ret = request_firmware_into_buf_via_script(rcar->firmware,
> +						   RCAR_GEN4_PCIE_FIRMWARE_SIZE,
> +						   "renesas_rcar_gen4_load_firmware",
> +						   &rcar->firmware_size);
> +	if (ret) {
> +		free(rcar->firmware);
> +
> +		printf("Define 'renesas_rcar_gen4_load_firmware' script which loads the R-Car\n"
> +		       "Gen4 PCIe controller firmware from storage into memory and sets these\n"
> +		       "two environment variables:\n"
> +		       "  renesas_rcar_gen4_load_firmware_addr ... address of firmware in memory\n"
> +		       "  renesas_rcar_gen4_load_firmware_size ... length of firmware in bytes\n"
> +		       "\n"
> +		       "Example:\n"
> +		       "  => env set renesas_rcar_gen4_load_firmware 'env set renesas_rcar_gen4_load_firmware_addr 0x54000000 && load mmc 0:1 ${renesas_rcar_gen4_load_firmware_addr} lib/firmware/rcar_gen4_pcie.bin && env set renesas_rcar_gen4_load_firmware_size ${filesize}'\n"
> +		       );
> +	}
>   
> -fail:
> -	printf("Define 'renesas_rcar_gen4_load_firmware' script which loads the R-Car\n"
> -	       "Gen4 PCIe controller firmware from storage into memory and sets these\n"
> -	       "two environment variables:\n"
> -	       "  renesas_rcar_gen4_load_firmware_addr ... address of firmware in memory\n"
> -	       "  renesas_rcar_gen4_load_firmware_size ... length of firmware in bytes\n"
> -	       "\n"
> -	       "Example:\n"
> -	       "  => env set renesas_rcar_gen4_load_firmware 'env set renesas_rcar_gen4_load_firmware_addr 0x54000000 && load mmc 0:1 ${renesas_rcar_gen4_load_firmware_addr} lib/firmware/rcar_gen4_pcie.bin && env set renesas_rcar_gen4_load_firmware_size ${filesize}'\n"
> -	       );
> -	return -EINVAL;
> +	return ret;
>   }
>   
>   /**

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
