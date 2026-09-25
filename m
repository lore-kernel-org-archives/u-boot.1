Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B2FC9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 12:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95AC6812BA;
	Fri, 25 Sep 2026 12:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqfjeW6o01H5; Fri, 25 Sep 2026 12:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C524812A7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790338319;
	b=krg/daJ4k8phdDNGGp4e/wV9vzoBhzEcZ9Hz9zvvtMU1wyo4ESqm3hu5pzO5BJn+CzmY
	 CNGjUmGaHVifitvwPrR1YOKYseRyZBOhMmme5vRBy93wXDNOO0rN80M1eBTHvTIHFd8ow
	 /DenrLwvXYbHdbRi0M7SJhIYHLA2Y/8ffCcBTAzvVL1B6pGXnav4En2WLdXh5SRNSb8s+
	 r4AP0pa+WM6/CC6J6tRWBZ3i1nyaUfTAqk+R7CabWbosC2Wg/u93egwBDIp4xeFiEOmpB
	 cLGZhlb7eKD+ujzh+jSUS9TcxR7Lf8mWgDx7RiTTuOx1ueldOiyxcrKJTGHp8CWAbGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790338319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UTR3UNHYiuSdQX8tB/pzkx7+px48dp4+j6qhlvYGftQ=;
	b=FkXQI5YwmI+GK2cYzkLIg7NRCZFDxUUkeEfecmb3MnzoJK0hFfFAHxhAKx1CAB5vClLM
	 JpTPbauvj4ulLZyhm+/mq8omIX2jR8bp2Tncdjo8ZlmcABCbQcOnBMeNg383BjwKeG9AC
	 OUbm+4W75k0G0kBwr4R2Njz8DKXH2ybZ1b9w4TCZumFfliQcX0XFEGvao2KlLDYNoaYxf
	 xR6tREUXuQBg+hdarX35KsQRzWU90AJb54hJQ+BnwCnHBQV3Sv3M6VUveMG56v+AF99Nr
	 +l3ELEUQlKe5FNehNq7nNgf3OlQ9Vb5/Pps40RNXY8h16iYnK/0sACzUPWkM4ta0/3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790338319;
	bh=UTR3UNHYiuSdQX8tB/pzkx7+px48dp4+j6qhlvYGftQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8NAHHkOtTsib++tPSN3eR12r03imBDTyY/IXmQGPx/sF1KjpQi35mV/BDCLidtyb
	 B0bzBAAxJ0T6jpN/4iG4Y2tThp3YhMTNhgBFvScVCrGw4cUwgMRwVbyfVmhkj0mVx/
	 nDotU0uUYxsz6uIVDY1uSQbRB+EXRD+Uj4EO4f84VXxAPWdL7OanDoSwk/S58Kxhmh
	 zyb+gHbC2xh6Nv8r4cDCMun4MMjd5t8zQjaG6W+4OC6tLYvdKZf4pVJfFGh9OecJ84
	 h9tvvBoFv7fpQON9U3VezFPUwwJQcZTF2Yaj+pY+ENaZtImb00M1y35ivqKkHG3iYy
	 eOFsPrySnwXQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C524812A7;
	Fri, 25 Sep 2026 12:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 079B52F5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED96C60BB2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HH1fB0U2nDR7 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 09:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7738660BA7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790330354;
 b=A5NiyKtk71HGhEEgSQJxKuu6o52cPbLbI6LnOCQ1u3N1r2KdF8JLAwvNkGM2n5b/Ugzg
 EFHOBDIftBlfF7zbChGsxeKsALRKPGVis7jXoLfDb7FJd7dw054lFxVEzv1nsUnB337Wb
 qOO7XrfHD4hw+PI17WyghdFMOOr3IMzQP7EAlMDIGoZ7k9K49qmq/a2rT++WrqWATxjZm
 dys+KHgFwNdKBCC232pl0rexZaYYxrr9M+fafhL37VIg/Ob2BsrMM1dLjGd/4u7BnhNHQ
 cU18S/1BfateVavKqHcOizHIwF7WjqB5bWKom5kzRDEx8fM2vCq36RS2SPytMN6XXMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790330354;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=UTR3UNHYiuSdQX8tB/pzkx7+px48dp4+j6qhlvYGftQ=;
 b=NijbvioIj0LkuHSHlfxBK7jG6xjSqN7EUULkiAD6Sh4Z3kfFUXHGtLr2xsTmsHpqfFRL
 w0SUNTSkbmeBgksXci9OlP34hJUu3WiIiKktpMqbycERx9dOGFMJVX4tcvodMlWCQ+nZC
 pEn17fWWkdlu3ZfKOfp3H32Wd6Y/EGE5BDqJpb0VdHsIo9y2U8AhDkHVeXJdgJo9due0q
 I3qaaWUd3CTpjzN79SnYobJdhN1Deh9MP5NP0cNmC1mwt6U/bvEG77lBKBKxP14nCzTQ0
 DXwmyoGDorRR462mhcfHFy7BdZtoQicY3FFMJPqk3411IYv/bEMolBkUzl9Am3TAsWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OaMn4JMa; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OaMn4JMa
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7738660BA7
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:59:12 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf2dd01d2so25884a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790330351; x=1790935151;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UTR3UNHYiuSdQX8tB/pzkx7+px48dp4+j6qhlvYGftQ=;
 b=OaMn4JMapTZ38jqUvGaEUZI3p+6hFiKpf58TK7cyFu3zwe8S2dPQf0g9ddNgrVi1un
 xU18KyflPsYldLL3snEybU6vpplngZjukvmUNUKSyG5ZW3vZyspLlcji4DKiqTCYasu2
 TWKYiuaS6MhtyNiuAl+RCs1vZwV8UO6O0HMp+JdkfVymCUHXwgfyWRVIHbR0kOp/WXDe
 kl1xdPTdFQVmJ9asuiBMvpn3hqHERRaJKVnSMdki66lorm0nGmM17H7ELna4hH6AIakF
 uEPxgE4Ob4mAZdHtkSqSu82AqZEJNHTJYjpro7OaMX2g3VIX/f8dGGvhA1doIsInRZ7V
 4EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790330351; x=1790935151;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UTR3UNHYiuSdQX8tB/pzkx7+px48dp4+j6qhlvYGftQ=;
 b=V5ka2n4p4DACEKeqH4358M4lh+TAPKKGnUNI/hwi7n8slDgfWd9BE8AW58mEkaAt8L
 YZq4kVt5htU+RU+NqfiihhkZMpOEGELD80uUOVNXEZPKmSaTlr7LIOhCNoWAwcAJ6Iws
 cbZeoV+VY3iBr5er56hLXkwvMUoYPf/B8RNpdEpsV7KsaYbAb0BGnZWTGi1ztRrDIfre
 TcV0PRhOBTSNSPX67zB5HGwlEf257Mg4c4q4H7fQSlnM0337DMqGpL1m4HeWkgUTfcgF
 Nl2zZNFFxRVU/1jtNERJ7cxrSsXuS5BUML65c8ozIDxDdcgYKi8XchvhbyfgoEX6GIrM
 gatQ==
X-Gm-Message-State: AFuF++kpCT2lDJhgKMisjcMcJ4jsCh4CUc9laTGfRhVgSnbA4UoHA44A
 aNryAWgjQU4ETFQX5NrzQtKcMhlmnlWuosx8WqTpGZTyI1RrxBhuQQF2NxiuLL8IyR4=
X-Gm-Gg: AYBFou0njE8gp1Y3MEqTLdmuysUylqWiUybOyX/Xdo2NWuUL9Xs8m8W1omADVMiiS9I
 wc/mCGF361uSOzaCHZqIulygALaFGz6yljfuEDJvjlBnKMdyuWPbsvDsKQOqsH/tmSnC6vMajLh
 sbA9PmPvEoZwkSRSq/lA3Iu3XwmUOUvqV3qmk12a05Tq4ORwKYvT07Yc1syl5Omlb9aOd8vS26M
 2d4E9T6XYgof5lTq9cx5AsX5QGHF2yqge6ET9MdB7EaVaWc9V5StWnczTyCIZCjnn4Ityo6oBpm
 nzyVLkonJijkERh2PX7KCO+luAxyZ8n/tS1rzFuTJjLjP7bFuQAwNRVjC+PCiZIZ2YQtj5jJjln
 sLdQhh4+M1oZjSgEJtZp1L3LHJc6mdmaHUNteera3eQVRrwKOSZr1pz74AJhvzCHOvxFrHirZFB
 5T+SEaIan+qElHSKazRE5duB0+7BPOwmaR9HCtQnPMTdC5fAPViaBYYY7664/MykbRr/+gXmLqb
 +hWRN1hn2gTh+0tgaS+fO5/t/Dgy5I=
X-Received: by 2002:a17:907:3f17:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c2ac234ac2cmr496270066b.3.1790330350562; 
 Fri, 25 Sep 2026 02:59:10 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aae5dd78e1sm798862a12.18.2026.09.25.02.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:59:09 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:59:07 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, c-vankar@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
Message-ID: <arZF61eAp54rQyrT@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <178964898806.1279633.17593305863869822172.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178964898806.1279633.17593305863869822172.b4-review@b4>
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:11:56 +0000
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

On 2026-09-17 18:13, Anshul Dalal wrote:
> On Wed, 16 Sep 2026 14:38:00 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> > [...]
> > ums. Love tested v7 on AMD/Xilinx boards. The rest is build tested only.
> > 
> > One thing is still open. Anshul sees a single "unknown endpoint event 0"
> > line on AM62p during enumeration. It is there with and without the cache
> > patch, and the transfers work anyway. I do not see it on X15, and we do
> > not know yet if it is older than this series.
> 
> The transfers work regardless, if it helps the issue seems to be in the ep0.c
> file.
> 
> CC + Chintan, Siddharth

Hi Anshul,

Thanks. That is what I would expect. If the whole event word is 0 it
decodes as endpoint 0 with event 0, and then it ends up in the default
case in dwc3_ep0_interrupt(). So it does not tell us where the 0 comes
from yet.

I think my two questions from the earlier mail [1] got lost:

1. Do you see it on plain mainline, without my patches? If it is there
   too then the resync did not cause it, and it can be fixed on its own.
   If mainline is clean then I broke it, and then it has to be fixed in
   this series.

2. Can you print the raw word and send me what it says? If it is
   00000000 we read an empty slot. If other bits are set it is a real
   event, and we decode it wrong.

  --- a/drivers/usb/dwc3/gadget.c
  +++ b/drivers/usb/dwc3/gadget.c
  @@ static void dwc3_process_event_entry(struct dwc3 *dwc,
   		const union dwc3_event *event)
   {
  +	printf("evt raw %08x\n", event->raw);
  +
   	if (!event->type.is_devspec)

Chintan, Siddharth, if one of you has an AM62p or a BeaglePlay, the
answer to 1. is the one I need most.


Cheers,
Anders
[1] https://lore.kernel.org/u-boot/apF-Y29Nk1g0WkUI@monster/
