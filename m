Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8974BCA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F50E60B3C;
	Wed, 30 Sep 2026 13:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DPVGtbbQJ8sp; Wed, 30 Sep 2026 13:07:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ED5FC60B2D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790773663;
	b=CF0iHfaK91oXwy2AOrQmvwsTMEe18vus5jE4XwYo6iUg1kBbIYHZWWCFQiexh6ZlaiQk
	 KMbdgiuESQsLCCCRvELIeGrRVojGC+M5qaquKvwCUErbUTJtxFjW5ZFn9GfcJQXG+Ipfl
	 RrQ6p+z3lgANuZI9bYtLt81lWP3i2Cy8hcOifhheaIobopmyGmwc5cWgj5OkVXj5W946Y
	 ZplxP7ZhL2jkkw5u3uDbE9arC9mhhy0qXJwUOC9+4nfFHEPx6eNfi7Qiov05Srwl7leyF
	 lB4HYoIrylhdrUnibtOvULFacRm7XFVqnrUzuLWbOB+15VZA9qzS6f4mn+rhWw/176Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790773663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F10GX2I4BirFjGNFw/zSiSdKdMmfJT945J7K3bBtM8Y=;
	b=NP1LfiX0iYXqA+wNpvxfnzeQiCnRZNDm7hG/BciuFh7fM6SCHnRP37K8XlRl+IMi8D2i
	 ojeCobA/b1xXURCuHVBrk9mU/SD5564C2M4BiEjQRvmwgWBwDrtN0nZIt46z+bNi7hyNj
	 1/eElM4+E6X2JjLjmSjTULmEhH82cv82W2rnwZLj7lkAs4qor8JWkc2FZZ4NgXS+vIB3I
	 gb27hldUvC9ocvTLk5QIskbTgPM7zDqIhRGFv/ekEIEbCE8Yiln+yQlUpnAb5PMkD5Kiw
	 6KvjdwlrPFwFzekqRWn2HrjbeYY4kYOPFIJZTwQ+YOZ0BLjh7J4wuHpY5IwJ0Oeszsg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=okeI60dc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790773663;
	bh=F10GX2I4BirFjGNFw/zSiSdKdMmfJT945J7K3bBtM8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ttz5zJlqXCiYR+LgdpWyoSn9SOCL37P7vB5QIEDJqeHflq4lKd0vScInQ51rJHiDk
	 RVISdkboPXx8KhECPsi8MOQKn/VD3EWCvpB074+RJLm3qN1QfIKxgctSN8dS79Xr+r
	 MJ8bMSUTP4zdzECcMUNvOydIMJ0QkrejMbI1tU+6n+LNgHNqW5ClJkNvDSg51g6yBr
	 bkA/ER2RZpP0AsKX+g5pr9YHQ2IPRP6FfiZRI6DpUoMfFzV/uWrnv/Ubr2OKEHh0kF
	 VK8pqDM07FIMMm7VvoOgrgz7IT2ZOGwdGhBGZJjOEC5T7Rn+pMWJUvju8RodXHTm6x
	 ZjUYZMB1KMh6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED5FC60B2D;
	Wed, 30 Sep 2026 13:07:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E5B033B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E875D608E2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCjeBY391iBO for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9705A608A8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790770226;
 b=p9WvN6gXtkCK4XvlJbdnWGRnqJdSJJc0VL4pQloFpTOFMo4ak888mlz/tTtKc/oFbM3a
 UGdSMXpxeNEpvBhZ7XFgrlWmmwyVWmkJpoYwjxYWDWXXLq6cyvOZZF+CJM0jLmKJzvwby
 7geZk8MWPDZG3RrRA0+LTxGVz7GeiPkI/i0G4qoto9v/CHjdoyysgdZvNCIGnL7V2TZ2m
 UvxmNwnPHUV/ELYdIp6ebEoOsT3CCP5AXfEW87WMhe4JDG65YXld6at+7QYK7HSze9dsa
 uIteqJunIkou2rhSBcFdvi+Bwf/vOUtBR42ckA8HEEB4DkTliUrWblReWgOjigMerrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790770226;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=F10GX2I4BirFjGNFw/zSiSdKdMmfJT945J7K3bBtM8Y=;
 b=gZwQKNVobv9i3ec5GklbIcLpqw+VqbDvrsomyEWhrgzrI66eI4iNrq/VM1ZCfeBUqIh5
 cuhrKRWt+cYMLI7mgRUMA1K+eqL5icrcMoY1nO4V0Tvk+QBf5+J1tGA8Oq+fITQRxPR3p
 FYOQXpMvXLnokpQTjVG9Sx1Cab9FTwTi8quszDP8F0pT9LBxpndFJnIBY43xkb9D0Jkwz
 yW5MNSlY9YwwPHFuPgIZl7wI+mBKRbptR/frPUgrUrOQ/IS9PBFaEVwfbrUNbCc1E0Iuj
 ikozbl6YFrNg1zs1ekOJxbM2fEktkWD6sVSd4Rv0HShvrqZowjkOkWdxYq85Ywti1cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=okeI60dc; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::d;
 helo=mail-ej2-x0d.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=okeI60dc
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9705A608A8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:10:24 +0000 (UTC)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e089965a9so12935166b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790770223; x=1791375023;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F10GX2I4BirFjGNFw/zSiSdKdMmfJT945J7K3bBtM8Y=;
 b=okeI60dcMUIvvZ2XJWf5RYnrValRubmSybyo/lacdieq+n790dL+f59f9FeAn/prsx
 4EPmklSCZ2mDeeMgxSV5baTZuo1S/h08qwrAbB2oNwFZElstr0eQiQBWOGADJgi44RTJ
 W3vvoMXfbmpoWI+WlcUuSMjIY7WDcyi/WZ3DF2UM4VzGNrjsikKN3huJaPUcXyLt8a6A
 w0LPGbEHUKEGTYtkH8cMXCWdeLKC3UX723eF8StrChvI8Y7rJXJEVYPb1kfjMBPu/5LR
 au7pH0g1VLZxvpk4winSReHCecRGdT0nvvuZqz3zKqw4rAQOBoMNOR9NJIhJ0X1OFaxu
 dsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790770223; x=1791375023;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F10GX2I4BirFjGNFw/zSiSdKdMmfJT945J7K3bBtM8Y=;
 b=YpoF0yAsqhYCCWKFES07GdxONwEcQjklkh7V5BYsltiUe9n0hHpLNglKo8CN4jmgK2
 cd7IERW20HPbUrhT5Lk7i3xCLPQggOsaQROvFcVkYWOlI7ABXt8k4QQVDZEF2nSlpzo8
 tC6TESOwYHI4Z/D4296SBp9lnWbZzyHJn7QHkGPFWboAiVx9tTU65s1O3Xw1QCmguRDs
 QOkp/KU+T47VSnvnU5uq3ut8PNM1b2Q+ie9LjnQao879aZLOiMIQi2BqQlo5iAaApNAQ
 B0cIkyqjp0dfieBFwfBnFNMdzw0eN4zol1PmXyen8FQFc5fDwjq2W/5bxlvk3JsL3T56
 PCMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZbbjgoY2fzH504A7gsMIpe4dxykU58+Xp8hObJTBI52dm9pl1bn1t6fgE8bn9jvxHo6spKwE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kt5r24P/HpuqAH+OZl3chvPG5HPIMNBRgqJJybw1dvg5+m3g6C
 qpgQ7Ui8INzoGbNz0dbcULJxeHJPmC28jFzfUAwTV1vb7zLOiwuq1pkLhobjps0LJdLfhPJHFAf
 asbmZ
X-Gm-Gg: AYBFou0pXSCri0H4chDysF4XLBLriQ83PYveRG2GL45hP1YrFdXRZRJoH1ATPBxMy3m
 iu1MTtSLzR2f/LI9UwciLeP5qsutXqurkoznL3TSuijMWVA1KrUavU+ewkWJX9MDBFIIfxS+KLm
 SY+6M9OP1XTs8oyrj+pDnnOULRtMhp2rkhw4Fr6Li1d6VITSMmxIRQXDp5VXB//ImiT0qMOcmu4
 7to1PkzJM61m38lCPiRk3EpPqmuiYGQKryGNBlrPeWIobsnnmYV0y42OWDAtYlzzg2895N2eH6e
 rGkTDj8OBt+fvZ7wkvNqoFcd2wCMNs0TRlXPyZIUn4kvLYSnauoV9dVE/65aATas8LaFTsXZdCm
 Kv9JaZvT3xWG5G0L6xUWaWbK2POMNd1+bR+v4weaJZ/TWCrnISYXWe/apFt7qdfXpYiFbrhPC39
 MbLH4fkxtipMDyWYjzSSB2etp5eU9Dl7DQP+CjlaZeUhOQww3Jk3mh2+nOfYFp31PnL2iI0QYy4
 hpDLQXTBwaBzf/w+U/xxOhKevRlTLA=
X-Received: by 2002:a17:907:6095:b0:c2d:bbae:703b with SMTP id
 a640c23a62f3a-c2e23ca5acbmr103355266b.2.1790770222745; 
 Wed, 30 Sep 2026 05:10:22 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e22fce6e6sm54576666b.71.2026.09.30.05.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:10:22 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:10:19 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.u-boot-project.org,
 marek.vasut@mailbox.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com, c-vankar@ti.com
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
Message-ID: <arz8K_Eg8gzLPrjj@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <178964898806.1279633.17593305863869822172.b4-review@b4>
 <arZF61eAp54rQyrT@monster>
 <4ca2f00c-9083-4d0e-be76-1465042849ae@ti.com>
 <aruN2OLSSnntkyrn@monster>
 <184e99fc-4c03-49e9-a1b7-7d701dc99142@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <184e99fc-4c03-49e9-a1b7-7d701dc99142@ti.com>
X-Mailman-Approved-At: Wed, 30 Sep 2026 13:07:38 +0000
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

On 2026-09-29 18:35, Siddharth Vadapalli wrote:
> On 9/29/26 3:37 PM, Anders Roxell wrote:
> > On 2026-09-25 16:09, Siddharth Vadapalli wrote:
> > 
> > [...]
> > 
> > > I didn't see "unknown endpoint event 0" at that point, so this series seems
> > > to introduce a regression.
> > 
> > Hi Siddharth,
> > 
> > Thanks for looking. But that line can not show up on mainline.
> > dwc3_ep0_interrupt() has no default case there, so an event 0 on ep0
> > is dropped and nothing is printed. The dev_err() came with the resync
> > from Linux. So your logs do not tell us if the event is new.
> > 
> > To know if it is a regression we need the same print on both. Can you
> > run ums on AM62p twice, once on plain master and once with my series,
> > and send me what it prints?
> > 
> > On plain master:
> > 
> >    --- a/drivers/usb/dwc3/ep0.c
> >    +++ b/drivers/usb/dwc3/ep0.c
> >    @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
> >     	case DWC3_DEPEVT_EPCMDCMPLT:
> >     		break;
> >    +	default:
> >    +		printf("unknown ep0 event %d raw %08x\n",
> >    +		       event->endpoint_event, *(const u32 *)event);
> >    +		break;
> >     	}
> >     }
> 
> Based on commit
> 369d71b895b usb: dwc3-generic: Fix ref clock enable error check
> of the main branch and with the above diff applied, I see the following on
> AM62P:
> => ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1dacc00
> CTRL+C - Operation aborted
> =>
> 
> So the 'unknown ep0 event' print doesn't appear on mainline.

Thanks for testing. Did the host see the disk in that run? If it did,
then mainline is clean and my series causes it.

> 
> > 
> > With my series:
> > 
> >    --- a/drivers/usb/dwc3/ep0.c
> >    +++ b/drivers/usb/dwc3/ep0.c
> >    @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
> >     	default:
> >     		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
> >    +		printf("unknown ep0 event %d raw %08x\n",
> >    +		       event->endpoint_event, *(const u32 *)event);
> >     		break;
> >     	}
> 
> I couldn't apply the part1 / part2 series cleanly, so I wasn't able to test
> this on AM62P.


Part 1 and part 2 are both on this branch, so you do not need to apply
anything:

https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v9

Can you run ums there with the diff for my series and send me the raw
value?

The raw value tells me where to look. If it is 00000000 we read an
empty slot. Then I will start with the event buffer code, it changed
a lot in the resync. If other bits are set it is a real event, and
something in the ep0 code handles it wrong.

Cheers,
Anders
