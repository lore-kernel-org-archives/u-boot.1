Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F82C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0476681ECD;
	Tue,  1 Apr 2025 19:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TgCgM1xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A8081F59; Tue,  1 Apr 2025 19:28:42 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E83817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf825f46bso3496665e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743528519; x=1744133319; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=k/zlksg73PYPsEyq7VGPfDwpzZXs/5kBnKAbMbNk0iY=;
 b=TgCgM1xsExrYUKutgPRSwzwqLSphfYjh/4Izi5Zqbn7FfiQZD7oJr/sd5v4j1kuZeK
 TutX/WNQztQ+reDZwohwoNckGYOkzF86I7751eojkv+fl5fCtj3lXJzZcpEAh3HUaOKJ
 1pNPNUovxbtW+1Mm2ee0OPxCi6qlmiFjBp2d7ueoLVCcGDcQUse+PD4NcBNcb0ifz4Rz
 0W63kl8ex27Av5lZrhn1DGnJjTrsrZ+nuZzbD0YFvB2Jjz9cykWftBDxoUR2Kpzh84Mf
 M1/0nnY0vOhF3TjkZhhL7LXBwP8IIS7Iv1HE4IAPJHeePPKPfc3eQtxUg9CK8bzWvMPa
 8jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528519; x=1744133319;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/zlksg73PYPsEyq7VGPfDwpzZXs/5kBnKAbMbNk0iY=;
 b=SddlWK2JFoDjjY9nIm0ujtgTLgB4m6wxXNUqRvtwxyeSqxTNwhNG8Nuohn8oyAc/i2
 ngFCm62ndd6ZDTHhk1I/OBY/mioRxkaMaY96y/d2mV9xuQSzeOkfR0j9ziOeNOnXX04f
 0dYoxgvyrquBBNKe/E94TD6Kj9Ibq9wFfMfNitJ7vnnWV+9AZ87HbGq4CNV43n14pihj
 I3B8XlO4QhYiMkqVrmfA+ZuGXuJrDD12kftq60Rm28whoujsSF1uUHuhJtd7Dzi3lSC6
 dom8z68j70F4mPK58AgTgNzRLuhPqC8+OneQSWBP3D3zaaCfRlBRvRVACkXycruvEopE
 8srA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV+p9kIRMwHhamBheEpZwFnMVAooS5OEPFdtL0hvGecFWThyvLoZ/atjmSFgwvTw3H86U1eZ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3NME8CiMatudDT0BcDka8RhV0i1DXYpFI5b49ILmaQpzVORs3
 Y1fpAqsTb4b0fMarxJGG1yatFBUKM6NFZ+ujRduxoqz8w+Nnlbwmrz6vFd159iI=
X-Gm-Gg: ASbGnctxs51L0OIGB57cYEOIztlf8aEHloCNOnaG39Uy0c1d0CUCfFFUna3jIbqdiQ/
 bKJddG3zvy/ZKANT6Tmm/c4AYA1Ayaqbp3b7XKm85OocS4s6L+xBPpE+QbntEfLbRO4O/iORgLY
 r3u27Qa3rd9zfkVL4H+UfuYaMZm2pisxuuJFxTdx1ydWh7c6xPXX6+X2xSw6sYCRrrAEINpQQpx
 BCQ0Iilazv+knaVnlhJdIRPoIZfe+UCozR3P3n9kT0e0/seuU6BDWY+UZnt9qbZJRQJFG84bmF/
 BQCVpJA58OinCH1r+UARwq7tiHPkN6wGfR+1kccZbkpv6vy3HZ5stQmPa8awEFw=
X-Google-Smtp-Source: AGHT+IEdkixMWufOaeCzNfBIShRHGWeL++sO5uVWQWItedWA2eIZI9rfyrEq3EAFEDoQWVteHlltUg==
X-Received: by 2002:a05:600c:3b12:b0:43d:2318:ed7f with SMTP id
 5b1f17b1804b1-43ea926c3cdmr10604715e9.0.1743528519429; 
 Tue, 01 Apr 2025 10:28:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e6a532sm204665425e9.9.2025.04.01.10.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 10:28:38 -0700 (PDT)
Message-ID: <62fd6270-e6df-472d-b3ee-0023bfce8d27@linaro.org>
Date: Tue, 1 Apr 2025 19:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
 <20250401144420.GE5495@bill-the-cat>
 <7b6542f2-0a2b-48ce-aaac-0bdf2f9b2fca@linaro.org>
 <20250401164016.GF5495@bill-the-cat>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250401164016.GF5495@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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

On 01/04/2025 18:40, Tom Rini wrote:
> On Tue, Apr 01, 2025 at 05:27:30PM +0200, Krzysztof Kozlowski wrote:
>> On 01/04/2025 16:44, Tom Rini wrote:
>>> On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
>>>> On 27/03/2025 15:50, Christian Marangi wrote:
>>>>> On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 14/03/2025 19:59, Christian Marangi wrote:
>>>>>>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is not a binding and
>>>>>>> should not be placed here. Value is derived internally in the user
>>>>>>> driver.
>>>>>>>
>>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> Please drop my Ack. I have never acked such patch for uboot. If I did,
>>>>>> it was by mistake - probably you CC-ed me for some reason.
>>>>>>
>>>>>
>>>>> Some explaination, uboot introduced the concept of upstream where they
>>>>> "import" linux patch for dts and dt-bindings.
>>>>
>>>> I expected OF_UPSTREAM to be taking the sources, not patches.
>>>>
>>>>>
>>>>> This and the other patch are the exact upstream patch with only the path
>>>>> changed so I keep all the patch commit message with tags and added the
>>>>>
>>>>> [ upstream commit ] thing.
>>>>>
>>>>> Hope Tom can better suggest how this should be done. You were CC
>>>>> probably because the git send-email included you as present in the
>>>>> different tags.
>>>>
>>>> Well, Ack is still not valid because I did not Ack exactly that change.
>>>> It does not matter for the ack, but for Reviewed-by it would matter,
>>>> because it is a statement (of oversight...). I cannot control what you
>>>> put into patches taken out of kernel, but at least do not Cc me on that.
>>>
>>> In specifics, yes, we should update doc/develop/devicetree/control.rst
>>> and maybe doc/develop/sending_patches.rst to use --suppress-cc=all for
>>> dts/upstream.
>>>
>>> But in general, what do you expect people to be doing with content from
>>> devicetree-rebasing? We're doing some direct cherry-picks in between
>>> merging of the tags. I think it would be weird to be dropping the tags
>>> and un-attributing peoples work.
>>
>>
>> I rather expected something like how kernel is importing dtc. You just
>> list the commits you get. If you want the full git history, then I would
>> expect simple git submodule. In both cases there will be no such patches
>> on the lists.
>>
>> For the Ack it does not matter, but I would feel uncomfortable if people
>> were sending stripped and modified patches with my Rb tag.
> 
> I guess I'm confused. Looking at
> https://patchwork.ozlabs.org/project/uboot/patch/20250314185941.27834-6-ansuelsmth@gmail.com/
> we're doing the normal thing of havig "[ upstream commit <sha>]" after
> the imported log. When I merge the subtree and tag it indeed gives what
> you're expecting too.

When you merge subtree, the patch is not modified and it lives in
separate repo. No one sends them over lists, no one modifies them.
Unlike here (even if modification did not happen, person was touching it
so how can anyone be sure? That's not a scripted process).

Best regards,
Krzysztof
