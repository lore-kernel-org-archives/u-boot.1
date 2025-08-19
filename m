Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22593CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B83781FEE;
	Tue, 19 Aug 2025 10:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="i5h01+PD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5A782BF6; Tue, 19 Aug 2025 10:48:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E18B80FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afca3e71009so893460666b.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1755593309; x=1756198109;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=x+l50qHk+23ihczaYSxOPGaktc1TCqWkRWaeysE3/B0=;
 b=i5h01+PDrqHv72CTzFvtU9F2olIg5Lz0EOab2GAFIP8ouayh08JGBV6k+TzrurGBT0
 snfz5HK8A3doS8K9dVtt36p6fhXqlVmjlHSNxeDfOzy3O23J7kmrozCmtYn6Qs+QxOeN
 Tt7Gc+NI/qjaRpJmWjo3310CobDUgyQz31fWBatsO1TXaHbeWdTnAxwpvqMfP1d0IxJb
 IT34jvH2O+7GR3fnnRLzqoJs/sHlZctk/xoD5LdMLQ9MdSl/PNbQ+7TCGDXKhHETCmjI
 E4o+gIgAh+tTh81gqCW3PH3FfTvFY94mF16uVGCA5vQETjRBjdmweIvgRyNzDXhN+XCg
 1Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755593309; x=1756198109;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+l50qHk+23ihczaYSxOPGaktc1TCqWkRWaeysE3/B0=;
 b=mMdO35vDUQSoXH8yA+ZXwnxgNxMzGBuIh5BNLZYxi44yhvcbrj6Yxc6dEOHQ1XH1Ch
 ddXH+sb/lorc9C57UF5jw81mWn4CJ4UZB+h0euu2hKOvT+7D9NtDntGsgeSVgXt0jg8T
 kdpAqyxwqnfjDV0G10YG0pE/4iIbZEHZvbn0iBfgCaO3yXMTH8CO59Fl5HUdzc0IA9Gf
 LgrXlopSA9ZZ6XsUTR4Q7FVpXNI6BMnPbrMYAMv+yJ9LzUY0c26R4gySCteFOd3IX837
 kJYWxirTssl+dGJ6UG8uaVEkjRNCob6Yw907oBJTGbIEAs1NWe0hllwb3M7c9qnE11Fr
 /xtQ==
X-Gm-Message-State: AOJu0YzZCbFBlW36AWprQYZ+7soqAEDjHmRCQfKUiNP0oFNlqUTmhXog
 VwvthyeodlbzyWp+1cNsQazo20EdMCy6g1IqfRzywqlzPyKd6CJ6bu5b59IKC8tXydVcnSSTu7G
 +Galuadl0
X-Gm-Gg: ASbGncutYMr80orL+PpK6/D6Vw1QjdRfcBgeOSEPK7V6iu5ZtB+4WX53bXJc/bpXsDY
 vVHoa4XFbEsw4pH9yK+4lDLrEydC28LfcypLc851X7zNazPjAHl//Q6UzHXDxvTFlqtDh8q0rwp
 vcDGIi5I6r+BQXWywT75knAO5SwArvBBD3xcyyoDMO7itb/4sRnZrcgfkw/Oenh1KgWdLQLqbfJ
 USkxXBetL0JkDcPY4yydWYFMtZnHxWnXtCZ/oGXypIw2CNl/1DgEQjgNi+QaDeOktbQ5MaL6DPl
 ufjvq57x6Ijmu5x8gWWLoeBBaJwItkdmJoBRB6R5+Ek1l3+ErZVpvmj4jYb0HDTHbGd7h/91xpv
 c48zdthaESCcBT2QfsIEGbHQJ
X-Google-Smtp-Source: AGHT+IGOMO0d9KzrK/T+47I0pYViyWZ17dGO6FhyZYlHqxLe1VOCttnmBUMZVjRDE6RIqMHSwYXibQ==
X-Received: by 2002:a17:906:cac7:b0:afc:d246:8425 with SMTP id
 a640c23a62f3a-afddf10e297mr137639366b.19.1755593309313; 
 Tue, 19 Aug 2025 01:48:29 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afcdcfcb2bbsm970608166b.77.2025.08.19.01.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 01:48:28 -0700 (PDT)
Message-ID: <cb51edb1-8da1-4e2d-9246-b630282a9fbf@monstr.eu>
Date: Tue, 19 Aug 2025 10:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add missing ethernet alias for kr260-revB
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <87d88dba98f7ed96463964684ee45a506d557226.1753797318.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <87d88dba98f7ed96463964684ee45a506d557226.1753797318.git.michal.simek@amd.com>
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



On 7/29/25 15:55, Michal Simek wrote:
> Ethernet aliases are used in fdt_fixup_ethernet() to inject
> local-mac-address in every boot for OS. Similar change has been done for
> other carrier cards by commit c4a711253613 ("arm64: zynqmp: Describe
> ethernet controllers via aliases on SOM").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 0d915d496cae..60ac5085f738 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -20,6 +20,11 @@
>   		     "xlnx,zynqmp-sk-kr260", "xlnx,zynqmp";
>   	model = "ZynqMP KR260 revB";
>   
> +	aliases {
> +		ethernet0 = "/axi/ethernet@ff0b0000"; /* &gem0 */
> +		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
> +	};
> +
>   	ina260-u14 {
>   		compatible = "iio-hwmon";
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

