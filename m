Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FEEC4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EA1838D7;
	Mon, 20 Jul 2026 15:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KayUKn2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 596E2842FC; Mon, 20 Jul 2026 15:25:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184B680517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso9889905e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553939; x=1785158739; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZehAxsvfZhH15aoQdLP+4oNr+iM17ios8rxa3P1nh70=;
 b=KayUKn2xX5p3WceXXCM189EaQdwfnYAfimmI19yFoVp1A2tQpEDGCnYcOkPF0qmQNv
 Qn2XprVvNIF8LPirZohIgEjE0o33W9aEO37afpUDVka9fS9JeJ1lFEWO6r8E0iA+4JEx
 p1WM4IHfcEhJY37ukTQeCa5Pamv6h4ShF92SaNbx53xWb+TWIjzxzzTP5va1eNxxpe9m
 kDOql/qvwFqR1pX8KQMKMNb+gylI1L36EQwtCpjz39R1IClRIBV4jdA3OaDwyZTxWmxT
 WvZyTftLanmRGC8pOfR9C4S36yCwkCNO6qG9nbnYJVYyTW5LZ0rDSzc0KzXnkZ+DCrn9
 JCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553939; x=1785158739;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZehAxsvfZhH15aoQdLP+4oNr+iM17ios8rxa3P1nh70=;
 b=FXeo5TzZjpBF8QyOhpxAzYcLXDLKuPT3bpChYyAH5p9kUjDQaVMN2LcwfWrCyd6MZP
 58b+8th7HMvVLo8FSrt52sqC7Dswsk/or+ML528MVDEDqtDbK7il1ZcgyaTqT1Wtzqzx
 WP+H4eAmoWvNhJjKAjW+vucaiZCq3LGffoQMyv/Zjo7BdqNJ6Ek5gajn9P1yjAbH+IX0
 1B6+CbbnwSLeYH3RkLbg2yuxgLLAInt0Nd2TzmW2Knqahm34N9iMJ58GThoiU+sauQZr
 5KpFrozJgPxn137uGNSm4AY0HsD1FhIjltHFyiGzkSzuDhpkk7BknA4+vOQYotseFjY4
 NElw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUXVq59nlDZlvnO4LBPzOM0+ODmzjisbVVBsq7Mzne1tmEznJNu2eee9ZjQTHGpmqWfGnKOVA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy7U31U70TMmqHnpz9tdKtkM5r6/OPs5FWLmqX6CtcU5gwedVs
 FC3qbqWFfkn1PZ/r5vEf3AoMzuFffyvmwpZRAIzm7h8IxmfywRMH+mvizViwLmflGxM=
X-Gm-Gg: AfdE7cnUhAY0plnH7dwBKkxrOEnDRtRnesLHmSvFOG62yVxMqvdQqJrAnAWr6EieeHS
 YFNwxjbmvQ1MghOldLPGDa/k6tJZ/+Xum9Z16m7ATjhFGmZR3396ki+obHL3oyiMG7+MQAvnDfP
 EDw7R8+V9XMkH/CiPThXsQPa46VIGb3b27fs/i+9pk6vj8qcCikB+jybzB8psUe5JxkUAimKKF9
 mEnm80A6GsgWCnKgjcJF24fGdMHnPkX+HgDs4EAzRPqdalX6NWyLYDSAkfnolQ2lwrqj+TlGzJ/
 LomDP9m1fYGcNNmp/BtxCafhpd80cjW4hI2DjeKH6Sw8lObxny2VV483wHpOVxkT31JPjzWZMh/
 +/7ngjXWJ0bQTbIDtsJwkWSzBtNSLRrO7FL7J6AvTwLgENiVw0euFxur6w3nzw2jbXasRnMJJbk
 YB4aaHRyMZ8Xfvqpr28JJnpychvg8e4E0rcDBIg/h9pMHwif2LOSOASMlIBeU=
X-Received: by 2002:a05:600d:9:b0:495:5e07:649b with SMTP id
 5b1f17b1804b1-4955e16aca3mr48038415e9.24.1784553938920; 
 Mon, 20 Jul 2026 06:25:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:1101:a3b4:4010:a727:b812?
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6fa848fcsm20087936f8f.0.2026.07.20.06.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 06:25:38 -0700 (PDT)
Message-ID: <83cb6bab-ca75-4c26-8363-19c40ce8da21@linaro.org>
Date: Mon, 20 Jul 2026 14:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tools: qcom: mkmbn: Add support for ipq5210
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
 <20260714-ipq5210-v1-2-0b98251aabbd@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260714-ipq5210-v1-2-0b98251aabbd@oss.qualcomm.com>
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

Hi Varadarajan,

On 7/14/26 10:52, Varadarajan Narayanan wrote:
> - Add ipq5210 entry to the 'boards' table
> - Add an argument to specify the SPL load address
> - ipq5210's boot rom expects the SPL image size to be 4-byte aligned. To
>    support this add an argument to specify the image size alignment to
>    enable the mkmbn script to pad the image accordingly.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   tools/qcom/mkmbn/mkmbn.py | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
> index 8d2078acc30..46edbcafb32 100755
> --- a/tools/qcom/mkmbn/mkmbn.py
> +++ b/tools/qcom/mkmbn/mkmbn.py
> @@ -85,6 +85,7 @@ boards: dict[bytes, MbnData] = {
>       b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
>       b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
>       b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
> +    b"qcom,ipq5210\0": MbnData(0x87980000, 7, SwId.aboot),
>       b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
>       b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
>   
> @@ -100,9 +101,15 @@ parser = argparse.ArgumentParser(
>   """
>   )
>   parser.register("type", "hex", lambda s: int(s, 16))
> +parser.add_argument(
> +    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
> +)

How about we extend MbnData to support an optional SPL load address 
option? Then just have a flag to indicate that we're building an SPL 
image (since presumably you need to add an SPL specific build target for 
u-boot-spl.mbn?).

>   parser.add_argument(
>       "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
>   )
> +parser.add_argument(
> +    "-s", "--szalign", type=int, default=0, help="Size alignment"
> +)

Pretty sure it's safe to align all the images...... we really don't need 
to be adding bogus flags for this kinda stuff.

>   parser.add_argument(
>       "-v", dest="verbose", action="store_true", default=False, help="Verbose"
>   )
> @@ -149,8 +156,15 @@ if not mbn:
>       args.output.unlink(missing_ok=True)
>       exit(1)
>   
> +if args.load != 0:
> +	print("Using load address from command line: %s" % hex(args.load))
> +	mbn.loadaddr = args.load
> +
>   log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
>   
> +if args.szalign != 0:
> +	data += b'\x00' * (-len(data) % args.szalign)
> +
>   elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
>   elf.ehdr.e_entry = mbn.loadaddr
>   elf.update()
> 

