Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B709C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 17:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2124040A1A;
	Fri, 28 Aug 2026 17:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TfvP-UxwPSBa; Fri, 28 Aug 2026 17:54:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787939677;
	bh=3Z/SPcPFTTDAwH2Ih9TEbNWNLJLZi4Kzua4uEZH4cVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vVETXzKhy7hC8C8rP2cYfNG91Wx6Kle8wpn1a8+mM6MCOEHPJ9q4lNnJrxeilb9b/
	 nroJ4/ALTT2pK1gcY6JaWXeglsSx+KhhoDWGDquloeL1m9c6J1dpqIVIk1Ut1wX8dl
	 cEnHvR60Si/el8+5S2bE4FgnAH8r9WuA5JsvEgZAfGowJNFHz98ECVyqQd3tT5sBHR
	 mZNSpsRt5nTXPs1dvsMtplI0/U8M7s9a0YFFYweL/+Qr/aDcDLtCa0jTSrhAsYCrQX
	 k9u1t8YnJutDcAB+wYMjzQOBh/YKGQTSPvfSq3vggJPW9o5hYnYnJz9pRhtFkJXlBO
	 c29KZu/jE7UNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1976E40A06;
	Fri, 28 Aug 2026 17:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58009127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 17:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49E7440A06
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 17:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBUA00Z_LeT0 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 17:54:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ibfngDCi
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BE0B409F9
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 17:54:33 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-90cdffe8e3eso9655326d6.2
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787939672; x=1788544472;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Z/SPcPFTTDAwH2Ih9TEbNWNLJLZi4Kzua4uEZH4cVk=;
 b=ibfngDCiBvo2XZNDJsgv2rE9Nb+2ID0LeUxLakGGZCwuyZVKTQ6qQhzNCwHtEzupCH
 SQu06NHLNR7BlR+SQ57yuJHg1uj2ff6lDs0MrAaOCLKMXiPf1rS1zlFpQ3qquhy56Rg/
 YOgF9/JLJ/eAn7A+4qliYziRhPS9aVQYdQbFkW2kWEBM3HPja/rwaNBt5c/nd2NiP2ii
 AOm15LszroP3iG0GxrjGlh6sOILlX8Xt4uBhUMVUhkA2aTf5cKgBJV1W3Uv10ssYDZTI
 pOaWhTwGazNIf4W1PDNMohISBJ16wjwWhB7NdgSBgVmAQtZBP4WhPaoLnApUnHGJ5X28
 DDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787939672; x=1788544472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Z/SPcPFTTDAwH2Ih9TEbNWNLJLZi4Kzua4uEZH4cVk=;
 b=DEA0KVW7raaad9aw8ExALoHEa1xOew0pLp81w31D1cRROtuJaX6T0+vSp670L8hzTA
 /9XSFdBHE2lp4lfNH/1bGRb1oHHTSgXvTBdGu/ukaHuHhf/gR7zr6ts2UrX8Z+VxmXKF
 yHBT1RtV4w/AzeQqJFwMYP+vVaYNwtBDOKI1uE/mRGc0sYnBmX9/JqOYtMmgNQ8MjdHB
 0TieZYDuPJ4/lpRtJwQ53zVazzh6nLlQe9fY0kbmnnma12qdxeATQYF78FAWNJOqun0w
 Hiig9tdBq7InSo8ckxgovZL/UQgXh4F6faLRlPa/whknvjDCSfw9PmjprNnAsFIr0N4h
 eZ7A==
X-Gm-Message-State: AFuF++n12WtOpHDZbRO+2WXvwrl6/oEHPHeitYzNmzO3ybTm6rBC5yDr
 EFHSGiHrs7No2W8PI7alh8Cz6g3Bom69y3hdLNmUQ+rs3VxiilTSmui5dp2g+4Oay7s=
X-Gm-Gg: AR+sD12hO46N/8bpMP+Hx+U7x8HFeJCfjXyKIwjpT0WYtBaLoVdoueKMJRRBoAd7L56
 k2Y3PGWlPtAhzzY7i8S5jmxBrqeMCLbeMWVgPfh4B/lhoSSDxx92TT6JGfkmqfW4U+gS6/W+7+/
 QPC33dPa+2bEmWrqRycrlOaLSguDflxu3fWieaO17IJkQAoSarsRtIesCoFoD3CF3Tkon57D0wH
 dqcyXjT1CYeVWAZdgU121bv9K6xLFSdCiEWew1ncUz5B8zPBvfp+yyg8VX8JpEouaSOKbREwU4y
 iYSUhoT1BgQ6YW+7wC1XhfwiJNG9GtoMUbLeqLxX+20ttD4o+/lTg5R5RUAkiEJNMqHVnhIZewD
 2EsO+6e5BIlzMsNjB8m/kfWOEfvlzi7/CuIhuteOMOc6P06V/eCUTxXLCpI73f4zIMnerXYqGQE
 ilb/ZblhnU5IscOzcb0NAejcx/aLzFoge3murOsbkhJrmRrKbzqAT4kpYy531Tf/qLfyaivIjnj
 HuKj7xOATpAdobLKNhV9lGRN4IA/74eFTjQy/vIcmw=
X-Received: by 2002:a05:6214:2b84:b0:8ef:e3c9:533e with SMTP id
 6a1803df08f44-90ce0e584f6mr122624566d6.9.1787939672540; 
 Fri, 28 Aug 2026 10:54:32 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90d98a9b324sm977876d6.20.2026.08.28.10.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 10:54:30 -0700 (PDT)
Date: Fri, 28 Aug 2026 13:54:29 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: r9a06g032: sync with upstream
Message-ID: <apHLVXtTGuVEoeWC@maple.netwinder.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
 <ab4604be-aba8-4193-97b3-cc997ea05861@mailbox.org>
 <aoBalbRFgBNJqZAV@maple.netwinder.org>
 <429a5b6b-cffe-4ab5-ba22-8e985c1c3a1e@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429a5b6b-cffe-4ab5-ba22-8e985c1c3a1e@mailbox.org>
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

On Sun, Aug 16, 2026 at 01:25:09PM +0200, Marek Vasut wrote:
>On 8/15/26 2:24 PM, Ralph Siemsen wrote:
>>On Sat, Aug 15, 2026 at 12:26:16AM +0200, Marek Vasut wrote:
>>>>---
>>>> arch/arm/dts/r9a06g032.dtsi | 270 
>>>>++++++++++++++++++++++++++++++++++ +++++++---
>>>Can you use dts/upstream/src/arm/renesas/r9a06g032.dtsi instead ?
>>>
>>>Can you switch to OF_UPSTREAM ?
>>
>>Almost, but not quite yet. The upstream version is missing the QSPI 
>>node, which just got added in the kernel side. So once that gets 
>>synced into U-boot then we can switch.
>Can you put the missing bits into -u-boot.dtsi ?

As of v2026.10-rc3 this patch is no longer needed, Tom has pulled in 
recent-enough DTS with the qspi node present.

I will switch to OF_UPSTREAM.

Ralph
