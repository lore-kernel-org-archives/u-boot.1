Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2A7CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1056C40832;
	Fri,  2 Oct 2026 16:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m7y0xjmybqi9; Fri,  2 Oct 2026 16:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 281DE40653
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959643;
	b=jZKqnLiUzRvuE7SN+DSWZDsHDkOPSR7Ke465unTU/iqibz6YZXnp4HKumXQjbhAGwRCM
	 cZreUIu6QG+4FxRS1qs/FABAknw5/J12jeoq3qzqyoVyW3NBLzAmgHsqPwaTREakGrpb8
	 MNeuOjNNdUfTa7M8medxJBHDekP3AToWHQF+m+dZ/Eu0efzmwNGcWTNp2tkwY9OS2Y7uo
	 b4pO3I3DPOlqpY6kQ4ZhuNTG+58xridZ/rowDqPa5ab62XaY0XYmhkWlGcrhiVAcOlaUs
	 RE3pCtnlIaWsm7nonU6pWA56voCiYq9ZCcFUDZ6ATLWUh6GefQAtjfqpp3g4IHszCZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TSMARrTQR3KVDORhFTPWN8di59KSet1TbJaoOkLJ7yU=;
	b=BzkTPRuqYYT2ZWG6w3GD9VzAThDIKaCdTg/9WWxlH3OwDooNrKzh0CmtijnqCzyj6X0m
	 YT9EQf2an51zhCOOIGOQR8jGtETu5Skm98KSRD8hAhWfy4kCtuzo4LcM5DEPnSCdXjrNA
	 0WkWoXbhhruqsJhxBR/PHA3pmNiSdaI3WSn+uX0tqs1aySNH3sHUGa1ZhkR32mHtQs3k6
	 HCQp4npxQGkLhUYe2p0y4wc7j9gMNAlaZF5gLgQDQiyIoN5PLUGQJjkzf543PvqfM17XN
	 tG60b6vzxVayFwTXasoA21UMdBD2rd4YL2vuuAYNDOODC8rFglsrRKcvkcQRt5dqCHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959643;
	bh=TSMARrTQR3KVDORhFTPWN8di59KSet1TbJaoOkLJ7yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gezUwePSS3jugf8qyx2QlATG9wJWq71LBEOcLpA/vQ8OaRfXk2Nnxv72vXO9v/Qe0
	 dtgGua88RdlzLASRsQvVDfCFlR3UN/yd+52ghH8SHFZ45ZvZEaKC6UCE7vbdod7Lx0
	 7PKmFzYci0Qhtg9qtY8fOAcX7z7HIPgsIL8zL2NiDjnR92ihi7qk8V8EGEDGDn2b+L
	 WWbfLo9UpMMPbeCbF3TjPkrs+iDfYQrbKIEcRlQYIfTXuhZbOl7mFtQHz7/un2RKZQ
	 UKtJBYZ+v0lwTsm5b/IvFpaDUwshIbRyLHN4h1zFufYAnYf9Oho+DCwLpGBk69IzrJ
	 z156Kqht4TYgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 281DE40653;
	Fri,  2 Oct 2026 16:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C3CD34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 12:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DD09400BB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 12:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqqieO5cIetW for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 12:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BA2944004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790945891;
 b=n6OeBrb4TF80xySw9AETh35zNQNncuNBL43JS5Cnh1GCwojKSqKin0q20v8i77othoJr
 f00y9CxtLb5YbQCForirnPcbNUGGbsWTddx8tyL6sAk4DljoAfg8ows6mtSLx7y/90u6A
 Sax0dD8MNG0WxTJYCPC9eEc2cTfffPbef40BkuDDZaHq9pixcFn7xfkopG+dl/iGNcMHi
 nXpDpQdpO7hnR4DL1wEIBovDNjHGbH7u4hd6SNB4rsHJhjNtkG9gGlYo4IeTFzLlMBzKR
 m6Vxc2ygId8QmEclea9FzbSW56Qpu+yOAJ1wyVJ+xqM2iUJP4mkXRMljYgxk02YUi3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790945891;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=TSMARrTQR3KVDORhFTPWN8di59KSet1TbJaoOkLJ7yU=;
 b=MekNuSlkXiN90yHT+ws7Pd6oReRE2NF37mzoXBA1kZ8QzSfWsE/7oPaC7yDJyKPolLJq
 5MNj5YDi2TxWZADb+7knPab6KrlmzRh7RosDg1UxBGcYm2trIxqix1RLNoq911nRNZiQq
 ylUJ2vf6IWACnlsZFW5Q6rjL9m5gY5wSlQKoMEQux0e/LhMkri9p07e8PCC0/xecDCz76
 6q3SIg3tcy1CYsvS6psweQ7lAWOGEEI+Q0JR4BcEFjhtwLUDQ/BRhvrfVgTgWqwfKeDZD
 g1UFCd+UillKquqOypGmfLlDxq6l5nJmrpx9ERJZGmk2yRV8SKYhW+tZrdG38DXgI7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="gl42/LBQ"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=a.heider@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gl42/LBQ
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA2944004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 12:58:10 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af9f88c95so1277564f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790945888; x=1791550688;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSMARrTQR3KVDORhFTPWN8di59KSet1TbJaoOkLJ7yU=;
 b=gl42/LBQV/lwtQIfDfxqWacwyOGAVAPumGA3YZZpbgoyOY497oNLnO88qYFJluLvin
 1s3OL0jBN5o9Ck8A8OBdn32DY2/kS8zO7hOKs8Qi55h5Q+I12NboriCDBZhAFDWA9BPF
 pPOQSB3md4Zm56Uw0uZJiEo0fSvTjjRWEs03BCdPOznPj0BWnnZjipaCio/U4av7DtiS
 Pk+AZtb3+TzOVoMKmq/0EWXCiKXxe9K4Y3PNrT9E+pgDrsLhYHCLgcJ+9MC/TZcVQxgJ
 tC4ytbHqOFxSOyGmyLQony0pJR38gM/Zk11XxHy2IFmw10XwgDHvh7sCmQFbdA/Woxay
 QDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945888; x=1791550688;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSMARrTQR3KVDORhFTPWN8di59KSet1TbJaoOkLJ7yU=;
 b=PcN7UWUXT6ZJhQLvM7bcmQr669U2rgxUxCBjG+iIo2/rvG0ivgOhkEuH8bJKARKz/b
 ksehIWFzSiWEUqmFbi0VowRwE05ZVJRRgipr5kr8p+SR3sMZ7Onz9w99C9A1wwlT8n/M
 XbY6/8wIuTRhPE38iYRYtT8lLYNpbW5JOrlA6ewYdIpjH4dfYfh1rgizI4glsGqDXoiP
 H5H/QtufQTscWkty/U0cbd2BAeqVGAfsyly8rpOJoiBpTcFoVhzHGXat6ANDENVWpXjf
 8q1vKNCcuIf/T6LfHdGLIMwMTkK2Hkt0Jg7oecn2qg0r4dTDlBBmGKj/i12lxjtO06jV
 533A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1WxaAQB9IqqvAT61i3I1s1kDcdsc6fhPk5Tg0n0xN/pup/xtOI4lB2nyni0WXqK2+wm//I1s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nbCsFX0WGrRcfr5W3FvrTZXmHkjafgiJjwzoCQv2FMof+mvDEz
 BIIQPsnxx3KOYZdhbbuVpK9aG+ASobh6bWjyw6kgkjNZe3wfjhlzDk3D
X-Gm-Gg: AYBFou0PeWOeULmpKR9fohw9gjuPt1lx/rSVmAAKMx3Sbf24m+Br6F1xB6KbVj+C1B+
 pY74s3c/3U1aiowp2b9CoYrHEjQryZuOL8nKGyN5mDttoNgyhdcjlaZCkY2jglQDIzkWgV2Mdwo
 ztI5gf4Wsf4laROzh4daB0F4OyUwymJjF2CINHSPbk13KlDL7AgJ93qx6vqKOyMN+cUPJHqUgMP
 nXDn+vAgeE7FI3L9mzzeWqG/FKl8SMLn+tUxkaHWYgDkwz/haKzD8seZ/WefRrtgYEs8n38T5u4
 7UbyUBwowXmelNIB7AQU9LqKFx8hg/eVzQj0vaqAlul4IqR7UvSz2Mzd2VRAZVrFE7Inro6evIg
 Ne1JY3N9qbmB8gsYuLZdsylT67UOd1vBiNcqJRYdoKokXpvKutPv+uQV3ZMl9ZbLAXLmGUjiNGR
 TQyV9LClejSZPJ4/AZQE7n0Gc4sPw/vFhB9MkvEo5u4ENQ5m4P0Jyk5C/2RQwUe2hM6VBIvPaeA
 gbq/w==
X-Received: by 2002:a05:600c:1e24:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a0275507d7mr44796565e9.11.1790945887799; 
 Fri, 02 Oct 2026 05:58:07 -0700 (PDT)
Received: from ?IPV6:2a02:560:4ec9:f00::a1f? ([2a02:560:4ec9:f00::a1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027735be1sm110934885e9.11.2026.10.02.05.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 05:58:07 -0700 (PDT)
Message-ID: <d1a8bab8-4d88-48f2-9ddb-89e8c0e323b8@gmail.com>
Date: Fri, 2 Oct 2026 14:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>,
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-7-71043b29630f@riscstar.com>
From: Andre Heider <a.heider@gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: <20260912-m4-v13-7-71043b29630f@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

Hi,

just a general question related to this patch, not about the patch itself, see below:

On 12.09.26 2:37 PM, Eric Chung wrote:
> +static const struct {
> +	const char *eeprom_name;
> +	const char *fit_name;
> +} k1_board_map[] = {
> +	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
> +	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
> +	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
> +};
This maps the EEPROMs product_name to the dtb, just like the vendor fork, nice.

But does the BPI F3 really have "k1-x_deb1" in there?
I know that's the fallback dtb of the vendor's fork [0][1], in case there's nothing there, and I thought that was the case for the F3?

Because it seems it's not set for BPI-CM6 IO board either [2], which then makes it impossible to distinguish, at least based on the EEPROM value :\

Are there any ideas how to handle that, yet?

Can we distinguish between those boards in the SPL based on something different?

Or can we make up our own strings and let users write that to EEPROM? Mainline and vendor technically allows it via e.g.:
   tlv_eeprom set 0x21 "k1-x_BPI-CM6-IO"
   tlv_eeprom write
But that's assuming the EEPROM is writable, which I haven't checked.
(And I neither have a F3 nor a CM6).

Cheers,
Andre

[0] https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/include/configs/k1-x.h#L28
[1] https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/board/spacemit/k1-x/spl.c#L558
[2] https://github.com/openwrt/openwrt/pull/23231#issuecomment-5943699070
