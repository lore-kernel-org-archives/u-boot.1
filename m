Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D60C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9938791A;
	Mon,  4 Dec 2023 09:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701679046;
	bh=gvvuhB81ghwj+7j2Q0WrvIkHXDK2JKBJtB6s2xnCZ9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EcS6aqxEwPRJjp0+JJQvQhu6HeraUnyjyJtI8RUUzW/kZfGYC7k2Pp/WBx6Tp0CRH
	 4bdSfL5MEr/5sSyYhEk6zKtCWcA317Wn5Q+FU1GDlj2nBkoYy/z4DoZHwkyk+5a8DV
	 aZgDBrmPgt6KaE3xV1cRsAAefRodpS0hP6hS48E82tRyjcVLLycQfFTHGrt86DMZpk
	 tgYdkhbhNCCgLW+7svOKAHd4z5Zh1a6wJQzGBHCGQ/f41ZtfG5tHhRCiWYwb1/8xoQ
	 B1fO8aCXn723CG1Mp1BNa6CfhDscvv7Nbf53rf2T5yytTVsGitUXEKHEUnsLZIKCFE
	 BZRZVh1PraLSQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 605EA8788D;
 Mon,  4 Dec 2023 09:37:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701679044;
 bh=gvvuhB81ghwj+7j2Q0WrvIkHXDK2JKBJtB6s2xnCZ9A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Djj9zeDU2MRIjuc+IsYhmaqK9NCUQTti6vukt4DuJa7uuGNpQQ1LNv71KZuaY4eDM
 tr0Ku3WUwmgzfL91K9KTDZ2dsN1qIHIuAEelov6LcEz2wbrZYE+YWSR8Jbz15qu4Cf
 gggbiqe59HDxshbVi5mwpLJTnAkAN+VK33SGzsrLtEoeErRVcJGjsqOU2utTDHF4qD
 drT4iHn1Lqy3yKsaQ1wz7J0Gkc4Ed5NF1K/nLbpidGYVNkLf81DUopOBBsD1FSPx+t
 edwmCZ7G9BwsW660yHIVxqVa56B65dEbij1bUt/UmBFcOKih9k3QCqed7jwTKO+M8R
 CNS0XzfcsdLiw==
Message-ID: <a9f1fbe8-d604-4df0-b390-2be147bdd965@denx.de>
Date: Mon, 4 Dec 2023 09:37:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
Content-Language: en-US
To: Alessandro Rubini <rubini@gnudd.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, rogan@dawes.za.net
References: <e7b025bd-3498-4899-a73e-c55ff7a81f7a@denx.de>
 <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
 <CAOMZO5Ajq2L9-pNLqq0JGUmWdn5Lw=SeQsoZZ1YNYJbC1gJZQQ@mail.gmail.com>
 <ZW2JNHXCeO+Szif6@arcana.i.gnudd.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZW2JNHXCeO+Szif6@arcana.i.gnudd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/23 09:09, Alessandro Rubini wrote:
> Hello.
> 
>>>> pre-filling with 0xff creates a proper boot loader image, but no
>>>> bad-block marker is there when written to flash.
> 
>> Isn't there some kobs-ng or whatever tool it was to properly initialize
>> the NAND on MXS ?
> 
> I didn't know. I used what u-boot offers, which works for me without
> vendor tools -- and dare I say I trust u-boot tools more than vendor
> tools?.
> 
> The default environment even has the rule to reflash from any
> u-boot.nand you manage to put into RAM. The only issue is that
> u-boot.nand, as created, marks good blocks as bad by prefilling with
> zeores.

But what about the bad block markers , do they get erased when you write 
this U-Boot image into the NAND ?

I think the vendor tool somehow dealt with it (but it might have 
depended on some weird stuff in GPMI NAND), I don't think I ever used 
that tool myself.
