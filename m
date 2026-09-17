Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B6FC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 22:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71E4560B05;
	Thu, 17 Sep 2026 22:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZqhEKrEgpky; Thu, 17 Sep 2026 22:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7C93460889
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789683538;
	b=ruXmXU/xp1SXotgQ2G0QQMVTgNAyHdWygIlw13Y52ZrG9K4NpRP1t3RY3jgYRAgRLcU2
	 BmI7GjWZxyTi8xIMjw+DFdZO2OHi4W60Zc93ayQJBmCHVyLtHmy5YlTNQ/cO7I2ej8kgd
	 G08RJ3elpIyftoTRO6MQOvViN3TRR7SYEVs3+pRSg797sE+TaFJDsPlxidv6qanJ0/XpZ
	 PUnsz88wAP3j2IAPcxPXe3ChCGqFXIOuVLJAxXf1WkECWGevj73VU0gqn5KByCiTTH05m
	 z5H8+8zZ8NsoKGIrnYpzZRwe8U424cLjxSN7x0cpoxTrGnhWbwZ67A//T9r5k/ocu4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789683538;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1hvosjK0zNffcFwfUoZua1dEWw9LhZiV6/MxmMUkvKU=;
	b=GWJ4FEDqmODr406ngs7m/12nrfKmB7+mAlghWEKYkEet8SjbmRn6yZ2wHte70OJMkmBz
	 G+/LwK2vtNRPhCtskwtWD60R1eRCwdEDKz7RRlGvlNMVIlhQ5CZm4ntoFB/Yv7o/2vePr
	 E7zHlaaouOOVJVdRvSENVpV5cUbteR+LoJPiRVclDCiTap97X/f20NPnSvzl+ioluyqvg
	 iR1QYcr/kjsxPnn90SaJlqZWp40iKEVADvK5H+G80x4M9pxkj8W3JsguRtx5Wm1FrZWZb
	 ewXRGKrWEKJhkAY0itrlOaxT5fCLsJVK7TuqSIr4+j0ZGoX+OzlXhtPij5ReSqHjUQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789683538;
	bh=1hvosjK0zNffcFwfUoZua1dEWw9LhZiV6/MxmMUkvKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HqpRBNumlVzIFc3TDxMFrWNOP583FSW0Af0ayaDh3yDuJvfZMsxETewxrxABnJZJ7
	 zB4Q7PDyl5js/ohG6Ig+5UwelgQVZliJY4DP+tT63YO+QABCVuJtCd0MbVIDza0Qsq
	 +aUdBbTmJREn4gHLbRDsrDoa1nS+zD9mrNrbMRSl2aBPIunk2LTYhiarL1twMPP+ck
	 u+81qb2woj258pafDs1sjeazQrn6Y/NErm4dC6TeHFHb51xUZ8z/usEtUJJyJWl621
	 tfIxzCrp2k4qxZ39PnWgTwOwJC/cN+xhH/Vr9donIpre4iKMag/w1Zt66fg2Udh+vE
	 n/kuLRZ1sfnKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C93460889;
	Thu, 17 Sep 2026 22:18:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E46BE13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6CCF40460
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfFhT2qhCRRZ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 22:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 10B2C4045B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789683536;
 b=iO9gUQZyAfRtttM0w+GI5BU4CSVm8IK4tTQAZiZEYo/yrk5WcJdBqyerKHg9WhNvGh8T
 XmyfgNOauEd+Nw8evBAMYQOxcCWkUG+8Eji9T9ZAebwlUjs9vJPFaCl7KtdsSP147DlV8
 yb4FoOjnIQOmJ0g8mMMFOZfImxJmCECmbg8IBQAkLh++hxPOkh0HTbgIKDQK6J6YoRiwZ
 nJ6MIVTEr92ABw2CVLr33/AkdHekg/IbGgrqU7M9wQhtQcYCW76iBkL+IXEvfRtb4qkBu
 iuNue8U0Tr6t2j7hEXDOYNCkf34wZ5QdwBrGeqd+Raq85GBVwhFQzXofFxu2ehQypNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789683536;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=1hvosjK0zNffcFwfUoZua1dEWw9LhZiV6/MxmMUkvKU=;
 b=LrbL8Y9AHJuesnUwVGkr64mBn3+iVUK6u7hslu35s3kTasAaLUAVqRsZn++63jS26fgc
 3mOMHrqR/BgHCs6iN1x61QQWGkv/pIdqYjRFDE3G5hVx/KaHbtPDWE7+DIFnc2M38/5Cq
 rgDwAd9HpkwxNGCtyXOVa8tSevPO77O1FQazJVNUki8FNl2I44mPx/SnpHzqkzzgAuqQi
 uZC0W504GccnFGLkafvvbcjpQQ7sS3D5gcd2CnPERlQIQcO2vcVKroy72sqiZEHAYPc03
 oQXwtgUzR/w+BQObuqczPIfRReRLjxCztpr+6gPswu3aC4qSful5XDCsZQpwA1cXSaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MHK8AAmE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MHK8AAmE
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10B2C4045B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:18:55 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 46e09a7af769-80477cb33a7so37327a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789683535; x=1790288335;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1hvosjK0zNffcFwfUoZua1dEWw9LhZiV6/MxmMUkvKU=;
 b=MHK8AAmEnoil/rNQowJMw9+xa59bOtXWqtSudqzQJJKSzEt2/+w+aG6eH7pPeULO3P
 usGMJGiw4tp0GdGfptAvj5Hcd5Iha0utrp8+Kd4C067iOl5W4bNFzDMNFX7gKLblJ4hK
 D4PaAurJF+BVnGOq4HBSoaJJRd7LC56NzS0Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683535; x=1790288335;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1hvosjK0zNffcFwfUoZua1dEWw9LhZiV6/MxmMUkvKU=;
 b=YJbsMqrFJqYQjykMrmyLKyhB7JXhWpZnmjUUEQezNlI11U/J0/sBOmX+CEG3uXZse2
 3a638HslVQRCpB1UaK83n63zPZ295jYuKPrN3mqogLlgQ3wYsBwN2Hi7hH2f+jFSzdCV
 QWKjM7c0lockKxQs4oJDsriw3CzChINUEpAf9krFcUiyu4+B7Ga1/dFO+J2UyspT+WiR
 YKh5mfMBYzNX6peIY+ouFFsRvfhTGc2YyKBxbwjip2ESx6ueqm/P8HyqsjK1RXCUtFeJ
 xJ8+E9VTpSYRP3rll7C3FApxQL3wqT5PR+7u/0JIFTkQI+i8VGhnIdaJi+K6YoKirLKD
 pSOw==
X-Gm-Message-State: AFuF++lh2uUERuwYF/pE8wF0hGQZjW/XlvIvhzBZfE145v/kjqxLBoxi
 gyAVg/zrvBSLhR1P/oJG77xl4azybz5DMTqboIawfzaiV2Y7FQVGulm534pnrId9QQKGZmgIdyn
 gHu+2aFdYBrysLvw=
X-Gm-Gg: AYBFou3ztHprJgFBkZJ1PPebEN4WVpsgaL5DkylhfBMZ0uNTG0ls9OOtMfLm450UMCS
 Q6ycx/vmJ8xwzYuEo1Sc6b/3UJ61AoR46duMVqQ75fOS9fqBFvtU01D8i/QTk4TtAs2dzT4mASC
 +9oi6d/+VcI2gEM5NOPe8BtYNGztd4Y8+8R9T4siKQXGLYZVVgFXU/DKQiLs47R90iJ8T8EzWW8
 hOml8/a5GXWMXYvEnYylFvkO4SN4ePC2IZLNxq0V50/CLVSiHftLASlslIF4u67ln/3PEVyiWdV
 NoZr796CFjezuNijtOQEOI9DR2PBhZNaMwLsO/eXq7Tp6WL+bbhlonVzNVQ/V59xOCBv617c1nv
 OYBZoiYlvYvlW7Kh3tY9Pis9675KcXhAVv4oJOv5qB4gQeS4BZGFzDlIGPZMH3xdJaz+1F0ymm7
 brNA/4/XxDi11OdK9Z4qc8ELM4o+dsfWE5PN845mUO8FjHWKjnmM+N9LXu7Gksne4aOZVUJWvR8
 O+ZXR/hrlnxd2MUDlrBsO6fydmgZ7lJ/uVRPkAPlOFSirAJ6HfqqpyFFu6vguwJYC/mlQpBrHnA
 Ghs4IpNxKDMpPrcvS38=
X-Received: by 2002:a05:6830:63cd:b0:7e6:ef1d:4aeb with SMTP id
 46e09a7af769-80de2bd5705mr671617a34.15.1789683534819; 
 Thu, 17 Sep 2026 15:18:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c46dbaa98sm4416077a34.18.2026.09.17.15.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:18:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
In-Reply-To: <20260917183012.552719-1-marek.vasut+renesas@mailbox.org>
References: <20260917183012.552719-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <178968353408.1566609.14426104244677644303.b4-ty@konsulko.com>
Date: Thu, 17 Sep 2026 16:18:54 -0600
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

On Thu, 17 Sep 2026 20:28:44 +0200, Marek Vasut wrote:

> Versaclock5 driver fix, trivial R-Car Gen5 clean ups and FFA command enablement.
> 
> The following changes since commit 444aca6d1439e4c4b9955171a7f45c053b540f69:
> 
>   Merge tag 'u-boot-dfu-20260914' of https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (2026-09-16 08:56:49 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


