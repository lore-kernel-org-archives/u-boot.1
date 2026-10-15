Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6DCCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08F1F80F56;
	Thu, 15 Oct 2026 08:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14_TneyEMnu8; Thu, 15 Oct 2026 08:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4943080F59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052820;
	b=aT2N3p6RY2+VPnPVFAP+Z+4CO6JCofJrGl1h6YAmFlxeojMZ3Jb7azBbNVKUatcFJ74g
	 OYqBntsL8hchxhvC+HakFnJKdC81ncS7Um+r9uj5jEOxDjXWQi2ozh3URbY7PuF51r/Cc
	 JsRfh983iEIOT8PmyWE/gigNv9RV83XDxL+a+qpxFmYPT3lKDcIiafHCidveQL7Yh5vY/
	 7Erwbo6QKdK/vRvbyEcjH6f6A9S168M0ctc+/YR1n3y8e1jcbwq3f2kvxG1xIClewXUBq
	 SU24PtnFeWx+3Yj0WWJxhWIN6u2BlAWNrtVUvtRV3Td2GpMSob56+eAHcvNJ+1ueN2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3++aCZmWENjR6h+9ViCu9pPOkFRk3/x8wjIB6680z2M=;
	b=TDQPkypNFrqylowGjAstVvtZbPoDOamG0lTzhZCaHYTCOm5/OsRdbT1PO4/dQLBHmAlb
	 u/0Iwk+AK6tmar0Bl0CZwjAnvv0pnWy2X0fEMQhZBnEE+z8+PYaf6gn7l/HRkCcOfCnXt
	 SCN3qXJehR8kMZfPSQLC0/xVniqDTvsUBfcFiA6EgWrC6ht2zyVy9tEYaLPJPZAY3H2n3
	 XggTECRcVdSksnAFCHuVPvy2LHN4PpkiedtvFFpe1gksloL4A4+UZhpRz9qcrXfkisVxd
	 XaNrT+4z6r3GsmK/SlddN2AbeyKKA54l9Yx/TdQn91PFBTqF7y8JuGeF8VLxWrZVhYw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052820;
	bh=3++aCZmWENjR6h+9ViCu9pPOkFRk3/x8wjIB6680z2M=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VOrSogI4fkuXUZVhlk0eyrZ8LbK11FR6FolmOB64XQVx/Goh5Clz6i15xXaYypaGc
	 MEjl7eSBgKOTpwE0ct6mQCOob3nqJZ7RhV3xNZr9qhFW25DBzUiCVGmCholaRgXWzJ
	 bbmOTa2FdkhQRxOnmmmWfkz/Lx9jlwkd47kKNIb6+sJTceqijCpbCv0Coe+Y46CR5P
	 itePMgNSI6p/2eanpSqRwRUe2rldltv3qpcKo+lO/0ZQHN4Xi0hjiAqMHj49vvCIIz
	 7VCm9t9IpySSCMkPbZEdz8dadKpSbYBb0+oWLqFJxZAB9K8S+VOTsGiEQbrxofBv/B
	 sp/EeW4A8Iy7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4943080F59;
	Thu, 15 Oct 2026 08:27:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86556769
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15A51403AF
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPCFFTQKWMQm for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 08:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1AA3840053
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792052786;
 b=GFVblqFfKC03karXq94fwI3HhEZznBKrqZSOrseXzV6jvLNn5920tddwPGhFavR7KcGB
 ivfB/A0rc5/P+5/xpSEEMHJPpghBa7odnpvmdkpAJ0RRSk2Ke7N0zjeIwh1M5LUjPrg9B
 q4QPLKhPeBK5XKSCltWm/ut2me1csx71XTjCryV6nIEEMAVvy2suNr1iyXocGou4a4Elt
 uTiJYmLplr9UV9fTahhff1mEraKH1iVMAbZ9gYBqUtOYu+E/fu/778cVQQfkn0qw8Vt1H
 7xMXkrxFgfpRjPQOLy4763/MMiD0HZFNN0TjeBWZzupo5dKPCQ9v6f6AjardWv7rppg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792052786;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=3++aCZmWENjR6h+9ViCu9pPOkFRk3/x8wjIB6680z2M=;
 b=fkdGA4Brvn7Y6s5VNtdxhHMFzJK45zYmv6T7DPOGXiUqJd6fuOi/mSNbe/1ZDfh2VOJx
 DpqW26CBM9UGbGn0f6CozYehXFxd314aK4o81hO171caNj8XD/L/vUfH9q/aqmGt2AgSp
 gttQP9zmeuPvA4rEABDIOsEU0IqI+9GxpakdwIQ6q9+JRzNeWDXDNvzbAkPtO2+gTlKqg
 jipUiglyxB9k0tlZp4ZknD4ESNEvSAAq70nXUx3VZdKymD+wJhjHQAdaXchXjIyCclV9+
 jlzQ9zwanI+2X563b/CGtrK+pYCHzDGpCiT7YJ/qd5bBt2ama4+zpZ5VM370O7NkLHw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VBJeAbXD; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VBJeAbXD
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AA3840053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:26:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 269C7107766; Thu, 15 Oct 2026 10:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792052779;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3++aCZmWENjR6h+9ViCu9pPOkFRk3/x8wjIB6680z2M=;
 b=VBJeAbXD3/OWxl0eWZTs4NM+3ipLblveCCv3ux7kwcAl2U5UY2+EsmBqRj2eQr65SpDpvw
 lBIKbttRr1S4worCkLZTuftBdaH2JjLlnf4h1TDOeqGRlUsHK6V3GmTXvbNfogNIDYRhEf
 ogAt4GG178+BCTaNaiPakIHeiuzIwIBekqpCxCT1mv/bLArXkMgtuI10Mgj/1xu5g5W4Tl
 dUfDlUfo5t5a10vpME1M1SQoOvy6nQGNKk4VguBU7tsGhgQB7lFX55zymkCqRFA2U1WFfj
 VAqtoOVdV0mhh0LH2tSzNMDboISaAAXzFiDl7zdNu/OWt/6NVS8ljMWZXjRDCA==
Message-ID: <735b9683-7bea-3ccb-701d-0f827ac5c88c@nabladev.com>
Date: Thu, 15 Oct 2026 10:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/5] arm: dts: ipq5424-rdp466: Add GENI I2C nodes
Content-Language: en-US
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <20261007174151.2590649-3-gurumoorthy.santhakumar@oss.qualcomm.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261007174151.2590649-3-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Gurumoorthy Santhakumar,

On 07.10.26 19:41, Gurumoorthy Santhakumar wrote:
> Add GENI I2C0 and I2C1 nodes with 400KHz bus speed.
> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
> ---
>   arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 65 +++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> index 56677cd6f6d..5c9a7384f04 100644
> --- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> +++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> @@ -38,3 +38,68 @@
>   		status = "okay";
>   	};
>   
> +	&qupv3 {
> +		i2c0: i2c@1a88000 {
> +			compatible = "qcom,geni-i2c";
> +			reg = <0x0 0x1a88000 0x0 0x4000>;
> +			reg-names = "se_phys";
> +			assigned-clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
> +			assigned-clock-rates = <64000000>;
> +			clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
> +			clock-names = "se";
> +			clock-frequency = <400000>;
> +			qcom,geni-se-clk-32mhz;

See my comments to v1

> +			pinctrl-0 = <&i2c0_pinmux>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +		};
> +
> +		i2c1: i2c@1a8c000 {
> +			compatible = "qcom,geni-i2c";
> +			reg = <0x0 0x1a8c000 0x0 0x4000>;
> +			reg-names = "se_phys";
> +			assigned-clocks = <&gcc GCC_QUPV3_I2C1_CLK>;
> +			assigned-clock-rates = <64000000>;
> +			clocks = <&gcc GCC_QUPV3_I2C1_CLK>;
> +			clock-names = "se";
> +			clock-frequency = <400000>;
> +			qcom,geni-se-clk-32mhz;

Here too, I really would like to prevent this U-Boot specific property.

> +			pinctrl-0 = <&i2c1_pinmux>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +		};
> +	};
> +
> +	&tlmm {
> +		i2c0_pinmux: i2c0 {
> +			i2c0_scl {
> +				pins = "gpio14";
> +				function = "i2c0_scl";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			i2c0_sda {
> +				pins = "gpio15";
> +				function = "i2c0_sda";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +		};
> +
> +		i2c1_pinmux: i2c1 {
> +			i2c1_scl {
> +				pins = "gpio16";
> +				function = "i2c1_scl";
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			i2c1_sda {
> +				pins = "gpio17";
> +				function = "i2c1_sda";
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +		};
> +	};
> 

Beside of that you can add my

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
