Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F5CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 15:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9993D83B9B;
	Thu,  6 Nov 2025 16:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="X9cQItzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E6083BCE; Thu,  6 Nov 2025 16:51:46 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D15583B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 16:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso12740555e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762444303; x=1763049103; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jgiZyDRCXFRjDWCQQdYFuO3a9cIBfhd+iR3hQGyVakI=;
 b=X9cQItzHv+PMXNUb8MDeMYtga1xiq/Pnl1A0mzsSQmwcLGrYUimgLgN7rN66szkYbL
 E9OiVYuTkSXC311gdyMre4HjIvQPNkzTfHUD7s6exD2DCVXgJ2Ter2MfVeHn6TNDqxC7
 kJbwJMoZts//TNnvraqtPm0Jtzmi97IUy6fePK+O6lk4n2rZj/lkBrX//FBCWNpOODwf
 h+Pq1yCRPU3LmyyeX6BI2Bs/O728oDA2riqNH2g7vnbmh9Em0hV5IEhkGJvPDt7Nkn0w
 pbFTILXOT5D2Y/UnxivGsOp+/0QKk8gwdmtKUbfr4AIOp37hVOskl3TvmjrirdRgPr89
 MGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444304; x=1763049104;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgiZyDRCXFRjDWCQQdYFuO3a9cIBfhd+iR3hQGyVakI=;
 b=k6eFH0AKP2swYD2GJ4+itKBI1FbZVecipHDpnkDdwBpz7Cs/w1n5FeRGneuPvb6Suv
 y9Wm0T/avJ5ELowjk6OpieobX7QHtHJe26fn17Ifx63kYI1IWCeAaJ93AFJiVjgOGlUN
 5K61u8JBbMwg9vAG4q7KvnFOA6Nq1KWgbpYNBSar8yEllp3lPsVrskcoXMJa/V4Y5B+U
 FBQ4Ojk03Zw1lgTBF7cuLNBOXjZ/Vp3TakPScc4ZtloXtpJ3qcSwWUt+yE8vaB51/sRd
 b+7WQ/NkyoyndBaT0f6gk3ADZu00erlrE1BNGQE5Zb3TVHukcmaM118B/Fgtm55gCQAF
 7h/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgUPGV4A7Ke91S/MWqFymbm80C56iiowV4nm4yQDiXbhn2fZpYeCxj9GRgu2f0OZotSoQQfqQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwH9ZhPC9j468yqIoRJbhk2upL0vla5i9SObOqscf2WKrZAbeMU
 DYy0wDax/2ToorVsav39iEX7MUfTbwzgERF8KB+Sy/94MuNUUe2cpk3OtWvPy31+9IM=
X-Gm-Gg: ASbGncursJW1nyXw7lLrF9CSnmWTiV2pTsFPad0/KnvYPf3cCqXTOjVUrYLaUWWt7/z
 DP5U7wrDLjLv6wyqC3Zqbw7q+ZScyqueG7wgfVLBoWaLkMx9OYjQj03ha0WvGCUKy7OAl9r1I4t
 65327gVv35wprmDrHKBuOUgu9OSocO4aQIhYDXjVCcobG5/wCS0kpI+wwZ7U/VNYC4gY8Mf7xUq
 /n0I645nnuGZidpuT6GqNv+1hrj9mWAKuDnIOAkeOG5NNMLESJzUi32nG3hk3nRp28Wej9eO9Qh
 UrxgTVoNfzP5tvGJWN5ZYjZX43yz99/PisWXotKtChyZJQdNOkxICr2huRcKelTPkaLLk0uxa11
 UGNh6ZrO+APiwbgK88ZlRTk5WXy7tlfwzW7DwMzcBYlOOaieJjuPhaODst7Dp/oMuKeP+2mGqYO
 rlAxmyGYDYWcFcesMX6LUAGqU=
X-Google-Smtp-Source: AGHT+IHDH+Kgi11w0YW1LKKwv+9V12ptvK91cXnaIQFlDhD/N1J2JaeIyaBhDiPNisiREoZPrx6AVQ==
X-Received: by 2002:a05:6000:4282:b0:429:d3c9:b88f with SMTP id
 ffacd0b85a97d-429e32cb7dcmr5951823f8f.8.1762444303517; 
 Thu, 06 Nov 2025 07:51:43 -0800 (PST)
Received: from [192.168.2.177] ([91.116.220.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb42a2aasm5704371f8f.21.2025.11.06.07.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:51:43 -0800 (PST)
Message-ID: <6c967722-18cd-4dfc-a282-b0bb0c37454b@suse.com>
Date: Thu, 6 Nov 2025 16:51:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/4] pci-uclass: respect ofnode_read_pci_vendev
 retval
To: Torsten Duwe <duwe@lst.de>, Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Huan Zhou <me@per1cycle.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?=
 <sairon@sairon.cz>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk
 <volodymyr_babchuk@epam.com>, Oleksii Moisieiev
 <Oleksii_Moisieiev@epam.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
References: <20251105163553.15F2A227AAC@verein.lst.de>
 <20251105164432.C8AA4227AAD@verein.lst.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT7CwXgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOzsFNBF3VOUgBEACbvyZOfLjgfB0hg0rhlAfpTmnFwm1TjkssGZKvgMr/t6v1yGm8nmmD
 MIa4jblx41MSDkUKFhyB80wqrAIB6SRX0h6DOLpQrjjxbV46nxB5ANLqwektI57yenr/O+ZS
 +GIuiSTu1kGEbP5ezmpCYk9dxqDsAyJ+4Rx/zxlKkKGZQHdZ+UlXYOnEXexKifkTDaLne6Zc
 up1EgkTDVmzam4MloyrA/fAjIx2t90gfVkEEkMhZX/nc/naYq1hDQqGN778CiWkqX3qimLqj
 1UsZ6qSl6qsozZxvVuOjlmafiVeXo28lEf9lPrzMG04pS3CFKU4HZsTwgOidBkI5ijbDSimI
 CDJ+luKPy6IjuyIETptbHZ9CmyaLgmtkGaENPqf+5iV4ZbQNFxmYTZSN56Q9ZS6Y3XeNpVm6
 FOFXrlKeFTTlyFlPy9TWcBMDCKsxV5eB5kYvDGGxx26Tec1vlVKxX3kQz8o62KWsfr1kvpeu
 fDzx/rFpoY91XJSKAFNZz99xa7DX6eQYkM2qN9K8HuJ7XXhHTxDbxpi3wsIlFdgzVa5iWhNw
 iFFJdSiEaAeaHu6yXjr39FrkIVoyFPfIJVyK4d1mHe77H47WxFw6FoVbcGTEoTL6e3HDwntn
 OGAU6CLYcaQ4aAz1HTcDrLBzSw/BuCSAXscIuKuyE/ZT+rFbLcLwOQARAQABwsF2BBgBCAAg
 FiEE5rmSGMDywyUcLDoX2RQLslYTAvEFAl3VOUgCGwwACgkQ2RQLslYTAvG11w/+Mcn28jxp
 0WLUdChZQoJBtl1nlkkdrIUojNT2RkT8UfPPMwNlgWBwJOzaSZRXIaWhK1elnRa10IwwHfWM
 GhB7nH0u0gIcSKnSKs1ebzRazI8IQdTfDH3VCQ6YMl+2bpPz4XeWqGVzcLAkamg9jsBWV6/N
 c0l8BNlHT5iH02E43lbDgCOxme2pArETyuuJ4tF36F7ntl1Eq1FE0Ypk5LjB602Gh2N+eOGv
 hnbkECywPmr7Hi5o7yh8bFOM52tKdGG+HM8KCY/sEpFRkDTA28XGNugjDyttOI4UZvURuvO6
 quuvdYW4rgLVgAXgLJdQEvpnUu2j/+LjjOJBQr12ICB8T/waFc/QmUzBFQGVc20SsmAi1H9c
 C4XB87oE4jjc/X1jASy7JCr6u5tbZa+tZjYGPZ1cMApTFLhO4tR/a/9v1Fy3fqWPNs3F4Ra3
 5irgg5jpAecT7DjFUCR/CNP5W6nywKn7MUm/19VSmj9uN484vg8w/XL49iung+Y+ZHCiSUGn
 LV6nybxdRG/jp8ZQdQQixPA9azZDzuTu+NjKtzIA5qtfZfmm8xC+kAwAMZ/ZnfCsKwN0bbnD
 YfO3B5Q131ASmu0kbwY03Mw4PhxDzZNrt4a89Y95dq5YkMtVH2Me1ZP063cFCCYCkvEAK/C8
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20251105164432.C8AA4227AAD@verein.lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 05/11/2025 17:44, Torsten Duwe wrote:
> The vendor:device read in pci_uclass_child_post_bind() might fail,
> which is currently ignored. In that case e.g. the RP1 on the RasPi5
> is erroneously being treated as a host bridge.
> 
> Mark the device's PCI info as invalid in case of failure.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/pci/pci-uclass.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> index c370f8c6400..4092e8ff5a9 100644
> --- a/drivers/pci/pci-uclass.c
> +++ b/drivers/pci/pci-uclass.c
> @@ -1200,6 +1200,7 @@ static int pci_uclass_post_probe(struct udevice *bus)
>   static int pci_uclass_child_post_bind(struct udevice *dev)
>   {
>   	struct pci_child_plat *pplat;
> +	int err;
>   
>   	if (!dev_has_ofnode(dev))
>   		return 0;
> @@ -1207,7 +1208,13 @@ static int pci_uclass_child_post_bind(struct udevice *dev)
>   	pplat = dev_get_parent_plat(dev);
>   
>   	/* Extract vendor id and device id if available */
> -	ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor, &pplat->device);
> +	err = ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor,
> +				     &pplat->device);
> +	if (err) {
> +		/* Mark PCI device structure as invalid */
> +		pplat->devfn = -1;
> +		return 0;
> +	}
>   
>   	/* Extract the devfn from fdt_pci_addr */
>   	pplat->devfn = pci_get_devfn(dev);

