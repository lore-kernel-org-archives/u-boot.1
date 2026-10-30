Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8C606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FU7jO1cY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ygRLBaD3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 516C640B3B;
	Fri, 30 Oct 2026 18:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-9Y-20_xhN4; Fri, 30 Oct 2026 18:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67BAB40B34
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793383904;
	b=Hc6BmtulaFRIfc2p/2gfHEY2BZdo3YWmj7mP81aaYA4Tqte06oDMHYs4fDyeLMNUHyQK
	 Ozmw+vBKNqlgcFmjfbu7242clIxU5XPWkslHl1YcxWq2/YK2xLVO7maVCnJ5xle3hAnce
	 G3Zzl+yUEU403W1obXAbRS877GhTm82MSd1pK0bsoOhjBgZiDFWFxUtmQ8z/Qk5u6HPHv
	 W74sHJYJCf1caDVkQYZKcBnoNt1pa9pyAxwCBKljYaXopML4tMFxC+RFiXn9SEJtZTo0C
	 +bvM880nx0T4kTrws7xvY5qz1NBgC0W4K7OWB+Zbm4xE3fWkUznYMv/Jj0IVj5HDb+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793383904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Sy8z+3KYAKuWn1IdezcRYWJzpQQl5Yo7OhbEvBmK1Q4=;
	b=Of5QZT3fFRmytlax/YNfzjdo08jbIoxpyd6Yzp3ohMTT5ajFwuLUlN6uCI6V6wggEszw
	 o3CQECqG6N5jcqsH1OTlIpPWWzmjnJJ5Bb5jOp8NQMTV+/VnekkDi2o5WoJZJZTrPAvFM
	 p2xmuislHvL6f3Qv3ihri9PdnP8vX87AJIu64qJOxRwCgIX6xZ5rHDFGU8NI6sFvWIi3y
	 v3qLHUPUV39zYqDHH+ppHK6HNTesKZ1wBl/5SU0HHShPgpbMx9GeqE1Kche2D3afuc7tu
	 MSYZp5QQ+9C6A7pJgs24EPkJxtVGXVagKtPHA+ygnPg232W1i+bY4McZCCDuVPVyI1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ygRLBaD3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793383904;
	bh=Sy8z+3KYAKuWn1IdezcRYWJzpQQl5Yo7OhbEvBmK1Q4=;
	h=Date:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FU7jO1cYpP1qavPN5wezNOQZOIPmtwSbGix/xa1qWU5WjjHPXC5F0DT/i0QwkNJI7
	 UFpzZVwfYoqT9Wrm3z2Ut22aOB1UFyp399muhGXSV5Zf20hVqlQrGl1pMo2xB+O+sw
	 kYmFbT2KfORw0IlO8oL2LpWnMqxWWKjkVZGkQ4FicaLTqlZC12ptBgnts6luYDIoXv
	 i95KypUygLrVhRB5FEMbn26aFagzFuE6a29uhyGCqp8ZqYO9InFKFp0V+S5C77QT7T
	 3HG1r2NQbSORKVIYOctMiAsKs04QnpVs8bbF8k0v8V5HpMdP31gqwuIfl3xS06a7io
	 4pccwYDsG71cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67BAB40B34;
	Fri, 30 Oct 2026 18:11:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48703235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A2EC40B38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rWKrKOodx6c7 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 18:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E8A640B34
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793383902;
 b=gZsuaw+BJKEzbezC16b2xMjx9vZB16b7GpBg1XMvxu5qXCFU3V1TWrvwnSNRP29v0ub+
 U92YyNn2ix9+X5odmHAY4J9GoyfcZI2O0c9Dv6OeIjJVWKppRe4TLwBrtBi9puvR+CVaN
 +RBRaKBkVxTzDA3GQNObasL+d/gNuDodB1pl010H+ZN8rAN5IuU8bAbR7yyA9pyjVytL0
 PbNKDKB4gviXf+j3ZefNx71hgF5aHo22Obe7C0jCmSUtVly86nHwEj8ycnl0scmMx2lzN
 lQKWsrpYV19tht8fQU8hEl7eeLvB+HAwy4KL7ZBZo6dzYjUR1K5cIZRy0Y/C7qt7PsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793383902;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:From:To:References:Content-Language:
 In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=Sy8z+3KYAKuWn1IdezcRYWJzpQQl5Yo7OhbEvBmK1Q4=;
 b=knw+Vr8id4C0ZC2wyiVnTXBXyHLPTFY6vPGfgtoccanzbTnGvi2uDHSQLnBt0K/pc3MG
 9TeFrIZKXAJ9jcMaBEDSzIDHYWeDjgRxoqD1X1GB1RSl1ztF37P3WZclr7f1ASGC+sAKU
 0imyzD7HhC9f6+JdYmKOfh0i8/Qs+NLFrkCjN8EWDSdAHsOwt9ugerVhe/WGTJCEUNYfY
 xAETY9Qj5AtQ96RIheWJe7KtF3GTIJPJD45Gweq7lum413fdHHtfehMLNBhxN9M2P+x1P
 67X/BpY1aDTeU6CXUdg3sqr5dVdl4OscoRfxYtqB/nW/N/sc0sDA2AO+KmyHmS/VaEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ygRLBaD3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ygRLBaD3
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E8A640B34
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:11:41 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so11725675e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793383900; x=1793988700;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sy8z+3KYAKuWn1IdezcRYWJzpQQl5Yo7OhbEvBmK1Q4=;
 b=ygRLBaD3wQoGKWHh00UWFgGEv3VHEBI1xgpmnryfGFbgopyHKbFZSiz1q1TFJFjAjg
 8X97vs9FL5NRrU0KwP8WUx6n8M/+GnIpFa+fY8gYgPgOeyGx0EgAGzZCSYxmOdgWBZeP
 zxzhmPz04lnHAqAda1nCW0Ab1U6UrLnYVEQvBM3rvs1fLBeSXSvZBg1eYXqqcaMeTJFF
 mFOFhIDa4TIhPaAOQUy9fNyi9jVbiAe1HU1GTDeMut0nxHDexQa0tXxnrSweNyiqxElI
 pdqbfUcv4dcOxUSrI42UaeTUSkixWeb8i2ZygQfM1r13L8zwCCUuB4BcFDIf1VYtGLvL
 NGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383900; x=1793988700;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sy8z+3KYAKuWn1IdezcRYWJzpQQl5Yo7OhbEvBmK1Q4=;
 b=OMD95WrKFJrXEnYEjdD+pRBZIPEGIub/idf0/kO09uQTkootovKbe3uzYZyo8wswmp
 /PE5t17mr5ZCWV0OWxTliQkyjsKhILbxm05ElxfvLyNs5FBK7A0V877xhYJT4PZIthP1
 37NyIFe2ensLf12M9sXy6rg6HXUEeo2UqF0dijkRuxHJnddcTfWxsZFCohQMgF6j6QKV
 m/MaRpvjM63NoKDAHRSZXKFzDOhX5e20hxfp7IEkwqAjsijy7qJtGiBk1s+grn/tWtOq
 XZ6G5GmbPd1OsId1hKTnEKWG5Ur9pyGPH/ovteyDjb8+50ksibllnK2QowtYqb9K8oA7
 NRPQ==
X-Gm-Message-State: AFq9FYKqpYimW2pbYRQLvywK5vUbUgvPJY9QufkenOpyOT3gpRQ4WSvt
 ywDHjiq3r8wXPOUVu4Ky8/oeKbbNVqVztBqG6SfvDMe+WWahGFF37G54TZmUlpylIJh2v6/fcHK
 ed7YIlv5gOA==
X-Gm-Gg: AYBFou0UvvBmbh3EyPYgO/V5vLCkMVPz27Ad8yxnZyB00U4YrgvFSIxxDUWjRqPR6j2
 Kxyxf1F4hTlAVCdzfUBzREXLazt67vpzfBaR9KP5DUNU5klnaG1FYVavuTxpBdUZXXN/ZYSfT5T
 lJjxxRKD65vzLx8bTqwvbNiUgkSfUBWluLbv2GIvQ/HOoIcYgVWqiy/fVZLSLGTrsfqLxPXxKTP
 7fS2Uyf4699q6a9jHW/nDlmiEPu3PJwWMI69pipMZ5kckoiySx4pPHQtlObLUFvbZB632l9UzQX
 7fg0e2XficpBl/APdBP8zT0SpqyF2bY/vYJzS9t8gDq6R5SDuNY6zbWJ4rDqohnzxGlxktJeAhi
 lKRXoc0Al8BpxmBUUXxpXTT9sEM4mcyEizUYykW+JC2GrjOzGdnaZXID1H04rdTHYF+8rTW+t1f
 S6faeml250JcKULXiXvLJy1RCyOq4npzSM7PJLi7dxySBUOL82eLYaKAFHoEkqxTZW8Q78mQGb9
 nelO1DRZwQvdwEdxF1D1F0k/GjO4f8V6q1kb8m2PwWerQEvF8kLq+a4tLT5xkHysxydZLfiLZ3W
 3btF3r8QPW9yZL5JgeH6zU2RVZiKTYVgGUuAIdGV8pNNWT6hsDKtkc9eXqrXKFheFx4NpbyO4iA
 lPndmkuapNeoSvsucHdLfEyGoDL2v
X-Received: by 2002:a05:600c:848c:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4ac1709b206mr75712665e9.17.1793383899549; 
 Fri, 30 Oct 2026 11:11:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e16:1f01:2c45:24ec:1847:8527?
 ([2a0a:ef40:e16:1f01:2c45:24ec:1847:8527])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm170612665e9.11.2026.10.30.11.11.38
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 11:11:38 -0700 (PDT)
Message-ID: <e5ce6ff6-2008-4f4c-bdef-b07725737f48@linaro.org>
Date: Fri, 30 Oct 2026 18:11:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: event_dump problem on recent OS.
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.u-boot-project.org
References: <9be46549-095b-45b5-a6fc-a527f1c7a0dc@linaro.org>
Content-Language: en-GB
In-Reply-To: <9be46549-095b-45b5-a6fc-a527f1c7a0dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 09:57, Andrew Goodbody wrote:
> I am running Debian 13 with binutils 2.44 and have come across a problem 
> with event_dump.py
> 
> With LTO enabled it fails like this:
> 
> $ ./scripts/event_dump.py ./build-sandbox_spl/u-boot
> Event type            Id                              Source location
> --------------------  ------------------------------ 
> ------------------------------
> EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           :?
> EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    :?
> EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         :?
> EVT_LAST_STAGE_INIT   efi_block_device_create         :?
> EVT_LAST_STAGE_INIT   install_smbios_table            :?
> EVT_MISC_INIT_F       sandbox_early_getopt_check build-sandbox_spl/../ 
> arch/sandbox/cpu/start.c:61
> EVT_TEST              h_adder_simple                  :?
> 
> So it cannot find any of the static functions. Adding back the __used 
> attribute does not seem to help.
> 
> With LTO disabled it works:
> 
> $ ./scripts/event_dump.py ./build-sandbox/u-boot
> Event type            Id                              Source location
> --------------------  ------------------------------ 
> ------------------------------
> EVT_FT_FIXUP          bootmeth_vbe_ft_fixup build-sandbox/../boot/ 
> vbe_request.c:152
> EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup build-sandbox/../ 
> boot/vbe_simple_os.c:53
> EVT_LAST_STAGE_INIT   alloc_write_acpi_tables build-sandbox/../lib/acpi/ 
> acpi_table.c:806
> EVT_LAST_STAGE_INIT   efi_block_device_create build-sandbox/../lib/ 
> efi_driver/efi_block_device.c:236
> EVT_LAST_STAGE_INIT   install_smbios_table build-sandbox/../lib/ 
> efi_loader/efi_smbios.c:59
> EVT_MISC_INIT_F       sandbox_early_getopt_check build-sandbox/../arch/ 
> sandbox/cpu/start.c:61
> EVT_TEST              h_adder_simple build-sandbox/../test/common/ 
> event.c:34
> 
> Andrew

Sorry, I see that this is a known problem and the test has been disabled 
for CI. I came across it running 'make qcheck' however.

Andrew
