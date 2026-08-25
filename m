Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94798C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 21:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F11E280C45;
	Tue, 25 Aug 2026 21:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3e_5t5pGzQz; Tue, 25 Aug 2026 21:41:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787694117;
	bh=H2hcDDIswcUO7mz/VsNlhVlp943MNsImrpDgWB4FEo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nyj3MXPkb7e4Z3uUsYCxdqbT4sXQGG064QZ8v9BFn0GBWyRj74fBBluRuSRdk5KnF
	 MuHjYGbECbfFTTfKSdtf/IgM8fH0zVAW8m7KjT19dn1kYV6AnHJzKoVMRCCTlVfFmL
	 nBzdg0rxJZ80sP9pjwNE0yJEcq2aPC5Yw7jgXq8gga2i5nHvdUOeXGVfORuvZWpbjy
	 udpG3JRDiGPseq4cAuLGMhEyPunGIt6TR4qovIh/E32CYlMFmXJBYg2zoxK6ScePM1
	 JmvYmMPvTrip6RBfwBeYGJXxunA3MdVdEEOItKWlv/5EQxF4h8QOOxhQAymXEJAQE4
	 J0omEIhv6K4Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6FD080C36;
	Tue, 25 Aug 2026 21:41:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52D3A105
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 410944008B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZpGyhKPcXIqO for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 21:41:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=egYWYl0D
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1137440055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:41:53 +0000 (UTC)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9F9A83FC0D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787694110;
 bh=H2hcDDIswcUO7mz/VsNlhVlp943MNsImrpDgWB4FEo0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=egYWYl0Dr21FHMNOzp7MKy87TraZ7BwLBMA9VSNENXp3siPio2tJXkS57oo3p+Rsa
 Awv+3HwzDXlexk/k6RJGHi9oOrwvphEsX+HOu4lZnB/uW0M7qbpwSpoLQnE5sCZKbt
 Bjtu6pfQdxCJKimYu9myMu97sZS7WT2txxFJm7RdFois0wB+AdsVKQRlqIAOimrO70
 MIQk6M1SyXP8MAIbukDHnYLvRpockq682j5Av6v0DmFOph4nCEmEd1KXVDjJltXn7c
 Dcx8HblNsK1O9Z7sqE+hMw/ZTyr3zbexphsN0lsXbJNeO5px/R+NUg4VIy5EqlE2ex
 qVgnXE91wz9oOlucbjztkwYJktvuBWp58bk3PDaQAX1d9sSLjoUqBCCUVY6Zd7E+ga
 dd/ZXJxvb8zjz5tXkEmamxsqf+DFmmOHSENR7T8ulz0iFCMn+AFY844CnAm0S93do/
 2IjXjSyw5UNpM+5X1Uu6iW3lvDq41bltDam4wCShZOh+bD/7znr76rpNtaOSRf/fpv
 NumTdnogT4NABexK4hSppZJLtTjW0wE+1Wa/mTFoEa+gJinrcDnq++5gML3op/BAmG
 QIG6DgCTGzONORckNDPGNEqa7kSMW68SXupKbeRJg/gDPMyw/tRkFpsNS08lP5/KMA
 oU/geythm8boplaHbNAxT4VI=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c11f2b9f62fso10288866b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694110; x=1788298910;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H2hcDDIswcUO7mz/VsNlhVlp943MNsImrpDgWB4FEo0=;
 b=A5iOtCIOub+wrv8VXyssMOUbvQNHy2RSQ9cAeZYd1Br7BJOtbjgxxxuwsS2lGC+DQj
 mZHm9/ZkTLnRJAa84sWlepfQzNyVtVJU90i6OOTMjyXSKmsYpdWUBM11bW3mzmQhfC10
 YKtB2iwJao3FmKntLKPvxZC7AmDW+BwpTC2EqrtYVsV+3tR0QlLZ13gWjbAnqKC5/N9s
 z4elr4ri8kO2zR6mwvXv2PSYcKkinPIpwsAFceLoOf7AV+gk6VRvabwNPF83WPoPM/gn
 U7z6x8j9+4OCmy0dk8+tT1dIS2rkt4gbZUUcxdiN8QRH+JxXtw89sKfpqDHz7YW1MjtX
 OMuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RptELJ2HaOsP8Us3ZPg0CvXnRrlkA0srE4eZuW7zYPZ9/+50kLvb5Tu45R63r4zeIKpexYZozo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mb2x3sfbMRNoplZa1ydbnKnzI92R+DJkWsR4WwrJTcj8RoAvOQ
 Kxcx6zdd6WnsRZ6/nNE40jC3rUYukJD43U7xNkHepcfLIV0vl3ruZxiN0QxwheUgd0AuMABPy+r
 lbm/cGoDH3r4Qef1xWdKiwzQCkiLtPg7Z1qG4KAdJLKNRfeVf0srtezaHqBDO8PAOV/n3Y3uab0
 P0IVfd+5sM0A==
X-Gm-Gg: AR+sD13dKjdo+6St/fob7WDl3m/Q+C+YeYbThGOzOCFTswgWMPE9cy709BAohAUZadv
 6H4uaxFnScr0S53R0vdUd1xHWu6QQ+Ga7YWuRACJ4j9WkFj9HADBJzaBUjJxoPr4E7krmyvZnps
 I4iV0TFN4lSQFVPKZTbcb9k/mB9KmII9nM+i+IVap/9x6Vb870raTMbzOAHOGfd4VQ8b3h8l98C
 Kgm+Ixv5nN+B0fI+wF/hsz8NCdPNEZDEij0a5e90ApMuKjxxK3oLkbldxYVsFkTTaICBzD0VGuX
 ERMYPcgDEJPm0FTLoeWnUSe+dNCbnZobeFQn0C/NuMJeIoLXt3clW3qTLknbSoSLtoHQixp1cv1
 mYNsRpfl+mMkBMHqBGX9ZEm4BH2GtiQM3ckGzWXdji+KEuOY9oEBZ8Yd3uZ2SixFFC5AsXqFXMY
 HYwMApGSux7jmJ+4VH9Rbz
X-Received: by 2002:a17:907:84e:b0:c24:c24f:e176 with SMTP id
 a640c23a62f3a-c250bc30e7fmr203114366b.15.1787694110227; 
 Tue, 25 Aug 2026 14:41:50 -0700 (PDT)
X-Received: by 2002:a17:907:84e:b0:c24:c24f:e176 with SMTP id
 a640c23a62f3a-c250bc30e7fmr203108666b.15.1787694109802; 
 Tue, 25 Aug 2026 14:41:49 -0700 (PDT)
Received: from ?IPV6:2a02:3035:667:9a84:7c86:797a:e54:8957?
 ([2a02:3035:667:9a84:7c86:797a:e54:8957])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b43absm138139966b.51.2026.08.25.14.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:41:48 -0700 (PDT)
Message-ID: <92d57391-aa91-4900-b36b-dea5b85e9694@canonical.com>
Date: Tue, 25 Aug 2026 23:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass
 <sjg@chromium.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 7/31/26 14:40, Alexey Charkov wrote:
> Unlike every other test in this file, test_gpt_write_part_type() never
> binds the disk image it operates on. It has worked since it was added
> only because some test that ran before it left host 0 bound to the
> image this fixture provides.
> 
> That breaks as soon as a test which binds something else is added
> above it, and it means the test silently depends on collection order
> rather than on its own fixture. Bind the image like the other tests do.
> 
> Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   test/py/tests/test_gpt.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> index e6d8792ac1fc..fb4c8ba67d48 100644
> --- a/test/py/tests/test_gpt.py
> +++ b/test/py/tests/test_gpt.py
> @@ -338,6 +338,7 @@ def test_gpt_write(state_disk_image, ubman):
>   def test_gpt_write_part_type(state_disk_image, ubman):
>       """Test the gpt command with part type uuid."""
>   
> +    ubman.run_command('host bind 0 ' + state_disk_image.path)

The "0" in the `host bind 0` command is not the device number but a 
label. If a prior `host bind` command used a different label your device 
"0" may not have device number 0 as assumed below.

Here is an example:

=> host bind 1 ../sandbox.img
=> host bind 0 ../sandbox.img
=> host info
dev       blocks  blksz label           path
   0       131072    512 1               ../sandbox.img
   1       131072    512 0               ../sandbox.img

Each test that uses host bind should unbind the device at the end of the 
test. This also applies to test_gpt_write_part_type().

For reliable testing we need a host sub-command that writes the 
device-number (dev_seq(dev)) for a label to a variable. We should extend 
the `host info` command for this purpose:

[PATCH 1/1] cmd/host: allow to retrieve sequence number for label
https://lists.u-boot-project.org/pipermail/u-boot/2026-August/629880.html

Best regards

Heinrich

>       output = ubman.run_command('gpt write host 0 "name=part1,type=data,size=1M;name=part2,size=512K,type=system;name=part3,size=65536,type=u-boot-env;name=part4,size=65536,type=375a56f7-d6c9-4e81-b5f0-09d41ca89efe;name=part5,size=-,type=linux"')
>       assert 'Writing GPT: success!' in output
>       output = ubman.run_command('part list host 0')
> 

