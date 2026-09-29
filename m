Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129AACA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB50E60897;
	Tue, 29 Sep 2026 12:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkAmUbzWLiOO; Tue, 29 Sep 2026 12:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0491960857
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686369;
	b=TqmtfOGklkrR2Msacs1itohV9w85gDS9qG7X3RPT640xi06F8XbcXv0yEEJcWkd++zP6
	 Px+rXqmR6YrTl7lze4D7Cn6ehEdEhRXPK/XLxEV1RP7S6HTjaq+uhd7YMd7zsnPf2SQSy
	 0y2Yeu4IjHUnmkPD2Bpc8nPy9WRm4aLyEvsdCqSRYQ0rfA5TTnSve8KklplVWZA1N6YPW
	 zAWTLR257vBAPaPXht5j23nRlcNO/6xGHguXxX/i9cAVhl/AYre2fBC87UdcPAak3P4Ad
	 OSwSCMZnO6PV/PMq/s4Elhu6644hmbNb4y9gL4evVuPBe6xmhu8sPC3fmJKOoY4gerQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mMZ07IpvDXo9hmVAFKlaVSbxBgCDg9hv3vlgd9oYRoE=;
	b=RVIbzH068PiB0En0njXV3/V7bJDQHO6oieTR9uGW1rRHsgssfQQupdCS7gjjv7rL3U28
	 7gkwTdsTC/IIDTu1pgx5aL7j3AIhwqiFhjRKpZRJaUWoaQLv1tddxcP7m2dtHPFqmpJpW
	 1hHJ+bAqhssK7Ao5muKEsQFiWYg5NHgIL5rJ9kmoCDptngwQeCluG1ndxP2Ws/ihqt4/r
	 7g1p+/ca4yjuKIc5xqzdrlXdMVKhn9GZjBhdD62l7v73/KN69Fj8lDL1XBu/sfBqq9R9U
	 SkiGXT2PDfkD5WqBiXTChompMK9y0GV3NuAgMAkO7Qpg6N0STdpVexjAqAeP1Bq8Ipg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686369;
	bh=mMZ07IpvDXo9hmVAFKlaVSbxBgCDg9hv3vlgd9oYRoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yrCZb7mAVOhBuNZKK41B2E6wMZdgOyuw3/bAo8KHhXkJ0cW2tKOLjXNgvm6VYfLAZ
	 jrgO/xEtn5EqSGjZaasivhcWdEPHwAoo/PBKwat7XCngaJ83wN9eDYh38qr7NKBvvJ
	 tJT0p0Fa3tA4OYxX9+Nb3sJQPlnH6lIcjz7zSiquW4ahW69molLlTElQ5i22opnTAB
	 gremBJdD3f3rq9NSsht/FNCrguLt5qFjd5bRCUZevnsx/hUioolByDsMKm00jCbIu7
	 QE2Fy0wpPOZE+POZzW1MpolpQlmjfWkhxwFvxmNL69qhffsfMsCY7FWKDyPEG+2Ib6
	 GM9CWW3Dy/yUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0491960857;
	Tue, 29 Sep 2026 12:52:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D49D4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB0774027A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lA_hM8LL18sk for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A84AA400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790676446;
 b=NV48csuQpPU9RmWGquHZt8IIloDKi1zohCVV16gycPRM8R/FeDy7uOVCp4s3LmXDFy1R
 BQszsmHxe83O9QjGMJLBa5RgB237aPltiCBgu9dVnpC/VontGkim8naEG9YLj5/knvTBX
 Ioa0zYweqvPEtE66DJ3M/98UXSLuvE8vNqFY8SsJYZgQTtZX/kDjt6bvhFJ5BqKdGlR09
 9OJKE2DMoyJttIU5Er/eKbzHcWkn5mGlKIPkb7jgail3C2erykmFs2MHqdxbuCzyYdWo6
 yDfNk0Xbe9hVH4gygUnV7mgr2YWDp8v9ByTSNqcWPOnp4cysW2Gw2EhUMSYdkMN3vPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790676446;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=mMZ07IpvDXo9hmVAFKlaVSbxBgCDg9hv3vlgd9oYRoE=;
 b=G2ZwfUhDIO+vw2PqxfHB469l69O7WBafIprhR6s1cVjQFuREPScJwzSqL7fBzwzlrhAL
 a/lvyJvBPZ4rVCEd9aTbVNCUfxbPy6Bm9/6yQaLGerCrNJEwiXQ3w9gNqJtWyxSRF7dTq
 hhx2u9ApzIjnnt2PhE9cHMaHZ4OZLon55U8HbZaceFzgxtft6Jf1nM7StKVC7+EaYLvw4
 odOPvJGSH08oQC+ssOkJ8Z961C03sycCXtsbHE1LzjoZM5YDlZCvULW2TNvBjwqSkddrw
 fZ5rBtVk4YIEs7OCkDzpc1q1zuMYoi5zLq0o0KHCNRVrTJhQWZsDvMBP/UUj4106ecQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=x1JQ9YoK; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::d;
 helo=mail-ej2-x0d.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=x1JQ9YoK
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A84AA400A2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:07:24 +0000 (UTC)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e027a995eso330366b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676442; x=1791281242;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mMZ07IpvDXo9hmVAFKlaVSbxBgCDg9hv3vlgd9oYRoE=;
 b=x1JQ9YoKdJFupNB5EaHTCRUTRv75olfVyrQEzJf3tLnKpg/5Ijre3UZgPkBucQFwrZ
 EH2jz0KYejKCZJoHBzKm/qApatES9JatSOCafVqfnpjTYOicHNFqN+0yb97IoFuYrQqu
 yfrB39DwlB3QgcIVibIpJm4bBww383KRRW5HLaAvs75hk1TsHhYIMh5oeBBgt9TZWfl2
 HcBnuFDn/nzcczQtN1mttOzv1IlCfHGR1aOqVwbUn1jP0M7KdZFMw8U2Hcw+36p6SK97
 68Hg4gAM0OYfhUvd8TSg8kSxrp+F5OK9pDRUTmw93cPNaLj3+M6G8F3EKsTXffLXUElM
 dUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676442; x=1791281242;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMZ07IpvDXo9hmVAFKlaVSbxBgCDg9hv3vlgd9oYRoE=;
 b=kRx3P260yLvlAk4vGHd5C3WMz8kHy+iaba6P7u7X26WZekEQrAcrSt9epF7Z0G5nWZ
 1isxxgCHbeIhiJWYLouCm6ZKLbwNgHTuN5eQGcMC0nn3rMhPXo4SOLxI2kGXFCcnSC3I
 CXAJsjFywORkw/RtIuDJO6QCPau5FfXVmfJfciPZkCTmzTqlqgv1oRAlbw8ViiDcPJ1l
 drzEsJJIeWXzffWkLEwhrL3l4ipzTYMKR2Horu+5IuGJL30MqZTSg3gyHmr8woM1IwbX
 9yjdoXcD7uqEhIio6ka8qa3hOxr4lftjXPcqhXnX8Dw9XMETCoCJRoDt0StAq7Q9rOXz
 7uEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIs+oxUAE2kE0hq821f4KWBl1qhKftd7YtVSYlytwzU1XtWgXC+8yqYUEqMFeZfmu5FHYZQVs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kA7tTMVRPPxnrRDMs3h2ThB9i8exlW5y7873vGMonarb9ZR57h
 iZVWMHg7X94HPupFAgCJFBl7vTy3MGqKqczEy1XCc24/QN86lGY+uA2iXWEmrXw3grY=
X-Gm-Gg: AYBFou279onJZ2hb17aAdvXjLu1U3zI9K2GaGn1hYWTLoRBbBYSqayj4UsC3SOdQzKx
 Vr+/B30QfiKQeCiblLiejdU3TD8MnRxFfptp2EkgQyUrmHmtjwsdzvhyx0d7fsb35i9pfL4In3E
 ZDn7rhnSpDzjsnn74Q48cENGDuyZoU9WhUI67geOX9PfmZIa1hYdUOBDgt6nRotaCAej7w1+0bp
 ti2BpFGu8HApxlNXzfK9p/g/e2dGFyZUG+4rlULKEieYJZQjEG+U2s7YlKwvg1zgkpD9hC7OWYc
 odx1AMNGnm/mEtKW1IABPi1owVie1LLZN0gCvTLgb3UooVhX7Ztfu4C7BzJWyOfFqaTiAWLLd3Q
 UseNu4Wq/nf5Fds97chog+ioCuRQDLcSvJ85dNFlXtvNuq+wDnowdoqooOcCnMkM0ZHxO0PJJDW
 Mi1F/V6fCL6LX2XqzQAfh+uumCwdoFkP30dxXsneqp357Cu6adajMc7N0ieiTvBrBckrGP8oFYd
 0hLtL//A4BXcniHv4ki0DJNyWy4vLR9Yh6bu0VciA==
X-Received: by 2002:a17:906:8459:b0:c2d:bbae:703b with SMTP id
 a640c23a62f3a-c2dbbae78cfmr524572366b.2.1790676442462; 
 Tue, 29 Sep 2026 03:07:22 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dbd380636sm423072066b.66.2026.09.29.03.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:07:22 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:07:20 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.u-boot-project.org,
 marek.vasut@mailbox.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com, c-vankar@ti.com
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
Message-ID: <aruN2OLSSnntkyrn@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <178964898806.1279633.17593305863869822172.b4-review@b4>
 <arZF61eAp54rQyrT@monster>
 <4ca2f00c-9083-4d0e-be76-1465042849ae@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ca2f00c-9083-4d0e-be76-1465042849ae@ti.com>
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:04 +0000
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

On 2026-09-25 16:09, Siddharth Vadapalli wrote:

[...]

> I didn't see "unknown endpoint event 0" at that point, so this series seems
> to introduce a regression.

Hi Siddharth,

Thanks for looking. But that line can not show up on mainline.
dwc3_ep0_interrupt() has no default case there, so an event 0 on ep0
is dropped and nothing is printed. The dev_err() came with the resync
from Linux. So your logs do not tell us if the event is new.

To know if it is a regression we need the same print on both. Can you
run ums on AM62p twice, once on plain master and once with my series,
and send me what it prints?

On plain master:

  --- a/drivers/usb/dwc3/ep0.c
  +++ b/drivers/usb/dwc3/ep0.c
  @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
   	case DWC3_DEPEVT_EPCMDCMPLT:
   		break;
  +	default:
  +		printf("unknown ep0 event %d raw %08x\n",
  +		       event->endpoint_event, *(const u32 *)event);
  +		break;
   	}
   }

With my series:

  --- a/drivers/usb/dwc3/ep0.c
  +++ b/drivers/usb/dwc3/ep0.c
  @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
   	default:
   		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
  +		printf("unknown ep0 event %d raw %08x\n",
  +		       event->endpoint_event, *(const u32 *)event);
   		break;
   	}

If it shows up on master too then it is older than the series, and I can
look at it separately. If master is clean, then I broke it and it has
to be fixed in this series.

If it is easier for you, I can also do it myself with remote access
to an AM62p. Then I need the serial console and a way to power cycle
the board and load my own U-Boot. I also need the host that the USB
port is connected to, so I can run ums.

Cheers,
Anders
