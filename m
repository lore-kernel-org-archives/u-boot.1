Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E7606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pXJdar1e;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxADU2qu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1AD881426;
	Sat, 14 Nov 2026 09:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JDFlzHt0TLd0; Sat, 14 Nov 2026 09:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2187B8143F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647022;
	b=IBz8XPiEv6nyW0sU2rXHij73HIf2/CMg2cB2mhHbjMjEstNOIYMoi//h8VsLd3RgpwWc
	 zHd0Uhgz0pI2g50OG7ilak5lXvbNbiD5pkgdwNAju8KsVOt0Pytao4F8lAGIQHoivK5Zj
	 s2VKQXHsHPquZi0gI0+ospZebrRQpLqjB4FzCVkXLbVN91tPzWSkks/Df+vCBDF28e+0b
	 9f99FDjT0zq2B52Hzo4BwwlEXEM4doKr61bG8TLdu+pqOauC92peUxx2wSMOwGr+2QDbt
	 QTdnhcMMxqI9s5ff+e0BOcD8dQZez3qJBKXG4BqHg1We+z8hT5IAecHBD0+r7bohJLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hFKr5YtNGEbdru/8BALdp82zp2JXSG7Wm/Vzku+f0PU=;
	b=PsGYPJie1m2cTJD+aXccjGNeNmbyAdZlVaLi2N/HXgG3DmTkOiDOCZ37SQqfDy7OfK69
	 kjwiVWNDSA7Hro1bQp41Z/T82dlxYken3tDmysag4l+DiXtMyufMxcVB2rCX0K0P/tMzY
	 cn7GJYtPS0ki7DhHWol45oJFLRjJz223u3wjEdPyI6zWCTs3kKy2BkMUh6UsjLyTDYTRU
	 dltDarjpMMYI4Of6PPGjEeSl1bZE10waIwy5kwfE3xFGkiyj13OzF6SByKjRuTeYRsN2c
	 q+eTpbephJ95OR+154oESEBca+7TWeaivGALvrvh+e92QUvJvDOOVUUHoTMZpEtPEPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647022;
	bh=hFKr5YtNGEbdru/8BALdp82zp2JXSG7Wm/Vzku+f0PU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pXJdar1eb0yXNHFykiMauPL0mVeWiAeMXASgxmY0exH+Bk7BkfeGUm8Ll6wDFpeLo
	 9an/sXzRCJ1uSIDfzjPnFMQhh60lylnSbAprkt+wCN9D1UCXm7Oi/RXXzEGDmGpYQL
	 thx0j1V1LFSKVraEM0uwAbLiZq5VYkwbQ/CztxCesG20lHKL1z1wQpBo+5+YNe2gxe
	 Wf5Y9wxmK3JWfvWmZ+y+9nUcJdYuvGvG5KMrey6Na8hZe32wCDYTV1OyCayBylAAzp
	 ecU7syclL8sO0STR/JTJdxyBjZ/aLf9OIzr2qqY1IGDKbZYkKhzPDL88Mtv0gHHeBH
	 cSfoSdYoAlK6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2187B8143F;
	Sat, 14 Nov 2026 09:03:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E955028C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E596040DF6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kyY88kCneW9g for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED63C40DA6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SxADU2qu
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED63C40DA6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:03:39 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b75c0f5fe8so282716a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647017; x=1795251817;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hFKr5YtNGEbdru/8BALdp82zp2JXSG7Wm/Vzku+f0PU=;
 b=SxADU2qui7kixkb11BEj1t/3aeG9g10gOZLazGuiA3hCqYEyZqwstbnWpy/+q1GDx3
 4+Wmsm0LGXE95Icc4hWX+wy1ZeeDuM3lmMWWNLQy4VkWqfA1NkIS+5EgyxGf7Fdk1uto
 5DEYY8IJd/Caxumzt6F6Uz+LzHtDrkAMOpyodGYWXg+b79q1kAl49AygsAKXTCVJLMPq
 VpnKwjHLnqyp/x5Ct6t9ut7dUjc4EDnobA7++f/3qhqL2yenaGLkbLzOa8mEv8wqINWT
 UgSdGv8eyYIt92sWhUQRKYi+1fqLC1oxihJ5sDYh+w0Yc/DW5n/wpouTfAe7Ph6THdt1
 6EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647017; x=1795251817;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hFKr5YtNGEbdru/8BALdp82zp2JXSG7Wm/Vzku+f0PU=;
 b=QWLytJQibsX19jRgnAUzWVNthRBvhChXfIz1syLdPf68Z2Cnvlg0Nho7xAnJigXNco
 FX75+x9JUNk9LeVG1shnXF+dIv/hcZM3VBl7CUtT/bKRo8tHlIsZ+fXhP++5wIqBTpxp
 JT3e22mB+vYkJznYoG5NCaNiXXKLO+p83buv6CYX5ctoGITrfv0uVJVlXIEqVjBEqSj6
 FZFYCQTSU17Q6BxiLmwXz3IjsDFr06UsAflwMg8/ne5K9CNW7oSEKPcNs1/OCt2R9Btu
 jgOzhq2mxvgoNYG+kza7/9lKjAeycBn8iahDAzta58EtxCYFxpt2Q2eHDTGJ5SEFbS9z
 aAZg==
X-Forwarded-Encrypted: i=1;
 AL+hErHn9jx/lz6oecc7TxQlulTnt9qpnNiNJb69pXpjNlgUifjLYp24vQ0cdsKzzRujYi0kc8xi4Gk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+aywM1Hgi59tfD1dVNFfj7bxcfhwlFU9SPX/d7BX6jpMI9m+VR
 Otuy9NZo2huRXNG0VFNzbQPBb+anapfkQiaIfKDC7nuKl9xOuebVPUWi
X-Gm-Gg: AYBFou3ryy5VCl9MpyqJ9PWf3DAEWwArckiG/AnPKhUW2wk06o3EM2dO+yZv3eyfsEq
 9t/tku5QoKXpQ355m7AfeQJYaHNVRwOzFr0bouFUK5Tl/AqfzeJkki5jkkz3iuFaQvcOKF5qBE1
 5gomCfhQuax9O8tbuNm1xJBEBH1kEQkRHfo5QBa+0kn/naaMMPTFSrnwzGwoV0LvSy7o3xBXWBl
 yqU8XhSogZo3r3uUf+tfmQK3D0fotzc4M59Huq88cuE/iL/csADW4UHPPCfshRVD2nt9aNAhnDq
 sR1du46ybGQSp+a1vqvxqh2zRA3LAQlbXsk3Pdn0Jai+WDVssTU2X4dBu9KnuVaIXYvKhRQDXRv
 ApOpEO63FPZi/s9BCBN0evnYDwynk/+9LEH1gIQUCl2scoh50w7+CI5KQ7uX7iXm5uyFKB8jqpW
 cxTHgo5xTCXXlPAPXWhHGTVsSFiE8Nk5k0NoLts1CVRbSdRN7WaSpf61HHpvCRHKBFEoBBWdt4q
 78e5azPeCNvS0KjPu0Kd4UHZC4BWiRh4MWZ6aT4MLYu5vrrBJYMV+4HOEJOKbiUHZC8xZ62WoBM
 XqLpm7+gKkuadAfSOXroDWZ8VHP2nscDRRz8TGjSIaNTCfM1aXaMqQ==
X-Received: by 2002:a05:6402:461c:20b0:6b7:aca7:4cee with SMTP id
 4fb4d7f45d1cf-6b7c0988bfemr4683890a12.3.1794647017430; 
 Sat, 14 Nov 2026 01:03:37 -0800 (PST)
Received: from ?IPV6:2001:470:b51d:1201:56bd:184:ef6d:ccaf?
 ([2a00:7c80:0:3a2::14]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c2361280sm2081572a12.10.2026.11.14.01.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 01:03:36 -0800 (PST)
Message-ID: <f9c329a8-3dcd-4c66-aa49-de8fe912dee3@gmail.com>
Date: Sat, 14 Nov 2026 12:03:35 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] net: mtk_eth: an8855: sync SerDes analog tuning
 with Linux driver
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <20261107142441.2104669-4-csharper2005@gmail.com>
 <95e43ff4-7f8b-42d4-9a09-c4c15cf01247@baylibre.com>
Content-Language: en-US
From: Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <95e43ff4-7f8b-42d4-9a09-c4c15cf01247@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On 11/10/26 00:25, David Lechner wrote:
>> +	/* TX FIR - improve TX EYE */
> 
> Probably should mention in this comment that these are 2500BASE-X values.

Agreed, I'll update the comment to clarify this.

>> +	an8855_reg_read(priv, AN8855_INTF_CTRL_10, &val);
>> +	val &= ~(0x1f << 24);
>> +	val |= (0x04 << 24);
>> +	val &= ~(0x1f << 16);
>> +	val |= (0x00 << 16);
> 
> nit: don't really need this line - unless we are going to follow up later
> with macros to give all of these names. And using GENMAK/FIELD_PREP/etc
> in a followup would be nice too. Don't combine that with fixes patches
> though.

Good point. I'll drop the redundant bitwise OR line in v2. I agree that
migrating to GENMASK/FIELD_PREP would be great for readability.

>> +	/* RX CDR - improve RX Jitter Tolerance */
>> +	an8855_reg_read(priv, AN8855_RG_QP_CDR_LPF_BOT_LIM, &val);
>> +	val &= ~(0x7 << 24);
>> +	val |= (0x5 << 24);
>> +	val &= ~(0x7 << 20);
>> +	val |= (0x5 << 20);
>> +	an8855_reg_write(priv, AN8855_RG_QP_CDR_LPF_BOT_LIM, val);
>> +
> 
> I don't know if order matters here, but it looks like the proposed Linux
> driver does this at the beginning of the init sequence rather than at the
> end.

You're right, the Linux driver applies these tuning parameters earlier.
I will move this block to the beginning of the init sequence in v2 to
mirror the behavior.

Thanks!
Mikhail

