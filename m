Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2927606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gu7ulohj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uSm+TqDp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 659B440CE8;
	Thu, 19 Nov 2026 15:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWzF1IIIJg31; Thu, 19 Nov 2026 15:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD1C640C66
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101141;
	b=FRZj3P9RbLj2zv2pO+49+IB/NZ89/CdXpg0c6oxCOPXy334cyf0fwaT1im4c2Vp3zWlJ
	 t5cc8wPr6BviFwzWTkR0ODs8CCQbHj7cgHyjMw4AIJvf+zSIqOBaVrNOZbc0lMO1ORT2k
	 LnDmQciRTnwc2ScAiwwKV0YvqGTg+2Jy2P8UA6A0+Oww0m8XqpxqDvQxFm459/9EYo2yW
	 9sNgusrY7+ypEQjjswctB1ZOPAzLwHmwHddLclMwgt93T0W8NFczfItTz6DiiasIiZ/HV
	 /lh/BVehLTrUKGj6IkA9u5tppDhcq3QgQ2OMb5lJF3TAFDWxrBQTo43GOT50t0nitIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YzsEVqtjQWyErX2ljRLlAibdaYSPlYJzQBsYZrhYi8g=;
	b=F5CAjc/ZjoC2+zGb6iem986h+m2O6Cnmwdfe+NcAxx0kdKrdEuOLTtnbPT+1ga+4ZTVn
	 0tBhtGm8XLWpqTlkt3qt59qDcppYn1IJgAJMDWg9ume3q8K2TY9nWBmrT9yUIHOvCFsrG
	 bwcRxTqRMzzUyo5VizkAO/JU+PYpfdBhGkX5XfjRyC7SWSFB2ExiaEbOpBk6Aa0N0lPGx
	 tMKOkSf857z9EVf3CaGz1uPtApuGMS0NmtorpgkT5S4QkZ8g0gJyRFvPgLQWzCIg07LIU
	 fxqcMs7V+AxjQaxwya2lYLW+bq8KawxY2nwWoNmwJrJN/YRKEcdGUPqwbtFkCQvpicg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uSm+TqDp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101141;
	bh=YzsEVqtjQWyErX2ljRLlAibdaYSPlYJzQBsYZrhYi8g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gu7ulohjEATgU89ReZyvvJkR6ofYx/ZlqZEV2GYhZIpflxFRAUuQOpyT+WZnSC9xF
	 48LDLMd+ffc6qg3Q8S8/RetBv4iNV9vQre3oUmkvX61Koai7bJZ0vzs+MS94qpLlLm
	 etvyFUbunngJomFnkzn5ftR3PZk2kx0o7u2ThL3BkPtUb2oMQ3g5NEDnBHK316ubPq
	 UdU/+EYurWUlYrXu/t5YNj7KIDKmAM1zZKhq51FCzv+/LBVvs3c6MLUPfE8gU/AoLU
	 OoTvOY2gsoRYxkrY6OWB4a05touBrHx+4h0BH09CT0V6vMDVtpHWghM7KrA/Evi5YJ
	 yRu24Yzlh2waA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD1C640C66;
	Thu, 19 Nov 2026 15:12:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05035465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEFC140C66
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ziOX9iy-Hpaz for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22F7340B28
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uSm+TqDp
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22F7340B28
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:12:18 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-70bf1671c21so1495706eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795101137; x=1795705937;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YzsEVqtjQWyErX2ljRLlAibdaYSPlYJzQBsYZrhYi8g=;
 b=uSm+TqDpddRY7g8VdOBGohmNpriHjTix96bHFUdeOM8RcYZoyJOnEtyLYF4E6tBhjA
 I+Qpwr+eJSLcBixiRnYlOnengMCqyQkJN/SQNgEwBtIwT4QeFTAXfMl6U5BJB4B9WSMS
 G0h2fJlSK2EMdPnGzOgQOYDKnxsMOgtC+h7yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795101137; x=1795705937;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YzsEVqtjQWyErX2ljRLlAibdaYSPlYJzQBsYZrhYi8g=;
 b=yYXh+97XRwxrN7Qrh6XdnqqXNw8oBMjud3qb/tWaDC+XkE9chz+XVLcRnmyTAtPcBx
 u/Ppxzwe6JEoyV3iUVHk+drcru9cFl2kzBBeQMxKSBRrU4bgkgwTvxX7bgiYyjYblGNc
 aHycovfS40qSNPd277ra2Im0jrGebKHP/ZBmg3BCCu2tXzsNgWLhecmJ4RJ9v9D09+cD
 CgHn1sreieOKqYH8RcPzgUAKmxg4LkbNoZk8puMwXAt8HvyNElB4IRV6+XgvqSgdpOgz
 rSkrK+7kQbfg30hRaDyOPmi8AR5CRMTtYjjI/A+8jYs+XsByZrpTZytwmLoTHnJr6rWG
 b9SQ==
X-Gm-Message-State: APuU4Z8f2GiGYJX/mibHXmj1+URchE9AVxZWwPXF1N55owKMCdxFrBtY
 kJi7OEBGcf6T3TV4lsZ/mrKFQ8taVzoha74pccTH4nAEjoVfooSLbgybuemmQRahXis=
X-Gm-Gg: AYBFou3RpZ6zb4EX+7+xDdmKHRnpbkWQ26Gal1r2wctnoNk+ZVS88F+SJvIdqZ2ru3G
 p+FrLoy7XAav6ilqmIL5szxIFwU4I6T69jx0r92tUC/TVF5cPEqj57itEaR551/2NcuIQOH0Ms4
 kZg1XaKlwWBpAR/tr9KtnIAxIcvWVuL7e0AYhYYURidL1hAZ/GUinjJgbN8ZFNG2Quz59wqyMPp
 2PPa+s77YMBCkt4UYmEDDdlWv1Ale9KePA5WYuhczpK4y5PR+rXf3cu10Za8KJ4dMxtcWNhN88O
 9M6aKu5MnqiPp+OxePJexSjz70Zl2mkG4nBTbQSWKrKkNmvjrT8BgCpzKxQ2JEewvJeWgnrpCyO
 q5vahX0II+vuESl05kcl93K8ePhZx7QWvVqGyvzQ0YLUWt2nKUBLzK8el0dRc0VJawxpUpacgDU
 /iDb0ISKPhG2CCY2GoD54cNTJrxmtPmYjBXCvvJJH6hqnSGT42rj2RGt/8AvImjXu4WrKUr0JS3
 o1nzV1V9hcT31v2c8O/eM73jszSt9XtLOgc1XnH3h204ZMC42799IAhSAxNs1qBBG0X6VN/ELNs
 7VxFDlI9/TU2CQeP1s63RFB7DR0h1bWSfNpNLS85BbJuXNgfkzPP2rjFUPW452Zo2xr4l0xYK57
 DO7JHRf7Bj3tZ1RsMrBhq1lhlFzW4ebvisA6ZGgm5NTRpVZ7qQwzMysTzupIZeN96MNKfUUhYMM
 NSFr9U1ekJABqtdRjFhTo2F0Mnn/H4lw==
X-Received: by 2002:a05:6820:708d:10b0:713:e3f5:251e with SMTP id
 006d021491bc7-71b1864eca5mr3605992eaf.48.1795101137521; 
 Thu, 19 Nov 2026 07:12:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380e5472sm153884eaf.14.2026.11.19.07.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:12:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20261110075707.1409824-1-aristo.chen@canonical.com>
References: <20261110075707.1409824-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/6] cmd: pstore: find the zones where Linux puts them
Message-Id: <179510113684.3401845.3416093732160541174.b4-ty@b4>
Date: Thu, 19 Nov 2026 09:12:16 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 07:56:36 +0000, Aristo Chen wrote:

> pstore display and pstore save look for the records where they expect
> the Linux ramoops driver to have put them. This series makes them use
> the layout of ramoops_probe() in Linux, including the zone order that
> changed in Linux 6.2. Each fix is followed by a test in test_pstore.py
> that fails without it.
> 
> Patch 1 checks that the buffer for the records is allocated. With a
> record size larger than the malloc pool, pstore display and pstore save
> copied the first valid record to address 0. Patch 2 sets such a size.
> 
> [...]

Applied to u-boot/main, thanks!

[1/6] cmd: pstore: check that the buffer for the records is allocated
      commit: 0f3f46d97a0241f842469d4b2ccb7e709506449f
[2/6] test: pstore: check that a buffer allocation failure is reported
      commit: 37d5923180f03e4e2e5247eff92ac554f88b7e14
[3/6] cmd: pstore: lay out the zones as Linux does
      commit: 9fa37af875090ed4b9c7842e3ccc4b7ad55224d0
[4/6] test: pstore: check that the zones are found where Linux puts them
      commit: b9caef4d85f49b4fa11004fdc5154cf8cd2467a1
[5/6] cmd: pstore: find the user space zone where Linux 6.2 puts it
      commit: f0936bdd737e31228ad5fd72860debf1ee14d49e
[6/6] test: pstore: check the ftrace and user zones in both orders
      commit: 628d4357b58c5b8076a7e1ba3fc6293565e5e648
-- 
Tom


