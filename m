Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A13BC624D3
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 00:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7B0D60BEA;
	Sat,  5 Sep 2026 00:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3RpTWmECw72; Sat,  5 Sep 2026 00:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF96360BED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788567282;
	b=T9HakIiv8LoTReRVW0aU3rWxrY7L5q89kFXKXEH7N1R+eSjzarSkHHljT0QweH5fTGwS
	 0zqQlgxTMw30oqEW0y1KIEC9sKiGB/cxr9S2WoTYGgdtGJvmj8DaYGnQd1SJTWQOn1sVB
	 TiD1OXeF0F14y3p8D/2JnyW3/vgcN9IizBiyPRM8cJXu7lXt4mojUbCiCvWLGRwq9+Vsc
	 j5AmSUq8xmJ0SrJAg7JoYmA7asOrKSMJAx6kHoBy7MD9tReXMYq+jPTtHugo58E8RU5GF
	 RNRMxQI/52vEbbwg02n5+GeiM+Pp/BIhGFvPlXgCi3xBr9iMLnr20YdeqKmlFBkxbDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788567282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=I8rZsKNhaddOUm5YH03jwF9+lwdfnFS+UaTjtkh3KcE=;
	b=q5a9Z3+stxI2BSlixIAsxSxkUqNfCFzVTEcSOS4R5k851F7OJ6TWMtxaueUW1l92n7zh
	 afn+S/4+b5C99FXO22EXcR9nLwVyu30XPNf7D0y19406d5ABIqpEyoKyM4c9ZOWgpuI13
	 jUs10IUR+lwBGH96rMbNoG5T0+DXylJFfbtb+qnBL+TTDXDWCgXiKWLF5ZmYfoSmjYbNM
	 9j7kFFz/zXYzljEC1ByR/VizqNwyjLIAFbvefLMrcl4J0p2Wv9blkf3LxH6CcRMWPGJMN
	 hV/FNFHSavz0pJmVEwzySV956GU2xp6CXq0HZoC7vIYcOH9iGX9FQJ4+b/iTHr925Cw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788567282;
	bh=I8rZsKNhaddOUm5YH03jwF9+lwdfnFS+UaTjtkh3KcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ofu1f+bAxl5TZ7tu2LzIYcupeg7mzrHnFNyJa8Lx4wXc48DDnkaL9s2W3NvBmW7BX
	 AbJvwDwe6jY6M51JbZEPZNKY5+S0tsaajn7sTPq5mBocAgJSR3CtVhRLfTFGosgUqN
	 XXOQ+QmQNfhVIOwlPAB9uq0V6hQ/yB1GGW7Fnq4YDU9A51yE+dS9iEDsEMM7wzSsW4
	 yXHn2aKr8NvrsCYHBLvWlgJgRBAmCn9rMJUnZjuze5XmChmsZ7g4U7x/Xo5Hfrv1IR
	 hbvy/QT6U7c/VvWFBz7IeClsQw/P1E2EoqrJMX3y9NymCGklV4xaZYZ4ikk8SBaU/x
	 wpTrT8fmdeEJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF96360BED;
	Sat,  5 Sep 2026 00:14:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA8CD2C7
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8033810D6
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wp7yVEhcD7ln for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 00:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3239B810D7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788567277;
 b=thFMnZ4UQXbAQ481klIc1gmBrvKaTi/hCDAJ9zW+RFipuHaeHP1IRzvByv5Tr3QoCGV/
 2ucoBT3UlBQkWUYTWJNKOSM4mpwtCQBpO5cT5gC5LaRRhhJfBqvrwr3Xkxbhq/N3Y5vH6
 CVnBz+FEjgGbQPiA37No/IVnhr/gpABDJ0V6b/8Ci4t67GrC9zSDpK8NKzzFx/IrZ01ka
 FfOEel+B0PqSeyiX8cUmTBolZEuUFoWU6aUTGRRgisMs/rVtrXLqHvhEj+xTlJgmphC5b
 PqJC27OMaOHC38sk2Sf0LB4br38WlcFr92ib7erSyg/YgfhVJa+XD2VGjjIj725I6sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788567277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=I8rZsKNhaddOUm5YH03jwF9+lwdfnFS+UaTjtkh3KcE=;
 b=aPtb874TAkc3nWX9ofvwOPdhjLu5SlDSlWaReGxuTZws6UVWaWabYzRzJLQVMTlRgfiT
 8NHhoBN9jOWWB1X6/dYLQCFMfGeDEM7rbvDrlYkP3Sfc8q+pcfnQT5WTU/BzcDBoj3F0K
 9dfj2QzGNA3BNkd9sRo3Rng5mCBXC6sBAJ94SyUe/SCX7ilbN51ysrEzpaFYxaN0mtsa4
 XbL2q9a8acXs0iqFfbiMRHVIlTNVpCpfpHJ4oAAP0NqkzIj+Z+CJT6QsKySVUSdVaM1O5
 rs6NbOVy4vz4nKElKXAsBUocFqyZIQMob+9xAcrVdRW7T75sBW8ym8PWi68ZE1Bipqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SgLDhKNM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SgLDhKNM
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3239B810D7
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:36 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4a40bcc8d69so1246899b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 17:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788567275; x=1789172075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I8rZsKNhaddOUm5YH03jwF9+lwdfnFS+UaTjtkh3KcE=;
 b=SgLDhKNMK6ZZbd78f/Hr9AqhHvmHk+Q2kOe72bKqyLumEC7ysJ1W7v/PVKtFESWLbe
 eitPkIogIirEeHC5H6wUsP7zDtm5YSY2BhLjrc4luixpsaFp7DQUH5RP4oQXHz9ixHqL
 3n4Erz09tfaUFxvp0NIdZrkwXTW5hPCxnyyR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788567275; x=1789172075;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I8rZsKNhaddOUm5YH03jwF9+lwdfnFS+UaTjtkh3KcE=;
 b=VymV7/rXBXDKNg7IGMMgnJ6uTChYJQKaWbfMIXVyHSaMuYZUxMQuBhRNax6tB8xUgD
 bO/LQEDMcVAGlvwjnQPmqisSN4gy/jgcaetmGJWVMeNWGy2CjfDWmvvdQPGeSYs+VTRv
 HK3mg8xsuSEwuEOhG8BLXghyuFrDfkHBMKvx4i14QGCVHpB9hHqZ0yBQvGdvi1FRjgQ5
 lnR35CEHHiiUMkNi2Cp9PhCjiNnyB4Pss0L9AfVovfLdTh4WQAxaVmooH/uGm8N0jx+/
 JOd7fwmGtny6yiM0r8n50q7nUi7Zg7QwC6Z2CZVpS03OOm5b3B2+lLs1111WZbYnsg4t
 jNQA==
X-Gm-Message-State: AFuF++mWVNuGDssz5y1UG57A2XHP4NlI3nCMEGgK5PI4SAO3Pwr+GE52
 Pay7B/NfpKqdFFmlzXj74stXTEEkAufZz7JApjYl50qLLtx7PsGeXxiqkY5EkicAC0s=
X-Gm-Gg: AYBFou1qmekzFXwXAQAwwbfUyUixy1JUJbtSjG214NGJ/hlGnx4zBZh/uoXvUlq7kjn
 S39vGyaf2NEzN5/2KOPRG5qMNTEKJZdQVRHG08h9IcviCPYx1DG/MZDngfAVpfj4A/Ya59UeZw3
 VE0/e9qtqGmLp8vY+QYnn5ZesqFpJDWvR3DXsVvDGhWLwLDn2cqhD+SmcT0COMhP/XztEzLhkBY
 oGLwFoO/VkX2MD9kn0zedHWUlTwUzz3d5KooAtu0RFUQs9wBNBANYb7QZMiIogGa70Q5GjtrCCv
 RMiBiaw0U0FLAe08TxveMg1/8NYmQvjaX/ganEQi6qzkTFKYc5qeWokt6lRa0OQKkIqgmXkGqf9
 YZSkaw5DKusvGuPn2bju3aIGjbOIaC4Lb5MjH39CTkpqAPdOKK7+xyJ7Nt9NJxQAmI5Fv7U5MoV
 KWK5FRiX1el4CQAvdyirnz2gfrnj9GWUUTXHWAtYAcgDKI+5Bm++8rCBozk3UbXTjsEDmEO4cJ2
 Twjj7ZspNGSR/ceu2+sWXlKWGdwpoJZ2W6QPAvn17fax+3itwDQi04hHtQrJSMJgYLkaL1bdG33
 aXw+Z/ub
X-Received: by 2002:a05:6808:4f63:b0:4b3:8bdc:30fc with SMTP id
 5614622812f47-4b96153c2a0mr10251475b6e.11.1788567275605; 
 Fri, 04 Sep 2026 17:14:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm4027463b6e.15.2026.09.04.17.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 17:14:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, "Michael C. Pratt" <mcpratt@pm.me>
Cc: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20260903002942.7835-1-mcpratt@pm.me>
References: <20260903002942.7835-1-mcpratt@pm.me>
Subject: Re: [PATCH v2] fw_env: use env-size property for nvmem layout
 device detection
Message-Id: <178856727427.3086907.9520438449585702811.b4-ty@konsulko.com>
Date: Fri, 04 Sep 2026 18:14:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 03 Sep 2026 00:29:58 +0000, Michael C. Pratt wrote:

> Since Linux commit 5b2f8c133d98 ("nvmem: layouts: u-boot-env:
> add optional "env-size" property"), there is support for providing the size
> of the u-boot environment used by the bootloader to the layout NVMEM driver
> in order to calculate the CRC if the range is less than the partition size
> in a similar fashion that it would be provided in a fw_env.config file.
> 
> Devicetree binary cells are always stored in big-endian,
> so endian translation is now necessary for this case.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fw_env: use env-size property for nvmem layout device detection
      commit: 7bf077ec5733a230bbce34d8ce324f92d8c46cc1
-- 
Tom


