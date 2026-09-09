Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D33C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 779C5810A5;
	Wed,  9 Sep 2026 20:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nY2n_3rThvCh; Wed,  9 Sep 2026 20:36:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B7C6180E7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788986187;
	b=sXRN8S32yrTEbG79C/65iXtGZm0VmxgwM8ShBtApRny5v1xBF1dyGxx89b+36xvqzVYi
	 rQ0eG4MhF8FX+6yHCQcKWjcFgaEVbEPv32O2Zw1glO6qQ41F2fbre5dpY8VoGwnwgflIP
	 xLMnSsERXv8OLXuzLTCmp7/E3vmwoZqWClkKSPNfiyfJgggNvdTNTPNA8XC2YrfacRZNX
	 TQHkYVZmOm/p7Id150q/QgfMMPjCo+Cherzwctr1Q2HqodsYaPKCgombX0h1YFpMl6s02
	 c7cZkKShSfZTX43kV3BxkNzwG7NE2GWshfhw/SbLcBs2Kqb66NmL+Gzrw1o3HicXYTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DWSYsL7SzvpBijvX/YSC0gcdwmLt3dUTMy+Oi+WkxQg=;
	b=DWKPjv+H8ZmQJQmC3ihelgUnI2573muXMwoySEAutowiWLMOsUYjLpkDYfY1NjOE7n6c
	 HLfh2OcsIL98e1UxbQlfwEmem9N4r9hUw8NvAkwzQiVPrG4k+JHo9iP8jnHL1RtTRWqzT
	 oIT4EfU9Opu6EA2M8rYITcnqsxl4zNhU0b2Y6CYPI88Lf5SVvhLWRG7AqxXQsNxMJxMGc
	 Fu/jMitloLxLxxHPRLLI5VYO8Pp8Ht9W46HW9N3Qggfy4lTQ3j3I81G8Xsh1Kq+IQW0eX
	 xhTFTXsCYbiDwa0BjaJ8d7ebEwH2Gp1mZtbMK/FNl0w74+xY6duymDTf9v2ZLVqGK9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986187;
	bh=DWSYsL7SzvpBijvX/YSC0gcdwmLt3dUTMy+Oi+WkxQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B8CcH3ygIKmcYk0vshH+pKZtq6NaLuI45xXJ9JqTr4BFwtENwyqGpswozj1T8cseM
	 xyFqMk0mZcbntYQjr+D5KGCEgelQLlP7mTjmcVCM41vFrgmFrcMznrdAT2tgEzb/uv
	 lC3jkDr1BvJlKt/NsUKcUK5KaTPGJVjPVDQtmnfjBNdOjv1g0wCRiQJVky1l++pVrp
	 SMg3V4PBlI0fA1CfFuYiVpyTFULJBP+v+Jm3i4fIr0Cnp+peYubOQ2X1Wx8lMEf56W
	 bo49jUqtz41YD9gA9ywDcJBFFj3fdxwpLVcZ/bjbI5aiPZorWlPIZQuUwNW8dqiUpV
	 wdMY5omWVfQRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7C6180E7D;
	Wed,  9 Sep 2026 20:36:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 495F596A
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44A6740A34
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXR3neeTWwea for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 31D3F40A30
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788986186;
 b=i+whLU/ecSNkC86gwaLrzRcrmIIXQgJfZxyDKmt6Bww4QACB/tiap+be2ctUF3R6QTuA
 rWHlgXHOjZFbfuQbbyJfCxABNGokISGWNNqdSqZA9/nYigGIKRZZBqninQ/SwNptRTktW
 3C5gHqnPh0W43dDglH+gaKrLtlS9u4rcw21d506HNr/rlDF08Q4gUU4LeyjXRPSwaAgMa
 EiEHWst9kpOZsPzv/9InBcGPMM7GEaQaDYpRoqh1savqLJ9ywgfdFRxqGK196B5J5V3T5
 /x9QkkJwLjG6qiR560F7YlvdNPrhQ3DS6OXjSKjnTIEYJ03EFk9UW2UPyq6IGJrSzPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788986186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=DWSYsL7SzvpBijvX/YSC0gcdwmLt3dUTMy+Oi+WkxQg=;
 b=K+m/0ELISyfIheRsV/+zIpTyO6Eo5ZuhEbfo+NowIk4A//lYZb1ydzGuTst/iQcsekf7
 D8Ce1x7C+xu1Rcj1i9Zza23bkc5OgUvvKg44X29vuuquja3Ma4QejOyOXXXVf3tDJxk8s
 bzpEHY77SvGcN+iHDTzwQsDYTxdY7dXdWoAat0sNMiiwVjdpU3mdjYjdtd/evzk4KVHjB
 WXc7XvEHUdmGKXiSyhP/sSEL4dsJsxTzmCFzQhsD88hq1UQn8jTLY7lfe2zq1ul/APWeh
 t1/+XyKmbAZu4gGO42PZqA71P4gI5u1P66hsPcAvLgzj5/LSCjweb92KiLhfLmMwGAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WHt+bhGQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WHt+bhGQ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31D3F40A30
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:36:25 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so894866f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788986183; x=1789590983;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DWSYsL7SzvpBijvX/YSC0gcdwmLt3dUTMy+Oi+WkxQg=;
 b=WHt+bhGQd9weXtTV0UXrxjpFL17YiywxhP2tgpevPAyzLz6tWzW8z7ka/FFxqemri5
 NAY44vSovarbUo6yRK7X6KUOHkMM7LU59JG3bU7/i0reDNbphLihYpjchBzAl32g6AgO
 LQCiB4xtV316qF38R4H1UEmTQGPFSv8sd4x6zAzi4RTlmeDeGX6OxaV7dFEoTH9vHsfq
 2X3HBy2a7B1m4IJ/Vd2InCZ3mmQnHblnTkN2nMU7pc/Eanm8LtFSbM0kbIqmHZqHeagf
 IOi+1fkrse81jrK4L93s8sirJABMpMTIPiz/4TgormLbACCBaXqj8sgEoxJN0pKouY/5
 WqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986183; x=1789590983;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DWSYsL7SzvpBijvX/YSC0gcdwmLt3dUTMy+Oi+WkxQg=;
 b=QGgznInphkVF0Uc4slEFKH9OI93BpfiBzXDzPVPAhrpxNqSXoG4od7Z7zP0SfF45g+
 lGJaRwCiaMH+fWGagCknHcrsH6MWLAeOuYQTQLc2lNBHw2JbmXHIvVfzmOsETASO8CuD
 8QR0OLaZl5WQ50llM5cwK6gO0Vlc/EJ++0Qnr6L03ggsL/iBEKW2tG/fp21Z92ZbOzNj
 zSeCpS3QzWTqp5QFvVVWelVDmYcrATrP5CEg+1jdD+dsASwoV0675B/UyQnk6kh7uzOH
 5uZD/A/ncW+OTWI9Sz3HhKzXXfSe7VF26RFjzVukQDeTgInL5CIpxzqwF2LEcY7FHeII
 YBeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjak63lorRzfuZ77opebicd/KstyCuO0C7XIWsREvaSU96yWGP3DzF60uOuhI6CuKWaSXIgjE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++khQly3R4yh2hDwDCrCzO0dlrQdQY9O36ALeCCUAJYlLa73yw7Z
 /x+HROM4tsKmfSt+ONYteJi+c9FjM47UPSNAXpmD/g/1myg+TLxVrszSwHizTHRqU2Q=
X-Gm-Gg: AYBFou21UTsF5jR9SB6SoqLyvc4glT5sn52O/I48cSiAZkB01PiX7L967Gv2dIBbMGd
 V1kATNoGZ6o9KzoiGrFHk9GazvqgUNjDj1UvChwjMw/UoZRfr6tPztxlejgVyDbjZiVOyEHMsdC
 lcjMUnP3yckUsCAKI/UcffVx9IIVcP8kPXAEn/vFQCkeNdQ4puSAmcxjlcRrDaJzCW47xDmPPtS
 IgH20C9bPtVzNjCK69wlCTk4vCaySQ6AnAyryL8Ym09H/pXn7WJ5+KDvt/3BOOyU/uA+fVJYTRY
 pUQzPqHmhONm15GjFkPxskyIIKc+k4/GAoSfT7nZ+lIio85JmcvDQfeFutgfPdk1FUxzBvnT/yR
 3YvSs1FmvGhCaDDgNVdqbI6LuaoJuXUQqyD3hMlnjSFaVbN0hbmL1rzGDpQzq/dOrkTrJnFtmaC
 nug/ZLgDeFIIXN3Yndx67+vo2S9+mFLYnegUBk1saDCpisA9cx1R89Ie4GhR4Y4t9+w7MyGiAWV
 hGZK9HbsIKTwKn3DMUY0AZuU4cW7FoSWAd0DorScAwvUeaWj4WPdkIxSA==
X-Received: by 2002:a05:600c:698c:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49d1f35366fmr175978995e9.10.1788986183312; 
 Wed, 09 Sep 2026 13:36:23 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm38570422f8f.13.2026.09.09.13.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:36:22 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:36:16 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v6 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
Message-ID: <aqHC17li1EWt9VGf@macbook>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-1-4d4a11d5741d@baylibre.com>
 <8f39c6a2-54dd-4809-badd-dc72619c3aa9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f39c6a2-54dd-4809-badd-dc72619c3aa9@baylibre.com>
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

On Wed, Sep 09, 2026 at 14:33:34 +0100, David Lechner wrote:
> On 9/6/26 10:30 AM, Carlo Caione wrote:
> > The Genio 510 and Genio 700 boot flows enter U-Boot SPL after an
> > external DDR loader has initialized DRAM. SPL then needs the debug UART
> > and eMMC controller, together with their clock, syscon, pinctrl and
> > watchdog providers, to load the firmware FIT.
> > 
> > Both boards share this MT8188-family dependency chain, so keep the
> > pre-RAM annotations in a common include used by their board-specific
> > U-Boot devicetrees.
> > 
> 
> ...
> 
> > +/ {
> > +	memory@40000000 {
> > +		/* Preserve the board memory description; the loader initializes DRAM. */
> > +		bootph-pre-ram;
> 
> Having this on memory seems a bit odd. Is it actually needed?

I thought it was but I was wrong. I'll remove it.

--
Carlo Caione
